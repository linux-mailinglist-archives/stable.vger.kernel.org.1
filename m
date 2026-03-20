Return-Path: <stable+bounces-227524-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDrSLM8wvWmI7QIAu9opvQ
	(envelope-from <stable+bounces-227524-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 12:34:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFA92D9A66
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 12:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9BA4330059AC
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 11:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38515390CB6;
	Fri, 20 Mar 2026 11:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hoJHZyNH"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7245A36AB7B;
	Fri, 20 Mar 2026 11:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774006475; cv=none; b=Rh69pMP5W/4vO7LahoNDLnzySgIIeEPXKJ7fdUAIShrQY1k0FPjLrDHmQPzgwuDMCJCUTP2jhhcjJdCEci8fXtRWArwONPewkZuORx7gdpL5Bh0PpnZum3BSIAef4NFXPU8Hy64w9AOdXH0hRKnREs08K2neaXZnP2GyobzCs2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774006475; c=relaxed/simple;
	bh=cpKrISeaEa81vfDe5seWgwqKqIsMJHuhN6Yw1HQT1tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYbbPLJJn36yPqDYU/1fDBENjYj/cJ3mwLc0LBhXIhNwmlYtYntXHuq2BSrLBy+jGUrhNEETxQCibqG+pMXUEeH7NDWhyYFRo7DvVai8osPErPkVN20a40S9sBaLK5cqJZ5aSQ2lgDM2ag7XdJWfCw8+Ksm98rj4l212uaHz0UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hoJHZyNH; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3852A40E024F;
	Fri, 20 Mar 2026 11:34:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id a8NG8j3wL-jy; Fri, 20 Mar 2026 11:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1774006468; bh=1Z/i1Kfr1XvhLZVi7iB3yONdSxIzOfrKcbNizv8Hwpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hoJHZyNHIShEl+vyzHZsZPXSo4z63Fugx2LRF4FCZqV1pDMpozjZJMvEi89ARubKP
	 +GbswhRdPlIROn+r6xSkPgNzbBm0WENQoSQC4dM+XARmn5IINVFhVL2qUbSVSoJ89T
	 F3HOwTS3oh++CRfZVe/8TuaQsIQzCF7FtYkYXZa0t9ZWYfiLkxQtCvzuZB6IIG4M4E
	 0yInpprduuQ+tdvIu6q+kvDhn7rhdm3OdaZv/SZ3PjjCvqx/Hj25/DT08b5yVQwP1c
	 R7pO2Lm/7wDLyCP0eKMblAxnahJXNHk8/DeV5JcdmvrAqtENZ0zN+A7wDmLW2hBjCD
	 k8OF9jnbZH0IvJcdyfRY0wbWDwPpH/fuRIwXB3FpU+lu8kKsbN18iW9869/ytwwt74
	 hdLb+d4FsueMwTQdJGAEgHEAtwrfOpWp5APIKngPDPoD/c8BhYOqUGm9bxFhWXOCis
	 8tY/5S/aujRbuHilxbqofVGUKep6dV94JQ4dMZLA6i2GVP0rQo53wL2ki4lrl5g7LX
	 Honp+f4sUkKDoN7bOP0PiJTVbu1utNC9xpfMJEG/6amFiGTdTSH7TRRkLA30ny3CFA
	 qPXrfFNCzUE9Nfgkpk771QdCav4Gm5fDtViifTjPPPTN79nanGEVxhYYjBjMXJZdqg
	 JoYP1kv0DqIDvBVJnPze5kgY=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id E4ADA40E01A9;
	Fri, 20 Mar 2026 11:34:18 +0000 (UTC)
Date: Fri, 20 Mar 2026 12:34:18 +0100
From: Borislav Petkov <bp@alien8.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Nikunj A Dadhania <nikunj@amd.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>, stable@vger.kernel.org,
	x86@kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] x86/cpu: Add comment clarifying CRn pinning
Message-ID: <20260320113418.GBab0wutW9JtefB667@fat_crate.local>
References: <20260318075654.1792916-3-nikunj@amd.com>
 <177385987098.1647592.3381141860481415647.tip-bot2@tip-bot2>
 <20260318204722.GD3738786@noisy.programming.kicks-ass.net>
 <20260318220939.GD3739106@noisy.programming.kicks-ass.net>
 <20260320092521.GG3739106@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260320092521.GG3739106@noisy.programming.kicks-ass.net>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[alien8.de:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227524-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5AFA92D9A66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 10:25:21AM +0100, Peter Zijlstra wrote:
> 
> Since Boris wanted a nice patch to just press 'apply' on, here goes :-)

/me presses that key!

Thanks man!

:-P

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

