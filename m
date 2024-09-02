Return-Path: <stable+bounces-72721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F459687D8
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 14:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3677F1C21D21
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 12:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F89F1D1F44;
	Mon,  2 Sep 2024 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D7y3iaBU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B199619C55C
	for <stable@vger.kernel.org>; Mon,  2 Sep 2024 12:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725281250; cv=none; b=hVHMjyxBwjQVjM4Vmz85Ccph61fQZ7v7YQdk0PKB9f4iJsL2+dFdy9qRGiPUECOKLy9LYf3w0Z1ksWLq6kwk9hbyIFfSCOb6lYyx7QhH61YVypwzBWdvmzCCvHnQRKGdmaXejkE023XvjlPK12PxR5yvHxrn64+TpqNn/4cRlZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725281250; c=relaxed/simple;
	bh=wF+TDzVSJ2YjjfA3NeGCW28IVmyODfLzxaDM+fl+FHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efv1fJ8YvFEG7Lu0sjatbwT2J8NTQ1EvFrfwah7XlG0thFSYl93Y3RlSlF7iaLPkFczpztOOWR8caoBkOTVfX1zx8e6fdnkFkCxR7CjR/7PJJtjJrPoWrgSKIZpkUxOBMF4OKCf5aIIKCbt0iKDKrSC5UYxwdmIZQgkGAYDgfmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D7y3iaBU; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-715cc93694fso3614783b3a.2
        for <stable@vger.kernel.org>; Mon, 02 Sep 2024 05:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725281248; x=1725886048; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sw56HONjylV3zP4q+WSmMqj4D4zJNduIGjeb5jWNs/E=;
        b=D7y3iaBUDV4W8AREiDBPtobdyHc0MbJbkyFnawRRq2UgD+LGkaBnWAPzZdWF6OSJgT
         baX/8s2Tf3wMlXsBcC2lI1IUybFOBVmRLRXKf51vSVPW+RxYpBEjQl1SBG+Ilb6y8LHd
         RcqOYVD2YRk9KCXogddYguzsJN+vjYhgcsoMbCCddFZfKLSIWu1cOckqSYhQJrYnRWYx
         J5xFkybBuLo51BnqFjveVmWvJEG2hDEQhpLecYRG5LgVgaFgOn1wUs4SLusmkBFgdKU2
         imKrnRTzCAwi7Zj6rVutx6ekbNsbdyWBf/yQUgyg2OwZk8h0A3GkibF//Vp+O/k2ZQfL
         T0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725281248; x=1725886048;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sw56HONjylV3zP4q+WSmMqj4D4zJNduIGjeb5jWNs/E=;
        b=vtZTqu297Sr4bGTkZA4j52GwGjsUZ/ry2gck7XB2tvglkkGOnfVGOsn/MEaPmyK3GQ
         9w+SwDo8++IIAZkRSLqILmBZVr8QG0/uZxRJlzkN4lz1VoC0GOfN2gbA8X2c3Uox++jA
         oKEgis4bKlwNoRbp2t1YSnXiVIMTCOh62SuVpHUVdwO3UkwoLyCdagEXxRke6wcy92bo
         qO3eQSW4mXx3040ymrwXGPWtOHDd92eDpeoHL0zPrZvjo4yD+8U/mac0jR7hEo/m1DPq
         5FbUeToMtInT+Y+H8Tq2W9GUfDQw2wVC0eGVmdOKN1TJIRDB8HprSyE1IPbwU7JUfS+P
         a4Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWoq3AO3hPz7ap0g9wZtz9bcocTFAHZnIvLmBJpZeEeVkFYiBefXnAgRgm2Yn3RgtZ6Z2bdF2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMbBjvQII/NuDJkMzrFk0ibUTxQcC7lNNH7KZhKuiEKNAdmR72
	ls3IUYS5j805zwvNtsD3Q3+sI8GPe9+Bqih1DPzPJoxhG6sBNqxW1EuRguO4rA==
X-Google-Smtp-Source: AGHT+IFm74MUePoqdJK4/q3NgMhKFYLf6zUq00FAgFNFSomryCyuaX6pCUOEG8+oPT7dru6YDuaHVg==
X-Received: by 2002:a05:6a20:b58b:b0:1c0:f2d9:a44a with SMTP id adf61e73a8af0-1ced0469115mr6570664637.22.1725281247917;
        Mon, 02 Sep 2024 05:47:27 -0700 (PDT)
Received: from thinkpad ([120.60.129.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9d77f2sm7438317a12.89.2024.09.02.05.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 05:47:27 -0700 (PDT)
Date: Mon, 2 Sep 2024 18:17:20 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Manish Pandey <quic_mapa@quicinc.com>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_nitirawa@quicinc.com,
	quic_bhaskarv@quicinc.com, quic_narepall@quicinc.com,
	quic_rampraka@quicinc.com, quic_cang@quicinc.com,
	quic_nguyenb@quicinc.com, stable@vger.kernel.org
Subject: Re: [PATCH V5] scsi: ufs: qcom: update MODE_MAX cfg_bw value
Message-ID: <20240902124720.coeidzis2xcmglzl@thinkpad>
References: <20240902114737.3740-1-quic_mapa@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240902114737.3740-1-quic_mapa@quicinc.com>

On Mon, Sep 02, 2024 at 05:17:37PM +0530, Manish Pandey wrote:
> Commit 8db8f6ce556a ("scsi: ufs: qcom: Add missing interconnect
> bandwidth values for Gear 5") updates the ufs_qcom_bw_table for

s/updates/updated

> Gear 5. However, it misses updating the cfg_bw value for the max

s/misses/missed

> mode.
> 
> Hence update the cfg_bw value for the max mode for UFS 4.x devices.
> 
> Fixes: 8db8f6ce556a ("scsi: ufs: qcom: Add missing interconnect
> bandwidth values for Gear 5")
> Cc: stable@vger.kernel.org
> Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> Changes from v4:
> - Updated commit message.
> 
> Changes from v3:
> - Cced stable@vger.kernel.org.
> 
> Changes from v2:
> - Addressed Mani comment, added fixes tag.
> 
> Changes from v1:
> - Updated commit message.
> ---
>  drivers/ufs/host/ufs-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index c87fdc849c62..ecdfff2456e3 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -93,7 +93,7 @@ static const struct __ufs_qcom_bw_table {
>  	[MODE_HS_RB][UFS_HS_G3][UFS_LANE_2] = { 1492582,	204800 },
>  	[MODE_HS_RB][UFS_HS_G4][UFS_LANE_2] = { 2915200,	409600 },
>  	[MODE_HS_RB][UFS_HS_G5][UFS_LANE_2] = { 5836800,	819200 },
> -	[MODE_MAX][0][0]		    = { 7643136,	307200 },
> +	[MODE_MAX][0][0]		    = { 7643136,	819200 },
>  };
>  
>  static void ufs_qcom_get_default_testbus_cfg(struct ufs_qcom_host *host);
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்

