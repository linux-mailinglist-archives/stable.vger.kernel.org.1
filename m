Return-Path: <stable+bounces-266699-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CBtABBpwMmrkzwUAu9opvQ
	(envelope-from <stable+bounces-266699-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 11:59:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E07F698312
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 11:59:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b="vQ/fXft/";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266699-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-266699-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B31D832CF68C
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 09:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FF43CCFDB;
	Wed, 17 Jun 2026 09:49:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D96A3CCA19;
	Wed, 17 Jun 2026 09:49:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689798; cv=none; b=ZnoN0TTLitQ1Jchcotd5NOrsvYTAsWUKxmYALUF8FhEx/wlrOCCEYSPjEaBT/LFtmM4uqTOJwDHhhd6K8x0W+foNj53+1l7gSNW+bNHoGwwGKj/YcpJMGWuBeLOpU/ASHI+QKued59BejrR4UxK4BeHxu4TGveJAtG7szUYMq5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689798; c=relaxed/simple;
	bh=zfVCtgTRAsvS+D3aeQbbK75JiVp3SqwTgEE46PHUzYs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=rFRxEBkqkmd1aOSlPgxW/3ui4KAe9cgcAdl3BjFZhz/sG5o03qPIuKCtQRsxRWQfS8KasjPE1REIMLJkEqkO+m7oycPgidZXMhdrQycm+zmwkOg8YBBGUZlGq1R008S3c32L2Pim1nrWsW5BfV82j3N4XVbR79Ll11p1R71QQdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=vQ/fXft/; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 96972A3D4C;
	Wed, 17 Jun 2026 11:49:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1781689793; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hf9QkZGmUnC30a53FfAC7EiUIkOgNwS4+ou504SVgNQ=;
	b=vQ/fXft/e5Zqd3TnCz3P+bXA/fCTXUM+7AziJv1w3xZXegBO7jfLqg/KmzfVwh9rErZjip
	Br1LglAlOqImEWq62SCTjPUjC099mK2wlDNT0mDprbF0oTMEPWxFk0YtI6vaMg5bPTlm9Q
	M+llX2tGyuCRtfEDFX4Oh85OVycQ0CmDNt1/swRfpFvwAtHp/xi5pKmCJfKoXjct3TaM9w
	8CH2lJkmOMUOy7CWURJc0I/kGJh0JDuhjso2YCx50HYQ+8FMJy4YcQFnTdX2Ss07AH/7ZY
	mwJHkJB0WRO+yKu56KpnjZGGDND/0/ElFtdk+XN2BdZBwUS9/7DvfpQEe1iciA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 17 Jun 2026 11:49:45 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Haavard
 Skinnemoen <hskinnemoen@atmel.com>, Jeff Garzik <jeff@garzik.org>, Conor
 Dooley <conor.dooley@microchip.com>, Paolo Valerio <pvalerio@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?Q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v3 2/2] net: macb: drop in-flight Tx SKBs on close
In-Reply-To: <20260617-macb-drop-tx-v3-2-d4c7e57d890b@bootlin.com>
References: <20260617-macb-drop-tx-v3-0-d4c7e57d890b@bootlin.com>
 <20260617-macb-drop-tx-v3-2-d4c7e57d890b@bootlin.com>
Message-ID: <133833c652ac0c979cf84865f2e5c7c5@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	FORGED_RECIPIENTS(0.00)[m:theo.lebrun@bootlin.com,m:nicolas.ferre@microchip.com,m:claudiu.beznea@tuxon.dev,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:hskinnemoen@atmel.com,m:jeff@garzik.org,m:conor.dooley@microchip.com,m:pvalerio@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vladimir.kondratiev@mobileye.com,m:gregory.clement@bootlin.com,m:benoit.monin@bootlin.com,m:tawfik.bayouk@mobileye.com,m:thomas.petazzoni@bootlin.com,m:maxime.chevallier@bootlin.com,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[nb@tipi-net.de,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-266699-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid,tipi-net.de:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6E07F698312

On 17.6.2026 11:17, Théo Lebrun wrote:
> The MACB driver has since forever leaked the outgoing SKBs that
> have not yet been marked as completed. They live in queue->tx_skb
> which gets freed without remorse nor checking.
> 
> macb_free_consistent() gets called in a few codepaths, but only
> close will trigger the added expressions. In macb_open() and
> macb_alloc_consistent() failure cases, tx_skb just got allocated
> and is empty.
> 
> Use the new macb_tx_unmap() prototype to report our error as
> SKB_DROP_REASON_NOT_SPECIFIED rather than SKB_CONSUMED which makes it
> sound like no error occurred. Equivalent to dev_kfree_skb_any().
> 
> Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai

