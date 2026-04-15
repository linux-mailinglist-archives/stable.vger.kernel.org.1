Return-Path: <stable+bounces-238208-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJFFCH7u32kCagAAu9opvQ
	(envelope-from <stable+bounces-238208-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 22:01:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 220F7407824
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 22:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9F7BE3050453
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 19:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30C3388E56;
	Wed, 15 Apr 2026 19:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WRxrdmIs"
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A4A3876C3;
	Wed, 15 Apr 2026 19:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776283105; cv=none; b=MJewEnMzZKq3okRfGMiJVEvyvHge5h5awfpOoFDhx5clXmHsj/XnxXKxAn6VXFOoXm5JSnJg807Y+twFlpO60p9mSbkf7Zt4HMKLHeQzWi5vADVggFnxUnrDt4kz6b7TmmRhtCunuvI2BBDOG+NhoYrRNwqdZ7ATKfa6aq0SzTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776283105; c=relaxed/simple;
	bh=Rn5TAguSbnyTq+0PpWIsZFRjn2Op8EOl6HKkVRq/1TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYWZGftz3/SNj99IxUr7aWQtsrNyUNutAw51VaSuJKKVdvT6DYWd8LtLnKgOVSzUuyp7Zhyu2PlbreU20ZW6zwXoEVo/MmWcQrVbbu1B4AZroawBfoaAJZTijmk0EP96EVYgsoCvh6I28H1uAQLSk9aHiHMWTRl+g7VXEwP9f2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WRxrdmIs; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zzfItcPbm51n9sUCqPS3pMEdP67XndcXm/lQ9tFu+D0=; b=WRxrdmIsc4eRiptzsUaHuJhBKe
	+UVOxQ0GJxULMlm3Gx+I9D42waGwzfpRMjNhf4nurL3eYPd1HdhdlvmLK71QFhp0NqOqCtdkcrrqZ
	KAQhYz+iCGUUYGP4vm66y5hr6xtILN/vce8MNQ5ihZahNRmB90D3K3p5wokjUq1X27a42va07e2AE
	VbYPoGKiDBDRBJXwHicnFlufKVEmimawsz2detW0wGLMlD5hmTaefp64z1J/ORfEQDff6kEnmuVOV
	aEbLNlCkIXAzRAWynK05SMR4CFYa9jXTmb6kqUCBaFr9jIU0r5fFUjp2Xw0tQMYWxTGtQE2QtPVcz
	H6quAEaA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40820)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wD6NJ-000000002SU-0s9z;
	Wed, 15 Apr 2026 20:58:13 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wD6NG-000000002VN-0Po4;
	Wed, 15 Apr 2026 20:58:10 +0100
Date: Wed, 15 Apr 2026 20:58:09 +0100
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
Message-ID: <ad_t0aOKdC6f5Ja8@shell.armlinux.org.uk>
References: <20260415023947.7627-1-CFSworks@gmail.com>
 <ad-LAB08-_rpmMzK@shell.armlinux.org.uk>
 <ad-8q4OrOm-VtGrO@shell.armlinux.org.uk>
 <CAH5Ym4gy6g8d88-vGhe1zxoV7jNH_fXHsDSdDWC4x00H7s-3=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5Ym4gy6g8d88-vGhe1zxoV7jNH_fXHsDSdDWC4x00H7s-3=w@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238208-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,bootlin.com,renesas.com,nxp.com,tkos.co.il,st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.061];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url,armlinux.org.uk:email,shell.armlinux.org.uk:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 220F7407824
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 10:53:15AM -0700, Sam Edwards wrote:
> On Wed, Apr 15, 2026 at 9:28 AM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Wed, Apr 15, 2026 at 01:56:32PM +0100, Russell King (Oracle) wrote:
> > > Locally, while debugging my issues, I used this to prevent cur_rx
> > > catching up with dirty_rx:
> > >
> > >                 status = stmmac_rx_status(priv, &priv->xstats, p);
> > >                 /* check if managed by the DMA otherwise go ahead */
> > >                 if (unlikely(status & dma_own))
> > >                         break;
> > >
> > >                 next_entry = STMMAC_NEXT_ENTRY(rx_q->cur_rx,
> > >                                                priv->dma_conf.dma_rx_size);
> > >                 if (unlikely(next_entry == rx_q->dirty_rx))
> > >                         break;
> > >
> > >                 rx_q->cur_rx = next_entry;
> > >
> > > If we care about the cost of reloading rx_q->dirty_rx on every
> > > iteration, then I'd suggest that the cost we already incur reading and
> > > writing rx_q->cur_rx is something that should be addressed, and
> > > eliminating that would counter the cost of reading rx_q->dirty_rx. I
> > > suspect, however, that the cost is minimal, as cur_tx and dirty_rx are
> > > likely in the same cache line.
> 
> No, no, I like your approach better. :) It also removes the need for
> the `limit` clamp at the top of the function, so later code can assume
> limit==budget.
> 
> > > It looks like any fix to stmmac_rx() will also need a corresponding
> > > fix for stmmac_rx_zc().
> 
> I agree that stmmac_rx_zc() is likely also broken (in a similar way,
> but not similar enough to permit a "corresponding" fix), but I don't
> agree that there's a dependency relationship here. This patch is
> addressing #221010, which affects the generic/non-ZC codepath; I'm
> afraid the ZC codepath warrants its own investigation.

The code structure is identical. The only difference is what happens
to the packets.

Both paths take the NAPI limit. Both paths process up to that limit of
descriptors. The state saving / restoring is similar. The read_again
label is the same, the condition after is the same.

The ZC path differs at this point in that it will attempt to refill
every 16 descriptors that have been processed.

Both paths then read the descriptor and check the ownership.
Both paths then increment cur_rx to point to the next entry around
the ring.
Both paths then get the following descriptor pointer and prefetch
it.
Both paths then get the extended status if we're using extended
descriptors.
Both paths then handle frame discard.
Both paths then jump back to read_again if this isn't the last
segment and we have an error.
Both paths then check for error.
... and so it goes on.

The ZC path to me looks like a copy-paste-and-tweak approach to
adding support. The difference seems to be centered only around
the handling of the data buffers in the descriptors. The overall
mechanism of processing the descriptors follows the same layout
in both functions.

> > I have some further information, but a new curveball has just been
> > chucked... and I've no idea what this will mean at this stage. Just
> > take it that I won't be responding for a while.
> 
> I think I follow your meaning. Good luck getting it straightened out!

It looks like further curveballs have been thrown as a result,
destroying all "plans" for the next days/week. I have aboslutely
no ideas how much time or when I'll be able to look at anything
at the moment, so don't assume that because I find an opportunity
to send an email, everthing is back to normal.

I'll also note that over the last two days I've written several
emails on this, spent many hours on them, only to discard them
as other ideas/research and maybe even the passage of time means
they're no longer appropriate to send.

Jakub: sorry, I just *can't* review stuff on netdev with everything
that is going on, not when .... cna't complete this.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

