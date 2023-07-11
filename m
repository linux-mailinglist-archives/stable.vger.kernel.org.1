Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7983174F845
	for <lists+stable@lfdr.de>; Tue, 11 Jul 2023 21:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjGKTL4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 15:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjGKTLz (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 15:11:55 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0DA100
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 12:11:54 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b9cd6a0051so20548085ad.1
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 12:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689102713; x=1691694713;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bARkGZ3dss4BcjOVsFQK3rhU45fbYb/5NrZsxAKBOWw=;
        b=tKXoZ3FXAeKX+M2oO4HP+/WPjGFNwhQ7JxxRc7Imh0nhSVoZaQcU87w+FG33tDfmLF
         //tcWgB3hqNls8PEMKySDlfc2PohNdxrCSNAI4t49sxVaIV8oBTjAOPeE6t2FKb5GMFV
         uneTjY4bfGmQDJ76oMbTe5uPn8mwwR7vlX2ZK8Zi/h9iIOa1jgcAh/7fUtGU5vw9Tkel
         5oXaXchmVv9TfMODaIF9bNbi8KPzTb10Jry1rbADu4wTW9nWHdDYfMVv0YoV0d+U4Gpu
         KTI84UDyQLEuhXjO69o6JH6gFi8qSGxTf4RsRYmbMwrmVlDj7krjcU+4UDnVgtO3T/Vy
         pbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689102713; x=1691694713;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bARkGZ3dss4BcjOVsFQK3rhU45fbYb/5NrZsxAKBOWw=;
        b=j5704xAVJAXFePnNEGCX5t4VorLZqCLH75QOD3zjf4WP8HQHpS7mrvAfacob7JxqLj
         7vtCfMdtn6MhT72mdarUr42Aim7xE3mIjsvIPlKckhMuX2UF4Mxvlzu8nqzov71bz8yL
         iVNftuwemJU0VfibMSnpOu9UMS2qngmzH2Tf8wx8gQINxXbhM8Y0DRkPlqYntHHOKwnF
         V30paeTn0yaZAl8Hf18P6iyMB4SaXqiUGlTPh3RJcF+QJ8j2mza/Xnr/Q0mxpjZ1C0Nt
         L4y+7U0XqnSaa03B4TJghtnBihJj2/Va4vfThRVtUi1khPDCuQmP+vyffodY5UQJnFTV
         cJKQ==
X-Gm-Message-State: ABy/qLbPLL+Sw+eI+Y32GTPjFc4zKH8wYrN/WKNvLokTQ4PlTv0fxzUU
        h0Of+sTN06NKMAjH9KehATOw6NvPLY7Q98uZp0IABA==
X-Google-Smtp-Source: APBJJlFvXwTqFFGqNrCW81tMtMXv8Wg63YE9/EInv2T9JmFbYeGHkhSOq0ivPMYCxfAqb2ZXxQpyUg==
X-Received: by 2002:a17:90b:3b4a:b0:262:f449:4492 with SMTP id ot10-20020a17090b3b4a00b00262f4494492mr12192634pjb.30.1689102713402;
        Tue, 11 Jul 2023 12:11:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n10-20020a17090aab8a00b00262e604724dsm8481221pjq.50.2023.07.11.12.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 12:11:52 -0700 (PDT)
Message-ID: <64ada978.170a0220.ab020.01d9@mx.google.com>
Date:   Tue, 11 Jul 2023 12:11:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.3.13
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-6.3.y
Subject: stable/linux-6.3.y build: 20 builds: 0 failed, 20 passed (v6.3.13)
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

stable/linux-6.3.y build: 20 builds: 0 failed, 20 passed (v6.3.13)

Full Build Summary: https://kernelci.org/build/stable/branch/linux-6.3.y/ke=
rnel/v6.3.13/

Tree: stable
Branch: linux-6.3.y
Git Describe: v6.3.13
Git Commit: d1047d75f77afefd19b19ae33cde7ad67f3628c9
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e.git
Built: 7 unique architectures

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
0 warnings, 0 section mismatches

---
For more info write to <info@kernelci.org>
