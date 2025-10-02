Return-Path: <stable+bounces-183117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90247BB4B66
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 19:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386FB1897890
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 17:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98AB270572;
	Thu,  2 Oct 2025 17:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovQz0d+v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EAE236A70;
	Thu,  2 Oct 2025 17:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759426727; cv=none; b=MC/qmg5B3PY7yQyqCPwLG0Gbo+2+kk5FaWU1x5tYBq83X0fTJTCdbjHpQ+B5cAeTwHizEu7qZH24qE8wxudHMFZouHr/nQjXSDYvtYSLhPsAwMaUcsTc8qTlaedQ5MQRJk82/jRPPjevz/WsafBx8IFFsewIJ7i0IJEiPkbSZKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759426727; c=relaxed/simple;
	bh=Mlu+5jima9P9sAzzlQ8rbFcsfXSGJ6aNaRbmiA+GvVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P08xZdYxbvbGYT956/VordkiRm2Q5Qhj9F3N1EgIRvXvlCsztXMZsRLEQLicx6KlMQ7MjOzmbQKej5FpAADI8iIXOiBlQD039/994hOQoBNvppVQZ21grztYEXShBDF9pJlwvY+IMjX1bnIZu1Nzq1xrIy4dVHgYVvfL3K+h3Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovQz0d+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF0BC4CEF4;
	Thu,  2 Oct 2025 17:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759426727;
	bh=Mlu+5jima9P9sAzzlQ8rbFcsfXSGJ6aNaRbmiA+GvVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ovQz0d+vyXHa8qgRIUcDvIY773dMW0JblO2jLVGEDFqvV11ph0k1wY15GYbJ7uUZp
	 Bab/IOaFi5DK9ap1+QvaaLvpfyONA8msJmaGmSxMrQMFmwGtEfQNvYBcLegFJ1fCHh
	 498n2M8rW9qyp0zRAIvbIsiNYqm9Do/dfTBt036ZeuMDg7z+IMnwFORQY0zp2l9ih/
	 KwmFfvX5PEtDyyJ8H22MjZMdqaKzfQo7FvneLnc6mBEH5mwmpc/V9LPGii/TwtK+WJ
	 CEwPDxubOTpE8ACk+9ryCpuH9DctxwlU+Oj6zTVo6tYWc/2W6/ycqZe5konDa5FTes
	 zbfABxq3kwFhQ==
Date: Thu, 2 Oct 2025 10:37:23 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, stable@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Michael van der Westhuizen <rmikey@meta.com>,
	Tobias Fleig <tfleig@meta.com>
Subject: Re: [PATCH v2] stable: crypto: sha256 - fix crash at kexec
Message-ID: <20251002173723.GE1697@sol>
References: <20251002-stable_crash-v2-1-836adf233521@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002-stable_crash-v2-1-836adf233521@debian.org>

On Thu, Oct 02, 2025 at 04:26:20AM -0700, Breno Leitao wrote:
> Loading a large (~2.1G) files with kexec crashes the host with when
> running:
> 
>   # kexec --load kernel --initrd initrd_with_2G_or_more
> 
>   UBSAN: signed-integer-overflow in ./include/crypto/sha256_base.h:64:19
>   34152083 * 64 cannot be represented in type 'int'
>   ...
>   BUG: unable to handle page fault for address: ff9fffff83b624c0
>   sha256_update (lib/crypto/sha256.c:137)
>   crypto_sha256_update (crypto/sha256_generic.c:40)
>   kexec_calculate_store_digests (kernel/kexec_file.c:769)
>   __se_sys_kexec_file_load (kernel/kexec_file.c:397 kernel/kexec_file.c:332)
>   ...
> 
> (Line numbers based on commit da274362a7bd9 ("Linux 6.12.49")
> 
> This started happening after commit f4da7afe07523f
> ("kexec_file: increase maximum file size to 4G") that landed in v6.0,
> which increased the file size for kexec.
> 
> This is not happening upstream (v6.16+), given that `block` type was
> upgraded from "int" to "size_t" in commit 74a43a2cf5e8 ("crypto:
> lib/sha256 - Move partial block handling out")
> 
> Upgrade the block type similar to the commit above, avoiding hitting the
> overflow.
> 
> This patch is only suitable for the stable tree, and before 6.16, which
> got commit 74a43a2cf5e8 ("crypto: lib/sha256 - Move partial block
> handling out"). This is not required before f4da7afe07523f ("kexec_file:
> increase maximum file size to 4G"). In other words, this fix is required
> between versions v6.0 and v6.16.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Fixes: f4da7afe07523f ("kexec_file: increase maximum file size to 4G") # Before v6.16
> Reported-by: Michael van der Westhuizen <rmikey@meta.com>
> Reported-by: Tobias Fleig <tfleig@meta.com>
> ---
> Changes in v2:
> - s/size_t/unsigned int/ as suggested by Eric
> - Tag the commit that introduce the problem as Fixes, making backport easier.
> - Link to v1: https://lore.kernel.org/r/20251001-stable_crash-v1-1-3071c0bd795e@debian.org
> ---
>  include/crypto/sha256_base.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/crypto/sha256_base.h b/include/crypto/sha256_base.h
> index e0418818d63c8..e3e610cfe8d30 100644
> --- a/include/crypto/sha256_base.h
> +++ b/include/crypto/sha256_base.h
> @@ -44,7 +44,7 @@ static inline int lib_sha256_base_do_update(struct sha256_state *sctx,
>  	sctx->count += len;
>  
>  	if (unlikely((partial + len) >= SHA256_BLOCK_SIZE)) {
> -		int blocks;
> +		unsigned int blocks;
>  
>  		if (partial) {
>  			int p = SHA256_BLOCK_SIZE - partial;
> 
> ---
> base-commit: da274362a7bd9ab3a6e46d15945029145ebce672
> change-id: 20251001-stable_crash-f2151baf043b

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric

