Return-Path: <stable+bounces-273184-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XmrvLjbHUGrq4wIAu9opvQ
	(envelope-from <stable+bounces-273184-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 12:19:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8EF7399B2
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 12:19:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=eNtniNpg;
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273184-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-273184-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DB64309D986
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 10:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B22406816;
	Fri, 10 Jul 2026 10:15:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCDB405C59;
	Fri, 10 Jul 2026 10:15:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783678521; cv=none; b=he03dABueapGh08dRgmQSRDWb/JRj1dBFSQAxpAHSAT57RrRpKuPf59nMbjVYr03z0XBdmgq/i0MR9b7UUxFjmn5qm+1HY9y90iDuQmhOGhiLMbrs87oy17bAUS52WpmUCUOBhA+ZbyHS3Z3y+Yppe8+1egm0QY4SM9/QUMcj7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783678521; c=relaxed/simple;
	bh=FKmWWJSiuyGCONBTeFkaKyMmM8kyVZKJDraj0CjHoF0=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=doubpfmWNnLvuiat8lqHNvDDJjfThfT27swTeba/b/WWGF5y52P/hWwnErhso5sPk33G89ul2JqeGsT5uwbXQEwk3rqc/8348E+IkeRGGjZPD2VjXZYJP8zx6l1SD2EmvNtu/ETJmLmypapEZWRruYXlUbxHY8mPVInFy0UkbjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=eNtniNpg; arc=none smtp.client-ip=113.46.200.221
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=dgMT0VKzV6QMPpn2ppwAC6YHO+ckzDJzwEDWY0NEAa4=;
	b=eNtniNpgfI6nT5pbdOlLVn5LZuyJPAiBfWxqnG6XT5wzA6YbB5/TO5skSIvk0gYYVQMyCggnI
	G/ZSujFN+qR+bofjtFZLPmAaxWWBVP1sMtQ79Uqr6tDn7UF1bU+UaCjDWF9lK0odtNtTiXRRjCr
	NjuypghJcj/6c0fNGoo3KYM=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gxSCD15LRzRhTG;
	Fri, 10 Jul 2026 18:06:00 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 2910C4058C;
	Fri, 10 Jul 2026 18:15:14 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 10 Jul 2026 18:15:13 +0800
Message-ID: <540e21ae-1c10-4ef3-928f-edac329b62e8@huawei.com>
Date: Fri, 10 Jul 2026 18:15:12 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, Xuanqiang Luo <luoxuanqiang@kylinos.cn>, Jian Shen
	<shenjian15@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net v1 3/3] net: hibmcge: fix double-free of tx skb on DMA
 mapping failure
To: <xuanqiang.luo@linux.dev>, <netdev@vger.kernel.org>
References: <20260710090527.58354-1-xuanqiang.luo@linux.dev>
 <20260710090527.58354-4-xuanqiang.luo@linux.dev>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260710090527.58354-4-xuanqiang.luo@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500018.china.huawei.com (7.202.195.199)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-273184-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[shaojijie@huawei.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:shaojijie@huawei.com,m:luoxuanqiang@kylinos.cn,m:shenjian15@huawei.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:xuanqiang.luo@linux.dev,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,vger.kernel.org:from_smtp,kylinos.cn:email,huawei.com:from_mime,huawei.com:email,huawei.com:mid,huawei.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F8EF7399B2


on 2026/7/10 17:05, xuanqiang.luo@linux.dev wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>
> If hbg_dma_map() fails, hbg_net_start_xmit() frees the skb, but buffer->skb
> is left pointing to it. ring->ntu is not advanced, so the buffer is not
> visible to the TX cleanup path.
>
> A subsequent transmit normally overwrites the buffer. However, if the
> interface is brought down first, hbg_ring_uninit() calls hbg_buffer_free().
> It sees the stale pointer, attempts to unmap the failed mapping, and frees
> the skb again.
>
> Clear buffer->skb before freeing the skb in the error path, preventing
> hbg_buffer_free() from treating it as an outstanding TX buffer.
>
> Fixes: 40735e7543f9 ("net: hibmcge: Implement .ndo_start_xmit function")
> Cc: stable@vger.kernel.org
> Assisted-by: Opencode:deepseek-v4-pro[1m]
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Thanks for fixing this. The patch looks good to me.

Reviewed-by: Jijie Shao <shaojijie@huawei.com>

> ---
>   drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
> index 0ae3149946769..4382af937e2e7 100644
> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
> @@ -155,6 +155,7 @@ netdev_tx_t hbg_net_start_xmit(struct sk_buff *skb, struct net_device *netdev)
>   	buffer->skb = skb;
>   	buffer->skb_len = skb->len;
>   	if (unlikely(hbg_dma_map(buffer))) {
> +		buffer->skb = NULL;
>   		dev_kfree_skb_any(skb);
>   		return NETDEV_TX_OK;
>   	}

