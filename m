Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157867BB3B5
	for <lists+stable@lfdr.de>; Fri,  6 Oct 2023 11:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjJFJBe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 6 Oct 2023 05:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjJFJBd (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Oct 2023 05:01:33 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F0993;
        Fri,  6 Oct 2023 02:01:31 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qogi9-00047J-CS; Fri, 06 Oct 2023 11:01:29 +0200
Message-ID: <207a8e5d-5f2a-4b33-9fc1-86811ad9f48a@leemhuis.info>
Date:   Fri, 6 Oct 2023 11:01:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Userland interface breaks due to hard HFSC_FSC
 requirement
Content-Language: en-US, de-DE
To:     Christian Theune <ct@flyingcircus.io>, stable@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     regressions@lists.linux.dev, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
References: <297D84E3-736E-4AB4-B825-264279E2043C@flyingcircus.io>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <297D84E3-736E-4AB4-B825-264279E2043C@flyingcircus.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1696582891;00110f0f;
X-HE-SMSGID: 1qogi9-00047J-CS
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 06.10.23 10:37, Christian Theune wrote:
> 
> (prefix, I was not aware of the regression reporting process and incorrectly reported this informally with the developers mentioned in the change)

Don't worry too much about that, but thx for taking care of all the
details. FWIW, there is one more thing that would be good to know:

Does the problem happen with mainline (e.g. 6.6-rc4) as well? That's
relevant, as different people might care[1].

Ciao, Thorsten

[1] this among others is explained here:
https://linux-regtracking.leemhuis.info/post/frequent-reasons-why-linux-kernel-bug-reports-are-ignored/

> I upgraded from 6.1.38 to 6.1.55 this morning and it broke my traffic shaping script, leaving me with a non-functional uplink on a remote router.
> 
> The script errors out like this:
> 
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + ext=ispA
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + ext_ingress=ifb0
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + modprobe ifb
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + modprobe act_mirred
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc del dev ispA root
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2061]: Error: Cannot delete qdisc with handle of zero.
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + true
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc del dev ispA ingress
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2064]: Error: Cannot find specified qdisc on specified device.
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + true
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc del dev ifb0 root
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2066]: Error: Cannot delete qdisc with handle of zero.
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + true
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc del dev ifb0 ingress
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2067]: Error: Cannot find specified qdisc on specified device.
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + true
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc add dev ispA handle ffff: ingress
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + ifconfig ifb0 up
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc filter add dev ispA parent ffff: protocol all u32 match u32 0 0 action mirred egress redirect dev ifb0
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc add dev ifb0 root handle 1: hfsc default 1
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc class add dev ifb0 parent 1: classid 1:999 hfsc rt m2 2.5gbit
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc class add dev ifb0 parent 1:999 classid 1:1 hfsc sc rate 50mbit
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2077]: Error: Invalid parent - parent class must have FSC.
> 
> The error message is also a bit weird (but that’s likely due to iproute2 being weird) as the CLI interface for `tc` and the error message do not map well. (I think I would have to choose `hfsc sc` on the parent to enable the FSC option which isn’t mentioned anywhere in the hfsc manpage).
> 
> The breaking change was introduced in 6.1.53[1] and a multitude of other currently supported kernels:
> 
> ----
> commit a1e820fc7808e42b990d224f40e9b4895503ac40
> Author: Budimir Markovic <markovicbudimir@gmail.com>
> Date: Thu Aug 24 01:49:05 2023 -0700
> 
> net/sched: sch_hfsc: Ensure inner classes have fsc curve
> 
> [ Upstream commit b3d26c5702c7d6c45456326e56d2ccf3f103e60f ]
> 
> HFSC assumes that inner classes have an fsc curve, but it is currently
> possible for classes without an fsc curve to become parents. This leads
> to bugs including a use-after-free.
> 
> Don't allow non-root classes without HFSC_FSC to become parents.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Budimir Markovic <markovicbudimir@gmail.com>
> Signed-off-by: Budimir Markovic <markovicbudimir@gmail.com>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Link: https://lore.kernel.org/r/20230824084905.422-1-markovicbudimir@gmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ----
> 
> Regards,
> Christian
> 
> [1] https://cdn.kernel.org/pub/linux/kernel/v6.x/ChangeLog-6.1.53
> 
> #regzbot introduced: a1e820fc7808e42b990d224f40e9b4895503ac40
> 
> 
