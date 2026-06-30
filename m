Return-Path: <stable+bounces-269921-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tMwsMbCLQ2oObAoAu9opvQ
	(envelope-from <stable+bounces-269921-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 11:26:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A706E221F
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 11:26:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=MQOn4K22;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269921-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269921-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4E213046356
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 09:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3273A358369;
	Tue, 30 Jun 2026 09:20:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090ED313E34
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 09:19:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782811202; cv=none; b=RtDF2mp7Drw9WgUlp5jea9+w8DhM7ENDs6+XaaZVZqrUMp81N2cnlxWgYurit1gnyL39gUxFnaltAAM2FtKA1XyZYG4bHYCj+5NiOm7oaft1VYLEMCNloqfcOFIfFybcVAK4FucoXflef1oZkitIJK0Nc3QyO75jdvsbrcdlW54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782811202; c=relaxed/simple;
	bh=Rz9u1wL+cfAoqAlVFh7Bm1MXtHcdFkD5ED4Y8Ra58IU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=I+6zjnInmLseBtfgNp6YDiP3WkCamuAxy65oagXduad7vLXYEww7CdKpUiK1roECFMmZnxNp3AGpqoa0dmlC94DlSzMDXJhAcOR7674TabzKsqyTlETtpdaL3c9kFb9iJpgc0UBLfLBqDda+JiaLB6GguLyqu7zH/gXHOn35mks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MQOn4K22; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C4B6FC51474;
	Tue, 30 Jun 2026 09:20:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4CB6060233;
	Tue, 30 Jun 2026 09:19:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6F5EC106F1D29;
	Tue, 30 Jun 2026 11:19:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782811197; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Rz9u1wL+cfAoqAlVFh7Bm1MXtHcdFkD5ED4Y8Ra58IU=;
	b=MQOn4K22FB+ZSukXRORS4ivpsz2hVhO0/wA9SMAODocZazKzX/q4DeWw232cyAXUltY7Ka
	QowY2GcacH16AvrJyWJaYU/PHqgxHAblRdIaHy6J9GKzYQROGQDvvZYmuHPX5DL2Jogg39
	Z+9NjcB8llBOzvodZpJfYNxnvIUwFnssGgn2MAw5JQrcJDK1PA8IZxlqTrv17xilh7FthK
	GdW9ntLZtVateNC8nE1AvJj6Zb/vvyqc/WEifUGkEA/cY9avP//uclSNPtpC2bxz3KaRkw
	BnhAT1vRne7EhOe7iIlKSJVk2d5UEv+I8Cto4veLhTBDIMh1JnmXvft/XM7ZEA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 11:19:43 +0200
Message-Id: <DJM9TJAOURO5.1QAA84FHLOMEF@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net v3 1/2] net: macb: give reasons for Tx SKB kfree
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Paolo Abeni" <pabeni@redhat.com>, "Haavard Skinnemoen"
 <hskinnemoen@atmel.com>, "Jeff Garzik" <jeff@garzik.org>, "Conor Dooley"
 <conor.dooley@microchip.com>, "Paolo Valerio" <pvalerio@redhat.com>,
 "Nicolai Buchwitz" <nb@tipi-net.de>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>, <stable@vger.kernel.org>
To: "Jakub Kicinski" <kuba@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260617-macb-drop-tx-v3-0-d4c7e57d890b@bootlin.com>
 <20260617-macb-drop-tx-v3-1-d4c7e57d890b@bootlin.com>
 <20260621144047.3db74e2b@kernel.org>
In-Reply-To: <20260621144047.3db74e2b@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[theo.lebrun@bootlin.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-269921-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:nicolas.ferre@microchip.com,m:claudiu.beznea@tuxon.dev,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:hskinnemoen@atmel.com,m:jeff@garzik.org,m:conor.dooley@microchip.com,m:pvalerio@redhat.com,m:nb@tipi-net.de,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vladimir.kondratiev@mobileye.com,m:gregory.clement@bootlin.com,m:benoit.monin@bootlin.com,m:tawfik.bayouk@mobileye.com,m:thomas.petazzoni@bootlin.com,m:maxime.chevallier@bootlin.com,m:stable@vger.kernel.org,m:kuba@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:mid,bootlin.com:url,bootlin.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 44A706E221F

Hello Jakub,

On Sun Jun 21, 2026 at 11:40 PM CEST, Jakub Kicinski wrote:
> On Wed, 17 Jun 2026 11:17:29 +0200 Th=C3=A9o Lebrun wrote:
>> Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
>> Cc: stable@vger.kernel.org
>
> Interesting, did AI suggest this? It's fairly uncommon for drivers
> to care about drop reasons, packet loss on egress ports is pretty
> clearly attributed by tx_drops.
>
> I don't think this belongs in net, net-next would be fine, if you think
> it's necessary. Sashiko seems to point out a few more clear cut bugs.

I don't use AI for kernel code generation, only code exploration and
reviews.

In MACB we know our stats are pretty broken (including tx_drops) but
fixing stats is a full refactor that will come later and is too large
for this bugfix. So I used the drop reason mechanism to have a way to
notice dropped packets, otherwise we have nothing.

My commit message should have covered this in more details!

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


