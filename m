Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB076F69E6
	for <lists+stable@lfdr.de>; Thu,  4 May 2023 13:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjEDL24 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 4 May 2023 07:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjEDL2z (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 4 May 2023 07:28:55 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE843AAF
        for <stable@vger.kernel.org>; Thu,  4 May 2023 04:28:54 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1puX8m-00075K-Oa; Thu, 04 May 2023 13:28:52 +0200
Message-ID: <a42f43e1-8586-a608-d073-3190af4eca94@leemhuis.info>
Date:   Thu, 4 May 2023 13:28:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: stable-rc/linux-4.14.y bisection: baseline.login on
 meson8b-odroidc1
Content-Language: en-US, de-DE
To:     =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org
References: <1fcff522-337a-c334-42a7-bc9b4f0daec4@collabora.com>
 <585b00d1-5ad7-ecff-e905-71e370613dfb@leemhuis.info>
 <4f77c914-562c-42ef-dfd0-43239398815d@collabora.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Greg KH <gregkh@linuxfoundation.org>
In-Reply-To: <4f77c914-562c-42ef-dfd0-43239398815d@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1683199734;63386aba;
X-HE-SMSGID: 1puX8m-00075K-Oa
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

[CCing Greg, in case he's interested]

On 04.05.23 12:22, Ricardo Cañuelo wrote:
> 
> Thanks for bringing this up, I think what you mentioned is
> interesting in a more general way, so let me use this email to
> share my impressions about the approach to reporting regressions
> and the role of the reporter.

Many thx for this, let me follow suit a bit.

> On 4/5/23 11:06, Linux regression tracking (Thorsten Leemhuis) wrote:
>> Have you tried if reverting the change on top of the latest 4.14.y
>> kernel works and looks safe (e.g. doesn't cause a regression on its own)?
> 
> No, I haven't. To be honest, my current approach when I'm
> reporting regressions is to act merely as a reporter, making sure
> the regression summaries reach the right people and providing as
> much info as possible with the data we gather from the test runs
> in KernelCI.
> 
> Sometimes I stop for some more time in a particular regression
> and I test it / investigate it more thoroughly to find the exact
> root cause and try to fix it, but I consider that to be beyond
> the role of a reporter. At that point I'm basically trying to
> find a fix, and that's much more time consuming.

Yeah, my situation is quite similar -- just that I'm not the reporter
and instead someone supposed to handle the tracking. But just like you I
sometimes do a bit more than the job description in the strict sense
requires. That msg you replied to was written in one of those moments. :-D

But FWIW, I have lines I don't cross myself (or at least try to).
Submitting fixes myself for example, even if they are simple -- like
patches adding quirk entries to resolve regressions (recently I
nevertheless got close to ignore that line, but then found a better
solution...).

>> I also briefly looked into "git log v4.14..v4.19 --
>> arch/arm/boot/dts/meson.dtsi" and noticed commit 291f45dd6da ("ARM: dts:
>> meson: fixing USB support on Meson6, Meson8 and Meson8b") [v4.15-rc1]
>> that mentions a fix for the Odroid-C1+ board -- which afaics wasn't
>> backported to 4.14.y. Is that maybe why this happens on 4.14.y and not
>> on 4.19.y? Note though: It's just a wild guess from the peanut gallery,
>> as this is not my area of expertise!
> 
> Maybe, that's the kind of thing that someone who's familiar with
> the code (author / maintainers) can quickly evaluate.

Definitely. Maybe I should have CCed them in my mail, but I didn't, as
that the point where I thought "the reporter is the better judge here".

> What you
> said about that not being your area of expertise is key, IMO. I
> don't think it's reasonable to expect a single person to
> investigate every possible type of regression. Investigating a
> bug could take me 5 minutes if it's something trivial or a few
> days if it's not and I'm not familiar with it, while the patch
> author/s could probably have it assessed and fixed in
> minutes. That's why I think that providing the regression info to
> the right people is a better use of the reporter's time.
> 
> There are many of us now in the community that are working
> towards building a common effort for regression reporting, so
> maybe we should take some time to define the roles involved and
> gather ideas about how to approach certain types of problems.

Yeah, maybe.

But OTOH I think we (e.g. reporters and developers) are all volunteers
here (e.g. as hobbyist or because our employer wants us to contribute).
Volunteers with a common goal. And all of us only have 24 hours in a day
(at least as far as I know) -- which is often not enough to get
everything done one is supposed to do. That in an ideal world should not
affect duties like "fix any regressions you caused". But well, we don't
live in an ideal world.

That's why I sometimes ignore the strict role definitions and also
wonder if defining them is worth it. But it's totally fine for me if
someone wants to do that.


That might sound a bit like a speech I'm giving trying to convince you
to follow my model. But be assured: that's not the case at all. After
your words I just felt I wanted to share my view on things.

Maybe that's because this is afaics a situation where a regression
likely will remain unfixed, unless some of us do a bit more than what is
expected from them. That's because I guess most people don't care much
about 4.14.y anymore -- either in general or on the particular platform
affected by this regression.

That leads to the question: should we spend our time on it? Maybe the
time would better be spend on more important things, even if that means
this particular regressions then likely will remain unfixed in 4.14.y.
Heck, maybe we should define that such an outcome is totally fine in
cases like this -- not sure, but I currently think leaving that
undefined might be better approach for the project as a whole.

Ciao, Thorsten
