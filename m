Return-Path: <stable+bounces-35673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A03D6896485
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 08:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B506282C0A
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 06:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEA017BD6;
	Wed,  3 Apr 2024 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yHfXDpzA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B2F171A7
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 06:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712125816; cv=none; b=JXfKmmav8EX1NT1HaHvIcdV0ta+H3KO4cfWfPi95P9lvXrQ4DZ1YhdCxsNl0cwWrBMKOgVqv7+L1qeLJ6ZRyMg4h1KHymmP5/albaw4J01Rn8T1Abd0p/bdoQz5LyRKFGKqu3d+66UduN/SIvRspingostNo1iny8GS9jNUNsSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712125816; c=relaxed/simple;
	bh=8sgnSowpaMZh5S2Y6ZK1p1McE5Xqmbt7t1FamwDhRVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELld+pXmaWxJmS7zaUTrYIc2VVggUWFrW8uAQAgFQB2wabof8m/h6l750yh/4K7zBbYyHYyG3RpGIPXnbdkgL4it+K55kZXd7nqf75HOzq6Oz6O++Ha+wSNSojEJ8mFEizSZOjB4ywdgINgXBCzzQ2ebX3lVPR6GcnsFw/cvZ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yHfXDpzA; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e2232e30f4so45739295ad.2
        for <stable@vger.kernel.org>; Tue, 02 Apr 2024 23:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712125814; x=1712730614; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7RD/Ll+en1rNJsL6MJyoQafEtmHmvnu+TP2GShmlV2E=;
        b=yHfXDpzAJb1GnWuhHW8WH2qmAtf4Am8P4pjtM86LyRqCDS6Qkwuw8ViaasHoziQuhv
         CWF3hug2o5T/0WSOu6LC9dz2u4WCyss6dXD+FM42fk3NwXBun2W1p3u6Qio1cc+H2fyL
         zy2pKjtn0uE7Z8Kft9aJRV0rICmOSpkIYGvdYT6sddfFxtpE/LJxE+obYvwg32Z0uZFY
         Jm0Ggmb7XJzG2QQSRqxff/CGOY7SncJLgRqfH5D+CPud72URHXKh0SDdPLYoypPMT6cp
         INzL2G/U77Ik4uRG69Vhpx94G1BTcVgf9EoGskijmWN9I53X/jChYGzcFn089Faoabgs
         ecZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712125814; x=1712730614;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7RD/Ll+en1rNJsL6MJyoQafEtmHmvnu+TP2GShmlV2E=;
        b=jLFmF026dw9Kfch+tfL4uJaL/zNMAF9kvgk8PXp7MEO34YUEhdBUw0kKKIsmytyEJ5
         YIkdtal85ZotHHYCLXpj1kDm+LmC0spHuT08zv126dEMP58Tn/EZNmRRTq0nLxZ60lcu
         EnoA2LCtZNYOzMyf5GNCaj1gIht9DJqsehoqJfedoQwbrKAGmPkQ5nq34d8cQBDENvKR
         pNt3Y/cKkPt52BdcAwTPo3G5VTlUotlEE81ApR+N7I1woV3ADVtpvq32Z1lr74vNgl1j
         NEQ0X1NhCImCt+1DkNTjJfUwuMTCQCM4+XeyKcsKgQ5idlew8nE0Dvk8vjlWCI5BHiG8
         2Vrw==
X-Forwarded-Encrypted: i=1; AJvYcCVvm6Vxvm13qRS9DrmnRZlCJ0wGy8ti1h9YFZFkc5GKGlqcz0PvJLu6eUj5X83zOybXArcTTQj0je9rdtgYtLhXCvdGmd8L
X-Gm-Message-State: AOJu0YxORIOWM6lW8lE6usnbNWUdzum8d9/V3XC94eVdnRTEwehB54Vz
	bFFgwHhwP6xM0p/J878FcbP5S8Yf6SRRfIdkocMmRnzxgc/ntLvNmSzf7zhp6w==
X-Google-Smtp-Source: AGHT+IFB1/jew2jwqrDsxXrqrjGsZHTMzuxqjY1GHMh3+JdUbou30h3sipXmeEKmZIIzGMunMk8+TA==
X-Received: by 2002:a17:902:dacf:b0:1e2:367:9879 with SMTP id q15-20020a170902dacf00b001e203679879mr15757623plx.45.1712125813278;
        Tue, 02 Apr 2024 23:30:13 -0700 (PDT)
Received: from thinkpad ([103.246.195.197])
        by smtp.gmail.com with ESMTPSA id d14-20020a170903230e00b001e06c1eed85sm12341503plh.141.2024.04.02.23.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 23:30:12 -0700 (PDT)
Date: Wed, 3 Apr 2024 12:00:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] mtd: rawnand: qcom: Fix broken misc_cmd_type in
 exec_op
Message-ID: <20240403063008.GA25309@thinkpad>
References: <20240402214136.29237-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240402214136.29237-1-ansuelsmth@gmail.com>

On Tue, Apr 02, 2024 at 11:41:34PM +0200, Christian Marangi wrote:
> misc_cmd_type in exec_op have multiple problems. With commit a82990c8a409
> ("mtd: rawnand: qcom: Add read/read_start ops in exec_op path") it was
> reworked and generalized but actually dropped the handling of the
> OP_RESET_DEVICE command.
> 
> The rework itself was correct with supporting case where a single misc
> command is handled, but became problematic by the addition of exiting
> early if we didn't had an OP_BLOCK_ERASE or an OP_PROGRAM_PAGE operation.
> 
> Also additional logic was added without clear explaination causing the
> OP_RESET_DEVICE command to be broken on testing it on a ipq806x nandc.
> 
> Add some additional logic to restore OP_RESET_DEVICE command handling
> restoring original functionality.
> 

I'd like to reword the commit subject and description as below. But I hope
Miquel can ammend it while applying:

"mtd: rawnand: qcom: Fix broken OP_RESET_DEVICE command in qcom_misc_cmd_type_exec()

While migrating to exec_ops in commit a82990c8a409 ("mtd: rawnand: qcom:
Add read/read_start ops in exec_op path"), OP_RESET_DEVICE command handling
got broken unintentionally. Right now for the OP_RESET_DEVICE command,
qcom_misc_cmd_type_exec() will simply return 0 without handling it. Even,
if that gets fixed, an unnecessary FLASH_STATUS read descriptor command is
being added in the middle and that seems to be causing the command to fail
on IPQ806x devices.

So let's fix the above two issues to make OP_RESET_DEVICE command working
again."

> Fixes: a82990c8a409 ("mtd: rawnand: qcom: Add read/read_start ops in exec_op path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

With the above change,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> Changes v3:
> - Merge patches
> - Rework commit description
> Changes v2:
> - Split patches
> 
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

