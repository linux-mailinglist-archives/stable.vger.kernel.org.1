Return-Path: <stable+bounces-158827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B62AECA1F
	for <lists+stable@lfdr.de>; Sat, 28 Jun 2025 21:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7AC189F59D
	for <lists+stable@lfdr.de>; Sat, 28 Jun 2025 19:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EE2221F21;
	Sat, 28 Jun 2025 19:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WiT70tP6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EC912EBE7
	for <stable@vger.kernel.org>; Sat, 28 Jun 2025 19:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751140403; cv=none; b=dA7uNXJOwTWkn5wU96peyKHAqu8tyLTOCCIBlBgvVbHBfEwNRTQI478MUCezA4PXjgy9DQZns3MaapxT56I2NeKNIBlsL/IXyNsPXmU0H3oK/i9hnSNjOPC/PdPG4PQOMVsa/aQ3J1osi4ufZPf2mZLMrM6PRTJrYDC49NfLoDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751140403; c=relaxed/simple;
	bh=KyN7c3OW4XSfhqKxip/xfXDgiwMEBmnDvDrRs2F33Ng=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bTvr7OBrCh8dtlbjSdUkF/bRDZdZ+0N+EzpYTKB3vx3OOzLMyF2e3ymQZ4GUNjDaqljMJWiWKpdqcAaXfqU8mO6/TqcbojZqN8PqR2LAaate/txT4xsHkRDWTKxg1BvTI3Fd5gz96NEp8ODFBo0Ighdn4tahJpl2PflaP2mj/C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WiT70tP6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so17405505e9.2
        for <stable@vger.kernel.org>; Sat, 28 Jun 2025 12:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751140400; x=1751745200; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QyHqQCf1rj8/jNTL5ig8eExEUuZ3Ia42+nYVYWkCr4=;
        b=WiT70tP6jgausJS9D7abpn0Dy0W8wzPSESY2YBo7hPlvxXCBUZki5VP1KwK4fo5phP
         QK3J4CViQLNtPOWQP9cD7EeEMTHhBWLR22+uKd/uuY1KlN8v/sWfZlLeBrJVmALkG+8H
         YA1nXbAtUWNhZ3yjWYbwgp0ucJzJHZPQfmwMiIcpwgia4N3Lv2va8iCcJZtiebEfrd8S
         vnRz7uKT3HGG3tOuBevj9eAVv3V/PKThANKlO6ncHNvRA7fMY3zAVu2sAiLVbVl1H7OQ
         9SECGBZbwTRK0rzLpJc8C8YTBwWwxo5TunIqA/7VmFJowBxACbXKoW9Ie5R1ql8N6T3e
         Diaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751140400; x=1751745200;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3QyHqQCf1rj8/jNTL5ig8eExEUuZ3Ia42+nYVYWkCr4=;
        b=HfT2uvd601xfKndMhVXH1Mw99gfft0iS3GlzbFO1EYIgM2SUc4rgD1gB8hAIYD/7Rp
         MwciPKGQPzcEGTm23gmbDXqwMHX9WNaR8eaGLObnI9e2a/yJ43ryfr6yIO3XQLJFajrM
         M5FxvajfC5XzTbf8/SDBMLYPuWrZUbViN0Xor2pL4IJYkZR/ypTssWyFckKvmREc4dqb
         S2VTy+D3j/hPJ5yIMQB9lAdG5y+xaxl/T6veOFHUYMB2FcKiuN+y24Bhp/RgbtZynwNV
         1NCPLLHITkA50B9Zh0XSa4D5RO7zvjQA2j5TX288KK0Mu3k3rCvEsqn/mXwd/b4eyVM/
         X+JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfWdLDrcU/IvstY9kMyLwTquX6vH0QaKLwGtBdoWjgGXC6pA4DSbaSRhUYx+adwH5evHtwtcY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp2L2c1/GLvASM+4UBCPdhSdxHzWzo324HHuuw7RHUSlI4AnSJ
	QU9vKPWuAeiyxDaSMj17KymjH/u761asAVOp/AUKiRN56T2WzVBLFGdYDFIxNG7DXFY=
X-Gm-Gg: ASbGncuwqY1WFUBm2d/DT8VMtuXtU0F9mUOTPksw5sgVJD6iUTGxe1z+xjbq9s29SdT
	AIv1xqAFKuln6zaAbE8ibq/05Q3q+5YZnJAjrCcvumHv6ScFDyobdaY0ev+bGZTXdtjnDDnKO3n
	LLMMyZud34gMpYwoXjjZn35dB+Mfxwp1XQJLyUifb8TAHJ0HT1PVKe6O+NLOUB0wv1YqYD0PvfF
	h9Xi0ntRcJ/EfY/r0aBeKt5IUhKPuEeXUD4Rfm8KxbeQgaKp7kBth+EyfMApdX7kevKvPtBg/dS
	2YoJhvNuS3cyXpsRDwtz/b2qfcRSqf8ZnHi8vuZ2Z/ePKwAG3bS5sxwBqfgiwZiE5e41
X-Google-Smtp-Source: AGHT+IFHukOoSyHfuwr6fdOhiMqwDh6w4eyGrcAqPmtqVI9++TGozuj4ALvF8dEZH78Qc3I+9tpD/w==
X-Received: by 2002:a05:6000:144d:b0:3a4:fc37:70e4 with SMTP id ffacd0b85a97d-3a90c07daffmr7119112f8f.58.1751140399497;
        Sat, 28 Jun 2025 12:53:19 -0700 (PDT)
Received: from localhost ([2a02:c7c:7213:c700:e33b:a0ed:df4b:222c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c80b516sm5871948f8f.41.2025.06.28.12.53.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jun 2025 12:53:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Jun 2025 20:53:18 +0100
Message-Id: <DAYFGP9TBU3K.1TEQFWX2GF7OR@linaro.org>
Cc: <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
 <andersson@kernel.org>, <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v2] iommu/arm-smmu-qcom: Add SM6115 MDSS compatible
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: <robin.clark@oss.qualcomm.com>, <will@kernel.org>,
 <robin.murphy@arm.com>, <iommu@lists.linux.dev>
X-Mailer: aerc 0.20.0
References: <20250613173238.15061-1-alexey.klimov@linaro.org>
In-Reply-To: <20250613173238.15061-1-alexey.klimov@linaro.org>

On Fri Jun 13, 2025 at 6:32 PM BST, Alexey Klimov wrote:
> Add the SM6115 MDSS compatible to clients compatible list, as it also
> needs that workaround.
> Without this workaround, for example, QRB4210 RB2 which is based on
> SM4250/SM6115 generates a lot of smmu unhandled context faults during
> boot:
>
> arm_smmu_context_fault: 116854 callbacks suppressed
> arm-smmu c600000.iommu: Unhandled context fault: fsr=3D0x402,
> iova=3D0x5c0ec600, fsynr=3D0x320021, cbfrsynra=3D0x420, cb=3D5
> arm-smmu c600000.iommu: FSR    =3D 00000402 [Format=3D2 TF], SID=3D0x420
> arm-smmu c600000.iommu: FSYNR0 =3D 00320021 [S1CBNDX=3D50 PNU PLVL=3D1]
> arm-smmu c600000.iommu: Unhandled context fault: fsr=3D0x402,
> iova=3D0x5c0d7800, fsynr=3D0x320021, cbfrsynra=3D0x420, cb=3D5
> arm-smmu c600000.iommu: FSR    =3D 00000402 [Format=3D2 TF], SID=3D0x420
>
> and also failed initialisation of lontium lt9611uxc, gpu and dpu is
> observed:
> (binding MDSS components triggered by lt9611uxc have failed)
>
>  ------------[ cut here ]------------
>  !aspace
>  WARNING: CPU: 6 PID: 324 at drivers/gpu/drm/msm/msm_gem_vma.c:130 msm_ge=
m_vma_init+0x150/0x18c [msm]
>  Modules linked in: ... (long list of modules)
>  CPU: 6 UID: 0 PID: 324 Comm: (udev-worker) Not tainted 6.15.0-03037-gaac=
c73ceeb8b #4 PREEMPT
>  Hardware name: Qualcomm Technologies, Inc. QRB4210 RB2 (DT)
>  pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
>  pc : msm_gem_vma_init+0x150/0x18c [msm]
>  lr : msm_gem_vma_init+0x150/0x18c [msm]
>  sp : ffff80008144b280
>   		...
>  Call trace:
>   msm_gem_vma_init+0x150/0x18c [msm] (P)
>   get_vma_locked+0xc0/0x194 [msm]
>   msm_gem_get_and_pin_iova_range+0x4c/0xdc [msm]
>   msm_gem_kernel_new+0x48/0x160 [msm]
>   msm_gpu_init+0x34c/0x53c [msm]
>   adreno_gpu_init+0x1b0/0x2d8 [msm]
>   a6xx_gpu_init+0x1e8/0x9e0 [msm]
>   adreno_bind+0x2b8/0x348 [msm]
>   component_bind_all+0x100/0x230
>   msm_drm_bind+0x13c/0x3d0 [msm]
>   try_to_bring_up_aggregate_device+0x164/0x1d0
>   __component_add+0xa4/0x174
>   component_add+0x14/0x20
>   dsi_dev_attach+0x20/0x34 [msm]
>   dsi_host_attach+0x58/0x98 [msm]
>   devm_mipi_dsi_attach+0x34/0x90
>   lt9611uxc_attach_dsi.isra.0+0x94/0x124 [lontium_lt9611uxc]
>   lt9611uxc_probe+0x540/0x5fc [lontium_lt9611uxc]
>   i2c_device_probe+0x148/0x2a8
>   really_probe+0xbc/0x2c0
>   __driver_probe_device+0x78/0x120
>   driver_probe_device+0x3c/0x154
>   __driver_attach+0x90/0x1a0
>   bus_for_each_dev+0x68/0xb8
>   driver_attach+0x24/0x30
>   bus_add_driver+0xe4/0x208
>   driver_register+0x68/0x124
>   i2c_register_driver+0x48/0xcc
>   lt9611uxc_driver_init+0x20/0x1000 [lontium_lt9611uxc]
>   do_one_initcall+0x60/0x1d4
>   do_init_module+0x54/0x1fc
>   load_module+0x1748/0x1c8c
>   init_module_from_file+0x74/0xa0
>   __arm64_sys_finit_module+0x130/0x2f8
>   invoke_syscall+0x48/0x104
>   el0_svc_common.constprop.0+0xc0/0xe0
>   do_el0_svc+0x1c/0x28
>   el0_svc+0x2c/0x80
>   el0t_64_sync_handler+0x10c/0x138
>   el0t_64_sync+0x198/0x19c
>  ---[ end trace 0000000000000000 ]---
>  msm_dpu 5e01000.display-controller: [drm:msm_gpu_init [msm]] *ERROR* cou=
ld not allocate memptrs: -22
>  msm_dpu 5e01000.display-controller: failed to load adreno gpu
>  platform a400000.remoteproc:glink-edge:apr:service@7:dais: Adding to iom=
mu group 19
>  msm_dpu 5e01000.display-controller: failed to bind 5900000.gpu (ops a3xx=
_ops [msm]): -22
>  msm_dpu 5e01000.display-controller: adev bind failed: -22
>  lt9611uxc 0-002b: failed to attach dsi to host
>  lt9611uxc 0-002b: probe with driver lt9611uxc failed with error -22
>
> Suggested-by: Bjorn Andersson <andersson@kernel.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Fixes: 3581b7062cec ("drm/msm/disp/dpu1: add support for display on SM611=
5")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---
>
> v2:
>  - added tags as suggested by Dmitry;
>  - slightly updated text in the commit message.
>
> Previous version: https://lore.kernel.org/linux-arm-msm/20250528003118.21=
4093-1-alexey.klimov@linaro.org/
>
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/a=
rm/arm-smmu/arm-smmu-qcom.c
> index 62874b18f645..c75023718595 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -379,6 +379,7 @@ static const struct of_device_id qcom_smmu_client_of_=
match[] __maybe_unused =3D {
>  	{ .compatible =3D "qcom,sdm670-mdss" },
>  	{ .compatible =3D "qcom,sdm845-mdss" },
>  	{ .compatible =3D "qcom,sdm845-mss-pil" },
> +	{ .compatible =3D "qcom,sm6115-mdss" },
>  	{ .compatible =3D "qcom,sm6350-mdss" },
>  	{ .compatible =3D "qcom,sm6375-mdss" },
>  	{ .compatible =3D "qcom,sm8150-mdss" },

Gentle ping.                                                               =
                                                                =20
                                                                           =
                                                                =20
This was sent over 2 weeks ago.                                            =
                                                                =20
                                                                           =
                                                                =20
Thanks,                                                                    =
                                                                =20
Alexey Klimov

