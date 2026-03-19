Return-Path: <stable+bounces-227392-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFBtBUNyvGkPywIAu9opvQ
	(envelope-from <stable+bounces-227392-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 23:01:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CFC2D2D93
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 23:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 549FA3025E3B
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 22:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0592F4070FB;
	Thu, 19 Mar 2026 21:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="weV3nqI7"
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB99B402BB2;
	Thu, 19 Mar 2026 21:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773957593; cv=none; b=NqQHWU7sibXBN6xAJqa/IO0PRKCASykZNgzsAdjRclXIoNIs6rwi42yf2u03yrgE2zY5OEUrqoapdUnYzwpBpXcBwNJwK40M1WYlyXUbwRkiWXP8OwnIYzFWzLpljvcL9ViD8u22T5eGueAFuEacYe6uewL1SBQjFGW9PK1m3Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773957593; c=relaxed/simple;
	bh=ZSq1KbVoUB+K1at8AD5hG1nGBkwED9vYe5QiDWUG7Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEprwBWsRbKI2yJzoFiqCnggV0WrgZMsHrcwdh10xKUr9BGL0IWdeHwfgQTko9t54gq5207TM77uxvse7venqyIuqLq5G5K6oyNXRRtQbqnUwP5uYPmwV6pzFxFetEDPiy6PBAE2bI0BNZ0gnG9c5MZNdXFDplVGt0kZ6se6Nl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=weV3nqI7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0yp23tNbPW94JMNdRGMZBEkiUIPkf8ue7dSq7oobTEQ=; b=weV3nqI7chBqru/dlHBoOpFFn3
	xshJScE+Z/b4faKZyekCELpOCgC109DFD4+6JYL6xn/mVHHv5AQ1Q6hYtr3o8Ju7ZVH28Gk3uRa5+
	voQiCnmMiErPZfckGZhef6YsihnyV13ZoybKYjvTG8a2NDOPgvdfeiuA7sKx6DGOVzWb14LTKnzxo
	VHQiIyorzK6RcDnFuC7Lgr/tYhk0RZ7NfngmXG3X86idQmG+wfpLArb58r514rquGwA5KwhmUI7Li
	UCKgfb3oDY8bKXDGd2xhZbuNZP7ns8jZJ3NUY4Tzo9FuyEhFYcMXpp1YbeCK7o0iV0dehkagz6tLl
	rdyOkYkg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60868)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w3LP2-000000005Mx-2VQf;
	Thu, 19 Mar 2026 21:59:40 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w3LOy-0000000008l-2rCx;
	Thu, 19 Mar 2026 21:59:36 +0000
Date: Thu, 19 Mar 2026 21:59:36 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Serge Semin <fancer.lancer@gmail.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: stmmac: Prevent NULL deref when RX
 memory exhausted
Message-ID: <abxxyHVXp6QpPue5@shell.armlinux.org.uk>
References: <20260319184031.8596-1-CFSworks@gmail.com>
 <20260319184031.8596-2-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319184031.8596-2-CFSworks@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227392-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,renesas.com,nxp.com,tkos.co.il,gmail.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	NEURAL_SPAM(0.00)[0.799];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 10CFC2D2D93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 11:40:30AM -0700, Sam Edwards wrote:
> The CPU receives frames from the MAC through conventional DMA: the CPU
> allocates buffers for the MAC, then the MAC fills them and returns
> ownership to the CPU. For each hardware RX queue, the CPU and MAC
> coordinate through a shared ring array of DMA descriptors: one
> descriptor per DMA buffer. Each descriptor includes the buffer's
> physical address and a status flag ("OWN") indicating which side owns
> the buffer: OWN=0 for CPU, OWN=1 for MAC. The CPU is only allowed to set
> the flag and the MAC is only allowed to clear it, and both must move
> through the ring in sequence: thus the ring is used for both
> "submissions" and "completions."
> 
> In the stmmac driver, stmmac_rx() bookmarks its position in the ring
> with the `cur_rx` index. The main receive loop in that function checks
> for rx_descs[cur_rx].own=0, gives the corresponding buffer to the
> network stack (NULLing the pointer), and increments `cur_rx` modulo the
> ring size. After the loop exits, stmmac_rx_refill(), which bookmarks its
> position with `dirty_rx`, allocates fresh buffers and rearms the
> descriptors (setting OWN=1). If it fails any allocation, it simply stops
> early (leaving OWN=0) and will retry where it left off when next called.
> 
> This means descriptors have a three-stage lifecycle (terms my own):
> - `empty` (OWN=1, buffer valid)
> - `full` (OWN=0, buffer valid and populated)
> - `dirty` (OWN=0, buffer NULL)
> 
> But because stmmac_rx() only checks OWN, it confuses `full`/`dirty`. In
> the past (see 'Fixes:'), there was a bug where the loop could cycle
> `cur_rx` all the way back to the first descriptor it dirtied, resulting
> in a NULL dereference when mistaken for `full`. The aforementioned
> commit resolved that *specific* failure by capping the loop's iteration
> limit at `dma_rx_size - 1`, but this is only a partial fix: if the
> previous stmmac_rx_refill() didn't complete, then there are leftover
> `dirty` descriptors that the loop might encounter without needing to
> cycle fully around. The current code therefore panics (see 'Closes:')
> when stmmac_rx_refill() is memory-starved long enough for `cur_rx` to
> catch up to `dirty_rx`.
> 
> Fix this by further tightening the clamp from `dma_rx_size - 1` to
> `dma_rx_size - stmmac_rx_dirty() - 1`, subtracting any remnant dirty
> entries and limiting the loop so that `cur_rx` cannot catch back up to
> `dirty_rx`. This carries no risk of arithmetic underflow: since the
> maximum possible return value of stmmac_rx_dirty() is `dma_rx_size - 1`,
> the worst the clamp can do is prevent the loop from running at all.

Isn't the limit equivalent to:

	space = CIRC_SPACE(rx_q->cur_rx, rx_q->dirty_rx,
			   priv->dma_conf.dma_rx_size);
	limit = min_t(unsigned int, space, limit);

(Think of the "full" and "empty" cases as "space" which can be
consumed to provide entries for the refiller to action.)

I think the same applies for patch 2 - when the above returns zero
it means we have no entries in the ring that aren't due for refill.

Have you checked whether stmmac_rx_zc() also buggy in this respect?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

