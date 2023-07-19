Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E74E759EED
	for <lists+stable@lfdr.de>; Wed, 19 Jul 2023 21:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjGSTph (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 19 Jul 2023 15:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjGSTpf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 19 Jul 2023 15:45:35 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E943B1FDC
        for <stable@vger.kernel.org>; Wed, 19 Jul 2023 12:45:30 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b8ad356f03so59685ad.1
        for <stable@vger.kernel.org>; Wed, 19 Jul 2023 12:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689795930; x=1692387930;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NavdZw/idDH+3MKxWPkvwChd1STdjAWSOwahB2PVL8g=;
        b=H9JfGYIuvVWkI/k35ucyC5UDO2JyaZHO6+wAZNnrIqrSd8YklOnYIjnK4PfzAwB/V2
         SqipGMag7ROMayKLSD9ruFnMWV3e/HkNlnfE8iLPl6oiJrKFW9RU68/vM4tBnpkml6eT
         ivTQlodxblbaFSO0nT+QrI2FlXXICCAMBvajFdRVjNfco+wJs5r80Ywqw1L4atiOaE2r
         dYhSZ8x4zKP9BWV+Z/NJl40j+w2Ona50wdCCOx8uCjzud+0VgRbEeii7rMObEwFAxWjp
         ft4QLXG9Pic2h3erTnFiE5T5r2UNRX5230OZD0cI4kDqlAy3Tg+fHK9Yl00rxha0jUZP
         +wNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689795930; x=1692387930;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NavdZw/idDH+3MKxWPkvwChd1STdjAWSOwahB2PVL8g=;
        b=Ur6lpEEwEyy1ndoTNv0WYRoMguMWgT+p7uAIPvqgMDPRCkEy3vbvYKxreN3bsHs9ah
         QHeKuzKU80XuRAsclngWKV/s4Jk+8+QH6BgWJ4I381v3jwy/NvLOjf2xT1IQxWsZchIU
         dqim0YHEjLkLTkC949ewtigOJBpteDu27QMgReehObAZAF9LQpD9ZjO/hm0SjeAiYDpF
         Hz3ygQIDZ5tvsmnFmSlBjduaypVWQSAgmkxGd2d7oWaRCrzVk+s7riFgebG83CTDISrJ
         gisv/1THU6YGWHfTkrE7uEgkHvI6c+hgebnJhhJSYblAmuNpPD1VehcKCN1PwyIv63oM
         o4rQ==
X-Gm-Message-State: ABy/qLbhdBu4vKCZL4Z4BllKdvBxuM7rgYkRECYNVX+3RPV+qYRLi1BS
        Te1F9N6ixmwEjv+5Wdv3hNeI7R4OWKFsGdmBAyuO4Q==
X-Google-Smtp-Source: APBJJlHnE6ZxIR+rr0/GGh6bs8fWJ7VnzrZP9+eWL1yrYkBG5Mf9avLhZEKudxm0Uto8ofgh24xSig==
X-Received: by 2002:a17:902:ced0:b0:1b9:c68f:91a5 with SMTP id d16-20020a170902ced000b001b9c68f91a5mr3304063plg.6.1689795929915;
        Wed, 19 Jul 2023 12:45:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d17-20020a170902729100b001b7ebb6a2d4sm4368644pll.163.2023.07.19.12.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 12:45:29 -0700 (PDT)
Message-ID: <64b83d59.170a0220.189fc.a4bd@mx.google.com>
Date:   Wed, 19 Jul 2023 12:45:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Kernel: v5.15.120
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-5.15.y build: 19 builds: 0 failed, 19 passed,
 3 warnings (v5.15.120)
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

stable-rc/linux-5.15.y build: 19 builds: 0 failed, 19 passed, 3 warnings (v=
5.15.120)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.15.=
y/kernel/v5.15.120/

Tree: stable-rc
Branch: linux-5.15.y
Git Describe: v5.15.120
Git Commit: d54cfc420586425d418a53871290cc4a59d33501
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
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
1 warning, 0 section mismatches

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction

---
For more info write to <info@kernelci.org>
