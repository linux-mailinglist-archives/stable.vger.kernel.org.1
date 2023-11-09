Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0937E6A55
	for <lists+stable@lfdr.de>; Thu,  9 Nov 2023 13:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjKIMHJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 9 Nov 2023 07:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjKIMHJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 9 Nov 2023 07:07:09 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7E51BDA
        for <stable@vger.kernel.org>; Thu,  9 Nov 2023 04:07:07 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5bde80aad05so658736a12.2
        for <stable@vger.kernel.org>; Thu, 09 Nov 2023 04:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699531626; x=1700136426; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+44rslOXFzki1Gd7Wqf+k8jwDNIr8YkqF/tU/Zcmqjk=;
        b=lbva0VfkJjq3SK9m9MnbV75yQqJRhB9diwj7yt9BLXQoB27qEeajzjIvrmjtl6tNE0
         wpVRSWi8uwe3kaxs3fUSppsGBt6/tcZguyD95RCTn6BvvdnNRnWkBwqKabzhjGxYLR9n
         pK+DQA9hAYPd6qdLtUTORYjKN6587/C/lxd/LDmHvS+h9j2HxPdV9SfC784JNYi2WIE8
         M2jAd75LP0MbQM2gKZHmOJ3jZZd9j4xh2dnpicNAsDGW8LUdjfTw29PiyyIsg3XcazIs
         IWJiDIVp0eTLMsC8LAO8zDnzKc1eq8Pk3w7lqGCaGWbExhnInHvtoF4jqGjx/ibirOA+
         iFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699531626; x=1700136426;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+44rslOXFzki1Gd7Wqf+k8jwDNIr8YkqF/tU/Zcmqjk=;
        b=m12FkH7i5dqdImvO7XYXegtBNd7jHiFIO/vqs1URUnJaiV0V4g5uTY4FTxUYEPFQWo
         QBl2JVBeu8Bd4ImixQobeM3W4S3ue9tpBBh711SX7J1ENqebc3OCDnmBzuYpcW8Ncjwg
         POVBZFBwsZrrPngBdIAIxzstp9MX5t8Nyi5LaqCp9eM/3Izr5bemBmZFUhYxh08lio0t
         MbrSItaP0QVQz5BGv78R1ryq5u8k/GR/tWcaycZqtxBVO9sYVxCf/8XLcCdLXFzHfluZ
         nxSP+e6OjOVIMIMbm5RrZsulsvleKbBtkx0oVG9GIPcK6CkGiF2owx/gXcBi+etR3D9G
         gb7g==
X-Gm-Message-State: AOJu0Yxeg67VPXE3EDWO2uDNNiSsfj8QDVzJ/dbPWbDwDQyffYJZXvwu
        Z0Bm1gwHaCOqy9CbLUiuSEhhfKBEcaYDHT2g/eS6pw==
X-Google-Smtp-Source: AGHT+IHj1EQzau6cGpdtsqvaSA0TeOm28wR4EsRfZX6Dr+3VBI4tum4dWNeaiddKZ8b4BijyB1/o+Q==
X-Received: by 2002:a05:6a21:71ca:b0:181:7914:7b34 with SMTP id ay10-20020a056a2171ca00b0018179147b34mr5836040pzc.21.1699531626138;
        Thu, 09 Nov 2023 04:07:06 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j8-20020a170903024800b001cc2c7a30f2sm3386404plh.155.2023.11.09.04.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 04:07:05 -0800 (PST)
Message-ID: <654ccb69.170a0220.74f02.9e91@mx.google.com>
Date:   Thu, 09 Nov 2023 04:07:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.62
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-6.1.y build: 20 builds: 2 failed, 18 passed,
 1 warning (v6.1.62)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.1.y build: 20 builds: 2 failed, 18 passed, 1 warning (v6.=
1.62)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.62/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.62
Git Commit: fb2635ac69abac0060cc2be2873dc4f524f12e66
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

arm64:
    defconfig+arm64-chromebook: (gcc-10) FAIL

x86_64:
    x86_64_defconfig+x86-board: (gcc-10) FAIL

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
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warn=
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
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 FAIL, 0 errors, 0 war=
nings, 0 section mismatches

---
For more info write to <info@kernelci.org>
