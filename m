Return-Path: <stable+bounces-108552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76964A0C57B
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 00:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD3A1886C40
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 23:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809851F9F70;
	Mon, 13 Jan 2025 23:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HegG9hO1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CBF1F9ECE;
	Mon, 13 Jan 2025 23:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736810181; cv=none; b=V9gs5EzBmyW8h5TEUSwxxYgvO8D1ODX5umEQbCcz2t9erUqKc5YG0oTyJcbKvB8jPYeQcO2KbyScORqT9TQXtC252urchFC+O0Qr+EYh4ZtO1ZzzsROw3FlPXxyF7JVWCVOmlWTQKfxlyQRICM0igGiTFqdNdlooQs1wPh9HV3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736810181; c=relaxed/simple;
	bh=dDUcFVAojLU/9heIWIOGhgjjlgFXUYHJ762B3sZtUm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WO8h2k8nMUeh9qBTyHAB3WwyAaPWK3eyR+W0I79tvZfYgtt6MOSlw+Immr2Kxe06hySKDGz/GuJKECCTFvXn7dkksXmvAkUL3LHpPsz19O5cIDYaOcR6xKkY8A3sDikPe+ytmtHeiOUHvH8eN4tN+MY0Vpeg2OpPkSPpvRoD5mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HegG9hO1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A34C4CED6;
	Mon, 13 Jan 2025 23:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736810180;
	bh=dDUcFVAojLU/9heIWIOGhgjjlgFXUYHJ762B3sZtUm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HegG9hO11Mi+Q78pqexEdq/3Xi/tNcdQ7rjYu06lA8Tk4QPXdja8Yu/r6CG+97S3V
	 vkTP2aoMPg4/4KQys8NGeI/mz7+YnDV8resLsv4HgYrUP7WhaLifajJmBpXa3F9Buk
	 AkteYXJm6t2J1O10+FQ4DxJKE9HN5I1qrW6BVOPpmcrKZ4jzI3zRkZJoHxS4quF0mi
	 CFfOOpuWzIWPislBFVc+lAdwuTgzOU2aJCi66W0EzbIz1+fLCS6pYoY6dGkTkRZrvk
	 TMw2jvI/KOpahvUwcgeFJZ2VXNmcbSEZ822qfuvpW2H0O0f6bz9OpwcVKJg7JWk4ib
	 YCOiDzlSMTk5g==
Date: Mon, 13 Jan 2025 17:16:19 -0600
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
Subject: Re: [PATCH v4 11/14] of: reserved-memory: Warn for missing static
 reserved memory regions
Message-ID: <20250113231619.GA1983895-robh@kernel.org>
References: <20250109-of_core_fix-v4-0-db8a72415b8c@quicinc.com>
 <20250109-of_core_fix-v4-11-db8a72415b8c@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109-of_core_fix-v4-11-db8a72415b8c@quicinc.com>

On Thu, Jan 09, 2025 at 09:27:02PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> For child node of /reserved-memory, its property 'reg' may contain
> multiple regions, but fdt_scan_reserved_mem_reg_nodes() only takes
> into account the first region, and miss remaining regions.
> 
> Give warning message when missing remaining regions.

Can't we just fix it to support more than 1 entry?

> 
> Fixes: 8a6e02d0c00e ("of: reserved_mem: Restructure how the reserved memory regions are processed")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/of/of_reserved_mem.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 03a8f03ed1da165d6d7bf907d931857260888225..e2da88d7706ab3c208386e29f31350178e67cd14 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -263,6 +263,11 @@ void __init fdt_scan_reserved_mem_reg_nodes(void)
>  			       uname);
>  			continue;
>  		}
> +
> +		if (len > t_len)
> +			pr_warn("%s() ignores %d regions in node '%s'\n",
> +				__func__, len / t_len - 1, uname);
> +
>  		base = dt_mem_next_cell(dt_root_addr_cells, &prop);
>  		size = dt_mem_next_cell(dt_root_size_cells, &prop);
>  
> 
> -- 
> 2.34.1
> 

