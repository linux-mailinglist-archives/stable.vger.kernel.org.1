Return-Path: <stable+bounces-230527-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEy/BUmRxWlG/QQAu9opvQ
	(envelope-from <stable+bounces-230527-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 21:04:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1D033B394
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 21:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC42F30107F9
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 20:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9F834C815;
	Thu, 26 Mar 2026 20:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhhP0pHm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC740823DD;
	Thu, 26 Mar 2026 20:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774555297; cv=none; b=isqGwJq3V86uCMi4SxXoaamdSG/yNpyW6lTWWJhV7rxybH42AzLSyzmNrUG+HAw5E/XrAfyuYTj91ECbEFYznVHY9kbIAP6wEOqzo144o/1B+RlxxRBO/5xZ1Vo8e/usmrG4avxadriIoAnP2df03zz7HqfyQ8h1cPu6u35pNc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774555297; c=relaxed/simple;
	bh=jK7Uvx3qiOAu88aK2LbmX3iGTbCOWx9vtglc4wZEfmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5lM1eC7Y0fUWIXCuRzeDserJS0BHqzdHMig8hiqCmmTg7hKG5cxOyduJKCLtcsUS+lcKmVTdtqFYWfUZ0Bf1EjJPvGRzZ2mjvILSd9/LAgeQlYy50LbcoIHYB7f45lmbC9BYiCL+5Z7oECKPK2/keluZKZJ0TuzPYjRC+7uKS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhhP0pHm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3992C116C6;
	Thu, 26 Mar 2026 20:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774555297;
	bh=jK7Uvx3qiOAu88aK2LbmX3iGTbCOWx9vtglc4wZEfmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BhhP0pHmQ1930LlWJ/7fsGD/Ip+YzH2+XKpDAQBLBM47n4SN1xoADzPTcAhZDsKTj
	 IUqMLhx2+cg5dDxavXaI+smA/+4OWqNTx0TkykCbCngE7zAiZ3Ad7q51aqq7D+8LNC
	 hmkMZZKBk033v1XdoVsPbyCCEl92y+eEcaO8jI9ETenZD3m+5S9D8K2Z3WC5OZx8cc
	 5JUHh1aQ5OMs39OMaNoXUWzGySAfAVcvW8b1Mk4phXoHyGHw+G+eQqYdb6TxRW+dtl
	 urcY2Z20SMZahpFHmMdFJILhU2Pkjpn2zz7aiyCFcB9p6f00IveR4GJ6Sl/KWB8+LL
	 aLkBVjRkCA8vg==
Date: Thu, 26 Mar 2026 20:01:33 +0000
From: Simon Horman <horms@kernel.org>
To: Oleh Konko <security@1seal.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH net] nfc: llcp: fix tlv offset wrap and missing bounds
 checks
Message-ID: <20260326200133.GX111839@horms.kernel.org>
References: <463598db3dea48fc963e8431181ae68a.security@1.0.0.127.in-addr.arpa>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <463598db3dea48fc963e8431181ae68a.security@1.0.0.127.in-addr.arpa>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-230527-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,1seal.org:email]
X-Rspamd-Queue-Id: 8C1D033B394
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 09:25:41PM +0000, Oleh Konko wrote:
> nfc_llcp_parse_gb_tlv() and nfc_llcp_parse_connection_tlv() iterate a
> u16 tlv_array_len with a u8 offset. once cumulative TLV consumption
> crosses 255 bytes, offset wraps and the loop may continue past the
> declared TLV array bounds.
> 
> both parsers also read tlv[1] before checking that a full 2-byte TLV
> header remains, and they advance by length + 2 without validating that
> the declared payload still fits in the remaining array.
> 
> fix this by widening offset to u16 and by rejecting incomplete headers
> or truncated TLVs before dereferencing or advancing the cursor.

This patch seems to fix two problems.  It's usually best to fix one problem
per patch, creating a patch-set with two or more patches and a cover letter
if necessary.

> 
> Fixes: d646960f7986 ("NFC: Initial LLCP support")
> Cc: stable@vger.kernel.org
> Reported-by: Oleh Konko <security@1seal.org>
> Signed-off-by: Oleh Konko <security@1seal.org>

This patch seems to have been sent twice in about half an hour.
Please don't do that.

Rather, please observe a pause of 24h between sending updated
revisions of a patch.

Link: https://docs.kernel.org/process/maintainer-netdev.html

> ---
>  net/nfc/llcp_commands.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
> index 291f26fac..157afd62f 100644
> --- a/net/nfc/llcp_commands.c
> +++ b/net/nfc/llcp_commands.c
> @@ -193,7 +193,8 @@ int nfc_llcp_parse_gb_tlv(struct nfc_llcp_local *local,
>  			  const u8 *tlv_array, u16 tlv_array_len)
>  {
>  	const u8 *tlv = tlv_array;
> -	u8 type, length, offset = 0;
> +	u8 type, length;
> +	u16 offset = 0;

It seems to me that the value passed to this function by the caller,
nfc_llcp_set_remote_gb(), is limited to a maximum value of 255 - 3 by
virtue of being a u8 with 3 subtracted. So I'm not sure that offset
can overflow here.

For consistency with other parts of this call-chain
it might be worth changing the type of tlv_array_len to u8.
But that would be a clean-up for net-next rather than a fix for net.

>  
>  	pr_debug("TLV array length %d\n", tlv_array_len);
>  
> @@ -201,6 +202,9 @@ int nfc_llcp_parse_gb_tlv(struct nfc_llcp_local *local,
>  		return -ENODEV;
>  
>  	while (offset < tlv_array_len) {
> +		if (tlv_array_len - offset < 2)
> +			return -EINVAL;
> +
>  		type = tlv[0];
>  		length = tlv[1];
>  
> @@ -227,6 +231,9 @@ int nfc_llcp_parse_gb_tlv(struct nfc_llcp_local *local,
>  			break;
>  		}
>  
> +		if (tlv_array_len - offset < (u16)length + 2)
> +			return -EINVAL;
> +
>  		offset += length + 2;
>  		tlv += length + 2;
>  	}
> @@ -243,7 +250,8 @@ int nfc_llcp_parse_connection_tlv(struct nfc_llcp_sock *sock,
>  				  const u8 *tlv_array, u16 tlv_array_len)
>  {
>  	const u8 *tlv = tlv_array;
> -	u8 type, length, offset = 0;
> +	u8 type, length;
> +	u16 offset = 0;

In this case the callers pass skb->ken as tlv_array_len.
As skb->len is an unsigned int in theory it might overflow
the u16 used for tlv_array_len. But perhaps in practice that
doesn't occur?

In any case, if you are going to update the type of offset, then
I would just change the type of type, length and offset to unsigned int.
I don't see a value in using narrower types here.

>  
>  	pr_debug("TLV array length %d\n", tlv_array_len);
>  
> @@ -251,6 +259,9 @@ int nfc_llcp_parse_connection_tlv(struct nfc_llcp_sock *sock,
>  		return -ENOTCONN;
>  
>  	while (offset < tlv_array_len) {
> +		if (tlv_array_len - offset < 2)
> +			return -EINVAL;
> +
>  		type = tlv[0];
>  		length = tlv[1];
>  
> @@ -270,6 +281,9 @@ int nfc_llcp_parse_connection_tlv(struct nfc_llcp_sock *sock,
>  			break;
>  		}
>  
> +		if (tlv_array_len - offset < (u16)length + 2)
> +			return -EINVAL;
> +
>  		offset += length + 2;
>  		tlv += length + 2;
>  	}
> -- 
> 2.50.0
> 

