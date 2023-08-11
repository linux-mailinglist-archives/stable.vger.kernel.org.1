Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6475778916
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 10:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbjHKInB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 04:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbjHKIm7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 04:42:59 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82692D6A
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 01:42:58 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso1584568f8f.0
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 01:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691743377; x=1692348177;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n0L7TNaPDjG2oP47xE9wFsvrLG+cbfbskrmcmsHvf/A=;
        b=I/sxIutcJCbO+pIGSgszv7i8DqFLycVyBoKVrOr3LmgHlime0xzpYp9Rrvzt9NV4NV
         +c8l6GC+YxH+6+aVHQnCzvsoNemJRwsLRatFuoyJhBvkx3gvLS5RJvIPOpGOLj3BXIk1
         385nGLNLDt2N4CS7WS4Rn4IX7w0JF4XqUrBzoY33GYt8lO3c25zukscckGy1l0F/I+Kc
         41nICKGyNYrALjpF5YM0Ft0vHsTFtcQVdkpJCD1DRx+1n8cx7TZK5hKFZxipzfRdlxCd
         fMRT97i7jbpWrN5K71Gl6IZ8I4cUsXQy+MmhE7f43/30aPT4E4IbwCOXubeNZO78suTJ
         Pj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691743377; x=1692348177;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n0L7TNaPDjG2oP47xE9wFsvrLG+cbfbskrmcmsHvf/A=;
        b=heHNh/BLlzTiJ632Cp0wEzaa7SHx62KPElJ5nkdT1gesClg/3UDs0ugQS0qVwST96n
         7HgdmJXbLLEBoLtMtdKQqxh47Fdh0veEHvsAd0d8Kzquzo5MC6QAtzkxxM0oRkwxNiwq
         TYb7NpyUxEiU1ZTDbeRKXh0Asj8GsDFC72oT0Tnagr6A3vJtPa82MiJ5hV9uarkyVB1I
         DWhbC4dWVNRNF5zhpGH1HlMsn87GcCIDa/pZhon2Sgi5C7q3KedHmD3RUTu5+FWVRVjo
         69IuTjjNT8inS35Ms2o5SwCPloFHs8gozBDVRjDRYQTk9dxj0+OVNzIF+olx2tCHONiC
         /DAw==
X-Gm-Message-State: AOJu0YyO6kkaAthlqhulyyx2LfUlx8veuO1fOb0GoG88uWzvWPW42Cpj
        xdh5xpqKYC1KZfj/Ispo80+s1g==
X-Google-Smtp-Source: AGHT+IEBcDWEXnDQ+Jh9eDdyDB1YdaPUSUloa6qFH16PZEYc9Ai9H0YWD0g3C7bqPWqWLPCCEenR7w==
X-Received: by 2002:adf:ef4a:0:b0:314:1b36:f440 with SMTP id c10-20020adfef4a000000b003141b36f440mr814509wrp.70.1691743377366;
        Fri, 11 Aug 2023 01:42:57 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id u16-20020a5d4690000000b00313de682eb3sm4669333wrq.65.2023.08.11.01.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 01:42:56 -0700 (PDT)
Message-ID: <8b72ce47-c338-2061-f11a-c0a608686d8c@linaro.org>
Date:   Fri, 11 Aug 2023 09:42:55 +0100
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
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <2214c31b-eca2-012e-a100-21252a724e7c@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 11/08/2023 07:04, Vikash Garodia wrote:
> 
> On 8/10/2023 5:03 PM, Bryan O'Donoghue wrote:
>> On 10/08/2023 03:25, Vikash Garodia wrote:
>>> +    if (hweight_long(core->dec_codecs) + hweight_long(core->enc_codecs) >
>>> MAX_CODEC_NUM)
>>> +        return;
>>> +
>>
>> Shouldn't this be >= ?
> Not needed. Lets take a hypothetical case when core->dec_codecs has initial 16
> (0-15) bits set and core->enc_codecs has next 16 bits (16-31) set. The bit count
> would be 32. The codec loop after this check would run on caps array index 0-31.
> I do not see a possibility for OOB access in this case.
> 
>>
>> struct hfi_plat_caps caps[MAX_CODEC_NUM];
>>
>> ---
>> bod
>>

Are you not doing a general defensive coding pass in this series ie

"[PATCH v2 2/4] venus: hfi: fix the check to handle session buffer 
requirement"

---
bod
