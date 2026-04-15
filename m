Return-Path: <stable+bounces-238149-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKp7FUW132lCXwAAu9opvQ
	(envelope-from <stable+bounces-238149-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 17:56:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 008D940625A
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 17:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DA293027103
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 15:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2E83E3C6B;
	Wed, 15 Apr 2026 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QV/84CX3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F46C3E3C5E;
	Wed, 15 Apr 2026 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776268604; cv=none; b=SdapKcD0q0E9S46civvmJF/mNKxwrW+Osx+icFTOc3LelwovSKr16BPTDq80wwtbkxQmOhPiajze7S4ipjaA51V6FtBJPmkZZP5cyEO+LJBSXxfxmeYNql+5PA1elJbHuhLyO0XXLgeiFxR+kStlAFOROHHVxPQTijk6YVqxd4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776268604; c=relaxed/simple;
	bh=3U/D4UJ1AZ9cCh8oZwiYyTzVpVp39NmKWBMFwFLnlzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eiNy6+RQjKR8RiivrGfOcIe0fnPJ1uXOXL4wBkfW1qdIF1aeuqAbwq6SfP9hxe7omfSCF+I8AbX12swWEL/iu8bVb6V8jhWQ9bjIHrINIfYuvtLn4JF8WxjTAbpaztkyPZliflGEfVwJU/vps94fw3rmf7pm4HStN72ieADf0Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QV/84CX3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581D0C19424;
	Wed, 15 Apr 2026 15:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776268603;
	bh=3U/D4UJ1AZ9cCh8oZwiYyTzVpVp39NmKWBMFwFLnlzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QV/84CX3NyG5jxXjtSz99+7b5OTHRS6jNngo1dhG0kVggGlohmtFEOkQ2f/GA3gQl
	 dzfSAKjc7EvwV83P/sCfhESNbBJq8DNej/jEoBGPmVBXptUgcHJ9PcWxaPrpMQl3rw
	 cZ0Ropt7TzzuAzuSZ7zYaGMm/6tCg9AvDTH75/nk/FKikfKrK1+HbFSsBeJ1XbVgRr
	 +GFaDLXxDFOoiLGJS0xU3m5Nxw3eQgIqRb+DfqlPJ+bPBvBVJMiTYg+29AuOnSgutB
	 7H/vDnT/67IIewRYqkDhv/PRzAMilTVmewChPAWbtF3UWL90/DVtfbWGiQT+w6SDdR
	 0flumdLzU3Gmw==
From: Simon Horman <horms@kernel.org>
To: mashiro.chen@mailbox.org
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jreuter@yaina.de,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: ax25: fix integer overflow in ax25_rx_fragment()
Date: Wed, 15 Apr 2026 16:56:17 +0100
Message-ID: <20260415155616.826085-2-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408172521.281365-1-mashiro.chen@mailbox.org>
References: <20260408172521.281365-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238149-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 008D940625A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: ax25: fix integer overflow in ax25_rx_fragment()

This commit addresses an integer overflow in the ax25_cb fragmentation
reassembly accumulator. It adds a check to ensure the combined payload
of fragments does not exceed USHRT_MAX. If the limit is exceeded, the
fragment queue is purged to prevent allocating a tiny buffer that leads
to a panic.

> Every skb_put() call in the copy loop
> that follows writes far beyond the allocated headroom, corrupting
> the kernel heap.

Is this description accurate?

skb_put() explicitly performs strict bounds checking and triggers a
deterministic kernel panic via skb_over_panic() if exceeded, rather than
silently corrupting the heap.

> Fix mirrors the identical bug fixed in NET/ROM (nr_in.c):

This isn't a bug, but is this the correct file reference? The check for
USHRT_MAX actually appears to exist in X.25 (x25_in.c), not NET/ROM.

> diff --git a/net/ax25/ax25_in.c b/net/ax25/ax25_in.c
> index d75b3e9ed93de..68202c19b19e3 100644
> --- a/net/ax25/ax25_in.c
> +++ b/net/ax25/ax25_in.c
> @@ -41,6 +41,11 @@ static int ax25_rx_fragment(ax25_cb *ax25, struct sk_buff *skb)
>  				/* Enqueue fragment */
>  				ax25->fragno = *skb->data & AX25_SEG_REM;
>  				skb_pull(skb, 1);	/* skip fragno */
> +				if ((unsigned int)ax25->fraglen + skb->len > USHRT_MAX) {

Is there a race condition with ax25->fraglen here?

If fragments for the same connection arrive concurrently on different CPUs,
both could evaluate this bounds check as safe and then concurrently add
their lengths.

> +					skb_queue_purge(&ax25->frag_queue);
> +					ax25->fragno = 0;
> +					return 1;

Does this code leak the skb?

When returning 1 here, the caller might skip freeing the skb because it
assumes the packet was successfully consumed or queued.

Could we explicitly call kfree_skb(skb) before returning 1, or return 0 to
instruct the caller to free it?

> +				}
>  				ax25->fraglen += skb->len;
>  				skb_queue_tail(&ax25->frag_queue, skb);

[ ... ]

>  					/* Copy data from the fragments */
>  					while ((skbo = skb_dequeue(&ax25->frag_queue)) != NULL) {
>  						skb_copy_from_linear_data(skbo,
>  							  skb_put(skbn, skbo->len),
>  									  skbo->len);

Could this read past the end of the skbo->data buffer if the fragment is
non-linear?

If the skb has paged data, skbo->len exceeds the linearly mapped data size,
which might trigger a panic or leak adjacent memory into the reassembled
packet.

Should this use skb_copy_bits() instead?

[ ... ]

>  	} else {
>  		/* First fragment received */
>  		if (*skb->data & AX25_SEG_FIRST) {
>  			skb_queue_purge(&ax25->frag_queue);
>  			ax25->fragno = *skb->data & AX25_SEG_REM;
>  			skb_pull(skb, 1);		/* skip fragno */
>  			ax25->fraglen = skb->len;

Is there a possibility of truncating the length here?

Since ax25->fraglen is an unsigned short, if a first fragment arrives with
skb->len > USHRT_MAX, it might be silently truncated.

Subsequent continuation fragments will be validated against this artificially
small fraglen, bypassing the new USHRT_MAX check.

Should the bounds check be applied to the first fragment as well?

>  			skb_queue_tail(&ax25->frag_queue, skb);
>  			return 1;
>  		}
>  	}

