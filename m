Return-Path: <stable+bounces-93676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172E99D03E9
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 13:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7802CB24334
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 12:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A2E18FC81;
	Sun, 17 Nov 2024 12:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WpCVL7zd"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BF1A945
	for <stable@vger.kernel.org>; Sun, 17 Nov 2024 12:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731848243; cv=none; b=UVLU3oGxxRwWbQV6mWK2SA0sVBhNx5XgSU2FDa4c+lAAvGx0Aj9TY8Ka4xbrCH81TKCdSeshgv7iVLw6qtWo2fcaxzdVSn73OohyqLFOUxJuBb0Dvt+qnKUYwFctrmGcgrxg0Sg6wmDI100paXTIWkX1tjEi+jN1cR6Vy0npLEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731848243; c=relaxed/simple;
	bh=6C2Vh6o628jIpNAhtgDsohB1br8pAS8SVtDQf4a9oAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FM/mtEa2FYBjCSTP4CjsXvCZb71N1HK5QAMtkIbcluh+x/LdEZENgnAzhiNZOwGoQZQqNHIYemxBRFBeiAlQL2xpgD2NvAqIUygPTkAnR8Tb72ByjY65Lpbktcxhahlpl9uY9FYEWCOz926mkiD85M+teZ0vRc42SlTT2oX/h/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WpCVL7zd; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6e377e4aea3so7899097b3.3
        for <stable@vger.kernel.org>; Sun, 17 Nov 2024 04:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731848240; x=1732453040; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NodmpFT+qxaaF/PGLm9mRIZsGR/VQH6X8ujv94bXnj0=;
        b=WpCVL7zdHPiD5aSY5K6S7ElNDcKRprQAN3bsExpBtfLlnHjecB64XyEqtoK54GQfyJ
         3vhlRSBCl6g28OQR9zxXf+iSC/aG8URhIAbs06NNuqcIPFvt7QF/jAXMSCqZg0ISU+Lo
         38HVaZs3UuBnAXkLEj8k9u34KOmmwstD4CoLgOTVgLwlbXeybCNmxB+mAMXN5D7wvv+d
         vABuDqzjUC5J1B22MtHDb589hwEGpLX2CYyB6VAo7SRLtGCNpULQV8VkBQyBp9aYdZkj
         2g/PjKyrQH8e7RkUhWM9dbsOC4BmsOlMQHFHZVCiyQ3dPIeHlONcdyvQ21mzkGfEv7uO
         bc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731848240; x=1732453040;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NodmpFT+qxaaF/PGLm9mRIZsGR/VQH6X8ujv94bXnj0=;
        b=H9Xh1cPK70Aw9tVrcr7GZz7NzQviCxOE4JXTBGtutagvJ6nUaCVwXXUa+dwl6mKouG
         ROTC96YgfH71kOHmLLAyYuz3Y3sB0tO5p+xBWr8T+34ZNGM8WE5Hs2WuvHJvlbW8vb8h
         473MO+5zLTRQ7B8hsg1KULexLNnRQjKSsBj5cXr3x8yk5rjBp4EJCLFjFWss8D90A25Z
         KKPPx5X8kiG6LhNWpqMpFoM7Ua7uvh9KXDM1TmuUNmOFjD49VY3fExBtBwCxkUHkba6N
         fY96uwHjLS+eAhMIVtA70H/sWmXPAQB+A3xkppvlv21wow1b3Z+iQr4pjFPDYO9s7/Yb
         QhFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYaTdWYTjni1/GXNPBIfBG0G46jiYCsebXQwsfRyS1JhGXikZw03FMe9xBRZSqx+IBd8Mj7qA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7I7lLg1IITf7TCLz/XLI1Cuq5gUN5N4P0QmEY69EwKpPv+RvJ
	tfEQgeOFpzthYaQchWNLwYS4V85il8VmumFV9iNDEeICvcP8mVcqtFerk8WBfVgARZ4OlzwJB6W
	sYwE7dzIWRwixLxXEhCCMQE+1evcnO4IW2xtVqA==
X-Google-Smtp-Source: AGHT+IGHhP6z6uzaMe/SjD7VuC2yupm/LLWj/hEg1VYAOasj1HmGbygRyNh0RqshUk1xmkg0eGSyb+eZTIFDMSpJNeg=
X-Received: by 2002:a05:690c:4b86:b0:6e3:2361:df8c with SMTP id
 00721157ae682-6ee55f1c99dmr80383367b3.42.1731848240497; Sun, 17 Nov 2024
 04:57:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115091545.2358156-1-quic_kriskura@quicinc.com>
 <ibh3n7gl5qcawpiyjgxy2yum6jsmfv5lpfefuun3m2ktldcswl@odhjnmkj5jre> <51f7cfa8-3362-46e3-a9e5-e43d585d4ac0@quicinc.com>
In-Reply-To: <51f7cfa8-3362-46e3-a9e5-e43d585d4ac0@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 17 Nov 2024 14:57:09 +0200
Message-ID: <CAA8EJpoxzEdJ5d8RtEb7a6=NHvCVhnisK7QLpqpp8EBHAvsBhw@mail.gmail.com>
Subject: Re: [PATCH 5.15.y] phy: qcom: qmp: Fix NULL pointer dereference for
 USB Uni PHYs
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Andersson <quic_bjorande@quicinc.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Andy Gross <agross@kernel.org>, Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	quic_ppratap@quicinc.com, quic_jackp@quicinc.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 Nov 2024 at 13:51, Krishna Kurapati
<quic_kriskura@quicinc.com> wrote:
>
>
>
> On 11/15/2024 9:29 PM, Dmitry Baryshkov wrote:
> > On Fri, Nov 15, 2024 at 02:45:45PM +0530, Krishna Kurapati wrote:
> >> Commit [1] introduced DP support to QMP driver. While doing so, the
> >> dp and usb configuration structures were added to a combo_phy_cfg
> >> structure. During probe, the match data is used to parse and identify the
> >> dp and usb configs separately. While doing so, the usb_cfg variable
> >> represents the configuration parameters for USB part of the phy (whether
> >> it is DP-Cobo or Uni). during probe, one corner case of parsing usb_cfg
> >> for Uni PHYs is left incomplete and it is left as NULL. This NULL variable
> >> further percolates down to qmp_phy_create() call essentially getting
> >> de-referenced and causing a crash.
> >
> > The UNI PHY platforms don't have usb3-phy subnode. As such the usb_cfg
> > variable should not be used in the for_each_available_child_of_node()
> > loop.
> >
> > Please provide details for the platform on which you observe the crash
> > and the backtrace.
> >
>
> I got this error when I started working on multiport support (begining
> of 2023). Initially I tried testing on my code on 5.15, hence this patch
> was raised on the same.
>
> The 2 qmp phys on sa8195 and sa8295 (based on sc8280xp) are uni phy and
> the following was the DT node that worked out for me on 5.15 codebase:
>
>
>         usb_1_qmpphy: ssphy@88eb000 {
>                 compatible = "qcom,sm8150-qmp-usb3-uni-phy";
>                 reg = <0x088eb000 0x200>;
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>                 ranges;
>                 //status = "disabled";
>                 clocks = <&gcc GCC_USB3_MP_PHY_AUX_CLK>,
>                          <&rpmhcc RPMH_CXO_CLK>,
>                          <&gcc GCC_USB3_SEC_CLKREF_CLK>,
>                          <&gcc GCC_USB3_MP_PHY_COM_AUX_CLK>;
>                 clock-names = "aux", "ref_clk_src", "ref", "com_aux";
>
>                 resets = <&gcc GCC_USB3UNIPHY_PHY_MP0_BCR>,
>                          <&gcc GCC_USB3_UNIPHY_MP0_BCR>;
>                 reset-names = "phy", "common";
>
>                 //vdda-phy-supply = <&L3C>;
>                 vdda-pll-supply = <&L5E>;
>
>                 usb_1_ssphy: usb3-phy@88eb200 {

As this is a UNI PHY and not a combo PHY, the child node should be
just phy@, not usb3-phy@. See
Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml

>                         reg = <0x088eb200 0x200>,
>                               <0x088eb400 0x200>,
>                               <0x088eb800 0x800>,
>                               <0x088eb600 0x200>;
>                         #clock-cells = <0>;
>                         #phy-cells = <0>;
>                         clocks = <&gcc GCC_USB3_MP_PHY_PIPE_0_CLK>;
>                         clock-names = "pipe0";
>                         clock-output-names = "usb3_uni_phy_pipe_clk_src";
>                 };
>         };
>
>
> I was hitting the bug when I write the DT above way on top of 5.15 baseline.
>
> In 5.15.y, the SM8150 usb_2_qmpphy dT is as follows:
>
>                  usb_2_qmpphy: phy@88eb000 {
>                          compatible = "qcom,sm8150-qmp-usb3-uni-phy";
>                          reg = <0 0x088eb000 0 0x200>;
>                          status = "disabled";
>                          #address-cells = <2>;
>                          #size-cells = <2>;
>                          ranges;
>
>                          clocks = <&gcc GCC_USB3_SEC_PHY_AUX_CLK>,
>                                   <&rpmhcc RPMH_CXO_CLK>,
>                                   <&gcc GCC_USB3_SEC_CLKREF_CLK>,
>                                   <&gcc GCC_USB3_SEC_PHY_COM_AUX_CLK>;
>                          clock-names = "aux", "ref_clk_src", "ref",
> "com_aux";
>
>                          resets = <&gcc GCC_USB3PHY_PHY_SEC_BCR>,
>                                   <&gcc GCC_USB3_PHY_SEC_BCR>;
>                          reset-names = "phy", "common";
>
>                          usb_2_ssphy: phy@88eb200 {

Just as I wrote, this one correctly uses phy@

>                                  reg = <0 0x088eb200 0 0x200>,
>                                        <0 0x088eb400 0 0x200>,
>                                        <0 0x088eb800 0 0x800>,
>                                        <0 0x088eb600 0 0x200>;
>                                  #clock-cells = <0>;
>                                  #phy-cells = <0>;
>                                  clocks = <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>;
>                                  clock-names = "pipe0";
>                                  clock-output-names =
> "usb3_uni_phy_pipe_clk_src";
>                          };
>                  };
>
> IIRC, when I tried using the above sm8150 dt on 5.15.y, the phy_create
> was (either not getting called) or crashing. Probably because
> "of_node_name_eq()" didn't find either "dp-phy" or "usb3-phy" and cfg
> variable was NULL.

Unless somebody backported some patch in an incorrect way, the SM8150
DT entry is correct, while SA8xxx is not,

>
> I can try reproducing the issue and get back again in a week.

Yes, please.

>
> Apologies if I have misunderstood something and this patch doesn't make
> sense. Let me know if I have made any mistake anywhere (either in my DT)
> or in understanding.
>
> Regards,
> Krishna,



-- 
With best wishes
Dmitry

