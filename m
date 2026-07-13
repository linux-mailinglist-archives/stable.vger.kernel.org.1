Return-Path: <stable+bounces-273534-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w6wBDktKVGoPkQMAu9opvQ
	(envelope-from <stable+bounces-273534-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 04:15:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C47A37468DF
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 04:15:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=crhGRaOt;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273534-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273534-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA64F300C03A
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 02:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF50A2BEC4E;
	Mon, 13 Jul 2026 02:15:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9CE21883E;
	Mon, 13 Jul 2026 02:15:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783908932; cv=none; b=WciButPTHMs/x2bMXd8gxDIqLPuHTjfasFP5Dmxh53T/clHSMxIJfNQ4UgHepSCKW++KvfyE2seMXZsmcaNE4sTtq3h0jyrPOZtwjwtx/RWVpb3Z322GIHD0etL5r7XRw26HZwMRsuiQFNJ2tNXlg9R9ybvDCb7I+vS9a2PUWrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783908932; c=relaxed/simple;
	bh=MqYD6XtPyh/IjlNYKeybkImoFzI6oxVbHfCCaskJRzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGyAvjjmKvuvWEE9VPogG18i9LVWyxbfqmFDd5oGb8zmZNXaYKVRSQ1OrC0uE50HiucO/TL6kjq7Bgm64+TswVO3rrOq6YNF0eBGPLYP2uoH3aa3+4YnMY666MZJgCpY8Y6w+4s6bGbgTMjdZMTkyRadmO9e5y9uqg2EzVWKfXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crhGRaOt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0841F000E9;
	Mon, 13 Jul 2026 02:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783908931;
	bh=7k0Lzgbjrzc0jwcGLOrgGZCu8dbATW+NlNDQQlTcaWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=crhGRaOtAUi1Dt5grB5AbQXJhQ3+UHpXpziWHU/nyTUufAY+syvELCbHQR1zTvFct
	 kuu4F7BoWhJFLb06EgBYxK49qJLb3qxJk3E+irjTybQrvQMtcqOJHJAIE6t2r5U3F+
	 /TPdnRcDbWgoOZdlgrvNkUhJDlz6Tj1Bt1mbN5fg1Evz3ynjycEx1g0bGN0eOUlF8s
	 7O/XVs3QehjQS7a5PFu3/+C8LG4x1+kVBxJ/mK+Hv4mN4Yiernj0fA+VddkWzM97cp
	 sUEhORijMMQNICwB7R098396W/U+L3MEQ8zyd+q+A/sH28K6DIUrQ7ETILDIV9o7KI
	 fqazt1zmvVYig==
Date: Sun, 12 Jul 2026 22:15:29 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, stable@vger.kernel.org
Subject: Re: [PATCH] crypto: aes - Fix conditions for selecting MAC
 dependencies
Message-ID: <20260713021529.GD4362@quark>
References: <20260709022954.45113-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709022954.45113-1-ebiggers@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ardb@kernel.org,m:Jason@zx2c4.com,m:herbert@gondor.apana.org.au,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-273534-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[quark:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C47A37468DF

On Wed, Jul 08, 2026 at 10:29:54PM -0400, Eric Biggers wrote:
> Starting in commit 7137cbf2b5c9 ("crypto: aes - Add cmac, xcbc, and
> cbcmac algorithms using library"), the aes module (CRYPTO_AES) supports
> CBC based MACs using the corresponding library functions.
> 
> To avoid including unneeded functionality, that support honors the
> existing CRYPTO_CMAC, CRYPTO_XCBC, and CRYPTO_CCM kconfig options.  The
> dependencies are selected if at least one of those is enabled.
> 
> However, the select statements don't correctly handle the case where
> CRYPTO_AES=y and (for example) CRYPTO_CMAC=m.  In that case the
> dependencies get selected at level 'm', due to how the kconfig language
> works.  That causes a linker error.
> 
> Fix this by changing the selection conditions to use '!= n'.
> 
> A similar issue also exists for CRYPTO_LIB_AES's conditional selection
> of CRYPTO_LIB_UTILS.  The same '!= n' would work, but instead just make
> CRYPTO_LIB_AES always select CRYPTO_LIB_UTILS.  CRYPTO_LIB_UTILS is
> lightweight, and it's needed by most AES modes and many other things.
> 
> Fixes: 7137cbf2b5c9 ("crypto: aes - Add cmac, xcbc, and cbcmac algorithms using library")
> Fixes: 309a7e514da7 ("lib/crypto: aes: Add support for CBC-based MACs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
> 

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=libcrypto-fixes

- Eric

