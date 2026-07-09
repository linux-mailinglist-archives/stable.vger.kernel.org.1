Return-Path: <stable+bounces-272911-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yoWFDtKdT2p9lAIAu9opvQ
	(envelope-from <stable+bounces-272911-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 15:10:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D36D7316A8
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 15:10:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="O8+/xFBP";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272911-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272911-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E241230A4A05
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 13:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C8F25B084;
	Thu,  9 Jul 2026 13:07:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCDC1DE894;
	Thu,  9 Jul 2026 13:07:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783602448; cv=none; b=lG5nMyqhOF5D6ybK6ZZPWnuOAeCHetiJtOzyEIYKBHpj5KikZYWOp35i2g6efMZiJuSy+4bRtzQHtGeKbKYpdq9QtQyQ0EVPyzoU9aAco/04YgDnJPH4pVR3uJzGO+eIReycEuTy4DTI/kYApEIw/C1JkxEhXCBItdGGlTrX6mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783602448; c=relaxed/simple;
	bh=v6wGCAJ+OjIEmrlQX6g4/fsLs9G2nvAmX69ExwtwMjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+vFsWVphVXEyZfZ6YyLiMM2ToTsEvr1pMPcMbAOB1UBIolcO7J4VucbwjknhAYXCy3Rxa8OUP8uG2FT8h5w99JXTea0m5zVrLKXAYwkDcC1itWBYT0MHW3W6TUNYuJN0b4OGakxTtfAp6Q9fGmiubaJs9hiUe2ufI3ds/T441w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O8+/xFBP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E391F000E9;
	Thu,  9 Jul 2026 13:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783602446;
	bh=8WW2suDc45jup1BOs8EMK1QW5Oz+r1eQvcIaoKjWMPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O8+/xFBPkIJDN5R2fVxmbOXNjSlOburat+QvNk+j8YbdRp8cRDNr01292CvubMM4h
	 iPiF/wfMijr4cqbObhP0hpbcHYr+vY2pEb+zNQ+zvkyzxgtIg3S8i6cbHdqFAuQ/tg
	 vpfkVN6bqe2bLCWmzkq8zdQZnUr4u8buVTTNtOz4=
Date: Thu, 9 Jul 2026 15:07:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: stable@vger.kernel.org, linux-hardening@vger.kernel.org,
	Kees Cook <kees@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	"Harry Yoo (Oracle)" <harry@kernel.org>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Subject: Re: [PATCH 6.18 4/4] slab: recognize @GFP parameter as optional in
 kernel-doc
Message-ID: <2026070910-crisped-crewman-25ab@gregkh>
References: <20260709043301.142931-1-ebiggers@kernel.org>
 <20260709043301.142931-5-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709043301.142931-5-ebiggers@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272911-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ebiggers@kernel.org,m:stable@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:kees@kernel.org,m:rdunlap@infradead.org,m:harry@kernel.org,m:vbabka@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:from_mime,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,vger.kernel.org:from_smtp,gregkh:mid,infradead.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D36D7316A8

On Thu, Jul 09, 2026 at 12:33:01AM -0400, Eric Biggers wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> commit 7b5f5865fb11e60edd03c5e063e2d228b7062317 upstream.
> 
> Since the @GFP parameter in kmalloc_obj() etc. is now optional, change
> the kernel-doc to indicate that it is optional. This avoids kernel-doc
> warnings:
> 
> WARNING: include/linux/slab.h:1101 Excess function parameter 'GFP' description in 'kmalloc_obj'
> WARNING: include/linux/slab.h:1113 Excess function parameter 'GFP' description in 'kmalloc_objs'
> WARNING: include/linux/slab.h:1128 Excess function parameter 'GFP' description in 'kmalloc_flex'
> 
> Fixes: e19e1b480ac7 ("add default_gfp() helper macro and use it in the new *alloc_obj() helpers")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Harry Yoo (Oracle) <harry@kernel.org>
> Link: https://patch.msgid.link/20260617163125.2716279-1-rdunlap@infradead.org
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  include/linux/slab.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Also added to 7.1.y to keep in sync, thanks!

greg k-h

