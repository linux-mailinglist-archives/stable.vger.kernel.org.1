Return-Path: <stable+bounces-61872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83AE93D297
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 13:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE5C282465
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 11:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420F917A934;
	Fri, 26 Jul 2024 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VVJkwlh0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8475617A5A5
	for <stable@vger.kernel.org>; Fri, 26 Jul 2024 11:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721994980; cv=none; b=OWpp07KhyrYSQyr6kzflY4mzK7Bog8wVKoet83BRmlcMX9fvWJsyN7hJG995zEymbM0p4W6sNE4/NfkzRLO9R/l+ORCuM/g5FsghI27Xu8PbfnLrbsSOMm2E/pcnWNPM15YPCWD4Cvbo6DyEuLzaIMmnGPjmrTc7Wzqvm1CiuAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721994980; c=relaxed/simple;
	bh=U539Uq8Qs5gV5WNuvWf2uP4NoFxyJZ+3W+hmd5gZpKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZbLsnpOn6YJIwxt+9qm/JnnglxreTMk2mZloGtPL8GkXZThI6GUDEokbBp/jh+0klhwgqVxckybFiPNhPLTnvJdrIKgTuIAtCBNsMPjq7CgK6oEp9+4YhJ6aC/EF8VGFsLaoDep66IN9nFpBm00Wa5nTQSFhRpzRI+DXKyBT5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VVJkwlh0; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fd69e44596so4190625ad.1
        for <stable@vger.kernel.org>; Fri, 26 Jul 2024 04:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721994978; x=1722599778; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5y7YOEDfU4JS5fx5scmrf6hqB3/+VWCj5aY8K/rMjG8=;
        b=VVJkwlh084nD+XdVnWTV2AvVpAxMPUr3jeo6roxIRLQLXOuCdDAMjaqAT2dtZO4vvZ
         s1pco6Vf7rj9+R5UIe7Tx+3xt0dXG+vGmegieQTECnkrdyL+Q3xT9FQdTqo5lRe0j754
         sUrfTxoAPEKoMw+q02EnIyVmjgALPqpurIZjaw57ozYtXmKV9D6M87WmsJLmx0GKwWun
         bK4K/0z3gCotXSR91s9IrbO30Hg6fsQgfPYellozxXBP7mZWblDVevOsSdWFOKkdJvzJ
         BecmTw/W4AcWQiT5Ce3WUFcjgWXIwcWAPb3SeoTcycuHuj3z4X2KS/nWrGut3WcUJi+u
         XXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721994978; x=1722599778;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5y7YOEDfU4JS5fx5scmrf6hqB3/+VWCj5aY8K/rMjG8=;
        b=I/KEyNYnN8CJC5cRWH/t9dTLTWjpVK8vqgHNDHkHW/jEw1EZIF6/2ADqhdK8LMZtUl
         UJx+Vsd+R83x6ukpSC00ZKdfpp3860XC5CuPKqvzo7uNBHD8aG3zPTY++asoMw9zc9pB
         Ir2wHbPP7VP11gxjvGDjEj84Wsay4zdg/anWvXMy0/pVsg2uf3QeV/aowCMX42knHRXO
         BjR0OKjLL8cEf3rv9evwcDP8dr/YjRFX5g2chJeNir5T86cJNLXVaH+APZwymAvrraEc
         eA30dIu43KMfLWEtXkG+PqfFwv82WqrI67lxwaUuhItl5B5PUm2GO9mxj/x2F8xBPz5v
         ccqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8ynV0chkOU6TDd0/gjBInDrGghrqaiBV9LF0TjVSwczDM8NU3ibd7OleWTBDG8CVcgXK9lMOcU0M1ujmFUnXoYJTU0XdA
X-Gm-Message-State: AOJu0Yzwydw5hgmTAl7uXOW4q97fgfjtwmNZYs7TsxZZxSA+hXVGRgr4
	QeOuc0p0J6p718TkgY5r9DxEcIXw6oCqXuYUnIJ1tTAJBOmthtZnZ0bzTpveHe4ij9j5vNILPkE
	=
X-Google-Smtp-Source: AGHT+IEcrjndBXB2ZtsnkLons2ztafN8jRqGa2IoiheYYReC037fHhFd+JnG6qPN10f0KGDBK21ZYw==
X-Received: by 2002:a17:902:e550:b0:1fc:5b81:729f with SMTP id d9443c01a7336-1fdd6e89195mr109783765ad.32.1721994977780;
        Fri, 26 Jul 2024 04:56:17 -0700 (PDT)
Received: from thinkpad ([2409:40f4:201d:928a:9e8:14a5:7572:42b6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fb67e4sm30343095ad.265.2024.07.26.04.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 04:56:17 -0700 (PDT)
Date: Fri, 26 Jul 2024 17:26:09 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, vigneshr@ti.com, kishon@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
	ahalaney@redhat.com, srk@ti.com
Subject: Re: [PATCH] PCI: j721e: Set .map_irq and .swizzle_irq to NULL
Message-ID: <20240726115609.GF2628@thinkpad>
References: <20240724065048.285838-1-s-vadapalli@ti.com>
 <20240724161916.GG3349@thinkpad>
 <20240725042001.GC2317@thinkpad>
 <93e864fb-cf52-4cc0-84a0-d689dd829afb@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93e864fb-cf52-4cc0-84a0-d689dd829afb@ti.com>

On Thu, Jul 25, 2024 at 01:50:16PM +0530, Siddharth Vadapalli wrote:
> On Thu, Jul 25, 2024 at 09:50:01AM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Jul 24, 2024 at 09:49:21PM +0530, Manivannan Sadhasivam wrote:
> > > On Wed, Jul 24, 2024 at 12:20:48PM +0530, Siddharth Vadapalli wrote:
> > > > Since the configuration of Legacy Interrupts (INTx) is not supported, set
> > > > the .map_irq and .swizzle_irq callbacks to NULL. This fixes the error:
> > > >   of_irq_parse_pci: failed with rc=-22
> > > > due to the absence of Legacy Interrupts in the device-tree.
> > > > 
> > > 
> > > Do you really need to set 'swizzle_irq' to NULL? pci_assign_irq() will bail out
> > > if 'map_irq' is set to NULL.
> > > 
> > 
> > Hold on. The errono of of_irq_parse_pci() is not -ENOENT. So the INTx interrupts
> > are described in DT? Then why are they not supported?
> 
> No, the INTx interrupts are not described in the DT. It is the pcieport
> driver that is attempting to setup INTx via "of_irq_parse_and_map_pci()"
> which is the .map_irq callback. The sequence of execution leading to the
> error is as follows:
> 
> pcie_port_probe_service()
>   pci_device_probe()
>     pci_assign_irq()
>       hbrg->map_irq
>         of_pciof_irq_parse_and_map_pci()
> 	  of_irq_parse_pci()
> 	    of_irq_parse_raw()
> 	      rc = -EINVAL
> 	      ...
> 	      [DEBUG] OF: of_irq_parse_raw: ipar=/bus@100000/interrupt-controller@1800000, size=3
> 	      if (out_irq->args_count != intsize)
> 	        goto fail
> 		  return rc
> 
> The call to of_irq_parse_raw() results in the Interrupt-Parent for the
> PCIe node in the device-tree being found via of_irq_find_parent(). The
> Interrupt-Parent for the PCIe node for MSI happens to be GIC_ITS:
> msi-map = <0x0 &gic_its 0x0 0x10000>;
> and the parent of GIC_ITS is:
> gic500: interrupt-controller@1800000
> which has the following:
> #interrupt-cells = <3>;
> 
> The "size=3" portion of the DEBUG print above corresponds to the
> #interrupt-cells property above. Now, "out_irq->args_count" is set to 1
> as __assumed__ by of_irq_parse_pci() and mentioned as a comment in that
> function:
> 	/*
> 	 * Ok, we don't, time to have fun. Let's start by building up an
> 	 * interrupt spec.  we assume #interrupt-cells is 1, which is standard
> 	 * for PCI. If you do different, then don't use that routine.
> 	 */
> 
> In of_irq_parse_pci(), since the PCIe-Port driver doesn't have a
> device-tree node, the following doesn't apply:
>   dn = pci_device_to_OF_node(pdev);
> and we skip to the __assumption__ above and proceed as explained in the
> execution sequence above.
> 
> If the device-tree nodes for the INTx interrupts were present, the
> "ipar" sequence to find the interrupt parent would be skipped and we
> wouldn't end up with the -22 (-EINVAL) error code.
> 
> I hope this clarifies the relation between the -22 error code and the
> missing device-tree nodes for INTx.
> 

Thanks for explaining the logic. Still I think the logic is flawed. Because the
parent (host bridge) doesn't have 'interrupt-map', which means INTx is not
supported. But parsing one level up to the GIC node and not returning -ENOENT
doesn't make sense to me.

Rob, what is your opinion on this behavior?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

