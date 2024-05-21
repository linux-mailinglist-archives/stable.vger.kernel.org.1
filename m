Return-Path: <stable+bounces-45505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8707C8CAE6E
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 14:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1AEA1F21690
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 12:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501BA75811;
	Tue, 21 May 2024 12:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="bk32Z15k"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E84A28E7
	for <stable@vger.kernel.org>; Tue, 21 May 2024 12:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716295119; cv=none; b=I5f7OQX+U89JPw4NQBkleBZqU8uVDB5aqpyYckMFJtsHd50sFigfHwezmIE9cihs9ij4eIviBT+2cYwCFW/wuhPLz9tRYw9XwNDNhNjpuVHHGJ+TU6YuUF2o+jeEb2Z3uBVTBD7dpCDXHEMuiCVS2NP9G3rRhYxMc3AZkRzmdH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716295119; c=relaxed/simple;
	bh=H8CLRcEkqmfqKoIGx97n87jAnrwCjDoCH6DESlOc1BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQA3Pc/a01MPiCo2lRN8Q4mLS1ae6Lndw9WBG2NEQu8mqpnt0qhrtaUcCvlK7ubJYArheX/KVaRNdjV9+4K7SFpN1NgOuEjjFRWv0NOT/loWJfP5ahjdDMy7SDHUwxm2ua7d0zEtT9jVCjFH/lxO8OQJntoZ11L9K37nwN16EUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=bk32Z15k; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-34cb27f1f2dso114889f8f.2
        for <stable@vger.kernel.org>; Tue, 21 May 2024 05:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1716295116; x=1716899916; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/Z8wMDpCRGL6ymc+tphf7A5z76HQxRHJoC5TqayrDUY=;
        b=bk32Z15kaH5i1g8Wox5IGmGrq1tNOcF90binJSLFDcW55gzqEhn5j2jp9IHPZBmLBo
         Ud9s4xtZK8wGgdV+eOcGgPNZ27y2OAIB5yMQjZj3an4fiI2iNrJsP1o5OkMp/HwoKJRA
         FBSPIO+x6QyenEuT4TxCw938i0uvGKoZzm2dI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716295116; x=1716899916;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Z8wMDpCRGL6ymc+tphf7A5z76HQxRHJoC5TqayrDUY=;
        b=sKVaKbZdPLnlcWsgmCDHcTDA6ZPzhgDzU09+NJBnEAi1CTSF3MnDEA3kf93DFZk9kA
         a6onPAAh7GQK55cBvGfta+7sEYObriQpl3Pc+q/yXvT+bo4mMemEQ79hd2+4W9FCxMDY
         gRAMgF8E/Q8BUph4CM3oPYw1IR7Pnwzv9goist74gBnYtsQZYxXuZeBf26dZ2lD5a47q
         m5IoAv7SdY0LGxn3KYaJ1my9RRqxWpqaq426UD/XP81+1uFtZ4ab2uLeja2sw5qiwSwJ
         vAXdrovUrZeRNuvnAi6RSEw7eaYNmkiDGBb7z+Ri364z2od0TIJCgIRxZb+6eqAjcK8s
         fCYg==
X-Forwarded-Encrypted: i=1; AJvYcCWdALFlm+RhQO/vIBPzyhp+ZTW0NHfFB/8P7e6G3EYs6fsQeKop/KOoJU7bQU5TVAftO9tNSTvaEXo4WJZCGairYcj68PjN
X-Gm-Message-State: AOJu0Yx2F1M2JQnbrjQbUIrjAgaktRK7KiGrGB0dUdP0BKZX3EbBIzyF
	Lrka0CnunJncg0SgXps3JUj7ZiLtwcj/CHjE84dpjPY7ovcq2GfL9tmxCrYTig0=
X-Google-Smtp-Source: AGHT+IFTghMdwTacSsVfy7EO6W3QxK6g6vt6x5SzPCadiSfw8FyInuVxjElraI0YQ0pBe7pld/vWnQ==
X-Received: by 2002:a05:600c:3582:b0:41a:bb50:92bb with SMTP id 5b1f17b1804b1-41fea539aafmr234868955e9.0.1716295115811;
        Tue, 21 May 2024 05:38:35 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee9292sm464641525e9.37.2024.05.21.05.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 05:38:34 -0700 (PDT)
Date: Tue, 21 May 2024 14:38:32 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org,
	"Wachowski, Karol" <karol.wachowski@intel.com>,
	Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
	Eric Anholt <eric@anholt.net>, Rob Herring <robh@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/shmem-helper: Fix BUG_ON() on mmap(PROT_WRITE,
 MAP_PRIVATE)
Message-ID: <ZkyVyLVQn25taxCn@phenom.ffwll.local>
References: <20240520100514.925681-1-jacek.lawrynowicz@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240520100514.925681-1-jacek.lawrynowicz@linux.intel.com>
X-Operating-System: Linux phenom 6.8.9-amd64 

On Mon, May 20, 2024 at 12:05:14PM +0200, Jacek Lawrynowicz wrote:
> From: "Wachowski, Karol" <karol.wachowski@intel.com>
> 
> Lack of check for copy-on-write (COW) mapping in drm_gem_shmem_mmap
> allows users to call mmap with PROT_WRITE and MAP_PRIVATE flag
> causing a kernel panic due to BUG_ON in vmf_insert_pfn_prot:
> BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
> 
> Return -EINVAL early if COW mapping is detected.
> 
> This bug affects all drm drivers using default shmem helpers.
> It can be reproduced by this simple example:
> void *ptr = mmap(0, size, PROT_WRITE, MAP_PRIVATE, fd, mmap_offset);
> ptr[0] = 0;
> 
> Fixes: 2194a63a818d ("drm: Add library for shmem backed GEM objects")
> Cc: Noralf Trønnes <noralf@tronnes.org>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v5.2+
> Signed-off-by: Wachowski, Karol <karol.wachowski@intel.com>
> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>

Excellent catch!

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

I reviewed the other helpers, and ttm/vram helpers already block this with
the check in ttm_bo_mmap_obj.

But the dma helpers does not, because the remap_pfn_range that underlies
the various dma_mmap* function (at least on most platforms) allows some
limited use of cow. But it makes no sense at all to all that only for
gpu buffer objects backed by specific allocators.

Would you be up for the 2nd patch that also adds this check to
drm_gem_dma_mmap, so that we have a consistent uapi?

I'll go ahead and apply this one to drm-misc-fixes meanwhile.

Thanks, Sima

> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 177773bcdbfd..885a62c2e1be 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -611,6 +611,9 @@ int drm_gem_shmem_mmap(struct drm_gem_shmem_object *shmem, struct vm_area_struct
>  		return ret;
>  	}
>  
> +	if (is_cow_mapping(vma->vm_flags))
> +		return -EINVAL;
> +
>  	dma_resv_lock(shmem->base.resv, NULL);
>  	ret = drm_gem_shmem_get_pages(shmem);
>  	dma_resv_unlock(shmem->base.resv);
> -- 
> 2.45.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

