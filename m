Return-Path: <stable+bounces-268866-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ahlSFGJsPmpxFwkAu9opvQ
	(envelope-from <stable+bounces-268866-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 14:11:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B99396CCDAD
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 14:11:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HuLiCafF;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268866-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268866-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CAC430B3095
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 12:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB343F4137;
	Fri, 26 Jun 2026 12:06:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660613F4134
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 12:06:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782475592; cv=none; b=I+nnNAtqCR62ov34XV/qzS8CHEb3fvukFW/AorfS6mdRbljHN3i9/fD0ZWVWqbRqaohcMEFDTzteyF7FUvIACxP9hmQOYM3cTolweizCpuCwAyubR6PaRTmzB7lWgSyCMSEa5PTBqTNqhiPbVRXyq51bUMKIWAdmyBdV+FlythA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782475592; c=relaxed/simple;
	bh=oA3l/vucteIpjI/8m54kvsuw6yyKtM+W3WDN4uvfG8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqSVYOrFozfD4j1LJvrZgA/o4otCWLPCwCwBpjSHPyPsK1+GsThUlBuXB9OePdqnbvSzk+eaS5SU4e1gYUBvAVY7M0V7Eyqdjqz0XLXl1Ef03lD5SbVcy9Ny/gtMP3CrJBisjshOrWZkFZ62vh7pcipC7Ny+nbz4MWndLSB0wRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuLiCafF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE9F1F000E9;
	Fri, 26 Jun 2026 12:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782475591;
	bh=CR/q+u4UxqSX/SXdvCBsFabJIJzu5N3mtpvnRKl9G+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HuLiCafF27i+a1Hwbe58UcUWXi+RtmTlsiS1578ZPbFvyClVUMajIx4xvQq1Nn9MW
	 6U9H0QCEquJHo5VesQ4uw/caR8kMCLxe/nFB59OF7KtpZiRUrh0cuf6AOVwt/zP1bJ
	 sXe63MHAbjGiDG2Nef7mAnwdboy4eJuhMEe5QZJusYZ+4XkVGtrDtnKkodet8xtO31
	 zUUEh1HFS/oV6/plnRvAFtq8v/w075BqMhU3Sc+KEzY+vTFxFd3uZgAHPVemYOqkrZ
	 TEm+sXgtZqQN/Jef6Wk7mfhIzzZhNGqRnfFkvJdoHDBShsbePempzC73XGjppHzGVA
	 F7pI/mUK+NtQw==
Date: Fri, 26 Jun 2026 13:06:23 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Alice Ryhl <aliceryhl@google.com>, linux-mm@kvack.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm: fix CONFIG_STACK_GROWSUP typo in
 tools/testing/vma/include/dup.h
Message-ID: <aj5qnsGDPC3nREdT@lucifer>
References: <20260611012258.432043-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611012258.432043-1-enelsonmoore@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-268866-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:enelsonmoore@gmail.com,m:vbabka@kernel.org,m:jannh@google.com,m:pfalcato@suse.de,m:akpm@linux-foundation.org,m:liam@infradead.org,m:aliceryhl@google.com,m:linux-mm@kvack.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lucifer:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B99396CCDAD

On Wed, Jun 10, 2026 at 06:22:44PM -0700, Ethan Nelson-Moore wrote:
> Commit 2b6a3f061f11 ("mm: declare VMA flags by bit") significantly
> refactored the header file include/linux/mm.h.  In that step, it introduced
> a typo in an ifdef, referring to a non-existing config option
> STACK_GROWS_UP, whereas the actual config option is called STACK_GROWSUP.
> 
> Commit 40a4af52e047 ("mm: fix CONFIG_STACK_GROWSUP typo in mm.h") fixed
> this typo in the mm.h header file, but did not update the copy of the
> code in tools/testing/vma/include/dup.h. Update this copy as well.
> 
> Commit message adapted from the above-referenced fix to mm.h.
> 
> Fixes: 2b6a3f061f11 ("mm: declare VMA flags by bit")
> Cc: stable@vger.kernel.org # 7.0+

Actually since we don't set the config options like the kernel does in
userland tests, this can't actually be something that you can get to
happen :P

So drop both Fixes, and the Cc: stable please as per David (Andrew - can
you make that change? Thanks!)

> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Thanks for fixing this however! I typo'd this in the actual code but didn't
update the VMA userland test code. Appreciate the cleanup! So, with the
fixes, Cc: stable tags dropped:

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

> ---
>  tools/testing/vma/include/dup.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
> index 9e0dfd3a85b0..adbc3179085d 100644
> --- a/tools/testing/vma/include/dup.h
> +++ b/tools/testing/vma/include/dup.h
> @@ -243,7 +243,7 @@ enum {
>  #define VM_NOHUGEPAGE	INIT_VM_FLAG(NOHUGEPAGE)
>  #define VM_MERGEABLE	INIT_VM_FLAG(MERGEABLE)
>  #define VM_STACK	INIT_VM_FLAG(STACK)
> -#ifdef CONFIG_STACK_GROWS_UP
> +#ifdef CONFIG_STACK_GROWSUP
>  #define VM_STACK_EARLY	INIT_VM_FLAG(STACK_EARLY)
>  #else
>  #define VM_STACK_EARLY	VM_NONE
> -- 
> 2.43.0
> 

Cheers, Lorenzo

