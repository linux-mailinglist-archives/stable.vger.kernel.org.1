Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA83878F22F
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 19:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237488AbjHaRwA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 13:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbjHaRv7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 13:51:59 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D21B8
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 10:51:56 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bf11b1c7d0so15668865ad.0
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 10:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693504315; x=1694109115; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ngf6C5raX0hxh/eUWDqhn/KanhqV7JRSGVSI6G8x4DQ=;
        b=qAm1saB9QLE2hCMQMJlmJYakY+22mzSAcEKz8cO85hRz6IST3lBFbk6sysFqTCHqYT
         7vFYBzfcCeum8l+7o403wWiql7wXn2AZ4u4+JgAn4BchMQgH+iQGKjDltOkRX87O10+K
         eAvBY75bcTpWjekNh6R1EUdSsXi3BXeaHIAoJnbaXcBOV/Y5n9/cia0RfkjiN26X0OmD
         9Tnyroc/6J58gXWnzh8IWChsC5WYxc0bxMOU3XeKhYGSZZ0eR7wkorG2+voPZw45x3Eo
         Ced2KcUXdEstnZlCSO7XStrk8IVup676BDHSm/5h2G6qoN9VsYOwpaZ90ZTf0L4Vxi0V
         qGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693504315; x=1694109115;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ngf6C5raX0hxh/eUWDqhn/KanhqV7JRSGVSI6G8x4DQ=;
        b=XD7kRswdUwQ3uS89pZL8hDEIckk9F0zWa9M4OS3tLBY55Grs69PH3+EUn+E3Uk3Pvq
         G8E9/vYWUkdk4aA7EBjbA3Dv7sE26LXrTQPVhxXrguDw5WaKJox03to/wfQMw5jtiLsX
         7k+L30z60XyOyOW+mFLwdXkmfOvRDaCkxA/7NeW9oCtyEjSHAM66gQ7SVShszNdJ6yVd
         SWeE5bzLQiWIeUNwO4jUqTqvpvtoSo7+9mlZ02200QoLz9PIjBkZ2no8F65m1jbc6p7R
         VLe33/FIKkcBXw8lGVpMlWHsxMVCNSJAStCfLzSYqSWMWoqQWkmBvuYzn6eVHn8mf+qy
         cJQA==
X-Gm-Message-State: AOJu0YxRzgQou02IEymNnVMqitAztelvp/SvE9ruER3ppVenjwyqB3bM
        gGqAuQes4wcEQIgzNmrDXfjdS5uqfC/wuJgp4N0=
X-Google-Smtp-Source: AGHT+IF2ANgpNqsVouEEKRa7uN+W8fDm7z/QuCHMh0Acl4l8gXXFJK08Uq85oz1USWWOXF+M+/sM+g==
X-Received: by 2002:a17:90b:a0c:b0:261:219b:13b3 with SMTP id gg12-20020a17090b0a0c00b00261219b13b3mr222849pjb.16.1693504315035;
        Thu, 31 Aug 2023 10:51:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id gv9-20020a17090b11c900b0026f39c90111sm1615535pjb.20.2023.08.31.10.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 10:51:54 -0700 (PDT)
Message-ID: <64f0d33a.170a0220.22795.338c@mx.google.com>
Date:   Thu, 31 Aug 2023 10:51:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v4.19.293-3-gcb2cdf2272086
Subject: stable-rc/linux-4.19.y build: 19 builds: 3 failed, 16 passed,
 20 warnings (v4.19.293-3-gcb2cdf2272086)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-4.19.y build: 19 builds: 3 failed, 16 passed, 20 warnings (=
v4.19.293-3-gcb2cdf2272086)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.293-3-gcb2cdf2272086/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.293-3-gcb2cdf2272086
Git Commit: cb2cdf2272086683c41f5bb61390600f01227b6e
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
    x86_64_defconfig (gcc-10): 2 warnings
    x86_64_defconfig+x86-chromebook (gcc-10): 2 warnings


Warnings summary:

    7    ld: warning: creating DT_TEXTREL in a PIE
    6    aarch64-linux-gnu-ld: warning: -z norelro ignored
    4    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'
    3    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in rea=
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
allnoconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section=
 mismatches

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
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 sectio=
n mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

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
tinyconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section m=
ismatches

Warnings:
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

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
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
2 warnings, 0 section mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---
For more info write to <info@kernelci.org>
