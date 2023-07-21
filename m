Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F393175D55C
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 22:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjGUUJz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 16:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjGUUJy (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 16:09:54 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926F235A1
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 13:09:50 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b8b4749013so17249735ad.2
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 13:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689970189; x=1690574989;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4iiPFyp6n/ULi6UVSCAx7x5yoBEvDl1RU3OTXVvjLhU=;
        b=C731azBZJjfLld/AZdbC2j4hAGXJqAn/YKDm6y4zR2Mu9FLnrAQ6mF7aJypOCXIRk9
         Klaalnq3m9FDceVtSNev6H6bUsYVwDMW6ntn9iM1fl2+MjvdOZYExNGyBeh57wc3ykfj
         HWrW9zrHnhDxNciZQWgl2o0r8bkFZaN82v7W3pKMKn1BWbsBiRZ9O9Qu9PTsSHap7EKa
         17YF6p8z81BIlVPSAzunWg70fvZxwiKeGBPWkPLVz6seFonQgkJY4yFHAfcdA/3O/Sgk
         9ubb3s+QRMIY0cwOd/7nahBI+pzdz23f9l/cFCSkHXxzRzVDf5hrjvTJM6dzo0JrFege
         5IfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689970189; x=1690574989;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4iiPFyp6n/ULi6UVSCAx7x5yoBEvDl1RU3OTXVvjLhU=;
        b=engj9Yjf9hw0WNkO3v6DWhRi9R2GV+XVaEvAUeWJJ76RmPH9Xd/4BjReQcXZZEPjZs
         zcpGLckPGt8fixYeiKwW58A0ygbhtM9T7zXSMj3/BZbSNbNXcQUxAHw5CncVeycunRRe
         H0lAeku8A4YrGkmFd9Ie5SX7E4Pv+pNvlMRHC34PIFubtcAgMYZzNLaRFtlYTh6P463C
         8cZw9DsxYpfhOmUPscfoKMBwwkmdADYNMPpChY/pXC7H3wQEfWUDt1NsfHuC+MUwfYn7
         9i7fqxSonvBLNwS2QWoq99q7sdX5mRU/yRpph8xU+lHJLitgKrhXiyBEvahF3rXPMIrC
         3ODg==
X-Gm-Message-State: ABy/qLbs8C8cI/JHFAK4zMnU7SphHc2ZlMJOVQwr+g/Lb/9nmUm0WIBv
        M60+cSJ2BdHN8UR8jevv5o3Lvlf0NQIPIs7fzss=
X-Google-Smtp-Source: APBJJlGLYd/TXV7MBqr5713TneiaBiUboUNbHCMq13V4c/7a14B+/7E5uQmC7Yb/2dvugUHrC3MS0g==
X-Received: by 2002:a17:902:e844:b0:1b8:9461:6729 with SMTP id t4-20020a170902e84400b001b894616729mr3559471plg.2.1689970189560;
        Fri, 21 Jul 2023 13:09:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jh5-20020a170903328500b001bb3beb2bc6sm3923809plb.65.2023.07.21.13.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 13:09:48 -0700 (PDT)
Message-ID: <64bae60c.170a0220.8c53d.8345@mx.google.com>
Date:   Fri, 21 Jul 2023 13:09:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Kernel: v6.1.39-224-ge54fe15e179b
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-6.1.y build: 5 builds: 0 failed, 5 passed,
 1 warning (v6.1.39-224-ge54fe15e179b)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.1.y build: 5 builds: 0 failed, 5 passed, 1 warning (v6.1.=
39-224-ge54fe15e179b)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.39-224-ge54fe15e179b/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.39-224-ge54fe15e179b
Git Commit: e54fe15e179b2cc0f0587e2ef1549295ae7bc3be
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 5 unique architectures

Warnings Detected:

arc:

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
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
rv32_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section=
 mismatches

---
For more info write to <info@kernelci.org>
