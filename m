Return-Path: <stable+bounces-91692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDCB9BF3CD
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 17:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97CA31F21D7E
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 16:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29141205137;
	Wed,  6 Nov 2024 16:59:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A2D201115
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 16:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730912375; cv=none; b=AqXSG+pzOtbFdDqhH3RUUaXP/lI3gTMYcS/BN1XXPtHXQnGPg0eWEgZaAZoHnr9sznr5y+7nLU3dSg2iyya0GYGA8GscS9R9eVa88kNpwXm5bN539wyGXOR6ioocrPYzf8Pnqj0Pfhgs3pYazEd0idYQXIQfYemhjf2IT8ZhzRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730912375; c=relaxed/simple;
	bh=lgAjABNx/ZczbuVaLjgEkZKXFff5AIcIWX3mV1BbdWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPivHBS36DAF756EZLpUuIniWV1a/DKEDbb6+bRz0f3qyFLsw7P0XpSHaIAlBnSMm17i/wy42BVwX4SWz+jP29mayruuH7Tis7PdzVrnRqsgXSgwdnNVb9KueNdk3b570CLp1hC9AktwZzr4jrS9kFoYoyVEJU9zYaB8LK7UBjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85683C4CEC6;
	Wed,  6 Nov 2024 16:59:33 +0000 (UTC)
Date: Wed, 6 Nov 2024 16:59:31 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
	broonie@kernel.org, maz@kernel.org, stable@vger.kernel.org,
	will@kernel.org
Subject: Re: [PATCH] arm64: Kconfig: Make SME depend on BROKEN for now
Message-ID: <Zyugcxz4Uu654ZvZ@arm.com>
References: <20241106164220.2789279-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106164220.2789279-1-mark.rutland@arm.com>

On Wed, Nov 06, 2024 at 04:42:20PM +0000, Mark Rutland wrote:
> Although support for SME was merged in v5.19, we've since uncovered a
> number of issues with the implementation, including issues which might
> corrupt the FPSIMD/SVE/SME state of arbitrary tasks. While there are
> patches to address some of these issues, ongoing review has highlighted
> additional functional problems, and more time is necessary to analyse
> and fix these.
> 
> For now, mark SME as BROKEN in the hope that we can fix things properly
> in the near future. As SME is an OPTIONAL part of ARMv9.2+, and there is
> very little extant hardware, this should not adversely affect the vast
> majority of users.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: <stable@vger.kernel.org> # 5.19

I agree that's the best way forward given the proximity to final 6.12.
Let's hope we'll revert it shortly after. Thanks to both you and broonie
for continuing to dig into this.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

