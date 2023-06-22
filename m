Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC6373A1FC
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 15:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjFVNiP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 09:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjFVNiK (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 09:38:10 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA25D1FC0
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 06:38:07 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b45a71c9caso97765751fa.3
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 06:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687441086; x=1690033086;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8sU2IdaYUJ2ay3kc5dVQP8Hdtv74Eh/9Ffxh1JEc+nM=;
        b=Bp4oEC/cOQ+j5JoiPTBm2I030bBzxN43rA2qvTM1hthlYTyk+Er23R9cz2IfGgSPWx
         uN6BdB7h8S30TS1260c7wGGHvXhWSQhWqbYSubKXPRayo3rmyJTuotz0biLTiLMOIzwQ
         56QiYMST9uFaZGkd6FXvhkBpa5XusxfmI8rmHOl2od6S2WN0WpFhompe/k15omg6OSxL
         4PxOYoztcee9nwZPksNyB1STWnPa7+pU4TYdhdFyD6W40aORa23TcNOXNcqCu9BJFq3o
         cCPmUoHwaPZXydqHVy+6Gso4Qc8IuPocHLmVKq6o/3+TLoi2NLT6IvmYndKpxFeEmkrm
         xaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687441086; x=1690033086;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8sU2IdaYUJ2ay3kc5dVQP8Hdtv74Eh/9Ffxh1JEc+nM=;
        b=kviBAEE1ARSKWlpF7l8C/u40uNrPvYcFC0y5daUgA9Y8Zi9EUGJHKiZzI/wMOD4xAK
         a3yvfSvccDcAxnt5ZLVPM4BD8SU3lkeok6fRiQ/Ij9ks5LLivj1X6YZozSk+SGsceQVm
         H6pT+UDboITMy5ASRjWn7MSnvwZMKOSrRKo1Y/vxx4Beh6ozr1lk+1Z/ycFj1JVZfe0x
         M1+YvoNRNCAjEfA38DIk7UseBVEqkDqdILEv8AVPDGO+06yPi2nPpcXpvArF4r2lWaNj
         8R3IBtuH11eti4eFlky8qttsM4nzWYwhA/tt0LLZWPMLkLJBM6+SvKrmNd17v/DSPyoN
         duTQ==
X-Gm-Message-State: AC+VfDxLKI/gOcTq5vRiJ5QAJi0navVfvy7MeZGl/iaRr6Mjxt0Qix20
        6eLishngoPkRj+2GkclmAvKh5g==
X-Google-Smtp-Source: ACHHUZ5PRfFokXr6emaSgdLyKVKSUy3Z02qvZPbW2KmZnWAb8MpfZBQTlVhtOfbeD7mKMAuQ8xUGsg==
X-Received: by 2002:a2e:9e44:0:b0:2b3:4cff:60ce with SMTP id g4-20020a2e9e44000000b002b34cff60cemr10881257ljk.0.1687441086084;
        Thu, 22 Jun 2023 06:38:06 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:c154:8b90:b6a7:cb1d? ([2a02:578:8593:1200:c154:8b90:b6a7:cb1d])
        by smtp.gmail.com with ESMTPSA id lf4-20020a170906ae4400b0098822e05eddsm4671525ejb.100.2023.06.22.06.38.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 06:38:05 -0700 (PDT)
Message-ID: <36c458a7-9ffb-4d25-ef77-90476b1a8a3c@tessares.net>
Date:   Thu, 22 Jun 2023 15:38:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: FAILED: patch "[PATCH] selftests: mptcp: join: skip test if
 iptables/tc cmds fail" failed to apply to 5.15-stable tree
Content-Language: en-GB
To:     gregkh@linuxfoundation.org, kuba@kernel.org
Cc:     stable@vger.kernel.org
References: <2023062219-thank-remedial-82cc@gregkh>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <2023062219-thank-remedial-82cc@gregkh>
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
> The patch below does not apply to the 5.15-stable tree.
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

We don't need to backport this commit 4a0b866a3f7d ("selftests: mptcp:
join: skip test if iptables/tc cmds fail"): it depends on a feature
introduced in commit ae7bd9ccecc3 ("selftests: mptcp: join: option to
execute specific tests") and we don't want to backport this. Also, this
fix here is mainly useful for the last stable version: I guess people
will likely not take the selftests version from v5.15.y and run them on
older kernels. They will more likely take the selftests from the last
stable version (or the same version as the kernel one).

So no need to do anything here.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
