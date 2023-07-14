Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFA67537DD
	for <lists+stable@lfdr.de>; Fri, 14 Jul 2023 12:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbjGNKVv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 14 Jul 2023 06:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbjGNKVu (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 14 Jul 2023 06:21:50 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8621BE44
        for <stable@vger.kernel.org>; Fri, 14 Jul 2023 03:21:49 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6687466137bso1141326b3a.0
        for <stable@vger.kernel.org>; Fri, 14 Jul 2023 03:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689330108; x=1691922108;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AjpTQGN+lYO9qrNW3icfYs3ECA8HS2tm8ENGGiE2+ck=;
        b=LEBSiOmGbkNjQCt/pvz/xgSP1+8pBHcRrCDqL+nvY4JPDECzAqbemIaWfI5ihIGIdW
         q3rdKYd07VxzxbUDevsM/KTbwwS7CadFa/9GARFki0N5RATgo5iWLfNmoVsZZX2ZsiA3
         dgTnFUiyWRso052T/LrII3c0R8Wy/Azwf5gDl0LlHNveFYrUF3zKUwDb66JeNrL7c/89
         qsJQlafm29MEKBkfUUCMWghZ3QFRzpZ2mewu+Rnoj3JXW5c7JHzJtSUrYP0+HVEz50Jx
         XlBePJLtNzk0mUtOZRcVsyul6hWdcGk1i6HdFHaWeQ8UpfkN+AaScDA2oJYGYOenSPpx
         XK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689330108; x=1691922108;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AjpTQGN+lYO9qrNW3icfYs3ECA8HS2tm8ENGGiE2+ck=;
        b=Bb6UMA35KI8+dm/h6Prg3Cu3zNuto/82UU0yRbtGLckgHXLu7gd0lmPnVpwZPFZMm0
         hSMvwBA8OW8Lf7PhHcRCXB2F5dZU0cXW8EppQbd1X+J4aXtC8I7rKsXX9jCTKW35hLLA
         OOiTMhdxlaHTuzSICMCfYwRNSUQwViFHO0XWodLWnCZTA9qqjiapGuH9jDp7GVzpSmYy
         fhvwcYfhK0+Sri6bDN8B9LmT5yZxbNICp8O6ISSG7E+cS9TkwDfWLpy+TzX/tHnSrw0A
         HFJfZcyHc151fGxeO7CpPHQ/Ja8WxAjmonh4GTrI9goYalnWSblRFwW1XEnx9m4d5Y4Y
         i6EQ==
X-Gm-Message-State: ABy/qLb4OfHKI55BQ2r/XuHB/cbYWq8xkdux3RIzPX2+8F3yNZ81Hlx7
        aaJN3C2tfvlfeRCFxVCAAMNrrqClzmA=
X-Google-Smtp-Source: APBJJlHUUMPOHi4ZK0m4BmXYMJh97zQZCQ2Uw05vkYcTnfaZuz+qtHH2e66brZ1auosaBG3fMw95Pw==
X-Received: by 2002:a05:6a20:7fa1:b0:11f:2714:f6f3 with SMTP id d33-20020a056a207fa100b0011f2714f6f3mr3712808pzj.11.1689330108515;
        Fri, 14 Jul 2023 03:21:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ff10-20020a056a002f4a00b00682a75a50e3sm7107855pfb.17.2023.07.14.03.21.47
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 03:21:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <897ebb05-5a1f-e353-8877-49721c52d065@roeck-us.net>
Date:   Fri, 14 Jul 2023 03:21:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     stable <stable@vger.kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Build failures / crashes in stable queue branches
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.14.y:

Build reference: v4.14.320-57-gbc1094b21392
Compiler version: arm-linux-gnueabi-gcc (GCC) 11.4.0
Assembler version: GNU assembler (GNU Binutils) 2.40

Building arm:omap2plus_defconfig ... failed
Building arm:multi_v5_defconfig ... failed
Building arm:keystone_defconfig ... failed (and others)

arm-linux-gnueabi-ld: arch/arm/probes/kprobes/core.o: in function `jprobe_return':
arch/arm/probes/kprobes/core.c:555: undefined reference to `kprobe_handler'

---------
6.1.y:

Build reference: v6.1.38-393-gb6386e7314b4
Compiler version: alpha-linux-gcc (GCC) 11.4.0
Assembler version: GNU assembler (GNU Binutils) 2.40

Building alpha:allmodconfig ... failed
Building m68k:allmodconfig ... failed
--------------
Error log:
<stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
In file included from block/genhd.c:28:
block/genhd.c: In function 'disk_release':
include/linux/blktrace_api.h:88:57: error: statement with no effect [-Werror=unused-value]
    88 | # define blk_trace_remove(q)                            (-ENOTTY)
       |                                                         ^
block/genhd.c:1185:9: note: in expansion of macro 'blk_trace_remove'
  1185 |         blk_trace_remove(disk->queue);

-------------
6.4.y:

Build reference: v6.4.3-548-g5f35ab2efbc9
Compiler version: alpha-linux-gcc (GCC) 11.4.0
Assembler version: GNU assembler (GNU Binutils) 2.40

Building alpha:allmodconfig ... failed
Building m68k:allmodconfig ... failed
--------------
Error log:
<stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
In file included from block/genhd.c:28:
block/genhd.c: In function 'disk_release':
include/linux/blktrace_api.h:88:57: error: statement with no effect [-Werror=unused-value]
    88 | # define blk_trace_remove(q)                            (-ENOTTY)
       |                                                         ^
block/genhd.c:1175:9: note: in expansion of macro 'blk_trace_remove'
  1175 |         blk_trace_remove(disk->queue);

Building mips:allmodconfig ... failed
--------------
Error log:
arch/mips/boot/dts/ingenic/ci20.dts:242.19-247.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/DCDC1: Reference to non-existent node or label "vcc_33v"
arch/mips/boot/dts/ingenic/ci20.dts:248.18-253.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/DCDC2: Reference to non-existent node or label "vcc_33v"
arch/mips/boot/dts/ingenic/ci20.dts:254.18-259.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/DCDC3: Reference to non-existent node or label "vcc_33v"
arch/mips/boot/dts/ingenic/ci20.dts:265.17-270.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO5: Reference to non-existent node or label "vcc_33v"
arch/mips/boot/dts/ingenic/ci20.dts:271.18-276.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO6: Reference to non-existent node or label "vcc_33v"
arch/mips/boot/dts/ingenic/ci20.dts:277.20-282.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO7: Reference to non-existent node or label "vcc_33v"
arch/mips/boot/dts/ingenic/ci20.dts:283.20-288.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO8: Reference to non-existent node or label "vcc_33v"
ERROR: Input tree has errors, aborting (use -f to force output)
make[3]: [scripts/Makefile.lib:419: arch/mips/boot/dts/ingenic/ci20.dtb] Error 2 (ignored)
arch/mips/boot/dts/ingenic/ci20.dts:242.19-247.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/DCDC1: Reference to non-existent node or label "vcc_33v"
arch/mips/boot/dts/ingenic/ci20.dts:248.18-253.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/DCDC2: Reference to non-existent node or label "vcc_33v"
arch/mips/boot/dts/ingenic/ci20.dts:254.18-259.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/DCDC3: Reference to non-existent node or label "vcc_33v"
arch/mips/boot/dts/ingenic/ci20.dts:265.17-270.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO5: Reference to non-existent node or label "vcc_33v"
arch/mips/boot/dts/ingenic/ci20.dts:271.18-276.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO6: Reference to non-existent node or label "vcc_33v"
arch/mips/boot/dts/ingenic/ci20.dts:277.20-282.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO7: Reference to non-existent node or label "vcc_33v"
arch/mips/boot/dts/ingenic/ci20.dts:283.20-288.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO8: Reference to non-existent node or label "vcc_33v"
ERROR: Input tree has errors, aborting (use -f to force output)

On top of the build failures, mcimx7d-sabre emulations crash
in 6.4.y.queue with a NULL pointer access in ads7846_probe().

[   15.286830] 8<--- cut here ---
[   15.287438] Unhandled fault: page domain fault (0x01b) at 0x00001eba
[   15.287707] [00001eba] *pgd=00000000
[   15.288503] Internal error: : 1b [#1] SMP ARM
[   15.288852] Modules linked in:
[   15.289177] CPU: 0 PID: 29 Comm: kworker/u4:2 Tainted: G                 N 6.4.4-rc1-g5f35ab2efbc9 #1
[   15.289433] Hardware name: Freescale i.MX7 Dual (Device Tree)
[   15.289780] Workqueue: events_unbound deferred_probe_work_func
[   15.290540] PC is at ads7846_probe+0x9f0/0xfa0
[   15.290701] LR is at _raw_spin_unlock_irqrestore+0x50/0x64

That is due to it picking up "Input: ads7846 - Convert to use software nodes"
without its fixes.

Guenter
