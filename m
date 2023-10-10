Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716D57C42A9
	for <lists+stable@lfdr.de>; Tue, 10 Oct 2023 23:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344087AbjJJVfX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 10 Oct 2023 17:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343936AbjJJVfX (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Oct 2023 17:35:23 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A357194
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 14:35:21 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5827f6d60aaso3927503a12.3
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 14:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696973720; x=1697578520; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8Zm9a1JeicOT6vQ9uNyFBzpHEK+/MDWFCoUnU+QzbqY=;
        b=PMgFIAFM2/Te9E6jRXHytnHV4pxUAqzqYRIuHpUlGF+fpxxcxCrayIQTyA3SEToziV
         G5Nv8Ey0ovLA3l41JmoRg5VKq3UBA3mWQD3gChUrdl7g+QRIER+hB+jW5QN0LqcbsOtK
         xkjL9MRAOkesyG9Sh3Hsxr9zs+sj+BsPv0fqxKS+mSAUJ5nWJUaEupALW26TlafX8dcR
         pEfs3kQrTUqfYcGoz0nwCluS26T+cSLZktUjSEkBS2UwikyYRj8i/qtsRvqqyXdtgdIS
         yxz1G3v/WBVPxYXQ3nv0+s3s0o3IO+D3hOOZPN1dljOH/cANJLXozh1V0TVRuOag2b+c
         /GHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696973720; x=1697578520;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Zm9a1JeicOT6vQ9uNyFBzpHEK+/MDWFCoUnU+QzbqY=;
        b=XYEursXKfMh1NGNsrf2HTXArPPrVNpXjueQoFR9UeqCrjy4LZ+hu/XcvlXVl2ZiiP4
         r8xAsGTG0PAzG0h+nQ+WeQvQGqeZrW3RwqMDWS6rvV+W+5LWTuXdaBXTdPYF/2DLeeFS
         qBDo0dFfDnDWeSPaO6XJ7/P42E46wXZuX97WO8EpnhHXDZClh/4ebldqcTwo5UnJsN7/
         Oyy0jg9qhjA91RZ3A93UPS94OhsoRzJTrk4TjV5yvqAJekifJvq1G++x/Hr4qFKPcKvq
         eiZmOL1UJlHf34FPYzmjrkaWmiTlhuZASWYwYcsHlSfa6TMZ9Ir/LAejvXTZB2SWh2Bt
         MNtA==
X-Gm-Message-State: AOJu0YykyfA14AhNfPY0jNBWlYxLP7fXwzodYb6P/UES2GYhJw0F2MDX
        THi7PNSjQ/Gf9hh79DT7EHDh+LpM7lCHt56+BGxSIQ==
X-Google-Smtp-Source: AGHT+IHHOSErTJMbFENkWg8vkmOBfZdgxp3OlB03SbOveN6OzbJI2uHIf1kUM3DVqX6QcazjDWkWfA==
X-Received: by 2002:a05:6a20:5485:b0:161:25e5:8de9 with SMTP id i5-20020a056a20548500b0016125e58de9mr20679591pzk.48.1696973720427;
        Tue, 10 Oct 2023 14:35:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jj22-20020a170903049600b001bb97e51ab4sm12223527plb.98.2023.10.10.14.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 14:35:19 -0700 (PDT)
Message-ID: <6525c397.170a0220.e993.14de@mx.google.com>
Date:   Tue, 10 Oct 2023 14:35:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.57
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable
Subject: stable/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.57)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-6.1.y build: 20 builds: 0 failed, 20 passed, 1 warning (v6.1.5=
7)

Full Build Summary: https://kernelci.org/build/stable/branch/linux-6.1.y/ke=
rnel/v6.1.57/

Tree: stable
Branch: linux-6.1.y
Git Describe: v6.1.57
Git Commit: 082280fe94a09462c727fb6e7b0c982efb36dede
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
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches

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
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
0 warnings, 0 section mismatches

---
For more info write to <info@kernelci.org>
