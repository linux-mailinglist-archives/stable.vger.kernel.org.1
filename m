Return-Path: <stable+bounces-144546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E256AB8DAE
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 19:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0323B3BADED
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 17:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FFC258CDC;
	Thu, 15 May 2025 17:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YclF0ypL"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAFE25742F;
	Thu, 15 May 2025 17:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747329865; cv=none; b=d3vYBux8/+hiJGc/bGi23vb32usmiwGhqq0hGl5XagoJNdMj8JcppPlLPMWAZjIuDvxzWNkM8qpa2F3nKiz8kf3UyZ27JtabK1zMVfQB1dkJEMecGFgB5hs0xLHxyadiWJqSge6Ecx0T9VBbDYVj7X9T3DsaC0qK1ueOeu/07wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747329865; c=relaxed/simple;
	bh=eNwAQA4z9tt/UhWr0PAxDKxPJ9Qa5LlS+FkuRrwfOW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8KhB1SPKa07TKRHnN2XmjItMrLHoLr7/F+zRx+qpLnL54HR/CB12zcjV9tVmjg5wOhlQBJJQ+SZc3lmihEsBsznI2NVsvNe1owCVv5MqQRcL9Z7M/sO4gP3Q59UbtcdQaT0Fxh+khV/VgdEHUV+xfA1lFTQ+gYi06FOO1JM8sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YclF0ypL; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0ACF640E015E;
	Thu, 15 May 2025 17:24:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aRmW3RpzN8oK; Thu, 15 May 2025 17:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1747329851; bh=vnOR8fxIQYmv1Re732NV39dffNo3/vy3eS6oQ+6mzBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YclF0ypLbGaa0NrSoiQz+Ln9euPla0VvbB9rtBzfeVEUOUGMYNpabshzKNV2P/ba+
	 xRViJdLSi9Q8EVgXsc0u5Mb48btKY3ITfn+03LCyX0gp6sZL8DMPmtfJb976QxmpbR
	 VktnF5iYqDQ97w1ysLVoxKu7dEx9VQZ8OYX0e3VJAmvopv4UA0630pP4s3v2BY+Iab
	 3pgJyQM+neW/Zn6KTcQRpEREqILh1/ZBiUqHoQJFC/9LFrbrpjBQWFn41jpyzkrpZS
	 GBZ4h9TNxa4Wt2VjzUe0d+6dPRzn4QD/EoqLg/RvZeUwF9ONN864/r+UKraFZ37/0n
	 efaTMLzXUeVe15IuB9hsPQ5mm8//Jbcyv7jDZR4bsm5i8u86MXOR6NbDdfpIk9nfo/
	 +KeI0xbj0KQabg7uha9b1ihbG7rPvFyA04YIx6wCnKtenZ1Y6F7S/1ZQYnkruXO9yx
	 WXa/JUnAkZfVTafchxEqObzoYAEGyDIfyIqOFBsbMLKWFF7027pxWtar062t+X3oR9
	 ljOLO9snb6Y0sXkyDVmNyyYycCGFIgoKIL9EFU5kbomsghRhNf+rPmPIM9H0ywr0E1
	 ovGa5GqoQPEUDf8y9E/MpPAym/00t1XGJ6K9kIuINX4zPuxWv4ctz7RHsPorXFfIgr
	 yM3CZ2KB8g2n8p4YoBCKRmig=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4DE6D40E0239;
	Thu, 15 May 2025 17:24:01 +0000 (UTC)
Date: Thu, 15 May 2025 19:23:55 +0200
From: Borislav Petkov <bp@alien8.de>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Suraj Jitindar Singh <surajjs@amazon.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] x86/bugs: Don't warn when overwriting
 retbleed_return_thunk with srso_return_thunk
Message-ID: <20250515172355.GIaCYjK_fz-n71Aruz@fat_crate.local>
References: <20250514220835.370700-1-surajjs@amazon.com>
 <20250514222507.GKaCUYQ9TVadHl7zMv@fat_crate.local>
 <20250514233022.t72lijzi4ipgmmpj@desk>
 <20250515093652.GBaCW1tARiE2jkVs_d@fat_crate.local>
 <20250515170633.sn27zil2wie54yhn@desk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250515170633.sn27zil2wie54yhn@desk>

On Thu, May 15, 2025 at 10:06:33AM -0700, Pawan Gupta wrote:
> As I said above, a mitigation unintentionally make another mitigation
> ineffective.

I actually didn't need an analysis - my point is: if you're going to warn
about it, then make it big so that it gets caught.

> Yes, maybe a WARN_ON() conditional to sanity checks for retbleed/SRSO.

Yes, that.

At least.

The next step would be if this whole "let's set a thunk without overwriting
a previously set one" can be fixed differently.

For now, though, the *least* what should be done here is catch the critical
cases where a mitigation is rendered ineffective. And warning Joe Normal User
about it doesn't bring anything. We do decide for the user what is safe or
not, practically. At least this has been the strategy until now.

So the goal here should be to make Joe catch this and tell us to fix it.

Makes sense?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

