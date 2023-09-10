Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E44879A016
	for <lists+stable@lfdr.de>; Sun, 10 Sep 2023 23:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjIJVZl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 10 Sep 2023 17:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjIJVZi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 10 Sep 2023 17:25:38 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A401DB9
        for <stable@vger.kernel.org>; Sun, 10 Sep 2023 14:25:30 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68fbd31d9ddso261723b3a.0
        for <stable@vger.kernel.org>; Sun, 10 Sep 2023 14:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694381130; x=1694985930; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hv0EW+wx5fCVdCK6NQ8MqMB21weamjymscALrxur6G0=;
        b=Uuebx1pdfdesAm8XERF5XUIhJMQ5Fu1GKCV86Mgk6Lk9dJ0yEeoWzO9ec65BkVwsBE
         +S7wPUq+w20VoAGsQ18L6Q/VW+Bu1G5YAePxERSFa2Qmf0xE95ocSlpYtBBnfPx/lf/s
         svDAS3TmriOoD8XHNBEs9OhQR9ktz0e2UCm/P7S/GnJWcWPilISrcnk3gL3ZVLgFTx68
         fHwVDIaBOrTRyAHaDu04P0eq2Dit0f2wA3oUF6GorumQlWEX5KQXYR9GKQHbidZwrEaH
         QrRHGZr94Dfjn9kWqA3KzZu26JP9w4VG9BmVYiTe4kzZuMtWCowowa1NIdjFu2f49xB3
         lPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694381130; x=1694985930;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hv0EW+wx5fCVdCK6NQ8MqMB21weamjymscALrxur6G0=;
        b=xG4+xdwW1LmoAHGzvace8zmAXvEvhCz6DIPu+/HECEgH4QXUMw/xpmsk2MFhDi1say
         6+6lskXF62sqNS0+KBJdCRzdWGNAIi3uhZf7xuRS2pEISwXWeG9fKo4LVobV+K2FKDfM
         MX0TMBIUAoLqGKRFDacGGb4r2p34QttgAdw5sr3kyYXiKqaXcIR4zTCnVLK7A4vMQq75
         IpncDeHUWIAs5NFqaLIGxJje0PJSfoxhnMSTnv5VJtgy8qR672iRph1rgumXL1YPisvp
         98sngYHEdNS3DbEYMiOVmWyg9IKbQBY0byLNqf/F/lKtgRXE5Qo6MfLu7Si4BIO/hkbi
         S5uA==
X-Gm-Message-State: AOJu0YyXQLqLw2UQxmlJaQYshgrWbF0I+bK4jW8dKl5QrB5JS1WonBwP
        TYAKqz207OVJgU3kD/s5ng1rveTvuHbO5gAXuvM=
X-Google-Smtp-Source: AGHT+IFevY80UTLZR0wtf6UhA2cpGgSdV6hLsgoMQtqYtY+hp3tGddfvjb6SEVK6DKN15Bua18ZCEg==
X-Received: by 2002:aa7:8881:0:b0:68e:3ca3:1873 with SMTP id z1-20020aa78881000000b0068e3ca31873mr7405241pfe.31.1694381129659;
        Sun, 10 Sep 2023 14:25:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a23-20020a62e217000000b00686e00313easm4333251pfi.157.2023.09.10.14.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 14:25:28 -0700 (PDT)
Message-ID: <64fe3448.620a0220.d9a3a.9f98@mx.google.com>
Date:   Sun, 10 Sep 2023 14:25:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v4.19.294-195-g74d4cf010295
Subject: stable-rc/linux-4.19.y build: 19 builds: 3 failed, 16 passed,
 40 warnings (v4.19.294-195-g74d4cf010295)
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

stable-rc/linux-4.19.y build: 19 builds: 3 failed, 16 passed, 40 warnings (=
v4.19.294-195-g74d4cf010295)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.294-195-g74d4cf010295/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.294-195-g74d4cf010295
Git Commit: 74d4cf010295264686eb149fc430c2b36880a77e
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

riscv:
    allnoconfig: (gcc-10) FAIL
    defconfig: (gcc-10) FAIL
    tinyconfig: (gcc-10) FAIL

Warnings Detected:

arc:

arm64:
    defconfig (gcc-10): 7 warnings
    defconfig+arm64-chromebook (gcc-10): 7 warnings

arm:
    imx_v6_v7_defconfig (gcc-10): 2 warnings
    multi_v5_defconfig (gcc-10): 1 warning
    multi_v7_defconfig (gcc-10): 1 warning
    omap2plus_defconfig (gcc-10): 2 warnings

i386:
    allnoconfig (gcc-10): 2 warnings
    i386_defconfig (gcc-10): 4 warnings
    tinyconfig (gcc-10): 2 warnings

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:
    defconfig (gcc-10): 1 warning

x86_64:
    allnoconfig (gcc-10): 2 warnings
    tinyconfig (gcc-10): 2 warnings
    x86_64_defconfig (gcc-10): 3 warnings
    x86_64_defconfig+x86-chromebook (gcc-10): 3 warnings


Warnings summary:

    13   include/linux/pci-ats.h:70:12: warning: =E2=80=98pci_prg_resp_pasi=
d_required=E2=80=99 defined but not used [-Wunused-function]
    7    ld: warning: creating DT_TEXTREL in a PIE
    7    fs/quota/dquot.c:2608:1: warning: label =E2=80=98out=E2=80=99 defi=
ned but not used [-Wunused-label]
    6    aarch64-linux-gnu-ld: warning: -z norelro ignored
    4    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'
    3    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in rea=
d-only section `.head.text'

Section mismatches summary:

    3    WARNING: modpost: Found 1 section mismatch(es).

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
    include/linux/pci-ats.h:70:12: warning: =E2=80=98pci_prg_resp_pasid_req=
uired=E2=80=99 defined but not used [-Wunused-function]

---------------------------------------------------------------------------=
-----
allnoconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section=
 mismatches

---------------------------------------------------------------------------=
-----
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section =
mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 sectio=
n mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 1 warning, 0 section mi=
smatches

Warnings:
    include/linux/pci-ats.h:70:12: warning: =E2=80=98pci_prg_resp_pasid_req=
uired=E2=80=99 defined but not used [-Wunused-function]

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 7 warnings, 0 section m=
ismatches

Warnings:
    fs/quota/dquot.c:2608:1: warning: label =E2=80=98out=E2=80=99 defined b=
ut not used [-Wunused-label]
    include/linux/pci-ats.h:70:12: warning: =E2=80=98pci_prg_resp_pasid_req=
uired=E2=80=99 defined but not used [-Wunused-function]
    include/linux/pci-ats.h:70:12: warning: =E2=80=98pci_prg_resp_pasid_req=
uired=E2=80=99 defined but not used [-Wunused-function]
    include/linux/pci-ats.h:70:12: warning: =E2=80=98pci_prg_resp_pasid_req=
uired=E2=80=99 defined but not used [-Wunused-function]
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 7 warn=
ings, 0 section mismatches

Warnings:
    fs/quota/dquot.c:2608:1: warning: label =E2=80=98out=E2=80=99 defined b=
ut not used [-Wunused-label]
    include/linux/pci-ats.h:70:12: warning: =E2=80=98pci_prg_resp_pasid_req=
uired=E2=80=99 defined but not used [-Wunused-function]
    include/linux/pci-ats.h:70:12: warning: =E2=80=98pci_prg_resp_pasid_req=
uired=E2=80=99 defined but not used [-Wunused-function]
    include/linux/pci-ats.h:70:12: warning: =E2=80=98pci_prg_resp_pasid_req=
uired=E2=80=99 defined but not used [-Wunused-function]
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 secti=
on mismatches

Warnings:
    fs/quota/dquot.c:2608:1: warning: label =E2=80=98out=E2=80=99 defined b=
ut not used [-Wunused-label]
    include/linux/pci-ats.h:70:12: warning: =E2=80=98pci_prg_resp_pasid_req=
uired=E2=80=99 defined but not used [-Wunused-function]
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 s=
ection mismatches

Warnings:
    fs/quota/dquot.c:2608:1: warning: label =E2=80=98out=E2=80=99 defined b=
ut not used [-Wunused-label]
    include/linux/pci-ats.h:70:12: warning: =E2=80=98pci_prg_resp_pasid_req=
uired=E2=80=99 defined but not used [-Wunused-function]

---------------------------------------------------------------------------=
-----
multi_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    include/linux/pci-ats.h:70:12: warning: =E2=80=98pci_prg_resp_pasid_req=
uired=E2=80=99 defined but not used [-Wunused-function]

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    include/linux/pci-ats.h:70:12: warning: =E2=80=98pci_prg_resp_pasid_req=
uired=E2=80=99 defined but not used [-Wunused-function]

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 s=
ection mismatches

Warnings:
    fs/quota/dquot.c:2608:1: warning: label =E2=80=98out=E2=80=99 defined b=
ut not used [-Wunused-label]
    include/linux/pci-ats.h:70:12: warning: =E2=80=98pci_prg_resp_pasid_req=
uired=E2=80=99 defined but not used [-Wunused-function]

---------------------------------------------------------------------------=
-----
tinyconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section =
mismatches

---------------------------------------------------------------------------=
-----
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section=
 mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
tinyconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section m=
ismatches

Warnings:
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
vexpress_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 s=
ection mismatches

Warnings:
    fs/quota/dquot.c:2608:1: warning: label =E2=80=98out=E2=80=99 defined b=
ut not used [-Wunused-label]
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
3 warnings, 0 section mismatches

Warnings:
    fs/quota/dquot.c:2608:1: warning: label =E2=80=98out=E2=80=99 defined b=
ut not used [-Wunused-label]
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---
For more info write to <info@kernelci.org>
