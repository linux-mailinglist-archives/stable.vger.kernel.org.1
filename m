Return-Path: <stable+bounces-243208-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cETtNbGo+Gl+xgIAu9opvQ
	(envelope-from <stable+bounces-243208-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:09:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9704BEA4C
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DFAE3050F5B
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7199F3D904D;
	Mon,  4 May 2026 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TAUP8NDl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334CC3D3308;
	Mon,  4 May 2026 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903294; cv=none; b=ql9YnXzbuUT7fB21DzRgJnIfG9HMCm4wSPTfUlQ/04KDHlWhXO46fV08mafbvk3kHV2O+5svp6zSiX0aPNP2meBYBf8TlZuvBnYSswuyVmIIXWAN37v/1K66gDE/vRxhhmJXl0iETPnZceTlO864hOZkq0w63NFIM+yL7VUq/JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903294; c=relaxed/simple;
	bh=1mHt8jksLFQ6LuEJzUYVYZRg/NW1Qi1WWXIhz38pS8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YlroItKWdmP+EzRzt04GGtDx4LqXBMwo2NPuto0/a2UbW57VxalROfnjBEEgYi9NH8+zj0XP4fK8psRIgCOJDyBqdyPS0WLnJhq4yALZgveuAoA8y48tEruv+Ph+xCw0tidFpxOHDmdAaWUWdcywtWpy7frjMcMTsMz+FhZ7okk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TAUP8NDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72521C2BCB8;
	Mon,  4 May 2026 14:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903293;
	bh=1mHt8jksLFQ6LuEJzUYVYZRg/NW1Qi1WWXIhz38pS8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TAUP8NDlvgUVcZt5PMptpYzcBVfAvCqmKvkG3KqSGAtb6x0fwQV0aBHxuSLecOmMQ
	 v2wv1fE2Y2hTXFMtjC4so2mFlUelKwnJK4NYOeaaEa2gaKkB98LU6e7ukG4ootMFT8
	 Ypz3AvM6U2hQf6CJApgjShOv2BY1QAPPJqEPCJi4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Julius Werner <jwerner@chromium.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Hans de Goede <hansg@kernel.org>,
	linux-fbdev@vger.kernel.org
Subject: [PATCH 7.0 179/307] firmware: google: framebuffer: Do not unregister platform device
Date: Mon,  4 May 2026 15:51:04 +0200
Message-ID: <20260504135149.608548590@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3B9704BEA4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243208-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Zimmermann <tzimmermann@suse.de>

commit 5cd28bd28c8ce426b56ce4230dbd17537181d5ad upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/google/framebuffer-coreboot.c |   10 ----------
 1 file changed, 10 deletions(-)

--- a/drivers/firmware/google/framebuffer-coreboot.c
+++ b/drivers/firmware/google/framebuffer-coreboot.c
@@ -81,19 +81,10 @@ static int framebuffer_probe(struct core
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
 static const struct coreboot_device_id framebuffer_ids[] = {
 	{ .tag = CB_TAG_FRAMEBUFFER },
 	{ /* sentinel */ }
@@ -102,7 +93,6 @@ MODULE_DEVICE_TABLE(coreboot, framebuffe
 
 static struct coreboot_driver framebuffer_driver = {
 	.probe = framebuffer_probe,
-	.remove = framebuffer_remove,
 	.drv = {
 		.name = "framebuffer",
 	},



