Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC917F18BD
	for <lists+stable@lfdr.de>; Mon, 20 Nov 2023 17:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjKTQhO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 20 Nov 2023 11:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjKTQhO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 20 Nov 2023 11:37:14 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5ECBB9
        for <stable@vger.kernel.org>; Mon, 20 Nov 2023 08:37:06 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6b5af4662b7so3896068b3a.3
        for <stable@vger.kernel.org>; Mon, 20 Nov 2023 08:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700498226; x=1701103026; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NaWruv9cJJUdlVvcv8ruke/O8XoH1Sx45EVJwrZT0kI=;
        b=njMKnQvaYcSUd1ILiRbVxx1Epg2jP83OzC3mCn5lsqin3jKtu47epFhwgTrtxqvBc3
         7XdMMOWZtwuOO7ByCxrMz0v8G4pf7jY71pRQFl8nhHNEwWW9tRDUFTb6hrcFBe6fmyTw
         sMY3lebePJF5c/d2p1tJP8Rja4i6S8mkSy05k9Q8y7y+xR/OdTB43jsil3pQ3tuDT1Sg
         5Pdl9t+50ilv3hOwo2acquzmHcP35SWvbwS5C1XMQ71L9SvtKqJu2NR5K7K160FUQA8Q
         jHmLNFSq/Zl7myLCoumeDIruCRChoiidGyIIpnEQCL6q3PlRqBthtoN8p8YC9Oljf3sN
         biow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700498226; x=1701103026;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NaWruv9cJJUdlVvcv8ruke/O8XoH1Sx45EVJwrZT0kI=;
        b=LIpbUFtG102qLIjtDgg9MeFjIWQQo/qP2sJSqBe26dV+0ZHvqjVIKDLltSjmTr2dtV
         fKuNm8A3e9AIIwPRUBYRwehi6XHaIL3bKbsY5HRkjYjchdrwPY9Pvu6QqgszypOn1Z17
         XkEVtCumaIrNE07Io5YGhcVkKoO38AuSyknFSzAdJUgiDS1SeBTgIuygi9cexjlSdD7b
         JxUrRTLe/hj0Mwocz0aqcsQbCPmFh49v+E00I0Ll6WteTQNPKUSrkbiOzaM6OK2aIir1
         jY6EotFSMqu+WF2p4h60J3gskFoavbxQ4KH8emxfk0ESK5m09cQHkc+TR5aoNALRAjtl
         omFQ==
X-Gm-Message-State: AOJu0YwgcjYJj5fn+NmWwUJ8GZIGSbNFyO9w1wQTHFsaavmHRLoBUDSX
        n6/2gyZNEoVi5e9PcgM12vlvapgbi/69FChRfvw=
X-Google-Smtp-Source: AGHT+IHFYMvjk9dI5MJ8zhSTj4hM1AfSG9Z8jTuR2gAnEivkZXnz8KMP+Ivj7pa/jajD3YoxEDCE6A==
X-Received: by 2002:a05:6a20:430d:b0:189:3748:f060 with SMTP id h13-20020a056a20430d00b001893748f060mr6449647pzk.26.1700498225878;
        Mon, 20 Nov 2023 08:37:05 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d13-20020a056a00244d00b00690fe1c928csm6373716pfj.147.2023.11.20.08.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 08:37:05 -0800 (PST)
Message-ID: <655b8b31.050a0220.bfb5e.0006@mx.google.com>
Date:   Mon, 20 Nov 2023 08:37:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.63
Subject: stable-rc/linux-6.1.y build: 20 builds: 2 failed, 18 passed,
 1 warning (v6.1.63)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.1.y build: 20 builds: 2 failed, 18 passed, 1 warning (v6.=
1.63)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.63/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.63
Git Commit: 69e434a1cb2146a70062d89d507b6132fa38bfe1
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

arm64:
    defconfig+arm64-chromebook: (gcc-10) FAIL

x86_64:
    x86_64_defconfig+x86-board: (gcc-10) FAIL

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
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warn=
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
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 FAIL, 0 errors, 0 war=
nings, 0 section mismatches

---
For more info write to <info@kernelci.org>
