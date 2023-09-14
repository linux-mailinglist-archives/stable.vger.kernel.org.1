Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA567A04C8
	for <lists+stable@lfdr.de>; Thu, 14 Sep 2023 15:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbjINNDW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 14 Sep 2023 09:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238444AbjINNDV (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 14 Sep 2023 09:03:21 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D59D1FD0
        for <stable@vger.kernel.org>; Thu, 14 Sep 2023 06:03:17 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d7e387c33f3so979831276.1
        for <stable@vger.kernel.org>; Thu, 14 Sep 2023 06:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694696597; x=1695301397; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aCsgoVc5MdDS0OEMSd5NVyJPQJml3xjCRjHmB8pQyQU=;
        b=UmE2vFAwharNvYSJfAL72mxudS2a4wmMf/TkC49VsGZd89aOhrQvypUzbF7VHtx+5a
         YC0BViG1cIGoWdpq0Wk1WSpeJL+12Xh2uJyvSYm4SC027sk8+3R+pbPXDyFh0sgVh+zq
         +toHzyaCDhS2DVcf+VzvePK3BfVZmovOBVq2KdwMDfy5PAWy12EcC9/a0poZjYvQyi/L
         CNS44n8C13mCfK+ICsZayqr9N842nE3AoEGju5c4BBD/ulhQAdP6J0AO99JNrOrCt24I
         Ayvd+SP0ciP7DovwVIQLwsp++nn1D6dz0sQPsuh3QoBcK5aT0bUCOLTT6cWsXl9M78IH
         b8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694696597; x=1695301397;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aCsgoVc5MdDS0OEMSd5NVyJPQJml3xjCRjHmB8pQyQU=;
        b=d7nJjYuYWf6VdV7H7r/bmMS2uV4Ja+lut4YxZuoi29B165ZWPC/Qt1u9zd20GsnyGa
         4G/oCaUjRTReQeSWuyrLUCV5laqDnrboNoAnxB2y7j1JqrEYzoBC7/xGNTkqPuVQ28QD
         Jh6H6rsbv+sPeY0ifdYen211aQ1z6nEyKPp3lmEO3ZeUxdr3qbrEpDqegwdOJ+QWGi3P
         wxp+uSVPNhNp/gTWw/Y9KtWKByZyoU04Fnokd5BnwlP7KX81oJZ1pY3D2x3XYzE+X7xY
         NAK+8V1roojK5c1+Ta1Dazks5FsYuvaQhOffTkSRoiMfvxpmdRZvsYuYyl8mVVHAfmBy
         WSug==
X-Gm-Message-State: AOJu0Yz2DWKVi6/S6ndA9Yey5eBinHm+P5979+dqT8mHI9/RhhiFvgtR
        ZBgNyjthoFXReUvvnPcV9rs3179Pj48rTKbmoGsJlQ==
X-Google-Smtp-Source: AGHT+IHtq67DZntMzVUKa/tcZfvAY9V5Pu2y+pL8a0RH0Ax2Jq7NeiRTvdNMEGDNeImVEaPGukeWC05mKHKjfg4DqmE=
X-Received: by 2002:a5b:449:0:b0:d54:b34c:1c7b with SMTP id
 s9-20020a5b0449000000b00d54b34c1c7bmr4766279ybp.59.1694696596656; Thu, 14 Sep
 2023 06:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230825135503.282135-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230825135503.282135-1-krzysztof.kozlowski@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Sep 2023 15:02:40 +0200
Message-ID: <CAPDyKFpZnoVnZt-WN_5YdqesoT_Xcbs56tJunwS5oNZSJySxgg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: sdhci-msm: correct minimum number
 of clocks
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, 25 Aug 2023 at 15:55, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> In the TXT binding before conversion, the "xo" clock was listed as
> optional.  Conversion kept it optional in "clock-names", but not in
> "clocks".  This fixes dbts_check warnings like:
>
>   qcom-sdx65-mtp.dtb: mmc@8804000: clocks: [[13, 59], [13, 58]] is too short
>
> Cc: <stable@vger.kernel.org>
> Fixes: a45537723f4b ("dt-bindings: mmc: sdhci-msm: Convert bindings to yaml")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 80141eb7fc6b..10f34aa8ba8a 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -69,7 +69,7 @@ properties:
>      maxItems: 4
>
>    clocks:
> -    minItems: 3
> +    minItems: 2
>      items:
>        - description: Main peripheral bus clock, PCLK/HCLK - AHB Bus clock
>        - description: SDC MMC clock, MCLK
> --
> 2.34.1
>
