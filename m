Return-Path: <stable+bounces-100885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F7E9EE48C
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 11:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C64018873C1
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 10:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED367211470;
	Thu, 12 Dec 2024 10:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="N/C+jDgF"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC6E1F2381
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 10:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734000981; cv=none; b=iQJv6LS0Iq7t8eXpn/eIY9Yko1wEKgyhf/OWCbeI+dvWHf8dY9Uba8gsfADQmM9RKWd0TAjRhFt8/JD/3ejMyWr4uKRQj3nM6Xzwk4+Uw7VAgN0Thkl0OW/iQn4N1ik371807ccH7ueMpBZpHRB5D95IKIpp1YF/dj309ikaZ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734000981; c=relaxed/simple;
	bh=AKaNnwMuf2jM4Q0uXuqdguknnEmykJ1knp/WBnZTQAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nU6fr4GrjLUu0FBltc//2iaNZjIp/KBDzX2DLqyxIi2KVYfQ1QDJ9C2/0RNzWOfInsnCYpu2O4k3d+mq8RXsORaqMubBUorb31/P5SmZ/ADMztM7NwOGY+1fSIgHMHIFxAcgY1XtYblXsrmLYQH3LCNGyPfa5PKIkPrI5Ad44rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=N/C+jDgF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so4233095e9.1
        for <stable@vger.kernel.org>; Thu, 12 Dec 2024 02:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1734000977; x=1734605777; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=attsE8hEORDjemvlGL7pyaKeKjhS5BgwJfmSRZH5MFI=;
        b=N/C+jDgFVJ7Oj0yWoTFmTBkl98k8JR3b5fNEfZcBjFungCgOFHoX6fVGx+wT8a729Z
         s2efJrNOfy5hgKnXrHfSQ95bKQ1rq3yU774AbSXdmhchFrfVhBGvsz+/iwfNAf+Qwc2+
         ukXfBq5G+0gN1PvQef8rO9rCVBupIhewVua90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734000977; x=1734605777;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=attsE8hEORDjemvlGL7pyaKeKjhS5BgwJfmSRZH5MFI=;
        b=dOdsyClVTkjjqTd1o3e8JY42Rhe0D6eELMuVp/GpVZzl/jlEdvLdjkSgBz0vHIsrsc
         Q2Y3eDYY8uHT3keztYQefL9GQvs0l3Dzc7AJzS5kNbdvuiYU6UDozCGUR96iF87I6K3l
         UK7H11R2LmL6o2YLwCKbriwjSeo8TDxTHDJ18MmGZWQdCKM0SG85hviQzN7hyX53tLTF
         Bhm/ozN/6qPE+2y6nVxku9GL2gyyOD6Cz9NiMv2rQX/4Z46a5Wb4aikU/0HKTxFhuDkE
         IjmmuWMqAEGDSg5HK33duZ+VbFaZtsCRN6LTOF+ZE0rgJZvrrOONOyQMuVLushyAdfGL
         y3lg==
X-Forwarded-Encrypted: i=1; AJvYcCWybr2GB3DFaTn3d0lx38ag5oDKrdZMjc0JlIIqAkxBLCS0/ITKnrTMJTeSB0pEuHfBXSoH/8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8CnwEqnG6HZ2x/4Lc6HZyJjjY9ux0iLqjPgQNQ6n8Sow5d0L2
	4C6hIDtOY9wgDEOEaf7xy2FoXtgBqACDOHbkm2XD7qGWymGkSIxjDFASsBUw7+o=
X-Gm-Gg: ASbGncsbrA2OPX8W/lKes23hJoiy41iWqqMnfU4jOU+uqKMSRRJ18g1JUvRdhvpQt6u
	1rnxXFiuGeyES74ddnlPTgl5ZDEkhfG9V5o6qctmHMJtur2Y6UhgNhZodkfO2+JpN/jrJOcZeHs
	v+JDnky6p1uBFo6nb0ffFTsCplES1/OB0eAcbdoynlB/UG4cGerkxBf3VSv9akMOCw2k0rz8QZ3
	o0gSkl5nF7QbuI+t8icGWp5ck92Hp7AqmRzcxWgQBMlHoYJuiBukDk5R1Y9Rk88k285
X-Google-Smtp-Source: AGHT+IEbTjr2n8d9Zsd/VKiFToITqIRzGlIA8jiihGPxhwXLnAVIgbqWfX9JtmYjLxTgfgmaBfphNA==
X-Received: by 2002:a5d:6f16:0:b0:385:f44a:a53 with SMTP id ffacd0b85a97d-3878768512cmr2192738f8f.4.1734000976635;
        Thu, 12 Dec 2024 02:56:16 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824bf228sm3682221f8f.51.2024.12.12.02.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 02:56:16 -0800 (PST)
Date: Thu, 12 Dec 2024 11:56:13 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: javierm@redhat.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
	regressions@leemhuis.info, nunojpg@gmail.com,
	dri-devel@lists.freedesktop.org, regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/fbdev-dma: Add shadow buffering for deferred I/O
Message-ID: <Z1rBTcM4xbi_jrXb@phenom.ffwll.local>
References: <20241211090643.74250-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241211090643.74250-1-tzimmermann@suse.de>
X-Operating-System: Linux phenom 6.11.6-amd64 

On Wed, Dec 11, 2024 at 10:06:28AM +0100, Thomas Zimmermann wrote:
> DMA areas are not necessarily backed by struct page, so we cannot
> rely on it for deferred I/O. Allocate a shadow buffer for drivers
> that require deferred I/O and use it as framebuffer memory.
> 
> Fixes driver errors about being "Unable to handle kernel NULL pointer
> dereference at virtual address" or "Unable to handle kernel paging
> request at virtual address".
> 
> The patch splits drm_fbdev_dma_driver_fbdev_probe() in an initial
> allocation, which creates the DMA-backed buffer object, and a tail
> that sets up the fbdev data structures. There is a tail function for
> direct memory mappings and a tail function for deferred I/O with
> the shadow buffer.
> 
> It is no longer possible to use deferred I/O without shadow buffer.
> It can be re-added if there exists a reliably test for usable struct
> page in the allocated DMA-backed buffer object.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reported-by: Nuno Gonçalves <nunojpg@gmail.com>
> CLoses: https://lore.kernel.org/dri-devel/CAEXMXLR55DziAMbv_+2hmLeH-jP96pmit6nhs6siB22cpQFr9w@mail.gmail.com/
> Tested-by: Nuno Gonçalves <nunojpg@gmail.com>
> Fixes: 5ab91447aa13 ("drm/tiny/ili9225: Use fbdev-dma")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: <stable@vger.kernel.org> # v6.11+

fbdev code scares me, but I at least tried to check a few things and looks
all good.

Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/drm_fbdev_dma.c | 217 +++++++++++++++++++++++---------
>  1 file changed, 155 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_fbdev_dma.c b/drivers/gpu/drm/drm_fbdev_dma.c
> index b14b581c059d..02a516e77192 100644
> --- a/drivers/gpu/drm/drm_fbdev_dma.c
> +++ b/drivers/gpu/drm/drm_fbdev_dma.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: MIT
>  
>  #include <linux/fb.h>
> +#include <linux/vmalloc.h>
>  
>  #include <drm/drm_drv.h>
>  #include <drm/drm_fbdev_dma.h>
> @@ -70,37 +71,102 @@ static const struct fb_ops drm_fbdev_dma_fb_ops = {
>  	.fb_destroy = drm_fbdev_dma_fb_destroy,
>  };
>  
> -FB_GEN_DEFAULT_DEFERRED_DMAMEM_OPS(drm_fbdev_dma,
> +FB_GEN_DEFAULT_DEFERRED_DMAMEM_OPS(drm_fbdev_dma_shadowed,
>  				   drm_fb_helper_damage_range,
>  				   drm_fb_helper_damage_area);
>  
> -static int drm_fbdev_dma_deferred_fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
> +static void drm_fbdev_dma_shadowed_fb_destroy(struct fb_info *info)
>  {
>  	struct drm_fb_helper *fb_helper = info->par;
> -	struct drm_framebuffer *fb = fb_helper->fb;
> -	struct drm_gem_dma_object *dma = drm_fb_dma_get_gem_obj(fb, 0);
> +	void *shadow = info->screen_buffer;
> +
> +	if (!fb_helper->dev)
> +		return;
>  
> -	if (!dma->map_noncoherent)
> -		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
> +	if (info->fbdefio)
> +		fb_deferred_io_cleanup(info);
> +	drm_fb_helper_fini(fb_helper);
> +	vfree(shadow);
>  
> -	return fb_deferred_io_mmap(info, vma);
> +	drm_client_buffer_vunmap(fb_helper->buffer);
> +	drm_client_framebuffer_delete(fb_helper->buffer);
> +	drm_client_release(&fb_helper->client);
> +	drm_fb_helper_unprepare(fb_helper);
> +	kfree(fb_helper);
>  }
>  
> -static const struct fb_ops drm_fbdev_dma_deferred_fb_ops = {
> +static const struct fb_ops drm_fbdev_dma_shadowed_fb_ops = {
>  	.owner = THIS_MODULE,
>  	.fb_open = drm_fbdev_dma_fb_open,
>  	.fb_release = drm_fbdev_dma_fb_release,
> -	__FB_DEFAULT_DEFERRED_OPS_RDWR(drm_fbdev_dma),
> +	FB_DEFAULT_DEFERRED_OPS(drm_fbdev_dma_shadowed),
>  	DRM_FB_HELPER_DEFAULT_OPS,
> -	__FB_DEFAULT_DEFERRED_OPS_DRAW(drm_fbdev_dma),
> -	.fb_mmap = drm_fbdev_dma_deferred_fb_mmap,
> -	.fb_destroy = drm_fbdev_dma_fb_destroy,
> +	.fb_destroy = drm_fbdev_dma_shadowed_fb_destroy,
>  };
>  
>  /*
>   * struct drm_fb_helper
>   */
>  
> +static void drm_fbdev_dma_damage_blit_real(struct drm_fb_helper *fb_helper,
> +					   struct drm_clip_rect *clip,
> +					   struct iosys_map *dst)
> +{
> +	struct drm_framebuffer *fb = fb_helper->fb;
> +	size_t offset = clip->y1 * fb->pitches[0];
> +	size_t len = clip->x2 - clip->x1;
> +	unsigned int y;
> +	void *src;
> +
> +	switch (drm_format_info_bpp(fb->format, 0)) {
> +	case 1:
> +		offset += clip->x1 / 8;
> +		len = DIV_ROUND_UP(len + clip->x1 % 8, 8);
> +		break;
> +	case 2:
> +		offset += clip->x1 / 4;
> +		len = DIV_ROUND_UP(len + clip->x1 % 4, 4);
> +		break;
> +	case 4:
> +		offset += clip->x1 / 2;
> +		len = DIV_ROUND_UP(len + clip->x1 % 2, 2);
> +		break;
> +	default:
> +		offset += clip->x1 * fb->format->cpp[0];
> +		len *= fb->format->cpp[0];
> +		break;
> +	}
> +
> +	src = fb_helper->info->screen_buffer + offset;
> +	iosys_map_incr(dst, offset); /* go to first pixel within clip rect */
> +
> +	for (y = clip->y1; y < clip->y2; y++) {
> +		iosys_map_memcpy_to(dst, 0, src, len);
> +		iosys_map_incr(dst, fb->pitches[0]);
> +		src += fb->pitches[0];
> +	}
> +}
> +
> +static int drm_fbdev_dma_damage_blit(struct drm_fb_helper *fb_helper,
> +				     struct drm_clip_rect *clip)
> +{
> +	struct drm_client_buffer *buffer = fb_helper->buffer;
> +	struct iosys_map dst;
> +
> +	/*
> +	 * For fbdev emulation, we only have to protect against fbdev modeset
> +	 * operations. Nothing else will involve the client buffer's BO. So it
> +	 * is sufficient to acquire struct drm_fb_helper.lock here.
> +	 */
> +	mutex_lock(&fb_helper->lock);
> +
> +	dst = buffer->map;
> +	drm_fbdev_dma_damage_blit_real(fb_helper, clip, &dst);
> +
> +	mutex_unlock(&fb_helper->lock);
> +
> +	return 0;
> +}
>  static int drm_fbdev_dma_helper_fb_dirty(struct drm_fb_helper *helper,
>  					 struct drm_clip_rect *clip)
>  {
> @@ -112,6 +178,10 @@ static int drm_fbdev_dma_helper_fb_dirty(struct drm_fb_helper *helper,
>  		return 0;
>  
>  	if (helper->fb->funcs->dirty) {
> +		ret = drm_fbdev_dma_damage_blit(helper, clip);
> +		if (drm_WARN_ONCE(dev, ret, "Damage blitter failed: ret=%d\n", ret))
> +			return ret;
> +
>  		ret = helper->fb->funcs->dirty(helper->fb, NULL, 0, 0, clip, 1);
>  		if (drm_WARN_ONCE(dev, ret, "Dirty helper failed: ret=%d\n", ret))
>  			return ret;
> @@ -128,14 +198,80 @@ static const struct drm_fb_helper_funcs drm_fbdev_dma_helper_funcs = {
>   * struct drm_fb_helper
>   */
>  
> +static int drm_fbdev_dma_driver_fbdev_probe_tail(struct drm_fb_helper *fb_helper,
> +						 struct drm_fb_helper_surface_size *sizes)
> +{
> +	struct drm_device *dev = fb_helper->dev;
> +	struct drm_client_buffer *buffer = fb_helper->buffer;
> +	struct drm_gem_dma_object *dma_obj = to_drm_gem_dma_obj(buffer->gem);
> +	struct drm_framebuffer *fb = fb_helper->fb;
> +	struct fb_info *info = fb_helper->info;
> +	struct iosys_map map = buffer->map;
> +
> +	info->fbops = &drm_fbdev_dma_fb_ops;
> +
> +	/* screen */
> +	info->flags |= FBINFO_VIRTFB; /* system memory */
> +	if (dma_obj->map_noncoherent)
> +		info->flags |= FBINFO_READS_FAST; /* signal caching */
> +	info->screen_size = sizes->surface_height * fb->pitches[0];
> +	info->screen_buffer = map.vaddr;
> +	if (!(info->flags & FBINFO_HIDE_SMEM_START)) {
> +		if (!drm_WARN_ON(dev, is_vmalloc_addr(info->screen_buffer)))
> +			info->fix.smem_start = page_to_phys(virt_to_page(info->screen_buffer));
> +	}
> +	info->fix.smem_len = info->screen_size;
> +
> +	return 0;
> +}
> +
> +static int drm_fbdev_dma_driver_fbdev_probe_tail_shadowed(struct drm_fb_helper *fb_helper,
> +							  struct drm_fb_helper_surface_size *sizes)
> +{
> +	struct drm_client_buffer *buffer = fb_helper->buffer;
> +	struct fb_info *info = fb_helper->info;
> +	size_t screen_size = buffer->gem->size;
> +	void *screen_buffer;
> +	int ret;
> +
> +	/*
> +	 * Deferred I/O requires struct page for framebuffer memory,
> +	 * which is not guaranteed for all DMA ranges. We thus create
> +	 * a shadow buffer in system memory.
> +	 */
> +	screen_buffer = vzalloc(screen_size);
> +	if (!screen_buffer)
> +		return -ENOMEM;
> +
> +	info->fbops = &drm_fbdev_dma_shadowed_fb_ops;
> +
> +	/* screen */
> +	info->flags |= FBINFO_VIRTFB; /* system memory */
> +	info->flags |= FBINFO_READS_FAST; /* signal caching */
> +	info->screen_buffer = screen_buffer;
> +	info->fix.smem_len = screen_size;
> +
> +	fb_helper->fbdefio.delay = HZ / 20;
> +	fb_helper->fbdefio.deferred_io = drm_fb_helper_deferred_io;
> +
> +	info->fbdefio = &fb_helper->fbdefio;
> +	ret = fb_deferred_io_init(info);
> +	if (ret)
> +		goto err_vfree;
> +
> +	return 0;
> +
> +err_vfree:
> +	vfree(screen_buffer);
> +	return ret;
> +}
> +
>  int drm_fbdev_dma_driver_fbdev_probe(struct drm_fb_helper *fb_helper,
>  				     struct drm_fb_helper_surface_size *sizes)
>  {
>  	struct drm_client_dev *client = &fb_helper->client;
>  	struct drm_device *dev = fb_helper->dev;
> -	bool use_deferred_io = false;
>  	struct drm_client_buffer *buffer;
> -	struct drm_gem_dma_object *dma_obj;
>  	struct drm_framebuffer *fb;
>  	struct fb_info *info;
>  	u32 format;
> @@ -152,19 +288,9 @@ int drm_fbdev_dma_driver_fbdev_probe(struct drm_fb_helper *fb_helper,
>  					       sizes->surface_height, format);
>  	if (IS_ERR(buffer))
>  		return PTR_ERR(buffer);
> -	dma_obj = to_drm_gem_dma_obj(buffer->gem);
>  
>  	fb = buffer->fb;
>  
> -	/*
> -	 * Deferred I/O requires struct page for framebuffer memory,
> -	 * which is not guaranteed for all DMA ranges. We thus only
> -	 * install deferred I/O if we have a framebuffer that requires
> -	 * it.
> -	 */
> -	if (fb->funcs->dirty)
> -		use_deferred_io = true;
> -
>  	ret = drm_client_buffer_vmap(buffer, &map);
>  	if (ret) {
>  		goto err_drm_client_buffer_delete;
> @@ -185,45 +311,12 @@ int drm_fbdev_dma_driver_fbdev_probe(struct drm_fb_helper *fb_helper,
>  
>  	drm_fb_helper_fill_info(info, fb_helper, sizes);
>  
> -	if (use_deferred_io)
> -		info->fbops = &drm_fbdev_dma_deferred_fb_ops;
> +	if (fb->funcs->dirty)
> +		ret = drm_fbdev_dma_driver_fbdev_probe_tail_shadowed(fb_helper, sizes);
>  	else
> -		info->fbops = &drm_fbdev_dma_fb_ops;
> -
> -	/* screen */
> -	info->flags |= FBINFO_VIRTFB; /* system memory */
> -	if (dma_obj->map_noncoherent)
> -		info->flags |= FBINFO_READS_FAST; /* signal caching */
> -	info->screen_size = sizes->surface_height * fb->pitches[0];
> -	info->screen_buffer = map.vaddr;
> -	if (!(info->flags & FBINFO_HIDE_SMEM_START)) {
> -		if (!drm_WARN_ON(dev, is_vmalloc_addr(info->screen_buffer)))
> -			info->fix.smem_start = page_to_phys(virt_to_page(info->screen_buffer));
> -	}
> -	info->fix.smem_len = info->screen_size;
> -
> -	/*
> -	 * Only set up deferred I/O if the screen buffer supports
> -	 * it. If this disagrees with the previous test for ->dirty,
> -	 * mmap on the /dev/fb file might not work correctly.
> -	 */
> -	if (!is_vmalloc_addr(info->screen_buffer) && info->fix.smem_start) {
> -		unsigned long pfn = info->fix.smem_start >> PAGE_SHIFT;
> -
> -		if (drm_WARN_ON(dev, !pfn_to_page(pfn)))
> -			use_deferred_io = false;
> -	}
> -
> -	/* deferred I/O */
> -	if (use_deferred_io) {
> -		fb_helper->fbdefio.delay = HZ / 20;
> -		fb_helper->fbdefio.deferred_io = drm_fb_helper_deferred_io;
> -
> -		info->fbdefio = &fb_helper->fbdefio;
> -		ret = fb_deferred_io_init(info);
> -		if (ret)
> -			goto err_drm_fb_helper_release_info;
> -	}
> +		ret = drm_fbdev_dma_driver_fbdev_probe_tail(fb_helper, sizes);
> +	if (ret)
> +		goto err_drm_fb_helper_release_info;
>  
>  	return 0;
>  
> -- 
> 2.47.1
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

