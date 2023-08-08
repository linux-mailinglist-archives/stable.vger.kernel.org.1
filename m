Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAA6774BBB
	for <lists+stable@lfdr.de>; Tue,  8 Aug 2023 22:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbjHHUys (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 8 Aug 2023 16:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235347AbjHHUyc (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 Aug 2023 16:54:32 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B9C92EC
        for <stable@vger.kernel.org>; Tue,  8 Aug 2023 13:42:59 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-686ba97e4feso5811390b3a.0
        for <stable@vger.kernel.org>; Tue, 08 Aug 2023 13:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691527379; x=1692132179;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PYcdqj+GxxxFrGDiB1WTgkAZVJQqEBVIAgq3d5FlioY=;
        b=kIU9MN7s1xUmsg+OL2oFqQO8wqHosoo8aBH7W7+BlwbOqbIpKI/P3DH+DuxhVrXYIa
         TeleoSkCm0mvOynY40B2nHv4wmGfokgTFMBqi4NLMG96a8BF5oMJeNPXFMn8vGO9ICSh
         k8EJzz1339NwQpYetAr/6hFbDuX5KTbl6jQZY4qtu6U5K6YY1pdkUeSiDU7uNMvHVOsb
         lAGNyVlrrmWufmhrHQrl/yvglRv3VT3RucgR+IUVWIrfKKAsgGynnsPk8QdAefsn51BL
         qIJJvqTkW5gv/FLrQMAE1BH48l3OleI9q0LilYSGh+0ryjVWfL6cGXQ8VpnzNnReZzGh
         9hVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691527379; x=1692132179;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYcdqj+GxxxFrGDiB1WTgkAZVJQqEBVIAgq3d5FlioY=;
        b=M1iIpkQWoYdnctTbuYktrTpCqyjgqN9iS7Rop9kOlv9hLc+hCgj3PVrwl1gJ1APOuP
         Vmeu9iGMc+HfUDy8oWcXwWSblPWWDlKieVceYI3WFnavxEbAAAypKHhG6zEamxz+9aKH
         KpATYGHNtG6GGTl0oeuL2gFf3jtBLmv0iQqpn3GRBN2AhTOfwzvZfEMWnHnLZQfkB8af
         sFyvW6e7UV5yMg3wGMHRPa1LXBe4qSG8PhcMchbmdnJW3iYe6QdWKaXCV4Qhe+7m1AFo
         5jBPe/Vk33YAnSJH/cgSfN7G5rBmRCuQFkditTLLnQzjhXM5mILwFDvZ3NKgFXtbtEih
         Zbmw==
X-Gm-Message-State: AOJu0YzbOtygNJe7PnHg78EKx5nYC7SesEgE7PjSV40YEt9yYkrFwl02
        3q9eM1vyuaAS+X6Iz6UNPEGSRu6UvSUDP8LoAPfS1A==
X-Google-Smtp-Source: AGHT+IGmuN+I4pECCJuDAPjNBGSxx9z2BMOrabzoDCPkZTKlfybBcNu4k/vSMEUl/1LwCQz7OBuTVA==
X-Received: by 2002:a17:90b:118:b0:268:300b:ee81 with SMTP id p24-20020a17090b011800b00268300bee81mr593296pjz.15.1691527378896;
        Tue, 08 Aug 2023 13:42:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m2-20020a17090a920200b002612150d958sm10897023pjo.16.2023.08.08.13.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 13:42:58 -0700 (PDT)
Message-ID: <64d2a8d2.170a0220.eddd.4b46@mx.google.com>
Date:   Tue, 08 Aug 2023 13:42:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1.44
X-Kernelci-Tree: stable
X-Kernelci-Branch: linux-6.1.y
Subject: stable/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 3 warnings (v6.1.44)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-6.1.y build: 20 builds: 0 failed, 20 passed, 3 warnings (v6.1.=
44)

Full Build Summary: https://kernelci.org/build/stable/branch/linux-6.1.y/ke=
rnel/v6.1.44/

Tree: stable
Branch: linux-6.1.y
Git Describe: v6.1.44
Git Commit: 0a4a7855302d56a1d75cec3aa9a6914a3af9c6af
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
    x86_64_defconfig (gcc-10): 1 warning
    x86_64_defconfig+x86-chromebook (gcc-10): 1 warning


Warnings summary:

    2    arch/x86/lib/retpoline.o: warning: objtool: .altinstr_replacement:=
 unexpected end of section
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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    arch/x86/lib/retpoline.o: warning: objtool: .altinstr_replacement: unex=
pected end of section

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
1 warning, 0 section mismatches

Warnings:
    arch/x86/lib/retpoline.o: warning: objtool: .altinstr_replacement: unex=
pected end of section

---
For more info write to <info@kernelci.org>
