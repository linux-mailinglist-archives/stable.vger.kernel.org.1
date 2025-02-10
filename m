Return-Path: <stable+bounces-114688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4962EA2F3C3
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 17:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D59A3A7053
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 16:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DBA1F4625;
	Mon, 10 Feb 2025 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHOyquvK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7122D2580D6
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739205485; cv=none; b=GdEtYPPYS1SK8a8tCGJdnwzd/S8K4IqxoHgE7BNFof5nrupDwujKNKUc2UNz3eO0DHasnTzbiP9BL0vkw+JKiLh678cKLDK7FRnTMVYhO2z9VORpvP82ydnGePeT01lZTGjj6RQVkpmf4NZK4iOH76bEh/TEr+HgYPpadZy1a6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739205485; c=relaxed/simple;
	bh=CpnvGWn9LObSDvCOUkk4A82aFysg9bYSFv6Z/NeUo64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcvuFI1wX+oCOb/hltuVMrSZBcwqDySm1Lc4RtkjniNhdXonbKlT+qxSXSRWRZ8El+bxrjKuADA6PevKchD/+yK9G3fg3YRmu6PuPXD29is5HwUgnlpW58+Lah0MEhsAlYFuqcJRndE71VXo+mThRXHmB3D0Nr8VeUGwKWQJjiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHOyquvK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2189C4CED1;
	Mon, 10 Feb 2025 16:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739205485;
	bh=CpnvGWn9LObSDvCOUkk4A82aFysg9bYSFv6Z/NeUo64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UHOyquvKQYClxarZzFakPsDnC+F0MBb/5fr/Wn+7eF7S2lDuM+u4ydlKNF5TdgOy0
	 U+XvVPvixZQplNaaTABdEPS7ozNSB7HJ6sUM5M1Rw9W8Y+w7OkSx5V9NaYQLiSB8CM
	 Zf8lMAYyUib9MqYIG8D/ELNz8r5LLc9ADEU6MsgTNOE7tMOdmgfEjwA5BcVQ9M7weH
	 IR2jtRrfx/5cON+7TUd/xyiYX0DstWQlO/4aPonGpgjLPOwehplGh3dOXJIzgcTrHX
	 HPfSoHKo4W9z7fxzhcILyB40I43iiOqWAjCo8m2SeSUleHNtu5Ew8H8Es6gXLGIaXL
	 /IuUTCcsW46Hg==
Date: Mon, 10 Feb 2025 16:37:59 +0000
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
	catalin.marinas@arm.com, eauger@redhat.com, eric.auger@redhat.com,
	fweimer@redhat.com, jeremy.linton@arm.com, maz@kernel.org,
	oliver.upton@linux.dev, pbonzini@redhat.com, stable@vger.kernel.org,
	tabba@google.com, wilco.dijkstra@arm.com
Subject: Re: [PATCH v2 6/8] KVM: arm64: Refactor exit handlers
Message-ID: <20250210163758.GG7568@willie-the-truck>
References: <20250206141102.954688-1-mark.rutland@arm.com>
 <20250206141102.954688-7-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206141102.954688-7-mark.rutland@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Feb 06, 2025 at 02:11:00PM +0000, Mark Rutland wrote:
> The hyp exit handling logic is largely shared between VHE and nVHE/hVHE,
> with common logic in arch/arm64/kvm/hyp/include/hyp/switch.h. The code
> in the header depends on function definitions provided by
> arch/arm64/kvm/hyp/vhe/switch.c and arch/arm64/kvm/hyp/nvhe/switch.c
> when they include the header.
> 
> This is an unusual header dependency, and prevents the use of
> arch/arm64/kvm/hyp/include/hyp/switch.h in other files as this would
> result in compiler warnings regarding missing definitions, e.g.
> 
> | In file included from arch/arm64/kvm/hyp/nvhe/hyp-main.c:8:
> | ./arch/arm64/kvm/hyp/include/hyp/switch.h:733:31: warning: 'kvm_get_exit_handler_array' used but never defined
> |   733 | static const exit_handler_fn *kvm_get_exit_handler_array(struct kvm_vcpu *vcpu);
> |       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~
> | ./arch/arm64/kvm/hyp/include/hyp/switch.h:735:13: warning: 'early_exit_filter' used but never defined
> |   735 | static void early_exit_filter(struct kvm_vcpu *vcpu, u64 *exit_code);
> |       |             ^~~~~~~~~~~~~~~~~
> 
> Refactor the logic such that the header doesn't depend on anything from
> the C files. There should be no functional change as a result of this
> patch.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Fuad Tabba <tabba@google.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Oliver Upton <oliver.upton@linux.dev>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/kvm/hyp/include/hyp/switch.h | 30 +++++--------------------
>  arch/arm64/kvm/hyp/nvhe/switch.c        | 30 ++++++++++++++-----------
>  arch/arm64/kvm/hyp/vhe/switch.c         |  9 ++++----
>  3 files changed, 27 insertions(+), 42 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will

