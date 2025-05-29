Return-Path: <stable+bounces-148093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9D8AC7D9F
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 14:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAE853B7EC2
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 12:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2C5222563;
	Thu, 29 May 2025 12:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QCwpzbep"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7F9220F2E
	for <stable@vger.kernel.org>; Thu, 29 May 2025 12:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748521334; cv=none; b=C9b5W3qVZP0yGTIcFo/VgMWiits9hMHmWEbUKnnhnaoQLbtiEZqj6/tisnJIx9T/IxtxJ7LsNxTJWVJ6Yu8CvN0xADyAbgIra427lHEilZQOQ0EqMFROXuuKXAP9tOcv5ATIoxtX5VF2ZJ35Hci4QyH+nC56d/eWxusuu9wiciA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748521334; c=relaxed/simple;
	bh=K7qjULalyjMkAxL7PVeGCHXQouk2F6broaGq36eQD0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWZPx2zBw4a+VnTX04y7My2LMK3euvuufxESOd/Xo5Inswod6rdU8+pNEuQ7mokwTh9BFw9NH0p1T1r034aS6Hed8T0IhaajUTAacdxsbrB4M/QQXs6vReWS4mcZoGRleUvfXukpwhH26YuUT0IHwkLEQWYdVFw02CONFZEv03g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QCwpzbep; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-450cd6b511cso5276435e9.2
        for <stable@vger.kernel.org>; Thu, 29 May 2025 05:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748521330; x=1749126130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=al8287RxjgUX+nRH6wDLFLDnBZ/mAzEmTjClCtJoDew=;
        b=QCwpzbepmjUqNLhiIsZsfzmN79FdLnNpzM534qoCvbZuLDVa83mlgV9cacr32shmeA
         94QV3Lyq62DHmYZxHh6+TrRIqsGvs74W2BkO95kI2YnAxc6CUCNBwvX2BxyWPmCCCXK9
         mGzjmDTFASnxTra0fkuc4JgABj6mI5U02/o8aFCnMlksNDkYyycpwD3YM1/03WaeU8Hk
         o8fCKlSr2H0nOn68/c0fHozsv2tAd9A13BaNNrvBeW6NCiCfAQh3d/1nL5HstjZUl2my
         D3UgTBophu9ZdwsGHVxu4WgcRx/n18pqHz4h6jB4P/wenCn5MCMrPa2NcyiUVRrSoRJO
         z4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748521330; x=1749126130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=al8287RxjgUX+nRH6wDLFLDnBZ/mAzEmTjClCtJoDew=;
        b=LO2oZ1T/9cA1PwS2AgcX5GNW4fhqj5YRAdTl+T4F6/wrxWfgKybXD+BIn2AtTSvCSj
         fkFmZSxK4mGbSF56yKwQsKyxaOSnNNAQlIYtF8fgw0ag3srs/o7OcviC+i2mygjaX1Vw
         D1FYfmWlQB6bDrxgGw7DViqDf12gXrtBL+41yI6efxlGshnFJNUuzPWO9Swbo0WWB6xR
         MLfcbHKcZt1gXHA/HheI4LPIGDJiD9VJ6AvwdS/VJvdn3DgBG4C3r1Tz6YkNayaigf2R
         z544TunhaMpuw5VAi1MNw1wySgMWw87p4sai26RczCZ4u+WavsHIJ2GrLYDTKGiezmJ0
         Dyuw==
X-Forwarded-Encrypted: i=1; AJvYcCWuy3J9n44cQnqLvPMSokWwnPyQQtQo0tUF4C7p8d5I2BeAHingIaD0O3Uh9gSSQABsrYvhBkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7EzTMUIT//ANOG9TZH8C1p//g4ZImVtXEMlWAFPeV65cuLNYy
	7EnHGZDEWUg7lkh6t11xUwiCpK0DQamPiMdwzLkjcx80aWyvyRHNW5z4jXGGaHb8lbA=
X-Gm-Gg: ASbGncudJn18z5xYf658/xb3SPAKK/ibfb0qVzk+ONYaeyjQMSIUul5ojjHYzS6KF1v
	oJ6SvMp0NSaqGc2NX5Gtt3+R2vU8T060D9De+CEFvCbOaGy0397TEQ6ikIC+/Oqua39HE+/unhJ
	iZS3VHhJDOESlswREiQvq9XhVdPGyewZDG75azofoQC5g5PQVYRiSp6bGCoe69AqDSDYhnAmSsx
	LKOyFvLPYmBa49LYTHrMjjPueJmKgBkAec0WKdLHubLNAsfMQWnXiNpMjlKJjhZozABsEO2dHwz
	uHDDEXBUYazPTAgdmH8ivCImpSJNLMU8FQS6KdCgA4hBS7ALqAPlw801MUtUZ4nf
X-Google-Smtp-Source: AGHT+IEi5QGaE/L2kia77TwpAy38jFwnSSaQnSkGGXHD3NLBpfAk7antH461TuYl2AZ2tzXQyeDH2w==
X-Received: by 2002:a05:600c:a00e:b0:43b:cc42:c54f with SMTP id 5b1f17b1804b1-45072553bb3mr59385965e9.14.1748521330468;
        Thu, 29 May 2025 05:22:10 -0700 (PDT)
Received: from localhost (109-81-89-112.rct.o2.cz. [109.81.89.112])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-450cfc16275sm18627795e9.22.2025.05.29.05.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 05:22:10 -0700 (PDT)
Date: Thu, 29 May 2025 14:22:09 +0200
From: Michal Hocko <mhocko@suse.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Hongyu Ning <hongyu.ning@linux.intel.com>, stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] mm: Fix vmstat after removing NR_BOUNCE
Message-ID: <aDhRcXcqctogIITw@tiehlicka>
References: <20250529103832.2937460-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529103832.2937460-1-kirill.shutemov@linux.intel.com>

On Thu 29-05-25 13:38:32, Kirill A. Shutemov wrote:
> Hongyu noticed that the nr_unaccepted counter kept growing even in the
> absence of unaccepted memory on the machine.
> 
> This happens due to a commit that removed NR_BOUNCE: it removed the
> counter from the enum zone_stat_item, but left it in the vmstat_text
> array.
> 
> As a result, all counters below nr_bounce in /proc/vmstat are
> shifted by one line, causing the numa_hit counter to be labeled as
> nr_unaccepted.
> 
> To fix this issue, remove nr_bounce from the vmstat_text array.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> Fixes: 194df9f66db8 ("mm: remove NR_BOUNCE zone stat")
> Cc: stable@vger.kernel.org
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Cc: Jens Axboe <axboe@kernel.dk>

Acked-by: Michal Hocko <mhocko@suse.com>
Unfortunatelly a common mistake to make. I have seen you have a followup
fix with a stricter build time check. Will have a look.

Thanks!

> ---
>  mm/vmstat.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 4c268ce39ff2..ae9882063d89 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1201,7 +1201,6 @@ const char * const vmstat_text[] = {
>  	"nr_zone_unevictable",
>  	"nr_zone_write_pending",
>  	"nr_mlock",
> -	"nr_bounce",
>  #if IS_ENABLED(CONFIG_ZSMALLOC)
>  	"nr_zspages",
>  #endif
> -- 
> 2.47.2

-- 
Michal Hocko
SUSE Labs

