Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5317C74C401
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 14:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjGIMSK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 08:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGIMSJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 08:18:09 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A842109
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 05:18:06 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-55b1238cab4so1810324a12.2
        for <stable@vger.kernel.org>; Sun, 09 Jul 2023 05:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688905085; x=1691497085;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h0vlG9/sRMQgVe5LYcorXCLyJ6AJ52vD3zrWN0Kxdb4=;
        b=Tsd0osy1knOva0wSZ6d+mORRDskHijYiHN0hEgD/XfQGtRLBEse6pbKXDVgnJm5RPa
         DSpxucTbKL/n70uJl8u1OcN5eHeGUdXa6HKY0iWXgc60Q0/yJW0MquXt8SwysBoIAati
         8MW7l8lTUjCN93sJ1bxcOQEseo4+l1aABaWxC61BYqg/XVJg8IKMg10hc+XOa0lfQuI+
         Q+scwvFVxksEfpHHh7OwtxouxpRrWW1VzN6cAMVs4sXkUeVu9n5zZ5PSQO3kZWCPkjfe
         PGCAgFJtqqwEkyLW91uT/2lXtnlZ7HMaVoC1ThKkj+gFvJKN9veckHHXxdqpDd3SWijU
         X67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688905085; x=1691497085;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h0vlG9/sRMQgVe5LYcorXCLyJ6AJ52vD3zrWN0Kxdb4=;
        b=Qp2PKuUooagWb98W6Zd/UWBlH8ju0xz6URzXdeOjp9D7X+pPfC0b3rjIPvyo85FLkS
         tw+MaQ6hvnpDDmNAZCXP1jH3UWT2MX7QT2bQuNCwDXGQKkDfGXD+7jGw8+hbFbvMbS4C
         92IH3A1aA6pU+GBjtKbe9lKgPxg6T41HVTiYzK3JJbCMSPAM8R9Vy426HyUhi/mEiT++
         PNNioJhWaC/8y3ax8jfCVHproy5hBG0owoFEuV0bpHHtr4NRSW5TnkVpdNoNn+vpD+bZ
         WXt8Nn2ul+FMSNeOjjljAFzEnYvf1qvOUyO8cFo0yEgPgkCKSAV7/L3kcNr0/ZUrJdrS
         rHQA==
X-Gm-Message-State: ABy/qLaeuEtcjoA7SPmEGr9sHap2jNdW7Nzl7ft3QQIsS4jxszlI1qF/
        JNk7B1nUqCH+w7IYXAbsbozkxwX6NN9uLqi1ikY=
X-Google-Smtp-Source: APBJJlF3n+0EQpP3/uScxvC/anh2c/fdqYRIVfpUJVZ4bv4vax7irC3KBmZ3ae0EF/F6sK2hF/NqYA==
X-Received: by 2002:a17:90b:46cf:b0:262:fe3e:a7c4 with SMTP id jx15-20020a17090b46cf00b00262fe3ea7c4mr8087024pjb.4.1688905084688;
        Sun, 09 Jul 2023 05:18:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 11-20020a17090a004b00b00265892de629sm4358889pjb.29.2023.07.09.05.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 05:18:04 -0700 (PDT)
Message-ID: <64aaa57b.170a0220.c6041.7afb@mx.google.com>
Date:   Sun, 09 Jul 2023 05:18:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.3.11-446-gc36188cdbe80
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-6.3.y
Subject: stable-rc/linux-6.3.y build: 123 builds: 3 failed, 120 passed,
 8 errors, 113 warnings (v6.3.11-446-gc36188cdbe80)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.3.y build: 123 builds: 3 failed, 120 passed, 8 errors, 11=
3 warnings (v6.3.11-446-gc36188cdbe80)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.3.y=
/kernel/v6.3.11-446-gc36188cdbe80/

Tree: stable-rc
Branch: linux-6.3.y
Git Describe: v6.3.11-446-gc36188cdbe80
Git Commit: c36188cdbe803adfeea94f8b4b1d2c5ebf1f0793
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

arm:
    omap1_defconfig: (gcc-10) FAIL

mips:
    ci20_defconfig: (gcc-10) FAIL
    decstation_64_defconfig: (gcc-10) FAIL

Errors and Warnings Detected:

arc:
    allnoconfig (gcc-10): 1 warning
    axs103_defconfig (gcc-10): 1 warning
    axs103_smp_defconfig (gcc-10): 1 warning
    haps_hs_defconfig (gcc-10): 1 warning
    haps_hs_smp_defconfig (gcc-10): 1 warning
    hsdk_defconfig (gcc-10): 1 warning
    nsimosci_hs_defconfig (gcc-10): 1 warning
    nsimosci_hs_smp_defconfig (gcc-10): 1 warning
    vdk_hs38_defconfig (gcc-10): 1 warning
    vdk_hs38_smp_defconfig (gcc-10): 1 warning

arm64:
    defconfig (gcc-10): 1 warning

arm:
    aspeed_g4_defconfig (gcc-10): 1 warning
    aspeed_g5_defconfig (gcc-10): 1 warning
    assabet_defconfig (gcc-10): 1 warning
    at91_dt_defconfig (gcc-10): 1 warning
    axm55xx_defconfig (gcc-10): 1 warning
    bcm2835_defconfig (gcc-10): 1 warning
    collie_defconfig (gcc-10): 1 warning
    exynos_defconfig (gcc-10): 1 warning
    gemini_defconfig (gcc-10): 1 warning
    h3600_defconfig (gcc-10): 1 warning
    hisi_defconfig (gcc-10): 1 warning
    imx_v4_v5_defconfig (gcc-10): 1 warning
    imx_v6_v7_defconfig (gcc-10): 1 warning
    imxrt_defconfig (gcc-10): 1 warning
    ixp4xx_defconfig (gcc-10): 1 warning
    jornada720_defconfig (gcc-10): 1 warning
    keystone_defconfig (gcc-10): 1 warning
    lpc18xx_defconfig (gcc-10): 1 warning
    lpc32xx_defconfig (gcc-10): 1 warning
    milbeaut_m10v_defconfig (gcc-10): 1 warning
    mmp2_defconfig (gcc-10): 1 warning
    moxart_defconfig (gcc-10): 1 warning
    multi_v4t_defconfig (gcc-10): 1 warning
    multi_v5_defconfig (gcc-10): 1 warning
    multi_v7_defconfig (gcc-10): 1 warning
    mvebu_v5_defconfig (gcc-10): 1 warning
    neponset_defconfig (gcc-10): 1 warning
    netwinder_defconfig (gcc-10): 1 warning
    nhk8815_defconfig (gcc-10): 1 warning
    omap1_defconfig (gcc-10): 3 errors, 1 warning
    orion5x_defconfig (gcc-10): 1 warning
    oxnas_v6_defconfig (gcc-10): 1 warning
    pxa168_defconfig (gcc-10): 1 warning
    pxa3xx_defconfig (gcc-10): 1 warning
    pxa910_defconfig (gcc-10): 1 warning
    pxa_defconfig (gcc-10): 1 warning
    qcom_defconfig (gcc-10): 1 warning
    realview_defconfig (gcc-10): 1 warning
    s3c6400_defconfig (gcc-10): 1 warning
    s5pv210_defconfig (gcc-10): 1 warning
    shmobile_defconfig (gcc-10): 1 warning
    sp7021_defconfig (gcc-10): 1 warning
    spear13xx_defconfig (gcc-10): 1 warning
    spear3xx_defconfig (gcc-10): 1 warning
    spear6xx_defconfig (gcc-10): 1 warning
    spitz_defconfig (gcc-10): 1 warning
    stm32_defconfig (gcc-10): 1 warning
    sunxi_defconfig (gcc-10): 1 warning
    tegra_defconfig (gcc-10): 1 warning
    u8500_defconfig (gcc-10): 1 warning
    versatile_defconfig (gcc-10): 1 warning
    vexpress_defconfig (gcc-10): 1 warning
    vf610m4_defconfig (gcc-10): 1 warning
    vt8500_v6_v7_defconfig (gcc-10): 1 warning
    wpcm450_defconfig (gcc-10): 1 warning

i386:
    allnoconfig (gcc-10): 1 warning

mips:
    32r2el_defconfig (gcc-10): 1 warning
    ar7_defconfig (gcc-10): 1 warning
    ath25_defconfig (gcc-10): 1 warning
    ath79_defconfig (gcc-10): 1 warning
    bcm47xx_defconfig (gcc-10): 1 warning
    bcm63xx_defconfig (gcc-10): 1 warning
    bmips_be_defconfig (gcc-10): 1 warning
    cavium_octeon_defconfig (gcc-10): 1 warning
    ci20_defconfig (gcc-10): 1 error
    cobalt_defconfig (gcc-10): 1 warning
    cu1000-neo_defconfig (gcc-10): 1 warning
    cu1830-neo_defconfig (gcc-10): 1 warning
    db1xxx_defconfig (gcc-10): 1 warning
    decstation_64_defconfig (gcc-10): 1 warning
    decstation_r4k_defconfig (gcc-10): 1 warning
    fuloong2e_defconfig (gcc-10): 1 error, 1 warning
    gcw0_defconfig (gcc-10): 1 warning
    gpr_defconfig (gcc-10): 1 warning
    ip22_defconfig (gcc-10): 1 warning
    ip28_defconfig (gcc-10): 1 warning
    ip32_defconfig (gcc-10): 1 warning
    jazz_defconfig (gcc-10): 1 warning
    lemote2f_defconfig (gcc-10): 1 error, 1 warning
    loongson1c_defconfig (gcc-10): 1 warning
    loongson2k_defconfig (gcc-10): 1 error, 1 warning
    loongson3_defconfig (gcc-10): 1 error, 1 warning
    malta_defconfig (gcc-10): 1 warning
    malta_kvm_defconfig (gcc-10): 1 warning
    malta_qemu_32r6_defconfig (gcc-10): 1 warning
    maltaaprp_defconfig (gcc-10): 1 warning
    maltasmvp_defconfig (gcc-10): 1 warning
    maltasmvp_eva_defconfig (gcc-10): 1 warning
    maltaup_defconfig (gcc-10): 1 warning
    maltaup_xpa_defconfig (gcc-10): 1 warning
    mtx1_defconfig (gcc-10): 1 warning
    omega2p_defconfig (gcc-10): 1 warning
    pic32mzda_defconfig (gcc-10): 1 warning
    qi_lb60_defconfig (gcc-10): 1 warning
    rb532_defconfig (gcc-10): 1 warning
    rm200_defconfig (gcc-10): 1 warning
    rs90_defconfig (gcc-10): 1 warning
    rt305x_defconfig (gcc-10): 1 warning
    sb1250_swarm_defconfig (gcc-10): 1 warning
    vocore2_defconfig (gcc-10): 1 warning

riscv:
    defconfig (gcc-10): 1 warning
    nommu_k210_sdcard_defconfig (gcc-10): 1 warning
    rv32_defconfig (gcc-10): 1 warning

x86_64:

Errors summary:

    4    cc1: error: =E2=80=98-mloongson-mmi=E2=80=99 must be used with =E2=
=80=98-mhard-float=E2=80=99
    1    arch/arm/mach-omap1/irq.c:250:23: error: implicit declaration of f=
unction =E2=80=98irq_find_mapping=E2=80=99 [-Werror=3Dimplicit-function-dec=
laration]
    1    arch/arm/mach-omap1/irq.c:222:13: error: =E2=80=98irq_domain_simpl=
e_ops=E2=80=99 undeclared (first use in this function)
    1    arch/arm/mach-omap1/irq.c:221:11: error: implicit declaration of f=
unction =E2=80=98irq_domain_add_legacy=E2=80=99 [-Werror=3Dimplicit-functio=
n-declaration]
    1    ERROR: Input tree has errors, aborting (use -f to force output)

Warnings summary:

    112  include/linux/blktrace_api.h:88:33: warning: statement with no eff=
ect [-Wunused-value]
    1    cc1: some warnings being treated as errors

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section m=
ismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
allnoconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section mi=
smatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
ar7_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section=
 mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
aspeed_g4_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
aspeed_g5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
assabet_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
at91_dt_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
ath25_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
ath79_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
axm55xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
axs103_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
axs103_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 s=
ection mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
bcm2835_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
bcm47xx_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
bcm63xx_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
bmips_be_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
bmips_stb_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

---------------------------------------------------------------------------=
-----
cavium_octeon_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning,=
 0 section mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
ci20_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sectio=
n mismatches

Errors:
    ERROR: Input tree has errors, aborting (use -f to force output)

---------------------------------------------------------------------------=
-----
cobalt_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
collie_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
cu1000-neo_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 =
section mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
cu1830-neo_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 =
section mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
db1xxx_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
decstation_64_defconfig (mips, gcc-10) =E2=80=94 FAIL, 0 errors, 1 warning,=
 0 section mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
decstation_r4k_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning=
, 0 section mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section mi=
smatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section mi=
smatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
exynos_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
fuloong2e_defconfig (mips, gcc-10) =E2=80=94 PASS, 1 error, 1 warning, 0 se=
ction mismatches

Errors:
    cc1: error: =E2=80=98-mloongson-mmi=E2=80=99 must be used with =E2=80=
=98-mhard-float=E2=80=99

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
gcw0_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
gemini_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
gpr_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section=
 mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
h3600_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
haps_hs_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 =
section mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
hisi_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section=
 mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
hsdk_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section=
 mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
imx_v4_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
imxrt_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
ip22_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
ip28_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
ip32_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
ixp4xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
jazz_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
jornada720_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 s=
ection mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
keystone_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
lemote2f_defconfig (mips, gcc-10) =E2=80=94 PASS, 1 error, 1 warning, 0 sec=
tion mismatches

Errors:
    cc1: error: =E2=80=98-mloongson-mmi=E2=80=99 must be used with =E2=80=
=98-mhard-float=E2=80=99

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
loongson1c_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 =
section mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
loongson2k_defconfig (mips, gcc-10) =E2=80=94 PASS, 1 error, 1 warning, 0 s=
ection mismatches

Errors:
    cc1: error: =E2=80=98-mloongson-mmi=E2=80=99 must be used with =E2=80=
=98-mhard-float=E2=80=99

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
loongson3_defconfig (mips, gcc-10) =E2=80=94 PASS, 1 error, 1 warning, 0 se=
ction mismatches

Errors:
    cc1: error: =E2=80=98-mloongson-mmi=E2=80=99 must be used with =E2=80=
=98-mhard-float=E2=80=99

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
lpc18xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
lpc32xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
malta_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
malta_kvm_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 s=
ection mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
malta_qemu_32r6_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warnin=
g, 0 section mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
maltaaprp_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 s=
ection mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
maltasmvp_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 s=
ection mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
maltasmvp_eva_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning,=
 0 section mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
maltaup_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
maltaup_xpa_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0=
 section mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
milbeaut_m10v_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, =
0 section mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
mmp2_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section=
 mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
moxart_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
mps2_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
mtx1_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
multi_v4t_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
multi_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
mvebu_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
mxs_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section=
 mismatches

---------------------------------------------------------------------------=
-----
neponset_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
netwinder_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
nhk8815_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
nommu_k210_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, =
0 section mismatches

---------------------------------------------------------------------------=
-----
nommu_k210_sdcard_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 1 war=
ning, 0 section mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
nsimosci_hs_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 =
section mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
nsimosci_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning=
, 0 section mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
omap1_defconfig (arm, gcc-10) =E2=80=94 FAIL, 3 errors, 1 warning, 0 sectio=
n mismatches

Errors:
    arch/arm/mach-omap1/irq.c:221:11: error: implicit declaration of functi=
on =E2=80=98irq_domain_add_legacy=E2=80=99 [-Werror=3Dimplicit-function-dec=
laration]
    arch/arm/mach-omap1/irq.c:222:13: error: =E2=80=98irq_domain_simple_ops=
=E2=80=99 undeclared (first use in this function)
    arch/arm/mach-omap1/irq.c:250:23: error: implicit declaration of functi=
on =E2=80=98irq_find_mapping=E2=80=99 [-Werror=3Dimplicit-function-declarat=
ion]

Warnings:
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
omega2p_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
orion5x_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
oxnas_v6_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
pic32mzda_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 s=
ection mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
pxa168_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
pxa3xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
pxa910_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
pxa_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section =
mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
qcom_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section=
 mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
qi_lb60_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
rb532_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
realview_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
rm200_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
rs90_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
rt305x_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
rv32_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
s3c6400_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
s5pv210_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
sb1250_swarm_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, =
0 section mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
shmobile_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
sp7021_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
spear13xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
spear3xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
spear6xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
spitz_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
stm32_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
sunxi_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
tegra_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
tinyconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section=
 mismatches

---------------------------------------------------------------------------=
-----
u8500_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
vdk_hs38_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
vdk_hs38_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0=
 section mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
versatile_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
vexpress_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
vf610m4_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
vocore2_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
vt8500_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0=
 section mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
wpcm450_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
0 warnings, 0 section mismatches

---
For more info write to <info@kernelci.org>
