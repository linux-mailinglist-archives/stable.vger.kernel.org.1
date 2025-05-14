Return-Path: <stable+bounces-144454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DB0AB7906
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 00:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B01EE7B1A30
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 22:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FC4221F35;
	Wed, 14 May 2025 22:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Y+CXRrsD"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CF91EA7D6;
	Wed, 14 May 2025 22:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747261535; cv=none; b=X5mYWK6RYXDieuG4OQ8hgV5gYPyDHn1MnoP+D755UxrJRNzLP5NZLshAezDMoauBYO0CLGHtZCsn3rEj/ax1gLTU+dvkXXzm0b2Lhdo5lhLgUYKgvtG7dWceBC4d4aOj6f0CzNfp/d2wMtp5jbFJbfgDQW4b/jJWgFggBlrW0ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747261535; c=relaxed/simple;
	bh=kt76mW7EYpSqm4dp8S9Ts3jRLpbzTTIf4rdn4dOuRC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8eh9sEjEYpygs/MVbDC/mrbXP9Xw2M60h5lS0tZnl2RBXCtiuhhaB6iMq/6YfW2n6/ldIcxDmGaMK+l2+enwBeDjYP2UStyI7Tqk95MYn58wgRUXOM5I7CdfJBx/wWmc2/awjB0+ut+3uLf9EzK1SFhl9W8NicGq/jU4v7DIWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Y+CXRrsD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9E06A40E01FA;
	Wed, 14 May 2025 22:25:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4vk0dmle8tFN; Wed, 14 May 2025 22:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1747261523; bh=3GO3lxo4ve1H+NZkEhr/MG/9q7gpIWMyeb/o2QdI5LE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y+CXRrsDn0BX5+9rVv3rvbC/CowGAJPGSGof4vEUoXLo5GHosUuviTEJyaclitBb8
	 oQPM8hyuLEhWaA78anc3PEpG+EBxAR8r53OWavJ0oyVSl6F2uxxkKPwsaYnd+60Tqm
	 qkV0eES0Ec2ansXbvX4C/XBCrIqfoAEytKZ4SsNG4RpK3BWZmG4FXJtU1cfS0fiF6F
	 VMKjah7ZyhAt6l9eNiKk63Lk97dwpcox3YpBtcqNjl26ink57Q7nUDtR9Q7qkmP+AX
	 qNcqwUH8IRUbUDp2QKXkHKr4dLJ1lw7on0JR/2o4xLiYYUuba0ck589/7UOSGWorRG
	 MvLnt7Wpwhkqf1cCSMBS2Z+mx2Jbhj8Qy6de8b3gB8jrYMCa9faXpOJEPsufoEFNq9
	 BltQHF5dRaK9i9mRabH36mAAw6QRU1spH1ei/zGBzXic6ryTGF+/1ZdDn/slpr7HM1
	 9XJ+2pddV/tctdNGWQvqy7ZbEeyWvWuTsJIXQ9gzKF2Jq+7X6psfWRcGO/rMuwH87x
	 tC21Z1QoynriMYNLMvz4ioeMGSiFWGkw8SU5XwNCYfYJkf/G23LA0F42unkNovtsbY
	 UJVssPOihlasjQG5tN0hCjsZdTvIbMHHyDP1LU5HE+JGF9Ac3WcA4kdJRKNsSCFuF5
	 vq2CJW6it77rS98QnOvQPxuE=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 909C040E01ED;
	Wed, 14 May 2025 22:25:13 +0000 (UTC)
Date: Thu, 15 May 2025 00:25:07 +0200
From: Borislav Petkov <bp@alien8.de>
To: Suraj Jitindar Singh <surajjs@amazon.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] x86/bugs: Don't warn when overwriting
 retbleed_return_thunk with srso_return_thunk
Message-ID: <20250514222507.GKaCUYQ9TVadHl7zMv@fat_crate.local>
References: <20250514220835.370700-1-surajjs@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250514220835.370700-1-surajjs@amazon.com>

On Wed, May 14, 2025 at 03:08:35PM -0700, Suraj Jitindar Singh wrote:
> -	if (x86_return_thunk != __x86_return_thunk)
> +	/*
> +	 * There can only be one return thunk enabled at a time, so issue a
> +	 * warning when overwriting it. retbleed_return_thunk is a special case
> +	 * which is safe to be overwritten with srso_return_thunk since it
> +	 * provides a superset of the functionality and is handled correctly in
> +	 * entry_untrain_ret().
> +	 */
> +	if ((x86_return_thunk != __x86_return_thunk) &&
> +	    (thunk != srso_return_thunk ||
> +	     x86_return_thunk != retbleed_return_thunk))

Instead of making this an unreadable conditional, why don't we ...

>  		pr_warn("x86/bugs: return thunk changed\n");

... turn this into a

	pr_info("set return thunk to: %ps\n", ...)

and simply say which thunk was set?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

