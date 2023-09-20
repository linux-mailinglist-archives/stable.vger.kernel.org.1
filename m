Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F287A81EA
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbjITMu5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbjITMuz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:50:55 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238EFCA
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:50:44 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c47309a8ccso5902375ad.1
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695214243; x=1695819043; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LR9555eNCirUAEUEI9CFHD8HQs0NwDo0Dr0xZI/jkZg=;
        b=ETaeF9lHE0DunSANxsnd4leGLBabGrbcPsB+HAh46c1/Ce11XBbz6KJI2Hx5Glrj4s
         1l2XAS7LjleKNQZGs97kNfrk1SRQ+SYVZcOvH08SCZFRCYcUIps5xmQ8WZZnhluiP7dP
         V/Xs6VGd6kfbkmkFWvxgVeuJ3Y4ztyCxOq9ulaGyJZIndkSiwnLTi78rVEsPRLVHdQyp
         v2qakV0yOF66Stqu5/No7glab1O1QhR7SL34HugNTIMJoS/r9KcmTNT8eRC2q2q0VlWZ
         kILDdwKU8N52hUEmoXHY4gN4I6HJpjZ1N0D/5nCmcxaBEFRf/uJBp8l2pwIPbpv18UOU
         AHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695214243; x=1695819043;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LR9555eNCirUAEUEI9CFHD8HQs0NwDo0Dr0xZI/jkZg=;
        b=Kv/Ziao86JA3pmOATegAMirA//pTf8nl/r2HuAuQeI2axvpT5OmJ+dM+rupDMjdlsj
         WkbJFD9/9524EBJTxSD/L5YQ6bDSghEIBmxHaHQJs+ZXeqiFpDPKHwFWkrNKnUor8l6k
         Jor2BI61E1JUHDlqwUI4Y7nFWhCSYwid6SZ4izS0F2RpXan+k+w2L73O4mryXYB/f3Li
         uI10byGKIn07wMUGfw0hrLDuSPxM1t4WAM66tAx71dCheYAJ8cV/ze8rLC4pw4oUGbZr
         jDV5x4lVWbus8O+71xikWh/GB/JbfQSwmb5QFkvgteZWGlkavquhFzc9SRIEg1O2wl3D
         IXCw==
X-Gm-Message-State: AOJu0YyUEpeNV2nuHWG7xPDl1U8dd3FtYnYrkSeFbA3T0lQWuXOBiwPp
        9lcYmlAXPsBNpJliFYT10wgIUpjAWH/VLeNK2cwIWQ==
X-Google-Smtp-Source: AGHT+IHlORFVvnV9jkl+fIPYzFfyjbay4B8Ww23TYSkJPd4JAgezJhYYZP1KWKLlwxUEnyvtYJ4jxQ==
X-Received: by 2002:a17:902:654e:b0:1bc:4f04:17f4 with SMTP id d14-20020a170902654e00b001bc4f0417f4mr6065351pln.30.1695214243008;
        Wed, 20 Sep 2023 05:50:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id r3-20020a638f43000000b005657495b03bsm9578369pgn.38.2023.09.20.05.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 05:50:42 -0700 (PDT)
Message-ID: <650aeaa2.630a0220.5df89.f429@mx.google.com>
Date:   Wed, 20 Sep 2023 05:50:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.19.294-274-gb67b483f6a45
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-4.19.y build: 19 builds: 4 failed, 15 passed, 2 errors,
 20 warnings (v4.19.294-274-gb67b483f6a45)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-4.19.y build: 19 builds: 4 failed, 15 passed, 2 errors, 20 =
warnings (v4.19.294-274-gb67b483f6a45)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.294-274-gb67b483f6a45/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.294-274-gb67b483f6a45
Git Commit: b67b483f6a4512bad5b589f3bf49503cfe941cf9
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

arm:
    imx_v6_v7_defconfig: (gcc-10) FAIL

riscv:
    allnoconfig: (gcc-10) FAIL
    defconfig: (gcc-10) FAIL
    tinyconfig: (gcc-10) FAIL

Errors and Warnings Detected:

arc:

arm64:
    defconfig (gcc-10): 3 warnings
    defconfig+arm64-chromebook (gcc-10): 3 warnings

arm:
    imx_v6_v7_defconfig (gcc-10): 2 errors

i386:
    allnoconfig (gcc-10): 2 warnings
    i386_defconfig (gcc-10): 2 warnings
    tinyconfig (gcc-10): 2 warnings

mips:

riscv:

x86_64:
    allnoconfig (gcc-10): 2 warnings
    tinyconfig (gcc-10): 2 warnings
    x86_64_defconfig (gcc-10): 2 warnings
    x86_64_defconfig+x86-chromebook (gcc-10): 2 warnings

Errors summary:

    1    drivers/pci/controller/dwc/pci-imx6.c:645:3: error: =E2=80=98const=
 struct dw_pcie_host_ops=E2=80=99 has no member named =E2=80=98host_deinit=
=E2=80=99; did you mean =E2=80=98host_init=E2=80=99?
    1    drivers/pci/controller/dwc/pci-imx6.c:645:17: error: =E2=80=98imx6=
_pcie_host_exit=E2=80=99 undeclared here (not in a function); did you mean =
=E2=80=98imx6_pcie_host_init=E2=80=99?

Warnings summary:

    7    ld: warning: creating DT_TEXTREL in a PIE
    6    aarch64-linux-gnu-ld: warning: -z norelro ignored
    4    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'
    3    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in rea=
d-only section `.head.text'

Section mismatches summary:

    3    WARNING: modpost: Found 1 section mismatch(es).

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
allnoconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section=
 mismatches

---------------------------------------------------------------------------=
-----
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section =
mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 sectio=
n mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 section m=
ismatches

Warnings:
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warn=
ings, 0 section mismatches

Warnings:
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 secti=
on mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 FAIL, 2 errors, 0 warnings, 0 s=
ection mismatches

Errors:
    drivers/pci/controller/dwc/pci-imx6.c:645:3: error: =E2=80=98const stru=
ct dw_pcie_host_ops=E2=80=99 has no member named =E2=80=98host_deinit=E2=80=
=99; did you mean =E2=80=98host_init=E2=80=99?
    drivers/pci/controller/dwc/pci-imx6.c:645:17: error: =E2=80=98imx6_pcie=
_host_exit=E2=80=99 undeclared here (not in a function); did you mean =E2=
=80=98imx6_pcie_host_init=E2=80=99?

---------------------------------------------------------------------------=
-----
multi_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
tinyconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section =
mismatches

---------------------------------------------------------------------------=
-----
tinyconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section m=
ismatches

Warnings:
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section=
 mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
vexpress_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 s=
ection mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
2 warnings, 0 section mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---
For more info write to <info@kernelci.org>
