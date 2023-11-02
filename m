Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01D87DF097
	for <lists+stable@lfdr.de>; Thu,  2 Nov 2023 11:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347140AbjKBKty (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 2 Nov 2023 06:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346817AbjKBKtx (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 2 Nov 2023 06:49:53 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88555133
        for <stable@vger.kernel.org>; Thu,  2 Nov 2023 03:49:47 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cc3c51f830so6228565ad.1
        for <stable@vger.kernel.org>; Thu, 02 Nov 2023 03:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698922186; x=1699526986; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bsHkNyuleuCdTYkXbIsmQty37rfmc7rY3dwqdLymzDs=;
        b=C/3uS9YbC0tJjuqGGsEMPDn/e4A73ZFUSBGtIWRsI11KdzF9CuIng6uJWz5O2byDwb
         iVpdpPzLGgdV/5GvvaazdQW/KVyjrJx7RpNZKr83+4hRHuAyiAvK5zsPEn8RHx1p4lX4
         XHF+ldgBQu2wSK5lrURN3afLGXRdoWYY76sgWIbKy3OhO0iQQ0Cel8OmVz0Qp/6fBdCc
         geQv6Ba94F09VxpcOuhefV1V6H7OcWxISZB+NWiZIoeapVZPkyT3UGbR+MY+5ntYpgx3
         +1I4M9imVJdG7E9tTijrN2K5gy58dU394X5e1g2OWiOYFhlfab/xgaQcekrmjtDLAb0Z
         hn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698922186; x=1699526986;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bsHkNyuleuCdTYkXbIsmQty37rfmc7rY3dwqdLymzDs=;
        b=D8LV7kpVcOB7qT/YVCHhmcTN9yVajykZMOp2GMj9SCEY5K1z7SjRQkcdlELM8UEeWr
         n5eI2+PtJJslm53lVDb0Eze0FEN33igupW0XV2Gj+52eKmG6002+jxTdgSUMx9bMlWpX
         ICW+45jOpinIPZ0aSYKtY1WKLHnLQIb/LhMlPHA8XZiruaApWX6+/rA8F9OzfvHL82aT
         lTIgJuu9mXg3LlIAcjPuTLcVTOLK85IsWpoW1X+KtlXVNkAxfdeKccGq54kbQhQOXAPr
         DJ+Jmg1Gfz+0vOgjShiR62o00r1VIGKSM7FtymVx/5Q+zXPc5XptnKnqId4cacTu9ZZm
         /bXw==
X-Gm-Message-State: AOJu0YxEfwyqSQVIRcFlTPcpmckKnXC8UjJzIcz7exekeDSyDedidgbR
        8b5y999aUEK3QeZl8NVB/6rG1OesxKaWe30mHAvUZw==
X-Google-Smtp-Source: AGHT+IH8kmboI7VIDf2tdDA1WRUf/I9bw991wV9OpcZsgjGOOPGL7MB+Nd3tVnCXgvl7WMK8iK5uqw==
X-Received: by 2002:a17:902:e494:b0:1c9:d948:33d5 with SMTP id i20-20020a170902e49400b001c9d94833d5mr11336964ple.64.1698922186463;
        Thu, 02 Nov 2023 03:49:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902cec200b001cc3b988fd6sm2820659plg.265.2023.11.02.03.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 03:49:45 -0700 (PDT)
Message-ID: <65437ec9.170a0220.92e3f.7587@mx.google.com>
Date:   Thu, 02 Nov 2023 03:49:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.61
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable
Subject: stable/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.61)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-6.1.y build: 20 builds: 0 failed, 20 passed, 1 warning (v6.1.6=
1)

Full Build Summary: https://kernelci.org/build/stable/branch/linux-6.1.y/ke=
rnel/v6.1.61/

Tree: stable
Branch: linux-6.1.y
Git Describe: v6.1.61
Git Commit: 4a61839152cc3e9e00ac059d73a28d148d622b30
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

x86_64:


Warnings summary:

    1    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_devic=
e_reg): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expec=
ted "0,0"

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
    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_device_reg=
): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expected "=
0,0"

---------------------------------------------------------------------------=
-----
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches

---------------------------------------------------------------------------=
-----
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warn=
ings, 0 section mismatches

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
multi_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
nommu_k210_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, =
0 section mismatches

---------------------------------------------------------------------------=
-----
nommu_k210_sdcard_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
rv32_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

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
vexpress_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---
For more info write to <info@kernelci.org>
