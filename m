Return-Path: <stable+bounces-244118-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Eg2GTzd+WkwEwMAu9opvQ
	(envelope-from <stable+bounces-244118-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:06:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EF74CD32C
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B75B3009B0B
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 12:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AD1407586;
	Tue,  5 May 2026 12:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAkxAcxU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD0F406277;
	Tue,  5 May 2026 12:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777982497; cv=none; b=V+V04/ueRtjWXg2OgFsQXhY9ry4Quhke7fFxyWcBrFXRRiogE7TBAvUmne5hw+Q9RpdYt/9JShf8FiwLztOZzWcHdbBFLz1R8CmMIZWpJhNUygmFTiu3+Fs/qwJhXKH0S0f3xxlq9MVaLuUiDlrlWIXXZ7BQLX+LfiP17sbf5H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777982497; c=relaxed/simple;
	bh=uVXKQh2MW7c3f089I8xTZMqN+Usqz7SnBNyZh419ucY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+R6OzpUGS24by5dfeYJ4mtn8ht0c+fJB4sMC9AcdSZSASIDU418rbjjeouVdzrz7tcy7qQkg/cBPKYMbIouYyngyr8n9Tb8WKpDzbhLK6CaOtcjBVW+wgPGeX2K8hXDDrIZxUuXQ26fOtY3t6GgYZXcXL0wNJnLOAQiOlDyVFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAkxAcxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75770C2BCB4;
	Tue,  5 May 2026 12:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777982497;
	bh=uVXKQh2MW7c3f089I8xTZMqN+Usqz7SnBNyZh419ucY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uAkxAcxU5TdvQVeRhopT444ePNjqSylKsGJ8+mlbRznXzEEjkOF0ZHFab0n9lB2MU
	 2vWZdZ9VP2Us9efFLvEbKnr9/AMy7wUyxRpR2SwTFxVJfNzM9fAJmxuV3DK29mUAUj
	 9kf8/ErmRKJLzkr3A3sDu4Ytu/UXjmy1vz6JaoIwaG3nqGemiO3fC7/K603lMtnSf5
	 dmw8JGrsAqZsvsVePJwQRTDf3JGkBtXVI/+WiST4nVf4ryI64SmFS4IZod/nYVXieR
	 fHOnV0eOoOGkVVyU7svJVunmnHCeVdoaE6/BNYcKBsCT3tdaeYLqDzT4XMRcmhkCDS
	 M+k99LmSfNzeA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Julius Werner <jwerner@chromium.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Hans de Goede <hansg@kernel.org>,
	linux-fbdev@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] firmware: google: framebuffer: Do not unregister platform device
Date: Tue,  5 May 2026 08:01:31 -0400
Message-ID: <20260505120131.663403-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050336-tainted-hundredth-63d4@gregkh>
References: <2026050336-tainted-hundredth-63d4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C3EF74CD32C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244118-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,chromium.org:email]

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 5cd28bd28c8ce426b56ce4230dbd17537181d5ad ]

The native driver takes over the framebuffer aperture by removing the
system- framebuffer platform device. Afterwards the pointer in drvdata
is dangling. Remove the entire logic around drvdata and let the kernel's
aperture helpers handle this. The platform device depends on the native
hardware device instead of the coreboot device anyway.

When commit 851b4c14532d ("firmware: coreboot: Add coreboot framebuffer
driver") added the coreboot framebuffer code, the kernel did not support
device-based aperture management. Instead native driviers only removed
the conflicting fbdev device. At that point, unregistering the framebuffer
device most likely worked correctly. It was definitely broken after
commit d9702b2a2171 ("fbdev/simplefb: Do not use struct
fb_info.apertures"). So take this commit for the Fixes tag. Earlier
releases might work depending on the native hardware driver.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: d9702b2a2171 ("fbdev/simplefb: Do not use struct fb_info.apertures")
Acked-by: Tzung-Bi Shih <tzungbi@kernel.org>
Acked-by: Julius Werner <jwerner@chromium.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Hans de Goede <hansg@kernel.org>
Cc: linux-fbdev@vger.kernel.org
Cc: <stable@vger.kernel.org> # v6.3+
Link: https://patch.msgid.link/20260217155836.96267-2-tzimmermann@suse.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/google/framebuffer-coreboot.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/firmware/google/framebuffer-coreboot.c b/drivers/firmware/google/framebuffer-coreboot.c
index c323a818805cc..a83ef081efe02 100644
--- a/drivers/firmware/google/framebuffer-coreboot.c
+++ b/drivers/firmware/google/framebuffer-coreboot.c
@@ -64,22 +64,12 @@ static int framebuffer_probe(struct coreboot_device *dev)
 						 sizeof(pdata));
 	if (IS_ERR(pdev))
 		pr_warn("coreboot: could not register framebuffer\n");
-	else
-		dev_set_drvdata(&dev->dev, pdev);
 
 	return PTR_ERR_OR_ZERO(pdev);
 }
 
-static void framebuffer_remove(struct coreboot_device *dev)
-{
-	struct platform_device *pdev = dev_get_drvdata(&dev->dev);
-
-	platform_device_unregister(pdev);
-}
-
 static struct coreboot_driver framebuffer_driver = {
 	.probe = framebuffer_probe,
-	.remove = framebuffer_remove,
 	.drv = {
 		.name = "framebuffer",
 	},
-- 
2.53.0


