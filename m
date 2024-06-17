Return-Path: <stable+bounces-52372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C0590AC98
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 13:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328BC1C21B32
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 11:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996111922F8;
	Mon, 17 Jun 2024 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y/Umh5/F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5k8lIL0Z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y/Umh5/F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5k8lIL0Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABA8381A1;
	Mon, 17 Jun 2024 11:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718622451; cv=none; b=j8q5yXtlAYxhymk92q5KXe9d9nd5G2ysk7a/XxWJ97E3zzOeQuSIp4wi6TxYJMDDwE0H6adoDoqI5N3LnRk0kZpijvyZ5zsbvkonad7DT9V3di+sbR6iCrYl/tzLujbysdPC3T2MorJi55I0dBMCgGm8Z0IUq5kyhksbqfvgt3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718622451; c=relaxed/simple;
	bh=RtP8wAheFoOOEkCkaLF8usXE0SLRCKHCmldOK4qaZ04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mRoK1w917/CjBt0zZeXq7d25uzwe/DCKSyGJL+mptdvR8AlskNhd32xubaiNh8XWnJWi/PrKo51t7NNtRTL37cDvuQuvYLFDbwOV3ZtmxaS8SfyrBVwxL1qTscBbMkJXXl8LZk3D05Nhg+oMIQAcFTEjq66AYu8lw3ndh7hznhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y/Umh5/F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5k8lIL0Z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y/Umh5/F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5k8lIL0Z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 17DC93808C;
	Mon, 17 Jun 2024 11:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718622448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6fMJghq86sbIk0j2HmZPFpiOi6slBdV0aPUVDOFhaiE=;
	b=y/Umh5/F6SpgZBf8iUvMJQvSlSPyplBcEq+G17GOJfPc7sjcunmRIIZK8sFJBaIByw83TD
	29Wsi+MzzujWWj/yVNPQlLcmfKXFDeCBsqE021JKuu2SrjD1Mq/nJg7BTStAYs/XWoqNJl
	e/wwE2Zn38XNKWLMNKDkGXnbcN6WvAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718622448;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6fMJghq86sbIk0j2HmZPFpiOi6slBdV0aPUVDOFhaiE=;
	b=5k8lIL0Zgl0qv+BmlqUqMGKOu03y8Uj6Xw3ztK6dd+ukUWkw72jJAmBrM2Jg72pOaP9ZT0
	UfmOfl2rBe3soGBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718622448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6fMJghq86sbIk0j2HmZPFpiOi6slBdV0aPUVDOFhaiE=;
	b=y/Umh5/F6SpgZBf8iUvMJQvSlSPyplBcEq+G17GOJfPc7sjcunmRIIZK8sFJBaIByw83TD
	29Wsi+MzzujWWj/yVNPQlLcmfKXFDeCBsqE021JKuu2SrjD1Mq/nJg7BTStAYs/XWoqNJl
	e/wwE2Zn38XNKWLMNKDkGXnbcN6WvAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718622448;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6fMJghq86sbIk0j2HmZPFpiOi6slBdV0aPUVDOFhaiE=;
	b=5k8lIL0Zgl0qv+BmlqUqMGKOu03y8Uj6Xw3ztK6dd+ukUWkw72jJAmBrM2Jg72pOaP9ZT0
	UfmOfl2rBe3soGBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D051113AAA;
	Mon, 17 Jun 2024 11:07:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dtUwMe8YcGbvFQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 17 Jun 2024 11:07:27 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	sam@ravnborg.org,
	javierm@redhat.com,
	hpa@zytor.com
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH v2] fbdev: vesafb: Detect VGA compatibility from screen info's VESA attributes
Date: Mon, 17 Jun 2024 13:06:27 +0200
Message-ID: <20240617110725.23330-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	FREEMAIL_TO(0.00)[gmx.de,ravnborg.org,redhat.com,zytor.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

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

v2:
- clarify comment on non-VGA modes (Helge)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 5e8ddcbe8692 ("Video mode probing support for the new x86 setup code")
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Cc: <stable@vger.kernel.org> # v2.6.23+
---
 drivers/video/fbdev/vesafb.c |  2 +-
 include/linux/screen_info.h  | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

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
index 75303c126285a..d21f8e4e9f4a4 100644
--- a/include/linux/screen_info.h
+++ b/include/linux/screen_info.h
@@ -49,6 +49,16 @@ static inline u64 __screen_info_lfb_size(const struct screen_info *si, unsigned
 	return lfb_size;
 }
 
+static inline bool __screen_info_vbe_mode_nonvga(const struct screen_info *si)
+{
+	/*
+	 * VESA modes typically run on VGA hardware. Set bit 5 signal that this
+	 * is not the case. Drivers can then not make use of VGA resources. See
+	 * Sec 4.4 of the VBE 2.0 spec.
+	 */
+	return si->vesa_attributes & BIT(5);
+}
+
 static inline unsigned int __screen_info_video_type(unsigned int type)
 {
 	switch (type) {
-- 
2.45.2


