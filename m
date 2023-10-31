Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133FE7DD106
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 16:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344837AbjJaPzw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 11:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344827AbjJaPzv (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 11:55:51 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7738EF4
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 08:55:48 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6bd73395bceso4315157b3a.0
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 08:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698767747; x=1699372547; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0pAcwJ8FMJSJmkuqRrLK9vNI3rOavVslBKsYE0icsnM=;
        b=X3WDX9zqtSEoSbnmeYKRruGm8PlpqJBZCPGsB4x+0jRkaBy1WqTufjHnlrN4yRawad
         oz8S2rBU6qc4RPO2dpxqKX8f2K3uQNoo4rSvJN+W6eZjkZ/gu8Ln+lyad5s+1MCzJ8jE
         QNU2KhDu7Fu/eji1wO8U/ScXtANSjAPtxkPXwQvYNKMzg8+UVBOe4nDVztOaRhxaEwY0
         sv1omYhSw45fN1o6wD8dp7p0RkCgeHMFCUzCsJxThIiEhDlhahafSTLyZtjRiljvWqjW
         XW1aK9xLUqMRM0F+h6B7NivEv0PJppiNcqqga7SRupb3RSpsOdWhCCP8T6cCj4YdJbu+
         IKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698767747; x=1699372547;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0pAcwJ8FMJSJmkuqRrLK9vNI3rOavVslBKsYE0icsnM=;
        b=XKqokkHmAXBmc5EmuMzbt/3xiD0fXK13lesU9MpAJL5ndLfROqE1htLrxyxXlpqfFb
         cqe44E0QpxQwkmkSzoC78ToIQ9lii7Jv2xd89YcHYYCF2stIEjqPo2jR4E3uEvlDPSqv
         1aAd5Do+VbxLFKD8ZEbOm2QkNQvuUN5lph3a8TXH1kJIHcpGk31ZpD0eDi9pTdZikmXX
         mR3aJ8gv2pRKEUj3Bbb7Mo6gi1Pq1jVDmdeS/Neb6B1k2LKM15ZWDSd+Eg3MpbEbbZME
         7m0XxE7P6yMd64vUhhLXfvo8qmbOlO8uo5FmTpQ3uFCZQXmljlxVSFFTXSdwCI9SoH1b
         FL8Q==
X-Gm-Message-State: AOJu0YyTLU3P2B4XAxyH71nyghvaXYI4JwLV072d0FaRfVClaU6TKxtv
        33CTHMK5KSo6xoOSLivAtpW9ce2xpAxwkuBnngkzDQ==
X-Google-Smtp-Source: AGHT+IFoQME+Cn5MkUu8e25TrdDrcRZqE0GIfSOqaOZn6dGfl8moFXC/85Qt0zA9F5F8ahqem+HvSA==
X-Received: by 2002:a05:6a00:1c85:b0:6c2:e10:42e3 with SMTP id y5-20020a056a001c8500b006c20e1042e3mr3725504pfw.8.1698767747391;
        Tue, 31 Oct 2023 08:55:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d21-20020aa78695000000b0066a4e561beesm1467900pfo.173.2023.10.31.08.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 08:55:46 -0700 (PDT)
Message-ID: <65412382.a70a0220.438dd.38a4@mx.google.com>
Date:   Tue, 31 Oct 2023 08:55:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.297-40-g79ba95be7c78
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-4.19.y build: 19 builds: 6 failed, 13 passed, 6 errors,
 14 warnings (v4.19.297-40-g79ba95be7c78)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-4.19.y build: 19 builds: 6 failed, 13 passed, 6 errors, 14 =
warnings (v4.19.297-40-g79ba95be7c78)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.297-40-g79ba95be7c78/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.297-40-g79ba95be7c78
Git Commit: 79ba95be7c783391caf279ac2c334da8f3139d39
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
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 sectio=
n mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
allnoconfig (i386, gcc-10) =E2=80=94 FAIL, 2 errors, 0 warnings, 0 section =
mismatches

Errors:
    arch/x86/kernel/head_32.S:57: Error: invalid character '(' in mnemonic
    arch/x86/kernel/head_32.S:57: Error: invalid character '(' in mnemonic

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
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section=
 mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
tinyconfig (i386, gcc-10) =E2=80=94 FAIL, 2 errors, 0 warnings, 0 section m=
ismatches

Errors:
    arch/x86/kernel/head_32.S:57: Error: invalid character '(' in mnemonic
    arch/x86/kernel/head_32.S:57: Error: invalid character '(' in mnemonic

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
