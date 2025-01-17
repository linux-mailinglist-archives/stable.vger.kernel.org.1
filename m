Return-Path: <stable+bounces-109403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D89A1551C
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 17:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C16993A4515
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 16:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95BF19F487;
	Fri, 17 Jan 2025 16:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FX6T+eAp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33239199249
	for <stable@vger.kernel.org>; Fri, 17 Jan 2025 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737133158; cv=none; b=J0ytOuSLEAlIJ3w12vQz61jpJXxtIpv8tvDncDLVO1ppzTRevH6mhGWC1prDEF2I8ktko1atCz/CGibFkVHYkSE60iii2FzMzaGtCGvIv/EfzI/Vv5RwxfNENbLd2/YaZunQmRR9EHn3WuDLH5nCz/9QcSGvgPEIiiUuEyD7Bbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737133158; c=relaxed/simple;
	bh=eELjTMxy9R374bYdUfkFwRMkrtaOe7EhJHvKRy25pnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrMa+KZnWGKpxB/ntN/VxhK4VFAkJ5PhYs87/mTU7Hf4tJyvsyltcjfD8Gexq2Rknq7m8GXooGV/AV/q9QI/KlyySSHi93hogI2ju9uHj6Suk0P22Z7TI3M0LWMuqxJu45YhLEOPT2LQWTDBwfe3pCTacqxJxjJ6vHVK1STQzYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FX6T+eAp; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2161eb95317so46923425ad.1
        for <stable@vger.kernel.org>; Fri, 17 Jan 2025 08:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737133156; x=1737737956; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XkhbZO8tYS+x52lOvx8K04qENXNly95zhsaFcqaUxAQ=;
        b=FX6T+eApkix0ks3jZyk0VSywgekeWYV+VEoow8Q3dDk9yMSfXe6G4SHjguPc/Ig5bc
         L02K6zFvs+ZGZLYOfSUnB6dRdiAvI0nfhKHp7hCF0md1MexzMqVRj8TSO2IkkuINbkaQ
         Gmzdw6syA8hYh7krDlgcLAU2u7KAG8c4jFdOe1mQk1mHqBpIiV7z8YcrhdTVVDijWOyH
         sNS0gmo+F/AQWgRyQLBuDyQLJX5PizYcKUccFjrjucOzjwskSwahnD8k9/98eggfCrAT
         ANVWicHzTN9ofaoD7svlu4r6pW6nE5GkcXAeBYJwnOEbEryPA32J+zW7QVHkjuXdmggg
         lrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737133156; x=1737737956;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XkhbZO8tYS+x52lOvx8K04qENXNly95zhsaFcqaUxAQ=;
        b=CHi8jzINAL1ABJeuUl1BfNlLJNbJ91SwM3PzF+M68H/mnhKHZTFngi0qxhmDw7X6pU
         pmx1G79J9s9upbDbIi8RU3CCQb3kXsH276s5i7movN8vUCnwM1aABkyKVmX+a70fv3sZ
         ihwbu4xxd6+RBHGC2b0AfHo/zofWqXvR23hFMplWI5KZz4YcW5deaDuuz6jIgy7kDH8o
         k8BcDlHuNJnvAXHEF4sFH1mGFn1zFVmnvblQJHOZOSrHfl4FajTpVaVk3x4XPcqkpg85
         suZa03LoHdFTHhdIHa0rlv3N85kabmi621hbkhKEMETBbRDemE6lKsPHs7aAG45z1Kub
         GBkw==
X-Forwarded-Encrypted: i=1; AJvYcCUViE23NDj4TonHHVAEgVOFS8wqHsh7pnq5Ea7KzfuX2QrtgvbrA/SXYYyi7AwmGcoi4Ry7BqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWH3Lnk5lZCX67koHd0GeSONfD/AfYUQz6cy6VHKQkBcA2ky8J
	VQsj/d+Ub9I85+NwF64U4ZKju3DM8WY5Au4BI+Wen9dKr/0uQDRXHw4q3kHE0w==
X-Gm-Gg: ASbGnct3yPw9LNvc7JRaunZ1MJzg0QyHZdTPgf87t5VX9hHfOk5rR5RTHwrIINBKJQR
	y3Vy53+qAcxiVifLpxi0eoKiFf4XnnasU0t2CQYghzbu4xRc3YJSI1VAWXizx8R1WByMnNxNFe6
	Egl7XeIW8kmL98H8H5kN9k9/uOyQm9KKsP9F35kBH+Sr3o2GtujylFyUixwx+/1HPsJdFxYCfj1
	B9YKoAZsOORwwLAWlZnz05E/OLArM+EvrCHa1XibxjstkunWVbUbH0kHIVZy3mGPHLd
X-Google-Smtp-Source: AGHT+IEfnnL3mUhpv8k8DjWFKRShJa/iF7JsGrlzqODd5Qcyj+91fLelDJ83KysyOwgQsgiCtdXH0A==
X-Received: by 2002:a05:6a20:9143:b0:1e0:dc06:4f4d with SMTP id adf61e73a8af0-1eb214da876mr5836750637.19.1737133156381;
        Fri, 17 Jan 2025 08:59:16 -0800 (PST)
Received: from thinkpad ([117.193.215.12])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bdf0b43aasm2041206a12.66.2025.01.17.08.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 08:59:15 -0800 (PST)
Date: Fri, 17 Jan 2025 22:29:07 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
Cc: quic_cang@quicinc.com, bvanassche@acm.org, avri.altman@wdc.com,
	peter.wang@mediatek.com, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, stable@vger.kernel.org,
	Bean Huo <beanhuo@micron.com>,
	Daejun Park <daejun7.park@samsung.com>,
	Guenter Roeck <linux@roeck-us.net>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] scsi: ufs: core: Fix the HIGH/LOW_TEMP Bit
 Definitions
Message-ID: <20250117165907.rfdaayq4a6ichhmy@thinkpad>
References: <69992b3e3e3434a5c7643be5a64de48be892ca46.1736793068.git.quic_nguyenb@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69992b3e3e3434a5c7643be5a64de48be892ca46.1736793068.git.quic_nguyenb@quicinc.com>

On Mon, Jan 13, 2025 at 10:32:07AM -0800, Bao D. Nguyen wrote:
> According to the UFS Device Specification, the dExtendedUFSFeaturesSupport
> defines the support for TOO_HIGH_TEMPERATURE as bit[4] and the
> TOO_LOW_TEMPERATURE as bit[5]. Correct the code to match with
> the UFS device specification definition.
> 
> Fixes: e88e2d322 ("scsi: ufs: core: Probe for temperature notification support")

Fixes commit SHA should be 12 characters:

Fixes: e88e2d32200a ("scsi: ufs: core: Probe for temperature notification support")

- Mani

> Cc: stable@vger.kernel.org
> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
> Reviewed-by: Avri Altman <Avri.Altman@wdc.com>
> ---
>  include/ufs/ufs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
> index e594abe..f0c6111 100644
> --- a/include/ufs/ufs.h
> +++ b/include/ufs/ufs.h
> @@ -386,8 +386,8 @@ enum {
>  
>  /* Possible values for dExtendedUFSFeaturesSupport */
>  enum {
> -	UFS_DEV_LOW_TEMP_NOTIF		= BIT(4),
> -	UFS_DEV_HIGH_TEMP_NOTIF		= BIT(5),
> +	UFS_DEV_HIGH_TEMP_NOTIF		= BIT(4),
> +	UFS_DEV_LOW_TEMP_NOTIF		= BIT(5),
>  	UFS_DEV_EXT_TEMP_NOTIF		= BIT(6),
>  	UFS_DEV_HPB_SUPPORT		= BIT(7),
>  	UFS_DEV_WRITE_BOOSTER_SUP	= BIT(8),
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்

