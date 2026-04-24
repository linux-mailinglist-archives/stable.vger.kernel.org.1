Return-Path: <stable+bounces-240637-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCbBFnVT62nkKwAAu9opvQ
	(envelope-from <stable+bounces-240637-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:26:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1177145DAF9
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE6AE301112E
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B244E3B0AE5;
	Fri, 24 Apr 2026 11:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JbCHr5ps"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8A53B0AC2;
	Fri, 24 Apr 2026 11:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777029801; cv=none; b=lnFKFPmkCRR73Ksy0pHCrbw2pTgc0Hm99L3PAdDQu5G2/7S5ZF7OcoYTmWVT4A0ZBYy8Ga2p/IwGdWDTt7ChVfnwO5T3VII4DWEa/+jJ3/pPXCjFOVGe/jfFLoaio6TqSVdAn7kmlLuK3b2CPxd/IE7MHTfwatK0b0SdEVXeQmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777029801; c=relaxed/simple;
	bh=GDKxQDD2uzrWcvo0rf7Ox4o00oq3jpy4JnR3vM9P3ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZGfPc5HIfKAWS0XBKB50hwlz4+2E6Iqca93igCu2ML7fcV4keqTtJEx+Zw3q531Te6TqQfy5dPPWNXrg7NvKdLZ/ieJS/Aoujfq+pExkmfOciitE6nvTJqzn7Uzw/FYmmdOM5SKf9HCbl8RQfC/GP6nNIrNq9mKmQwARvMjZIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JbCHr5ps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336B4C2BCB4;
	Fri, 24 Apr 2026 11:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777029800;
	bh=GDKxQDD2uzrWcvo0rf7Ox4o00oq3jpy4JnR3vM9P3ps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JbCHr5psXcKdOm+Bdk5oRHUjBjs0H0hK3D5VPgbvLW+z5BorAuX0Vohbt4QeYFSTB
	 xV7Y5q6xgpGptF34s71xOXxrezGiOYs4OjQFXJMlIhDdhb62Gd9Cvb0sOPTSeGTrXb
	 tvrXI9nwaHRl9K/SigwY8RoaTa5K7N+ZrVFDAHZw=
Date: Fri, 24 Apr 2026 13:23:18 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] driver core: faux: fix root device registration
Message-ID: <2026042438-mousiness-preorder-b1b9@gregkh>
References: <20260424102231.2615557-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424102231.2615557-1-johan@kernel.org>
X-Rspamd-Queue-Id: 1177145DAF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240637-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Fri, Apr 24, 2026 at 12:22:31PM +0200, Johan Hovold wrote:
> A recent change made the faux bus root device be allocated dynamically
> but failed to provide a release function to free the memory when the
> last reference is dropped (on theoretical failure to register the device
> or bus).
> 
> Fix this by using root_device_register() instead of open coding.

Ah, good catch, I missed that, thanks!

> Also add the missing sanity check when registering faux devices to avoid
> a NULL-pointer dereference if the bus failed to register (which would
> previously have triggered a bunch of use-after-free warnings).

If the bus fails to register at boot time, we have bigger problems than
those types of warnings :)

I'll queue this up after -rc1 is out, thanks.

greg k-h

