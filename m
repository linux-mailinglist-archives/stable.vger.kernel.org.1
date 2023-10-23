Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233797D363D
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 14:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbjJWMSY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 08:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjJWMSX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 08:18:23 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FB3FF
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 05:18:21 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-27cfb84432aso1957276a91.2
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 05:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698063500; x=1698668300; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=neTSj6h8vaOqkzcHN4Ln8/ZX7RcKKy57lXEmzAWBn78=;
        b=vYRTJgN/B4pb8lmTL81AuTMA3QC3OaDvAKdRDPyK6AHuojLABgK0bQqR0rjyepurvd
         vbrcgUrRqFWAg7u2A07cE/2YpSwESeNsSW6VoJZSGqgBn5fgtOdQIBngIvQMMkRMbHO2
         on7aDLgTNDEhEYiepIw6FionXQX5ActMhvFmdI4MVM/1xO1Y7AEhJ/HKgsGPpnpQgMSF
         TigkeF16o8HofuhPj7+xLVpbVrL6+iAR2e0K8noNw1f1JzXPl8m+dvqF4pUSZtXbgGZT
         j9P/jAvsr3galBbFFPU4iGT8fQsLjcBn4U6DSWx248gZrb4GEtl6YWtv1GrMtYTQ+ej8
         Ea3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698063500; x=1698668300;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=neTSj6h8vaOqkzcHN4Ln8/ZX7RcKKy57lXEmzAWBn78=;
        b=mj4JY68l5lLxEO69CqUGz3WHhfdju4AfiqVmWIdy6U9X7WmB4CatpuCyRzw2Ad+lmP
         lq3SaSxbw/htOfPj+cxeLv8oEn+Pf+TrnntSJjjplXpXVQlPmEac+6sB2HiI+pcbunbh
         IDJB8OzbXwTC13I38Mol/i8JVKo4hek5pJrMZucstDvZc4g1xfYJDxKpW5vCaQVV+B0x
         QW/hiaYvk2c/2Vip7/1GgO7nDIrejL1i7uqM1GvHpGK9Vb64Hqdqn0Czo6kGhnKxrRKS
         LGldYmoO+hSHy/FcZQjZn+yyc9+2UNULsMfMz6X/48FM6NQs0b1QJJH6y8Wpcm+E9enV
         TLkw==
X-Gm-Message-State: AOJu0YzwGNZylhe/FB5GxLBpa0ZCNloio0zpTQ612VHlvFg5zdeHxaEn
        NNaMxgkgQXUuGAHwXe54LaIj7VN1y5zYOyYvTBuCXQ==
X-Google-Smtp-Source: AGHT+IGtFsrNX9+bmHu7betQlAbRyepje6jHACg7vQpqUnGq6Q9zJy3Fms8mINZV30Ss0KpJ0llpJw==
X-Received: by 2002:a17:90a:b903:b0:27d:5504:4cc8 with SMTP id p3-20020a17090ab90300b0027d55044cc8mr6774421pjr.9.1698063500198;
        Mon, 23 Oct 2023 05:18:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l5-20020a170902d34500b001c72d694ea5sm5819876plk.303.2023.10.23.05.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 05:18:19 -0700 (PDT)
Message-ID: <6536648b.170a0220.bd20.0851@mx.google.com>
Date:   Mon, 23 Oct 2023 05:18:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.58-328-gfa9447b759f6
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-6.1.y build: 19 builds: 0 failed, 19 passed,
 1 warning (v6.1.58-328-gfa9447b759f6)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.1.y build: 19 builds: 0 failed, 19 passed, 1 warning (v6.=
1.58-328-gfa9447b759f6)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.58-328-gfa9447b759f6/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.58-328-gfa9447b759f6
Git Commit: fa9447b759f65cb3a25b4092562576311f245dff
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
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
0 warnings, 0 section mismatches

---
For more info write to <info@kernelci.org>
