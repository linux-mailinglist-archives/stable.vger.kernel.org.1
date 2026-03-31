Return-Path: <stable+bounces-231421-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GdWFCjIy2mnLgYAu9opvQ
	(envelope-from <stable+bounces-231421-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 15:12:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AEA369FF7
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 15:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D486230C1494
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 13:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374833E3D98;
	Tue, 31 Mar 2026 13:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="i+xuOMXf"
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E82A3E5EC9;
	Tue, 31 Mar 2026 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774962478; cv=none; b=HQnTLVGC8j3ZO9lw7gzEzeytbPmf5jyBYwtPdGJlBxdudMho7P0NLmgFPVt0W65Isn//KanMScR3XnTWgGPk68JJ7+fE1SXLy2/WPrlawz3FIbNcMUzmObVJ2wNroC0zjWn6jB551sW6jBoQNUdOqh34Ob6asoCUewFB50zQRkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774962478; c=relaxed/simple;
	bh=eosv1AZxzlSDL5rb2/xDDZuxQtW9KHKcYbpvcjA+Eb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZI9qWENb3j6o+PPZnRMs6gRooOplAnP8HzjRkxerQAlMsFmKwobgHO/TS0Xlr9fcqbuTzgQMUvutRXQGTmgnxXhYoMcQXOH3Gt9pdy7hnN3qTZgeHEdfWPHmIpGTfxiNArlEM/B7HYR7Pi1CG96gELKDASQpL3gPabV2ibTAEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=i+xuOMXf; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1sO/3nA/45rKDmeI79eubvzryv2xW7zUpGf4TvMjB2I=; b=i+xuOMXfN/z1pnGaVlTZDVBVej
	+OQUKTtgErtR8OHs/RNH7L4DczjIUnF6sAqFDKbQy2KtZ4ol5qHg1GToJDrofCPjxlZyGUumF405x
	YKMpxCq5IU5XVWjerIwF7cY6ed9qDVX/HK1Wd13hIFlHZbXOROciiFEVqMqcC3jvmkFYSs/2hdmu3
	7AzaHWFPdMbAONzqh298d0KZf5VksL87ZTmceUBTY37hlZJatiPKTEI+5UME+17ZTvPfxUMMD2gX7
	Aif15E+MzsYSapEUP0VexHYi1NqmHbOSJvs4FbYsczTX/HPw97hTywaM90WdbfMkTpwb9N3+OG/OB
	pLx2gvcw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42808)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w7Yox-000000001rh-1uLR;
	Tue, 31 Mar 2026 14:07:51 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w7Yos-000000003kB-2g58;
	Tue, 31 Mar 2026 14:07:46 +0100
Date: Tue, 31 Mar 2026 14:07:46 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH net] net: txgbe: fix RTNL assertion warning when remove
 module
Message-ID: <acvHIpPd8BL_wFFU@shell.armlinux.org.uk>
References: <D56A7C3379B4DA62+20260331071107.5414-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D56A7C3379B4DA62+20260331071107.5414-1-jiawenwu@trustnetic.com>
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
	TAGGED_FROM(0.00)[bounces-231421-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.654];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url,shell.armlinux.org.uk:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03AEA369FF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 03:11:07PM +0800, Jiawen Wu wrote:
> For the copper NIC with external PHY, the driver called
> phylink_connect_phy() during probe and phylink_disconnect_phy() during
> remove. It caused an RTNL assertion warning in phylink_disconnect_phy()
> upon module remove.
> 
> To fix this, move the phylink connect/disconnect PHY to ndo_open/close.

Wouldn't it be simpler to just wrap the phylink_disconnect_phy() in the
remove function with rtnl_lock()..rtnl_unlock() ?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

