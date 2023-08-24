Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF4F7873CC
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 17:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237213AbjHXPP1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 11:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238196AbjHXPPK (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 11:15:10 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1EA199D
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 08:15:08 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bdc19b782aso230815ad.0
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 08:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692890108; x=1693494908;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GbQm5GrS9AHJeptmoTY1xlWaV3Sgc7qH5XFXcMaRxu8=;
        b=HBnSodqDLAC3oJXtWYIyv4/pAE5x5xrMeetcnpjyZhyDdOFk6VkFC/gzPru9KJvPeE
         YbNJp7VeBCcD3AXXo1gS/TT8is0F9D/D4Q5w0P9X+my5iHNNqXvntRwsxTCgdMyKpo2x
         mATdyhsD6cjsUqdfLKqZ/CWHSkTV2PiKv7+hWvbmv9mP1n3Tgmy6ferq5k/XcDwc+Vi8
         ta4WTwb6GCS0uP5L23NZLRQUYQhmYofPNCGsI9pFBe1xVtn1MAk0VWunZJ5lXxjE1TLj
         atjtSsE5rPvXDJgTtCQgkL3ljk7jqTPtQS+U5L2rIwmn3woZJdxNe6zJW3XQnwLv57/J
         yF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692890108; x=1693494908;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GbQm5GrS9AHJeptmoTY1xlWaV3Sgc7qH5XFXcMaRxu8=;
        b=d80Ie2Y2eyIuEsPfdRhUusVxOvcSU5frXZDe4zZgTsyceLjiiU47mHfMl62WPSDS7W
         BNTk6UXhjO+UNcSAlVi+reMpY/o+/6OEDNFM1D3rJhJ79er0QKqXN4UH2qwiW/KuZyLa
         esW8NTcohF/L7+pcuYWVyrMwQw3xmJ31HG3B0lce1TquMegPfSNm7BLf8URN5wLwjIkj
         Fh0CyhmejR0LOLXLI9hOHK7YkFsb5SXjxPt8WSVY5Tv1/vdKQHCcdmc3XMfN0riu6Qu+
         NIweel9rBtS5OYYbBuu/w44E+DFIMqbeUhzSd/m5gVg+nplKTwEumKnNOPxMyFvqkXsc
         mCYg==
X-Gm-Message-State: AOJu0YwrGYcCBHjiF4x4NCnB5bgHw1gy33VoEgwliwd+LGCZ3EvW6qex
        oQCJDaHR/I5PpPmZ8jyLCF2ePN01IkMlcO7qrVQ=
X-Google-Smtp-Source: AGHT+IGa1XCVHrKlFLguvpSauVbWvZBxVQV31Qzw2wFqTtBLNQ1EEewbc93NcJDl4IMe7Lk/pgFuMg==
X-Received: by 2002:a17:902:f68e:b0:1bb:91f2:bb3e with SMTP id l14-20020a170902f68e00b001bb91f2bb3emr15085658plg.49.1692890107969;
        Thu, 24 Aug 2023 08:15:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g8-20020a1709029f8800b001bf52834696sm11004261plq.207.2023.08.24.08.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 08:15:07 -0700 (PDT)
Message-ID: <64e773fb.170a0220.eab39.5dd9@mx.google.com>
Date:   Thu, 24 Aug 2023 08:15:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1.47-16-gc079d0dd788a
Subject: stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.47-16-gc079d0dd788a)
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

stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed, 1 warning (v6.=
1.47-16-gc079d0dd788a)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.47-16-gc079d0dd788a/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.47-16-gc079d0dd788a
Git Commit: c079d0dd788ad4fe887ee6349fe89d23d72f7696
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
