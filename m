Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2AA761868
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 14:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjGYMbT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 08:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbjGYMbS (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 08:31:18 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D3A199C
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 05:31:16 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-3464c774f23so25501395ab.1
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 05:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690288276; x=1690893076;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b1FgvdgVsA8AhmFdAzoWM+AOFT1yafAZy4p4c4o2sIg=;
        b=Hslm1yFyWvTKsfdAP5hMBFuOwahqCUrbTN4iwdv9XCYkkylsRfvUp6ebVsHfjXgL0p
         TQ97kj6HpGjqUAhilqJzfJ+3+TPnY6Qztwra6E2QLB6d4jSlUx7js0EJQGe5HMMCLXrE
         oeW2yNrRGqYJ1Orvmt/D+WLlitXeWDDu/cbinRusP1GE/hcUK57F2hfFUdepWSFl6mBz
         uejroZc4TP3icqz8KG94cU2RAZXT4P1iYOSBWNakRLik5ANkYZcFGnPuWBxS/DQrDEKn
         R2XcP8AS0+lzxQMLvC9YH0dF6TLEtavbgDMBkzgO4ndk1UhCHqF25h9CYaiF/weObPOQ
         VTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690288276; x=1690893076;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b1FgvdgVsA8AhmFdAzoWM+AOFT1yafAZy4p4c4o2sIg=;
        b=Zs+ra9IfCjKidwIfITPSdkCAVhBgS9SgjtBMco/WxmHhBT/i+QY8awkMyfr/VMU6wh
         E/p21SLk6jzSVAdvM5JQknSJvy7H8rtm5KUeV6memULWJW3pvERPVGMKC2ngbRyKs7hL
         UjVPRVN5Zllv8R7VI3QinipPh5zAnF3flj/qqItPes6Y6h4mGOn4GpHsygGsfPURsvee
         e6++XOmGGKoaP4jBoFapEVZ2WrnwYEDcvjh1o9UoeSGUm23w4BV9FyFygvtoMqJ+fMj2
         JzFUdkJW+xo8bcyQbJL6cCiT1xJwg0pRvXgaoNYcQFXpOVh1pUcA/C0cmQUIsiy1U+4N
         Zy3A==
X-Gm-Message-State: ABy/qLax+tarvUey4J75ra6sPVjxhceFfnXV0bnRQWIB+DPmJ1/V08MZ
        o9Ul95XrmMd02j8ea9m83AYQaQ==
X-Google-Smtp-Source: APBJJlF9iUN4yUd16TkYLNfCh05utlxera1aImKMVg8l++3z5FT59pZCDICzckk8yXvh57Fw2k7W+w==
X-Received: by 2002:a6b:730c:0:b0:786:e003:1c6a with SMTP id e12-20020a6b730c000000b00786e0031c6amr2483451ioh.21.1690288275982;
        Tue, 25 Jul 2023 05:31:15 -0700 (PDT)
Received: from [10.211.55.3] (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.gmail.com with ESMTPSA id g10-20020a02c54a000000b0042b6ae47f0esm3600276jaj.108.2023.07.25.05.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 05:31:15 -0700 (PDT)
Message-ID: <f0fb38cb-ed2f-d09d-7675-97291d1bc2cc@linaro.org>
Date:   Tue, 25 Jul 2023 07:31:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net] net: ipa: only reset hashed tables when supported
To:     Greg KH <gregkh@linuxfoundation.org>, Alex Elder <elder@linaro.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, dianders@chromium.org,
        caleb.connolly@linaro.org, mka@chromium.org, evgreen@chromium.org,
        andersson@kernel.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20230724224106.1688869-1-elder@linaro.org>
 <2023072538-corned-falsify-d054@gregkh>
Content-Language: en-US
From:   Alex Elder <alex.elder@linaro.org>
In-Reply-To: <2023072538-corned-falsify-d054@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 7/25/23 2:08 AM, Greg KH wrote:
> You sent 2 different versions of this patch?  Which one is for what
> tree?  Is this in Linus's tree already?  If so, what's the git id?

It was a mistake.  I reached out to the netdev maintainers
yesterday to explain and I'm sorry I didn't do the same for
you/stable.

One of those patches will be brought upstream the normal
netdev way.  Back-porting to 6.1 won't work cleanly--and
once it's upstream I'll provide the other one if required.

I'm really sorry to have caused the confusion.

					-Alex
