Return-Path: <stable+bounces-69315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E07995468E
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 12:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05551F22CBC
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 10:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82041170A2D;
	Fri, 16 Aug 2024 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0FTh5Nl"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9888881741;
	Fri, 16 Aug 2024 10:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723803209; cv=none; b=Q4vz5TJzRtPnEdWbWDOot160hMcKip6VoTbsViO33KgY63wm6QVSLLnoArfnWhkvYE3ebzBOToqaAg3WkI9eFybHxh1Z3Ky/LzcikVH2xLYSKraokpatM6Af/9SsUySX/d/abgA3ACY6nX7Kntfz14ZmgciS4HOc7CAYEzi5eXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723803209; c=relaxed/simple;
	bh=yMpT0AwU6aa6vozdU3i8e/x/S3yREPELsS/sP0YSs6A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Es5WQu3mHTe07yWX2LSjCRySvukpJE8OUKrYW0y+7pWdQq06gTQlyAbKNSFClNn73pFGbs7UiMPvjLaIa/VCpFMrnc2qI7+TkYDnYEuFbmnLbD0whpmzK4+8MtoGB7YrrFt2G3tZIse+bzJ8vDe4ZtTNmDSw7aQSsqD0fXyldJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0FTh5Nl; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso26994491fa.2;
        Fri, 16 Aug 2024 03:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723803206; x=1724408006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mX0QjytBccHj3E/U2+ZxJG6mQrfJ0MGA/Z6TLsinBxw=;
        b=h0FTh5Nln8jHaqlDKE+J1ElAR+BYuuOPEP24jp034Fi8GVzBtwVdHWl2o2HCy0ocDV
         n6deeSCTgyLT6s9Uz6bED34lOqMOMuXE2gUtJXHlhUUv7RpaE/ndyiHQmfL9moDLhR2P
         yHalXfYogWcn6eu1eV4m+bkejvOOxseWzovlUtf3zHKKbsSVvcmKDm/0vsghJUd18h30
         IIvIibQAnpmphxqygDlFMa27xjZ4I/Ha9UTZm8aPCnIx+s6OZySaw19JrhLNED5eOQ42
         X5+rdlHvNyDwGkQOHf9B0g0umS2te61XyzErRXS+jhJu7MdVTf7p6Imi7R8nCAwUW2LA
         /sHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723803206; x=1724408006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mX0QjytBccHj3E/U2+ZxJG6mQrfJ0MGA/Z6TLsinBxw=;
        b=u4kgDPTMos7sH0nGI2UqNd4zE6CWY9jXjS5gSdZOMNBSjWLM4Ax7h5Kv/3PoFgv/l5
         ij5Xi03FaaHk2iPLPa2Dq5FNa91XnQ4TXT7y4Abaz8JTgFq8gDkRf5SPPS+VzQVWpE+v
         IvLN2AoXEX8JSwbDTPgKZGhLF0I+cZUya0rAHRJ5C0Msg83kuSCgKWJ5njTxsO4XiaFV
         vxZsSAm7X2w8kujz64nAyXHjx5Bj63bKXn3xnrg8jjIsv2v90TzVXkT6ztBZwp5ystM7
         r0H21j7bsO0gHAtvX7586XYhuSCQxo62LGAnEh8rrTu4AY+zrfAHZo7j+UI9mk2++s6W
         IMRA==
X-Forwarded-Encrypted: i=1; AJvYcCVTlelru4/T2MIFbjqq6lyux1SviQprYDv2+D8Hs3IGdOSiFVCwvsg7gMe1Q9g83HAE+yAFVGGo0B05NWRsXKDiydfsg3zw2c8Qu55uu1To7pewnXb79SYw7ugjxc/1AN2WOFTo
X-Gm-Message-State: AOJu0YzXjwElLVI6e0kvE+sA5y1ycX584PkliyLzl8nrPsnm8FxA6eFQ
	rZD/a/W9D3KLEJOEEQkW6feuDG+RC+HBsZU4Hp/c8OKilTfpF6RN
X-Google-Smtp-Source: AGHT+IHoN/OTahMDYZFxiU7ILKiovPlHB8SS+Ly2Ed8r65CGLkK2ARLHV4+PTXUycWoouYbLtPjl5w==
X-Received: by 2002:a05:6512:10cd:b0:530:b871:eba9 with SMTP id 2adb3069b0e04-5331c691e9dmr2025403e87.1.1723803205198;
        Fri, 16 Aug 2024 03:13:25 -0700 (PDT)
Received: from pc636 (host-90-233-214-145.mobileonline.telia.com. [90.233.214.145])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5330d41df75sm501629e87.194.2024.08.16.03.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 03:13:24 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 16 Aug 2024 12:13:21 +0200
To: Hailong Liu <hailong.liu@oppo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>, Michal Hocko <mhocko@suse.com>,
	Barry Song <21cnbao@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Tangquan Zheng <zhengtangquan@oppo.com>, stable@vger.kernel.org,
	Baoquan He <bhe@redhat.com>, Matthew Wilcox <willy@infradead.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v1] mm/vmalloc: fix page mapping if
 vm_area_alloc_pages() with high order fallback to order 0
Message-ID: <Zr8mQbc3ETdeOMIK@pc636>
References: <20240808122019.3361-1-hailong.liu@oppo.com>
 <CAGsJ_4z4+CCDoPR7+dPEhemBQN60Cj84rCeqRY7-xvWapY4LGg@mail.gmail.com>
 <ZrXiUvj_ZPTc0yRk@tiehlicka>
 <ZrXkVhEg1B0yF5_Q@pc636>
 <20240815220709.47f66f200fd0a072777cc348@linux-foundation.org>
 <20240816091232.fsliktqgza5o5x6t@oppo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816091232.fsliktqgza5o5x6t@oppo.com>

On Fri, Aug 16, 2024 at 05:12:32PM +0800, Hailong Liu wrote:
> On Thu, 15. Aug 22:07, Andrew Morton wrote:
> > On Fri, 9 Aug 2024 11:41:42 +0200 Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > > > > Acked-by: Barry Song <baohua@kernel.org>
> > > > >
> > > > > because we already have a fallback here:
> > > > >
> > > > > void *__vmalloc_node_range_noprof :
> > > > >
> > > > > fail:
> > > > >         if (shift > PAGE_SHIFT) {
> > > > >                 shift = PAGE_SHIFT;
> > > > >                 align = real_align;
> > > > >                 size = real_size;
> > > > >                 goto again;
> > > > >         }
> > > >
> > > > This really deserves a comment because this is not really clear at all.
> > > > The code is also fragile and it would benefit from some re-org.
> > > >
> > > > Thanks for the fix.
> > > >
> > > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > >
> > > I agree. This is only clear for people who know the code. A "fallback"
> > > to order-0 should be commented.
> >
> > It's been a week.  Could someone please propose a fixup patch to add
> > this comment?
> 
> Hi Andrew:
> 
> Do you mean that I need to send a v2 patch with the the comments included?
> 
It is better to post v2.

But before, could you please comment on:

in case of order-0, bulk path may easily fail and fallback to the single
page allocator. If an request is marked as NO_FAIL, i am talking about
order-0 request, your change breaks GFP_NOFAIL for !order.

Am i missing something obvious?

Thanks!

--
Uladzsislau Rezki

