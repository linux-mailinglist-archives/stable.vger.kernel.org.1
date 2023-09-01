Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6407900CA
	for <lists+stable@lfdr.de>; Fri,  1 Sep 2023 18:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346107AbjIAQgT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 1 Sep 2023 12:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345991AbjIAQgS (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 1 Sep 2023 12:36:18 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091C810EC
        for <stable@vger.kernel.org>; Fri,  1 Sep 2023 09:36:15 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d7830c5b20aso236353276.0
        for <stable@vger.kernel.org>; Fri, 01 Sep 2023 09:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693586174; x=1694190974; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7LEzHt4NZiik9U85JbASFK8/bDKDKmrv1K/mkDPZW1E=;
        b=ilyo1tBe4hOn4QUrWd+D5ff3cElsRun22YDz8reDZW6mfJHgPKOneMDcweGeVOn+l/
         v0zH112jSuecxus9TAgwdXebCgMXad7yDN7gTonNjN/5W7EfXqnonY1U2CPRTe8ftr3/
         ixBMjteORaduQGro03sOz2GHtlInSJoxf91cSUo8AMoMg9hZ1TDQgCp31hRrXPf+sAzk
         oGaIuPWYZDVD2w+Kaecf16rZg1a0EDa0QtFK8LcPPuBB/2mkknR5HKMKvKkYZEdQ0ecX
         zprXN0CmqSOywXa3JUmNewTfbB/H9SKF0RmejBiB+A65h39oHjgPdYUuHA9Ip+KFb3Gn
         mXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693586174; x=1694190974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7LEzHt4NZiik9U85JbASFK8/bDKDKmrv1K/mkDPZW1E=;
        b=NlRQZWkkoQNqRkuuxtyE4v7aHqWD1ElaoMAW/DoWpKyOmGvjV/CeDDvTQiBQSziJoq
         Tq7s4vwA5gEhSXn0MWgVR3ZReIBWKfr7zsfpHVy/uEFqmQ9Mjp3QGlcc6cA8mTjoYclH
         afCVMTh95B5W89EBg4liBpRSLOilP8C/a8ZWAP/ad0/52EFyjzEms/rD+rCbhTSkF16l
         37BvbRzhMJJekpTzvJW+WXZCS2y/wHQFKiBTkL7KeKcg8VKp+jP1fJ4UzSHdB45Cb7Gz
         Hh+I5c6xStvhXuPqOMJDG205fex09n9nI2s0hAcmpx3bYaiW1CD+PlLjIyKpSUUxLtEg
         uUyg==
X-Gm-Message-State: AOJu0YySy2uI2v7qnip4rcP75I9zDevCxelHFpiXmbdV77Y9XkrDj8oU
        Wb85LkhrV+8todm7WaQJDclY2wWm6uc8ADk9azIcmA==
X-Google-Smtp-Source: AGHT+IHPM6b0WFdVup+/QotG7mEFQrLBe/HDdJxJ2M6uo15O9+njzMi1H61REGJ59HMd9LgJTvuinNk6gH9jPMPrr9U=
X-Received: by 2002:a25:ae89:0:b0:d78:414d:1910 with SMTP id
 b9-20020a25ae89000000b00d78414d1910mr4401918ybj.25.1693586174181; Fri, 01 Sep
 2023 09:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230901081812.19121-1-krzysztof.kozlowski@linaro.org> <20230901081812.19121-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230901081812.19121-2-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 1 Sep 2023 19:36:03 +0300
Message-ID: <CAA8EJpoOVaDptuo9u4CaNRi0gJjt4Mr65Os3XJTf3-Sbk280gQ@mail.gmail.com>
Subject: Re: [RFT PATCH 2/2] arm64: dts: qcom: msm8996-xiaomi: fix missing
 clock populate
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, 1 Sept 2023 at 11:18, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Commit 338958e30c68 ("arm64: dts: qcom: msm8996-xiaomi: drop simple-bus
> from clocks") removed "simple-bus" compatible from "clocks" node, but
> one of the clocks - divclk1 - is a gpio-gate-clock, which does not have
> CLK_OF_DECLARE.  This means it will not be instantiated if placed in
> some subnode.  Move the clocks to the root node, so regular devices will
> be populated.

I don't think this is a good idea. We have other fixed clocks under
/clocks. And they have been always working. I think the better way
would be to teach clk-gpio to work with CLK_OF_DECLARE

>
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Closes: https://lore.kernel.org/all/CAA8EJprF==p87oN+RiwAiNeURF1JcHGfL2Ez5zxqYPRRbN-hhg@mail.gmail.com/
> Cc: <stable@vger.kernel.org>
> Fixes: 338958e30c68 ("arm64: dts: qcom: msm8996-xiaomi: drop simple-bus from clocks")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../boot/dts/qcom/msm8996-xiaomi-common.dtsi  | 32 +++++++++----------
>  .../boot/dts/qcom/msm8996-xiaomi-gemini.dts   | 16 ++++------
>  2 files changed, 22 insertions(+), 26 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
> index bcd2397eb373..06f8ff624181 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
> @@ -11,26 +11,24 @@
>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>
>  / {
> -       clocks {
> -               divclk1_cdc: divclk1 {
> -                       compatible = "gpio-gate-clock";
> -                       clocks = <&rpmcc RPM_SMD_DIV_CLK1>;
> -                       #clock-cells = <0>;
> -                       enable-gpios = <&pm8994_gpios 15 GPIO_ACTIVE_HIGH>;
> +       divclk1_cdc: divclk1 {
> +               compatible = "gpio-gate-clock";
> +               clocks = <&rpmcc RPM_SMD_DIV_CLK1>;
> +               #clock-cells = <0>;
> +               enable-gpios = <&pm8994_gpios 15 GPIO_ACTIVE_HIGH>;
>
> -                       pinctrl-names = "default";
> -                       pinctrl-0 = <&divclk1_default>;
> -               };
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&divclk1_default>;
> +       };
>
> -               divclk4: divclk4 {
> -                       compatible = "fixed-clock";
> -                       #clock-cells = <0>;
> -                       clock-frequency = <32768>;
> -                       clock-output-names = "divclk4";
> +       divclk4: divclk4 {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <32768>;
> +               clock-output-names = "divclk4";
>
> -                       pinctrl-names = "default";
> -                       pinctrl-0 = <&divclk4_pin_a>;
> -               };
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&divclk4_pin_a>;
>         };
>
>         gpio-keys {
> diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
> index d1066edaea47..f8e9d90afab0 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
> @@ -20,16 +20,14 @@ / {
>         qcom,pmic-id = <0x20009 0x2000a 0x00 0x00>;
>         qcom,board-id = <31 0>;
>
> -       clocks {
> -               divclk2_haptics: divclk2 {
> -                       compatible = "fixed-clock";
> -                       #clock-cells = <0>;
> -                       clock-frequency = <32768>;
> -                       clock-output-names = "divclk2";
> +       divclk2_haptics: divclk2 {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <32768>;
> +               clock-output-names = "divclk2";
>
> -                       pinctrl-names = "default";
> -                       pinctrl-0 = <&divclk2_pin_a>;
> -               };
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&divclk2_pin_a>;
>         };
>  };
>
> --
> 2.34.1
>


-- 
With best wishes
Dmitry
