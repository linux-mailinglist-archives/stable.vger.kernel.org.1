Return-Path: <stable+bounces-230050-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BqzCgcOwmlGZQQAu9opvQ
	(envelope-from <stable+bounces-230050-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 05:07:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9FB301EEE
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 05:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4559430712C3
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 04:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B673A1E69;
	Tue, 24 Mar 2026 04:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="PfaN31bo"
X-Original-To: stable@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C464C70818;
	Tue, 24 Mar 2026 04:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774325211; cv=none; b=HfCnQzbKUWURgR/QeW5CjFKsOTLZTqOBGn8otExQ3sLHdeR1M2alT8l67s/0F1WyzpOB5D4AVtPTW45vXDyAcabVKSpUESAoMb9+SD47lHceJrbq4zU5s7K9TUg/1jkK79X/+OKFqHywkVwMvtP7uUNtIAwoQdgfR4zT76I0tEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774325211; c=relaxed/simple;
	bh=BpeoYm2me6K+Dc6+M7uak6KdTN0vdOyhFUGGh1WvVVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y4m1fklA7fsY7iGfkh9ms+/ePwRKALZJHJ4q9094+utDCdCTtSXKA5tQ7pr6EqTX/4oDZB6R95VNqJWcnD/b/nZYrjkZAspiRn/xY5cA0u5k4NppgYTkFIYTxGHhgzjaaWJimDWCofZqsfB0xd/K6feGBNfCDSlVCgpdGVjakcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=PfaN31bo; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=AEw0ALkfl/eEyK8p9OdBYjDi13UrriYKZIfwNtIhTxU=;
	b=PfaN31bo6Pa+Muf/7pXaU2aOV5b101wvtrv8P8hsNKqyEWnUsEd9vbvt+nEUn0
	12XPJkQxBohvsdBVIQxJuIptGU+7aa6BivCdb1DVx4b6uXckO29h6gZefIHtmpXy
	f1U0KwMWlkUGP/mk+CRTnKQNnGFbXmtfoeeMP94H16Ppk=
Received: from [7.247.167.152] (unknown [])
	by gzsmtp2 (Coremail) with UTF8SMTPA id Ms8vCgDnP4LIDMJpyYMBAA--.3218S2;
	Tue, 24 Mar 2026 12:02:17 +0800 (CST)
Message-ID: <8f918b23-5877-4963-a048-5783f11f264c@yeah.net>
Date: Tue, 24 Mar 2026 12:02:15 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] virtio_net: Fix UAF on dst_ops when
 IFF_XMIT_DST_RELEASE is cleared and napi_tx is false
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260312025406.15641-1-xietangxin@yeah.net>
 <20260314124017.59206dac@kernel.org>
 <CANn89iJHp+nCcAo7tzMTfH5yW2qDsEXP_u=RzdV=DC9ZvDH9Fg@mail.gmail.com>
 <20260314181243.177d4ab4@kernel.org>
From: xietangxin <xietangxin@yeah.net>
In-Reply-To: <20260314181243.177d4ab4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Ms8vCgDnP4LIDMJpyYMBAA--.3218S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrW3tw4kKF4UXrWDAF43Wrg_yoW8Wr48pa
	yIqF4S9F4kWrWxCan7t3WFqryjk395ua42gr1kW3sIvr45u3WF9r18Zw45WFn0kr4kXw42
	van7Xr95KF4UAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jIzuXUUUUU=
X-CM-SenderInfo: x0lh3tpqj0x0o61htxgoqh3/1tbiIglAdGnCDMm4NwAA3+
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yeah.net,none];
	R_DKIM_ALLOW(-0.20)[yeah.net:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230050-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[yeah.net];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xietangxin@yeah.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[yeah.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,yeah.net:dkim,yeah.net:email,yeah.net:mid]
X-Rspamd-Queue-Id: BB9FB301EEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/15/2026 9:12 AM, Jakub Kicinski wrote:
> On Sat, 14 Mar 2026 21:11:33 +0100 Eric Dumazet wrote:
>>> On Thu, 12 Mar 2026 10:54:06 +0800 xietangxin wrote:  
>>>> Fixes: f2fc6a54585a ("[NETNS][IPV6] route6 - move ip6_dst_ops inside the network namespace")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: xietangxin <xietangxin@yeah.net>  
>>>
>>> The Fixes tag should be:
>>>
>>> Fixes: 0287587884b1 ("net: better IFF_XMIT_DST_RELEASE support")  
>>
>> I disagree
>>
>> What was the situation before this patch ?
> 
> My thinking process was that it's fairly unusual that the dst is kept
> because the stack decided so. Normally its the device driver that asks
> for dst to be kept when its xmit is called. I thought 0287587884b1 was
> the first time when stack could make the dst decision behind device
> driver's back. But my analysis was very shallow, could well be wrong.
Hi Jakub and Eric,

Thank you both for this deep dive.

As Eric noted, the root cause is architectural (the per-netns dst_ops),
but virtio_net with napi_tx=N seems to be a particularly vulnerable trigger.

I have verified that the TUN driver is not affected (discussed in v1 [1])
because its lifecycle management of skbs is different.
However, I haven't check other drivers that might also defer skb freeing.

Should I wait for a consensus on a more generic fix in the network core,
or would it be acceptable to land this targeted fix for virtio_net first
to address the immediate UAF?

[1] https://lore.kernel.org/all/4b8a6182-da50-4edb-a34a-b75ed784f1e2@yeah.net/

Best regards,
Tangxin Xie


