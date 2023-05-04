Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E003C6F6905
	for <lists+stable@lfdr.de>; Thu,  4 May 2023 12:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjEDKWb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 4 May 2023 06:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjEDKWa (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 4 May 2023 06:22:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050A64C1B
        for <stable@vger.kernel.org>; Thu,  4 May 2023 03:22:25 -0700 (PDT)
Received: from [IPV6:2a0c:5a83:9100:1200:e870:56ba:3086:b9b4] (unknown [IPv6:2a0c:5a83:9100:1200:e870:56ba:3086:b9b4])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 44E3066031D7;
        Thu,  4 May 2023 11:22:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683195744;
        bh=YaP7WMy/OdBgoenIX1sFJldEXAzsy+QaHcRHObSl+B8=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=LeAUKz1BfYsSxGqWyK3Z6oaUf9xWna5UZ/1aW2RcbHKi6V/qnCJ5tgww4PtA4QDxF
         dW96AF5yXIA71WreKIN91A5TIkje63CL2ghEqlxKc41JlCsQHbbVm4CWlhwcceRgKr
         jQRSVo35nZZEOZDTglgsJrIAtX9iG6eXfA2C76YFssaMuJLDf69eNj7RD6OG/mYQz+
         AAfLMOc7ty0pnd2inIF26EzDOJmyMGCdAWfjja6ghi0ODSvzwuJu38scCmVNZpNO5J
         ybemUj1NAiQNoj3R6S4RnpcceOPlJW0mtB76xbqbDPmC5IEVVxqyhIvhCVyGuL54dN
         xHIKoym6h/R/w==
Message-ID: <4f77c914-562c-42ef-dfd0-43239398815d@collabora.com>
Date:   Thu, 4 May 2023 12:22:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: stable-rc/linux-4.14.y bisection: baseline.login on
 meson8b-odroidc1
Content-Language: en-US
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org
References: <1fcff522-337a-c334-42a7-bc9b4f0daec4@collabora.com>
 <585b00d1-5ad7-ecff-e905-71e370613dfb@leemhuis.info>
From:   =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>
In-Reply-To: <585b00d1-5ad7-ecff-e905-71e370613dfb@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hey Thorsten,

Thanks for bringing this up, I think what you mentioned is
interesting in a more general way, so let me use this email to
share my impressions about the approach to reporting regressions
and the role of the reporter.

On 4/5/23 11:06, Linux regression tracking (Thorsten Leemhuis) wrote:
> Have you tried if reverting the change on top of the latest 4.14.y
> kernel works and looks safe (e.g. doesn't cause a regression on its own)?

No, I haven't. To be honest, my current approach when I'm
reporting regressions is to act merely as a reporter, making sure
the regression summaries reach the right people and providing as
much info as possible with the data we gather from the test runs
in KernelCI.

Sometimes I stop for some more time in a particular regression
and I test it / investigate it more thoroughly to find the exact
root cause and try to fix it, but I consider that to be beyond
the role of a reporter. At that point I'm basically trying to
find a fix, and that's much more time consuming.

> I also briefly looked into "git log v4.14..v4.19 --
> arch/arm/boot/dts/meson.dtsi" and noticed commit 291f45dd6da ("ARM: dts:
> meson: fixing USB support on Meson6, Meson8 and Meson8b") [v4.15-rc1]
> that mentions a fix for the Odroid-C1+ board -- which afaics wasn't
> backported to 4.14.y. Is that maybe why this happens on 4.14.y and not
> on 4.19.y? Note though: It's just a wild guess from the peanut gallery,
> as this is not my area of expertise!

Maybe, that's the kind of thing that someone who's familiar with
the code (author / maintainers) can quickly evaluate. What you
said about that not being your area of expertise is key, IMO. I
don't think it's reasonable to expect a single person to
investigate every possible type of regression. Investigating a
bug could take me 5 minutes if it's something trivial or a few
days if it's not and I'm not familiar with it, while the patch
author/s could probably have it assessed and fixed in
minutes. That's why I think that providing the regression info to
the right people is a better use of the reporter's time.

There are many of us now in the community that are working
towards building a common effort for regression reporting, so
maybe we should take some time to define the roles involved and
gather ideas about how to approach certain types of problems.

Thanks,
Ricardo
