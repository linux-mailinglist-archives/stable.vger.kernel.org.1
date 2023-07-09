Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F9A74C84F
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 23:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjGIVLA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 17:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGIVLA (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 17:11:00 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9BF118
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 14:10:56 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-262ea2ff59dso1822390a91.0
        for <stable@vger.kernel.org>; Sun, 09 Jul 2023 14:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688937056; x=1691529056;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gh1vhAUIIyfFDMveB5LJ4okl9WqoEnNhN4+WLv82AgE=;
        b=QYGsgcG7Odc8k+/s3/Ak70TYmXJo4c/sv52U+rKhLE/uua1x5AzFg4FUgrASEgRY+d
         lEJpg1m2kkGgHHS4qbLQUYAuAdAn1CNlzAQQgcsjfrn2iLQrxhM4UfA6fQXSegPzcgR/
         eELaKHX60vpn10PrQ/6wnKIddRrC6gyujrbjnGW+Cj6SqdVtzBeVhWTlAA35v4gGI94u
         d7Py5rIWw2Tv0OtKz5EJnGXdidVLsmcpMtuog5+njmDgRMGjWbFzfCNY5jjyZF/8Mg0D
         Jox7MPi4NaeadMk9jK8OOYwX9yINXjA7NRKjU80SndUnWhpR/FAukkcwsEUlZYuxuHR3
         J6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688937056; x=1691529056;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gh1vhAUIIyfFDMveB5LJ4okl9WqoEnNhN4+WLv82AgE=;
        b=N9l5U9/rq5xLFxG/0pa1Jg1Vn1wdMcOTE2x89TCto5LB26WCuGiJPoaK1GcPnRVmsQ
         3P3O7ae+cTmyOdfhs4hRWCarco97KpX1ekjhyZilZ6NVnggRE6+oRFsRsDLKjWQceA4j
         gTdUbOfesaR90V4gwgGcou7ztZiHD9PHUwItnuwIM3ia6ykxJTKwyBcHbAHmBXMi9x2g
         E/uKpU31sjAOIjYEN69eXMoUg+xyUlvUFw4b5045tViqHDPi/IaRdRov6b9a5W8JR7MK
         i0fLQ7WnrWG+4VSZSrzYp+8uLK5wLsZAG2LmGPyZwPaCxGsxwoEDYIF2thiO7q6RSaBm
         u+ow==
X-Gm-Message-State: ABy/qLbZmmlNzIh7l2o4QTrUve34ZEzZ/DnaNI7sg6DTfnr9hnhvhMvf
        7+zP1Sno9OHMDeLXDL4vZ0slh55fTQYVoVj6vRSxgA==
X-Google-Smtp-Source: APBJJlE7m0KYKrE558zX+mwfN1jeQS6p8smNe42ffEX9RqOaFpV5yZ7iBK3vyCM5nTgY+QxFoRrjqg==
X-Received: by 2002:a17:90a:c292:b0:263:f5fa:cf1b with SMTP id f18-20020a17090ac29200b00263f5facf1bmr8627951pjt.30.1688937055208;
        Sun, 09 Jul 2023 14:10:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f91-20020a17090a706400b00264040322ddsm5191128pjk.45.2023.07.09.14.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 14:10:54 -0700 (PDT)
Message-ID: <64ab225e.170a0220.cfd0a.9ae1@mx.google.com>
Date:   Sun, 09 Jul 2023 14:10:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.3.11-440-g3b3c1cd9a77d
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-6.3.y
Subject: stable-rc/linux-6.3.y build: 123 builds: 2 failed, 121 passed,
 4 errors, 113 warnings (v6.3.11-440-g3b3c1cd9a77d)
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

stable-rc/linux-6.3.y build: 123 builds: 2 failed, 121 passed, 4 errors, 11=
3 warnings (v6.3.11-440-g3b3c1cd9a77d)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.3.y=
/kernel/v6.3.11-440-g3b3c1cd9a77d/

Tree: stable-rc
Branch: linux-6.3.y
Git Describe: v6.3.11-440-g3b3c1cd9a77d
Git Commit: 3b3c1cd9a77dad944040628eb27473ce6b4cec2c
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

mips:
    ci20_defconfig: (gcc-10) FAIL
    decstation_64_defconfig: (gcc-10) FAIL

Errors and Warnings Detected:

arc:
    axs103_defconfig (gcc-10): 1 warning
    axs103_smp_defconfig (gcc-10): 1 warning
    haps_hs_defconfig (gcc-10): 1 warning
    haps_hs_smp_defconfig (gcc-10): 1 warning
    hsdk_defconfig (gcc-10): 1 warning
    nsimosci_hs_defconfig (gcc-10): 1 warning
    nsimosci_hs_smp_defconfig (gcc-10): 1 warning
    vdk_hs38_defconfig (gcc-10): 1 warning

arm64:
    defconfig (gcc-10): 1 warning
    defconfig+arm64-chromebook (gcc-10): 1 warning

arm:
    am200epdkit_defconfig (gcc-10): 1 warning
    aspeed_g4_defconfig (gcc-10): 1 warning
    aspeed_g5_defconfig (gcc-10): 1 warning
    assabet_defconfig (gcc-10): 1 warning
    at91_dt_defconfig (gcc-10): 1 warning
    axm55xx_defconfig (gcc-10): 1 warning
    bcm2835_defconfig (gcc-10): 1 warning
    collie_defconfig (gcc-10): 1 warning
    davinci_all_defconfig (gcc-10): 1 warning
    exynos_defconfig (gcc-10): 1 warning
    footbridge_defconfig (gcc-10): 1 warning
    gemini_defconfig (gcc-10): 1 warning
    h3600_defconfig (gcc-10): 1 warning
    hisi_defconfig (gcc-10): 1 warning
    imxrt_defconfig (gcc-10): 1 warning
    integrator_defconfig (gcc-10): 1 warning
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
    mvebu_v7_defconfig (gcc-10): 1 warning
    neponset_defconfig (gcc-10): 1 warning
    netwinder_defconfig (gcc-10): 1 warning
    nhk8815_defconfig (gcc-10): 1 warning
    omap2plus_defconfig (gcc-10): 1 warning
    orion5x_defconfig (gcc-10): 1 warning
    pxa_defconfig (gcc-10): 1 warning
    qcom_defconfig (gcc-10): 1 warning
    realview_defconfig (gcc-10): 1 warning
    s3c6400_defconfig (gcc-10): 1 warning
    s5pv210_defconfig (gcc-10): 1 warning
    sama5_defconfig (gcc-10): 1 warning
    sama7_defconfig (gcc-10): 1 warning
    socfpga_defconfig (gcc-10): 1 warning
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
    bigsur_defconfig (gcc-10): 1 warning
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
    ip27_defconfig (gcc-10): 1 warning
    ip28_defconfig (gcc-10): 1 warning
    ip32_defconfig (gcc-10): 1 warning
    jazz_defconfig (gcc-10): 1 warning
    lemote2f_defconfig (gcc-10): 1 error, 1 warning
    loongson1b_defconfig (gcc-10): 1 warning
    loongson1c_defconfig (gcc-10): 1 warning
    loongson3_defconfig (gcc-10): 1 error, 1 warning
    malta_defconfig (gcc-10): 1 warning
    malta_kvm_defconfig (gcc-10): 1 warning
    malta_qemu_32r6_defconfig (gcc-10): 1 warning
    maltaaprp_defconfig (gcc-10): 1 warning
    maltasmvp_defconfig (gcc-10): 1 warning
    maltasmvp_eva_defconfig (gcc-10): 1 warning
    maltaup_xpa_defconfig (gcc-10): 1 warning
    mtx1_defconfig (gcc-10): 1 warning
    pic32mzda_defconfig (gcc-10): 1 warning
    qi_lb60_defconfig (gcc-10): 1 warning
    rbtx49xx_defconfig (gcc-10): 1 warning
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
    allnoconfig (gcc-10): 1 warning

Errors summary:

    3    cc1: error: =E2=80=98-mloongson-mmi=E2=80=99 must be used with =E2=
=80=98-mhard-float=E2=80=99
    1    ERROR: Input tree has errors, aborting (use -f to force output)

Warnings summary:

    113  include/linux/blktrace_api.h:88:33: warning: statement with no eff=
ect [-Wunused-value]

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
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section=
 mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
am200epdkit_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 =
section mismatches

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
bigsur_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

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
davinci_all_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 =
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
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warn=
ing, 0 section mismatches

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
footbridge_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 s=
ection mismatches

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
imxrt_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
integrator_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 s=
ection mismatches

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
ip27_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
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
loongson1b_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 =
section mismatches

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
mvebu_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
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
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

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
pic32mzda_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 s=
ection mismatches

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
rbtx49xx_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

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
sama5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
sama7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

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
socfpga_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

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
tinyconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section=
 mismatches

---------------------------------------------------------------------------=
-----
tinyconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

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
