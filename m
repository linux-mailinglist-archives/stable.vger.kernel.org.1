Return-Path: <stable+bounces-177973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86783B4762A
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 20:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CEB8A423AF
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 18:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41AD27BF85;
	Sat,  6 Sep 2025 18:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="ZFveB0o3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TEgnNUAP"
X-Original-To: stable@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CD41F4CAF
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 18:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757183857; cv=none; b=Jxcx/U9nBa2WqHt+2kH3KXmbsZDEU7Td4+/WV53xWeV0NvTBODJ1Iyoho1z0Ox5Ps5ovHEcHxh+0xSJiURWj7zAuzKR0O9vI+X24eg+kHKZL+RPepSNaQd3IsK0Qqo2v1cXM+YhQ9W7OpUutrCet6ovOZR0V2hGU6JbLH6DionI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757183857; c=relaxed/simple;
	bh=6fbcV2GxPzbAzWoxLMNgEkwVW4jRf1UCiSc+GZ9tqvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAoY7t94j0yjLVxu5uJ1skieiiE1lJtOmYlG4yqkSwwL7t324EMst8AqVacdHSC4DwE3u617qTxDcrvBOp5IYS4q7diRmFVIF05o95hqXccntld3SgtpxWGh+6Fr/757/ImozygLxpN0HpR1esJdwVHYRRl8k+9Dui2vNq0ImQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=ZFveB0o3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TEgnNUAP; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id D0FC01D00226;
	Sat,  6 Sep 2025 14:37:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sat, 06 Sep 2025 14:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757183852; x=1757270252; bh=sAuOcKfJzb
	ZgMj0ltm/N/UkH8l3N5gjmJcg5CA6fJYo=; b=ZFveB0o34gyLjwdRwgsy943Az/
	fFCV06PcyOTpN6akZXhR5Se9hQabM+FaorXPcdRYe1QjODv9bTIRCqnPWR438OXp
	hAryBDMX9Ty3hz9IqqQlzjJN6hgFwELa0+cNNz1M1Y5BlVo4jXrg4A4wVBKB8mX/
	43rC6uKBqb2MnPZrEicTnkCeov8/OYJfpmpDHuRWaXtKbJ4SdDYvU9VUR5635ap/
	yReUDI4T/b7wskwpJIek4dAQ3x7vsjYHeMoDzC5qt4Js9C6NRjZPqU6wgffD7yEg
	gfb9M9PV8DfWIpG/FoQKaJi0IfdlMbShubG+LAQGr+3P5Z0faYRHT1QDB1Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757183852; x=1757270252; bh=sAuOcKfJzbZgMj0ltm/N/UkH8l3N5gjmJcg
	5CA6fJYo=; b=TEgnNUAPgqtCnKmh+MRpitSc9je26TgHpJSMXDVi2/9oUD2F9YO
	k4+SibsRvMsYrxwznSCaCstPtveH0/zbuWHqDzUT3eAqup/s/hd594LPPgPosdbx
	dYEBfIODATtU6XNvDGD2q+m1068wS5gj20yW5wuQapEwJqgDiqz1h7EHtRLCNi1I
	FBqsZnDWZzGMVcx+Ke/ql/WMbjbU9NCbfkw1k1TonFsgleSoNmBqIoJUqCGhMxfF
	ZgOEAsOcBAzGQDaZDdjgZb4ZeIcR99w/bwg2Ba2mhpH+NXV18Ozr9lfZYMdvtao+
	HVfdU8EBF9fF+xpEZ9V75zvl0MAekijz5wg==
X-ME-Sender: <xms:bH-8aEEqttElcpdz1bvAw-xMCOKvUN7SauD0kYXgFoGKjB3LtIsekw>
    <xme:bH-8aNAl7c_P9jhOi4kJL-mG8FOMbbNWfNBI0oMAbJxp1Pcj_wB38FGn60mevmkrL
    IVJMKP3_nj8rA>
X-ME-Received: <xmr:bH-8aJx_KjZunahbpMsXDkRFfFxU8feO01TF35HuOMKhwDm9hWrAx0QEBfXJCTFGetPVk5U-B9IIIdH2EBAH5rvvNs8j-3JsxNnkgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcumffj
    uceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvvedvle
    ejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtg
    homhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehhrghrshhhihhtrdhmrdhmohhgrghlrghprghllhhisehorhgrtghlvgdrtghomhdprh
    gtphhtthhopegrgigsohgvsehkvghrnhgvlhdrughkpdhrtghpthhtohepshhtrggslhgv
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhgvghgrrhgurdhnohhssh
    humhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepshihiigsohhtodehgegtsggsfhgs
    gegusgeludegheguvdeifhgtvdesshihiihkrghllhgvrhdrrghpphhsphhothhmrghilh
    drtghomh
X-ME-Proxy: <xmx:bH-8aB7B3CFAm-OtRVNuZb4WwiPNW9xMqgU31qoalLNg1y96J2HBeA>
    <xmx:bH-8aKwADMOfyN9qtPRl2cISwpuQQdWe8o1gWu-6aBFqC81JH7SBvA>
    <xmx:bH-8aFfsEWu0Gle7JzdQ7uQ1p7uSFSz5owlmKc0Ra9I4y9C7Xmo0vg>
    <xmx:bH-8aPA1XcBBjBoQVtZJHFtkBTQ14noNMGKB6C_YZFpvj66SKuGC6A>
    <xmx:bH-8aJIskuxx1VrSU6euWjx-wb9vg5xdzsobybQDt40Iaaik4kSfU4wJ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Sep 2025 14:37:31 -0400 (EDT)
Date: Sat, 6 Sep 2025 20:37:30 +0200
From: Greg KH <greg@kroah.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, stable@vger.kernel.org,
	vegard.nossum@oracle.com,
	syzbot+54cbbfb4db9145d26fc2@syzkaller.appspotmail.com
Subject: Re: [PATCH 6.12.y 11/15] io_uring/msg_ring: ensure io_kiocb freeing
 is deferred for RCU
Message-ID: <2025090604-sectional-preheated-e5c7@gregkh>
References: <20250905110406.3021567-1-harshit.m.mogalapalli@oracle.com>
 <20250905110406.3021567-12-harshit.m.mogalapalli@oracle.com>
 <f43fe976-4ef5-4dea-a2d0-336456a4deae@kernel.dk>
 <8a53f86b-9d5a-47f9-a4f0-74a9c5c0fc78@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a53f86b-9d5a-47f9-a4f0-74a9c5c0fc78@oracle.com>

On Sat, Sep 06, 2025 at 07:47:00AM +0530, Harshit Mogalapalli wrote:
> Hi Jens,
> 
> 
> On 06/09/25 01:28, Jens Axboe wrote:
> > On 9/5/25 5:04 AM, Harshit Mogalapalli wrote:
> > > diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
> > > index 5ce332fc6ff5..3b27d9bcf298 100644
> > > --- a/include/linux/io_uring_types.h
> > > +++ b/include/linux/io_uring_types.h
> > > @@ -648,6 +648,8 @@ struct io_kiocb {
> > >   	struct io_task_work		io_task_work;
> > >   	/* for polled requests, i.e. IORING_OP_POLL_ADD and async armed poll */
> > >   	struct hlist_node		hash_node;
> > > +	/* for private io_kiocb freeing */
> > > +	struct rcu_head		rcu_head;
> > >   	/* internal polling, see IORING_FEAT_FAST_POLL */
> > >   	struct async_poll		*apoll;
> > >   	/* opcode allocated if it needs to store data for async defer */
> > 
> 
> Thanks a lot for looking into this one.
> 
> > This should go into a union with hash_node, rather than bloat the
> > struct. That's how it was done upstream, not sure why this one is
> > different?
> > 
> 
> We don't have commit: 01ee194d1aba ("io_uring: add support for hybrid
> IOPOLL") which moves hlist_node	to a union along with iopoll_start,
> 
>         struct io_task_work             io_task_work;
> -       /* for polled requests, i.e. IORING_OP_POLL_ADD and async armed poll
> */
> -       struct hlist_node               hash_node;
> +       union {
> +               /*
> +                * for polled requests, i.e. IORING_OP_POLL_ADD and async
> armed
> +                * poll
> +                */
> +               struct hlist_node       hash_node;
> +               /* For IOPOLL setup queues, with hybrid polling */
> +               u64                     iopoll_start;
> +       };
> 
> 
> given that we don't need the above commit, and partly because I didn't
> realize about the bloat benefit we would get I added rcu_head without a
> union. Thanks a lot for correctly. I will check the size bloat next time
> when I run into this situation.
> 
> Thank you very much for correcting this and providing a backport.
> 
> Greg/Sasha: Should I send a v2 of this series with my backport swapped with
> the one from Jens ?

I just took Jens's patch.  So I'll drop your patch from this series too.

thanks,

greg k-h

