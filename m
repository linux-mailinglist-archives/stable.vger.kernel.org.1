Return-Path: <stable+bounces-161455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0964AAFEB32
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 16:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 588CE5C2887
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 14:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DE72DA779;
	Wed,  9 Jul 2025 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="IhClFQJN"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320152C3247
	for <stable@vger.kernel.org>; Wed,  9 Jul 2025 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069260; cv=none; b=EygXlkstej6Hh08QdqwzwpKBVEHoMVc/VI8jm61Mi70Xs15JzZtKHsXUHVV69YzGp/0Mx7MwpxDCyuS/fuujMQPZOjdkfGhXDsueI59iQUaP/y2E3GCDx5ZC7VN5aIi/hXG7WJqE26KTdkIFPMbnmhkL5fSQFONYNIKw4+Puq3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069260; c=relaxed/simple;
	bh=+uZLFnFM5N9TPmJ0U1TGD597Rha+KYSLeQsVlQ8Mv4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHDghfrnCCdXf79LxQAW3mvz0f13WbrubbVE5cGOn7lj/vEhzZO1oI3FtdRM+j0mx0fMLRenSKcb9IXQf0DNSWCG5IPPdsR+wWcKx+g/OS3JgEA22IALkOUZnjS6zrnMa/4aubpgQ/Pa4Xog7kwdPDt5SREgWhI2bOo2FbtTqMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=IhClFQJN; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-450ce671a08so29809125e9.3
        for <stable@vger.kernel.org>; Wed, 09 Jul 2025 06:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1752069256; x=1752674056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6vLeNNO8152O2umrZswKv7pwUlDj7EkRHEDFrV26qmg=;
        b=IhClFQJNAqkUDCSFnSTs97s9y5H9LZMrUpHAflBnOnqP3YLOsEoEEk3UUmiwnLm7UV
         gD8SPN9LlZ+UVWeF7c4iw8uyZFPW4yYd1YPLuU9DDG8J1XeDYPFoVFgjKnwBKUc071O2
         8TctVoK0HlB1/CDtAS1Vf4aXBgU3pzQ3u8i1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752069256; x=1752674056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vLeNNO8152O2umrZswKv7pwUlDj7EkRHEDFrV26qmg=;
        b=qqZY4SC/J5pdEJd4inDi9wdCpYw23vBWbgyiXs1Otn0N5gSDFzPeCOkDes9NEkHu2f
         YlAaK92/Rki0ExXkvYqEQJ1vET1GLOotQfpPn6/WkmAXbvb+UNjDUc9AlYq5+ZaMMYTG
         3PCMTWS/2LTXke6p3GegVpCkVbbrOTHu2ecWSsS4PYfBYJ1JC1WyexPYxeOtb3aF2kBz
         k2sMq1jbTZbLRpxhrMrVoersNaL3G5JoRGWPB9Wh86+a1Cvkx5Olkid9BMIxEEncnKrW
         M4LOqH9UhNi0T+opaI+t2TXc7LAot4O3UGMYohGuJcByukrI1Ik53C4x9J1V7Op1ZBpX
         DPkA==
X-Forwarded-Encrypted: i=1; AJvYcCV2j/8QWSBlpyQ/UGBaiLZnLCQV0aeI3IkkOwOgFp15yQ+X1zATeNsukYwD+eVC7O2wAFAkw4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRvKcwdbUbb/uXpDgL8lgDsdjn7dZvvsq0dngihkWH14HTUZUo
	Ce7KKUech4/5lUiyFc0kfOpoT7RQDR1O1eG9yuHFBSntDSIIGB3gNUri2Zn/E4H1+7Y=
X-Gm-Gg: ASbGncuv8c0LW9V9SApHsRwOylORe2g6+fK89LZoAmDaWqBoKCcIEqGIop3/ZDx8mU9
	n/WMmMAyuPwqDFNsjBWHoVr006MmPu6EOIfoM2cbZrrEin/EiEQsYw99+qhHGm9/F43KT2v8HPD
	wrrN+fGrpfWqN4dt56QFHmUZc1zFNH/Ye2KC5PQg/khy2mcG39bbGU/LutLBTqh/aAqGISQaHzz
	n02hS0evbai5C1xQYWDij38GXUPDhQ20Tiyo0ptlY5OitApHXjSidQmqqDrq7ss99ceULQf7PYS
	2XI/lEZmQso97Q0spcSexlxxG0ru+9AvDyoBmdN8nptvnLUZF5eSo0Pmkm+uAP5VecW8zNrkoQ=
	=
X-Google-Smtp-Source: AGHT+IFQ64bJI0YogKdzo+Zkc2dfr0OjXcld75k0uMW3P0ftqy2V9CVtvBoV6ut+g73nqKeYrS+C3Q==
X-Received: by 2002:a05:600c:4709:b0:453:62e9:125a with SMTP id 5b1f17b1804b1-454d53ef39amr27994395e9.18.1752069256234;
        Wed, 09 Jul 2025 06:54:16 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50516e3sm24944955e9.15.2025.07.09.06.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 06:54:15 -0700 (PDT)
Date: Wed, 9 Jul 2025 15:54:13 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Cc: Intel Xe Development <intel-xe@lists.freedesktop.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Simona Vetter <simona.vetter@intel.com>
Subject: Re: [PATCH 1/2] drm/gem: Fix race in drm_gem_handle_create_tail()
Message-ID: <aG50hcfCsmGdSmnl@phenom.ffwll.local>
References: <20250707151814.603897-1-simona.vetter@ffwll.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707151814.603897-1-simona.vetter@ffwll.ch>
X-Operating-System: Linux phenom 6.12.30-amd64 

On Mon, Jul 07, 2025 at 05:18:13PM +0200, Simona Vetter wrote:
> Object creation is a careful dance where we must guarantee that the
> object is fully constructed before it is visible to other threads, and
> GEM buffer objects are no difference.
> 
> Final publishing happens by calling drm_gem_handle_create(). After
> that the only allowed thing to do is call drm_gem_object_put() because
> a concurrent call to the GEM_CLOSE ioctl with a correctly guessed id
> (which is trivial since we have a linear allocator) can already tear
> down the object again.
> 
> Luckily most drivers get this right, the very few exceptions I've
> pinged the relevant maintainers for. Unfortunately we also need
> drm_gem_handle_create() when creating additional handles for an
> already existing object (e.g. GETFB ioctl or the various bo import
> ioctl), and hence we cannot have a drm_gem_handle_create_and_put() as
> the only exported function to stop these issues from happening.
> 
> Now unfortunately the implementation of drm_gem_handle_create() isn't
> living up to standards: It does correctly finishe object
> initialization at the global level, and hence is safe against a
> concurrent tear down. But it also sets up the file-private aspects of
> the handle, and that part goes wrong: We fully register the object in
> the drm_file.object_idr before calling drm_vma_node_allow() or
> obj->funcs->open, which opens up races against concurrent removal of
> that handle in drm_gem_handle_delete().
> 
> Fix this with the usual two-stage approach of first reserving the
> handle id, and then only registering the object after we've completed
> the file-private setup.
> 
> Jacek reported this with a testcase of concurrently calling GEM_CLOSE
> on a freshly-created object (which also destroys the object), but it
> should be possible to hit this with just additional handles created
> through import or GETFB without completed destroying the underlying
> object with the concurrent GEM_CLOSE ioctl calls.
> 
> Note that the close-side of this race was fixed in f6cd7daecff5 ("drm:
> Release driver references to handle before making it available
> again"), which means a cool 9 years have passed until someone noticed
> that we need to make this symmetry or there's still gaps left :-/
> Without the 2-stage close approach we'd still have a race, therefore
> that's an integral part of this bugfix.
> 
> More importantly, this means we can have NULL pointers behind
> allocated id in our drm_file.object_idr. We need to check for that
> now:
> 
> - drm_gem_handle_delete() checks for ERR_OR_NULL already
> 
> - drm_gem.c:object_lookup() also chekcs for NULL
> 
> - drm_gem_release() should never be called if there's another thread
>   still existing that could call into an IOCTL that creates a new
>   handle, so cannot race. For paranoia I added a NULL check to
>   drm_gem_object_release_handle() though.
> 
> - most drivers (etnaviv, i915, msm) are find because they use
>   idr_find(), which maps both ENOENT and NULL to NULL.
> 
> - drivers using idr_for_each_entry() should also be fine, because
>   idr_get_next does filter out NULL entries and continues the
>   iteration.
> 
> - The same holds for drm_show_memory_stats().
> 
> v2: Use drm_WARN_ON (Thomas)
> 
> Reported-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> Tested-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: stable@vger.kernel.org
> Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Signed-off-by: Simona Vetter <simona.vetter@intel.com>
> Signed-off-by: Simona Vetter <simona.vetter@ffwll.ch>

Pushed to drm-misc-fixes, thanks for the reviews.
-Sima

> ---
>  drivers/gpu/drm/drm_gem.c | 10 +++++++++-
>  include/drm/drm_file.h    |  3 +++
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index bc505d938b3e..1aa9192c4cc6 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -316,6 +316,9 @@ drm_gem_object_release_handle(int id, void *ptr, void *data)
>  	struct drm_file *file_priv = data;
>  	struct drm_gem_object *obj = ptr;
>  
> +	if (drm_WARN_ON(obj->dev, !data))
> +		return 0;
> +
>  	if (obj->funcs->close)
>  		obj->funcs->close(obj, file_priv);
>  
> @@ -436,7 +439,7 @@ drm_gem_handle_create_tail(struct drm_file *file_priv,
>  	idr_preload(GFP_KERNEL);
>  	spin_lock(&file_priv->table_lock);
>  
> -	ret = idr_alloc(&file_priv->object_idr, obj, 1, 0, GFP_NOWAIT);
> +	ret = idr_alloc(&file_priv->object_idr, NULL, 1, 0, GFP_NOWAIT);
>  
>  	spin_unlock(&file_priv->table_lock);
>  	idr_preload_end();
> @@ -457,6 +460,11 @@ drm_gem_handle_create_tail(struct drm_file *file_priv,
>  			goto err_revoke;
>  	}
>  
> +	/* mirrors drm_gem_handle_delete to avoid races */
> +	spin_lock(&file_priv->table_lock);
> +	obj = idr_replace(&file_priv->object_idr, obj, handle);
> +	WARN_ON(obj != NULL);
> +	spin_unlock(&file_priv->table_lock);
>  	*handlep = handle;
>  	return 0;
>  
> diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
> index eab7546aad79..115763799625 100644
> --- a/include/drm/drm_file.h
> +++ b/include/drm/drm_file.h
> @@ -300,6 +300,9 @@ struct drm_file {
>  	 *
>  	 * Mapping of mm object handles to object pointers. Used by the GEM
>  	 * subsystem. Protected by @table_lock.
> +	 *
> +	 * Note that allocated entries might be NULL as a transient state when
> +	 * creating or deleting a handle.
>  	 */
>  	struct idr object_idr;
>  
> -- 
> 2.49.0
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

