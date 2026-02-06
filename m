Return-Path: <stable+bounces-214671-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2E46CGUQhmk1JgQAu9opvQ
	(envelope-from <stable+bounces-214671-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 17:01:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C8DFFFB3
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 17:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C40073013011
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 16:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA3B2FF67A;
	Fri,  6 Feb 2026 16:01:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6040C146A66;
	Fri,  6 Feb 2026 16:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770393697; cv=none; b=IO6efU8zo6MeDxfCQsJoPiXXvMt2Np8GaRH2lZnphdpz/sfx6xuYGFKPHLDNR51ZvYGcGs+mCN8NPkZ8Yp+tAefLIEHr5VzdTaqkX3zNRkG6xoOA1xifB2S6TJ2L9HVA/X66EKhsbzA7i8/5t17A377WufjL9AI562NU5Sx+W5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770393697; c=relaxed/simple;
	bh=jzZbn+jdw4BQYdIMULDf/o4Som0gse8JSrD8ZJr4Lkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cAp9+c/KmforJu64+YsluvCDiOjEhlBYJH70jUUs+I27Z4L8x7/n/lBG251l+HlegAHPNxIe6oyb7XaEpXDC7dOGoY1YXnGemqSEzcUZw7SCggoSRvaRlgr1AIcbZgVQD0vKCKgF1+kpqla2Bl9Znujili5HP8rk42GdGFJ6L1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42C58339;
	Fri,  6 Feb 2026 08:01:29 -0800 (PST)
Received: from [10.57.54.83] (unknown [10.57.54.83])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C36A3F632;
	Fri,  6 Feb 2026 08:01:34 -0800 (PST)
Message-ID: <ea381264-5f8b-403d-85da-57a15ca944e5@arm.com>
Date: Fri, 6 Feb 2026 16:01:31 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irqchip/gic-v3-its: Limit number of per-device MSIs to
 the range the ITS supports
To: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Thomas Gleixner <tglx@kernel.org>, stable@vger.kernel.org
References: <20260206154816.3582887-1-maz@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260206154816.3582887-1-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214671-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robin.murphy@arm.com,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.886];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:mid,arm.com:email]
X-Rspamd-Queue-Id: C7C8DFFFB3
X-Rspamd-Action: no action

On 2026-02-06 3:48 pm, Marc Zyngier wrote:
> The ITS driver blindly assumes that EventIDs are in abundant supply,
> to the point where it never checks how many the HW actually supports.
> 
> It turns out that some pretty esoteric integrations make it so that
> only a few bits are available, all the way down to a. single. bit.
> 
> Enforce the advertised limitation at the point of allocating the
> device structure, and hope that the endpoint driver can deal with
> such limitation.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>   drivers/irqchip/irq-gic-v3-its.c   | 4 ++++
>   include/linux/irqchip/arm-gic-v3.h | 1 +
>   2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 2988def30972b..a51e8e6a81819 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -3475,6 +3475,7 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
>   	int lpi_base;
>   	int nr_lpis;
>   	int nr_ites;
> +	int id_bits;
>   	int sz;
>   
>   	if (!its_alloc_device_table(its, dev_id))
> @@ -3486,7 +3487,10 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
>   	/*
>   	 * Even if the device wants a single LPI, the ITT must be
>   	 * sized as a power of two (and you need at least one bit...).
> +	 * Also honor the ITS's own EID limit.
>   	 */
> +	id_bits = FIELD_GET(GITS_TYPER_IDBITS, its->typer) + 1;
> +	nvecs = min_t(unsigned int, nvecs, BIT(id_bits));
>   	nr_ites = max(2, nvecs);
>   	sz = nr_ites * (FIELD_GET(GITS_TYPER_ITT_ENTRY_SIZE, its->typer) + 1);
>   	sz = max(sz, ITS_ITT_ALIGN);
> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
> index 70c0948f978eb..0225121f30138 100644
> --- a/include/linux/irqchip/arm-gic-v3.h
> +++ b/include/linux/irqchip/arm-gic-v3.h
> @@ -394,6 +394,7 @@
>   #define GITS_TYPER_VLPIS		(1UL << 1)
>   #define GITS_TYPER_ITT_ENTRY_SIZE_SHIFT	4
>   #define GITS_TYPER_ITT_ENTRY_SIZE	GENMASK_ULL(7, 4)
> +#define GITS_TYPER_IDBITS		GENMASK_ULL(12, 8)
>   #define GITS_TYPER_IDBITS_SHIFT		8
>   #define GITS_TYPER_DEVBITS_SHIFT	13
>   #define GITS_TYPER_DEVBITS		GENMASK_ULL(17, 13)


