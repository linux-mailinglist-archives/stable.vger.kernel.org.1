Return-Path: <stable+bounces-196753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 075AFC81294
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 15:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 145EB4E7B48
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 14:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FD9285CB8;
	Mon, 24 Nov 2025 14:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zukuhWj0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37A226F2AD
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 14:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763995849; cv=none; b=QIpx9KAm5LjIw/1VVeffDXU9TPOBE2PBDE0JA0jvr66kOX7PewW+27PoZEBZaVQbpOmtVjWozPVBBlW9Y7BpXKTyFyLB30kEk1rlpJTdysH0ZT2Cr9KGa/AkaGlbNd0NqwfPmKC9lHviLtQtlJGlJFX4FReMPBpwSfuhm3wCYsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763995849; c=relaxed/simple;
	bh=U1DlVLfZ2HhDp+QUcAihuyMgg/P2ejCMNTUv2cC900M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCrnS6r1PGYcXRQ46RuMshdqOI67+QLnrFBcyh1vhnEEF10Kwlm34S1oGCayhovap29a3H4ebpIjwJwIJ7s1hUoNVWgthjE6bTh5JPOyCKKogN1g1B/5ZsxgXU35Ym4qtHyS0wexIi2AMfUyd+Ny7aX4VPHw3cmOKiL5jxrUTVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zukuhWj0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD5EC4CEF1;
	Mon, 24 Nov 2025 14:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763995848;
	bh=U1DlVLfZ2HhDp+QUcAihuyMgg/P2ejCMNTUv2cC900M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zukuhWj0PmF4SV8R8jeLxkhcH2kPpxyEI0Fit22+foawTYLhT7OlwxI2Wc5FIff97
	 +XBkxLZVEHWVyC/fkVN5MuOUZYZc37VvYO/nn/IBdxbR2Ad6p9tobqG5cp54SvG3oF
	 DHVxL39L24UC/uvn7Ue74yxzP+Om7aFlvsI4LnHU=
Date: Mon, 24 Nov 2025 15:50:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Sebastian Ene <sebastianene@google.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 6.6.y] KVM: arm64: Check the untrusted offset in FF-A
 memory share
Message-ID: <2025112405-campus-flatworm-25a5@gregkh>
References: <2025112429-pasture-geometry-591b@gregkh>
 <20251124141134.4098048-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124141134.4098048-1-sashal@kernel.org>

On Mon, Nov 24, 2025 at 09:11:34AM -0500, Sasha Levin wrote:
> From: Sebastian Ene <sebastianene@google.com>
> 
> [ Upstream commit 103e17aac09cdd358133f9e00998b75d6c1f1518 ]
> 
> Verify the offset to prevent OOB access in the hypervisor
> FF-A buffer in case an untrusted large enough value
> [U32_MAX - sizeof(struct ffa_composite_mem_region) + 1, U32_MAX]
> is set from the host kernel.
> 
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> Acked-by: Will Deacon <will@kernel.org>
> Link: https://patch.msgid.link/20251017075710.2605118-1-sebastianene@google.com
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/arm64/kvm/hyp/nvhe/ffa.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
> index 8d21ab904f1a9..eacf4ba1d88e9 100644
> --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> @@ -425,7 +425,7 @@ static void __do_ffa_mem_xfer(const u64 func_id,
>  	DECLARE_REG(u32, npages_mbz, ctxt, 4);
>  	struct ffa_composite_mem_region *reg;
>  	struct ffa_mem_region *buf;
> -	u32 offset, nr_ranges;
> +	u32 offset, nr_ranges, checked_offset;
>  	int ret = 0;
>  
>  	if (addr_mbz || npages_mbz || fraglen > len ||
> @@ -460,7 +460,12 @@ static void __do_ffa_mem_xfer(const u64 func_id,
>  		goto out_unlock;
>  	}
>  
> -	if (fraglen < offset + sizeof(struct ffa_composite_mem_region)) {
> +	if (check_add_overflow(offset, sizeof(struct ffa_composite_mem_region), &checked_offset)) {
> +		ret = FFA_RET_INVALID_PARAMETERS;
> +		goto out_unlock;
> +	}

I was told that a "straight" backport like this was not correct, so we
need a "better" one :(

Sebastian, can you provide the correct backport for 6.6.y please?

thanks,

greg k-h

