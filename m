Return-Path: <stable+bounces-267931-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bLvjJwh0OmqM9QcAu9opvQ
	(envelope-from <stable+bounces-267931-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 13:54:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 335D66B6E57
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 13:54:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=V9pKA7na;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267931-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-267931-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A19D0303F1D7
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 11:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3DC3D47C5;
	Tue, 23 Jun 2026 11:54:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7729534BA50;
	Tue, 23 Jun 2026 11:54:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782215683; cv=none; b=RUE+w9tzqlBUIzCUhJI4+IP9o/w3EP/CwsAjOgyTshyUfeP4YPoOx6Jm28pWMLVXaqtptQb5pqQOImAH2Vo0EIMf5Ti4Vgtrt6NnCbXXJb1n6R6RUq3TBcXXw+f/a5g6tnPMOxnB+8ObK9dLLvTR2lIEx5O1rmtVCuesIxcLf9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782215683; c=relaxed/simple;
	bh=MtnZMRhYrROhIvmxLTrsezHs78ZcfJ61HBdYCexhb9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9guK79M1W7JU1bBXGxDMcVAxoWHZi1gB9BhaLrH1vrdMZE8oAK9HOtlZ8BZwGc7MD8QAyIillN0bUX2q+YbJRpJbi7jG4ZHtO7oTgpOnHQ1R1cFUlUUyQwbl93+lvxzeAGdvXZkANR6n0wdwc1Cqpkwnp7ked9UuBVtIK/BcE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V9pKA7na; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6175D1F000E9;
	Tue, 23 Jun 2026 11:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782215682;
	bh=h76uWuNHHgMzp8lEDtKmFje9j78UHKbnnBpQIlM0Vus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V9pKA7naAZFxBaTyQXja1fOoqJvGPuTltI4UJr0nqIqgYFrdRM3RBmdb7/GJgkvbM
	 7B4OWMOllmdxrCmB2+9wQBcCsHiWY1a9jfvonqNLAo40TLI8p+w33lcAwdfXo4P8bS
	 8faCOjqEsr5JZqQqTuWNjZpXFvV2KqvlkYUFaM5g=
Date: Tue, 23 Jun 2026 13:53:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: w15303746062@163.com
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, kees@kernel.org,
	stable@vger.kernel.org, Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: Re: [PATCH v2] misc: ibmasm: Fix static and dynamic out-of-bounds
 MMIO accesses
Message-ID: <2026062354-quote-lullaby-85e3@gregkh>
References: <2026062354-crawfish-t-shirt-d45d@gregkh>
 <20260623114046.368089-1-w15303746062@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623114046.368089-1-w15303746062@163.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:w15303746062@163.com,m:arnd@arndb.de,m:linux-kernel@vger.kernel.org,m:kees@kernel.org,m:stable@vger.kernel.org,m:25181214217@stu.xidian.edu.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-267931-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,gregkh:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,xidian.edu.cn:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 335D66B6E57

On Tue, Jun 23, 2026 at 07:40:46PM +0800, w15303746062@163.com wrote:
> From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> 
> The ibmasm driver maps PCI BAR 0 without verifying if the hardware-provided
> resource length is sufficient.
> 
> When evaluating the driver against emulated hardware or during virtual
> device fuzzing, a malformed device may expose a significantly undersized
> BAR 0. This leads to two distinct out-of-bounds (OOB) MMIO access vectors:
> 
> 1. Static OOB: The driver hardcodes access to INTR_CONTROL_REGISTER
>    (offset 0x13A4) during probe.
> 2. Dynamic OOB: The driver reads dynamic Message Frame Addresses (MFA)
>    from hardware queues and uses them directly as offsets to dereference
>    I2O messages via get_i2o_message(). A malicious MFA can cause the
>    driver to access memory far beyond the mapped BAR.
> 
> If an OOB access triggers a #PF during module probe while holding the
> idempotent_init_module() lock, it leaves the module loading subsystem
> in a corrupted state, leading to a cascading global soft lockup.
> 
> Fix this comprehensively by:
> - Storing the mapped resource size in 'struct service_processor'.
> - Ensuring the BAR size covers the highest statically accessed register
>   (INTR_CONTROL_REGISTER) during probe.
> - Validating all dynamic MFA offsets against the mapped size before
>   dereferencing to prevent dynamic OOB accesses.
> 
> Fixes: bdbeed75b288 ("pci: use pci_ioremap_bar() in drivers/misc")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> ---
> Changes in v2:
>  - Added dynamic MFA bounds checking in get_i2o_message() to prevent runtime OOB (prompted by Greg KH).
>  - Implemented hardware mailbox deadlock prevention by releasing MFA if bounds check fails.
>  - Fixed potential unsigned integer underflow in bounds check arithmetic.

That's a lot of different things all at once here.  Please split this up
into a patch series, doing only one logical thing per patch so it is
easier to review and apply.

thanks,

greg k-h

