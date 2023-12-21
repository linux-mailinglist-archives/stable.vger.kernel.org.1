Return-Path: <stable+bounces-8245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DBE81B4C9
	for <lists+stable@lfdr.de>; Thu, 21 Dec 2023 12:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E87F1F24FC5
	for <lists+stable@lfdr.de>; Thu, 21 Dec 2023 11:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042F16BB26;
	Thu, 21 Dec 2023 11:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="WndblT38"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3807E6BB24
	for <stable@vger.kernel.org>; Thu, 21 Dec 2023 11:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5c6839373f8so464846a12.0
        for <stable@vger.kernel.org>; Thu, 21 Dec 2023 03:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703157585; x=1703762385; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6aYkuU6srMEAiAZIHjCcuiNeUXlXFp07W0DFP1zqdRk=;
        b=WndblT38knMEtJRVwvumSflv5iClzTvX6rHs8z7k16LbZCs/hx3SXHuD4au+KCs5aM
         fIcjPa6T4sfM7nrh900m49E7djRMj0v+iac6EahjdtlEBNOn2KX7CmIs1fnmwkM3izLu
         r3T/e+VSRXivUMD9DbSIRmCVlpOrXsyz30wBIzaUReLqBfxRashfmKpTJYBc91wlmWi4
         GQvwVZmegIjNcS0uhfwoF6z2bIOFpSBvSMH1VCCwgVVdjAgR2GIoUN561OYUxFBmWSHY
         kbQbOdEt+mZAGK6bBXZHEI/Htxe42anogDtl3IxVBn4wW6oHXc6LLFM/BiA1gAKetPnq
         XAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703157585; x=1703762385;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6aYkuU6srMEAiAZIHjCcuiNeUXlXFp07W0DFP1zqdRk=;
        b=NaPTFskFNy5jOTL1jgGYp/9uFpPiP5g6zxkiaB6lQegiX0Hr1CBqXVvILr9QZ/iNpK
         uYi6daOwIxHSmRgSYplzkPMqA2WPz+M5fevoPRAeJs+kNub9JgBcllE27DgXLpgtDEUy
         eBOTZ1VHcgofVmb1Zrlg5M2yVCoBJXZ9iiPTSxb2LtPmkdDYMxy1Y/5b/A/YKdFmpNQD
         Rq7SxF0Z0x07feIEH7wV85aBSElmf9EKB2iuADxtETliQtXL283jjOO1xQOqYE3C1I6b
         EwL2GySZaLdX2J4NLDUZdcUFgGImXQf6DNK0NYdUjfaUqLRo04JMIeEcXo8FeJvPoPCO
         zuoQ==
X-Gm-Message-State: AOJu0Yw/I9u7STwTAlXhEN490he27FhmPAEV63XYE6X8YNXB8W4Ylf/Y
	u4BcUHKCSSf0PdjRy2XSV9vn43ccJfyV6/75/ILUi4i/G/o=
X-Google-Smtp-Source: AGHT+IEavQXcbDj/FrgCFLQNMnC7wRQ1gluvTHijUFcs9/yGMaogg+jHaoJKMVRrbP09DilmSAcltQ==
X-Received: by 2002:a05:6a21:3284:b0:18f:9c4:d33e with SMTP id yt4-20020a056a21328400b0018f09c4d33emr614335pzb.46.1703157584954;
        Thu, 21 Dec 2023 03:19:44 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b13-20020aa7870d000000b006ce75e0ef83sm1400508pfo.179.2023.12.21.03.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 03:19:44 -0800 (PST)
Message-ID: <65841f50.a70a0220.4b917.37a2@mx.google.com>
Date: Thu, 21 Dec 2023 03:19:44 -0800 (PST)
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
X-Kernelci-Kernel: v6.6.7-168-g611edaf5fedea
Subject: stable-rc/queue/6.6 build: 19 builds: 0 failed,
 19 passed (v6.6.7-168-g611edaf5fedea)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.6 build: 19 builds: 0 failed, 19 passed (v6.6.7-168-g611e=
daf5fedea)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F6.6=
/kernel/v6.6.7-168-g611edaf5fedea/

Tree: stable-rc
Branch: queue/6.6
Git Describe: v6.6.7-168-g611edaf5fedea
Git Commit: 611edaf5fedea04df15f13c80a8d88ab76c9f6e9
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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>

