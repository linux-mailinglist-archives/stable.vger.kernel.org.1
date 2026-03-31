Return-Path: <stable+bounces-231378-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHfzNCefy2loJgYAu9opvQ
	(envelope-from <stable+bounces-231378-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 12:17:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6EE367C01
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 12:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F39E9316607F
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 10:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC133F0770;
	Tue, 31 Mar 2026 10:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZ+/feDV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LsNK/xIy"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A713B3E95B2
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 10:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774951528; cv=none; b=QVtJDpCi1ZicwiSXZXVJV22HHTsIT3zWkRnEbybAvQFLqLwxCOzkSRexBxwNyhZEmiZpvjHDRFSN1I5UBo3Xg/G7i1i09KEhEoi6oQmK399uSVHVepIE7FO8w7IQevU+G8RkmZquqEumyhV9Cy+6ijHdxhpqD3jIbHVH1sM4oyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774951528; c=relaxed/simple;
	bh=XCPP/PMrtCcz/JsiOqTQo/8RXnAJW/5LUskEDQIusAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GS/5pdw0vyWnHuJlVTDNKPcU9+uMSfTCS1+hbPuGfZ5bdvmCvX62MzHvQ7CbmzQ6F6LSzemd4Fihz6E5hxbtILWYV1X6Rhc8ILX6p8Gb42QIV0z10CMihbCoCSJ1ahjPh/hK0MFsIwZLVxebxAYY2PQddk5IRV1+AJ31Hha4ZAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KZ+/feDV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LsNK/xIy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774951525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aWf8TWp7tV0k/mvc1MkGGf1LVYNGyvNv3HnsTa0+7UI=;
	b=KZ+/feDV4nuoQypGBWoZ+gB/qBA2e2C5P2n5QWg2OHsHmoXbiDx3XAmSr0UFcHRWm8CCnT
	3r1AgsJS2ypodlCS7kTrnlOWd2oZCXSs4bvEL/aBPFMvY7hJbS+RS1omsGPxHnl8d6L6Ez
	ej3mJU1MuU/r/2On0SYv2v7p6kkB9Lk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-M__I96XfNa6TuG6qBWFELw-1; Tue, 31 Mar 2026 06:05:24 -0400
X-MC-Unique: M__I96XfNa6TuG6qBWFELw-1
X-Mimecast-MFC-AGG-ID: M__I96XfNa6TuG6qBWFELw_1774951523
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43cfc3bf7f6so2283589f8f.2
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 03:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774951523; x=1775556323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aWf8TWp7tV0k/mvc1MkGGf1LVYNGyvNv3HnsTa0+7UI=;
        b=LsNK/xIyrfnTj6l348+INoF0scyhDadGxgTbcl3Xwv7zkEtJEa6xTfwlcgDYTXJWKu
         H8ro2eiNzMu6ILw05GUfpKSL4rR9VaXFBYbO+RhEDcVJBLVmpXv5QWcfRJrsMPnA8v8F
         mukSLU2b6IBFdAila+sRIHD8npKThfRt216HbSAcdK92w20NG2LSMnksK8HPMuXy36Av
         e6P9eYEnyjZ/jjrOEihD7DBzqKq48hugq09svDFD2SWOH3B0S8SEYJoy2PPZ4sUfEmZU
         fjupjBsB5jQvZFbw5Jx/X2JEQwdsvUidNyhzW4K3LqEkR1/SPTVN2YVmVzEaxNZsP8dn
         0F0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774951523; x=1775556323;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aWf8TWp7tV0k/mvc1MkGGf1LVYNGyvNv3HnsTa0+7UI=;
        b=a99rYZJe7ZGGlN3MXHqpl0pNUg5emesFWm3oR3lDQatptvx7ByuQukxJmJNy+C68sh
         zs8qzdPwkWdSyPjsj40/SDfSAlwn0Wmfi5RlAoc/aCp/PzKG7Za5Vm/RRRv3Hk0WRSLu
         u94LG98EOu4hoUYu5sYxGtn0FWITX0EyL2R6mveHK1HBMHV6uhSBxGRtYbryKdTN1EDb
         xT2NvlOQaavihdaQWqFmZ3aaLylOGSXohqg782eQYwO4Zi5OpzATc0tDwYZqDrOSVNbk
         01GP+tN+ZOxvndAITm7AXUMrnDkyjJuPxcaKGWfVDef6e9DQr7AhOV/uQo9UlQGm0jSR
         1cNw==
X-Forwarded-Encrypted: i=1; AJvYcCVF3eDaQmxADO0LS9ljUXOyMdQ+gceu7sXqsc/LWeUYWkPEDDf9chz4bMclrKVJupVdSMbG6wQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQVDfuB+BS2Y9P48wg5xBaHX5GNUBSl8zLTmZ53BeFLN55uOj3
	WqN95DvUdp61eWoY4NUnaBeKGgW2i+q2j6hkFDUngF7cMOYi3sB8TVdVfA4myMlk/iXAD5OcCvx
	4fevicb2qj3odisNEFYXPnBQCMEOnIn2uTOBIlyuhDNjGbr3Ni403MKgwhw==
X-Gm-Gg: ATEYQzxAjN1hdjQMM6YNnvqXaY0tTSyTIG8aaVTZMQVs63NrxpEieiv2lQUaXQGQq4V
	LwiOhx5jNQiZ40byg/q0eOF8n9iMAVlBh3SD/nWG5MA3mgiITwTnDpGAaKOkinzmtJOfjTLywoC
	LLQs/AYKsodSVDIptqp6DWt+w1WxIi8NDAwhO4kg8Lo6jUjNQRtOSRnTB2AyH19qdQ3RzK57Mvz
	IZZ856bcv8g/SQF4W67cmfhZW4KeIuO2wBpaWS/vURhjGGmoRKda4hBuEMAr7hAphKiNqxEoeNn
	Oxf4ySo2ilmIZgRj5zSRDlQ3qOkfn5lwDnlRu17kJPAmfjo/j0j7V6QeS1WO8bCEW2XAFNSuS2h
	itV3xo0SWvW2CXzD1lYdGiyl4CQJFnPLvQLtg0jmXfN/DKMDFcl3zlbL1
X-Received: by 2002:a05:600c:6386:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-48727ee5532mr256940875e9.4.1774951522828;
        Tue, 31 Mar 2026 03:05:22 -0700 (PDT)
X-Received: by 2002:a05:600c:6386:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-48727ee5532mr256940295e9.4.1774951522308;
        Tue, 31 Mar 2026 03:05:22 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887adc52b2sm14522545e9.12.2026.03.31.03.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 03:05:20 -0700 (PDT)
Message-ID: <51dfd8ae-dc4e-4837-9b00-c596c457117e@redhat.com>
Date: Tue, 31 Mar 2026 12:05:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ns83820: check DMA mapping errors in hard_start_xmit
To: Wang Jun <1742789905@qq.com>, kuba@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 simon.horman@corigine.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, gszhai@bjtu.edu.cn, 25125332@bjtu.edu.cn,
 25125283@bjtu.edu.cn, 23120469@bjtu.edu.cn, stable@vger.kernel.org
References: <tencent_5F1EACA5E1063E7E346A4138913F7486A009@qq.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <tencent_5F1EACA5E1063E7E346A4138913F7486A009@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231378-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[qq.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qq.com:email]
X-Rspamd-Queue-Id: 3A6EE367C01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/27/26 2:16 AM, Wang Jun wrote:
> The ns83820 driver currently ignores the return values of dma_map_single()
> and skb_frag_dma_map() in the transmit path. If DMA mapping fails due to
> IOMMU exhaustion or SWIOTLB pressure, the driver may proceed with invalid
> DMA addresses, potentially causing hardware errors, data corruption, or
> system instability.
> 
> Additionally, if mapping fails midway through processing fragmented
> packets,previously mapped DMA resources are not released, leading
> to DMA resource leaks.
> 
> Fix this by:
> 1. Checking dma_mapping_error() after each DMA mapping call.
> 2. Implementing an error handling path to unmap successfully
> mapped buffers(both linear and fragments) using
> dma_unmap_single().
> 3. Freeing the skb using dev_kfree_skb_any() to safely handle
> both process and softirq contexts, as hard_start_xmit may be
> called with IRQs enabled.
> 4. Returning NETDEV_TX_OK to drop the packet gracefully and
> prevent TX queue stagnation.
> 
> This ensures compliance with the DMA API guidelines and
> improves driver stability under memory pressure.
> 
> Fixes: fd9e4d6fec15 ("natsemi: switch from 'pci_' to 'dma_' API")

The fix tag looks wrong, as the above just to mechanical substitution of
used APIs. The issue is pre-existent

> Cc: stable@vger.kernel.org
> Signed-off-by: Wang Jun <1742789905@qq.com>
> ---
>  drivers/net/ethernet/natsemi/ns83820.c | 32 ++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/net/ethernet/natsemi/ns83820.c b/drivers/net/ethernet/natsemi/ns83820.c
> index cdbf82affa7b..90465e4977c3 100644
> --- a/drivers/net/ethernet/natsemi/ns83820.c
> +++ b/drivers/net/ethernet/natsemi/ns83820.c
> @@ -1051,6 +1051,12 @@ static netdev_tx_t ns83820_hard_start_xmit(struct sk_buff *skb,
>  	int stopped = 0;
>  	int do_intr = 0;
>  	volatile __le32 *first_desc;
> +	dma_addr_t frag_dma_addr[MAX_SKB_FRAGS];
> +	unsigned int frag_dma_len[MAX_SKB_FRAGS];
> +	int frag_mapped_count = 0;
> +	dma_addr_t main_buf = 0;
> +	unsigned int main_len = 0;
> +	int i;

Please respect the reverse christmas tree order above.

>  	dprintk("ns83820_hard_start_xmit\n");
>  
> @@ -1121,6 +1127,13 @@ static netdev_tx_t ns83820_hard_start_xmit(struct sk_buff *skb,
>  	buf = dma_map_single(&dev->pci_dev->dev, skb->data, len,
>  			     DMA_TO_DEVICE);
>  
> +	if (dma_mapping_error(&dev->pci_dev->dev, buf)) {
> +		dev_kfree_skb_any(skb);
> +		return NETDEV_TX_OK;
> +	}
> +	main_buf = buf;
> +	main_len = len;
> +
>  	first_desc = dev->tx_descs + (free_idx * DESC_SIZE);
>  
>  	for (;;) {
> @@ -1144,6 +1157,15 @@ static netdev_tx_t ns83820_hard_start_xmit(struct sk_buff *skb,
>  
>  		buf = skb_frag_dma_map(&dev->pci_dev->dev, frag, 0,
>  				       skb_frag_size(frag), DMA_TO_DEVICE);
> +		if (dma_mapping_error(&dev->pci_dev->dev, buf))
> +			goto dma_map_error;
> +
> +		if (frag_mapped_count < MAX_SKB_FRAGS) {
> +			frag_dma_addr[frag_mapped_count] = buf;
> +			frag_dma_len[frag_mapped_count] = skb_frag_size(frag);
> +			frag_mapped_count++;
> +		}
> +
>  		dprintk("frag: buf=%08Lx  page=%08lx offset=%08lx\n",
>  			(long long)buf, (long) page_to_pfn(frag->page),
>  			frag->page_offset);
> @@ -1166,6 +1188,16 @@ static netdev_tx_t ns83820_hard_start_xmit(struct sk_buff *skb,
>  	if (stopped && (dev->tx_done_idx != tx_done_idx) && start_tx_okay(dev))
>  		netif_start_queue(ndev);
>  
> +	return NETDEV_TX_OK;
> +dma_map_error:
> +	dma_unmap_single(&dev->pci_dev->dev, main_buf, main_len, DMA_TO_DEVICE);
> +	for (i = 0; i < frag_mapped_count; i++) {
> +		dma_unmap_single(&dev->pci_dev->dev, frag_dma_addr[i], frag_dma_len[i],
> +				 DMA_TO_DEVICE);
> +	}
> +
> +	dev_kfree_skb_any(skb);

AI review says:

If nr_free < MIN_TX_DESC_FREE earlier in the function, netif_stop_queue
is called and the stopped flag is set to 1. By returning NETDEV_TX_OK
directly from the error path, we skip the race check at the end of the
normal
flow:
	if (stopped && (dev->tx_done_idx != tx_done_idx) && start_tx_okay(dev))
		netif_start_queue(ndev);
If all pending packets completed concurrently right before the queue was
stopped, could this cause the TX queue to stall indefinitely until the
tx watchdog fires?


