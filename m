Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1832A77EAB0
	for <lists+stable@lfdr.de>; Wed, 16 Aug 2023 22:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243082AbjHPU25 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 16 Aug 2023 16:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346157AbjHPU2i (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 16 Aug 2023 16:28:38 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA92926BB
        for <stable@vger.kernel.org>; Wed, 16 Aug 2023 13:28:36 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68879c7f5easo1212069b3a.1
        for <stable@vger.kernel.org>; Wed, 16 Aug 2023 13:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692217715; x=1692822515;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FI4HO7IqPz1Bj02MIrF3X2QdmI7mwITtJcCi8eLCwYE=;
        b=R725Yf3l0cOFXwzOqQKlBPVh/jMwsOZbQamWz3GLi4qU0jEZdD2QFMSLxbqXeGFwq0
         Dt/8VszStL0jYYVyB06ss+6wCJgff/UtanDJk2W8wL08O4/oWM3qeFIP8mShKmfmi0s8
         aE2NYFYbe35MjF5/0UcRkSjHDemoiW2ugv0nGk3wx3myA0hWQcqVv1dOrT4jB+K1YKas
         kNnTzM3xpFKAEcQMFzHsB+jOGIsKTTpGGSTdoiX5bKvpYWhQZHmyiJujzjiymAPECgN0
         jvipDX48D18sBiN3r3znJ8i1qeyy2+gfS3Aq7kKY/xrhlBri6a+Fyzmo3YB8BkfY5MP/
         yYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692217715; x=1692822515;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FI4HO7IqPz1Bj02MIrF3X2QdmI7mwITtJcCi8eLCwYE=;
        b=cPV6MamhcsUWS3b9vtJbrZuNbwWoTBtFJ6KrTNpJfwgOypNlaOA2VN9NHsnv3FLjb+
         7gUkvhku5nQBioArQCDJGX6Wa3uQn353VhCpp5Io6pMXaJQRKqh+zA/RVoYbkRwkHD5P
         wq/pEI8dC2gVh1ivU+nrH7qlbglCvu3XNRAnZON7gXrtKYoWv8TH/HP2nEt4SrzlGYqx
         LVAUScB+gFl3c25g0KC6Df19oz644g17BkBwR8qWVGaBb/+zNmw7WV5covCjsbSQB2Ne
         5B16Vi3au5GDTNSwhMrYLPJOgN1UOEWczFzuLVJKY8bdXvLTzri1HN98ZuXmJOhAM0WT
         lVjQ==
X-Gm-Message-State: AOJu0YwYC1WuJW15eQ+8DqnTeeOH67IuADrzBa6+DVM7SlpwqcCrh5Ym
        KprYkr6J9WTou9mo8epsFZIYgH3nomYxd3ZBmT1CtQ==
X-Google-Smtp-Source: AGHT+IGBtVvus1/cEYAKS4WQU2qdjhFmvpFkA4aAZm/uKcGDOvVLe+pRThcEOJJtWI0NU7I0aS1wWg==
X-Received: by 2002:a05:6a00:22d0:b0:67b:8602:aa1b with SMTP id f16-20020a056a0022d000b0067b8602aa1bmr2963014pfj.27.1692217715641;
        Wed, 16 Aug 2023 13:28:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g6-20020a63be46000000b00563ea47c948sm11296293pgo.53.2023.08.16.13.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 13:28:35 -0700 (PDT)
Message-ID: <64dd3173.630a0220.eca8d.39b9@mx.google.com>
Date:   Wed, 16 Aug 2023 13:28:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1.46
X-Kernelci-Tree: stable
X-Kernelci-Branch: linux-6.1.y
Subject: stable/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 3 warnings (v6.1.46)
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

stable/linux-6.1.y build: 20 builds: 0 failed, 20 passed, 3 warnings (v6.1.=
46)

Full Build Summary: https://kernelci.org/build/stable/branch/linux-6.1.y/ke=
rnel/v6.1.46/

Tree: stable
Branch: linux-6.1.y
Git Describe: v6.1.46
Git Commit: 6c44e13dc284f7f4db17706ca48fd016d6b3d49a
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
