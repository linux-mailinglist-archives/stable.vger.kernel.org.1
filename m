Return-Path: <stable+bounces-234550-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QE0DGhuh1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234550-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:40:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B775E3C12EE
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B78C316EA04
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0233D411F;
	Wed,  8 Apr 2026 18:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="he495sLB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3883F32A3FD;
	Wed,  8 Apr 2026 18:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673150; cv=none; b=Tb9921X5Do+ct5h20l630aIWd2tMHn4io7tQeJ5pVGA50SFyRLsJrnSr2oVbF+0elwL2ayIlfbfYTkvJww6QJriBCrUiO9UJU9LeuRg4KflvqfX/D5bcv2mIhZto6huK3HamfCy7BC9O+WkhYT08THuOsygbOlTiZizjnqiU7wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673150; c=relaxed/simple;
	bh=taYg02Dtc8e5XppYdlIf9dEznCOMYTUqsGjz5LZksIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cr6ETMkvXLmICTUIhuAaVR5KTXmTKt0nUHwuYwaFckZKovARMz9NH5BrHmmC+D7DLoZbfYtZPe071ef6SFcBNXmmo1TKvCiVQyDzwOtwgwCiWe+bWHOkK1YpTheC0cBu44wW1gBKrIFVGrKyF9mg6oOdF++zWZS1BbDPoz7SGZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=he495sLB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FD3C19421;
	Wed,  8 Apr 2026 18:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673150;
	bh=taYg02Dtc8e5XppYdlIf9dEznCOMYTUqsGjz5LZksIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=he495sLB+uivZoNkAGyhtUCi0sxLRlHZZJ03XfKSs+fhTj4mVpVVmA7V2xEder1D1
	 CIq8vdXv7q3dG83SdqTbYkJyaC7+5Nev2r9+vUQbHpIdgGiVLlRa8SX8JcW8DuIRBo
	 pSKbexIcw4VnMQMp73vjWAbdXH1HlX+4+JRimNCs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen Ni <nichen@iscas.ac.cn>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 121/277] drm/sysfb: Fix efidrm error handling and memory type mismatch
Date: Wed,  8 Apr 2026 20:01:46 +0200
Message-ID: <20260408175938.390734510@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.836769063@linuxfoundation.org>
References: <20260408175933.836769063@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234550-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,suse.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: B775E3C12EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit 5e77923a3eb39cce91bf08ed7670f816bf86d4af ]

Fix incorrect error checking and memory type confusion in
efidrm_device_create(). devm_memremap() returns error pointers, not
NULL, and returns system memory while devm_ioremap() returns I/O memory.
The code incorrectly passes system memory to iosys_map_set_vaddr_iomem().

Restructure to handle each memory type separately. Use devm_ioremap*()
with ERR_PTR(-ENXIO) for WC/UC, and devm_memremap() with ERR_CAST() for
WT/WB.

Fixes: 32ae90c66fb6 ("drm/sysfb: Add efidrm for EFI displays")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patch.msgid.link/20260311064652.2903449-1-nichen@iscas.ac.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/sysfb/efidrm.c | 46 +++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/sysfb/efidrm.c b/drivers/gpu/drm/sysfb/efidrm.c
index 1883c4a8604c2..97a3711e79337 100644
--- a/drivers/gpu/drm/sysfb/efidrm.c
+++ b/drivers/gpu/drm/sysfb/efidrm.c
@@ -150,7 +150,6 @@ static struct efidrm_device *efidrm_device_create(struct drm_driver *drv,
 	struct drm_sysfb_device *sysfb;
 	struct drm_device *dev;
 	struct resource *mem = NULL;
-	void __iomem *screen_base = NULL;
 	struct drm_plane *primary_plane;
 	struct drm_crtc *crtc;
 	struct drm_encoder *encoder;
@@ -235,21 +234,38 @@ static struct efidrm_device *efidrm_device_create(struct drm_driver *drv,
 
 	mem_flags = efidrm_get_mem_flags(dev, res->start, vsize);
 
-	if (mem_flags & EFI_MEMORY_WC)
-		screen_base = devm_ioremap_wc(&pdev->dev, mem->start, resource_size(mem));
-	else if (mem_flags & EFI_MEMORY_UC)
-		screen_base = devm_ioremap(&pdev->dev, mem->start, resource_size(mem));
-	else if (mem_flags & EFI_MEMORY_WT)
-		screen_base = devm_memremap(&pdev->dev, mem->start, resource_size(mem),
-					    MEMREMAP_WT);
-	else if (mem_flags & EFI_MEMORY_WB)
-		screen_base = devm_memremap(&pdev->dev, mem->start, resource_size(mem),
-					    MEMREMAP_WB);
-	else
+	if (mem_flags & EFI_MEMORY_WC) {
+		void __iomem *screen_base = devm_ioremap_wc(&pdev->dev, mem->start,
+							    resource_size(mem));
+
+		if (!screen_base)
+			return ERR_PTR(-ENXIO);
+		iosys_map_set_vaddr_iomem(&sysfb->fb_addr, screen_base);
+	} else if (mem_flags & EFI_MEMORY_UC) {
+		void __iomem *screen_base = devm_ioremap(&pdev->dev, mem->start,
+							 resource_size(mem));
+
+		if (!screen_base)
+			return ERR_PTR(-ENXIO);
+		iosys_map_set_vaddr_iomem(&sysfb->fb_addr, screen_base);
+	} else if (mem_flags & EFI_MEMORY_WT) {
+		void *screen_base = devm_memremap(&pdev->dev, mem->start,
+						  resource_size(mem), MEMREMAP_WT);
+
+		if (IS_ERR(screen_base))
+			return ERR_CAST(screen_base);
+		iosys_map_set_vaddr(&sysfb->fb_addr, screen_base);
+	} else if (mem_flags & EFI_MEMORY_WB) {
+		void *screen_base = devm_memremap(&pdev->dev, mem->start,
+						  resource_size(mem), MEMREMAP_WB);
+
+		if (IS_ERR(screen_base))
+			return ERR_CAST(screen_base);
+		iosys_map_set_vaddr(&sysfb->fb_addr, screen_base);
+	} else {
 		drm_err(dev, "invalid mem_flags: 0x%llx\n", mem_flags);
-	if (!screen_base)
-		return ERR_PTR(-ENOMEM);
-	iosys_map_set_vaddr_iomem(&sysfb->fb_addr, screen_base);
+		return ERR_PTR(-EINVAL);
+	}
 
 	/*
 	 * Modesetting
-- 
2.53.0




