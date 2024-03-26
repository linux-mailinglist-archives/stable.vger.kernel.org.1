Return-Path: <stable+bounces-32288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 413CB88BB29
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 08:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB0F1C2C5BE
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 07:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192B7130A66;
	Tue, 26 Mar 2024 07:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S5t9B9JF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC9D130485
	for <stable@vger.kernel.org>; Tue, 26 Mar 2024 07:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711437921; cv=none; b=XkLkpGnOLHwgDAF5D02mZAJqYUIXyTL811TWQmLLDCXxCDwaIt/OCqWmKA/2xF5Z/0n2a8HUAAhQ5kGFKliDNDqYiHgVJkr70S/nbbzFq/lsCcOobwoTPDto6Q0RSULQ3TEYg9eLVAuIZrz0kv2qpEPKSx3Ev8T7iaedSZvgLB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711437921; c=relaxed/simple;
	bh=RCJd7q0o3ZJEoAOEbM8/cHPtVvSmD4lVXiyFy7D0BdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWqqg9M3WBMKgpQHo7mamgFcvQvOEB8YK4vwEO9drZMFxZ0w9sLPM2DQLTPyV1UJheyPB64lWOLq0tgO0fbTFA3G5nny9w8OWRmd5jiHNt15IXSpxFpfbPwIJw6V+PndI6oOzwKsbghPT208rvdQg38wLDkihplBAqXN5xyAj3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S5t9B9JF; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6eabbce2d15so172538b3a.2
        for <stable@vger.kernel.org>; Tue, 26 Mar 2024 00:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711437919; x=1712042719; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ziezrdSsh0z8yLzL6N5wKqOMM+Xy/az5Lcsk/lp8gTM=;
        b=S5t9B9JF+F9ogctCTfN/kOz9bx+j2nIIIW3LXPRQoKp2Kqpbtc+IKHq5w67wAnKWss
         hzZteIrOjiIjbz2gRNlq8MeYRPjATUjurpLAcG/KNPgM5wGXJrqxc0CjzCW8Ywl6rjBD
         8BarCTsPD0ZfvkjU9WK2sLP2xZ756FqfUkO2ReMvaAIU811hcUW1nBRpDp72BRBKIhzv
         mZkav0Pc66SYqVu/MuR9Xoy5wanFaB5jsW63A6xmsuMiruDDWbXvoxeER4kY9t70I4ox
         F4zpyTa6aLTfsW6WhNsFpU1RQ6cV8ADucjEdnaCIzYfnzwH7/qW5SuJgAfFi38skEHA9
         /vbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711437919; x=1712042719;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ziezrdSsh0z8yLzL6N5wKqOMM+Xy/az5Lcsk/lp8gTM=;
        b=fXKtLFfCnWFJQaQB7fx2uVaNY2mXCuVWH0AYqzXPYBOhtoItv9S138GoTc2HphG5Lh
         2GxDkMNU9bP7dMqexPePCxu+N1iYAALZtHe6aVldZbcsnOnQRvSqPM7Po2kqg8e8hN68
         klLbilUXwWM0zHlwHvwggCBUg0/HlBIjIU3vuFycsHqzv/Mdzz/7gCuotO8xaEDlmanm
         2RQihdQZmUWFS1XPQSvw/8ruYSC0xQ7GEzHiQKZ7nQaJ2uk+qhiWpJaNGSUx9KoE40dt
         qc3V07SXyjYsamwlZ8R3jpjWKg/qGcsO3+8UhEXwEoOB6Nl1mS0SPqigZQu/u3SpaBnX
         GYpg==
X-Forwarded-Encrypted: i=1; AJvYcCWnu6ujQF33D+tzrWNwhG7WGtt0RHyxbwMKEnrBOEj/u7bNG77DMIx9yMrhay11OYhwFXVd0eK6pvKXyrdNuzDE48k/pQ6l
X-Gm-Message-State: AOJu0YxGOGfoVJjQB2bU/cn+aKlKP0Dqg0f8/lL5e9B++GE91mkyZnz1
	055vbEvqzCXaGtMQigems0iPepkhpDX3efOg/8T86HrmQPYQTiJ5NVgZHSZasA==
X-Google-Smtp-Source: AGHT+IHWfgFpUSpNvP9uI3sCuKgKc8JET+a3gmSe493+ufibi13U2SnauOugHZJYLmPcovLDrvBtjQ==
X-Received: by 2002:a05:6a00:1d1b:b0:6ea:bd1a:5dd6 with SMTP id a27-20020a056a001d1b00b006eabd1a5dd6mr483754pfx.32.1711437919416;
        Tue, 26 Mar 2024 00:25:19 -0700 (PDT)
Received: from thinkpad ([117.207.28.168])
        by smtp.gmail.com with ESMTPSA id fh7-20020a056a00390700b006eaacc63435sm2874254pfb.173.2024.03.26.00.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 00:25:19 -0700 (PDT)
Date: Tue, 26 Mar 2024 12:55:12 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mtd: rawnand: qcom: Fix broken erase in
 misc_cmd_type in exec_op
Message-ID: <20240326072512.GA8436@thinkpad>
References: <20240325103053.24408-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240325103053.24408-1-ansuelsmth@gmail.com>

On Mon, Mar 25, 2024 at 11:30:47AM +0100, Christian Marangi wrote:
> misc_cmd_type in exec_op have multiple problems. With commit a82990c8a409
> ("mtd: rawnand: qcom: Add read/read_start ops in exec_op path") it was
> reworked and generalized but actually broke the handling of the
> ERASE_BLOCK command.
> 
> Additional logic was added to the erase command cycle without clear
> explaination causing the erase command to be broken on testing it on
> a ipq806x nandc.
> 
> Fix the erase command by reverting the additional logic and only adding
> the NAND_DEV0_CFG0 additional call (required for erase command).
> 
> Fixes: a82990c8a409 ("mtd: rawnand: qcom: Add read/read_start ops in exec_op path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v2:
> - Split this and rework commit description and title
> 
>  drivers/mtd/nand/raw/qcom_nandc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index b079605c84d3..19d76e345a49 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -2830,9 +2830,8 @@ static int qcom_misc_cmd_type_exec(struct nand_chip *chip, const struct nand_sub
>  	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
>  
>  	write_reg_dma(nandc, NAND_FLASH_CMD, instrs, NAND_BAM_NEXT_SGL);
> -	(q_op.cmd_reg == OP_BLOCK_ERASE) ? write_reg_dma(nandc, NAND_DEV0_CFG0,
> -	2, NAND_BAM_NEXT_SGL) : read_reg_dma(nandc,
> -	NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
> +	if (q_op.cmd_reg == OP_BLOCK_ERASE)
> +		write_reg_dma(nandc, NAND_DEV0_CFG0, 2, NAND_BAM_NEXT_SGL);

So this only avoids the call to, 'read_reg_dma(nandc, NAND_FLASH_STATUS, 1,
NAND_BAM_NEXT_SGL)' if q_op.cmd_reg != OP_BLOCK_ERASE. But for q_op.cmd_reg ==
OP_BLOCK_ERASE, the result is the same.

I'm wondering how it results in fixing the OP_BLOCK_ERASE command.

Can you share the actual issue that you are seeing? Like error logs etc...

- Mani

-- 
மணிவண்ணன் சதாசிவம்

