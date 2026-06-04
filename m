Return-Path: <stable+bounces-260250-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NJm4DjDvIGrG9gAAu9opvQ
	(envelope-from <stable+bounces-260250-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 05:21:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D9763CAEF
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 05:21:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=iUie9TD0;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260250-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260250-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C78D302FEBC
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 03:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062823AEF3E;
	Thu,  4 Jun 2026 03:21:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCDC303C83;
	Thu,  4 Jun 2026 03:21:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780543276; cv=none; b=YB6hkpO0CA2uCyaQ4qMp7aPJ76KWM9Y1/fIFjVz9TXmwpGTiJNmYBi9Pj8xzffz6hCUbuGYSRmtFllowGaPFucZRMrA+anZgEzpe4uEIYR0MH9EWrWmUrfKoc8gdwrIF2UgDvLK2YygyMDknOOnVhpEGCNn5UV4Iw0ed7e9H/A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780543276; c=relaxed/simple;
	bh=YkZVwwjq5SMhkXrIQdUBGBsYEsVgBWkqfge/twrMw14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N83jFBzkULNYWloy/yhGzHYC96G1Qu/KD7z2xgLjfxTCBa8jATZit+Sqr6YJf0eA9JlcHQMMRz7F0qS8icVXWqWjo299tqgt9+3OC/tV34r6DEojVPOraJ76zzwtPjbMoLboXnz5RjlWNtQ99T5+lwiMCx2QAtJCgo4X/jkHkH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iUie9TD0; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LNCNr5x3EzSqqtU6NP0iKEehA9J/yexioticfuX5tdw=; b=iUie9TD0Jl3ttEMwfdLPxUO9u7
	sOK5KuJgqH1RKQk2sTTh0jjP1ieh4To/8a8zEIyXKp9xniy0r/X+xLtO2iPGCyHDAgxwH8drNmlrE
	4NeFsnM/SLXlq6hn11bYiXSeGBcZQ13LKs+wEzht6SM8Y0kbgVm4uF2i8mcxyEFIrDxI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUydh-005yof-UA; Thu, 04 Jun 2026 05:21:01 +0200
Date: Thu, 4 Jun 2026 05:21:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
	mturquette@baylibre.com, sboyd@kernel.org, bmasney@redhat.com,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] clk: mvebu: ap-cpu: fix missing clk_put() in
 ap_cpu_clock_probe()
Message-ID: <bdaf822d-a084-42ea-8fa0-01d9d9ea3385@lunn.ch>
References: <20260604025115.3763823-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604025115.3763823-1-vulab@iscas.ac.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260250-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[bootlin.com,gmail.com,baylibre.com,kernel.org,redhat.com,lists.infradead.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:gregory.clement@bootlin.com,m:sebastian.hesselbarth@gmail.com,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-clk@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:sebastianhesselbarth@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 87D9763CAEF

On Thu, Jun 04, 2026 at 02:51:15AM +0000, Wentao Liang wrote:
> The function ap_cpu_clock_probe() calls of_clk_get() to obtain a
> reference to the parent clock for each CPU cluster, but it never
> releases it with clk_put().  The returned clk is used only to read
> the parent's name via __clk_get_name(), and the reference is leaked
> on every successful cluster initialization as well as on the error
> path when devm_clk_hw_register() fails.

Is there potentially a different interpretation?

If the parent clock was to disappear, the clocks to the CPU would
disappear, resulting in a dead system. By keeping a reference on the
parent, it cannot disappear?

Also, do we care that much about the error case? If we fail to setup
the CPU clock, how much longer is the CPU going to run before it dies
a horrible death?

> Add the missing clk_put() after the name has been extracted and
> before returning on error to fix the leak.
> 
> Fixes: af9617b419f7 ("clk: mvebu: ap-cpu-clk: Fix a memory leak in error handling paths")
> Cc: stable@vger.kernel.org

Does this actually bother people? It needs to in order to be sent to
stable:

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

     Andrew

