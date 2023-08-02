Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC3276C815
	for <lists+stable@lfdr.de>; Wed,  2 Aug 2023 10:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbjHBILd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 2 Aug 2023 04:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjHBILb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 2 Aug 2023 04:11:31 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE8E1FC6
        for <stable@vger.kernel.org>; Wed,  2 Aug 2023 01:11:29 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bb8a89b975so39258695ad.1
        for <stable@vger.kernel.org>; Wed, 02 Aug 2023 01:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690963888; x=1691568688;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f7gHJ1DGq2DroPTnTOQBrr6agFe4QaaluUTK3UUCB/8=;
        b=tAbvU6pqdPlu3flRF9wzPMNywKDfzI1wr9XgtIM+FUF0IILMC3hwxGrkJh5AIPvSJq
         iy7OPJU7xo1nov0NPUWxSdcdK2JaidbC6lDNEczNbUQCK4x9s7g7Qo/GqqIE0VWeLtDB
         pJfyc1S0B+oHu5KR3kUK9TrRxEt6kugTLkk+OSJ2jFIkAbKXaQqE50jdJeGEwhso/Ss0
         TruH1FFYPWMzu3cRqDDnsCixhziBNK3eb/pExVYd3f71NKm+L0Ye75jfAEkpbufO81dp
         52IGJzlLnWfjZa1+q7qncGRVy1G066nuOBMDwyBa+wQgyQ40qhO4EfDa1/dx+v7rqISO
         Fs0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690963888; x=1691568688;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f7gHJ1DGq2DroPTnTOQBrr6agFe4QaaluUTK3UUCB/8=;
        b=TzBpTwerD0r42GLIwQZpWbKvq8AxWBdYnJjDK6Zo+NGheqebLxe0AXuw1rxgTK/3iC
         GOnbbq6gcKb+dkh+BjqJodLK0rFQjdbssJLPsL1xZfygfCwZMHWF3KmMqmwsaoRoCvRW
         x0HVlun1pifbO0ono3iEzEJiX0Y2B0Qv9/eu9IqJ0TJQ+js+laRjGGrSKdBY4EdIn3Bw
         9E2uyG5G9aNk1HyXrXLhWFlbs6gEc42zVX9Za+c1+EtBbdApE9++XpbDWpFqxndzEJxe
         0TnUAmrGxQ3wTg0FPyIytejkTnq6lm19j0fJheDa+tap0qBD//oFobIWbUDEGgHnTiP0
         wO2w==
X-Gm-Message-State: ABy/qLbf489WuAQTxbX0UR31/90thzBCzUF/ok3/TvP9YfdNOX9bHVCe
        bQaGbgV9mTDWAvy68yXMkx68hxwffvXBLVdrzMCJRg==
X-Google-Smtp-Source: APBJJlF7B5ZArc5plqcNuSM25pSn7ZMPI5LfT82zapZt2alF49DUzmccxQObe7L1FRFe9nA2m46MKg==
X-Received: by 2002:a17:902:8207:b0:1b8:b464:fa1d with SMTP id x7-20020a170902820700b001b8b464fa1dmr12179899pln.69.1690963888551;
        Wed, 02 Aug 2023 01:11:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ee8900b001bbd8cf6b57sm11744836pld.230.2023.08.02.01.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 01:11:27 -0700 (PDT)
Message-ID: <64ca0faf.170a0220.867b8.72cc@mx.google.com>
Date:   Wed, 02 Aug 2023 01:11:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1.42-226-gbdcf4e82a088
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-6.1.y
Subject: stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.42-226-gbdcf4e82a088)
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

stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed, 1 warning (v6.=
1.42-226-gbdcf4e82a088)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.42-226-gbdcf4e82a088/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.42-226-gbdcf4e82a088
Git Commit: bdcf4e82a088a0bc7c5557d08d0c86c67bbda149
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
