Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BB27DFAE4
	for <lists+stable@lfdr.de>; Thu,  2 Nov 2023 20:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjKBT2D (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 2 Nov 2023 15:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKBT2C (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 2 Nov 2023 15:28:02 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2F1188
        for <stable@vger.kernel.org>; Thu,  2 Nov 2023 12:27:54 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6c311ca94b4so1323810b3a.3
        for <stable@vger.kernel.org>; Thu, 02 Nov 2023 12:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698953272; x=1699558072; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vS74e/df2YHdbTb2PaVxJ/fcowJMQY03Vzr5IDyEL/M=;
        b=2eiqWhevGgcE1IH0cozam7zogo4+FEQGBxF27DflmtVLpndwbN7Te39ZrEujVJUd1t
         420rv/4mHKxq7xHrWeZrs9HMRIvTA3Ec2BNBtqA1Z+NTHMVZU0/WQw+YNOKm9aMR59aI
         5CHQMNtp+/lfujLGFpcyxe7zpq2XwcnfcsxnkK77x3RM2d790Jkm2uFyonHlEHHf6qO6
         PgQ8N3Qf4s4utTyXi9fIq3f+p9yGxTzeYotlcp3AhyMPgULIGV8dzcNS/LNY/sJjbbqQ
         eazje3E4SU0wUKFykFlKyhwfgDEV9OOwEZleSuxKy8rqyItfUL7ERxHhO0ug3W3KHFeV
         h9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698953272; x=1699558072;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vS74e/df2YHdbTb2PaVxJ/fcowJMQY03Vzr5IDyEL/M=;
        b=sw/ktpXG7dHweimXkQ6jxfUBJcd4MbcGtC+7Xvi7+LYhcSd/6EVSnAyCdAKUJ2zby5
         g2RBi2xdp+o1z7Efzc81xVBIVnYGskysQDmHwqy+0ZTRpt2FvesHRcdRTyaJ/aowfEF1
         k8PrVPUAFmRMvPykXMooim5Q+gDYbEBSlL47Xx//JCgD94gbjb5ab8xWjngWliSmZYUb
         e3qUcjS4VCBgHqquxMhZTJtMC5KfAsHkgx/cMgwr02C29rnSZsXdGTldF3DGW3LzHYDl
         92uPtTA6pLiXHyP54c9Rbm/jMTyMNlyTVPpmH6iGyfbn8oe8aM82J4gZztAZ4G5wv99Y
         Vr4g==
X-Gm-Message-State: AOJu0Yz39CBC6Vfg9Dj6AhOSA1qvtbN5AEpkCOCYk0TPs1xg5lmrNli9
        SU3134g+vbTX9x/GiBb69qDDrWwlViwJcU7ymMLcWw==
X-Google-Smtp-Source: AGHT+IET586yvWwCpSCboYcyWPSC2+1NkJXvWrzSwidStC4InS0P3UoOMP4/4EtYcWEywjoMfLWzrg==
X-Received: by 2002:a05:6a20:7d8b:b0:17b:9b0c:f215 with SMTP id v11-20020a056a207d8b00b0017b9b0cf215mr20971354pzj.37.1698953272431;
        Thu, 02 Nov 2023 12:27:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id r7-20020a63e507000000b005891f3af36asm99605pgh.87.2023.11.02.12.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 12:27:51 -0700 (PDT)
Message-ID: <6543f837.630a0220.78221.07e0@mx.google.com>
Date:   Thu, 02 Nov 2023 12:27:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.297-41-g46e03d3c6192
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-4.19.y build: 19 builds: 6 failed, 13 passed, 6 errors,
 14 warnings (v4.19.297-41-g46e03d3c6192)
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

stable-rc/linux-4.19.y build: 19 builds: 6 failed, 13 passed, 6 errors, 14 =
warnings (v4.19.297-41-g46e03d3c6192)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.297-41-g46e03d3c6192/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.297-41-g46e03d3c6192
Git Commit: 46e03d3c6192741f041d7d46136bc90245ed7220
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

i386:
    allnoconfig: (gcc-10) FAIL
    i386_defconfig: (gcc-10) FAIL
    tinyconfig: (gcc-10) FAIL

riscv:
    allnoconfig: (gcc-10) FAIL
    defconfig: (gcc-10) FAIL
    tinyconfig: (gcc-10) FAIL

Errors and Warnings Detected:

arc:

arm64:
    defconfig (gcc-10): 3 warnings
    defconfig+arm64-chromebook (gcc-10): 3 warnings

arm:

i386:
    allnoconfig (gcc-10): 2 errors
    i386_defconfig (gcc-10): 2 errors
    tinyconfig (gcc-10): 2 errors

mips:

riscv:

x86_64:
    allnoconfig (gcc-10): 2 warnings
    tinyconfig (gcc-10): 2 warnings
    x86_64_defconfig (gcc-10): 2 warnings
    x86_64_defconfig+x86-board (gcc-10): 2 warnings

Errors summary:

    6    arch/x86/kernel/head_32.S:57: Error: invalid character '(' in mnem=
onic

Warnings summary:

    6    aarch64-linux-gnu-ld: warning: -z norelro ignored
    4    ld: warning: creating DT_TEXTREL in a PIE
    4    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'

Section mismatches summary:

    3    WARNING: modpost: Found 1 section mismatch(es).

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
allnoconfig (i386, gcc-10) =E2=80=94 FAIL, 2 errors, 0 warnings, 0 section =
mismatches

Errors:
    arch/x86/kernel/head_32.S:57: Error: invalid character '(' in mnemonic
    arch/x86/kernel/head_32.S:57: Error: invalid character '(' in mnemonic

---------------------------------------------------------------------------=
-----
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 sectio=
n mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
allnoconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section=
 mismatches

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 section m=
ismatches

Warnings:
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warn=
ings, 0 section mismatches

Warnings:
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 FAIL, 2 errors, 0 warnings, 0 secti=
on mismatches

Errors:
    arch/x86/kernel/head_32.S:57: Error: invalid character '(' in mnemonic
    arch/x86/kernel/head_32.S:57: Error: invalid character '(' in mnemonic

---------------------------------------------------------------------------=
-----
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
multi_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
tinyconfig (i386, gcc-10) =E2=80=94 FAIL, 2 errors, 0 warnings, 0 section m=
ismatches

Errors:
    arch/x86/kernel/head_32.S:57: Error: invalid character '(' in mnemonic
    arch/x86/kernel/head_32.S:57: Error: invalid character '(' in mnemonic

---------------------------------------------------------------------------=
-----
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section=
 mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
tinyconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section =
mismatches

---------------------------------------------------------------------------=
-----
vexpress_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 s=
ection mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 war=
nings, 0 section mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---
For more info write to <info@kernelci.org>
