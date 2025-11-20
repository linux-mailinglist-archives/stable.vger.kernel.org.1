Return-Path: <stable+bounces-195422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 209B6C765A9
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 22:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D2CBB348ECE
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 21:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BDC2144D7;
	Thu, 20 Nov 2025 21:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i+q8HPs8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636DC261B9A
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 21:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763673336; cv=none; b=HF7uLaAX+goluhkcMsQbp2QBl1vvYnCbEDI10+oIkKs31Gi8h1HBhCVXOds2UIPJV5oORTCFjGn9pEVtq3c+338OAu5hOk0+R+BzGsHfzcBmmMhcHoBNDe2kCtli1EqWlNUmisGqEr1TcE+ALmx47cxu13HlyA2atpMbt6Yi3/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763673336; c=relaxed/simple;
	bh=D+YG9Qs3HwUYCXxm4rudobX7433U6rzry9pMefof4gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYVPD/TDGNBhAhrkYaibJ1IvWClgPqhY/MTm/xFM0kUVXi2uhClCaWpLbxRXYOsv8TTqFtB/wruX5c838NXVA8/czRpMOACEmT0hkGEFYTf4X6Y752CiQa2fk8yV/CKvU6USX6VEa+lbPItpfIk3tttLgdzuGSd1sMPFIAL8SuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i+q8HPs8; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-295c64cb951so51445ad.0
        for <stable@vger.kernel.org>; Thu, 20 Nov 2025 13:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763673335; x=1764278135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bxpNivunlSaXukC7vAT1IlXrIkVZJMg+O439LnQYshs=;
        b=i+q8HPs8xHtKAg/s+aSMfhkJhBYzwtyAhjnL6eKrJ5bsQURPc2FlFP4hYqm5oQvAfd
         OdWwuZEk8QWF1GucdV6Hm/3lDO6Caij0TO/NrZ0mVWNqCC4PpNcAg3Gklea4wQ03svZU
         g/EFAJ+Fq+0KVQOW7OMqbE3BseoEe7wEXxn0x54WV73EFFC8rKk8wwry6J7Gnde55fBS
         5oyHUWODu1fEARTRhdZfGJFDwYBpF/Ww9xw5NFpEXFKZfpYoGhHJq2AN7foGSE2B+3zJ
         qvAf3VQMMEyM4xsCg5Zfmacwu+VFsOFElVFI0NCtj1HGxkVAwoZTUILJBnvsSu262euN
         CJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763673335; x=1764278135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxpNivunlSaXukC7vAT1IlXrIkVZJMg+O439LnQYshs=;
        b=ksf62TeVwiBkG8qZgN3/9vuTxLg/+ua8NluGC3xKZ0tMuovDTtLqKv5To2OlQJBJWn
         QXR6rHj6RcpUwIi1WUdLM++4qRy9ZiShAWENs6Ezf6d6hq6MlHVsAI2c7BfTy9oag0Lf
         BLQVE420N+9G6KfRLPMxUkOB3r+DUkRWykNCWxFJ4KGr91a0MjsdAGlZWmp0LVf1CpGq
         azSd+nR9CKObXxLcjeN6lHI195EGk42EKZ4cRmRTi+xi7mZ7U7bQK86WS1F+hBs5gSBR
         1s87+10UptWQgBlwSIrggvgmE9jTtRmPWsFPRtcIPBZDv3CCnfvjw6Rh/IJoobcjvJbv
         DgfQ==
X-Gm-Message-State: AOJu0YxbDmOK0KCJMxKIwShHAE4B9nXiUu4Yq94n2mWt/P951J2vCcqw
	UnCe3iESIvntGO53x/EjZsYYOfvF9Z8uhW+Twp2tpWWlotkT5+e2K2oZ9oNS9qbTTCw890jtvB/
	uEI2CdUqT
X-Gm-Gg: ASbGncuDyuyN8jj4FzsOlDx5/r+V2ULXOooKO8ZaOKULyfs1FrJLPTYfTZpW0GcxLms
	bKc2kOJuG7ZvjhbdfEKLOCynVx/Y3xTB/hAdmm2feSNl9Li+ZWjXUIl6G/J5dWLHvkRzzNs9qiM
	xQVAmeKr2sLCo4yBrkgN6H5BMHB7hZ1Mx6tpwyb7MvON4Vg8pvIE0noUyc/D7+ygkaw36vXf8aL
	0kjeG3Ue+1DazzW+/gKk8V8gsBbQ5kCJw8GZ2oXuEt3G99WkgE1oEdQujTLPa0TeMBZls6x7dtf
	i6RTQFTW0eGIrzHaWMprXPuFFwY05JryYrqVLl0OkChm7LhK/HvnIKSv72dy99fDXGyw9PbyJ+/
	NLTGibMAznY4ERKp4fKg5eSaOf584SBVtkz8WDZU3rtM51L9L/hW+TxLenmNRl7dtWPlIcG+hdu
	JBY4cDSS+MHwEINCXoZeVmS6ArqyGEywv0ezUmgayOegThLs3Y8BYi
X-Google-Smtp-Source: AGHT+IHb4j9e7w4Z1WKDos1CtUEzS+i75G+acTwVwgRaT0CyMRyxav14ZbIL9CsA0j+IZZ9wiHvSbQ==
X-Received: by 2002:a05:7022:ec05:b0:119:e56b:c1d9 with SMTP id a92af1059eb24-11c9be27efamr33398c88.4.1763673334175;
        Thu, 20 Nov 2025 13:15:34 -0800 (PST)
Received: from google.com ([2a00:79e0:2e51:8:71fa:5788:3fe4:41f1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93db556csm12662324c88.1.2025.11.20.13.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 13:15:33 -0800 (PST)
Date: Thu, 20 Nov 2025 13:15:28 -0800
From: Isaac Manjarres <isaacmanjarres@google.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: stable@vger.kernel.org, David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y] mm/mm_init: fix hash table order logging in
 alloc_large_system_hash()
Message-ID: <aR-E8LN0hj9jm-pF@google.com>
References: <2025112032-parted-progeny-cd9e@gregkh>
 <20251120194222.2365413-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120194222.2365413-1-rppt@kernel.org>

On Thu, Nov 20, 2025 at 09:42:22PM +0200, Mike Rapoport wrote:
> From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
> 
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 86066a2cf258..d760b96604ec 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -9225,7 +9225,7 @@ void *__init alloc_large_system_hash(const char *tablename,
>  		panic("Failed to allocate %s hash table\n", tablename);
>  
>  	pr_info("%s hash table entries: %ld (order: %d, %lu bytes, %s)\n",
> -		tablename, 1UL << log2qty, ilog2(size) - PAGE_SHIFT, size,
> +		tablename, 1UL << log2qty, get_order(size), size,
>  		virt ? (huge ? "vmalloc hugepage" : "vmalloc") : "linear");
>  
>  	if (_hash_shift)
> -- 
> 2.50.1
> 

Thanks for backporting these patches to the older kernel branches, Mike!
I really appreciate it :)

--Isaac

