Return-Path: <stable+bounces-60520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B7893490C
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 09:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DF3C1F250AD
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 07:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF93770FB;
	Thu, 18 Jul 2024 07:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bp/qcbxN"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D17F763EE
	for <stable@vger.kernel.org>; Thu, 18 Jul 2024 07:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721288500; cv=none; b=BV0d0dlSR06qAs7FFD23rnJ09VLf3n9hcCNn85czKIMEkG5sRCME3p46XYFvVcXk6fEwQIhDP+Vbw3rWc85sfyTXis3PL/hDHtBc6aiVZejPS2s4eCZCA+JTdIn22QS92iJKH+u4vOPFY8RryzAaTDbMU/WszEVMDV8kU4l59hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721288500; c=relaxed/simple;
	bh=wVE+yx4Ss1MhXuj3+RhJnfm27yiEuBz9TzoY7IgOcqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZkY29yViQAG+Egi1SB3cIfRWYOJb2kKNlAlOAdXKwE8msdgth8H66UVoq6h5L8pLHYEiFLP9sYi0OFNEQl7THIj7SQUt2JAmZ3FrSkZyobW5GpMI0zDOZ6W/gKRA79jPBfqKckI3haOdS1oWi+/gr/cXBqHqjQkWWzGrZUiZyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bp/qcbxN; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a1fcb611baso193586a12.1
        for <stable@vger.kernel.org>; Thu, 18 Jul 2024 00:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721288497; x=1721893297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jsCgYHs9veGqQPIzZ9BstB5GAjg0LaX8Lo7wNPsbkjQ=;
        b=Bp/qcbxNpe1XK+TMf0fF+TVD5z0PcDAV9GSnUo1SXXdcgmRI+ryUIj5CbWbNjFF8Sk
         6l2HA9LP7Yr4+cO72M3cD2QkNOK88Wj/KyvtCKPI5oZjpvl5HtpdXfyhQo151k8yASfQ
         AFw8TfL7MmVO2UA2VdVUrWj5w1Gwjpv1E4agLQawl2UYIxjh5PFqfwNN98hn8uPimifC
         dUjejV/kVZxd2oNhPwCu3J02LGzEQ/Ck+xX1lCnOQv5ggg+8uus1ISYiLclMBenqiuy6
         0I0RB79snd+8kBODtldaowKhJ6NvttWTI33VkyjYvZ1nNNi2n+mUtRcg3DNR0eeXwQll
         lUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721288497; x=1721893297;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jsCgYHs9veGqQPIzZ9BstB5GAjg0LaX8Lo7wNPsbkjQ=;
        b=L6zHWrwZdb0Vh4k5XaQTB3hUbSr441ZDp1pgA7CstgNqxe9lxmEWvEww8I+0Nc6ViQ
         3ST7txE7py7qn3jcbJHSUAzu2HP9I0XWNFSJlpO1oFfnV6rXwvwApl/ziMULaAx6xzXY
         2QugCNr2tlIjjp0opT+sGAlb1YqaykS3P84Eauxye/HCwphqAANjy29mZKM5pf+OUc99
         PFQ+rh6wCHUOBENkB2PSTpPVlDgBxIn8x+5/ujjAjb1BxuVDEq4m33hDd7VlnvBVdYr4
         BxG026yUkrq0WmDIdljlFq258iFryIxZYH5pYYAiAdtV7697aXrsPA4aMehezUgXimX4
         YwAA==
X-Forwarded-Encrypted: i=1; AJvYcCU0POCIY4iUMquNZSdY0dgKkAoR+gpOZ4rDvg1tUHsKbbcT/X/Rd/dmITev5oNXowq4vBYwl8jmuAUVSMgLvsT/sI8Rch2r
X-Gm-Message-State: AOJu0YwxUVV+9G1PgxJ7sFUPbgaNJ+QQSz5NXkSHnF6vELNmfAFhsht9
	SfQf2u1SUk4ChwCiYwYZiVcsrVwK3QKmWLCVi6flfHnQAXZSrW3FgBxiMcvsyhE=
X-Google-Smtp-Source: AGHT+IEahCzpsXdtrUWST/QB1gRZe+xS2I35R5EcstokAOmYiTArd2LOanE3HiK0z0ovnLW0y3eZDw==
X-Received: by 2002:a05:6402:210d:b0:5a1:f360:9a6b with SMTP id 4fb4d7f45d1cf-5a1f360a5bbmr494938a12.6.1721288496755;
        Thu, 18 Jul 2024 00:41:36 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::7424? ([2a02:8109:aa0d:be00::7424])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b268a293csm8021740a12.67.2024.07.18.00.41.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 00:41:36 -0700 (PDT)
Message-ID: <d17e7e6d-12dd-475d-80ae-fa48178d6cf2@linaro.org>
Date: Thu, 18 Jul 2024 09:41:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] soc: qcom: cmd-db: Map shared memory as WC, not WB
To: Maulik Shah <quic_mkshah@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: stephan@gerhold.net, swboyd@chromium.org, dianders@chromium.org,
 robdclark@gmail.com, nikita@trvn.ru, quic_eberman@quicinc.com,
 quic_pkondeti@quicinc.com, quic_lsrao@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, stable@vger.kernel.org
References: <20240718-cmd_db_uncached-v2-1-f6cf53164c90@quicinc.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240718-cmd_db_uncached-v2-1-f6cf53164c90@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/07/2024 08:03, Maulik Shah wrote:
> From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
> 
> Linux does not write into cmd-db region. This region of memory is write
> protected by XPU. XPU may sometime falsely detect clean cache eviction
> as "write" into the write protected region leading to secure interrupt
> which causes an endless loop somewhere in Trust Zone.
> 
> The only reason it is working right now is because Qualcomm Hypervisor
> maps the same region as Non-Cacheable memory in Stage 2 translation
> tables. The issue manifests if we want to use another hypervisor (like
> Xen or KVM), which does not know anything about those specific mappings.
> 
> Changing the mapping of cmd-db memory from MEMREMAP_WB to MEMREMAP_WT/WC
> removes dependency on correct mappings in Stage 2 tables. This patch
> fixes the issue by updating the mapping to MEMREMAP_WC.
> 
> I tested this on SA8155P with Xen.
> 
> Fixes: 312416d9171a ("drivers: qcom: add command DB driver")
> Cc: stable@vger.kernel.org # 5.4+
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> Tested-by: Nikita Travkin <nikita@trvn.ru> # sc7180 WoA in EL2
> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Changes in v2:
>   - Use MEMREMAP_WC instead of MEMREMAP_WT
>   - Update commit message from comments in v1
>   - Add Fixes tag and Cc to stable
>   - Link to v1: https://lore.kernel.org/lkml/20240327200917.2576034-1-volodymyr_babchuk@epam.com
> ---
>   drivers/soc/qcom/cmd-db.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
> index d84572662017..ae66c2623d25 100644
> --- a/drivers/soc/qcom/cmd-db.c
> +++ b/drivers/soc/qcom/cmd-db.c
> @@ -349,7 +349,7 @@ static int cmd_db_dev_probe(struct platform_device *pdev)
>   		return -EINVAL;
>   	}
>   
> -	cmd_db_header = memremap(rmem->base, rmem->size, MEMREMAP_WB);
> +	cmd_db_header = memremap(rmem->base, rmem->size, MEMREMAP_WC);
>   	if (!cmd_db_header) {
>   		ret = -ENOMEM;
>   		cmd_db_header = NULL;
> 
> ---
> base-commit: 797012914d2d031430268fe512af0ccd7d8e46ef
> change-id: 20240718-cmd_db_uncached-e896da5c5296
> 
> Best regards,

-- 
// Caleb (they/them)

