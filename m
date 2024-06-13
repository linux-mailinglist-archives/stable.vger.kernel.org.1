Return-Path: <stable+bounces-50477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE6F906816
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 539F21C236B7
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 09:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5C913E8BF;
	Thu, 13 Jun 2024 09:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gMSrLkSX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GKzis372";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gMSrLkSX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GKzis372"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D06913F421;
	Thu, 13 Jun 2024 09:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718269369; cv=none; b=Vj2QellXzi3AKxBcdancKUc5V6aZqqAyl63I3j/EKhxIfbgUGfitPlMjP2NadGQmY5st+S+PfFJFgIlkWCWlZP7TBpEvq3sA1nk+MSlg098U9tqNxg1GXhqH1v6XkeV3ZQVGFgvyB7G3kc8Mw+WMuM8bdIuelHsmvNKfj8Xvy24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718269369; c=relaxed/simple;
	bh=iDhareU5SkOa05ZzgiJgRQj3kzXnJKuHzPl/A+ifQvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hNlGR4yEpu2oIBuZhtgH6OBb1dPqesGUSD8SEaAENLUukyafn02uBVDIGfY76f1PtKpEKQINC9qAEb2ktx8PIV2nIU1q/6RQP3BtzTBf1SlfYZHpdP/QB+6eNUHZmuD4WGIHCF+7qwRPXy6ylPxoqmp5btpDl2D8rqRcADIlonw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gMSrLkSX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GKzis372; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gMSrLkSX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GKzis372; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 73A8B5D079;
	Thu, 13 Jun 2024 09:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718269365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pIVDisUcR8VzoZKPTV+OuoRv5XGyVWJlmcO4Rce/v2I=;
	b=gMSrLkSXexMPw9/kUjkJSX1TOuZj/aS7qWXH/Ji6l4XWan6aU1xNEBElCer1QSjJeWO1bK
	AFL0QvLJNX1DQ4l1mB/3fK2fRTWDtdtpo9C7+CtcPOA+vPbFwEyrNvFXqqWPwSp0wcTirM
	pHrdzYpjtnKOQM9lNd0h0eB3Kwd84TM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718269365;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pIVDisUcR8VzoZKPTV+OuoRv5XGyVWJlmcO4Rce/v2I=;
	b=GKzis372FGj5MdEJcQ4TN/+ZVtiIfVnL68wH45TH6k9woqsa6JaqR+mzITfbKxdkbk68sl
	TQVBMr3q9Z4LbMDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gMSrLkSX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GKzis372
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718269365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pIVDisUcR8VzoZKPTV+OuoRv5XGyVWJlmcO4Rce/v2I=;
	b=gMSrLkSXexMPw9/kUjkJSX1TOuZj/aS7qWXH/Ji6l4XWan6aU1xNEBElCer1QSjJeWO1bK
	AFL0QvLJNX1DQ4l1mB/3fK2fRTWDtdtpo9C7+CtcPOA+vPbFwEyrNvFXqqWPwSp0wcTirM
	pHrdzYpjtnKOQM9lNd0h0eB3Kwd84TM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718269365;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pIVDisUcR8VzoZKPTV+OuoRv5XGyVWJlmcO4Rce/v2I=;
	b=GKzis372FGj5MdEJcQ4TN/+ZVtiIfVnL68wH45TH6k9woqsa6JaqR+mzITfbKxdkbk68sl
	TQVBMr3q9Z4LbMDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 392E713A7F;
	Thu, 13 Jun 2024 09:02:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HZSjDLW1ambHZgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 13 Jun 2024 09:02:45 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	sam@ravnborg.org,
	javierm@redhat.com,
	hpa@zytor.com
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH] fbdev: vesafb: Detect VGA compatibility from screen info's VESA attributes
Date: Thu, 13 Jun 2024 11:02:22 +0200
Message-ID: <20240613090240.7107-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 73A8B5D079
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmx.de,ravnborg.org,redhat.com,zytor.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Test the vesa_attributes field in struct screen_info for compatibility
with VGA hardware. Vesafb currently tests bit 1 in screen_info's
capabilities field, It sets the framebuffer address size and is
unrelated to VGA.

Section 4.4 of the Vesa VBE 2.0 specifications defines that bit 5 in
the mode's attributes field signals VGA compatibility. The mode is
compatible with VGA hardware if the bit is clear. In that case, the
driver can access VGA state of the VBE's underlying hardware. The
vesafb driver uses this feature to program the color LUT in palette
modes. Without, colors might be incorrect.

The problem got introduced in commit 89ec4c238e7a ("[PATCH] vesafb: Fix
incorrect logo colors in x86_64"). It incorrectly stores the mode
attributes in the screen_info's capabilities field and updates vesafb
accordingly. Later, commit 5e8ddcbe8692 ("Video mode probing support for
the new x86 setup code") fixed the screen_info, but did not update vesafb.
Color output still tends to work, because bit 1 in capabilities is
usually 0.

Besides fixing the bug in vesafb, this commit introduces a helper that
reads the correct bit from screen_info.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 5e8ddcbe8692 ("Video mode probing support for the new x86 setup code")
Cc: <stable@vger.kernel.org> # v2.6.23+
---
 drivers/video/fbdev/vesafb.c | 2 +-
 include/linux/screen_info.h  | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
index 8ab64ae4cad3e..5a161750a3aee 100644
--- a/drivers/video/fbdev/vesafb.c
+++ b/drivers/video/fbdev/vesafb.c
@@ -271,7 +271,7 @@ static int vesafb_probe(struct platform_device *dev)
 	if (si->orig_video_isVGA != VIDEO_TYPE_VLFB)
 		return -ENODEV;
 
-	vga_compat = (si->capabilities & 2) ? 0 : 1;
+	vga_compat = !__screen_info_vbe_mode_nonvga(si);
 	vesafb_fix.smem_start = si->lfb_base;
 	vesafb_defined.bits_per_pixel = si->lfb_depth;
 	if (15 == vesafb_defined.bits_per_pixel)
diff --git a/include/linux/screen_info.h b/include/linux/screen_info.h
index 75303c126285a..95f2a339de329 100644
--- a/include/linux/screen_info.h
+++ b/include/linux/screen_info.h
@@ -49,6 +49,11 @@ static inline u64 __screen_info_lfb_size(const struct screen_info *si, unsigned
 	return lfb_size;
 }
 
+static inline bool __screen_info_vbe_mode_nonvga(const struct screen_info *si)
+{
+	return si->vesa_attributes & BIT(5); // VGA if _not_ set
+}
+
 static inline unsigned int __screen_info_video_type(unsigned int type)
 {
 	switch (type) {
-- 
2.45.2


