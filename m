Return-Path: <stable+bounces-5201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 485ED80BC12
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 17:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CBE81C20889
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 16:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1D2171B2;
	Sun, 10 Dec 2023 16:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ok2uTUWQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E82F5
	for <stable@vger.kernel.org>; Sun, 10 Dec 2023 08:04:58 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6cebcf8a48aso2640998b3a.3
        for <stable@vger.kernel.org>; Sun, 10 Dec 2023 08:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702224297; x=1702829097; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rjYIH3b9fCurcqLs5TCxw03KReKTwQYaFjXTRMlrTcA=;
        b=ok2uTUWQATc10tPs8QOQofSSqFkOIJNgz6lvO2FRQuWFHD4/EnYnzjeLYHE7v3XtW6
         /o/xdF/wf7mhcspclAjssCfjVxRjNUxb/X3iTH4JqNEWTEW30uc3vaX18SAF8VvZ9d62
         eUNOF6xJ8OZc0Ho2LeLZHMkERsg/yq9btt4ZDpAdPxdi75enKgMfez3NIAOu8pGYFJxf
         auQO+zMnYSuvhtv+C/ifRbEvu/Ep8Qe+pkweEiqqXC3wbt2LpLlNVccRlie3dRZiVZSd
         +RFMdDmHwlbPEGAsSwOjf+vx0UL6J1Epgd0ytoua4FOg99jQgVwda5+UttzaZj2IRjxV
         GMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702224297; x=1702829097;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjYIH3b9fCurcqLs5TCxw03KReKTwQYaFjXTRMlrTcA=;
        b=ey3gvDiy7N/e9FoZ00vF1mQQrM27cusm3B60SH59JDbfV6B3EFEh+OAQG5jUHR1BJA
         RJNW6qHddLCwDPnoIhc5VkE7rQod0Ct6H2k0/5avGea7BdcJE55zuu7dNFZgQip66W44
         ZyEU8dkqdMQok27Cr/XtZi3PO9fCCQCulM56yCk3kuZHrWGiJnss13wm4TKsAgRrbWSi
         h9sN1TVC4rBQueVm/Cir9XiIpyVyrpdyUJcg+F6cseHmCXQZhlibg0LuWHPBtBb6YqI7
         HD8D5SSZ+dQ39SbDta8DVQGCY7UxJEzs5OjCGGddu8j6Sh3b4xnVOhydDpDx38Iqhps5
         uW7A==
X-Gm-Message-State: AOJu0Yynvca5YzUi3x1tYsKnxNLN6sffh0sWV2L0fqaMC5nK7+w2cDXO
	jygX0Ei+Wnz0Iewv1pO53bCYuXqtKmf0cX6xXHikjg==
X-Google-Smtp-Source: AGHT+IHMT2DYKSVNLXX1veuvCTYgQ9NwfmICIrNqld20BVIfHEX1W7rgyRUup6z7nqA7o2+64WWYOg==
X-Received: by 2002:a05:6a00:4653:b0:6ce:6f99:4ec4 with SMTP id kp19-20020a056a00465300b006ce6f994ec4mr4061678pfb.1.1702224297510;
        Sun, 10 Dec 2023 08:04:57 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z19-20020aa78893000000b006cb884c0362sm4666341pfe.87.2023.12.10.08.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 08:04:56 -0800 (PST)
Message-ID: <6575e1a8.a70a0220.4351b.cebe@mx.google.com>
Date: Sun, 10 Dec 2023 08:04:56 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.10.203-59-gd6656e065a9a5
Subject: stable-rc/queue/5.10 build: 19 builds: 0 failed, 19 passed,
 5 warnings (v5.10.203-59-gd6656e065a9a5)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 build: 19 builds: 0 failed, 19 passed, 5 warnings (v5.=
10.203-59-gd6656e065a9a5)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F5.1=
0/kernel/v5.10.203-59-gd6656e065a9a5/

Tree: stable-rc
Branch: queue/5.10
Git Describe: v5.10.203-59-gd6656e065a9a5
Git Commit: d6656e065a9a52c761a83874e2234e0b067393fb
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
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---
For more info write to <info@kernelci.org>

