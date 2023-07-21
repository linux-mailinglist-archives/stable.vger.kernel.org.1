Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FBF75D165
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjGUS2f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjGUS2e (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:28:34 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA58530C7
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:28:33 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-668709767b1so1592919b3a.2
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689964113; x=1690568913;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k9J/Ki0iNowQXsTmQsI166jzwihICLM56acy/tldx3o=;
        b=ILW6kimF3q4UFRZNyeitkQhIgm9Vt1s99zxUvvi2RFU0ZGt3mth1/wo10Em4YlVAfW
         S3W+5L6+XlX0mmI17K/N7iD3DHwGxxYnst91fD6HcIKY1Np2me2jVTgp0uep+2hE87bf
         3uJGZNZ02e7EzMvoSx5b59YL3jZus93vraqJsnk3NMrTAvi/SD+Jvfb85YkkBTveP53I
         hsThpIQq/dm1DnNoNEUhhu6MXC2t140LdjUUq8NKOlSUBOhj85U1q24Dx78hvPhw2iNg
         f8FUql0idUsOnH0+lczda0O2GmhM+e7yTJU0b8sZmQ0hjCPT+tnzIWxp3yEPp5a5Oq3R
         Zdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689964113; x=1690568913;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k9J/Ki0iNowQXsTmQsI166jzwihICLM56acy/tldx3o=;
        b=PAfrPbPehcFUqSWRGvxycQdlD8gqQpABxgEb06P1DQRYzISjd+QvnywLqs532mvm67
         cHsRUlmm7oTXy0EKpd4225J6L78LVV811+rhqFvoyDLz6EprykkQ3DsuUOG0oy5NVjtt
         BlfArypPBG6cUWp6YU5Fe5UG32TnY9EOOxcqMcQ6vqfzDZ6EgSTrOe9Z7ApOTC6cSOJL
         yS8nEvHpclJksKj6VnVn0+309mkL8gUHVHnmWf/e21BN+/7M3na3SdFqLiE1tqVaikbg
         Kv0oFkxYW07izuPC5I0Yul3Zf0JL/UjMtWKC3IfuCYrA4y7um0ILtNN6c6gRWDz8Bctp
         SEHQ==
X-Gm-Message-State: ABy/qLb79RMLL1tRhZUAH/9mx94AgCNoWvnF2x7WeACeXpZh4pSNiCiS
        GyK4NRF3KOn6DJDaRSVWZg64aRxRC6/hOprF978=
X-Google-Smtp-Source: APBJJlGSwwVVr3UI8ZnwxMqni3RGkNNbDRX810rleU803ua/D9GQQ5yeOEmcY28/247eSr/QA8lG+Q==
X-Received: by 2002:a05:6a20:3a88:b0:12d:f1ac:e2cd with SMTP id d8-20020a056a203a8800b0012df1ace2cdmr1811164pzh.32.1689964112958;
        Fri, 21 Jul 2023 11:28:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902d38900b001b8b2fb52d4sm301596pld.203.2023.07.21.11.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 11:28:32 -0700 (PDT)
Message-ID: <64bace50.170a0220.5a93f.1180@mx.google.com>
Date:   Fri, 21 Jul 2023 11:28:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.4.y
X-Kernelci-Kernel: v5.4.249-278-g78f9a3d1c959
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-5.4.y build: 5 builds: 0 failed, 5 passed,
 11 warnings (v5.4.249-278-g78f9a3d1c959)
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

stable-rc/linux-5.4.y build: 5 builds: 0 failed, 5 passed, 11 warnings (v5.=
4.249-278-g78f9a3d1c959)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.4.y=
/kernel/v5.4.249-278-g78f9a3d1c959/

Tree: stable-rc
Branch: linux-5.4.y
Git Describe: v5.4.249-278-g78f9a3d1c959
Git Commit: 78f9a3d1c959657b597bceaaf963b5d918b642a4
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 3 unique architectures

Warnings Detected:

arm:
    imx_v6_v7_defconfig (gcc-10): 1 warning
    multi_v7_defconfig (gcc-10): 1 warning

i386:
    allnoconfig (gcc-10): 2 warnings
    tinyconfig (gcc-10): 2 warnings

x86_64:
    x86_64_defconfig+x86-chromebook (gcc-10): 5 warnings


Warnings summary:

    3    ld: warning: creating DT_TEXTREL in a PIE
    3    fs/ext4/ioctl.c:595:7: warning: assignment to =E2=80=98int=E2=80=
=99 from =E2=80=98struct super_block *=E2=80=99 makes integer from pointer =
without a cast [-Wint-conversion]
    2    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in rea=
d-only section `.head.text'
    1    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'
    1    arch/x86/entry/entry_64.o: warning: objtool: If this is a retpolin=
e, please patch it in with alternatives and annotate it with ANNOTATE_NOSPE=
C_ALTERNATIVE.
    1    arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x1c1: un=
supported intra-function call

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

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
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    fs/ext4/ioctl.c:595:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    fs/ext4/ioctl.c:595:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]

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
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
5 warnings, 0 section mismatches

Warnings:
    arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x1c1: unsuppo=
rted intra-function call
    arch/x86/entry/entry_64.o: warning: objtool: If this is a retpoline, pl=
ease patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALT=
ERNATIVE.
    fs/ext4/ioctl.c:595:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---
For more info write to <info@kernelci.org>
