Return-Path: <stable+bounces-263659-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rCIJCZImMWopcwUAu9opvQ
	(envelope-from <stable+bounces-263659-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 12:33:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D42168E569
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 12:33:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=S021kXW+;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263659-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263659-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 271A6313A6DD
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 10:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45B43B7B6B;
	Tue, 16 Jun 2026 10:21:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33FB35504D
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 10:21:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605279; cv=none; b=Sxk2Hc1F7Elvpo9a2ye6hauxRGrjKckuFnh3hf7uBr5tlI2E5WFlzFpHhBPW++maqo+uarwzWpJbG0hxAwrUoUElSy1FkH9Sui5UrxFsDU/XTz4QlM5HKR7LPkv3snrsVW9ibmNvWHeBOYxgEk1W90Qyl/GtZgVMeGrCafVnqQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605279; c=relaxed/simple;
	bh=HV4HGFeV+reKZlhjdubbcImOwDCIEbYxNHDzgdHrvRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QY/lIT9A47j/bZ+CtW5KV7xXiqh2/LmsMAFNFUBtVDseDIPbUkwZ1FBEDRDoZPgIjuyI704+gRGvw+gqAuB6LG15gCyUOb2Vyd0U2mTMkky3YrCYKHpKv9Rt5njr4MfhNVyRLdTeIhX3FDz7b5JKAhKF3DtUD9mQwIIxoGzy4Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S021kXW+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4121F000E9;
	Tue, 16 Jun 2026 10:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781605278;
	bh=0S7NZbJ6OqdUsRfFey/fgDpfi+ywvfrUg345BHUcxgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S021kXW+0yoiScZqgxBGW08IRQvJbLg/e28gjKU2IKUoiSbMaLH7hg9a8sSYIhNVa
	 GqJAFxGgQVnG4XzWSeTTCuyOCCFnlwob+hZzbQkSytEkcO+2ANnzq45IU7J7k071/k
	 JvjNbB2sd+eg+EBll3GAumsmy3FLhZyvol3pCM3E=
Date: Tue, 16 Jun 2026 15:49:49 +0530
From: Greg KH <gregkh@linuxfoundation.org>
To: Clark Williams <clrkwllms@kernel.org>
Cc: stable@vger.kernel.org, sashal@kernel.org
Subject: Re: [PATCH linux-6.1.y 0/2]
Message-ID: <2026061644-upstairs-reversion-7a16@gregkh>
References: <20260616013306.3850069-1-clrkwllms@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616013306.3850069-1-clrkwllms@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263659-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:clrkwllms@kernel.org,m:stable@vger.kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D42168E569

On Mon, Jun 15, 2026 at 08:33:04PM -0500, Clark Williams wrote:
> GCC 16.1.1 introduces stricter diagnostics that surface two latent issues
> in the 6.1.y stable tree, both of which become hard errors under -Werror:
> 
> 1. -Wattributes on regparm(0) for x86-64
> arch/x86/kvm/vmx/vmx_ops.h applies __attribute__((regparm(0))) to
> vmread_error_trampoline(). On x86-32 this is intentional: it overrides
> the kernel's -mregparm=3 convention so the trampoline receives its
> arguments on the stack, matching the inline-asm callers that push args
> before the call. On x86-64 the attribute has always been a no-op (the
> SysV ABI already passes arguments in registers), but older GCC silently
> accepted it. GCC 16.1.1 now warns, which -Werror promotes to a build
> failure. The fix guards the attribute with #ifdef CONFIG_X86_32.
> 
> 2. -Wdiscarded-qualifiers in libbpf
> In tools/lib/bpf/libbpf.c, resolve_full_path() assigns the result
> of strchr() on a const char * to a plain char * variable. Newer
> GCC/glibc combinations propagate the const qualifier through strchr(),
> so this assignment now triggers -Werror=discarded-qualifiers. Since the
> variable (next_path) is only used for pointer arithmetic and is never
> written through, the fix is simply to declare it const char *.
> 
> Clark Williams (2):
>   tools/lib/bpf: fix const-qualifier discard in resolve_full_path
>   kvm/vmx: guard regparm(0) on vmread_error_trampoline for x86_32 only
> 
>  arch/x86/kvm/vmx/vmx_ops.h | 7 +++++--
>  tools/lib/bpf/libbpf.c     | 2 +-
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> 
> -- 
> 2.54.0
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

