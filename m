Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABBD7A34D1
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 11:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbjIQJIO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 05:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbjIQJHt (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 05:07:49 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71F3121
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 02:07:40 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6c0b8f42409so2129714a34.0
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 02:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694941659; x=1695546459; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u2x/NZmpVINVauxH+WJGuylWDbZ7rQVU1Ipnc7f4Kuc=;
        b=3Jr+mUQqiurtPF5RWfJgPymtBUhYjQMBbTGgcuu3frrykg+4hfyKjLUtU7taLFMlEH
         iwla2u398KEfUKFmqrFcFlrILhU9oxHzfVGN6/CC3o0wX3BCjRJnttBaXT9U0Q1Ullkx
         B02mXgdTq1cDheaHPUY/v9FZbGwcaptETtw+3ox+v+4ayYH3jx6MkXm9uDWGXByuPdL8
         lc4VZJTP8718dzX24TndtdTupn9a050c4nlNyAB/QVNJq52B2wzIDwjScgBQjgTymaQW
         hgTYcOrG1mAy0PsGUv+3M733kpzzMZyPfu4Eh+Q07bzdm0vsENCbpcXruWRf2Y5jwl1c
         IvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694941659; x=1695546459;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u2x/NZmpVINVauxH+WJGuylWDbZ7rQVU1Ipnc7f4Kuc=;
        b=RMgfAwECotbKT3kyYnjcIk2hBEZ55tQhrvf9FZSGVwdYyvWe6plIdet6OQNX7cHexr
         vT7ECMT1b7Z0KQ9JBKgxMLtOzC4GcA/gjgLvuvGb5SuNC/EdcnxPJqNc9l2cp5Y8imDw
         yd8317jwjpTv3qhe4CbkHSDjnra1Up2mVqOuDYCofjFWePX16+rwppqA6/CBILq9x3Mu
         +HBA6oDaV1t2z23HURvP0vraKUqdb2KEB2mkj+S6AJG1OC04kpylofNx9kAylj+MFqN4
         w5i1HQ9qSMFG/moT+Dt6CQutxsSurxtZuWa/csEScRgDX63HjQ2VHPzDlRGN6uR4wGBT
         mzoA==
X-Gm-Message-State: AOJu0YwfOqoA06xwzlRXMs3lXF4/gU3C8zcs94ylN/0Ctw8ZXl4BdLlL
        Ty7yBCf+P9xbbRfQRJ0SIGoAXPihLohNJzU+q0dKgA==
X-Google-Smtp-Source: AGHT+IFXoShZWtAC09kblIB9CR6NXKS8BIIYe7rrQZ1pSVQac2k5uqEs3kYOKhvarJMY7lHrKTTkrw==
X-Received: by 2002:a05:6358:709:b0:13d:c0:1b0d with SMTP id e9-20020a056358070900b0013d00c01b0dmr8066967rwj.2.1694941659537;
        Sun, 17 Sep 2023 02:07:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u17-20020aa78491000000b0068fb996503esm5389488pfn.100.2023.09.17.02.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 02:07:38 -0700 (PDT)
Message-ID: <6506c1da.a70a0220.9dfc3.35c6@mx.google.com>
Date:   Sun, 17 Sep 2023 02:07:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.52-814-g5e5c3289d389
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.52-814-g5e5c3289d389)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed, 1 warning (v6.=
1.52-814-g5e5c3289d389)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.52-814-g5e5c3289d389/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.52-814-g5e5c3289d389
Git Commit: 5e5c3289d3893fe13c2783ba8ecb76038405e19a
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
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
tinyconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section=
 mismatches

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
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
0 warnings, 0 section mismatches

---
For more info write to <info@kernelci.org>
