Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991F97F321D
	for <lists+stable@lfdr.de>; Tue, 21 Nov 2023 16:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbjKUPQt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 21 Nov 2023 10:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbjKUPQs (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 21 Nov 2023 10:16:48 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A1DDD
        for <stable@vger.kernel.org>; Tue, 21 Nov 2023 07:16:43 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1r5SUU-00049x-3B; Tue, 21 Nov 2023 16:16:42 +0100
Message-ID: <c72ca99e-8657-4ed8-9999-5702ebeb5b8c@leemhuis.info>
Date:   Tue, 21 Nov 2023 16:16:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION]: nouveau: Asynchronous wait on fence
Content-Language: en-US, de-DE
To:     "Owen T. Heisler" <writer@owenh.net>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org
Cc:     nouveau@lists.freedesktop.org, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Sasha Levin <sashal@kernel.org>,
        Danilo Krummrich <dakr@redhat.com>,
        dri-devel@lists.freedesktop.org
References: <6f027566-c841-4415-bc85-ce11a5832b14@owenh.net>
 <5ecf0eac-a089-4da9-b76e-b45272c98393@leemhuis.info>
 <6b7a71b4-c8a2-46f4-a995-0c63e7745ca3@owenh.net>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <6b7a71b4-c8a2-46f4-a995-0c63e7745ca3@owenh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1700579804;588a27c6;
X-HE-SMSGID: 1r5SUU-00049x-3B
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 15.11.23 07:19, Owen T. Heisler wrote:
> On 10/31/23 04:18, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 28.10.23 04:46, Owen T. Heisler wrote:
>>> #regzbot introduced: d386a4b54607cf6f76e23815c2c9a3abc1d66882
>>> #regzbot link: https://gitlab.freedesktop.org/drm/nouveau/-/issues/180
>>>
>>> ## Problem
>>>
>>> 1. Connect external display to DVI port on dock and run X with both
>>>     displays in use.
>>> 2. Wait hours or days.
>>> 3. Suddenly the secondary Nvidia-connected display turns off and X stops
>>>     responding to keyboard/mouse input. In *some* cases it is
>>> possible to
>>>     switch to a virtual TTY with Ctrl+Alt+Fn and log in there.
> 
>> You thus might want to check if the problem occurs with 6.6 -- and
>> ideally also check if reverting the culprit there fixes things for you.
> 
> The problem also occurs with v6.6.

You meanwhile might want to give 6.7-rc as well on the off chance that
it improves things, even if that is unlikely.

> Here is a decoded kernel log from an
> untainted kernel:
> 
> https://gitlab.freedesktop.org/drm/nouveau/uploads/c120faf09da46f9c74006df9f1d14442/async-wait-on-fence-180.log
> 
> The culprit commit does not revert cleanly on v6.6. I have not yet
> attempted to resolve the conflicts.
> 
> I have also updated the bug description at
> <https://gitlab.freedesktop.org/drm/nouveau/-/issues/180>.

Maybe one of the nouveau developer can take a quick look at
d386a4b54607cf and suggest a simple way to revert it in latest mainline.
Maybe just removing the main chunk of code that is added is all that it
takes.

Ciao, Thorsten
