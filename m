Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1CB799845
	for <lists+stable@lfdr.de>; Sat,  9 Sep 2023 15:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbjIINC3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 9 Sep 2023 09:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjIINC2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 9 Sep 2023 09:02:28 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7689C
        for <stable@vger.kernel.org>; Sat,  9 Sep 2023 06:02:23 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-5736caaf151so1739754eaf.3
        for <stable@vger.kernel.org>; Sat, 09 Sep 2023 06:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694264543; x=1694869343; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5EP2QvaTRcaCpTUfCzy97sE7hkb0vHpi9DaQsg1ESww=;
        b=UhEF5+eXlmc6rwBVWpwZNnC3YZm13QMS0pmxM2S51ETC9i9kop2zLv9bTHMjeHYAbN
         7NLdzrM4cCtj6EluOpF2H+yguhPPUyKRXx/mVOS5tZGkO4Nry+lKV7OqzUe6b8L42Emw
         7+rF1PK1fdNiR3Ikza9ZPrWeF2wb2pKVwzrq3lGuFpe12wOAMJBHThrngsGVHnN859YL
         oPILNVnIHFQAJkO5UHNDjQomNlzy/YQb2LskgawMafjwt3iklPpOJ+Az/Xnc5ZrqdWn5
         X9mxETBbvvXFYjA3K4eLRcwzW3hOOcbk1yxj0s6jm0BYSg7tuUi8R96OISSu9kCXSt1A
         zaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694264543; x=1694869343;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5EP2QvaTRcaCpTUfCzy97sE7hkb0vHpi9DaQsg1ESww=;
        b=bomx9c/2l04ZTAMOUJOcsP62fWQIESdBfwEoWmFiPBso+aotp2esxztQ0WKl+HNwip
         2BOIMIw7fGn8wKk6tXGd0g9EtNspfyp/O9FXAjWask5QbVEXOlz+Drr7MoOXURgPpaP4
         Gu/VitVYuhbhp8lIlbiBK4tYo3aPH/JiWPrULJ4ioXAMg/rO0wb6uSm4wV83cUCF42v0
         xdNpgwU5fRYYaNZFw1gopZM90ob32yRgZgBqM31XcpkDdJB9fYzJZPH3c3yPSz6aqeuz
         TBqHUK0iIx5dgOyg+tHXLVoVr8Wp0tDxVLPK1kvo3I/A6OMmtJheEB1Y/QUx4KBL1Jw5
         JQSA==
X-Gm-Message-State: AOJu0Ywb8yjoTC5Wo/MwzFkrctfZKCiiaVzEPiQzZivk+LCMYZVNn52F
        pfkPqQqXqOxKWGvTYgQjqI7uJLrtR5BT2DauWpb91A==
X-Google-Smtp-Source: AGHT+IHfu/WgD/wObaJilJM9tjzCDyYm7Gk02NhSsxBB9Kftz5ayy70MUJHKLiYe4OS92PYAcukp5bqlA7NXuxaI718=
X-Received: by 2002:a05:6358:9315:b0:131:b4c:b871 with SMTP id
 x21-20020a056358931500b001310b4cb871mr4596392rwa.22.1694264543169; Sat, 09
 Sep 2023 06:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <2023090923-conform-underwear-d8bd@gregkh>
In-Reply-To: <2023090923-conform-underwear-d8bd@gregkh>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Sat, 9 Sep 2023 18:31:46 +0530
Message-ID: <CAMi1Hd3scukKpc9iwV+B-eT3ZUO5o7eO72=-eiRsOrwCvtLozA@mail.gmail.com>
Subject: Re: Patch "arm64: dts: qcom: sdm845-db845c: Mark cont splash memory
 region as reserved" has been added to the 5.10-stable tree
To:     gregkh@linuxfoundation.org, stable <stable@vger.kernel.org>
Cc:     andersson@kernel.org, caleb.connolly@linaro.org,
        krzysztof.kozlowski@linaro.org, stable-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, 9 Sept 2023 at 18:16, <gregkh@linuxfoundation.org> wrote:
>
>
> This is a note to let you know that I've just added the patch titled
>
>     arm64: dts: qcom: sdm845-db845c: Mark cont splash memory region as reserved
>
> to the 5.10-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
> The filename of the patch is:
>      arm64-dts-qcom-sdm845-db845c-mark-cont-splash-memory-region-as-reserved.patch
> and it can be found in the queue-5.10 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>

Please skip this patch for 5.10.y. We ran into a boot (mdss crash)
regression with this patch.

Regards,
Amit Pundir

>
> From 110e70fccce4f22b53986ae797d665ffb1950aa6 Mon Sep 17 00:00:00 2001
> From: Amit Pundir <amit.pundir@linaro.org>
> Date: Wed, 26 Jul 2023 18:57:19 +0530
> Subject: arm64: dts: qcom: sdm845-db845c: Mark cont splash memory region as reserved
>
> From: Amit Pundir <amit.pundir@linaro.org>
>
> commit 110e70fccce4f22b53986ae797d665ffb1950aa6 upstream.
>
> Adding a reserved memory region for the framebuffer memory
> (the splash memory region set up by the bootloader).
>
> It fixes a kernel panic (arm-smmu: Unhandled context fault
> at this particular memory region) reported on DB845c running
> v5.10.y.
>
> Cc: stable@vger.kernel.org # v5.10+
> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Link: https://lore.kernel.org/r/20230726132719.2117369-2-amit.pundir@linaro.org
> Signed-off-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts |    9 +++++++++
>  1 file changed, 9 insertions(+)
>
> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> @@ -85,6 +85,14 @@
>                 };
>         };
>
> +       reserved-memory {
> +               /* Cont splash region set up by the bootloader */
> +               cont_splash_mem: framebuffer@9d400000 {
> +                       reg = <0x0 0x9d400000 0x0 0x2400000>;
> +                       no-map;
> +               };
> +       };
> +
>         lt9611_1v8: lt9611-vdd18-regulator {
>                 compatible = "regulator-fixed";
>                 regulator-name = "LT9611_1V8";
> @@ -482,6 +490,7 @@
>  };
>
>  &mdss {
> +       memory-region = <&cont_splash_mem>;
>         status = "okay";
>  };
>
>
>
> Patches currently in stable-queue which might be from amit.pundir@linaro.org are
>
> queue-5.10/arm64-dts-qcom-sdm845-db845c-mark-cont-splash-memory-region-as-reserved.patch
