Return-Path: <stable+bounces-69579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43C1956A20
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 13:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8BFA1C22419
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FABB168486;
	Mon, 19 Aug 2024 11:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izwVd1lQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAB415B972;
	Mon, 19 Aug 2024 11:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724068786; cv=none; b=XudComkI0hM3Hv1rlCy6c5URGWKtmridylqEbTpJPra/jrUiunJwSl5XmkLgP1i3HPeUPX8xpR1Oul/BJmRQ1mgg7tTNSHolUPdOEJHfRhS8LFY6/h/CLe9a0I3sH32ExQDvKPrvQNfl7EhbdxQyf2kZRS1zUUZvz+/3S/qDukc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724068786; c=relaxed/simple;
	bh=QNxzEbbmVYsN7LYfH04kavc3TDZdr/+lk+puUfhhFLs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyY7mvz7km4Ghcyugl90f3jYenfOrzvLWJYsL/A7Vx+Taf2xS4omLtVL2quCD4BKLMo1sqPWLIXe6mE3UYfkUgE9HJ0u9tW8gfkKyCs+2zoCnW0QS7NP7wJrusxo+e5sHhQi0Ky6wQdlZ/tGUPh/hX8SVS0N8UoT4XXWySkmAI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izwVd1lQ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso12365751fa.2;
        Mon, 19 Aug 2024 04:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724068783; x=1724673583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=11BaiIrZqK6uC9f6mo5FUMGk8lscaJMZdcTKC0DE5Gw=;
        b=izwVd1lQh/+7DPEFSQrtxDAWvRdJwLp5QHcZwY48aad+PYsv8evg3fXynVYdB/Tm0K
         AWccw/uOtQ6jUtRAp9u/D6L9NfK8rbf9ih0LMEjErbwZEzgyM7/ZUaoXMLP6SiGBPh06
         Q8zPgXHVVrcLzG11Tktbqt/tCxpCfqMlWMcT2oUfvXJEKSt+D0SEcrdd7vN0DmHlL8hL
         4oFmKLgK5UjGUH/2OeXyJPJ3QGL3gJECitHYINEc/oFX1vk3gmG+OJuN0dGPxULd8c9A
         muIVp22tejnoo9dC6h3UGdfe7JrIsnT4NCedr0v/GCKD+F3EmcNIfR7fpr6QiWwZuCMp
         Sibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724068783; x=1724673583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11BaiIrZqK6uC9f6mo5FUMGk8lscaJMZdcTKC0DE5Gw=;
        b=gMuWFLSNXb6gQ2iPEwojxDqPqYKIvHy5SQ8F00nIabnPOQ7c7XO/JhFiRUjPKets8S
         0WYucZwhKp/pFyBXp9Y50RnVrAUQ478G1sghnG/1CGjmOxGzduehDSMygZvViXUwwc9u
         fkPZVYW5jLVU5IVlSq0qu7VTDFkrhF94z5xj6AwLUAYuM05BXJs0r+4qFVipTiT0/5N4
         X1nPM9A3zaU/3KsrrVsCR757xdeMcG5o8zK/BiOq6096DsUKBRsGWG3wYdaDaoLfzIha
         HX8/mmNc5EdiMTmFkEbOwbEV48zwf6KT5CSsnWEJO8v4/na9BiywTui9fw83pJLJTqQ8
         xBsg==
X-Forwarded-Encrypted: i=1; AJvYcCUvptSjEGOsiPw4w8yKj9U4bcdl20PrQZ5IIa+v3IljIrFINyNdgfFWF86EHc+z1NDOaZckASwmonVFJkrWi8aLBtGK9IBj3VleYtD4CqUEwn9K0e3wCIQUZ66x9IIA1xlmt0NT
X-Gm-Message-State: AOJu0YyiV7G52bF0HB4q8HHoKlnY4dy7C1GA5Yim9uPSxYQj/YTop9Iu
	n4jS7uN341S4iX/I19D+DiK2BcjnFkKsRtpV/xtDQatWNiOGSS3e
X-Google-Smtp-Source: AGHT+IHZcVhAZ8nSbzw84gbFmvs+SpnOwYZjzUxnOnvuu+EHF8HwpuzZOmAF90sj/Kck0Tf9+mSA1Q==
X-Received: by 2002:a05:6512:3a82:b0:530:da96:a990 with SMTP id 2adb3069b0e04-5331c6bbefcmr9002028e87.32.1724068782130;
        Mon, 19 Aug 2024 04:59:42 -0700 (PDT)
Received: from pc636 (host-90-233-222-226.mobileonline.telia.com. [90.233.222.226])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5330d3afb37sm1476875e87.20.2024.08.19.04.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 04:59:41 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 19 Aug 2024 13:59:39 +0200
To: Hailong Liu <hailong.liu@oppo.com>, Michal Hocko <mhocko@suse.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>, Barry Song <21cnbao@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Tangquan Zheng <zhengtangquan@oppo.com>, stable@vger.kernel.org,
	Baoquan He <bhe@redhat.com>, Matthew Wilcox <willy@infradead.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v1] mm/vmalloc: fix page mapping if
 vm_area_alloc_pages() with high order fallback to order 0
Message-ID: <ZsMzq4bAIUCTJspN@pc636>
References: <20240808122019.3361-1-hailong.liu@oppo.com>
 <CAGsJ_4z4+CCDoPR7+dPEhemBQN60Cj84rCeqRY7-xvWapY4LGg@mail.gmail.com>
 <ZrXiUvj_ZPTc0yRk@tiehlicka>
 <ZrXkVhEg1B0yF5_Q@pc636>
 <20240815220709.47f66f200fd0a072777cc348@linux-foundation.org>
 <20240816091232.fsliktqgza5o5x6t@oppo.com>
 <Zr8mQbc3ETdeOMIK@pc636>
 <20240816114626.jmhqh5ducbk7qeur@oppo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816114626.jmhqh5ducbk7qeur@oppo.com>

On Fri, Aug 16, 2024 at 07:46:26PM +0800, Hailong Liu wrote:
> On Fri, 16. Aug 12:13, Uladzislau Rezki wrote:
> > On Fri, Aug 16, 2024 at 05:12:32PM +0800, Hailong Liu wrote:
> > > On Thu, 15. Aug 22:07, Andrew Morton wrote:
> > > > On Fri, 9 Aug 2024 11:41:42 +0200 Uladzislau Rezki <urezki@gmail.com> wrote:
> > > >
> > > > > > > Acked-by: Barry Song <baohua@kernel.org>
> > > > > > >
> > > > > > > because we already have a fallback here:
> > > > > > >
> > > > > > > void *__vmalloc_node_range_noprof :
> > > > > > >
> > > > > > > fail:
> > > > > > >         if (shift > PAGE_SHIFT) {
> > > > > > >                 shift = PAGE_SHIFT;
> > > > > > >                 align = real_align;
> > > > > > >                 size = real_size;
> > > > > > >                 goto again;
> > > > > > >         }
> > > > > >
> > > > > > This really deserves a comment because this is not really clear at all.
> > > > > > The code is also fragile and it would benefit from some re-org.
> > > > > >
> > > > > > Thanks for the fix.
> > > > > >
> > > > > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > > > >
> > > > > I agree. This is only clear for people who know the code. A "fallback"
> > > > > to order-0 should be commented.
> > > >
> > > > It's been a week.  Could someone please propose a fixup patch to add
> > > > this comment?
> > >
> > > Hi Andrew:
> > >
> > > Do you mean that I need to send a v2 patch with the the comments included?
> > >
> > It is better to post v2.
> Got it.
> 
> >
> > But before, could you please comment on:
> >
> > in case of order-0, bulk path may easily fail and fallback to the single
> > page allocator. If an request is marked as NO_FAIL, i am talking about
> > order-0 request, your change breaks GFP_NOFAIL for !order.
> >
> > Am i missing something obvious?
> For order-0, alloc_pages(GFP_X | __GFP_NOFAIL, 0), buddy allocator will handle
> the flag correctly. IMO we don't need to handle the flag here.
> 
Agree. As for comment, i meant to comment the below fallback:

<snip>
fail:
	if (shift > PAGE_SHIFT) {
		shift = PAGE_SHIFT;
		align = real_align;
		size = real_size;
		goto again;
	}
<snip>

--
Uladzislau Rezki

