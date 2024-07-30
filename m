Return-Path: <stable+bounces-62787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD62941253
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 14:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0525E284EE5
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1A41A0B1B;
	Tue, 30 Jul 2024 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcgLvhrE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AC41A0B16;
	Tue, 30 Jul 2024 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343550; cv=none; b=T3y1B76dSsiBKCiXfWtP6ROumM1Lr7H6hu0zTZL2xEHlIY6gZepiuo9LWRkJTxypxKlAo+UWluizek8H2XiKWYMUYggOpjI0oUb7ZCmuCPCV9irujt72qtyG0fFcjG6ZMNOHziY2PfTvqtB0usEEmy8ZrdJNSN67iQW/CXrFZyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343550; c=relaxed/simple;
	bh=cmNw9VxdIQLXVJ/hRNLZci0k4wKOmf2e0XeTyYxf0Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U/9VPsGPkFZIzO9w9p9BT99i2HznIfahgkyNfwUlk7sJ2wmeuhLOiJkM0Cq6hepdGg31FauTqolUpNzicT49bl+Mdm76l4T98ypZT5hRIOrGfGwaOqAdFg4BhVVgsxovqVM1EQeIG1TgTXkPryyeL3rLlPKkakLQpS8IiK1fLxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcgLvhrE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCFBC4AF09;
	Tue, 30 Jul 2024 12:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722343549;
	bh=cmNw9VxdIQLXVJ/hRNLZci0k4wKOmf2e0XeTyYxf0Zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hcgLvhrEIC+b4Tm+0TEDZTZmHmb58/98eR4UnRsxPPKlUo5GMNAvNVedP+o3BWxRy
	 mXAD/mVC5oNupbtctVAQ3BmjyqhNxT+35NlGmU3jugp7YYDfJ5sI9v1Ut3PJBz35ZO
	 GjMpgCqHQKVEMBbNSSJRh43O3Dm5yKT6vj7/SvoFM5ubbPnsAXejnNuEmVggqoCZg0
	 J6GDnO1crcy4fiFarRzFMR+0+Tc78MEJwRtA+I4+67wDIReeo2bbg2dFaBNzOwo0qt
	 HYFf0MggywQgTMUvNt1viG2RaJZViKuGJG47qcfBYh3YxzjcZlXcGZaTXDVY7dKxI9
	 TunSlIMbE6BaA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 4/7] driver core: Make dev_err_probe() silent for -ENOMEM
Date: Tue, 30 Jul 2024 08:45:34 -0400
Message-ID: <20240730124542.3095044-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730124542.3095044-1-sashal@kernel.org>
References: <20240730124542.3095044-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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
index aeb4644817d57..a39b3d6f80061 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4990,11 +4990,22 @@ int dev_err_probe(const struct device *dev, int err, const char *fmt, ...)
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


