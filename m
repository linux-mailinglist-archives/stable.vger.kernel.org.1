Return-Path: <stable+bounces-4720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 077AF805A82
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 17:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF71D1F2178F
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 16:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA4560BA2;
	Tue,  5 Dec 2023 16:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="GJ0ULZlE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847F51724
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 08:52:35 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6ce52ff23dfso1826262b3a.0
        for <stable@vger.kernel.org>; Tue, 05 Dec 2023 08:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701795154; x=1702399954; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdafSA9qO0VZMtIZ0y0RoMOU0kgqv2wKrjr8P7XrDjU=;
        b=GJ0ULZlEK+Ow3ZdrHueaHRKT1IYuQn8qgfiu6nG2lFLzK9/ijLbEdFmNOMlpfC92At
         Mr7kpRpCcJSHv3UGNjc5iwd5SX64pR48Y8UDCJHwF7eZ6TeuJjwlkaAKGUdzGuEgYPBc
         zfxzMxLv6JRX4iuzF+gh6tHnrKkL72gzUWHGfo0XUvNl4KJ7Z8rNu5bhw5a4gtdRCgpm
         kxhF3Fpo6wmh4m48Urom15W2U5Brl42/VhFAMOS/Uw6CIqX+gAKW7kEp14BE93IL6V7G
         GbJAkZzgbEie5ccM/Q34o+Qvm1sYEhmwu16ZnSSYilubeBREBWKGhQ3sb83C4yUqqfZ6
         56AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701795154; x=1702399954;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZdafSA9qO0VZMtIZ0y0RoMOU0kgqv2wKrjr8P7XrDjU=;
        b=UbG9YUT1BfO6MqaFPnUxapp0Mc1RrljheVhlGoWazAR08djifc48uMUIGkHmJrvzBL
         Nif2BhJb9KH/hiylnaXnfW2CkT8deqBs6507v54sZL+FaIABGXPImL2T0fPFE2Uf7yqQ
         QiKv8iWkRlwdfVdSO9AdJ6UquJnf2p9sUevbXer+NwcV06cJSk+QHi68cMBEb9I5YWBS
         H0+bdArBAxQN41fGYkDtSYY35OI+0N5cercbW0R4WMJp8+CtdRv0UBLEyzif3orhAa8q
         N0LPWNhrkncCCSxjv2uJdZR92oCBcbUxYyVnU+oTmnZy+qr9Gd4+UXOscbnUUMT1jT/W
         qu7Q==
X-Gm-Message-State: AOJu0YwLJNuqYWcQS1TBtuo9GTvFyHRabaf0GiM+Zwzs90FOStdMYARO
	c+R9Erbp2f3xU5vPgMFkUGh6sg4ENgtkRhYKBycMVw==
X-Google-Smtp-Source: AGHT+IFMlQzd9efphwI7NThaBwdg1OHQiGRRb3mujOe4bnBgNKUXzxdPsTKaJsS5k0kSktEXpzvwDQ==
X-Received: by 2002:a05:6a00:130f:b0:6cd:fa30:f52 with SMTP id j15-20020a056a00130f00b006cdfa300f52mr1470955pfu.9.1701795154564;
        Tue, 05 Dec 2023 08:52:34 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c18-20020a056a00009200b006ce458995f8sm4813556pfj.173.2023.12.05.08.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 08:52:34 -0800 (PST)
Message-ID: <656f5552.050a0220.5bd9a.d693@mx.google.com>
Date: Tue, 05 Dec 2023 08:52:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.15.141-67-ga00c66688b94
Subject: stable-rc/queue/5.15 build: 20 builds: 0 failed, 20 passed,
 3 warnings (v5.15.141-67-ga00c66688b94)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 build: 20 builds: 0 failed, 20 passed, 3 warnings (v5.=
15.141-67-ga00c66688b94)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F5.1=
5/kernel/v5.15.141-67-ga00c66688b94/

Tree: stable-rc
Branch: queue/5.15
Git Describe: v5.15.141-67-ga00c66688b94
Git Commit: a00c66688b948a18242a10ae70053097bdec7e8c
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
    x86_64_defconfig (gcc-10): 1 warning
    x86_64_defconfig+x86-board (gcc-10): 1 warning


Warnings summary:

    2    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unr=
eachable instruction
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
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section=
 mismatches

---------------------------------------------------------------------------=
-----
tinyconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
vexpress_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 1 war=
ning, 0 section mismatches

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction

---
For more info write to <info@kernelci.org>

