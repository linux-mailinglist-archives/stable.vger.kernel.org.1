Return-Path: <stable+bounces-147932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5BEAC65BA
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 11:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 146DA4E39FC
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 09:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FDC279345;
	Wed, 28 May 2025 09:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="PKs2dBNo"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2A82777FE
	for <stable@vger.kernel.org>; Wed, 28 May 2025 09:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748424137; cv=none; b=ToO3wOnkcaJ4wP2a5NpBEe4VEOaFO69cWBOl9hN1tal0wdVlKE2hnKr4t5ELsESpgLcQWSwbKFQU2e33MO5/M6FL5is4aGZu8HuFfq/31P5rxOg2K7rlJuj468GpUkw1VB6izHZHNF6IUbBhx1g4kdUzPAKlq6pApeK+LKp2RH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748424137; c=relaxed/simple;
	bh=tl9WMdB+SR686EC/uHlmMXaDe/UBTO92Wt3kIrXvUko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPpMDR4eBoQ/z7GIu3RBDjwsy3oGvw4IdJwD3TdMb7mxj7ZfPXzOk2HCo1VBUKgpR14daQMzxJU7i/qDlWbNd9Bj2x1dZ0GTRLt3OplP1DSAyAXVUaJ/lbqsKijQQAaP925r6U2n1XQ+vG4wgWwEcYQiMga+1c5KS2JLCmWqc70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=PKs2dBNo; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a36e090102so2381482f8f.2
        for <stable@vger.kernel.org>; Wed, 28 May 2025 02:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1748424133; x=1749028933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zO+owTbI7AwSyY1EJNJe4E1/RlH7PIREOgvq6bjCeoE=;
        b=PKs2dBNolb3XsOlmGRyi6/KmboYx5NMMZx5/qsA1PW85MXSREeVjzNSx9ndi62DTJU
         rsLagzgn4k5G6JtFr39s9HWENc0Px39WMfX7oHzeiFCJxeXkAV0UrxzkwpEpUe+0EeKH
         v4MxIPlIoiSBfyNKcnTzsokm6jLEf/P+tpJJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748424133; x=1749028933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zO+owTbI7AwSyY1EJNJe4E1/RlH7PIREOgvq6bjCeoE=;
        b=Y96aVJte5RUG2ZF1ob18UQXLyfyzXVpmJ1N4m7B5ixh85+3sGeFkDw9Am++LR882dH
         5hXWkesWjxi/wo2H8sG7JqtxCoS8VLZSNRTsU+Ri2MxEdIynDdVNIr2lMMhusheeJo8B
         Jspjxkuaw427HnwWp0fhVStKL8mYm7VbZ/5TMC4gDpb14wY6l/3S75Q0cyNKA7Nxse5L
         3S2mmQKw7Fwjes9w7aOH4Vs4MY+ICJAtijXF3QiCsnUrG2EKPn75mMRo7dH0HYS4tYZu
         tw4PM5gZyp1saNOr+39nPhpxWJkMtU5VFXUtxzXKS5NWbcA0ls95wxs5uWzg2to9Q7oP
         4YQw==
X-Forwarded-Encrypted: i=1; AJvYcCWbLa8HC5bMs3A9jWcxfLEzFcCEQAbdXih3O68E4ccfonxaF/rxbx0qOWdM1C8kkcbl/9STuQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2U8QZyO8bGBPEILLq+5ffrQLTZRQDhp5h4PaEnK2WA8i118bd
	JpFH98A/mvGdkj4mXdGq4bBplbVCL2j8xzTtTKXLOy+u2V/Wa9MWHYNha5hScruTdTE=
X-Gm-Gg: ASbGncuswNW4CuEo0W8DHQK35buRF77KoW/V5d6Njf4b9YdZJq9f8T31s5mnQhZ03Cp
	Tyh5fIcw2pdMGXh1M8nHB53bbVgtsylDs4YtkMqn1S5f/mYWUXgh1Apqmo/zcuoEMP9zW7IDHls
	PpmPw51knL1svc+zQSCjNV8sm6wZ4FexivCSTqOl7AH1TV6XemW1ZoxlC9SXv04gMeoI+rbjlnr
	IUeCOzxw1pntjMDVmj1eOX2cwpp9VxVMdEajlCkAIwuRffbJKFeqD/+YzmwOaFZD2ySvV5bYBhi
	xAl5ZnSqMMOMfmUpVIBIUkhlj9rKjqLtqbqFFyE82cIuvDbqx59Dd4a9hKNFrMigmjTCAf++YQ=
	=
X-Google-Smtp-Source: AGHT+IFHkUgBJ3MDpGmc55Df2jnO4O7GDDWk04es2D4qvl9vkrointO9bgr3vdSybyJfzVBW7+QH2A==
X-Received: by 2002:a05:6000:381:b0:3a4:cfbf:51a0 with SMTP id ffacd0b85a97d-3a4e943c6a1mr1299117f8f.21.1748424133000;
        Wed, 28 May 2025 02:22:13 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4eace3283sm919873f8f.89.2025.05.28.02.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 02:22:12 -0700 (PDT)
Date: Wed, 28 May 2025 11:22:10 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Cc: intel-xe@lists.freedesktop.org, Simona Vetter <simona.vetter@ffwll.ch>,
	Rob Clark <robdclark@chromium.org>,
	Emil Velikov <emil.l.velikov@gmail.com>,
	Tvrtko Ursulin <tvrtko.ursulin@intel.com>, stable@vger.kernel.org,
	Simona Vetter <simona.vetter@intel.com>
Subject: Re: [PATCH 2/8] drm/fdinfo: Switch to idr_for_each() in
 drm_show_memory_stats()
Message-ID: <aDbVwo6W8zq6H9Qq@phenom.ffwll.local>
References: <20250528091307.1894940-1-simona.vetter@ffwll.ch>
 <20250528091307.1894940-3-simona.vetter@ffwll.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528091307.1894940-3-simona.vetter@ffwll.ch>
X-Operating-System: Linux phenom 6.12.25-amd64 

On Wed, May 28, 2025 at 11:13:00AM +0200, Simona Vetter wrote:
> Unlike idr_for_each_entry(), which terminates on the first NULL entry,
> idr_for_each passes them through. This fixes potential issues with the
> idr walk terminating prematurely due to transient NULL entries the
> exist when creating and destroying a handle.
> 
> Note that transient NULL pointers in drm_file.object_idr have been a
> thing since f6cd7daecff5 ("drm: Release driver references to handle
> before making it available again"), this is a really old issue.
> 
> Aside from temporarily inconsistent fdinfo statistic there's no other
> impact of this issue.
> 
> Fixes: 686b21b5f6ca ("drm: Add fdinfo memory stats")
> Cc: Rob Clark <robdclark@chromium.org>
> Cc: Emil Velikov <emil.l.velikov@gmail.com>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> Cc: <stable@vger.kernel.org> # v6.5+
> Signed-off-by: Simona Vetter <simona.vetter@intel.com>
> Signed-off-by: Simona Vetter <simona.vetter@ffwll.ch>

Ok I screwed up reading idr_for_each_entry() respectively
idr_get_next_ul() big time, it already copes with NULL entries entirely
fine.

Mea culpa.
-Sima

> ---
>  drivers/gpu/drm/drm_file.c | 95 ++++++++++++++++++++++----------------
>  1 file changed, 55 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> index 246cf845e2c9..428a4eb85e94 100644
> --- a/drivers/gpu/drm/drm_file.c
> +++ b/drivers/gpu/drm/drm_file.c
> @@ -892,6 +892,58 @@ void drm_print_memory_stats(struct drm_printer *p,
>  }
>  EXPORT_SYMBOL(drm_print_memory_stats);
>  
> +struct drm_bo_print_data {
> +	struct drm_memory_stats status;
> +	enum drm_gem_object_status supported_status;
> +};
> +
> +static int
> +drm_bo_memory_stats(int id, void *ptr, void *data)
> +{
> +	struct drm_bo_print_data *drm_data;
> +	struct drm_gem_object *obj = ptr;
> +	enum drm_gem_object_status s = 0;
> +	size_t add_size;
> +
> +	if (!obj)
> +		return 0;
> +
> +	add_size = (obj->funcs && obj->funcs->rss) ?
> +		obj->funcs->rss(obj) : obj->size;
> +
> +	if (obj->funcs && obj->funcs->status) {
> +		s = obj->funcs->status(obj);
> +		drm_data->supported_status |= s;
> +	}
> +
> +	if (drm_gem_object_is_shared_for_memory_stats(obj))
> +		drm_data->status.shared += obj->size;
> +	else
> +		drm_data->status.private += obj->size;
> +
> +	if (s & DRM_GEM_OBJECT_RESIDENT) {
> +		drm_data->status.resident += add_size;
> +	} else {
> +		/* If already purged or not yet backed by pages, don't
> +		 * count it as purgeable:
> +		 */
> +		s &= ~DRM_GEM_OBJECT_PURGEABLE;
> +	}
> +
> +	if (!dma_resv_test_signaled(obj->resv, dma_resv_usage_rw(true))) {
> +		drm_data->status.active += add_size;
> +		drm_data->supported_status |= DRM_GEM_OBJECT_ACTIVE;
> +
> +		/* If still active, don't count as purgeable: */
> +		s &= ~DRM_GEM_OBJECT_PURGEABLE;
> +	}
> +
> +	if (s & DRM_GEM_OBJECT_PURGEABLE)
> +		drm_data->status.purgeable += add_size;
> +
> +	return 0;
> +}
> +
>  /**
>   * drm_show_memory_stats - Helper to collect and show standard fdinfo memory stats
>   * @p: the printer to print output to
> @@ -902,50 +954,13 @@ EXPORT_SYMBOL(drm_print_memory_stats);
>   */
>  void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file)
>  {
> -	struct drm_gem_object *obj;
> -	struct drm_memory_stats status = {};
> -	enum drm_gem_object_status supported_status = 0;
> -	int id;
> +	struct drm_bo_print_data data = {};
>  
>  	spin_lock(&file->table_lock);
> -	idr_for_each_entry (&file->object_idr, obj, id) {
> -		enum drm_gem_object_status s = 0;
> -		size_t add_size = (obj->funcs && obj->funcs->rss) ?
> -			obj->funcs->rss(obj) : obj->size;
> -
> -		if (obj->funcs && obj->funcs->status) {
> -			s = obj->funcs->status(obj);
> -			supported_status |= s;
> -		}
> -
> -		if (drm_gem_object_is_shared_for_memory_stats(obj))
> -			status.shared += obj->size;
> -		else
> -			status.private += obj->size;
> -
> -		if (s & DRM_GEM_OBJECT_RESIDENT) {
> -			status.resident += add_size;
> -		} else {
> -			/* If already purged or not yet backed by pages, don't
> -			 * count it as purgeable:
> -			 */
> -			s &= ~DRM_GEM_OBJECT_PURGEABLE;
> -		}
> -
> -		if (!dma_resv_test_signaled(obj->resv, dma_resv_usage_rw(true))) {
> -			status.active += add_size;
> -			supported_status |= DRM_GEM_OBJECT_ACTIVE;
> -
> -			/* If still active, don't count as purgeable: */
> -			s &= ~DRM_GEM_OBJECT_PURGEABLE;
> -		}
> -
> -		if (s & DRM_GEM_OBJECT_PURGEABLE)
> -			status.purgeable += add_size;
> -	}
> +	idr_for_each(&file->object_idr, &drm_bo_memory_stats, &data);
>  	spin_unlock(&file->table_lock);
>  
> -	drm_print_memory_stats(p, &status, supported_status, "memory");
> +	drm_print_memory_stats(p, &data.status, data.supported_status, "memory");
>  }
>  EXPORT_SYMBOL(drm_show_memory_stats);
>  
> -- 
> 2.49.0
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

