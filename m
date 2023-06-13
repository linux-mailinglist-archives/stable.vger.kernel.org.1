Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDDF72E76B
	for <lists+stable@lfdr.de>; Tue, 13 Jun 2023 17:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240660AbjFMPhf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 13 Jun 2023 11:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242118AbjFMPha (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Jun 2023 11:37:30 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBA92100;
        Tue, 13 Jun 2023 08:36:57 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q964h-0002ws-DO; Tue, 13 Jun 2023 17:36:51 +0200
Message-ID: <49292fe0-db4a-0358-1949-f0ce1c876a73@leemhuis.info>
Date:   Tue, 13 Jun 2023 17:36:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] usb: typec: ucsi: Fix command cancellation
Content-Language: en-US, de-DE
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, Stephan Bolten <stephan.bolten@gmx.net>,
        stable@vger.kernel.org
References: <20230606115802.79339-1-heikki.krogerus@linux.intel.com>
 <977dae31-7963-d3f5-7612-6f7761b03507@leemhuis.info>
 <2023061313-headed-stumble-cf30@gregkh>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <2023061313-headed-stumble-cf30@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1686670617;40b2dee8;
X-HE-SMSGID: 1q964h-0002ws-DO
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 13.06.23 17:09, Greg Kroah-Hartman wrote:
> On Tue, Jun 13, 2023 at 04:51:58PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 06.06.23 13:58, Heikki Krogerus wrote:
>>> The Cancel command was passed to the write callback as the
>>> offset instead of as the actual command which caused NULL
>>> pointer dereference.
>>>
>>> Reported-by: Stephan Bolten <stephan.bolten@gmx.net>
>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217517
>>> Fixes: 094902bc6a3c ("usb: typec: ucsi: Always cancel the command if PPM reports BUSY condition")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>>
>> Gentle reminder that this made no progress for a week now. Or was there
>> and I just missed it? Then apologies in advance.
> 
> This just landed in my usb-linus branch a few hours before you sent
> this, and will show up in linux-next tomorrow as:
> 	c4a8bfabefed ("usb: typec: ucsi: Fix command cancellation")

Ahh, great! Sorry, I check next in cases like this before sending mails,
but not the subsystem trees directly. :-/

>> I'm asking, as it afaics would be nice to have this (or some other fix
>> for the regression linked above) mainlined before the next -rc. That
>> would be ideal, as then it can get at least one week of testing before
>> the final is released.
> 
> It will get there, sorry for the delay, now caught up on all pending USB
> and TTY/serial fixes.

No worries and thx for the update. It just looked like something where a
quick "what's up" seemed appropriate. Thx again.

Ciao, Thorsten
