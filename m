Return-Path: <stable+bounces-200209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49861CA98C6
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 23:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B6143058460
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 22:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4182DE1E6;
	Fri,  5 Dec 2025 22:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z643k2Yg"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9060296BDE
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 22:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764975235; cv=none; b=leq6WKhbeoKyRebZ5WuA8AJYbdRgTDKLffBmyEtctLkKXLdlTfe8rHAD1Us2zfTXxQuO/IH42ONnpQ1Xkc83478T/Jt7FGfLl16vBP3j3YrJk6VHOs7qsOQJV3zUAgfTn5Mv7tlx2HrETvPu0fG9iCwyQrdvc52e5uCH1KjgjKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764975235; c=relaxed/simple;
	bh=a83ACYj0G6I1Rz4DZzhr9hUJgI+DUEO8CweOmZiI6iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thTCAd5IOPhOE+Lz2wZSWjrMxDDNQfO4vLHpf0HAQY1Eksf8L2YUvf6WQFQnu7j31Wj9q3UyyyPFKuPRl2ErSUAC2SLya5J/IILL07FX9IEGDm6jcu7n1m9MK2Q7IhVoSBRrKrU6Qx7L80aodzVKzz3o+jGEXkN3y9/D5O3j2UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z643k2Yg; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3f53ec0af62so256377fac.1
        for <stable@vger.kernel.org>; Fri, 05 Dec 2025 14:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764975233; x=1765580033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kxdaj8XvuPU7tC1NYzWDQ//BWgRc9lqBUZULAQw0owM=;
        b=Z643k2Ygn203CyLl+5O10JFBD3RDR+byFeYf6Yblt8B+X2PCeorpM7CJ/uAWal/DiP
         ZaWMSANb+I13jgWd+PdklbsUguuVzRrMltfWKmkRXCi0AUJF6z3/s31/LgeQhcCIGBVS
         Uk5D+DmNfT+KGnE9U/jK5eyhxBPbcWrbqxt2O7F5Rvca0ZVPEc24i7wXh0HTL4PLTx2H
         4oAJDUotk+uCJ5LhjMh86hQQtr8RIpH48iaNUno/ijaLSsj8UxfsAa5/KjoYXM681eFc
         nAuWfPhrgXtrR7mI149IVFvzR80dritDZxDK0qezDmNCbxoYFDvK5dULG7quR0nFZuzX
         GllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764975233; x=1765580033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kxdaj8XvuPU7tC1NYzWDQ//BWgRc9lqBUZULAQw0owM=;
        b=YvkbSvU8CcNTDBp8+oKNmPDll/OKqMj/U6AHRwxCbGupzCG/bpCdxDq9ITnP17k1SA
         LYPEPwvnLVwBWdipnQUobJwjEk4nJSZb+qJ+tBgK5zEz/pkhCGOgkfbnO7HWWZYcG+S/
         rltW6FJEZKRpW3XEBx4i75X8YaYfPEnmz6MOzIVRsxKTBAIuYhG8YOSh8tQf2JSXBgny
         9+iW9CTfZ7clMTue1x9D2F+QtjzEdIGAoxb9BePPdyUjNEmtEtFgW0/nOtp/5n8fM82Y
         fG9kg3pg5kb6T5sjuNEw9UMVQPlhKKMiP/mt2aQ7yARVl5lRSnVisaT6FC73LHMdqH2H
         86DQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2DfntPamHbyQBZrIhbHae1gqDYdbvl0diKQ+A8g5TMY34L6LH+Q5Oxc9MgHeN8wwGg5uXogA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc2XytZHgxSDPvRaZRvSDte3D1TjPw0NUsf0K+6N7Bij+biEJq
	++aS62vvQ8p1X3knElUwnJF/RtGsnJnM35dgoM/qO6e716aXVf/Y6nPtKpVv/Ok8pw==
X-Gm-Gg: ASbGnctVHBV0tIB+engOo/GyaqPuMYC1lRaHHwoGoxellWbxPScavh7Iz0vEtLSH+tN
	H407aQlL82R++t57VtRF35s91/zFZCEO32JvFhNRPMIZc/H+N26oBLOqHj4Fdu7zFgVxuxWCM0K
	nTsnpFclQAfft9SHIFP0E0uX2shQlXgzi89gnOfLzzxir+DF3Yom3LV38EEAQSqvFtVIQSitS1P
	0jf5xk/JPqthupawCTWIRD8GfH4rGYgWyc+kEDwP/jc/DaLI4G4lrPxJvRmXq1kIqQiDcGNJr33
	9jhga64zHXwT9+ozd84IpM5/in3669zK+baKj8fNQ4f7qB/P9tdjEj2Po0mJ6oQIGibjepEQO70
	BmYx9Zso9exlmUKHtYzXS+Xx7GEaQbeP0XPCJoshyifspvl8yl1jEQ4DN473WLZLSLQU40wLE2/
	cVSQQq18hUAaz1Cq9pD+CViDKOSRc+r9CjUJ04xBva1qjAUC1sV6ragY+G
X-Google-Smtp-Source: AGHT+IHFhRnliDQG56ynaPUfrvYkb15pzZZPHThQqlHTj/wS5YVOBzORn8GShCTA0dGK9AIk0FRxfQ==
X-Received: by 2002:a05:6820:81c9:b0:659:9a49:8dde with SMTP id 006d021491bc7-6599a8ea4b3mr367263eaf.32.1764975232750;
        Fri, 05 Dec 2025 14:53:52 -0800 (PST)
Received: from google.com (122.130.171.34.bc.googleusercontent.com. [34.171.130.122])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f50aa9675fsm4497431fac.6.2025.12.05.14.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 14:53:52 -0800 (PST)
Date: Fri, 5 Dec 2025 14:53:49 -0800
From: Justin Stitt <justinstitt@google.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Will Deacon <will@kernel.org>, 
	Christopher Covington <cov@codeaurora.org>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y RESEND] KVM: arm64: silence
 -Wuninitialized-const-pointer warning
Message-ID: <hafkvcj6frhjrzqotsdwws2buy7c6tfwjt5kkjkjc2emuxud7n@cv5vp4ftwvdv>
References: <20251204-b4-clidr-unint-const-ptr-v1-1-95161315ad92@google.com>
 <2lse2swdqrovimdsakgtriadki2fsvikhuetjzxztoui5hpsai@6mmc64ugt22k>
 <20251205002245.GA3463270@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205002245.GA3463270@ax162>

Hi,

On Thu, Dec 04, 2025 at 05:22:45PM -0700, Nathan Chancellor wrote:
> On Thu, Dec 04, 2025 at 12:53:58PM -0800, Justin Stitt wrote:
> > Quick correction:
> > 
> > On Thu, Dec 04, 2025 at 12:50:11PM -0800, Justin Stitt wrote:
> > > A new warning in Clang 22 [1] complains that @clidr passed to
> > > get_clidr_el1() is an uninitialized const pointer. get_clidr_el1()
> > > doesn't really care since it casts away the const-ness anyways.
> > > 
> > > Silence the warning by initializing the struct.
> > > 
> > > This patch won't apply to anything past v6.1 as this code section was
> > > reworked in Commit 7af0c2534f4c ("KVM: arm64: Normalize cache
> > > configuration"). There is no upstream equivalent so this patch only
> > > needs to be applied (stable only) to 6.1.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Fixes: 7c8c5e6a9101e ("arm64: KVM: system register handling")
> > > Link: https://github.com/llvm/llvm-project/commit/00dacf8c22f065cb52efb14cd091d441f19b319e [1]
> > > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > > ---
> > > Resending this with Nathan's RB tag, an updated commit log and better
> > > recipients from checkpatch.pl.
> > 
> > My usage of $ b4 trailers must've not been correct because this 6.1
> > version didn't pick up Nathan's RB tag. Whoops! Hopefully whoever picks
> > this up can add that for me :)
> 
> Looks like you resent the first iteration of this change [1] instead of
> the second [2], hence why 'b4 trailers -u' did not work, since I never
> reviewed the first iteration after Marc rejected it :)
> 
> Your 5.15 resend looks correct though.
> 
> [1]: https://lore.kernel.org/20250724-b4-clidr-unint-const-ptr-v1-1-67c4d620b6b6@google.com/
> [2]: https://lore.kernel.org/20250728-stable-disable-unit-ptr-warn-v1-1-958be9b66520@google.com/

Thanks for spotting this, I got lost in my b4 branches. I've sent the v2
resend [1]. Hopefully all is good there :)

> 
> Cheers,
> Nathan

[1]: https://lore.kernel.org/r/20251205-stable-disable-unit-ptr-warn-v2-1-cec53a8f736b@google.com

Justin

