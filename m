Return-Path: <stable+bounces-5031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D44C80A78F
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 16:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8A792814C4
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 15:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1813031A61;
	Fri,  8 Dec 2023 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="FNmc86gx"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EA310EB
	for <stable@vger.kernel.org>; Fri,  8 Dec 2023 07:38:00 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-58ceabd7cdeso1100339eaf.3
        for <stable@vger.kernel.org>; Fri, 08 Dec 2023 07:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702049879; x=1702654679; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vo9F077bslV6QMX2VygNHI3lqeegkSV9JJEBsbIgH00=;
        b=FNmc86gxpKugrzoPaMJVuWDZhY61oee9Y2CwiCawcJ/f5dIeKcp+x574KP9gazCxoT
         I8KOLfQDegQ3ayF6LqVyC3YuzKYgOL7EOBAKKAd8QOb8uN6G3QSvqCOqVSlgTUkxWHTg
         lwq96TA/dYx2ANcWt60dTqira9Mbg52Ju7gHdZVRVCZrkQWNfeHkFecgPvMbcjkMStG4
         SEsOJ5DF69b5AHFFcuOpCBWVEsoDCModhAHqzCgP/BYeyb1Dz75mIBhBe/qMys3iOwXa
         XLHstcYs81nbvBGUNG2Zip5N9G59ipoXtRwrz4O7U8xS3WOxxwA3rLu37nShzXvmbtNa
         tdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702049879; x=1702654679;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vo9F077bslV6QMX2VygNHI3lqeegkSV9JJEBsbIgH00=;
        b=YK97gTVzSFT6igpKO8tSfiP3nkgOWLHRpWxhLKistRnR/03BR/S+gjwr7SbWh1k6fq
         fNwZ/JJqj9mymQLBSfDoNvCsA7Qm29gp5GdXLthkbH7ckSHiBwvgoKEwlqk8k039px6Z
         UthlaTj1yFt7oc1h3ZfolsWbSsqUWMfsUvBuliNxbLWAuBOEkBWVS42Vhioz4XaX0tvy
         gT6/0MS4Ui1pE6JxX5IoZjBGLqzTOK3sOEaZ5PQgWcT2FyB8tgrsen2438Gzy3zHjzis
         0U2m+Lux2x/XUSPos6/RIv4GdD68+JRXeEw7F4gwCf6ygRjd6f0VUkz8GeYSE1UYEvN+
         wOmA==
X-Gm-Message-State: AOJu0YwNoQXMaOyx/NreQ2fqjeD0wB3SBNYAU0qK3QOh4l8sz49/cQwO
	102nLWqf67zjGdOLCjpSzikfQE68bKoiJebgxiFGkg==
X-Google-Smtp-Source: AGHT+IENz63gx0JdIwrJSpFukxxx5mFApmmqnuvx8WetGHaGuO9oaT0A5PO+Z2itaG/WQbnOeVdvig==
X-Received: by 2002:a05:6358:15d0:b0:170:15a7:1fea with SMTP id t16-20020a05635815d000b0017015a71feamr97744rwh.2.1702049878929;
        Fri, 08 Dec 2023 07:37:58 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id gx4-20020a056a001e0400b0068fe9c7b199sm1713311pfb.105.2023.12.08.07.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 07:37:58 -0800 (PST)
Message-ID: <65733856.050a0220.75d19.5abe@mx.google.com>
Date: Fri, 08 Dec 2023 07:37:58 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1.66
Subject: stable-rc/linux-6.1.y build: 19 builds: 0 failed, 19 passed,
 1 warning (v6.1.66)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-6.1.y build: 19 builds: 0 failed, 19 passed, 1 warning (v6.=
1.66)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.66/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.66
Git Commit: 6c6a6c7e211cc02943dcb8c073919d2105054886
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

x86_64:


Warnings summary:

    1    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_devic=
e_reg): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expec=
ted "0,0"

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
    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_device_reg=
): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expected "=
0,0"

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
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---
For more info write to <info@kernelci.org>

