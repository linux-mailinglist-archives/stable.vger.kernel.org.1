Return-Path: <stable+bounces-220006-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBKYCGf9oWl4yAQAu9opvQ
	(envelope-from <stable+bounces-220006-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 21:24:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C741BD961
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 21:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A2C131BD2F1
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 20:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C720847A0BD;
	Fri, 27 Feb 2026 20:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U8ypfNZC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814B747A0C5
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 20:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772223154; cv=none; b=o0OBdSsHWxOXUw2QLjHmi5c5LwZW5BllZVpNvlQ5K+ore2ngcz3eEslB7IcbKN8mLBU6my0TubxVOFgNqbPUFM5Egx8CsAJ+HEjjlwT92OqjcxDuzowW3LFbyTJsiHZnupZEhwYLmapOFLnt53d1ftOaeyjun4DLTVlLr5QdrMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772223154; c=relaxed/simple;
	bh=YV7eKAbUWGj3wAh5cJIWDxJd635OI5hL5WsM1pNkrvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFzQahMzH5nggg+Eu3F673JOO7c5q24vMZBo4TP1mN8GBp0gyM+C5t5+MJVmKyLgLFX6OHwZR58HNeGmQD8ZuXEkdmMtuArysKsf/jpSRoDJjJnb4ffBz3QFyJTZK9yEnHDZGnCuzOO4MWEgXFOvPknFAhb+dGuTF3atps37LJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U8ypfNZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8551C116C6;
	Fri, 27 Feb 2026 20:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772223154;
	bh=YV7eKAbUWGj3wAh5cJIWDxJd635OI5hL5WsM1pNkrvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U8ypfNZC1bkX5laRs5qzwwBRCWLE3gkOKv/wQvBQF85EM5aVEc0ImA0s5E1kL94oi
	 6ak+zr1rpB/Mgg38IGpybD7xniVPY+kLPhN7BfxVjiOKGsO+pYKxTbKzLSC01iAt7R
	 g4DkMRetmyioeVZT7BehOUOD89VSeo4EralUKZUk=
Date: Fri, 27 Feb 2026 15:12:22 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: Rainer Fiebig <jrf@mailbox.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, jpoimboe@kernel.org
Subject: Re: 6.18.14: VirtualBox modules don't build anymore; bisected
Message-ID: <2026022741-mahogany-coveted-acfa@gregkh>
References: <62d12399-76e5-3d40-126a-7490b4795b17@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62d12399-76e5-3d40-126a-7490b4795b17@mailbox.org>
X-Rspamd-Server: lfdr
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220006-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 84C741BD961
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 04:33:34PM +0100, Rainer Fiebig wrote:
> In case this hasn't been reported already: with 6.18.14 the
> VirtualBox-7.1.16 modules won't build during the boot process, as they
> usually do.  Bisecting between 6.18.13/14 led to this:
> 
> f056c340b73962ebaffe93997b582bdf16dc6270 is the first bad commit
> commit f056c340b73962ebaffe93997b582bdf16dc6270 (HEAD)
> Author: Josh Poimboeuf <jpoimboe@kernel.org>
> Date:   Tue Feb 10 13:45:22 2026 -0800
> 
>     kbuild: Add objtool to top-level clean target
> 
>     [ Upstream commit 68b4fe32d73789dea23e356f468de67c8367ef8f ]
> 
>     Objtool is an integral part of the build, make sure it gets cleaned
>     by "make clean" and "make mrproper".
> [...]
> 
> 
> The script I use for building my kernels includes "make mrproper" before
> compiling and "make clean" after the kernel and modules have been
> installed.
> 
> Perhaps it would be more appropriate to report this to the
> VirtualBox-devs but I won't do that because the registration procedure
> asks for too many private data.

We obviously can not do anything about external modules, so if you rely
on these, you are going to have to work with them on this, sorry.

thanks,

greg k-h

