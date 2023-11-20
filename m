Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A1A7F21A2
	for <lists+stable@lfdr.de>; Tue, 21 Nov 2023 00:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjKTXw5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 20 Nov 2023 18:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjKTXw4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 20 Nov 2023 18:52:56 -0500
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com [IPv6:2001:4860:4864:20::41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD8FCF
        for <stable@vger.kernel.org>; Mon, 20 Nov 2023 15:52:52 -0800 (PST)
Received: by mail-oa1-x41.google.com with SMTP id 586e51a60fabf-1f938410f92so856256fac.3
        for <stable@vger.kernel.org>; Mon, 20 Nov 2023 15:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700524372; x=1701129172; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ncz/Tp1Mf9Fy7JIo8FK35VPzWJoQzK6AGavFbmVN9K8=;
        b=eeS7Ck8I4MXI890gJEYS7hBl+vft1/2KIvwA8t2zqztOKL1HonDW08eglFZ7+ZroD+
         0Xy8hVdrIc+3bCFmMdMD8MeMEWYcplnwmlzwVSqSagsGUhOktVsaUTfT02tfxKOkVgV5
         LiYHmy5gntlEn9KnQDCKKnqVutXlePxw5AHEtjP9W3jnWkmythiwBF1v+p3skWQ1pOZY
         d+R6ND5ZaPN0IZW3VGkdDlANjOI4KQJN6DmiZGfSJ2/gRJwusMwCy/ktFPsploVcJO2K
         ZrUkqOM+AuEJ5T+HUUbDSnhMTAY5/NCsC/1qp1Cpj91PiGs4i3MyMtRmL1fY8NcZPmcL
         JCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700524372; x=1701129172;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ncz/Tp1Mf9Fy7JIo8FK35VPzWJoQzK6AGavFbmVN9K8=;
        b=BIZWCWU8siZlfQkEn7IKV8vGLxzQuXYvfUkwi+tFZyzXtpG9Xm8QHfzBDsQA/fSQCx
         JYrDICJOmGZTrybmX7nkri6oZ9iHIxfn7jnjqnGuJQSKw8oQ2PQaA2LULe7AoUEzrXd0
         /z+mc+Zphdqivv5oIa2/igDu2fb27RgdOBm2VJeZ5Com3hQmTB1HlwfYt1d06HimN7wd
         WIvpEPg9hHfAVoaX882kHlgX8PaU9EvLjO0RB9JdmPj+qPUB9hZZ4HfyEZU1XvhZrlXs
         TQRH3AdCiWP3LzP+fFf5d+AWKJlXYfnOY3uSf2PXVXf22FLWhv3hyU4KPvQ50I7wDEuw
         5GHA==
X-Gm-Message-State: AOJu0YwphSqO+uqsZl1RRwSgf0xmbL6zxPRZ3y7wkgvkAEY4CPT0OORu
        5jadPu88GhpSzblbB7r74M3UIYI75qIABA==
X-Google-Smtp-Source: AGHT+IH3lUqVGUyIud6qdAH5KXPLtFPeA2Q0KZwrhkGkWbN8mRbMcb0268xaF6cT4ScjF/KlmpolDA==
X-Received: by 2002:a05:6870:2429:b0:1f5:ad14:890c with SMTP id n41-20020a056870242900b001f5ad14890cmr10183359oap.48.1700524371806;
        Mon, 20 Nov 2023 15:52:51 -0800 (PST)
Received: from [10.10.13.50] ([136.226.64.177])
        by smtp.gmail.com with ESMTPSA id u19-20020a056a00099300b006cb75e0eb02sm3520101pfg.152.2023.11.20.15.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 15:52:51 -0800 (PST)
Message-ID: <9c3e4b65-4781-4d45-a270-f1b75dfb48d3@gmail.com>
Date:   Mon, 20 Nov 2023 15:52:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.5 153/191] Input: xpad - add HyperX Clutch Gladiate
 Support
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, "Nguyen, Max" <maxwell.nguyen@hyperx.com>,
        carl.ng@hp.com
References: <20231016084015.400031271@linuxfoundation.org>
 <20231016084018.949398466@linuxfoundation.org>
 <MW4PR84MB17804D57BB57C0E2FB66EFC6EBADA@MW4PR84MB1780.NAMPRD84.PROD.OUTLOOK.COM>
 <MW4PR84MB178083997D411DFFD45BEFCDEBB7A@MW4PR84MB1780.NAMPRD84.PROD.OUTLOOK.COM>
 <6b2973c5-469a-4af8-995b-ee9196d0818b@gmail.com>
 <2023111814-impeach-sweep-aa30@gregkh>
Content-Language: en-US
From:   "Nguyen, Max" <hphyperxdev@gmail.com>
In-Reply-To: <2023111814-impeach-sweep-aa30@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


On 11/18/2023 3:32 AM, Greg KH wrote:
> On Fri, Nov 17, 2023 at 03:42:22PM -0800, Nguyen, Max wrote:
>>> Hi,
>>>
>>> We would like to apply this patch to version 6.1 of the LTS branch.
>>> This is to add a project ID for Android support for a gamepad
>>> controller.  We would like it to apply sooner than waiting for the next
>>> LTS branch due to project schedules.
>>>
>>> commite28a0974d749e5105d77233c0a84d35c37da047e
>>>
>>> Regards,
>>>
>>> Max
>>>
>> Hi Linux team,
>>
>> We would like to have this patch backported to LTS versions 4.19, 5.4, 5.10,
>> and 5.15 as well.  The main purpose would to add our device ID for support
>> across older android devices.  Feel free to let us know if there are any
>> concerns or issues.
> Please provide a working backport that you have tested as I think it did
> not apply cleanly on its own, right?
>
> thanks,
>
> greg k-h

Hi Greg,

Do you have any general suggestions or instructions on how I can create 
a backport to test?  I apologize as this is new to me.

Also, what do you mean by the patch did not apply cleanly on its own?

