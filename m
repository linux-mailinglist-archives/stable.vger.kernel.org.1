Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74D578E94B
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 11:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbjHaJUw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 05:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjHaJUw (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 05:20:52 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4614AE5D;
        Thu, 31 Aug 2023 02:20:38 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qbdqu-0004t5-SH; Thu, 31 Aug 2023 11:20:36 +0200
Message-ID: <6a5f4d0d-c75a-1b92-b9ec-776c00081ad8@leemhuis.info>
Date:   Thu, 31 Aug 2023 11:20:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.1.30: thunderbolt: Clear registers properly when auto clear
 isn't in use cause call trace after resume
Content-Language: en-US, de-DE
To:     Linux Regressions <regressions@lists.linux.dev>
Cc:     Linux USB <linux-usb@vger.kernel.org>, stable@vger.kernel.org
References: <CAG7aomXv2KV9es2RiGwguesRnUTda-XzmeE42m0=GdpJ2qMOcg@mail.gmail.com>
 <ZHKW5NeabmfhgLbY@debian.me>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZHKW5NeabmfhgLbY@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1693473638;ff2f768a;
X-HE-SMSGID: 1qbdqu-0004t5-SH
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 28.05.23 01:48, Bagas Sanjaya wrote:
> On Sat, May 27, 2023 at 04:15:51PM -0400, beld zhang wrote:
>> Upgrade to 6.1.30, got crash message after resume, but looks still
>> running normally
>>
>> After revert
>>     e16629c639d429e48c849808e59f1efcce886849
>>     thunderbolt: Clear registers properly when auto clear isn't in use
>> This error was gone.
> 
> Can you check latest mainline to see if this regression still happens?
> [...]
> #regzbot ^introduced: e16629c639d429
> #regzbot title: Properly clearing Thunderbolt registers when not autoclearing triggers ring_interrupt_active crash on resume

#regzbot fix: 5532962c9ed259daf6824041aa923452cfca6b
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.


