Return-Path: <stable+bounces-262429-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vPeDOsoHKWpAPAMAu9opvQ
	(envelope-from <stable+bounces-262429-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 08:44:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BF26665AE
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 08:44:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ideasonboard.com header.s=mail header.b=wixy1yu2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262429-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-262429-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ideasonboard.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 794713075FF5
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 06:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1550377ED4;
	Wed, 10 Jun 2026 06:43:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAEC376A1B;
	Wed, 10 Jun 2026 06:43:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781073838; cv=none; b=ICKz3EbtyNUQuTbhASRmUkNhJLV87euAKvTtJL3zStGL1r97fy/0MvOL565Z49b2K3JMJdRl8VMI3i+IxngxteexQgZuLIW7B5Y5Vm4/7G38+Qwx3hfdxwBt09WJmgZMUReLzCLqQG0pp+sIGlootPeDKzb72+a4i4tmvwtybsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781073838; c=relaxed/simple;
	bh=5inMq/XR960HU/BSti4Yji3fGwSGFSYzXWRfVD+iWWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DSsCtZXENyeu2DiMBpw40wmawJQUxxO8oaoKTNF5uGPKVWs85Sgy29Wh/Y5CrF2mndHd65ae+n5jgHdHO8/f9dvaJ9PyPb6Z6D7fLohErmQe3DN/gOOGIl51JnhlT7fwrlwZFsqqlvTglfq6FuTE8hYFK5mJIsAgqLzt0CyMEzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=wixy1yu2; arc=none smtp.client-ip=213.167.242.64
Received: from [192.168.0.43] (chfd-03-b2-v4wan-176392-cust229.vm15.cable.virginm.net [82.19.20.230])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 843F4517;
	Wed, 10 Jun 2026 08:43:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1781073805;
	bh=5inMq/XR960HU/BSti4Yji3fGwSGFSYzXWRfVD+iWWw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=wixy1yu2LHIbIvh0JqaVerABA5qPy9J7y858DdSPeSbooUqpGugxNi27tqtIdnC/5
	 ANMblWBq3hPPGqpHI4AKuiWyfXBP3wDG9BbzpczoqWxcK3EmTAHIdM3NmJspfe42ZP
	 KiO4O/yKfuvlsLwXVbu2DCNCueHCNjFL3hgVCVZc=
Message-ID: <56b1e92a-ebdd-4ae1-963a-9e3225863c56@ideasonboard.com>
Date: Wed, 10 Jun 2026 07:43:50 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: mali-c55: fix integer overflow in scaler factor
 calculation
To: David Carlier <devnexen@gmail.com>,
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil+cisco@kernel.org>,
 Nayden Kanchev <nayden.kanchev@arm.com>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260529024429.6942-1-devnexen@gmail.com>
 <20260529050649.14109-1-devnexen@gmail.com>
Content-Language: en-US
From: Dan Scally <dan.scally@ideasonboard.com>
In-Reply-To: <20260529050649.14109-1-devnexen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ideasonboard.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ideasonboard.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262429-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,ideasonboard.com];
	FORGED_SENDER(0.00)[dan.scally@ideasonboard.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:devnexen@gmail.com,m:jacopo.mondi@ideasonboard.com,m:mchehab@kernel.org,m:hverkuil+cisco@kernel.org,m:nayden.kanchev@arm.com,m:linux-media@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:hverkuil@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.scally@ideasonboard.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[ideasonboard.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable,cisco];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 62BF26665AE

Hi David

On 29/05/2026 06:06, David Carlier wrote:
> The scaling factors are computed by multiplying the crop dimension by
> the Q4.20 unit (1 << 20) and dividing by the output dimension. The
> results are stored in u64, but both operands are 32-bit, so the product
> is evaluated in 32-bit arithmetic and only widened afterwards.
> 
> Crop dimensions may be up to 8192. Once a dimension reaches 4096 the
> product overflows 32 bits and wraps (zero at exactly 4096), programming
> a corrupted scaling increment and corrupting the downscaled output.
> 
> Define the fixed-point unit as unsigned long long so the multiplication
> is done in 64-bit arithmetic.
> 
> Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>

Thanks for spotting this:

Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>

> ---
> v2: Use the BIT_ULL() macro instead of an open-coded (1ULL << 20)
>      (checkpatch).
> ---
>   drivers/media/platform/arm/mali-c55/mali-c55-resizer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-resizer.c b/drivers/media/platform/arm/mali-c55/mali-c55-resizer.c
> index c4f46651dcee..6706939b4a90 100644
> --- a/drivers/media/platform/arm/mali-c55/mali-c55-resizer.c
> +++ b/drivers/media/platform/arm/mali-c55/mali-c55-resizer.c
> @@ -15,7 +15,7 @@
>   #include "mali-c55-registers.h"
>   
>   /* Scaling factor in Q4.20 format. */
> -#define MALI_C55_RSZ_SCALER_FACTOR	(1U << 20)
> +#define MALI_C55_RSZ_SCALER_FACTOR	BIT_ULL(20)
>   
>   #define MALI_C55_RSZ_COEFS_BANKS	8
>   #define MALI_C55_RSZ_COEFS_ENTRIES	64


