Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA08073A1FE
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 15:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjFVNi3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 09:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjFVNi2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 09:38:28 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227271FEB
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 06:38:21 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-98d25cbbb43so97441066b.1
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 06:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687441099; x=1690033099;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VdsOmrGOouO6FAJz+S7EnO1o2aDwMI9ei1KAon2Zvmw=;
        b=q9AlbfK227wCGAp+iBn62hH6mLXkdZ7+sh6Ep/QAqBO3zJgNEPVXOz2sKKCRLpFWP6
         UPkRUZDtfYxLgcOSJ/3IDyRyp8BZ8S8RKz847RUXwplbpPlOmtqD733Q3IK71NUKi/XW
         YEIhtQVrzzY8nSZCfzF3MjpD3jmtktVMW9nP7zZ88V8sn9dp5sc8Z0o8iOecZvBpTPPg
         Iu/k6qdXfEuH9eqGXcYFppcALJvX43cvmMQVLLkHkFEI5dgzQ/7+fwDBfsmWvRyCc+GT
         Ueyniri70suW8z+YfVEX3kk50RYIhQxvOeEnRKNQ91L4g0TyXjBAsa5oRvL9GN7M0T/J
         3Yeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687441099; x=1690033099;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VdsOmrGOouO6FAJz+S7EnO1o2aDwMI9ei1KAon2Zvmw=;
        b=BaLTm8m/hJP3+j3qe1nvkjkMPbTrBX9MrdL2ctYZz3qgbjXqVS+oFxqKR9gy9nrMLJ
         vDbtcfUnURKqQMMvs2YJkFH5swSWRv8ECKC4znNainFfYoP+olppxVdEKVYvLhC7j88C
         zduus6XwHiCbb0arBR1sbd7xnQh7S0ICdo++a/hv7NhYbLb0uoAZUnc4UETLoDSMVA6l
         nj/9Vu2vYobNzIm/ZKDrioMQ5FDtsn9uGIqEtX5Cq6xZz6lIIf5OA0g3p7HIHfClBzlA
         wjXtRovA6RlFXKYkcy/IfaWLZzsjHwPKjWpOepy707g5Dst2cwQX787SNm08e55I7tHZ
         uS8w==
X-Gm-Message-State: AC+VfDwNHDg7j7XjnIPAK9oZhxz1yQe7xQCH7V4+X8BsY7MVG4jGa7cV
        NmH5b0AD0s2Lcd3AuhhGB1QeXg==
X-Google-Smtp-Source: ACHHUZ63qWYhGb54QFF+ZYnXHYxk5DwTOQMwPOqzeBibu81wzdgtQZZ7mWlB5Ed2GT9u7u109hbvzQ==
X-Received: by 2002:a17:907:940d:b0:989:64f0:8f89 with SMTP id dk13-20020a170907940d00b0098964f08f89mr5259021ejc.38.1687441099483;
        Thu, 22 Jun 2023 06:38:19 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:c154:8b90:b6a7:cb1d? ([2a02:578:8593:1200:c154:8b90:b6a7:cb1d])
        by smtp.gmail.com with ESMTPSA id u9-20020a170906068900b00988ca8b175dsm4700117ejb.119.2023.06.22.06.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 06:38:19 -0700 (PDT)
Message-ID: <8856f544-b753-a0bd-4e4d-e52616da9006@tessares.net>
Date:   Thu, 22 Jun 2023 15:38:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: FAILED: patch "[PATCH] selftests: mptcp: join: skip test if
 iptables/tc cmds fail" failed to apply to 5.10-stable tree
Content-Language: en-GB
To:     gregkh@linuxfoundation.org, kuba@kernel.org
Cc:     stable@vger.kernel.org
References: <2023062220-unclamped-fiddle-b56e@gregkh>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <2023062220-unclamped-fiddle-b56e@gregkh>
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

On 22/06/2023 10:00, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

(...)

> ------------------ original commit in Linus's tree ------------------
> 
> From 4a0b866a3f7d3c22033f40e93e94befc6fe51bce Mon Sep 17 00:00:00 2001
> From: Matthieu Baerts <matthieu.baerts@tessares.net>
> Date: Sat, 10 Jun 2023 18:11:40 +0200
> Subject: [PATCH] selftests: mptcp: join: skip test if iptables/tc cmds fail
> 
> Selftests are supposed to run on any kernels, including the old ones not
> supporting all MPTCP features.
> 
> Some tests are using IPTables and/or TC commands to force some
> behaviours. If one of these commands fails -- likely because some
> features are not available due to missing kernel config -- we should
> intercept the error and skip the tests requiring these features.
> 
> Note that if we expect to have these features available and if
> SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var is set to 1, the tests
> will be marked as failed instead of skipped.
> 
> This patch also replaces the 'exit 1' by 'return 1' not to stop the
> selftest in the middle without the conclusion if there is an issue with
> NF or TC.
> 
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
> Fixes: 8d014eaa9254 ("selftests: mptcp: add ADD_ADDR timeout test case")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thank you for this notification!

With the same reasons as the ones explained in my email for the same
patch but for v5.15, here for v5.10, we also don't need to backport this
commit 4a0b866a3f7d ("selftests: mptcp: join: skip test if iptables/tc
cmds fail").

So no need to do anything here.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
