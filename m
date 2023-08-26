Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540D4789871
	for <lists+stable@lfdr.de>; Sat, 26 Aug 2023 19:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjHZRga (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 26 Aug 2023 13:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjHZRg3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 26 Aug 2023 13:36:29 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A70AB
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 10:36:27 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c06f6f98c0so15754395ad.3
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 10:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693071386; x=1693676186;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5OdsCNJbFjlGQVaBNH2ygEqLeU/OeanLmFkFFEe+Acg=;
        b=NEz9eJZNfDwsEUsOkFqFQ7gFnjZknblFIdDFYPs/7NLVZMkwSKp9A41035LKIj2zkb
         0VYOOMeWcsh2qku5n+ZNZUOXO5J3lercd1X6Y6hMh6tZnk882zb7mvp0UOLnux8MtlkD
         4olfT/bZnjKtOj6rCebzSxV8zA+z3U3gEjH6Oh6Gfzk375XDTpvFQCXGsHt4Fbdc3gc1
         E+kAObLDMW6RX7K6I9ezzBbWfGKIT/hJjwKhk+9eJeB6hapG3WJww47rhC9c1o0NOLyD
         CDnauq34Le2hqevmEcRdbFRGPs9Qrkz/SEf3y3Xbs7kGbB7gPfGzpX5yYnAcns8GV2JH
         cndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693071386; x=1693676186;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5OdsCNJbFjlGQVaBNH2ygEqLeU/OeanLmFkFFEe+Acg=;
        b=ROSqOyx4EhXZrcxjIz5Oec1Z40yL4b7Ihcg4D5QtKFW76Rtre6mLu8PrxBOe6V7XKx
         KnASi6ERbO3CTHMZYKGi5d/WS+188OR8VFNpCFcIQqevEcdCXpJOVgjh9WK5sIwDmKEd
         K5MaPJtaMNji6DkZxZjn1awoVzMhewLEnn8TgmvvS2aIslJ4Sdi2MGVaNPUbEahYlId8
         AHqRbzSOrnzwIm0T3x1zBRuGUduXkpNdrqt+GCGPlPRiZSckTqs/DPOWJ3+KWR4/qqHb
         BT35qzrAaFvasPe0ULcYKd1WvU6ifZUpoe/4I5833W3AccHuhpYJDv+ULtIYqCDUWMFI
         oycA==
X-Gm-Message-State: AOJu0Yy1RTJ0nRDrTldwawGRDPRCP1QS8dnjgYRSXOsfvsg/wi88w0k6
        19IRTrSgRydk8mOEN1zkYjj3Lah02FtiimZWvlY=
X-Google-Smtp-Source: AGHT+IG/4hkbkt8i0j256a4+b6YVBT2MN3QIQJHc4iwTJ3TJ7Bl3TsSLeZwrz4rzutxdASlVDGOSwA==
X-Received: by 2002:a17:902:e74a:b0:1bd:c931:8c47 with SMTP id p10-20020a170902e74a00b001bdc9318c47mr26335025plf.68.1693071386377;
        Sat, 26 Aug 2023 10:36:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902f54800b001bb515e6b39sm3959095plf.306.2023.08.26.10.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 10:36:25 -0700 (PDT)
Message-ID: <64ea3819.170a0220.413f8.6180@mx.google.com>
Date:   Sat, 26 Aug 2023 10:36:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1.48-5-g1d91878df63ce
Subject: stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.48-5-g1d91878df63ce)
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
1.48-5-g1d91878df63ce)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.48-5-g1d91878df63ce/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.48-5-g1d91878df63ce
Git Commit: 1d91878df63ceab6316c7c84876abc7eec08a2e4
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
