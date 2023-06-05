Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B36172242A
	for <lists+stable@lfdr.de>; Mon,  5 Jun 2023 13:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjFELG3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 5 Jun 2023 07:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjFELGG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Jun 2023 07:06:06 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B0B127
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 04:05:46 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q681u-0003sO-VM; Mon, 05 Jun 2023 13:05:43 +0200
Message-ID: <548d5c4b-4080-d718-3d0e-17a3601d05d6@leemhuis.info>
Date:   Mon, 5 Jun 2023 13:05:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Regression on drm/i915, with bisected commit
Content-Language: en-US, de-DE
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=c3=89ric_Brunet?= <eric.brunet@ens.fr>,
        stable@vger.kernel.org
Cc:     regressions@lists.linux.dev, ville.syrjala@linux.intel.com,
        jouni.hogander@intel.com, jani.nikula@intel.com,
        gregkh@linuxfoundation.org
References: <3236901.44csPzL39Z@skaro> <ZGQXELf3MSt4oUsR@debian.me>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZGQXELf3MSt4oUsR@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1685963146;beba2831;
X-HE-SMSGID: 1q681u-0003sO-VM
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 17.05.23 01:51, Bagas Sanjaya wrote:
> On Tue, May 16, 2023 at 03:04:53PM +0200, Éric Brunet wrote:
>>
>> I have a HP Elite x360 1049 G9 2-in-1 notebook running fedora 38 with an Adler 
>> Lake intel video card.
>>
>> After upgrading to kernel 6.2.13 (as packaged by fedora), I started seeing 
>> severe video glitches made of random pixels in a vertical band occupying about 
>> 20% of my screen, on the right. The glitches would happen both with X.org and 
>> wayland.
> [...]
> #regzbot ^introduced: e2b789bc3dc34ed
> #regzbot title: Selective fetch area calculation regression on Alder Lake card
> #regzbot link: https://bugzilla.redhat.com/show_bug.cgi?id=2203549 

#regzbot fix: drm/i915: Use 18 fast wake AUX sync len
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.


