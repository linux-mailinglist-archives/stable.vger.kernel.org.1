Return-Path: <stable+bounces-240467-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCNRFWwE6mk/rQIAu9opvQ
	(envelope-from <stable+bounces-240467-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 13:37:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B89CC4515C8
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 13:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7CA83014C77
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 11:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BF53E928E;
	Thu, 23 Apr 2026 11:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s/ZRLaIQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64E43E9594;
	Thu, 23 Apr 2026 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776944231; cv=none; b=nOE0pYPddf+htjQnu2va5TqESe8pHeYlY1aRkCbQeFhm9NBVIm6GGEghJM5UkGUjC85TlMtUMG5Mbr5jJyknVARLJ02YDcEOfMDy2mcS6VJ0O2JNXwrmcpEQauwDO2bhx58uakjPpFVkx43Y4EHPF5TztyUy3gB3ln3LxfFcpJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776944231; c=relaxed/simple;
	bh=m9/JFjgzTqhPrqkzyzm6cCd274LhVOdNJDyQamWher0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3OjXKCsVoOoocdm5RNiYFoxQ9AThtVrJt5RF/fTHgYCIyH8YrbhX69+lnW0Tdb2spWw+hzN5EjfuwRBdea+YVKIC33YZTUzg6ZzYyI+Pz/8v2K0EH3oFgYsXx/mxi0+3ve0aLzljveD5JWght6MxsGSPUYlKWPTYvuVdpFIqGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s/ZRLaIQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFB7C2BCB3;
	Thu, 23 Apr 2026 11:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776944230;
	bh=m9/JFjgzTqhPrqkzyzm6cCd274LhVOdNJDyQamWher0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s/ZRLaIQxgCzrhu9ur4Du3FBYhj3jx2jfYPwgSR724mAVnys5xFRujLH5Gttw1SHW
	 n+LH5eeOeGkoCPaHs/UqkfyGxfpfif1/7JZETdfPUEYJjd9A9a6ZrlTLO91xADKuHr
	 gBIlpKVtxHURa5vRGxdj5mwPoIVpSt/nwA2IAalc=
Date: Thu, 23 Apr 2026 13:37:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Johnny Hao <johnny_haocn@sina.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexey Nepomnyashih <sdl@nppct.ru>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 5.15.y] xen-netfront: handle NULL returned by
 xdp_convert_buff_to_frame()
Message-ID: <2026042315-moonshine-enticing-be37@gregkh>
References: <20260327055950.2618928-1-johnny_haocn@sina.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327055950.2618928-1-johnny_haocn@sina.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[sina.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240467-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nppct.ru:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: B89CC4515C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 01:59:50PM +0800, Johnny Hao wrote:
> From: Alexey Nepomnyashih <sdl@nppct.ru>
> 
> [ Upstream commit cc3628dcd851ddd8d418bf0c897024b4621ddc92 ]
> 
> The function xdp_convert_buff_to_frame() may return NULL if it fails
> to correctly convert the XDP buffer into an XDP frame due to memory
> constraints, internal errors, or invalid data. Failing to check for NULL
> may lead to a NULL pointer dereference if the result is used later in
> processing, potentially causing crashes, data corruption, or undefined
> behavior.
> 
> On XDP redirect failure, the associated page must be released explicitly
> if it was previously retained via get_page(). Failing to do so may result
> in a memory leak, as the pages reference count is not decremented.
> 
> Cc: stable@vger.kernel.org # v5.9+
> Fixes: 6c5aa6fc4def ("xen networking: add basic XDP support for xen-netfront")
> Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
> Link: https://patch.msgid.link/20250417122118.1009824-1-sdl@nppct.ru
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Johnny Hao <johnny_haocn@sina.com>
> ---
>  drivers/net/xen-netfront.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
> index 4b19d54fa2e2..310bc1f7d404 100644
> --- a/drivers/net/xen-netfront.c
> +++ b/drivers/net/xen-netfront.c
> @@ -982,20 +982,27 @@ static u32 xennet_run_xdp(struct netfront_queue *queue, struct page *pdata,
>  	act = bpf_prog_run_xdp(prog, xdp);
>  	switch (act) {
>  	case XDP_TX:
> -		get_page(pdata);
>  		xdpf = xdp_convert_buff_to_frame(xdp);
> +		if (unlikely(!xdpf)) {
> +			trace_xdp_exception(queue->info->netdev, prog, act);
> +			break;
> +		}
> +		get_page(pdata);
>  		err = xennet_xdp_xmit(queue->info->netdev, 1, &xdpf, 0);
> -		if (unlikely(!err))
> +		if (unlikely(err <= 0)) {
> +			if (err < 0)
> +				trace_xdp_exception(queue->info->netdev, prog, act);
>  			xdp_return_frame_rx_napi(xdpf);
> -		else if (unlikely(err < 0))
> -			trace_xdp_exception(queue->info->netdev, prog, act);
> +		}
>  		break;
>  	case XDP_REDIRECT:
>  		get_page(pdata);
>  		err = xdp_do_redirect(queue->info->netdev, xdp, prog);
>  		*need_xdp_flush = true;
> -		if (unlikely(err))
> +		if (unlikely(err)) {
>  			trace_xdp_exception(queue->info->netdev, prog, act);
> +			xdp_return_buff(xdp);
> +		}
>  		break;
>  	case XDP_PASS:
>  	case XDP_DROP:
> -- 
> 2.34.1
> 

Breaks the build:
	ERROR: modpost: "xdp_return_buff" [drivers/net/xen-netfront.ko] undefined!



