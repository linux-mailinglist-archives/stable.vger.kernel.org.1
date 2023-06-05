Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93127722590
	for <lists+stable@lfdr.de>; Mon,  5 Jun 2023 14:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjFEMYR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 5 Jun 2023 08:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbjFEMYK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Jun 2023 08:24:10 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D976DBD
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 05:24:08 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so5937529e87.3
        for <stable@vger.kernel.org>; Mon, 05 Jun 2023 05:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685967847; x=1688559847;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v1oCugcv9e8PDCZgVOtz+CT0CGXVq0farPi5ZReqnSU=;
        b=XKn9Ja/VrCnXmb+vPU7OaaQtn8AhPwWenq/sc3Ett7vrne1fOPRiPKHQY7cRxzF+of
         7zNM5WPmxSuTGerSEQIsY5wNAfJE99bGT9oUVjB5QDMeUDFIkiShbktiYeN9vAqm0XDp
         Pg91H7+XBDePc7WkKIyxU1vEl4dEuH8tbUEt1W/Gu8blfhWzmI/7vhvcpKaCQIixHXa4
         FYifubRKMkj8pcV69CRERexZxY/NGrttXK3AHdM3uZu/rQ/MMBL04g0sN/aXmRTXkqyf
         RKhZSi7fvS6WVu2WoVe3awIFaFBvTuHsSqgE+W1NbTBzR5dBaK//i+/L/ph333k/Yjyk
         hN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685967847; x=1688559847;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v1oCugcv9e8PDCZgVOtz+CT0CGXVq0farPi5ZReqnSU=;
        b=Hwjmdb5TFKfgqdArce4qccdlGheQG9fLB0a1GLhZyVLE2bCSy2Qf8MgVfwt921ozCA
         C/aLkULmrdQhnTC4i0+m1CbtDvItXqURXXiZvl9dgLjXl4UOKcQVDn4DCa049a+h+jUb
         9MYPWQTVndJ4Isr8iRXAEohDLjSdDoqzeYamVUz5UjHpIampr2AiMnUmul56fX0+rYdW
         g4ll0+l1qfknIRRVpRU7nEqmtOVxP33YJ/ytC8mKFZSkVn4fqJYRgdDFbroUdxaIaR27
         z0VEeZ69MNWoGn8V/rhfh0U371GgoMHdF2abBNoruqXtzDMt4VfapVKKavnljCcSaP6I
         qStw==
X-Gm-Message-State: AC+VfDwdxzJJSAadiRuLss1DMOOuUFoX7TXbfCAy5Go3d8xKn6tj2RTK
        M94Mfj9b2Kql8/4DMw92f9juwg==
X-Google-Smtp-Source: ACHHUZ5mIXxubACaNX3T1qugmzFiFiORbjeTKZQpU6qO+lnYpYsYcyBwBi914ZyUighJAI5A6WLI6Q==
X-Received: by 2002:ac2:5222:0:b0:4f6:2593:b75c with SMTP id i2-20020ac25222000000b004f62593b75cmr1816329lfl.52.1685967847177;
        Mon, 05 Jun 2023 05:24:07 -0700 (PDT)
Received: from [192.168.0.107] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id h9-20020a056000000900b002f9e04459desm9746915wrx.109.2023.06.05.05.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 05:24:06 -0700 (PDT)
Message-ID: <9e2f734c-8b71-27ce-16f4-302f77138133@linaro.org>
Date:   Mon, 5 Jun 2023 13:24:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: FAILED: patch "[PATCH] net: cdc_ncm: Deal with too low values of
 dwNtbOutMaxSize" failed to apply to 4.14-stable tree
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     kuba@kernel.org, simon.horman@corigine.com, stable@vger.kernel.org,
        Lee Jones <joneslee@google.com>
References: <2023052625-mutual-punch-5c0b@gregkh>
 <4f0cac8d-ef9b-5c97-3076-8a6a78e11137@linaro.org>
 <2023060524-pluck-undermost-a9e1@gregkh>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <2023060524-pluck-undermost-a9e1@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 6/5/23 12:19, Greg KH wrote:
> On Mon, Jun 05, 2023 at 12:07:20PM +0100, Tudor Ambarus wrote:
>> Hi!
>>
>> In order to apply this without conflicts to 4.14-stable, one needs to
>> apply a dependency, thus the sequence is:
>>
>> 7e01c7f7046e ("net: cdc_ncm: Deal with too low values of dwNtbOutMaxSize")
>> 0fa81b304a79 ("cdc_ncm: Implement the 32-bit version of NCM Transfer Block")
>>
>> Let me know if you want me to send the patches explicitly.
> 
> Please do, as 7e01c7f7046e does not apply at all either.
> 

It was the other way around. Sent the patches at:
https://lore.kernel.org/all/20230605122045.2455888-1-tudor.ambarus@linaro.org/

Thanks,
ta
