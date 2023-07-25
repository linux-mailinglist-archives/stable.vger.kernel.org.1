Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8427604FC
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 04:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjGYCBg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 22:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjGYCBg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 22:01:36 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CE710EF
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 19:01:34 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-666eb03457cso2807339b3a.1
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 19:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690250494; x=1690855294;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9vMJjs+GbWNX9ueLF5j0KRZjYkxmFZkrgAzls/TgZwo=;
        b=cQxsysWIUGFoYhBfgajZxEnxPfq0hL/DHm9NhRqJ9ckTV/JH22XMHbg2MZVWA1UFGo
         9ymZDgjIqlmzZID9rR2QQT/4xhXibEsk+JgvZSJQiUc/3bX8KjmdBi4TPuYUy41sf3+U
         /j7l6uB2rxNDCScZLy5TipuO2yKMbCPv4ZThKn3g7WCBoMLCSwk5xnXfjcyHlq4FZ0ST
         yhhKzInp/3JnMwcH/KfBgtFawR29jGOLjey42JbR2EbDS2DsyPCwhq91oYNI3+JlmDMT
         ep+B9qloAOBesfz3J/Ylsyo9oesL7/g/6BOqx2nOlIg9FCkoi5EGF+oVE4TmNlaO//U8
         u4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690250494; x=1690855294;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9vMJjs+GbWNX9ueLF5j0KRZjYkxmFZkrgAzls/TgZwo=;
        b=KFhtZwlLnbA6a70nEbUm1JJ28+a9jDtnFUW0Fu92e7kBMC+8Pfy+gcD9p0QKucTuso
         ZR/IxCCJEBQt2xItcHGOPy4J+R2TXcDH9vRFIpDadkwbMA9gWlPyyGELaF7OW3i8WiwJ
         K/BygxVIWqAPb1XEBnQserQdhuHUL1eCKbEaR92QBjulw8mgYmt5Ra0WsBTPLrMP7MPK
         dnFe6wTJREj8E1eAywcdBhpCTCjm2xEvGX+Ypmnz2NvLxbMqOUPGogZ+bHgq0JJK5CJl
         6SK5jgdEVTX6r8nNunupvNdhTsSUoKYU9FWRDGiOoOFhlu7kGAZdpoZYzEopTSDUyOsM
         yLwQ==
X-Gm-Message-State: ABy/qLbyBLuBnmcTf4buqzwYo43PVPhq914I/HY5h5ya20K+kGXjBM7e
        TTs4hAd80jv7Z7+c79yNqaJNLxMHkQ1yHq1B6LCAXeQO
X-Google-Smtp-Source: APBJJlF9fby6i0BdNvYdNS9RO0nDCyBZvNvIJUuBDyMpwtvDCstodyqBMoi8G8HkwkIZbwvxToHtcQ==
X-Received: by 2002:a05:6a00:1911:b0:63d:3339:e967 with SMTP id y17-20020a056a00191100b0063d3339e967mr7920816pfi.19.1690250493776;
        Mon, 24 Jul 2023 19:01:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f9-20020aa782c9000000b00679d3fb2f92sm8326693pfn.154.2023.07.24.19.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 19:01:33 -0700 (PDT)
Message-ID: <64bf2cfd.a70a0220.ccd5f.e7fc@mx.google.com>
Date:   Mon, 24 Jul 2023 19:01:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Kernel: v4.19.289-218-g1cf0365815540
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-4.19.y build: 6 builds: 1 failed, 5 passed,
 8 warnings (v4.19.289-218-g1cf0365815540)
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

stable-rc/linux-4.19.y build: 6 builds: 1 failed, 5 passed, 8 warnings (v4.=
19.289-218-g1cf0365815540)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.289-218-g1cf0365815540/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.289-218-g1cf0365815540
Git Commit: 1cf0365815540b3e2db00b630d9519430a31b3bc
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 5 unique architectures

Build Failure Detected:

riscv:
    tinyconfig: (gcc-10) FAIL

Warnings Detected:

arc:

arm:
    multi_v7_defconfig (gcc-10): 1 warning
    omap2plus_defconfig (gcc-10): 1 warning

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

x86_64:
    x86_64_defconfig (gcc-10): 5 warnings


Warnings summary:

    4    fs/ext4/ioctl.c:583:7: warning: assignment to =E2=80=98int=E2=80=
=99 from =E2=80=98struct super_block *=E2=80=99 makes integer from pointer =
without a cast [-Wint-conversion]
    1    ld: warning: creating DT_TEXTREL in a PIE
    1    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'
    1    drivers/gpu/drm/drm_edid.o: warning: objtool: validate_displayid.c=
onstprop.0()+0x6a: return with modified stack frame
    1    drivers/gpu/drm/drm_edid.o: warning: objtool: validate_displayid.c=
onstprop.0()+0x0: stack state mismatch: cfa1=3D7+112 cfa2=3D7+8

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
    fs/ext4/ioctl.c:583:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    fs/ext4/ioctl.c:583:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    fs/ext4/ioctl.c:583:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]

---------------------------------------------------------------------------=
-----
tinyconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section =
mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 5 warnings, 0 s=
ection mismatches

Warnings:
    fs/ext4/ioctl.c:583:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]
    drivers/gpu/drm/drm_edid.o: warning: objtool: validate_displayid.constp=
rop.0()+0x6a: return with modified stack frame
    drivers/gpu/drm/drm_edid.o: warning: objtool: validate_displayid.constp=
rop.0()+0x0: stack state mismatch: cfa1=3D7+112 cfa2=3D7+8
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---
For more info write to <info@kernelci.org>
