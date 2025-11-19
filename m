Return-Path: <stable+bounces-195153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28063C6D0FF
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 08:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9F77E34D251
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 07:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EC72EA730;
	Wed, 19 Nov 2025 07:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhzsuhQd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0AC2673B7;
	Wed, 19 Nov 2025 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763536506; cv=none; b=dlnanoZvEKZqJz5U2JPqgsDLRV3+notXORcaDZFXFcg7Oi9NGyLcu04K2f0t6K9HDvRrhYED9jnynuoUHGye+E8K1Kv02fzqfFHjTB8T96D9UTLDvvruQR3ZfFMV44lg5JN42gjoDJEMXmFeVqOTYcZGPKk8oWfihLq6JzXYPEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763536506; c=relaxed/simple;
	bh=85Q1fxYUc90RG8bi1kmn3NZavgBysfdLuTimKjiXkxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6cZUhG4mGfwkIp5GUmBv0QdPRsA3KGyLdAisjS9unTErSpHsvhOvu350SMY2oXmmcreFbEcd2nfe22vrDE908mCb3a7zjA8pbc7Uk6yc/lU90yT2uHaHRH3820biwVptFV3HglLBJQnUq9R8fqBKdp7Ny0VV3BeF6aypLk4SBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhzsuhQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1EE0C116D0;
	Wed, 19 Nov 2025 07:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763536503;
	bh=85Q1fxYUc90RG8bi1kmn3NZavgBysfdLuTimKjiXkxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mhzsuhQdkBNdpM22TohLCYrXugC3eqDOXwXSBlT2Kqn3T0x4zqom5ZBKDLT8BMYcL
	 6YjA/CQWCkydZGaSHPQc/q+Z3Kxfy7J8YOr1WDi2DmKmY81Ci7gFp+Ft8KZecP6JY7
	 eFDAnJU4Oo0EwGBEfylOcOpNeKIF6JFIQ5ncSJO5AeU8FZEM91xrIcFatDtPT3YIRD
	 MIrDg8lEUxqdPGLROzLl62TPJ8iZkgCjN0kYBFCAL9ATf4MN0V0mOtik9ylXL0rtzO
	 GgAHV4jY8JH51UsCRL0d8teCKcEt/nhsXWQFExg19GOxd9eVcQfO2Neu/ZPkJhs/9g
	 8pnwd6obqtSzw==
Date: Wed, 19 Nov 2025 09:14:56 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add test_kho to KHO's entry
Message-ID: <aR1ucHaX8z9qV_oi@kernel.org>
References: <20251118182416.70660-1-pratyush@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118182416.70660-1-pratyush@kernel.org>

On Tue, Nov 18, 2025 at 07:24:15PM +0100, Pratyush Yadav wrote:
> Commit b753522bed0b7 ("kho: add test for kexec handover") introduced the
> KHO test but missed adding it to KHO's MAINTAINERS entry. Add it so the
> KHO maintainers can get patches for its test.
> 
> Cc: stable@vger.kernel.org
> Fixes: b753522bed0b7 ("kho: add test for kexec handover")
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 05e336174ede5..b0873f8ebcda6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13799,6 +13799,7 @@ F:	Documentation/admin-guide/mm/kho.rst
>  F:	Documentation/core-api/kho/*
>  F:	include/linux/kexec_handover.h
>  F:	kernel/liveupdate/kexec_handover*
> +F:	lib/test_kho.c
>  F:	tools/testing/selftests/kho/
>  
>  KEYS-ENCRYPTED
> -- 
> 2.47.3
> 

-- 
Sincerely yours,
Mike.

