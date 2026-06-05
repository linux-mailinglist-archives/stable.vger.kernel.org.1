Return-Path: <stable+bounces-260721-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0rirOfvnImo9fAEAu9opvQ
	(envelope-from <stable+bounces-260721-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 17:15:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 821DF649312
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 17:15:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=QgAgqxeU;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260721-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260721-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF691301586F
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 15:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4F740960A;
	Fri,  5 Jun 2026 15:08:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049EA3E5564;
	Fri,  5 Jun 2026 15:08:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780672130; cv=none; b=MTTxJCYwpBeaKYCmmJe5AMOrCwTVTiznIYHWgrkPtmRTJLaytyz8B7qv9NjuoECsEGwdTGMt28zMYRKZOfTSuKpH6fMWG8pbgT/m9Knv2A6xWSn0qAouDWAJYECO1qjsXtJ77Z8oe6I+CTRaafUDWIlbQZCj3T3cGl8ioTLNAo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780672130; c=relaxed/simple;
	bh=UJHREpDeIob2u3UyEwalJQx5zfb1tBSJ5dQ/an4MA1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBFgmd2LDiqJB67f2wyNEJEXnfNuGLb0R3ISMKWPfsHurqBwcO9yUQlj+ftz+Ibft8lLLbNE3fcBTQx2D1NUPzvu+/IztESwHQzcxrVz/QgPj3VoF9FnKynQXYFUOm9KbZ7I8ITC+jFwAHBsfZte40GFru6i8tbL34FXOkGxZLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QgAgqxeU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5597B1F00893;
	Fri,  5 Jun 2026 15:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780672129;
	bh=KwnobDycUoeaG1IWloTQkcMfkvmcZSblONxcFsLEbZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QgAgqxeUL6dLtlMll8pVENTIkHWVKMQXpzFQrw82adMgfO2+VOfMw6rviQVuOm85/
	 p+uYNu5ceOAtKIIpWrlUgzNRXNdfQqOVcDTIvwVdLAKjKHHHLAeccVXZ26ZbRCo7bI
	 JevuEq4sTFrqQIgQZmQqg95QV1T8WI/IBm9hVZLo=
Date: Fri, 5 Jun 2026 16:57:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Nguyen Minh Tien <zizuzacker@gmail.com>
Cc: stable@vger.kernel.org, Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org
Subject: Re: [PATCH 6.6.y] net: usb: lan78xx: program MAC_CR for LAN7801
 fixed-PHY link
Message-ID: <2026060535-subpanel-proven-595a@gregkh>
References: <20260605121535.51414-1-zizuzacker@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605121535.51414-1-zizuzacker@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zizuzacker@gmail.com,m:stable@vger.kernel.org,m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-260721-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 821DF649312

On Fri, Jun 05, 2026 at 07:15:35PM +0700, Nguyen Minh Tien wrote:
> While bringing up a LAN7801 wired over RGMII to an MDIO-less switch, I
> hit a link that the fixed PHY reported as "up" but that could not pass a
> single packet: every frame came out corrupted at the switch and no ARP
> reply ever made it back.
> 
> It turned out the MAC_CR speed/duplex bits are never set on this path.
> lan7801_phy_init() registers a fixed PHY at SPEED_1000/DUPLEX_FULL, but
> nothing programs the MAC to match: there is no PHY state machine for a
> fixed link, and lan78xx_reset() only sets the auto speed/duplex bits for
> the 7800.  So the 7801 comes up at 10M/half, clocks RGMII TXC at 2.5 MHz
> instead of 125 MHz, and mangles everything it transmits.
> 
> Fix it by programming MAC_CR to 1G/full in the fixed-PHY branch, to match
> fphy_status.  Only that branch is touched, so boards with a real external
> PHY (and the 7800/7850) are unaffected.
> 
> Mainline fixes this differently via the phylink conversion in v6.16,
> commit e110bc825897 ("net: usb: lan78xx: Convert to PHYLINK for improved
> PHY and MAC management"), which is far too large to backport, so this is
> a small fix for stable only.

Why is that too large?  If we take this, we then diverge and any future
fixes will not apply here :(

Please backport exactly what is in the mainline tree, otherwise odds
are, this one-off fix will be found incorrect (we always get it
wrong...)

thanks,

greg k-h

