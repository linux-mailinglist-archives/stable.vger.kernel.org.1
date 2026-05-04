Return-Path: <stable+bounces-243004-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCa/Fk2L+Gl+wQIAu9opvQ
	(envelope-from <stable+bounces-243004-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 14:04:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B37944BCBB8
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 14:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 018353011772
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 12:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2733CCFD6;
	Mon,  4 May 2026 12:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2jnVR/8u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3AB3CCFCE
	for <stable@vger.kernel.org>; Mon,  4 May 2026 12:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777896264; cv=none; b=hLBHKR6aft4Ci21ivf8KeRs//Ge3t3Rvhkg40lguVMwC7/trzeJc9BwCnnfc7anmmlOM8s+0ow0HYsnPjrTxjnBPG0mgtMHeqB153EOHaRR+NAlSNpZfay+/8RkWSZlz1O5bdC2WHnRkumx1tbzssNcYyIJLaXwxvnRRwoceq6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777896264; c=relaxed/simple;
	bh=hVQz1V4X201otwbV2q4Yc0zTy7v6Mfu5G9sTDmbwpXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbiqxnPIlM8d258ImBy1P7qXmb+gIT6qGM7SxMIrfk2tPdiX5yhZFfWl4w7gb6wjWinJyrxuxJdXb57/2SvPpjH5YTjp+72ekle3sTT3e1MHCWlZXzXiztoe+CRhKm+Ds5hCKgaPVXgwLuYDOzUzgtnw0zB6LM/A7Vk+5KJNduE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2jnVR/8u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8662C2BCB8;
	Mon,  4 May 2026 12:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777896264;
	bh=hVQz1V4X201otwbV2q4Yc0zTy7v6Mfu5G9sTDmbwpXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2jnVR/8uFCtFuJmfkvASBuHjhqbpvNmmk5lKBTx7U9nHAY1CkAEsce/HVtKZgtFQm
	 p17qNgRmdu6YBQ1a+1/u0+ntYJPZnnp3SeFGK1ZYFgrHsRYWxQdtMdQ+zbnznF2OmS
	 pddLYcENX8VUIe3etXHHgIk6ob8jypqfQFcbS4Z0=
Date: Mon, 4 May 2026 14:04:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
	stable@kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.12.y] rxrpc: Fix conn-level packet handling to unshare
 RESPONSE packets
Message-ID: <2026050415-program-rejoicing-0c01@gregkh>
References: <2026050142-gag-tasting-5084@gregkh>
 <20260503141723.1081399-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503141723.1081399-1-sashal@kernel.org>
X-Rspamd-Queue-Id: B37944BCBB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-243004-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,msgid.link:url,linuxfoundation.org:dkim,sashiko.dev:url]

On Sun, May 03, 2026 at 10:17:23AM -0400, Sasha Levin wrote:
> From: David Howells <dhowells@redhat.com>
> 
> [ Upstream commit 24481a7f573305706054c59e275371f8d0fe919f ]
> 
> The security operations that verify the RESPONSE packets decrypt bits of it
> in place - however, the sk_buff may be shared with a packet sniffer, which
> would lead to the sniffer seeing an apparently corrupt packet (actually
> decrypted).
> 
> Fix this by handing a copy of the packet off to the specific security
> handler if the packet was cloned.
> 
> Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
> Closes: https://sashiko.dev/#/patchset/20260408121252.2249051-1-dhowells%40redhat.com
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: Jeffrey Altman <jaltman@auristor.com>
> cc: Simon Horman <horms@kernel.org>
> cc: linux-afs@lists.infradead.org
> cc: stable@kernel.org
> Link: https://patch.msgid.link/20260422161438.2593376-5-dhowells@redhat.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  include/trace/events/rxrpc.h |  2 ++
>  net/rxrpc/conn_event.c       | 29 ++++++++++++++++++++++++++++-
>  2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
> index 3eb806f7bc6a5..c5533176d770d 100644
> --- a/include/trace/events/rxrpc.h
> +++ b/include/trace/events/rxrpc.h
> @@ -146,12 +146,14 @@
>  	EM(rxrpc_skb_put_jumbo_subpacket,	"PUT jumbo-sub") \
>  	EM(rxrpc_skb_put_last_nack,		"PUT last-nack") \
>  	EM(rxrpc_skb_put_purge,			"PUT purge    ") \
> +	EM(rxrpc_skb_put_response_copy,		"PUT resp-cpy ") \
>  	EM(rxrpc_skb_put_rotate,		"PUT rotate   ") \
>  	EM(rxrpc_skb_put_unknown,		"PUT unknown  ") \
>  	EM(rxrpc_skb_see_conn_work,		"SEE conn-work") \
>  	EM(rxrpc_skb_see_recvmsg,		"SEE recvmsg  ") \
>  	EM(rxrpc_skb_see_reject,		"SEE reject   ") \
>  	EM(rxrpc_skb_see_rotate,		"SEE rotate   ") \
> +	EM(rxrpc_skb_see_unshare_nomem,		"SEE unshar-nm") \
>  	E_(rxrpc_skb_see_version,		"SEE version  ")
>  
>  #define rxrpc_local_traces \
> diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
> index 6ef2dc1aa8cc2..6d7b064661d88 100644
> --- a/net/rxrpc/conn_event.c
> +++ b/net/rxrpc/conn_event.c
> @@ -226,6 +226,33 @@ static void rxrpc_call_is_secure(struct rxrpc_call *call)
>  		rxrpc_notify_socket(call);
>  }
>  
> +static int rxrpc_verify_response(struct rxrpc_connection *conn,
> +				 struct sk_buff *skb)
> +{
> +	int ret;
> +
> +	if (skb_cloned(skb)) {
> +		/* Copy the packet if shared so that we can do in-place
> +		 * decryption.
> +		 */
> +		struct sk_buff *nskb = skb_copy(skb, GFP_NOFS);
> +
> +		if (nskb) {
> +			rxrpc_new_skb(nskb, rxrpc_skb_new_unshared);
> +			ret = conn->security->verify_response(conn, nskb);
> +			rxrpc_free_skb(nskb, rxrpc_skb_put_response_copy);
> +		} else {
> +			/* OOM - Drop the packet. */
> +			rxrpc_see_skb(skb, rxrpc_skb_see_unshare_nomem);
> +			ret = -ENOMEM;
> +		}
> +	} else {
> +		ret = conn->security->verify_response(conn, skb);
> +	}
> +
> +	return ret;
> +}
> +
>  /*
>   * connection-level Rx packet processor
>   */
> @@ -253,7 +280,7 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
>  		}
>  		spin_unlock(&conn->state_lock);
>  
> -		ret = conn->security->verify_response(conn, skb);
> +		ret = rxrpc_verify_response(conn, skb);
>  		if (ret < 0)
>  			return ret;
>  
> -- 
> 2.53.0
> 
> 

Does not apply :(

