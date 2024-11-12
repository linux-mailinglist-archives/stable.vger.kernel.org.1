Return-Path: <stable+bounces-92201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E36719C4F1A
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 08:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B5128486B
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 07:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B7520A5F1;
	Tue, 12 Nov 2024 07:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YcFIg7+x"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FC720512D
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 07:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731395030; cv=none; b=PHB1/nYL3gMvxaCktyo+jY+Tet8yBLMmtVCn7NA4jO3ylVqQQo9E73w769dhCYb5IjBuMX/KKiA0t71xqkY+BBnUygb+eiTAtZrSqRIwCsilGh/3xH+m9n7FYOqQKP3Yuqi5lnDKmgC3/iKdRZ73qxZfxcdx8DTPJVeT2bK6b4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731395030; c=relaxed/simple;
	bh=DvNQK6mA7Kz26h0fHHOlW7vyb83SV8fVN2+kusgRUI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAdzkZKMRGS+ns2JCWV7RUfLEYSB246dYlBbf8e2DgSmsmajYl6y5SQeLHU8SbojfmbHR0sBQsG4fRtLoanRBIKAOfpeSmuhbMqK7EzQFuSQkGfxYzELS7qAer5lgtdiKDu46gYlAJ6HY4PhJQU84ACaP9jw6pl66u/i9QY/6yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YcFIg7+x; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c805a0753so50740085ad.0
        for <stable@vger.kernel.org>; Mon, 11 Nov 2024 23:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731395028; x=1731999828; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CtXSYI1FQ4E7dsXKd94sUPPTZjQy6RVTwfrdLkSup3g=;
        b=YcFIg7+x/88AMryLD7paAhC+T4FrAi9Jw02bRgbpXkacsWyXuz4w6CnTm/7DIs/8+P
         YA1kWgcJKjW4uXC8gRO2Qe4aYpHvLs3RG/2a2d3ipsW1TEGGfODWJJ5CWNBI1EYsTQMZ
         S5odGfp4RWQBizYEpwWg4dU6jRcIe+ZCQBpHtE4P/RW0Zad9IXC3/CQhK1GignQCGTzo
         o8zatlsDZCUHXs1z7PJg1/BxZqpVej1i+f+S3VuEZj5nfMnNr9uR/AkIMTiwaOUqPfbE
         /JJbwx54YNPS97EwZgUwOwUgYTzsfwaQpoB8A5Q4fMsiL57URsx9PSOy4Ge8p8VehMb4
         OtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731395028; x=1731999828;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CtXSYI1FQ4E7dsXKd94sUPPTZjQy6RVTwfrdLkSup3g=;
        b=hDa/Zn+7I3Og2dqPR/UnJCsnsCTqAb1k0Pih3lOQM5gAoQFV4dulXoapyHZpm5G9Ey
         vzWrkDN7ASFPUXdXj0WzTKYNr2SAZ7UJBafp3TTQ15ZwKjsM2lQ3udqcv7g2iwlQneYk
         HeV5vpkLiccUWj356t47ZEiBtLrgA10OXrsPPk3FPZ+6LwsT50l/iyhz+NaU3mQ2Xi0B
         oSWU5mo1e6rtRn5CJZyjKVpdZpWVpD4pk6snwT2yTYWeFYpMSm0BGRMxskE0LEJPl9J8
         bldFQEHad5wtTRCRhiPYIbXJBE+meb2tYA9R6IgB/N37Lexjtric0V6xZJzwVimlqcdt
         6WGA==
X-Forwarded-Encrypted: i=1; AJvYcCVpYG6OUqKoGFv8mhVSOUlNfiYNE4YI8Xt5xL+0dwyQF+1E7XlLs4Ok1sDMglXP3MIWL2DCtdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeCERiEXSIXXdxjMuiON1DMQFktYGGQaEtPxzkr1su/gjAyajg
	uQpgu/M/xEfykGMziFi+3pL2/a82yr2zVrqNayXedCPLLZ9PK7iVneXeB5SrWw==
X-Google-Smtp-Source: AGHT+IEjvEHX2atHyyUImoC8uoL9LPzEKoDKdV14R1x+vxmQsk2xRS2pyeOTiOQOQGHIpy1UDCS3eA==
X-Received: by 2002:a17:902:e747:b0:20c:769b:f042 with SMTP id d9443c01a7336-21183d6717dmr212635615ad.31.1731395028416;
        Mon, 11 Nov 2024 23:03:48 -0800 (PST)
Received: from thinkpad ([117.213.103.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e58399sm86294955ad.196.2024.11.11.23.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 23:03:47 -0800 (PST)
Date: Tue, 12 Nov 2024 12:33:39 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: endpoint: Fix API pci_epc_destroy()
 releasing domain_nr ID faults
Message-ID: <20241112070339.ivgjqctoxaf2xqxr@thinkpad>
References: <20241107-epc_rfc-v2-0-da5b6a99a66f@quicinc.com>
 <20241107-epc_rfc-v2-1-da5b6a99a66f@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241107-epc_rfc-v2-1-da5b6a99a66f@quicinc.com>

On Thu, Nov 07, 2024 at 08:53:08AM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> pci_epc_destroy() invokes pci_bus_release_domain_nr() to release domain_nr
> ID, but the invocation has below 2 faults:
> 
> - The later accesses device @epc->dev which has been kfree()ed by previous
>   device_unregister(), namely, it is a UAF issue.
> 
> - The later frees the domain_nr ID into @epc->dev, but the ID is actually
>   allocated from @epc->dev.parent, so it will destroy domain_nr IDA.
> 
> Fix by freeing the ID to @epc->dev.parent before unregistering @epc->dev.
> 
> The file(s) affected are shown below since they indirectly use the API.
> drivers/pci/controller/cadence/pcie-cadence-ep.c
> drivers/pci/controller/dwc/pcie-designware-ep.c
> drivers/pci/controller/pcie-rockchip-ep.c
> drivers/pci/controller/pcie-rcar-ep.c

No need to mention the callers.

> 
> Fixes: 0328947c5032 ("PCI: endpoint: Assign PCI domain number for endpoint controllers")
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: Shawn Lin <shawn.lin@rock-chips.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: stable@vger.kernel.org
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

Good catch! (not sure how I messed up in first place).

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/endpoint/pci-epc-core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 17f007109255..bcc9bc3d6df5 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -837,11 +837,10 @@ EXPORT_SYMBOL_GPL(pci_epc_bus_master_enable_notify);
>  void pci_epc_destroy(struct pci_epc *epc)
>  {
>  	pci_ep_cfs_remove_epc_group(epc->group);
> -	device_unregister(&epc->dev);
> -
>  #ifdef CONFIG_PCI_DOMAINS_GENERIC
> -	pci_bus_release_domain_nr(&epc->dev, epc->domain_nr);
> +	pci_bus_release_domain_nr(epc->dev.parent, epc->domain_nr);
>  #endif
> +	device_unregister(&epc->dev);
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_destroy);
>  
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

