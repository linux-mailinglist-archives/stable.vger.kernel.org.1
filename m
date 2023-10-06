Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E407BBA09
	for <lists+stable@lfdr.de>; Fri,  6 Oct 2023 16:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjJFOOH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 6 Oct 2023 10:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjJFOOG (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Oct 2023 10:14:06 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C8C95;
        Fri,  6 Oct 2023 07:14:05 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c760b34d25so16870155ad.3;
        Fri, 06 Oct 2023 07:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696601645; x=1697206445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=se+93OT/Osj2QCJD0bLmh5PXf8LhiyfIU3o8SYbOIfk=;
        b=k0PJ2tfpWb117RPMLTeX4uHxRm/tM3UdkXbXzEnjZ4bvhzD8J0FEEibsDw6fuTOO3w
         q8/k+vwLKPer0IfY7lNQaZ+QJShFc3iYnR6bQxGn+8vdi7Bk5KfXSAy7Lr1sMY2QqN+L
         JAmILwkEppmz37+od5AHB9j3+0WwKi0+9c9WabRPMTvKFz2XRFnrorFzczO6SSfmauUI
         MxnfpjWnouFwYzB88QmFKwZ+JFpY/qGAtffns4YPKtKkxNg6b7DebG9JRuzmf9GWrEeF
         W1kR797FG8gtubcCDvdquYdd3OspAIDV44DE0FloVqNOdGUYIGvgVtGHhtoeDMatDrFE
         RCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696601645; x=1697206445;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=se+93OT/Osj2QCJD0bLmh5PXf8LhiyfIU3o8SYbOIfk=;
        b=vrooZmV3qbxE4n0FmdNs1W2bpRXfktiiVFsllihXrujHbZ/0ggiJA991JcLB5w7IOc
         T9DuOIhCiPjwRv4aYwgewI8sQeWMQwS74BreceM6nxYuVmsocKZobnZ61sbR8iWtv2bX
         QEmFuL64S/xOxF8aL/5GhH+O+Fl+5YCnHVw5FEA5sJtQlhR3nq55QQP+uYtCe0R29/QI
         4FSm4DjWpftUSmyMKMKKj91sFq088nSrWGE3oSJ9Dd97NJQKgSvXfCKEyVMlSLCCgSSU
         rZRha+PXEUSu6BzMmJcoEtOYUMNA7FuxBTeUqRHK3glaccE7ISYHY9h/kiBi4MYrC9Q8
         xQ1w==
X-Gm-Message-State: AOJu0Yz5HlokFxusPQPWwyzKUZKLW5X6l2witU4tA6YyFH8e3AJgh7P/
        79QYc7YzZ7pwCMaPjgFONSAOmfVNMmw=
X-Google-Smtp-Source: AGHT+IHXpB3kWyz99GEFTIMPxct/mdKgGLEGMKjfizAva+sEXhbN+7W4V3GP6TJHgppuXPuqTHYDnQ==
X-Received: by 2002:a17:903:2305:b0:1c6:c3f:9dc3 with SMTP id d5-20020a170903230500b001c60c3f9dc3mr8663224plh.54.1696601645140;
        Fri, 06 Oct 2023 07:14:05 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b001c5fda4d3eesm3880746plx.261.2023.10.06.07.14.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 07:14:04 -0700 (PDT)
Message-ID: <31b59df2-d668-478e-a546-c3805f74c3a3@gmail.com>
Date:   Fri, 6 Oct 2023 21:13:49 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Userland interface breaks due to hard HFSC_FSC
 requirement
Content-Language: en-US
To:     Christian Theune <ct@flyingcircus.io>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
References: <297D84E3-736E-4AB4-B825-264279E2043C@flyingcircus.io>
 <207a8e5d-5f2a-4b33-9fc1-86811ad9f48a@leemhuis.info>
 <879EA0B7-F334-4A17-92D5-166F627BEE6F@flyingcircus.io>
 <740b0d7e-c789-47b5-b419-377014a99f22@leemhuis.info>
 <BBEA77E4-D376-45CE-9A93-415F2E0703D7@flyingcircus.io>
 <982dc76d-0832-4c8a-a486-5e6a2f5fb49a@gmail.com>
 <0AAB089F-A296-472B-8E6F-0D60B9ACCB95@flyingcircus.io>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <0AAB089F-A296-472B-8E6F-0D60B9ACCB95@flyingcircus.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 06/10/2023 19:37, Christian Theune wrote:
> Hi,
> 
>> On 6. Oct 2023, at 14:07, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>
>> On 06/10/2023 17:51, Christian Theune wrote:
>>> Hi,
>>>
>>> sorry, no I didn’t. I don’t have a testbed available right now to try this out quickly.
>>>
>>
>> Please don't top-post; reply inline with appropriate context instead.
> 
> Sorry, I will avoid that in the future - I was a bit in a hurry and thus negligent, but you’re right of course.
> 
>> You need to have testing system, unfortunately. It should mimic your
>> production setup as much as possible. Your organization may have one
>> already, but if not, you have to arrange for it.
> 
> I’m able to do that, I just didn’t have one at hand at this very moment and no time to prepare one within a few minutes. I’ll try to reproduce with a 6.6rc in the next days.
> 

OK, thanks!


-- 
An old man doll... just what I always wanted! - Clara

