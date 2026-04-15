Return-Path: <stable+bounces-238158-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAXeDE2932mOYQAAu9opvQ
	(envelope-from <stable+bounces-238158-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:31:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D067C40664D
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF94E30488C2
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 16:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910663D88E6;
	Wed, 15 Apr 2026 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nMR9rhZH"
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B393DC4A0;
	Wed, 15 Apr 2026 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776270525; cv=none; b=G35JM+QmxvTGXK3eGkztQDgTi9FQRtUd/U1TjmAX6ZcO2yR7MDDZjQOFGfnUZ34EOfjAX7s7V/J8ejiQTXZGE5mdw1A6L6yr+OuFUmcYw6+Hp/DCzdZYzzrGz9PEHHFdO3xtznIXS49z/W5oaAtQlEbaFqAi9GBsiNeai/6Uma8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776270525; c=relaxed/simple;
	bh=aof32GZdYa8Oryjhe9ylzBwFzjJaPRLNrDRXmz9WUpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htRdWMJoiaQfABLHpHP6X8Qy3htbmtPBlgB722rza13uuVdWDidzZbgYorPyulXaqjVgh1aCMHkPhQcc8wRGAoB8wXAeMoskt1Unmju1UrmZTtIfvSJG/25xMaXeHV+dQRzxojPuyPz3pEADbFjjH6HT+OYD4IgduweLal4bCM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nMR9rhZH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xpnoSDDGsBCL+2BDd4JTT1XxKpjuL1ghLwvkFgcvTjA=; b=nMR9rhZHp02XU3aSVh1bIewT7H
	Xgo9Jdkgy1fEEb7SgxTiqMZO5/IOYh6iOuPqlHM7P0qcFq/Cz5ZxKt7zQ+rlZMaI2TBw2UgXBMHU5
	HriC4AedygCY5+7VjHUYQUGcYOgcZXIRjZNYjCWAejcjmNe2GFDZZfIeUopiIIMIb9xmOjMtea/Cc
	IZyVMbecLSxdYh7dmwr7LDrDAJ6VDKEZ4GLZ2nIEA0nmHkUBCudEyk/VgNCDISD6yOKZAFxxa7Bjg
	ofArRRTshrucwsaKkGej5QQ6qcRl0a/6wOM8tgCs5b+wJSZ76Nvbz+8BuOD1D10HLy984fUXXb+0P
	RXVJsO5A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60524)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wD36N-000000002I9-1yPN;
	Wed, 15 Apr 2026 17:28:31 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wD36J-000000002LW-20lB;
	Wed, 15 Apr 2026 17:28:27 +0100
Date: Wed, 15 Apr 2026 17:28:27 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Serge Semin <fancer.lancer@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v5] net: stmmac: Prevent NULL deref when RX memory
 exhausted
Message-ID: <ad-8q4OrOm-VtGrO@shell.armlinux.org.uk>
References: <20260415023947.7627-1-CFSworks@gmail.com>
 <ad-LAB08-_rpmMzK@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad-LAB08-_rpmMzK@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238158-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,bootlin.com,renesas.com,nxp.com,tkos.co.il,st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	NEURAL_SPAM(0.00)[0.054];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shell.armlinux.org.uk:mid,armlinux.org.uk:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D067C40664D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 01:56:32PM +0100, Russell King (Oracle) wrote:
> On Tue, Apr 14, 2026 at 07:39:47PM -0700, Sam Edwards wrote:
> > The CPU receives frames from the MAC through conventional DMA: the CPU
> > allocates buffers for the MAC, then the MAC fills them and returns
> > ownership to the CPU. For each hardware RX queue, the CPU and MAC
> > coordinate through a shared ring array of DMA descriptors: one
> > descriptor per DMA buffer. Each descriptor includes the buffer's
> > physical address and a status flag ("OWN") indicating which side owns
> > the buffer: OWN=0 for CPU, OWN=1 for MAC. The CPU is only allowed to set
> > the flag and the MAC is only allowed to clear it, and both must move
> > through the ring in sequence: thus the ring is used for both
> > "submissions" and "completions."
> > 
> > In the stmmac driver, stmmac_rx() bookmarks its position in the ring
> > with the `cur_rx` index. The main receive loop in that function checks
> > for rx_descs[cur_rx].own=0, gives the corresponding buffer to the
> > network stack (NULLing the pointer), and increments `cur_rx` modulo the
> > ring size. After the loop exits, stmmac_rx_refill(), which bookmarks its
> > position with `dirty_rx`, allocates fresh buffers and rearms the
> > descriptors (setting OWN=1). If it fails any allocation, it simply stops
> > early (leaving OWN=0) and will retry where it left off when next called.
> > 
> > This means descriptors have a three-stage lifecycle (terms my own):
> > - `empty` (OWN=1, buffer valid)
> > - `full` (OWN=0, buffer valid and populated)
> > - `dirty` (OWN=0, buffer NULL)
> > 
> > But because stmmac_rx() only checks OWN, it confuses `full`/`dirty`. In
> > the past (see 'Fixes:'), there was a bug where the loop could cycle
> > `cur_rx` all the way back to the first descriptor it dirtied, resulting
> > in a NULL dereference when mistaken for `full`. The aforementioned
> > commit resolved that *specific* failure by capping the loop's iteration
> > limit at `dma_rx_size - 1`, but this is only a partial fix: if the
> > previous stmmac_rx_refill() didn't complete, then there are leftover
> > `dirty` descriptors that the loop might encounter without needing to
> > cycle fully around. The current code therefore panics (see 'Closes:')
> > when stmmac_rx_refill() is memory-starved long enough for `cur_rx` to
> > catch up to `dirty_rx`.
> > 
> > Fix this by further tightening the clamp from `dma_rx_size - 1` to
> > `dma_rx_size - stmmac_rx_dirty() - 1`, subtracting any remnant dirty
> > entries and limiting the loop so that `cur_rx` cannot catch back up to
> > `dirty_rx`. This carries no risk of arithmetic underflow: since the
> > maximum possible return value of stmmac_rx_dirty() is `dma_rx_size - 1`,
> > the worst the clamp can do is prevent the loop from running at all.
> > 
> > Fixes: b6cb4541853c7 ("net: stmmac: avoid rx queue overrun")
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221010
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> 
> Locally, while debugging my issues, I used this to prevent cur_rx
> catching up with dirty_rx:
> 
>                 status = stmmac_rx_status(priv, &priv->xstats, p);
>                 /* check if managed by the DMA otherwise go ahead */
>                 if (unlikely(status & dma_own))
>                         break;
> 
>                 next_entry = STMMAC_NEXT_ENTRY(rx_q->cur_rx,
>                                                priv->dma_conf.dma_rx_size);
>                 if (unlikely(next_entry == rx_q->dirty_rx))
>                         break;
> 
>                 rx_q->cur_rx = next_entry;
> 
> If we care about the cost of reloading rx_q->dirty_rx on every
> iteration, then I'd suggest that the cost we already incur reading and
> writing rx_q->cur_rx is something that should be addressed, and
> eliminating that would counter the cost of reading rx_q->dirty_rx. I
> suspect, however, that the cost is minimal, as cur_tx and dirty_rx are
> likely in the same cache line.
> 
> It looks like any fix to stmmac_rx() will also need a corresponding
> fix for stmmac_rx_zc().

I have some further information, but a new curveball has just been
chucked... and I've no idea what this will mean at this stage. Just
take it that I won't be responding for a while.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

