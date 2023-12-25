Return-Path: <stable+bounces-8434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1F181DDA5
	for <lists+stable@lfdr.de>; Mon, 25 Dec 2023 03:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF08B1F21C86
	for <lists+stable@lfdr.de>; Mon, 25 Dec 2023 02:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3647F2;
	Mon, 25 Dec 2023 02:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="aCtQ5SrU"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9780C804
	for <stable@vger.kernel.org>; Mon, 25 Dec 2023 02:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3ba14203a34so3521914b6e.1
        for <stable@vger.kernel.org>; Sun, 24 Dec 2023 18:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703472718; x=1704077518; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KXsJc6Y+9w0/xFpjM1rbjfbuaPQWRJTcxR9EzgJq2Hk=;
        b=aCtQ5SrULoc6OXZNAxNavv4tGkNoc8xVHo03HY9se5zkbhIc3E2RUCAuVNBF1MbPRw
         2koGkBFdXDHna2ClLqoKu9/+ik+iLH81ZuP3MlMvVCW0CdsTCWKVJsqDhS1rx+QkUXKX
         PWKXK/NvXroLYp1NbspvrCWummDtg3WuucSfJWWRIJ0GNpqqcFR4oncrdZTBpbB1Jowr
         Mdi7rMaT4hWc5xFYA873llIuC7obEW3RPGyziIlYKyXikzvlj/eDyLWgYDt/wbYR9flc
         V26QCc4BfhKJ72Wl4dTMJyCHHTOPErwsEAu2KjaHQYyuqEiifgdkIdWU7xVLtWIVsX+G
         cTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703472718; x=1704077518;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KXsJc6Y+9w0/xFpjM1rbjfbuaPQWRJTcxR9EzgJq2Hk=;
        b=gtPuvfnMDxjNMqSN5l0OqwGpACJBGoMbU4e9RYjnhWxvylZq4bp8RWZj4MxdpsIbl0
         l1oDQ+MZbPHT13PTCx7Y13m+6goJMpc9ztw4vU7TbJwlHrQbJt0PwE9SCL7opaBCGvgk
         tRKHp8pOk8oz1RV/88UkFez/s9wwsTIbf1UYrDEcRm+nXx6DEGEr7anhUiaWHcQt6QUr
         huX3yzuDoraC4icpb8tb8B8poI8jkVfjis+UsMTYWAzgpUs4C/spCYCvrOltweYYrLNO
         VNMlz/zi7Y8sFGt/lty/QeFSkNoaPDK8BJ2apnmO52BWEZWAu4GIrriZSdSFKPizn0XO
         JgGg==
X-Gm-Message-State: AOJu0YwqrLjX1w6nLsscy/nfiyeGy/3jrkmIsj26pxAdBkClJz0QFaGI
	KXE+e8VxuSsGWKk/dxAGu9nhhm0QAHqHmlDHXX38mjyTNTE=
X-Google-Smtp-Source: AGHT+IF8nljuujzmmxg42mVpGCjHNAWuXBoCYdCzRnSKwCjIoWb7f3aok7y6+L9pv/PiMDJX/sIETA==
X-Received: by 2002:a05:6808:178b:b0:3b8:b706:3a47 with SMTP id bg11-20020a056808178b00b003b8b7063a47mr7428318oib.74.1703472718245;
        Sun, 24 Dec 2023 18:51:58 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x9-20020a63db49000000b005ccf10e73b8sm6941086pgi.91.2023.12.24.18.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 18:51:57 -0800 (PST)
Message-ID: <6588ee4d.630a0220.be64e.1e35@mx.google.com>
Date: Sun, 24 Dec 2023 18:51:57 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.6
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.6.7-255-ga21961156b26a
Subject: stable-rc/queue/6.6 build: 20 builds: 0 failed,
 20 passed (v6.6.7-255-ga21961156b26a)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.6 build: 20 builds: 0 failed, 20 passed (v6.6.7-255-ga219=
61156b26a)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F6.6=
/kernel/v6.6.7-255-ga21961156b26a/

Tree: stable-rc
Branch: queue/6.6
Git Describe: v6.6.7-255-ga21961156b26a
Git Commit: a21961156b26a29f2e7852b29512c23c8c14cc17
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

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

