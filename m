Return-Path: <stable+bounces-71389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A1A96206E
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 09:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12E9B1F2432B
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 07:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6144215852B;
	Wed, 28 Aug 2024 07:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SskXlKU0"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323FB328DB
	for <stable@vger.kernel.org>; Wed, 28 Aug 2024 07:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724829298; cv=none; b=oPoR6hxH2n/skFHtxtgVhSz3t5JX3uYKs46jgvyiflYhDKf+czoLYy6stKS4L9dCsYRvWwc/6WA+hyJaLI9fYBLWKnyHO/G0Xod97zVZobTGS7VuqvFTRqfD8Hl42AK5pwM6CtaaHlEhxwHkGe3HsuWTCwers2/XJJniH63pFSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724829298; c=relaxed/simple;
	bh=WDCMytwnAp8pMu54YN3rA1pD3RkmB/XK2BssZPaZ/kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3y3D1y7ugpYuc38J2cpsQr6CQp5fl2FERulNafh1lCWYSM9vddkBVUIMRbxJnSFWrsNRyDcxQje3rANjUQ5/yQWA5fvfTb4j31/aI1LvGEyuAkh5jDF+wWy5+d3TljVgirox6tssQq3wXcK3kfkZvMO16tyGMRPprm2obhdsTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SskXlKU0; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a86910caf9cso56283866b.1
        for <stable@vger.kernel.org>; Wed, 28 Aug 2024 00:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724829294; x=1725434094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PG+Y+iPEJrhNPEqaAwHaY0bOaMvK21xV21Vun1ew9Is=;
        b=SskXlKU0aL9W5s87F2CWILvbceP5TcVMIwJeBX69+dh3crl72FlC4UrSxLt/AtqzmJ
         yyz1yAEUjF33ndOANJQARIXgYGIvLcG9EH5WWZ5y+y7im0NWPxad0PRbVLrmhuzCkt89
         UJkdpTg/8E+eAxTkQCtjM5P9SgFXjjnyJqeqont4xd2x3eIczrwBNzblqxqHwGgj4vFM
         F0i0xAlgskqz2MhCtQC9Yj8fkKtlil808gqqkskTuzpp48Zo9bnZnFTeljMcjxv1pX+P
         LbQfzDPPonLop4IY7FPufYAl01srIhwt8Roi8PaoQi/UTLW6+rkzIEAw1W6caN/7NJcm
         XU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724829294; x=1725434094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PG+Y+iPEJrhNPEqaAwHaY0bOaMvK21xV21Vun1ew9Is=;
        b=xCAfzKAMsBHp+Jhpta1YITBnRmUGSNo2v3itg9V1XX5+Pvc4IykkkqQIPakuscQUp4
         lPgPoI9JsFSmbVVFTJ17Mkk7sf429KMuqaDonJpO8HclJTVm9CjUX3LgO0c3izDt5BPQ
         JLMm+LWh76x06XqKsQLvyAJDgPchowAL2FPGHzb56LWcFaQ70QBwhVU1Ha/IJ4tXgiUl
         cDCUMuS089bxlZqGEQeAwXuoI5J7IJjAFJhyymNd9kNZWayRxDvR/XxCZpaCnvy3d99Z
         FmgHLy2bxLdF9XI26evK4SQH7WgIM2udjCJb5gnfZYbhmHqIgKA1KSz4ptYY7xSphufw
         ZwtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZyNuMvyZ3kGjU9lqiudMTupHoyUgW0uX0Mz9Ldo40+ImaOZ1CptuSW/GOdIMviaaj72cSbUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo9IFVkgm0xgR35FtZvp/rsuo6BheHiM+aFo85T0I9/aMTOiH5
	rzHdY7T/EQQNdB7pPlVWgs94L0M928PEZy9ST9kyqlVbd/aF6Tnu96xaIRTBqAY=
X-Google-Smtp-Source: AGHT+IHFQn+2dk85m69kJ8Wp6sfOI9yrSVVvMx2xqX2Nlpk3qlQRXfnHV1pIvevTbCDASqx1v9/IJQ==
X-Received: by 2002:a17:907:1b1d:b0:a86:b5ac:e22a with SMTP id a640c23a62f3a-a870ab0c6f6mr143124766b.34.1724829294499;
        Wed, 28 Aug 2024 00:14:54 -0700 (PDT)
Received: from localhost (109-81-92-122.rct.o2.cz. [109.81.92.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e549ca7bsm203208866b.52.2024.08.28.00.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 00:14:54 -0700 (PDT)
Date: Wed, 28 Aug 2024 09:14:53 +0200
From: Michal Hocko <mhocko@suse.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Hailong Liu <hailong.liu@oppo.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <21cnbao@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Tangquan Zheng <zhengtangquan@oppo.com>, stable@vger.kernel.org,
	Baoquan He <bhe@redhat.com>, Matthew Wilcox <willy@infradead.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v1] mm/vmalloc: fix page mapping if
 vm_area_alloc_pages() with high order fallback to order 0
Message-ID: <Zs7ObXBgULkuvaXK@tiehlicka>
References: <Zr8mQbc3ETdeOMIK@pc636>
 <20240816114626.jmhqh5ducbk7qeur@oppo.com>
 <Zr9G-d6bMU4_QodJ@tiehlicka>
 <Zsi8Byjo4ayJORgS@pc638.lan>
 <Zsw0Sv9alVUb1DV2@tiehlicka>
 <Zsx3ULRaVu5Lh46Q@pc636>
 <Zs12_8AZ0k_WRWUE@tiehlicka>
 <Zs3K4h5ulL1zlj6L@pc636>
 <Zs3WouJpDk3AWV4D@tiehlicka>
 <Zs3w3k7-bzCYa3KC@pc636>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs3w3k7-bzCYa3KC@pc636>

On Tue 27-08-24 17:29:34, Uladzislau Rezki wrote:
> On Tue, Aug 27, 2024 at 03:37:38PM +0200, Michal Hocko wrote:
> > On Tue 27-08-24 14:47:30, Uladzislau Rezki wrote:
> > > On Tue, Aug 26, 2024 at 08:49:35AM +0200, Michal Hocko wrote:
> > [...]
> > > > > 2. High-order allocations. Do you think we should not care much about
> > > > > it when __GFP_NOFAIL is set? Same here, there is a fallback for order-0
> > > > > if "high" fails, it is more likely NO_FAIL succeed for order-0. Thus
> > > > > keeping NOFAIL for high-order sounds like not a good approach to me.
> > > > 
> > > > We should avoid high order allocations with GFP_NOFAIL at all cost.
> > > > 
> > > What do you propose here? Fail such request?
> > 
> > We shouldn't have any hard requirements for higher order allocations in the vmalloc
> > right? In other words we can always fallback to base pages.
> >
> We always drop NOFAIL for high-order, if it fails we fall-back to
> order-0. I got the feeling that you wanted just bail-out fully if
> high-order and NOFAIL.

Nope. We should always fall back to order 0 for both NOFAIL and regular
vmalloc allocations.

-- 
Michal Hocko
SUSE Labs

