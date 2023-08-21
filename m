Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D250783077
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 20:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjHUSxa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 14:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjHUSx3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 14:53:29 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A6149C2
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 11:53:24 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-313e742a787so2244234f8f.1
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 11:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692643921; x=1693248721;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zCtenRCjXXMg5T6uzuSAM+POnJmMfnMhSwDV8nofr7M=;
        b=iVERGBgjqfA46CdXTSzrqZEX8b3lJrt02ilp+nvqeCCzs9suPzxQrFDFE+JTYqzoZl
         4JKR4Ud877MnlFzqLNsFeyWZftJIazb5XCvSXmMhxt5GK1BZs2vf8g7DttbDRCPvBs0Y
         VkbxcIPnQorhIuSzlkoT8IkbSSF1M4pGqI2MW6LlQb9WrUWfebzYilzgvPsyOGKCh7i/
         NvT2SrktOPoQhtqGCccKXMXndXTNzGVoYO3NfOlLvoSKHTBgdAiwKvPJ31gGQgZxPo+h
         xbjSG6NM6EpaqZjlkHIZad2rprdGkYyGmdiMr/u19FhV/ULmo1ChIsJdNS5DXMhhkWuQ
         6zcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692643921; x=1693248721;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zCtenRCjXXMg5T6uzuSAM+POnJmMfnMhSwDV8nofr7M=;
        b=PdaAK2rlgiAx4ovgJ6f3G4uZmAYB435ODI5gjfwtRGmSL2saXMMWEiPbMwDRO3M6pS
         9+mkdAeM646oyhZFDgaOfu8EsTYBjgtt6lk0wJufrkqiX1bWMyp+X77wLUSXohAKew43
         LaHKgx7PaD2Ext8kTojMZmpXfcr41V9w+vLGFexvIv8npvqVWy44+8rzufpWDDp/SO15
         JQlBMkzJagJQgdBOjuggM5npZnvHthYt0SMM5h5f7LrDmwewfmOu8nj5K71tlXWwQVsE
         n6ZNhysM7bzZal6rfQPjN25MldcrJEq63h626gnh7z1jnrFjjvavlE1UXxD0iuU54byZ
         BqNg==
X-Gm-Message-State: AOJu0YzgMSkGDt1uwc/k+DHQ1rSff65flER1wtgqjbiosr9Vrjc3vj6T
        pbmbp9vK+TWOpdwF5JsZizdvbA==
X-Google-Smtp-Source: AGHT+IEIBL5BILI0Pd6OWt114UByKQoedPY/3p8aG6w/uJFzgAGbmiKQooOd5z2oKWcFGRNX4goGEQ==
X-Received: by 2002:adf:f74b:0:b0:319:7c17:4c65 with SMTP id z11-20020adff74b000000b003197c174c65mr7259307wrp.12.1692643921096;
        Mon, 21 Aug 2023 11:52:01 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id p6-20020a5d68c6000000b00317c742ca9asm13494807wrw.43.2023.08.21.11.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 11:52:00 -0700 (PDT)
Message-ID: <62859b0e-cfee-f094-2ae9-bf0e243e2929@linaro.org>
Date:   Mon, 21 Aug 2023 19:51:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v0 8/9] media: qcom: camss: Fix set CSI2_RX_CFG1_VC_MODE
 when VC is greater than 3
Content-Language: en-US
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20230814141007.3721197-1-bryan.odonoghue@linaro.org>
 <20230814141007.3721197-9-bryan.odonoghue@linaro.org>
 <edd4bf9b-0e1b-883c-1a4d-50f4102c3924@xs4all.nl>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <edd4bf9b-0e1b-883c-1a4d-50f4102c3924@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 21/08/2023 10:53, Hans Verkuil wrote:
> +		u8 dt_id = vc * 4;

You're right.

dt_id = vc is wrong but so is dt_id = vc * 4.

I'll post a fix for the dt_id as a separate patch.

---
bod
