Return-Path: <stable+bounces-272656-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nooDN7hXTmrRKwIAu9opvQ
	(envelope-from <stable+bounces-272656-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 15:59:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F17B727037
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 15:59:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=v06q6lq3;
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272656-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-272656-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 887BD3089448
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 13:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BD840801B;
	Wed,  8 Jul 2026 13:55:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0208A41169C;
	Wed,  8 Jul 2026 13:55:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783518940; cv=none; b=Z5N8ehrNOCCcLI8KbVAml/+Q6Fnqt2eAGV+GBFvyEOwJ9hht6B7QsuU6UdTyBKnuiqn3SiPKKHCxuVC3X3HhmKS8t+EIIXpi96/ScBc01Y5ksQ5gDie+YzceKTcWraV3h8M/6KqHJECIIzpjSlgRp+WPQaewD7x7xCj3fE9Dpvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783518940; c=relaxed/simple;
	bh=y71ANcgxK4k7zYOyU6FPjouwov/Lhp1d/qAMm3ED5C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+lTFVQhIQ8ld65TITGRVv1auXKHQcYmH27qONP0h1cMjcNB9uWwSk/sz88W2+UrkpIdyWGDqdv17RcGuI2NupJl4KHWLhP4JogvlKKdBF5YXAcFav6LbbhukvgF9ms/YZ19u6nSsbTRAEJDGVDs/jBvFTsUFM2VUhNocpXKAuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=v06q6lq3; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KgSsb7UuDIy1B6AUzPi0R2vyt+fJ3IagJlno1nuwFLk=; b=v06q6lq3/kSHtnrAEMiI/9cvla
	Mu7/mNO+HUhrksELxTxHKQSy4DgKgvk58b0Qwwv1/75Tp1UMEToQ5tgW460QqDfYfIri5tmRg+MUs
	Ee4RA+YhQzLjHgmZ2x7XAsKChrds/vs1JlDHl0IrCmIjTNAq97NyR2qHn324lguX+ImA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1whSk4-00BKIb-FK; Wed, 08 Jul 2026 15:55:12 +0200
Date: Wed, 8 Jul 2026 15:55:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Breitenberger <bre@breiti.cc>
Cc: andrew+netdev@lunn.ch, bre@keba.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, stable@vger.kernel.org,
	yong.liang.choong@linux.intel.com
Subject: Re: [PATCH net] net: stmmac: intel: don't reconfigure SerDes on
 unchanged mode
Message-ID: <2e3c213c-e49a-4bcc-8cb9-e43403a2ea37@lunn.ch>
References: <abd431d1-2819-4dc9-97f5-8e2b2ceb2658@lunn.ch>
 <20260707220814.109028-1-bre@breiti.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707220814.109028-1-bre@breiti.cc>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-272656-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bre@breiti.cc,m:andrew+netdev@lunn.ch,m:bre@keba.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:stable@vger.kernel.org,m:yong.liang.choong@linux.intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F17B727037

On Wed, Jul 08, 2026 at 12:08:14AM +0200, Markus Breitenberger wrote:
> Hi Andrew,
> 
> Thanks for looking at this, and you're right - the runtime case is the
> more dangerous one. If a genuine interface change (SGMII <-> 2500BASE-X)
> happened at runtime while the disk was live, reprogramming the shared
> ModPHY LCPLL would disturb the SATA PHY under an active filesystem, and
> a failed boot would be preferable to that.
> 
> Two points of clarification:
> 
> - A plain switch change does not reprogram the ModPHY on my fixed-PHY
>   setup. mac_finish() only runs a real reconfiguration when the
>   MAC-side interface mode changes (e.g. a multi-rate SFP moving between
>   SGMII and 2500BASE-X).

A fibre SFP is unlikely to use SGMII. It will swap between 2500BaseX
and 1000BaseX, if the SFP module is ejected and a different one
plugged in.

> On a fixed copper PHY the interface mode does
>   not change, so changing the link partner / switch does not trigger
>   the reconfiguration.

That depends on the PHY. Some change there host side interface to
match the line side. So they use 25000BaseX for 2.5G, but SGMII for
10/100/1G. Other use 'rate-adaptation'. They run the host side at the
fastest speed, 25000BaseX, and then insert pause frames to slow down
the MAC when the line side is running at 10/100/1G.

> Given that, I'd like to keep this patch scoped to the boot regression
> and leave the pre-existing shared-ModPHY-with-live-SATA question to the
> maintainers, who have the hardware knowledge to decide whether a
> stronger guard is warranted.

a42f6b3f1cc1 is from Intel, so i assume they thought about what
happens to the SATA controller, and are happy to take the risk of
destroying filesystems. So, yes, lets leave it as is for the moment.

	   Andrew

