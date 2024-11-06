Return-Path: <stable+bounces-90049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5649BDD28
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FECD1F21F4A
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A1918B47E;
	Wed,  6 Nov 2024 02:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XALZov/T"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3C5A47;
	Wed,  6 Nov 2024 02:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730861293; cv=none; b=j1uS+O4N7MLu/zIJsjZ3jypw/KvouuRyKc4BMgGaiWh7uFSxTR3/0tNtxHOSSakxxbxpd7VJ6C1iO3RQOut8Dfzn7ogUcUrxo4rbfYMgcpEuFIeCrDZLs1Q7GZ6/6fVDEexJ857gSZpD2TYtZLL/ktPiU/V8+YlHJ9c4KjXOUT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730861293; c=relaxed/simple;
	bh=5Stzl46TvVRzSLhLOWShk+S8kp2aWvvpUWQwVQ2iJJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPLEbxVQ2fpdxz1VCazvgqo9YsW0ojYIwA3MvJCkuD1Yt9hMnmEGu+tMZplcmKHKLacMWNEAIU9lyXYoeV53n8weZIe6Rb+Wes178fKz14V7Llft/s8diT1C30F9BSY+ADzfL3m3zQ/6S8j2iHX5MORhOrsja8+LDpmWTnSrS84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XALZov/T; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7f3f1849849so899980a12.1;
        Tue, 05 Nov 2024 18:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730861292; x=1731466092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XA4RV3f14XOhxic3OxE/rLOjQ3fBuwIvrwqO+BWPzBQ=;
        b=XALZov/T3eWcjYcdRhsjPdSGoBbwSLFWOedwPDGO5uclgNPIoHGeVKplV4Bo6uhUcO
         OyM2H4RyIPYIRTS6406oev9k/cb4zsWYe53fGzHVT6L3lwu0phOxh5/P4n7x8BFdTFd/
         iLAJameHLx5onKRFTTAfe+jyNYVgg/Hi8OtJM1WHhlWl2ZE2xyEfK0E4CENf78HMk2Wf
         8U40gcS9WWztpVlpRKioy+eSQZJ6ABKOqvLy9NzdDvGTgVdSyJFfbZrJzDoadSUlpS4d
         42EDL8yB0eQCnF6Fy0z/FHEQYtFFYrOsMcdnh+I/0h0NFd3Xtb9BxrUhnXGdq0WpxrtH
         /VXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730861292; x=1731466092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XA4RV3f14XOhxic3OxE/rLOjQ3fBuwIvrwqO+BWPzBQ=;
        b=CkCJtBdd8OM/40HkxfGJ8v71KZb5kA1wRfzmybnv0SBcrCuJvMYuzKz2a6WzPlouWI
         h1ZxH/94WPZY9zzhvEqooQo6eiOrwVjTnx6jfX0K10zD4R8jnZxBmuUPBNegIoTbOSYz
         SfKc/aZO1MQGTAldOhmHpfDfkDqVDXgBvfBHtLveYn/g/r+mZpPA2JQXGBln0TxWAksl
         GnQxO9V2yiNOo6dI4zFu8zspbLcfF40t1hnLFbs3U8wSapvXvCP7L111VS+sJsvD4WPi
         1dkNHogAz892m5Ey6stzx6dUO2qiruWq2HERb1ib9bW1/GesIsrHyUpzgzbTCE2OZlj1
         KBPw==
X-Forwarded-Encrypted: i=1; AJvYcCU/2aVXUxS+VXWvp7NqniueUyaiweZ8tFEcCahFu3fFSg5OzyuKQRUam3H8+AFpkc12Ow8hE2o7@vger.kernel.org, AJvYcCX0TC23xQ3X3Hed9hc2GVQdn9BSMmjEz1dnl3wyKdkYtmQP/pJQ5ZBj/dnvIgy2rr6/2NG7FU8A01i21HU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtEJVTVIhTkntJPTqchNGWhtheDmB4a1TDTGFiulR+jtJ9vgR6
	ZVGfps4cFiL34a0/p9HiAZ0Cz2pEFQ04bGrytaN+1fFKTCOsrn+S
X-Google-Smtp-Source: AGHT+IEhLwywn62cebsAZxheY2qHgMhbNy5pGIA5Apkn9GUpDIh3N0UWX98b/OFLLVgYI37dnqIfDA==
X-Received: by 2002:a05:6a20:3d88:b0:1db:daab:2ae7 with SMTP id adf61e73a8af0-1dbdaab2b0bmr14629245637.19.1730861291582;
        Tue, 05 Nov 2024 18:48:11 -0800 (PST)
Received: from z790sl ([240f:74:7be:1:f95:4edb:e798:4ba9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2eb6bcsm10576883b3a.169.2024.11.05.18.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 18:48:11 -0800 (PST)
Date: Wed, 6 Nov 2024 11:48:06 +0900
From: Koichiro Den <koichiro.den@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, cl@linux.com, 
	penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, 
	akpm@linux-foundation.org, roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, kees@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/slab: fix warning caused by duplicate kmem_cache
 creation in kmem_buckets_create
Message-ID: <sdpgw6ni7thxpkuxpbrjrw2gm2rffejmrbpvzipxz4fl4oilnc@3vr64pl5ln4b>
References: <20241105022747.2819151-1-koichiro.den@gmail.com>
 <6125f047-7326-49f7-a568-9cabf80f51c7@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6125f047-7326-49f7-a568-9cabf80f51c7@suse.cz>

On Tue, Nov 05, 2024 at 05:48:56PM +0100, Vlastimil Babka wrote:
> On 11/5/24 03:27, Koichiro Den wrote:
> > Commit b035f5a6d852 ("mm: slab: reduce the kmalloc() minimum alignment
> > if DMA bouncing possible") reduced ARCH_KMALLOC_MINALIGN to 8 on arm64.
> > However, with KASAN_HW_TAGS enabled, arch_slab_minalign() becomes 16.
> > This causes kmalloc_caches[*][8] to be aliased to kmalloc_caches[*][16],
> > resulting in kmem_buckets_create() attempting to create a kmem_cache for
> > size 16 twice. This duplication triggers warnings on boot:
> > 
> > [    2.325108] ------------[ cut here ]------------
> > [    2.325135] kmem_cache of name 'memdup_user-16' already exists
> > [    2.325783] WARNING: CPU: 0 PID: 1 at mm/slab_common.c:107 __kmem_cache_create_args+0xb8/0x3b0
> > [    2.327957] Modules linked in:
> > [    2.328550] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc5mm-unstable-arm64+ #12
> > [    2.328683] Hardware name: QEMU QEMU Virtual Machine, BIOS 2024.02-2 03/11/2024
> > [    2.328790] pstate: 61000009 (nZCv daif -PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> > [    2.328911] pc : __kmem_cache_create_args+0xb8/0x3b0
> > [    2.328930] lr : __kmem_cache_create_args+0xb8/0x3b0
> > [    2.328942] sp : ffff800083d6fc50
> > [    2.328961] x29: ffff800083d6fc50 x28: f2ff0000c1674410 x27: ffff8000820b0598
> > [    2.329061] x26: 000000007fffffff x25: 0000000000000010 x24: 0000000000002000
> > [    2.329101] x23: ffff800083d6fce8 x22: ffff8000832222e8 x21: ffff800083222388
> > [    2.329118] x20: f2ff0000c1674410 x19: f5ff0000c16364c0 x18: ffff800083d80030
> > [    2.329135] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> > [    2.329152] x14: 0000000000000000 x13: 0a73747369786520 x12: 79646165726c6120
> > [    2.329169] x11: 656820747563205b x10: 2d2d2d2d2d2d2d2d x9 : 0000000000000000
> > [    2.329194] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
> > [    2.329210] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> > [    2.329226] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
> > [    2.329291] Call trace:
> > [    2.329407]  __kmem_cache_create_args+0xb8/0x3b0
> > [    2.329499]  kmem_buckets_create+0xfc/0x320
> > [    2.329526]  init_user_buckets+0x34/0x78
> > [    2.329540]  do_one_initcall+0x64/0x3c8
> > [    2.329550]  kernel_init_freeable+0x26c/0x578
> > [    2.329562]  kernel_init+0x3c/0x258
> > [    2.329574]  ret_from_fork+0x10/0x20
> > [    2.329698] ---[ end trace 0000000000000000 ]---
> > 
> > [    2.403704] ------------[ cut here ]------------
> > [    2.404716] kmem_cache of name 'msg_msg-16' already exists
> > [    2.404801] WARNING: CPU: 2 PID: 1 at mm/slab_common.c:107 __kmem_cache_create_args+0xb8/0x3b0
> > [    2.404842] Modules linked in:
> > [    2.404971] CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.12.0-rc5mm-unstable-arm64+ #12
> > [    2.405026] Tainted: [W]=WARN
> > [    2.405043] Hardware name: QEMU QEMU Virtual Machine, BIOS 2024.02-2 03/11/2024
> > [    2.405057] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [    2.405079] pc : __kmem_cache_create_args+0xb8/0x3b0
> > [    2.405100] lr : __kmem_cache_create_args+0xb8/0x3b0
> > [    2.405111] sp : ffff800083d6fc50
> > [    2.405115] x29: ffff800083d6fc50 x28: fbff0000c1674410 x27: ffff8000820b0598
> > [    2.405135] x26: 000000000000ffd0 x25: 0000000000000010 x24: 0000000000006000
> > [    2.405153] x23: ffff800083d6fce8 x22: ffff8000832222e8 x21: ffff800083222388
> > [    2.405169] x20: fbff0000c1674410 x19: fdff0000c163d6c0 x18: ffff800083d80030
> > [    2.405185] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> > [    2.405201] x14: 0000000000000000 x13: 0a73747369786520 x12: 79646165726c6120
> > [    2.405217] x11: 656820747563205b x10: 2d2d2d2d2d2d2d2d x9 : 0000000000000000
> > [    2.405233] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
> > [    2.405248] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> > [    2.405271] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
> > [    2.405287] Call trace:
> > [    2.405293]  __kmem_cache_create_args+0xb8/0x3b0
> > [    2.405305]  kmem_buckets_create+0xfc/0x320
> > [    2.405315]  init_msg_buckets+0x34/0x78
> > [    2.405326]  do_one_initcall+0x64/0x3c8
> > [    2.405337]  kernel_init_freeable+0x26c/0x578
> > [    2.405348]  kernel_init+0x3c/0x258
> > [    2.405360]  ret_from_fork+0x10/0x20
> > [    2.405370] ---[ end trace 0000000000000000 ]---
> > 
> > To address this, alias kmem_cache for sizes smaller than min alignment
> > to the aligned sized kmem_cache, as done with the default system kmalloc
> > bucket.
> > 
> > Cc: <stable@vger.kernel.org> # 6.11.x
> > Fixes: b32801d1255b ("mm/slab: Introduce kmem_buckets_create() and family")
> > Signed-off-by: Koichiro Den <koichiro.den@gmail.com>
> 
> Thanks. Given this warning was introduced in 6.12, I'm adding it to the
> slab/for-6.12-rc7/fixes branch so we fix it before 6.12 is final.
> 
> > @@ -427,18 +426,29 @@ kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
> >  			cache_useroffset = useroffset;
> >  			cache_usersize = min(size - cache_useroffset, usersize);
> >  		}
> > -		(*b)[idx] = kmem_cache_create_usercopy(cache_name, size,
> > -					0, flags, cache_useroffset,
> > -					cache_usersize, ctor);
> > -		kfree(cache_name);
> > -		if (WARN_ON(!(*b)[idx]))
> > -			goto fail;
> > +
> > +		aligned_idx = __kmalloc_index(size, false);
> > +		if (!(*b)[aligned_idx]) {
> > +			cache_name = kasprintf(GFP_KERNEL, "%s-%s", name, short_size + 1);
> > +			if (WARN_ON(!cache_name))
> > +				goto fail;
> > +			(*b)[aligned_idx] = kmem_cache_create_usercopy(cache_name, size,
> > +						0, flags, cache_useroffset,
> > +						cache_usersize, ctor);
> > +			if (WARN_ON(!(*b)[aligned_idx])) {
> > +				kfree(cache_name);
> 
> Note we need to free cache_name always, because kmem_cache_create() does a
> kstrdup_const(), so your change would be creating a memory leak. I've fixed
> it up locally.
> 
> Vlastimil

Ugh, sorry about that. Thanks.

> 
> > +				goto fail;
> > +			}
> > +			set_bit(aligned_idx, &mask);
> > +		}
> > +		if (idx != aligned_idx)
> > +			(*b)[idx] = (*b)[aligned_idx];
> >  	}
> >  
> >  	return b;
> >  
> >  fail:
> > -	for (idx = 0; idx < ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]); idx++)
> > +	for_each_set_bit(idx, &mask, ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]))
> >  		kmem_cache_destroy((*b)[idx]);
> >  	kmem_cache_free(kmem_buckets_cache, b);
> >  
> 

