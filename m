Return-Path: <stable+bounces-134581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE01AA93750
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 14:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 502457B1DDC
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 12:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967B1274FC4;
	Fri, 18 Apr 2025 12:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUMiwnUu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4B978F3B;
	Fri, 18 Apr 2025 12:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744980120; cv=none; b=XiGqBJDoj65FikcEDbASR/mOYRfAvOcbRfFaABIcx4oz+2OpK9enSJh9rjus9APSWQaXIK4ZSVqU/XakhPJXxjvUIiPAPfjfC+pAwNW7lKks7Zz3Eb5fEYPQd0XB3Uc3dOShTipwTUprJGhbCys9xghobkkJVFvMjbVBH91DN/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744980120; c=relaxed/simple;
	bh=74lG1heVu8ZQPyZ+4RI7fAOwAeW+JzuGBLrWapfasMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsZGsvaXNiEgclfExaMzwyX33E6HcWes+6X4Vu7uEPN+T/alzaEBOt8T5AaFouCt9B/5rbsnUc9GiyRCwbBamAOOEIYJEh2pT+jqavutTQo4hZs2uFGumw90Fqx6TAcXvZ8TSZyE9sH3nxj+YX7upyUQp6bvXE4Qn54ivQ/NDdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUMiwnUu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A41C4CEE2;
	Fri, 18 Apr 2025 12:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744980119;
	bh=74lG1heVu8ZQPyZ+4RI7fAOwAeW+JzuGBLrWapfasMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FUMiwnUuHH9MRj9WKAlVsN5wC0tDGqj3Ek7/D7BQDzBMGOJlVGAGeC+RZGaq7WRsd
	 NBBowfX63J+WdAruAJOgQos73kbiU0XCyors6rhQb60jTA1YqwSSICe7BCUhVvL3TM
	 ROrIYN9v+3lZtRxA/yl1ekXxF0Ne+P2TaUMeHB8dZa/ppfj+X9f38iVHqIANGCjF0Y
	 5hSJgZ0tNL1WIDuSHz0A7J6ewoFKzOnTvb6xmfeDHRLYQpZwImShQky3BzJM2P4YYa
	 olFVG+8L0ipHTbY6IPB4vMgg5MeKg8stNcEevk9kvqyNOxHOkqY9msBCnQI+JSFVvu
	 uYK9ED7HKziqw==
Date: Fri, 18 Apr 2025 14:41:25 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable <stable@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Sandipan Das <sandipan.das@amd.com>, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/cpu/amd: Fix workaround for erratum 1054
Message-ID: <aAJIdUAHfwo8d7WS@gmail.com>
References: <174495817953.31282.5641497960291856424.tip-bot2@tip-bot2>
 <20250418104013.GAaAIsDW2skB12L-nm@renoirsky.local>
 <aAJBgCjGpvyI43E3@gmail.com>
 <20250418123713.GCaAJHedTC_JWN__Td@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418123713.GCaAJHedTC_JWN__Td@fat_crate.local>


* Borislav Petkov <bp@alien8.de> wrote:

> > plus the erratum is a perf-counters information quality bug 
> > affecting what appears to be a limited number of models, with the 
> > workaround
> 
> No, the fix is needed because Zen2 and newer won't set 
> MSR_K7_HWCR_IRPERF_EN_BIT. It needs to go everywhere.

Fair enough - the current version already has Cc: stable:

  263e55949d89 x86/cpu/amd: Fix workaround for erratum 1054

  ...

  Fixes: 232afb557835 ("x86/CPU/AMD: Add X86_FEATURE_ZEN1")
  Signed-off-by: Sandipan Das <sandipan.das@amd.com>
  Signed-off-by: Ingo Molnar <mingo@kernel.org>
  Acked-by: Borislav Petkov <bp@alien8.de>
  Cc: stable@vger.kernel.org
  Link: https://lore.kernel.org/r/caa057a9d6f8ad579e2f1abaa71efbd5bd4eaf6d.1744956467.git.sandipan.das@amd.com

Thanks,

	Ingo

