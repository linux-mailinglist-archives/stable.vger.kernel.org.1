Return-Path: <stable+bounces-106122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E20AE9FC7FA
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 05:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 465FE1882512
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 04:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A9C14E2E2;
	Thu, 26 Dec 2024 04:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lkP3NIVr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3BE2F852
	for <stable@vger.kernel.org>; Thu, 26 Dec 2024 04:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735187701; cv=none; b=Me8QsIyDKE0vOfBLr1Iq0oPY7Rnws4ipqkDwTE81VbpEodknk5jX3Yk/NyTbZedfQWmlmfn9EIa0d6co9x2GIIUZOeL7D7Cp0ls1dhU2DjVehkIc9A7/Sqay2qpjeSIHTC57UyxEff9xPhY/gyXg+RKnvY3cKRJj91BJq2ixxaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735187701; c=relaxed/simple;
	bh=ofgtrx+ToL0co1PolJ8/p00OmE4FUa+xQf2Nw+6Q7jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8G5T+82cjbBR8++VivHoOB/cS5MRpoJSCR6a8cn+J/i7W3tdXft7gDhqrn6MT/FgjY9xF4UVhD00AJ/E6v5DSwf+U3o4hkNr1O/+yCl1ugNpYhtsWyX2/58OCwJ3pLGlssT049ooqV5zqhovUh8e5KcROFHkgqwws4IauYXyFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lkP3NIVr; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ee786b3277so5090925a91.1
        for <stable@vger.kernel.org>; Wed, 25 Dec 2024 20:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735187698; x=1735792498; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CMCUr486bsmmq3TlE2yNphtQucspjTQzlA2KwwYZkQw=;
        b=lkP3NIVrTY5shb+pVM48I6Lfexwd78xv5i1CtZOy+7qqi2RaTG15Q7fzcM8EoIRG5N
         bfP0x30tAlHobIwOwzZcJrL8HKwT/KMsu4oz1+HvXTjHU+e0KtX2e2aw9g7Azl3zA+rI
         mJUDmuTRMZpj3yDeQnf7i1MLyR/KGi6JVux+nkL9vLQfYZoDT4XHlzFhADWVlyphDdxI
         TNA9HCsS+2vj7bFXmSmd5lalUCOxDAGxyH4YK6C3Wq3XqyPMCzv6MwwcWKrhmAPOpWpi
         5uCk5p9DG2rHiUxeAN29ABXwuEIaYQjxU09AV7/zzq+Xr+MFSjSCwIUPHFV51d5BfD1K
         GFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735187698; x=1735792498;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CMCUr486bsmmq3TlE2yNphtQucspjTQzlA2KwwYZkQw=;
        b=YTo7dwfmclHuAq9VnrzYy8Ve4JyBz8BEVPO6M/kSWLI2266EhAAKCG+tVHOA+7Spll
         J04Ne0hkq1sgZR4W6LEX/z91UVRUkt9PqOQ9Dsjj/G4/wIktw1fApexHpviWkfk9eKIX
         /rhHP5r5PcZlE9d8fravP2hQGctkSK4ekA0nccb1LBPwHQIMCI1U9kiX8ebjVOEtm1Zl
         OJsff//mNSrRhGKz+7F16w9tVlOi8bu8RlZcCM/VmiWd5uCHl48s+TcSWq8a0t1RiLF1
         qDPhVSfOce/56W/7QrK4dIJKVBC7tWXQOWw7JvYhQZ5D54DKBP6psGp9cgBJLUPD1I/A
         fGgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU67Q/ieCVWSxzDh2kWmflf1XP/6vc596z8otsHxCCbvgappD9nTSgtn+d8zmQS2ck6bCd73uY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz59OXwEHjl4JVr71YgCjgXuEzYEUpFidSIn4zEToOixOWV4neg
	FrGnAK1LAWbQ9YQT9iRnA82v8yBMqBk3axo8lrSPLdWo3OGU8NpsMB3aaomgUg==
X-Gm-Gg: ASbGncuDBmek0Fy+zplyuAyr9e9iYfK3C69mB1kiGctVcdZ6s47Fo5peqMNaX753ntS
	jTJPg9DdYfUXXkvk+PQ/9W4hXwzua9+qNdiwj2i7JzZ5WlIo2IDzADXmx/2L0HznRsiRsYEo3SW
	J8sfGyv0qFyuqbG+clItEnnBbx4z80sDcT7cw0MgUZGGBJ8YUPSzNDB/jRQy3QiHIcXpW5LRL9Z
	+xuTIgEThx7zMX8P2cdXFIm3CdxXi6+0xEpmssW0fzCypTNL+swzpZ5ZP0sYbuEaQ==
X-Google-Smtp-Source: AGHT+IGyCAyLDoLYd6WndbUJFcjYDJVuNhReCK6r1pPUXqGqT9ozO6gC5H+W7mYTNQfIe0UKmCQDMQ==
X-Received: by 2002:a17:90a:d88d:b0:2ee:863e:9ffc with SMTP id 98e67ed59e1d1-2f452e4ace5mr29069894a91.21.1735187697759;
        Wed, 25 Dec 2024 20:34:57 -0800 (PST)
Received: from thinkpad ([36.255.17.73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ed52dfecsm14791061a91.4.2024.12.25.20.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Dec 2024 20:34:57 -0800 (PST)
Date: Thu, 26 Dec 2024 10:04:51 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Amit Pundir <amit.pundir@linaro.org>,
	Nitin Rawat <quic_nitirawa@quicinc.com>, stable@vger.kernel.org,
	Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
Subject: Re: [PATCH v3 0/4] scsi: ufs: qcom: Suspend fixes
Message-ID: <20241226043451.vnm2nxm52foqnwlo@thinkpad>
References: <20241219-ufs-qcom-suspend-fix-v3-0-63c4b95a70b9@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241219-ufs-qcom-suspend-fix-v3-0-63c4b95a70b9@linaro.org>

On Thu, Dec 19, 2024 at 10:20:40PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> Hi,
> 
> This series fixes the several suspend issues on Qcom platforms. Patch 1 fixes
> the resume failure with spm_lvl=5 suspend on most of the Qcom platforms. For
> this patch, I couldn't figure out the exact commit that caused the issue. So I
> used the commit that introduced reinit support as a placeholder.
> 
> Patch 4 fixes the suspend issue on SM8550 and SM8650 platforms where UFS
> PHY retention is not supported. Hence the default spm_lvl=3 suspend fails. So
> this patch configures spm_lvl=5 as the default suspend level to force UFSHC/
> device powerdown during suspend. This supersedes the previous series [1] that
> tried to fix the issue in clock drivers.
> 
> This series is tested on Qcom SM8550 QRD, SM8650 QRD and Qcom RB5 boards.
> 
> [1] https://lore.kernel.org/linux-arm-msm/20241107-ufs-clk-fix-v1-0-6032ff22a052@linaro.org
> 

Martin, can you please pick up this series?

- Mani

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> Changes in v3:
> - Added a patch that honors the runtime/system PM levels set by host drivers.
>   Otherwise patch 4 doesn't have any effect. This was discovered with SM8650
>   QRD.
> - Collected tags
> - Link to v2: https://lore.kernel.org/r/20241213-ufs-qcom-suspend-fix-v2-0-1de6cd2d6146@linaro.org
> 
> Changes in v2:
> - Changed 'ufs_qcom_drvdata::quirks' type to 'enum ufshcd_quirks'
> - Collected tags
> - Link to v1: https://lore.kernel.org/r/20241211-ufs-qcom-suspend-fix-v1-0-83ebbde76b1c@linaro.org
> 
> ---
> Manivannan Sadhasivam (4):
>       scsi: ufs: qcom: Power off the PHY if it was already powered on in ufs_qcom_power_up_sequence()
>       scsi: ufs: core: Honor runtime/system PM levels if set by host controller drivers
>       scsi: ufs: qcom: Allow passing platform specific OF data
>       scsi: ufs: qcom: Power down the controller/device during system suspend for SM8550/SM8650 SoCs
> 
>  drivers/ufs/core/ufshcd-priv.h |  6 ------
>  drivers/ufs/core/ufshcd.c      | 10 ++++++----
>  drivers/ufs/host/ufs-qcom.c    | 31 +++++++++++++++++++------------
>  drivers/ufs/host/ufs-qcom.h    |  5 +++++
>  include/ufs/ufshcd.h           |  2 --
>  5 files changed, 30 insertions(+), 24 deletions(-)
> ---
> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> change-id: 20241211-ufs-qcom-suspend-fix-5618e9c56d93
> 
> Best regards,
> -- 
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

