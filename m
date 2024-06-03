Return-Path: <stable+bounces-47894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C082E8FA575
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 00:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67EF11F23BE8
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 22:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6E113C805;
	Mon,  3 Jun 2024 22:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="V4RZH6Ut"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8443522E
	for <stable@vger.kernel.org>; Mon,  3 Jun 2024 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717453219; cv=none; b=TBSpDKS94L1d2MjQps29BzrOcuDdBg+j4YENJBZXtgYCz8xrDgwDcN+gBvZ2RicmA6P9mrKmH1w64vckGyZryfiy8ys3PWlGKHAbDaRRiPuAsr5VMcKEBDhG2DVF32wdShW2vXAdSnnoG50qsjH+73l/XfRtQ2STiW8RtOPngd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717453219; c=relaxed/simple;
	bh=bgxp9a1P7PBhjpZl0y+m758d86ew1ZtpBd28ZI1jRvQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TFLUm0Ml5dqmGPPN0iHVb4A8POp95bg+VwVnxcaBTPYQ0NqIX1MbV7s7iTZaaF+AZbaQDJYXJCidjjNrZvGff3Drif5djCw0aZkIfOmwdMl68g4Uv9mFvmMoh7bguVa071jxL9pjEAX0XvU8nWtAI1pQtiP7gFXYLu+mW4akLqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=V4RZH6Ut; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1717453201; x=1718058001; i=w_armin@gmx.de;
	bh=1yYtmmbg+AELRU48mLWpjWdWzW6UWz52kC2jC8mXgao=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=V4RZH6Ut/Lc8vc6OhmR4vPLEvJEeNjfGWL2138dNSu/LqxL/1S4O3LfqcPMeLRNK
	 4iMAD7AEbyBks8Ti0GPirD3+J/yI62LHTjWWDTMEPbMDVCbydg2ohD+9WBLPZEm5I
	 0OeRCx0P5wxJvoF7QYEzMktd5kU6Am8gon8hiw5y+mF7iZE71uzQjtOC9XUd84poF
	 IwAD6Vo5OsjGcwlKrBAtdqyZtfbYwW0YMvQQg8CRn28KFe5LqIfJDwN8+llnKRiO9
	 MD8gdEglXGv3vEm2EooD/+aQZnBb1L5RB+ZfFPAKiyu3C+HPPSoC0Qcq/XmDPCaD6
	 73wkHMC/C+OkNBln3w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.35] ([91.137.126.34]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mwfac-1sOnrm2wfK-00yAJY; Tue, 04
 Jun 2024 00:20:01 +0200
Message-ID: <663b8003-3970-4293-930e-e19dce054e01@gmx.de>
Date: Tue, 4 Jun 2024 00:19:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amdgpu: init iommu after amdkfd device init"
From: Armin Wolf <W_Armin@gmx.de>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 gregkh@linuxfoundation.org, sashal@kernel.org
Cc: stable@vger.kernel.org, bkauler@gmail.com, yifan1.zhang@amd.com,
 Prike.Liang@amd.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
References: <20240523173031.4212-1-W_Armin@gmx.de>
Content-Language: en-US
In-Reply-To: <20240523173031.4212-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:9Yy1R/vmaJ4klLAia29uf4AydX4Zn/cMRbnRvzhC9mwVnu7mcCY
 ooCRScbfqYp7Cy41cDFdVqGiHOaWjAfANCFCYeqnIdvlOPmJWAFk9LEsp0LP9ScfXStPrYo
 eO6+ucrsraxusHXFc1hiL+NVkbAqrnS+HtTa6WorXz5N4JXhRbz5/URkdwtLVP7sjS85wNN
 UQlunXr/ksbmnltZv/M2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rj2MlId6gAQ=;a2USGC2Fidug1zFjbaKD71cBonC
 zUdmm9roV5kOhaizgwO9gmqyO1k3IwZ+67fMcbjEum9ACyBS4t2+siU9eaVO8GjCdUqUsgkoq
 7wRiR8qU0CX0GDFJoNf6dGPVP4sl6ZHGtUL1KJslPB7Gq+0psOjGu0csytlmnv/YRJmwf7KOZ
 I6lykPYrqKW4SdXXb3vN9tCooPg2I5IqInC9hoDWJ/gDfeWJIabIXasctQwhWkBuF2Y6f4qrQ
 7s7cuVxg9uRTxk9855dX+QE+VQRYVjWIXB8aa+3J0PEEAI3msc6iJa39QcJiM1q4I2GDtIFQK
 S+QewYvxzSg0d64MiSiXTnCBElUC9zZYFJL+zkhGqGCSzZ++gZdmbMUm2fk87UNncbNbDA7WB
 L3ZTXYSktU1e4e+VqdBkHEolqG4X5fTUYTZXknSrEAVq4jPjVlLNGjEqkhMeXCPmK9NCHJFkE
 OhNgFpW9/Obofej0P+lakqS7HMcdS24+YIa807uyAP1c8a9T8Gzwh2FPNDTVLowRgNvPMcH19
 Sziq/ioRStVW6IOW5TOupJ+k0jcuQmXLHF6NGjXmXcw72W5/pkzjtQypw0OCxf1AQJwb9Dyya
 UGzYkrWVGAjJJf/OndOssadSxIv7ZM0uIUdPTYVHgapfog16T4mZnRuI+VoVz/OZghssDJ08g
 eEGHhevec2QN2sEOs+lSEWc0rGs6nCxFhSCE1HBYQ4H6N5lc/8AIrRBW2NcweE9Ryh8B7QHaI
 WbxTqwY1KSDv+XVBP4K85WFCaEk5Ivi0Yvk0X8A9aD0dnCLKw4PjDslFJs1JJAMgv9KsBzbFD
 6NbgutPHbHTLNQuiFyOmQTObDjv2LNKNVHJhVLJ3Ak0j5owil/3fe7SnSqA7DPbj+h

Am 23.05.24 um 19:30 schrieb Armin Wolf:

> This reverts commit 56b522f4668167096a50c39446d6263c96219f5f.
>
> A user reported that this commit breaks the integrated gpu of his
> notebook, causing a black screen. He was able to bisect the problematic
> commit and verified that by reverting it the notebook works again.
> He also confirmed that kernel 6.8.1 also works on his device, so the
> upstream commit itself seems to be ok.
>
> An amdgpu developer (Alex Deucher) confirmed that this patch should
> have never been ported to 5.15 in the first place, so revert this
> commit from the 5.15 stable series.

Hi,

what is the status of this?

Armin Wolf

>
> Reported-by: Barry Kauler <bkauler@gmail.com>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 222a1d9ecf16..5f6c32ec674d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2487,6 +2487,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>   	if (r)
>   		goto init_failed;
>
> +	r = amdgpu_amdkfd_resume_iommu(adev);
> +	if (r)
> +		goto init_failed;
> +
>   	r = amdgpu_device_ip_hw_init_phase1(adev);
>   	if (r)
>   		goto init_failed;
> @@ -2525,10 +2529,6 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>   	if (!adev->gmc.xgmi.pending_reset)
>   		amdgpu_amdkfd_device_init(adev);
>
> -	r = amdgpu_amdkfd_resume_iommu(adev);
> -	if (r)
> -		goto init_failed;
> -
>   	amdgpu_fru_get_product_info(adev);
>
>   init_failed:
> --
> 2.39.2
>
>

