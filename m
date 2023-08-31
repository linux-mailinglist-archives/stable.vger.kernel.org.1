Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6468E78EA55
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 12:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237246AbjHaKlV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 06:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjHaKlV (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 06:41:21 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B4ECF3
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 03:41:18 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1cccbd43250so343391fac.1
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 03:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693478477; x=1694083277; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KfNTk2jQjUPbDfL6g5my8kJ3OWYUtq2NBWSV084TheE=;
        b=pP1EYTy2EpQ0qIUfgmDpLXV1uP/C00OXrVUP7flzOFHVUCfemPn0Xp++MiKH9m3EZv
         roTM1oyTHjE8B0YunuBgfFdoGYTb1TvvWmWHLM5Ms7oOGZ+uA9WPJQ/fuJ/wKpJPs1ut
         QVg5hyQTaHTHrZh4rUrVuFE94eBmhFXodYBwcBnAGAwgEKNCPbI+wjOGs8N7nI3VVTvW
         PWJoxjpf2W6CqEnvrxpeDXAFYYVstodFWm2dw6Cl8R08xeIug7CXZ8GafJ+/Jh4NH7YP
         4mpC9cFssHDeGzNyeekccz+OzoXeXtuNoFLvCkNhu51Kn864yIyX45DSMt6PAD5UleJD
         1t2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693478477; x=1694083277;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KfNTk2jQjUPbDfL6g5my8kJ3OWYUtq2NBWSV084TheE=;
        b=UnV7ANbASTV/zs0H1RogSb8iofC3unaJKKbAo4+PokA/7Uq3XNkJq2tAqx1dfyQKBs
         NM2enjwDjL3qqgv1curXaPeirEFJ8zlGtD3Uk6kGdr5Gokg2I7+LKy1TNbClRsPXoqPi
         0j+grnD5wWKEQr/AcWwGZq5oDYL+DfH0weGcDo59h1a/uVFZws/BK7w4ZpUrEhYsAJ5B
         3lMWKZVzgFFmy8yCNwVhECiNWdngEml2095xPXHXnH7Xtq2EVw519O93Gh74QLiSCt/j
         vBFGSTbtZSYqw9VQgYWM0LVwA2fPN4PVyPR6OYyXCGZfqyYIGmTQ0PFea7d/eOHumSfh
         P+mg==
X-Gm-Message-State: AOJu0YzTY2SZ5ox9KkPsfj+BFEGGhZ4u3vnP1IWZmxy4IMbFF3Q1SGDc
        e0uCn39BdHGeLVcVH9lOetuWgjxwLm99zDfL4XY=
X-Google-Smtp-Source: AGHT+IGVK3R73acQxl9To9pnsre+8sLmZbLBwQtUx0OYLGuXqZhSs8KM7kbaNrQA8tPhUGIXQ4zfTg==
X-Received: by 2002:a05:6871:810:b0:1be:9a37:cf12 with SMTP id q16-20020a056871081000b001be9a37cf12mr4308220oap.42.1693478477036;
        Thu, 31 Aug 2023 03:41:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902b78200b001aaf2e8b1eesm976074pls.248.2023.08.31.03.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 03:41:16 -0700 (PDT)
Message-ID: <64f06e4c.170a0220.9bf06.1a35@mx.google.com>
Date:   Thu, 31 Aug 2023 03:41:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.4.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.4.255
Subject: stable-rc/linux-5.4.y build: 14 builds: 0 failed, 14 passed,
 22 warnings (v5.4.255)
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

stable-rc/linux-5.4.y build: 14 builds: 0 failed, 14 passed, 22 warnings (v=
5.4.255)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.4.y=
/kernel/v5.4.255/

Tree: stable-rc
Branch: linux-5.4.y
Git Describe: v5.4.255
Git Commit: 5eb967dd50a5a29952ab6e6b1ef4bf216cf1652c
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 6 unique architectures

Warnings Detected:

arc:

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
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section =
mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

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
