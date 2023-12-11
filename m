Return-Path: <stable+bounces-5239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1781880C064
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 05:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 890941F20F4B
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 04:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA6F19BB8;
	Mon, 11 Dec 2023 04:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="V7aFozyG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB64CFD
	for <stable@vger.kernel.org>; Sun, 10 Dec 2023 20:39:31 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d05212a7c5so21190895ad.0
        for <stable@vger.kernel.org>; Sun, 10 Dec 2023 20:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702269571; x=1702874371; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=STHOHK+4Dvoz7R8z68a4PLobDN4NwZOe5hsbnljXy5I=;
        b=V7aFozyG3Fw16DqwjUnhlUfyO2hHhzBLi71uM3tGRMuZCUQ3v9sj0v8NVW7919XXXs
         zQyb5UstXltuN+NhzSmP5ybm4mI1euOTiIC8OsT4kagTPIPU9iDi3s9yI3MqRiwgHZfG
         a0PjDeATG2fQceqKbbMKrqo/Htte0cJDkcsyuyFlr2ZraSUd9hBpH0c+m3K+6jQcU7LB
         pBjZgC9cOXzSih7gyqXZrp+R48OmgcpspoCguYUm9QOCeDwDtuJxkxFGL7SSFmZ29KD5
         8Dj/ooL3g6DT0m5uj/UHp/FQOHqe4clKbEdshGUhAk82bhJj70Pa9pMZr4ZzsqJHcctm
         cw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702269571; x=1702874371;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=STHOHK+4Dvoz7R8z68a4PLobDN4NwZOe5hsbnljXy5I=;
        b=tz9RuluWo2DF3kIuzuUZO+h7u8dz8kl1GLg8l0+FbYD+2/KUd2syq7IYOWwL07Onm+
         bg+tRUh20AGAuTxM9vd7EZUwDqu0HAPVZbWhFRN9/02JfZdx/5CKzpTC7YPoJagnNe5p
         KSIK7ls3Gp6CK2CvatjoAvT4e7I8MO7SRSPHMeU2XfC4jFAUatK3WhNj8ov81UqnI0FQ
         3LFeQDxI4CZvHr9bRVQL+CWOw4daNYUDa5bxwMLozB4CGPpWnwmw4xIpdwBoTgq7rARg
         dzqimuvU3mpPVAabrUIwUNPgSyxOK0BI3+GWnXNhs4EskRMEicMCdAaOFEvxffX9yh28
         OT7A==
X-Gm-Message-State: AOJu0YwmBbsel8+erSfRKrf45kxsVWZj9Nkq3lE7iwFbyjMvOd3G/LKk
	EowA2J/tzl/BdvANVmbYk2Hm0uBLWNf/mGE0Tynwrg==
X-Google-Smtp-Source: AGHT+IFTOFDUG3NbNcEF1RShRG5gIy2STY43qtx/os+caKkSS7OsWmsw3OIl+IPOPpWRxUDI6Vkw0g==
X-Received: by 2002:a17:902:dacd:b0:1cf:8ebd:4eae with SMTP id q13-20020a170902dacd00b001cf8ebd4eaemr1260004plx.69.1702269570914;
        Sun, 10 Dec 2023 20:39:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902768100b001d078445069sm5508689pll.230.2023.12.10.20.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 20:39:30 -0800 (PST)
Message-ID: <65769282.170a0220.d4afa.f7cb@mx.google.com>
Date: Sun, 10 Dec 2023 20:39:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1.66-149-gd84f8303168b1
Subject: stable-rc/queue/6.1 build: 19 builds: 0 failed, 19 passed,
 1 warning (v6.1.66-149-gd84f8303168b1)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 build: 19 builds: 0 failed, 19 passed, 1 warning (v6.1.=
66-149-gd84f8303168b1)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F6.1=
/kernel/v6.1.66-149-gd84f8303168b1/

Tree: stable-rc
Branch: queue/6.1
Git Describe: v6.1.66-149-gd84f8303168b1
Git Commit: d84f8303168b150ca33fdfccf7faba4087b8b54a
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

