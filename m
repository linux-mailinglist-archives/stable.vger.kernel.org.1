Return-Path: <stable+bounces-235638-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDN5M4kh2WkqmggAu9opvQ
	(envelope-from <stable+bounces-235638-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 18:12:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 911A43DA2DB
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 18:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E433300E14F
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 16:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0073D75D4;
	Fri, 10 Apr 2026 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Szit41X4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F31F3A453B;
	Fri, 10 Apr 2026 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775837301; cv=none; b=Iq8NtrJxdpTght09Pe2meXk5R95sbYIIgsMeNrTJAIjup14GUavjvNDNUhRmchVGcDn1dniY2loFQWX82Cvap2E0sm0Il7vNb2+TOwb+Ogvyw9vOGtQ/vZl7oY8O9ybI5aru6izLAMC4GvAoe7dvU4JcxMlTnHhNorGvX9CWH4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775837301; c=relaxed/simple;
	bh=1AumQo2ei88qRXMSnuX1xeEdx8pnbyFH9BQfPPiSsBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMhWDidONq/nVHT1VoM5RfZ9xnvwtB16UyOEwapbykoeH19NASkS+5a8sHy299+rb3x5SgPBglqXDT150jIkMlHj5te0PwnEYAE72uWR1uzaKeSL6T1Kuc2JV0w25JO/+8I/GCvjsj6uNfxDEKrOO9yXlDVyWKibAHpjA2KLQqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Szit41X4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5619C19421;
	Fri, 10 Apr 2026 16:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775837301;
	bh=1AumQo2ei88qRXMSnuX1xeEdx8pnbyFH9BQfPPiSsBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Szit41X4LJOLgsFY8HncJVwgFM5x+6rV8r3DPg6TonnJYf7ogaInjJBk6MFhZYC7w
	 ix2agFcxjVSLYd+N3fY/iuKraVLN+U1rkDuIksS0StrGjLczYv59abJPynCpFPv+Db
	 DdnkZ63XnoZ1fhpCINUBzgNq+Jzb0jE9as6gh9zcEg23td2+vccBon42kTymt/jPBP
	 eg8Qumt3mk/kY4Oo52v6hvs0UVcT2O47iRBokmtSPGjMtTpsann0oUWumKYgCtLCES
	 Q5zIyo3XOh6yTzUQ0xzy+U+4RrMF6Y09EmU9kdtj7RyKnH21R2EpuxD5YH5cUaQhXG
	 6ekAmLJBTLULA==
From: Simon Horman <horms@kernel.org>
To: mashiro.chen@mailbox.org
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gregkh@linuxfoundation.org,
	ben@decadent.org.uk,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] net: netrom: fix integer overflow in nr_queue_rx_frame()
Date: Fri, 10 Apr 2026 17:04:33 +0100
Message-ID: <20260410160431.641061-3-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407171600.102988-2-mashiro.chen@mailbox.org>
References: <20260407171600.102988-2-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235638-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 911A43DA2DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev

Simon says: This review combines a review of the patch with a report
of an existing problem. And you will see a similar pattern in
the AI generated reviews I am forwarding for the other patches in this
series.

I would suggest not growing the scope of this series too much.
But rather noting (other) existing problems as areas for further work.

Frankly, I suspect fixing all such problems is a significant body of work.

---
    net: netrom: fix integer overflow in nr_queue_rx_frame()

This commit addresses an integer overflow in nr_queue_rx_frame() where
accumulating fragment lengths could wrap around a 16-bit integer. It attempts
to fix this by checking if adding the incoming skb length to the accumulated
fraglen exceeds USHRT_MAX, purging the queue and returning an error if so.

> diff --git a/net/netrom/nr_in.c b/net/netrom/nr_in.c
> index 97944db6b5ac6..0b7cdb99ae501 100644
> --- a/net/netrom/nr_in.c
> +++ b/net/netrom/nr_in.c
> @@ -36,12 +36,22 @@ static int nr_queue_rx_frame(struct sock *sk, struct sk_buff *skb, int more)
>  	nr_start_idletimer(sk);
>  
>  	if (more) {
> +		if ((unsigned int)nr->fraglen + skb->len > USHRT_MAX) {
> +			skb_queue_purge(&nr->frag_queue);
> +			nr->fraglen = 0;
> +			return 1;
> +		}

If we return 1 here, does the caller (nr_state3_machine) treat it as a
transient busy condition?

If the caller retries the skb later, the skb will have already been modified
by the unconditional skb_pull() at the start of nr_queue_rx_frame(). Does
this mean the next time it is processed, it will read from the wrong offset
and potentially process attacker-controlled payload?

Furthermore, since nr->fraglen is reset to 0, wouldn't the oversized fragment
now pass the USHRT_MAX check on retry, bypassing the overflow mitigation
entirely?

When we purge the fragment queue here, are we also silently dropping
fragments that the protocol stack has already acknowledged to the sender?

Since nr_queue_rx_frame() previously returned 0 for those earlier fragments,
the expected sequence number has already advanced. If the sender never
retransmits them and fraglen is reset, will the receiver accept the next
fragment as the start of a new sequence, leading to a truncated message being
delivered to the application?

[ ... ]

While reviewing this patch, I also noticed a few pre-existing issues in
nr_queue_rx_frame() that might be worth addressing.

Looking at the start of the function:

static int nr_queue_rx_frame(struct sock *sk, struct sk_buff *skb, int more)
{
	struct sk_buff *skbo, *skbn = skb;
	struct nr_sock *nr = nr_sk(sk);

	skb_pull(skb, NR_NETWORK_LEN + NR_TRANSPORT_LEN);

Is it possible for skb_pull() to be called on a malformed packet where the
total length is sufficient but the linear region is too small? If so, would
this trigger a BUG_ON() panic inside __skb_pull()? Should there be a length
validation check using pskb_may_pull() beforehand?

Further down, during fragment reassembly:

	while ((skbo = skb_dequeue(&nr->frag_queue)) != NULL) {
		skb_copy_from_linear_data(skbo,
					  skb_put(skbn, skbo->len),
					  skbo->len);
		kfree_skb(skbo);
	}

If skbo is a non-linear (paged) skb, skbo->len includes the paged data length.
Since skb_copy_from_linear_data() acts as a direct memory copy, does this
result in reading past the end of the linear allocation (skb_headlen()) into
adjacent kernel memory?

Finally, looking at the error paths:

	if ((skbn = alloc_skb(nr->fraglen, GFP_ATOMIC)) == NULL)
		return 1;
	...
	return sock_queue_rcv_skb(sk, skbn);

If sock_queue_rcv_skb() fails, it returns a non-zero error which propagates
to the caller. Does the caller then try to re-enqueue the original fragment
pointer into a retry queue?

Since the original fragments were already dequeued from frag_queue and freed
via kfree_skb() in the loop above, could enqueuing the freed skb lead to a
use-after-free?

Additionally, if alloc_skb() fails and returns 1, does the caller enqueue the
original skb while it is still linked in frag_queue, potentially corrupting
the doubly-linked list?

