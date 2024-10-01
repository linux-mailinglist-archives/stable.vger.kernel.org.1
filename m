Return-Path: <stable+bounces-78563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 566FE98C464
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 19:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A32D1B2205A
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 17:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420721CBE9F;
	Tue,  1 Oct 2024 17:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PYmWqb2w"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC671C6F54
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 17:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727803690; cv=none; b=R53O6i5ocs+mCvcybkP9x7ExL8GW+lQLWzxRicqe9XTipBznNT5kF8KSMZuakBVEy1hccYmMH5DckJN3m5ywgn9KMX5PLeq/Kd1TrpJ53MvwFHzl95BFw1NhesPGZPswPUUrGrj/Ytx6hngIyPIvhaU6vJrqhjl6TQpqwXjxKN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727803690; c=relaxed/simple;
	bh=XbgmZwyb1H1QKAtJCYiTNrZ6tZzvq/vwTc/xyKudu7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=suGJn5xnWpGRENDAuMDMsCsLpcqwe2u2jaLY2GafYGMHjNPN2wuxCqDJemyRrLUFzJ6vXm8M+UgYzY9K4AvaW+JlUcKnYrC1xSBkklLYWvDvrTdkWxQ2HdZKMSwr3ZZmi3WT+0meF3M/6jyQjQdyJYORzyL668kNXLxxosZeQ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PYmWqb2w; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8a706236bfso473960566b.0
        for <stable@vger.kernel.org>; Tue, 01 Oct 2024 10:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727803687; x=1728408487; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TsUX7CM10TaWxwkWgkusEjk7ICdS5H0gqcjn5rK2sCw=;
        b=PYmWqb2whIIOrzGsOopYP7vKxE8Oc4n/CaQf+CPDDP5FlcPylAV4xqWKE129BWWhfD
         SAdKKtAXzZxWS7R0B1MMQvx29xi6PhQ5dJqq43eLGPfU7ish3uGsHsF2xbwg0JPu+2SE
         M7E2UhAV28l4bfauSDsRHBkX6qZlB2qtAW1vEZS/2tHaH4FLouJlzfr2pzEwma1nHsta
         wGcM38RpujBWnAtZSTqg40WooH/oA0hIgJuM/eaKFhseGVkQ7B0ploKJAWaTlnqfXJRT
         imkQoxCJDZcqnk3yQ4wWeW1g+Nqgm+FbrGbtgVtN+uyeCehIaj+Efw6xGw/XnCvXfdKH
         0YUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727803687; x=1728408487;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TsUX7CM10TaWxwkWgkusEjk7ICdS5H0gqcjn5rK2sCw=;
        b=j6K5/vLILplmdtJb2OtMXJneNDmzEXbT+xU9N/Ko/TtXx1cveCMxgMZk5OnAlr7KTt
         fVIhAbakC+iqbEHVc+AW6al9eXQEsxZgjl5NLtHHuAOLGJxBUaT6eol5WMiz0cbUy/02
         EQjVZdq7UwZfMzOQN14V3pyoKlEpzJ9yYI9msjw3eC54WbuWlybZM0rbntgsK5jxgHWU
         nhWZneMiy1Ms/uuhpCPq594rLnvnrV1bjIcDD9PfaUoVatlq9jKyYLHElp9BojLakCuY
         QUNbDwdVcclCxGiOKzZCRZyXb7zhnDaKkRfyxQsIv09SwCEhru+DqrX+z+lqutR19AOa
         wWFw==
X-Gm-Message-State: AOJu0Yzt59rjXEL3QmQmEVJAfqM9J2zn8xD1EHiH3RFSYrdv7xDuwGAI
	rPFYDHfC8dhpzLWoMCAPZ/Pvj+9emJ5hHLv6LDu7J3G+9x1T5KHoh5gkrvt3vXcwsOiKNqC1Sqc
	4Evi/Bf0S7kklR1EN71wfW0T6vBihkE9a+vCqaJ5DI3Z0ZsIQ
X-Google-Smtp-Source: AGHT+IHenDgfYzeJtdxZkt83AOPuWN3YnTpgSh/ORhX0cttRHbgCmSq7UM2L3p+I9VPp69r/CFp5dc8faU1Wtxkq2YY=
X-Received: by 2002:a05:6402:4002:b0:5c7:1f16:78e3 with SMTP id
 4fb4d7f45d1cf-5c8b1b65519mr158707a12.22.1727803686530; Tue, 01 Oct 2024
 10:28:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730151615.753688326@linuxfoundation.org> <20240730151617.057892121@linuxfoundation.org>
In-Reply-To: <20240730151617.057892121@linuxfoundation.org>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Tue, 1 Oct 2024 22:57:55 +0530
Message-ID: <CAO_48GGH0J9z3NCq=jH5PKQewPdrhUiNk-Bu9yKvX8yhsTWDtQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 033/440] arm64: dts: qcom: sm8250: switch UFS QMP PHY
 to new style of bindings
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello Greg,

On Tue, 30 Jul 2024 at 21:25, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.1-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
> [ Upstream commit ba865bdcc688932980b8e5ec2154eaa33cd4a981 ]
>
> Change the UFS QMP PHY to use newer style of QMP PHY bindings (single
> resource region, no per-PHY subnodes).

This patch breaks UFS on RB5 - it got caught on the merge with
android14-6.1-lts.

Could we please revert it? [Also on 5.15.165+ kernels].
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Link: https://lore.kernel.org/r/20231205032552.1583336-8-dmitry.baryshkov@linaro.org
> Signed-off-by: Bjorn Andersson <andersson@kernel.org>
> Stable-dep-of: 154ed5ea328d ("arm64: dts: qcom: sm8250: add power-domain to UFS PHY")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index 3d02adbc0b62f..194fb00051d66 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -2125,7 +2125,7 @@ ufs_mem_hc: ufshc@1d84000 {
>                                      "jedec,ufs-2.0";
>                         reg = <0 0x01d84000 0 0x3000>;
>                         interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
> -                       phys = <&ufs_mem_phy_lanes>;
> +                       phys = <&ufs_mem_phy>;
>                         phy-names = "ufsphy";
>                         lanes-per-direction = <2>;
>                         #reset-cells = <1>;
> @@ -2169,10 +2169,8 @@ ufs_mem_hc: ufshc@1d84000 {
>
>                 ufs_mem_phy: phy@1d87000 {
>                         compatible = "qcom,sm8250-qmp-ufs-phy";
> -                       reg = <0 0x01d87000 0 0x1c0>;
> -                       #address-cells = <2>;
> -                       #size-cells = <2>;
> -                       ranges;
> +                       reg = <0 0x01d87000 0 0x1000>;
> +
>                         clock-names = "ref",
>                                       "ref_aux";
>                         clocks = <&rpmhcc RPMH_CXO_CLK>,
> @@ -2180,16 +2178,10 @@ ufs_mem_phy: phy@1d87000 {
>
>                         resets = <&ufs_mem_hc 0>;
>                         reset-names = "ufsphy";
> -                       status = "disabled";
>
> -                       ufs_mem_phy_lanes: phy@1d87400 {
> -                               reg = <0 0x01d87400 0 0x16c>,
> -                                     <0 0x01d87600 0 0x200>,
> -                                     <0 0x01d87c00 0 0x200>,
> -                                     <0 0x01d87800 0 0x16c>,
> -                                     <0 0x01d87a00 0 0x200>;
> -                               #phy-cells = <0>;
> -                       };
> +                       #phy-cells = <0>;
> +
> +                       status = "disabled";
>                 };
>
>                 ipa_virt: interconnect@1e00000 {
> --
> 2.43.0
>
>
>
>

Best,
Sumit.

