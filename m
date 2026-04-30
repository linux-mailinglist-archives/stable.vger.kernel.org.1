Return-Path: <stable+bounces-241980-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0M+zKV7A8mnktwEAu9opvQ
	(envelope-from <stable+bounces-241980-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 04:37:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A88449C655
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 04:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EEB43040447
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 02:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96235287257;
	Thu, 30 Apr 2026 02:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etwG8gnx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D4E175A5;
	Thu, 30 Apr 2026 02:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777516489; cv=none; b=RmUZSNIKwg4Zk+25wv+lZJ1mrS06/4Ey0z934zQgXo054b2CTi8WjQ0p8B2E23vjv4T5kcd0LqG1m6tJLtAGhCApEPAhHmeLu9/xyEXjKaogel3FDWG9bVHMrwhsyW7bU3hJNJfY7ZXPCkJoXz9IMOn28F2Bfco0VmAokkDsB4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777516489; c=relaxed/simple;
	bh=Akn6BBdD9VzfdZuUDM8cGWmjnSwFKo+fMd1NMemYleY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DXyzsgkKhjckghHCduN8IIZMDMinlZNkwbNf8GbPvD21jcG1qiYcSi/PvCE7vrGp2QzLwM180Bj2GEI6izFAxTMvOcou7w46JAVPaBx+HdrYJYhtYwMOu/mU531giU2wm0tpmIdLMuwAyVmJtCN6Yl8zzcHlw916MdQKoKx6gBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etwG8gnx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDABBC19425;
	Thu, 30 Apr 2026 02:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777516488;
	bh=Akn6BBdD9VzfdZuUDM8cGWmjnSwFKo+fMd1NMemYleY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=etwG8gnxcw1f0mIkPJ4N1NlXamuy+3oKr+++bRrqZJOlX7OluoFD9kx6zdyiah44Y
	 Pgxae1oCn2+qLYw/kLEHMR/zvwKd1QZLl4CSxm/oXuS9V0WLVs8bEcWa4bu6KqJ0Tg
	 4sXYZmSTDFni3kXtEOFy2CvFet8i6Uzd4RdtvRsTuNwtermhmUNfTK/TIYo9q5LCTU
	 R7iiP/c1/dTesatYATC80BnVfyUrDvYl0P4OflSaWzXu60mrNsKp6X3rQxfD1twGZ0
	 ZMRUKTv5TIfLBce05avRvwVnz3Ynk4C8GyhZ9d1Adu6IsPKed/SyO+GNKzrLpAAHR7
	 HhVYAXggn3BBw==
Date: Wed, 29 Apr 2026 19:34:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Jeff
 Garzik <jeff@garzik.org>, Paolo Valerio <pvalerio@redhat.com>, Conor Dooley
 <conor@kernel.org>, Nicolai Buchwitz <nb@tipi-net.de>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?B?QmVub8OudA==?= Monin
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v2 2/4] net: macb: drop in-flight Tx SKBs on close
Message-ID: <20260429193446.5985abea@kernel.org>
In-Reply-To: <20260428-macb-drop-tx-v2-2-647f5199d8df@bootlin.com>
References: <20260428-macb-drop-tx-v2-0-647f5199d8df@bootlin.com>
	<20260428-macb-drop-tx-v2-2-647f5199d8df@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0A88449C655
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-241980-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, 28 Apr 2026 18:32:58 +0200 Th=C3=A9o Lebrun wrote:
>  	for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue) {
> -		kfree(queue->tx_skb);
> -		queue->tx_skb =3D NULL;
> +		if (queue->tx_skb) {
> +			unsigned int dropped =3D 0, tail;
> +
> +			for (tail =3D queue->tx_tail; tail !=3D queue->tx_head;
> +			     tail++) {
> +				if (macb_tx_skb(queue, tail)->skb)
> +					dropped++;
> +				macb_tx_unmap(bp, macb_tx_skb(queue, tail), 0,
> +					      SKB_DROP_REASON_NOT_SPECIFIED);
> +			}
> +
> +			queue->stats.tx_dropped +=3D dropped;
> +			bp->dev->stats.tx_dropped +=3D dropped;

I'm slightly baffled by the stats in this driver.

Incrementing of both device and queue stats is highly unusual.
The driver seems to already have the values for the per-queue drops
but currently never increments it (did I miss it?) It does for Rx
stats but not for Tx stats.

As sashiko correctly points out incrementing dev stats will lead
to races and lass of increments for multi-queue devices.

Since there are no increments for tx_dropped stat today - could you
please delete it from ethtool -S, migrate the only existing
dev->stats.tx_dropped++; to increment the per-queue stat and make=20
macb_get_stats() collect the tx_dropped from all queues, instead
of relying on the device-level stat?

This should be patch 2 in this series, and then subsequent patches
don't have to do this double-counting dance.

I suppose you may want to migrate the byte and packet counters
while at it, and add a u64 sync...

