Return-Path: <stable+bounces-52122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 627519080E4
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 03:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AC6F1F21078
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 01:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE761822F9;
	Fri, 14 Jun 2024 01:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8AXkjFq"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC48C1822D0
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 01:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718329464; cv=none; b=LGYNjE0liCKnUaddT6nf0n7r63Key+AWcmRiwVNyEBDIRiC/C1IhhSbFPXngP5r6ocsq152QY4/GbffHkCqbMuE84nRYpkqU9y2cKtz8dEvWJHu/WI7vFA/Xf3ucUgMFVMQFNxCoZ5Nnbr4c/0P4X0bkRAgy1tCvBxUvFBhayoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718329464; c=relaxed/simple;
	bh=+RCWV73DUVEVHGiyqZFoF+gZrjMk5TB4BjKep8k6Pxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuQy4prmRqbQMpbELxIsFRwBCwmr/Jxq93XekLZ75YqbRQf0DkLCJ/bNAbEdbvNRltqiglsZc9KuICpNtNYvxjA9HtWrspMoZIPpccG56VZIrQYgsgGSY9+cOcQ1suA15xjaLt2D/O+HRvXYB8TuuP0FXuJPuAJIa/o4orI9v/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f8AXkjFq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718329461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F9lKE8hYmf6g8IWvc3VrycK3qfVps8kbUy/YMAHDU0c=;
	b=f8AXkjFqTk2JQ+azXCIqA9ehTWs1X2oMAfq5g4S2KnkBiBJt4fwnwSWqPkPTf0dvjanbOp
	q6UhOcGYj2jqEUAysaqZKETcTJSqf8sfdG9ydEg5nz++uJzjL7I0TQ3SJ1k5sfUnh2IAbX
	va67fBCD9xsDL5bUlBhDM9JXT1shmQ8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-aN38hECoPl2QwgrDPMIVkw-1; Thu,
 13 Jun 2024 21:44:16 -0400
X-MC-Unique: aN38hECoPl2QwgrDPMIVkw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 011231956089;
	Fri, 14 Jun 2024 01:44:14 +0000 (UTC)
Received: from localhost (unknown [10.72.112.37])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8F5B19560AA;
	Fri, 14 Jun 2024 01:44:10 +0000 (UTC)
Date: Fri, 14 Jun 2024 09:44:06 +0800
From: Baoquan He <bhe@redhat.com>
To: hailong liu <hailong.liu@oppo.com>,
	Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	"zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	steve.kang@unisoc.com
Subject: Re: [Resend PATCHv4 1/1] mm: fix incorrect vbq reference in
 purge_fragmented_block
Message-ID: <ZmugZp3Qe5nB6NB1@MiWiFi-R3L-srv>
References: <20240607023116.1720640-1-zhaoyang.huang@unisoc.com>
 <CAGWkznEODMbDngM3toQFo-bgkezEpmXf_qE=SpuYcqsjEJk1DQ@mail.gmail.com>
 <CAGWkznE-HcYBia2HDcHt6trM9oeJ2x6KdyFzR3Jd_-L5HyPxSA@mail.gmail.com>
 <ZmiUgPDjzI32Cqr9@pc636>
 <CAGWkznGnaV8Tz0XrgaVWEVG0ug7dp3w23ygKKmq8SPu_AMBhoA@mail.gmail.com>
 <ZmmGHhUDk5PqSHPB@pc636>
 <ZmqwvtZQwYLNYf+V@MiWiFi-R3L-srv>
 <20240613091106.sfgtmoto6u4tslq6@oppo.com>
 <CAGWkznEJgUZ6bsuhb0Q+3-Jny+AGxPpaBnSmJJqoWz-mgU43sQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGWkznEJgUZ6bsuhb0Q+3-Jny+AGxPpaBnSmJJqoWz-mgU43sQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 06/13/24 at 05:23pm, Zhaoyang Huang wrote:
> On Thu, Jun 13, 2024 at 5:11 PM hailong liu <hailong.liu@oppo.com> wrote:
> >
> > On Thu, 13. Jun 16:41, Baoquan He wrote:
> > > On 06/12/24 at 01:27pm, Uladzislau Rezki wrote:
> > > > On Wed, Jun 12, 2024 at 10:00:14AM +0800, Zhaoyang Huang wrote:
> > > > > On Wed, Jun 12, 2024 at 2:16 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > > > >
> > > > > > >
> > > > > > > Sorry to bother you again. Are there any other comments or new patch
> > > > > > > on this which block some test cases of ANDROID that only accept ACKed
> > > > > > > one on its tree.
> > > > > > >
> > > > > > I have just returned from vacation. Give me some time to review your
> > > > > > patch. Meanwhile, do you have a reproducer? So i would like to see how
> > > > > > i can trigger an issue that is in question.
> > > > > This bug arises from an system wide android test which has been
> > > > > reported by many vendors. Keep mount/unmount an erofs partition is
> > > > > supposed to be a simple reproducer. IMO, the logic defect is obvious
> > > > > enough to be found by code review.
> > > > >
> > > > Baoquan, any objection about this v4?
> > > >
> > > > Your proposal about inserting a new vmap-block based on it belongs
> > > > to, i.e. not per-this-cpu, should fix an issue. The problem is that
> > > > such way does __not__ pre-load a current CPU what is not good.
> > >
> > > With my understand, when we start handling to insert vb to vbq->xa and
> > > vbq->free, the vmap_area allocation has been done, it doesn't impact the
> > > CPU preloading when adding it into which CPU's vbq->free, does it?
> > >
> > > Not sure if I miss anything about the CPU preloading.
> > >
> > >
> >
> > IIUC, if vb put by hashing funcation. and the following scenario may occur:

Thanks for the details, it's truly a problem as you said.

> >
> > A kthread limit on CPU_x and continuously calls vm_map_ram()
> > The 1 call vm_map_ram(): no vb in cpu_x->free, so
> > CPU_0->vb
> > CPU_1
> > ...
> > CPU_x
> >
> > The 2 call vm_map_ram(): no vb in cpu_x->free, so
> > CPU_0->vb
> > CPU_1->vb
> > ...
> > CPU_x
> Yes, this could make the per_cpu vbq meaningless and the VMALLOC area
> be abnormally consumed(like 8KB in 4MB for each allocation)
> >
> > --
> > help you, help me,
> > Hailong.
> 


