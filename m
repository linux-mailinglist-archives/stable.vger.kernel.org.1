Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2626C78E9A4
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 11:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjHaJko (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 05:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233915AbjHaJkn (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 05:40:43 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D61CFE
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 02:40:40 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qbeAI-0000cH-Si; Thu, 31 Aug 2023 11:40:38 +0200
Message-ID: <fe7400f8-aa26-01a9-3c54-be36a15ec0f9@leemhuis.info>
Date:   Thu, 31 Aug 2023 11:40:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nouveau bug in linux/6.1.38-2
Content-Language: en-US, de-DE
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Linux kernel regressions list <regressions@lists.linux.dev>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20be6650-5db3-b72a-a7a8-5e817113cff5@kravcenko.com>
 <c27fb4dd-b2dc-22de-4425-6c7db5f543ba@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <c27fb4dd-b2dc-22de-4425-6c7db5f543ba@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1693474840;5d33ab7c;
X-HE-SMSGID: 1qbeAI-0000cH-Si
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

On 04.08.23 14:02, Thorsten Leemhuis wrote:
> On 02.08.23 23:28, Olaf Skibbe wrote:
>> Dear Maintainers,
>>
>> Hereby I would like to report an apparent bug in the nouveau driver in
>> linux/6.1.38-2.
> 
> Thx for your report. Maybe your problem is caused by a incomplete
> backport. I Cced the maintainers for the drivers (and the regressions
> and the stable list), maybe one of them has an idea, as they know the
> driver.

#regzbot fix: 98e470dc73a9b3539e5a7a3c72f6b7c01c98
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.


