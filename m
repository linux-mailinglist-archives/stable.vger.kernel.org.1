Return-Path: <stable+bounces-161841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26396B03FAB
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 15:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC4E163061
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 13:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A279724DD11;
	Mon, 14 Jul 2025 13:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcMD5mgU"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63B424A047;
	Mon, 14 Jul 2025 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499165; cv=none; b=BhiiLffmRumNiSFc7ld1Wpt6J2aXlHK/8lgG1GaPAFzsvAdECgj9zZvx/6c8mhwY4Ewo2E27RzDtP+OxKGlhxZCffYJYOdBKyA/jT+4Fp4UanmcxK6s27DWC4Wy0LlTU/thvWFic1CEEg4dAbw2aI6tvlIirzfb5I+xh6Fe+3pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499165; c=relaxed/simple;
	bh=MEiZe9dT3AcI47jjSXnxopISrbtPuAcEGPjwBbo8RXM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwIf3MVcUA9zX4VCUdW9gOlE4Xqi18C4uoVLwgRId6Ym2paXrsypDs5up4x5aO5xJBPYzwcId8ULd0QAkpV0yrYSlGZOtP29qJr79cV1iHDV7AvtfobyT7LEb2dxXk0Evt5bbF1QR9Xe8VY8MFX90rvNUo7IplFiplfGVjRKV0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcMD5mgU; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-555163cd09aso3354377e87.3;
        Mon, 14 Jul 2025 06:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752499162; x=1753103962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=78IVLypB20S33j4pHBE/zVDOjkBG6gwwlw+HOaWrG1k=;
        b=JcMD5mgUC3YmuPmlMuaQplY5S10mIx3tKbPTjikpdjclzjiAp/r7dfn3ZdzQ4t6aTw
         nZ97rPLh7VI7QgIt1+N2CWLSv2xJMfMZo0eMWfTL61itjn5rnwf37c+DPXG7xa1j5wFs
         qluz9joYGYawMn/F4Pcr4NpzkZYZDHsR7yNxizd1iw2O6ExXTb9xO7384JMbEAT051Fc
         n4+Zxpua+qkAtSXeVQqlRMuKD81NKf5a7sEMVN2AROXmNdDQ2KtOURRbB3LtiV5MjHPh
         KAkvfr+XHISapoSZJXhHzZo+qLrgbFDWSdKGdzTQN1EOgprVGO8JAzQhgYDCNS+x27FI
         r27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752499162; x=1753103962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78IVLypB20S33j4pHBE/zVDOjkBG6gwwlw+HOaWrG1k=;
        b=NHYcmTcEUtEwv/2H7KrjD9j/6vBysjfDZM1tqYMd9lgrz0mWxN4xFhOUd+8rdPUHBJ
         7yUts7YG03BPfGPQ3FqElKz01KODpNzpdDgJxRFZuJbHqYMc4eAF7G8eIngo+Gd71DWm
         ywF0FFLm28MW263icvgHKiNVVYnRIPm9hMKS+zyaip5QSQN4uZrwirGWsh0PkaHqcKPO
         xKTJNONcvcVi8BhBewcMyZH1Axys51K7vowj3tcToCuUkn6ULxMot9lNlkPEOr3fIn+s
         zNsLqoBwBiW3F/mZFYWiDgXFgPiAFua7EdQuk5YVDHdmumM8JcNOEl75qhzXtg0dsPDw
         yHvg==
X-Forwarded-Encrypted: i=1; AJvYcCUVXaOG1oWWZyenENsSiifJ+ylxtcoNWJhT2bcdhQBXAwUdkCdLJOpQ9JpzJKNhGyAQZBFNLS4Q@vger.kernel.org, AJvYcCW86jSQrV3uMHr4DYm2pedVsmcCsKiAEdUaF+vHxxbvs229gw7PfuTH7jyH7uRE7CibVjOsIdvib4HAdvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo5nGvRL9BJ607j3j5ZPn336CNFtKhJ6B4vRyUJviXbn3bdIsv
	Itsj1EqlVFuOxDZBjvmB5LD6uHpR907KO3i5XFqMLBH/afxhru0hxK96
X-Gm-Gg: ASbGncuK+BCh+uR3AbElOXRWkPemqIDtBpMB0gIujB6ceQA20jDhDUSN5PuQ+gVq5v8
	HCV4kLZ3HHUWFXHsSWc9q/g6Km/Xymks3eBrFU5M+dt6Dvihuc7alCMorT+I1iGe/5znjeaBswJ
	JkOdhd+Ur0L4GH/C6A/ZLTIG58TvUfJvkk1iMcAqaldi7KIBbXKQGVzVIDrXu0yEIeFfzXlGE64
	9f8wgYEHv7miTEne5k7We9LRLa0vlRQKeAfC6MkZi952CU8iDTR7TZ9LF0pYI7q2h26Yv+wwzmx
	aotxH678kKi9334+DJWiCbJ6C1YYMyzBJtTEILiRg2iXk8iS3cduJWE1MJf7JpoYm8T1Ziyfs2D
	vzLWMzLL+YSSsmqO+OOO7SArh9eLZzF7T4lr/AZkwwuJ265UoBpBEvr81mA==
X-Google-Smtp-Source: AGHT+IEMCGGGprcbXRR1yMw//2aiZLM5Ci4pXvi2khlJ9ETOkX78f4aDe8DT5j9DDWK3UG+TrKW9ew==
X-Received: by 2002:a05:6512:a89:b0:553:addb:ef5c with SMTP id 2adb3069b0e04-55a046538fbmr3898999e87.54.1752499161600;
        Mon, 14 Jul 2025 06:19:21 -0700 (PDT)
Received: from pc636 (host-95-203-19-28.mobileonline.telia.com. [95.203.19.28])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b77c64sm1956468e87.219.2025.07.14.06.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 06:19:20 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 14 Jul 2025 15:19:17 +0200
To: David Laight <david.laight.linux@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>, jacob.pan@linux.microsoft.com,
	Jason Gunthorpe <jgg@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, iommu@lists.linux.dev,
	security@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/sva: Invalidate KVA range on kernel TLB flush
Message-ID: <aHUD1cklhydR-gE5@pc636>
References: <20250704133056.4023816-1-baolu.lu@linux.intel.com>
 <20250709085158.0f050630@DESKTOP-0403QTC.>
 <20250709162724.GE1599700@nvidia.com>
 <20250709111527.5ba9bc31@DESKTOP-0403QTC.>
 <42c500b8-6ffb-4793-85c0-d3fbae0116f1@intel.com>
 <20250714133920.55fde0f5@pumpkin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714133920.55fde0f5@pumpkin>

On Mon, Jul 14, 2025 at 01:39:20PM +0100, David Laight wrote:
> On Wed, 9 Jul 2025 11:22:34 -0700
> Dave Hansen <dave.hansen@intel.com> wrote:
> 
> > On 7/9/25 11:15, Jacob Pan wrote:
> > >>> Is there a use case where a SVA user can access kernel memory in the
> > >>> first place?    
> > >> No. It should be fully blocked.
> > >>  
> > > Then I don't understand what is the "vulnerability condition" being
> > > addressed here. We are talking about KVA range here.  
> > 
> > SVA users can't access kernel memory, but they can compel walks of
> > kernel page tables, which the IOMMU caches. The trouble starts if the
> > kernel happens to free that page table page and the IOMMU is using the
> > cache after the page is freed.
> > 
> > That was covered in the changelog, but I guess it could be made a bit
> > more succinct.
> > 
> 
> Is it worth just never freeing the page tables used for vmalloc() memory?
> After all they are likely to be reallocated again.
> 
>
Do we free? Maybe on some arches? According to my tests(AMD x86-64) i did
once upon a time, the PTE entries were not freed after vfree(). It could be
expensive if we did it, due to a global "page_table_lock" lock.

I see one place though, it is in the vmap_try_huge_pud()

	if (pud_present(*pud) && !pud_free_pmd_page(pud, addr))
		return 0;

it is when replace a pud by a huge-page.

--
Uladzislau Rezki

