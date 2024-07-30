Return-Path: <stable+bounces-62794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC80941260
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 14:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FD2E281DAF
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481741A01C7;
	Tue, 30 Jul 2024 12:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cN1boRTY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B1F1A01C1;
	Tue, 30 Jul 2024 12:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343579; cv=none; b=Vk1zyx58z3VF0kjId7TnVVDC5Pi+TFYFX9Xmn3fGlPu6TE6vO5b/ZloPQVliTM7SMMsaHDihyWXiUQpxsKxttGZHA2RzVBzIcGJhmPSQ+jIs7r2G87lR2yeaN3vkoWM1F+CK2uP9WVscPSFoL+g/nGntoSR/nyYRPM+1PdAqR00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343579; c=relaxed/simple;
	bh=tRgMKHu3xH3PNwfJ13dzPAnL+mwOkH+hL8yOUi+mZKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O7O9laV+p+eFvmJ+EdA6cm6UZWUyMZwJi5uiThGfloF3gUgEaQ5obE9LWvC8inJS7XWYJYbZV9aBT8ou6xPGVUW18n5DDG2mM7PaN/C8t8w/Osfp9v3N54dg93JpisPkPRCAzRqV0t/FwbIyN5np/j1tJmkrUQjVWzU+VY63/cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cN1boRTY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA65C32782;
	Tue, 30 Jul 2024 12:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722343578;
	bh=tRgMKHu3xH3PNwfJ13dzPAnL+mwOkH+hL8yOUi+mZKc=;
	h=From:To:Cc:Subject:Date:From;
	b=cN1boRTYjvBqyHVdrcpGgRqx2kouch4N6So0ejJryeAsbA+47D5aJ83QDJ+FuZWM4
	 QOiHKLYcY5WYriolTzJybvrYYhhDHLgwYgcuhUT8RhMS5J7NpHAADCyfc7uJR+3mqq
	 SUHjwmPOOsDqLpuALJHOHAb1l0wz0vOIz8U+Ue81aGhioIOgzrlYRuuBI1pwL72RkP
	 PBTV/ZIfafSKQJVUO6y1BV1BJfCq/9un0HOHsjkju3GzvXkDb5ToYg7f5e5WEFsfw3
	 eY48bevZ2AuoCtwfD51IcG2H3HygIiA/GiCk6CV7oT5yW4E2KiYaeqt/wP4DS/OM6s
	 JMMCIXBY6GzUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.15 1/3] driver core: Make dev_err_probe() silent for -ENOMEM
Date: Tue, 30 Jul 2024 08:46:10 -0400
Message-ID: <20240730124616.3097556-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

[ Upstream commit 2f3cfd2f4b7cf3026fe6b9b2a5320cc18f4c184e ]

For an out-of-memory error there should be no additional output. Adapt
dev_err_probe() to not emit the error message when err is -ENOMEM.
This simplifies handling errors that might among others be -ENOMEM.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/3d1e308d45cddf67749522ca42d83f5b4f0b9634.1718311756.git.u.kleine-koenig@baylibre.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/core.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index d995d768c362a..a5415f0b021b5 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4724,11 +4724,22 @@ int dev_err_probe(const struct device *dev, int err, const char *fmt, ...)
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	if (err != -EPROBE_DEFER) {
-		dev_err(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
-	} else {
+	switch (err) {
+	case -EPROBE_DEFER:
 		device_set_deferred_probe_reason(dev, &vaf);
 		dev_dbg(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
+		break;
+
+	case -ENOMEM:
+		/*
+		 * We don't print anything on -ENOMEM, there is already enough
+		 * output.
+		 */
+		break;
+
+	default:
+		dev_err(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
+		break;
 	}
 
 	va_end(args);
-- 
2.43.0


