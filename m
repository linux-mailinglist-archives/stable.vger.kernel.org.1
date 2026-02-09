Return-Path: <stable+bounces-214888-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHhbLNOTiWlj/AQAu9opvQ
	(envelope-from <stable+bounces-214888-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 08:59:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC7110CAF4
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 08:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9389301477B
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 07:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3BD33C507;
	Mon,  9 Feb 2026 07:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="kqbK3oii"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F71633BBD2;
	Mon,  9 Feb 2026 07:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770623944; cv=none; b=KcFDuK4iyuLl4o/2yUA8N8SQcAeUu9Ys4U4wD2QiTQweFPm29lN2wn3+67BAPNYgjGDCqJK22rze9F5j6zMCVxbyk+48/kHa5kJp5le8tjBxq0hGvIfVQqcHOV+AhSaNA5AYpHBVCxA3zMSQam8bWHSvkKtI33dd0Zzx+d1bVeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770623944; c=relaxed/simple;
	bh=++ReS9XegZQHNmyNsPh3Bhw06zEogxVcMR+KgBBJAeQ=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NLN7Ni/xOshpKMG1UqnqC+BgeiZIsDseY4hjA82MADa+3T/BU6HtIe6m7+ax3WsfpHCVYQRhcNB8Z0ygml878/KR6XV0+VzRQI6qLOHJD5bbPrZp/9Yd4lOyyS68I2erwYuWaxbYJ7+1qN5pSVgVdkZAZChU92p08AajCLXQo9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=kqbK3oii; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=jqeB9cQk6daGDcSKVompikvICasiia4Vo+NYb14w+Tc=;
	b=kqbK3oiiKj3sKeD6xrSZpTzsvQVmZp6Fn1xLuDb7UqyhPmFHLYns4b7Ons9m9wRd7LgeXEFhA
	/zZm+YpsqxaX0pnstIQvr8EkTmyjzJCPBuFYhUDiyDiXR3ZBl2flryLGgw4oKVE9u7513JqMeCR
	95UbPJqGtVJ+/F4X3iV2+Pc=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f8cQv5NXVzKm4q;
	Mon,  9 Feb 2026 15:54:15 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 72CF440565;
	Mon,  9 Feb 2026 15:58:53 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 9 Feb 2026 15:58:52 +0800
Message-ID: <b106c744-112f-4820-8bac-b0949c51801a@huawei.com>
Date: Mon, 9 Feb 2026 15:58:51 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <gakula@marvell.com>, <sgoutham@marvell.com>,
	<sbhatta@marvell.com>, <hkelam@marvell.com>, <horms@kernel.org>,
	<bbhushan2@marvell.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <sumang@marvell.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net v2 1/2] octeontx2-af: CGX: fix bitmap leaks
To: Bo Sun <bo@mboxify.com>, <kuba@kernel.org>, <pabeni@redhat.com>
References: <20260206130925.1087588-1-bo@mboxify.com>
 <20260206130925.1087588-2-bo@mboxify.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260206130925.1087588-2-bo@mboxify.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214888-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,huawei.com:dkim,huawei.com:mid]
X-Rspamd-Queue-Id: 2AC7110CAF4
X-Rspamd-Action: no action


on 2026/2/6 21:09, Bo Sun wrote:
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

Reviewed-by: Jijie Shao <shaojijie@huawei.com>


