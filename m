Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81872759C40
	for <lists+stable@lfdr.de>; Wed, 19 Jul 2023 19:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjGSRT0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 19 Jul 2023 13:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjGSRTZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 19 Jul 2023 13:19:25 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5FC189
        for <stable@vger.kernel.org>; Wed, 19 Jul 2023 10:19:17 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-66767d628e2so4775722b3a.2
        for <stable@vger.kernel.org>; Wed, 19 Jul 2023 10:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689787156; x=1692379156;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jh42tsdISO9/UzjH7/8mVZyOXK6A27D8NFnbbkhYrAo=;
        b=4XxrrkJJ8Vzx+v9PPq7i3ZAzFAYnKTrOIr69+HpwHrgOpZpADnoEpLixphXAa06EqH
         oTMimrm2CxORc9NrAb7BcSclbGSLfwWagPOeXYwMvYa+T4N7hmSQF+yMHwZ1PbO/6vAK
         QXvcrPX95f/1cHkp9tvuMI4m557ETgvyXWev92h+bCflElz19ynpkOXvpkzsjHS39hRB
         jOAn9cZ755JSxDkkJm6ow8DzbPXZiRwQK8by5Tk0gIMdP7Se+5xgDVEmkbKuwGmB62eH
         4DnGxHXPOAimNZIoqNufz7SjvCc2u5MaJnasWMM5kspC/GmwQY9oJAi7LZ9J1C1JENiG
         L40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689787156; x=1692379156;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jh42tsdISO9/UzjH7/8mVZyOXK6A27D8NFnbbkhYrAo=;
        b=TeK+E8Nr9Whr1X8LCJgPl6pWyx89K6pDhB/uGppMuBV1PkpotLYSw4S9XEHvjPHA+K
         9dt3hIbLnZWoYbMTdPk43K2NElrWFE9nL80fedJxE0uP0cmaxskdwTQPA5hBz9nPfliN
         lOMzGPmeoFdVWa+GGLV7cmOJAcR/kyry1fvz0/szOtpjaY7hUu2nTBFIzgYB6wDBBklq
         Rg8pYHhtezlGQpAd3YeSYTBGukAv0K2b0idGhcoQLWOwIXJ2q2cSjt8XKtMQ8HFcsPGE
         hLNhBvWal7cJmttI09jFx3SfTRJBcfLk8exohmxwpaVefMKPzE4242afwkp5R8Q7Ru24
         V48Q==
X-Gm-Message-State: ABy/qLZba1YMjtJ2yUYcfvTqUMpM8EltDlBXATgDcmkZRA4GrCx+m1Oi
        /u5CCf5/Uy2BgDCgLWpgFqKPL925hDLcmVvxHsIhww==
X-Google-Smtp-Source: APBJJlF+8ICw2cA0knoOu82P0vACeGwSY5ZVxWVVXM1JixDT9QTKRqn+naaGsso1AAcHBnqWs/4Jmg==
X-Received: by 2002:a05:6a20:9147:b0:134:409f:41f4 with SMTP id x7-20020a056a20914700b00134409f41f4mr2915258pzc.24.1689787156347;
        Wed, 19 Jul 2023 10:19:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e16-20020a62aa10000000b0063f00898245sm3621695pff.146.2023.07.19.10.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 10:19:15 -0700 (PDT)
Message-ID: <64b81b13.620a0220.59dff.76a7@mx.google.com>
Date:   Wed, 19 Jul 2023 10:19:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Kernel: v6.1.39
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-6.1.y build: 19 builds: 0 failed, 19 passed,
 1 warning (v6.1.39)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.1.y build: 19 builds: 0 failed, 19 passed, 1 warning (v6.=
1.39)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.39/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.39
Git Commit: a456e17438819ed77f63d16926f96101ca215f09
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
