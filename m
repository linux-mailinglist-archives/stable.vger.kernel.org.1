Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB26974CDC4
	for <lists+stable@lfdr.de>; Mon, 10 Jul 2023 08:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjGJG7k (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 10 Jul 2023 02:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjGJG7k (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 10 Jul 2023 02:59:40 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C81E5
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 23:59:38 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b6f0508f54so61742591fa.3
        for <stable@vger.kernel.org>; Sun, 09 Jul 2023 23:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688972377; x=1691564377;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KIClO8Lu4EpQRuSM4dQTJsPgeAAmg04f9ozvN8hppFU=;
        b=h66ZEBNcpH4beV2RchzHrF9JSa2iIMx5RlJAfNSm8AGigvGOOjV9G7p6RRYhousOsW
         lJJb6oIBLNS+yiR4Tyasz0GXII2E82fddz4qffWTzaJ690Zj/5Iynl3AbgNJWKsE65z5
         kK77k+ChrwSl7CcEKr1boDwtV4zPhuLnVrTab6Fj6ITEu50v2d72pv/u0hROlb3f65dw
         DcCi5uU4Hxa5nfZBY7nmBEf13SUVa6uDmmjBwaeiovBd5KSTnf5KxGfd2fzdEA/Ed620
         rrdLhq1u/I3ob9diGm4amyOYDQs5CRpYn48AlfyRpgvjOPIEK4eitNzuqgDfXI5obFK0
         HDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688972377; x=1691564377;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KIClO8Lu4EpQRuSM4dQTJsPgeAAmg04f9ozvN8hppFU=;
        b=ZwFpcvcyciqJf5FaF4vUWAB/jIk+BOsL2Wlzg2BD64dgcWw6OVbeLtgrYhl5O23bDp
         5p7zCbIgU2SSsRn5EJw1y2yuf0Y/nQ+6O8OXDSDuRVziM/inQqtPNjWmNnKjRqOlZGd1
         bL+ebYwEuOhQyt3wI+jRw1p0JV0qgh/9OElHmsUvloDDOagVF9dfBkXT+mcD2lvDhd1x
         i1kRovrQT+KUAkABvTaFB1m/YTkkw5tyiYq+hg4u3OSqBBztU0iVXvIKKYr7wFckb2IP
         sZvdusoSY1ewz5zXf6oZXG2h+cHM/DGmOvWRJtYFcIqZargyOvMC8DtKPnd1zXG83nfZ
         s77A==
X-Gm-Message-State: ABy/qLZE9mZfXtHYv54Sfe3dcE1nYIY5SSrHUAv5qAn64e+nLAYGOCnJ
        ZZ3tIcXHrJ4gffzwhF8a/sngYQ==
X-Google-Smtp-Source: APBJJlHdBzz0FIIHNvRSRvaVIuA6CJ8sE0O8DPjVl2svOP7xogmqgfwctSl4QSYL+FVPc+RlxhQs/Q==
X-Received: by 2002:a2e:740a:0:b0:2b6:da66:2d69 with SMTP id p10-20020a2e740a000000b002b6da662d69mr8748695ljc.28.1688972377077;
        Sun, 09 Jul 2023 23:59:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id le26-20020a170907171a00b00987e2f84768sm5687713ejc.0.2023.07.09.23.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 23:59:36 -0700 (PDT)
Message-ID: <98b39071-cbfa-bc58-032e-56f6e9dd5c2a@linaro.org>
Date:   Mon, 10 Jul 2023 08:59:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/3] ARM: dts: exynos/i9100: Fix LCD screen's physical
 size
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, stable@vger.kernel.org
References: <20230708084027.18352-1-paul@crapouillou.net>
 <20230708084027.18352-4-paul@crapouillou.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230708084027.18352-4-paul@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 08/07/2023 10:40, Paul Cercueil wrote:
> The previous values were completely bogus, and resulted in the computed
> DPI ratio being much lower than reality, causing applications and UIs to
> misbehave.
> 
> The new values were measured by myself with a ruler.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Fixes: 8620cc2f99b7 ("ARM: dts: exynos: Add devicetree file for the Galaxy S2")
> Cc: <stable@vger.kernel.org> # v5.8+
> ---

This does not apply. You rebased your work on some older version/tree,
without new layout. Please work on linux-next.

Best regards,
Krzysztof

