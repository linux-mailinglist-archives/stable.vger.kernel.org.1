Return-Path: <stable+bounces-2614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA62C7F8D2B
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 19:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D82421C20BB8
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 18:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B123328377;
	Sat, 25 Nov 2023 18:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="P1mRpUI8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562F8BF
	for <stable@vger.kernel.org>; Sat, 25 Nov 2023 10:38:07 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cfbda041f3so1961355ad.2
        for <stable@vger.kernel.org>; Sat, 25 Nov 2023 10:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700937486; x=1701542286; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pIjU1t6VGSYBRd1/6soSu/COmh1Xnr50/01fpM1xg74=;
        b=P1mRpUI8ZERcadLQlDP6JtF5qaOkYu82OHXiOA49XtfW1B4LBaipp8ugWWdkknSM7v
         eUABPt4l5fAkrj5mk2jvkV1q5u5WG0OOlk2ZY5erhJXv3cFD+2oNlIxDdtNYaxCr0+Nu
         kYEtSX082ZUBxi0rJQI3SYShfhn4BW91jUkcA0emHsPQ7Xukr8Beto+EzqDndbSI7kXH
         qTbN8XCMEoieLiIXyRurEicB8V5jR3RG9LZRa0CQFwAVLmyu/f0HPoRLDWvrB7gmu78T
         S7mEJKtQqg7hVzTCfSIlQhlxKq/EBN15bfmOQ1ZGASjZa02GOH1R7s9zv8nEOYq3IuDr
         356g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700937486; x=1701542286;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pIjU1t6VGSYBRd1/6soSu/COmh1Xnr50/01fpM1xg74=;
        b=oSGDDPh3MTHJilXqi3VAkD7uHZcjfO0XwWiPd2n5E00irUSPMZ4j5QY1RUM50W6H5x
         jlw+djfUZMSNUM0Kl3BgjDtQRRlzTMIP6/Kt3c5EywElnHlGkPPuMCDnhGaZAnhAVnNc
         2zlt5y2HoWCbtYRIgXNhTxYwQDUSpbtR1DlrcvYO8uGUaVEA+n6iVqL2U0iw1pcV8kJV
         ACAdix2f9vJ1dtXxMZW0O2u8NyM97uXpTZdqVg6ASSCkA8QSKA2s2nJYLR/ygWcuxhZm
         ixdeoc7nO232Sy3/n/U4syLQcQrwREovlilW1HJAr22f2deCGQj/4VmHt/+sWv6eOHID
         HFkQ==
X-Gm-Message-State: AOJu0YzQGTnvhz166QGuU+HsKqXUw6F196tqBARB3XJbS0iEpftsulan
	Kdgj5/w5XQq38ef1TvTCSNdi2lnnK6vbqmbOL9Q=
X-Google-Smtp-Source: AGHT+IGhCCHBCJSPPqaSHi7rxP9sXsbZuaD4sapALaEYxHcnR/zYGRpcxQMAa63ragtDqzkWoAoGTA==
X-Received: by 2002:a17:902:e749:b0:1cc:7f53:c190 with SMTP id p9-20020a170902e74900b001cc7f53c190mr9524245plf.51.1700937486274;
        Sat, 25 Nov 2023 10:38:06 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p20-20020a170902ead400b001ae0152d280sm3527082pld.193.2023.11.25.10.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 10:38:05 -0800 (PST)
Message-ID: <65623f0d.170a0220.90ede.83d4@mx.google.com>
Date: Sat, 25 Nov 2023 10:38:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.63-369-g4cad21545d49d
Subject: stable-rc/queue/6.1 build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.63-369-g4cad21545d49d)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 build: 20 builds: 0 failed, 20 passed, 1 warning (v6.1.=
63-369-g4cad21545d49d)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F6.1=
/kernel/v6.1.63-369-g4cad21545d49d/

Tree: stable-rc
Branch: queue/6.1
Git Describe: v6.1.63-369-g4cad21545d49d
Git Commit: 4cad21545d49d4e1b3721aa0489c85600627deb9
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

