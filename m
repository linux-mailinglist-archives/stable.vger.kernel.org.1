Return-Path: <stable+bounces-50475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D531B906742
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 10:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034851C228E0
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 08:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5225140E5E;
	Thu, 13 Jun 2024 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MV5pg5ma"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503E413E88B
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 08:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268118; cv=none; b=XQArRT+uOkulizqIYMVYaHoi1rF/qfpbqMJNoUmKKkStL+O5YsVCuHwxPwEylWrpjO8KrajhNz7iq7m4kJpO99uu/HpSbsWq2yD7qR5K0QTXWnHhkI8CZbLhI+4xmtUYRva975r1TI1TPSnOtzlaPd034DycIBlnC8aGZAum/Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268118; c=relaxed/simple;
	bh=90BPhjxVzkALdKOSEosBfGN4SwwLRfPVDP2EOAxkwVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdq4+kq7SAIRxzMRnGxBeg3x/ZqfyzwxJdlo4T/58QKGbyKK14kHUoi3qsLZxyJoqvjsLmHtE+YzxCqOUxmQlnJGy30VxaYvbnou/bFZYXN0vypdiYNQN0Zm9I8nUlvyeJ1F2vGqard2u2UU8iWAP+1xRnoo1qgut4PNAg/8Ysw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MV5pg5ma; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718268116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vWc82pHy204AzEDhPBKEPpo04KnSaVs2ShuVlzL9t+0=;
	b=MV5pg5maCruNKdMUNqjkbXIgt283mGhR/hHCxtVegjNYgzfopHnzMkLgAk9PNVmApY0ekS
	ckaOR3EQKEVTqtULo5LJe4Jokyy44ZXXaNor+uy0Fpo3fknNnQJKYMUySYe+lB25XYNkQB
	nqSl4Sx9G054cX50KusChqW7zgcxZhM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-bY8pvBWrOYGbtQ7EkwnCKA-1; Thu,
 13 Jun 2024 04:41:44 -0400
X-MC-Unique: bY8pvBWrOYGbtQ7EkwnCKA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A5B8C19560AF;
	Thu, 13 Jun 2024 08:41:41 +0000 (UTC)
Received: from localhost (unknown [10.72.112.37])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3E6E3000219;
	Thu, 13 Jun 2024 08:41:39 +0000 (UTC)
Date: Thu, 13 Jun 2024 16:41:34 +0800
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
Message-ID: <ZmqwvtZQwYLNYf+V@MiWiFi-R3L-srv>
References: <20240607023116.1720640-1-zhaoyang.huang@unisoc.com>
 <CAGWkznEODMbDngM3toQFo-bgkezEpmXf_qE=SpuYcqsjEJk1DQ@mail.gmail.com>
 <CAGWkznE-HcYBia2HDcHt6trM9oeJ2x6KdyFzR3Jd_-L5HyPxSA@mail.gmail.com>
 <ZmiUgPDjzI32Cqr9@pc636>
 <CAGWkznGnaV8Tz0XrgaVWEVG0ug7dp3w23ygKKmq8SPu_AMBhoA@mail.gmail.com>
 <ZmmGHhUDk5PqSHPB@pc636>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmmGHhUDk5PqSHPB@pc636>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 06/12/24 at 01:27pm, Uladzislau Rezki wrote:
> On Wed, Jun 12, 2024 at 10:00:14AM +0800, Zhaoyang Huang wrote:
> > On Wed, Jun 12, 2024 at 2:16 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> > >
> > > >
> > > > Sorry to bother you again. Are there any other comments or new patch
> > > > on this which block some test cases of ANDROID that only accept ACKed
> > > > one on its tree.
> > > >
> > > I have just returned from vacation. Give me some time to review your
> > > patch. Meanwhile, do you have a reproducer? So i would like to see how
> > > i can trigger an issue that is in question.
> > This bug arises from an system wide android test which has been
> > reported by many vendors. Keep mount/unmount an erofs partition is
> > supposed to be a simple reproducer. IMO, the logic defect is obvious
> > enough to be found by code review.
> >
> Baoquan, any objection about this v4?
> 
> Your proposal about inserting a new vmap-block based on it belongs
> to, i.e. not per-this-cpu, should fix an issue. The problem is that
> such way does __not__ pre-load a current CPU what is not good.

With my understand, when we start handling to insert vb to vbq->xa and
vbq->free, the vmap_area allocation has been done, it doesn't impact the
CPU preloading when adding it into which CPU's vbq->free, does it? 

Not sure if I miss anything about the CPU preloading.


