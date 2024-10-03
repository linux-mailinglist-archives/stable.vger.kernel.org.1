Return-Path: <stable+bounces-80648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8E898F1A1
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 16:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84934B229E0
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 14:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E3F19F13F;
	Thu,  3 Oct 2024 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aR0r8DIN"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8A219CC3C
	for <stable@vger.kernel.org>; Thu,  3 Oct 2024 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727966357; cv=none; b=V4KnobESpsLYzA7u4DGgu/55EN1zENF4yKQ2eqACXpnLTUf2pOA3L1qkebb3BrLpSLHMWecv+t8t/OLOYW8MaAEr1Spcd7uub7TofIA4AroKdcFKh+5Z09aPiZWOGvhO6wbGpiXQlonmk3PAqZZNURueh1QHJs+TwTpbBvTBFFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727966357; c=relaxed/simple;
	bh=IsVtYr89vV3ukCV0XZp2MdP2yfgN3qT++GO1QKoWSGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EbbvUNjwgx1goFc7YjjrQRjskWy8yJLuhnE3EZwuVvM/3KNM+cP/IlELb399kQjQyCOl8Lmq3Rezo/vilqjA5xEXyv1e15kx6Ke2hokkFq7cSIQyclsKo8+56jW+7ZpzZIyERm5dbVdbtavnuD3KJS3jewRKo5dy2DhGbPPTqFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aR0r8DIN; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fac60ab585so12803241fa.0
        for <stable@vger.kernel.org>; Thu, 03 Oct 2024 07:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727966353; x=1728571153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yj9z931PBcW8CsAAhy0LhI6QwfekI87eYHfcwDscQMk=;
        b=aR0r8DINmFICKmRWr0UIqtBQ1zOdWbr6Tj9ig7q6+mNKXmwJaVqlaHa9LZjoQ10mVc
         fGp5BQzVhNfVHP6fGJhvPy32yGHbGK5L73vC28lTaskmAOlPMbNW6QYJdE4NmQLBaHAK
         NuCJPtPGLlDnCtBPVcuSY2CScyf6+qId2uTK0aq63rTxJUon5KF+tbH0CodpY+OXDg2C
         4dcqIVpTNFGEsA8ui43WoJHu1fVDRWTPD+ZBb5G0Z0s2klxQk19vPhNhXoFz6pYnZmnX
         kq61u8Px0CmZRmuLGZFSoHgqeMmy/45/mUR0WGCXSrGO4lq09ed5crJiFten0X+EACfp
         FUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727966353; x=1728571153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yj9z931PBcW8CsAAhy0LhI6QwfekI87eYHfcwDscQMk=;
        b=qIjJKe2MsJUeLuT2fiC7v+EqrsS2/ixlD87cwvgaKzZo+rThvbivKt5waxd9aEa2Am
         4gja8qgI5nZtA6E3uIdCq61LbrTNDHrpEkIKvp5sLak35OfSuhM7T7GOjkg9o/gj0UDt
         Belm0RVnVPxAw5DEV8zaOaOJ+CmvzNTZgPG575FQ7cVYEOYXyznm9RZV6pt3H0Pyy4RH
         UCLEhpgqdAW0+kbyW8RyLg3+a/lcor/0sOUgRWwYwyL6HR+c7GO5hVWwmcW8f0XfkC53
         24Ap45y8jEi03Ggm17eEBG6SlTb3J+PRKjCgyPu1/NaP3gDLa4is+Q/rVR0AuQTsaoVn
         TXJw==
X-Gm-Message-State: AOJu0Yz09Y5oXjO6u5l0vNnl8/2aJTEmwoaH/l0HJNQojbPUHQicKIJK
	P1T0EvplB4I84L2gxc8fINF+X4NUVxvgqOfgvAbMwAWeDeQv94rMlFlEYRGp8rg70Lh9R3ztI2/
	0Wx5egDnDP+jecazeCBU50tC9Vx8V89HaHYD2nfmuobh5Y0fZfck=
X-Google-Smtp-Source: AGHT+IHFS1T03KdtBLnPodJCfB1N8Cq1q9oC0FfyIzGoruvGU+91mLF/B8kmqJbUkSTOeDOEOSq1KP1G4odXza1nxiE=
X-Received: by 2002:a2e:711:0:b0:2fa:bf53:1dad with SMTP id
 38308e7fff4ca-2fae107f795mr34104041fa.31.1727966353113; Thu, 03 Oct 2024
 07:39:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003143532.108444-1-sumit.semwal@linaro.org>
In-Reply-To: <20241003143532.108444-1-sumit.semwal@linaro.org>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Thu, 3 Oct 2024 20:09:01 +0530
Message-ID: <CAO_48GF4poFkJ6XLnUxcGNpO0UKHReiAEs9_xPxciDRb_cETiA@mail.gmail.com>
Subject: Re: [PATCH] Revert "arm64: dts: qcom: sm8250: switch UFS QMP PHY to
 new style of bindings"
To: stable@vger.kernel.org
Cc: dmitry.baryshkov@linaro.org, agross@kernel.org, bjorn.andersson@linaro.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Oct 2024 at 20:05, Sumit Semwal <sumit.semwal@linaro.org> wrote:
>
> This reverts commit cf9c7b34b90b622254b236a9a43737b6059a1c14.
>
> This commit breaks UFS on RB5 in the 6.1 LTS kernels. The original patch
> author suggests that this is not a stable kernel patch, hence reverting
> it.
Minor correction here: this is applicable to both 6.1 and 5.15 LTS
kernels; patch applies as-is on both.
>
> This was reported during testing with 6.1.103 / 5.15.165 LTS kernels
> merged in the respective Android Common Kernel branches.
>
> Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/q=
com/sm8250.dtsi
> index 6a2852584405..c9780b2afd2f 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -2125,7 +2125,7 @@ ufs_mem_hc: ufshc@1d84000 {
>                                      "jedec,ufs-2.0";
>                         reg =3D <0 0x01d84000 0 0x3000>;
>                         interrupts =3D <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
> -                       phys =3D <&ufs_mem_phy>;
> +                       phys =3D <&ufs_mem_phy_lanes>;
>                         phy-names =3D "ufsphy";
>                         lanes-per-direction =3D <2>;
>                         #reset-cells =3D <1>;
> @@ -2169,8 +2169,10 @@ ufs_mem_hc: ufshc@1d84000 {
>
>                 ufs_mem_phy: phy@1d87000 {
>                         compatible =3D "qcom,sm8250-qmp-ufs-phy";
> -                       reg =3D <0 0x01d87000 0 0x1000>;
> -
> +                       reg =3D <0 0x01d87000 0 0x1c0>;
> +                       #address-cells =3D <2>;
> +                       #size-cells =3D <2>;
> +                       ranges;
>                         clock-names =3D "ref",
>                                       "ref_aux";
>                         clocks =3D <&rpmhcc RPMH_CXO_CLK>,
> @@ -2178,12 +2180,18 @@ ufs_mem_phy: phy@1d87000 {
>
>                         resets =3D <&ufs_mem_hc 0>;
>                         reset-names =3D "ufsphy";
> +                       status =3D "disabled";
>
>                         power-domains =3D <&gcc UFS_PHY_GDSC>;
>
> -                       #phy-cells =3D <0>;
> -
> -                       status =3D "disabled";
> +                       ufs_mem_phy_lanes: phy@1d87400 {
> +                               reg =3D <0 0x01d87400 0 0x16c>,
> +                                     <0 0x01d87600 0 0x200>,
> +                                     <0 0x01d87c00 0 0x200>,
> +                                     <0 0x01d87800 0 0x16c>,
> +                                     <0 0x01d87a00 0 0x200>;
> +                               #phy-cells =3D <0>;
> +                       };
>                 };
>
>                 ipa_virt: interconnect@1e00000 {
> --
> 2.46.2
>


--=20
Thanks and regards,

Sumit Semwal (he / him)
Tech Lead - Android, Platforms and Virtualisation
Linaro.org =E2=94=82 Arm Solutions at Light Speed

