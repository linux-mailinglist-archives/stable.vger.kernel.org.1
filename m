Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A398D778C28
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 12:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbjHKKlm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 06:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjHKKll (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 06:41:41 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03D211F
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 03:41:40 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3159d5e409dso1763210f8f.0
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 03:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691750499; x=1692355299;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RncF6ccyWdgiKANFFFDRTdDe2RHMHSG6x0t3CEmTPBc=;
        b=zgFghbc3TnB5zV77tCtSvgULe6XORX612ZhELOiTxS9Z5kCfXgFNkcEPGmf3vd5c5y
         idLe7HgE7ZUhRka5QdwCgjZCG20AbjSKAsgmivGH97AkCxyg4o9dqSAEiKDlIY5shZ0c
         1lOu86MGtyqvb/sIRqg9VIHKHWRtBltIHDqx5V1dKV6aNCmxdXL9eLOuv3DGVwnpkukt
         LrhMsEeMG4FmC5N9u9do2SQi7FfBTVS05cXBZqqFPfCB0SfwLz4SG4dxoFMN5CgiC0O6
         1JHwJMGYR8ibZRRk5xYmXfOidPhdbH/wKsGKIOSZzHuWk9nx/ldtksRgUqUh+r+mp/QY
         av1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691750499; x=1692355299;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RncF6ccyWdgiKANFFFDRTdDe2RHMHSG6x0t3CEmTPBc=;
        b=SD0hohIHaJeTMLuasKZTjStr3qMY+VbiMPn4f5Ce0VcWb2fCY5bKi6PuQBL3SYv6NE
         b8HKEonGT0LdbGmut2ohUB2HE24gW5V9J9f9Cp3jfw+QzJaZNRTg2Vw/E3wSw7GTJVs+
         PTUeE5L1ouXOMcjueiYLCIQ0fWLbYDtVaeic3aSz0MSptQf9BvV8zitzjmwcM81ckfM5
         8RnSYLGNzXSHBg1HsDyzt0cICDo6EPDq0vijMS/nNtRdj8oqmqrt0JZ+gD1xojvnBxz0
         cJ9PYubmH+tftivLs6OWUSGWyMce/4RHs1asOvsC2j6pDeIcrp54Jt/GE3MEztXKu9nK
         SZJw==
X-Gm-Message-State: AOJu0YxeJ/+kCm8cA5LFcC0zhYST2z03ewoscsjYR6UEsOV6kF3F+wNK
        4UGJ69ASZ1Mz0L7F0sGlXunl1Q==
X-Google-Smtp-Source: AGHT+IHHj4vcpFwgQZNe6OP5GFfkkYEm8iojN1TMcxqbt4fTf8CpEhLGaCo/Aq6a/Tws9yLqCchyHw==
X-Received: by 2002:adf:f384:0:b0:317:de66:259b with SMTP id m4-20020adff384000000b00317de66259bmr4206750wro.15.1691750499215;
        Fri, 11 Aug 2023 03:41:39 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id o11-20020a056000010b00b0031431fb40fasm5007824wrx.89.2023.08.11.03.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 03:41:38 -0700 (PDT)
Message-ID: <8f1a4ca0-dde8-fa5d-bca3-d317886609de@linaro.org>
Date:   Fri, 11 Aug 2023 11:41:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 4/4] venus: hfi_parser: Add check to keep the number of
 codecs within range
Content-Language: en-US
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        stanimir.k.varbanov@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hans.verkuil@cisco.com, tfiga@chromium.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <1691634304-2158-1-git-send-email-quic_vgarodia@quicinc.com>
 <1691634304-2158-5-git-send-email-quic_vgarodia@quicinc.com>
 <fec4a8c7-206f-7af8-4ea9-c919a677bf7e@linaro.org>
 <2214c31b-eca2-012e-a100-21252a724e7c@quicinc.com>
 <8b72ce47-c338-2061-f11a-c0a608686d8c@linaro.org>
 <e880da07-ccd4-e427-ed34-20b284dc7838@quicinc.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <e880da07-ccd4-e427-ed34-20b284dc7838@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 11/08/2023 09:49, Vikash Garodia wrote:
> 
> On 8/11/2023 2:12 PM, Bryan O'Donoghue wrote:
>> On 11/08/2023 07:04, Vikash Garodia wrote:
>>>
>>> On 8/10/2023 5:03 PM, Bryan O'Donoghue wrote:
>>>> On 10/08/2023 03:25, Vikash Garodia wrote:
>>>>> +    if (hweight_long(core->dec_codecs) + hweight_long(core->enc_codecs) >
>>>>> MAX_CODEC_NUM)
>>>>> +        return;
>>>>> +
>>>>
>>>> Shouldn't this be >= ?
>>> Not needed. Lets take a hypothetical case when core->dec_codecs has initial 16
>>> (0-15) bits set and core->enc_codecs has next 16 bits (16-31) set. The bit count
>>> would be 32. The codec loop after this check would run on caps array index 0-31.
>>> I do not see a possibility for OOB access in this case.
>>>
>>>>
>>>> struct hfi_plat_caps caps[MAX_CODEC_NUM];
>>>>
>>>> ---
>>>> bod
>>>>
>>
>> Are you not doing a general defensive coding pass in this series ie
>>
>> "[PATCH v2 2/4] venus: hfi: fix the check to handle session buffer requirement"
> 
> In "PATCH v2 2/4", there is a possibility if the check does not consider "=".
> Here in this patch, I do not see a possibility.
> 
>>
>> ---
>> bod

But surely hweight_long(core->dec_codecs) + 
hweight_long(core->enc_codecs) == MAX_CODEC_NUM is an invalid offset ?

---
bod
