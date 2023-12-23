Return-Path: <stable+bounces-8399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0665F81D56D
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 18:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68DF282CFD
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 17:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FE111C8A;
	Sat, 23 Dec 2023 17:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="O4m4e9pj"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152E212E47
	for <stable@vger.kernel.org>; Sat, 23 Dec 2023 17:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-35fe9a6609eso7997665ab.2
        for <stable@vger.kernel.org>; Sat, 23 Dec 2023 09:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703354028; x=1703958828; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qmTFuHGqJJwsiF8+nIVxOrd5QGRLywj5j47JJeI5Wq8=;
        b=O4m4e9pjPocW0Zp9MfytfdM4zUtwbiJKLy/THKHQcJgbO9q7vmUPO6WT1V3crsW+68
         vU1UmuhKHcAs+L8KjJy2/FVE57KPWlHCV6U1IOsqpUXOIWkOWaD4jJkt9NzKDw/7LjPc
         NbdGQTcUnJIKI1KmTMf9CtpeDzmP3CYAqpGQdv01paHUedo0pHWOYT26x8nanIuRVz7X
         n9d4YV2+oTgSC5b+Cl2qaAfWxf7P00eTpJMXUPnv4kMHl0Qzf8BTlAN8pD+8NsCO+vYw
         P4JYUM+sgc6y+uYdSj6RpIGSokN/u8969txcEuLf3FpdaCexrCsFL2W5uwkBKREruaPI
         1RBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703354028; x=1703958828;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qmTFuHGqJJwsiF8+nIVxOrd5QGRLywj5j47JJeI5Wq8=;
        b=NmgT435/uGbWupmoLKnW/T6BZxFj2hsgmVMUzgiffFf/hMnxOFf/K6ideQZgEEkOxH
         G1OP2E7GWWA8VSvljl9ijwBrAJDwsTZfa7+D7piog5j9C1ZHL7rKtIoEGBjmWqnsAfvm
         E1UPkSFuBc1dMOtVpufiyb/6tR0XH91V7T0jgGrUrA4/JwDtf9RkPLT9cUKSoy6qZLAH
         YhQGxhv7PABDiI1661stWKBbZ2R1bCSqWo9glRGzzo/jsmj04oGS7Al+vM8Rf4r+6F8K
         4RoKwD2yIeyTQwiF5d+xhc4yDH626mdr/0/KtocP0DJyAo+uIjA+KfXE7HXTRx8CnkUX
         Q3mQ==
X-Gm-Message-State: AOJu0YxlVyzAhJ3f5f1yTfasxwJvn3zLa7MT+DqRA+ReHUMC0vlrE6n9
	QiRd1INaY9G6JxiVVodscCm1FH91lYu2nhLN+knM3iwSXzM=
X-Google-Smtp-Source: AGHT+IFgqM6+5KqoOHlK05MZ4l+3jmceSJ+ISbMrwfujfVqth+GvK6NnpYumt5a1zq0t6pMmnkyV7A==
X-Received: by 2002:a05:6e02:1885:b0:35f:a3ec:a309 with SMTP id o5-20020a056e02188500b0035fa3eca309mr5094392ilu.115.1703354027776;
        Sat, 23 Dec 2023 09:53:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q17-20020a170902dad100b001d3f42edb4dsm5352914plx.294.2023.12.23.09.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 09:53:47 -0800 (PST)
Message-ID: <65871eab.170a0220.f06c2.fca7@mx.google.com>
Date: Sat, 23 Dec 2023 09:53:47 -0800 (PST)
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
X-Kernelci-Kernel: v6.6.7-246-g9ddf911049886
Subject: stable-rc/queue/6.6 build: 20 builds: 0 failed,
 20 passed (v6.6.7-246-g9ddf911049886)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.6 build: 20 builds: 0 failed, 20 passed (v6.6.7-246-g9ddf=
911049886)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F6.6=
/kernel/v6.6.7-246-g9ddf911049886/

Tree: stable-rc
Branch: queue/6.6
Git Describe: v6.6.7-246-g9ddf911049886
Git Commit: 9ddf911049886afac1c06696073380e3233b6233
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

