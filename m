Return-Path: <stable+bounces-214869-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGf4MZjaiGmtxQQAu9opvQ
	(envelope-from <stable+bounces-214869-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Feb 2026 19:48:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D67AC109ED9
	for <lists+stable@lfdr.de>; Sun, 08 Feb 2026 19:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 079193002519
	for <lists+stable@lfdr.de>; Sun,  8 Feb 2026 18:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DD82FF16F;
	Sun,  8 Feb 2026 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AS1C9oKM"
X-Original-To: stable@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304C81D7E5C
	for <stable@vger.kernel.org>; Sun,  8 Feb 2026 18:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770576529; cv=none; b=W1+bDki3xOH0i16h+B7TTaUmv5F72ROpnRT/Ckcqe58/cid6WXtdNjrBaAB4R/YubwXjxhrsV9pkzX5PNh8VnftKVVrqFy8RDosp+f+vCB2aTfCRrxOchGPNpx81rKuihlwXBMaD2qApY2ocJq3xK+RQgAzalOcMaLdIEH+Dd5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770576529; c=relaxed/simple;
	bh=xgFu91dpE/i9uAtS3jCgI3SWcbMGsLOgFMXTVFOoZgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FKikql1LaqaA3dgMz3CDmV8cLZ3x0boGlHTD0awLYEBPw31mALmxQ4hzty/qiss4j78K3jgvajosn6k+vHNymlo7FnA5pkDPN4/EyfllilyGYaDwLkC2Lb2GoYocOyOSGv+M+uxzr/mvZzRrjRim1paDIL9pJRyrjbBds6Rlqlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AS1C9oKM; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8d17a56c-63b5-4d5c-836c-dfc150dcbfc8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770576526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hoJGcHFv/oYgr8ufHtoFHRJgFzkCO5vheTSp69h1m2U=;
	b=AS1C9oKMelaYyhQD/dVCPvXRT8zQHMc4yG3Ce9ZPm/JO/DpKkhVEVb/nvOEts836Fi23oE
	hXkTg4vKtFXjbnjq7JNZLi0ed3+MwcpyQRP2R7jL3YmsJbp7WT8OBzhANfW5MpEM5UJ6e1
	ksSPr9TGlawPOVBXz0zhLOJAg8eE5p8=
Date: Mon, 9 Feb 2026 02:48:41 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] irqchip/gic-v3-its: Limit number of per-device MSIs to
 the range the ITS supports
To: Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Thomas Gleixner <tglx@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 stable@vger.kernel.org
References: <20260206154816.3582887-1-maz@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20260206154816.3582887-1-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214869-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zenghui.yu@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: D67AC109ED9
X-Rspamd-Action: no action

On 2/6/26 11:48 PM, Marc Zyngier wrote:
> The ITS driver blindly assumes that EventIDs are in abundant supply,
> to the point where it never checks how many the HW actually supports.
> 
> It turns out that some pretty esoteric integrations make it so that
> only a few bits are available, all the way down to a. single. bit.
> 
> Enforce the advertised limitation at the point of allocating the
> device structure, and hope that the endpoint driver can deal with
> such limitation.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  drivers/irqchip/irq-gic-v3-its.c   | 4 ++++
>  include/linux/irqchip/arm-gic-v3.h | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 2988def30972b..a51e8e6a81819 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -3475,6 +3475,7 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
>  	int lpi_base;
>  	int nr_lpis;
>  	int nr_ites;
> +	int id_bits;
>  	int sz;
>  
>  	if (!its_alloc_device_table(its, dev_id))
> @@ -3486,7 +3487,10 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
>  	/*
>  	 * Even if the device wants a single LPI, the ITT must be
>  	 * sized as a power of two (and you need at least one bit...).
> +	 * Also honor the ITS's own EID limit.
>  	 */
> +	id_bits = FIELD_GET(GITS_TYPER_IDBITS, its->typer) + 1;
> +	nvecs = min_t(unsigned int, nvecs, BIT(id_bits));
>  	nr_ites = max(2, nvecs);
>  	sz = nr_ites * (FIELD_GET(GITS_TYPER_ITT_ENTRY_SIZE, its->typer) + 1);
>  	sz = max(sz, ITS_ITT_ALIGN);
> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
> index 70c0948f978eb..0225121f30138 100644
> --- a/include/linux/irqchip/arm-gic-v3.h
> +++ b/include/linux/irqchip/arm-gic-v3.h
> @@ -394,6 +394,7 @@
>  #define GITS_TYPER_VLPIS		(1UL << 1)
>  #define GITS_TYPER_ITT_ENTRY_SIZE_SHIFT	4
>  #define GITS_TYPER_ITT_ENTRY_SIZE	GENMASK_ULL(7, 4)
> +#define GITS_TYPER_IDBITS		GENMASK_ULL(12, 8)
>  #define GITS_TYPER_IDBITS_SHIFT		8
>  #define GITS_TYPER_DEVBITS_SHIFT	13
>  #define GITS_TYPER_DEVBITS		GENMASK_ULL(17, 13)

Reviewed-by: Zenghui Yu <zenghui.yu@linux.dev>

Thanks,
Zenghui

