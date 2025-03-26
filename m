Return-Path: <stable+bounces-126650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A891A70E49
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 01:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A251794C8
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 00:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7E4182BC;
	Wed, 26 Mar 2025 00:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KiNTvJ3d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7D13C1F;
	Wed, 26 Mar 2025 00:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742949983; cv=none; b=U9NPZ7pWAMYv5Y2MHD/qMMKKZKJG7YiWhK9el6mOKJMoch6PyMJTcmmuUBPDihIgOwCkEbhxcRCRXJjGKOzJJDfXRh1vjC9QZ4tAIAxnUG1HPu2Yy2X80XLLy+wPLIGGDl7ev0JvqXvq0CEQQ2l8i7sz7j+YBV+QnsWYk4CR1dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742949983; c=relaxed/simple;
	bh=brfKMtX/GkPPpztcNixu8wrkiq6lT3Mw1ZpH5gGnQiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4B54CYgSicTYC/vAKMcPPKK6yLOaCvKxvzs8ACasHkd7Cf+4xULpjo7J/tYECQZJsIfCx1qOT2rJGrRaZrt2lAqwyCtWQO66MIG1VuU0LMIxWGGWtxWBmiPPJVBacDQka1RYqLvk2mkQK7SNvE5uzNtSW1Lscfm1lge+IiElE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KiNTvJ3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72552C4CEE4;
	Wed, 26 Mar 2025 00:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742949982;
	bh=brfKMtX/GkPPpztcNixu8wrkiq6lT3Mw1ZpH5gGnQiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KiNTvJ3dz+OY8p3SvtmhqlVedDXypD9DQUpsLjjZFqiS11JRmNmi4KbAf8dOAkblw
	 4SvM6V1C8GSsemCKRLtV3tJJWuNa+6UXwYZwNoOjPKVS5vRFk6GT4g0rNaiWaHnHTn
	 SpPrs8T9gi0JYMifbR0ZdhyQP4EGmL0si8fYVYeg=
Date: Tue, 25 Mar 2025 20:45:00 -0400
From: Greg KH <gregkh@linuxfoundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sahil Gupta <s.gupta@arista.com>, stable@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Dmitry Safonov <dima@arista.com>,
	Kevin Mitchell <kevmitch@arista.com>
Subject: Re: [PATCH 6.1 6.6 6.12 6.13] scripts/sorttable: fix ELF64
 mcount_loc address parsing when compiling on 32-bit
Message-ID: <2025032554-compile-unlivable-0fb4@gregkh>
References: <CABEuK17=Y8LsLhiHXgcr7jOp2UF3YCGkQoAyQu8gTVJ5DHPN0w@mail.gmail.com>
 <20250326001122.421996-2-s.gupta@arista.com>
 <2025032553-celibacy-underpaid-faeb@gregkh>
 <20250325203236.3c6a19f4@batman.local.home>
 <20250325203723.53d3afde@batman.local.home>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325203723.53d3afde@batman.local.home>

On Tue, Mar 25, 2025 at 08:37:23PM -0400, Steven Rostedt wrote:
> On Tue, 25 Mar 2025 20:32:36 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > I guess it is loosely based on 4acda8edefa1 ("scripts/sorttable: Get
> > start/stop_mcount_loc from ELF file directly"), which may take a bit of
> > work to backport (or we just add everything that this commit depends on).
> 
> And looking at what was done, it was my rewrite of the sorttable.c code.
> 
> If it's OK to backport a rewrite, then we could just do that.
> 
> See commits:
> 
>   4f48a28b37d5 scripts/sorttable: Remove unused write functions
>   7ffc0d0819f4 scripts/sorttable: Make compare_extable() into two functions
>   157fb5b3cfd2 scripts/sorttable: Convert Elf_Ehdr to union
>   545f6cf8f4c9 scripts/sorttable: Replace Elf_Shdr Macro with a union
>   200d015e73b4 scripts/sorttable: Convert Elf_Sym MACRO over to a union
>   1dfb59a228dd scripts/sorttable: Add helper functions for Elf_Ehdr
>   67afb7f50440 scripts/sorttable: Add helper functions for Elf_Shdr
>   17bed33ac12f scripts/sorttable: Add helper functions for Elf_Sym
>   58d87678a0f4 scripts/sorttable: Move code from sorttable.h into sorttable.c

Backport away!

