Return-Path: <stable+bounces-176640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A11B3A77B
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 19:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9163BD51C
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 17:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808E1334732;
	Thu, 28 Aug 2025 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOTCUzMR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91EB33472C;
	Thu, 28 Aug 2025 17:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756401246; cv=none; b=ZBjwdR5hyHQNdFxjj3V0by8cLrLvl0CiTR4WVMnQB0B/ULbkPMC6311Rob/SCKNv2doRj9Lid+gf9dP99GphMjK7z5651VF8kcxsdLYhoYIx6d6c6660oZt3tP63YjR/pTu34pgGEXVwD5PfL/W4Mbu1ORhZ5J7A0X79pB+sFh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756401246; c=relaxed/simple;
	bh=e2P3GbBnr/vA2wrzEew5Vztgeqpf47vGM3LUngBv630=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnQ2BRRTdetKNeD5R1JIdtIos1vLYkbTDD5p7Jfq3z/bQWTE+TrMNhUCp+SXHsHvQznYbli3ZzVXkzQr5rdT0MtPxUl95VtoehvtDrpr91+vmo8i5/iHLQ3Vy9rhqq1QkZ0iovYNG9n4i8UZq2tJy+F557fQytArVkZfvu4x3x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOTCUzMR; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4c8bee055cso266883a12.2;
        Thu, 28 Aug 2025 10:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756401244; x=1757006044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oFf6Y+kZ5qDzWQbTvOGNXX5jgmWUdsOKV0pU+ZaksJQ=;
        b=ZOTCUzMRhdyDQhSFZpxB3xR7Ugfsr/YN5MBvcT3Uiey6pud0BSjGWy+397Wa2ZX9NU
         oQhrsbZ+/C/yya+EjdnouL7WgiIh6oJtu2pl/rMOokaWD/QY3CBWW4XU514u1x2Cczh9
         ggmfi2s4MoBVO8Ea3yBhapzazSYMETAUp79YSe42Pn+iDD8PvLswiChOXPl9FtGZpyTR
         XSdx9tByY1JOaJkekCCe1fwOS1TcRu/puy7dSHqz4QjOYNwVrFluSBDnItZb+uE3OQh8
         xO5xmdIaqvKSwkDKE1oZpVXLHF9sbtUCr2RDPLiu1qbLYV9IAPB9At9HtQPUHtQHaQnP
         tWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756401244; x=1757006044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFf6Y+kZ5qDzWQbTvOGNXX5jgmWUdsOKV0pU+ZaksJQ=;
        b=oTByoKcaertxYvZoFxAWZijK0fR/F4iEpWexOZ8m/swC3RycuIMnR4O4UqeaciOfGP
         m2sC0BheSLZfSMJnY7OAyF1GIpBGwo267iXSOL3vb3vbdkT2kptRrxDL5FNYbQ3gD/To
         MTYrpi1y5Ffsyfe/jc96USHANENnUq4Bk2VVDcmzJQv7QbOUtxGQsIoDrJTbVGf68GGc
         7FkKDPO76/MoknYUX9wQpoEgD5/Ybc+BEx9SwLsTUEAlKsRqu2DXvGJhQhm2XmuJvxTd
         zU/E0NqBOJVXA4CID4rNCaOzN7K15KoKCgijjkLXJ4B/CS5Yf4SdzlZ+zd4fbJ7z37Bz
         Fd3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVfs4p5uct2pt0zWcOt74mMSSIztIN061APnz5492OxH9/2KEFBSRS3vzoPkW0snqarkyV9saA8Jrmh7tE=@vger.kernel.org, AJvYcCXdKY+C/VzYIDsIi5wRzyoeXqm2imxBZOLJMeYdsPEVjWkyT7n86rm7znk/n7owMHUpIYbHjp9c@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7EAl3sii1MfK0es/ffBbQRoRPOTZIhXiOXBH0RWgnl6iokWne
	wl/x/7whj9a272EIciDwn56BpoodeWp0AqK1CYZF8Pd0HxkwtmzbMlZA
X-Gm-Gg: ASbGncsWNphTQJMimA1GA/S9XKe4RkCNNTuhUOqrBUiBemTq9TpNAe2D/nedi2Kei6V
	NrBaXb94OWwq8qiMnGi1In07ZJH7YgfOPBcw10SZUiD950TDx+uQHxSbE/7IIrC0EkCygoUql6g
	UzJKE4a8KBmum8JANT4vezZYASU8t12OKKBS6P5OQEwNquHPA6giJ/5aWX51atFLff9+GbpmlxM
	BhMP8+jf8l9qBlACwb2zIXdFx+FdjNyixCXrmhpW9inaOyATzDIdLJjCDv6dC9Sqgaq29rLRYaq
	Q1v2aQt7NYjsRK5b9buMeQaY5r0P9Sw1aIHjrGvu6g8Ms+JJLt+hIyf3trz0zyPG7QtG1ckefhF
	u66iY2rq4VwMBnBPYhBPzduz/CrSqfOUkcR/4uoTlOt44l4O1jlKfV49z+0Bg8fH0F9v6fm8=
X-Google-Smtp-Source: AGHT+IGTAmc9IupZXzbfxYJAl1mMm5d8+llf0Cd4P4qOL3CGSr38IgDE3agkuRUZsGBinXlT0DgVBQ==
X-Received: by 2002:a17:903:3c2b:b0:242:bba6:fc85 with SMTP id d9443c01a7336-2462ef4a02fmr346186855ad.56.1756401243950;
        Thu, 28 Aug 2025 10:14:03 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327da8e71a8sm212401a91.15.2025.08.28.10.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 10:14:03 -0700 (PDT)
Date: Fri, 29 Aug 2025 01:13:58 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
	cl@gentwo.org, rientjes@google.com, roman.gushchin@linux.dev,
	glittao@gmail.com, jserv@ccns.ncku.edu.tw, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Joshua Hahn <joshua.hahnjy@gmail.com>, chuang@cs.nycu.edu.tw,
	cfmc.cs13@nycu.edu.tw, jhcheng.cs13@nycu.edu.tw,
	c.yuanhaur@wustl.edu
Subject: Re: [PATCH 1/2] mm/slub: Fix cmp_loc_by_count() to return 0 when
 counts are equal
Message-ID: <aLCOVoshch9phL5M@visitorckw-System-Product-Name>
References: <20250825013419.240278-1-visitorckw@gmail.com>
 <20250825013419.240278-2-visitorckw@gmail.com>
 <eb2fa38c-d963-4466-8702-e7017557e718@suse.cz>
 <aKyjaTUneWQgwsV5@visitorckw-System-Product-Name>
 <aK1n_t-V1AlN86JR@hyeyoo>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK1n_t-V1AlN86JR@hyeyoo>

On Tue, Aug 26, 2025 at 04:53:34PM +0900, Harry Yoo wrote:
> On Tue, Aug 26, 2025 at 01:54:49AM +0800, Kuan-Wei Chiu wrote:
> > Hi Vlastimil,
> > 
> > On Mon, Aug 25, 2025 at 07:28:17PM +0200, Vlastimil Babka wrote:
> > > On 8/25/25 03:34, Kuan-Wei Chiu wrote:
> > > > The comparison function cmp_loc_by_count() used for sorting stack trace
> > > > locations in debugfs currently returns -1 if a->count > b->count and 1
> > > > otherwise. This breaks the antisymmetry property required by sort(),
> > > > because when two counts are equal, both cmp(a, b) and cmp(b, a) return
> > > > 1.
> > > 
> > > Good catch.
> > > 
> > > > This can lead to undefined or incorrect ordering results. Fix it by
> > > 
> > > Wonder if it can really affect anything in practice other than swapping
> > > needlessly some records with an equal count?
> > > 
> > It could result in some elements being incorrectly ordered, similar to
> > what happened before in ACPI causing issues with s2idle [1][2]. But in
> > this case, the worst impact is just the display order not matching the
> > count, so it's not too critical.
> 
> Could you give an example where the previous cmp_loc_by_count() code
> produces an incorrectly sorted array?
> 
Sorry for the late reply.

I tried generating random arrays to find a concrete example where the
old cmp_loc_by_count() causes a wrong ordering, but I couldn't
reproduce one. So I would like to withdraw my earlier claim that it
definitely leads to incorrect results, since I cannot demonstrate a
failing case.

The complexity of the sort() implementation also makes it hard to
reason precisely whether such inputs exist.

That said, I still believe the patch should be merged, because sort()
only guarantees correct behavior if the comparison function satisfies
antisymmetry and transitivity. When those are violated, correctness
depends on implementation details, and future changes (e.g., switching
to a different sorting algorithm) could potentially break the ordering.

Regards,
Kuan-Wei

> > [1]: https://lore.kernel.org/lkml/70674dc7-5586-4183-8953-8095567e73df@gmail.com
> > [2]: https://lore.kernel.org/lkml/20240701205639.117194-1-visitorckw@gmail.com
> > 
> > > > explicitly returning 0 when the counts are equal, ensuring that the
> > > > comparison function follows the expected mathematical properties.
> > > 
> > > Agreed with the cmp_int() suggestion for a v2.
> > > 
> > I'll make that change in v2.
> 
> -- 
> Cheers,
> Harry / Hyeonggon

