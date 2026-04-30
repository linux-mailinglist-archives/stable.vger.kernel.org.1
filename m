Return-Path: <stable+bounces-242041-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HxzC2wB82lswgEAu9opvQ
	(envelope-from <stable+bounces-242041-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 09:14:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A123249E7AA
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 09:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41CCC301D321
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 07:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43E539BFFB;
	Thu, 30 Apr 2026 07:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="oVgLBWoK"
X-Original-To: stable@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A18377EBC;
	Thu, 30 Apr 2026 07:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777533280; cv=none; b=shNTCCbk57idlN7+8TXw5wm7cud0vlcb0HWI8r4jCu/neYcrjCFO072O8PupE7snXkXiUXWKZl5LG0honk+gTTr2Ze1iP2A94DdUOldH8ikW/awsfdg1yyOajQ/B1rGToa+gmMJn2Fmom8s8kYefpcLxm3A7Tq7915q/2+3txbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777533280; c=relaxed/simple;
	bh=9p6qcbnC9W8Op8ZW63/wJ/shZ8IDJFL5eDzsJbCfzjE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=pXnLaE5q/HjZkJdxRJ4ZlqI1bkvFLpcW2JiJfVDYEvZkG4LNIxjhpBP3LGLwRRboD7s9AWW9HtVkz60Kdu4HDVJL573+EXSItRquX6gRbJc8t2dfteOs2b+A1loIirFXVWkJDrYwBA2DEUA1LcIwl5fA2LB3ni6TAytOSKdtdQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=oVgLBWoK; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D5E9FA5338;
	Thu, 30 Apr 2026 09:14:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1777533273; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ofsbHe1+Vc16B+sH0Di155irlQlERmPTioiiPYeTY1U=;
	b=oVgLBWoK1rhtvx9PiPWRC2g0SEkdmrUkxMbW5NjqEiEC1t7iqgqM9f9IvzYazP57a0qzs9
	Do/ceK3rgdkeA+V+yyU9c+MQrKPoawLG1wUXL6rTmIhYmYf4bIeVRxcXZFBprsS3DaULGn
	KHTXJnJrcL35ReG9UaRAb/XjYQMJmmoSgRJ6C+iGfY4bWX8gxvSHgfbvsamRERzQclLuz0
	o/WFnwqd90ymjKeweI2bFh7lg705xtwVTk0QbfjsmD1LSGe4YIi4xVURPQMFGimxOXSL8i
	Iy6FM8TEP6rGXr5FoKYP79QmrubtJ5s+lAc5P+SNBdwpxN/ZSyOztgfCWXKaxA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Apr 2026 09:14:26 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Jeff Garzik
 <jeff@garzik.org>, Paolo Valerio <pvalerio@redhat.com>, Conor Dooley
 <conor@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?Q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v2 2/4] net: macb: drop in-flight Tx SKBs on close
In-Reply-To: <20260429193446.5985abea@kernel.org>
References: <20260428-macb-drop-tx-v2-0-647f5199d8df@bootlin.com>
 <20260428-macb-drop-tx-v2-2-647f5199d8df@bootlin.com>
 <20260429193446.5985abea@kernel.org>
Message-ID: <08335d886fb578f18b13f82deafe2995@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: A123249E7AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[tipi-net.de];
	TAGGED_FROM(0.00)[bounces-242041-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi Théo and Jacub

On 30.4.2026 04:34, Jakub Kicinski wrote:
> On Tue, 28 Apr 2026 18:32:58 +0200 Théo Lebrun wrote:
>>  	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
>> -		kfree(queue->tx_skb);
>> -		queue->tx_skb = NULL;
>> +		if (queue->tx_skb) {
>> +			unsigned int dropped = 0, tail;
>> +
>> +			for (tail = queue->tx_tail; tail != queue->tx_head;
>> +			     tail++) {
>> +				if (macb_tx_skb(queue, tail)->skb)
>> +					dropped++;
>> +				macb_tx_unmap(bp, macb_tx_skb(queue, tail), 0,
>> +					      SKB_DROP_REASON_NOT_SPECIFIED);
>> +			}
>> +
>> +			queue->stats.tx_dropped += dropped;
>> +			bp->dev->stats.tx_dropped += dropped;
> 
> I'm slightly baffled by the stats in this driver.
> 
> Incrementing of both device and queue stats is highly unusual.
> The driver seems to already have the values for the per-queue drops
> but currently never increments it (did I miss it?) It does for Rx
> stats but not for Tx stats.
> 
> As sashiko correctly points out incrementing dev stats will lead
> to races and lass of increments for multi-queue devices.
> 
> Since there are no increments for tx_dropped stat today - could you
> please delete it from ethtool -S, migrate the only existing
> dev->stats.tx_dropped++; to increment the per-queue stat and make
> macb_get_stats() collect the tx_dropped from all queues, instead
> of relying on the device-level stat?

Would make sense, yes. While we're already cleaning this up, two
more things possibly worth touching:

1. macb_start_xmit() drops the skb on macb_clear_csum() and
    macb_pad_and_fcs() failures without counting it. Both could
    use a tx_dropped++.

2. tx_packets / tx_bytes already increment per-queue but never
    rach nstat (rx side too). Could just pick them up in the same
    loop.

> [...]

Thanks,
Nicolai

