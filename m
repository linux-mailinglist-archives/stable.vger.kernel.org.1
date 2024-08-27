Return-Path: <stable+bounces-70364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06175960C41
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52F528319D
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 13:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F231BF334;
	Tue, 27 Aug 2024 13:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bk04D5LQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39E01A0730
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 13:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724765864; cv=none; b=uftnDMI4a0DNvH3nCYJsvBHpGVHIKqSRRgt+f+sGv82JGT+aL945mW2fIf4fYdzpoXA0vG+J2vq8kBIXfmCbJIpPcwZ7d8jhqaCjmeMwSFcPprepRV3iT2xaUnI5eEZl5lH+smu7TkDnJzJTQXSo7VZpwMK7Yrt8IQWWBeIcwz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724765864; c=relaxed/simple;
	bh=wXsFWmD5dBtUKOpD/T8KdCEFMfFAVqUNboZ9+9Off0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIXwEDfqhdgQWwEZLh3gl2rqv2rCsSpg40P1F1AG4omyLH7DH2n18oMB43h2Rpi2mVZVh5e0OJukIaeJcM8y7KXNUt0dk5umrXlspydt/0lYnlmPYLd+LMjexmH4sjpJdH8yTWRu41qsSVp9ZiBwLpKYK8vXu1n6ij+yuOhFSas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bk04D5LQ; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f409c87b07so65085031fa.0
        for <stable@vger.kernel.org>; Tue, 27 Aug 2024 06:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724765860; x=1725370660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AT4VXmb4R9vLR4EZHGzi0KQ518kZdDJ1Wc7PbdyET90=;
        b=bk04D5LQumPJQrJeVrYScMfKlYwwb8Hn/9maV2wbNo1daMNdFCpZ7g7JgjNyoXrdYr
         SU7OLIGEphcDAsnVtyDUXYw9w4sfot90BYiUKoKA4UamQIM7X0w1ScqQ9sbW5HANloa3
         0599YvGCiRxG7yADvCFhchX12dTWdkYNY5aWsjfWrgZIvH1frklOYIYgJiaEOsY/+Z4U
         0jVLPFYRSHsOUjqkUiclmj2rTD0QpAQxJjhYtA3+k/XmMbvdT6StNGddMGcTwaPF3kWv
         5MsmqE0jhC0Dh5Ymc5MWZIcZl+nbj7lW5Oo/nab7QszNtH4xlJt3n3Vfv9BlJZKIio+Y
         c7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724765860; x=1725370660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AT4VXmb4R9vLR4EZHGzi0KQ518kZdDJ1Wc7PbdyET90=;
        b=uUMFrnnY5iFj/RQUCTFdOv5yIYP1LcjTTwUV4TYJPseoVJTK9UvJUJnH26Gq5n8RTh
         XtgRjJu6N3sZghzsjGKQYHHvpabE2kizI4Wid/BrQqMS+uMhFMeQ3iqadPLB+9fJ0k+Q
         DXpiA/j3PFIBrZzdi6yMr5OdTBgS+ulemdMqzdPbEpYoTvrDuy8zV46Wh6sNJ0V8o8OV
         tWKO8DMD/+zE7uRU7/ycfeB8r//aGT3aEmv+HnnEPhL9Nk3+OlhBvUNjrwh321Exwamv
         gyZf8mrTosLVk0sQ/NXNVJywhlQm6BPM9Yw+gGhPbJVtsyXF59Ne8rIqRMboZST1oftP
         mxEw==
X-Forwarded-Encrypted: i=1; AJvYcCVSIak2Fzhvmy9lyhTPbcWJceJKNGRk8pZEGHtHQUBAwpCDyHhtn7Ur/6pJ9xIIPqtlfBynYx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz43S+y9IveFeXhi5q1WjgYzCXqy0XbVeumXYaREZKhxgO+4N95
	DYi35PArcgyAGSZaFJM+97XtbiQa96nZ8EM0CHJZrWNWYN/PqLlOWsRxU7QHMEY=
X-Google-Smtp-Source: AGHT+IHLZaTBk7t7Tm5sDsRxPVC4MnBBYf4HikHA9gnfnsCOTEJ+b/dFLLVXn/7+6yLZPfm13I9ibA==
X-Received: by 2002:a05:651c:b1f:b0:2ef:2b53:c77e with SMTP id 38308e7fff4ca-2f4f48d605dmr94846181fa.7.1724765859849;
        Tue, 27 Aug 2024 06:37:39 -0700 (PDT)
Received: from localhost (109-81-92-122.rct.o2.cz. [109.81.92.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb1c2d45sm1029610a12.12.2024.08.27.06.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 06:37:39 -0700 (PDT)
Date: Tue, 27 Aug 2024 15:37:38 +0200
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
Message-ID: <Zs3WouJpDk3AWV4D@tiehlicka>
References: <20240815220709.47f66f200fd0a072777cc348@linux-foundation.org>
 <20240816091232.fsliktqgza5o5x6t@oppo.com>
 <Zr8mQbc3ETdeOMIK@pc636>
 <20240816114626.jmhqh5ducbk7qeur@oppo.com>
 <Zr9G-d6bMU4_QodJ@tiehlicka>
 <Zsi8Byjo4ayJORgS@pc638.lan>
 <Zsw0Sv9alVUb1DV2@tiehlicka>
 <Zsx3ULRaVu5Lh46Q@pc636>
 <Zs12_8AZ0k_WRWUE@tiehlicka>
 <Zs3K4h5ulL1zlj6L@pc636>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs3K4h5ulL1zlj6L@pc636>

On Tue 27-08-24 14:47:30, Uladzislau Rezki wrote:
> On Tue, Aug 27, 2024 at 08:49:35AM +0200, Michal Hocko wrote:
[...]
> > > 2. High-order allocations. Do you think we should not care much about
> > > it when __GFP_NOFAIL is set? Same here, there is a fallback for order-0
> > > if "high" fails, it is more likely NO_FAIL succeed for order-0. Thus
> > > keeping NOFAIL for high-order sounds like not a good approach to me.
> > 
> > We should avoid high order allocations with GFP_NOFAIL at all cost.
> > 
> What do you propose here? Fail such request?

We shouldn't have any hard requirements for higher order allocations in the vmalloc
right? In other words we can always fallback to base pages.
-- 
Michal Hocko
SUSE Labs

