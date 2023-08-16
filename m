Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4663F77ED10
	for <lists+stable@lfdr.de>; Thu, 17 Aug 2023 00:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbjHPW1E (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 16 Aug 2023 18:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346951AbjHPW0n (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 16 Aug 2023 18:26:43 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCBB2136
        for <stable@vger.kernel.org>; Wed, 16 Aug 2023 15:26:40 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bcad794ad4so47585125ad.3
        for <stable@vger.kernel.org>; Wed, 16 Aug 2023 15:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692224799; x=1692829599;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8eI76nMmzvz9KxWsy22illX0zYyu9Ih9SpEgW+h7Rso=;
        b=Bw0aVqVkBDimJIcKbAxf46SJ4+TcRrfz1+FHyIWVrZnDmtksOMbUAKpGu8vxF09fSs
         d0Wk58eZYpIWa3h16sQTlnGqQL7pi7l8NjDJI5YHkyQm5qH2Dfe3vBHB0TojFQOuPt80
         4mbTvpEIEECt6MqRtrL2JzXai9H5dksSQr+KDYVrWE+agNUzZfWns5fUZcWbuFGGN5Tk
         jTIpFrnXT+guIxvpagfCyExw88E5+ZVpa1H6RiSLGQW/2yIdt0oUlTVYaVKL+CUtxMHG
         UcbICI2r3kWmaNNnEj1e11jqEUNZfM5vQ6gLeHfNFBtbwuC4TeU3uuQiCI5hbZOf9Xdc
         D91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692224799; x=1692829599;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8eI76nMmzvz9KxWsy22illX0zYyu9Ih9SpEgW+h7Rso=;
        b=W5I9jtYblsUYasdK/eWI+L6UZhJASE/revDrRL84AP8ezSUIm8/H4LeOBBzMCmjLGK
         FTmHhBCtMXbwGKExApOppVRpUhPmMqMMrYm62aCwBRWgQxQE414DstdO9MFL37Xcmr8y
         9QFA/attMaQ6Tk5YVmGqGVBy9beGca2caCWQAvxsOZfJCtI+79vJYoq81i6IvsqCefbY
         VOsNSKZgiLb4oSzR4t4l5EMeAqUYLKo9FffByg+fEfh++fk2l/47MX/YQM10yGjgkuHl
         bOUCZ6euCbpXwcKSDndhizOq4Dkkr72eOaqSOwOLoZFxAxqRdeLAoiGugwi1Z9pc1zI4
         P2fQ==
X-Gm-Message-State: AOJu0YyB/FI3zhmp9tArhON2q9e8qmdyobBdo5cJ3szXMFtMSxzrrTuE
        B1P9CENyc9NLanFD07Q+HRWb3nrnCJW9M7b3+B8EMw==
X-Google-Smtp-Source: AGHT+IH+mKF4MHYivkvCJWweOOfCHUA+IfAAfUoKLPcfuwWUxcevnIUStHOB8L9oIkkQvLdKFhwExQ==
X-Received: by 2002:a17:90a:e592:b0:268:a61:ba86 with SMTP id g18-20020a17090ae59200b002680a61ba86mr2519427pjz.16.1692224799126;
        Wed, 16 Aug 2023 15:26:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z2-20020a17090a1fc200b0026b46ad94c9sm249330pjz.24.2023.08.16.15.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 15:26:38 -0700 (PDT)
Message-ID: <64dd4d1e.170a0220.37e41.0cd8@mx.google.com>
Date:   Wed, 16 Aug 2023 15:26:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1.46
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-6.1.y
Subject: stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 3 warnings (v6.1.46)
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

stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed, 3 warnings (v6=
.1.46)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.46/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.46
Git Commit: 6c44e13dc284f7f4db17706ca48fd016d6b3d49a
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
