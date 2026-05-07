Return-Path: <stable+bounces-244553-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SABKHShs/GmMPwAAu9opvQ
	(envelope-from <stable+bounces-244553-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 12:40:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CE74E6EB6
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 12:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A70430095DE
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 10:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFEB3E92AF;
	Thu,  7 May 2026 10:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E0TodAKX"
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A393E928C
	for <stable@vger.kernel.org>; Thu,  7 May 2026 10:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778150311; cv=none; b=hj2Ksa4Nx7sBdRxgkddBtB/IBzq/miAs/kX7HavnOQGtz3br+c9WOzTybHbHw0qBsYnH8ugougKD0gnSZEse7hT4NqBU6j2d7AfKbCdPBh8G4MO3X2HA/1W5MNs3OWrREmHQyGiCL7Qg3/IuHW7vIrtttErYnqoVBxxLSs4+DoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778150311; c=relaxed/simple;
	bh=SfE7ty4TkXsSlVVH9Ai/KCBLN6KBzP06jcDej2glciQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gm+nnRX3Mx/1FtNOt+dJLAFrm22vEqB2qrgNxsm5P9M+6q1IWXVVwEeMiKo8kvHsp5Nmfys6Fj0zTV0ygzpOX3IA650bC+v8S/4tp4jR2NE28IIM5wkw1IRdAiNLMTXUG2SbObpYB8XLY6hgG025pEkPgYdyRow5GkzO4EbNxtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E0TodAKX; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6511ab18-250b-436a-a11c-f50e78334666@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778150297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HpI1/WK04V2Kme2O38dmAV6glQ7zCtBfEYYnw24SZEM=;
	b=E0TodAKX7voo0lLIQQ5c3GOsjc9FCrxnNwkm4KY8FjJ43plUOYvfxvj2lEP8zc3CvIfN+4
	VB6FbEqBS4SvvmWX6sae+4C1w5L1p7bU0ygA9GbWnduKWwxXxJKM8I6l/dou6c3KBhLBjN
	Ww7MxcBepwt1HUUf97ssUpA0K0vV+Do=
Date: Thu, 7 May 2026 11:38:05 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: ena: PHC: Check return code before setting
 timestamp output
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
References: <20260507003518.22554-1-akiyano@amazon.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260507003518.22554-1-akiyano@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 75CE74E6EB6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244553-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 07/05/2026 01:35, Arthur Kiyanovski wrote:
> ena_phc_gettimex64() is setting the output parameter regardless
> of whether ena_com_phc_get_timestamp() succeeded or failed.
> 
> When ena_com_phc_get_timestamp() returns an error, the timestamp
> parameter may contain uninitialized stack memory (e.g., when PHC is
> disabled or in blocked state) or invalid hardware values. Passing
> these to userspace via the PTP ioctl is both a security issue
> (information leak) and a correctness bug.
> 
> Fix by checking the return code after releasing the lock and only
> setting the output timestamp on success.
> 
> Fixes: e0ea34158ee8 ("net: ena: Add PHC support in the ENA driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
> ---
>   drivers/net/ethernet/amazon/ena/ena_phc.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/amazon/ena/ena_phc.c b/drivers/net/ethernet/amazon/ena/ena_phc.c
> index 7867e893fd15..c2a3ff1ef645 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_phc.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_phc.c
> @@ -46,9 +46,12 @@ static int ena_phc_gettimex64(struct ptp_clock_info *clock_info,
>   
>   	spin_unlock_irqrestore(&phc_info->lock, flags);
>   
> +	if (rc)
> +		return rc;
> +
>   	*ts = ns_to_timespec64(timestamp_nsec);
>   
> -	return rc;
> +	return 0;
>   }

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Just an observation while reviewing - the idea of taking 2 spinlocks
while reading timestamp doesn't look great and can potentially be
CPU-expensive. Please, consider refactoring into RCU-style...

