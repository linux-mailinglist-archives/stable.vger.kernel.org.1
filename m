Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEC67E2B74
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 18:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjKFRsb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 12:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjKFRsa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 12:48:30 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAEFD4D
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 09:48:27 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6b87c1edfd5so3557363b3a.1
        for <stable@vger.kernel.org>; Mon, 06 Nov 2023 09:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699292906; x=1699897706; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jOaruvKHlsq4CI8K95HpA6RmGUpTJTqBoUpkCsYKJD4=;
        b=XZ8G51CtSmPBEbqdl1Y2pc3nk+VDBi2fGNlKsRZcwKqsgMdqNjzVgJJVYXQP0C2gyT
         TfQlQkEdGFlOybaOpr0MMZ1GwEtlBFcWuLVK4u/ia41lkUA9luM7722eUVK0WrehMrSq
         gEuLLj9SPtnppYG3oaAChwBfEdGNQjxTQLzu8rFfjB5uzesT8CufotMz8mXyFz3B61H1
         zcIBDulETJsdMX1O/Uve4Rlgkr7e6zpTiktGm0Q1nKUT8lNiyRH5TjcuONPubUJTPOa+
         BNMAvIYR6SHWq36c/2/ElFfEfeIwyAHx323bXi50r1/VtY9uA4ITahuSqe63fLKFMtQ4
         vN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699292906; x=1699897706;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOaruvKHlsq4CI8K95HpA6RmGUpTJTqBoUpkCsYKJD4=;
        b=ex1NIwCXyhoog1nlNY7QK8GXEw6eUmIamiSZsivIcHxjsH/MBFCEkggrThZRZ3TO6O
         exYc/7Ne1hYwBc6dMPKHoGBbyQKbhEiaow0c5CEOzsJNC5XwVB36AnRykNx2Lgk+jcSm
         /xif+PEdrkdShU+HMA8Gn+sFoaPXB3aEbK6VZDLlvTmqX9DaSQ8+gtKlYR/c4XYQP4MS
         RNzHnYCKg47W15X5+yQNTB41qHlmDJfHPCTDXS9/4HChp916w8sLy5KIrl80iVSwg/jB
         a/CEbBn0rWlIHsZC41BcCuTVu/V7TmcFhDAeFtE7nLhRFtS+UM2TtrNLkt8KYYLRaTXh
         7KDQ==
X-Gm-Message-State: AOJu0YwuslP1M7voPmNcSU87zEGv638eKfzAuZb7ZiqdxSahKcDtMYJh
        RnCAbOUgPuM1PRIc7Ifh9iZTgWE1C24ycqqbDuT05g==
X-Google-Smtp-Source: AGHT+IHF0H/5O/WpFWOj7dKP15ZRTLq9jBioheSb8lOZBb7rCuNO4TbImgFo+0pjJbNT5GoXNVyK3A==
X-Received: by 2002:a05:6a20:ae17:b0:15e:986:d92b with SMTP id dp23-20020a056a20ae1700b0015e0986d92bmr17816589pzb.16.1699292906576;
        Mon, 06 Nov 2023 09:48:26 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m2-20020aa78a02000000b0068fb8e18971sm5855670pfa.130.2023.11.06.09.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 09:48:25 -0800 (PST)
Message-ID: <654926e9.a70a0220.3dfd6.d421@mx.google.com>
Date:   Mon, 06 Nov 2023 09:48:25 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.61-63-gf2e7db5bff466
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.61-63-gf2e7db5bff466)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed, 1 warning (v6.=
1.61-63-gf2e7db5bff466)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.61-63-gf2e7db5bff466/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.61-63-gf2e7db5bff466
Git Commit: f2e7db5bff4666814d68d4f2a8f1818be97f5e70
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
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---
For more info write to <info@kernelci.org>
