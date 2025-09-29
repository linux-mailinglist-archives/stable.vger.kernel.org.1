Return-Path: <stable+bounces-181863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E57BA8643
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 10:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9F2E3C1303
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 08:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5A126D4C1;
	Mon, 29 Sep 2025 08:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="evHPGrpK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X+xAXSKg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="evHPGrpK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X+xAXSKg"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B61219A81
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 08:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759134393; cv=none; b=S2h7V3qzyfAICHoiKROaXJ9dPVd8BcUco5L+H6GNtHxBTrG5lX3xHoqzmJOqUl2/AT0VvyTLAmXq5ZouewoMoDpdaOL0GXJc/3c5tKJVFBZtgRkCG3VIJBh06L0b29L8JrpB4+1ntQRerNEWPZyBB7Wxv2cT6mGNrJDs95ce0Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759134393; c=relaxed/simple;
	bh=560klkq7PdH/h3fI0nVBT+Nt5TTppGbblB1qtIfpS6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zq1C9SNpcW52xaOPKeTo3XTjUobRbtdP8MeD96YK4hGrtRWmOOZeMuw2Pq0jNE1UZ/rAGXgZaNX5iGTP7+6/XsCxzT1U8tj3NWfD+610TvK9Z7/eqsB1xKvz58AjREy1qmBIFu0DLot5OfVfXHRAPPzctwEh/esmXZKxAJXpgE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=evHPGrpK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X+xAXSKg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=evHPGrpK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X+xAXSKg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 15412303F2;
	Mon, 29 Sep 2025 08:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759134387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ftV2nISmrvOmX5rtXwSqZESh0cTotKlJR1zjnKJ/clw=;
	b=evHPGrpKP+cCI9CDQfDiXtUW5K9rDUkl3zLx9NhXjJkwJx9GbBr6YVMwsYliYlvDglvyhh
	hT5d3lm3FhqEU9nuGEzaOpSm00fCGZYTRLhsHGentoSLb+0/mWhpWsJb7V14s95iq9gQ+Z
	uaQwIc78tEBXQgTmYPyAsjwTLl2HjOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759134387;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ftV2nISmrvOmX5rtXwSqZESh0cTotKlJR1zjnKJ/clw=;
	b=X+xAXSKgmKEY7ZP0oyb68fFabYLxXXLVLcR1INl7ppXgrvhdAxp/GAlmjxJtgJa+gsj3VO
	PJ/ktrHXcO1IzPAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759134387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ftV2nISmrvOmX5rtXwSqZESh0cTotKlJR1zjnKJ/clw=;
	b=evHPGrpKP+cCI9CDQfDiXtUW5K9rDUkl3zLx9NhXjJkwJx9GbBr6YVMwsYliYlvDglvyhh
	hT5d3lm3FhqEU9nuGEzaOpSm00fCGZYTRLhsHGentoSLb+0/mWhpWsJb7V14s95iq9gQ+Z
	uaQwIc78tEBXQgTmYPyAsjwTLl2HjOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759134387;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ftV2nISmrvOmX5rtXwSqZESh0cTotKlJR1zjnKJ/clw=;
	b=X+xAXSKgmKEY7ZP0oyb68fFabYLxXXLVLcR1INl7ppXgrvhdAxp/GAlmjxJtgJa+gsj3VO
	PJ/ktrHXcO1IzPAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5E2413A21;
	Mon, 29 Sep 2025 08:26:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sG/SLrJC2mi0MgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 29 Sep 2025 08:26:26 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: patrik.r.jakobsson@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Stefan Christ <contact@stefanchrist.eu>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	stable@vger.kernel.org
Subject: [PATCH] drm/gma500: Remove unused helper psb_fbdev_fb_setcolreg()
Date: Mon, 29 Sep 2025 10:23:23 +0200
Message-ID: <20250929082338.18845-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,linux.intel.com,kernel.org,ffwll.ch];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -1.30

Remove psb_fbdev_fb_setcolreg(), which hasn't been called in almost
a decade.

Gma500 commit 4d8d096e9ae8 ("gma500: introduce the framebuffer support
code") added the helper psb_fbdev_fb_setcolreg() for setting the fbdev
palette via fbdev's fb_setcolreg callback. Later
commit 3da6c2f3b730 ("drm/gma500: use DRM_FB_HELPER_DEFAULT_OPS for
fb_ops") set several default helpers for fbdev emulation, including
fb_setcmap.

The fbdev subsystem always prefers fb_setcmap over fb_setcolreg. [1]
Hence, the gma500 code is no longer in use and gma500 has been using
drm_fb_helper_setcmap() for several years without issues.

Fixes: 3da6c2f3b730 ("drm/gma500: use DRM_FB_HELPER_DEFAULT_OPS for fb_ops")
Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: Stefan Christ <contact@stefanchrist.eu>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v4.10+
Link: https://elixir.bootlin.com/linux/v6.16.9/source/drivers/video/fbdev/core/fbcmap.c#L246 # [1]
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/gma500/fbdev.c | 43 ----------------------------------
 1 file changed, 43 deletions(-)

diff --git a/drivers/gpu/drm/gma500/fbdev.c b/drivers/gpu/drm/gma500/fbdev.c
index 32d31e5f5f1a..a6af21514cff 100644
--- a/drivers/gpu/drm/gma500/fbdev.c
+++ b/drivers/gpu/drm/gma500/fbdev.c
@@ -50,48 +50,6 @@ static const struct vm_operations_struct psb_fbdev_vm_ops = {
  * struct fb_ops
  */
 
-#define CMAP_TOHW(_val, _width) ((((_val) << (_width)) + 0x7FFF - (_val)) >> 16)
-
-static int psb_fbdev_fb_setcolreg(unsigned int regno,
-				  unsigned int red, unsigned int green,
-				  unsigned int blue, unsigned int transp,
-				  struct fb_info *info)
-{
-	struct drm_fb_helper *fb_helper = info->par;
-	struct drm_framebuffer *fb = fb_helper->fb;
-	uint32_t v;
-
-	if (!fb)
-		return -ENOMEM;
-
-	if (regno > 255)
-		return 1;
-
-	red = CMAP_TOHW(red, info->var.red.length);
-	blue = CMAP_TOHW(blue, info->var.blue.length);
-	green = CMAP_TOHW(green, info->var.green.length);
-	transp = CMAP_TOHW(transp, info->var.transp.length);
-
-	v = (red << info->var.red.offset) |
-	    (green << info->var.green.offset) |
-	    (blue << info->var.blue.offset) |
-	    (transp << info->var.transp.offset);
-
-	if (regno < 16) {
-		switch (fb->format->cpp[0] * 8) {
-		case 16:
-			((uint32_t *) info->pseudo_palette)[regno] = v;
-			break;
-		case 24:
-		case 32:
-			((uint32_t *) info->pseudo_palette)[regno] = v;
-			break;
-		}
-	}
-
-	return 0;
-}
-
 static int psb_fbdev_fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	if (vma->vm_pgoff != 0)
@@ -135,7 +93,6 @@ static const struct fb_ops psb_fbdev_fb_ops = {
 	.owner = THIS_MODULE,
 	__FB_DEFAULT_IOMEM_OPS_RDWR,
 	DRM_FB_HELPER_DEFAULT_OPS,
-	.fb_setcolreg = psb_fbdev_fb_setcolreg,
 	__FB_DEFAULT_IOMEM_OPS_DRAW,
 	.fb_mmap = psb_fbdev_fb_mmap,
 	.fb_destroy = psb_fbdev_fb_destroy,
-- 
2.51.0


