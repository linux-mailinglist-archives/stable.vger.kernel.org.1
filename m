Return-Path: <stable+bounces-100583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C97E99EC859
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 10:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FEB41888CCB
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 09:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2EC1F8695;
	Wed, 11 Dec 2024 09:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xnpjIA3X";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IK72y9UF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xnpjIA3X";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IK72y9UF"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B045C1F8685
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 09:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908015; cv=none; b=DsEPpsMkQYgo94sj+al7Dp2D/1/PrgDQjY8YboMs7+ZviSGxwWqqgQo+t47XoxKNYNzyilpxeax4hPS6MnuUQ20/iap5B9T88TuIzd8SN/hdGaMLFyom5Ttzu/dRWh2+0fDHfj9j837qlbqVBG4kHpZJqIJgWRUKrZ6iLGzmmj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908015; c=relaxed/simple;
	bh=YZaWfcKZHNGWRR0Sf+SedxNkXO9Bdy0UhZ/0uQqMxWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cMkmPpLibP6fxBTbk2H6fucGqHlPtEmq/2Cs1m3NbUb7YZAP8tgWLeJuQKx6KNojKSNzL6mudX3T+e5ljtUO3qvrCWu12f1Ue9Sk3YKxqUMcpMBgh2YTMDmmetZoOZj8V+gU1Zy6HcO9d1926koDJtYalBXY+2fd2ZY0J+XepwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xnpjIA3X; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IK72y9UF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xnpjIA3X; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IK72y9UF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C483521166;
	Wed, 11 Dec 2024 09:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733908010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VVMQAKxvJUrIeQiVpoHxZbbRnNcqkrPAIforSAvOHMo=;
	b=xnpjIA3XGtAkDvQhrJTGzwDFMKAuLKx/Ch1DfE2Dw/x/YAhvEiIYhfU5VLbi9P0Su/SoVz
	MKmctPKy5KJ2g1cW7YISZCEaf5X0QF0IRMkZom/UNiKGP6H7Id1+4X1AOQUfNXROFpwwIv
	AT7bT5zPLIqD+yU7PGgL7XGxxblHiio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733908010;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VVMQAKxvJUrIeQiVpoHxZbbRnNcqkrPAIforSAvOHMo=;
	b=IK72y9UFrbBnNch0TqC2An96mve4H1VtvCQSjRHtZsf73oud1IpFD8RjxPKajcdvOydnn0
	gAH0c/Es/df68RBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xnpjIA3X;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IK72y9UF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733908010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VVMQAKxvJUrIeQiVpoHxZbbRnNcqkrPAIforSAvOHMo=;
	b=xnpjIA3XGtAkDvQhrJTGzwDFMKAuLKx/Ch1DfE2Dw/x/YAhvEiIYhfU5VLbi9P0Su/SoVz
	MKmctPKy5KJ2g1cW7YISZCEaf5X0QF0IRMkZom/UNiKGP6H7Id1+4X1AOQUfNXROFpwwIv
	AT7bT5zPLIqD+yU7PGgL7XGxxblHiio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733908010;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VVMQAKxvJUrIeQiVpoHxZbbRnNcqkrPAIforSAvOHMo=;
	b=IK72y9UFrbBnNch0TqC2An96mve4H1VtvCQSjRHtZsf73oud1IpFD8RjxPKajcdvOydnn0
	gAH0c/Es/df68RBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A1601344A;
	Wed, 11 Dec 2024 09:06:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z/iQHCpWWWctQwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 11 Dec 2024 09:06:50 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	regressions@leemhuis.info
Cc: nunojpg@gmail.com,
	dri-devel@lists.freedesktop.org,
	regressions@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH] drm/fbdev-dma: Add shadow buffering for deferred I/O
Date: Wed, 11 Dec 2024 10:06:28 +0100
Message-ID: <20241211090643.74250-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C483521166
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,leemhuis.info];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,lists.freedesktop.org,lists.linux.dev,suse.de,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

DMA areas are not necessarily backed by struct page, so we cannot
rely on it for deferred I/O. Allocate a shadow buffer for drivers
that require deferred I/O and use it as framebuffer memory.

Fixes driver errors about being "Unable to handle kernel NULL pointer
dereference at virtual address" or "Unable to handle kernel paging
request at virtual address".

The patch splits drm_fbdev_dma_driver_fbdev_probe() in an initial
allocation, which creates the DMA-backed buffer object, and a tail
that sets up the fbdev data structures. There is a tail function for
direct memory mappings and a tail function for deferred I/O with
the shadow buffer.

It is no longer possible to use deferred I/O without shadow buffer.
It can be re-added if there exists a reliably test for usable struct
page in the allocated DMA-backed buffer object.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reported-by: Nuno Gonçalves <nunojpg@gmail.com>
CLoses: https://lore.kernel.org/dri-devel/CAEXMXLR55DziAMbv_+2hmLeH-jP96pmit6nhs6siB22cpQFr9w@mail.gmail.com/
Tested-by: Nuno Gonçalves <nunojpg@gmail.com>
Fixes: 5ab91447aa13 ("drm/tiny/ili9225: Use fbdev-dma")
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: <stable@vger.kernel.org> # v6.11+
---
 drivers/gpu/drm/drm_fbdev_dma.c | 217 +++++++++++++++++++++++---------
 1 file changed, 155 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/drm_fbdev_dma.c b/drivers/gpu/drm/drm_fbdev_dma.c
index b14b581c059d..02a516e77192 100644
--- a/drivers/gpu/drm/drm_fbdev_dma.c
+++ b/drivers/gpu/drm/drm_fbdev_dma.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: MIT
 
 #include <linux/fb.h>
+#include <linux/vmalloc.h>
 
 #include <drm/drm_drv.h>
 #include <drm/drm_fbdev_dma.h>
@@ -70,37 +71,102 @@ static const struct fb_ops drm_fbdev_dma_fb_ops = {
 	.fb_destroy = drm_fbdev_dma_fb_destroy,
 };
 
-FB_GEN_DEFAULT_DEFERRED_DMAMEM_OPS(drm_fbdev_dma,
+FB_GEN_DEFAULT_DEFERRED_DMAMEM_OPS(drm_fbdev_dma_shadowed,
 				   drm_fb_helper_damage_range,
 				   drm_fb_helper_damage_area);
 
-static int drm_fbdev_dma_deferred_fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
+static void drm_fbdev_dma_shadowed_fb_destroy(struct fb_info *info)
 {
 	struct drm_fb_helper *fb_helper = info->par;
-	struct drm_framebuffer *fb = fb_helper->fb;
-	struct drm_gem_dma_object *dma = drm_fb_dma_get_gem_obj(fb, 0);
+	void *shadow = info->screen_buffer;
+
+	if (!fb_helper->dev)
+		return;
 
-	if (!dma->map_noncoherent)
-		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+	if (info->fbdefio)
+		fb_deferred_io_cleanup(info);
+	drm_fb_helper_fini(fb_helper);
+	vfree(shadow);
 
-	return fb_deferred_io_mmap(info, vma);
+	drm_client_buffer_vunmap(fb_helper->buffer);
+	drm_client_framebuffer_delete(fb_helper->buffer);
+	drm_client_release(&fb_helper->client);
+	drm_fb_helper_unprepare(fb_helper);
+	kfree(fb_helper);
 }
 
-static const struct fb_ops drm_fbdev_dma_deferred_fb_ops = {
+static const struct fb_ops drm_fbdev_dma_shadowed_fb_ops = {
 	.owner = THIS_MODULE,
 	.fb_open = drm_fbdev_dma_fb_open,
 	.fb_release = drm_fbdev_dma_fb_release,
-	__FB_DEFAULT_DEFERRED_OPS_RDWR(drm_fbdev_dma),
+	FB_DEFAULT_DEFERRED_OPS(drm_fbdev_dma_shadowed),
 	DRM_FB_HELPER_DEFAULT_OPS,
-	__FB_DEFAULT_DEFERRED_OPS_DRAW(drm_fbdev_dma),
-	.fb_mmap = drm_fbdev_dma_deferred_fb_mmap,
-	.fb_destroy = drm_fbdev_dma_fb_destroy,
+	.fb_destroy = drm_fbdev_dma_shadowed_fb_destroy,
 };
 
 /*
  * struct drm_fb_helper
  */
 
+static void drm_fbdev_dma_damage_blit_real(struct drm_fb_helper *fb_helper,
+					   struct drm_clip_rect *clip,
+					   struct iosys_map *dst)
+{
+	struct drm_framebuffer *fb = fb_helper->fb;
+	size_t offset = clip->y1 * fb->pitches[0];
+	size_t len = clip->x2 - clip->x1;
+	unsigned int y;
+	void *src;
+
+	switch (drm_format_info_bpp(fb->format, 0)) {
+	case 1:
+		offset += clip->x1 / 8;
+		len = DIV_ROUND_UP(len + clip->x1 % 8, 8);
+		break;
+	case 2:
+		offset += clip->x1 / 4;
+		len = DIV_ROUND_UP(len + clip->x1 % 4, 4);
+		break;
+	case 4:
+		offset += clip->x1 / 2;
+		len = DIV_ROUND_UP(len + clip->x1 % 2, 2);
+		break;
+	default:
+		offset += clip->x1 * fb->format->cpp[0];
+		len *= fb->format->cpp[0];
+		break;
+	}
+
+	src = fb_helper->info->screen_buffer + offset;
+	iosys_map_incr(dst, offset); /* go to first pixel within clip rect */
+
+	for (y = clip->y1; y < clip->y2; y++) {
+		iosys_map_memcpy_to(dst, 0, src, len);
+		iosys_map_incr(dst, fb->pitches[0]);
+		src += fb->pitches[0];
+	}
+}
+
+static int drm_fbdev_dma_damage_blit(struct drm_fb_helper *fb_helper,
+				     struct drm_clip_rect *clip)
+{
+	struct drm_client_buffer *buffer = fb_helper->buffer;
+	struct iosys_map dst;
+
+	/*
+	 * For fbdev emulation, we only have to protect against fbdev modeset
+	 * operations. Nothing else will involve the client buffer's BO. So it
+	 * is sufficient to acquire struct drm_fb_helper.lock here.
+	 */
+	mutex_lock(&fb_helper->lock);
+
+	dst = buffer->map;
+	drm_fbdev_dma_damage_blit_real(fb_helper, clip, &dst);
+
+	mutex_unlock(&fb_helper->lock);
+
+	return 0;
+}
 static int drm_fbdev_dma_helper_fb_dirty(struct drm_fb_helper *helper,
 					 struct drm_clip_rect *clip)
 {
@@ -112,6 +178,10 @@ static int drm_fbdev_dma_helper_fb_dirty(struct drm_fb_helper *helper,
 		return 0;
 
 	if (helper->fb->funcs->dirty) {
+		ret = drm_fbdev_dma_damage_blit(helper, clip);
+		if (drm_WARN_ONCE(dev, ret, "Damage blitter failed: ret=%d\n", ret))
+			return ret;
+
 		ret = helper->fb->funcs->dirty(helper->fb, NULL, 0, 0, clip, 1);
 		if (drm_WARN_ONCE(dev, ret, "Dirty helper failed: ret=%d\n", ret))
 			return ret;
@@ -128,14 +198,80 @@ static const struct drm_fb_helper_funcs drm_fbdev_dma_helper_funcs = {
  * struct drm_fb_helper
  */
 
+static int drm_fbdev_dma_driver_fbdev_probe_tail(struct drm_fb_helper *fb_helper,
+						 struct drm_fb_helper_surface_size *sizes)
+{
+	struct drm_device *dev = fb_helper->dev;
+	struct drm_client_buffer *buffer = fb_helper->buffer;
+	struct drm_gem_dma_object *dma_obj = to_drm_gem_dma_obj(buffer->gem);
+	struct drm_framebuffer *fb = fb_helper->fb;
+	struct fb_info *info = fb_helper->info;
+	struct iosys_map map = buffer->map;
+
+	info->fbops = &drm_fbdev_dma_fb_ops;
+
+	/* screen */
+	info->flags |= FBINFO_VIRTFB; /* system memory */
+	if (dma_obj->map_noncoherent)
+		info->flags |= FBINFO_READS_FAST; /* signal caching */
+	info->screen_size = sizes->surface_height * fb->pitches[0];
+	info->screen_buffer = map.vaddr;
+	if (!(info->flags & FBINFO_HIDE_SMEM_START)) {
+		if (!drm_WARN_ON(dev, is_vmalloc_addr(info->screen_buffer)))
+			info->fix.smem_start = page_to_phys(virt_to_page(info->screen_buffer));
+	}
+	info->fix.smem_len = info->screen_size;
+
+	return 0;
+}
+
+static int drm_fbdev_dma_driver_fbdev_probe_tail_shadowed(struct drm_fb_helper *fb_helper,
+							  struct drm_fb_helper_surface_size *sizes)
+{
+	struct drm_client_buffer *buffer = fb_helper->buffer;
+	struct fb_info *info = fb_helper->info;
+	size_t screen_size = buffer->gem->size;
+	void *screen_buffer;
+	int ret;
+
+	/*
+	 * Deferred I/O requires struct page for framebuffer memory,
+	 * which is not guaranteed for all DMA ranges. We thus create
+	 * a shadow buffer in system memory.
+	 */
+	screen_buffer = vzalloc(screen_size);
+	if (!screen_buffer)
+		return -ENOMEM;
+
+	info->fbops = &drm_fbdev_dma_shadowed_fb_ops;
+
+	/* screen */
+	info->flags |= FBINFO_VIRTFB; /* system memory */
+	info->flags |= FBINFO_READS_FAST; /* signal caching */
+	info->screen_buffer = screen_buffer;
+	info->fix.smem_len = screen_size;
+
+	fb_helper->fbdefio.delay = HZ / 20;
+	fb_helper->fbdefio.deferred_io = drm_fb_helper_deferred_io;
+
+	info->fbdefio = &fb_helper->fbdefio;
+	ret = fb_deferred_io_init(info);
+	if (ret)
+		goto err_vfree;
+
+	return 0;
+
+err_vfree:
+	vfree(screen_buffer);
+	return ret;
+}
+
 int drm_fbdev_dma_driver_fbdev_probe(struct drm_fb_helper *fb_helper,
 				     struct drm_fb_helper_surface_size *sizes)
 {
 	struct drm_client_dev *client = &fb_helper->client;
 	struct drm_device *dev = fb_helper->dev;
-	bool use_deferred_io = false;
 	struct drm_client_buffer *buffer;
-	struct drm_gem_dma_object *dma_obj;
 	struct drm_framebuffer *fb;
 	struct fb_info *info;
 	u32 format;
@@ -152,19 +288,9 @@ int drm_fbdev_dma_driver_fbdev_probe(struct drm_fb_helper *fb_helper,
 					       sizes->surface_height, format);
 	if (IS_ERR(buffer))
 		return PTR_ERR(buffer);
-	dma_obj = to_drm_gem_dma_obj(buffer->gem);
 
 	fb = buffer->fb;
 
-	/*
-	 * Deferred I/O requires struct page for framebuffer memory,
-	 * which is not guaranteed for all DMA ranges. We thus only
-	 * install deferred I/O if we have a framebuffer that requires
-	 * it.
-	 */
-	if (fb->funcs->dirty)
-		use_deferred_io = true;
-
 	ret = drm_client_buffer_vmap(buffer, &map);
 	if (ret) {
 		goto err_drm_client_buffer_delete;
@@ -185,45 +311,12 @@ int drm_fbdev_dma_driver_fbdev_probe(struct drm_fb_helper *fb_helper,
 
 	drm_fb_helper_fill_info(info, fb_helper, sizes);
 
-	if (use_deferred_io)
-		info->fbops = &drm_fbdev_dma_deferred_fb_ops;
+	if (fb->funcs->dirty)
+		ret = drm_fbdev_dma_driver_fbdev_probe_tail_shadowed(fb_helper, sizes);
 	else
-		info->fbops = &drm_fbdev_dma_fb_ops;
-
-	/* screen */
-	info->flags |= FBINFO_VIRTFB; /* system memory */
-	if (dma_obj->map_noncoherent)
-		info->flags |= FBINFO_READS_FAST; /* signal caching */
-	info->screen_size = sizes->surface_height * fb->pitches[0];
-	info->screen_buffer = map.vaddr;
-	if (!(info->flags & FBINFO_HIDE_SMEM_START)) {
-		if (!drm_WARN_ON(dev, is_vmalloc_addr(info->screen_buffer)))
-			info->fix.smem_start = page_to_phys(virt_to_page(info->screen_buffer));
-	}
-	info->fix.smem_len = info->screen_size;
-
-	/*
-	 * Only set up deferred I/O if the screen buffer supports
-	 * it. If this disagrees with the previous test for ->dirty,
-	 * mmap on the /dev/fb file might not work correctly.
-	 */
-	if (!is_vmalloc_addr(info->screen_buffer) && info->fix.smem_start) {
-		unsigned long pfn = info->fix.smem_start >> PAGE_SHIFT;
-
-		if (drm_WARN_ON(dev, !pfn_to_page(pfn)))
-			use_deferred_io = false;
-	}
-
-	/* deferred I/O */
-	if (use_deferred_io) {
-		fb_helper->fbdefio.delay = HZ / 20;
-		fb_helper->fbdefio.deferred_io = drm_fb_helper_deferred_io;
-
-		info->fbdefio = &fb_helper->fbdefio;
-		ret = fb_deferred_io_init(info);
-		if (ret)
-			goto err_drm_fb_helper_release_info;
-	}
+		ret = drm_fbdev_dma_driver_fbdev_probe_tail(fb_helper, sizes);
+	if (ret)
+		goto err_drm_fb_helper_release_info;
 
 	return 0;
 
-- 
2.47.1


