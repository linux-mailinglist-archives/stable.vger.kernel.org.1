Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C076FE0E1
	for <lists+stable@lfdr.de>; Wed, 10 May 2023 16:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237626AbjEJO6r (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 10 May 2023 10:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237517AbjEJO6q (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 10 May 2023 10:58:46 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6086868B
        for <stable@vger.kernel.org>; Wed, 10 May 2023 07:58:44 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d4so46797695e9.1
        for <stable@vger.kernel.org>; Wed, 10 May 2023 07:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683730723; x=1686322723;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tEkLDnYi6amM57tdf5gQnUUcHk3hMqAJVN6n+xRcEeo=;
        b=dEpKg1WOUB5ETVmIYDA/QCSUmtZoIWNfO6R6U4Hskff340eWzjX3xFzw190yKhoag9
         f7bGh4mkONO9w8bLWdTj3889mqoYAppqK9ghpsDdLuUmldPAs8gtSrfOFeieieTgBbDv
         8IepZC2UHKdqO26mTTW61BzNrs2dFFBoEbwfAU/7EP/Y07SlPoQgYsiPtPbOqQ+qTPmL
         Lo7gcY3ayCK0bfZIbeamcaGO0cSy+E7dLRZc/14osbSBfc8NWepXU1b/8NavlTMlTZQ4
         uZeVdlkIqHuEs3Fb8LlSKl56ZCLQr39o9u/BwVAJfhiziLPNkZDlQUv73P8ejSWKRJ9C
         uM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683730723; x=1686322723;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tEkLDnYi6amM57tdf5gQnUUcHk3hMqAJVN6n+xRcEeo=;
        b=fk7o5ZaRa98IpvY+J0cRq5GSa7LKd4k8JcKrEIixNIUc0+NyI9y7U+ZWlpnCMyjVkQ
         M6loElAWdPAtqoS7QrobW9cgbIxlcHHZuViX82rlnw6NSasp3JfNZ3EC8rv5kxxVxt7U
         W6bYP/cWV2O2SEFOQtBmEzAhJxYzLq6eYzozFdCGxPCigOyON96PZQuR5W2TsuRhVmzP
         /4ut2drgbne+KoHJ9He6okzdZFRojgT+Hc7s2czNgKa7JIHWRb0mVLRsuyiko5T2jXGs
         EcdKahe4EJLt+BToJGaKMxftI4y9cyWnF1SGbTLp1kuDZx81Cc/624fXqN2a5XSnlBY/
         Oc/w==
X-Gm-Message-State: AC+VfDzV6CZ831fXIQmylUykuY8P+LR5muXOdhgkoShcZM0dXbW8EHWo
        na21PXZOtANoSTSxLGsQjWhHxg==
X-Google-Smtp-Source: ACHHUZ73tOLq3Z/LRshLlvD/QEdXldSGIbtBPgjM4oYjibmsuEAudP6W9JhTrUhldd8HFaYMRce5Mg==
X-Received: by 2002:a7b:c404:0:b0:3f1:6942:e024 with SMTP id k4-20020a7bc404000000b003f16942e024mr13596026wmi.27.1683730722969;
        Wed, 10 May 2023 07:58:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:2ee9:7e58:bce6:9219? ([2a01:e0a:982:cbb0:2ee9:7e58:bce6:9219])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c229100b003f423a04016sm10687507wmf.18.2023.05.10.07.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 07:58:42 -0700 (PDT)
Message-ID: <cfebdda6-6e51-25f5-1c99-1e0b203e749b@linaro.org>
Date:   Wed, 10 May 2023 16:58:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] pinctrl: meson-axg: add missing GPIOA_18 gpio group
Content-Language: en-US
To:     =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>,
        linux-amlogic@lists.infradead.org
Cc:     stable@vger.kernel.org, Xingyu Chen <xingyu.chen@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
References: <20230510141934.112994-1-martin@geanix.com>
Organization: Linaro Developer Services
In-Reply-To: <20230510141934.112994-1-martin@geanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On 10/05/2023 16:19, Martin Hundebøll wrote:
> Without this, the gpio cannot be explicitly mux'ed to its gpio function.
> 
> Fixes: 83c566806a68a ("pinctrl: meson-axg: Add new pinctrl driver for Meson AXG SoC")
> Signed-off-by: Martin Hundebøll <martin@geanix.com>
> ---
>   drivers/pinctrl/meson/pinctrl-meson-axg.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg.c b/drivers/pinctrl/meson/pinctrl-meson-axg.c
> index 7bfecdfba177..d249a035c2b9 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson-axg.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson-axg.c
> @@ -400,6 +400,7 @@ static struct meson_pmx_group meson_axg_periphs_groups[] = {
>   	GPIO_GROUP(GPIOA_15),
>   	GPIO_GROUP(GPIOA_16),
>   	GPIO_GROUP(GPIOA_17),
> +	GPIO_GROUP(GPIOA_18),
>   	GPIO_GROUP(GPIOA_19),
>   	GPIO_GROUP(GPIOA_20),
>   

You're missing some mailing-lists and maintainers in CC, please see output of get_maintainers.

Neil
