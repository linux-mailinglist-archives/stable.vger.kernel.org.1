Return-Path: <stable+bounces-95858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CAE9DEF50
	for <lists+stable@lfdr.de>; Sat, 30 Nov 2024 09:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48BE2B21BC0
	for <lists+stable@lfdr.de>; Sat, 30 Nov 2024 08:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5D7146D57;
	Sat, 30 Nov 2024 08:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t/UjA+fm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41222FC52
	for <stable@vger.kernel.org>; Sat, 30 Nov 2024 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732954997; cv=none; b=nNfxAw8HrU9fPJ0l9WkYbgUcQ5s4s1edGr81R04Lk4etZWSDIEpCki4g1pZP/z7f8Y79X1hYBGaZylOKaitRrehhW2B6zn47fQh+PDyxadbtr+6dGDmnD6AkUuKQsOHFylWn3TcGIpa0iN0OO+bf4A83Vp3R85zzfSG9ehXNrw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732954997; c=relaxed/simple;
	bh=ByrR8tIF411nep0B5oVqaD2d798WvXZ1DGKPUssEvM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYjYURt0hPo8shzTmyvqGRPRTtTt1vOa27IKZt7Fo+8fQr0hFveA+Zn6Z6kfHg7DxJ2hIcVGrbT3Y3QWwHxWqSgVXKDikMORMc7sFqTq/NbfmWt6xYY43v0VQTL0n0x8LYs6hx4bY2CIyllsCiXwDaqFWPk/dZOUvZCT08FsmTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t/UjA+fm; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-724f0f6300aso2886332b3a.2
        for <stable@vger.kernel.org>; Sat, 30 Nov 2024 00:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732954995; x=1733559795; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ey9mK2QYcDtPPCKwbACtibTYlsE29O14SbX2DFECs0A=;
        b=t/UjA+fmy+MIwqa5sdxf64uRV+K4RY/hu6PCH7zEMAlm8LGXvoM4+qBoEXYVYjf8Yd
         kyFP2jNFz/mWV2LMqi6g3tROItam0PCpSxhNUyLawoNmzEtfiVRF4k0vIDhMToJug7+g
         HDILaVsF9/4HrTgFRMFraweM55a3jWSFrvWNYVYI9ZIwdttqupixF4enU2IBPJjmlhBS
         Zrzn7tuoBEuBj8oFPflLKiiMjUz/pf5yx8+v+ZVMiLT8WdREJu9LpHNaxQj0yaN3ln97
         fqLfHZgEcalNXqMlOi+kN88/2tFr2TLDGBu+U8lQAbPCnMKOkzR/k1cdvepiYwLBGHYn
         ztMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732954995; x=1733559795;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ey9mK2QYcDtPPCKwbACtibTYlsE29O14SbX2DFECs0A=;
        b=s+M2pH0GTLMZ2FAd+oSv5dWmLNo5guI5hPWn6kq4pK8D8WLE8ZafVf+UkBLwC0V+4X
         cnmJAgjlhcUEdPw9xqTNBC/BElR8gVLNA0hPT5KD+oP9lJDMw86OWhXZDeV2gChDI1bp
         Z2rr6aFqDiJrbB3tYADrRc9Cp94aOM/5ZlPbkT369UQHHXiuSIgPp0GtbcbYjuT6gWlu
         alzm7iqPBPegOZYJkPxCG6jVk3jN5oJQvb7yqFG64yGbBmU0/MhvHRTsxWiF+1NcjYrF
         euf5YFckEaQYV9DMnJDPaQTCtr05fqVlLyB8/5CmWAGb1EoLBbW0TSFpzIEkDPtyOtaQ
         DBYg==
X-Forwarded-Encrypted: i=1; AJvYcCX6ekDXPyoQd9Qi4kFifC+EQcsvr/Rzv4rINGbVA4zq6qMifIcnlBqHpRNeq4/HpCnXtmrtAkA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx49iS7Of4FCm074Wv+4v2kS7eHPWziq3yMfBRKMv0NkBqYKq7q
	TFS+gAg9tQePu16lRV0su/XYPGDMHL8YlJ3puKqIstSAvwJwetX0QL/YSec1XA==
X-Gm-Gg: ASbGncttp7FJsFc+E75EL+JEOnGi2QODfP7DqkQvLPRxkFjvWRWAhVtuWfAV1tS6Q82
	laNfDjvV6nPdYiNgbe/Ugm99EvL9jixZdgVtqq53r5N4mDA/fxze896qC64fIm9Po53onv3CBao
	z2Ea31C33GTQCQv6e/ZT/+3Lz0jsU4CsjlQrnulgoiY4OBG8oL8/ZMazR3TNhzqJwHwtuAkS9D5
	PeVJEhIkPbyI+Kn4ziViqIP4e2Rbz71FeFwIA1kL5OAlHuniQxL8zxwrFRI
X-Google-Smtp-Source: AGHT+IEevzG/vRxDLEDST9WWoqNiJfyVNndxBjogGzADGjYE/6vBufeiKYVrM7etFIzouaRIIo/thw==
X-Received: by 2002:a05:6a00:2301:b0:724:63f1:a520 with SMTP id d2e1a72fcca58-7253014a0d1mr20309929b3a.18.1732954995303;
        Sat, 30 Nov 2024 00:23:15 -0800 (PST)
Received: from thinkpad ([120.60.57.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254176121asm4686980b3a.39.2024.11.30.00.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 00:23:14 -0800 (PST)
Date: Sat, 30 Nov 2024 13:53:05 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>, stable@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 1/6] PCI: dwc: ep: iATU registers must be written
 after the BAR_MASK
Message-ID: <20241130082305.camrgbzloeev4pei@thinkpad>
References: <20241127103016.3481128-8-cassel@kernel.org>
 <20241127103016.3481128-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241127103016.3481128-9-cassel@kernel.org>

On Wed, Nov 27, 2024 at 11:30:17AM +0100, Niklas Cassel wrote:
> The DWC Databook description for the LWR_TARGET_RW and LWR_TARGET_HW fields
> in the IATU_LWR_TARGET_ADDR_OFF_INBOUND_i registers state that:
> "Field size depends on log2(BAR_MASK+1) in BAR match mode."
> 
> I.e. only the upper bits are writable, and the number of writable bits is
> dependent on the configured BAR_MASK.
> 
> If we do not write the BAR_MASK before writing the iATU registers, we are
> relying the reset value of the BAR_MASK being larger than the requested
> size of the first set_bar() call. The reset value of the BAR_MASK is SoC
> dependent.
> 
> Thus, if the first set_bar() call requests a size that is larger than the
> reset value of the BAR_MASK, the iATU will try to write to read-only bits,
> which will cause the iATU to end up redirecting to a physical address that
> is different from the address that was intended.
> 
> Thus, we should always write the iATU registers after writing the BAR_MASK.
> 
> Cc: stable@vger.kernel.org
> Fixes: f8aed6ec624f ("PCI: dwc: designware: Add EP mode support")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 28 ++++++++++---------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index f3ac7d46a855..bad588ef69a4 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -222,19 +222,10 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	if ((flags & PCI_BASE_ADDRESS_MEM_TYPE_64) && (bar & 1))
>  		return -EINVAL;
>  
> -	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
> -
> -	if (!(flags & PCI_BASE_ADDRESS_SPACE))
> -		type = PCIE_ATU_TYPE_MEM;
> -	else
> -		type = PCIE_ATU_TYPE_IO;
> -
> -	ret = dw_pcie_ep_inbound_atu(ep, func_no, type, epf_bar->phys_addr, bar);
> -	if (ret)
> -		return ret;
> -
>  	if (ep->epf_bar[bar])
> -		return 0;
> +		goto config_atu;
> +
> +	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
>  
>  	dw_pcie_dbi_ro_wr_en(pci);
>  
> @@ -246,9 +237,20 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  		dw_pcie_ep_writel_dbi(ep, func_no, reg + 4, 0);
>  	}
>  
> -	ep->epf_bar[bar] = epf_bar;
>  	dw_pcie_dbi_ro_wr_dis(pci);
>  
> +config_atu:
> +	if (!(flags & PCI_BASE_ADDRESS_SPACE))
> +		type = PCIE_ATU_TYPE_MEM;
> +	else
> +		type = PCIE_ATU_TYPE_IO;
> +
> +	ret = dw_pcie_ep_inbound_atu(ep, func_no, type, epf_bar->phys_addr, bar);
> +	if (ret)
> +		return ret;
> +
> +	ep->epf_bar[bar] = epf_bar;
> +
>  	return 0;
>  }
>  
> -- 
> 2.47.0
> 

-- 
மணிவண்ணன் சதாசிவம்

