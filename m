Return-Path: <stable+bounces-217193-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ALSLdrslGnUIwIAu9opvQ
	(envelope-from <stable+bounces-217193-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 23:34:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7E715183D
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 23:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D46C53044367
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 22:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771382F6907;
	Tue, 17 Feb 2026 22:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sD2Htsze"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394BD28469F;
	Tue, 17 Feb 2026 22:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771367636; cv=none; b=aifD01hfTaY5rxE3dhGTkSjNASshEGXY5h9JwXJU2vvmrWS3rKFvILrDuM2Sjjikzg0qL9L5h0izi/bBCHItM1i5D+TA+foxmbFpyc6m5G3TYhwEFeNmEuLNH32rFM7vGTrQsTl6GNxTgrJjbKTy9fPg0Faug7MDy1w9Uu+nTsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771367636; c=relaxed/simple;
	bh=LlrpJcHFap7X5mLuKnk4GuwG/MJaw1lF4+KlirxoQsU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rkmmVGZJNNr8o291H7Aa4iA83ItMPgAiHIONIb5VlR9LhBoDPKKBjkPQhnargweuL3XC8dxOcIq+96eLlj9R4AdJUT3F2TGsyzsh6yN7vpQCT3Br8FLyNPSx8JnJXRM3UzmudIgxVzMDWFP4MU4cLvgH+WG9qjhWQcU4Hw0YLxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sD2Htsze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582D9C4CEF7;
	Tue, 17 Feb 2026 22:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771367635;
	bh=LlrpJcHFap7X5mLuKnk4GuwG/MJaw1lF4+KlirxoQsU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sD2Htsze+iZt25IH8dAnf2DJw4ZsoPTkKAPtN5Ye2aU0EcKrki7UIIQdIwDzkTnMg
	 +p5cFlEmi8RiSfyfqH0WFd92Q5C/QPKRcptTLFOMgCSP4HN7cfi8u2Jv6rbT0pDyI1
	 KhvLbXIqrrcIk6ROYypQTNkrrlUDM5yL4bjN1/XCquDZi8IhscHqCOq+BCfx3Mq25p
	 XMxX3bNOnJLRNnTd1KNznSlC8fPP648e3XjdRtNhI0ScEIU/EL+np1vf7WG5y6ZIFy
	 KQXxqXCc/vqriOBt15Uq65/AXFvbY7aJPzhfrvIkaQo2OHeIkXW3jwwH3WCWQz/9vC
	 0etW/OG9elpPQ==
Date: Tue, 17 Feb 2026 14:33:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Fabian Druschke <fdruschke@outlook.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Fabian Druschke <fabian@druschke.network>,
 Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] r8169: avoid OOM when allocating RX buffers
Message-ID: <20260217143354.3366db18@kernel.org>
In-Reply-To: <GVZP280MB1013A39E6B154E88E8CBB87EAF6DA@GVZP280MB1013.SWEP280.PROD.OUTLOOK.COM>
References: <20260216185245.182450-1-fabian@druschke.network>
	<64b1a578-5325-4d51-9b10-2b54fcaa0a7f@lunn.ch>
	<GVZP280MB1013A39E6B154E88E8CBB87EAF6DA@GVZP280MB1013.SWEP280.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,druschke.network,gmail.com,realtek.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-217193-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2E7E715183D
X-Rspamd-Action: no action

On Tue, 17 Feb 2026 22:50:30 +0100 Fabian Druschke wrote:
> Ahoy! Thanks for clarification! Didn't know it was intended behaviour.
> 
> We've encountered this issue specifically with this Realtek NIC on 
> ShredOS due to lack of mlx5, mlx4 etc.
> 
> For NICs like ixgbe we didn't encounter this issue so i was thinking 
> about a bug.

Most / all "professional grade"(??) NICs support scatter, where larger 
frames are written into multiple chunks, 4kB each. order-2 allocations
on the fast path are a bad idea. One way to alleviate the performance
implications would be to use page pool, but that doesn't help with the
initial fill, just the datapath :(

reminder: please avoid top posting when replying on the mailing list

