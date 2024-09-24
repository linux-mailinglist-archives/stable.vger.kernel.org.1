Return-Path: <stable+bounces-76974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D3798425C
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 11:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0B2EB2AE63
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 09:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A811422C7;
	Tue, 24 Sep 2024 09:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="gtqqPTEw"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F9228370
	for <stable@vger.kernel.org>; Tue, 24 Sep 2024 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170473; cv=none; b=kmimdzpU3MedLBiiYqNgayaIxTaT9FtdUsCMWsRRWJRlUaadKdXBga5kfHxrKCuNSKmp3AigOV5Hjcb1W5BpNdnlZqk1ncy6uG6sJ+7Zwo4SnK0c0vqFlgN8Y9SIfK6Pu1LJH53FrgYMOF2oQzQg5KfFHYzg2Egh/bAYfsaGQLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170473; c=relaxed/simple;
	bh=LRka+EG2pedKrhlrHAT/U/nxyCJhGD4zj7CWOsG7EjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHsOmcZ349ObuvFpdiWvzTmj/Ls7xNg0WTVsNA/uPCvYogxMX35vGIr4yEXcWE2GzylCT/6IPWhQ8l8vYku0yNSdfEGLfTbFfuhmt0e8o8I+X2TYYyF9nVs+gIpl4mPGf7pvjFCdSTC7Qz/uSlcHR63pUHctw/8hYn/P7ESwKqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=gtqqPTEw; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c24ebaa427so9620687a12.1
        for <stable@vger.kernel.org>; Tue, 24 Sep 2024 02:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1727170470; x=1727775270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7RRWBWG57uA44GUBQrsl15WkC/o180aGwukpCqRC5go=;
        b=gtqqPTEwzUP6YUlyV9XkUbKUx5u31c2rbHSDay0Xu6m7lnOr2lAZKInila/EGN54V7
         QkbfsA51o+5RDe6PF4JZi9K2XoMBQFTsBhIspveg0y/tS7qqRma8puWkkncCp07XKO1e
         d4rHzq6lENM0zNqdthlkIbQEYKPUXefvDbik4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727170470; x=1727775270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RRWBWG57uA44GUBQrsl15WkC/o180aGwukpCqRC5go=;
        b=ZnO6s2DcKhzxbO0zzfmPv1blKafic7Mk9nSGKzlI2jKXrIwdf8YrRsJMDoJdPbE5hx
         uMj0bSd5bf4hxzAP/2+XMYc89th/WsBR9AvHXjTT8+wP/fG3ALnW1+a+A7AIa7CqqMEn
         bFTW6FcXqAe27P3AY9t1tewvqtbmui6A5HLmCdvbXyyQ56rRILNRbHtwZrjo+0fmHyyq
         efetrSiA9Gl9hMsh85APpO4eQUrvgRQ06YqD5zXmfkYH7DXx1g0cRv4cjkOe3Gp/NyXC
         LBBESprmESw6uxI0LQf22asOMhtzeF4odm88UPenlMXZhwwNk6UAab0nd11HbHtulG3S
         hnhA==
X-Forwarded-Encrypted: i=1; AJvYcCU1UuZccC6NZezCAvxRI/5jYvMW6A+6EW/q4EeqfHbKbHHwTN+WUhq7CujLla3JPGXKDngjdbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn1KeeBeC3tfydsmm9zLlAeIgviQWcWPpMixMHgDummpDrEX1k
	+vBfio5Zzxv2ZUeHxVgNHjD9D6pA6+8oEZwTww3i+r1s3IFNYD81ZA3u6DwhyC4=
X-Google-Smtp-Source: AGHT+IEOxJA4K3EQDLC2Qw1CU57RkmkkueV4+nPdX+F6ALYfAW9umNjOTw7OR9IAvGlwaRx1iKqULg==
X-Received: by 2002:a17:907:971f:b0:a8a:9243:486 with SMTP id a640c23a62f3a-a92c4878f6bmr279763566b.21.1727170470052;
        Tue, 24 Sep 2024 02:34:30 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f54141sm62309866b.83.2024.09.24.02.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 02:34:29 -0700 (PDT)
Date: Tue, 24 Sep 2024 11:34:27 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
	=?iso-8859-1?Q?Adri=E1n?= Larumbe <adrian.larumbe@collabora.com>,
	dri-devel@lists.freedesktop.org, kernel@collabora.com,
	Matthew Brost <matthew.brost@intel.com>,
	Simona Vetter <simona.vetter@ffwll.ch>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Don't add write fences to the shared BOs
Message-ID: <ZvKHowqMfvwvHsRl@phenom.ffwll.local>
References: <20240905070155.3254011-1-boris.brezillon@collabora.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905070155.3254011-1-boris.brezillon@collabora.com>
X-Operating-System: Linux phenom 6.10.6-amd64 

On Thu, Sep 05, 2024 at 09:01:54AM +0200, Boris Brezillon wrote:
> The only user (the mesa gallium driver) is already assuming explicit
> synchronization and doing the export/import dance on shared BOs. The
> only reason we were registering ourselves as writers on external BOs
> is because Xe, which was the reference back when we developed Panthor,
> was doing so. Turns out Xe was wrong, and we really want bookkeep on
> all registered fences, so userspace can explicitly upgrade those to
> read/write when needed.
> 
> Fixes: 4bdca1150792 ("drm/panthor: Add the driver frontend block")
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Simona Vetter <simona.vetter@ffwll.ch>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

fwiw Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 9a0ff48f7061..41260cf4beb8 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -3423,13 +3423,8 @@ void panthor_job_update_resvs(struct drm_exec *exec, struct drm_sched_job *sched
>  {
>  	struct panthor_job *job = container_of(sched_job, struct panthor_job, base);
>  
> -	/* Still not sure why we want USAGE_WRITE for external objects, since I
> -	 * was assuming this would be handled through explicit syncs being imported
> -	 * to external BOs with DMA_BUF_IOCTL_IMPORT_SYNC_FILE, but other drivers
> -	 * seem to pass DMA_RESV_USAGE_WRITE, so there must be a good reason.
> -	 */
>  	panthor_vm_update_resvs(job->group->vm, exec, &sched_job->s_fence->finished,
> -				DMA_RESV_USAGE_BOOKKEEP, DMA_RESV_USAGE_WRITE);
> +				DMA_RESV_USAGE_BOOKKEEP, DMA_RESV_USAGE_BOOKKEEP);
>  }
>  
>  void panthor_sched_unplug(struct panthor_device *ptdev)
> -- 
> 2.46.0
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

