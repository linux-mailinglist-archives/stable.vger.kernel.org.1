Return-Path: <stable+bounces-155080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67993AE18B6
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 12:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB9885A5F36
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 10:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18965284B49;
	Fri, 20 Jun 2025 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bp3zl8IG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BF11CD3F;
	Fri, 20 Jun 2025 10:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750414801; cv=none; b=KrI4+DKhKiif1e8h4ggWMZarpa1PFB2EvD8NytieioQpPlAa18teMPfDWW3jWJLCaO5Anxd7+j9GDeMbuWYliuY2qb6YwOBRpDyjedWTpyJVgMx35ac+XkemQaCQw6KQ328TPz6JLTpWGj2VXO215/rXTMEW/NclW+diAPrKbcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750414801; c=relaxed/simple;
	bh=/HF0GRE0rELbF1/hXwI1CJgQW6d58fCgkOQgy8tcysM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDXi1MfEV30rKt4PaOYWt4HzAKtAhJnxAIV02uV5s5GFQCBA85+2503IJunzPrjzbP9nZoz5HS5bJ5zFyWBRAbxYC6hHPlR3Rg/TYHtc2GCShMXi4oqVnqnTVokIQvqC8KppoI8kC0V5Mh5yOaEWWuV4Zt/OCuPcs1D5xwCY9E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bp3zl8IG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614DDC4CEE3;
	Fri, 20 Jun 2025 10:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750414801;
	bh=/HF0GRE0rELbF1/hXwI1CJgQW6d58fCgkOQgy8tcysM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bp3zl8IGgdHy+QkrPJ0bBoukbp6pcSY3uLMLFAvhWpz5IFynpJV3qCIEVz43/+Oz7
	 vyZisHgNJACIAuj6JX63APq/qw9wD9pYjCrZuRRu1Rgky5HurVYfuEXEjNEGaitkGF
	 zTjANew9gor75Oa1H1rd9fCtnpFZP2u7UeQ0R+BlFw82/mCNpwSS1tHxvg8GwcjEuW
	 mPJjckcueO2PoQ+1D/jktAieqe6m+6sMgoxFMqhsnwbMEhw8YcXWW+CxdyZIIgVTUD
	 NM7aPVKlOIXkYYdxPZN6mf1iFs/3yz9LcsU2AasdRArLMipuVOnMpu2VGQxz53BBzd
	 5lNI90DD5F8eA==
Date: Fri, 20 Jun 2025 11:19:56 +0100
From: Will Deacon <will@kernel.org>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, yebin10@huawei.com,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Patch "arm64/cpuinfo: only show one cpu's info in c_show()" has
 been added to the 6.15-stable tree
Message-ID: <20250620101956.GB22514@willie-the-truck>
References: <20250620022800.2601874-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620022800.2601874-1-sashal@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Jun 19, 2025 at 10:28:00PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     arm64/cpuinfo: only show one cpu's info in c_show()
> 
> to the 6.15-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      arm64-cpuinfo-only-show-one-cpu-s-info-in-c_show.patch
> and it can be found in the queue-6.15 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

I don't think this one needs to be backported.

Will

