Return-Path: <stable+bounces-204942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F932CF5A90
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 22:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65CBC3027584
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 21:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C464301708;
	Mon,  5 Jan 2026 21:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMqnwYu3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08E23016E3
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 21:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767648339; cv=none; b=c9gz0S/68aSqqJeYX+Fzxs6x3gJ4KmgsknRQPFgTLGxutYiBnw9Gk13YEBfT7euqQuWvpCmw2zVrVDS+EVkO0+sm/ZtgDv4FGWdzfOMKKwiGzPbHz1YYepTayxoer0rY6q0RYuoIG8adiDe6WYHiJHHYVRzqYP7NM7VVRjHULjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767648339; c=relaxed/simple;
	bh=emnuWaNbQ/8r/CtexRe8ZoNLJgQGD8zcqE9kgbYDXbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEqZ5qr8r03aqsWMUaJD2mIhEbtUSBu+LiAkneHQWNpYc3F53WmSJdcVgQb3nxVYBLne2bsg0cPWsG8OEL2mqFFkDzpENtuYvQXE2WRprXudnbR67P6brfkhnkGsPuAwkJdJnuxzbg+I16oRT+EAdIhO7J2CI1WDF56M5YKGxX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMqnwYu3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F8CC116D0;
	Mon,  5 Jan 2026 21:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767648339;
	bh=emnuWaNbQ/8r/CtexRe8ZoNLJgQGD8zcqE9kgbYDXbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DMqnwYu3huICq9qp/8JaBvCQHBJWgeL+xOc0H3SsW56bt1rS9BavzrXVhL7tkllhc
	 yHpM9qcealhig6gpwQyQqQoQTHu/KcujzUdKZiwNCfYP9q4mS5xUS7n9v7oWxAjhgd
	 8CUi7aVA65YS3+9OSF5utS9vgoPkBALhMseN/QgvmMiPse/aTnhkTVyGiDHA+CG27P
	 A+O5df3wxGMoWU+So3tHJrasroflA2GlBDghfTiRZtEl6i02lBFu386w71Z4ELQbKo
	 F1aAmft3iDgjqdGiDVxg3+D89cuhemkeTxTLcUbD5QRe3ROwxUjwXYFXXPYY4x/+V+
	 owYPatY0lTPDw==
Date: Mon, 5 Jan 2026 21:25:34 +0000
From: Will Deacon <will@kernel.org>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, joro@8bytes.org
Cc: robin.murphy@arm.com, robin.clark@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org, kch@nvidia.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] iommu/io-pgtable-arm: fix size_t signedness bug in unmap
 path
Message-ID: <aVwsThVhGG-6bINs@willie-the-truck>
References: <20251219232858.51902-1-ckulkarnilinux@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219232858.51902-1-ckulkarnilinux@gmail.com>

On Fri, Dec 19, 2025 at 03:28:58PM -0800, Chaitanya Kulkarni wrote:
> __arm_lpae_unmap() returns size_t but was returning -ENOENT (negative
> error code) when encountering an unmapped PTE. Since size_t is unsigned,
> -ENOENT (typically -2) becomes a huge positive value (0xFFFFFFFFFFFFFFFE
> on 64-bit systems).
> 
> This corrupted value propagates through the call chain:
>   __arm_lpae_unmap() returns -ENOENT as size_t
>   -> arm_lpae_unmap_pages() returns it
>   -> __iommu_unmap() adds it to iova address
>   -> iommu_pgsize() triggers BUG_ON due to corrupted iova
> 
> This can cause IOVA address overflow in __iommu_unmap() loop and
> trigger BUG_ON in iommu_pgsize() from invalid address alignment.
> 
> Fix by returning 0 instead of -ENOENT. The WARN_ON already signals
> the error condition, and returning 0 (meaning "nothing unmapped")
> is the correct semantic for size_t return type. This matches the
> behavior of other io-pgtable implementations (io-pgtable-arm-v7s,
> io-pgtable-dart) which return 0 on error conditions.
> 
> Fixes: 3318f7b5cefb ("iommu/io-pgtable-arm: Add quirk to quiet WARN_ON()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
> ---
>  drivers/iommu/io-pgtable-arm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index e6626004b323..05d63fe92e43 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -637,7 +637,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>  	pte = READ_ONCE(*ptep);
>  	if (!pte) {
>  		WARN_ON(!(data->iop.cfg.quirks & IO_PGTABLE_QUIRK_NO_WARN));
> -		return -ENOENT;
> +		return 0;
>  	}
>  
>  	/* If the size matches this level, we're in the right place */

Acked-by: Will Deacon <will@kernel.org>

Joerg -- please can you pick this one up for 6.19-rc?

Cheers,

Will

