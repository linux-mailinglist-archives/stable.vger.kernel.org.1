Return-Path: <stable+bounces-233510-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJYwLQ611GnvwQcAu9opvQ
	(envelope-from <stable+bounces-233510-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 09:41:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 762423AADDE
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 09:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1ED673002E01
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 07:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C6939E6C9;
	Tue,  7 Apr 2026 07:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="icfMnjbb"
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9363F4C92;
	Tue,  7 Apr 2026 07:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775547657; cv=none; b=r6dn+2JfH1Bk8NnKNvsn2YmeceRUfwshwR1L9xoFcOamaHoshOBTgqRfQHb3oMECNgpaYUkiQmloRcquR8B63cYG3BV9PONpfn1Fc3c5GuaAL9uNGVn7s/LVfqRRsn2+5W6DQFRJs476+ggZNFuXTsKqo+FLHmysR/ryLdSLpXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775547657; c=relaxed/simple;
	bh=xJ+zGuJ1ieW3IvMEzlcpuTEzIG3X1G9Bvo6tbsCX+bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXpSg32PM0w5D60y12zs1jZI6N3y9aMukCnnmrrG2yKct2iLSPS2Tr7ZtPPD7/637TvbukFmbcHuuZEeP9pERrD3fI8eKa9H1U6BDa4tAAEhYLXqusCqJJdLtfP4l6vfk+6dbJD7aXBOPfVVFT3ipXdkEaQ5jZ0szuNZW/3G4Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=icfMnjbb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=w/+taouX3Llr4l2eNBv9LRKm8Q+7wm2zafn3JOBQYX4=; b=icfMnjbbmfPCRJfi6wFqpbccat
	I+tTYcSPNng6wcCLScI5QuOdiQWPTNkg+ZHm1k6dU7FMxmRawVpOpWkQyy7mgX5+TadNHI3uILMdk
	St++IawXo4a1zb5Zdj7WvnDXzK40sWF6+2u7B5cUGJwOqIEdMcCbBrwRm+01I+N8oMuroHx+bAE5Q
	BznflKUqRdIY59SWUTQeydZnIOcZ/EXRLiD9hyAuK4xpnQeLUCONlVZcqbMAS2O9uh8U9bGBbQccy
	q9T3T27hk0AHqsKp0BEYuffGuCV/07WMj8durbr4ffpJiYGgyFr4lX3gh+cnOwsUo2GrIntLerLJH
	0ULKTmaw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35644)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wA13K-000000000aL-13ou;
	Tue, 07 Apr 2026 08:40:50 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wA13E-00000000260-3esB;
	Tue, 07 Apr 2026 08:40:44 +0100
Date: Tue, 7 Apr 2026 08:40:44 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, 'Mengyuan Lou' <mengyuanlou@net-swift.com>,
	'Andrew Lunn' <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	'Eric Dumazet' <edumazet@google.com>,
	'Jakub Kicinski' <kuba@kernel.org>,
	'Paolo Abeni' <pabeni@redhat.com>,
	'Simon Horman' <horms@kernel.org>,
	'Jacob Keller' <jacob.e.keller@intel.com>,
	'Abdun Nihaal' <abdun.nihaal@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH net] net: txgbe: fix RTNL assertion warning when remove
 module
Message-ID: <adS0_I_2HBH-gM19@shell.armlinux.org.uk>
References: <D56A7C3379B4DA62+20260331071107.5414-1-jiawenwu@trustnetic.com>
 <acvHIpPd8BL_wFFU@shell.armlinux.org.uk>
 <076401dcc17d$905c40b0$b114c210$@trustnetic.com>
 <acy5evlrUesbcB46@shell.armlinux.org.uk>
 <096d01dcc657$9ee42b00$dcac8100$@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <096d01dcc657$9ee42b00$dcac8100$@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233510-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.312];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,armlinux.org.uk:url]
X-Rspamd-Queue-Id: 762423AADDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 02:27:34PM +0800, Jiawen Wu wrote:
> On Wed, Apr 1, 2026 2:22 PM, Russell King (Oracle) wrote:
> > On Wed, Apr 01, 2026 at 10:16:34AM +0800, Jiawen Wu wrote:
> > > On Tue, Mar 31, 2026 9:08 PM, Russell King (Oracle) wrote:
> > > > On Tue, Mar 31, 2026 at 03:11:07PM +0800, Jiawen Wu wrote:
> > > > > For the copper NIC with external PHY, the driver called
> > > > > phylink_connect_phy() during probe and phylink_disconnect_phy() during
> > > > > remove. It caused an RTNL assertion warning in phylink_disconnect_phy()
> > > > > upon module remove.
> > > > >
> > > > > To fix this, move the phylink connect/disconnect PHY to ndo_open/close.
> > > >
> > > > Wouldn't it be simpler to just wrap the phylink_disconnect_phy() in the
> > > > remove function with rtnl_lock()..rtnl_unlock() ?
> > >
> > > This is also a solution. But I think it would be nice to unify with other drivers
> > > that call the functions in ndo_open/close.
> > 
> > Both approaches are equally valid. Some network drivers attach the PHY
> > at probe time (and thus can return -EPROBE_DEFER if the PHY is specified
> > but not present). Others attach in .ndo_open which can only fail in this
> > circumstance with no retry without userspace manually implementing that.
> > 
> > There are other advantages and disadvantages to each approach.
> 
> Hi,
> 
> So is it still recommended that add rtnl_lock()...rtnl_unlock() instead of moving it?

The reaosn phylink_disconnect_phy() requires the RTNL lock is because it
_can_ be called while the netdev is published, and the RTNL lock
protects the networking core from the PHY being removed from the netdev,
preventing ethtool ops into the PHY driver from running concurrently
with the PHY's disconnection and potential later destruction.

Offering two APIs, one which requires the lock to provide that
protection and one which doesn't would over-complicate the phylink code
and make reviews way more difficult, as we'd now have to spot the
wrong function being used in the wrong code path.

It's simpler for drivers that want to connect and disconnect the PHY
at probe/remove time for them to just take the RTNL lock briefly over
the call to phylink_disconnect_phy().

There is no "recommendation" for connecting and disconnecting the
PHY at probe/remove time vs ndo_open/ndo_release. That's entirely up
to the driver author. As I've already said, there are advantages and
disadvantages of either way and that's a matter for the driver author
to consider and select the most appropriate choice for their driver.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

