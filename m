Return-Path: <stable+bounces-214758-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLmqFH0th2kyUwQAu9opvQ
	(envelope-from <stable+bounces-214758-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 13:18:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7B4105D78
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 13:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80ECC3014437
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 12:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F53313550;
	Sat,  7 Feb 2026 12:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UdW5glPZ"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B020E3033F5;
	Sat,  7 Feb 2026 12:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770466679; cv=none; b=tMsYw/MVChlZvXPzggPXlDYRRNSCydR8MNQBqs6c7ECG1ePGGLexEG/Gx70SZv/sSju8D1b3rS9iixuS1DFkH1CzvF79CoNjYQcUlHlqkMJZgRd+jcVP4Vb4ToI12vWUtRDw9mKjTRUC6KqeQEcm6z9ZPlaU06mLzXwTW84r4Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770466679; c=relaxed/simple;
	bh=6RTlPCjN3ZYJVpREsa2236B4aKYYqjHN+TyJxs3yUIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KD6k63NZA7AEPfEHgGV92Ks6P9M69hsBv6bFC99q3FlX7YsTgurOntkHtHw0ygD0iDy1I6I28NjvZ/9O1dlLiz0Q3yEWHJxRgfbTftx+NENly93GmDrOWgjU32WYpLY8WcG2beN+xa6wt5VMvYCoRcnNO3GeV1oaSoTXIwniwxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UdW5glPZ; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <34f1cf21-fe1c-444e-a773-c6e639f0c618@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770466666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+cKtIWuSfWUtLorzNWZSkOBuigYD76NOh/+Tg/mc3cE=;
	b=UdW5glPZnjsaFwyuJhaIyYN15pybiPkJR+BhHKsNG8Iv2Ei33PtqshGQUNqJl3vX5Hpgol
	mdCF8zy3iyyUxt+XiUwlggW96WN8zYpzBwga8QUhuJV7BG03THKtuten/TSg3y2KvhuWzs
	H9dcSpTbXNmuNk15gXnoyVvTrabYC14=
Date: Sat, 7 Feb 2026 12:17:30 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2 1/2] octeontx2-af: CGX: fix bitmap leaks
To: Bo Sun <bo@mboxify.com>, kuba@kernel.org, pabeni@redhat.com
Cc: gakula@marvell.com, sgoutham@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, horms@kernel.org, bbhushan2@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 sumang@marvell.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260206130925.1087588-1-bo@mboxify.com>
 <20260206130925.1087588-2-bo@mboxify.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260206130925.1087588-2-bo@mboxify.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214758-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.971];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mboxify.com:email]
X-Rspamd-Queue-Id: BD7B4105D78
X-Rspamd-Action: no action

On 06/02/2026 13:09, Bo Sun wrote:
> The RX/TX flow-control bitmaps (rx_fc_pfvf_bmap and tx_fc_pfvf_bmap)
> are allocated by cgx_lmac_init() but never freed in cgx_lmac_exit().
> Unbinding and rebinding the driver therefore triggers kmemleak:
> 
>      unreferenced object (size 16):
>          backtrace:
>            rvu_alloc_bitmap
>            cgx_probe
> 
> Free both bitmaps during teardown.
> 
> Fixes: e740003874ed ("octeontx2-af: Flow control resource management")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bo Sun <bo@mboxify.com>
> ---
>   drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> index 42044cd810b1..fd4792e432bf 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> @@ -1823,6 +1823,8 @@ static int cgx_lmac_exit(struct cgx *cgx)
>   		cgx->mac_ops->mac_pause_frm_config(cgx, lmac->lmac_id, false);
>   		cgx_configure_interrupt(cgx, lmac, lmac->lmac_id, true);
>   		kfree(lmac->mac_to_index_bmap.bmap);
> +		rvu_free_bitmap(&lmac->rx_fc_pfvf_bmap);
> +		rvu_free_bitmap(&lmac->tx_fc_pfvf_bmap);
>   		kfree(lmac->name);
>   		kfree(lmac);
>   	}

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

