Return-Path: <stable+bounces-241849-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKVnHvPO8WlrkgEAu9opvQ
	(envelope-from <stable+bounces-241849-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 11:27:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 744C0491E1A
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 11:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 654F83008091
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 09:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D1421B9F6;
	Wed, 29 Apr 2026 09:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1nArF057"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D86B37D137;
	Wed, 29 Apr 2026 09:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454827; cv=none; b=JScX3syGl3TVjs5u3vQfgrH7k0RoMRqA7VBiTTQDWxA9Szg9zx4zwdU9E04RlXlQHRuz5JBkqshBGXoKQK5V40KYDcjhPxJcbNkiRpy3f1e/zFHuosU+FEnVAi+gXcU+DwR41wq/bID56AyZJ9kcespdUUqd+QXR2ZRcuuIJH5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454827; c=relaxed/simple;
	bh=e9kpVznoXWPmdDZYzo5h7YVmLm1mINreekjC/IMMlhU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=QlQnMt31rsk7tw91AcRWQzRpZTDnvlTdKrwjq5zhhrqZajghNKx9d5I3LZ3FnM7JNv0NnG+IU1TI3+MvpAn1jlVu+jKpj8FHJSpnhSonbbZPhb2L3u6rx/fO8SHy5lT/Whu1GaF+5fn+Nfr4s8CJl0PpLvBimwX3yPtwIDeer5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1nArF057; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 14CCC4E42B3E;
	Wed, 29 Apr 2026 09:27:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CCBA9601DF;
	Wed, 29 Apr 2026 09:27:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B918D10729379;
	Wed, 29 Apr 2026 11:26:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777454821; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=xZ8VMjmAuXE7bj1xiXzUWvyTTPxElhI0qs5AYciLeQ8=;
	b=1nArF057MsMdZUgpYhN6s2KAv0T+92sKVtzrc9vC4QAfR0RXrUhkbBhxtmA9h1DCjxoujY
	QVnIjPjFlbwJud/AmAcnGvuzmaW9fNl+GOe/afSDYnBUDnQOsdmCsbUSVr07HAWddXsSj6
	IaJksiqOzEQDbMp/0m5HTQvuorwLatoJIiupolrhAKmWuSoHdq+e/nz2zG+3ZoZdJ3NoaR
	4IcS4+0df/byy5pe321xxmEhjDt40kcvH7xHhQeSRjvf3VI3HkbxyISGfetNNkseaCEuuH
	piAruBTpPYZ/tTLULngBtcnjj1Br7ipcaommegW5qt2UElS4/W4X+FyrPFgq1A==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 11:26:47 +0200
Message-Id: <DI5J5659IHRK.2VDGEBK93OQJP@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net v2 2/4] net: macb: drop in-flight Tx SKBs on close
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Haavard Skinnemoen" <hskinnemoen@atmel.com>, "Jeff Garzik"
 <jeff@garzik.org>, "Paolo Valerio" <pvalerio@redhat.com>, "Conor Dooley"
 <conor@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>, <stable@vger.kernel.org>
To: "Nicolai Buchwitz" <nb@tipi-net.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260428-macb-drop-tx-v2-0-647f5199d8df@bootlin.com>
 <20260428-macb-drop-tx-v2-2-647f5199d8df@bootlin.com>
 <75229fab491465e06a98ee580a51f0b4@tipi-net.de>
In-Reply-To: <75229fab491465e06a98ee580a51f0b4@tipi-net.de>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 744C0491E1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241849-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:email,bootlin.com:dkim,bootlin.com:url]

Hello Nicolai,

On Tue Apr 28, 2026 at 11:30 PM CEST, Nicolai Buchwitz wrote:
> On 28.4.2026 18:32, Th=C3=A9o Lebrun wrote:
>> The MACB driver has since forever leaked the outgoing SKBs that
>> have not yet been marked as completed. They live in queue->tx_skb
>> which gets freed without remorse nor checking.
>>=20
>> macb_free_consistent() gets called in a few codepaths, but only
>> close will trigger the added expressions. In macb_open() and
>> macb_alloc_consistent() failure cases, tx_skb just got allocated
>> and is empty.
>>=20
>> Use the new macb_tx_unmap() prototype to report our error as
>> SKB_DROP_REASON_NOT_SPECIFIED rather than SKB_CONSUMED which makes it
>> sound like no error occurred. Equivalent to dev_kfree_skb_any().
>>=20
>> Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>> ---
>>  drivers/net/ethernet/cadence/macb_main.c | 22 ++++++++++++++++++++--
>>  1 file changed, 20 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c=20
>> b/drivers/net/ethernet/cadence/macb_main.c
>> index 9caae1ef52b1..5a2500bd59a6 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -2678,8 +2678,26 @@ static void macb_free_consistent(struct macb=20
>> *bp)
>>  	dma_free_coherent(dev, size, bp->queues[0].rx_ring,=20
>> bp->queues[0].rx_ring_dma);
>>=20
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
>
> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks for the review!
We are quite a few caring about MACB which is nice.

> Side note, not blocking: macb_close() doesn't cancel tx_error_task,
> so the workqueue handler can race with this loop on tx_skb[]. The
> exposure is pre-existing, but maybe worth a follow-up adding
> cancel_work_sync() between napi_disable() and macb_free_consistent().

Yes, noticed that while working on the context swapping series [0].
The goal here is to improve MACB piecewise, so I won't take that on in
the current series.

[0]: https://lore.kernel.org/all/90f843aa3940bdbabadddce27314c1f1@tipi-net.=
de/t/#mda18f759c27a4d833084b23605463994632d97e3
     (and the two replies)

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


