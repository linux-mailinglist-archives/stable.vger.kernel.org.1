Return-Path: <stable+bounces-62791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CF694125B
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 14:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966181F2123B
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069751A2C3A;
	Tue, 30 Jul 2024 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmOP3T+z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FB11A00FA;
	Tue, 30 Jul 2024 12:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343565; cv=none; b=KyuEFg829Y7CudAEWMrk0vzCm0N1c0UUuOlgqoAgPt/N9aaeOm1wgGvIkNHWWXvT4Jl5b7RBB7TOWrm2W8bAf2pp98lSwBHd4cMZ0GlKR6/KaNBTSKkB2yhJZ4uXpR5S0pA4rOh4f0LR4wLv6ggHIldtkGkRY6kF/xNx6zrDJm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343565; c=relaxed/simple;
	bh=Anv2mdWVlttJHahzWioCIYp42LdPDcQ8juPxmlB8ftU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kVdPjoEkWPAwvYe3hBbPyINPuDz/wUa85cVGXJu5JaKoN1o95PM77gNYpfuopuoY+F/1MXVBcUUko3aeAsmld24uW1QdnDxMbJl18ecAgpWml85hqgfAvrGBo+QU2sC9Pan0ZAMhGviDZbn1L3JhFsfWO1ZhAXmUuRvS02a+HkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmOP3T+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE8EC32782;
	Tue, 30 Jul 2024 12:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722343565;
	bh=Anv2mdWVlttJHahzWioCIYp42LdPDcQ8juPxmlB8ftU=;
	h=From:To:Cc:Subject:Date:From;
	b=tmOP3T+zIg/OQ0iOUmHyqv4mnLZvGhVG7aGAI2CXbWllAtPAQ4xdQ8icO3F4VdImo
	 dvlFwf++eNPJetFoDeeNzr4TlLJKdzlKWLXx16Ca5cgT7dzNriZORrl3d835LD5HwJ
	 GBSFblh7nUmbos3PX19P35mFsLm+FaZJzY3r8B9PSL5bbWuaBA9fV4RpfccLzSpKkq
	 g8TA0S7mNZBg1HCeEOTcs04TZIxyLINzh3PEtbsmrudK4Ip7w8uoxMRa5Q/w4Rq+2g
	 EcXdQ5DHihpPhtbd5HxnW2w6HZ8fML8jgpAHpJv5Sg8pIEyKjK/u7GGrfXZnCz4ha8
	 M8OYgz2gtHb/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 1/3] driver core: Make dev_err_probe() silent for -ENOMEM
Date: Tue, 30 Jul 2024 08:45:57 -0400
Message-ID: <20240730124603.3096510-1-sashal@kernel.org>
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
X-stable-base: Linux 6.1.102
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
index 30204e62497c2..b86f6c81fde7d 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -5036,11 +5036,22 @@ int dev_err_probe(const struct device *dev, int err, const char *fmt, ...)
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


