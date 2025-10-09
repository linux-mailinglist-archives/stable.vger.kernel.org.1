Return-Path: <stable+bounces-183700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC9CBC91B6
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 14:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 061B9188826E
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 12:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA8F23E334;
	Thu,  9 Oct 2025 12:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bB95S1NX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDFFBA3F
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760014019; cv=none; b=YVRi/TGrjqjKQPFoIET4+1ouTXnCGF0uxGZY4kHrmgt9VjQ4sQn+lUDchnp1k/2QTIee+IpXlNcCZxLkHM73KWFV60FimynRm+xseRfL7NK9aDeVT7clEKY6rTi9ow2gzFtaXgCgfTPdW7L5F9dlzUJ0VA0ai1Mhbw/oPtbwqSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760014019; c=relaxed/simple;
	bh=4jXmqHuqD7VrpSNjnW3wyubD0AMbmelliRUoP8W2ZHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ee7usvXxRf3aqz1V6T4hKv30BOUyVeFdInuYlblUpSmV8aDIBlM3V0KDvXzh5/tuAVQb/FZihtPW7EZmEyl1i3f0pUBjWacHvh62tViEQLZ12bNP77lL8gsJ4qXHUaeL+VLfeQcFqJBdOEzHE8idJayUc1Mawq4yRki3mBZs+3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bB95S1NX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B24DC4CEE7;
	Thu,  9 Oct 2025 12:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760014018;
	bh=4jXmqHuqD7VrpSNjnW3wyubD0AMbmelliRUoP8W2ZHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bB95S1NXNYtZEXb62RcfqfOk5oUa8MXshB6eOozHhC1NLvG/w9X5edO+nQ9J8OI4Y
	 zTR17jTAr7lRieWK3eTc0zJeJvW8e2Y9Ao2tP9MvZehsNZ9qesjr/5LuNsEsKa46oT
	 n3mHTnEFGGiHJI+Ayna9FM5tZXt95NkTGVVH3b7Kvc2GgH7XTvjWOk4+CsTcLn6fhO
	 Zg2YzV65eXCHfLG1Mcb0BROdOaxOAC0KjoMmWkW2UiTzIu9DyzqErEE+ZV/qCBoiKa
	 lWBA8X8iGniy/UtJZHma68gMoR8CY3Zvbe5rZiiqSghTesL0gN3xH876Jab9r3b3Ip
	 /ifETLlPyZuxg==
Date: Thu, 9 Oct 2025 14:46:54 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	stable@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: pci-epf: Move DMA initialization to EPC init
 callback
Message-ID: <aOeuvipwGfwvQG_C@ryzen>
References: <20250909112121.682086-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909112121.682086-2-cassel@kernel.org>

On Tue, Sep 09, 2025 at 01:21:22PM +0200, Niklas Cassel wrote:
> From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> 
> For DMA initialization to work across all EPC drivers, the DMA
> initialization has to be done in the .init() callback.
> 
> This is because not all EPC drivers will have a refclock (which is often
> needed to access registers of a DMA controller embedded in a PCIe
> controller) at the time the .bind() callback is called.
> 
> However, all EPC drivers are guaranteed to have a refclock by the time
> the .init() callback is called.
> 
> Thus, move the DMA initialization to the .init() callback.
> 
> This change was already done for other EPF drivers in
> commit 60bd3e039aa2 ("PCI: endpoint: pci-epf-{mhi/test}: Move DMA
> initialization to EPC init callback").
> 
> Cc: stable@vger.kernel.org
> Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/nvme/target/pci-epf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
> index 2e78397a7373a..9c5b0f78ce8df 100644
> --- a/drivers/nvme/target/pci-epf.c
> +++ b/drivers/nvme/target/pci-epf.c
> @@ -2325,6 +2325,8 @@ static int nvmet_pci_epf_epc_init(struct pci_epf *epf)
>  		return ret;
>  	}
>  
> +	nvmet_pci_epf_init_dma(nvme_epf);
> +
>  	/* Set device ID, class, etc. */
>  	epf->header->vendorid = ctrl->tctrl->subsys->vendor_id;
>  	epf->header->subsys_vendor_id = ctrl->tctrl->subsys->subsys_vendor_id;
> @@ -2422,8 +2424,6 @@ static int nvmet_pci_epf_bind(struct pci_epf *epf)
>  	if (ret)
>  		return ret;
>  
> -	nvmet_pci_epf_init_dma(nvme_epf);
> -
>  	return 0;
>  }
>  
> -- 
> 2.51.0
> 
> 

Gentle ping


Kind regards,
Niklas

