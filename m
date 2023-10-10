Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C607BF008
	for <lists+stable@lfdr.de>; Tue, 10 Oct 2023 03:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378608AbjJJBGT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 21:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379287AbjJJBGT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 21:06:19 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B50AF
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 18:06:16 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6910ea9cca1so3723627b3a.1
        for <stable@vger.kernel.org>; Mon, 09 Oct 2023 18:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696899976; x=1697504776; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f3rtML/YG+d/rUXh065siv/d4JmZWRQOPcQo/Xq06PI=;
        b=mT+ga34M9cS8buUBl1gkRbDOmEbu1Rx+pjPJ9CToniMxSxhFkbLVsczZbBw75o6YKZ
         jrlCFppjRaQp9XZ+kBS6zx3xJ0JLqiv7nXpSkN3TLOS8IGv84ylLunLXe3hjzJZYV3Og
         5sZdIdRHaMBGzUaC3A1QcolhA9gm5ZfdsA4eUiGVJgkLL1T99h8D6sL1k6NfAJ/TUfxB
         Z9ilwmlsCmCRoQfwlDmD9fjm/OKU+R9UDX37GrIpfoMDaiyCCwxtjfMFj3pCwIyrYftu
         4PYF+/jhZ/qrMqpKxJhcXHn4rXmrMsKBEdqeMQNgjTWhSjVsXyi7hmpCjBNEQNmCHYWF
         bVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696899976; x=1697504776;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f3rtML/YG+d/rUXh065siv/d4JmZWRQOPcQo/Xq06PI=;
        b=FglRfuhMamSuwNgCXN5k9jSwKX2ij1+iDWGyvZbGzsgb7FKefHLChBOQ3oxoS7pkSd
         YytmiJOewDqVlfXWYapKoAJTw2pT+ogFkNyX117g+9M3oRQtQ3mjh4ucQRGo3X1YYUXT
         /MlYh7GsWBy9Jx3N0iXvHS2uK99/4uzrAInG/yhgj1CgvI3IoaInYMjlEMXJdJBPu3L4
         G9WxtwNi5rPXsMaAlEt5Dgu1LCqaR7oejipoLudmEXSWm3+0ZqzlST8r5iq9P/1S1Kl/
         E+s3TmUa5pf+xSOyhyjKcNZodR/1Mg0zoG061NHUzNZD4pEBpObQTqqSduqQQnLPikRL
         xXtA==
X-Gm-Message-State: AOJu0YxojLc6VWc390fA7x9OXsCxlA0ZGy+0qiiU/ibtyad38R0/v0TI
        AkbbCIYOoywf48SrHz9TVb494GXHADaL0pau2MeaJQ==
X-Google-Smtp-Source: AGHT+IEiY1MsSk/qPRpgf6U8WceU0JBk9RXEe5daM0E+jpK/D6Q5MgC32/fPnU48csbcov+amB1A/w==
X-Received: by 2002:a05:6a20:dda6:b0:135:1af6:9a01 with SMTP id kw38-20020a056a20dda600b001351af69a01mr12812847pzb.8.1696899975683;
        Mon, 09 Oct 2023 18:06:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q25-20020a62e119000000b0069370f32688sm7035510pfh.194.2023.10.09.18.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 18:06:14 -0700 (PDT)
Message-ID: <6524a386.620a0220.f8f98.1d78@mx.google.com>
Date:   Mon, 09 Oct 2023 18:06:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.56-163-g282079f8e4074
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.56-163-g282079f8e4074)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed, 1 warning (v6.=
1.56-163-g282079f8e4074)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.56-163-g282079f8e4074/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.56-163-g282079f8e4074
Git Commit: 282079f8e40746cc342a7dd12654e3af7de01823
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
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
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
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
0 warnings, 0 section mismatches

---
For more info write to <info@kernelci.org>
