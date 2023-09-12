Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDE279D747
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 19:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbjILRKq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 13:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbjILRKq (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 13:10:46 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700B1110
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 10:10:42 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qg6uN-0008KM-0i; Tue, 12 Sep 2023 19:10:39 +0200
Message-ID: <82469f2f-59e4-49d5-823d-344589cbb119@leemhuis.info>
Date:   Tue, 12 Sep 2023 19:10:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression since 6.1.46 (commit 8ee39ec): rtsx_pci from
 drivers/misc/cardreader breaks NVME power state, preventing system boot
Content-Language: en-US, de-DE
To:     Paul Grandperrin <paul.grandperrin@gmail.com>,
        stable@vger.kernel.org
Cc:     regressions@lists.linux.dev, Wei WANG <wei_wang@realsil.com.cn>,
        Roger Tseng <rogerable@realtek.com>,
        Ricky WU <ricky_wu@realtek.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <5DHV0S.D0F751ZF65JA1@gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <5DHV0S.D0F751ZF65JA1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1694538642;44837c33;
X-HE-SMSGID: 1qg6uN-0008KM-0i
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

(CCing Greg, as he merged the culprit, and Linus, in case he wants to
revert this from mainline directly as this apparently affects and annoys
quite a few people)

On 12.09.23 14:29, Paul Grandperrin wrote:
> 
> My computer doesn't boot with kernels newer than 6.1.45.>
> Here's what happens:
> - system boots in initramfs
> - detects my encrypted ZFS pool and asks for password
> - mount system, pivots to it, starts real init
> - before any daemon had time to start, the system hangs and the kernel
> writes on the console
> "nvme 0000:04:00.0: Unable to change power state from D3cold to D0,
> device inaccessible"
> - if I reboot directly without powering off (using magic sysrq or
> panic=10), even the UEFI complains about not finding any storage to boot
> from.
> - after a real power off, I can boot using a kernel <= 6.1.45.

Thx for the report.

> The bug has been discussed here:
> https://bugzilla.kernel.org/show_bug.cgi?id=217705

And recently here:
https://bugzilla.kernel.org/show_bug.cgi?id=217802
https://lore.kernel.org/all/5f968b95-6b1c-4d6f-aac7-5d54f66834a8@sapience.com/

And in
https://bugzilla.suse.com/show_bug.cgi?id=1214428
and a few other places iirc, too.

openSUSE Tumblewed reverted the culprit a while ago:

https://github.com/openSUSE/kernel-source/commit/1b02b1528a26f4e9b577e215c114d8c5e773ee10

I think we should do the same for mainline (and stable afterwards).

Ciao, Thorsten

> My laptop is a Dell XPS 15 9560 (Intel 7700hq).
> 
> I bisected between 6.1.45 and 6.1.46 and found this commit
> 
> commit 8ee39ec479147e29af704639f8e55fce246ed2d9
> Author: Ricky WU <ricky_wu@realtek.com>
> Date:   Tue Jul 25 09:10:54 2023 +0000
> 
>    misc: rtsx: judge ASPM Mode to set PETXCFG Reg
> 
>    commit 101bd907b4244a726980ee67f95ed9cafab6ff7a upstream.
> 
>    ASPM Mode is ASPM_MODE_CFG need to judge the value of clkreq_0
>    to set HIGH or LOW, if the ASPM Mode is ASPM_MODE_REG
>    always set to HIGH during the initialization.
> 
>    Cc: stable@vger.kernel.org
>    Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
>    Link:
> https://lore.kernel.org/r/52906c6836374c8cb068225954c5543a@realtek.com
>    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> drivers/misc/cardreader/rts5227.c  |  2 +-
> drivers/misc/cardreader/rts5228.c  | 18 ------------------
> drivers/misc/cardreader/rts5249.c  |  3 +--
> drivers/misc/cardreader/rts5260.c  | 18 ------------------
> drivers/misc/cardreader/rts5261.c  | 18 ------------------
> drivers/misc/cardreader/rtsx_pcr.c |  5 ++++-
> 6 files changed, 6 insertions(+), 58 deletions(-)
> 
> If I build 6.1.51 with this commit reverted, my laptop works again,
> confirming that this commit is to blame.
> 
> Also, blacklisting `rtsx_pci_sdmmc` and `rtsx_pci`, while preventing to
> use the sd card reading, allows to boot the system.
> 
> I can't try 6.4 or 6.5 because my system is dependent on ZFS..
> 
> Have a nice day,
> Paul Grandperrin
> 
