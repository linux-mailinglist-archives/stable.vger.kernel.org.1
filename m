Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F4A7576FD
	for <lists+stable@lfdr.de>; Tue, 18 Jul 2023 10:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjGRIqu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 18 Jul 2023 04:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjGRIqt (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 18 Jul 2023 04:46:49 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC70DFA
        for <stable@vger.kernel.org>; Tue, 18 Jul 2023 01:46:45 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b743161832so82147351fa.1
        for <stable@vger.kernel.org>; Tue, 18 Jul 2023 01:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689670004; x=1692262004;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MnzbPmWnAb7CwK/wuL7NwhmauQ1USOEwbft8Y2BSGCM=;
        b=xFdnhv87iBmtbmlGnWDlh1oZp0jr7givZF0Y03tGaYDXLXHfLQRM1jxMz4vadvFO6o
         g56z4n5UpDVimwbrTK2Mu7zyHsI6j6j4ZeQkt1NjsN4W+MuTZrVytfwcdtXLTkr7qQJb
         5VK1++Fm/fTIvYL1gZkWUOJSQCPkOc3he1+0xTWMiZiUR/TDYCXj5z9/SCiU7duwHmSD
         NZ3BU7CnkUx5xXO3z9pdND5u8lcMzSmHMDTFKdCVFQl6AA6hTW7gCsNEOWR7c8b6DyWo
         xhWajKIjf3IOcXTYhkZAcUwMQUGVSWxVEfjkz0AOXoW3CwYXVdrECu8uuAXEzu0TIFAy
         +sFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689670004; x=1692262004;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MnzbPmWnAb7CwK/wuL7NwhmauQ1USOEwbft8Y2BSGCM=;
        b=ccUzTF+0eMJQH8ZRA+AwE+nPGgNEWNLYunxBnsA/g1pucz9wH331PPoPTRVAA+urRH
         r7uuqpKV0FNCA919gTPuCtkBL9V5C5N2t35150QKEwdF4CgWU1xyWcnTKm/G8dGOQoH4
         Q4fUHs339i0jWgCK9th0Mz370ifcTx2/na/JJfrci1RMQ7/WqrhRqAWALdbw4JmC0yAL
         15246xVxosFo0KD1gkZwPqmoT29b26rNLTjBmx1z/U+N8aFcsEARa9NM+ee9PLGm3qNI
         /0+8u1WwcKfWF0xzxA1RiIP8I7B1BRQJuV1CKVHn23n+THMdzzb1iX87GKcJVdsdY/pC
         pHKA==
X-Gm-Message-State: ABy/qLa6RKub8G2iVqlS2oZqVfZoVYSim8IYWOQPD2FR7LHLgjC84Oce
        4X/p8872wXVkCnGN7ArXopZ8LA==
X-Google-Smtp-Source: APBJJlHGS5e+EIT4+lLGogH32cz9OUkRmuKxYFTJZlnclFA8TUxt1xm8U6DxEGTNjKRkxoAC6+Ih3g==
X-Received: by 2002:a2e:908b:0:b0:2b6:d9da:3d7e with SMTP id l11-20020a2e908b000000b002b6d9da3d7emr9649920ljg.45.1689670003830;
        Tue, 18 Jul 2023 01:46:43 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:73f8:f6b0:6460:6f2e? ([2a02:578:8593:1200:73f8:f6b0:6460:6f2e])
        by smtp.gmail.com with ESMTPSA id l6-20020a7bc446000000b003fc07e1908csm1552628wmi.43.2023.07.18.01.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 01:46:43 -0700 (PDT)
Message-ID: <06b4d3a2-7629-310f-fea5-4c21429dc2f8@tessares.net>
Date:   Tue, 18 Jul 2023 10:46:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net 0/3] selftests: tc: increase timeout and add missing
 kconfig
Content-Language: en-GB
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Paul Blakey <paulb@mellanox.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org
References: <20230713-tc-selftests-lkft-v1-0-1eb4fd3a96e7@tessares.net>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230713-tc-selftests-lkft-v1-0-1eb4fd3a96e7@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi David, Jakub, Paolo,

On 13/07/2023 23:16, Matthieu Baerts wrote:
> When looking for something else in LKFT reports [1], I noticed that the
> TC selftest ended with a timeout error:
> 
>   not ok 1 selftests: tc-testing: tdc.sh # TIMEOUT 45 seconds
> 
> I also noticed most of the tests were skipped because the "teardown
> stage" did not complete successfully. It was due to missing kconfig.
> 
> These patches fix these two errors plus an extra one because this
> selftest reads info from "/proc/net/nf_conntrack". Thank you Pedro for
> having helped me fixing these issues [2].

It looks like this series is marked as "Changes Requested" on Patchwork
[1] but I think that's a mistake. There was one discussion on-going on
the first patch but it looks like the proposed version is OK.

I didn't see any instructions to pw-bot and nothing on the website [2].

Do you prefer if I re-send it?

Cheers,
Matt

[1]
https://patchwork.kernel.org/project/netdevbpf/list/?series=765455&state=*
[2] https://patchwork.hopto.org/pw-bot.html
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
