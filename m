Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E746F67F0
	for <lists+stable@lfdr.de>; Thu,  4 May 2023 11:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjEDJHD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 4 May 2023 05:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjEDJHC (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 4 May 2023 05:07:02 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92D88F
        for <stable@vger.kernel.org>; Thu,  4 May 2023 02:06:56 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1puUvP-0004Ux-C3; Thu, 04 May 2023 11:06:55 +0200
Message-ID: <585b00d1-5ad7-ecff-e905-71e370613dfb@leemhuis.info>
Date:   Thu, 4 May 2023 11:06:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: stable-rc/linux-4.14.y bisection: baseline.login on
 meson8b-odroidc1
Content-Language: en-US, de-DE
To:     =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>,
        stable@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <1fcff522-337a-c334-42a7-bc9b4f0daec4@collabora.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <1fcff522-337a-c334-42a7-bc9b4f0daec4@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1683191216;0d71ce43;
X-HE-SMSGID: 1puUvP-0004Ux-C3
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

On 10.04.23 08:06, Ricardo Cañuelo wrote:
> Culprit:
> https://lore.kernel.org/r/20211227180026.4068352-2-martin.blumenstingl@googlemail.com
> 
> On lun 27-12-2021 19:00:24, Martin Blumenstingl wrote:
>> The dt-bindings for the UART controller only allow the following values
>> for Meson6 SoCs:
>> - "amlogic,meson6-uart", "amlogic,meson-ao-uart"
>> - "amlogic,meson6-uart"
>>
>> Use the correct fallback compatible string "amlogic,meson-ao-uart" for
>> AO UART. Drop the "amlogic,meson-uart" compatible string from the EE
>> domain UART controllers.
> 
> KernelCI detected that this patch introduced a regression in
> stable-rc/linux-4.14.y (4.14.267) on a meson8b-odroidc1.
> After this patch was applied the tests running on this platform don't
> show any serial output.
> 
> This doesn't happen in other stable branches nor in mainline, but 4.14
> hasn't still reached EOL and it'd be good to find a fix.
> 
> Here's the bisection report:
> https://groups.io/g/kernelci-results/message/40147
> 
> KernelCI info:
> https://linux.kernelci.org/test/case/id/64234f7761021a30b262f776/
> 
> Test log:
> https://storage.kernelci.org/stable-rc/linux-4.14.y/v4.14.311-43-g88e481d604e9/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-meson8b-odroidc1.html

Lo! From the earlier discussion[1] it seems the mainline developers of
the patch-set don't care (which is fine). And the stable team always has
a lot of work at hand, which might explain why they haven't looked into
this. Hence let me try to fill this gap a little here by asking:

Have you tried if reverting the change on top of the latest 4.14.y
kernel works and looks safe (e.g. doesn't cause a regression on its own)?

I also briefly looked into "git log v4.14..v4.19 --
arch/arm/boot/dts/meson.dtsi" and noticed commit 291f45dd6da ("ARM: dts:
meson: fixing USB support on Meson6, Meson8 and Meson8b") [v4.15-rc1]
that mentions a fix for the Odroid-C1+ board -- which afaics wasn't
backported to 4.14.y. Is that maybe why this happens on 4.14.y and not
on 4.19.y? Note though: It's just a wild guess from the peanut gallery,
as this is not my area of expertise!

Ciao, Thorsten

[1]
https://lore.kernel.org/lkml/20230405132900.ci35xji3xbb3igar@rcn-XPS-13-9305/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke
