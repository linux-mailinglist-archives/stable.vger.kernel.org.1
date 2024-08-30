Return-Path: <stable+bounces-71561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08073965844
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 09:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30521F21D45
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 07:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF1C15747C;
	Fri, 30 Aug 2024 07:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="joBH0amu"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7DF14B96F
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 07:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725002416; cv=none; b=cmWuS0ApL8PNe0U2fGYJoGnNmp/UjlUM8GN00Hk8UKuTRD4vbbidGqCXMzhBZm9WOhMbcBeky3ECVQlZ8yCae5gDeJg1NuygnZHQu2OxWXYDD/GhfN7T3019+Wf76UKmA4cH/9CWDxnZ8NEEMKW5qd9S8TvnFJ8XE9wb+QClAPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725002416; c=relaxed/simple;
	bh=HLaqna6UCuIrOsmYb1PawOtU1637YFWvoiEdQ3WVIvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAtJPWufguqyJOE3qylSvymhHi5sTJ2FFiHOQW6dvOd/9/gbU0Ru3U4QpchLpUjwy3z/dUYyAdaBj7Ut1CwrtftQMAmfPuWUG0cfdnIi6vhRReWuYY9a/QKG6n0Km/zvjrapBrDQbpQ6CkeNGyHM3UjDwX0iP+rkmxhmCelA+48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=joBH0amu; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f401b2347dso13922271fa.1
        for <stable@vger.kernel.org>; Fri, 30 Aug 2024 00:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725002411; x=1725607211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3qiXwyV3htRr/C+q00ThbxxW4I9Cl0S2rzv2BfSX2XE=;
        b=joBH0amuZpBKyGqaJtPqzzegijjS50M4tXjk8LFHCMGa9oGTVNbBs1udaNr602W2WT
         4xdG9K9J+IXAhMn2CX9uWbtRe7I++LOA+blDXWboGMjWLTxqbUypPoJFgeaQBPK/fOr5
         CrludGWJ0ZBMpqblO99/Qyg7ckv1tlCURDn3rUqGoC0YOCpmCbJW2Ab92R+8NFn3N2Pr
         lUa1PLpiPEw9oKoYgaccdpKFo4yL2+GrCU8rXl1TClSVeQOvvloKXh7UCKbVQngLvkJ0
         d51G7tshDXD4+RUyYMwOCUvYi/52COj8nF/0Az5yn+M/UKTra/j06NKvbeTgkOoVAA3c
         IDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725002411; x=1725607211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qiXwyV3htRr/C+q00ThbxxW4I9Cl0S2rzv2BfSX2XE=;
        b=LTVHimnsUtt7z9DuZC/LqR8k4/VFQs2Jj9EWWZ8c66gL+D2WGZ/2iNfkBGJmivR/LY
         gjG4VzKyQX0zPy1efsrKPMtp4/PGxlJUvpq3tZBBqDUWQCZj0rgEQvnKWl2eCcUtesh8
         YQ3BnpWOh5hXp6s7SREPf294s56Iw5J/ggO6XXKD5xkOye4NNISBRpbTYwRrkmIzEqpN
         XANjsUJUQgtvaR58qcrbT69d8wAN7eGTCVOgJoSgRMIC4CvZ6rTnZc0H2dU9JXBhDUcE
         aQqOeO8X2gp3nQnvtMgkSfa/c9/JQSiEtQesJRHwY0u8sP3fnApEeZZLpp3pSuqPNppF
         QWLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmPMJ75wzvMJDCclHAh0O+EQFUTzde1JiozaOY1ckgfslIDrs45mJ5nq4LtVvgd1FyXPewR1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGeKLOj/w4Q2BqAXDNiF/9Xsyvj68FiG/MViFQbRWrkX4C+hWB
	3a1GRyxllNFxIp7jOFQU80BkDEUibe2G8EymdO4O7e5pS80jQuxq3H5T1su5HP8=
X-Google-Smtp-Source: AGHT+IHr64ktPPLwO8bWL9kuJHNB6sUG3ObN0WP5rN3nb+epYFlsrNNeuu9wmeVfANO5vZbNzp/aoQ==
X-Received: by 2002:a2e:a99c:0:b0:2ef:2f8a:52d5 with SMTP id 38308e7fff4ca-2f61e05c9cfmr5342641fa.8.1725002410729;
        Fri, 30 Aug 2024 00:20:10 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f6151828c3sm5066641fa.109.2024.08.30.00.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 00:20:10 -0700 (PDT)
Date: Fri, 30 Aug 2024 10:20:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Manish Pandey <quic_mapa@quicinc.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com, quic_narepall@quicinc.com, 
	quic_rampraka@quicinc.com, quic_cang@quicinc.com, quic_nguyenb@quicinc.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH V4] scsi: ufs: qcom: update MODE_MAX cfg_bw value
Message-ID: <a7v4sgkh5f67hmbrpf4hukgt652qzkgaykszsbzbed44bnh2m7@xaspg6nxxduf>
References: <20240829123938.31115-1-quic_mapa@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829123938.31115-1-quic_mapa@quicinc.com>

On Thu, Aug 29, 2024 at 06:09:38PM GMT, Manish Pandey wrote:
> The cfg_bw value for max mode is incorrect for the Qualcomm SoC.
> Update it to the correct value for cfg_bw max mode.
> 
> Fixes: 03ce80a1bb86 ("scsi: ufs: qcom: Add support for scaling interconnects")
> Cc: stable@vger.kernel.org
> Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>
> ---
> Changes from v3:
> - Cced stable@vger.kernel.org.
> 
> Changes from v2:
> - Addressed Mani comment, added fixes tag.

Mani also asked you to provide details, why the value is considered to
be incorrect. You have responded in the email, but instead those details
should have gone to the commit message. Please fix it accordingly.

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
With best wishes
Dmitry

