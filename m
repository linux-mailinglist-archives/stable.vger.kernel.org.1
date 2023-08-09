Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71233775737
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjHIKl4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjHIKl4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:41:56 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0A01982
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:41:55 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bc8a2f71eeso9600705ad.0
        for <stable@vger.kernel.org>; Wed, 09 Aug 2023 03:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691577714; x=1692182514;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RpcnSr5OEEB4X+2SHkjb/JoeOgz5fHhPY78kPsYm9p8=;
        b=LOgOn415qzz+LmUGiL0FQky8DiUzKxjJYvBr9quprrmtNRDwA226tyr7YmqB71A3ly
         s9++895zWe080oLtiy7KacNZBZIFdWn0rUFAH1JiR95VZF2QN7dv3VaTUfvbOmwjGmtz
         tsfVKnnx4ne+rzVgO3okQ4tjsLidRv0sFWXVksvCRPNSk7grfHv9dKURB2vBFkcYmPKg
         zMATp7WHUoBK4ck6iOquXQvPMQ1RNeYCRo8NSCERxiPnn2Mj1M4oRovNQPXpYZxsIAJQ
         pzYG8oYDLuVndiMjHhD4hl+a4xc8F6mqBokmi1p3VhuTBrUZfsjOdknX0icaoxPr3bio
         ngJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691577714; x=1692182514;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RpcnSr5OEEB4X+2SHkjb/JoeOgz5fHhPY78kPsYm9p8=;
        b=Mn6vOsysVaAXVM+Cr6Z7EEsmLQ/VThUb80MD99NrKO9nqwZmazxn/RI8nEyz8EzlcB
         vhZ8BxqUDiXmrq5NZHVxTHqWHghbsOQgFUxMwzUwfOp0mw71UfLB3DEojNW6VuRsboBb
         VTaqYPOdRSAy8VSnK0VNn5wVe8Xn92Q3uRS2cg4+c8DjauOKenhajcBOlcXN/ZAE5Y+w
         L+tQXpGbDHIMo1cPObbZ6mBl3YPKbyWzu68yQBBC767l7nV/5zh+uXUF7mWEJmpjgXrM
         ybF9hirX+C6fsu0auPPshvSaELxXgg2cz79265pDK8xbLmgZAmeP+pWCTN35cTqERRvj
         hyyQ==
X-Gm-Message-State: AOJu0Yy06Fuq1gYmoD8rAURV1TJWQt8aHyeNtAFvf5kOE7BlpCSEd3tq
        4R499Ahn0jp1qFOgR4KpJ0PJLoB8Xwuj8l+ytY1x6g==
X-Google-Smtp-Source: AGHT+IHQdePmsy2YWhD4X6f6KwwR08+1EwM1pnWzG0bzJTliwnYRDyhog7vc4Sf0vcGfM505tObEBg==
X-Received: by 2002:a17:902:b701:b0:1b9:cb27:7f43 with SMTP id d1-20020a170902b70100b001b9cb277f43mr1772481pls.43.1691577714523;
        Wed, 09 Aug 2023 03:41:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t22-20020a1709028c9600b001bc68602e54sm6860906plo.142.2023.08.09.03.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 03:41:54 -0700 (PDT)
Message-ID: <64d36d72.170a0220.cb533.c48e@mx.google.com>
Date:   Wed, 09 Aug 2023 03:41:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v4.19.290-323-g620319be9a607
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.19.y
Subject: stable-rc/linux-4.19.y build: 19 builds: 3 failed, 16 passed,
 24 warnings (v4.19.290-323-g620319be9a607)
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

stable-rc/linux-4.19.y build: 19 builds: 3 failed, 16 passed, 24 warnings (=
v4.19.290-323-g620319be9a607)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.290-323-g620319be9a607/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.290-323-g620319be9a607
Git Commit: 620319be9a607a1b6b72d38a21ca5aefcac95a4c
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

riscv:
    allnoconfig: (gcc-10) FAIL
    defconfig: (gcc-10) FAIL
    tinyconfig: (gcc-10) FAIL

Warnings Detected:

arc:

arm64:
    defconfig (gcc-10): 3 warnings
    defconfig+arm64-chromebook (gcc-10): 3 warnings

arm:

i386:
    allnoconfig (gcc-10): 2 warnings
    i386_defconfig (gcc-10): 2 warnings
    tinyconfig (gcc-10): 2 warnings

mips:

riscv:

x86_64:
    allnoconfig (gcc-10): 2 warnings
    tinyconfig (gcc-10): 2 warnings
    x86_64_defconfig (gcc-10): 4 warnings
    x86_64_defconfig+x86-chromebook (gcc-10): 4 warnings


Warnings summary:

    7    ld: warning: creating DT_TEXTREL in a PIE
    6    aarch64-linux-gnu-ld: warning: -z norelro ignored
    4    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'
    3    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in rea=
d-only section `.head.text'
    2    drivers/gpu/drm/drm_edid.o: warning: objtool: validate_displayid.c=
onstprop.0()+0x6a: return with modified stack frame
    2    drivers/gpu/drm/drm_edid.o: warning: objtool: validate_displayid.c=
onstprop.0()+0x0: stack state mismatch: cfa1=3D7+112 cfa2=3D7+8

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
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 sectio=
n mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section =
mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
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
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 secti=
on mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

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
tinyconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section =
mismatches

---------------------------------------------------------------------------=
-----
tinyconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section m=
ismatches

Warnings:
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

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
vexpress_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 s=
ection mismatches

Warnings:
    drivers/gpu/drm/drm_edid.o: warning: objtool: validate_displayid.constp=
rop.0()+0x6a: return with modified stack frame
    drivers/gpu/drm/drm_edid.o: warning: objtool: validate_displayid.constp=
rop.0()+0x0: stack state mismatch: cfa1=3D7+112 cfa2=3D7+8
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
4 warnings, 0 section mismatches

Warnings:
    drivers/gpu/drm/drm_edid.o: warning: objtool: validate_displayid.constp=
rop.0()+0x6a: return with modified stack frame
    drivers/gpu/drm/drm_edid.o: warning: objtool: validate_displayid.constp=
rop.0()+0x0: stack state mismatch: cfa1=3D7+112 cfa2=3D7+8
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---
For more info write to <info@kernelci.org>
