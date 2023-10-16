Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A83F7CA4FF
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 12:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjJPKPJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 06:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPKPJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 06:15:09 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68844B4
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 03:15:07 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bdf4752c3cso23695855ad.2
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 03:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697451306; x=1698056106; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ElYEcnSQHRMqEuLmFYNcqzZfwb6nrhYk8LR1GQu3lt8=;
        b=vzDNq042v0NImG06AEk2bdqGWRc+MHWYB0cQoQF0+SyzrpvCTlZvA56rB8ilXh6ORx
         2GaK7iUGZnmP26pNKf+wRcmr6RBrraPgP0nZIS05nko/NcAxjeMj8b5jVeC9/HPfyzuK
         fcAXRt9bhU6Pe4E5Dl45rzT/k4fFGUUAOftJhyIOOIDKLaZgGMgzZzrYwHTWJQtWyFo2
         CJskgSBzzeRjFQztkmy1N6bIvUDRvMxWAfd1uJ2kURpsLiOCcsZEk7N4jpSxOSGHAbpr
         O9Wz0KIxR95WFnT7bcZ1+9+j5j3GwWF2KwghISCH280HiAYsdLz5AfVIYxi1LKSqZY9Y
         gFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697451306; x=1698056106;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ElYEcnSQHRMqEuLmFYNcqzZfwb6nrhYk8LR1GQu3lt8=;
        b=HPt8/kE3Cfcy8SdUvHqQb+BuDwYSAHWJ+n5DscTDWLs1kX5rHr7cvYRdUaCKSMRcWi
         8PhHYiDJRdpBvP19RXDoKkV/f0AznKG1j3st2ARvyTYJAcMa2e1hZsmxCA9uZnec32ea
         1bku+dQpYDebcf3a0TQNiWoiyJ7cdHMweE+5snN9X55fKzuIsxQ60fKFY8UxAwQ4ga9M
         dr5C7/4wh69b7x5DPXDhOBdX/AqeJSJA4Nr3MKtPrHgFw6oQHoarD9RGQVNxmqB+jr+H
         S4txa3frcHwAoVz9Si0FeaAWMJEXj87x963GDgGMswc3XdpmBkH/YjyXV1dTbRWt7Ymj
         KJpA==
X-Gm-Message-State: AOJu0YzVEWEpZ4IKy0q5+rFfmUpBXCo9F7AsWdkkPcoe9wyeUGxCXiNs
        r3ZZkeXq6j4gVEIfTkil7HMehRo6qysUu7l5Z000lw==
X-Google-Smtp-Source: AGHT+IFIIDEIg/3WYx9jSZhsdTVZtMrSnHbcN9iMYMliGH0VIh5HSG4uHi42WL0ieG3Og41gH17JMA==
X-Received: by 2002:a17:902:ca14:b0:1c9:ca02:6451 with SMTP id w20-20020a170902ca1400b001c9ca026451mr10128325pld.39.1697451306428;
        Mon, 16 Oct 2023 03:15:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i18-20020a170902eb5200b001bdeedd8579sm8089982pli.252.2023.10.16.03.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 03:15:05 -0700 (PDT)
Message-ID: <652d0d29.170a0220.3b24d.7e3e@mx.google.com>
Date:   Mon, 16 Oct 2023 03:15:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.4.258-44-ga8161789be4b
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-5.4.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.4.y build: 17 builds: 0 failed, 17 passed,
 26 warnings (v5.4.258-44-ga8161789be4b)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.4.y build: 17 builds: 0 failed, 17 passed, 26 warnings (v=
5.4.258-44-ga8161789be4b)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.4.y=
/kernel/v5.4.258-44-ga8161789be4b/

Tree: stable-rc
Branch: linux-5.4.y
Git Describe: v5.4.258-44-ga8161789be4b
Git Commit: a8161789be4b3c1f382b228bc928546869ed480d
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:
    defconfig (gcc-10): 2 warnings
    defconfig+arm64-chromebook (gcc-10): 2 warnings

arm:

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


Warnings summary:

    7    ld: warning: creating DT_TEXTREL in a PIE
    4    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'
    4    arch/arm64/include/asm/memory.h:238:15: warning: cast from pointer=
 to integer of different size [-Wpointer-to-int-cast]
    3    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in rea=
d-only section `.head.text'
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
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

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
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

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
