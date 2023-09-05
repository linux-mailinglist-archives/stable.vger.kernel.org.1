Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1EF793154
	for <lists+stable@lfdr.de>; Tue,  5 Sep 2023 23:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244413AbjIEVw2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 5 Sep 2023 17:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbjIEVw2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 5 Sep 2023 17:52:28 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5C6D2
        for <stable@vger.kernel.org>; Tue,  5 Sep 2023 14:52:24 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so647766a12.0
        for <stable@vger.kernel.org>; Tue, 05 Sep 2023 14:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693950743; x=1694555543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1sXq4tMf8r0BTPTigD/vFRQoudDkPpomgeI7QgSk3C8=;
        b=RjjyOZU1EqGPscqwSvhLmnoSqcQIPX+xHmwLUtHI7X2YHQPRpuAj/c7GlB193WArVY
         qpGMLFuPbIXgHq8UmkMNjld2CgcgUhcIIAnZRrotvMBs/Mm9pgwDGZTI96sOCoeQi4aV
         X1gs8/svzgpjolRBMpRG3jG03ZgVTK3M1dyQvX6x4LB69AoQhnWLhxKRYV84PcleCAao
         sAy2j0HUK4KanlLzkBUh2ZvJKWmTxLBbkQM3pFF+xHTVynnyWQC6+7uo89/Z6bUG9eTL
         7laVhnMolvqk949Yjnlz2ddPdeFt+L6D9vGbbRO7XMnZ0fG7kHPB3rBnN7MmBgRBgmBK
         NLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693950743; x=1694555543;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1sXq4tMf8r0BTPTigD/vFRQoudDkPpomgeI7QgSk3C8=;
        b=WzNBs7S1nan04Cj0A9mlETeGyNv4RDUlQ0afQ31aU2+25L8DpLhQ9VloURzh1P8KEE
         kayu/qImgCs4BEGuw0+X2NIljUKVWiQwjooDC8/NsTWfHc1p1/idczhLJKYkak4zsMR+
         yQb6vifEElWzn+Rvrn3nu6WvElLzwelflKQM56629p7H3We37b3Efsc8g7YFswaKnNF+
         FQaZn7zadHcNyblyua0oJsHR0tlHD8stvUvCZAbKgr8oqFUI1dhRk/mfsxoDhiIsasjC
         L+uFk1us2K16iQkYPyd5Wj0OX0Lu6kQbFYSx4TFGbWf2vA3vik5pWrVpm5TFCpZitPiY
         abpw==
X-Gm-Message-State: AOJu0Yyjsvg7RxZTALF1xWv4jHXIK1qf3wNu0LAFgyG8FV3bV0zptpzM
        2ktfHkGX8fkccwGo2AKkdrss5A==
X-Google-Smtp-Source: AGHT+IFIais0k3szY6NyGV7Kf+EEyxKBSpYfXVxluyTtAR3ZvSYb875QLxLdksYWv2WENpcP1T0NjA==
X-Received: by 2002:a17:906:9754:b0:9a5:9b93:d60d with SMTP id o20-20020a170906975400b009a59b93d60dmr993645ejy.36.1693950742989;
        Tue, 05 Sep 2023 14:52:22 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id gf16-20020a170906e21000b0098669cc16b2sm8050192ejb.83.2023.09.05.14.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 14:52:22 -0700 (PDT)
Message-ID: <34a95082-ed15-48db-9c64-2ecbe0ccdd6a@linaro.org>
Date:   Wed, 6 Sep 2023 00:52:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT PATCH 2/2] arm64: dts: qcom: msm8996-xiaomi: fix missing
 clock populate
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
References: <20230901081812.19121-1-krzysztof.kozlowski@linaro.org>
 <20230901081812.19121-2-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230901081812.19121-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 01/09/2023 11:18, Krzysztof Kozlowski wrote:
> Commit 338958e30c68 ("arm64: dts: qcom: msm8996-xiaomi: drop simple-bus
> from clocks") removed "simple-bus" compatible from "clocks" node, but
> one of the clocks - divclk1 - is a gpio-gate-clock, which does not have
> CLK_OF_DECLARE.  This means it will not be instantiated if placed in
> some subnode.  Move the clocks to the root node, so regular devices will
> be populated.
> 
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Closes: https://lore.kernel.org/all/CAA8EJprF==p87oN+RiwAiNeURF1JcHGfL2Ez5zxqYPRRbN-hhg@mail.gmail.com/
> Cc: <stable@vger.kernel.org>
> Fixes: 338958e30c68 ("arm64: dts: qcom: msm8996-xiaomi: drop simple-bus from clocks")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../boot/dts/qcom/msm8996-xiaomi-common.dtsi  | 32 +++++++++----------
>   .../boot/dts/qcom/msm8996-xiaomi-gemini.dts   | 16 ++++------
>   2 files changed, 22 insertions(+), 26 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

