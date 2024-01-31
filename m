Return-Path: <stable+bounces-17529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D928448A9
	for <lists+stable@lfdr.de>; Wed, 31 Jan 2024 21:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6BA284251
	for <lists+stable@lfdr.de>; Wed, 31 Jan 2024 20:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD213F8F9;
	Wed, 31 Jan 2024 20:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lucaweiss.eu header.i=@lucaweiss.eu header.b="4STUOJTs"
X-Original-To: stable@vger.kernel.org
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91CA3FE23
	for <stable@vger.kernel.org>; Wed, 31 Jan 2024 20:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732411; cv=none; b=XxPsTs/5e/cTTAMn+zXtMK7ZwT7oJwo/2fuL36LXATFbqONc+bsn08xuH0+Qi2x/PoWK0Sx5iKNnr3qBBoyJjTAcCzUlMToxJAj28QFMKYB6aBxLXPoK+CeK8Gf1c0noMaglcM1Ch6dixk2gZY0LaNzaiW2Sir/YnmDxel3Y33M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732411; c=relaxed/simple;
	bh=dVJ8ry9WN65F1aQ7ut6opxkgd1LGVMmXdqh/2UX7xmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=At7r2qaWXtmxFV0fes5eRLufyfXVwxzh8ZHHRrRKg9JschJcdX8JQj5PBaXFiiWWV/ybshwGwCcEV4G2ppO5MmghFuEjgIysCMEdS6WnLxiUhwEqm3S9dN6kTeORt2JfS0Cx0XF65/uKVf6lYZPqkWpMsXn2XBEZNMD6vBDYWlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lucaweiss.eu; spf=pass smtp.mailfrom=lucaweiss.eu; dkim=pass (1024-bit key) header.d=lucaweiss.eu header.i=@lucaweiss.eu header.b=4STUOJTs; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lucaweiss.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lucaweiss.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lucaweiss.eu; s=s1;
	t=1706732400; bh=dVJ8ry9WN65F1aQ7ut6opxkgd1LGVMmXdqh/2UX7xmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=4STUOJTsTK9Q12gce336MWuNNGCBlhVE1+/WNi2aKmVfPFpHVOXpuRgXCOmUF/DvQ
	 Si+sGvtDKS35ZFcJbOM0SSd7581kaELsyZQj5oQR6gu8uZMlPfQepc1W7T8L40/0D6
	 tKPn6V0YhKPcZafMAEkzKEBDxKsHE3UjPkdcRTbA=
From: Luca Weiss <luca@lucaweiss.eu>
To: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Amit Pundir <amit.pundir@linaro.org>
Cc: Stable <stable@vger.kernel.org>
Subject: Re: [PATCH for-v6.1.y+] drm/msm/dsi: Enable runtime PM
Date: Wed, 31 Jan 2024 21:19:59 +0100
Message-ID: <12452267.O9o76ZdvQC@z3ntu.xyz>
In-Reply-To: <20240130134647.58630-1-amit.pundir@linaro.org>
References: <20240130134647.58630-1-amit.pundir@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 30. J=E4nner 2024 14:46:47 CET Amit Pundir wrote:
> From: Konrad Dybcio <konrad.dybcio@linaro.org>
>=20
> [ Upstream commit 6ab502bc1cf3147ea1d8540d04b83a7a4cb6d1f1 ]
>=20
> Some devices power the DSI PHY/PLL through a power rail that we model
> as a GENPD. Enable runtime PM to make it suspendable.
>=20
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Patchwork: https://patchwork.freedesktop.org/patch/543352/
> Link:
> https://lore.kernel.org/r/20230620-topic-dsiphy_rpm-v2-2-a11a751f34f0@lin=
ar
> o.org Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Stable-dep-of: 3d07a411b4fa ("drm/msm/dsi: Use pm_runtime_resume_and_get =
to
> prevent refcnt leaks") Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> ---
> Fixes display regression on DB845c running v6.1.75, v6.6.14 and v6.7.2.

Can confirm this fixes display on qcom-msm8226 on v6.7.2.

Not sure if it's appropriate for -stable but:

Tested-by: Luca Weiss <luca@z3ntu.xyz>

Regards
Luca

>=20
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c index 62bc3756f2e2..c0bcf020ef66
> 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> @@ -673,6 +673,10 @@ static int dsi_phy_driver_probe(struct platform_devi=
ce
> *pdev) return dev_err_probe(dev, PTR_ERR(phy->ahb_clk),
>  				     "Unable to get ahb clk\n");
>=20
> +	ret =3D devm_pm_runtime_enable(&pdev->dev);
> +	if (ret)
> +		return ret;
> +
>  	/* PLL init will call into clk_register which requires
>  	 * register access, so we need to enable power and ahb clock.
>  	 */





