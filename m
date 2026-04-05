Return-Path: <stable+bounces-233315-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKFzIXP20WkkRwcAu9opvQ
	(envelope-from <stable+bounces-233315-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 07:43:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D976F39D6CB
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 07:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2DAF3008529
	for <lists+stable@lfdr.de>; Sun,  5 Apr 2026 05:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3F3285417;
	Sun,  5 Apr 2026 05:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GEJOYesf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F853537E9
	for <stable@vger.kernel.org>; Sun,  5 Apr 2026 05:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775367790; cv=none; b=C2rOOujzoFGZiTBQIQgP7M3syt17TnLwrlklZ72u5WvHE6jbBp6mWCSdmUYmr/XS0SO6J5AMtZeD8TPzuhYm1VlhTq3PkIGZuJE4jaQ3UroEo/X5S++Su+DISpi67Nb0/VyVuLVHCRxWPr3499fY0UbzHnYZw3d7r4ZC9u4KCvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775367790; c=relaxed/simple;
	bh=+NkcE9OxAav+MOqdZFQZlUPUUKRzpwVFH7SG0qYzxMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8LR16P+H9GfZe25YU1PZL8hHWQ74oyrtWy5jhFBhTp1UzJ1K5nYjT1IBOq+Wmn5ZH96IebjVwyqqU8TRtoKq31KpHgmqSX2FaIls9qdgxHXlIqPepSbSdmkWJorImgkSyg2Ax/pibX29D/DjUZ9QPZbbxwXM63ddZXAQIl0soo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GEJOYesf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEE9C116C6;
	Sun,  5 Apr 2026 05:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775367789;
	bh=+NkcE9OxAav+MOqdZFQZlUPUUKRzpwVFH7SG0qYzxMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GEJOYesfZt7DFC9aS8ylDxTcRd2VI1QV7dL4vZv11yhvtQ0D3WIFXRjlQhnM4UeT0
	 kBOgB3QrEnoRZTpe0nzT8shS6Cfqlnu4CtUQVU5uf+oCu49pIgsckrSOo1OCh+2LRN
	 bE1G5I5TPORSlBYzF+mc/V3boS+QvgRb0v/VqAI4=
Date: Sun, 5 Apr 2026 07:42:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Delene Tchio Romuald <delenetchior1@gmail.com>
Cc: security@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix heap buffer overflow in
 recvframe_defrag()
Message-ID: <2026040547-implicit-dimmer-9a7b@gregkh>
References: <20260404211142.53071-1-delenetchior1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404211142.53071-1-delenetchior1@gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233315-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.990];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: D976F39D6CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 04, 2026 at 10:11:41PM +0100, Delene Tchio Romuald wrote:
> In recvframe_defrag(), a memcpy() copies fragment data into the
> reassembly buffer before recvframe_put() validates that the buffer
> has sufficient space. If the total reassembled payload exceeds the
> receive buffer capacity, this results in a heap buffer overflow.
> 
> An attacker within WiFi radio range can exploit this by sending
> crafted 802.11 fragmented frames. No authentication is required.
> 
> Add a bounds check before the memcpy() to verify that the fragment
> payload fits within the remaining buffer space, using the same error
> handling pattern already present in the function.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Delene Tchio Romuald <delenetchior1@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_recv.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
> index 337671b12..901f4b1ff 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_recv.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
> @@ -1132,7 +1132,13 @@ static union recv_frame *recvframe_defrag(struct adapter *adapter,
>  		/* append  to first fragment frame's tail (if privacy frame, pull the ICV) */
>  		recvframe_pull_tail(prframe, pfhdr->attrib.icv_len);
>  
> -		/* memcpy */
> +		/* Verify the receiving buffer has enough space for the fragment */
> +		if (pnfhdr->len > (uint)(pfhdr->rx_end - pfhdr->rx_tail)) {
> +			rtw_free_recvframe(prframe, pfree_recv_queue);
> +			rtw_free_recvframe_queue(defrag_q, pfree_recv_queue);
> +			return NULL;
> +		}
> +
>  		memcpy(pfhdr->rx_tail, pnfhdr->rx_data, pnfhdr->len);
>  
>  		recvframe_put(prframe, pnfhdr->len);
> -- 
> 2.43.0
> 
> 

As you sent this to a public list, can you resend it to the proper set
that scripts/get_maintainer.pl shows to use?

Also, do you have this hardware to test this change (and the other
changes you made to this driver)?

And finally, how did you find this problem?

thanks,

greg k-h

