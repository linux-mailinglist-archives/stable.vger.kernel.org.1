Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB1C7A73CD
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 09:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbjITHRE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 03:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbjITHRD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 03:17:03 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7B3C9
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 00:16:57 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c93638322so128177066b.1
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 00:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695194215; x=1695799015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q2eQVdoUT9SBA1b8M5ykPkKlAeuNJeFmhFlc8MCDqTU=;
        b=oQBC5J5Vh97nxtE389DqY7yqQHPoHfnktkMg2IqdJ6BSitANYGT2pvkv9KkfxLt5Up
         Rxy3et6EfDJU82MtrNrVEVL8l3A4hZ/jWY4TdTKY/X5SkOp3/4f+veUoQ0hw+fOt8J2D
         VfYUVLJpaH88C2o+JOdwoNBo8eskfU+C6fPNQGzwNV8y9NNC91OQNK49Wld2wqd2Eopk
         ApQKexLKCJeUttv2gnHJCo7F5Psl0rwozhiY2NvAQp8lcLzn5JwL3peKG5p/1CtXWxXf
         SpxDMJhXHCX6xcGkvKC72F94xM0ccG/2xqE3E3rNik0KafL1dFSugLWnWCH4hwei2rpF
         d1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695194215; x=1695799015;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q2eQVdoUT9SBA1b8M5ykPkKlAeuNJeFmhFlc8MCDqTU=;
        b=O8VFfStzy7ph0lwNtW0kGKhInowRvnQIbkAw3i2VZq4mAoCUZtCqHvFkGHkwIivijZ
         Sr1ii89OQp6rt6LfBcWnDlbJWlhtZYcvkEkdWJh0xnFhFYolL4xqJS6pa+BAa53FNtjS
         6W13Jg4Q60oQSH2/l3AEL8l2SakRmWJhaIDAWpmAREpVAmr9vSLJwwGYn8AcTI19Gm4T
         9OkJDlVK4zKxqU3QVW6LSjdYK8QDihLBC/JVgxUzINEoqMk9ppzY7OStUeuQ92VKeHT7
         O/qE1zRo/bJt03urNLzbuhmFiMZmb6wqSgOAC5sgYP2PB1mPYGjt5h1X7Dq65vElDjnm
         mi+g==
X-Gm-Message-State: AOJu0YwVY7dCw6Tt5U+sMEszcgJmaI0p9M5NzgS7Um3tKC6h7+FvJ8Pq
        cmc4BG3xpKkBy12bzfhcRLDNp66+F9ysjfcsYae+Sg==
X-Google-Smtp-Source: AGHT+IHhkthx7La4ES4fm9zVIeF/hC42jbQNxbARKR3kkYPQQKu6/fzEtLxK3AGfYDSmQri0prplFQ==
X-Received: by 2002:a17:907:760a:b0:9ae:513f:b837 with SMTP id jx10-20020a170907760a00b009ae513fb837mr192908ejc.5.1695194215478;
        Wed, 20 Sep 2023 00:16:55 -0700 (PDT)
Received: from [172.20.24.238] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id w18-20020a170906481200b0099329b3ab67sm8914549ejq.71.2023.09.20.00.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 00:16:55 -0700 (PDT)
Message-ID: <263d0059-d0d9-9eaa-d3c9-90b5a16a8025@linaro.org>
Date:   Wed, 20 Sep 2023 09:16:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH AUTOSEL 6.5 30/36] arm64: dts: qcom: sc8280xp-x13s: Add
 camera activity LED
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>, Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>, agross@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230908192848.3462476-1-sashal@kernel.org>
 <20230908192848.3462476-30-sashal@kernel.org>
 <ZP60ngCV3hhNZiX5@hovoldconsulting.com> <ZQjEEt7sB2M5EO53@sashalap>
 <ZQk8aJx268Soy4yH@hovoldconsulting.com> <ZQmc7hznPpIh6iwP@sashalap>
 <ZQmh-DaBTwMuOLHe@hovoldconsulting.com> <ZQm5woD5zwRIG9cf@sashalap>
 <ZQnA4o7G4A3YC-pe@hovoldconsulting.com>
 <ZQnFj6g4pbwMz69C@hovoldconsulting.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZQnFj6g4pbwMz69C@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 19/09/2023 18:00, Johan Hovold wrote:
> On Tue, Sep 19, 2023 at 05:40:18PM +0200, Johan Hovold wrote:
>> On Tue, Sep 19, 2023 at 11:09:54AM -0400, Sasha Levin wrote:
>>> On Tue, Sep 19, 2023 at 03:28:24PM +0200, Johan Hovold wrote:
>>>> On Tue, Sep 19, 2023 at 09:06:54AM -0400, Sasha Levin wrote:
>>>>> On Tue, Sep 19, 2023 at 08:15:04AM +0200, Johan Hovold wrote:
>>
>>>>>> Call it what you will, but please drop it. Otherwise by that logic you'd
>>>>>> need to backport all devicetree patches (as well as most driver changes)
>>>>>> since they ultimately aim at enabling hardware.
>>>>>
>>>>> Not all, only ones that re-use existing kernel driver but enable it for
>>>>> new hardware (i.e. adding a new pci-id/usb-id/dts entries).
>>>>
>>>> Again, that's basically all our device-tree patches. And that can break
>>>> in all sorts of ways. So again, please drop. This does not belong in
>>>> stable.
>>>
>>> This is part of the criteria we use to select patches, yes? If you have
>>> an objection around this particular patch then please let me know, or if
>>> you have an objection around hardware enablement patches in stable then
>>> we can have a bigger discussion around that one.
>>>
>>> However, just dropping this one for no particular reasonisn't the right
>>> approach: we've been using this selection criteria for quite a few years
>>> now.
>>
>> This patch makes zero sense to backport. It's a place holder for a
>> camera led that we may one day need. No one marked it for stable, no
>> one wants it in stable, no one needs it in stable, yet you repeatedly
>> refuse to drop it and keep wasting my time.
>>
>> Backports, and especially your autosel ones, always come with a risk.
>> And here there is ZERO upsides to that. Next time the feature you try to
>> retroactively enable may not be as trivial and could cause real
>> regressions.
>>
>> We're on our knees dealing with development and review of stuff that
>> people do want and need. And you keep pushing silly things like and
>> spamming us with backports that no one asked for. I'm just baffled.
> 
> You also seem to have made up new stable kernel rules as adding device
> tree nodes clearly doesn't fit the description in
> stable-kernel-rules.rst:
> 
> 	It must either fix a real bug that bothers people or just add a
> 	device ID.
> 
> (This used to say "New device IDs and quirks are also accepted.")

I agree here with Johan. This is not a new device ID, not a quirk, not
minor stuff for hardware enablement. DTS describes the hardware for the
OS. The original commit is such new hardware description for previously
undescribed hardware. Such description might rely on changes in OS
drivers and might not work without driver patches, even if compatible
looks documented. Because this is not a quirk.

Such DTS patches should not be backported to stable kernels.

Best regards,
Krzysztof

