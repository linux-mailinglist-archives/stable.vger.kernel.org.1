Return-Path: <stable+bounces-121194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B98A545F7
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 10:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 227DB16DF46
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 09:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568B92080C5;
	Thu,  6 Mar 2025 09:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q/m4dJBB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5BA207DEA
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 09:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741252259; cv=none; b=sl4yEvPPWSw+iXAJUA/2JghpgV40fbhZy9n+IjEFkoupF48t41MjDJXmghUi61vpTGM94yQZT3edeaWDGXSQMbBvandB1tyJrJK/HVNjo9pndenTOE9xsmmBs8PEuq3CZSCP39yTb9I5F+Lq/GCdoSrOzGeM1y4faRFIs9QFvFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741252259; c=relaxed/simple;
	bh=T9gwR9XxB9pG9R6MbiToMZJagqH3T8qqcqNBF7PeQ7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XwOu9lyRwdhnmFCUi+3qZcqltmXKmBbYLw5nwowsgWi2fIP0V/wFRdiwxID5EIPFPyraRMS6djen4HlWr8Lm1EjzB+1V/tUaRLeH4b6/n1uWClfwYRvWggp/80TYUqd40x2tVpZ4nkvjGx55gnTHLyYWIzdo5UwbAi/Rn5o7R6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q/m4dJBB; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so2155645e9.3
        for <stable@vger.kernel.org>; Thu, 06 Mar 2025 01:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741252255; x=1741857055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tN16NGGx/95g9rx+yQ6oZi4rmDu8bCDsZdK+zJvVznI=;
        b=Q/m4dJBBwPz5Kq2VmZgMLYkIIAumPGyocL7EZMHhlb4nSBIEM3xyri7OpVJOYkO9vd
         9dS4JPJ+FDQ6zQyo5OLmRHarir/WnYPTlxlPaIb8tlBX/BtP7IFYfoUQZGgKFZYyTC5S
         GHDj+7W5jiVmVzX0cejYV2GYCZ9X99eJRP5TLP1ZH8geaNX+d9zkEsVUc3EWpa3Kfbbf
         4QFFYqTFmhBp4sn+Qza3x535ur4LaIHLicqQCdzr+ah9dVF0whhiMzLQkNGiWfM5NzYi
         gX/S3vKR5gFGClOqUnL/APXTobEAtnejLSigo0VGd7SYn2seNYsTmQuzMq2PIG/CRTlH
         ej2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741252255; x=1741857055;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tN16NGGx/95g9rx+yQ6oZi4rmDu8bCDsZdK+zJvVznI=;
        b=U/lvwU8Xh3WSwNfSoOmR0XousYIG4j0oII+/vpYSx9Y3+Cgj28ZN/asmnGj3yfU+sF
         c+nfLdrkDerCHRRU+KLMWWrSv7pSrJX0C3jHWHt6//JIAEimgsu3D0p9B9HT0Z0CU7Qm
         04fg6xmPTIslZDpQa1u5qvxq915ghq+JkOvdumBe9H6JCeMZLavlusjJmmgIH+IKWKF6
         MMbry2XDVYwuT97BHLAgq6L+btkhbFmG+zp8YaB8y26z97021t7055UkWi+e1+eSl8Q7
         Dtawr9EcWCky0JLxiVd3XkGB6VJ+A00/hp5VdzMCwX/KairSlLh6KyvrJkQkS02iy28X
         Apig==
X-Forwarded-Encrypted: i=1; AJvYcCVhLQOJpsT1HYkuaXLcJ+bEl8tddeU7utSOHts0+vHM664/3EgowllR1J/cnAJcZo1bc2CdEag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEVeik3s6X5pKqwYbIvfbVkWuBVAWUyCt+yk696cZ4gv7Xrps2
	t3CvH/FlpfJ9PRVKvv1iEFMDJTrb93ndciOdA1r624aVNY9oPD+xQt1NEr21CE0=
X-Gm-Gg: ASbGncsODEp+FXGSgxr69rz72tsqPWGrZWS5EriPDD/FfiRcLZUIjvxPRu4vIClw3u+
	oLk5YHukHOOzgiGSqIAFURPW/yvfLT4eX9xQWzhacRMNKKsEvd89e3bK9kZCAk99v6lZWGHamRa
	rxj1+ZJOYRr+7ek7PIVpuPOiiMek3Z1gi4W71i6yCFThfX+IG2YsfTTcaah+YBEYKvK+dxVkE4D
	0sIqNKQfd96vzG9s5w0dUJJ2Dv7F1MieOr9cXXWLTARGc9ewqoDjWO/F8AMCZThpyGjmzIQ9uvE
	l1q2be9bZLkbVXfC/rkdZ1JAb6BLhH0FR2d3jX3WTOuiTbBbaBpsjQ==
X-Google-Smtp-Source: AGHT+IGbmWH12q0oH0l9u656j7YSKd4B1+DuJJ5Tv4FfjDn745/uTx8L4UjyOIbWFjxB05chPwZ2yw==
X-Received: by 2002:a05:6000:1844:b0:390:f698:ecd0 with SMTP id ffacd0b85a97d-3911f726495mr5583521f8f.11.1741252255578;
        Thu, 06 Mar 2025 01:10:55 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c1030cfsm1402164f8f.90.2025.03.06.01.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 01:10:54 -0800 (PST)
Message-ID: <f47b9e82-2d0a-4999-bc26-82cb55558f79@linaro.org>
Date: Thu, 6 Mar 2025 09:10:53 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: nand: Fix a kdoc comment
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <michael@walle.cc>,
 linux-mtd@lists.infradead.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org
References: <20250305194955.2508652-1-miquel.raynal@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250305194955.2508652-1-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/5/25 7:49 PM, Miquel Raynal wrote:
> The max_bad_eraseblocks_per_lun member of nand_device obviously
> describes a number of *maximum* number of bad eraseblocks per LUN.
> 
> Fix this obvious typo.
> 
> Fixes: 377e517b5fa5 ("mtd: nand: Add max_bad_eraseblocks_per_lun info to memorg")
> Cc: stable@vger.kernel.org

no trivial fixes for stable please.

replace Cc to stable with:
Cc: <stable+noautosel@kernel.org> # fix kdoc comment

With that:
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  include/linux/mtd/nand.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
> index 0e2f228e8b4a..07486168d104 100644
> --- a/include/linux/mtd/nand.h
> +++ b/include/linux/mtd/nand.h
> @@ -21,7 +21,7 @@ struct nand_device;
>   * @oobsize: OOB area size
>   * @pages_per_eraseblock: number of pages per eraseblock
>   * @eraseblocks_per_lun: number of eraseblocks per LUN (Logical Unit Number)
> - * @max_bad_eraseblocks_per_lun: maximum number of eraseblocks per LUN
> + * @max_bad_eraseblocks_per_lun: maximum number of bad eraseblocks per LUN
>   * @planes_per_lun: number of planes per LUN
>   * @luns_per_target: number of LUN per target (target is a synonym for die)
>   * @ntargets: total number of targets exposed by the NAND device


