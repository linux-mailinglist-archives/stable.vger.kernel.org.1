Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48B6736E78
	for <lists+stable@lfdr.de>; Tue, 20 Jun 2023 16:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjFTOQY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 20 Jun 2023 10:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjFTOQX (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Jun 2023 10:16:23 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D61E68;
        Tue, 20 Jun 2023 07:16:22 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qBc9c-0006w4-Hj; Tue, 20 Jun 2023 16:16:20 +0200
Message-ID: <19199830-33b6-2a4c-e08b-d1a76ce4c59b@leemhuis.info>
Date:   Tue, 20 Jun 2023 16:16:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: issues with cdc ncm host class driver
Content-Language: en-US, de-DE
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Oliver Neukum <oneukum@suse.com>,
        "Purohit, Kaushal" <kaushal.purohit@ti.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>
References: <da37bb0d43de465185c10aad9924f265@ti.com>
 <28ec4e65-647f-2567-fb7d-f656940d4e43@suse.com>
 <da479ebf-b3fb-0a58-16be-07fe55d36621@leemhuis.info>
In-Reply-To: <da479ebf-b3fb-0a58-16be-07fe55d36621@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1687270582;bd39fb3c;
X-HE-SMSGID: 1qBc9c-0006w4-Hj
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 04.04.23 12:33, Linux regression tracking (Thorsten Leemhuis) wrote:
> Side note: there is now a bug tracking ticket for this issue, too:
> https://bugzilla.kernel.org/show_bug.cgi?id=217290
> 
> On 03.04.23 12:09, Oliver Neukum wrote:
>> On 03.04.23 08:14, Purohit, Kaushal wrote:
> 
>>> Referring to patch with commit ID
>>> (*e10dcb1b6ba714243ad5a35a11b91cc14103a9a9*).
>>>
>>> This is a spec violation for CDC NCM class driver. Driver clearly says
>>> the significance of network capabilities. (snapshot below)
>>>
>>> However, with the mentioned patch these values are disrespected and
>>> commands specific to these capabilities are sent from the host
>>> regardless of device' capabilities to handle them.
>>
>> Right. So for your device, the correct behavior would be to do
>> nothing, wouldn't it? The packets would be delivered and the host
>> needs to filter and discard unrequested packets.
> 
> #regzbot ^introduced e10dcb1b6ba714243ad
> https://bugzilla.kernel.org/show_bug.cgi?id=217290
> #regzbot from: Purohit, Kaushal
> #regzbot title net: cdc_ncm: spec violation for CDC NCM
> #regzbot ignore-activity

Not sure what happen to this, my last inquiries were not answered, so it
seems nobody cares anymore

#regzbot inconclusive: radio silence, ignoring
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

