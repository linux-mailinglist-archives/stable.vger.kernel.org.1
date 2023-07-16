Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669C8754F08
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 16:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjGPOgE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 10:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGPOgE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 10:36:04 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0946FE66
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 07:36:03 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 6B9965C0099;
        Sun, 16 Jul 2023 10:36:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 16 Jul 2023 10:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1689518162; x=1689604562; bh=o4
        d84Tv+g0WMCxx+BWTsUnAG277GK5STWTQ2KPci9CI=; b=QZcNmv71k0sRpIBeSE
        5h0Kz+nsDuLt/xV56qXHV7Z//KTOtjR4kGr7tvTxTiCvLzB4OMs8BC2woXSR/yRr
        hJ6mAv8FiS0Oz9nuVXgf9HzrD8Hnf0zrIAdETVkZxjHxT23EIYkFhQdojBpTio5G
        WAFYqhrPpZDCcHBWucW6g9nM20cTe0nmRRsvhSZ/+wUcx6OTDlBZm8VdDgARrd3V
        +61NmxqBTD+Llo1HVxg4iqQpMp2pU4gEljofzCiq7dtzVrflLejcAyOUD86qzTfr
        JlX1diBzYSykKAhKUy9HpRQ53jSJB/izmeI9IE79HM+LYnDyLiA39uxvPtSv3x+3
        5SBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689518162; x=1689604562; bh=o4d84Tv+g0WMC
        xx+BWTsUnAG277GK5STWTQ2KPci9CI=; b=AstHwyXQ7YVqOwCq/S7bAAR0FlO6H
        jOUZfYCoUlqHRBIYSCESZOPG7/jA+LT4jDJ1qT7Gyzf4fmN2MYq4TTYlRMXaN/G0
        rYyBCaNkAvu/9dbjmM0UCMokFq+KH9V7NeBjiF4xuheRa6sUvhQw3MX/NRq3/2ep
        OylbTawhjpOAYo11Dx+pL9Ktbqma8dwKYmYTFJCvB3GKto7PgOiPtYEDIepNWDfj
        8ZlN8MbnPeVXKIK3z2zivBUEkwPcG9NC+H/5sbdiE2PyAu9Ia/2BNEFsRLkCoY0J
        Pz7zNo8nv0mpNkRaPBD6Je/n+4Q4Ah1kFHwWDafBJ7nczn9maTZjF1kaw==
X-ME-Sender: <xms:UgC0ZBOSAVZDmUEsPgYqP-DWiWlk-2uDEm-BqNy3NTolBafszJP3GA>
    <xme:UgC0ZD9gYnNUfaIGHBy-Cr6mhh_oVSWBSQGDEGv0UAt7pp6g09gaRf7ok1vBucFaw
    D9qTj0Uw1aCRg>
X-ME-Received: <xmr:UgC0ZATtz9b8h50jON19JS1EnUxYJw7QULQGj-JwkuwB5NS-AFvPo_5y-_phWk8YttDDCk6f0HLgrSfrq_WfZ8APgaSxSp-jlPKXsgDQaYk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgedtgdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepheegvdevvdeljeeugfdtudduhfekledtiefhveejkeejue
    fhtdeufefhgfehkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:UgC0ZNvuDILG8uY8r2ElGOfaSvjMQnbzjR-PB-ROFjVnqtm0iPG3vg>
    <xmx:UgC0ZJc5QlYDaCRghmrmI6qyuaJqfZuXNjTYPldUv9CH1A5EoE9gmg>
    <xmx:UgC0ZJ3LCsQSwqKl2gDM0nK4F8S27VQFAo0b4CVyUHhW4wf1BitwbA>
    <xmx:UgC0ZKpC7BhwW6IVW4zPWRber0YccqWZ30R_-sXEo2fskauS9-MiSA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Jul 2023 10:36:01 -0400 (EDT)
Date:   Sun, 16 Jul 2023 16:35:59 +0200
From:   Greg KH <greg@kroah.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable <stable@vger.kernel.org>
Subject: Re: Build failures / crashes in stable queue branches
Message-ID: <2023071614-bridged-amendable-8336@gregkh>
References: <897ebb05-5a1f-e353-8877-49721c52d065@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <897ebb05-5a1f-e353-8877-49721c52d065@roeck-us.net>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Jul 14, 2023 at 03:21:46AM -0700, Guenter Roeck wrote:
> 4.14.y:
> 
> Build reference: v4.14.320-57-gbc1094b21392
> Compiler version: arm-linux-gnueabi-gcc (GCC) 11.4.0
> Assembler version: GNU assembler (GNU Binutils) 2.40
> 
> Building arm:omap2plus_defconfig ... failed
> Building arm:multi_v5_defconfig ... failed
> Building arm:keystone_defconfig ... failed (and others)
> 
> arm-linux-gnueabi-ld: arch/arm/probes/kprobes/core.o: in function `jprobe_return':
> arch/arm/probes/kprobes/core.c:555: undefined reference to `kprobe_handler'

Offending commit now dropped, thanks.

> ---------
> 6.1.y:
> 
> Build reference: v6.1.38-393-gb6386e7314b4
> Compiler version: alpha-linux-gcc (GCC) 11.4.0
> Assembler version: GNU assembler (GNU Binutils) 2.40
> 
> Building alpha:allmodconfig ... failed
> Building m68k:allmodconfig ... failed
> --------------
> Error log:
> <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
> In file included from block/genhd.c:28:
> block/genhd.c: In function 'disk_release':
> include/linux/blktrace_api.h:88:57: error: statement with no effect [-Werror=unused-value]
>    88 | # define blk_trace_remove(q)                            (-ENOTTY)
>       |                                                         ^
> block/genhd.c:1185:9: note: in expansion of macro 'blk_trace_remove'
>  1185 |         blk_trace_remove(disk->queue);

Should now be fixed.

> -------------
> 6.4.y:
> 
> Build reference: v6.4.3-548-g5f35ab2efbc9
> Compiler version: alpha-linux-gcc (GCC) 11.4.0
> Assembler version: GNU assembler (GNU Binutils) 2.40
> 
> Building alpha:allmodconfig ... failed
> Building m68k:allmodconfig ... failed
> --------------
> Error log:
> <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
> In file included from block/genhd.c:28:
> block/genhd.c: In function 'disk_release':
> include/linux/blktrace_api.h:88:57: error: statement with no effect [-Werror=unused-value]
>    88 | # define blk_trace_remove(q)                            (-ENOTTY)
>       |                                                         ^
> block/genhd.c:1175:9: note: in expansion of macro 'blk_trace_remove'
>  1175 |         blk_trace_remove(disk->queue);

Same error?  Ah, needs to go to 6.4.y as well, now queued up.

> Building mips:allmodconfig ... failed
> --------------
> Error log:
> arch/mips/boot/dts/ingenic/ci20.dts:242.19-247.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/DCDC1: Reference to non-existent node or label "vcc_33v"
> arch/mips/boot/dts/ingenic/ci20.dts:248.18-253.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/DCDC2: Reference to non-existent node or label "vcc_33v"
> arch/mips/boot/dts/ingenic/ci20.dts:254.18-259.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/DCDC3: Reference to non-existent node or label "vcc_33v"
> arch/mips/boot/dts/ingenic/ci20.dts:265.17-270.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO5: Reference to non-existent node or label "vcc_33v"
> arch/mips/boot/dts/ingenic/ci20.dts:271.18-276.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO6: Reference to non-existent node or label "vcc_33v"
> arch/mips/boot/dts/ingenic/ci20.dts:277.20-282.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO7: Reference to non-existent node or label "vcc_33v"
> arch/mips/boot/dts/ingenic/ci20.dts:283.20-288.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO8: Reference to non-existent node or label "vcc_33v"
> ERROR: Input tree has errors, aborting (use -f to force output)
> make[3]: [scripts/Makefile.lib:419: arch/mips/boot/dts/ingenic/ci20.dtb] Error 2 (ignored)
> arch/mips/boot/dts/ingenic/ci20.dts:242.19-247.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/DCDC1: Reference to non-existent node or label "vcc_33v"
> arch/mips/boot/dts/ingenic/ci20.dts:248.18-253.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/DCDC2: Reference to non-existent node or label "vcc_33v"
> arch/mips/boot/dts/ingenic/ci20.dts:254.18-259.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/DCDC3: Reference to non-existent node or label "vcc_33v"
> arch/mips/boot/dts/ingenic/ci20.dts:265.17-270.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO5: Reference to non-existent node or label "vcc_33v"
> arch/mips/boot/dts/ingenic/ci20.dts:271.18-276.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO6: Reference to non-existent node or label "vcc_33v"
> arch/mips/boot/dts/ingenic/ci20.dts:277.20-282.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO7: Reference to non-existent node or label "vcc_33v"
> arch/mips/boot/dts/ingenic/ci20.dts:283.20-288.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO8: Reference to non-existent node or label "vcc_33v"
> ERROR: Input tree has errors, aborting (use -f to force output)

Which tree is this failing on?

> On top of the build failures, mcimx7d-sabre emulations crash
> in 6.4.y.queue with a NULL pointer access in ads7846_probe().
> 
> [   15.286830] 8<--- cut here ---
> [   15.287438] Unhandled fault: page domain fault (0x01b) at 0x00001eba
> [   15.287707] [00001eba] *pgd=00000000
> [   15.288503] Internal error: : 1b [#1] SMP ARM
> [   15.288852] Modules linked in:
> [   15.289177] CPU: 0 PID: 29 Comm: kworker/u4:2 Tainted: G                 N 6.4.4-rc1-g5f35ab2efbc9 #1
> [   15.289433] Hardware name: Freescale i.MX7 Dual (Device Tree)
> [   15.289780] Workqueue: events_unbound deferred_probe_work_func
> [   15.290540] PC is at ads7846_probe+0x9f0/0xfa0
> [   15.290701] LR is at _raw_spin_unlock_irqrestore+0x50/0x64
> 
> That is due to it picking up "Input: ads7846 - Convert to use software nodes"
> without its fixes.

Hm, let me run the "find the fixes for the patches in the queue" scripts
now and see what it digs up.

thanks for the report!

greg k-h
