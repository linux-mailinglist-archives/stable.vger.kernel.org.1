Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB74759DFE
	for <lists+stable@lfdr.de>; Wed, 19 Jul 2023 20:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjGSS5j (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 19 Jul 2023 14:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjGSS5h (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 19 Jul 2023 14:57:37 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C66E5
        for <stable@vger.kernel.org>; Wed, 19 Jul 2023 11:57:36 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b9cdef8619so46685475ad.0
        for <stable@vger.kernel.org>; Wed, 19 Jul 2023 11:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689793056; x=1692385056;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tNAPyu566Fv9MiiiFzigfRQA8YTuMAzlft64JyDqRv8=;
        b=tmBHGvQrft/SkW/eMz8kVneoa0ZWzfZi2t8aaKYKxXrKkXujQqgMlnlVe9mP9SDSBT
         fNPadx6BzNFVEjpecapqjv9JUbr8F9J8bZT1UNZOJAV4tNx0IUbxXTvZ9qlvhqgbmdXc
         hsZwRz97d5jiFoVIkVbeHjIuVkMq9HK9azr8YixD1rSTUyhoOiVXs/jbx5sb/Fa/+p9F
         W6s3hNizptuLQg8x9v62EyLTfJWOO4rUflXQZdFHhRWJd3UCNpoXoN9QR4bclOr7b1vJ
         DvNLz6tk46FG4bbnI3ClWfxw6CJV/TT5e0ZdNqczKLxbGgWfKBolONpRg5ycJ8PjWNeM
         6QrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689793056; x=1692385056;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tNAPyu566Fv9MiiiFzigfRQA8YTuMAzlft64JyDqRv8=;
        b=b4VJBouqUiS0KQjcB+iKiyYEWtRyUlC4vb7gcB7o00DRw0H+uyi8RlOImDVsQ9FtU9
         KcacfPk1bKzaQlRU/8yEcHbp2Alru6fOu3pXtlsUXjm2an8TH4fhR1FWERnJOIpDxMtV
         tXYNJ7j6vpZfkHaxBHuHV0AchIzCfDza4m40FiY5lh4ul2mj3+/sCgVPuE43ZnGw0STG
         gVxKLew8eE5ax0lfbPQHvCrhhD7FCSlRCrqj8ODLvtIlBcNqTqk4fj+mO2/0OoMMMYql
         uUCeHDFdmBkM6OLY7+LYl0alKnLNkGuMuseL05hRh+Wh1JECoG8TK0xhU8EQ0ZN5YH2r
         Wb7g==
X-Gm-Message-State: ABy/qLaj103Tp0E6+w7JlRFe6K3+yOd+1SN/XCikvJvPBwmG57/i1kAE
        VvXwZaeWg39UtXViqlzX1LKYEFngNW2iTRe3/UAVIQ==
X-Google-Smtp-Source: APBJJlEmAd/CChhXWLowRDHPQCW6kg7cZLQShYKbg6JCwHbOT8B4okUCEC70QScVz7zj7tMoHw2ckw==
X-Received: by 2002:a17:903:41c1:b0:1a6:74f6:fa92 with SMTP id u1-20020a17090341c100b001a674f6fa92mr6590717ple.19.1689793055979;
        Wed, 19 Jul 2023 11:57:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jh6-20020a170903328600b001b5247cac3dsm4362765plb.110.2023.07.19.11.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 11:57:35 -0700 (PDT)
Message-ID: <64b8321f.170a0220.c648d.a191@mx.google.com>
Date:   Wed, 19 Jul 2023 11:57:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-6.3.y
X-Kernelci-Kernel: v6.3.13
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-6.3.y build: 19 builds: 0 failed, 19 passed (v6.3.13)
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

stable-rc/linux-6.3.y build: 19 builds: 0 failed, 19 passed (v6.3.13)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.3.y=
/kernel/v6.3.13/

Tree: stable-rc
Branch: linux-6.3.y
Git Describe: v6.3.13
Git Commit: d1047d75f77afefd19b19ae33cde7ad67f3628c9
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
0 warnings, 0 section mismatches

---
For more info write to <info@kernelci.org>
