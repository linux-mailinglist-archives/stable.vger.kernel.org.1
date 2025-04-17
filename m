Return-Path: <stable+bounces-132910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CC5A91520
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 09:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A51B7A8D5F
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 07:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DDF21B9FE;
	Thu, 17 Apr 2025 07:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TWRG+9BX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ebto0iWg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TWRG+9BX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ebto0iWg"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2561C2192FE
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 07:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744874929; cv=none; b=gYBgmWHWt2n8T+c2MZK1B3dSxbDNVuzMu03AyaBJksS4+gtLDP1A5R3JxU6YkHBfjJkK+uh2AK87BSmlCF+jJL/QOL2b+Rwlh9CC/iJ2OKIim6lewG0besLsBL13UiPdm18wcqeu7mhkBUDmBlQby+1RlL/0ODXi9ZHzP8Fbu1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744874929; c=relaxed/simple;
	bh=Jg6UG4xC5UO7CNaDaqDYvjh9J7U6NpWUG5a5yxtQuL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JWL56mmBRMJjm0FfLyg4wXzCk/y4nstRNnkUoZDokwNKUhdoG+nQITLMXKYSpBGNvrSJjzQ8XBGeVLFZ0GPlHmsttYocGuuEh1Db5c9YCFLrJ4W29mVaAkAvIwHKmbue09Rep62EfjgBTsDpD0WFKCbDkKA85ao8/pKai/tcT4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TWRG+9BX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ebto0iWg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TWRG+9BX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ebto0iWg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1E66F1F457;
	Thu, 17 Apr 2025 07:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744874926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Bf0I+0LtGfueJJIC/SIxBKXtdnsXrsSkLMSdUtoXEEA=;
	b=TWRG+9BXOk1x1eU0k10XXBjS+j7JBTNaRICRkXPvroQePrDerk783afE5bPSmWs+yejxl5
	0zVm6xGMZkTq2HOGxbdcgYNpcc5ANiRolx4y6AOv/6jmJ00yPYbtLH+ao3vrNY/tboa4rg
	RJzJQcJ5ladJo1nBdEaTLJgVv73e0+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744874926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Bf0I+0LtGfueJJIC/SIxBKXtdnsXrsSkLMSdUtoXEEA=;
	b=ebto0iWgqfPRLc5C3YSL6abKf/R7vAh9UBtiYb/iZ3cysn8BE1LuiSnNk6hVZjSA3p6bwF
	CfOLVMhO+hm0AFAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TWRG+9BX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ebto0iWg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744874926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Bf0I+0LtGfueJJIC/SIxBKXtdnsXrsSkLMSdUtoXEEA=;
	b=TWRG+9BXOk1x1eU0k10XXBjS+j7JBTNaRICRkXPvroQePrDerk783afE5bPSmWs+yejxl5
	0zVm6xGMZkTq2HOGxbdcgYNpcc5ANiRolx4y6AOv/6jmJ00yPYbtLH+ao3vrNY/tboa4rg
	RJzJQcJ5ladJo1nBdEaTLJgVv73e0+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744874926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Bf0I+0LtGfueJJIC/SIxBKXtdnsXrsSkLMSdUtoXEEA=;
	b=ebto0iWgqfPRLc5C3YSL6abKf/R7vAh9UBtiYb/iZ3cysn8BE1LuiSnNk6hVZjSA3p6bwF
	CfOLVMhO+hm0AFAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6986137CF;
	Thu, 17 Apr 2025 07:28:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LwTzNq2tAGjrTgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 17 Apr 2025 07:28:45 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	iivanov@suse.de
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH] video: screen_info: Update framebuffers behind PCI bridges
Date: Thu, 17 Apr 2025 09:27:33 +0200
Message-ID: <20250417072751.10125-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1E66F1F457
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,suse.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Apply bridge window offsets to screen_info framebuffers during
relocation. Fixes invalid access to I/O memory.

Resources behind a PCI bridge can be located at a certain offset
in the kernel's I/O range. The framebuffer memory range stored in
screen_info refers to the offset as seen during boot (essentialy 0).
During boot up, the kernel may assign a different memory offset to
the bridge device and thereby relocating the framebuffer address of
the PCI graphics device as seen by the kernel. The information in
screen_info must be updated as well.

The helper pcibios_bus_to_resource() performs the relocation of
the screen_info resource. The result now matches the I/O-memory
resource of the PCI graphics device. As before, we store away the
information necessary to update the information in screen_info.

Commit 78aa89d1dfba ("firmware/sysfb: Update screen_info for relocated
EFI framebuffers") added the code for updating screen_info. It is
based on similar functionality that pre-existed in efifb. But efifb
did not handle bridges correctly, so the problem presumably exists
only on newer systems.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reported-by: Tested-by: "Ivan T. Ivanov" <iivanov@suse.de>
Closes: https://bugzilla.suse.com/show_bug.cgi?id=1240696
Tested-by: Tested-by: "Ivan T. Ivanov" <iivanov@suse.de>
Fixes: 78aa89d1dfba ("firmware/sysfb: Update screen_info for relocated EFI framebuffers")
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.9+
---
 drivers/video/screen_info_pci.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/video/screen_info_pci.c b/drivers/video/screen_info_pci.c
index 6c5833517141..c46c75dc3fae 100644
--- a/drivers/video/screen_info_pci.c
+++ b/drivers/video/screen_info_pci.c
@@ -8,7 +8,7 @@
 static struct pci_dev *screen_info_lfb_pdev;
 static size_t screen_info_lfb_bar;
 static resource_size_t screen_info_lfb_offset;
-static struct resource screen_info_lfb_res = DEFINE_RES_MEM(0, 0);
+static struct pci_bus_region screen_info_lfb_region;
 
 static bool __screen_info_relocation_is_valid(const struct screen_info *si, struct resource *pr)
 {
@@ -31,7 +31,7 @@ void screen_info_apply_fixups(void)
 	if (screen_info_lfb_pdev) {
 		struct resource *pr = &screen_info_lfb_pdev->resource[screen_info_lfb_bar];
 
-		if (pr->start != screen_info_lfb_res.start) {
+		if (pr->start != screen_info_lfb_region.start) {
 			if (__screen_info_relocation_is_valid(si, pr)) {
 				/*
 				 * Only update base if we have an actual
@@ -69,10 +69,21 @@ static void screen_info_fixup_lfb(struct pci_dev *pdev)
 
 	for (i = 0; i < numres; ++i) {
 		struct resource *r = &res[i];
+		struct pci_bus_region bus_region = {
+			.start = r->start,
+			.end = r->end,
+		};
 		const struct resource *pr;
 
 		if (!(r->flags & IORESOURCE_MEM))
 			continue;
+
+		/*
+		 * Translate the address to resource if the framebuffer
+		 * is behind a PCI bridge.
+		 */
+		pcibios_bus_to_resource(pdev->bus, r, &bus_region);
+
 		pr = pci_find_resource(pdev, r);
 		if (!pr)
 			continue;
@@ -85,7 +96,7 @@ static void screen_info_fixup_lfb(struct pci_dev *pdev)
 		screen_info_lfb_pdev = pdev;
 		screen_info_lfb_bar = pr - pdev->resource;
 		screen_info_lfb_offset = r->start - pr->start;
-		memcpy(&screen_info_lfb_res, r, sizeof(screen_info_lfb_res));
+		memcpy(&screen_info_lfb_region, &bus_region, sizeof(screen_info_lfb_region));
 	}
 }
 DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY, 16,
-- 
2.49.0


