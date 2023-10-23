Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301F77D3709
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 14:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjJWMmD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 08:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjJWMl7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 08:41:59 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7663102
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 05:41:55 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bf55a81eeaso20024635ad.0
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 05:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698064915; x=1698669715; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Bb5DTOVuLJuSkncgYRdtsVAOmnj+yRXfoucXQNzsGJA=;
        b=MtG67BaHHFTjNiEqeJlKWsMV0383GzPzEgGfBQ8MXj91WlGZZfCcFBZcUHwORF4WUs
         NNAPW5fKo5Xsh/CGYvbZkfw9zpQD4ozlR41Mjy14OlFQA/kyDnyRHehu0K1cjwPrMMrQ
         0OW/GdObT5L3CSHzBlEkv8Ty1IWvY5/poiWKNFCPSjcg33De0/tLBTjtrN+gObeOOLg0
         vCZ6NuAGLvQteJS5URydRSDqaVQXiGHw4fMfLgeaefOzQTlH0uld2Kx0h6x8ot7Ybykd
         Pq7KlOOOci4CFdwMQ42q4z2oASfw8qHPUrohAoEMGM7p/aMv5xYsqtcPn5TiB5/Acezk
         ADJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698064915; x=1698669715;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bb5DTOVuLJuSkncgYRdtsVAOmnj+yRXfoucXQNzsGJA=;
        b=B1zzzHDo4UahTqu7oQ/l+991+pqQmXJ0k7m3kgfQYs9ostRz68HxbDDURlP0F9e1m/
         nQCaHpRQeCr4M1f0Tn9NhO6MCyQaTFMyN09ZdSlb7vbrLus1ox1xgbXGdB/CrJ25UbGT
         KRFdpevMdXJUl22COyHUR/zbRIx4J8g3FXHE3jIM9sgvXsR2fdrpLkXRrI3Ehdke0nMB
         X154aS1EJPsYnCyb44NoWc8uOsB9jU/grjJcTsisAu8oW9Ziua6YQVhCSu9qRG9cW85s
         peuIePrb7jU2QGWontkEoI0CGthDu7vqtzPQ7LMJvFfRorr74ldTuLtDV6/vfyBy1IY2
         t0Dw==
X-Gm-Message-State: AOJu0YzKsKTI/7+dMQQlghkdQs/LcHS9bplNjunKarPePvVkfJVgHmkr
        5fV2Z2ByDGUFCNwM88quFn3Z1kHEDyIbAGzqDeHCrg==
X-Google-Smtp-Source: AGHT+IGj4d/ZLzk9UzzyMIUrxiYrWXpRqibHshpyOcRHc5bgJPBFQLua9KDz/d1Hd7VnVVrSfGOtxw==
X-Received: by 2002:a17:903:191:b0:1c8:791c:d782 with SMTP id z17-20020a170903019100b001c8791cd782mr7189523plg.29.1698064914633;
        Mon, 23 Oct 2023 05:41:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jk19-20020a170903331300b001c898328289sm5853086plb.158.2023.10.23.05.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 05:41:54 -0700 (PDT)
Message-ID: <65366a12.170a0220.22f20.0cef@mx.google.com>
Date:   Mon, 23 Oct 2023 05:41:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.4.258-124-gfe0f70cc261a
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-5.4.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.4.y build: 17 builds: 2 failed, 15 passed, 8 errors,
 30 warnings (v5.4.258-124-gfe0f70cc261a)
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

stable-rc/linux-5.4.y build: 17 builds: 2 failed, 15 passed, 8 errors, 30 w=
arnings (v5.4.258-124-gfe0f70cc261a)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.4.y=
/kernel/v5.4.258-124-gfe0f70cc261a/

Tree: stable-rc
Branch: linux-5.4.y
Git Describe: v5.4.258-124-gfe0f70cc261a
Git Commit: fe0f70cc261a97c0d8f20c9e24d2a92bffc1b2e5
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

arm:
    imx_v6_v7_defconfig: (gcc-10) FAIL
    multi_v7_defconfig: (gcc-10) FAIL

Errors and Warnings Detected:

arc:

arm64:
    defconfig (gcc-10): 2 warnings
    defconfig+arm64-chromebook (gcc-10): 2 warnings

arm:
    imx_v6_v7_defconfig (gcc-10): 4 errors, 2 warnings
    multi_v7_defconfig (gcc-10): 4 errors, 2 warnings

i386:
    allnoconfig (gcc-10): 2 warnings
    i386_defconfig (gcc-10): 2 warnings
    tinyconfig (gcc-10): 2 warnings

mips:

riscv:

x86_64:
    allnoconfig (gcc-10): 4 warnings
    tinyconfig (gcc-10): 4 warnings
    x86_64_defconfig (gcc-10): 4 warnings
    x86_64_defconfig+x86-chromebook (gcc-10): 4 warnings

Errors summary:

    2    drivers/gpio/gpio-vf610.c:340:2: error: implicit declaration of fu=
nction =E2=80=98gpio_irq_chip_set_chip=E2=80=99 [-Werror=3Dimplicit-functio=
n-declaration]
    2    drivers/gpio/gpio-vf610.c:251:2: error: =E2=80=98GPIOCHIP_IRQ_RESO=
URCE_HELPERS=E2=80=99 undeclared here (not in a function)
    2    drivers/gpio/gpio-vf610.c:250:6: error: =E2=80=98IRQCHIP_ENABLE_WA=
KEUP_ON_SUSPEND=E2=80=99 undeclared here (not in a function); did you mean =
=E2=80=98IRQCHIP_MASK_ON_SUSPEND=E2=80=99?
    2    drivers/gpio/gpio-vf610.c:249:11: error: =E2=80=98IRQCHIP_IMMUTABL=
E=E2=80=99 undeclared here (not in a function); did you mean =E2=80=98IS_IM=
MUTABLE=E2=80=99?

Warnings summary:

    7    ld: warning: creating DT_TEXTREL in a PIE
    4    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'
    4    arch/arm64/include/asm/memory.h:238:15: warning: cast from pointer=
 to integer of different size [-Wpointer-to-int-cast]
    3    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in rea=
d-only section `.head.text'
    2    drivers/gpio/gpio-vf610.c:251:2: warning: excess elements in struc=
t initializer
    2    cc1: some warnings being treated as errors
    2    arch/x86/entry/entry_64.o: warning: objtool: If this is a retpolin=
e, please patch it in with alternatives and annotate it with ANNOTATE_NOSPE=
C_ALTERNATIVE.
    2    arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x1c1: un=
supported intra-function call
    2    arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x151: un=
supported intra-function call
    2    arch/x86/entry/entry_64.S:1756: Warning: no instruction mnemonic s=
uffix given and no register operands; using default for `sysret'

Section mismatches summary:

    1    WARNING: vmlinux.o(___ksymtab_gpl+vic_init_cascaded+0x0): Section =
mismatch in reference from the variable __ksymtab_vic_init_cascaded to the =
function .init.text:vic_init_cascaded()

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

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
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 sectio=
n mismatches

Warnings:
    arch/x86/entry/entry_64.S:1756: Warning: no instruction mnemonic suffix=
 given and no register operands; using default for `sysret'
    arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x151: unsuppo=
rted intra-function call
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section m=
ismatches

Warnings:
    arch/arm64/include/asm/memory.h:238:15: warning: cast from pointer to i=
nteger of different size [-Wpointer-to-int-cast]
    arch/arm64/include/asm/memory.h:238:15: warning: cast from pointer to i=
nteger of different size [-Wpointer-to-int-cast]

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warn=
ings, 0 section mismatches

Warnings:
    arch/arm64/include/asm/memory.h:238:15: warning: cast from pointer to i=
nteger of different size [-Wpointer-to-int-cast]
    arch/arm64/include/asm/memory.h:238:15: warning: cast from pointer to i=
nteger of different size [-Wpointer-to-int-cast]

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 secti=
on mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 FAIL, 4 errors, 2 warnings, 0 s=
ection mismatches

Errors:
    drivers/gpio/gpio-vf610.c:249:11: error: =E2=80=98IRQCHIP_IMMUTABLE=E2=
=80=99 undeclared here (not in a function); did you mean =E2=80=98IS_IMMUTA=
BLE=E2=80=99?
    drivers/gpio/gpio-vf610.c:250:6: error: =E2=80=98IRQCHIP_ENABLE_WAKEUP_=
ON_SUSPEND=E2=80=99 undeclared here (not in a function); did you mean =E2=
=80=98IRQCHIP_MASK_ON_SUSPEND=E2=80=99?
    drivers/gpio/gpio-vf610.c:251:2: error: =E2=80=98GPIOCHIP_IRQ_RESOURCE_=
HELPERS=E2=80=99 undeclared here (not in a function)
    drivers/gpio/gpio-vf610.c:340:2: error: implicit declaration of functio=
n =E2=80=98gpio_irq_chip_set_chip=E2=80=99 [-Werror=3Dimplicit-function-dec=
laration]

Warnings:
    drivers/gpio/gpio-vf610.c:251:2: warning: excess elements in struct ini=
tializer
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
multi_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

Section mismatches:
    WARNING: vmlinux.o(___ksymtab_gpl+vic_init_cascaded+0x0): Section misma=
tch in reference from the variable __ksymtab_vic_init_cascaded to the funct=
ion .init.text:vic_init_cascaded()

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 FAIL, 4 errors, 2 warnings, 0 se=
ction mismatches

Errors:
    drivers/gpio/gpio-vf610.c:249:11: error: =E2=80=98IRQCHIP_IMMUTABLE=E2=
=80=99 undeclared here (not in a function); did you mean =E2=80=98IS_IMMUTA=
BLE=E2=80=99?
    drivers/gpio/gpio-vf610.c:250:6: error: =E2=80=98IRQCHIP_ENABLE_WAKEUP_=
ON_SUSPEND=E2=80=99 undeclared here (not in a function); did you mean =E2=
=80=98IRQCHIP_MASK_ON_SUSPEND=E2=80=99?
    drivers/gpio/gpio-vf610.c:251:2: error: =E2=80=98GPIOCHIP_IRQ_RESOURCE_=
HELPERS=E2=80=99 undeclared here (not in a function)
    drivers/gpio/gpio-vf610.c:340:2: error: implicit declaration of functio=
n =E2=80=98gpio_irq_chip_set_chip=E2=80=99 [-Werror=3Dimplicit-function-dec=
laration]

Warnings:
    drivers/gpio/gpio-vf610.c:251:2: warning: excess elements in struct ini=
tializer
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 section=
 mismatches

Warnings:
    arch/x86/entry/entry_64.S:1756: Warning: no instruction mnemonic suffix=
 given and no register operands; using default for `sysret'
    arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x151: unsuppo=
rted intra-function call
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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 s=
ection mismatches

Warnings:
    arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x1c1: unsuppo=
rted intra-function call
    arch/x86/entry/entry_64.o: warning: objtool: If this is a retpoline, pl=
ease patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALT=
ERNATIVE.
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
4 warnings, 0 section mismatches

Warnings:
    arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x1c1: unsuppo=
rted intra-function call
    arch/x86/entry/entry_64.o: warning: objtool: If this is a retpoline, pl=
ease patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALT=
ERNATIVE.
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---
For more info write to <info@kernelci.org>
