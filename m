Return-Path: <stable+bounces-217450-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FMAFb4ul2kcvgIAu9opvQ
	(envelope-from <stable+bounces-217450-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 16:39:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BC016041D
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 16:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 654D5301AA71
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 15:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E24346FC3;
	Thu, 19 Feb 2026 15:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="IeDBh943"
X-Original-To: stable@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE1F3451A7;
	Thu, 19 Feb 2026 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771515421; cv=none; b=Ob36+vZf7AmufgGLNEzQQ6UyGR6m/+CSUNO1zexy2WNbrxcMpAXyGdKBkt7SSZVcaVUWU0qB4uKJjM/0i1H0CrgsT88n2p1oSB4buNt0hK1uMLDxaUQ2SLpnu0BXAPd1fZNvoB5BLwTKTh3kHjt1t8h8vo4OB8Oz7KJ5Y5LpY9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771515421; c=relaxed/simple;
	bh=FtxsfZVG+UyeZeesGRnVoCjX4vtU9MuQ61F/Ejwoylk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITRkXqHZg8s76NabJ3CQ/mm0w0GxENN2fMC6JZtfYJl4OMtYt9z/Qu/1Bd7kw2exDw9erwR08aQwIagzCeJV3drV5hk2v7XKXiQ+5Gymucdy9s/9pLKN3x9rDsJ+B5W5KeTECihxzFNCMkoh/DX/NQ98Kr24nChVlJ9lNf9rzvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=IeDBh943; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 56F651483189;
	Thu, 19 Feb 2026 16:36:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1771515417; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=1AE1AmYfvATrMvyJE4ZzKXon+W6nliw611/s/YfGS68=;
	b=IeDBh943I007i0SbNfYfqY1DhYKrBB6M0hoXqlo9oXlXPWIYy5aKQkJJhjki771Feu1KqK
	9vaDD2gMIQNZWYWrol4O6TevD0HVs7uDSK6Ax0J0YDXFKYvgeGY6nlNFTmtmnCht12dxNA
	tLB60zs7sQLKyLJheFI1aTkpPcvWAsMUlr49ZNqACcU6dvOdEz9w8iLPZSaATe+sv2Y+xG
	BKyd99Xn6FcVfhvn6Rr3+4B5miODha/EN+a7nnPIOv6Nx/uvKLrDQ+7/7zGWxYEGcPAd6Z
	KlAjylnD4ZeO2yEWgcgk5LiTJXpHPfwRJLYkS+I1NoUt7646dykHP/MDFXAwtg==
Date: Thu, 19 Feb 2026 16:36:53 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Kevin Hao <kexin.hao@windriver.com>
Cc: Xiaolei Wang <xiaolei.wang@windriver.com>, pabeni@redhat.com,
	nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, rmk+kernel@armlinux.org.uk, netdev@vger.kernel.org,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
Subject: Re: [PATCH net v3] net: macb: Relocate mog_init_rings() callback
 from macb_mac_link_up() to macb_open()
Message-ID: <20260219-zeppelin-scope-8cf10fdf1d43@thorsis.com>
Mail-Followup-To: Kevin Hao <kexin.hao@windriver.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>, pabeni@redhat.com,
	nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, rmk+kernel@armlinux.org.uk, netdev@vger.kernel.org,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
References: <20251222015624.1994551-1-xiaolei.wang@windriver.com>
 <20260219-knapsack-thirteen-7d9e83451a40@thorsis.com>
 <aZcjqF1E57E-i5aS@pek-khao-d3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZcjqF1E57E-i5aS@pek-khao-d3>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[thorsis.com,quarantine];
	R_DKIM_ALLOW(-0.20)[thorsis.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217450-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ada@thorsis.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[thorsis.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev,kernel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[thorsis.com:mid,thorsis.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 92BC016041D
X-Rspamd-Action: no action

Hello Kevin,

Am Thu, Feb 19, 2026 at 10:52:24PM +0800 schrieb Kevin Hao:
> On Thu, Feb 19, 2026 at 03:34:54PM +0100, Alexander Dahl wrote:
> > After upgrading from 6.12.57-rt14 to 6.12.66-rt15 on a custom at91
> > sam9x60 based board with PREEMPT_RT patch, we noticed a complete
> > system lockup, which I bisected to this changeset.
> > 
> > After unplugging and plugging the ethernet cable, while
> > running PROFINET, system does not respond to anything anymore.
> > Last message in kernel log is:
> > 
> >   [  +8.621919] macb f802c000.ethernet eth0: Link is Up - 100Mbps/Full - flow control off
> > 
> > Heartbeat LED does not blink anymore, no network communication,
> > serial console does not respond anymore.
> > 
> > Reverting that change locally prevents the system lockup for me, but
> > what is the proper course of action on kernel side now?  Send a revert
> > to stable?  Send a revert to master?  Please advise.
> > 
> > (I'm aware there were least two more patches on netdev referencing
> > this change, but if I'm not mistaken none of those made it to stable,
> > right?)
> 
> A fix for this commit is available in the latest mainline kernel. Could you
> please verify whether it resolves the issue you encountered?
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bf9cf80cab81e39701861a42877a28295ade266f

Verified by replacing the revert with your patch backported to my
6.12.66-rt15 based tree.  Answered to your patch mail, so hopefully
that change hits stable soon.  Thanks for your effort.

Greets
Alex

> 
> Thanks,
> Kevin



