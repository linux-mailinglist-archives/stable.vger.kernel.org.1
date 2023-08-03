Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A3576EC13
	for <lists+stable@lfdr.de>; Thu,  3 Aug 2023 16:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjHCONq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 3 Aug 2023 10:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235938AbjHCOMz (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 3 Aug 2023 10:12:55 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E788846BC
        for <stable@vger.kernel.org>; Thu,  3 Aug 2023 07:12:10 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qRZ3g-00060s-Kt; Thu, 03 Aug 2023 16:12:08 +0200
Message-ID: <75318e5a-2b84-5be5-6d4d-311d99dd6e54@leemhuis.info>
Date:   Thu, 3 Aug 2023 16:12:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: YouTube Broken Since Last Update(s)
Content-Language: en-US, de-DE
To:     Misty Plianca <thepalpatinelives@gmail.com>, stable@vger.kernel.org
Cc:     regressions@lists.linux.dev, admin@linuxmint.com,
        root@linuxmint.com
References: <1ff785e1-479e-a822-73dc-cd713a2781c5@gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <1ff785e1-479e-a822-73dc-cd713a2781c5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1691071931;0ec96fd7;
X-HE-SMSGID: 1qRZ3g-00060s-Kt
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 03.08.23 15:47, Misty Plianca wrote:
> 
> Since installing the latest updates for Linux Mint yesterday or this
> morning, YouTube is acting super goofy via Brave Browser. I cannot
> search for anything at all. Nothing happens. Secondly, it is
> occasionally reporting that it is disconnected from the internet and to
> try again. Firefox works fine, however. I reported the issue to Brave,
> and have now communicated this with you to be certain everyone is aware.
> 
> I have some other stuff to discuss with you when you are available. I
> have information that you may find helpful and disturbing regarding
> Linux security. If you would like to discuss this, please reply.
> 
> My System:
> 
> Kernel: 5.4.0-155-generic x86_64 bits: 64 compiler: gcc v: 9.4.0
> Desktop: Cinnamon 5.2.7 wm: muffin dm: LightDM Distro: Linux Mint 20.3 Una
> base: Ubuntu 20.04 focal

Thx for your report. FWIW, as you might not know this: the developers of
the upstream Linux kernel are extremely unlikely to look into your
report, as you apparently use a heavily modified vendor kernel -- and
any of those changes might cause problems that are not present in the
upstream kernel, hence it's up to the vendor to take care of supporting
it, as explained here:
https://linux-regtracking.leemhuis.info/post/frequent-reasons-why-linux-kernel-bug-reports-are-ignored/

If you suspect this to be a regression that originates in the upstream
kernel, please validate with vanilla kernels: first check if the latest
version is also broken, then check if earlier ones worked; ideally
bisect to find the change causing it.

Ciao, Thorsten
