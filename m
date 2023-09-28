Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA877B2039
	for <lists+stable@lfdr.de>; Thu, 28 Sep 2023 16:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjI1OzK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 28 Sep 2023 10:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjI1OzJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 28 Sep 2023 10:55:09 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2326AF9
        for <stable@vger.kernel.org>; Thu, 28 Sep 2023 07:55:06 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qlsPx-0005QP-6N; Thu, 28 Sep 2023 16:55:05 +0200
Message-ID: <19565eb0-9130-45b1-ba15-b77987a5bca6@leemhuis.info>
Date:   Thu, 28 Sep 2023 16:55:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] EINVAL with mount in selinux_set_mnt_opts when
 mounting in a guest vm with selinux disabled
Content-Language: en-US, de-DE
To:     Simon Kaegi <simon.kaegi@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     stable@vger.kernel.org, regressions@lists.linux.dev,
        dhowells@redhat.com, jpiotrowski@linux.microsoft.com,
        brauner@kernel.org, sashal@kernel.org
References: <CACW2H-5W6KE6UJ8HwD6r9pOx4Ow_W6ACZyg9LpTykjU6tHHB3g@mail.gmail.com>
 <9c208dd856b82a4012370b201c08b2d73a6c130e.camel@kernel.org>
 <CACW2H-7-KyYrAcnO+QKBV9fs4mGfzOpKvAutbj6hkq7D0m+EzQ@mail.gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CACW2H-7-KyYrAcnO+QKBV9fs4mGfzOpKvAutbj6hkq7D0m+EzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695912907;5371253e;
X-HE-SMSGID: 1qlsPx-0005QP-6N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 28.09.23 16:43, Simon Kaegi wrote:
> Thanks Jeff. I've confirmed that Ondrej's patch fixes the issue we
> were having. Definitely would be great to get this in 6.1.x. soon.

That patch afaics is already part of 6.1.55

#regzbot fix: 978b86fbdb2acf69

HTH!

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

> On Wed, Sep 27, 2023 at 4:21 PM Jeff Layton <jlayton@kernel.org> wrote:
>>
>> On Wed, 2023-09-27 at 15:55 -0400, Simon Kaegi wrote:
>>> #regzbot introduced v6.1.52..v6.1.53
>>> #regzbot introduced: ed134f284b4ed85a70d5f760ed0686e3cd555f9b
>>>
>>> We hit this regression when updating our guest vm kernel from 6.1.52 to
>>> 6.1.53 -- bisecting this problem was introduced
>>> in ed134f284b4ed85a70d5f760ed0686e3cd555f9b -- vfs, security: Fix automount
>>> superblock LSM init problem, preventing NFS sb sharing --
>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.1.53&id=ed134f284b4ed85a70d5f760ed0686e3cd555f9b
>>>
>>> We're getting an EINVAL in `selinux_set_mnt_opts` in
>>> `security/selinux/hooks.c` when mounting a folder in a guest VM where
>>> selinux is disabled. We're mounting from another folder that we suspect has
>>> selinux labels set from the host. The EINVAL is getting set in the
>>> following block...
>>> ```
>>> if (!selinux_initialized(&selinux_state)) {
>>>         if (!opts) {
>>>                 /* Defer initialization until selinux_complete_init,
>>>                         after the initial policy is loaded and the security
>>>                         server is ready to handle calls. */
>>>                 goto out;
>>>         }
>>>         rc = -EINVAL;
>>>         pr_warn("SELinux: Unable to set superblock options "
>>>                 "before the security server is initialized\n");
>>>         goto out;
>>> }
>>> ```
>>> We can reproduce 100% of the time but don't currently have a simple
>>> reproducer as the problem was found in our build service which uses
>>> kata-containers (with cloud-hypervisor and rootfs mounted via virtio-blk).
>>>
>>> We have not checked the mainline as we currently are tied to 6.1.x.
>>>
>>> -Simon
>>
>> This sounds very similar to the bug that Ondrej fixed here:
>>
>>     https://lore.kernel.org/selinux/20230911142358.883728-1-omosnace@redhat.com/
>>
>> You may want to try that patch and see if it helps.
>> --
>> Jeff Layton <jlayton@kernel.org>
> 
> 
