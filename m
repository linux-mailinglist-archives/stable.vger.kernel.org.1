Return-Path: <stable+bounces-3801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D45780260F
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 18:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A451F20F89
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 17:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C927171D9;
	Sun,  3 Dec 2023 17:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="VCPS2zNf"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390B1D3
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 09:50:06 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6d9a1c13ea6so37240a34.2
        for <stable@vger.kernel.org>; Sun, 03 Dec 2023 09:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701625805; x=1702230605; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UYzR8UKZPk3+fvNYh65o0mgopoCaW34KtYaeKue/Vog=;
        b=VCPS2zNfuEInSl8yARWZbJZV+V89mfiRImRVGwS8dyT2NVEcU19CLEkUgsxOcvaSRx
         AyjvHudVkIFafWmuu1g9+zZP+aoET1f8IwY9JJxPsmKdrsMkbACbkaW/AaLByGwRuHO+
         +eIsqOFvoFxsh57qmHZqsIflaIoqKvDy+8rvYN0ivlLeJ3RLzc6L42jj/6jOThiXql29
         qWaU3nbUJcA9Hnu6I3aG7Ju9boOnECS2OsXXh70ZbF2kJxtzyKSGkCjfO3rltuoGE0fd
         dNPuB+1MkErlP6VzAq36NkmYxYOg7sNNuYkmTXu1HcVnHTgfx6LByySrefuo48UoZRob
         4png==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701625805; x=1702230605;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYzR8UKZPk3+fvNYh65o0mgopoCaW34KtYaeKue/Vog=;
        b=qG1WSB7Nx7W8zO8vSQ+MEKXBtrwA08AmaapDISyKzXRavrwU4QSjy5l+yEUi+ODX9g
         AoeegOUbXGN0uzm9TuQ+tDDTvoIDf1FdyDxP7X1GZMDc7WPT18xyh/pAaM9KMG+RzGxo
         pX12us0YqIyeAgIPq7VOgfPCLMlJ8InbwBefgTUqE6OCQy0KFvSFpo8NJy3fVvDlFZtC
         D+7e0tE+PdZ0cuf3HTTxcCCsPkHEZULZZvBxiwf/ZIbLTQry8Ihcg4o2Xl0qAbDEgFta
         UkJB9od/VLNGiymaMoqlvIpLX+W6iWnoqf8kcFbBHJb6yfj0iwZDSgE1zU0TdqUnf2za
         tsgQ==
X-Gm-Message-State: AOJu0YyVADkI2rFo1HLVEiDLSE08U4h9WhM8tJIA8gN91ac3+wO9wZAu
	djZ6zzTIRnC+K3pT9ZuDt5YfAjfjTxBH9tktlwdrmg==
X-Google-Smtp-Source: AGHT+IHj/BU9c0KlHR3xo8INNF/xNc713TGsh8nh0GEgrrz05AY8mKDFy1wPWaFMHb4+sgq2uezQqw==
X-Received: by 2002:a05:6830:1b62:b0:6d8:15ac:938c with SMTP id d2-20020a0568301b6200b006d815ac938cmr2611285ote.0.1701625805209;
        Sun, 03 Dec 2023 09:50:05 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f19-20020a056a001ad300b006cbb75d87d2sm1466484pfv.6.2023.12.03.09.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 09:50:04 -0800 (PST)
Message-ID: <656cbfcc.050a0220.c7fc9.2afa@mx.google.com>
Date: Sun, 03 Dec 2023 09:50:04 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.65-54-g51afe13792d3c
Subject: stable-rc/linux-6.1.y build: 19 builds: 0 failed, 19 passed,
 1 warning (v6.1.65-54-g51afe13792d3c)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-6.1.y build: 19 builds: 0 failed, 19 passed, 1 warning (v6.=
1.65-54-g51afe13792d3c)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.65-54-g51afe13792d3c/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.65-54-g51afe13792d3c
Git Commit: 51afe13792d3cd798bc2d54685caef8ee5f3ae72
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
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---
For more info write to <info@kernelci.org>

