Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6322A78C96A
	for <lists+stable@lfdr.de>; Tue, 29 Aug 2023 18:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237417AbjH2QNa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 29 Aug 2023 12:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237415AbjH2QNO (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 29 Aug 2023 12:13:14 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9524B1AD
        for <stable@vger.kernel.org>; Tue, 29 Aug 2023 09:13:11 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-401da71b7faso5308365e9.2
        for <stable@vger.kernel.org>; Tue, 29 Aug 2023 09:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693325590; x=1693930390;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QOloLP8KeMUkL/Jq5xZLVezEea9mj4ydYOnhYPBWQ2Q=;
        b=eRrtd07xYLSpEgY3PiawWjGxmTgWpX51lDmI8IlmqjE9SdS7xCFh/HiBvZLUsEPXTb
         Cn2lDzcNHNJTKaJNGiKybabya989eJqEmmGMsYW+D2p/2/Icz5j6lJcigtQaYis9L4rd
         n7V+FLaYEHiwza2VKnSHlS/KVVT+VN7e77cgrGHOtdCyvNOkcRRXKx9hK55cLtA4BonY
         80WLqnQDIlRGsD3yOcu7Z3VvXyeU//rZUrns4dBTvHqJJQvTb+8qoS7CkJJX7g43jEQI
         u5FFjrE8TgrMPLUczQvS75G4LjcxXoFxBWrGsQW548tpPZqvyeO7wdTCuWIYetl8YaDz
         IS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693325590; x=1693930390;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QOloLP8KeMUkL/Jq5xZLVezEea9mj4ydYOnhYPBWQ2Q=;
        b=T1G3K5dKk44XXYz95J1/AdmvjgD439LRIkyRcZK6u7MiOuhmZ2IEA2pnV9sszp0nCF
         MvdKsbt97u3wwd/N2JEm3wsPiTYhqcRSp/8ePQWOb311DyczI5AC2SzBvonKHHaQ7nIW
         KMyajXhvLFF76RLQLqB9bzxKD36bsHPIlAK29+9xHE9L41ja6q/TA+p0InXLXSAmpcoL
         JepRR2RIKQSYXDHDEMMOdj9x31gliB9EPkdQLf0sOCN0Ct7ARy4pzTgW5C8WSAvmDGgi
         Cu7FBxETqwribtXbOxhcjZVHym/fDO50whDMiTZCzJEPaE9RLv5nL3d5xo7P9iWbuqSa
         1SuA==
X-Gm-Message-State: AOJu0YyNJLeTiF07IvQxFDvQ6rQ1RfEmiBqVGGX8QHy/NNf/CghMDU2N
        UNfhFor1WWGHILyt+QTuz3JAwr1K/F0GCcfz+8E=
X-Google-Smtp-Source: AGHT+IHcdnfkStpEnXlknvj6hsYOpgEpIA7JoM/jexaCgsmNY+SWJ7vHF5ibgDOHseDi1um3J1mX5w==
X-Received: by 2002:a05:600c:234a:b0:401:d258:ad3d with SMTP id 10-20020a05600c234a00b00401d258ad3dmr2677945wmq.2.1693325590097;
        Tue, 29 Aug 2023 09:13:10 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id f22-20020a5d58f6000000b0031981c500aasm14124155wrd.25.2023.08.29.09.13.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 09:13:09 -0700 (PDT)
Message-ID: <ebb87316-189b-3c54-d53e-3732e60cec75@linaro.org>
Date:   Tue, 29 Aug 2023 17:13:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 5/9] media: qcom: camss: Fix VFE-480
 vfe_disable_output()
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20230822200626.1931129-1-bryan.odonoghue@linaro.org>
 <20230822200626.1931129-6-bryan.odonoghue@linaro.org>
 <20230828171725.GZ14596@pendragon.ideasonboard.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230828171725.GZ14596@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 28/08/2023 18:17, Laurent Pinchart wrote:
>> vfe-480 is copied from vfe-17x and has the same racy idle timeout bug as in
>> 17x.
>>
>> Fix the vfe_disable_output() logic to no longer be racy and to conform
>> to the 17x way of quiescing and then resetting the VFE.
> How about dropping the duplicate function and share a single
> implementation for the two files ?
> 

Hmm, so I looked at this.

In principle I like it. Right now vfe-170 only deals with a single 
write-master = 0, whereas vfe-480 deals with multiple write-masters.

Collapsing down into one place is the right thing to do however, it 
feels like a larger update to vfe-170 that merits its own series along 
the lines of "Support multiple write-masters for vfe-17x" or better 
still "Support virtual channels for vfe-17x" which is what is implied by 
this.

Yet another thing to add to the TODO list here.

---
bod
