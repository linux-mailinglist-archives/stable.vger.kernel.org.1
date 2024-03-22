Return-Path: <stable+bounces-28623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F811886F63
	for <lists+stable@lfdr.de>; Fri, 22 Mar 2024 16:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E7328637F
	for <lists+stable@lfdr.de>; Fri, 22 Mar 2024 15:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95594D9FC;
	Fri, 22 Mar 2024 15:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E9it4zVh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78C14D5A5
	for <stable@vger.kernel.org>; Fri, 22 Mar 2024 15:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119917; cv=none; b=qh3qN1fjFao1R3EOQ6WGeHrULdh+e8OQpykCPUyuc5G90F+1NSeZhy51nV5ZQOs8HE8B6bAsm0wVow7j5pOCuS+gInPmVUuqM8A6Ijc9vpPt+6kJxCQ6ZK9UWUnKgXhktX2Wcl+Y2xdhW4NcWmzBsxK3R7pQ8nQUNW2j64BY6Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119917; c=relaxed/simple;
	bh=gkYusBscgoxgaz2KTP3MjsMEu9+re1gKs0yjn4oDBW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIKHq2qt0tfM03u6Zt8jsT3CTuBeKU6svsTMcf/ddqTTpx48R+lyORCmoIORWsgTNYUW+GOl0NOwTsDrVt3saPdWF3VEPeFQ8gU4Tw1QYRfrKO5SyhV9xVSvkJLTb4gIN8xRHgSM0/nYRq2FOJiXVwBrdIEJc0+1b9uVX2Su4Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E9it4zVh; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29ddfada0d0so1322747a91.3
        for <stable@vger.kernel.org>; Fri, 22 Mar 2024 08:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711119915; x=1711724715; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nYtRMDTbG4RNH7nK1yI7ROk5/pYQnmRT4k34XSD/fpw=;
        b=E9it4zVh9Pkks3nwfSUogd0oEvXC8XrwSt0mueISehd+g9ShdMJRzkz0xBSr10Zg6B
         3YQo5ZfQDiVEbC22WCdo1df/bt7/ji62Uira2xHoj8SkxYtmo5WOanEsqdUVftPi497H
         wirNuBmfYtc0eOy0TBHulPPitlIBZCjbZQmHKO7SVmuf2FARpKNGaxenvSy/th3Uaqdq
         kNL2myDWA1GWQwol1RInA1akjed1GNeyyj6QhEZ0FqmDYtNikQX+mNNVegvah+G//4ZD
         rAAh6eA+OPerRqfSbphSb5dIkxGqgxNsdPkIvRtiFEKhuvw/vMWsNJrJtlRoLFHR498C
         rVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711119915; x=1711724715;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nYtRMDTbG4RNH7nK1yI7ROk5/pYQnmRT4k34XSD/fpw=;
        b=Hss3VZ2+xasb7y0f1tZf/4OKdB4gI5vzI1nEZ6xqHiFmyzTSQ8G/fmLiru83atKAyV
         IL5X2/YP8JB7IaUZ7y7h4tkW5vD0xwX1MiWBhaU9ZadXEgAPTs5yIgr6Vs/PulmXR4Le
         aLJmqU+tcS2Ge7HbtVqUq+eWznvZaBRDWOPiolgP49ks0imH6Puz19Xc75g3Sguv3sWI
         uHP8BGpueR7NFBKHcIMWKGCqko+aCvN9H6u48GU5ebUlxqa1X/N8v4Fjuqqj+ZM8qxBH
         rDgEIQNQ8Pkz/DmAIzNo3cGljdjyFwdxrjB8CqANBbESfcrXtYHNRCAwn0Qd8veNof3U
         J3nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFnb5mNDPCBZaQ1XOsc3+ypDksXVVEr8TVMS+0U3D8+h4CWXTSFnESzcLvSXFoM3+jJluw3mVd/Yg3VTiRcNsicV18nCb2
X-Gm-Message-State: AOJu0YzsqHyrloW7rwM//h5xf2SqLvEGoerWPyyvjY96mFL6n1mpfzVS
	zacNUHa5gbmuFnrIOPx/JTujhJkh57CNJuVJh4gwdfxv8al2yso2wJil3/PhUw==
X-Google-Smtp-Source: AGHT+IGYbQybiUZqXzRNwAr1M/pqxdrMdugBVhGSQDcs2L60R2/mNWIyHVBayTYGU3wCM5UA6L13jA==
X-Received: by 2002:a17:90a:ff95:b0:29f:9548:4932 with SMTP id hf21-20020a17090aff9500b0029f95484932mr2430080pjb.3.1711119914819;
        Fri, 22 Mar 2024 08:05:14 -0700 (PDT)
Received: from thinkpad ([103.28.246.103])
        by smtp.gmail.com with ESMTPSA id x20-20020a17090abc9400b0029dd7b52d1bsm5604576pjr.56.2024.03.22.08.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 08:05:14 -0700 (PDT)
Date: Fri, 22 Mar 2024 20:35:10 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: qcom: Fix broken misc_cmd_type in exec_op
Message-ID: <20240322150510.GC3774@thinkpad>
References: <20240320001141.16560-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240320001141.16560-1-ansuelsmth@gmail.com>

On Wed, Mar 20, 2024 at 01:11:39AM +0100, Christian Marangi wrote:
> misc_cmd_type in exec_op have multiple problems. With commit a82990c8a409
> ("mtd: rawnand: qcom: Add read/read_start ops in exec_op path") it was
> reworked and generalized but actually dropped the handling of the
> RESET_DEVICE command.
> 
> The rework itself was correct with supporting case where a single misc
> command is handled, but became problematic by the addition of exiting
> early if we didn't had an ERASE or an OP_PROGRAM_PAGE operation.
> 
> Also additional logic was added without clear explaination causing the
> erase command to be broken on testing it on a ipq806x nandc.
> 

Interesting. I believe Alam tested the rework on IPQ platforms and not sure how
it got missed.

> Add some additional logic to restore RESET_DEVICE command handling and
> fix erase command.
> 

This sounds like two independent fixes, no? Please split them into separate
patches.

- Mani

> Fixes: a82990c8a409 ("mtd: rawnand: qcom: Add read/read_start ops in exec_op path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/mtd/nand/raw/qcom_nandc.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index b079605c84d3..b8cff9240b28 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -2815,7 +2815,7 @@ static int qcom_misc_cmd_type_exec(struct nand_chip *chip, const struct nand_sub
>  			      host->cfg0_raw & ~(7 << CW_PER_PAGE));
>  		nandc_set_reg(chip, NAND_DEV0_CFG1, host->cfg1_raw);
>  		instrs = 3;
> -	} else {
> +	} else if (q_op.cmd_reg != OP_RESET_DEVICE) {
>  		return 0;
>  	}
>  
> @@ -2830,9 +2830,8 @@ static int qcom_misc_cmd_type_exec(struct nand_chip *chip, const struct nand_sub
>  	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
>  
>  	write_reg_dma(nandc, NAND_FLASH_CMD, instrs, NAND_BAM_NEXT_SGL);
> -	(q_op.cmd_reg == OP_BLOCK_ERASE) ? write_reg_dma(nandc, NAND_DEV0_CFG0,
> -	2, NAND_BAM_NEXT_SGL) : read_reg_dma(nandc,
> -	NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
> +	if (q_op.cmd_reg == OP_BLOCK_ERASE)
> +		write_reg_dma(nandc, NAND_DEV0_CFG0, 2, NAND_BAM_NEXT_SGL);
>  
>  	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
>  	read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

