Return-Path: <stable+bounces-52121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CEB9080A5
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 03:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F552843A8
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 01:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393571A28C;
	Fri, 14 Jun 2024 01:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GxQjnUtq"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FAB29A2
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 01:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718328778; cv=none; b=vEW/w4KIiNabkeDCtqHhDZrtfT3kEB8V3TgSbL/XG3/B8XYEx1YH8pIYkaipPBGUvaYpyYGIULcPOmiDbmHn4Gj+ui/5VDHTbwQLF4ikO4gfxEjlHfIkH1sYhpeesU1Y6eWswp/dUIZJx3NeSLASoKfMBFp3Ic4CxfnO7vezQK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718328778; c=relaxed/simple;
	bh=Fq67c7NLEOa5qBfZ6f3hPMTOPg+FlCpN87WN/bAjhW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6ulTHje6GzLiMS3NEh0Anq200RUWB0DfJQ5KBnLKdjbJObiFGRLEveq6j33E/1wIeSV2C5e7Z23VhYTtxZxEzN1NxubXip8KuPrwGc6mN5CHqcpVTqm4wv+y5irqCpuTjqJtFP0Yba9Qkk3NvmdTARkPtcE9DuqafT8xtIvdXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GxQjnUtq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718328775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MomHJJ0WTXAcFGOMzH8XSlE6O618dhh1qz/zUs8NtfM=;
	b=GxQjnUtqyyPPpaGt9suY5U6u+ogx4B97oGyQxomQp+V3d5nudPLE8ooowXWIA/sWF0UIJw
	GmyFQUqBjgx5oVKXkL/pXuJrv/ZYSpPL6ph8/WuPq6R7IazFpo3yRlzuHVe2gos+p2/kTC
	XV94nbqw6jz9rmB4Gqad8sydRJmRZZU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-bUZTF0aLM8u8t2Wkb7qMSw-1; Thu,
 13 Jun 2024 21:32:50 -0400
X-MC-Unique: bUZTF0aLM8u8t2Wkb7qMSw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A320195608C;
	Fri, 14 Jun 2024 01:32:48 +0000 (UTC)
Received: from localhost (unknown [10.72.112.37])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E6FC3000219;
	Fri, 14 Jun 2024 01:32:45 +0000 (UTC)
Date: Fri, 14 Jun 2024 09:32:41 +0800
From: Baoquan He <bhe@redhat.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>,
	"zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	hailong liu <hailong.liu@oppo.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	steve.kang@unisoc.com
Subject: Re: [Resend PATCHv4 1/1] mm: fix incorrect vbq reference in
 purge_fragmented_block
Message-ID: <ZmuduRrf3hLXWBkT@MiWiFi-R3L-srv>
References: <20240607023116.1720640-1-zhaoyang.huang@unisoc.com>
 <CAGWkznEODMbDngM3toQFo-bgkezEpmXf_qE=SpuYcqsjEJk1DQ@mail.gmail.com>
 <CAGWkznE-HcYBia2HDcHt6trM9oeJ2x6KdyFzR3Jd_-L5HyPxSA@mail.gmail.com>
 <ZmiUgPDjzI32Cqr9@pc636>
 <CAGWkznGnaV8Tz0XrgaVWEVG0ug7dp3w23ygKKmq8SPu_AMBhoA@mail.gmail.com>
 <ZmmGHhUDk5PqSHPB@pc636>
 <ZmqwvtZQwYLNYf+V@MiWiFi-R3L-srv>
 <ZmrXwABpPPoK0bIp@pc636>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmrXwABpPPoK0bIp@pc636>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 06/13/24 at 01:28pm, Uladzislau Rezki wrote:
> On Thu, Jun 13, 2024 at 04:41:34PM +0800, Baoquan He wrote:
> > On 06/12/24 at 01:27pm, Uladzislau Rezki wrote:
> > > On Wed, Jun 12, 2024 at 10:00:14AM +0800, Zhaoyang Huang wrote:
> > > > On Wed, Jun 12, 2024 at 2:16 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > > >
> > > > > >
> > > > > > Sorry to bother you again. Are there any other comments or new patch
> > > > > > on this which block some test cases of ANDROID that only accept ACKed
> > > > > > one on its tree.
> > > > > >
> > > > > I have just returned from vacation. Give me some time to review your
> > > > > patch. Meanwhile, do you have a reproducer? So i would like to see how
> > > > > i can trigger an issue that is in question.
> > > > This bug arises from an system wide android test which has been
> > > > reported by many vendors. Keep mount/unmount an erofs partition is
> > > > supposed to be a simple reproducer. IMO, the logic defect is obvious
> > > > enough to be found by code review.
> > > >
> > > Baoquan, any objection about this v4?
> > > 
> > > Your proposal about inserting a new vmap-block based on it belongs
> > > to, i.e. not per-this-cpu, should fix an issue. The problem is that
> > > such way does __not__ pre-load a current CPU what is not good.
> > 
> > With my understand, when we start handling to insert vb to vbq->xa and
> > vbq->free, the vmap_area allocation has been done, it doesn't impact the
> > CPU preloading when adding it into which CPU's vbq->free, does it? 
> > 
> > Not sure if I miss anything about the CPU preloading.
> > 
> Like explained below in this email-thread:
> 
> vb_alloc() inserts a new block _not_ on this CPU. This CPU tries to
> allocate one more time and its free_list is empty(because on a prev.
> step a block has been inserted into another CPU-block-queue), thus
> it allocates a new block one more time and which is inserted most
> likely on a next zone/CPU. And so on.

Thanks for detailed explanation, got it now.

It's a pity we can't unify the xa and the list into one vbq structure
based on one principal.

> 
> See:
> 
> <snip vb_alloc>
> ...
>         rcu_read_lock();
> 	vbq = raw_cpu_ptr(&vmap_block_queue); <- Here it is correctly accessing this CPU 
> 	list_for_each_entry_rcu(vb, &vbq->free, free_list) {
> 		unsigned long pages_off;
> ...
> <snip vb_alloc>
> 
> <snip new_vmap_block>
> ...
>        vbq = addr_to_vbq(va->va_start); <- Here we insert based on hashing, i.e. not to this CPU-block-queue
>        spin_lock(&vbq->lock);
>        list_add_tail_rcu(&vb->free_list, &vbq->free);
>        spin_unlock(&vbq->lock);
> ...
> <snip new_vmap_block>
> 
> Thanks!
> 
> --
> Uladzislau Rezki
> 


