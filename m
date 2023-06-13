Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F7672D6E6
	for <lists+stable@lfdr.de>; Tue, 13 Jun 2023 03:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237650AbjFMBbb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 21:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjFMBba (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 21:31:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E747E170C;
        Mon, 12 Jun 2023 18:31:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83F7F617D1;
        Tue, 13 Jun 2023 01:31:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D467DC433D2;
        Tue, 13 Jun 2023 01:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686619888;
        bh=2Qez9fGDCFarTx5Ve6EEpJ+fNKUyZFNMcYEhegPotRk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Ymn+zv/3mhPOAFGGWPqiKA7Uc4oKtTwekHW6dOkSKEwTPxU3Fv/GVDF8Sm3fvdvI5
         h2ALZriwNyeuyylwodcgJIuGz+CywTVMzB4hrWBNI8fQwP/hk+XbB8U37wX6W2MGgN
         ZnS8QTLy4VsRZPkN4Iip0OpzFhtT9guGtiTcWEoOssmVN3ZTYC9HBqBwMZnW3WuvQl
         BAJbRtqlRJzTLHn358OlYUma5DoUnTqGcMgZin2XVWAki8HBUVVViv+Il2DETDVISE
         v2AHEflA7g0Ejwdop/iC77SUC43qI00puE4jacNxyVHoQsBWBLgaxnomLKqDx3KohU
         J3qFstmEqjigg==
Message-ID: <17da2c39b6dee3e18d55da7a8d08d2c5.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230524014924.2869051-1-zhoubinbin@loongson.cn>
References: <20230524014924.2869051-1-zhoubinbin@loongson.cn>
Subject: Re: [PATCH] clk: clk-loongson2: Zero init clk_init_data
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn,
        Binbin Zhou <zhoubinbin@loongson.cn>, stable@vger.kernel.org,
        Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Date:   Mon, 12 Jun 2023 18:31:26 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Quoting Binbin Zhou (2023-05-23 18:49:24)
> As clk_core_populate_parent_map() checks clk_init_data.num_parents
> first, and checks clk_init_data.parent_names[] before
> clk_init_data.parent_data[] and clk_init_data.parent_hws[].
>=20
> Therefore the clk_init_data structure needs to be explicitly initialised
> to prevent an unexpected crash if clk_init_data.parent_names[] is a
> random value.
>=20
> [    1.374074] CPU 0 Unable to handle kernel paging request at virtual ad=
dress 0000000000000dc0, era =3D=3D 9000000002986290, ra =3D=3D 900000000298=
624c
> [    1.386856] Oops[#1]:
> [    1.389151] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.4.0-rc2+ #4582
> [    1.395717] pc 9000000002986290 ra 900000000298624c tp 900000010009400=
0 sp 9000000100097a60
> [    1.404126] a0 9000000104541e00 a1 0000000000000000 a2 0000000000000dc=
0 a3 0000000000000001
> [    1.412533] a4 90000001000979f0 a5 90000001800977d7 a6 000000000000000=
0 a7 900000000362a000
> [    1.420939] t0 90000000034f3548 t1 6f8c2a9cb5ab5f64 t2 000000000001134=
0 t3 90000000031cf5b0
> [    1.429346] t4 0000000000000dc0 t5 0000000000000004 t6 000000000001130=
0 t7 9000000104541e40
> [    1.437753] t8 000000000005a4f8 u0 9000000104541e00 s9 9000000104541e0=
0 s0 9000000104bc4700
> [    1.446159] s1 9000000104541da8 s2 0000000000000001 s3 900000000356f9d=
8 s4 ffffffffffffffff
> [    1.454565] s5 0000000000000000 s6 0000000000000dc0 s7 90000000030d0a8=
8 s8 0000000000000000
> [    1.462972]    ra: 900000000298624c __clk_register+0x228/0x84c
> [    1.468854]   ERA: 9000000002986290 __clk_register+0x26c/0x84c
> [    1.474724]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=3DCC DACM=3DCC -WE)
> [    1.480975]  PRMD: 00000004 (PPLV0 +PIE -PWE)
> [    1.485373]  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
> [    1.490209]  ECFG: 00071c1c (LIE=3D2-4,10-12 VS=3D7)
> [    1.494865] ESTAT: 00010000 [PIL] (IS=3D ECode=3D1 EsubCode=3D0)
> [    1.500390]  BADV: 0000000000000dc0
> [    1.503899]  PRID: 0014a000 (Loongson-64bit, )
> [    1.508369] Modules linked in:
> [    1.511447] Process swapper/0 (pid: 1, threadinfo=3D(____ptrval____), =
task=3D(____ptrval____))
> [    1.519768] Stack : 90000000031c1810 90000000030d0a88 900000000325bac0=
 90000000034f3548
> [    1.527848]         90000001002ab410 9000000104541e00 0000000000000dc0=
 9000000003150098
> [    1.535923]         90000000031c1810 90000000031a0460 900000000362a000=
 90000001002ab410
> [    1.543998]         900000000362a000 9000000104541da8 9000000104541de8=
 90000001002ab410
> [    1.552073]         900000000362a000 9000000002986a68 90000000034f3ed8=
 90000000030d0aa8
> [    1.560148]         9000000104541da8 900000000298d3b8 90000000031c1810=
 0000000000000000
> [    1.568223]         90000000034f3ed8 90000000030d0aa8 0000000000000dc0=
 90000000030d0a88
> [    1.576298]         90000001002ab410 900000000298d401 0000000000000000=
 6f8c2a9cb5ab5f64
> [    1.584373]         90000000034f4000 90000000030d0a88 9000000003a48a58=
 90000001002ab410
> [    1.592448]         9000000104bd81a8 900000000298d484 9000000100020260=
 0000000000000000
> [    1.600523]         ...
> [    1.602993] Call Trace:
> [    1.603000] [<9000000002986290>] __clk_register+0x26c/0x84c
> [    1.611072] [<9000000002986a68>] devm_clk_hw_register+0x5c/0xe0
> [    1.617031] [<900000000298d3b8>] loongson2_clk_register.constprop.0+0x=
dc/0x10c
> [    1.624314] [<900000000298d484>] loongson2_clk_probe+0x9c/0x4ac
> [    1.630270] [<9000000002a4eba4>] platform_probe+0x68/0xc8
> [    1.635703] [<9000000002a4bf80>] really_probe+0xbc/0x2f0
> [    1.641054] [<9000000002a4c23c>] __driver_probe_device+0x88/0x128
> [    1.647185] [<9000000002a4c318>] driver_probe_device+0x3c/0x11c
> [    1.653142] [<9000000002a4c5dc>] __driver_attach+0x98/0x18c
> [    1.658749] [<9000000002a49ca0>] bus_for_each_dev+0x80/0xe0
> [    1.664357] [<9000000002a4b0dc>] bus_add_driver+0xfc/0x1ec
> [    1.669878] [<9000000002a4d4a8>] driver_register+0x68/0x134
> [    1.675486] [<90000000020f0110>] do_one_initcall+0x50/0x188
> [    1.681094] [<9000000003150f00>] kernel_init_freeable+0x224/0x294
> [    1.687226] [<90000000030240fc>] kernel_init+0x20/0x110
> [    1.692493] [<90000000020f1568>] ret_from_kernel_thread+0xc/0xa4
>=20
> Fixes: acc0ccffec50 ("clk: clk-loongson2: add clock controller driver sup=
port")
> Cc: stable@vger.kernel.org
> Cc: Yinbo Zhu <zhuyinbo@loongson.cn>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---

Applied to clk-fixes
