Return-Path: <stable+bounces-239245-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0K1NNEFL5mnSuQEAu9opvQ
	(envelope-from <stable+bounces-239245-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:50:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E14042EA22
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B61C334199F
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FF12D5937;
	Mon, 20 Apr 2026 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kM3jkTWP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331762C11D9;
	Mon, 20 Apr 2026 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776696523; cv=none; b=H2cB9WhVF8ctkC5fmBDwApX0/GZ7M0X7boJmcCelpPvTBowC+IT6fbYiqMbTPQTIzQ76ZTEvQYdD+686pGMp2dCZcAfFwmkLWy14cUBtQvVSrXT4znyqNVrrkVIxJOUFiDnnaF6RuxQftdwxdlWvLtDseJ7cozaHW0qFzBp6O3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776696523; c=relaxed/simple;
	bh=00lttEm2yNSCLaaJ8HV0cNziy+CMymLYRCkfifHVXt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+/KSZ8wsi2KtYge4K53g/l4yiFz2Plo4GpWnQPGOIUWzj4n+6xaSYSmkHytbNi5sLgmUqVkZj7/6YXkLez33pVOYUVPY4QP/MuyoMlAEzNgPWe3RMgMhmXwGLggLLXKPezhvfzeoIST5RmGRzk3c6IvbcGKITF21bFDAmbjFGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kM3jkTWP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5322BC19425;
	Mon, 20 Apr 2026 14:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776696522;
	bh=00lttEm2yNSCLaaJ8HV0cNziy+CMymLYRCkfifHVXt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kM3jkTWPV3Q8HCVBAxHNmFZK9cH3tU0uIg5DKX+c+gMrfA2OU1BvZiBa69sy0M/bj
	 Cq9J7X+AIQYVPeSUCYbgS+azA/f8fURibttQRs0c8d2hBlczjnSKhy4Tmpvc7RRZS+
	 E8OCaydFmFGIWC+P8/1TKO794wXt43L/meWdcpoP1adw0+oJZbVCUYO1a7eNuX9pAL
	 M67J/00G/YzAKktbTDQOxRtSmzO8yXSoMWxkWC+VT2OVTJ7fA0ZHYxnfV+ltdIoNYz
	 b0fxGRRm3bb+H+GA+hSv2ApeaOZ0DWVxPvm7ODM7zJ6s1MST3M6ApG2RNtkmTcC4Cd
	 nmlfYOHhk2Cdg==
From: Simon Horman <horms@kernel.org>
To: ashutoshdesai993@gmail.com
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-hams@vger.kernel.org,
	jreuter@yaina.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.laight.linux@gmail.com
Subject: Re: [PATCH v4 net] ax25: fix OOB read after address header strip in ax25_rcv()
Date: Mon, 20 Apr 2026 15:30:02 +0100
Message-ID: <20260420143001.537302-2-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417065407.206499-1-ashutoshdesai993@gmail.com>
References: <20260417065407.206499-1-ashutoshdesai993@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239245-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,yaina.de,davemloft.net,google.com,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E14042EA22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ax25: fix OOB read after address header strip in ax25_rcv()
    
A crafted AX.25 frame with a valid address header but no control or PID
bytes causes skb->len to drop to zero after skb_pull() strips the
address header. The subsequent reads of skb->data[0] and skb->data[1]
are then out of bounds.

> diff --git a/net/ax25/ax25_in.c b/net/ax25/ax25_in.c
> index d75b3e9ed93de..d14ccebf9cdd5 100644
> --- a/net/ax25/ax25_in.c
> +++ b/net/ax25/ax25_in.c
> @@ -190,6 +190,9 @@ static int ax25_rcv(struct sk_buff *skb, struct net_device *dev,
>  	ax25_cb *ax25;
>  	ax25_dev *ax25_dev;
>  
> +	if (skb_linearize(skb))
> +		goto free;

Could calling skb_linearize() before verifying if the device is configured for
AX.25 introduce a regression?

Since ax25_packet_type is registered globally, ax25_rcv() receives all
ETH_P_AX25 packets from any network interface. skb_linearize() performs
memory allocations to coalesce fragmented packets. By performing this before
checking if ax25_dev is NULL, could an attacker send fragmented ETH_P_AX25
packets to an unconfigured interface to force unnecessary memory allocation
and CPU cycles?

Should the skb_linearize() call be moved after the device configuration check?

> +
>  	/*
>  	 *	Process the AX.25/LAPB frame.
>  	 */
[ ... ]
> @@ -217,6 +220,9 @@ static int ax25_rcv(struct sk_buff *skb, struct net_device *dev,
>  	 */
>  	skb_pull(skb, ax25_addr_size(&dp));
>  
> +	if (skb->len < 2)
> +		goto free;

Does this unconditionally drop all AX.25 LAPB control frames?

Standard AX.25 LAPB control frames (such as SABM, DISC, UA, DM, and RR)
consist solely of a 1-byte Control field and no PID byte. For these connection
management frames, skb->len is exactly 1 after the address header is pulled.
By discarding all frames shorter than 2 bytes, could this break the ability
to establish, acknowledge, or disconnect AX.25 connections?

Should the initial check only verify skb->len >= 1, and any requirement for
skb->len >= 2 be strictly scoped to the code paths that actually parse a PID
byte?

Also, if this skb->len < 2 check is relaxed, there is a pre-existing
out-of-bounds read in ax25_decode() for extended modulus frames.

If a malformed 1-byte frame is received on an extended modulus (AX25_EMODULUS)
connection, ax25_decode() unconditionally reads skb->data[1] for I-frames and
S-frames. It then calls skb_pull(skb, 2) but ignores the return value. Should
ax25_decode() validate that skb->len >= 2 before parsing the second control
byte for extended modulus frames?

Finally, there appears to be a pre-existing use-after-free and list corruption
in the ax25_rcv() error path when allocating memory for ax25->digipeat.

When handling an incoming connection request for a listener socket, the code
physically links the skb into the listener socket's receive queue via
skb_queue_head(&sk->sk_receive_queue, skb). Shortly after, it attempts to
allocate memory. If this allocation fails, the error path explicitly calls
kfree_skb(skb).

However, it fails to unlink the skb from sk->sk_receive_queue. (The subsequent
call to ax25_destroy_socket() flushes the newly created socket's queue, not
the listener socket's queue). This leaves a freed skb in the listener socket's
queue. When a user process later calls accept(), will it dequeue and
dereference the freed skb, resulting in a use-after-free?

