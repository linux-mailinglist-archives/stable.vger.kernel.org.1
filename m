Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9035F7D275C
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 01:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbjJVXsv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 22 Oct 2023 19:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVXsu (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Oct 2023 19:48:50 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B736E8F
        for <stable@vger.kernel.org>; Sun, 22 Oct 2023 16:48:45 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso1916473b3a.1
        for <stable@vger.kernel.org>; Sun, 22 Oct 2023 16:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698018525; x=1698623325; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QuOseHNd2dEjLysZSSH1/Y88qvXevh9Nk774UuVHY8s=;
        b=Obak4GVcEod4coQYqo2hDdHDW049Fl208cUFJLLcjvHHH0n83Ca7A8D3YJzauSOrO4
         tqbV2HyZxHMyJpAR4aUqPF6nc0nLwsapZCfCXgoUbtPp5fo3tqbHEHGItDHuu1Iwp+2B
         rHH3y5PbdS1i4P7FUzAijdDOjBv5aZQsUDscxaszQ4XZJeL3FQSoyhaMYQmMdrW0Z6l/
         5KIH/Kbx5pECKahZQiC44CJZYG4iNdhxz8bqzIn8JP/oE5j1Bvuz7hLwUC4q3/UQ2Krj
         3X5TxbAmLL5/m7/6O+36l2WBkf4+ny6eMapre3Q+jnRDpxqdooOERQw4zvzi1DOSNLDz
         5U8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698018525; x=1698623325;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QuOseHNd2dEjLysZSSH1/Y88qvXevh9Nk774UuVHY8s=;
        b=OCi/0vF7UiDF9YFrL3jr7gfLO2zZvruxKLwE6VTIGo7ymfXGIY/yK777SmVkIHK0Us
         G5gbFNDq1lN2/6bB+ExUcWwysTVRUiFG4miYyXPhQKjDOhD/MA/PAHvp77rzv2zoBUq4
         5lSv6U899hABAuxAN2fHAqK0PPum8x8WFmEkxXW1Bg8HKaZo4cekF1gBDg7cLeT8NyPn
         dCbXmrw3NDHi1JLghWSENLlGUFJr6Lm8ClgfFJQD/9s9fYyfCrJ3qLekdpPR9Z/K17Zj
         Kd7zSwLuwQnyqC8YsR940ppzSTAwo8DjKnQVMV2bH2Gxvr5E8K2L/Mxv5iUwnRXJzPBz
         Rzjw==
X-Gm-Message-State: AOJu0YwZXEU9Ktvnyxftwu79hHWyZOBVY9L2j6SkKc/Gogyw9IUP+7WL
        ta2+xJ+jahDJEvEIEcEVgQcK0bc0WbF68BolDZA1kQ==
X-Google-Smtp-Source: AGHT+IH6qunbpDi+OQ+pZei9k9JLMVeLZefWdPpDu0k7wkm/strJDPae+mMqDXqzeFBvQcmLBHPxvw==
X-Received: by 2002:a05:6a00:1817:b0:68e:3616:604a with SMTP id y23-20020a056a00181700b0068e3616604amr10933675pfa.8.1698018524776;
        Sun, 22 Oct 2023 16:48:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b006b84ed9371esm5159571pfo.177.2023.10.22.16.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 16:48:44 -0700 (PDT)
Message-ID: <6535b4dc.a70a0220.13e1a.f5c6@mx.google.com>
Date:   Sun, 22 Oct 2023 16:48:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.58-336-g8056f2017920
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.58-336-g8056f2017920)
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

stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed, 1 warning (v6.=
1.58-336-g8056f2017920)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.58-336-g8056f2017920/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.58-336-g8056f2017920
Git Commit: 8056f201792097a9f1a4ad286326f00d7c2bd500
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
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
0 warnings, 0 section mismatches

---
For more info write to <info@kernelci.org>
