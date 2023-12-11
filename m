Return-Path: <stable+bounces-5522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 601FD80D431
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14D221F21A34
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 17:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0684E633;
	Mon, 11 Dec 2023 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xMk5Kx40"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700C1EA
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 09:39:38 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-db3fa47c2f7so4961927276.0
        for <stable@vger.kernel.org>; Mon, 11 Dec 2023 09:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702316377; x=1702921177; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jm/U5iX89/NkKIBpHMc6e7m4WD1ivJqJGvRe8VbK7nY=;
        b=xMk5Kx40uxnogy9AW7ZGbyel1segDScwJiW1q/8+184jID9Hc+mGeFtmnwtQ1IpDQz
         SYMeM/SdNzq99X/NS5fiqnSNzlPmTiOBnRFr+5oxsAhYf0KDA3+C07qcUQYZVF+r3tva
         EmhGlI7m8AqvI/C+gjP0wOVkLwWID8pJvqIaleVOUApl0zU//TRSkmH9L0NnJpehbblD
         4skez4shaR3btqb0eaTCUlaeKrMKB0klyYKtTlSA3NRhN7iozRnw41Iydt50YZUNZG/z
         Ycyf639054gAT8I4DG65lehK/OnZyjcjiUYeLgrnN1Rn0N6wq14k9zKAR8fXKNzRY32R
         1Kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702316377; x=1702921177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jm/U5iX89/NkKIBpHMc6e7m4WD1ivJqJGvRe8VbK7nY=;
        b=KIrF5KROHFfsg86TWTAplEdaJu21B9rrkQqFwPspsYsuYQmnQz0b2iGsmVz22KTuzY
         0gBHtC0dMyabX2W7BtITC148q9+uRIFzo24/tap1T1ETqUqtzSEDFcNO/siUWzRm8m0Z
         89s0ZkKuQ3SWmiolA6FwTmEDZLcVlr9mF8r9sDTI5a8xAPiBrxBOHoOQrqkYTXu133SZ
         oOEMXvVLOawvZVrhJe59e7sxbyEe5ZrFHymhMqtaqD8T99syWR0qD3db2dF17ZG3q5Bw
         7kjXQll1rPTjWiuBdWxcDt3DfzY7+7eUxB7SG5dFerpMP8Oro83f7VANo0ETq0OhPNoo
         vUhw==
X-Gm-Message-State: AOJu0YxAHPZgxYTTtQ7MWRflbHa7U9Sli8Z+MUicsu9BdBvuaiLXIdg7
	c3Z+c+3G/PcAGGJ+/Y7q83Y4KUrPTb3wA5ry9U1B663x6fY91l6X2rH/Tw==
X-Google-Smtp-Source: AGHT+IFP/Y5PRlU1eXMLK1DEPHD4ZlTXHmj1o1ZRYUX5WxIJwcx84DGmQIVNKNxHrRJGzAv/k5G2es+ZoybkpQPW+kc=
X-Received: by 2002:a05:6902:1a44:b0:db9:8c22:a455 with SMTP id
 cy4-20020a0569021a4400b00db98c22a455mr3582817ybb.11.1702316377187; Mon, 11
 Dec 2023 09:39:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211172411.141289-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20231211172411.141289-1-manivannan.sadhasivam@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 11 Dec 2023 19:39:25 +0200
Message-ID: <CAA8EJppQNnLhH2XNg1qSTuY9uvChLU2rWy3Ep97yq8yLgwAJYg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: qcom-sdx55: Fix the base address of PCIe PHY
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Dec 2023 at 19:24, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> While convering the binding to new format, serdes address specified in the
> old binding was used as the base address. This causes a boot hang as the
> driver tries to access memory region outside of the specified address. Fix
> it!
>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: stable@vger.kernel.org # 6.6
> Fixes: bb56cff4ac03 ("ARM: dts: qcom-sdx55: switch PCIe QMP PHY to new style of bindings")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  arch/arm/boot/dts/qcom/qcom-sdx55.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
> index 2aa5089a8513..a88f186fcf03 100644
> --- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
> +++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
> @@ -436,9 +436,9 @@ pcie_ep: pcie-ep@1c00000 {
>                         status = "disabled";
>                 };
>
> -               pcie_phy: phy@1c07000 {
> +               pcie_phy: phy@1c06000 {
>                         compatible = "qcom,sdx55-qmp-pcie-phy";
> -                       reg = <0x01c07000 0x2000>;
> +                       reg = <0x01c06000 0x2000>;
>                         #address-cells = <1>;
>                         #size-cells = <1>;
>                         ranges;
> --
> 2.25.1
>


-- 
With best wishes
Dmitry

