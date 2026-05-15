Return-Path: <stable+bounces-247722-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFE9MCQTB2rgrQIAu9opvQ
	(envelope-from <stable+bounces-247722-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:35:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C99A754FAA0
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EC1C30AABC2
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0AA47ECFC;
	Fri, 15 May 2026 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="Z79YpyUw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JmQb/nKr"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CD447ECFA
	for <stable@vger.kernel.org>; Fri, 15 May 2026 11:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778846372; cv=none; b=jJxsCocAnyrsoQzt0F/NlW6VUZpg5yn9jLWqvf/K6o/3MATIwURGOj+GKvyPzTcQIQhU8RY5GWajtiweIQT66G1cTMMFfJdqazxv+c/q29XQAe4a0fpCKLWOtdJ2GgjTzLvelINcYiWDro/OHo/8h4E5hYqvU/Gsz0l5I8GUOm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778846372; c=relaxed/simple;
	bh=+ZN/rQClRBRBAWs65UAPjEUgJ4Y9HBy6RNfgvjCYLDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q6oIQjRfQBz4TZ9tu60I22ArDJwwqNrjVaofcMqTgnBsmUSTYzLYzvwop8V1o/ZvdTAtnBdp5DYaIDqBCljWKn7lLLsz0iDUhx+OS8r6RnhYR49WbHqwhsJ50qk6ozHBDStZRGqY0ijiwoBHFeCmFMj+RVRNpnvQimuVeAZ9rZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=Z79YpyUw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JmQb/nKr; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 862A81400129;
	Fri, 15 May 2026 07:59:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 15 May 2026 07:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778846370;
	 x=1778932770; bh=kTPXzdtKVtjmT4/N5aCrO3snBbC23SVWwltpL2BzCts=; b=
	Z79YpyUwiJoT/GkWrTY+OdbCRcOtapJNxyHXXN6bgkBIHSZDvWA5nSxxo6t/kLo0
	z3Hy3gosA5hPijHx8QbKP+Ch21gicDJnxA9w1LFN7zKbWE2lOPIit3hHMleS86Qz
	a/n6Fj+x7tPMjqUwHoXoKdyvleP1qb91/xRqE42Ts1/ctIyxhmqwVoEAAhiG5XGD
	iCL0SHIVy5L1+S9ZtKGruIXYWtyLDP8tRVYk1k6I79yx2KgUvmuS8CxNfFF3C1za
	T3gS0wXeXLLR8JwnI+QZNQ6DEWVakiZV+rWYyNZv6rgPM+P96pNPKkWqsnQ9kMVv
	CdsatwWywTnX0sHVByjzyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778846370; x=
	1778932770; bh=kTPXzdtKVtjmT4/N5aCrO3snBbC23SVWwltpL2BzCts=; b=J
	mQb/nKrJlv9+NDheUT8mmgSA4BfsvwOuCfSjvxr5SBVKBwRLlkaCe82+yECp5RDa
	K9tu+AmLI2bW3qln/325s9807pL+Cd6D/CG4va8zXn8ZiEi5fF4wonG6b719o5bI
	nCKkYKyiP2ml5TEyUNC5jWRkFBLehxzn1DfxA6OeKLVrI0ujqxtTRQUGPA71l3cn
	KZSqiv5LnRpLxiH3+faLq5GKO6lq3kCcxF4tAiPaJuU3/AD6VCPsCQzl31FOpHIi
	a4MNUHghA2of8UJ2HzCHh5KP2y9sa1Wp6naMWwVIjJcIqG4VK4RUf6kj5MrVtdYR
	Ffmn4R4XVIEDhPAViK/1A==
X-ME-Sender: <xms:ogoHaquanBVINjx5g8vRaaFd11GRnUc28fA69FBgsULS0gYr46btoA>
    <xme:ogoHaozsNKoFYZGNPh1V7gASpsiVvMIzKDPbZcKJhvUCU6FO9j-TfamQEFYp2ui3e
    qx3iOFhOVlgrBSyQyc9itURUbM97JMO1FDjWoVJIHYq1XllAn8>
X-ME-Received: <xmr:ogoHatBOlORvwUKxTjxEafJI5zuIoyZGaFkNbthI1S0cNCL-3TZbKrOtli-5k23UeghBmRrFDbBx-7-8DUq3EyssMWdIQmNNGAhwjmDavXUusfPSzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufedtfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtg
    homhdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohep
    fhhushgvqdguvghvvghlsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheprg
    hlihesuggunhdrtghomhdprhgtphhtthhopehhohhrshhtsegsihhrthhhvghlmhgvrhdr
    uggvpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ogoHameN5CiXv2JyXbS_XWMuYjjaDN_pCoRM3pKYQGBPfR6vBh6Vyg>
    <xmx:ogoHank1V3vUR0lxdwIXU5D2jVN-nopUhR5R1JBHyKO4lvPbvWsfjA>
    <xmx:ogoHatF-hhZXaFTKU7r9C4GmQhWY2nqzo0OjxRiRdo2l_Bg3p23imA>
    <xmx:ogoHav6gI380AUuDQyKPxR1MHTRQkO4nN6PkkQOL7eKi1WRNv-govQ>
    <xmx:ogoHalN50Ml0YCyEIiuGy2ycyHGPkqCrqk44glSXP8Z6G-N7mRORLQ85>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 May 2026 07:59:29 -0400 (EDT)
Message-ID: <a59c061c-3734-47ba-8891-fc72926458da@bsbernd.com>
Date: Fri, 15 May 2026 13:59:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] fuse: fix race between registration and connection
 abortion
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: fuse-devel@lists.linux.dev, ali@ddn.com, horst@birthelmer.de,
 stable@vger.kernel.org
References: <20260515045541.1171335-1-joannelkoong@gmail.com>
 <20260515045541.1171335-3-joannelkoong@gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <20260515045541.1171335-3-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C99A754FAA0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bsbernd.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bsbernd.com:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-247722-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,szeredi.hu];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[bsbernd.com:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernd@bsbernd.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Action: no action



On 5/15/26 06:55, Joanne Koong wrote:
> This fixes this race:
> - thread a: io_uring_enter -> register sqe ->
>   fuse_uring_create_ring_ent -> allocate ent but doesn't grab queue_ref
>   yet
> - thread b: fuse_conn_destroy() -> fuse_chan_abort() ->
>   fuse_uring_abort() is a no-op due to queue ref being 0
> - thread a: grabs the queue_ref, queue_ref is now 1, rest of
>   fuse_uring_do_register() logic executes
> - thread b: fuse_chan_abort() returns, fuse_chan_wait_aborted() now runs
>   and calls
>   "wait_event(ring->stop_waitq, atomic_read(&ring->queue_refs) == 0);"
> The abort/unmount thread will hang indefinitely in unkillable state as
> nothing will decrement queue_refs or wake stop_waitq, and the ring,
> queue, and ent are leaked.
> 
> Fix this by checking fch->connected under fch->lock after the created
> ent has grabbed a ref count on the queue. This ensures that in the
> scenario above, it is guaranteed that we either release the queue ref
> and wake up stop_waitq (in case fuse_chan_wait_aborted() is already
> waiting) in fuse_uring_do_register() when we detect !fch->connected, or
> if the connection is aborted after the check, it is guaranteed that the
> async teardown worker will be running in the background cleaning up ents
> and decrementing the ent's ref on the queue, which will unblock the
> eventual queue and ring teardown.
> 
> Fixes: 24fe962c86f5 ("fuse: {io-uring} Handle SQEs - register commands")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev_uring.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index cd75f61018ec..d9108b5b5db8 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -977,15 +977,26 @@ static bool is_ring_ready(struct fuse_ring *ring, int current_qid)
>  /*
>   * fuse_uring_req_fetch command handling
>   */
> -static void fuse_uring_do_register(struct fuse_ring_ent *ent,
> -				   struct io_uring_cmd *cmd,
> -				   unsigned int issue_flags)
> +static int fuse_uring_do_register(struct fuse_ring_ent *ent,
> +				  struct io_uring_cmd *cmd,
> +				  unsigned int issue_flags)
>  {
>  	struct fuse_ring_queue *queue = ent->queue;
>  	struct fuse_ring *ring = queue->ring;
>  	struct fuse_chan *fch = ring->chan;
>  	struct fuse_iqueue *fiq = &fch->iq;
>  
> +	spin_lock(&fch->lock);
> +	/* abort teardown path is running or has run */
> +	if (!fch->connected) {
> +		spin_unlock(&fch->lock);
> +		if (atomic_dec_and_test(&ring->queue_refs))
> +			wake_up_all(&ring->stop_waitq);
> +		kfree(ent);
> +		return -ECONNABORTED;
> +	}
> +	spin_unlock(&fch->lock);
> +
>  	fuse_uring_prepare_cancel(cmd, issue_flags, ent);
>  
>  	spin_lock(&queue->lock);
> @@ -1002,6 +1013,7 @@ static void fuse_uring_do_register(struct fuse_ring_ent *ent,
>  			wake_up_all(&fch->blocked_waitq);
>  		}
>  	}
> +	return 0;
>  }
>  
>  /*
> @@ -1118,9 +1130,7 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
>  	if (IS_ERR(ent))
>  		return PTR_ERR(ent);
>  
> -	fuse_uring_do_register(ent, cmd, issue_flags);
> -
> -	return 0;
> +	return fuse_uring_do_register(ent, cmd, issue_flags);
>  }
>  
>  /*

Reviewed-by: Bernd Schubert <bernd@bsbernd.com>

