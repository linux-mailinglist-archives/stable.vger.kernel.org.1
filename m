Return-Path: <stable+bounces-232852-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIFzCvV2zWnYdgYAu9opvQ
	(envelope-from <stable+bounces-232852-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 21:50:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BA637FF6A
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 21:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EFB730125C3
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 19:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B76122156C;
	Wed,  1 Apr 2026 19:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="DMrqeHPG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SX6PzwlM"
X-Original-To: stable@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2344319852;
	Wed,  1 Apr 2026 19:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775072976; cv=none; b=MJTOG5xBUokbvVh4HconXp3YX01kDK/hNZ/04v4rnh1IjikR6Wa93eu/+PKxRT147ZEhdOZ34R2WBys9odnlSS9Xu8yZ0b4eTeACSegdzeff9YYYOL9BgGKD3VANZA+QnkmP+emxAsPALuynjPEzgU6sjCqdRDuebaKcKsB6GNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775072976; c=relaxed/simple;
	bh=AW6IAphtnMrKqb8JFeOVWdb7kazsk1J3Ae7YYMFGaiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MkPHBK69+q5wBT+HljVXi0myDZlnw/j50gU0YUA+tqAgmw9XTiEbcfoJC5QguXR+mWOpp6Ko/nIHjgAiUz2ZWaHl95Goxz+WnCoOUl2TiWIwHD/nH7VAlNCfuOFLhN49BSQJGgo+NU5BGAiNZb4vnX/A2EWAPh/O9ozl3XoRDwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=DMrqeHPG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SX6PzwlM; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D4FCCEC0238;
	Wed,  1 Apr 2026 15:49:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 01 Apr 2026 15:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1775072973;
	 x=1775159373; bh=ryVshn7gwERhWO/KEcxICuFnEAk7VQ3gPl+wdKnz7nU=; b=
	DMrqeHPG6WyFLLcSQ9zxUy7rbpTFUw4YH4+5ObS6uVK/puUHepFNJ52K4y0mQhoL
	MVi3CnRS24EKZ43f3MlCEqaDQrp5u/NmnIunE1BGLBRDKsTxR73tdHRmz6lrwD6M
	bcjKHgwc4S0STq69NuFHCUMNRr/wMP3gRatt888m9WXw5Cr4XCtv7++t2NhdyBpq
	mhbVEJCSzkeMap0HKabwd2C0XCOVaVzWush/oGuaGnPnY+JZU2rJ03ijsAX02GHp
	N4ZOvioMiBZwD2/ce32As1CtQVIWxKMJKSj3Glod5B7vzxYN4MAYS0VMUX67VnLH
	19dnRrMxa1iNi8w1pUrw7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775072973; x=
	1775159373; bh=ryVshn7gwERhWO/KEcxICuFnEAk7VQ3gPl+wdKnz7nU=; b=S
	X6PzwlM2sGR21Dr/Aoky3Luv97RLa+s76YhCjvvR4dUPY8yaWbbGyBgV/TsguOL1
	ZMwWcO2HiThbYwMQcDtkkXrrnGbifQsah1v2GRKuo41t074orR43+Ih5vrUA0Ijh
	QFBnXIbjZgUi1Ldve+klc0MO5yBb6HP21q4u93tuSaaQ7TFyM6j9rtAP89MCP2wn
	BLi/cbqJrRnQLaJq1SvlRHWhB9eW3ooQe7/VRaAuEEWGy/VK0eDgJVqumloPmDHy
	A+gVCbgjVxlj1aYkvFnj/ehH8FYsXjSKCPdnLK7rjipdUxfG3gU7/TNK2ocZU/Wx
	xeG+sY7wt6Drm3VII3LsA==
X-ME-Sender: <xms:zXbNacfvtYAGjseanQwBCuoxPfu4YQbCyFVKsLRQeZUKGHdWYWuDmg>
    <xme:zXbNafsL-WX65-v2UHhykh0TpdF_qdZVnsKR0_QdTCnMHUzJno6F91_ChnLsFtNvF
    Egh4SPDdWdD46xjnbQbcgAJX7rvuVpvtq8NboaCGZ3FJKCJ6Gg2>
X-ME-Received: <xmr:zXbNadlYRxa4XfB9oe404QCjIRIL43ZqF-U61EO_0G6MpkDy3iqXckn5SMB2tvVP5Czj43TfdymtaRN1Hy0md4infF4Mp6pFhPVJlaoRE19G87sFgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegtddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhguucfu
    tghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrghtth
    gvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueevudeu
    geenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvg
    hrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomh
    dprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhi
    nhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhsghirhht
    hhgvlhhmvghrseguughnrdgtohhm
X-ME-Proxy: <xmx:zXbNaRwkPLB25AzkBNTm3vSEEKCwfWer9HAS2kzKK82NAT9xiu-kKA>
    <xmx:zXbNafPPFfokvpGYTls3PbQDLwO-x53ovBWxfxM3kpqC9tiyvLosEw>
    <xmx:zXbNadodk3m_o6v4owgg46qpEfOhjnXCr2pnNuTlCCmMZUGS8R4KrA>
    <xmx:zXbNaYHsMMrOmob2BgQQu02rygB8ICkxrvuJ8Usn0FhrOzcVKi0IWQ>
    <xmx:zXbNaSvaRc-yAeioHRiWNVxgFRj8Rn9-W6KSLd6OQ1NTG7PM9tembu1n>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 15:49:32 -0400 (EDT)
Message-ID: <278724ec-0c5a-4b3b-b4d7-c5a3c0ceef3b@bsbernd.com>
Date: Wed, 1 Apr 2026 21:49:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fuse: fix io-uring background queue stall on request
 completion
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
 Horst Birthelmer <hbirthelmer@ddn.com>
References: <20260401184915.747714-1-joannelkoong@gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US
In-Reply-To: <20260401184915.747714-1-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bsbernd.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bsbernd.com:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232852-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,szeredi.hu];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bsbernd.com:+,messagingengine.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernd@bsbernd.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bsbernd.com:dkim,bsbernd.com:email,bsbernd.com:mid]
X-Rspamd-Queue-Id: 48BA637FF6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/1/26 20:49, Joanne Koong wrote:
> When a background request completes via the io_uring path, the
> background queue gets flushed to dispatch pending background requests,
> but this is done before the connection-level background counters
> (fc->num_background, fc->active_background) are properly accounted,
> which can leave pending background requests stuck in the per-queue
> background queue.

I don't think it ever gets stuck. In fuse_uring_flush_bg()

        while ((fc->active_background < fc->max_background ||
                !queue->active_background) &&


And queue->active_background gets decreased in the caller,
fuse_uring_req_end. Idea is to always let through at least one 
background request per queue. Reson is that the global 
fc->num_background might be at the limit already, a 
queue then might get a request, it would get added to 
queue->fuse_req_bg_queue, but once fc->active_background goes 
down, there wouldn't be anything to wake up these requests. 
Issue: Only one request allowed per queue when this comes up.

> 
> The connection-level counters are decremented in fuse_request_end(), but
> flush_bg_queue() flushes the /dev/fuse path queue (fc->bg_queue), not
> the io_uring per-queue bg one, which means pending uring background
> requests on the queue are never dispatched.
> 
> Fix this by accounting the connection-level background counters first
> before flushing the queue's background queue. Since
> fuse_request_bg_finish() clears FR_BACKGROUND, fuse_request_end() will
> skip the background cleanup branch entirely, which avoids any
> double-decrements; it will call the wake_up(&req->waitq) branch but this
> is effectively a no-op as background requests have no waiters on
> req->waitq.
> 
> Fixes: 857b0263f30e ("fuse: Allow to queue bg requests through io-uring")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev.c        | 41 ++++++++++++++++++++++++-----------------
>  fs/fuse/dev_uring.c  |  1 +
>  fs/fuse/fuse_dev_i.h |  1 +
>  3 files changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index b212565a78cf..35cdfc162ba5 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -447,6 +447,29 @@ static void flush_bg_queue(struct fuse_conn *fc)
>  	}
>  }
>  
> +void fuse_request_bg_finish(struct fuse_conn *fc, struct fuse_req *req)
> +{
> +	lockdep_assert_held(&fc->bg_lock);
> +
> +	clear_bit(FR_BACKGROUND, &req->flags);
> +	if (fc->num_background == fc->max_background) {
> +		fc->blocked = 0;
> +		wake_up(&fc->blocked_waitq);
> +	} else if (!fc->blocked) {
> +		/*
> +		 * Wake up next waiter, if any.  It's okay to use
> +		 * waitqueue_active(), as we've already synced up
> +		 * fc->blocked with waiters with the wake_up() call
> +		 * above.
> +		 */
> +		if (waitqueue_active(&fc->blocked_waitq))
> +			wake_up(&fc->blocked_waitq);
> +	}
> +
> +	fc->num_background--;
> +	fc->active_background--;
> +}
> +
>  /*
>   * This function is called when a request is finished.  Either a reply
>   * has arrived or it was aborted (and not yet sent) or some error
> @@ -479,23 +502,7 @@ void fuse_request_end(struct fuse_req *req)
>  	WARN_ON(test_bit(FR_SENT, &req->flags));
>  	if (test_bit(FR_BACKGROUND, &req->flags)) {
>  		spin_lock(&fc->bg_lock);
> -		clear_bit(FR_BACKGROUND, &req->flags);
> -		if (fc->num_background == fc->max_background) {
> -			fc->blocked = 0;
> -			wake_up(&fc->blocked_waitq);
> -		} else if (!fc->blocked) {
> -			/*
> -			 * Wake up next waiter, if any.  It's okay to use
> -			 * waitqueue_active(), as we've already synced up
> -			 * fc->blocked with waiters with the wake_up() call
> -			 * above.
> -			 */
> -			if (waitqueue_active(&fc->blocked_waitq))
> -				wake_up(&fc->blocked_waitq);
> -		}
> -
> -		fc->num_background--;
> -		fc->active_background--;
> +		fuse_request_bg_finish(fc, req);
>  		flush_bg_queue(fc);
>  		spin_unlock(&fc->bg_lock);
>  	} else {
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 7b9822e8837b..ae916733f18a 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -90,6 +90,7 @@ static void fuse_uring_req_end(struct fuse_ring_ent *ent, struct fuse_req *req,
>  	if (test_bit(FR_BACKGROUND, &req->flags)) {
>  		queue->active_background--;
>  		spin_lock(&fc->bg_lock);
> +		fuse_request_bg_finish(fc, req);

This basically solves the issue that situations could come up where only
one requests runs at a time.

>  		fuse_uring_flush_bg(queue);
>  		spin_unlock(&fc->bg_lock);
>  	}
> diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
> index 134bf44aff0d..7da505af6d35 100644
> --- a/fs/fuse/fuse_dev_i.h
> +++ b/fs/fuse/fuse_dev_i.h
> @@ -59,6 +59,7 @@ unsigned int fuse_req_hash(u64 unique);
>  struct fuse_req *fuse_request_find(struct fuse_pqueue *fpq, u64 unique);
>  
>  void fuse_dev_end_requests(struct list_head *head);
> +void fuse_request_bg_finish(struct fuse_conn *fc, struct fuse_req *req);
>  
>  void fuse_copy_init(struct fuse_copy_state *cs, bool write,
>  			   struct iov_iter *iter);


Reviewed-by: Bernd Schubert <bernd@bsbernd.com>



PS: If you should be chasing a stuck bg queue issue at tear down, Horst
is chasing a teardown issue with bg queue. 
We are currently testing this patch

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 3de97ed2280f..451bf8981e19 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -136,11 +136,10 @@ void fuse_uring_abort_end_requests(struct fuse_ring *ring)
                if (!queue)
                        continue;

-               queue->stopped = true;
-
                WARN_ON_ONCE(ring->fc->max_background != UINT_MAX);
                spin_lock(&queue->lock);
                spin_lock(&fc->bg_lock);
+               queue->stopped = true;
                fuse_uring_flush_bg(queue);
                spin_unlock(&fc->bg_lock);
                spin_unlock(&queue->lock);


Thanks,
Bernd

