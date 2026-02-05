Return-Path: <stable+bounces-214460-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AD4FNWKfhGmI3wMAu9opvQ
	(envelope-from <stable+bounces-214460-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 14:47:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA98F37FB
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 14:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7CCD300DDDF
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 13:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1D623ABBD;
	Thu,  5 Feb 2026 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b="UaLIrKvp"
X-Original-To: stable@vger.kernel.org
Received: from mail-108-mta118.mxroute.com (mail-108-mta118.mxroute.com [136.175.108.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D332367D5
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770298844; cv=none; b=vDUYnVmPH/xN9OZlpsg7G5QW9wCJHbEIFH9BpB7fTIwIqj8D5SMhimlJ+gEUVB90mN4vcjF0uMyr30DSOyABmRzPSS36c4kF4LDI6TS327BhxIoiCIsHNhbX4G1dXiuyWfnqZuuYYv83qOhxriJo4IKhNdCBjQsmtgXJ72AVsvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770298844; c=relaxed/simple;
	bh=yroxCojQdGBi/aKWMoFi35tE5WwZxtA2iHWwNG4lflg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gtEpDF3KuTiSSRdUGlxBCL5zClb/GMP7Fg8WrdVRDGFBrtoVZDzXHOR5F/kr0WkuBV1+UZuYyJzTGJombN/5N1M0m+RcXRGMlSBT6EGckDj2ogJAvXq9pNgnKzrFU240/BO3CpF+7yrFbsQlXiWplzawaIsED+XBNhEWomv+AUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com; spf=pass smtp.mailfrom=mboxify.com; dkim=pass (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b=UaLIrKvp; arc=none smtp.client-ip=136.175.108.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mboxify.com
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta118.mxroute.com (ZoneMTA) with ESMTPSA id 19c2e03e83a0009140.00e
 for <stable@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Thu, 05 Feb 2026 13:35:33 +0000
X-Zone-Loop: c79c1f4473339a8173fb8ad34dda41f7a472768cafe9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mboxify.com
	; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:
	Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=WeW8iiZRN8HHaCuf1senWk7tSGOueZmex5nL4o7MqUY=; b=UaLIrKvpsoq0aumI1XVF6fFl2z
	MhOcf8JihR+TpX17oYuhEcEQVRRNF61E6PIPfNFGguDa7DUBg1LtJ73BD8C0FJ2ug3ZNZN5y/lMd9
	QpmrU9W5hOcE3KMiZJQZOj/qy9uYo+QwJvmrnrW2sOKlJJXsz39GXvbUVlSllkRl/jiV8Dbm89QK1
	Z8LydfN8kDIw90qe9oygqdsD12YSGgNw5X2W7pMs2qvV8jgm8uSSBMpxwEHO4FG93WVsLEGhNdwtK
	M0+zLrFHvL3IpF4OlUkVIgivrYmVrrkvO/SkSwICcnJAapc2LI3BWuyZ9K5u9qwmW02ME9JmneyRB
	i2sqK5xw==;
Message-ID: <ba2c3143-0761-4903-ac0e-88ca502b4e50@mboxify.com>
Date: Thu, 5 Feb 2026 21:35:29 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] octeontx2-af: CGX: fix bitmap leaks
To: Jakub Kicinski <kuba@kernel.org>
Cc: pabeni@redhat.com, sgoutham@marvell.com, lcherian@marvell.com,
 gakula@marvell.com, jerinj@marvell.com, hkelam@marvell.com,
 sbhatta@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20251020143112.357819-1-bo@mboxify.com>
 <20251020143112.357819-2-bo@mboxify.com> <20251022182226.00967149@kernel.org>
Content-Language: en-US
From: Bo Sun <bo@mboxify.com>
In-Reply-To: <20251022182226.00967149@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: bo@mboxify.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[mboxify.com : SPF not aligned (strict),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[mboxify.com:s=x];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-214460-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bo@mboxify.com,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	DKIM_TRACE(0.00)[mboxify.com:-];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mboxify.com:mid,mboxify.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3CA98F37FB
X-Rspamd-Action: no action

On 10/23/2025 9:22 AM, Jakub Kicinski wrote:
> On Mon, 20 Oct 2025 22:31:12 +0800 Bo Sun wrote:
>> The RX/TX flow-control bitmaps (rx_fc_pfvf_bmap and tx_fc_pfvf_bmap)
>> are allocated by cgx_lmac_init() but never freed in cgx_lmac_exit().
>> Unbinding and rebinding the driver therefore triggers kmemleak:
>>
>>      unreferenced object (size 16):
>>          backtrace:
>>            rvu_alloc_bitmap
>>            cgx_probe
>>
>> Free both bitmaps during teardown.
>>
>> Fixes: e740003874ed ("octeontx2-af: Flow control resource management")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bo Sun <bo@mboxify.com>
> 
> Looks like rvu_free_bitmap() exists. We should probably use it?

Apologies for the late reply.
You're right that rvu_free_bitmap() exists. I stayed with direct kfree()
for consistency with the existing code in cgx_lmac_exit(), because which
already uses kfree(lmac->mac_to_index_bmap.bmap).

That said, I'm OK with either way:
1. Keep kfree() to match the existing pattern in this function
2. Switch all three bitmap frees (including mac_to_index_bmap) to use
rvu_free_bitmap() for consistency with the alloc/free API pairing

What's your preference?

Thanks,
Bo

> 
>> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
>> index ec0e11c77cbf..f56e6782c4de 100644
>> --- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
>> @@ -1823,6 +1823,8 @@ static int cgx_lmac_exit(struct cgx *cgx)
>>   		cgx->mac_ops->mac_pause_frm_config(cgx, lmac->lmac_id, false);
>>   		cgx_configure_interrupt(cgx, lmac, lmac->lmac_id, true);
>>   		kfree(lmac->mac_to_index_bmap.bmap);
>> +		kfree(lmac->rx_fc_pfvf_bmap.bmap);
>> +		kfree(lmac->tx_fc_pfvf_bmap.bmap);
>>   		kfree(lmac->name);
>>   		kfree(lmac);
>>   	}


