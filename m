Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16CB762B04
	for <lists+stable@lfdr.de>; Wed, 26 Jul 2023 07:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjGZF5o (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 26 Jul 2023 01:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjGZF5n (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 26 Jul 2023 01:57:43 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE921989
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 22:57:42 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bb893e6365so21224765ad.2
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 22:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690351061; x=1690955861;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VPuNFkhwpyb3PUUZ8TVx6furGK++PwExybgE5vRefvY=;
        b=I1DqhWBh6iZs+wYMEkQqXVR9gedFlWT8R/0uKwjXxrQjOATewF5a8qA0uagQDDsuIQ
         4KPzyC+zAPUpZl0p0I3oLtiZcow3t2Z4AgieQRqS3klKDcQkvEvUXbGYjpiL4zmwPQ06
         DvH9ox+BUQAo3PrcUJv4jxdjgG2lBTCvtkTuZvrJurnfJDxfTC/xsWAIoQDqk6BWyqRK
         0xdW1Af1H70L13FLJVbAdMMtw2YIRDwYoaKzyYQxKh1KDoEvabPfLhXAAbklD8IOafpK
         If6xCHoFP57yoDoF+KqstxDwIb+OZbwVz31VXEh+sBcqkVGMpDJYQPOFD6906LoEwazp
         KSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690351061; x=1690955861;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VPuNFkhwpyb3PUUZ8TVx6furGK++PwExybgE5vRefvY=;
        b=DkcKA38hhgiYfYLmBNr3TpdRCd6aqSmgtYmssdvtSspwWIRnzAuPwuz/FFd/5GZV2k
         pGVQnvhPz18yJ56TrYKsD/EZKYjpxAcSL9HrAA+y2XDWhrpGRzsQvpvhXcgT72Qtx9Lx
         HukjWDe21ub1KvNi4IQvCaEfgG3qDoWyRPansK72l7fyBAyXYhUXNrdxYZNeZ496yerA
         mxoNx7xvNpnarZCxRqTW6E4kG3lkvYChSNHy2b1LU1rG6JFenGF4TKh0wocwkI88bncp
         iH+h3HopH58hpqRrpwvFFSX4jNMSiL2DZHPCDwyTJs5jEtedDVnc/UP1sgkoTrHMhRQJ
         K7xg==
X-Gm-Message-State: ABy/qLYSQK/DjOSeIbvd/UlKMEqmYhqw4Ou6Z+mgsRKgyw2eH8wn4gM7
        pFt2Ni5MxXwIM4l2Z0We7HYqVQKRkwVrJ+7ukOPMHA==
X-Google-Smtp-Source: APBJJlHpKrT88JGLzxAe7ad2su7HxVGAjd2to63pLLx++uLtuOnCSuhjiZO19VB/4qCfX2uBQgkXBw==
X-Received: by 2002:a17:902:9882:b0:1b8:a720:f513 with SMTP id s2-20020a170902988200b001b8a720f513mr821399plp.30.1690351061289;
        Tue, 25 Jul 2023 22:57:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902db0100b001bb9883714dsm6352876plx.143.2023.07.25.22.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 22:57:40 -0700 (PDT)
Message-ID: <64c0b5d4.170a0220.84cd0.b400@mx.google.com>
Date:   Tue, 25 Jul 2023 22:57:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Kernel: v5.10.187-509-g76be48121794
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-5.10.y build: 19 builds: 0 failed, 19 passed,
 5 warnings (v5.10.187-509-g76be48121794)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y build: 19 builds: 0 failed, 19 passed, 5 warnings (v=
5.10.187-509-g76be48121794)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.10.=
y/kernel/v5.10.187-509-g76be48121794/

Tree: stable-rc
Branch: linux-5.10.y
Git Describe: v5.10.187-509-g76be48121794
Git Commit: 76be481217944567fbdcc92f135a187cc3de8158
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
