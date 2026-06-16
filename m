Return-Path: <stable+bounces-263625-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qGQoFm/zMGqDZQUAu9opvQ
	(envelope-from <stable+bounces-263625-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 08:55:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E4368CAC5
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 08:55:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=rLe7AsV5;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263625-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263625-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2092F305FAFD
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 06:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9043161AD;
	Tue, 16 Jun 2026 06:55:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A9F3148C2
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 06:55:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781592936; cv=none; b=exsX8XfKPBLWIsHOW0PIYzZAKpTFh6RspjxGo99Lk3yjpNLpB98YhO+iuukAqMnYUd6oYBeuNarCE4Us94CnNblCuAFazHeXVuLHsTab1cLIrPMbQUt6cU5JbvlYjArMajhuEug3ajCjWSmWPCcn1bS8qseVfGMpKs3X7Ate6fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781592936; c=relaxed/simple;
	bh=3HfITxVGTDvbV6I0CHXjJI4ktEOEYcWlDGfg65X5/r8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpBwW/BRDtdemynM1i/a1I2zaIxul6mB1pn1kmpXrf9U+2+LszOvVyBy6Aa7hWuUhFepeEwCIdI/t/1SiKprrPLu6Ar871E9k3Nhb0MbGA19TviYbOZj0FKR7um2DTvQiKyg2mCh1lIzRIpdULHKsj4uEVhlBG9UglJqlazxxz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rLe7AsV5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24EB41F000E9;
	Tue, 16 Jun 2026 06:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781592935;
	bh=dpEk3OrKYc2Q+i7d7zo70OdWHTvJ54nuZ3pYl/gCfgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=rLe7AsV5qprgVmyHPDKQeDLrna0oDRDNs9yYq7F+Q10uOpCbGTmcYBdP0aOpVXqBS
	 TNb5E2EaWAczBjgzn0YqKjw7BDBxiRoFZCEr/N5EP13jCjRPiNTOY8sAEniyf6Xvno
	 0uCLBBKbfNIaVxYTMBR3xmJhbTB7dtu7J45z21dk=
Date: Tue, 16 Jun 2026 12:24:30 +0530
From: Greg KH <gregkh@linuxfoundation.org>
To: Sven Eckelmann <sven@narfation.org>
Cc: wangjiexun2025@gmail.com, bird@lzu.edu.cn, n05ec@lzu.edu.cn,
	tomapufckgml@gmail.com, tr0jan@lzu.edu.cn, yifanwucs@gmail.com,
	yuantan098@gmail.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] batman-adv: stop tp_meter sessions during
 mesh teardown" failed to apply to 5.10-stable tree
Message-ID: <2026061623-unreeling-dangle-5f46@gregkh>
References: <2026051555-germproof-bolt-6720@gregkh>
 <2004925.tdWV9SEqCh@sven-desktop>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2004925.tdWV9SEqCh@sven-desktop>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263625-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sven@narfation.org,m:wangjiexun2025@gmail.com,m:bird@lzu.edu.cn,m:n05ec@lzu.edu.cn,m:tomapufckgml@gmail.com,m:tr0jan@lzu.edu.cn,m:yifanwucs@gmail.com,m:yuantan098@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,lzu.edu.cn,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gregkh:mid,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C8E4368CAC5

On Fri, May 15, 2026 at 01:37:05PM +0200, Sven Eckelmann wrote:
> On Friday, 15 May 2026 10:44:55 CEST gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.10-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 3d3cf6a7314aca4df0a6dde28ce784a2a30d0166
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051555-germproof-bolt-6720@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..
> > 
> > Possible dependencies:
> 
> 
> I had a look at it but it would need get a backport of timer_shutdown_sync for 
> the original patch. Then the version from 5.15 should work directly.
> 
> But when I've looked into the patches. I saw that there is a big gap already 
> between 5.10 and 5.15.
> 
> Already backported in 5.15 (and could be used as reference for 5.10)
> 
> b0b0aa5d858d ("Documentation: Remove bogus claim about del_timer_sync()")
> 80b55772d41d ("ARM: spear: Do not use timer namespace for timer_shutdown() function")
> 5135c7150732 ("clocksource/drivers/arm_arch_timer: Do not use timer namespace for timer_shutdown() function")
> 6e1fc2591f11 ("clocksource/drivers/sp804: Do not use timer namespace for timer_shutdown() function")
> 82ed6f7ef58f ("timers: Replace BUG_ON()s")
> 2249b9ec4232 ("Documentation: Replace del_timer/del_timer_sync()")
> d02e382cef06 ("timers: Silently ignore timers with a NULL function")
> 8553b5f2774a ("timers: Split [try_to_]del_timer[_sync]() to prepare for shutdown mode")
> 0cc04e80458a ("timers: Add shutdown mechanism to the internal functions")
> f571faf6e443 ("timers: Provide timer_shutdown[_sync]()")
> a31323bef2b6 ("timers: Update the documentation to reflect on the new timer_shutdown() API")
> 20739af07383 ("timers: Fix NULL function pointer race in timer_shutdown_sync()")
> 
> But between 5.10 and 5.15 are 134 patches which at least partially should be 
> relevant for the backporting of timer_shutdown_sync.
> 
> For the moment, I will skip the backporting of timer_shutdown_sync and switch 
> it to del_timer_sync() - which should work here because the re-arming will 
> only happen by the timer.

Seems reasonable, thanks!

greg k-h

