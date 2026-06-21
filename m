Return-Path: <stable+bounces-267579-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fU/mILlaOGqhbQcAu9opvQ
	(envelope-from <stable+bounces-267579-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 23:42:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C516AB9FB
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 23:42:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LEyG607A;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267579-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267579-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED1C93024517
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 21:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1749C371860;
	Sun, 21 Jun 2026 21:40:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078D42DCBFA;
	Sun, 21 Jun 2026 21:40:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782078050; cv=none; b=E7Mj2dGhsO3ta9WczvCRyOiEBDKahNKHD9i1oqxNnJkJotuiCzykba318GUmXjtO3KByM5XEmegGS0c7gdsledBGRJpABju2u9gsCwS2sB2c7LJ+/I+bYcBZMAKZ873yaomGLbrPfK4SwtMAgiw6BIk5MaEw5iY4pcsB+xqaUCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782078050; c=relaxed/simple;
	bh=X5pGV1s0tb8RzbdB2MLctPvgkzsHzHWrGSc/nN3KGsM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aEjKExGp8UkQxxTgjemYAiYI4dwQH3mM7ScfXig7SI2x0tBKfx5A1eDSwXnfKxBaIdYrshMY2sktzMMubHHpiAGoKzPR/ZPtTqHtgLaKY6AYPEZvhNQ2jq+Yzd6rxnklarFr4HRMznJSZKHcskI3cC6NIn2JMr6G/HpMdcFbAN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEyG607A; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6BB1F000E9;
	Sun, 21 Jun 2026 21:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782078049;
	bh=X5pGV1s0tb8RzbdB2MLctPvgkzsHzHWrGSc/nN3KGsM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LEyG607AjsH9UuvhNVXOCOfCZ9MkEPbKo2G30XGhwLDJbqZnDBH3zCYT5N0S/4qGQ
	 JdVH1dj/RFyr7nTj4rpAPcqN33Zq7b0Py9ZxtZjTL7fMNaSViW70Z56YZD6KNZBX4U
	 B7k2DgD1WtW2EiqJrtipDrqeUrTMBZHTDoMmPcWgH4sh8uCi4sPFyb99KbNjtURp83
	 jlMxEnmkJPeFLolkG/0STMvHgY7WK2+b3yZ6g2ZTotb4P5UFY9nYDBl/2Etfw7U/BA
	 xLtdkOLRgINbK/ONjHXP37Jo+MfG70fUWctXloQuqvnquIgZs0EAp8Qi3tYCnC6c7t
	 oqmkYatHIV8Jg==
Date: Sun, 21 Jun 2026 14:40:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Jeff
 Garzik <jeff@garzik.org>, Conor Dooley <conor.dooley@microchip.com>, Paolo
 Valerio <pvalerio@redhat.com>, Nicolai Buchwitz <nb@tipi-net.de>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?B?QmVub8OudA==?= Monin
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] net: macb: give reasons for Tx SKB kfree
Message-ID: <20260621144047.3db74e2b@kernel.org>
In-Reply-To: <20260617-macb-drop-tx-v3-1-d4c7e57d890b@bootlin.com>
References: <20260617-macb-drop-tx-v3-0-d4c7e57d890b@bootlin.com>
	<20260617-macb-drop-tx-v3-1-d4c7e57d890b@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267579-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:theo.lebrun@bootlin.com,m:nicolas.ferre@microchip.com,m:claudiu.beznea@tuxon.dev,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:hskinnemoen@atmel.com,m:jeff@garzik.org,m:conor.dooley@microchip.com,m:pvalerio@redhat.com,m:nb@tipi-net.de,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vladimir.kondratiev@mobileye.com,m:gregory.clement@bootlin.com,m:benoit.monin@bootlin.com,m:tawfik.bayouk@mobileye.com,m:thomas.petazzoni@bootlin.com,m:maxime.chevallier@bootlin.com,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C8C516AB9FB

On Wed, 17 Jun 2026 11:17:29 +0200 Th=C3=A9o Lebrun wrote:
> Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
> Cc: stable@vger.kernel.org

Interesting, did AI suggest this? It's fairly uncommon for drivers
to care about drop reasons, packet loss on egress ports is pretty
clearly attributed by tx_drops.

I don't think this belongs in net, net-next would be fine, if you think
it's necessary. Sashiko seems to point out a few more clear cut bugs.
--=20
pw-bot: cr

