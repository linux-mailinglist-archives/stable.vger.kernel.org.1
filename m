Return-Path: <stable+bounces-114693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0226A2F4BF
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 18:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F9333A3C1D
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 17:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD8D24FC1F;
	Mon, 10 Feb 2025 17:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="grmkWbwR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C1524FC16
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 17:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739207424; cv=none; b=J1Vw7ScvrCLA0Uj43GMskWgST8t/Czmlb5U3zgacO1VuIzsX0CIfbIRQHqt+f9FVHcRkISeDexn843JY76L/debI/4Qa6UkBYriDYXRv/Gq6lj4J5NjB2j+DmqGSPfg6om5zHsAbUK0+ljGvqapNfeDe6W9y9qbZ3bMetcuj9h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739207424; c=relaxed/simple;
	bh=33obMPf5mqSs6wPrXyBZW3o1+l4eJAntmMYywvCOYOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXax+gb4gczCOIxh8lbyej2mzs+7Ylc/Y3MZcQ5HjwxZWAhtppRM1T0YxUt/AL7RNA7mtgOOKQt+OnHyz5z0oznWU9RBPWBBUswZiTknjSczl8LYpG+0s8rQK/gg82CfG/XnRDBBfB4rI3UEHv7BEkvCKITtW59y0yuDBHONEsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=grmkWbwR; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f4a4fbb35so59968495ad.0
        for <stable@vger.kernel.org>; Mon, 10 Feb 2025 09:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739207422; x=1739812222; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iJBo65n/x3cGPmTDY6dfaDs6s3ZVqbAaIw7gB8ar1TU=;
        b=grmkWbwRR61jXYhgSgX08nsc1LwM5cX/vF5k1XWhZ5s1ANfFcZoZQXettLtC/eZLhb
         YbKMp/sk9BQc8hZxxK6FljCrN5O5+6yfJd9gzoDTkHQPRpNuZ9Ibs1cAuDrSI8FtHKO8
         3xGn0R13WQFkqdTSDX9y1eT2kECEG3MA7eBfhkBv6Py/7NN+iPXOBbpExw5R4pwUvQE8
         1WnNZpucv/DxGJJfJQloeL1gWNlFXTg2ZtFC1I4zvy99NNxaiTCwg5DfVz0L40/mADdo
         +sXkwBQH1U+WLTPDjuWgxTujKcvuVSvTyqp0uFuUhQKq4zGAE8cfZTGz0R8XwtdT1fvd
         b0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739207422; x=1739812222;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iJBo65n/x3cGPmTDY6dfaDs6s3ZVqbAaIw7gB8ar1TU=;
        b=oVwmTbGnKRl6oVZnmiN++i4982nhwopP5rgHxKw53x0SmWOCz5gAbEpWSefvzrUk5I
         cxkaY/oyHwOuMDNRKMmO6O8SEmdoeD+qEA2a4xb5tBPOFpZcgroB1Z97dvuifG3d6EKe
         GbE8iT0Q210fPlYyqFgR7CYSLM0xmhcHQCcVNwfv8Tg33eT8CevoMnDi8ZiQ55ZtPL0q
         xNvW9ykMQNcxgApew+y1OrmGME6ND8OpPa2isGRf4N4xcq9bF9yyH7mr+ocv/Qf/3MTf
         gk+j1p4uPVkNb2qMwoNF7Zi0tpRORQRFjZL3GoektKr2tH2LBiyAGf5m87D3pGVVkfB0
         sj+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPUpj+7J4M99/7RsN9PBAhAgDLIu2xTQcb/Y4L2w9FKYIu5xUG38BP2RonlPPsxhxyo7kwpwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtepvteE/zWD7VGx/2N55SSLDM8D3gHTQr2zT3IqxPkn+7/4W+
	eiLa49w3/T21ZNOm+M/HdEiApxl420ola5MtoG6sX+MhiLl4boBZ1LodPP8+WA==
X-Gm-Gg: ASbGncsd6CeTXsUs7mbDwtkx7teRY4tXDK/rRcfoxKsJBmEYe3Ivxg07FiPTTDmvbjC
	Amu52+vJmyL9JY5LKLHdOS1mQoQQg3TTdoG1g9tMd+Bs5DSLuu3WM28GfS3wlWA5EahkDQrzXAy
	R47NvsK+oaCNA83jspHCtkfZCq8NQj7ZItu+ErZ4KjOaJ0Qu7Br+Yt7+x+1Kymeq+oqqAVUeT+2
	BbuwKhJ7Bca47fqap4BnfwFEWkTt/bGTO8E4kwFTU7e9sXU1bdNuCJKicoxT8ZwRv0GAuBDk8qn
	qfaFw9wcByjthHjF5VsDZxS4qS1h
X-Google-Smtp-Source: AGHT+IF56qTkw7TJubOEXPIM9zfQyfQzn7+cZYQk9mn9YGpujIBnDlW/B1WsBT0lOvPG9bCSoLR7yg==
X-Received: by 2002:a17:902:e54d:b0:21f:3823:482b with SMTP id d9443c01a7336-21fb6f54a29mr1014975ad.25.1739207395874;
        Mon, 10 Feb 2025 09:09:55 -0800 (PST)
Received: from thinkpad ([220.158.156.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f365446d7sm81455805ad.82.2025.02.10.09.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 09:09:55 -0800 (PST)
Date: Mon, 10 Feb 2025 22:39:50 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Robert Marko <robimarko@gmail.com>
Subject: Re: [PATCH v2] mtd: rawnand: qcom: fix broken config in
 qcom_param_page_type_exec
Message-ID: <20250210170950.zxgm5hjeb2a4evfn@thinkpad>
References: <20250209140941.16627-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250209140941.16627-1-ansuelsmth@gmail.com>

On Sun, Feb 09, 2025 at 03:09:38PM +0100, Christian Marangi wrote:
> Fix broken config in qcom_param_page_type_exec caused by copy-paste error
> from commit 0c08080fd71c ("mtd: rawnand: qcom: use FIELD_PREP and GENMASK")
> 
> In qcom_param_page_type_exec the value needs to be set to
> nandc->regs->cfg0 instead of host->cfg0. This wrong configuration caused
> the Qcom NANDC driver to malfunction on any device that makes use of it
> (IPQ806x, IPQ40xx, IPQ807x, IPQ60xx) with the following error:
> 

I'm wondering whether the offending commit was really tested or not :(

> [    0.885369] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xaa
> [    0.885909] nand: Micron NAND 256MiB 1,8V 8-bit
> [    0.892499] nand: 256 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
> [    0.896823] nand: ECC (step, strength) = (512, 8) does not fit in OOB
> [    0.896836] qcom-nandc 79b0000.nand-controller: No valid ECC settings possible
> [    0.910996] bam-dma-engine 7984000.dma-controller: Cannot free busy channel
> [    0.918070] qcom-nandc: probe of 79b0000.nand-controller failed with error -28
> 
> Restore original configuration fix the problem and makes the driver work
> again.
> 
> Also restore the wrongly dropped cpu_to_le32 to correctly support BE
> systems.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0c08080fd71c ("mtd: rawnand: qcom: use FIELD_PREP and GENMASK")
> Tested-by: Robert Marko <robimarko@gmail.com> # IPQ8074 and IPQ6018
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks for the fix!

- Mani

> ---
> Changes v2:
> - Fix smatch warning (add missing cpu_to_le32 that was also dropped
>   from the FIELD_PREP patch)
> 
>  drivers/mtd/nand/raw/qcom_nandc.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index d2d2aeee42a7..6720b547892b 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -1881,18 +1881,18 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
>  	nandc->regs->addr0 = 0;
>  	nandc->regs->addr1 = 0;
>  
> -	host->cfg0 = FIELD_PREP(CW_PER_PAGE_MASK, 0) |
> -		     FIELD_PREP(UD_SIZE_BYTES_MASK, 512) |
> -		     FIELD_PREP(NUM_ADDR_CYCLES_MASK, 5) |
> -		     FIELD_PREP(SPARE_SIZE_BYTES_MASK, 0);
> -
> -	host->cfg1 = FIELD_PREP(NAND_RECOVERY_CYCLES_MASK, 7) |
> -		     FIELD_PREP(BAD_BLOCK_BYTE_NUM_MASK, 17) |
> -		     FIELD_PREP(CS_ACTIVE_BSY, 0) |
> -		     FIELD_PREP(BAD_BLOCK_IN_SPARE_AREA, 1) |
> -		     FIELD_PREP(WR_RD_BSY_GAP_MASK, 2) |
> -		     FIELD_PREP(WIDE_FLASH, 0) |
> -		     FIELD_PREP(DEV0_CFG1_ECC_DISABLE, 1);
> +	nandc->regs->cfg0 = cpu_to_le32(FIELD_PREP(CW_PER_PAGE_MASK, 0) |
> +					FIELD_PREP(UD_SIZE_BYTES_MASK, 512) |
> +					FIELD_PREP(NUM_ADDR_CYCLES_MASK, 5) |
> +					FIELD_PREP(SPARE_SIZE_BYTES_MASK, 0));
> +
> +	nandc->regs->cfg1 = cpu_to_le32(FIELD_PREP(NAND_RECOVERY_CYCLES_MASK, 7) |
> +					FIELD_PREP(BAD_BLOCK_BYTE_NUM_MASK, 17) |
> +					FIELD_PREP(CS_ACTIVE_BSY, 0) |
> +					FIELD_PREP(BAD_BLOCK_IN_SPARE_AREA, 1) |
> +					FIELD_PREP(WR_RD_BSY_GAP_MASK, 2) |
> +					FIELD_PREP(WIDE_FLASH, 0) |
> +					FIELD_PREP(DEV0_CFG1_ECC_DISABLE, 1));
>  
>  	if (!nandc->props->qpic_version2)
>  		nandc->regs->ecc_buf_cfg = cpu_to_le32(ECC_CFG_ECC_DISABLE);
> -- 
> 2.47.1
> 

-- 
மணிவண்ணன் சதாசிவம்

