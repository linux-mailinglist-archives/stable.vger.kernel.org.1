Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276937262D3
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 16:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241060AbjFGOaf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 10:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240850AbjFGOae (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 10:30:34 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C457F1FC4
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 07:30:30 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-97460240863so990767366b.0
        for <stable@vger.kernel.org>; Wed, 07 Jun 2023 07:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686148229; x=1688740229;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=09wjGjuF8BafJz5/rIk0zFD7cGTqxzAdsPZzNoJir4A=;
        b=jiBTqH/2bFljhkZ7rYTVEpCajh27br6re37VyXRZTW9S37k25kAA4ZR8ammFIMoW6z
         Y8c1BLeMn6Ja1k1Pum02IMIYZvZJxxea7eow4BGwgU8waPsX5kowUv2h75q+JjHzcFqq
         xi78YUQG3JDJRYmU9gDbqgaZ/7ZqvI6cIy1AMM1xgiZkCOByVJOs6ryYRaWgjSHKCsUr
         669Sblqe5xRuA0NtMwj23K5giYHQSztjsADFhit7IwjYzwyIUMw+lidPK0H2oeaP/PMp
         q7Qv4f4fB0GDfZS3uxvYn3YWD5W8CnyhJ/nqSVlFpMDoDi31LwtSc2JY5W5lAcFUgLxo
         m7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686148229; x=1688740229;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=09wjGjuF8BafJz5/rIk0zFD7cGTqxzAdsPZzNoJir4A=;
        b=MiKeB+DwZH+VhhL2uj7Lcz5QAgpqYk4MJBL38BkY0nsDZWRaN4Pk67tkHdPGXw1hxQ
         p6HNZhc41SjyFmHhcVYrXw6hmlMlmkGPgYvGnbeDRykmzKUMJB4uSB8VP1AWxBQBe2t1
         ykuuu9nnbSr3N5OJWV4sV9jHfpCTdpnSpbnTbziOI1WjD1Voh3E5gjGkX7wSGHS5ylqb
         rtN9P/hyRuhwyNPP6lnfkeBXQFKJQhFsk2pVG6tLDYBExh8TXmM1tlYXe9yyekFmm2c8
         EUTPmbDMSfj1MzAZGywxElR4qUYZqaarxgqR3IPUHb59INw0bE1o0fqpKiRlCqCGCu6j
         Resw==
X-Gm-Message-State: AC+VfDwzAzzu2vwIpr7D9SM7l71sy0l3MkTyCgeAuOCyrKcIqwOAUlGg
        wFfo5mU94cL4WDp5xt1u/TD0wQ==
X-Google-Smtp-Source: ACHHUZ6ID42MXAI0o8qCiY3ZLSzc3b/0MU2uU/cmT4za4Yi4tFXGx9q6fR/OHY0td5MgGgpabMriYg==
X-Received: by 2002:a17:907:98e:b0:970:553:272c with SMTP id bf14-20020a170907098e00b009700553272cmr6066260ejc.27.1686148228914;
        Wed, 07 Jun 2023 07:30:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id w22-20020a170906185600b00977d02973e8sm4759226eje.0.2023.06.07.07.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 07:30:28 -0700 (PDT)
Message-ID: <f5cfc81d-d8ae-d270-f29a-c2b45b07a651@linaro.org>
Date:   Wed, 7 Jun 2023 16:30:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v8 05/10] dt-bindings: sc16is7xx: Add property to change
 GPIO function
Content-Language: en-US
To:     Hugo Villeneuve <hugo@hugovil.com>, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        jesse.sung@canonical.com, isaac.true@canonical.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Lech Perczak <lech.perczak@camlingroup.com>
References: <20230607140525.833982-1-hugo@hugovil.com>
 <20230607140525.833982-6-hugo@hugovil.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230607140525.833982-6-hugo@hugovil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 07/06/2023 16:05, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Some variants in this series of UART controllers have GPIO pins that
> are shared between GPIO and modem control lines.
> 
> The pin mux mode (GPIO or modem control lines) can be set for each
> ports (channels) supported by the variant.
> 
> This adds a property to the device tree to set the GPIO pin mux to
> modem control lines on selected ports if needed.
> 
> Cc: <stable@vger.kernel.org> # 6.1.x
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
> ---
>  .../bindings/serial/nxp,sc16is7xx.txt         | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> index 0fa8e3e43bf8..1a7e4bff0456 100644
> --- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> +++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> @@ -23,6 +23,9 @@ Optional properties:
>      1 = active low.
>  - irda-mode-ports: An array that lists the indices of the port that
>  		   should operate in IrDA mode.
> +- nxp,modem-control-line-ports: An array that lists the indices of the port that
> +				should have shared GPIO lines configured as
> +				modem control lines.
>  
>  Example:
>          sc16is750: sc16is750@51 {
> @@ -35,6 +38,26 @@ Example:
>                  #gpio-cells = <2>;
>          };
>  
> +	sc16is752: sc16is752@53 {

Since you keep sending new versions, fix the names. nNode names should
be generic. See also explanation and list of examples in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Best regards,
Krzysztof

