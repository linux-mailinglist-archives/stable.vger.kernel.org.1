Return-Path: <stable+bounces-241956-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJ7WCO+C8mnLsAEAu9opvQ
	(envelope-from <stable+bounces-241956-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 00:15:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 794CD49AD11
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 00:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A5D7302AE09
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 22:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB594266BA;
	Wed, 29 Apr 2026 22:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="hj/9APhO"
X-Original-To: stable@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F471A6819;
	Wed, 29 Apr 2026 22:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777500902; cv=none; b=LmTQffq/PYG5/9VFh1f5G67XuoM6FQXh0cODBDTKqml4hGILE9ppW0MY5/PM3U46c66eqcMXa4fZTpQVCMB1CfBF71taxgyydFIQU8tSGy78I5xQ+aDHL6AkBWSyxQIyOP1w5AF6OXO3bUlEhqEU7vYG4p+8h/+hHJTFP/dHyYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777500902; c=relaxed/simple;
	bh=HT26rCSHP7clF/Q6nvPHVhG4+FSjhFhTgoNSTML3fLc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=RwDQgLF5eJka9lY5tJPg/LuJ3Emf9uDTkBBboLi9r+7PwE6Uiwm3LOVhnZuGzsWgjRdLX8ydzol/TO4n4f0G5WHzPfJg5xNDR9F4n4hGkRGkLSI/fWmmfmeaU8ALmupy8/lthjFUv4X/CuNbTv4t0DvBO6d7m9h2zPePk/xGoZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=hj/9APhO; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3F538A3C20;
	Thu, 30 Apr 2026 00:14:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1777500889; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7BzH4qdeDi13MyxTGrEycFeytt8YAjgTx/LRGdh9EU4=;
	b=hj/9APhOG7xv9bwIo0S5OI+KMe2TJPUcRp/fSesPsu+tjUb08UvR9h79VYmk7yRKcYQAzF
	4NwDMYQXEuXV/0dAMur/0sGJD9yn94rl4PT3qxxNpnmkpG7q9+SzzlkJC9rjoHoZWvjCov
	50TKGyQf0zNn2SJ3RtHeMBUsRBnTg39+2JiicHcl8RWFjMiM4g8T53jrKksXTpiqG5jyZC
	B9gF27oqA2VPHL0QcfTKCgn1P7WnxZVpFgbWTRqRNaLtJoSh2mJ1P6TzEvDOlGag0z8GkB
	ZFYk9cAK78sScCM/UBWeBqLkpJY6joAb10kyP5jvgkGu55a4nzJ1fqCqPxQhMg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Apr 2026 00:14:46 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Haavard
 Skinnemoen <hskinnemoen@atmel.com>, Jeff Garzik <jeff@garzik.org>, Paolo
 Valerio <pvalerio@redhat.com>, Conor Dooley <conor@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?Q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v2 2/4] net: macb: drop in-flight Tx SKBs on close
In-Reply-To: <DI5J5659IHRK.2VDGEBK93OQJP@bootlin.com>
References: <20260428-macb-drop-tx-v2-0-647f5199d8df@bootlin.com>
 <20260428-macb-drop-tx-v2-2-647f5199d8df@bootlin.com>
 <75229fab491465e06a98ee580a51f0b4@tipi-net.de>
 <DI5J5659IHRK.2VDGEBK93OQJP@bootlin.com>
Message-ID: <a1fa54317d5a534bd7e6746754a754e8@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 794CD49AD11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241956-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]

Hi Théo

On 29.4.2026 11:26, Théo Lebrun wrote:
> [...]

>> Side note, not blocking: macb_close() doesn't cancel tx_error_task,
>> so the workqueue handler can race with this loop on tx_skb[]. The
>> exposure is pre-existing, but maybe worth a follow-up adding
>> cancel_work_sync() between napi_disable() and macb_free_consistent().
> 
> Yes, noticed that while working on the context swapping series [0].
> The goal here is to improve MACB piecewise, so I won't take that on in
> the current series.
> 
> [0]: 
> https://lore.kernel.org/all/90f843aa3940bdbabadddce27314c1f1@tipi-net.de/t/#mda18f759c27a4d833084b23605463994632d97e3
>      (and the two replies)

Yes, flagged it on that series too. Wasn't my intention to fold it
into this one either, just wanted to make sure it doesn't get lost
with so much in flight on macb right now, which I really appreciate!

> [...]

Cheers,
Nicolai

