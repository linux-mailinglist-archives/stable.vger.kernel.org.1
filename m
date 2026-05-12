Return-Path: <stable+bounces-245589-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CF/dAbA4A2qh1wEAu9opvQ
	(envelope-from <stable+bounces-245589-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:26:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECA25226BF
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30C0531C85F6
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15303394E96;
	Tue, 12 May 2026 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2t9SWKH"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6773911A6
	for <stable@vger.kernel.org>; Tue, 12 May 2026 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593120; cv=none; b=KhCJvvbz5KiR4yR8FwLIbIW5YxwbEZ+JsDO9AwNTLyYcvCNBl7oBeP+6gB9zKX+yhNjr5uxmIWpecBWZVdVA4YxYRdRtJEWEaNVout8K8dvokAZur8Q2+M+UDd0r3wFr+UBJPxmFqNfv8vF2TMvAKFHuoiOjOZ+yZU/VhVojm5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593120; c=relaxed/simple;
	bh=5rucsuS8hZdV/3ev9sdHdT9VKXHJ0QA9VdTwQrRMI6I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YMXWNKz+IdfkDD8aFgf8tNaMKoZZ9uSKRIw6n7xHPyIFdiZxFOEbfPayGqD6JqVb7ay2ZZMtzkg6xrS7jxyqKFBOC1fm5knVhnG4ee1luLW/+cglNc9z9pYfCHplp+vBLiw8IvdKumDV8cp5vmuwRmtsdmP+1TDtl4Bs9jfLhTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2t9SWKH; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488b0046078so46524465e9.1
        for <stable@vger.kernel.org>; Tue, 12 May 2026 06:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778593117; x=1779197917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLra9IdckiEYkvhtbWy3DFeiQMA2xXw49XoLCCcKJHE=;
        b=m2t9SWKHfwZvEF/sp10oPCY5JQV76/euCB+vH10B/ZjBOSTPBXr0gdWvCd/Nof+X5M
         CmDkquBT52moj0gJyq824umfE3lVYXzNrbYvFVwM6PPP0Zrs/Cxwo5GDQ75nwHDZRMZ6
         m+0u1KpW4gkbwPg/aK2NgOS0hI8JrmVcLURgTrwQ3tE2dPnH3Sfloru/Nw65nXNwzzn1
         6cCCSFHoZp44fEQpIBhnJBMCpmLzZURAvGSI1BAqrBrkPhcQDOCGJdLL+YTNpUgtyGko
         G9JCCZfHx4XXP7kP7ldlfHGlF1k0dSaOJeO6StlNiOR1KxgplUZSteuH9BNrZ7uaWx1k
         KgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778593117; x=1779197917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HLra9IdckiEYkvhtbWy3DFeiQMA2xXw49XoLCCcKJHE=;
        b=HaCBXAwaeMhIoB8l3G0dsLvzx4uV0M6JO79nGI7xRUvFdyvgY8OXc0GOwikAMYU8lp
         zw08x+U3RF02cMFXHs/EPSTLFYGXUZvp2SfGWZqLQ3qxyNpPklcfQPKkUO31ZMIdGEHq
         7iqBkani/G/m6gkMq0Mnm/CGMe2s0mSiQpMfj9oIHmHvFWZBRYvbvJ+7NkplROBYAYIm
         G+0aoSUAs4JVaouEbwZ9iqRrdlcWqLKjJOSfOjBwWxBsPnZ45s6tF+IfUwC4N3rcj+F6
         g1ZLpSpYWI0a1adJQCt3YvI2tdIPwjGbezabZEhB3UpY8VSKPL+ZLz0gWRTLYEmM7/6v
         GKyA==
X-Forwarded-Encrypted: i=1; AFNElJ+K1ydTGImIv+KlPhfJWYBHcQX1t3YJrnLORzsO6lUw5NQdKnYDGnOpyaxNChIoZa2CMXmIQL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXne9I7dkQX09y0LB33lVLx8EmehWbTaN5Tzrb1BqGLryt6YFx
	7ChJOjoNrfde08fY1FwLMMhGCa1RA0J3qXKExFSI3oKpqS41aCx6xDQp
X-Gm-Gg: Acq92OEoOiD38nPE3gTnjJune6tLRyh1JY0jqWAmEFnFRIZFYaGO5l2fJIJbsMbHhD9
	PCBoSlGmlozXyWKxKA7nIQiAPJup61XkejjvUKq+CqiScblGfXRVU77A4jW5x0OEYnRoui+XeZi
	S7w+HT+FKSZ6gwqNkJSvUuVWF1YrHBcxD9p0hRZxf7xZS4ZVyArTvjdVGr/5uyr7/J7UlaU903J
	YkOSo2D1sB8GjQTJiBEI5wBSONUz60WsgK57XJUZfqaAcOwSwdDJr43eAc5OJ6BnPllEChhLD+/
	zOnJk43gSoKHajpaOkqc3P2vFwsA6AXwbkxfwNGOTXx+FJsyRdKIx+Q4LKcISBbX5dgnjo5diRc
	Iut+zQiKy5+vYHeYt2pzfF3nvLnY8BabUx0YqgYqRuDR1ldHE5HsYnNr8E4gNAzmGQ+7IQcvrY8
	RFhHlkxpqiao/M2II3GkWrxyIn5WSd5dcxpP4an3UIB7MgiARho1sbQ2Ayc9HO1z+qb4HFgMk=
X-Received: by 2002:a05:600c:c11c:b0:488:c078:bfda with SMTP id 5b1f17b1804b1-48e706e0168mr158047415e9.26.1778593117302;
        Tue, 12 May 2026 06:38:37 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f540aecsm18062255e9.33.2026.05.12.06.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 06:38:37 -0700 (PDT)
Date: Tue, 12 May 2026 14:38:35 +0100
From: David Laight <david.laight.linux@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Hyunwoo Kim <imv4bel@gmail.com>, Marc Dionne
 <marc.dionne@auristor.com>, Jakub Kicinski <kuba@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org, Jeffrey Altman
 <jaltman@auristor.com>, Jiayuan Chen <jiayuan.chen@linux.dev>,
 stable@vger.kernel.org
Subject: Re: [PATCH net 2/3] rxrpc: Fix DATA decrypt vs splice() by copying
 data to buffer in recvmsg
Message-ID: <20260512143835.13af8bc4@pumpkin>
In-Reply-To: <20260511160753.607296-3-dhowells@redhat.com>
References: <20260511160753.607296-1-dhowells@redhat.com>
	<20260511160753.607296-3-dhowells@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6ECA25226BF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245589-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,auristor.com,kernel.org,davemloft.net,google.com,redhat.com,lists.infradead.org,linux.dev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,davemloft.net:email,auristor.com:email]
X-Rspamd-Action: no action

On Mon, 11 May 2026 17:07:48 +0100
David Howells <dhowells@redhat.com> wrote:

> This improves the fix for CVE-2026-43500.
> 
> Fix the pagecache corruption from in-place decryption of a DATA packet
> transmitted locally by splice() by getting rid of the packet sharing in the
> I/O thread and unconditionally extracting the packet content into a bounce
> buffer in which the buffer is decrypted.  recvmsg() (or the kernel
> equivalent) then copies the data from the bounce buffer to the destination
> buffer.  The sk_buff then remains unmodified.
> 
> This has an additional advantage in that the packet is then arranged in the
> buffer with the correct alignment required for the crypto algorithms to
> process directly.  The performance of the crypto does seem to be a little
> faster and, surprisingly, the unencrypted performance doesn't seem to
> change much - possibly due to removing complexity from the I/O thread.

Yep, avoiding data copies is overrated :-)

> Yet another advantage is that the I/O thread doesn't have to copy packets
> which would slow down packet distribution, ACK generation, etc..
> 
> The buffer belongs to the call and is allocated initially at 2K,
> sufficiently large to hold a whole jumbo subpacket, but the buffer will be
> increased in size if needed.  There is one downside here, and that's if a
> MSG_PEEK of more than one byte occurs, it may move on to the next packet,
> replacing the content of the buffer.  In such a case, it has to go back and
> re-decrypt the current packet.
> 
> Note that rx_pkt_offset may legitimately see 0 as a valid offset now, so
> switch to using USHRT_MAX to indicate an invalid offset.
> 
> Note also that I would generally prefer to replace the buffers of the
> current sk_buff with a new kmalloc'd buffer of the right size, ditching the
> old data and frags as this makes the handling of MSG_PEEK easier and
> removes the double-decryption issue, but this looks like quite a
> complicated thing to achieve.  skb_morph() looks half way to what I want,
> but I don't want to have to allocate a new sk_buff.

Wouldn't you need to do that anyway when the kkb is shared - or can't
that happen?

> 
> Fixes: d0d5c0cd1e71 ("rxrpc: Use skb_unshare() rather than skb_cow_data()")
> Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> Closes: https://lore.kernel.org/r/afKV2zGR6rrelPC7@v4bel/
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: Jeffrey Altman <jaltman@auristor.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Simon Horman <horms@kernel.org>
> cc: Jiayuan Chen <jiayuan.chen@linux.dev>
> cc: netdev@vger.kernel.org
> cc: linux-afs@lists.infradead.org
> cc: stable@vger.kernel.org
> ---
>  net/rxrpc/ar-internal.h |  7 +++-
>  net/rxrpc/call_event.c  | 22 +----------
>  net/rxrpc/call_object.c |  2 +
>  net/rxrpc/insecure.c    |  3 --
>  net/rxrpc/recvmsg.c     | 72 +++++++++++++++++++++++++++-------
>  net/rxrpc/rxgk.c        | 49 +++++++++++------------
>  net/rxrpc/rxgk_common.h | 79 +++++++++++++++++++++++++++++++++++++
>  net/rxrpc/rxkad.c       | 86 +++++++++++++++--------------------------
>  8 files changed, 200 insertions(+), 120 deletions(-)
> 
> diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
> index 27c2aa2dd023..783367eea798 100644
> --- a/net/rxrpc/ar-internal.h
> +++ b/net/rxrpc/ar-internal.h
> @@ -213,8 +213,6 @@ struct rxrpc_skb_priv {
>  		struct {
>  			u16		offset;		/* Offset of data */
>  			u16		len;		/* Length of data */
> -			u8		flags;
> -#define RXRPC_RX_VERIFIED	0x01
>  		};
>  		struct {
>  			rxrpc_seq_t	first_ack;	/* First packet in acks table */
> @@ -774,6 +772,11 @@ struct rxrpc_call {
>  	struct sk_buff_head	recvmsg_queue;	/* Queue of packets ready for recvmsg() */
>  	struct sk_buff_head	rx_queue;	/* Queue of packets for this call to receive */
>  	struct sk_buff_head	rx_oos_queue;	/* Queue of out of sequence packets */
> +	void			*rx_dec_buffer;	/* Decryption buffer */
> +	unsigned short		rx_dec_bsize;	/* rx_dec_buffer size */
> +	unsigned short		rx_dec_offset;	/* Decrypted packet data offset */
> +	unsigned short		rx_dec_len;	/* Decrypted packet data len */

Is it actually worth making those short rather than int?
I doubt the extra 4 bytes will matter and the generated code might be better.
(IIRC 32bit arm has a limited offset from 16 bit load/store, dunno about 64bit)

> +	rxrpc_seq_t		rx_dec_seq;	/* Packet in decryption buffer */
>  
>  	rxrpc_seq_t		rx_highest_seq;	/* Higest sequence number received */
>  	rxrpc_seq_t		rx_consumed;	/* Highest packet consumed */
> diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
> index 2b19b252225e..fec59d9338b9 100644
> --- a/net/rxrpc/call_event.c
> +++ b/net/rxrpc/call_event.c
> @@ -332,27 +332,7 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
>  
>  			saw_ack |= sp->hdr.type == RXRPC_PACKET_TYPE_ACK;
>  
> -			if (sp->hdr.type == RXRPC_PACKET_TYPE_DATA &&
> -			    sp->hdr.securityIndex != 0 &&
> -			    (skb_cloned(skb) ||
> -			     skb_has_frag_list(skb) ||
> -			     skb_has_shared_frag(skb))) {
> -				/* Unshare the packet so that it can be
> -				 * modified by in-place decryption.
> -				 */
> -				struct sk_buff *nskb = skb_copy(skb, GFP_ATOMIC);
> -
> -				if (nskb) {
> -					rxrpc_new_skb(nskb, rxrpc_skb_new_unshared);
> -					rxrpc_input_call_packet(call, nskb);
> -					rxrpc_free_skb(nskb, rxrpc_skb_put_call_rx);
> -				} else {
> -					/* OOM - Drop the packet. */
> -					rxrpc_see_skb(skb, rxrpc_skb_see_unshare_nomem);
> -				}
> -			} else {
> -				rxrpc_input_call_packet(call, skb);
> -			}
> +			rxrpc_input_call_packet(call, skb);
>  			rxrpc_free_skb(skb, rxrpc_skb_put_call_rx);
>  			did_receive = true;
>  		}
> diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
> index f035f486c139..fcb9d38bb521 100644
> --- a/net/rxrpc/call_object.c
> +++ b/net/rxrpc/call_object.c
> @@ -152,6 +152,7 @@ struct rxrpc_call *rxrpc_alloc_call(struct rxrpc_sock *rx, gfp_t gfp,
>  	spin_lock_init(&call->notify_lock);
>  	refcount_set(&call->ref, 1);
>  	call->debug_id		= debug_id;
> +	call->rx_pkt_offset	= USHRT_MAX;
>  	call->tx_total_len	= -1;
>  	call->tx_jumbo_max	= 1;
>  	call->next_rx_timo	= 20 * HZ;
> @@ -553,6 +554,7 @@ static void rxrpc_cleanup_rx_buffers(struct rxrpc_call *call)
>  	rxrpc_purge_queue(&call->recvmsg_queue);
>  	rxrpc_purge_queue(&call->rx_queue);
>  	rxrpc_purge_queue(&call->rx_oos_queue);
> +	kfree(call->rx_dec_buffer);
>  }
>  
>  /*
> diff --git a/net/rxrpc/insecure.c b/net/rxrpc/insecure.c
> index 0a260df45d25..7a26c6097d03 100644
> --- a/net/rxrpc/insecure.c
> +++ b/net/rxrpc/insecure.c
> @@ -32,9 +32,6 @@ static int none_secure_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
>  
>  static int none_verify_packet(struct rxrpc_call *call, struct sk_buff *skb)
>  {
> -	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
> -
> -	sp->flags |= RXRPC_RX_VERIFIED;
>  	return 0;
>  }
>  
> diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
> index e1f7513a46db..865e368381d5 100644
> --- a/net/rxrpc/recvmsg.c
> +++ b/net/rxrpc/recvmsg.c
> @@ -147,15 +147,55 @@ static void rxrpc_rotate_rx_window(struct rxrpc_call *call)
>  }
>  
>  /*
> - * Decrypt and verify a DATA packet.
> + * Decrypt and verify a DATA packet.  The content of the packet is pulled out
> + * into a flat buffer rather than decrypting in place in the skbuff.  This also
> + * has the advantage of aligning the buffer correctly for the crypto routines.
> + *
> + * We keep track of the sequence number of the packet currently decrypted into
> + * the buffer in ->rx_dec_seq.  Unfortunately, this means that a MSG_PEEK of
> + * more than one byte may cause a later packet to be decrypted into the buffer,
> + * requiring the original to be re-decrypted when recvmsg() is called again.
>   */
>  static int rxrpc_verify_data(struct rxrpc_call *call, struct sk_buff *skb)
>  {
>  	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
> +	int ret;
>  
> -	if (sp->flags & RXRPC_RX_VERIFIED)
> +	if (call->rx_dec_seq == sp->hdr.seq && call->rx_dec_buffer)
>  		return 0;
> -	return call->security->verify_packet(call, skb);
> +
> +	if (call->rx_dec_bsize < sp->len) {

IMHO That test is backwards; the 'more constant' value should be on the right.

> +		/* Make sure we can hold a 1412-byte jumbo subpacket and make
> +		 * sure that the buffer size is aligned to a crypto blocksize.
> +		 */
> +		size_t size = umin(round_up(sp->len, 32), 2048);

Doesn't min() work?

> +		void *buffer = krealloc(call->rx_dec_buffer, size, GFP_NOFS);
> +
> +		if (!buffer)
> +			return -ENOMEM;
> +		call->rx_dec_buffer = buffer;
> +		call->rx_dec_bsize = size;
> +	}

That doesn't look right.
If sp->len is bigger than 2048 the you keep allocating a new buffer
and the call below overruns the allocated buffer.

> +
> +	ret = -EFAULT;
> +	if (skb_copy_bits(skb, sp->offset, call->rx_dec_buffer, sp->len) < 0)
> +		goto err;
> +
...

-- David

