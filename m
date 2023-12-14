Return-Path: <stable+bounces-6693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D8F81249F
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 02:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868BC1C20906
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 01:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DA865B;
	Thu, 14 Dec 2023 01:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="edqnseXY"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91777D5
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 17:33:19 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b9efed2e6fso4601271b6e.0
        for <stable@vger.kernel.org>; Wed, 13 Dec 2023 17:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702517598; x=1703122398; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2Hk3V1Frs2NBUkNKfipTQcAuXKtnavwBmBtx0EHOrTc=;
        b=edqnseXY4CasmqYo3sb+dK8rXLjmSQqleJ4X4bhlr861KL2/4ZKrrVYuIxLZPbDYWd
         lKWj17sj4CllWcydTobi1YOeHUxQmiWsmdZuQuqXvA8/6cBlDSrX9xL8dse0esgFByQA
         6cO7LyXkhiXw8AS+I1fSqXyQqUcfW/X78c8X3NPK+0jPvDx0kGSUk2p3ZKwb5vwWQWkK
         5sSHCxkEC4lr7W919NgC5G0eXNhtrKUgqXfds6ViWgmNz8vyPYAapn1fDKkdAEvgRYPf
         5rdiQ16CFHEc2rLIP9eCKPQJPZ1eB3V3xUAsNoiMHWbyYoc0MD03U+AWw1vQ5OIJufVl
         VKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702517598; x=1703122398;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Hk3V1Frs2NBUkNKfipTQcAuXKtnavwBmBtx0EHOrTc=;
        b=w8B+MAlCaSlr4kOtjwn8Lsg15tjAF+yMEQEqFApBVyoDwe4zQkcF2VgYnFBc7Q4n56
         ZauaDEAdCf6IipH75OnC36hNpCdf1yQLnJW2r3yMGELYMfDnCYGiJXsamAd2KXBsRUvQ
         On1U80ug4Zbl6OxezpMCyoT6o/PVkkCQVRk6y2Rz14kI5gHtW8kNHZ+gZQ3C3MBVfX0P
         j0LtDn1u21E14axefd2tiT/l4q9vjdnJ3vN4/+xnbFBhznA1oCmtujczzwTHV5zrNjAG
         IcIhGRI3PWL/QcVH1yGNpPHBhad6qtk8B3H45HqzPChARjSxJfDpdkzYvqlzodIWLa+t
         M1OA==
X-Gm-Message-State: AOJu0YwAiz2RvJrpVpDcxBf6z2TvSzuyAmy9c+t4FtpmICc7IqPfeUFs
	CsQ0/ypjNEw1AFV1/3BVz3vACuthKn03Y7OmV8h3EA==
X-Google-Smtp-Source: AGHT+IGRhyfsCB/HBwg/rQb+5NUnYrJIt17vsL9ccmW4VA/WVodgeys7Sth7YCJsc1e/5smCThu8OA==
X-Received: by 2002:a05:6808:1184:b0:3ba:82c:ab54 with SMTP id j4-20020a056808118400b003ba082cab54mr7310012oil.107.1702517598630;
        Wed, 13 Dec 2023 17:33:18 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id fw21-20020a17090b129500b00286da7407f2sm3143331pjb.7.2023.12.13.17.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 17:33:18 -0800 (PST)
Message-ID: <657a5b5e.170a0220.1fd19.c8c7@mx.google.com>
Date: Wed, 13 Dec 2023 17:33:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1.68
Subject: stable/linux-6.1.y build: 19 builds: 0 failed, 19 passed (v6.1.68)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable/linux-6.1.y build: 19 builds: 0 failed, 19 passed (v6.1.68)

Full Build Summary: https://kernelci.org/build/stable/branch/linux-6.1.y/ke=
rnel/v6.1.68/

Tree: stable
Branch: linux-6.1.y
Git Describe: v6.1.68
Git Commit: ba6f5fb465114fcd48ddb2c7a7740915b2289d6b
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e.git
Built: 6 unique architectures

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

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

