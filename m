Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA0373F129
	for <lists+stable@lfdr.de>; Tue, 27 Jun 2023 05:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjF0DIW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 23:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjF0DIU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 23:08:20 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB211BB
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 20:08:18 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6687446eaccso3718699b3a.3
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 20:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687835298; x=1690427298;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nHTwqfjqw5/y5tRrG47R4Kc1iN5MintdPzzRnxsWx50=;
        b=z4Etnexk7/dp3scPw570bf1MCyushm8184q3fsZPqiNNNuSOPmaYXTmlJDxvZ3Hwst
         pltC6chZUtuGzC3hynOCsD2NXdslNznQyu0AkfcuXH7NQ9NViC3GxtpCxqzjebqndQFd
         emY2HvNrLyHc0/VZGeHlmtLbtf/HkIZG1B+jwzpDPCFEmP81r35DBdaJBib4QuMHucXY
         COvwhnxaIeR1KooOerR6fhAjylAa2ynCQzlxR8QfDKTzMQYs+xv+oHfkf2XovTmchZKL
         lxaKunfogXAS+FBPrrGDCwxMlEGLkCV1zHAK8s+32lUTICR4lvXjfQVgQYRYDq3F/J6Z
         T75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687835298; x=1690427298;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nHTwqfjqw5/y5tRrG47R4Kc1iN5MintdPzzRnxsWx50=;
        b=Cmq0ltHcHsu4CWtHhoyFwa8kJBwUYaWLOw1VYyhpXCFkb7uu3l0+EhDikgCxezpuKT
         Fu4XltaZYr0emyEZrSo+bmIR71I1v5vDA13iy0O2rxNO5aiKCGLtiiVNt/wGVNVGt3f8
         XE+qzBIz4nYbm6GG5Gn/uKzQhF/pFbF5ES2WH4WVWpBmui93/lch3P4CVacJsBlGlHzf
         +aAEk8ZCxhT+sY7uXC5dFP4x0Z0lzg0HDL9m2ms7A2s4Ddh79WKQueJmc5U2JVEYV9/S
         51cIpj+HHYJJ/L55EiOp8jzwjefDA4BZ7K4mhi3m9B7D/ZnbcUXAtLcSCmEWDOgzjZ+7
         0Dgw==
X-Gm-Message-State: AC+VfDzl1UBBZ4nAJ3nEMvno7y8m4KfoUbqBy3DTIB81rWlY8hgUA0Gm
        m47uhtuTuAR1QyyTtezn1ufS3+5uD6D09bvG8ZijTg==
X-Google-Smtp-Source: ACHHUZ4BHhH07fU47r1iGhBmvHAlfOW6w6be2eu3f0uCgmph6BbU8UtLy7009XainkVFIeciVLRlDQ==
X-Received: by 2002:a05:6a21:328c:b0:126:a80d:4960 with SMTP id yt12-20020a056a21328c00b00126a80d4960mr9158543pzb.30.1687835298103;
        Mon, 26 Jun 2023 20:08:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y17-20020a170902b49100b001b54d064a4bsm4796722plr.259.2023.06.26.20.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:08:17 -0700 (PDT)
Message-ID: <649a52a1.170a0220.c684.90a5@mx.google.com>
Date:   Mon, 26 Jun 2023 20:08:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v4.14.319-27-g11aa1c2697f5
Subject: stable-rc/linux-4.14.y build: 19 builds: 0 failed, 19 passed,
 3 warnings (v4.14.319-27-g11aa1c2697f5)
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

stable-rc/linux-4.14.y build: 19 builds: 0 failed, 19 passed, 3 warnings (v=
4.14.319-27-g11aa1c2697f5)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.319-27-g11aa1c2697f5/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.319-27-g11aa1c2697f5
Git Commit: 11aa1c2697f51ec92ee0c9033b8bce9e13b71787
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 4 unique architectures

Warnings Detected:

arc:

arm:

i386:
    allnoconfig (gcc-10): 3 warnings

mips:


Warnings summary:

    1    ld: warning: creating DT_TEXTREL in a PIE
    1    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in rea=
d-only section `.head.text'
    1    arch/x86/entry/entry_32.S:480: Warning: no instruction mnemonic su=
ffix given and no register operands; using default for `btr'

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 section =
mismatches

Warnings:
    arch/x86/entry/entry_32.S:480: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
am200epdkit_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
axs103_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

---------------------------------------------------------------------------=
-----
badge4_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
hackkit_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
imx_v4_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
ip32_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
keystone_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
multi_v4t_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
mxs_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section=
 mismatches

---------------------------------------------------------------------------=
-----
nsim_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
nsimosci_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warning=
s, 0 section mismatches

---------------------------------------------------------------------------=
-----
pxa168_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
socfpga_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
tango4_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
u8500_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
vt8500_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, =
0 section mismatches

---------------------------------------------------------------------------=
-----
xcep_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---
For more info write to <info@kernelci.org>
