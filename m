Return-Path: <stable+bounces-147919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB64EAC63A2
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 10:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C3EB17245D
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 08:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFDA246348;
	Wed, 28 May 2025 08:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GMAatOj3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1DpwMK4/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GMAatOj3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1DpwMK4/"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DF624502D
	for <stable@vger.kernel.org>; Wed, 28 May 2025 08:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748419563; cv=none; b=VNzAXzl+yuh+/pxplI9TYWWR3oHqk2bEApCGwrzOpVWd+1C18cjcAEshXPSG1POnuOnFfKUpdG4OYWAs3CM9zwXH0dBlXCcZeHFxiBUjKhPnvEIRXyoCW3VomQNVOEFcU4ERnpfugIuqp0ol5lRvmYUZER8podSgC7IxFZpPc+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748419563; c=relaxed/simple;
	bh=o4bdzZC7koh9nP5ZfzXpv+m4tHlX03NaPqpW01Q5s70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z+Laabq0nbVAxUTFOvJG+dLZBjox0BnTH3hU09h43gN5eVFg0W3ZTJSwfgvgi8rbcajG2KY2hT6+1zIDcn37ecPgkA/CDGbTxjK/yITrKwAJPsZbXCSLvNfW8y6P/8uvUz+jv8wiH8MKFr7E/pcpGDraLaiIKcEzHlMUR4POAdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GMAatOj3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1DpwMK4/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GMAatOj3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1DpwMK4/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8262E1F79F;
	Wed, 28 May 2025 08:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748419558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3vSiP53C+zA47IDRW6hNhnJDVCP+tkdTkYAk5YjdfnA=;
	b=GMAatOj3dJ/3t3uISU2A5eFl9NzxxAeNm3xEEfT8wia/rk5+iDwp9jXOjErrwDVt7QAm9c
	7QA6XioWTxKSVqTqKZzvMSM+0llZ+O+Bmu7y2J3IqqcjEpe67rVFCVNazkvwkOuMAiUwkj
	T5rSdzg49taYlmDNxOmhwCNntmS7s3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748419558;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3vSiP53C+zA47IDRW6hNhnJDVCP+tkdTkYAk5YjdfnA=;
	b=1DpwMK4/FVw6kMzyKroHudabbqBKOerpU1tQxCu+6otOlKGQLFd5SJbgxT8tWnvrjbVY34
	7vTuyQpxYBgaKpDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748419558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3vSiP53C+zA47IDRW6hNhnJDVCP+tkdTkYAk5YjdfnA=;
	b=GMAatOj3dJ/3t3uISU2A5eFl9NzxxAeNm3xEEfT8wia/rk5+iDwp9jXOjErrwDVt7QAm9c
	7QA6XioWTxKSVqTqKZzvMSM+0llZ+O+Bmu7y2J3IqqcjEpe67rVFCVNazkvwkOuMAiUwkj
	T5rSdzg49taYlmDNxOmhwCNntmS7s3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748419558;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3vSiP53C+zA47IDRW6hNhnJDVCP+tkdTkYAk5YjdfnA=;
	b=1DpwMK4/FVw6kMzyKroHudabbqBKOerpU1tQxCu+6otOlKGQLFd5SJbgxT8tWnvrjbVY34
	7vTuyQpxYBgaKpDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41F55136E3;
	Wed, 28 May 2025 08:05:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A5bGDubDNmjLUQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 28 May 2025 08:05:58 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	bhelgaas@google.com,
	iivanov@suse.de,
	tiwai@suse.de
Cc: dri-devel@lists.freedesktop.org,
	linux-pci@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH v3] video: screen_info: Relocate framebuffers behind PCI bridges
Date: Wed, 28 May 2025 10:02:08 +0200
Message-ID: <20250528080234.7380-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,lists.freedesktop.org:email,suse.com:url];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:email,suse.de:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

Apply PCI host-bridge window offsets to screen_info framebuffers. Fixes
invalid access to I/O memory.

Resources behind a PCI host bridge can be relocated by a certain offset
in the kernel's CPU address range used for I/O. The framebuffer memory
range stored in screen_info refers to the CPU addresses as seen during
boot (where the offset is 0). During boot up, firmware may assign a
different memory offset to the PCI host bridge and thereby relocating
the framebuffer address of the PCI graphics device as seen by the kernel.
The information in screen_info must be updated as well.

The helper pcibios_bus_to_resource() performs the relocation of the
screen_info's framebuffer resource (given in PCI bus addresses). The
result matches the I/O-memory resource of the PCI graphics device (given
in CPU addresses). As before, we store away the information necessary to
later update the information in screen_info itself.

Commit 78aa89d1dfba ("firmware/sysfb: Update screen_info for relocated
EFI framebuffers") added the code for updating screen_info. It is based
on similar functionality that pre-existed in efifb. Efifb uses a pointer
to the PCI resource, while the newer code does a memcpy of the region.
Hence efifb sees any updates to the PCI resource and avoids the issue.

v3:
- Only use struct pci_bus_region for PCI bus addresses (Bjorn)
- Clarify address semantics in commit messages and comments (Bjorn)
v2:
- Fixed tags (Takashi, Ivan)
- Updated information on efifb

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reported-by: "Ivan T. Ivanov" <iivanov@suse.de>
Closes: https://bugzilla.suse.com/show_bug.cgi?id=1240696
Tested-by: "Ivan T. Ivanov" <iivanov@suse.de>
Fixes: 78aa89d1dfba ("firmware/sysfb: Update screen_info for relocated EFI framebuffers")
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.9+
---
 drivers/video/screen_info_pci.c | 79 +++++++++++++++++++++------------
 1 file changed, 50 insertions(+), 29 deletions(-)

diff --git a/drivers/video/screen_info_pci.c b/drivers/video/screen_info_pci.c
index 6c5833517141..66bfc1d0a6dc 100644
--- a/drivers/video/screen_info_pci.c
+++ b/drivers/video/screen_info_pci.c
@@ -7,8 +7,8 @@
 
 static struct pci_dev *screen_info_lfb_pdev;
 static size_t screen_info_lfb_bar;
-static resource_size_t screen_info_lfb_offset;
-static struct resource screen_info_lfb_res = DEFINE_RES_MEM(0, 0);
+static resource_size_t screen_info_lfb_res_start; // original start of resource
+static resource_size_t screen_info_lfb_offset; // framebuffer offset within resource
 
 static bool __screen_info_relocation_is_valid(const struct screen_info *si, struct resource *pr)
 {
@@ -31,7 +31,7 @@ void screen_info_apply_fixups(void)
 	if (screen_info_lfb_pdev) {
 		struct resource *pr = &screen_info_lfb_pdev->resource[screen_info_lfb_bar];
 
-		if (pr->start != screen_info_lfb_res.start) {
+		if (pr->start != screen_info_lfb_res_start) {
 			if (__screen_info_relocation_is_valid(si, pr)) {
 				/*
 				 * Only update base if we have an actual
@@ -47,46 +47,67 @@ void screen_info_apply_fixups(void)
 	}
 }
 
+static int __screen_info_lfb_pci_bus_region(const struct screen_info *si, unsigned int type,
+					    struct pci_bus_region *r)
+{
+	u64 base, size;
+
+	base = __screen_info_lfb_base(si);
+	if (!base)
+		return -EINVAL;
+
+	size = __screen_info_lfb_size(si, type);
+	if (!size)
+		return -EINVAL;
+
+	r->start = base;
+	r->end = base + size - 1;
+
+	return 0;
+}
+
 static void screen_info_fixup_lfb(struct pci_dev *pdev)
 {
 	unsigned int type;
-	struct resource res[SCREEN_INFO_MAX_RESOURCES];
-	size_t i, numres;
+	struct pci_bus_region bus_region;
 	int ret;
+	struct resource r = {
+		.flags = IORESOURCE_MEM,
+	};
+	const struct resource *pr;
 	const struct screen_info *si = &screen_info;
 
 	if (screen_info_lfb_pdev)
 		return; // already found
 
 	type = screen_info_video_type(si);
-	if (type != VIDEO_TYPE_EFI)
-		return; // only applies to EFI
+	if (!__screen_info_has_lfb(type))
+		return; // only applies to EFI; maybe VESA
 
-	ret = screen_info_resources(si, res, ARRAY_SIZE(res));
+	ret = __screen_info_lfb_pci_bus_region(si, type, &bus_region);
 	if (ret < 0)
 		return;
-	numres = ret;
 
-	for (i = 0; i < numres; ++i) {
-		struct resource *r = &res[i];
-		const struct resource *pr;
-
-		if (!(r->flags & IORESOURCE_MEM))
-			continue;
-		pr = pci_find_resource(pdev, r);
-		if (!pr)
-			continue;
-
-		/*
-		 * We've found a PCI device with the framebuffer
-		 * resource. Store away the parameters to track
-		 * relocation of the framebuffer aperture.
-		 */
-		screen_info_lfb_pdev = pdev;
-		screen_info_lfb_bar = pr - pdev->resource;
-		screen_info_lfb_offset = r->start - pr->start;
-		memcpy(&screen_info_lfb_res, r, sizeof(screen_info_lfb_res));
-	}
+	/*
+	 * Translate the PCI bus address to resource. Account
+	 * for an offset if the framebuffer is behind a PCI host
+	 * bridge.
+	 */
+	pcibios_bus_to_resource(pdev->bus, &r, &bus_region);
+
+	pr = pci_find_resource(pdev, &r);
+	if (!pr)
+		return;
+
+	/*
+	 * We've found a PCI device with the framebuffer
+	 * resource. Store away the parameters to track
+	 * relocation of the framebuffer aperture.
+	 */
+	screen_info_lfb_pdev = pdev;
+	screen_info_lfb_bar = pr - pdev->resource;
+	screen_info_lfb_offset = r.start - pr->start;
+	screen_info_lfb_res_start = bus_region.start;
 }
 DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY, 16,
 			       screen_info_fixup_lfb);
-- 
2.49.0


