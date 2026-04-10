Return-Path: <stable+bounces-235639-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LRjGtwh2WlRmggAu9opvQ
	(envelope-from <stable+bounces-235639-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 18:14:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 286483DA33D
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 18:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD684303B4EF
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 16:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486813D9045;
	Fri, 10 Apr 2026 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzbMeuh2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A02D329E5A;
	Fri, 10 Apr 2026 16:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775837397; cv=none; b=EzcNowZr/KANtbf5VbdroOWkXLPIHkrYe4dVZZKOWeQrhznbUcWqHTBrzZtV/omUAaVcyZHC71topD3QnyZEzGIV75hBRfJGLSOlQedygGeft55Sw6GK1k2u9BzuslUAlg0FMNND6Jvt5QyqjsmYA1YKtizq+SmNZ5qFKovDDFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775837397; c=relaxed/simple;
	bh=BPuIV3fPFpwYg6ix3BMQTX4oJCZmbgJcukjRLnv9PJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPkIKj+0yCOuSdZ44fBdi98O8itq4lJEVe1cpj5Bh8kJkzI8YT3+c+0PBv/iQ/1cWqnDOXTpJCoV8T/tcNQ0AvL93UGWuXSSfmhcmsiDfD9flBH+45STHTHMgdJV2vZGDiV5rQhlarMvJnXbFB+pQuMIcFzK51EHx7GwEe5qx28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzbMeuh2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37489C19421;
	Fri, 10 Apr 2026 16:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775837396;
	bh=BPuIV3fPFpwYg6ix3BMQTX4oJCZmbgJcukjRLnv9PJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jzbMeuh2xvk8XUGcUB2H31FMccXtVFoiiA/q/QzETocN+mXl9MZhzFcMVIsHlGdQT
	 XwnJIfVRjMHeM5bEDyHO/myXF9swjecey4ut/c1FeMqnH1s9Kg/l7yw3vOg/F0gBgZ
	 V30yAYoLS5R9il1N7A18BWfccqqzEb2KYEHGUQYJY06mNB8YuaaFVI2wWLi75F10C5
	 FxVQgGo346cL+Z9MtT+P3sTWqN4xs48NpQdHWh+9lkoGs5dcu+7qp9tUzKltAkVLaR
	 GPx9WHHgULx6kXV5j219ajoM0IgDPbpNyFHODOkuUYQRASBoBkBPME5ogBheuUqjSe
	 mdJpB9TdzqYWQ==
From: Simon Horman <horms@kernel.org>
To: mashiro.chen@mailbox.org
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gregkh@linuxfoundation.org,
	ben@decadent.org.uk,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/3] net: netrom: validate source address in nr_find_socket()
Date: Fri, 10 Apr 2026 17:09:43 +0100
Message-ID: <20260410160943.644081-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407171600.102988-3-mashiro.chen@mailbox.org>
References: <20260407171600.102988-3-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235639-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 286483DA33D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: netrom: validate source address in nr_find_socket()

This commit adds a source address parameter to nr_find_socket() to validate
incoming frames against the socket's dest_addr. This prevents unauthenticated
injection of crafted NR_INFO frames into existing connections.

> diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
> index b816c56124ab8..1da32c52a1931 100644
> --- a/net/netrom/af_netrom.c
> +++ b/net/netrom/af_netrom.c

[ ... ]

> @@ -219,7 +221,8 @@ static unsigned short nr_find_next_circuit(void)
>  		j = id % 256;
>  
>  		if (i != 0 && j != 0) {
> -			if ((sk=nr_find_socket(i, j)) == NULL)
> +			sk = nr_find_socket(i, j, NULL);
> +			if (!sk)
>  				break;
>  			sock_put(sk);
>  		}

This isn't a bug introduced by this patch, but does the loop in
nr_find_next_circuit() lack a termination condition?

If all 65,025 valid (i, j) circuit IDs are in use, nr_find_socket() will
always return a socket. The loop will increment id indefinitely, wrap around
65535, and never break, potentially triggering a CPU lockup in softirq
context.

Additionally, since the circuit ID is managed globally, is there a race
condition during its allocation? Multiple threads could concurrently execute
nr_find_next_circuit() and circuit++, leading to identical circuit IDs being
assigned to different connections.

[ ... ]

> @@ -923,7 +926,7 @@ int nr_rx_frame(struct sk_buff *skb, struct net_device *dev)
>  		if (frametype == NR_CONNREQ)
>  			sk = nr_find_peer(circuit_index, circuit_id, src);
>  		else
> -			sk = nr_find_socket(circuit_index, circuit_id);
> +			sk = nr_find_socket(circuit_index, circuit_id, src);
>  	}
>  
>  	if (sk != NULL) {

This isn't a bug introduced by this patch, but does nr_rx_frame() safely
access the socket buffer data?

It unconditionally accesses data up to skb->data[19], and for CONNREQ frames,
it copies 7 bytes from skb->data + 21. If the packet is shorter than 28 bytes,
could this cause an out-of-bounds read and leak adjacent kernel memory?

Furthermore, pskb_may_pull() is not called before these accesses.

Additionally, if an IP-over-NET/ROM packet is smaller than 20 bytes,
skb_pull() fails and is ignored, erroneously passing the unmodified packet
to the IP stack.

