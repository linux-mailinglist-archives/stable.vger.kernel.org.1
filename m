Return-Path: <stable+bounces-244694-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGm8LwGY/WnBgAAAu9opvQ
	(envelope-from <stable+bounces-244694-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 10:00:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5CA4F36C9
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 10:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FFA5300C021
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 07:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF6336EAAB;
	Fri,  8 May 2026 07:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qjy8dFfX"
X-Original-To: stable@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBC9378822
	for <stable@vger.kernel.org>; Fri,  8 May 2026 07:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778227154; cv=none; b=HQN82Fbjml9u7B1h9spLS8Z4bscip5O1S5xl1hE4VBM8FApJVuJTpDpmrWYCJJKKsEVoxlpGLADvYWZcBZyCN7Jm+IyYcyeoJuA0DZqsIsgBYj6rfHTu0YEcXGgpBtQL0xxotuccKO37Qofi0PMrHVR6jPG1UHJ3W8ic/f6L3/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778227154; c=relaxed/simple;
	bh=A5eLo0k1WN3dKsNjpIfOF2pKn7Y3GKqYof0joQHkltM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GKC3lyeXlaQQdJvBPMMu8IwkTm1BK6UXQkOiajlz7TjmMciqLl6ivYWQ5yzvTEGNfB4yyNIsRlJ23543fViRqvIx4FL1Bm1NPgCSULefOKVFGB/FwuPx1Eh2jh0wNwp4wEMg+ot9GLkKRl0+4Mdns2ijI/Xeb76IKEaI3ZF5fsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qjy8dFfX; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6a1a50d1-9aa8-406d-90b1-4d5ca9fe0afb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778227141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EebeowThzEPHzOPHxVe8PsQqS05P87lAK1+IwQ9r900=;
	b=Qjy8dFfXevjzgSXdRI1yDAk2G8yPi/JugjEL0KTVbj7Q73qdGyrgbj7Ldy7OqgADZFF+ct
	MhgQ+ysmCiE64X077RZfXX4MGsixZdjmO3BmUT3YT//HVjGBsu6ZI1HZsZtfKDPVzSroHW
	I/Q0TdE6vWkf3MuGkDwmsBElASIklS0=
Date: Fri, 8 May 2026 15:58:34 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] rxrpc: Also unshare DATA/RESPONSE packets when
 paged frags are present
To: Hyunwoo Kim <imv4bel@gmail.com>, dhowells@redhat.com,
 marc.dionne@auristor.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, qingfang.deng@linux.dev
Cc: linux-afs@lists.infradead.org, netdev@vger.kernel.org,
 stable@vger.kernel.org
References: <af2F1FU5d4Q_Gn1W@v4bel>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <af2F1FU5d4Q_Gn1W@v4bel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 2A5CA4F36C9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,auristor.com,davemloft.net,google.com,kernel.org,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244694-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On 5/8/26 2:42 PM, Hyunwoo Kim wrote:
> The DATA-packet handler in rxrpc_input_call_event() and the RESPONSE
> handler in rxrpc_verify_response() copy the skb to a linear one before
> calling into the security ops only when skb_cloned() is true.  An skb
> that is not cloned but still carries paged fragments (skb->data_len != 0)
> falls through to the in-place decryption path, which binds the frag
> pages directly into the AEAD/skcipher SGL via skb_to_sgvec().
>
> Extend the gate so that any skb with non-linear data is also copied,
> ensuring the security handler always operates on a fully linear skb.
> The OOM/trace handling already in place is reused.
>
> Fixes: d0d5c0cd1e71 ("rxrpc: Use skb_unshare() rather than skb_cow_data()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
> Changes in v2:
> - Use skb_is_nonlinear() instead of skb->data_len
> - v1: https://lore.kernel.org/all/afKV2zGR6rrelPC7@v4bel/
> ---
>   net/rxrpc/call_event.c | 2 +-
>   net/rxrpc/conn_event.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
> index fdd683261226..a6ad5ff6ec5f 100644
> --- a/net/rxrpc/call_event.c
> +++ b/net/rxrpc/call_event.c
> @@ -334,7 +334,7 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
>   
>   			if (sp->hdr.type == RXRPC_PACKET_TYPE_DATA &&
>   			    sp->hdr.securityIndex != 0 &&
> -			    skb_cloned(skb)) {
> +			    (skb_cloned(skb) || skb_is_nonlinear(skb))) {
>   				/* Unshare the packet so that it can be
>   				 * modified by in-place decryption.
>   				 */
> diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
> index a2130d25aaa9..632cbeff1f5d 100644
> --- a/net/rxrpc/conn_event.c
> +++ b/net/rxrpc/conn_event.c
> @@ -245,7 +245,7 @@ static int rxrpc_verify_response(struct rxrpc_connection *conn,
>   {
>   	int ret;
>   
> -	if (skb_cloned(skb)) {
> +	if (skb_cloned(skb) || skb_is_nonlinear(skb)) {
>   		/* Copy the packet if shared so that we can do in-place
>   		 * decryption.
>   		 */


Why not adopt the same gate as the ESP fix:


     skb_cloned(skb) || skb_has_frag_list(skb) || skb_has_shared_frag(skb)


so NIC page_pool RX keeps its zero-copy path while still catching the 
splice-loopback vector?



