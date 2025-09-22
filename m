Return-Path: <stable+bounces-180906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97518B8FA6C
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 10:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F17916D5F9
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 08:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCD2280033;
	Mon, 22 Sep 2025 08:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AU/P3ygy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A77923B616;
	Mon, 22 Sep 2025 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758531022; cv=none; b=DyCfSZY8hqYhjwOTXlPu2bki+OYpj1OKxAiUFZn2i8Zaq3if2KdkPOlVoeq6gLnnEsgfI/2TLqM/gu5sdnTtb7LQLDEpEikR4w9f7F3eAE/GKg0V0thUo6J97viIHa6v8ZM0uxFi8C0OggxnkFmmsCjqWvxkX9pAkGnKXbfYZlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758531022; c=relaxed/simple;
	bh=3LiBLlWVvFCy5klUJ+cPajsUi3HC6fr8Tl8FH/qHaac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soCTwNeGKO8qSeKNmTQdANF7c94WnAeJWFpvS193+uvD0V6cST6rr9MKeCcdePx2M0I8CTYmmc6Bvj2tcA+u22f2ao1eOh0zmu0JvmccnCHjiJbjT4lt1Pzs1A+KBbira9lOrY4mQteLdqbsBSpxGe+k8848UEN9Ygzdf2sOlJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AU/P3ygy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60413C4CEF0;
	Mon, 22 Sep 2025 08:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758531021;
	bh=3LiBLlWVvFCy5klUJ+cPajsUi3HC6fr8Tl8FH/qHaac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AU/P3ygynrdzgQwEX0PEavE51C9fuBWO2Z2T34OfzDhViNrVpPkVKiJCcFrsmoZb6
	 WKe+JcFsQmuTBB2sipJv74gQx1OqwjkdAPYMAzG3+YAH9hkxYu8wDzWkqc88Xgxnag
	 TVE8lRIwlu1OGdCS94LRtWC8B8aJconfMJIzGxnS+DO8S5PV9BEzlBbmsc0jsHcPcc
	 rNoPyS4BRUMZvkQp6LeUDncUpxbqtnSK53uI/86l9Hw4TMmlajXndgU1SDYhnk5HKH
	 Sl46Ms4slzsouDHcjFTioWHFiyp43wUka3CO0IlGRMTtMtbdOrEgUrxJ16Z1QWYf/M
	 5Q9xLtlBObZeA==
Date: Mon, 22 Sep 2025 14:20:14 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
	Jerome Forissier <jerome.forissier@linaro.org>,
	stable@vger.kernel.org, Masami Ichikawa <masami256@gmail.com>
Subject: Re: [PATCH v2] tee: fix register_shm_helper()
Message-ID: <aNENxpvdpW7ItjgT@sumit-X1>
References: <20250922083211.3341508-2-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922083211.3341508-2-jens.wiklander@linaro.org>

On Mon, Sep 22, 2025 at 10:31:58AM +0200, Jens Wiklander wrote:
> In register_shm_helper(), fix incorrect error handling for a call to
> iov_iter_extract_pages(). A case is missing for when
> iov_iter_extract_pages() only got some pages and return a number larger
> than 0, but not the requested amount.
> 
> This fixes a possible NULL pointer dereference following a bad input from
> ioctl(TEE_IOC_SHM_REGISTER) where parts of the buffer isn't mapped.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Masami Ichikawa <masami256@gmail.com>
> Closes: https://lore.kernel.org/op-tee/CACOXgS-Bo2W72Nj1_44c7bntyNYOavnTjJAvUbEiQfq=u9W+-g@mail.gmail.com/
> Tested-by: Masami Ichikawa <masami256@gmail.com>
> Fixes: 7bdee4157591 ("tee: Use iov_iter to better support shared buffer registration")
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
> Changes from v1
> - Refactor the if statement as requested by Sumit
> - Adding Tested-by: Masami Ichikawa <masami256@gmail.com
> - Link to v1:
>   https://lore.kernel.org/op-tee/20250919124217.2934718-1-jens.wiklander@linaro.org/
> ---
>  drivers/tee/tee_shm.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index daf6e5cfd59a..76c54e1dc98c 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -319,6 +319,14 @@ register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
>  	if (unlikely(len <= 0)) {
>  		ret = len ? ERR_PTR(len) : ERR_PTR(-ENOMEM);
>  		goto err_free_shm_pages;
> +	} else if (DIV_ROUND_UP(len + off, PAGE_SIZE) != num_pages) {
> +		/*
> +		 * If we only got a few pages, update to release the
> +		 * correct amount below.
> +		 */
> +		shm->num_pages = len / PAGE_SIZE;
> +		ret = ERR_PTR(-ENOMEM);
> +		goto err_put_shm_pages;
>  	}
>  
>  	/*
> -- 
> 2.43.0
> 

