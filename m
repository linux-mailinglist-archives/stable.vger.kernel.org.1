Return-Path: <stable+bounces-180877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75653B8EE8A
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 06:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5046F7AA9B5
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 04:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2E02D9EFA;
	Mon, 22 Sep 2025 04:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LA1B5JnG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9AB6BB5B;
	Mon, 22 Sep 2025 04:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758514277; cv=none; b=nDwolKWcl6/Ra4F26KCGzsJklQEHj96eOkqr5a0+2NvgEK9wmZyEX0AWvOvCLG4Eydr52aON8O7nGQpVFnN3CzyLl7wWAnDXwMeiOM2mAvExeH0M0gJXvOufr5iBg2SA22hWzgQsp64E0Du2rnIuVILpj6QMbw5euCWSOvoQ5TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758514277; c=relaxed/simple;
	bh=qLe5+D3p/KCHuEXmJDeqOmQHa8PWtS/4MQOlxPYDX7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUsbag6F18MUgMQsaVindSnbweC9ylZF+r+LpsGrHLDe+ytOBJ2eZ2YQIgg7ORDEpOC5bUamSnuwBzhHpcTtQiuPQREtRPXMu2oTqgyF/NYGVfg2qxBLQshecnqn4mq0awDVz08HjAn0xQpxcRfPa1Ilm0oTcLyAhztYgvG7kb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LA1B5JnG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EED2C4CEF5;
	Mon, 22 Sep 2025 04:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758514276;
	bh=qLe5+D3p/KCHuEXmJDeqOmQHa8PWtS/4MQOlxPYDX7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LA1B5JnGwrN9VzNVeM/dbIS00PgdcxFS4733F2v2T9YlH3M5yujhhvRNDpVcR4vtz
	 yKbWstSh5+BAbFl2n4jD2hTE8bmJaYVdU7LRWUOnrgfFEmaIpsE1e6RI4gfTjGaEsc
	 85VFdX7B2MIYH4SYEs0Ivqwo+TO7+n+dR3Vl5kHTlMLcTGnaJ2EbbWAj5rw2NLFKpu
	 6r9EQIChNAGv1G7HYfGXHB53zhT6apKxF1sdDqWm0sWwBTQ3uqGB2up4ntxnaBcWDi
	 kA2g7nHKA4D5oBZSNt1ROCBEnJc5QVbhuoT5Xre+fv8cuA34uaqpAS6L1SwCv3vMae
	 WT9ve0Qz92AYg==
Date: Mon, 22 Sep 2025 09:41:10 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
	Jerome Forissier <jerome.forissier@linaro.org>,
	stable@vger.kernel.org, Masami Ichikawa <masami256@gmail.com>
Subject: Re: [PATCH] tee: fix register_shm_helper()
Message-ID: <aNDMXvTriEiSLwPb@sumit-X1>
References: <20250919124217.2934718-1-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919124217.2934718-1-jens.wiklander@linaro.org>

On Fri, Sep 19, 2025 at 02:40:16PM +0200, Jens Wiklander wrote:
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
> Fixes: 7bdee4157591 ("tee: Use iov_iter to better support shared buffer registration")
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/tee_shm.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index daf6e5cfd59a..6ed7d030f4ed 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -316,7 +316,16 @@ register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
>  
>  	len = iov_iter_extract_pages(iter, &shm->pages, LONG_MAX, num_pages, 0,
>  				     &off);
> -	if (unlikely(len <= 0)) {
> +	if (DIV_ROUND_UP(len + off, PAGE_SIZE) != num_pages) {
> +		if (len > 0) {
> +			/*
> +			 * If we only got a few pages, update to release
> +			 * the correct amount below.
> +			 */
> +			shm->num_pages = len / PAGE_SIZE;
> +			ret = ERR_PTR(-ENOMEM);
> +			goto err_put_shm_pages;
> +		}
>  		ret = len ? ERR_PTR(len) : ERR_PTR(-ENOMEM);
>  		goto err_free_shm_pages;
>  	}

Rather than operating directly on "len" without checking for error code
first doesn't seems appropriate to me. How about following diff instead?

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index daf6e5cfd59a..cb52bc51943e 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -319,6 +319,14 @@ register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
        if (unlikely(len <= 0)) {
                ret = len ? ERR_PTR(len) : ERR_PTR(-ENOMEM);
                goto err_free_shm_pages;
+       } else if (DIV_ROUND_UP(len + off, PAGE_SIZE) != num_pages) {
+               /*
+                * If we only got a few pages, update to release the correct
+                * amount below.
+                */
+               shm->num_pages = len / PAGE_SIZE;
+               ret = ERR_PTR(-ENOMEM);
+               goto err_put_shm_pages;
        }
 
        /*

-Sumit

> -- 
> 2.43.0
> 

