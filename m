Return-Path: <stable+bounces-71247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497089612EC
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDB12B22B07
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385F21C6F51;
	Tue, 27 Aug 2024 15:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMZNf6vB"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE13148302;
	Tue, 27 Aug 2024 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772582; cv=none; b=UgrlKik4Y+urIfnt7HczHm48JnDe1lLRDxQXPDv9Qt/vT7JaLhulfzTilsYT0X5Ldb+YuZLvKj+gKeayiUJeQMmCGqqI3Uo3O8WY17ZnRODABcKrHlF+9+tQbcl9a59ujX0kZkM4qEmEscbL25AzDKwsiU38DDrn1Tu+bAeAfyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772582; c=relaxed/simple;
	bh=9aW2onbiq5EWdt1zGOOLGyusFlqkV6Ndt0HXHadGScI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3aydI7zdfu50mxH0/bikH22EnO9VpdX8ykG+Eo3uN49MFZLPM1wIKVxB3DMU1oC1NbLkNq47lJo+pB3QVy+1sGBdRNkkqwUcH7tIx4JP+9PxmTZZUQPfQ4pbWhKAPuUMEWJ7JHRnk7rWm5pPBwz8hH18g0K4CW2OjSngBRROrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMZNf6vB; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53349d3071eso6888377e87.2;
        Tue, 27 Aug 2024 08:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724772578; x=1725377378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f0CuVBUU188TFdCdCElDdpiQeiLNGXtDVDEZ4g9j024=;
        b=BMZNf6vBkLfMU62qzKvBFF8xrdW343TSwbZVPL8z4aqNN6Y9jo8EmtgFIvH+JX4l3u
         XBd4/rjlwjdplsP/WIuWZ92j9WgshBVpKVBDmM/xEqkIwoJQP+mwWtoXzLBJQzB9OyCN
         9k8FK26mVZw637Fgz1IMRnvgAWoyU2Vkq91MpS66toaIh9NC+CPZubiLweOjhmEMHtNn
         sZYdfIvTThhn7BZwJrxSa1TueCg3MyA43vnBZOtlAlwQiP3NE05LVJYy++pHZqp2u+27
         7mXptBR0fftO5Ju2TUI/j468a4k9yHbZenBXJy9ZWpOFZnR3kznWRLp4VrtcueVCPn1N
         Z36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724772578; x=1725377378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0CuVBUU188TFdCdCElDdpiQeiLNGXtDVDEZ4g9j024=;
        b=mWkduCOOy8vpzodydAPu/Xae3agtDSl6k2UGjlewsPtXCsG3mGOQZFWSedmFW+D+HZ
         CQOTh6wcyrMVgmMNqYIY9A5N9wR+cm2tgVSx592hWX8APQNnTyDlDGHKDCbI0RIVVLRZ
         ITM/TjTZw5kltFahks9MIb2CgiTm8OlImH5oBUDQ1rPWcTC3FuhpyTbrAry95zYVPDW/
         LPnF18WrXEWACUc2+l3hJ3hdCRDjg/FPWuXF0EKWicxOjSeMKCkSGfKvJmwRxi3sPosa
         emBeFacCWyyz4l21tZ8HxEAEfzFu3vQCSX3N24iQDeRznEXcClSwVXAOBsqFifCdaSSN
         qu5A==
X-Forwarded-Encrypted: i=1; AJvYcCVlWsMAMCgZekwlWrA1EnYQB2lF/bLoz6yVscAwd7S+AJctDqBWJbB0bjAj7mcI1jTlAJeexKrV@vger.kernel.org, AJvYcCWbKVxb70ydWKMamQlB/2lH8vlWlUNVZ0tPLGMozOLVkCVNT1GWox2mgBjkTLHX0mAZMWAhq2pz6G6hVBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0eEpr8jj0Rc1vBdfTva8Dd6JITMWJDzkzI1fMkPnI0XtUCWSj
	rORf6nyAEdKVlp9yn+jfTsWX1j3lOu97XMiP+gJo9d+g4JnbLN7Y
X-Google-Smtp-Source: AGHT+IEIP68WxlCLDhys8pYQtHsPKoUPB4CYjjsRJozxWR4f23vWfH5GoC33jNXHu9c5dPW+mp3mkw==
X-Received: by 2002:a05:6512:108b:b0:52e:768e:4d1f with SMTP id 2adb3069b0e04-534387858a6mr9416434e87.36.1724772577623;
        Tue, 27 Aug 2024 08:29:37 -0700 (PDT)
Received: from pc636 (host-90-233-206-146.mobileonline.telia.com. [90.233.206.146])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea5da51sm1826531e87.224.2024.08.27.08.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 08:29:37 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 27 Aug 2024 17:29:34 +0200
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
Message-ID: <Zs3w3k7-bzCYa3KC@pc636>
References: <20240816091232.fsliktqgza5o5x6t@oppo.com>
 <Zr8mQbc3ETdeOMIK@pc636>
 <20240816114626.jmhqh5ducbk7qeur@oppo.com>
 <Zr9G-d6bMU4_QodJ@tiehlicka>
 <Zsi8Byjo4ayJORgS@pc638.lan>
 <Zsw0Sv9alVUb1DV2@tiehlicka>
 <Zsx3ULRaVu5Lh46Q@pc636>
 <Zs12_8AZ0k_WRWUE@tiehlicka>
 <Zs3K4h5ulL1zlj6L@pc636>
 <Zs3WouJpDk3AWV4D@tiehlicka>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs3WouJpDk3AWV4D@tiehlicka>

On Tue, Aug 27, 2024 at 03:37:38PM +0200, Michal Hocko wrote:
> On Tue 27-08-24 14:47:30, Uladzislau Rezki wrote:
> > On Tue, Aug 26, 2024 at 08:49:35AM +0200, Michal Hocko wrote:
> [...]
> > > > 2. High-order allocations. Do you think we should not care much about
> > > > it when __GFP_NOFAIL is set? Same here, there is a fallback for order-0
> > > > if "high" fails, it is more likely NO_FAIL succeed for order-0. Thus
> > > > keeping NOFAIL for high-order sounds like not a good approach to me.
> > > 
> > > We should avoid high order allocations with GFP_NOFAIL at all cost.
> > > 
> > What do you propose here? Fail such request?
> 
> We shouldn't have any hard requirements for higher order allocations in the vmalloc
> right? In other words we can always fallback to base pages.
>
We always drop NOFAIL for high-order, if it fails we fall-back to
order-0. I got the feeling that you wanted just bail-out fully if
high-order and NOFAIL.

--
Uladzislau Rezki

