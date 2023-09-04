Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D886479145C
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 11:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347691AbjIDJIk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 05:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349569AbjIDJIj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 05:08:39 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC57184
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 02:08:36 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68c3b9f85b7so477355b3a.2
        for <stable@vger.kernel.org>; Mon, 04 Sep 2023 02:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693818515; x=1694423315; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RebWqc6BiiLtvxirmVFiEkONsp2RCWrdRxlO8sr8YVA=;
        b=kx3fEq1qypiPH/g9nzbhKzNcx3WG0YHEInbduOCY5HvroXfZ6YsbyCT6tegtcmc2UQ
         II/SFJ/ZyeuRTjtoch4Ngu4MslA23XyjgCi/J51tbQobukzW9nIooPmf6+zbEJP6LPfc
         vSjcvFqNpiYe/5kuMMIdOc5nCHeB/N03j0TjtJKHXbIkb/fDh6nZBHD8z6XPHaHqbTE9
         YY0O5EirjSwZ5F1vEtgCFdpGU9XBPmKCj7q+2xdtlhvimxg9WRGkVAa6OwzaEBJHtXGl
         5U0e6kNlWDVwdqDUGcC1bqWHw+/FkoGlng5p6KnVMW00VetSQRZTV1BF+HKHRgTsAX8o
         NY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693818515; x=1694423315;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RebWqc6BiiLtvxirmVFiEkONsp2RCWrdRxlO8sr8YVA=;
        b=YZHAMfikOt9pn4h5dDtrw9IT+cFEDjgx4ZzqQksKH6aRIBkzV039kRcwIMziwrauEo
         64dEMHkYf7JbpQAG1+ewa/UCqjTBv9Xr0R+XD2eNaT3rT38HQrXNzk9X5hTRqZv/adPi
         U5lo3Ui6ZPajy+oNbozKbZ90lAwZkq00nsTRmbbb4C/cme2g0eNTLp7BqAgfrYMHkJ5U
         4ZBk0DcmlbQL2KqXUf/lVknxLqt8NLQoLLZ+sao8qn51FQesqUZVMc0HiErCb10Gnu/2
         zY4/aq6QbBXJRD9n39BEGGJe0P0wW6Beji65srftJ24ZrvmGINKJgXV1qqm8oKBnCbBI
         HuPg==
X-Gm-Message-State: AOJu0YwmeR964ZUyh1j41+81T7fll3wknkxd5WJSsAbwYfwejlrdVMEj
        gCo2cNVnSWmf1hfZJLyVuJYONgV7dw++g0Ct2lM=
X-Google-Smtp-Source: AGHT+IGph0nxeFdIJJMDxU1cKVCkXMBC1eyzBn+rRdSLYcygl51Bc8s0E9qRUPIy8IYtdYrAmUnLCg==
X-Received: by 2002:a05:6a20:974f:b0:14c:f4e1:d9e9 with SMTP id hs15-20020a056a20974f00b0014cf4e1d9e9mr7372516pzc.45.1693818515408;
        Mon, 04 Sep 2023 02:08:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n16-20020a170902e55000b001c0af36dd64sm7173326plf.162.2023.09.04.02.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 02:08:34 -0700 (PDT)
Message-ID: <64f59e92.170a0220.be6a4.e461@mx.google.com>
Date:   Mon, 04 Sep 2023 02:08:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.15.130-27-g8b47c0181c8e
Subject: stable-rc/linux-5.15.y build: 19 builds: 0 failed, 19 passed,
 3 warnings (v5.15.130-27-g8b47c0181c8e)
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

stable-rc/linux-5.15.y build: 19 builds: 0 failed, 19 passed, 3 warnings (v=
5.15.130-27-g8b47c0181c8e)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.15.=
y/kernel/v5.15.130-27-g8b47c0181c8e/

Tree: stable-rc
Branch: linux-5.15.y
Git Describe: v5.15.130-27-g8b47c0181c8e
Git Commit: 8b47c0181c8e7dac2978a87dcad976913f34e282
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
    x86_64_defconfig (gcc-10): 1 warning
    x86_64_defconfig+x86-chromebook (gcc-10): 1 warning


Warnings summary:

    2    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unr=
eachable instruction
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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
1 warning, 0 section mismatches

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction

---
For more info write to <info@kernelci.org>
