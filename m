Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861DF791327
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 10:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344639AbjIDITQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 04:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352525AbjIDITL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 04:19:11 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4A0FD
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 01:19:07 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68becf931d0so582290b3a.3
        for <stable@vger.kernel.org>; Mon, 04 Sep 2023 01:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693815546; x=1694420346; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o9C4RdO+CRjWyf94OKOfz5DbTZRm/YU7ILFxvi4dzWs=;
        b=RQj7LXYPNAeML/ZuIApeAO7cEMaj+YtvsYUP5/o5hmBx0SLwqpcItRIWY8npkEkWvP
         xHg9q5mVqIMADkAPzmxqesTZilUq6YvTqeaL2hZmky6I0Pd1WZwVsYpGJ/Rh0E84/ViX
         VKe46tyVTZKSY43Md7S6okphGHmqBs6U2h9Ru8r2pSB7hCpD6QGfWOhklp6v1iruDvrC
         EIdXang0NghmM8F/0ceBbl2SKKkn7ZY+BikKiLLUc7SX6Hgq8CPq/Dufm9eYSEyehoGi
         tzX3qm5naO0Q6EO1IhlPI/ngHHNN1vwquFreqM9574CHHrTIkyaQPzMOfEwcAFtKbXEV
         h2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693815546; x=1694420346;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o9C4RdO+CRjWyf94OKOfz5DbTZRm/YU7ILFxvi4dzWs=;
        b=BPSC2oAym9a77jihEur+Z0J885DuFL77kGG8kGqd1cNlee4Rrzhs4nS3YXR0aZhYq8
         JV8Qjy1nXz6dcbD86kTVir855EAO2PXWm6U0JZ+5yoDa3EJe1VGzPggbXrPLpjMMgSye
         aYLK8bOD7+0Cxtiaf+UlR9d87azyXwTVKdpW2jWEd1m0EUf9UM6BlavvE0Dt9jbsMrh9
         jCa4/6MVDC0/OTlZDcMeBIbXKDkVosf6dveYj4/QInS0/W0balJXxNJv/4yvJo9iCrEO
         JRHs8tVwRNmZc/ahjW8+AvYkS1IgtkbtPk6wggdoqrsnLTvq8PM1VE8NJVbkUXiD3dLd
         zX/w==
X-Gm-Message-State: AOJu0YzCte+m7y8YrrCiJyWHTIVWrgEaEotED0uhyYuSAvI/rNrtLNoj
        CgheYdnEUxO/2UBqW+2vmAbb7UYyEmaoCgfnuag=
X-Google-Smtp-Source: AGHT+IERzl81de4iZEk3OEiuLdDM7c5XHU04dIe+2T3qsM1o6h6E5QtQA8ARyHSYK2Us4yiiyrpmnw==
X-Received: by 2002:a05:6a00:2182:b0:68a:604f:420d with SMTP id h2-20020a056a00218200b0068a604f420dmr7361025pfi.3.1693815546330;
        Mon, 04 Sep 2023 01:19:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 25-20020aa79119000000b0062cf75a9e6bsm6780920pfh.131.2023.09.04.01.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 01:19:05 -0700 (PDT)
Message-ID: <64f592f9.a70a0220.2540b.d5a3@mx.google.com>
Date:   Mon, 04 Sep 2023 01:19:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1.51-32-g652995c5153b
Subject: stable-rc/linux-6.1.y build: 19 builds: 0 failed, 19 passed,
 1 warning (v6.1.51-32-g652995c5153b)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.1.y build: 19 builds: 0 failed, 19 passed, 1 warning (v6.=
1.51-32-g652995c5153b)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.51-32-g652995c5153b/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.51-32-g652995c5153b
Git Commit: 652995c5153b4cd24238c240f723afee17f8ce7e
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
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
0 warnings, 0 section mismatches

---
For more info write to <info@kernelci.org>
