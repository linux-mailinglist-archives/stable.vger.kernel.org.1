Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F769764A1A
	for <lists+stable@lfdr.de>; Thu, 27 Jul 2023 10:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbjG0IG6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Jul 2023 04:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbjG0IGI (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Jul 2023 04:06:08 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCA949CD
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 01:02:53 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bb8a89b975so3598395ad.1
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 01:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690444972; x=1691049772;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=22Hte5SfGM0kpS7XTaIU6FYdreK+bKXwQ8T5xt9c4C8=;
        b=H8uS/ejCZXwrOo/93WogMq2pLmwikC+wzU+4Hp513Giw824v+mMH17SKB2s2B0mUIB
         bXuI1VVjm12hJalEXbtq/5BvIWMbvkwqu5j//hnRwb+rP+KR9gNypZHWQaWhqIf1lNnr
         d82PQNO58Sg1HbC5VyLP6IK/K4cuwoAH5AwOAVzyBtR33brUSfld8M04KjRoIXtDq9LM
         xEATPIpL4eDn+u0nb+UpvlvwyPSqu/EjpgKyaXTkhwo/YuETHctPd5Dyxmhrvb/tmJu4
         q3gcMY4HDPeSw61FVuk3OEmrNU2mAFKLDc5bDcJWt3oaK8D9z7ogQNSUIfVNn5cX2nsS
         jEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690444972; x=1691049772;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=22Hte5SfGM0kpS7XTaIU6FYdreK+bKXwQ8T5xt9c4C8=;
        b=b2DJbUs2epbO22tA3lJmmrApjOxCUuVKbAO+UAJQZg0OZLb27b/IaV7zgWmoZqn/bc
         S7pw/Z7aqV43OlSnaudMC2p1DvIBdSeeuUzbJ9/IcKy0PGxl66C2TzXmPmeESieogdjg
         k6zCr5pCCNCM+/vjt6WyZEMk/ZABf8pC0lE1STi5EsasQvJboS65pqRvuiWPpiFc2EkB
         UywfWRwAcrMmQ3x+GN2IR2eZrMbQeFGpEt4F5QmMmiWVrak2Eqv6FGMtreDeevGSQeGS
         Cfq6dsSvMBUnb7WOTXdly5T3xkoYbsSsM6vQDh2qSwqMq8rcpSL1/LyjlLCNDfS0yClM
         FcWQ==
X-Gm-Message-State: ABy/qLbOVlYGvKnmfjmM4QWy2U+c/rbQAOYuuUm+DcCXEiwdkqwckJjT
        w6MVDN6AhzgB84ZzefB5vHY6s+FWVr32oYq+Pvky3A==
X-Google-Smtp-Source: APBJJlGtRedkmfgDXe1ldy5jiP5SY79XBiUOPrfEHKYYYmeqm39tCQnhr/O7bNglWeZfb4MmPm6JTA==
X-Received: by 2002:a17:902:ea06:b0:1b8:9552:ca with SMTP id s6-20020a170902ea0600b001b8955200camr3909205plg.45.1690444972355;
        Thu, 27 Jul 2023 01:02:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902748900b001b54a88e4a6sm929477pll.51.2023.07.27.01.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:02:51 -0700 (PDT)
Message-ID: <64c224ab.170a0220.23dda.183a@mx.google.com>
Date:   Thu, 27 Jul 2023 01:02:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Kernel: v5.10.188
X-Kernelci-Report-Type: build
Subject: stable/linux-5.10.y build: 19 builds: 0 failed, 19 passed,
 5 warnings (v5.10.188)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-5.10.y build: 19 builds: 0 failed, 19 passed, 5 warnings (v5.1=
0.188)

Full Build Summary: https://kernelci.org/build/stable/branch/linux-5.10.y/k=
ernel/v5.10.188/

Tree: stable
Branch: linux-5.10.y
Git Describe: v5.10.188
Git Commit: 3602dbc57b556eff2456715301d35a1ef8964bba
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
    rv32_defconfig (gcc-10): 4 warnings

x86_64:


Warnings summary:

    2    <stdin>:830:2: warning: #warning syscall fstat64 not implemented [=
-Wcpp]
    2    <stdin>:1127:2: warning: #warning syscall fstatat64 not implemente=
d [-Wcpp]
    1    WARNING: modpost: Symbol info of vmlinux is missing. Unresolved sy=
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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
0 warnings, 0 section mismatches

---
For more info write to <info@kernelci.org>
