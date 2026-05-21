Return-Path: <stable+bounces-253583-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HMGEx0mD2paGgYAu9opvQ
	(envelope-from <stable+bounces-253583-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 17:34:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3808B5A8728
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 17:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4EE13043F78
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 14:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B6C3FFAC8;
	Thu, 21 May 2026 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="nD7/scCW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SbZbVWH4"
X-Original-To: stable@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBA93DC875;
	Thu, 21 May 2026 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374377; cv=none; b=OUfcRXnmHImyET6FM/aBi9zjWUVXIsl1YF3b3aNCl5vf7wI7y9GPHi+sqn0hiQqN1E1fzl9Bl6s/zYHsabKWTNso++/riCCweeSoNrFaCu2uYenussOYoJBrRe2w/2xYmYluWHUGrZSCcirK+m2ndEUKnfr30dUAq7Ckp/hVoG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374377; c=relaxed/simple;
	bh=roB8K90pZdJLjtNA8L+9YNNxQDDBDXi36h+2ABWO5Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bj9qPy9DQdUf6nADmz3BgGwIgA4G8qnazeRyVzg6Lx+hxC2SRQGJKhgdPA3TwlfCsavuyF+HDw/Z+Bya7oa0ktTrEhHI9ypW0+BDPCmObZzxjt/X8CUgruU2Uku5pmK6Vw55kXMSW1KMQ/6Kq5KwW98TZI8TwP0y9oMKOiy1NE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=nD7/scCW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SbZbVWH4; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 1BA591D00095;
	Thu, 21 May 2026 10:39:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 21 May 2026 10:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1779374373; x=
	1779460773; bh=icCV10FL3VV6bt0ffyB2QjNC3KhIKFtGh4koyNHlte8=; b=n
	D7/scCWxW/F5K7DgViOywccXizPwH6dpty77uoB0zVHa4nge+ibyUHegYoHWZpAo
	GL7Dj43VcHUBN8SgA5owHFwJQFp2uCS4QX+Vr1/uslsbiLbFdOMOhqMtiBvRoCJb
	xQLycYxgP75x5F6SQH6HJo9b4nuTu2jaaE6eiOXKjyUVJB9Zl4IUBYzY4Ds6rcRI
	YC73AMY39OVzBcgaY4hNgra6P/7BlrBILSrZYmfuYwxmJSagqVSVXhf1TYhkr+90
	TpFXC8ByPBEhBzzT02ortz/l0OBXUIYrx7ayhual04/hjiIyNlAmF1u4tfiPEh6V
	4/FvZs6HJX2fykPSt0+Zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779374373; x=1779460773; bh=icCV10FL3VV6bt0ffyB2QjNC3KhIKFtGh4k
	oyNHlte8=; b=SbZbVWH4isnHFfA57kY0P+1nh/wnvG/EY6I0249sJuelmmAzsWh
	/RKTKxbLr2up8916cWcfZxq5lquibeVB1Zw02ilrfifEK+bkgl2OeeDxubvMPPNS
	fbsZbQHrJi08l8qgFohGYgt9zpTTEmmbKxEosM54rtBsBA4lVZSAqUmSXlu5ZbSk
	UgiStuFDqewNyrMcSIHTBvAE8V/fk2mxsOXmsGcvdljGovGvjBse3fH6DcIaXvZL
	F7go65nrnYKGQb4GrmF6+Ds4iocghMMbH9zBdZRWLfDXjqWXlM33XQKbTpG5J6aZ
	3cjOQFn2xdcjXXTHh+en7d4OCOeOTb+brBg==
X-ME-Sender: <xms:JBkPao05RU3zrquL2XP3S2Eh51Q8QQFYoyyVplnvMN404cf_Xd9lqw>
    <xme:JBkParQ_nC4gAxkHwIn1HJKuh_DLx-7EtBnHT8MMiJkcnSrnWntp_vAbLFPhJpGXq
    KZ9CDnpAU0xQnj-hod6Z59JLwHtQDNu2xlUdOnP5Ge1u7WiutacoQ>
X-ME-Received: <xmr:JBkPaseZLZWPFJgRMR68iZESxMk0CKH68m1aQp5RqoQdfrk66TzAEkkUhUcW43FV5ZPw5C8Jm_j6a5chnllRYlU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedutddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprggrrhhonhduvghsrghusehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepshhtvghffhgvnhdrkhhlrghsshgvrhhtsehsvggtuhhnvghtrdgtohhmpd
    hrtghpthhtohephhgvrhgsvghrthesghhonhguohhrrdgrphgrnhgrrdhorhhgrdgruhdp
    rhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvg
    guuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtph
    htthhopehhohhrmhhssehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:JBkPasfJfzRzNXBEZY-kyO2-FX2fZE2v15OaJ3Ufa5QCDZYzS3aX1A>
    <xmx:JBkPam33c7YdfTb8QEiOxcdozCFlnAMnANlg7mtqFulwWqlbHzx4yQ>
    <xmx:JBkPak8aDXW0E2ygpc8fGfUdojHFxIlH1n6RZ08lWa1gVrRfjyf7SA>
    <xmx:JBkPar5I1i6muHHylBqwjHkxDrGJq-P2K2aZ-DF8RI3lOlOBK60MLA>
    <xmx:JRkPahJByw9VQY2jo6ExZTykmT52uiliWDEHBRixKKREHvYPHIhXmbax>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 10:39:31 -0400 (EDT)
Date: Thu, 21 May 2026 16:39:29 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Aaron Esau <aaron1esau@gmail.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	"David S . Miller" <davem@davemloft.net>, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] xfrm: espintcp: fix sg.size corruption on partial send
 error
Message-ID: <ag8ZIQuxvJa0DFvX@krikkit>
References: <20260518032109.616327-1-aaron1esau@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260518032109.616327-1-aaron1esau@gmail.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253583-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,queasysnail.net:dkim]
X-Rspamd-Queue-Id: 3808B5A8728
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-05-18, 12:21:09 +0900, Aaron Esau wrote:
> espintcp_sendskmsg_locked() calls put_page() and sk_mem_uncharge() for
> each scatterlist element it successfully sends, but never decrements
> sg.size. If tcp_sendmsg_locked() then fails partway through, the error
> path advances sg.start past the freed elements while sg.size still
> accounts for them. A subsequent sk_msg_free() in espintcp_close() loops
> until sg.size reaches zero, overshoots sg.end, hits zeroed entries with
> NULL pages, and crashes in put_page().
> 
> Fix this by decrementing sg.size as each element is freed. Also use
> sk_msg_iter_var_next() instead of raw addition for sg.start, so it
> wraps at NR_MSG_FRAG_IDS.

(wrapping shouldn't be an issue since I don't think we can have start
!= 0 in espintcp)

> Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Esau <aaron1esau@gmail.com>
> ---
>  net/xfrm/espintcp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
> index e1b11ab59..6755f6df6 100644
> --- a/net/xfrm/espintcp.c
> +++ b/net/xfrm/espintcp.c
> @@ -237,7 +237,8 @@ static int espintcp_sendskmsg_locked(struct sock *sk,
>  		ret = tcp_sendmsg_locked(sk, &msghdr, size);
>  		if (ret < 0) {
>  			emsg->offset = offset - sg->offset;
> -			skmsg->sg.start += done;
> +			while (done--)
> +				sk_msg_iter_var_next(skmsg->sg.start);
>  			return ret;
>  		}
>  
> @@ -250,6 +251,7 @@ static int espintcp_sendskmsg_locked(struct sock *sk,
>  		done++;
>  		put_page(p);
>  		sk_mem_uncharge(sk, sg->length);
> +		skmsg->sg.size -= sg->length;
>  		sg = sg_next(sg);
>  	} while (sg);

Or maybe switch to using sk_msg_free_partial()? It should fix the
issue and clean up the code at the same time. The diff looks a bit
nasty but this boils down to "remove all the custom
size/offset/partial send handling":

-------- 8< --------
diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index a2756186e13a..4802b68a833d 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -212,43 +212,23 @@ static int espintcp_sendskmsg_locked(struct sock *sk,
 	struct sk_msg *skmsg = &emsg->skmsg;
 	bool more = flags & MSG_MORE;
 	struct scatterlist *sg;
-	int done = 0;
 	int ret;
 
-	sg = &skmsg->sg.data[skmsg->sg.start];
 	do {
 		struct bio_vec bvec;
-		size_t size = sg->length - emsg->offset;
-		int offset = sg->offset + emsg->offset;
-		struct page *p;
-
-		emsg->offset = 0;
 
+		sg = &skmsg->sg.data[skmsg->sg.start];
 		if (sg_is_last(sg) && !more)
 			msghdr.msg_flags &= ~MSG_MORE;
 
-		p = sg_page(sg);
-retry:
-		bvec_set_page(&bvec, p, size, offset);
-		iov_iter_bvec(&msghdr.msg_iter, ITER_SOURCE, &bvec, 1, size);
-		ret = tcp_sendmsg_locked(sk, &msghdr, size);
-		if (ret < 0) {
-			emsg->offset = offset - sg->offset;
-			skmsg->sg.start += done;
+		bvec_set_page(&bvec, sg_page(sg), sg->length, sg->offset);
+		iov_iter_bvec(&msghdr.msg_iter, ITER_SOURCE, &bvec, 1, sg->length);
+		ret = tcp_sendmsg_locked(sk, &msghdr, sg->length);
+		if (ret < 0)
 			return ret;
-		}
-
-		if (ret != size) {
-			offset += ret;
-			size -= ret;
-			goto retry;
-		}
 
-		done++;
-		put_page(p);
-		sk_mem_uncharge(sk, sg->length);
-		sg = sg_next(sg);
-	} while (sg);
+		sk_msg_free_partial(sk, skmsg, ret);
+	} while (skmsg->sg.size);
 
 	memset(emsg, 0, sizeof(*emsg));
 
-- 
Sabrina

