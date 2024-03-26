Return-Path: <stable+bounces-32291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E5D88BB89
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 08:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53FFB29FDB0
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 07:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4F7132816;
	Tue, 26 Mar 2024 07:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NmeTkp1V"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B524F130A48
	for <stable@vger.kernel.org>; Tue, 26 Mar 2024 07:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711438954; cv=none; b=rfjYTPUUE5OQAU2TVyJt41IkM+diOAnFOfNx6H6w03bxwl76gCcD7wEQAjkeQslXHtP3c2NtoluF7MRaZdn9N6KGuWr6WWfER0wIhqTU+VLNj4V9ojYv/GeGUFcWWxcPc2AC8XGJyI4YpRD0JfhuIMhnxdWYXyg+8jwwfv+oeD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711438954; c=relaxed/simple;
	bh=lQLJYF/S6aNnizdrvZwuqBFYXgWMgmOQnMbgfAPsYiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6Vj6Um6Q9yM8i4j7YOgfyz1rBlBSoSJW5yzfLtX0IdgFbLLRbk2lUaQJxj/uDgApf338yjj1cVkfzrHbiopyWUIMwOunTKQ1BlAWNZT4maVV3ySnukGsJDj5jEQ8lF/8iOTM22LQR9hnt/LaCHQS83mQQlpiobVouQhPWbvGoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NmeTkp1V; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e6ee9e3cffso3572120b3a.1
        for <stable@vger.kernel.org>; Tue, 26 Mar 2024 00:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711438951; x=1712043751; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=suWtwDEm4B03eU+FNeyx8FV8u6kO5WvtfeH16xAc4og=;
        b=NmeTkp1V7Xu9S3lMJMQawDIf6myHY8XQCtdQq4/jp9Gq+emaSf90nqfPH91VjefEkm
         vqXx+vZPNSJLOnWYOhmGmkUXTIWM79eaab1nhBtRnuDgXwAaSmgAjfhli4hDVpZnO8A0
         vd8PSXor5j0NWFBfuynf1kpNOBmMHHYI2AKuuwV3iJYQVsAOHjVieCrC61XwHVnDkZbM
         tXUPob354J2vaQFIueDJp7mYvD6Sy5r2Hw2pEArkoVm0Yv92nZ71C4UCC/l/oiVKtf48
         sL4RxwOQjrBQjDZk5b4ZuV1bJ7m5LJX/2CfyomH7lvgPkqLJBdLumG9Vd7JoAw9WAoJf
         k4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711438951; x=1712043751;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=suWtwDEm4B03eU+FNeyx8FV8u6kO5WvtfeH16xAc4og=;
        b=pQvDA3PBZjFDHIbOZoIZ2NalpR4sWCtBwho4t54a4dlA0NkRT05UAglquLiQ8k5Uy4
         KIoYc+1h30c1ixiu2uAstrp1DehzFUaEIuiD6yeEHoKGQe4D/OLSmknUqkYBUHwDYb1w
         WjfIVVwVgnUr60AXrDBhOfE+tW7Q3o+bZsNL6SdZfFXENbkR8MF+VBnvHvtxQzEsj5S8
         9wJid+6SXguzRjdczQvn5G3Ik3uJta6+tn9RTYH02tIL4XyFJTf0uz1hg/96u7AEs3iZ
         KEQvNQjqmZjqN8wKX5E/gEADzlivumS0NUMCdbIqQuOaOIniD6cC5dJ6zc9NsEcSohqN
         dkZg==
X-Forwarded-Encrypted: i=1; AJvYcCWSgSXF6RM184DJ4wtYIlLqS9kvbJghE4lPo/T2KX4Q3PPPEioDnRbK7295LKBXwFkYCXeCQpLQwgvWPWrcufkCSdPb76nC
X-Gm-Message-State: AOJu0YwxM8UWIUiXtovKOBtHRd9izSYJGjY6EZrfykFJrTwfJ7Lo8xtQ
	cUaCbPxtL+RMov8i1tky4FM28j0eMOrjGYhMaclfLJ0vH7fOs9IhF+yb1LH9NQ==
X-Google-Smtp-Source: AGHT+IENYADQhqltAgsX3SaQGsChrRbnmlYma0ZqXAvA2PgQ9EbWV1JZJVQXA1LqKU8H1D8C5SxnMA==
X-Received: by 2002:a05:6a20:3d87:b0:1a3:a8ff:473b with SMTP id s7-20020a056a203d8700b001a3a8ff473bmr939435pzi.29.1711438950796;
        Tue, 26 Mar 2024 00:42:30 -0700 (PDT)
Received: from thinkpad ([117.207.28.168])
        by smtp.gmail.com with ESMTPSA id fi16-20020a056a00399000b006e795082439sm5313094pfb.25.2024.03.26.00.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 00:42:30 -0700 (PDT)
Date: Tue, 26 Mar 2024 13:12:23 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mtd: rawnand: qcom: Fix broken reset in
 misc_cmd_type in exec_op
Message-ID: <20240326074223.GB9565@thinkpad>
References: <20240325103053.24408-1-ansuelsmth@gmail.com>
 <20240325103053.24408-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240325103053.24408-2-ansuelsmth@gmail.com>

On Mon, Mar 25, 2024 at 11:30:48AM +0100, Christian Marangi wrote:
> misc_cmd_type in exec_op have multiple problems. With commit a82990c8a409
> ("mtd: rawnand: qcom: Add read/read_start ops in exec_op path") it was
> reworked and generalized but actually dropped the handling of the
> RESET_DEVICE command.
> 
> The rework itself was correct with supporting case where a single misc
> command is handled, but became problematic by the addition of exiting
> early if we didn't had an ERASE or an OP_PROGRAM_PAGE operation.
> 
> Add additional logic to handle the reset command and return early only
> if we don't have handling for the requested command.
> 
> Fixes: a82990c8a409 ("mtd: rawnand: qcom: Add read/read_start ops in exec_op path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v2:
> - Add this patch
> 
>  drivers/mtd/nand/raw/qcom_nandc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index 19d76e345a49..b8cff9240b28 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -2815,7 +2815,7 @@ static int qcom_misc_cmd_type_exec(struct nand_chip *chip, const struct nand_sub
>  			      host->cfg0_raw & ~(7 << CW_PER_PAGE));
>  		nandc_set_reg(chip, NAND_DEV0_CFG1, host->cfg1_raw);
>  		instrs = 3;
> -	} else {
> +	} else if (q_op.cmd_reg != OP_RESET_DEVICE) {

But this will fail if the previous patch is not applied. So this makes me think
that you are trying to fix the OP_RESET_DEVICE command with these 2 patches.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

