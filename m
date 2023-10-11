Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1347C46CF
	for <lists+stable@lfdr.de>; Wed, 11 Oct 2023 02:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344281AbjJKAkY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 10 Oct 2023 20:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344470AbjJKAkW (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Oct 2023 20:40:22 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD7B8F
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 17:40:20 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-690d8c05784so4893198b3a.2
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 17:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696984819; x=1697589619; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2uhA9ZJrpcP9YTl82P45ZY2EHZofBNn0ynRG5W1uwrs=;
        b=rTuKoMojLhHLdxvCVUumIreu0/a1hdJIeg1WcSqJLOoxpIgarrUeOhtvCdXZa3RSEv
         KzBIwnsPaXzjAzvEJVdgl+dMk0vMosCeNKHB5LsDCx9cBWrR41iinVHaUESfsZP259Me
         JwqdEXUsWec0dDEJJCGAxRAyuCYCCb7674QdE9pT1/slmLTTtGmeQoVDCCnk7mbEiqLI
         7GKlK0PnrNpr7jOPGNAevZOxOd1x+shppsxeadmns/sJuaMZWFAJCNJvJPQKP8E4iJPQ
         5/PR2fiZyjtrxzZWiLs34IpyyukDdXdGyRdiB8oJ5aw+B8VsgYL6kZiRWwUeAB/wl7KL
         xQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696984819; x=1697589619;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2uhA9ZJrpcP9YTl82P45ZY2EHZofBNn0ynRG5W1uwrs=;
        b=kvAh2vb/6LhCAXwx72at3xWNkFBjjAqunaWKxQ24Iemb9ksZxEoaJV48/dqA5SZeTu
         5uKzhIVlajaAX651o5+7eNmnl9rrtsSbrlLL74qrZmfmQdeoArjnQwMb0itdy6TnKXf8
         0dzKa64cep2AkYj0hTtZmNgeEkyRKvu2XvB6kTgugbjL+waWCtj8nXO2AyAS3pYpaUb9
         EFWm0+5aM5t93hWr41+8b4qmjUGF6+ddVEgH5ZKZLhw19I/fqoRP5F1M+J4rZs30RNaU
         nUPk7w0t/ULeGNhGMg9qf1DWRlonxs4avk+bJihFP4RScPnlr+owX2/+pJVY6wBjjmlW
         icrg==
X-Gm-Message-State: AOJu0YznqKr17wuALIoRyTYhlF6smZRyk1JihEf4p9YGIZ2mrgsW4Bh1
        cjxBWRkcM+n/FKb+us/BMTeZEf/UvCvjjO7Lqv2Y0w==
X-Google-Smtp-Source: AGHT+IHTp+VwJHVeQOAekUkbF+kKTM8pJKjHLSGpoG+9IXFx1Ibyf4LvGr5g4PE/SGVQLGiRgsUqaA==
X-Received: by 2002:a05:6a20:3ca5:b0:13d:d5bd:7593 with SMTP id b37-20020a056a203ca500b0013dd5bd7593mr19431742pzj.12.1696984819255;
        Tue, 10 Oct 2023 17:40:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t17-20020aa79391000000b00694fee1011asm8847034pfe.208.2023.10.10.17.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 17:40:18 -0700 (PDT)
Message-ID: <6525eef2.a70a0220.77f7b.784d@mx.google.com>
Date:   Tue, 10 Oct 2023 17:40:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.57
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-6.1.y build: 19 builds: 0 failed, 19 passed,
 1 warning (v6.1.57)
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

stable-rc/linux-6.1.y build: 19 builds: 0 failed, 19 passed, 1 warning (v6.=
1.57)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.57/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.57
Git Commit: 082280fe94a09462c727fb6e7b0c982efb36dede
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
