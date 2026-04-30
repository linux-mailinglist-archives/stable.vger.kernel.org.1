Return-Path: <stable+bounces-242158-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHlqGKuB82kY4wEAu9opvQ
	(envelope-from <stable+bounces-242158-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 18:22:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4B74A59B3
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 18:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15B13305A3FF
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 16:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7008F4657DA;
	Thu, 30 Apr 2026 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R6dIxE6U"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A8545BD57;
	Thu, 30 Apr 2026 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566020; cv=none; b=uqF2xrb7ssRMqzc8hHl23UEggipd4ypvYcXm0oZliCs+NTK5iKB0afbpeTh7/dSFtU1By82APYr0VFPOL1lAwJOnmm0KgXrifcgn26ysOg1FPjzvZnd1/0+/O4Pxo4kk1siLZvW2zIxjqhvXAL0t3A51SfKpnZMB5HYIwfMtYEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566020; c=relaxed/simple;
	bh=E2SKPUsUqU+3vPOonTNGjXVFFdcFDlAnxiNBfRQyCts=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=jjdXHOEOPJcR4Xahdp1oBMK2uZBVqMkFv+syT2uzYPe3nsgQQlxU4efJnr4+YP+zixIeYvpU9Lrl44yGDwlMqrz5o4LAhFZ1lXKOLgWJnsdujlHYmFV/ymHyvLNMCoSQlX+0yKrpeAadxwumQojx+qhCFg2NqMkR7dAjtUpuHXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R6dIxE6U; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 96DDD1A3489;
	Thu, 30 Apr 2026 16:20:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 67062601DF;
	Thu, 30 Apr 2026 16:20:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E2EFE11AC9346;
	Thu, 30 Apr 2026 18:20:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777566014; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3Bi+4lUG6gSEZp6P+IQVg5hHVjrg/DNa8f+Q/OrWakE=;
	b=R6dIxE6UeJHb3IJWoP5AjOqIMP5hS8HjvAxpqCFwoGDsIUyEc3UC+CufNMrVteeX5COYLa
	n5vuxJaWZUZCjNdkbxFHDgDOzGzLEMH9CMwbZPmarpJjnum8IJqP7B4EZ1s7RaOW2L7HGU
	BBoeZsHOROojOw13UHbyM8qZgA5Q7wURC937eIcEnxJ0mKBUTpZMWeal6lM3kgVQxGvc2p
	xea0gpF21AgpU9FxRG4O6JLvcFilPkvAoDC9oiY2x9ozIEhMb5jwvM03WDPLT0siT/7Q0x
	0GxtL5cNowkDpIO3bQIihdWpA4PbX5peGjlOpQHAkx1VP8gqs6lOEdhaCGU9mg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Apr 2026 18:20:01 +0200
Message-Id: <DI6MK3PFX8EE.1R1567RYTUVNL@bootlin.com>
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Paolo Abeni" <pabeni@redhat.com>, "Haavard Skinnemoen"
 <hskinnemoen@atmel.com>, "Jeff Garzik" <jeff@garzik.org>, "Paolo Valerio"
 <pvalerio@redhat.com>, "Conor Dooley" <conor@kernel.org>, "Nicolai
 Buchwitz" <nb@tipi-net.de>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>, <stable@vger.kernel.org>
To: "Jakub Kicinski" <kuba@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net v2 2/4] net: macb: drop in-flight Tx SKBs on close
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260428-macb-drop-tx-v2-0-647f5199d8df@bootlin.com>
 <20260428-macb-drop-tx-v2-2-647f5199d8df@bootlin.com>
 <20260429193446.5985abea@kernel.org>
In-Reply-To: <20260429193446.5985abea@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: CD4B74A59B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242158-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,bootlin.com:dkim,bootlin.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hello Jakub,

On Thu Apr 30, 2026 at 4:34 AM CEST, Jakub Kicinski wrote:
> On Tue, 28 Apr 2026 18:32:58 +0200 Th=C3=A9o Lebrun wrote:
>>  	for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue) =
{
>> -		kfree(queue->tx_skb);
>> -		queue->tx_skb =3D NULL;
>> +		if (queue->tx_skb) {
>> +			unsigned int dropped =3D 0, tail;
>> +
>> +			for (tail =3D queue->tx_tail; tail !=3D queue->tx_head;
>> +			     tail++) {
>> +				if (macb_tx_skb(queue, tail)->skb)
>> +					dropped++;
>> +				macb_tx_unmap(bp, macb_tx_skb(queue, tail), 0,
>> +					      SKB_DROP_REASON_NOT_SPECIFIED);
>> +			}
>> +
>> +			queue->stats.tx_dropped +=3D dropped;
>> +			bp->dev->stats.tx_dropped +=3D dropped;
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
> dev->stats.tx_dropped++; to increment the per-queue stat and make=20
> macb_get_stats() collect the tx_dropped from all queues, instead
> of relying on the device-level stat?
>
> This should be patch 2 in this series, and then subsequent patches
> don't have to do this double-counting dance.
>
> I suppose you may want to migrate the byte and packet counters
> while at it, and add a u64 sync...

Agreed. Here is the plan for next revision. It goes further than your
proposal on some aspects and less so on others.

 - Stop using `netdev->stats`. Not even on MACB (single queue) or from
   at91 code (single queue, custom functions for a lot of things). This
   will drop all the double-counting; I added some in this series but
   there is lot in the driver to drop.

   sed 's/netdev->stats/queue->stats/' **/macb_main.c  # -ish

 - All stats that used to land in netdev->stats will instead land in
   queue->stats. For that we need to add two fields:
    - multicast, incremented by at91ether_rx()
    - tx_errors, incremented by at91ether_interrupt()

 - Make queue->stats u64 values (getting inspiration from nstat).

 - In macb_get_stats(), replace:

      netdev_stats_to_stats64(nstat, &bp->dev->stats);

   by:

      for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue)=
 {
         u64_stats_fetch_begin(...);
         nstat->rx_packets +=3D queue->stats.rx_packets;
         nstat->tx_packets +=3D queue->stats.tx_packets;
         // ... same for all stats ...
      }

 - Also the struct name (struct queue_stats) deserves a driver prefix.

Notice we don't drop tx_dropped from `ethtool -S`. It might be useful to
get per-queue stats and it doesn't cost much. We need per-queue
counters anyway, let's keep exposing them.

I don't have time to test enough, next revision will wait next week.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


