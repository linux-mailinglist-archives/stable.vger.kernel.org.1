Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9863749A96
	for <lists+stable@lfdr.de>; Thu,  6 Jul 2023 13:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjGFL2y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 6 Jul 2023 07:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGFL2y (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 6 Jul 2023 07:28:54 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BC1AA
        for <stable@vger.kernel.org>; Thu,  6 Jul 2023 04:28:53 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qHNAI-0007pB-MX; Thu, 06 Jul 2023 13:28:50 +0200
Message-ID: <b81e3f5d-01ea-02c8-a9a7-e7f624ca0603@leemhuis.info>
Date:   Thu, 6 Jul 2023 13:28:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] HID: amd_sfh: Check that sensors are enabled before
 set/get report
Content-Language: en-US, de-DE
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Malte Starostik <malte@starostik.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Haochen Tong <linux@hexchain.org>
References: <20230620193946.22208-1-mario.limonciello@amd.com>
 <b691b60d-80c4-2bf8-4f62-c957bf8fc1ba@amd.com>
 <MN0PR12MB61012CD476072E6FBCCF5BE7E22FA@MN0PR12MB6101.namprd12.prod.outlook.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <MN0PR12MB61012CD476072E6FBCCF5BE7E22FA@MN0PR12MB6101.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1688642933;49065715;
X-HE-SMSGID: 1qHNAI-0007pB-MX
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 05.07.23 18:07, Limonciello, Mario wrote:
> [Public]
> 
>> can we check below patch series which solves this issue by initializing HID only
>> if is_any_sensor_enabled.
>> https://lore.kernel.org/all/nycvar.YFH.7.76.2305231559000.29760@cbobk.
>> fhfr.pm/
>>
> 
> The original reporter won't be able to test it because they've upgraded their
> firmware and SFH is disabled in the new firmware.
> 
> But yeah it seems plausible this series could help.  If it comes back up again
> we should point anyone affected to this series.
> 
> Thanks!

Hmmm. So this won't be fixed in 6.3.y. and 6.4.y then, as none of those
patches afaics looks like they will be picked up by the stable team?

Hmmm. That doesn't completely feel right to me, unless we consider the
problem Haochen Ton ran into an extremely unlikely bug (reminder: only a
few of those that encounter a problem will report it). Do we? If not: is
backporting that patch-set to 6.4.y an option once this was in mainline
for a while without causing trouble?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
