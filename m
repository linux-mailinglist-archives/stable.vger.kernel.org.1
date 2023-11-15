Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8E57ED70A
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 23:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbjKOWIh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 17:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbjKOWIg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 17:08:36 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754E0E6
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 14:08:33 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6b709048f32so130183b3a.0
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 14:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700086112; x=1700690912; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5hwrYZC9S3SupqolE/dbs0FRUVZebOtv5uIfZj9TZa8=;
        b=A86qpgZgqHOEBlTEHKsjIuwb9mmcTBX+Nfm1ELvtBnGwFVOHODTj/BemTDmxy3UUUJ
         WADnc0jreA3eruBdXwEs9uJykDCPa4Du/yw4m0Fb5dVyuhZ34vf1QOucKXFePPQAhVl7
         9YXxcCXPr2PUiHipSRvaadvWl6KP5GdSNh6c8C4tH9drb6wxqRf2h0Bl8g8jUQJF3Mft
         a88AaZ03K0Y9nUsRFl0zydNh/SIYjs0VtpUCsESelwM0lWGC8yMGUHU7S+kv7TWjJi7F
         NqqJcJm75+Zpn7SNTREJs8ozlCUT7gZI/HTvuJ6gYKT/Zk8bd4VYMQY46yVEK+JZ0si8
         UBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700086112; x=1700690912;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5hwrYZC9S3SupqolE/dbs0FRUVZebOtv5uIfZj9TZa8=;
        b=IIkIhrwSbB/xR7BSdCjHgzWOpLRzuV1Lte4TxdVDYdQqeH1x29By/eVUYcXaJCdJJJ
         cEdDRsSRJV0DNmmMnMDlaoiC9FmIaBus6xOeObQUqO4y/bUoN9xeTCRS93sdgjyCocPn
         aFjtEfh17fYMVDgMK8E1VY3Hao313D5nlYktjgTf5aFK9T0jWGlqw5N+TwSisquv/DxA
         LS5LePaNETP8ayE3w1tic4glgBayHTN/tawt66HKImG3vJFNEq7B6dgaMZPf1dBIqM53
         7dYYwHTsUZPUEGtM80Gb49l5bP/p4sf9DDGrXKzxxET2NYZ0bSbnjP39lCZPwS8FEHEw
         yGtg==
X-Gm-Message-State: AOJu0Yzol9BHT0xzzcU2T6FRzwZofvdPtfT2ZpHMVWTSgvD4DUK9Vb0F
        exRi/SYChiXAHCGLcscM0MuwROCxnpkvJdTATz9+Tg==
X-Google-Smtp-Source: AGHT+IFjzVDbuUistDIkKruLPiSut9+3WVrqp/ygxiuCTVmhWToHwh7+S20TLvA38Ab0vBxCOEQG3A==
X-Received: by 2002:a05:6a00:1790:b0:6bd:f224:c79e with SMTP id s16-20020a056a00179000b006bdf224c79emr13728425pfg.11.1700086112425;
        Wed, 15 Nov 2023 14:08:32 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id it2-20020a056a00458200b006c4d371ef7csm3349652pfb.14.2023.11.15.14.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 14:08:31 -0800 (PST)
Message-ID: <6555415f.050a0220.ffd16.b1b0@mx.google.com>
Date:   Wed, 15 Nov 2023 14:08:31 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.138-245-g0d55b31d7e1d
Subject: stable-rc/linux-5.15.y build: 20 builds: 2 failed, 18 passed,
 3 warnings (v5.15.138-245-g0d55b31d7e1d)
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

stable-rc/linux-5.15.y build: 20 builds: 2 failed, 18 passed, 3 warnings (v=
5.15.138-245-g0d55b31d7e1d)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.15.=
y/kernel/v5.15.138-245-g0d55b31d7e1d/

Tree: stable-rc
Branch: linux-5.15.y
Git Describe: v5.15.138-245-g0d55b31d7e1d
Git Commit: 0d55b31d7e1db6eee3c65c0e64d373dd4269578c
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
    x86_64_defconfig (gcc-10): 1 warning
    x86_64_defconfig+x86-board (gcc-10): 1 warning


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
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 FAIL, 0 errors, 1 war=
ning, 0 section mismatches

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction

---
For more info write to <info@kernelci.org>
