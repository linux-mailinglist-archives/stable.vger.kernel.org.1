Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAC17A62E6
	for <lists+stable@lfdr.de>; Tue, 19 Sep 2023 14:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjISM3W (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 19 Sep 2023 08:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjISM3V (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 19 Sep 2023 08:29:21 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C6CF2
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 05:29:15 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c43b4b02c1so26785475ad.3
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 05:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695126554; x=1695731354; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BNsNrbaAlmjBhH9/7tPB1ZiS8lVfvps0Tp83o37FhpI=;
        b=n9TOb+2wfbGVtDUq2oJjX3g06pNQljJUC8ov84dJDlApcLYxME3VEDmLxJ5p3XtXJ4
         cSFkzfp04IkK7dcHr9gaiwvJ/ZnbMJOWak+usNntFdfwiV4syVqXxRCNzXoSK/brKHUQ
         Jq5T1XkEGGQBDEqE7djNxvmIppgu2sY21To8NVGB086A0sWVkLTqSLBSITFKSMLLXbvY
         nbqEedn1XNN8KR75qdXYXYiAdxcFeDQMESH4TFgBSNktzVrcWCLUmAyoApMXdoxgSrnv
         LtqevgMYGw8WEZLVCQ/r1j700aGtwDD6Ur+D6mM5wEnv31RTS21BccUR6JW0uu6iRWoO
         RDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695126554; x=1695731354;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BNsNrbaAlmjBhH9/7tPB1ZiS8lVfvps0Tp83o37FhpI=;
        b=Bs7AByO0jQY4DsbNHXtDEFZXhG3G7IF225GHSOhNlsaYQ4I5xci34ZoAYkX7vVh4AF
         o8CIHz9Ygn1nORfPCXv1ddBKbXq//41VWPlbHxB2esyg1dH5GnEgqEvrerX58qla/VjP
         tsLoPIuQ1cVwLnLrCSSa4M5UqRiZWxCEnqYbg7r6pzMhSn6TcKbKznkGreD9n/FEtzrY
         MIsce75tGwSzPLs5k923P6NDhw0nOniNmmhteNbP3pRDgZew6lRFYwGmbv6EN8WewSaq
         CQGqy2HShsbhh8/SNWLLDEzUgz2H8oeqjvnBPvKVeU3UKWZhqVYHf6nMJrwf2QMo45N4
         XIdA==
X-Gm-Message-State: AOJu0YxyJRTrFrXnZa+hdy8K0kdjFWOgg8xqfSPId4jhGkwzcoPG6Edn
        HM2+8Sl6SlH2P0zEHIVnN4FO6AEbfW9uqJ//lm/10A==
X-Google-Smtp-Source: AGHT+IERvhhd53/E9v3Stc+G3tf94xW07A6zK/MVZjlWYoYTOdKN9Y3g2r9HVRSlDz4Ja3w7qdEKpg==
X-Received: by 2002:a17:902:b710:b0:1bb:94ed:20a with SMTP id d16-20020a170902b71000b001bb94ed020amr8572318pls.24.1695126554678;
        Tue, 19 Sep 2023 05:29:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902704700b001aaf2e8b1eesm9893418plt.248.2023.09.19.05.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 05:29:14 -0700 (PDT)
Message-ID: <6509941a.170a0220.b981d.1f8b@mx.google.com>
Date:   Tue, 19 Sep 2023 05:29:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.54
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-6.1.y build: 19 builds: 0 failed, 19 passed,
 1 warning (v6.1.54)
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
1.54)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.54/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.54
Git Commit: a356197db198ad9825ce225f19f2c7448ef9eea0
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
