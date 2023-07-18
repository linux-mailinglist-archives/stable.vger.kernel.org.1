Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4387575B1
	for <lists+stable@lfdr.de>; Tue, 18 Jul 2023 09:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjGRHuY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 18 Jul 2023 03:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjGRHuW (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 18 Jul 2023 03:50:22 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B08DD
        for <stable@vger.kernel.org>; Tue, 18 Jul 2023 00:50:21 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31454996e06so5098271f8f.2
        for <stable@vger.kernel.org>; Tue, 18 Jul 2023 00:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689666620; x=1692258620;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=72FhdPS3Ipgc+61xo1bTQmq7CNwY+k/csxqHf0W+Kgc=;
        b=eIGrinQLYAnNV+SLaGJPr3GVN2lItD7H1d9sM+vyxsFnJBpMxHOKV7DsBXhFKakXHe
         P8qNDpnSF/6sbzvyNymiywjIK/x/i+njaGplUUqzoi7RLs8hcsAd5tZknLmVoY7oqkZe
         ukm5aQnXn13LcI6A8a0nHEFOHe6kXbYIywBTa5dVj6SM4nO7rfj11duI6uFDeQK5Oey6
         2N+V4MT35geqyok3qOIRTY+pKYUd3XsAiyGp6NGVHu8nKi2aTBq4T4Tf5UVGXrLW+yVr
         1ntpionamnSULrahwiipdSQ2rhMixSw/4HMISUx7EBDQEMjo4jVqbyq6wAp96w1lzN1s
         838Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689666620; x=1692258620;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72FhdPS3Ipgc+61xo1bTQmq7CNwY+k/csxqHf0W+Kgc=;
        b=hN13+I2HqWJMrCFn6Yr7xoh8wbPVR6qE5sQr87Vk+TqIk0KO9c5R0vYoCxfYuKTlEZ
         il99x4LDxaBgCHKtyd3POGrXXjuQkNZEP2CrK4qssMrpHJBzRr2BMBIon0MSgpewO+MM
         9YnMs4A0O+DuvX6kqOKKgmdvn9BdTZKoHx+SfWKd1oZg9ovQ7Zg5Wh2HBZw6ddSyFp4U
         s7nK7wNvZQLVt6uphLyZX8tbhIkJ8UUbDq8EveOidblG/4jlFSQrXvjgAYCfWGqfnrzv
         2+9ypPq+VcmyqVYoBS6t0WTsfASbEDOarTHsFpnEaD+h/5IzTMMsrdnSopFiPhFURjxr
         75og==
X-Gm-Message-State: ABy/qLY36R4zncLQ7EZAuJQ8zqQKjF2roc5Jiy3l7GaCWUD8pPfK+PpH
        XoUsAfbRzWXiN0Ej10QTT2jq4Q==
X-Google-Smtp-Source: APBJJlG8EPUE1XziNnCoSl2rQUWh4TKDhDkTXeNhO9azyswkPzzAsEcqa9Z9/FJpb8REI/NZmb45Ew==
X-Received: by 2002:adf:e787:0:b0:315:8f4f:81b1 with SMTP id n7-20020adfe787000000b003158f4f81b1mr11999178wrm.50.1689666619960;
        Tue, 18 Jul 2023 00:50:19 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.146])
        by smtp.gmail.com with ESMTPSA id j20-20020a5d4534000000b003159d2dabbasm1544415wra.94.2023.07.18.00.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 00:50:19 -0700 (PDT)
Message-ID: <adea1b76-f40b-9d42-9b42-ae20a8976698@linaro.org>
Date:   Tue, 18 Jul 2023 08:50:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] mtd: spi-nor: Correct flags for Winbond w25q128
Content-Language: en-US
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20230712-spi-nor-winbond-w25q128-v2-1-50c9f1d58d6c@linaro.org>
 <f00fa2ae-6d4a-90cb-3724-2bedb96cb4fb@linaro.org>
 <0525440a652854a2a575256cd07d3559@walle.cc>
 <d99d87e7-47ba-d6fe-735f-16de2a2ec280@linaro.org>
 <e642ff27fd0bc0f1f0e293972145f680@walle.cc>
 <2d71326c-023e-69af-9337-62672f50fed9@linaro.org>
In-Reply-To: <2d71326c-023e-69af-9337-62672f50fed9@linaro.org>
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



On 7/18/23 08:44, Tudor Ambarus wrote:
>> If you decide to break older flashes, then I'd prefer to also drop
>> the n_sectors and sector_size, i.e. INFO(0xef...., 0, 0, 0).
>>
> Isn't v4 already doing this? I'll amend it if not. Waiting for ack from
> both you and Linus.

It needs another round of testing if we set n_sectors and sector_size
to 0, thus Linus has to spend a little more time on it, sorry.

Let's agree on the final version and close the topic.
Cheers,
ta
