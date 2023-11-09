Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4A57E69B5
	for <lists+stable@lfdr.de>; Thu,  9 Nov 2023 12:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjKILdC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 9 Nov 2023 06:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjKILdB (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 9 Nov 2023 06:33:01 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C72893
        for <stable@vger.kernel.org>; Thu,  9 Nov 2023 03:32:59 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5b856d73a12so626590a12.1
        for <stable@vger.kernel.org>; Thu, 09 Nov 2023 03:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699529578; x=1700134378; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3lp3FqYlKahoV/Meyfmwyrk1aWLCp7V/J9Eh9Zq+H3k=;
        b=DtvBXEaMROYaKTwv5LXpO5q/fxlQfkI6uP+JeRpyfpECY8iZxli/venoUfDQ1I6O6u
         maPpwD9VCvsYyaMSp2vwv5/mHTetDJFrE9OuiOLErbVr/zQyUGhuvj9S1G88lme1WiS3
         449UEncNs093Ff8xmoS9N+cGWfC6vVfQP/L+eULAFgVrppSzTRpt2T0+5gP4s6NN+Z+I
         CduTYcxMOG3IqUAbxsnRIRbvmykb8gKcCSvFKvqoWQ4U/kADzcaN8AWIMRm/Pd5IHH8l
         yMraYW/ODwXV9uF+R+VB2c5WkpOxF2x6ZnvVmFgekSgfmy8ivY9thEr5gF4kbO/B2goV
         yCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699529578; x=1700134378;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3lp3FqYlKahoV/Meyfmwyrk1aWLCp7V/J9Eh9Zq+H3k=;
        b=gKZOiVZKuNzTwza5WJ51v1jTnuwFEAwqFTGZ4SXsW1lEBCYY4hh+5aYId+pK2hpEWa
         8HuPD14XbqlJ8+iN2c6GKI/UP1MY6nmwOcDPHwWf99XXzFFzSAbVphFF4IP+CrjXCK7E
         aaNq7wGub3P9hbFtO3ZeFnJvVKM4QQjD02YyPlOpZoRtPsjqAEkTdcJGyq0+mltjiDH2
         o29c+KSGTHMnjZItAKW7/qJrVH7RfDP+RC+hdo86oV56Gj7v8OAK3jWxEOBEDJOGp/BD
         ZMeF1Qg6AF9wsJsp1DaR7V2Uz020re71qeoCWWvfW+tVk8o10o7i6rjVrBxPW4UQ+h0M
         ow6w==
X-Gm-Message-State: AOJu0YyfXxBM+C4BhE8k2DV8QIU4p9XWw3CbYN+P8JBGgh6dNZuaCoyZ
        /8qK+6iTNTjOXTQv67Qmt7C4RSb/At0vFsaTAPpPUA==
X-Google-Smtp-Source: AGHT+IFZrFYWqBEMaiVDdu+gWOs0qh1rFYJZEwtLa6TZDVRegv/aG2J6AUqweItBUQoOfEn2zOMVQw==
X-Received: by 2002:a05:6a20:8f13:b0:15e:d84:1c5e with SMTP id b19-20020a056a208f1300b0015e0d841c5emr5754818pzk.38.1699529578629;
        Thu, 09 Nov 2023 03:32:58 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b12-20020a170902ed0c00b001cc8cf4ad14sm3295407pld.142.2023.11.09.03.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 03:32:58 -0800 (PST)
Message-ID: <654cc36a.170a0220.bc61.985e@mx.google.com>
Date:   Thu, 09 Nov 2023 03:32:58 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.200
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable
Subject: stable/linux-5.10.y build: 19 builds: 2 failed, 17 passed,
 5 warnings (v5.10.200)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-5.10.y build: 19 builds: 2 failed, 17 passed, 5 warnings (v5.1=
0.200)

Full Build Summary: https://kernelci.org/build/stable/branch/linux-5.10.y/k=
ernel/v5.10.200/

Tree: stable
Branch: linux-5.10.y
Git Describe: v5.10.200
Git Commit: 3e55583405ac3f8651966dcd23590adb3db1d8c2
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e.git
Built: 7 unique architectures

Build Failures Detected:

arm64:
    defconfig+arm64-chromebook: (gcc-10) FAIL

x86_64:
    x86_64_defconfig+x86-board: (gcc-10) FAIL

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
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches

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
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warn=
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
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 FAIL, 0 errors, 0 war=
nings, 0 section mismatches

---
For more info write to <info@kernelci.org>
