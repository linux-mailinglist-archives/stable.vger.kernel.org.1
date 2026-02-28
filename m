Return-Path: <stable+bounces-220050-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCvHD+OaomlI4QQAu9opvQ
	(envelope-from <stable+bounces-220050-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 08:36:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 928511C1198
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 08:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1123230F7FE5
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 07:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8573C346AFF;
	Sat, 28 Feb 2026 07:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="f9NKL87L"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A24727A927
	for <stable@vger.kernel.org>; Sat, 28 Feb 2026 07:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772263769; cv=none; b=HJzG7ELO9pArk9JnD0/ku5G1WBd6ghqQqItC95jaOZZq3EwZ4xVt9bSr93YVc0zqVAjeq12vexelnGj5Nj5dHgB1ft8w9uZ6D9l/LTJnuC1Gs86Tv/KOf5llPSsx30j08UOFRa0X7RdUn3S7vrXZcsPlIuLSCIe5xKZFEEARCaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772263769; c=relaxed/simple;
	bh=2EV2YmG1++2stZUJ/8BPD4b4UjXtmwiPD+yf/ahSYn4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=qnsiuPq1XfJeb9pwssmFoCE3S65mG/qTB1TEk2SXJ7SeeE9cU23OMHZXZBA2f0+sdnAdLcJHZSuhVZrgRBzcEOUooQ9QMjtiro1koI4Y7W0H/38rg4l7LbBPi000kShpffHZwpHJuqjFZns6bOlBJhtDgWqyWqFJfxdbK1MiDF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=f9NKL87L; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:To:
	Content-Type; bh=4yftyQN3T5lkPN7/EbJSKidJ/ybAXZ9dk4qmsSrIuQk=;
	b=f9NKL87LjdlQkV6bHvgmBIaoLEk1rpX8Z/ps6hDZubitJgtueqio+V9KMeqfmM
	MalEPEc9o5TJoN85EujPNqOZFjQEGx95/edved+yc/6e6DQA4dquKrf80va2qjH1
	tXhWV/YVsdQt+SDXag7E7rysuXd1P9ykmYdBxUCGakEkI=
Received: from [192.168.3.47] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCnjehNmaJpm0nCOQ--.36832S2;
	Sat, 28 Feb 2026 15:29:18 +0800 (CST)
Message-ID: <7517ebc1-dd47-4144-84e5-50936d20f8e6@163.com>
Date: Sat, 28 Feb 2026 15:29:18 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y] dmaengine: mmp_pdma: Fix race condition in
 mmp_pdma_residue()
From: Wenshan Lan <jetlan9@163.com>
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
References: <20260228072545.4110-1-jetlan9@163.com>
Content-Language: en-US
In-Reply-To: <20260228072545.4110-1-jetlan9@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wCnjehNmaJpm0nCOQ--.36832S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw47JF1Uur4rZw43AF1UWrg_yoW5Xr1kpF
	W3Ga15trWqqr409FsrC3WrZr15Xrs8KrW5urW7K3ZrZ345Jr90vF1xGayjqFyDJry5uanx
	AF43Kas3C3yDGrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR01vsUUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbC7A58RWmimU6YTwAA3Q
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220050-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jetlan9@163.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[163.com]
X-Rspamd-Queue-Id: 928511C1198
X-Rspamd-Action: no action

Please ignore this email for I forgot cc the related person.


On 2/28/2026 3:25 PM, Wenshan Lan wrote:
> From: Guodong Xu <guodong@riscstar.com>
>
> [ Upstream commit a143545855bc2c6e1330f6f57ae375ac44af00a7 ]
>
> Add proper locking in mmp_pdma_residue() to prevent use-after-free when
> accessing descriptor list and descriptor contents.
>
> The race occurs when multiple threads call tx_status() while the tasklet
> on another CPU is freeing completed descriptors:
>
> CPU 0                              CPU 1
> -----                              -----
> mmp_pdma_tx_status()
> mmp_pdma_residue()
>    -> NO LOCK held
>       list_for_each_entry(sw, ..)
>                                     DMA interrupt
>                                     dma_do_tasklet()
>                                       -> spin_lock(&desc_lock)
>                                          list_move(sw->node, ...)
>                                          spin_unlock(&desc_lock)
>    |                                     dma_pool_free(sw) <- FREED!
>    -> access sw->desc <- UAF!
>
> This issue can be reproduced when running dmatest on the same channel with
> multiple threads (threads_per_chan > 1).
>
> Fix by protecting the chain_running list iteration and descriptor access
> with the chan->desc_lock spinlock.
>
> Signed-off-by: Juan Li <lijuan@linux.spacemit.com>
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> Link: https://patch.msgid.link/20251216-mmp-pdma-race-v1-1-976a224bb622@riscstar.com
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> [ Minor context conflict resolved. ]
> Signed-off-by: Wenshan Lan <jetlan9@163.com>
> ---
>   drivers/dma/mmp_pdma.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
> index e8d71b35593e..bac4905c47db 100644
> --- a/drivers/dma/mmp_pdma.c
> +++ b/drivers/dma/mmp_pdma.c
> @@ -764,6 +764,7 @@ static unsigned int mmp_pdma_residue(struct mmp_pdma_chan *chan,
>   {
>   	struct mmp_pdma_desc_sw *sw;
>   	u32 curr, residue = 0;
> +	unsigned long flags;
>   	bool passed = false;
>   	bool cyclic = chan->cyclic_first != NULL;
>   
> @@ -779,6 +780,8 @@ static unsigned int mmp_pdma_residue(struct mmp_pdma_chan *chan,
>   	else
>   		curr = readl(chan->phy->base + DSADR(chan->phy->idx));
>   
> +	spin_lock_irqsave(&chan->desc_lock, flags);
> +
>   	list_for_each_entry(sw, &chan->chain_running, node) {
>   		u32 start, end, len;
>   
> @@ -822,6 +825,7 @@ static unsigned int mmp_pdma_residue(struct mmp_pdma_chan *chan,
>   			continue;
>   
>   		if (sw->async_tx.cookie == cookie) {
> +			spin_unlock_irqrestore(&chan->desc_lock, flags);
>   			return residue;
>   		} else {
>   			residue = 0;
> @@ -829,6 +833,8 @@ static unsigned int mmp_pdma_residue(struct mmp_pdma_chan *chan,
>   		}
>   	}
>   
> +	spin_unlock_irqrestore(&chan->desc_lock, flags);
> +
>   	/* We should only get here in case of cyclic transactions */
>   	return residue;
>   }


