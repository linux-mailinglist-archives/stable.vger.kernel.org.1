Return-Path: <stable+bounces-7898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 418E9818561
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 11:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8A691F2393A
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 10:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1337B14263;
	Tue, 19 Dec 2023 10:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="m4p/0qW3"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8CE12B7D
	for <stable@vger.kernel.org>; Tue, 19 Dec 2023 10:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3b9e2a014e8so3507106b6e.2
        for <stable@vger.kernel.org>; Tue, 19 Dec 2023 02:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702982264; x=1703587064; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SFHHy5X1Quq92rJwT9pFxjUVHRzyKcc+5XfNoLY09KA=;
        b=m4p/0qW3Udd1M+YvFkp2QsrPF4GNjMAnr/nY6rXwIud2SlKvRzAobR6uzy7YZDHuKu
         ZXc9DOnpHcCkxi/mFPFhNmHIuTXSfSStSpX5mLljDkzXWLVCVwq7RpwseSqKmGjPeBrO
         ahQjVa/VGbmx+AGDX/1kxoHPXxuo9ebHFgclX0QGeoxqwQo7JlVPOlPEigsVcpwj1x6p
         6G3AqpvKagK76dPVoTxrUNI2MB7fYdoQ3GAVOkpPJaqbR0I+nVYCJMSK2AlN55CMDLnG
         NViYcYkfMwhjV54yw14dmrl446N4mPLe0t4gTLQYYKjrUOYwYagmhGb943uAEGsxwd+Q
         ykvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702982264; x=1703587064;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SFHHy5X1Quq92rJwT9pFxjUVHRzyKcc+5XfNoLY09KA=;
        b=YtmuxvDFhuSfBKNPnhnTp9ZGt3avWabXaXu/efg40Ya7qCjbcFbbuzmBeef4N5ETJd
         S2v8Jl3V5FYLz6o+o0vK9DBqJ5nXH+UC3Scl+xb8UXFca/4lXrK1EvYlJf3ZJ9if5UJ3
         CcaLTsTG4r/SKYkbNL6OhLpNhs3I9iqJJhGzmABlwWa9PDh3zL1QO5I8UzpQAO0IlpDa
         Z8YEEgt2GUbP+iB+UVYmNvU/Dbzi/3iFQni3/M/B+775etGinvoF5oQKgIgPEuxYaJzr
         P5BYA8S+M06iKkHexrPUJdgT5f7JCnhL+X292hsFOxnCWSscJZk/sM1Mda8nnCk0G8zK
         Wbcw==
X-Gm-Message-State: AOJu0YzCMJQRFUIAOiXc+8y4ZrSbuTa1bFTashd1WyKfRA2Rwlp5bLwz
	oLLi3R/stCoonkb6uynH0FR66OY24MP9+7Vr2IE=
X-Google-Smtp-Source: AGHT+IGPtQmJBh0Oc1Mt2GjBmZiQ+x6XU7md98zAWaUZEMGkiv9ZdkATyKvZLmCrXc14rmkW64jt5g==
X-Received: by 2002:a05:6808:640f:b0:3ae:16b6:6338 with SMTP id fg15-20020a056808640f00b003ae16b66338mr763313oib.3.1702982264689;
        Tue, 19 Dec 2023 02:37:44 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id fk1-20020a056a003a8100b006d40f44dc03sm5593986pfb.11.2023.12.19.02.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 02:37:44 -0800 (PST)
Message-ID: <65817278.050a0220.53539.ca7e@mx.google.com>
Date: Tue, 19 Dec 2023 02:37:44 -0800 (PST)
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
X-Kernelci-Kernel: v6.6.7-166-g323633885756
Subject: stable-rc/queue/6.6 build: 19 builds: 0 failed,
 19 passed (v6.6.7-166-g323633885756)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.6 build: 19 builds: 0 failed, 19 passed (v6.6.7-166-g3236=
33885756)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F6.6=
/kernel/v6.6.7-166-g323633885756/

Tree: stable-rc
Branch: queue/6.6
Git Describe: v6.6.7-166-g323633885756
Git Commit: 3236338857560191c131dea50bc39fd3e4b784ad
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

