Return-Path: <stable+bounces-249290-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDxSKDIYC2o5/wQAu9opvQ
	(envelope-from <stable+bounces-249290-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:46:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 239C856DEEC
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5162A302AE08
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 13:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5EC481643;
	Mon, 18 May 2026 13:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="nKlGXvTe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OGccABEX"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18A41DD877
	for <stable@vger.kernel.org>; Mon, 18 May 2026 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111638; cv=none; b=SUlPVkAvqUAOQdgMFZ1cT/XTbavhnjgVXTzjRDOcF1hL8Ge7/QmYlUrOXntelonXHBgSFJvaL7G5VftyWSr3mazdgQgp6PM+s5KsX/kLDweEiuX+6+HCcr42NOGLWcg/W5X/4DNIJWcLhFIStvvP6y8jYabKKBwXJxEjpfMS11k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111638; c=relaxed/simple;
	bh=y5YCMW5pJxVRzfiREh/cwGNAxSOXwhuCaPub7DT4Ge8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bDV6z9EoaZhepZSrTHOi9SqZFmJajbbJSiR/vemowKB6s1x+YqEmKYPAsHQTnE8ml8wnuxv8lS9Fk8z/JMiNNybxPxbA4FmEcEWA9YjrtbNEc38lMfwj/pUyOTgvihSzz0CWKYvnZ+EOSsknfTjPCDS6IwrDjLcZfII0gwXBeyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=nKlGXvTe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OGccABEX; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BB4CF7A011C;
	Mon, 18 May 2026 09:40:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 18 May 2026 09:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779111634;
	 x=1779198034; bh=x3ZnqmK6dBpt+lvdbHCPoG4z49tou97P+HHjRNGSdzo=; b=
	nKlGXvTe93YUQ0hNiKL2M7BCTu6j6idwDwg9e5zFMUAA0rabTsfgpgyJ+gQ1iEXH
	MLRkqf6XeOfIMYO/fF6TjAV1DwNkVcjv71FsgVXK3WO4jHAh9OMlM6mCtxsK7ODA
	16FeI1XH7CfAyTpts9VwO9LRa+7aRNJ1SfNENdt4DMAF2d1BzhgKxd7XYDretDBW
	Zj9tA+qZUZJxicWaWOEb8+0pr8OYSS1dz8ykqGclRzumpTzlVXM5eANB1Z+CoYdn
	Q0FtbxLl9IIBTocykXAHM0hKYVbwC/5xBw/6C/zTs05pV6vPanRf1jrNVjXnjnt+
	Wh81AAK9Ryi7hMoj1i3MSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779111634; x=
	1779198034; bh=x3ZnqmK6dBpt+lvdbHCPoG4z49tou97P+HHjRNGSdzo=; b=O
	GccABEXAVJuNfUBx0I1OaxBgZkQ1v9+QZwa4HrSeZWDkJKeZVCQjf7OvSh9f4Gcv
	aOHXlVZxCvdr8Z8azgTE8/8idXKDIOZRcQxze9f1aLgJi9NSZzgBNIAs9FBXCbkf
	IXraQxUzgm9lnHwhEMbvjMpVXezT9IX88W8Uc6b8LqmCTWyKDm1O4qnWeA1ngP03
	M0aNwR7QWTUyAMrfwsWv6xaSXJTWQwllx2gr/NpU589HsJn5IsVHEg/ur2JZNUbr
	PoXH8f64s+SlbOPQNOSqUYhMBgMEIMnLarkrUcsdHD7T6C1CVOcwbJd7khqI4/wj
	ms5Dkj7CXF5XxGL2gwBPA==
X-ME-Sender: <xms:0hYLalTbMSj1Ujr-woggLSwbkuHj8m_rYfBvneZ90WFk3Xd4t_TAUg>
    <xme:0hYLavdIZ4BoFgrbDwz2YkyuiHek_OsJfbh318Ihhi21ybXqizmAm85dayWjAhfkL
    bPIDbLVAbs5UFgY45GdJvZ-ege3XugWfwUB-wQg9yWOY7UKbXZKkw>
X-ME-Received: <xmr:0hYLapDP8DRYrIW-n_Qf1ERxFhhb3oYp6jn1XOwtTGctbRtkzQHLuo_wpndnXEMG91GweBMv5B2Z1lFBlBhCLVAUvBCse-5J_VvMuzcYEz0JURg2mQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeeltdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtg
    homhdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohep
    fhhushgvqdguvghvvghlsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheprg
    hlihesuggunhdrtghomhdprhgtphhtthhopehhohhrshhtsegsihhrthhhvghlmhgvrhdr
    uggvpdhrtghpthhtohepghhgrghnjhhiuddusehnrghvvghrrdgtohhmpdhrtghpthhtoh
    epshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:0hYLahkgEXDc6cLus0gukX9CmZXRD3Up5Wqm2T9YrmbiHrEN17Fy_Q>
    <xmx:0hYLakd8B9Os3_w0TEIi8zII-WmhjejBuJP0D1kHZsGIqSyiYbENbQ>
    <xmx:0hYLalSvtEWt3EM9sY0wN83WGE3XnY9oeOSQXryUV2GBZYr7p4mMxQ>
    <xmx:0hYLarvccBD7TLgF079SFpr4hSr7yF_KnY9t3mW0hIeC30VkBh5LMw>
    <xmx:0hYLahKkT4tJ11YygmJ-0UpFkyTodlEzPSfIm9PGR4b8pQA2KlhAJ0Y3>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 09:40:33 -0400 (EDT)
Message-ID: <e55945b3-99a1-40b3-a145-b4867053930e@bsbernd.com>
Date: Mon, 18 May 2026 15:40:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] fuse: fix moving cancelled entry to
 ent_in_userspace list
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: fuse-devel@lists.linux.dev, ali@ddn.com, horst@birthelmer.de,
 Heechan Kang <gganji11@naver.com>, stable@vger.kernel.org
References: <20260515045541.1171335-1-joannelkoong@gmail.com>
 <20260515045541.1171335-4-joannelkoong@gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <20260515045541.1171335-4-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bsbernd.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bsbernd.com:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,ddn.com,birthelmer.de,naver.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249290-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,szeredi.hu];
	DKIM_TRACE(0.00)[bsbernd.com:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernd@bsbernd.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bsbernd.com:email,bsbernd.com:mid,bsbernd.com:dkim,naver.com:email,messagingengine.com:dkim,birthelmer.de:email,ddn.com:email]
X-Rspamd-Queue-Id: 239C856DEEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/15/26 06:55, Joanne Koong wrote:
> fuse_uring_cancel() moves entries that are available (these have no reqs
> attached) to the ent_in_userspace list. ent_list_request_expired()
> checks the first entry on ent_in_userspace and dereferences
> ent->fuse_req unconditionally, which will crash on a cancelled entry
> that was moved to this list.
> 
> Fix this by freeing the entry and dropping queue_refs directly in
> fuse_uring_cancel(). This is safe because cancel is the cancel handler
> itself - after io_uring_cmd_done(), no more cancels will be dispatched
> for this command, and teardown serializes with cancel via queue->lock.
> 
> Since cancel now decrements queue_refs, fuse_uring_abort() must no
> longer gate fuse_uring_abort_end_requests() on queue_refs > 0, as
> cancelled entries may have already dropped queue_refs while requests are
> still queued. Remove the gate so abort always flushes requests and stops
> queues.
> 
> Reported-by: Heechan Kang <gganji11@naver.com>
> Fixes: 4fea593e625c ("fuse: optimize over-io-uring request expiration check")
> Cc: stable@vger.kernel.org
> Co-developed-by: Jian Huang Li <ali@ddn.com>
> Co-developed-by: Horst Birthelmer <horst@birthelmer.de>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev_uring.c   | 6 ++++--
>  fs/fuse/dev_uring_i.h | 6 +++---
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index d9108b5b5db8..f4ba64a1796a 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -511,8 +511,7 @@ static void fuse_uring_cancel(struct io_uring_cmd *cmd,
>  	queue = ent->queue;
>  	spin_lock(&queue->lock);
>  	if (ent->state == FRRS_AVAILABLE) {
> -		ent->state = FRRS_USERSPACE;
> -		list_move_tail(&ent->list, &queue->ent_in_userspace);
> +		list_del_init(&ent->list);
>  		need_cmd_done = true;
>  		ent->cmd = NULL;
>  	}
> @@ -521,6 +520,9 @@ static void fuse_uring_cancel(struct io_uring_cmd *cmd,
>  	if (need_cmd_done) {
>  		/* no queue lock to avoid lock order issues */
>  		io_uring_cmd_done(cmd, -ENOTCONN, issue_flags);
> +		kfree(ent);
> +		if (atomic_dec_and_test(&queue->ring->queue_refs))
> +			wake_up_all(&queue->ring->stop_waitq);
>  	}
>  }
>  
> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> index 368f4d0790eb..22ec67e39ee0 100644
> --- a/fs/fuse/dev_uring_i.h
> +++ b/fs/fuse/dev_uring_i.h
> @@ -150,10 +150,10 @@ static inline void fuse_uring_abort(struct fuse_chan *fch)
>  	if (ring == NULL)
>  		return;
>  
> -	if (atomic_read(&ring->queue_refs) > 0) {
> -		fuse_uring_abort_end_requests(ring);
> +	fuse_uring_abort_end_requests(ring);
> +
> +	if (atomic_read(&ring->queue_refs) > 0)
>  		fuse_uring_stop_queues(ring);
> -	}
>  }
>  
>  static inline void fuse_uring_wait_stopped_queues(struct fuse_chan *fch)


Reviewed-by: Bernd Schubert <bernd@bsbernd.com>

