Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4156079A54B
	for <lists+stable@lfdr.de>; Mon, 11 Sep 2023 10:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjIKIDK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 04:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjIKIDJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 04:03:09 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BA9BB
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 01:03:04 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6c09f1f9df2so3244131a34.2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 01:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694419384; x=1695024184; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+CH+Y8NlafVFHpb7npglWMhXLDZ63X5FPbO9HGFTVis=;
        b=vM9HeTVGsuEDFeVVsoLfbZYW9wNRjnpDHItG6h5uqsbK29hDAVfKentaAOuNPoKcAK
         iTt/RDs9YuvH1Snbc2H8P4XZCZRitR2Cqu5FvQSQbftrAheSIDr7lWsgnBOx+8Onbrmx
         4uqxlcxAGMf3FjI2NXtzUe/4dp4nOlUBNycxtCkS1YTB8p5VZy3rPzENjPRJqY0R+F8G
         JBuEyIba993Dv2Wl2e6e538mPiDj1Y+aX1EhobSW3fbC7rIJT/2CnBp2tPKl25ropLF0
         pHOd9V6ETxwsQMS87IKqDwIeLxjaUSNucGlKtlEh3WZ31Yjus0v+Zz/2pC6g88ymjrZv
         PwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694419384; x=1695024184;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+CH+Y8NlafVFHpb7npglWMhXLDZ63X5FPbO9HGFTVis=;
        b=Yob4rN9PbxddKpxyONtyiBpW6ZHMrWeLkxX2EanDLO4EBMOFacbRRdYM+B5X3RKHHO
         NI/b8Pdc+p8a22PXqm67fcUHu5Cbdg4fT1l7nVAsD7go5CxnMEGgJPMOSPGVb4TjY/0R
         5h/uT/c0NfE9LtB45IrBTkXOpbPb3+wQTELRU1Rp7TTEBc+E7fyuTrC7/3I3qkVDhDLX
         GTeO+dGbs+F5QMOKitgcUZc6NhSyw8rW9LNXHeuP5a5bqMJj5p2HZUCYMLPD8xNAUd2g
         rpdUFiX4NG/HG6e/u2eia5LQYWWcIGNzutuJm1SnRB0JfEx4obcn4VoAyA63WDa7Rupa
         5t8Q==
X-Gm-Message-State: AOJu0YwDViObVAj+5BfSZaXxVwlYlIhOdfI0UGY1EtcW0nXCBV3/AgbS
        ZFsHweBRIM0UvETk99LrK6sUEBOo4yOkiEMsRmI=
X-Google-Smtp-Source: AGHT+IHx+2iLXppSOGOFNH1uENJeOgIhCdeXY3Zck/Fuelz9ygyza83usiOS7n1Dw7YzgIc/h00tKg==
X-Received: by 2002:a05:6830:14c5:b0:6bb:1c30:6f3c with SMTP id t5-20020a05683014c500b006bb1c306f3cmr10058837otq.0.1694419383802;
        Mon, 11 Sep 2023 01:03:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id cw23-20020a056a00451700b0068fd1683234sm554068pfb.47.2023.09.11.01.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 01:03:03 -0700 (PDT)
Message-ID: <64fec9b7.050a0220.74cac.12eb@mx.google.com>
Date:   Mon, 11 Sep 2023 01:03:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1.52-601-g0d9da1076cc2
Subject: stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.52-601-g0d9da1076cc2)
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
1.52-601-g0d9da1076cc2)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.52-601-g0d9da1076cc2/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.52-601-g0d9da1076cc2
Git Commit: 0d9da1076cc25b7a8a82a39ffc1719b5be735ee8
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
