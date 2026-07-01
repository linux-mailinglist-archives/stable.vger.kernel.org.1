Return-Path: <stable+bounces-270097-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SiVNLwCqRGqQygoAu9opvQ
	(envelope-from <stable+bounces-270097-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 07:47:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EF06E9EAD
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 07:47:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=KmBAFpdy;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270097-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270097-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 536673037E66
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 05:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7867B38F957;
	Wed,  1 Jul 2026 05:43:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3703D37F75B;
	Wed,  1 Jul 2026 05:43:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782884622; cv=none; b=G5IuEN/YiVrT4Jcy/9FbU4Q+rGU68OAjK2w6K+sd63wg5CCIsdePmVGJb6nIZKbEwbr/KqWmJmUkYk4jcolPHkTDDcYvJUBcX5BZTMWGV/N+UN+ghEsH3RdThWvan0+HgWk/1fY2Vn89PmgVMIPNrNB9ph50c3xMgxeALwqFbvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782884622; c=relaxed/simple;
	bh=gRKQ3/hQFEanmmBi+Rz+LeKtfw8kylGgvKZNe6XmuhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITQqd4ruXrTQiJkM6PXvmweCuwkPGUVaDXAHRnGYH4oH2HVwRJgR0DP1GwTS58kH97Z+qIAxNIcXqUtDUJU44hfKjK4GNUoiYrcXZGCv8L6v4WnCSU9ilu0JmmUo0RtJtrLZSQ7ytd9jNtfxxCzphMvjtB30BAb3BHQoX2Xfkmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KmBAFpdy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FF61F000E9;
	Wed,  1 Jul 2026 05:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782884620;
	bh=KWfvH7ukIpAAnwG0drNrOUeLjPT5WPF+nH/nAIY22J0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KmBAFpdyYekG1ZSySTKNOriNmKusVX4SalkQAXKbuMeZF798AO7q3fcuT2Q81LRq0
	 XoTRUCizmZvyN6qD9RW1ufUGF4+Rs6R4PZubzdVT7JkNjHx2qvqoQdBJC8Bk9XFAOd
	 agxC0UXc8pEc8ZaJDksLmxzvpiKsjt6BssSHWFWc=
Date: Wed, 1 Jul 2026 07:43:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "jianing.li" <m13940358460@163.com>
Cc: Sebastian Reichel <sre@kernel.org>, Iskren Chernev <me@iskren.info>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Matheus Castello <matheus@castello.eng.br>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] power: supply: max17040: handle missing status supplier
Message-ID: <2026070115-equate-shimmy-5f19@gregkh>
References: <20260701012101.782-1-m13940358460@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701012101.782-1-m13940358460@163.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:m13940358460@163.com,m:sre@kernel.org,m:me@iskren.info,m:krzk@kernel.org,m:m.szyprowski@samsung.com,m:matheus@castello.eng.br,m:linux-pm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[163.com];
	TAGGED_FROM(0.00)[bounces-270097-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[jianing.li:url,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,gregkh:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 11EF06E9EAD

On Wed, Jul 01, 2026 at 09:21:01AM +0800, jianing.li wrote:
> MAX17040 does not report charger state itself, so the driver forwards
> POWER_SUPPLY_PROP_STATUS to a supplier power supply. If no supplier is
> registered, power_supply_get_property_from_supplier() returns -ENODEV and
> leaves the output value untouched.
> 
> max17040_get_property() currently ignores that error and returns success,
> so userspace can read an uninitialized status value from the battery power
> supply. This happens on systems that use the fuel gauge without a charger
> supplier relationship in firmware.
> 
> Return POWER_SUPPLY_STATUS_UNKNOWN when no supplier provides STATUS, and
> propagate other supplier lookup errors.
> 
> Fixes: f4b782af61ae ("power: max17040: pass status property from supplier")
> Cc: stable@vger.kernel.org # 6.7+
> Signed-off-by: jianing.li <m13940358460@163.com>

Please use your name, not an email alias.

And why send this 3 times?

thanks,

greg k-h

