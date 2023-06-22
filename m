Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FCE73A2A2
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 16:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjFVOG2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 10:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjFVOG1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 10:06:27 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA030118
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 07:06:25 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51a2de3385fso9192771a12.0
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 07:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687442784; x=1690034784;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d6QN3Cz7WW29pg6flXO8llQ0qHAVlOUd6e3Hs3YtgPA=;
        b=O162cjkdHBrrkoMyViFk5lIjlHbQoMydIAQp0FqYTUVAgGQ3pebMA155mMFXZtNOSJ
         v0OPQvv/MM8Q7uD1stJwmbdGGFSXOBbJvt/5oZwkEO/xmvC0tWH90ApI6iuMztkmDH7M
         38U5ivRk1NRVdpOsVVD5lJ0Lh0HcBxZgdKQLgmKfghb40JR4XgPWoGwKOhINSaFfWrrY
         ZRJZnxf/Jkd0//Nu4exj0OZEDoi4YBYRp/UmkArXpuUbSQN7pfA3uTc7dlNwHYP/lpxo
         /QDhZmzG18dyrl52EkdqeedvLTr9ryB4+CYz1j9R8y6MnDS7+U0LpnB5issHxwg8DCEY
         lP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687442784; x=1690034784;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d6QN3Cz7WW29pg6flXO8llQ0qHAVlOUd6e3Hs3YtgPA=;
        b=cGadXre8Yk4x205xeS4AKwx3+bEoNYhkzSSFEFHaVAj67ttZQZ989/cWKmmgy5yh/u
         73TjQgY7SehZ95rG/egB9n1braCbtYlCkxshzRofJkm2SwsHMebxPtxqoXYvl4TmaGsW
         hPeHLyvJVI4c5WZsqdl/zRTTTYqbdbeYC/SQoRKNHANnl6eTfy8CZzfhd9RJJMePA/w/
         6ZjAF5NJYw7VCtPNH2YZI9gVHIu4HtJYDzEJFQcSY37IwGOR+K2jXi4KJ9/+tX5GFPmp
         FIrOvoplOEzC4cVoB5swNu2fDuf+aiw7YYG3LYB5hfTQD2p9/4QfGI9qOmFzsryV3zaN
         irTQ==
X-Gm-Message-State: AC+VfDwUQW6Rw55PpTlEe4ZtylTNS1gia7FEoBFvam1Tz4Mt7zE1gbsU
        L8AytW6dTAhevZofT/xRxkcmOyGsSDGXdPGadG5R2A==
X-Google-Smtp-Source: ACHHUZ5Ns5ZHjxiZjRpoNohXLSzfmtuHTi3JbiFG4BjYoWKhfkeAAZ8ezed0ABiXk1/iVfLeMjf3gQ==
X-Received: by 2002:a05:6402:68f:b0:51a:4f10:4c55 with SMTP id f15-20020a056402068f00b0051a4f104c55mr8448140edy.41.1687442784122;
        Thu, 22 Jun 2023 07:06:24 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:c154:8b90:b6a7:cb1d? ([2a02:578:8593:1200:c154:8b90:b6a7:cb1d])
        by smtp.gmail.com with ESMTPSA id u8-20020aa7d0c8000000b0051a3248cf96sm4051152edo.57.2023.06.22.07.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 07:06:23 -0700 (PDT)
Message-ID: <6f9987c8-dcdb-6938-9bae-82605162acd4@tessares.net>
Date:   Thu, 22 Jun 2023 16:06:22 +0200
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
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <2023062213-job-matriarch-144d@gregkh>
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

Hi Greg,

On 22/06/2023 11:19, Greg KH wrote:
> On Thu, Jun 22, 2023 at 11:08:52AM +0200, Matthieu Baerts wrote:
>> commit dc97251bf0b70549c76ba261516c01b8096771c5 upstream.
>>
>> Selftests are supposed to run on any kernels, including the old ones not
>> supporting all MPTCP features.
>>
>> One of them is the listen diag dump support introduced by
>> commit 4fa39b701ce9 ("mptcp: listen diag dump support").
>>
>> It looks like there is no good pre-check to do here, i.e. dedicated
>> function available in kallsyms. Instead, we try to get info if nothing
>> is returned, the test is marked as skipped.
>>
>> That's not ideal because something could be wrong with the feature and
>> instead of reporting an error, the test could be marked as skipped. If
>> we know in advanced that the feature is supposed to be supported, the
>> tester can set SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var to 1: in
>> this case the test will report an error instead of marking the test as
>> skipped if nothing is returned.
>>
>> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
>> Fixes: f2ae0fa68e28 ("selftests/mptcp: add diag listen tests")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>> Applied on top of stable-rc/linux-6.1.y: 639ecee7e0d3 ("Linux 6.1.36-rc1")
>> Conflicting with commit e04a30f78809 ("selftest: mptcp: add test for
>> mptcp socket in use"): modifications around __chk_msk_nr() have been
>> included here.
>> ---
>>  tools/testing/selftests/net/mptcp/diag.sh | 47 ++++++++++++-----------
>>  1 file changed, 24 insertions(+), 23 deletions(-)
>>
> 
> Now queued up, thanks.

Thank you for having already queued this patch and all the other ones
from Linus' tree!

I just sent the last patches fixing conflicts in v5.10. I don't have any
others linked to MPTCP and I replied to the ones that don't need to be
backported to older versions than v6.1.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
