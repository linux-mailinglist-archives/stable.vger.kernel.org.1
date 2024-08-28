Return-Path: <stable+bounces-71432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D378D962E62
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 19:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E068B23537
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 17:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9B61A38D6;
	Wed, 28 Aug 2024 17:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecYsA2Q1"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4E236130;
	Wed, 28 Aug 2024 17:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724865845; cv=none; b=SQ3T3k4W1o32lJiYP8zdUjpEgQReQ92loDNJfRykuqwhtO22XH812sjYIZ/XnI0hPeeaZQW11B4421SxR1rZQTCz8DxLfYesw4krkzxgwz8ljn5QVk6MexqDOKDj42gXQ2hy4SbZrFf6hVNL3Ubd5QHv57gBz8JsbovVVGXvV9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724865845; c=relaxed/simple;
	bh=vFWl8poib/+4F/OW6aol1GsR7dFJOwzrkvpb0GGqDlg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SH6eqEIfCRBw/WCBv8wMAd2RqYRlJ/23czKlr5FO98zIA2sFG3aFsPkMYDDfS4uqG9t1tMYoQMY/eSXEDiH7JgzdtoYq5PSzuZ5HYSqlQmYqpM4pehxoCYy+/m36OtMvDjRKa3tdNl04xFKa5Fe5pAORbEZAzZpwgrqbcnnFm7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecYsA2Q1; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f50f1d864fso36823261fa.1;
        Wed, 28 Aug 2024 10:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724865842; x=1725470642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wKSf7KHGE8x6jvVOVqxv8wQa+Jwbt0tqgqyGwouit5E=;
        b=ecYsA2Q1+2Gf8za/kg/QadO3R+U8jO93+rq2POyp327ImN7ZY/2n7eeblnEXB6Qpsm
         aCpFgZxD9Si8i+liOXFt71/zSlDnjjQt7Y6msYf8JqpaZET2iqeS/D9LtvhoxY1P4VaU
         Rrno6P8ZufrmfS/c/ybHpp3+pKOhRaIuirfRHLToB5vKBcZdRnuU4R8bhXW5NkrI9nG9
         70hYzkKM/5uP4dRXr9QKsL0dS9eWmvLOmB1TNa79eF/+tI6hqIGpv84FyN/cjBp9ihvK
         DzOhVcmpdeMzR3d99po68+6QyaCGkDtBBEuaeKx0U+5rd1C3ggI2igvuGkR6rJFUuknu
         1G3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724865842; x=1725470642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKSf7KHGE8x6jvVOVqxv8wQa+Jwbt0tqgqyGwouit5E=;
        b=o2is1lgYivvPMoEbL5lVVR6c7NBmgnBMk4hJbCVEVA8+8j4JDE1hgq8132Lq4hMlRj
         +h8+IgJ8aY6RcZrpyIJvJymUEoPB06QVFg1D+HBWP4BDtgwVPQ74CEZ71Pqg7mu7w6yd
         T9qSHrAJW+JazVVJp+qM+AJgRAt2uautle2XAdZA0I2TAusmx1L3W5w5fgLFlm8pt2Lq
         EwEEPTRVA5ZjVRaflHw2aVXnXGxVuNHuM9jWdd0s4qc96Q1+tAbMpfUyQfnSbtOpEqt0
         DJsa2CawDIKEHN5oAplBWe10eCMQ0Fcy5mS+9C9gh8cRVNZ4owcMY42zp1B62gcvnpv/
         R1gg==
X-Forwarded-Encrypted: i=1; AJvYcCU6mI28lj7jmjvOopKu0B2bMkKwbCcQ4mA70Kc6fPHRClghvl8GBEf1K5iCHwbXdXb8m36h3QqBuBxEFQU=@vger.kernel.org, AJvYcCUrsF2p3ST18eR2Fb40WQ8gLiLA1iO9esmhRbfCQ45HygSTmLHctEths8SCd6iTSwa4vyjty3Ng@vger.kernel.org
X-Gm-Message-State: AOJu0YxLLJVJVeiVVqkKiA65D3ofTvp0+J6pqxfAr2puazD5NVpXSXIv
	nJyXXBgmRFf2gyNLp2OsG+KhrJUnoNtZMrAyter1wCVBs4dWW8f9
X-Google-Smtp-Source: AGHT+IGsw/F5hC5DWs12E3b4scBC2HyWOsUKn1a0W2LDOS1mCJtNnBGRm4CD71rylVT8vnXP8/sAgg==
X-Received: by 2002:a2e:4e11:0:b0:2ec:55b5:ed45 with SMTP id 38308e7fff4ca-2f6103f62cemr2492661fa.24.1724865841293;
        Wed, 28 Aug 2024 10:24:01 -0700 (PDT)
Received: from pc636 (host-90-233-206-146.mobileonline.telia.com. [90.233.206.146])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f40487f80csm19726941fa.107.2024.08.28.10.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 10:24:00 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 28 Aug 2024 19:23:58 +0200
To: Michal Hocko <mhocko@suse.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Hailong Liu <hailong.liu@oppo.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <21cnbao@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Tangquan Zheng <zhengtangquan@oppo.com>, stable@vger.kernel.org,
	Baoquan He <bhe@redhat.com>, Matthew Wilcox <willy@infradead.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v1] mm/vmalloc: fix page mapping if
 vm_area_alloc_pages() with high order fallback to order 0
Message-ID: <Zs9dLuNrEwa-DxCk@pc636>
References: <20240816114626.jmhqh5ducbk7qeur@oppo.com>
 <Zr9G-d6bMU4_QodJ@tiehlicka>
 <Zsi8Byjo4ayJORgS@pc638.lan>
 <Zsw0Sv9alVUb1DV2@tiehlicka>
 <Zsx3ULRaVu5Lh46Q@pc636>
 <Zs12_8AZ0k_WRWUE@tiehlicka>
 <Zs3K4h5ulL1zlj6L@pc636>
 <Zs3WouJpDk3AWV4D@tiehlicka>
 <Zs3w3k7-bzCYa3KC@pc636>
 <Zs7ObXBgULkuvaXK@tiehlicka>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs7ObXBgULkuvaXK@tiehlicka>

On Wed, Aug 28, 2024 at 09:14:53AM +0200, Michal Hocko wrote:
> On Tue 27-08-24 17:29:34, Uladzislau Rezki wrote:
> > On Tue, Aug 27, 2024 at 03:37:38PM +0200, Michal Hocko wrote:
> > > On Tue 27-08-24 14:47:30, Uladzislau Rezki wrote:
> > > > On Tue, Aug 26, 2024 at 08:49:35AM +0200, Michal Hocko wrote:
> > > [...]
> > > > > > 2. High-order allocations. Do you think we should not care much about
> > > > > > it when __GFP_NOFAIL is set? Same here, there is a fallback for order-0
> > > > > > if "high" fails, it is more likely NO_FAIL succeed for order-0. Thus
> > > > > > keeping NOFAIL for high-order sounds like not a good approach to me.
> > > > > 
> > > > > We should avoid high order allocations with GFP_NOFAIL at all cost.
> > > > > 
> > > > What do you propose here? Fail such request?
> > > 
> > > We shouldn't have any hard requirements for higher order allocations in the vmalloc
> > > right? In other words we can always fallback to base pages.
> > >
> > We always drop NOFAIL for high-order, if it fails we fall-back to
> > order-0. I got the feeling that you wanted just bail-out fully if
> > high-order and NOFAIL.
> 
> Nope. We should always fall back to order 0 for both NOFAIL and regular
> vmalloc allocations.
> 
Good.

Thanks for the ACK!

--
Uladzislau Rezki

