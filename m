Return-Path: <stable+bounces-238364-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2K4kCcpJ4WmDrQAAu9opvQ
	(envelope-from <stable+bounces-238364-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 22:42:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F71414AC1
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 22:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A48C130538BC
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 20:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09BC379EF5;
	Thu, 16 Apr 2026 20:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKl/TJ+Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31D0223702;
	Thu, 16 Apr 2026 20:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776372162; cv=none; b=CF1LLjSyeCxmo5EbRRvkRHnS5wB2edER7Mo8+I4X7CU315T9Mu4ouxYhpUwz5nvS9M3Sf7a2ofJfZ3veWwdqYNHLpaQ5OuXPvzzfqYopV44l6XP5hu5RVaUXDdJNFrlK7lMSoXBdS1tMpw/CkJbzp7MB2XZeP9mX7Bu8N7YIGXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776372162; c=relaxed/simple;
	bh=JPUtuKxwLtiIktkD4islzsWIZs7009+OiFPhBhlfWPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RA/7Yj6T98VeuzaDrfOKdB/1C1NYBVu2Y0TsvuRHiSMJ2NdVwwh5H0E4gNj5+2xLwQ0tAksYvYuCIIeYDi2jFL/IUk4Q/yPuLMMwkD//Skl/3R5rnnAUdgHJhc3//s+j8uvzYCef+ihlKFtRXMgIPFcCJpwFLIigCyfxlEjxyx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKl/TJ+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CAAC2BCAF;
	Thu, 16 Apr 2026 20:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776372162;
	bh=JPUtuKxwLtiIktkD4islzsWIZs7009+OiFPhBhlfWPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BKl/TJ+ZPdIlIDnjASWVrYDL3IV0Hg0SaOut31d8EHj6+hXZs80Wfl4tXdwmMANjD
	 p0Cip9RVzakMik22MUBSbt49iaVUGF0GFEsqa8q67nNOSf0B58sUOk8hbyTUr7krtJ
	 UFhL/EMnZ1xQEjfvXrdyn60WEML2yUN/qnke0FX8jFsFUCTDNT14bfzSbX4oyJSsLI
	 BArEStBBoQzqcYsFHt+csASsL1Zlv1gAZrubkNPfOzId3/fu5m8FsfxfSgfmJOAQgV
	 WIosob1fRsmzNhwqzTKTOhp2Q29qUP9+5Fsz1vtfOJ2RRibzDH6LkGjNEEkBTXOqZl
	 hEV324AI0Bt5A==
Date: Thu, 16 Apr 2026 13:42:37 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] extract-cert: Wrap key_pass with '#ifdef
 USE_PKCS11_ENGINE'
Message-ID: <20260416204237.GA4136475@ax162>
References: <20260325-certs-extract-cert-key_pass-unused-but-set-global-v1-1-ecf94326d532@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325-certs-extract-cert-key_pass-unused-but-set-global-v1-1-ecf94326d532@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238364-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,lkml];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A6F71414AC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 06:19:15PM -0700, Nathan Chancellor wrote:
> A recent strengthening of -Wunused-but-set-variable (enabled with -Wall)
> in clang under a new subwarning, -Wunused-but-set-global, points out an
> unused static global variable in certs/extract-cert.c:
> 
>   certs/extract-cert.c:46:20: error: variable 'key_pass' set but not used [-Werror,-Wunused-but-set-global]
>      46 | static const char *key_pass;
>         |                    ^
> 
> After commit 558bdc45dfb2 ("sign-file,extract-cert: use pkcs11 provider
> for OPENSSL MAJOR >= 3"), key_pass is only used with the OpenSSL engine
> API, not the new provider API. Wrap key_pass's declaration and
> assignment with '#ifdef USE_PKCS11_ENGINE' so that it is only included
> with its use to clear up the warning. While this is a little uglier than
> just marking key_pass with the unused attribute, this will make it
> easier to clean up all code associated with the use of the engine API if
> it were ever removed in the future. While in the area, use a tab for
> the key_pass assignment line to match the rest of the file.
> 
> Cc: stable@vger.kernel.org
> Fixes: 558bdc45dfb2 ("sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

I am going to apply this to my tree and send it to Linus at some point
during the merge window, as this warning breaks the build early,
disrupting our upstream LLVM testing. If there are any objections to
this, please let me know; it does not seem like extract-cert.c is a hard
owned file.

> ---
> I am taking a fix for a similar warning in modpost through the kbuild
> tree so I don't mind picking this up with an appropriate Ack or it can
> just go through the keyring tree, does not matter to me.
> ---
>  certs/extract-cert.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/certs/extract-cert.c b/certs/extract-cert.c
> index 7d6d468ed612..54ecd1024274 100644
> --- a/certs/extract-cert.c
> +++ b/certs/extract-cert.c
> @@ -43,7 +43,9 @@ void format(void)
>  	exit(2);
>  }
>  
> +#ifdef USE_PKCS11_ENGINE
>  static const char *key_pass;
> +#endif
>  static BIO *wb;
>  static char *cert_dst;
>  static bool verbose;
> @@ -135,7 +137,9 @@ int main(int argc, char **argv)
>  	if (verbose_env && strchr(verbose_env, '1'))
>  		verbose = true;
>  
> -        key_pass = getenv("KBUILD_SIGN_PIN");
> +#ifdef USE_PKCS11_ENGINE
> +	key_pass = getenv("KBUILD_SIGN_PIN");
> +#endif
>  
>  	if (argc != 3)
>  		format();
> 
> ---
> base-commit: d2a43e7f89da55d6f0f96aaadaa243f35557291e
> change-id: 20260325-certs-extract-cert-key_pass-unused-but-set-global-23007ecfadf9
> 
> Best regards,
> --  
> Nathan Chancellor <nathan@kernel.org>
> 

