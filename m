Return-Path: <stable+bounces-69335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EE2954E86
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 18:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39EC81F21716
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 16:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC661C0DC7;
	Fri, 16 Aug 2024 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NBu3hWz6"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A164B1BE85D
	for <stable@vger.kernel.org>; Fri, 16 Aug 2024 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723824696; cv=none; b=GqQx3H2BwunrqwAwyHpA+2BXxIBKINvHKQxJb/EuBtYuMIjORpCXrXqAYT5eOvtZwynjcIzpypIqCRhHBCo5hGbd9jHXHs7ouQQHzDZtG5i8se14ULMs/R31nnVjANZmX3C3ztR+QXxiMmsOAM7wE2hTDWgGp+yoxDFsee+II4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723824696; c=relaxed/simple;
	bh=+UCIpa1KVCoF5jmVvofQJCLzOF2skYmjgQkSMCwnH14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLIMzJ70iNU07aSLgjtEL+mMYXV4KN1s4kM6s96ZaWIRgHVgVcfGx3M8MU1d19xwSLhXWz9kTG2Jx5z7XZOd4AcQpMBIU/0szd+jETMhep19W8mi3JrizjCJj2drTVa2CUxey2U55enjM0/pnLAIVpltwHvEWilwIAWlucYyUZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NBu3hWz6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723824693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AxGBqUeMb4W96mBC2jM2m3uE9NqvD77N4xwdXzOBol8=;
	b=NBu3hWz65k/YEAowWL+FdRqrF5uZOIWTQ03RZL3Hr1tY+864525ngDkAzd/TgiJZ/3Elpx
	qw1GVU7eTLUmSor3ZkwPLo4Rf4utjzzh/ULPGqCdqW8k4E2QgAE3YNUp40TvFOKzxrpoY+
	L+7FyhbRD5u3PAqlPgBLG9cWPCHO1I0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-VUTFbWR6NHSwk2ou4Gbppw-1; Fri,
 16 Aug 2024 12:11:29 -0400
X-MC-Unique: VUTFbWR6NHSwk2ou4Gbppw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9CBBF1955D56;
	Fri, 16 Aug 2024 16:11:26 +0000 (UTC)
Received: from localhost (unknown [10.72.112.51])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5BFFA19560A3;
	Fri, 16 Aug 2024 16:11:23 +0000 (UTC)
Date: Sat, 17 Aug 2024 00:11:19 +0800
From: Baoquan He <bhe@redhat.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Hailong Liu <hailong.liu@oppo.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>, Barry Song <21cnbao@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Tangquan Zheng <zhengtangquan@oppo.com>, stable@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v1] mm/vmalloc: fix page mapping if
 vm_area_alloc_pages() with high order fallback to order 0
Message-ID: <Zr96JyrzXuQXT2BG@MiWiFi-R3L-srv>
References: <20240808122019.3361-1-hailong.liu@oppo.com>
 <CAGsJ_4z4+CCDoPR7+dPEhemBQN60Cj84rCeqRY7-xvWapY4LGg@mail.gmail.com>
 <ZrXiUvj_ZPTc0yRk@tiehlicka>
 <ZrXkVhEg1B0yF5_Q@pc636>
 <20240815220709.47f66f200fd0a072777cc348@linux-foundation.org>
 <20240816091232.fsliktqgza5o5x6t@oppo.com>
 <Zr8mQbc3ETdeOMIK@pc636>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr8mQbc3ETdeOMIK@pc636>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 08/16/24 at 12:13pm, Uladzislau Rezki wrote:
> On Fri, Aug 16, 2024 at 05:12:32PM +0800, Hailong Liu wrote:
> > On Thu, 15. Aug 22:07, Andrew Morton wrote:
> > > On Fri, 9 Aug 2024 11:41:42 +0200 Uladzislau Rezki <urezki@gmail.com> wrote:
> > >
> > > > > > Acked-by: Barry Song <baohua@kernel.org>
> > > > > >
> > > > > > because we already have a fallback here:
> > > > > >
> > > > > > void *__vmalloc_node_range_noprof :
> > > > > >
> > > > > > fail:
> > > > > >         if (shift > PAGE_SHIFT) {
> > > > > >                 shift = PAGE_SHIFT;
> > > > > >                 align = real_align;
> > > > > >                 size = real_size;
> > > > > >                 goto again;
> > > > > >         }
> > > > >
> > > > > This really deserves a comment because this is not really clear at all.
> > > > > The code is also fragile and it would benefit from some re-org.
> > > > >
> > > > > Thanks for the fix.
> > > > >
> > > > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > > >
> > > > I agree. This is only clear for people who know the code. A "fallback"
> > > > to order-0 should be commented.
> > >
> > > It's been a week.  Could someone please propose a fixup patch to add
> > > this comment?
> > 
> > Hi Andrew:
> > 
> > Do you mean that I need to send a v2 patch with the the comments included?
> > 
> It is better to post v2.
> 
> But before, could you please comment on:
> 
> in case of order-0, bulk path may easily fail and fallback to the single
> page allocator. If an request is marked as NO_FAIL, i am talking about
> order-0 request, your change breaks GFP_NOFAIL for !order.

In case order-0, bulk_gfp masks off __GFP_NOFAIL, but alloc_gfp doesn't.
So alloc_gfp has __GFP_NOFAIL in fallback, it won't be failed by
alloc_pages().


