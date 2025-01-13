Return-Path: <stable+bounces-108554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 262B1A0C598
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 00:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17F7C1679C3
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 23:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E801F8F04;
	Mon, 13 Jan 2025 23:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M61Fkc6T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A054C1F941C;
	Mon, 13 Jan 2025 23:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736810752; cv=none; b=nMpmv+gl32RA2n3UoWSGCJyl5+hi+uFNHtpCF9X7KwNUPWTJQ5q80gvvD1RIeiTBYx5kbTjzynpmO125//Jh1MlVPIeL6U/ib/ZxBJdOzxvqQviLqYFOs9kndle9WzSXwbbaBa+XSh1X3623ZGcYrQs2q8ALxP9Noa4S+SdFO0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736810752; c=relaxed/simple;
	bh=xdbkNfhzVGi5t9ubBvaCKgPr96uIkFavHnkVEJt4Hro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IaY7pOKA3JLh9zsdJFSmniLSuvcmdGpZhE7aGfoLByPNabO+ffYxQHO8z2/suQGybdtgncC6yP1CsSL1XJWS4yqc8I9/8sbbAO+vlM23d5dZXRUCzxdvsMhI2lttuaC4KUxPakOUKeb3o52sPGjF5B343lNSSy77v7zGLfwvJk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M61Fkc6T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46ED4C4CED6;
	Mon, 13 Jan 2025 23:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736810752;
	bh=xdbkNfhzVGi5t9ubBvaCKgPr96uIkFavHnkVEJt4Hro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M61Fkc6To705m6TsvmDpF+ULDRihS8ld5R8AxKLBdQgXmkfaD/oIqQvR5ZjwmkUm9
	 9ZMbDwD6T9tL1O0X3xnmbhbIFkJmDqCX36qF2b7sJmV0GMgPjVm+bWZ7YvhJ+lCiPA
	 bMNmVM4TpRrEWpwaeAZYxskPsUVB3uGfieBIglNivMcfQowibTvRVE+FoYtoJWkrZf
	 2aI9O1niKw9U/dqbQMVEMQMqBSkwMMZMyiINr/zechNiWTONcCtWqavA9NV0oP46Vk
	 fPgbjMuTfBiPLvVJFOyYaeDFdA4b9NSoCEB2LwdlBja0tvxjVHisxKWAImqBKq4nz2
	 m/se6gRY7pb0w==
Date: Mon, 13 Jan 2025 17:25:51 -0600
From: Rob Herring <robh@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Saravana Kannan <saravanak@google.com>,
	Maxime Ripard <mripard@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Marc Zyngier <maz@kernel.org>,
	Andreas Herrmann <andreas.herrmann@calxeda.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Oreoluwa Babatunde <quic_obabatun@quicinc.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
Subject: Re: [PATCH v4 09/14] of: reserved-memory: Fix using wrong number of
 cells to get property 'alignment'
Message-ID: <20250113232551.GB1983895-robh@kernel.org>
References: <20250109-of_core_fix-v4-0-db8a72415b8c@quicinc.com>
 <20250109-of_core_fix-v4-9-db8a72415b8c@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250109-of_core_fix-v4-9-db8a72415b8c@quicinc.com>

On Thu, Jan 09, 2025 at 09:27:00PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> According to DT spec, size of property 'alignment' is based on parent
> node’s #size-cells property.
> 
> But __reserved_mem_alloc_size() wrongly uses @dt_root_addr_cells to get
> the property obviously.
> 
> Fix by using @dt_root_size_cells instead of @dt_root_addr_cells.

I wonder if changing this might break someone. It's been this way for 
a long time. It might be better to change the spec or just read 
'alignment' as whatever size it happens to be (len / 4). It's not really 
the kernel's job to validate the DT. We should first have some 
validation in place to *know* if there are any current .dts files that 
would break. That would probably be easier to implement in dtc than 
dtschema. Cases of #address-cells != #size-cells should be pretty rare, 
but that was the default for OpenFirmware.

As the alignment is the base address alignment, it can be argued that 
"#address-cells" makes more sense to use than "#size-cells". So maybe 
the spec was a copy-n-paste error.

> 
> Fixes: 3f0c82066448 ("drivers: of: add initialization code for dynamic reserved memory")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/of/of_reserved_mem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 45517b9e57b1add36bdf2109227ebbf7df631a66..d2753756d7c30adcbd52f57338e281c16d821488 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -409,12 +409,12 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
>  
>  	prop = of_get_flat_dt_prop(node, "alignment", &len);
>  	if (prop) {
> -		if (len != dt_root_addr_cells * sizeof(__be32)) {
> +		if (len != dt_root_size_cells * sizeof(__be32)) {
>  			pr_err("invalid alignment property in '%s' node.\n",
>  				uname);
>  			return -EINVAL;
>  		}
> -		align = dt_mem_next_cell(dt_root_addr_cells, &prop);
> +		align = dt_mem_next_cell(dt_root_size_cells, &prop);
>  	}
>  
>  	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
> 
> -- 
> 2.34.1
> 

