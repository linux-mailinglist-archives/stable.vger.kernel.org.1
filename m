Return-Path: <stable+bounces-244721-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCoWBmKt/WmlhgAAu9opvQ
	(envelope-from <stable+bounces-244721-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 11:31:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 651B04F4471
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 11:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45CF33007E26
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 09:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83B4383C6B;
	Fri,  8 May 2026 09:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="syba9Nwx"
X-Original-To: stable@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A43355F43
	for <stable@vger.kernel.org>; Fri,  8 May 2026 09:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778232513; cv=none; b=B68XGqjlr/SfHVCp4i+GxxQmGY5LkWEz9XGsHdb49Bi8RPmKSxU0IaVuedI1qSOKaHTOYp7390oJoQbr107XWbzi+nrCJW6y1o38dq+u4qqf2LZn17vt6EiUM69W4KcSe5tfIlNzyYP+PR/pi79QN3g4vAbnOHyH2PDyx1iyuI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778232513; c=relaxed/simple;
	bh=a/7MP5KgFHbcO1EOLTaNUbNZhO9UjZJbmPG24V98Ts0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cik51KFjRELu4jYNnsCgRHm5pT+B1IjF3jB4D/f+Q0s/Fr4Zoko33k2yb9HOolyYADEoL0rbWrCLXeLjJEOtg6NNH0TARv5d4LbdNW0vRHb/AqTPSvukY71yjpYypy92Z5NdmajNiLBaCpOpFnDMp6xw7H2wkSZT5xCmqF7jvsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=syba9Nwx; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <33d3f804-2877-490e-b59f-5464e51bbf74@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778232508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IYZcQhqYYzE659oIBhM3F6WkTOSlrt+goCsH4UGC31I=;
	b=syba9NwxIH6kg/aJEm6IgB5V+6hCCchQOcFO/Nt0wV2iRFYqTxBanApdRpKLF0WFFUs3TH
	+2k8zTpRQnAgWSdsbgaPeD3BNG6fs0QkCTrI5yg22GtVwoBuF8cuXZhkPyrp5juER9Be9z
	L+/xKGqaDNd5Mf3qz5NgQXVRSKvoR8k=
Date: Fri, 8 May 2026 10:28:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: ena: PHC: Fix potential use-after-free in
 get_timestamp
To: Arthur Kiyanovski <akiyano@amazon.com>, David Miller
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
Cc: Richard Cochran <richardcochran@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Miroslav Lichvar <mlichvar@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Wen Gu <guwen@linux.alibaba.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 David Woodhouse <dwmw@amazon.com>, Yonatan Sarna <ysarna@amazon.com>,
 Zorik Machulsky <zorik@amazon.com>, Alexander Matushevsky
 <matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>,
 Matt Wilson <msw@amazon.com>, Anthony Liguori <aliguori@amazon.com>,
 Nafea Bshara <nafea@amazon.com>, Evgeny Schmeilin <evgenys@amazon.com>,
 Netanel Belgazal <netanel@amazon.com>, Ali Saidi <alisaidi@amazon.com>,
 Benjamin Herrenschmidt <benh@amazon.com>, Noam Dagan <ndagan@amazon.com>,
 David Arinzon <darinzon@amazon.com>, Evgeny Ostrovsky <evostrov@amazon.com>,
 Ofir Tabachnik <ofirt@amazon.com>, Amit Bernstein <amitbern@amazon.com>,
 stable@vger.kernel.org
References: <20260508062126.7273-1-akiyano@amazon.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260508062126.7273-1-akiyano@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 651B04F4471
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244721-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,redhat.com,infradead.org,linutronix.de,lunn.ch,linux.alibaba.com,amazon.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Action: no action

On 08/05/2026 07:21, Arthur Kiyanovski wrote:
> Move the phc->active check and resp pointer assignment to after
> acquiring the spinlock. Previously, phc->active was checked without
> holding the lock, and resp was cached from ena_dev->phc.virt_addr
> before the lock was acquired.
> 
> If ena_com_phc_destroy() runs between the lockless active check and
> the lock acquisition, it sets active=false, releases the lock, frees
> the DMA memory, and sets virt_addr=NULL. The get_timestamp path would
> then read a NULL virt_addr and dereference it.
> 
> With both the active check and the pointer read under the lock,
> destroy cannot free the memory while get_timestamp is using it.
> 
> Fixes: e0ea34158ee8 ("net: ena: Add PHC support in the ENA driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
> ---
>   drivers/net/ethernet/amazon/ena/ena_com.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
> index e67b592..8c86789 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_com.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_com.c
> @@ -1782,20 +1782,23 @@ void ena_com_phc_destroy(struct ena_com_dev *ena_dev)
>   
>   int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
>   {
> -	volatile struct ena_admin_phc_resp *resp = ena_dev->phc.virt_addr;
>   	const ktime_t zero_system_time = ktime_set(0, 0);
>   	struct ena_com_phc_info *phc = &ena_dev->phc;
> +	volatile struct ena_admin_phc_resp *resp;
>   	ktime_t expire_time;
>   	ktime_t block_time;
>   	unsigned long flags = 0;
>   	int ret = 0;
>   
> +	spin_lock_irqsave(&phc->lock, flags);
> +
>   	if (!phc->active) {
> +		spin_unlock_irqrestore(&phc->lock, flags);
>   		netdev_err(ena_dev->net_device, "PHC feature is not active in the device\n");
>   		return -EOPNOTSUPP;
>   	}
>   
> -	spin_lock_irqsave(&phc->lock, flags);
> +	resp = ena_dev->phc.virt_addr;
>   
>   	/* Check if PHC is in blocked state */
>   	if (unlikely(ktime_compare(phc->system_time, zero_system_time))) {

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

