Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D03F785F79
	for <lists+stable@lfdr.de>; Wed, 23 Aug 2023 20:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbjHWSWe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 23 Aug 2023 14:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238095AbjHWSWc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 23 Aug 2023 14:22:32 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46963CC7
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 11:22:30 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-56c2e840e70so2324140a12.3
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 11:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692814949; x=1693419749;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4WsiNQLt9GR3u3u6uRAKHL8uIjlyqG2YL1OgnmHbPYc=;
        b=SIrSY7WpHTc02wIGLWTXJDExiJORscu4owIXgJ/9dracnor4edn+jnTgURhZm1Qz4C
         AWz8h17c3UjNPvlKBYbi2bu9jwU/vFF9n+ovid4vS4ieo/Uk7oq/zePNDv8+iZOZUQz1
         vFohCvrtmswhvOIMF+J2li2PH5BkX29JhnG37wvuyYvCkRLdB7B1aVJCnF9nXwPTdfmg
         dt7iQ1kR0UI55LDYHSmjLWf/ryu5ZOlKgVeuaUpfuhGVZ5l3qVX3obmQiLLizyzrSvDl
         xM6/q+fU+TdJ3gWouAqpqrqWWfUWzQkZPN5j/WLmvIQkr44y20YbJfPyvoCEXm6FTpwp
         DfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692814949; x=1693419749;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4WsiNQLt9GR3u3u6uRAKHL8uIjlyqG2YL1OgnmHbPYc=;
        b=cdiVlZvo79yu6ChkrPYE/VR2eAb1/0LBmpEHZfdHBLhxmEt2QcsQhTyiJ2yRH4fc7t
         aihRDs4qBUPDUhaS6ELli2eIE6EX0j4f9D27nFtajonVvY6gBX4ANCHHrLEGqnjCQt0Q
         p2V5hHWKInxiLlkxkO5Rs76ZSuyHgKGsWc+dsfdf3tbm+O/mgCHfpF/A4NQZDWMhxWrR
         VoqpnJXw/ibH0atNrZvTxUfYu/z+HWJFc4JLpd5ouMeuRb3LVqz1nCMo3hpa1DSQq9sm
         bdh/JYyISx5pULltCDf2QciWW233zWSMpHzP4e60nxduP+afVzbvilcM5GKUmJ2gIxA4
         917g==
X-Gm-Message-State: AOJu0Yz8sytooYypehvMVuA45we+FZ2LUYrsxCpXfz5z4zpad/0Dfcv4
        +usXTSml1dYaYvxqmJ9l2tDWrT7Ter4Lhxt0wkI=
X-Google-Smtp-Source: AGHT+IG5UXT2OCFYXPiPbeEzFCyuELAy/1j4hQr24SLzd5RCDbsOY0qgeL8IKN+jldcgCvKa6LkqPg==
X-Received: by 2002:a17:90a:3fc6:b0:26d:887:481d with SMTP id u6-20020a17090a3fc600b0026d0887481dmr10905694pjm.35.1692814949221;
        Wed, 23 Aug 2023 11:22:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h5-20020a17090aea8500b002682392506bsm99699pjz.50.2023.08.23.11.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 11:22:28 -0700 (PDT)
Message-ID: <64e64e64.170a0220.10f8.0727@mx.google.com>
Date:   Wed, 23 Aug 2023 11:22:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.10.191
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.10.y
Subject: stable-rc/linux-5.10.y build: 19 builds: 0 failed, 19 passed,
 7 warnings (v5.10.191)
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

stable-rc/linux-5.10.y build: 19 builds: 0 failed, 19 passed, 7 warnings (v=
5.10.191)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.10.=
y/kernel/v5.10.191/

Tree: stable-rc
Branch: linux-5.10.y
Git Describe: v5.10.191
Git Commit: da742ebfa00c3add4a358dd79ec92161c07e1435
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
    rv32_defconfig (gcc-10): 4 warnings

x86_64:
    x86_64_defconfig (gcc-10): 1 warning
    x86_64_defconfig+x86-chromebook (gcc-10): 1 warning


Warnings summary:

    4    arch/x86/lib/retpoline.o: warning: objtool: .altinstr_replacement:=
 unexpected end of section
    4    <stdin>:830:2: warning: #warning syscall fstat64 not implemented [=
-Wcpp]
    4    <stdin>:1127:2: warning: #warning syscall fstatat64 not implemente=
d [-Wcpp]
    2    WARNING: modpost: Symbol info of vmlinux is missing. Unresolved sy=
mbol check will be entirely skipped.

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
    WARNING: modpost: Symbol info of vmlinux is missing. Unresolved symbol =
check will be entirely skipped.

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
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
rv32_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 sect=
ion mismatches

Warnings:
    <stdin>:830:2: warning: #warning syscall fstat64 not implemented [-Wcpp]
    <stdin>:1127:2: warning: #warning syscall fstatat64 not implemented [-W=
cpp]
    <stdin>:830:2: warning: #warning syscall fstat64 not implemented [-Wcpp]
    <stdin>:1127:2: warning: #warning syscall fstatat64 not implemented [-W=
cpp]

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
