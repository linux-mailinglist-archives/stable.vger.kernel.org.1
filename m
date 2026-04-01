Return-Path: <stable+bounces-232697-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CWuHEa6zGmcWAYAu9opvQ
	(envelope-from <stable+bounces-232697-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 08:25:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C978A37525B
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 08:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C877430A1117
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 06:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D7F3290D0;
	Wed,  1 Apr 2026 06:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="A6iCIG5O"
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34AB2D949F;
	Wed,  1 Apr 2026 06:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775024522; cv=none; b=JcwP4xNa+5aJmHD2hYsYpcvtDcgq5jnrUVhipCKjhG4R9Uz+TgN2SNiZ+3vyn9TXiQ52iRhYE1pfEHUuyIg9Lh2HxY9pjFK6tIEmzyzsUInEk8QgPmF4++Ux6mt/Qnh0eAijID+iuubKbU8YwJbaxCOQAcc8kwEeozEmcQQ1m2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775024522; c=relaxed/simple;
	bh=4TkN4Njd+1r2wUAHjH0tt0wEfh2n3eZkV0NaI+/ac5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQXu5+vOV16GmsMPBn9Wd5V3F2YenT/ZNknbRyenVlIVZgg474A/J/CVXvd6GRjIu4Zj3rQOlYfesBddczba4ZaOAqsbREuB1A4JoZBwqbyqQgQI8UBbzyMPQM/Z9v3Osv5SMagMU0loKb+qVlfIL3aN/L9MceWy+pYuQcOTwJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=A6iCIG5O; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=it/qF9fCFa5ssBvtdu87V9T0PCnHUZzqElqkEoHsFSg=; b=A6iCIG5OCNHWjH4sTjq7883pzI
	Dnw5HNlZGkOhfuDF4mtLjFqj1zXJ46sAvLr2GLYxNhqwNGZ8xMWRqNaw5vKKUXGOSuR60J0cVUOtU
	+2vZ/G+cp6905NLiDRtoST2Jox5HzIprYhWCe6OhyfFJYix83UwFlixOV2ROsCO4N+qLAyAs2/uib
	AwKq+5tx+RcS3BJrju/5tFFwA8bf1sDx+3zoWay4jp+15/CVO1JHNoVIOIQ6KJVrA2QTP33RKlXwY
	r6uyDNnrjzfZ/PL4Vv88vCprYyzfIWqQVLhXxRUP+SlLPdGHdLITvKhoQm+5RSRCiZXOok8SVtFs2
	PgjGB3xQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59932)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w7oxc-000000002bb-1VIn;
	Wed, 01 Apr 2026 07:21:52 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w7oxW-000000004ZE-2OBa;
	Wed, 01 Apr 2026 07:21:46 +0100
Date: Wed, 1 Apr 2026 07:21:46 +0100
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
Message-ID: <acy5evlrUesbcB46@shell.armlinux.org.uk>
References: <D56A7C3379B4DA62+20260331071107.5414-1-jiawenwu@trustnetic.com>
 <acvHIpPd8BL_wFFU@shell.armlinux.org.uk>
 <076401dcc17d$905c40b0$b114c210$@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <076401dcc17d$905c40b0$b114c210$@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232697-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.653];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shell.armlinux.org.uk:mid,armlinux.org.uk:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C978A37525B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 10:16:34AM +0800, Jiawen Wu wrote:
> On Tue, Mar 31, 2026 9:08 PM, Russell King (Oracle) wrote:
> > On Tue, Mar 31, 2026 at 03:11:07PM +0800, Jiawen Wu wrote:
> > > For the copper NIC with external PHY, the driver called
> > > phylink_connect_phy() during probe and phylink_disconnect_phy() during
> > > remove. It caused an RTNL assertion warning in phylink_disconnect_phy()
> > > upon module remove.
> > >
> > > To fix this, move the phylink connect/disconnect PHY to ndo_open/close.
> > 
> > Wouldn't it be simpler to just wrap the phylink_disconnect_phy() in the
> > remove function with rtnl_lock()..rtnl_unlock() ?
> 
> This is also a solution. But I think it would be nice to unify with other drivers
> that call the functions in ndo_open/close.

Both approaches are equally valid. Some network drivers attach the PHY
at probe time (and thus can return -EPROBE_DEFER if the PHY is specified
but not present). Others attach in .ndo_open which can only fail in this
circumstance with no retry without userspace manually implementing that.

There are other advantages and disadvantages to each approach.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

