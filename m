Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6267CF69B
	for <lists+stable@lfdr.de>; Thu, 19 Oct 2023 13:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345363AbjJSLWm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 19 Oct 2023 07:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345340AbjJSLWl (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 19 Oct 2023 07:22:41 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336AC12F
        for <stable@vger.kernel.org>; Thu, 19 Oct 2023 04:22:39 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507b18cf2e1so5508295e87.3
        for <stable@vger.kernel.org>; Thu, 19 Oct 2023 04:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697714557; x=1698319357; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JF3I+wTLcoIXHkUlqgyCgajBza1SKWve0FuhZ7R74mQ=;
        b=MjJyjHIm/7nbx/A2nNmykGOUKOAM+oZp1ydNLgCHWpflNhu+wm/MgHbvzqkQ6l+pid
         Ml7bMm44FXr1S/1d9qUt0vZySzGXh8FmAJ/AQIWWkG0EEbbsXtRaMJcvxT+5d/MKAvwB
         jTliervsvC3JsO+LKSyNgVasagxdoEuyd4EIfjRnnO3BBF90B41TMoUdUtGd0em3YZZD
         M6CYdzCoiG7DogP7TB8VAcGn92GpY+t3kKyt4QLQ1tEnA7Jna7xYZASI3fEeyD7DDVJf
         UI0b3qrGWHKt1rKZKVWsplxO7NJzReVlCrQHNSC4Ppk9ov3WiG3SsKUkPYuKwjU9M6AS
         iwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697714557; x=1698319357;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JF3I+wTLcoIXHkUlqgyCgajBza1SKWve0FuhZ7R74mQ=;
        b=rPFdEn3N4ZlfMBMLApCsEVVK83HKpsy+3LfAdtUIosYa3zN9zWrCKkuJFhta3AASIU
         ZVEFeb5722KQabbhkNQFsPqe8HmdaYqhCvUpGW/ZFMdSVqPTsVfQTsHXcn454WojOHzd
         UkOg9kTgHgng6QLbzDiXaDPPYcIoLWwurtra8ykzpDnGJrXls1bT6wtpgqBfTjYg2ChE
         UhVFxvJxlIH35KaRSxe8nSwm5QnhNnrXwbvV3gAgNh8A6nMeiUkoViCTpyNhhqQQXDJt
         N0CYTsUAcojHKQJ3hgYieJNKhr2SufsFwYQA4eFbJ3X49c9LS8XumtnJQheTfeurs4LE
         NvPg==
X-Gm-Message-State: AOJu0YyMKWKvXbT4QS8KJkRjw0VsxRNhn4PNpOkCbuXz1iieYGkk+9th
        iQ5SgZnKwF3RXgeGHvoEbzTI+w==
X-Google-Smtp-Source: AGHT+IGHu1SthsKQxFVZ5zrdpJuE4LvCEAyyAzSdVgld40OewvREW+BFTjg7BmlIMUrvGbJa0COjEA==
X-Received: by 2002:a05:6512:2038:b0:507:9693:12aa with SMTP id s24-20020a056512203800b00507969312aamr1286536lfs.15.1697714557365;
        Thu, 19 Oct 2023 04:22:37 -0700 (PDT)
Received: from [172.30.205.86] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id e7-20020a195007000000b0050574829e48sm1075529lfb.298.2023.10.19.04.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 04:22:36 -0700 (PDT)
Message-ID: <76b652c8-041c-49d6-9804-2781fe2ccfe3@linaro.org>
Date:   Thu, 19 Oct 2023 13:22:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] clk: qcom: ipq8074: drop the CLK_SET_RATE_PARENT
 flag from PLL clocks
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Devi Priya <quic_devipriy@quicinc.com>,
        Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        stable@vger.kernel.org
References: <20230913-gpll_cleanup-v2-0-c8ceb1a37680@quicinc.com>
 <20230913-gpll_cleanup-v2-1-c8ceb1a37680@quicinc.com>
 <76f3bc23-8677-42bd-a3a5-43b17cbe552e@linaro.org>
 <c3dfeecf5cde513cf675b2f1a382f7a4.sboyd@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <c3dfeecf5cde513cf675b2f1a382f7a4.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 10/19/23 02:16, Stephen Boyd wrote:
> Quoting Konrad Dybcio (2023-09-15 05:19:56)
>> On 14.09.2023 08:59, Kathiravan Thirumoorthy wrote:
>>> GPLL, NSS crypto PLL clock rates are fixed and shouldn't be scaled based
>>> on the request from dependent clocks. Doing so will result in the
>>> unexpected behaviour. So drop the CLK_SET_RATE_PARENT flag from the PLL
>>> clocks.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: b8e7e519625f ("clk: qcom: ipq8074: add remaining PLL’s")
>>> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
>>> ---
>> Stephen, do you think there should be some sort of error
>> or at least warning thrown when SET_RATE_PARENT is used with
>> RO ops?
>>
> 
> Sure? How would that be implemented?
drivers/clk/clk.c : static void clk_change_rate()

if (!skip_set_rate && core->ops->set_rate)
	core->ops->set_rate(core->hw, core->new_rate, best_parent_rate);

->

if (!skip_set_rate) {
	if (core->ops->set_rate)
		core->ops->set_rate(core->hw, core->new_rate,
				    best_parent_rate);
	else
		pr_err("bad idea");
}

Konrad
