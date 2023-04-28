Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797D06F136B
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 10:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345391AbjD1IpM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 04:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjD1IpL (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 04:45:11 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232662D40;
        Fri, 28 Apr 2023 01:45:10 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1psJj2-0005Ab-HS; Fri, 28 Apr 2023 10:45:08 +0200
Message-ID: <563d96ca-8c2f-3c84-bef6-10311fa5ebcf@leemhuis.info>
Date:   Fri, 28 Apr 2023 10:45:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: issues with cdc ncm host class driver
Content-Language: en-US, de-DE
To:     Oliver Neukum <oneukum@suse.com>,
        "Purohit, Kaushal" <kaushal.purohit@ti.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
References: <da37bb0d43de465185c10aad9924f265@ti.com>
 <3a51acb5-6862-7558-5807-c94f8e0d0f64@suse.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <3a51acb5-6862-7558-5807-c94f8e0d0f64@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1682671510;9fae6006;
X-HE-SMSGID: 1psJj2-0005Ab-HS
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 05.04.23 12:53, Oliver Neukum wrote:
> On 03.04.23 08:14, Purohit, Kaushal wrote:
>>
>> Referring to patch with commit ID
>> (*e10dcb1b6ba714243ad5a35a11b91cc14103a9a9*).
>>
>> This is a spec violation for CDC NCM class driver. Driver clearly says
>> the significance of network capabilities. (snapshot below)
>>
>> However, with the mentioned patch these values are disrespected and
>> commands specific to these capabilities are sent from the host
>> regardless of device' capabilities to handle them.
>>
>> Currently we are setting these bits to 0 indicating no capabilities on
>> our device and still we observe that Host (Linux kernel host cdc
>> driver) has been sending requests specific to these capabilities.
> 
> Hi,
> 
> please test the patch I've attached to kernel.org's bugzilla.

Did you ever do that? Doesn't look like it from here, but maybe I'm
missing something.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

BTW, let me fix something up in regzbot while at it:

#regzbot from: Kaushal Purohit
#regzbot poke
