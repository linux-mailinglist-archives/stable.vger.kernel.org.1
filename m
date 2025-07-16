Return-Path: <stable+bounces-163194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEF0B07D4C
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 21:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ADFA580DF5
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 19:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C36628A406;
	Wed, 16 Jul 2025 19:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ES2aZlZX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D13262FE4;
	Wed, 16 Jul 2025 19:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752692406; cv=none; b=dpHDSta4jiog1PlDpenKDSOHeNeQG6gRPkVRdZKnWPYlZmvT4vJFHHuQbQZAQzMub1wrV2BjnBFN43K76yCBC0p4gV4/thNepK0zq5fVeS/mfqmQLFlic1ofPkiyD24i1WaIGsw0YpOUddvQaErsGFaTWUjJX+s5ufpV13tuAsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752692406; c=relaxed/simple;
	bh=p2+4mqzxD3sDrSRSR0HQQ+5Xty+gSI5dRJC0NlwYk18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSat83lbC8vCoS5cUOFR2ZDf0WIGGiifLg+qpVtSkoK1lfmrxnsmaeS5Bvz+HcXP+Herplk/glkMbtVp/r+J/TMPYSkMyTK5yv2uc4lZt39lcGg7n0uwpoY8nbiIamJoYSKckbjgjjXLtSF0Znp+YNjgQzQ5T4+HLZkiWQfF0bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ES2aZlZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0DFC4CEE7;
	Wed, 16 Jul 2025 19:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752692406;
	bh=p2+4mqzxD3sDrSRSR0HQQ+5Xty+gSI5dRJC0NlwYk18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ES2aZlZXOdejVK3HMuuPryg8FNHMpK7gBm4VfINlG1DO0gn157INFfhfIB5Yzz7NK
	 GFV58NkaQLccxWfFs3UmhtRn3OZvRWkM2kqEKhoQfTxs2F4ZwqHhtpllOb0v0zlG6k
	 yPjIZq6xpYtX1aZNIdHmpH0wzCYb9F52ep/t72T0a3GWcm22jPXLZFZw2JqSThASQF
	 i8u1/OGekD5+xJc50GG2iVqIfgvyliSX6d3DwDUdDHXuzcPJaIPnUSg0/M3QEBu3GN
	 4kV7921M8D1K/FgSymJHzgLCJcAoCVJhVQd23ak++ET8Hht0jbmczQg6aCnFakFLhL
	 MW4c47ovoG8Hw==
Date: Wed, 16 Jul 2025 20:00:01 +0100
From: Simon Horman <horms@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jeffrey Altman <jaltman@auristor.com>,
	"Junvyyang, Tencent Zhuque Lab" <zhuque@tencent.com>,
	LePremierHomme <kwqcheii@proton.me>, stable@vger.kernel.org
Subject: Re: [PATCH net 3/5] rxrpc: Fix notification vs call-release vs
 recvmsg
Message-ID: <20250716190001.GR721198@horms.kernel.org>
References: <20250716115307.3572606-1-dhowells@redhat.com>
 <20250716115307.3572606-4-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716115307.3572606-4-dhowells@redhat.com>

On Wed, Jul 16, 2025 at 12:53:02PM +0100, David Howells wrote:
> When a call is released, rxrpc takes the spinlock and removes it from
> ->recvmsg_q in an effort to prevent racing recvmsg() invocations from
> seeing the same call.  Now, rxrpc_recvmsg() only takes the spinlock when
> actually removing a call from the queue; it doesn't, however, take it in
> the lead up to that when it checks to see if the queue is empty.  It *does*
> hold the socket lock, which prevents a recvmsg/recvmsg race - but this
> doesn't prevent sendmsg from ending the call because sendmsg() drops the
> socket lock and relies on the call->user_mutex.
> 
> Fix this by firstly removing the bit in rxrpc_release_call() that dequeues
> the released call and, instead, rely on recvmsg() to simply discard
> released calls (done in a preceding fix).
> 
> Secondly, rxrpc_notify_socket() is abandoned if the call is already marked
> as released rather than trying to be clever by setting both pointers in
> call->recvmsg_link to NULL to trick list_empty().  This isn't perfect and
> can still race, resulting in a released call on the queue, but recvmsg()
> will now clean that up.
> 
> Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Jeffrey Altman <jaltman@auristor.com>

...

> diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c

...

> @@ -638,6 +628,12 @@ void rxrpc_release_calls_on_socket(struct rxrpc_sock *rx)
>  		rxrpc_put_call(call, rxrpc_call_put_release_sock);
>  	}
>  
> +	while ((call = list_first_entry_or_null(&rx->recvmsg_q,
> +						struct rxrpc_call, recvmsg_link))) {
> +		list_del_init(&call->recvmsg_link);
> +		rxrpc_put_call(call, rxrpc_call_put_release_recvmsg_q);
> +	}
> +
>  	_leave("");
>  }
>  

Hi David,

I believe it is addressed in patch 5/5.
But unfortunately this change breaks bisection.

  .../call_object.c:634:24: error: use of undeclared identifier 'rxrpc_call_put_release_recvmsg_q'
    634 |                 rxrpc_put_call(call, rxrpc_call_put_release_recvmsg_q);
        |                                      ^

-- 
pw-bot: changes-requested


