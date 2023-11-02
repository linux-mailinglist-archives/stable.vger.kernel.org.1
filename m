Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983BA7DEDDD
	for <lists+stable@lfdr.de>; Thu,  2 Nov 2023 09:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjKBIFQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 2 Nov 2023 04:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbjKBIFP (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 2 Nov 2023 04:05:15 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB5AE7;
        Thu,  2 Nov 2023 01:05:09 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qyShP-0007hW-SQ; Thu, 02 Nov 2023 09:05:07 +0100
Message-ID: <49ea26fb-a895-4879-b96e-0d3e97eeb713@leemhuis.info>
Date:   Thu, 2 Nov 2023 09:05:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Userland interface breaks due to hard HFSC_FSC
 requirement
Content-Language: en-US, de-DE
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     stable@vger.kernel.org, netdev@vger.kernel.org
Cc:     regressions@lists.linux.dev
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>
References: <297D84E3-736E-4AB4-B825-264279E2043C@flyingcircus.io>
 <78f59b5f-33d7-4b5b-9b7c-ee7a4647b35f@leemhuis.info>
In-Reply-To: <78f59b5f-33d7-4b5b-9b7c-ee7a4647b35f@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1698912309;ca4770eb;
X-HE-SMSGID: 1qyShP-0007hW-SQ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 01.11.23 20:05, Linux regression tracking #update (Thorsten Leemhuis)
wrote:
> [TLDR: This mail in primarily relevant for Linux kernel regression
> tracking. See link in footer if these mails annoy you.]
> 
> On 06.10.23 10:37, Christian Theune wrote:
>>
>> I upgraded from 6.1.38 to 6.1.55 this morning and it broke my traffic shaping script, leaving me with a non-functional uplink on a remote router.
>> [...]
>> #regzbot introduced: a1e820fc7808e42b990d224f40e9b4895503ac40
> 
> #regzbot fix: net/sched: sch_hfsc: upgrade rt to sc when it becomes a
> inner curve
> #regzbot ignore-activity

Sorry, that had a typo:

#regzbot fix: d80bc191420a2edecb555b
#regzbot ignore-activity

#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
