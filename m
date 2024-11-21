Return-Path: <stable+bounces-94556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5389D5500
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 22:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DAD6B21E1F
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 21:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B951B86CF;
	Thu, 21 Nov 2024 21:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTuhQYDw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8963E83CDA;
	Thu, 21 Nov 2024 21:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732225714; cv=none; b=dLBKAvwuAJJ9RvMv9p6DN/o4ew4+/g6b1Ozc0b0uAKil+p7SgGRG6sgJfI2Wjs1JBdxeVoGgVmnyAK3eW2EH9I8neIdcF9UWemlrrk8dRHfmuiG2JPzez3mJJgER+TUF7C5EZxnmriBoKyibg2bvsj57H1Ro/SYIjR+d5sdjzU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732225714; c=relaxed/simple;
	bh=sUlBre1omzYxfJz9R6ez1ZUiGw1UMxiKfCYx+xMel6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvuLE0WtbxmJzWHRPJCNDVeYoteMW8oJ7wyTzuYSjvkOziuP5QaeefCHvwwuLp3nCIYm0x4Py5Xtfwg/Qp+nroJe2S0GX1tDdACwwsgWXLrtl41eDY1viCz86vIDL7yfXddRupnYdpy/nvmscify0C2adoyqS0XV9qpFW9Y0p2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTuhQYDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75B4C4CECC;
	Thu, 21 Nov 2024 21:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732225714;
	bh=sUlBre1omzYxfJz9R6ez1ZUiGw1UMxiKfCYx+xMel6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YTuhQYDwHkLtUBM7Sfpra2vWH6aTqPCpalB/nVeGU+tRJRft4nLYVdMiL/CRd5+b+
	 zPce61w9dMMDK3cjv5Kw0mW/NWGDWHsxfV7d00EsOLx0N/qvTQeIQHIYZjmNPZEDXZ
	 DmSrN0sttZ1skvk8LkcMJKoi6C4tE75fIG6PcFudx7Kh47y4+EvZ19XifNLFRZPP+b
	 c1q4jzkYsqcbHD/XtVQP8d5IQO7HCzO6LOf0W6LEKVKl2SOP8xTnCCc+65uWhe964K
	 V0a1xS8uWWuPf4SbhzOI9ev6XhXPEoNfn/RTN2jhskMVw5tOIyxg09Uzg0B6qE8N9W
	 Er+kDwpDCiyLA==
Date: Thu, 21 Nov 2024 15:48:32 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: stable@vger.kernel.org, Saravana Kannan <saravanak@google.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thierry Reding <treding@nvidia.com>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2] of: property: fw_devlink: Do not use interrupt-parent
 directly
Message-ID: <173222571046.3843916.9274020402675483469.robh@kernel.org>
References: <20241120233124.3649382-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120233124.3649382-1-samuel.holland@sifive.com>


On Wed, 20 Nov 2024 15:31:16 -0800, Samuel Holland wrote:
> commit 7f00be96f125 ("of: property: Add device link support for
> interrupt-parent, dmas and -gpio(s)") started adding device links for
> the interrupt-parent property. commit 4104ca776ba3 ("of: property: Add
> fw_devlink support for interrupts") and commit f265f06af194 ("of:
> property: Fix fw_devlink handling of interrupts/interrupts-extended")
> later added full support for parsing the interrupts and
> interrupts-extended properties, which includes looking up the node of
> the parent domain. This made the handler for the interrupt-parent
> property redundant.
> 
> In fact, creating device links based solely on interrupt-parent is
> problematic, because it can create spurious cycles. A node may have
> this property without itself being an interrupt controller or consumer.
> For example, this property is often present in the root node or a /soc
> bus node to set the default interrupt parent for child nodes. However,
> it is incorrect for the bus to depend on the interrupt controller, as
> some of the bus's children may not be interrupt consumers at all or may
> have a different interrupt parent.
> 
> Resolving these spurious dependency cycles can cause an incorrect probe
> order for interrupt controller drivers. This was observed on a RISC-V
> system with both an APLIC and IMSIC under /soc, where interrupt-parent
> in /soc points to the APLIC, and the APLIC msi-parent points to the
> IMSIC. fw_devlink found three dependency cycles and attempted to probe
> the APLIC before the IMSIC. After applying this patch, there were no
> dependency cycles and the probe order was correct.
> 
> Acked-by: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org
> Fixes: 4104ca776ba3 ("of: property: Add fw_devlink support for interrupts")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> 
> Changes in v2:
>  - Fix typo in commit message
>  - Add Fixes: tag and CC stable
> 
>  drivers/of/property.c | 2 --
>  1 file changed, 2 deletions(-)
> 

Applied, thanks!


