Return-Path: <stable+bounces-46199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4078CF349
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 11:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCF4A1C203D5
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 09:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5821208C1;
	Sun, 26 May 2024 09:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H12PbXJR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7D522F0E;
	Sun, 26 May 2024 09:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716716530; cv=none; b=WJ2ZS4uEGipmGAJBoU+I1dC8V08oxX5rxgCiKSVFstd39uXGLlM9unhHxCmhwdWWu2vX0secZyBwiHUEyhhfxFC67Crlfg5Av0NQ/ZWztSCK1Z3kAh1YdakLdKGwAm6y9N/uwoE0NWzH658w8DX2/B02RyVozsaDCJxrJlAJOGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716716530; c=relaxed/simple;
	bh=yZCx+Ui138RWNHsw6N6p9WbGX2dhsHntqReUeJevRsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qh3jzzJQwB14HWg0ffUvBaentVCsMEGot8GdN9t4QY0c3wqD6/bvKNLYYj4/7z24Owp5c96BjTblptP/vUq2wXfSlzxVKwj75H2AF/BH8ncZAIKtjgwrbXRht4ERyWzDrlZ505ebcWwbp0rmiQQK0wHYSBet1ya5k+zBeC8vK2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H12PbXJR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A5AC2BD10;
	Sun, 26 May 2024 09:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716716530;
	bh=yZCx+Ui138RWNHsw6N6p9WbGX2dhsHntqReUeJevRsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H12PbXJRWwUs4qUrR7/UCM60O2drp95+uuo7qza9Letqy1VdivoJWZr6BSG+rFN+o
	 5O+WC3SiSsEtQurEXWN/7SitlObWFsB6A4ANxKEL7A3ggTqYoH7hZZQX7Se9eLqH7h
	 srMF7IVYRGoOGKPzFral7El08dKjwR3Jx2bbkN5Tpt1LR0fhSAzUlPLQRQLdkcvddz
	 fr9RPipfrSka9kAnXOC51jNKLlA/vB68rrGFKOYpeh9IPbw8BVZbiLTXGJyyAH83Z1
	 fohlRPYK/uIsazpEgiK0g/TxKReW5LpUeCb01Njv6oJDhMCHLlT2OPn1DM0N96GuNW
	 UVTXrMqTa983g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Prashant Malani <pmalani@chromium.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	chrome-platform@lists.linux.dev
Subject: [PATCH AUTOSEL 6.9 11/15] platform/chrome: cros_usbpd_notify: provide ID table for avoiding fallback match
Date: Sun, 26 May 2024 05:41:43 -0400
Message-ID: <20240526094152.3412316-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240526094152.3412316-1-sashal@kernel.org>
References: <20240526094152.3412316-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.1
Content-Transfer-Encoding: 8bit

From: Tzung-Bi Shih <tzungbi@kernel.org>

[ Upstream commit 8ad3b9652ed6a115c56214a0eab06952818b3ddf ]

Instead of using fallback driver name match, provide ID table[1] for the
primary match.

[1]: https://elixir.bootlin.com/linux/v6.8/source/drivers/base/platform.c#L1353

Reviewed-by: Benson Leung <bleung@chromium.org>
Acked-by: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Link: https://lore.kernel.org/r/20240329075630.2069474-8-tzungbi@kernel.org
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/chrome/cros_usbpd_notify.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
index aacad022f21df..c83f81d86483c 100644
--- a/drivers/platform/chrome/cros_usbpd_notify.c
+++ b/drivers/platform/chrome/cros_usbpd_notify.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_data/cros_usbpd_notify.h>
@@ -218,12 +219,19 @@ static void cros_usbpd_notify_remove_plat(struct platform_device *pdev)
 					   &pdnotify->nb);
 }
 
+static const struct platform_device_id cros_usbpd_notify_id[] = {
+	{ DRV_NAME, 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, cros_usbpd_notify_id);
+
 static struct platform_driver cros_usbpd_notify_plat_driver = {
 	.driver = {
 		.name = DRV_NAME,
 	},
 	.probe = cros_usbpd_notify_probe_plat,
 	.remove_new = cros_usbpd_notify_remove_plat,
+	.id_table = cros_usbpd_notify_id,
 };
 
 static int __init cros_usbpd_notify_init(void)
@@ -258,4 +266,3 @@ module_exit(cros_usbpd_notify_exit);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("ChromeOS power delivery notifier device");
 MODULE_AUTHOR("Jon Flatley <jflat@chromium.org>");
-MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.43.0


