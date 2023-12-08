Return-Path: <stable+bounces-5069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5BE80B05D
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 00:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56AFC281BCF
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 23:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B1E5AB88;
	Fri,  8 Dec 2023 23:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="xpzitPMX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE4910C7
	for <stable@vger.kernel.org>; Fri,  8 Dec 2023 15:04:25 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d075392ff6so20919225ad.1
        for <stable@vger.kernel.org>; Fri, 08 Dec 2023 15:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702076664; x=1702681464; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tG5BmlvAyz7a5HpEODvKah0ZJgkFAqWZEFjT6rB3z8k=;
        b=xpzitPMXz04BYkBjDBuR/1CPWlqpBSAX02t843mIgPw1V4Q3QoKcXxacxqUACCaecY
         2dQQaAR+RjFGfn4VUMmqgd1jXLpBHgwwK7iInbmskhdQBTDn2dei3YUjVYwD6RpMQiOq
         55M1GN8ZZeDOzoSy3TfQrVUQvaKC7IGIqbMtkLcsoO/h3X6yBg/h0jSee9z10NNYcm3e
         zGYRwIW8IkoNF14RXex8y3aOhWo3+fx/tSAmFYqEMVrgmkrrCoG/qmpeehnxpPD+Tmgz
         Z0c4Lb8ll02BXA/HbMR8rSIBiovcj4EcIuS0RoznP3jDyF9eX4zYHlfZnEdLzJl51KR3
         N02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702076664; x=1702681464;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tG5BmlvAyz7a5HpEODvKah0ZJgkFAqWZEFjT6rB3z8k=;
        b=F9iH38V5l/1CV0IPAOqduMwB/4Y/44ABqyXUCaFoYZC+d2rAfqGvO+iSUHoKx/suuw
         +JOLXLdzfokyahy7cI2/aJWA61uiMLznE0PHFcu2wtps8XMDuURso8ACTFjvZTNJgzNF
         4hlLpnDnr3cjbdZZfYh1Z29kfjKTrDOJdtsaXRdfwM2EzvRWsRkkDyM7JmC4SgRtUGJG
         X0T/dAtx2QCLUE/0ufzEPTujPME+C4WhPzK8WvbETuAeRz11IGzGC52eLUTs5mvL1jnn
         LwB933EGZUtoN2YGu8Gz4vc6Md9+cW6c5uT+adwJnJPWKIKebrypmrqBGg89LGnd5Jll
         +3Nw==
X-Gm-Message-State: AOJu0YysClACOnlIKQs1j20n7lhGg+jGDINz3+qI5GBntf68yVAdguyS
	pjiphLqdxZL+X7CQOx6/+oavE37Oe/Z2cntflFhwpw==
X-Google-Smtp-Source: AGHT+IFZqrLHj/+AYi0ZhK0qhO8eUpsdo+G1Y/vy3c4PXbgN8PNQJqUMsXIlP7L8IMg215QnrOOvjQ==
X-Received: by 2002:a17:903:24e:b0:1d0:af63:2403 with SMTP id j14-20020a170903024e00b001d0af632403mr1010652plh.50.1702076664578;
        Fri, 08 Dec 2023 15:04:24 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902d50300b001d0b7c428d5sm2222736plg.104.2023.12.08.15.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 15:04:23 -0800 (PST)
Message-ID: <6573a0f7.170a0220.9061a.8646@mx.google.com>
Date: Fri, 08 Dec 2023 15:04:23 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.66-15-ga472e3690d9cb
Subject: stable-rc/queue/6.1 build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.66-15-ga472e3690d9cb)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 build: 20 builds: 0 failed, 20 passed, 1 warning (v6.1.=
66-15-ga472e3690d9cb)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F6.1=
/kernel/v6.1.66-15-ga472e3690d9cb/

Tree: stable-rc
Branch: queue/6.1
Git Describe: v6.1.66-15-ga472e3690d9cb
Git Commit: a472e3690d9cb501cd5df9181c8135287f11badb
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

