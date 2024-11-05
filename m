Return-Path: <stable+bounces-89774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E09CF9BC32C
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 03:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FD411F21441
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 02:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9091CFA9;
	Tue,  5 Nov 2024 02:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMy5MmAZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A119036AF5;
	Tue,  5 Nov 2024 02:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730773860; cv=none; b=VnDaILAs+GpQO2RNMbmgSqBpz6VD1BneuMoAh5i/5ZgynBQEs3Hb9163GCvgCPEZks/HdqkS1pSTeER+zC3BjvbS+RELUb6GsDK1kpRMaeHnJk4F5KkghivM3EqEoH8H17ST4oocRnYntZXL1bxlo1QEwVAkXfsH1DgzIbjIUXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730773860; c=relaxed/simple;
	bh=QxxbzCiU3yFhyX14Y8WR5/kI7eQBi/SOTh3tW/aFWLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tp9e1tOIJQ/6+9Cs1vRcyuvX+QL7sqXoKDI9w65n5W33orjYmOlVTHpuOSsEYpAw5LChudNtZtF4WtVeKQWvtiUo2XNRaj1wOdufiMuPHUEANSSGp4eHLmm9gffe68Cu9fml9qwQZQLF0xrFfIYwUTGm/46tRhnnOeji1qcqOy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMy5MmAZ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7eab7622b61so3793202a12.1;
        Mon, 04 Nov 2024 18:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730773858; x=1731378658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X2P1a3dRdV3xHFpFY4jxvzlaleVlDKjflmju/CEhpUI=;
        b=KMy5MmAZ1W1SaVa0C/U6Qx2G/Duy/NzPiOt3uk08PsU4JiK0+1J2bFuIXTewpeaDER
         ZeAJuptssHQVXIu82ZdYkOD6CTPwmxSYqd4m4zROI2OzUu85mQAUBftRqO9ejvnU6lim
         Ez/qWFKA4i7OWaBg7SKtBUnK+cn41YYlsPLBEdfmBbUTyLfCZwEGLO4ukqrElCUZqh7L
         1DrN16o36VTMMN+r1bJVBYZpTyftOCOUb9xeS2aL95EwE82iTHxMzLyv96O/B9a3fawJ
         WIlCZJJtzuePeLI8vAxtLc8oV1rNTb3vZHodPNnDgEdy/mBc6HZGV46M31r51NnFXFOU
         nbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730773858; x=1731378658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2P1a3dRdV3xHFpFY4jxvzlaleVlDKjflmju/CEhpUI=;
        b=HeX+gXsV/F2ysw52JWdPlIYLriWerWncguxbEu/5k7dZ3nsPi/LtqgrizjcLjllJfw
         L9KphZ4W8BalnFITyk+wPL8gCfodAkGr4YPNwJUuKyuz2XeaH8IEaZWvu66PQJSHZ3Y3
         efxx9Ym1OwNKQFuC1ZSptneuNlLqEh4yVVZGtgnOL2j5FR68oYkyby7HVca4B4kvT5N+
         SpJGEyp1k5XNk99nPYF90GTDyXLEvCZ2YwwUdLAAW3xAtJcId71EWCJrUGmJ0BJNNQIn
         QcmYawaYqQpSun2noVnztDh0UEJDSH6Jk1eummfPwKeD/G7LwyiZ7DFps+6oBL2Xq9Tt
         pHuw==
X-Forwarded-Encrypted: i=1; AJvYcCW3zNVdojpyiGxXyd9m/kQ0PfC1ethdJ2xsxOk8YMlsRpCp8laDh3QJoyimWmb2HPQYgpI8iS27@vger.kernel.org, AJvYcCWponKYVFPAnW2dt4ZFJ936dpUWj7IBTZT7yHxkABDWlMDiLXMVurVFEyJIen2lnuOk9tn5yip25c6z/OA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQFyyeNa5OjIB6TNJm2ZdBJ0jEdKl1pY41hNTAtEwSI5arxcKz
	ybwyE7Af86P638lF3etmGe/63/nDcqMAR+9CJ3nDVrNQLciTMvKG
X-Google-Smtp-Source: AGHT+IHas9AFF3rpn/hlEB9XmENylzBx4gr+WW3R1HvtT5vIR5jCsZAF6ErjjvCUZGWF8PyDEzUuDw==
X-Received: by 2002:a05:6a20:439e:b0:1cf:50ce:58d7 with SMTP id adf61e73a8af0-1d9a8404bf8mr47545628637.29.1730773857770;
        Mon, 04 Nov 2024 18:30:57 -0800 (PST)
Received: from z790sl ([240f:74:7be:1:54ee:9253:695b:4125])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2c54f1sm8326622b3a.121.2024.11.04.18.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 18:30:56 -0800 (PST)
Date: Tue, 5 Nov 2024 11:30:51 +0900
From: Koichiro Den <koichiro.den@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	Peter Collingbourne <pcc@google.com>, cl@linux.com, penberg@kernel.org, rientjes@google.com, 
	iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, roman.gushchin@linux.dev, 
	42.hyeyoo@gmail.com, kees@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/slab: fix warning caused by duplicate kmem_cache
 creation in kmem_buckets_create
Message-ID: <f6suzwxd6euy5drff5ur7xykmmimyd4g6s7bfu4j5zhimvndra@bjzvy2jmeq3h>
References: <20241104150837.2756047-1-koichiro.den@gmail.com>
 <ZykLxG5Tyet5HcwL@casper.infradead.org>
 <8202821f-05bc-41f8-9de3-bf78899a7c7b@suse.cz>
 <ZylJLXSTAY8TLijb@arm.com>
 <ZylKlUqHkzLNwEHA@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZylKlUqHkzLNwEHA@arm.com>

On Mon, Nov 04, 2024 at 10:28:37PM +0000, Catalin Marinas wrote:
> On Mon, Nov 04, 2024 at 10:22:37PM +0000, Catalin Marinas wrote:
> > On Mon, Nov 04, 2024 at 07:16:20PM +0100, Vlastimil Babka wrote:
> > > On 11/4/24 19:00, Matthew Wilcox wrote:
> > > > On Tue, Nov 05, 2024 at 12:08:37AM +0900, Koichiro Den wrote:
> > > >> Commit b035f5a6d852 ("mm: slab: reduce the kmalloc() minimum alignment
> > > >> if DMA bouncing possible") reduced ARCH_KMALLOC_MINALIGN to 8 on arm64.
> > > >> However, with KASAN_HW_TAGS enabled, arch_slab_minalign() becomes 16.
> > > >> This causes kmalloc_caches[*][8] to be aliased to kmalloc_caches[*][16],
> > > >> resulting in kmem_buckets_create() attempting to create a kmem_cache for
> > > >> size 16 twice. This duplication triggers warnings on boot:
> > > > 
> > > > Wouldn't this be easier?
> > > 
> > > They wanted it to depend on actual HW capability / kernel parameter, see
> > > d949a8155d13 ("mm: make minimum slab alignment a runtime property")
> > > 
> > > Also Catalin's commit referenced above was part of the series that made the
> > > alignment more dynamic for other cases IIRC. So I doubt we can simply reduce
> > > it back to a build-time constant.
> > 
> > I principle, I wouldn't reduce it back to constant though the 8 vs 16
> > difference is not significant. It matter if one enables KASAN_HW_TAGS
> > and wants to run it on hardware without MTE, getting the *-8 caches
> > back.
> > 
> > That said, I haven't managed to trigger this warning yet. Do I need
> > other config options than KASAN_HW_TAGS and DEBUG_VM?
> 
> Ah, I was missing SLAB_BUCKETS. I'll have a look tomorrow.
> 
> -- 
> Catalin

Thank you for reviewing. I just sent v2 so please take a look at that
instead.
v2: https://lore.kernel.org/linux-mm/20241105022747.2819151-1-koichiro.den@gmail.com/

