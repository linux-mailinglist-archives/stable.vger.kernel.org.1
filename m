Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CB07DFAE8
	for <lists+stable@lfdr.de>; Thu,  2 Nov 2023 20:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjKBTad (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 2 Nov 2023 15:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKBTac (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 2 Nov 2023 15:30:32 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FB9E7
        for <stable@vger.kernel.org>; Thu,  2 Nov 2023 12:30:26 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6b1e46ca282so1400651b3a.2
        for <stable@vger.kernel.org>; Thu, 02 Nov 2023 12:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698953425; x=1699558225; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A0ZrLT4WYoQFMm8awlr9CRPfTr4CxajSmyfLyh5viYE=;
        b=1kRiK5HLgt8pcjpb9hYtkePvP51olsuWVWWkQeGOQtl5Qg0D/OpMCHz1yraGV0yNHW
         TQcKeL7fjndg3VBU/hXXKpaChOH4+3A+7+/4xlJ9iMzgK7Cqvh6wXTy8aZhKAzpEeyNP
         UkzIJ0nhc+kROLqPkJ3Q/qde/3jYgKJoULOZlC5R04Rof52nwH3fF3DNKHph1ia6G8Ln
         zM+PuHt9btMVp/ukVGunSFDKtZIJN0E6gqLaESFvagKVH6ryr8lLlA+QxyX5NgrA2bNM
         8uQOZej52U5tqzrfFg73b1tKR8tSrngTU6/UPmVENl7YjRt3uuV1nwEKSy6yhiG4WRlX
         K+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698953425; x=1699558225;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A0ZrLT4WYoQFMm8awlr9CRPfTr4CxajSmyfLyh5viYE=;
        b=LVLKJ7bUQhMFEDcVKjEeBe/gVw9UzDXPooFnLvJleQ4jqOZAV8QhbSZUGDORnsIgVh
         OUw/lwi7i61dr9tiDzpukAVLmsUbIXlSpk7LC69HX+phsyhD6JJHreMYBsFUnKfvxBEg
         +4/+e+uNkFvPorZ0r6CwqjZOqylcM3p5kTBfZ/lGt7jEWS1gZx8yjKApnxWNSzYSt+iJ
         u4WZ80QrdO8YojprHSLW64mde5Mf/Yyr9GfoOFS6mHnJAEAtxZ0N3zxz4JFnk2gWIxLR
         Gw9ZCagO49KBx7oLGrTsCScdOkVpIFK8RsXFQZWlauaUFSaBnT9Rd2i3zUsaYxulxqFG
         ONwQ==
X-Gm-Message-State: AOJu0YwMWzTaenkQj1xfWEZj4gIGK/ztUmILLZW7k/Ensjl/9E2NwqC7
        YCfe6QEUIbGd04w+b03hIWI4D9VxeYSFl+vKf+e7xg==
X-Google-Smtp-Source: AGHT+IGxcXDRRZ/KuTybUNE/7JbWb/ifUJlkAYbTd2lrL/OllA0GUTW1WtRdY3N4pls2rMZf6srb2A==
X-Received: by 2002:a05:6a20:144f:b0:13c:ca8b:7e29 with SMTP id a15-20020a056a20144f00b0013cca8b7e29mr24760061pzi.12.1698953425179;
        Thu, 02 Nov 2023 12:30:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b14-20020aa7810e000000b006be17e60708sm108757pfi.204.2023.11.02.12.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 12:30:24 -0700 (PDT)
Message-ID: <6543f8d0.a70a0220.05cf.0784@mx.google.com>
Date:   Thu, 02 Nov 2023 12:30:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15.137-75-g249907aa0ef1
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.15.y build: 20 builds: 0 failed, 20 passed,
 3 warnings (v5.15.137-75-g249907aa0ef1)
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

stable-rc/linux-5.15.y build: 20 builds: 0 failed, 20 passed, 3 warnings (v=
5.15.137-75-g249907aa0ef1)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.15.=
y/kernel/v5.15.137-75-g249907aa0ef1/

Tree: stable-rc
Branch: linux-5.15.y
Git Describe: v5.15.137-75-g249907aa0ef1
Git Commit: 249907aa0ef13c8da243e797eca5a2722737a4fb
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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 1 war=
ning, 0 section mismatches

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction

---
For more info write to <info@kernelci.org>
