Return-Path: <stable+bounces-233240-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPOdDK4+0GkL5QYAu9opvQ
	(envelope-from <stable+bounces-233240-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 00:26:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82407398B9F
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 00:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDD893024C9E
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 22:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388673596E3;
	Fri,  3 Apr 2026 22:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRH4SFaD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0D1625;
	Fri,  3 Apr 2026 22:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775255202; cv=none; b=X3OntXR16BAizqW5jtsUWo820oRnwrRCQKY2eD6mK+s6GB4gu37dc+vs3ruCT35cjNy5cgdAKICvgbQ6b8qieZn2FBSQLVWlISqD9oVSvDojHeUTiNJEH8CIsvQmCMC/EADssD187EGT71noPUvRzO7bFTZvmQ4UXXMAzqZd14Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775255202; c=relaxed/simple;
	bh=7ufy+ZHgftsIsq8ig2HhUv3cMxcCahew1M3qeKmgSjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5G5IYkp5v6Dutuh2CfpDawPuAOdobsSn1k7ozT5Q9AM/f+H7dswfl9ZpZnKZGn/xjiG/TBl+e0+J1ChS4Hb54vovHFUy+7sQl0L+fixrh3Dk6ggTqE+gAfmZOsWsx6Rgkum4KjQoySn2TDORyZATcszPnSh9leyc60WN7QU3S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRH4SFaD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150B2C4CEF7;
	Fri,  3 Apr 2026 22:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775255201;
	bh=7ufy+ZHgftsIsq8ig2HhUv3cMxcCahew1M3qeKmgSjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MRH4SFaD6XPXRn5dambTucgppGVL4fVwWmuHM9ZYFE2gZ0jO4LhMYW78alaB7AnNk
	 3vjy5tDWHnAu5yhOobQoR8WDYABJlE4a9N4oQWwfwjpkNFrq4Zr0nvo187W+Qi4pP2
	 QuQTy+boCKsJIes9+1ABxmXybMzJkbiQ4HhaVEQjeqKS5VtJy4jxK+JEWihZ1iEoQ8
	 0Yjq3ezRsFs2JWLuM4EJfeD55zlN1JwXKXgb0JY1a61Jm7Kwq3ukxhQxC2NgYrTrRi
	 6fusp+iBlvijW8H4MIpgy4H8z4fNfhXsvmFMyVkQZYD3Y/V25wt6gessQ6M5i08TYC
	 ZCe/QzwwFhyBw==
From: Jakub Kicinski <kuba@kernel.org>
To: devnexen@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	horatiu.vultur@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: lan966x: fix page_pool error handling in lan966x_fdma_rx_alloc_page_pool()
Date: Fri,  3 Apr 2026 15:26:35 -0700
Message-ID: <20260403222634.2287124-2-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402172823.83467-1-devnexen@gmail.com>
References: <20260402172823.83467-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233240-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 82407398B9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email says "Let's make sure the callers can handle the error, too."
---
net: lan966x: fix page_pool error handling in lan966x_fdma_rx_alloc_page_pool()

This commit adds an IS_ERR check after page_pool_create() to return early
on failure. This prevents passing an error pointer to
xdp_rxq_info_reg_mem_model() which would cause a kernel oops when
dereferenced.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> index 7b6369e43451d..34bbcae2f0685 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> @@ -92,6 +92,9 @@ static int lan966x_fdma_rx_alloc_page_pool(struct lan966x_rx *rx)
>  
>  	rx->page_pool = page_pool_create(&pp_params);
>  
> +	if (unlikely(IS_ERR(rx->page_pool)))
> +		return PTR_ERR(rx->page_pool);
> +

This isn't a bug in the patch itself, but since this patch correctly handles
errors from page_pool_create(), it makes the existing error recovery paths more
reachable.

If lan966x_fdma_rx_alloc_page_pool() succeeds here, it creates a new page pool
and updates port->xdp_rxq memory models to point to it. If the subsequent
fdma_alloc_coherent() call in lan966x_fdma_rx_alloc() fails:

lan966x_fdma.c:lan966x_fdma_rx_alloc() {
	if (lan966x_fdma_rx_alloc_page_pool(rx))
		return PTR_ERR(rx->page_pool);

	err = fdma_alloc_coherent(lan966x->dev, fdma);
	if (err)
		return err;
    ...
}

Does this return an error without destroying the newly created page pool?

During an MTU change in lan966x_fdma_reload(), this failure triggers a jump
to the restore: label, which reverts rx->page_pool to the old pool:

lan966x_fdma.c:lan966x_fdma_reload() {
    ...
	err = lan966x_fdma_rx_alloc(&lan966x->rx);
	if (err)
		goto restore;
    ...
restore:
	lan966x->rx.page_pool = page_pool;
    ...
}

Does this irrevocably leak the newly created page pool and leave the xdp_rxq
memory models pointing to the leaked pool?

Similarly, in lan966x_fdma_init(), if lan966x_fdma_tx_alloc() fails:

lan966x_fdma.c:lan966x_fdma_init() {
    ...
	err = lan966x_fdma_rx_alloc(&lan966x->rx);
	if (err)
		return err;

	err = lan966x_fdma_tx_alloc(&lan966x->tx);
	if (err) {
		fdma_free_coherent(lan966x->dev, &lan966x->rx.fdma);
		return err;
	}
    ...
}

Does the error handler explicitly free rx.fdma via fdma_free_coherent() but
forget to destroy rx.page_pool, resulting in a permanent memory leak during
probe failure?

Additionally, the error recovery path in lan966x_fdma_reload() appears to
resume hardware DMA into freed pages.

When lan966x_fdma_reload() runs, it first stops the hardware and calls
lan966x_fdma_rx_free_pages(), which returns all RX ring pages back to the
old page pool via page_pool_put_full_page(). If lan966x_fdma_rx_alloc()
subsequently fails, execution jumps to the restore: label:

lan966x_fdma.c:lan966x_fdma_reload() {
    ...
	lan966x_fdma_rx_free_pages(&lan966x->rx);
    ...
	err = lan966x_fdma_rx_alloc(&lan966x->rx);
	if (err)
		goto restore;
    ...
restore:
	lan966x->rx.page_pool = page_pool;
	memcpy(&lan966x->rx.fdma, &fdma_rx_old, sizeof(struct fdma));
	lan966x_fdma_rx_start(&lan966x->rx);
    ...
}

The restore block copies back the old FDMA descriptors, which point to the
pages that were just freed, and calls lan966x_fdma_rx_start() to re-enable
the hardware RX channel.

Since it never re-allocates or re-maps pages for these restored descriptors,
will the hardware actively resume DMAing incoming network packets into
physical addresses that the page pool considers free? If the page pool
returns these pages to the buddy allocator, could this overwrite memory
owned by unrelated kernel subsystems?

>  	for (int i = 0; i < lan966x->num_phys_ports; ++i) {
>  		struct lan966x_port *port;
>

