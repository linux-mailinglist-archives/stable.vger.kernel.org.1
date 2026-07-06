Return-Path: <stable+bounces-272275-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3mfwKd3mS2rGcQEAu9opvQ
	(envelope-from <stable+bounces-272275-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 19:33:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 412FA713E82
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 19:33:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=FFrHcKC6;
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272275-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272275-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9148A31071DB
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 15:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E31C3859FA;
	Mon,  6 Jul 2026 15:21:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE054383C6E;
	Mon,  6 Jul 2026 15:21:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783351274; cv=none; b=Bp260lhRRbTVIfyNOFGPbD5RF5GEvDPytEF9ifzH2/I5MC0dz7CrFBCIuTIWRELLWqx1L6kuQ/faOLTh519rhsDvbFJStnQ7Ne0y/kQAY51R2hRHxEApBM2KpcB5d5kOEqTuGjlb7X5gsUGYR1BBs+4PT7JrUL3iUxEXsOm7F9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783351274; c=relaxed/simple;
	bh=ciRF2Mc4rTopLLq8ltTzVZpcmSHzNtL7ksVSacb1R1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAA7fLz1MWpaE4zu8TUP6MuAiG+fZHOYbFcwXGuAeOy5masHT1UuT3B/wBqzXSlqZYr76TIiIa8KL+106ry7/nhzvF9Lg9/A0TLHuauraCTNGQ0olTU4HERw+AUVnFXWdi3TVwV09YtBkBx1imXQHXeZmUU1NAYR06Zz8CVu+oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FFrHcKC6; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YiDRpnXhMQ5WxLE3PvPoeOjg07KWo1ysywGP+Tmm9iI=; b=FFrHcKC62Wn+KbHyrQdCNwzASa
	D6UpdCpizepGsyPQkUKVt1HXX3V4ZBkR8UzoZZXBJTHsO2Vm0hjxB6ZhdxgwqqAO2XL1ujQGBpFDp
	KbhBVKNZoMIOX9TchbcXGr2zQl11YSRJER8JFGawi02N5IVDqwro4eCx70lsT0NL0O+U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wgl83-00B0nz-1I; Mon, 06 Jul 2026 17:21:03 +0200
Date: Mon, 6 Jul 2026 17:21:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Breitenberger <bre@breiti.cc>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	stable@vger.kernel.org, Markus Breitenberger <bre@keba.com>
Subject: Re: [PATCH net] net: stmmac: intel: don't reconfigure SerDes on
 unchanged mode
Message-ID: <abd431d1-2819-4dc9-97f5-8e2b2ceb2658@lunn.ch>
References: <20260706061954.94842-1-bre@breiti.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706061954.94842-1-bre@breiti.cc>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272275-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andrew@lunn.ch,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:bre@breiti.cc,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:yong.liang.choong@linux.intel.com,m:stable@vger.kernel.org,m:bre@keba.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:from_mime,lunn.ch:dkim,lunn.ch:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 412FA713E82

On Mon, Jul 06, 2026 at 08:19:54AM +0200, Markus Breitenberger wrote:
> From: Markus Breitenberger <bre@keba.com>
> 
> intel_mac_finish() is registered as the phylink mac_finish() callback
> for the Elkhart Lake SGMII ports. phylink calls mac_finish() at the end
> of every major link reconfiguration, including the initial one during
> probe, before any interface mode has actually changed.
> 
> The callback reprograms the shared ModPHY LCPLL through the PMC IPC and
> then power-cycles the SerDes. On Elkhart Lake that ModPHY is also used
> by the on-die AHCI SATA PHY. Running the reconfiguration during the
> initial boot-time link-up disturbs the shared analog block while it is
> still driving SATA, so the SATA link fails to train:
> 
>   ata1: SATA link down (SStatus 1 SControl 300)
> 
> The disk carrying the root filesystem is never detected and the system
> hangs at rootwait. Ethernet itself comes up normally, which makes the
> failure look unrelated to the network driver.
> 
> Firmware already programs the ModPHY for the configured interface, so
> the reconfiguration is redundant unless the interface mode really
> changes. Return early when the requested mode equals the current one.
> This avoids touching the shared ModPHY (and the SATA PHY) during boot
> while preserving runtime SGMII to 2500BASE-X switching, which still
> sees a genuine mode change and reconfigures as before.

What happens to the disk at runtime, rather than boot time, if it is
necessary to reconfigure the ModPHY?

I think i would prefer the machine fails to boot, rather than corrupt
its disk when i plug it into a different network switch.

	Andrew

