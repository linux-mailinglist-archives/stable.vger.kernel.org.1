Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B384C73A722
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 19:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjFVRWN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 13:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjFVRWM (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 13:22:12 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B7E199B
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 10:22:11 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-988e6fc41ccso527718466b.3
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 10:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687454529; x=1690046529;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AXU6ZzLGI2hMj+gQaJDhPbUVOrCtUClvKvaEoR2I66U=;
        b=zUrHjbezGiW55VJIMCiroK0885pi96QmU+Au/TBdwSI/3mg9HoG83I0a9j+OsH1xjs
         pdj7fV+e2YJVz/N+Cm84Ftb171ataci4HbRV3qotau46u8CQZaWsKW98sekPMEtWhonn
         qIeg9fmpZZRQ1VXXh7V8fMo+eeSQ/TBHmCWan1vYu28FYtV1NWSEUeAEZ3JS+qmdPMry
         Ah0G42CbuOaSoAiIgiY5Vwa+4NgEG6k0eEt/IVZ5M2kZH8vuOuKuGDhhAQ743R5n5BYF
         dVJRUUGdq0Q2ggE5QuXVSli7MbO/V96CwrNv0pbar/niPEU5Twxk/ZTeNz6a3ch4tnLq
         e0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687454529; x=1690046529;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AXU6ZzLGI2hMj+gQaJDhPbUVOrCtUClvKvaEoR2I66U=;
        b=Qc3ikNBUGmmdASFHE+n0o+weGJwVVxeAPyEueTo7PbEcI46n2us8P1FzEE8McFGsWe
         CWbUPlojFYtl8ZEfljGE9xINoEmKBcIQMUMyjtX2ln30L9uBV154BxCrp4Jz3Myt3zlO
         UAPxx0J8f488tdisbHqTjhPZDrhiyeEkYiiuVk92QK0kq0+j8EHzjtzwXo+XAeGe/7KU
         ZD+sYNNtL/3uXSXqwFU12+Ay5hKIjoVsZO0MQ7GUT6BbgenvBVDVYIf3LCrfo5+873hH
         8VeBzD1s7PWl8ZVWKEFO/wxbQkTije8NqTpuKnmQN4WzuroOEUu4J/mZcUwqtlW1xtTh
         a7qQ==
X-Gm-Message-State: AC+VfDxNXoSgsXvis20/67aeBphSHhkUmLjFb5Dv3i4LPe5MgT+AOsqR
        V8d23fKTw5FzjpxMBR5II2A9MQ==
X-Google-Smtp-Source: ACHHUZ4FB29IdGtIz1tBiEHYYXNwImKV7+FMiize2DuELWtFE1YjwQ7876w4lSDBwdWsqYiS2GAhjw==
X-Received: by 2002:a17:906:eecb:b0:958:4c75:705e with SMTP id wu11-20020a170906eecb00b009584c75705emr14956912ejb.17.1687454529320;
        Thu, 22 Jun 2023 10:22:09 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:6f36:aa91:2721:9c00? ([2a02:578:8593:1200:6f36:aa91:2721:9c00])
        by smtp.gmail.com with ESMTPSA id w10-20020a1709062f8a00b009662b4230cesm5059540eji.148.2023.06.22.10.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 10:22:08 -0700 (PDT)
Message-ID: <02976c42-b21b-71d7-514d-391de26b757e@tessares.net>
Date:   Thu, 22 Jun 2023 19:22:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 6.1.y] selftests: mptcp: diag: skip listen tests if not
 supported
Content-Language: en-GB
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
References: <2023062242-ripple-resilient-26a8@gregkh>
 <20230622090852.2848019-1-matthieu.baerts@tessares.net>
 <2023062213-job-matriarch-144d@gregkh>
 <6f9987c8-dcdb-6938-9bae-82605162acd4@tessares.net>
 <2023062256-salary-glorified-e5c0@gregkh>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <2023062256-salary-glorified-e5c0@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 22/06/2023 19:13, Greg KH wrote:
> On Thu, Jun 22, 2023 at 04:06:22PM +0200, Matthieu Baerts wrote:
>> Hi Greg,
>>
>> On 22/06/2023 11:19, Greg KH wrote:
>>> On Thu, Jun 22, 2023 at 11:08:52AM +0200, Matthieu Baerts wrote:
>>>> commit dc97251bf0b70549c76ba261516c01b8096771c5 upstream.
>>>>
>>>> Selftests are supposed to run on any kernels, including the old ones not
>>>> supporting all MPTCP features.
>>>>
>>>> One of them is the listen diag dump support introduced by
>>>> commit 4fa39b701ce9 ("mptcp: listen diag dump support").
>>>>
>>>> It looks like there is no good pre-check to do here, i.e. dedicated
>>>> function available in kallsyms. Instead, we try to get info if nothing
>>>> is returned, the test is marked as skipped.
>>>>
>>>> That's not ideal because something could be wrong with the feature and
>>>> instead of reporting an error, the test could be marked as skipped. If
>>>> we know in advanced that the feature is supposed to be supported, the
>>>> tester can set SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var to 1: in
>>>> this case the test will report an error instead of marking the test as
>>>> skipped if nothing is returned.
>>>>
>>>> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
>>>> Fixes: f2ae0fa68e28 ("selftests/mptcp: add diag listen tests")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>>>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>>> ---
>>>> Applied on top of stable-rc/linux-6.1.y: 639ecee7e0d3 ("Linux 6.1.36-rc1")
>>>> Conflicting with commit e04a30f78809 ("selftest: mptcp: add test for
>>>> mptcp socket in use"): modifications around __chk_msk_nr() have been
>>>> included here.
>>>> ---
>>>>  tools/testing/selftests/net/mptcp/diag.sh | 47 ++++++++++++-----------
>>>>  1 file changed, 24 insertions(+), 23 deletions(-)
>>>>
>>>
>>> Now queued up, thanks.
>>
>> Thank you for having already queued this patch and all the other ones
>> from Linus' tree!
>>
>> I just sent the last patches fixing conflicts in v5.10. I don't have any
>> others linked to MPTCP and I replied to the ones that don't need to be
>> backported to older versions than v6.1.
>>
> 
> Thanks, I think I got them all now!

Yes, I think you did!

Thank you very much!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
