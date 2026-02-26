Return-Path: <stable+bounces-219821-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLEmJi1aoGlPigQAu9opvQ
	(envelope-from <stable+bounces-219821-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 15:35:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 185181A7A7A
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 15:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5F44300D158
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 14:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875253D4120;
	Thu, 26 Feb 2026 14:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kcinII8x"
X-Original-To: stable@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B400C3D3CEC
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772116133; cv=none; b=S9Kuxm6vISijTVURBBc+9PnWhu9qp0xL1ekVTr9ZLEkSLlWzV+wEtcLgmu8PWobDRgdGr4LiJ75KxQEJ2Hrb2Jg/Gp/2b6iaydtJbirhxgHPotVMlXXGMsvQsncj+vwfKc4EbNpWVgJmfNnrv1PshdU2dOFwRNm98GCE9r2bZJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772116133; c=relaxed/simple;
	bh=7rpVZ+fxTUQLAz/MsXS+ABz6b8FDyA1NowiHxW15/zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MMOC1AzmFTYBKDfqk6VEmmKW3S8HCv9UmAf2y4/cBMZApnCoXoOv66t39i1EnSBpi+2drvyF5+Lx2OOn4YOlG2sf1VxbQcifPRCKxc3qXOnEZzNyc2oKwKPF8FTuPilW+PIivQOyFwkTLfFTe7ulN0hHrDpJIG0IIJmDeINZkdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kcinII8x; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <46896339-b3a3-4109-a2e2-324446be5aeb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772116126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AQnoxdPqvcrup1Ns5bia3RQkVtFv3JRAv6rhmjfIRe8=;
	b=kcinII8xvQi7dPe8qWMA8eJ00twW2kq2qUuuzP5isI8+GdlUewOyrXS/yYsgPHegxfwFe6
	HkLZ4ODOTRfHBnyjLMAG8nSjEAHrl2Smjoj/C2aAm2lr5siJtku1vYQqi8YoG4ildrVywS
	ZgsODQbTI1YUgV5/dIkmUR+U5pi8Yhw=
Date: Thu, 26 Feb 2026 14:28:14 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: mana: Ring doorbell at 4 CQ wraparounds
To: Long Li <longli@microsoft.com>, "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
 Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260225184948.941599-1-longli@microsoft.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260225184948.941599-1-longli@microsoft.com>
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
	TAGGED_FROM(0.00)[bounces-219821-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 185181A7A7A
X-Rspamd-Action: no action

On 25/02/2026 18:49, Long Li wrote:
> MANA hardware requires at least one doorbell ring every 8 wraparounds
> of the CQ. The driver rings the doorbell as a form of flow control to
> inform hardware that CQEs have been consumed.
> 
> The NAPI poll functions mana_poll_tx_cq() and mana_poll_rx_cq() can
> poll up to CQE_POLLING_BUFFER (512) completions per call. If the CQ
> has fewer than 512 entries, a single poll call can process more than
> 4 wraparounds without ringing the doorbell. The doorbell threshold
> check also uses ">" instead of ">=", delaying the ring by one extra
> CQE beyond 4 wraparounds. Combined, these issues can cause the driver
> to exceed the 8-wraparound hardware limit, leading to missed
> completions and stalled queues.
> 
> Fix this by capping the number of CQEs polled per call to 4 wraparounds
> of the CQ in both TX and RX paths. Also change the doorbell threshold
> from ">" to ">=" so the doorbell is rung as soon as 4 wraparounds are
> reached.
> 
> Cc: stable@vger.kernel.org
> Fixes: 58a63729c957 ("net: mana: Fix doorbell out of order violation and avoid unnecessary doorbell rings")
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>   drivers/net/ethernet/microsoft/mana/mana_en.c | 23 +++++++++++++++----
>   1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 9919183ad39e..fe667e0d930d 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1770,8 +1770,14 @@ static void mana_poll_tx_cq(struct mana_cq *cq)
>   	ndev = txq->ndev;
>   	apc = netdev_priv(ndev);
>   
> +	/* Limit CQEs polled to 4 wraparounds of the CQ to ensure the
> +	 * doorbell can be rung in time for the hardware's requirement
> +	 * of at least one doorbell ring every 8 wraparounds.
> +	 */
>   	comp_read = mana_gd_poll_cq(cq->gdma_cq, completions,
> -				    CQE_POLLING_BUFFER);
> +				    min_t(u32, (cq->gdma_cq->queue_size /

no need for min_t, simple min() can be used, queue_size is already u32

> +					   COMP_ENTRY_SIZE) * 4,
> +					  CQE_POLLING_BUFFER));
>   
>   	if (comp_read < 1)
>   		return;
> @@ -2156,7 +2162,14 @@ static void mana_poll_rx_cq(struct mana_cq *cq)
>   	struct mana_rxq *rxq = cq->rxq;
>   	int comp_read, i;
>   
> -	comp_read = mana_gd_poll_cq(cq->gdma_cq, comp, CQE_POLLING_BUFFER);
> +	/* Limit CQEs polled to 4 wraparounds of the CQ to ensure the
> +	 * doorbell can be rung in time for the hardware's requirement
> +	 * of at least one doorbell ring every 8 wraparounds.
> +	 */
> +	comp_read = mana_gd_poll_cq(cq->gdma_cq, comp,
> +				    min_t(u32, (cq->gdma_cq->queue_size /

same here

> +					   COMP_ENTRY_SIZE) * 4,
> +					  CQE_POLLING_BUFFER));
>   	WARN_ON_ONCE(comp_read > CQE_POLLING_BUFFER);
>   
>   	rxq->xdp_flush = false;

