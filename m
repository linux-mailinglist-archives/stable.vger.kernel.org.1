Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2431735CC1
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 19:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjFSRJ2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 13:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjFSRJ1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 13:09:27 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDAD11A
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:09:26 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qBINY-0000dt-Rk; Mon, 19 Jun 2023 19:09:24 +0200
Message-ID: <bca4dcf5-15ac-8f48-3342-325bca764f9a@leemhuis.info>
Date:   Mon, 19 Jun 2023 19:09:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: stable-rc/linux-4.14.y bisection: baseline.login on
 meson8b-odroidc1
Content-Language: en-US, de-DE
To:     =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>
References: <1fcff522-337a-c334-42a7-bc9b4f0daec4@collabora.com>
 <585b00d1-5ad7-ecff-e905-71e370613dfb@leemhuis.info>
 <4f77c914-562c-42ef-dfd0-43239398815d@collabora.com>
 <a42f43e1-8586-a608-d073-3190af4eca94@leemhuis.info>
 <1296be13-e15e-5478-452f-8ae8494563c0@leemhuis.info>
 <87pm5ris6h.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <87pm5ris6h.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1687194566;0dac378b;
X-HE-SMSGID: 1qBINY-0000dt-Rk
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 19.06.23 13:53, Ricardo Cañuelo wrote:
> On lun, jun 19 2023 at 11:36:02, "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info> wrote:
>> BTW and JFYI (as you earlier said my docs helped you): the aspect "who
>> is responsible to handle this regression: the regular maintainer or the
>> stable team?" that came up earlier with this report lead me to sit down
>> and write a text called "Why your Linux kernel bug report might be
>> ignored or is fruitless" I published here:
>>
>> https://linux-regtracking.leemhuis.info/post/frequent-reasons-why-linux-kernel-bug-reports-are-ignored/
> 
> This is fantastic

Feels really good to hear this, as it was a lot of work that involved a
lot of rewriting...

Nevertheless: let me know, if there is something where you think "this
doesn't feel right", "this could be clearer", "I don't understand this",
or something like that.

> and a much needed document that should be mandatory
> training for anyone reporting kernel regressions.

Well, bugs in general I'd say.

> IMO this kind of
> documents should be located in a more prominent place

Yeah, but where? I wondered if I should ask Jonathan if this is
something for lwn.net, but something in me says it would be a odd fit.

> Maybe with a bit of effort of us all we can improve the
> situation so that bugs and regression reporting and tracking in the
> kernel becomes a much more streamlined process.

I'd really like to work more on that, but this regression tracking thing
is a time sink. And regzbot still needs quite a few improvements as
well. :-/

Would help if I finally would figure out how to use "git clone" to
create a clone or two of myself. ;)

>>> That leads to the question: should we spend our time on it?
>>
>> As expected there wasn't any progress (at least afaics).
>> [...]
>> Ricardo, how would do you and Kernelci folks feel about ignoring this?
> 
> I can't speak on behalf of the KernelCI people, but this being something
> that isn't failing in mainline and considering that the stable release
> where it happened was very close to EOL puts this in the low-priority
> category for me. Fixing bugs can become a quite expensive task in terms
> of time, and I'm try to factor in the impact of the fix to make sure the
> time spent fixing it is worth it.
> In other words, making test results green just for the sake of
> green-ness is not a sound reason to go after the failures. We're trying
> to improve the kernel quality after all, so I'd rather focus on the
> regressions that seem more important for the kernel integrity and for
> the users.

Well said. It's similar for regression tracking, hence let me remove it
from the list of tracked issues

#regzbot inconclusive: seems nobody is motivated enough to work on
resolving this issue found by KernelCI (see lists for details).

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
