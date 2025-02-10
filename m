Return-Path: <stable+bounces-114690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 586CBA2F3C6
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 17:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9716A7A0FB0
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 16:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254C12580FF;
	Mon, 10 Feb 2025 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLQLTDiT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D900C2580D6
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 16:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739205555; cv=none; b=cjIjj5XJshh0bpHU0oZ+z9bLCx0NEP4W4W2SohkVxet9EHIIulpLospRwO3izq8icrq4+srJSvdQlBT0urRVGTPCYHd8z85c1uqdN7hszfUc4TcfvL48WzQJctmIkzzBzbvdEyvTjk/Gh17ofYjItKD3EF5DT80OfzaTWSG8E2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739205555; c=relaxed/simple;
	bh=zBjbBU1Nue8L7MN3bQCSRhEpfSUoOdHKNZD8vOvv7L0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQGxvFWZuAq1ukIq05I7Zx/MR4GRHNOwg6pSuo7wRMZvhFNh3AKoK7ZnyADdXi+6i/dQ++6dDpGeWwRsteLQmpix+ET9Swb6N6yXf3gGqLHIykHOxgCp/YXyuFwuwszcEUaPEE2cJXZX7u6x66UHrKntaTazULPCSWSEzc+8HtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLQLTDiT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7612C4CED1;
	Mon, 10 Feb 2025 16:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739205555;
	bh=zBjbBU1Nue8L7MN3bQCSRhEpfSUoOdHKNZD8vOvv7L0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XLQLTDiTeiHzk/qyhW9ivMiUSlqCTySZkOICCKSaWhRhk/kmmGWXg8JFTEs7d4Aju
	 WS7M3zfk5YmMIOPWa7jCMKa4K44ebuPyoxbcK70ZkEiOvfLilhcBXHX1WKqREYtjRw
	 G0OqQFOR+ouCc1jNrTczi5saa1gCw8NQXbHUsx6B6HBJbCDLBAjXxSizcn4zS8UZ/J
	 tyxI0/JGpmWnqB32MCnZMVKARC8YbTYrZcW7DwLXN+xMgz1ctehtFnm1weEytQXx9X
	 zGH8ucM9JCon5V8l/1ShaXqychsPmyJGFeWA5G/6Y118mZztlaof3XZQAKFiD7e5GS
	 oqVStBWrvK0CA==
Date: Mon, 10 Feb 2025 16:39:09 +0000
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
	catalin.marinas@arm.com, eauger@redhat.com, eric.auger@redhat.com,
	fweimer@redhat.com, jeremy.linton@arm.com, maz@kernel.org,
	oliver.upton@linux.dev, pbonzini@redhat.com, stable@vger.kernel.org,
	tabba@google.com, wilco.dijkstra@arm.com
Subject: Re: [PATCH v2 7/8] KVM: arm64: Mark some header functions as inline
Message-ID: <20250210163909.GH7568@willie-the-truck>
References: <20250206141102.954688-1-mark.rutland@arm.com>
 <20250206141102.954688-8-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206141102.954688-8-mark.rutland@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Feb 06, 2025 at 02:11:01PM +0000, Mark Rutland wrote:
> The shared hyp switch header has a number of static functions which
> might not be used by all files that include the header, and when unused
> they will provoke compiler warnings, e.g.
> 
> | In file included from arch/arm64/kvm/hyp/nvhe/hyp-main.c:8:
> | ./arch/arm64/kvm/hyp/include/hyp/switch.h:703:13: warning: 'kvm_hyp_handle_dabt_low' defined but not used [-Wunused-function]
> |   703 | static bool kvm_hyp_handle_dabt_low(struct kvm_vcpu *vcpu, u64 *exit_code)
> |       |             ^~~~~~~~~~~~~~~~~~~~~~~
> | ./arch/arm64/kvm/hyp/include/hyp/switch.h:682:13: warning: 'kvm_hyp_handle_cp15_32' defined but not used [-Wunused-function]
> |   682 | static bool kvm_hyp_handle_cp15_32(struct kvm_vcpu *vcpu, u64 *exit_code)
> |       |             ^~~~~~~~~~~~~~~~~~~~~~
> | ./arch/arm64/kvm/hyp/include/hyp/switch.h:662:13: warning: 'kvm_hyp_handle_sysreg' defined but not used [-Wunused-function]
> |   662 | static bool kvm_hyp_handle_sysreg(struct kvm_vcpu *vcpu, u64 *exit_code)
> |       |             ^~~~~~~~~~~~~~~~~~~~~
> | ./arch/arm64/kvm/hyp/include/hyp/switch.h:458:13: warning: 'kvm_hyp_handle_fpsimd' defined but not used [-Wunused-function]
> |   458 | static bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
> |       |             ^~~~~~~~~~~~~~~~~~~~~
> | ./arch/arm64/kvm/hyp/include/hyp/switch.h:329:13: warning: 'kvm_hyp_handle_mops' defined but not used [-Wunused-function]
> |   329 | static bool kvm_hyp_handle_mops(struct kvm_vcpu *vcpu, u64 *exit_code)
> |       |             ^~~~~~~~~~~~~~~~~~~
> 
> Mark these functions as 'inline' to suppress this warning. This
> shouldn't result in any functional change.
> 
> At the same time, avoid the use of __alias() in the header and alias
> kvm_hyp_handle_iabt_low() and kvm_hyp_handle_watchpt_low() to
> kvm_hyp_handle_memory_fault() using CPP, matching the style in the rest
> of the kernel. For consistency, kvm_hyp_handle_memory_fault() is also
> marked as 'inline'.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Fuad Tabba <tabba@google.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Oliver Upton <oliver.upton@linux.dev>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/kvm/hyp/include/hyp/switch.h | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will

