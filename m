Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF677B8DAF
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 21:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbjJDTxJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 15:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbjJDTxI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 15:53:08 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F476A6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 12:53:05 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-690d2e13074so154490b3a.1
        for <stable@vger.kernel.org>; Wed, 04 Oct 2023 12:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696449184; x=1697053984; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YUw9TQ9ZqTunwGpwtWoT1BzEPepTuIA2ovm/52D/XJk=;
        b=MAZz1tcfbeNm4Aq9PZLmt+V6LnnsJd6D42tq/qoIzzwYC8sCWO4MvDVR7J1J4wMT1m
         zyzUOKoWHf/7R/HDwNcH5v6pWDDSgTvI/7dCE2ihfOP+AaMJh5HsXuG3q7PcX3eM5ZM5
         fl1A2fXOVXXlswZKxfeFyBQGdZo7YP1qmswSbqMv5WKNBEn2fr0ITGEcYYwWqTWN+RQM
         YZuFE+rfV+xQI/7VbQl4hQYbkqBAOJIxkIpPBqGsxnnGkwOP6i8YQfKWy8C/S6fzwFgP
         ZoSzQtV9uPVuTNum19Ld9fiRbx/EmCwdTx0Dro9O0DMUEpSm0bLBeqxCZ7haBIVni/XR
         3MXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696449184; x=1697053984;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YUw9TQ9ZqTunwGpwtWoT1BzEPepTuIA2ovm/52D/XJk=;
        b=XntLP5IaoAa/rF1VotBKRLBkkaiSeJLoiPGQIgYKb/tje804aOm7tfQQDMmaUW0acM
         gLUz3ymPq5RJ5MY7nLJ6rMQJSE6nhsy/k97mqHhgi/g0H3I8jLwbhlBQeQ9hwWFnVwMG
         cOMk52e1/K1jRjh9/sPk6gOdG2q6NiIpk+6AHUZq5Hu2cyK2hBsfp1HOWfiQ4N1dauBS
         6DVvOZd/QT4ju6PCu5TyXnzvkDXoOcIeEsJ4QTM24+K9ZlEJLicQOK6sunvuTtipnHyI
         S5L/DE9Z/HVRH1js3axjRS3tOksSByaRsdwGqgHMI9N0C+i0sVpy7stm8DjhqeDcldQd
         jw0w==
X-Gm-Message-State: AOJu0YyRAEjlcNy3VWM99rht3AfZzLbHLCdn477GFA7AqKrU81SscVKB
        puA4T+PTf/ACQGlflVJGIiU97aj/K1+gO6a0P/Cw1Q==
X-Google-Smtp-Source: AGHT+IGd+AWVnefPv6g1hvp6ThJhSAbh6ft+QgOu6BerWGd3w6Rif8bLFQSmV95Bl+wlVTjeQO0cVQ==
X-Received: by 2002:a05:6a20:54a4:b0:159:b7ba:74bd with SMTP id i36-20020a056a2054a400b00159b7ba74bdmr3550753pzk.50.1696449184279;
        Wed, 04 Oct 2023 12:53:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ey24-20020a056a0038d800b0068fadc9226dsm3638035pfb.33.2023.10.04.12.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 12:53:03 -0700 (PDT)
Message-ID: <651dc29f.050a0220.9b25c.af2f@mx.google.com>
Date:   Wed, 04 Oct 2023 12:53:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.55-260-g0353a7bfd2b60
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.55-260-g0353a7bfd2b60)
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

stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed, 1 warning (v6.=
1.55-260-g0353a7bfd2b60)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.55-260-g0353a7bfd2b60/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.55-260-g0353a7bfd2b60
Git Commit: 0353a7bfd2b60c5e42c8651eb3fa4cc48159db5f
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
