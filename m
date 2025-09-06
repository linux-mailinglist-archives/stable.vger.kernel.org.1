Return-Path: <stable+bounces-177972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D69D9B47623
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 20:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92771C20068
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 18:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7518527FD6B;
	Sat,  6 Sep 2025 18:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ja/POPek"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F4227FB21
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 18:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757183782; cv=none; b=S3zAJE1JYJ7GUB5VlXsPPUFBPZ8tJqi/JdH5mOZpBm4qvSRlgGaSgSaepXfq+DdOQke3rnUeMdQjy9PHSFSM3j0KJvTE2SpPtyqrD2ZxoAZE9UzY6UtJydkkkGbpdEOs1CIDVsRcIFWwnQXZKGBQ5JuzLnMCJ8P580sB+w4X6yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757183782; c=relaxed/simple;
	bh=xzoCRkUUs4/ZjBRIS10Og6kqcpPCqmYrhKSIGAEVkMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LG7a9MMgj2KdNBc+BT40OKue9xI56/Jt2urITBsC95zt1SiAHRmY9vNL6N1w6i9HAd+yWCjarzXQvStVZFSsK0xAuQbt2I/Jpk/JhITdDa+tK5Erxag3diV5/IwGw/QxHgMZja09yR01kQ0u1zrDt4b5gmzgVFR7wd5UeCJ/HUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ja/POPek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FDCC4CEE7;
	Sat,  6 Sep 2025 18:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757183782;
	bh=xzoCRkUUs4/ZjBRIS10Og6kqcpPCqmYrhKSIGAEVkMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ja/POPekoZw1JTc8jm4bfMQ7pBjixgqEeq+p3SGqn9pj8a71RKq8GU7Td1XWBSt8o
	 xKyuM5KEMhFsMJ/asrAJUoRFSl/9xbtbEkha2jGb0o5wVLwWiRwYiQqIbrEoFUi9ni
	 6ve08iGa2Z/231NHL+PrkQ6sl4P6N1GsfXzlRDVU=
Date: Sat, 6 Sep 2025 20:36:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	stable@vger.kernel.org, vegard.nossum@oracle.com,
	syzbot+54cbbfb4db9145d26fc2@syzkaller.appspotmail.com
Subject: Re: [PATCH 6.12.y 11/15] io_uring/msg_ring: ensure io_kiocb freeing
 is deferred for RCU
Message-ID: <2025090622-crispy-germproof-3d11@gregkh>
References: <20250905110406.3021567-1-harshit.m.mogalapalli@oracle.com>
 <20250905110406.3021567-12-harshit.m.mogalapalli@oracle.com>
 <f43fe976-4ef5-4dea-a2d0-336456a4deae@kernel.dk>
 <96857683-167a-4ba8-ad26-564e5dcae79b@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96857683-167a-4ba8-ad26-564e5dcae79b@kernel.dk>

On Fri, Sep 05, 2025 at 07:23:00PM -0600, Jens Axboe wrote:
> On 9/5/25 1:58 PM, Jens Axboe wrote:
> > On 9/5/25 5:04 AM, Harshit Mogalapalli wrote:
> >> diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
> >> index 5ce332fc6ff5..3b27d9bcf298 100644
> >> --- a/include/linux/io_uring_types.h
> >> +++ b/include/linux/io_uring_types.h
> >> @@ -648,6 +648,8 @@ struct io_kiocb {
> >>  	struct io_task_work		io_task_work;
> >>  	/* for polled requests, i.e. IORING_OP_POLL_ADD and async armed poll */
> >>  	struct hlist_node		hash_node;
> >> +	/* for private io_kiocb freeing */
> >> +	struct rcu_head		rcu_head;
> >>  	/* internal polling, see IORING_FEAT_FAST_POLL */
> >>  	struct async_poll		*apoll;
> >>  	/* opcode allocated if it needs to store data for async defer */
> > 
> > This should go into a union with hash_node, rather than bloat the
> > struct. That's how it was done upstream, not sure why this one is
> > different?
> 
> Here's a test variant with that sorted. Greg, I never got a FAILED email
> on this one, as far as I can tell. When a patch is marked with CC:
> stable@vger.kernel.org and the origin of the bug clearly marked with
> Fixes, I'm expecting to have a 100% reliable notification if it fails to
> apply. If not, I just kind of assume patches flow into stable.
> 
> Was this missed on my side, or was it on the stable side? If the latter,
> how did that happen? I always ensure that stable has what it needs and
> play nice on my side, but if misses like this can happen with the
> tooling, that makes me a bit nervous.
> 

This looks like a failure on my side, sorry.  I don't see any FAILED
email that went out for this anywhere, so I messed up.

sorry about that, and Harshit, thanks for noticing it.

greg k-h

