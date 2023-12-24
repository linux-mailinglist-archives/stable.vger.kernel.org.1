Return-Path: <stable+bounces-8416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7BD81DBAB
	for <lists+stable@lfdr.de>; Sun, 24 Dec 2023 18:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619D9281C60
	for <lists+stable@lfdr.de>; Sun, 24 Dec 2023 17:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000B2C8C7;
	Sun, 24 Dec 2023 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="y7qI4Pgm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0692D23CD
	for <stable@vger.kernel.org>; Sun, 24 Dec 2023 17:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6d9b51093a0so274426b3a.0
        for <stable@vger.kernel.org>; Sun, 24 Dec 2023 09:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703438154; x=1704042954; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jeH5QsZfkI4SJYJgiaDPu6CHm+UXs9X6lyHA5AViAYY=;
        b=y7qI4PgmXESiiRyi6f3h2xOAmLux3d+CGOpYYaHfQs+8U9PUgiotyv0NUWNWKnWb+l
         GxFni9uG5l3yUoZ7cmVLnqIQ5MygWd7jWJZD3bIiVdseNUExnik/Yuf5o+GJofcB5uBl
         RhSq/7dP4+OqheQD/P5fm+FByxTfNYNhLaYUvSxBeM174b877TK/jhbrU2sTDEDU27qN
         ID530Ij9QVoQcXMcOeu2PF1+tDj2tXvEciNjdVQPlc72mZ00CHcDgLRIRPwdz6npt2Ba
         riSgMHBfwnW4bJdligAAGSXxXUOQHaWubi323LHISRya1zD+YmWKYUdXdPzHLg4RwUIc
         85hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703438154; x=1704042954;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jeH5QsZfkI4SJYJgiaDPu6CHm+UXs9X6lyHA5AViAYY=;
        b=jRvTTrKmmF4GVqvWN20WtcJ+yOJfCM4YGD+w2sBETj1J/fjrU+rWToF0TZPo0P5PyF
         IGxTHGvyi6atAmS+Z8FgbvAxyherKNLpw4alOD/F4iqmoBvGSNbDuY8H3pJRdL3f1T/f
         lQkhg3I0V3xyCE7YA3ynbqf4/+mydpkSkEywbeqR8ydmKgPd9S33cIrYiKfOTh9yvReN
         ViCvPj6HzoooJC9I1sIQ1yf1OFPd5Td2RVGU33ZfdCp01Q/4nfYBhkEqI28axANX1wnn
         +fGtl6v3Q1Jihi4k8WO1by2pNg4t1uKUsycgBKa7nesNu3SnPT7alYvaKPLFkPRBm4V3
         Uvlg==
X-Gm-Message-State: AOJu0Yzl8UD7GBZqI0AFHfG9ZGYWJG0Uyo60TpomkiU8bBN1W9ssBuaT
	Tpvp1pMJS0CNOak7WuXYfRdMy57PM1Yq/A0hgGi6INzqI5w=
X-Google-Smtp-Source: AGHT+IE6l4sQZCb8ZbnxwJnHHmKBMF+9WoELCrOrg7poK528NPQjwsettkySNZcHHqOwRXVipjiZyg==
X-Received: by 2002:a62:e407:0:b0:6d9:9126:cab5 with SMTP id r7-20020a62e407000000b006d99126cab5mr4145412pfh.57.1703438154638;
        Sun, 24 Dec 2023 09:15:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l23-20020a62be17000000b006d45fc85962sm6660652pff.55.2023.12.24.09.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 09:15:54 -0800 (PST)
Message-ID: <6588674a.620a0220.10058.205c@mx.google.com>
Date: Sun, 24 Dec 2023 09:15:54 -0800 (PST)
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
X-Kernelci-Kernel: v6.6.7-247-ga9715522c0820
Subject: stable-rc/queue/6.6 build: 19 builds: 0 failed,
 19 passed (v6.6.7-247-ga9715522c0820)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.6 build: 19 builds: 0 failed, 19 passed (v6.6.7-247-ga971=
5522c0820)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F6.6=
/kernel/v6.6.7-247-ga9715522c0820/

Tree: stable-rc
Branch: queue/6.6
Git Describe: v6.6.7-247-ga9715522c0820
Git Commit: a9715522c08209efd55ae0f87268aedf54b78433
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

---
For more info write to <info@kernelci.org>

