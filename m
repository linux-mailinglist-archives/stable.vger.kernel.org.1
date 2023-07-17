Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10AC756EE4
	for <lists+stable@lfdr.de>; Mon, 17 Jul 2023 23:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjGQVT5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 17 Jul 2023 17:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjGQVTk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 17 Jul 2023 17:19:40 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D9113D
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 14:19:38 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b8b2b60731so27264305ad.2
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 14:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689628778; x=1692220778;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D5Pm5jzSIKj/sD7KPDF/oEosvK9rF6VJX784upTlK9Q=;
        b=otN7GQT9vd3ibVv6n+3DDUsyBaM6PkKm9iew2PRVvKuauLiw5ZSYGf7hEYf2lp8Ch4
         7xvpWtbSat7ZkfCXR6iidQUNq3Hn5JWBvhYwZMIWLj2NfpMaWBwcDBZ6F8y2v2ZJgYI1
         cRVLIFRZthWIKBTeWRrU9STcHvjB6xXeCAmxqNpP7jxjmYJTPRApxiLBeOW/fRMOpJ+V
         odnnZ/2tCnQwWxgWwS4GAPjz2M/vukDKBRZ3bM5kPC9JLocMRo1NYfo55qUsD036Pkjm
         tz/Mawbl0I7C/PV6dz8G2ix0rfEJ+Xnlo9izUWp7vXWbIZNAXs3WZ8jdMr1hcPBoIp7h
         xC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689628778; x=1692220778;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5Pm5jzSIKj/sD7KPDF/oEosvK9rF6VJX784upTlK9Q=;
        b=P5T/6ccr5aCdb0v/TzRaY1RNm36hOmaK0Gn0XLdyFrzokhIT2cFZ75voQtBDKfI0mO
         5SrtjfQ1rzw86J5jgn8xi1NN5nAeuRK+Osx2cQ+LkrbfYEcGDWadXWJC2fGvo05aRKCC
         XIDMbHDKPUPdNAQutVwkDDHXlvtiKSJD1Szn3w7DGKXJo2Qttes+KlSaw91IfKZxHl/L
         yl2gEvaz8S3FIalLSBNANODOkdqXED6bqEywHVvYuBMQQ6Y4TNKaGG27TSYwOa2b4Nor
         xePNPYTSuJ5BqKvOb59ojN8H/0IkqUw5zhEIVM9ZyHMqXkPOF66vppWvWDvhg8JuuT6l
         p3VQ==
X-Gm-Message-State: ABy/qLbTLwfrwGzHsqHh+Y5sPDsFfGMNSPwB82eEmiF93RQkexKs9NsD
        8YpQiS0uVSezyuTx5PdXc3oHumeYCaTMd3aUjzc0+Q==
X-Google-Smtp-Source: APBJJlHjjtZlJp6rCwhmzprENiIfN0Yi4DCtksUfWXqdPl0kJf2cQ6FmI+qlWtYNuPrEeUorxjDWvQ==
X-Received: by 2002:a17:902:b188:b0:1b8:1c1b:125a with SMTP id s8-20020a170902b18800b001b81c1b125amr11387067plr.2.1689628777961;
        Mon, 17 Jul 2023 14:19:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bf6-20020a170902b90600b001b890b3bbb1sm301950plb.211.2023.07.17.14.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 14:19:37 -0700 (PDT)
Message-ID: <64b5b069.170a0220.dc486.1507@mx.google.com>
Date:   Mon, 17 Jul 2023 14:19:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Kernel: v6.1.38-590-gce7ec1011187
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.38-590-gce7ec1011187)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed, 1 warning (v6.=
1.38-590-gce7ec1011187)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.38-590-gce7ec1011187/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.38-590-gce7ec1011187
Git Commit: ce7ec101118789331617601d680d905c318b4ab6
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
