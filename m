Return-Path: <stable+bounces-230719-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKwAIE/txmkIQQUAu9opvQ
	(envelope-from <stable+bounces-230719-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 21:49:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E439934B499
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 21:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 641703054CB5
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 20:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB63388E5E;
	Fri, 27 Mar 2026 20:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="saT7JU0T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B353644BB;
	Fri, 27 Mar 2026 20:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774644166; cv=none; b=mn+cTjAm4ROhVWxcbcpJOSSnZNj71Q6yEQcofohfgb5GijlJKyFmNtLqPujiZFnvQRyN69ESRiRrRmBoC10II52rLrXVanKSCVn1oTnd3DPcfO2Sajy0yHQPUa2CiD4k0XRpiA5ileOHgkIB0hgRJsatI1yuU4imMQ7E7yoIaTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774644166; c=relaxed/simple;
	bh=GUwTJ+AUklF4tfkJKsmupMy9ODQKFmYM1yyDv+OKmIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+XDFmrTJo6/McA2cnywXxFeqcF7MBlOYej9LeKMKo7aJqaBgEJ2zUki6qPfb43Uf9gS+YHVTuPGhhZA1tZobcqFnUU75IPSvVqyXVqlrcbWSgY0F2AeZwqwvpN8OnFff+n0m0xhZGysX+smsq3b0Qz0Wuhk0W2kei/3kSpYChg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=saT7JU0T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF27DC19423;
	Fri, 27 Mar 2026 20:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774644166;
	bh=GUwTJ+AUklF4tfkJKsmupMy9ODQKFmYM1yyDv+OKmIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=saT7JU0TvsPESpqKzvgvXLBDubmwdua/dBJu5K5G0cR01QPRAClfUbZsl6gnmkH3B
	 1YvKAyS98N8nz5APhEqsiAlDbxgstNFya+hDl2IFcogIbsPUl58dPhgX1YJXf/Z1Xm
	 fCjNvhx1MlmcdJh/lovknkP1zWs53kl5BrmHSv5wx7FoEjHdeK0JmrK6vl8UKPy5Ot
	 sIHZrvwGTL1tJ/5ft7WCPWiGXzFHPwiTLTY0IndLV82CH4TEIhrVwshMsxU9hRg7xH
	 IVMH9UKOj4iFQOb2ZpzFNiS3/NziyNTFVGAHVaUXrZW4WJSlRxVsw3nbSCxLYAxZMe
	 JVAhUjLDClAZQ==
Date: Fri, 27 Mar 2026 13:42:43 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Theodore Ts'o <tytso@mit.edu>, stable@vger.kernel.org
Subject: Re: [PATCH] lib/crypto: chacha - Zeroize permuted_state before it
 leaves scope
Message-ID: <20260327204104.GA61750@quark>
References: <20260326032920.39408-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326032920.39408-1-ebiggers@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230719-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E439934B499
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 08:29:20PM -0700, Eric Biggers wrote:
> Since the ChaCha permutation is invertible, the local variable
> 'permuted_state' is sufficient to compute the original 'state', and thus
> the key, even after the permutation has been done.
> 
> While the kernel is quite inconsistent about zeroizing secrets on the
> stack (and some prominent userspace crypto libraries don't bother at all
> since it's not guaranteed to work anyway), the kernel does try to do it
> as a best practice, especially in cases involving the RNG.
> 
> Thus, explicitly zeroize 'permuted_state' before it goes out of scope.
> 
> Fixes: c08d0e647305 ("crypto: chacha20 - Add a generic ChaCha20 stream cipher implementation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
> 
> This patch is targeting libcrypto-fixes

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=libcrypto-fixes

- Eric

