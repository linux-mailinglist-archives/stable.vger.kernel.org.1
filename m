Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FB37998BA
	for <lists+stable@lfdr.de>; Sat,  9 Sep 2023 15:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346125AbjIINsA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 9 Sep 2023 09:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjIINr7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 9 Sep 2023 09:47:59 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA14C12B
        for <stable@vger.kernel.org>; Sat,  9 Sep 2023 06:47:51 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3aa1446066aso2030080b6e.1
        for <stable@vger.kernel.org>; Sat, 09 Sep 2023 06:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694267270; x=1694872070; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EUfgFXh/dyKdmJ3NbEy2879TMj5iJokdG0E7LuJeg90=;
        b=jYHsi9kmrz4rTT3MTkI/XBOu7kBGi2QqFId4h7JDrptLKF7O+Ocnf6rnIbvcYM6qOX
         N75sNDsr+yI9Ehq1N8ttiZ+Ue7+A4G4UJUpHyQTR3m0SpejLJ/0wUqPMY2LOOhc4znZi
         XEWYkQ08j0TNzkWOoZbSnS2mgnxaEY0AnAc95xE/IrCfdXylUkv7SrH9sqNDmgk1dIRn
         hSx2a495upZYydfx+5ssxBmaERC/v1WjritsFY3RUkO1Lle7lGtIO0uubPihNe8hPAbi
         9kXVXPniEyIXe95aZaYtVd5e20UKT/idia9RSareMfRE+LrPZvO5+78sIgkCeJuCj+ZD
         tt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694267270; x=1694872070;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EUfgFXh/dyKdmJ3NbEy2879TMj5iJokdG0E7LuJeg90=;
        b=L8WY6JrBI6xNCDXgzJzfVoAbJDGNRPjOaOOYwIiEnJaPgMzDnzbRI6faSkxY0U+gNn
         PLlqLY9whjTcAu6IOWfxBLuhwys9jbqy8fvC39VUUxcvTa+9M9H5gFC8THsdb/DLS/cE
         7wSjY0IXDmrJoHHL2pmugtfZ0vrX6ai9E0OEQnZv274RvztU0tzoYgKQBLpki9B2J3A+
         rsLqcHhNBqK9LGG5bLlsF36TwpZoGX5cj425aqvQna9ivDl+tn3uEwa8vpLEGCRR6HQ7
         P2QhPA94Yw3Tayjd8pNd9uBQE9vn4ZuC9dLGLD+mo0WO48kKkPrCruL1eAk7sgKUWc5G
         1uXg==
X-Gm-Message-State: AOJu0YwFenOoW96puozNaUZLn89pGwUQagCStrDLCQtcqj7sBBEo6+k8
        2hLUMUMtWAo6/6y0OqUjIL2VBdhe7F0ZZVRI/Kc=
X-Google-Smtp-Source: AGHT+IGqUHW373DfHAH/nVMXXBq3voX0StMJuYfkvfxnTfaLVrYd5ya7692v3ZxA6d3ZWRMXBK8g8w==
X-Received: by 2002:a05:6808:3094:b0:3ab:7adb:7b35 with SMTP id bl20-20020a056808309400b003ab7adb7b35mr3989832oib.50.1694267270553;
        Sat, 09 Sep 2023 06:47:50 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e20-20020a656894000000b0056001f43726sm2354780pgt.92.2023.09.09.06.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 06:47:49 -0700 (PDT)
Message-ID: <64fc7785.650a0220.fcec6.4b7d@mx.google.com>
Date:   Sat, 09 Sep 2023 06:47:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1.52-547-g0480b8535974
Subject: stable-rc/linux-6.1.y build: 22 builds: 18 failed, 4 passed,
 108 errors, 19 warnings (v6.1.52-547-g0480b8535974)
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

stable-rc/linux-6.1.y build: 22 builds: 18 failed, 4 passed, 108 errors, 19=
 warnings (v6.1.52-547-g0480b8535974)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.52-547-g0480b8535974/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.52-547-g0480b8535974
Git Commit: 0480b8535974b203450ef268b4f9277c0aff3544
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

arc:
    haps_hs_smp_defconfig: (gcc-10) FAIL

arm64:
    allnoconfig: (gcc-10) FAIL
    defconfig: (gcc-10) FAIL
    defconfig+arm64-chromebook: (gcc-10) FAIL

arm:
    imx_v6_v7_defconfig: (gcc-10) FAIL
    multi_v5_defconfig: (gcc-10) FAIL
    multi_v7_defconfig: (gcc-10) FAIL
    omap2plus_defconfig: (gcc-10) FAIL
    vexpress_defconfig: (gcc-10) FAIL

i386:
    allnoconfig: (gcc-10) FAIL
    i386_defconfig: (gcc-10) FAIL

mips:
    32r2el_defconfig: (gcc-10) FAIL

riscv:
    allnoconfig: (gcc-10) FAIL
    defconfig: (gcc-10) FAIL
    rv32_defconfig: (gcc-10) FAIL

x86_64:
    allnoconfig: (gcc-10) FAIL
    x86_64_defconfig: (gcc-10) FAIL
    x86_64_defconfig+x86-chromebook: (gcc-10) FAIL

Errors and Warnings Detected:

arc:
    haps_hs_smp_defconfig (gcc-10): 6 errors, 1 warning

arm64:
    allnoconfig (gcc-10): 6 errors, 1 warning
    defconfig (gcc-10): 6 errors, 1 warning
    defconfig+arm64-chromebook (gcc-10): 6 errors, 1 warning

arm:
    imx_v6_v7_defconfig (gcc-10): 6 errors, 1 warning
    multi_v5_defconfig (gcc-10): 6 errors, 1 warning
    multi_v7_defconfig (gcc-10): 6 errors, 1 warning
    omap2plus_defconfig (gcc-10): 6 errors, 1 warning
    vexpress_defconfig (gcc-10): 6 errors, 1 warning

i386:
    allnoconfig (gcc-10): 6 errors, 1 warning
    i386_defconfig (gcc-10): 6 errors, 1 warning

mips:
    32r2el_defconfig (gcc-10): 6 errors, 2 warnings

riscv:
    allnoconfig (gcc-10): 6 errors, 1 warning
    defconfig (gcc-10): 6 errors, 1 warning
    rv32_defconfig (gcc-10): 6 errors, 1 warning

x86_64:
    allnoconfig (gcc-10): 6 errors, 1 warning
    x86_64_defconfig (gcc-10): 6 errors, 1 warning
    x86_64_defconfig+x86-chromebook (gcc-10): 6 errors, 1 warning

Errors summary:

    85   io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99=
 has no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=
=99?
    18   io_uring/io-wq.c:192:1: error: control reaches end of non-void fun=
ction [-Werror=3Dreturn-type]
    5    io_uring/io-wq.c:191:43: error: 'struct io_worker' has no member n=
amed 'wq'; did you mean 'wqe'?

Warnings summary:

    15   cc1: some warnings being treated as errors
    3    cc1: all warnings being treated as errors
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
32r2el_defconfig (mips, gcc-10) =E2=80=94 FAIL, 6 errors, 2 warnings, 0 sec=
tion mismatches

Errors:
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:192:1: error: control reaches end of non-void function=
 [-Werror=3Dreturn-type]

Warnings:
    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_device_reg=
): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expected "=
0,0"
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
allnoconfig (arm64, gcc-10) =E2=80=94 FAIL, 6 errors, 1 warning, 0 section =
mismatches

Errors:
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:192:1: error: control reaches end of non-void function=
 [-Werror=3Dreturn-type]

Warnings:
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
allnoconfig (x86_64, gcc-10) =E2=80=94 FAIL, 6 errors, 1 warning, 0 section=
 mismatches

Errors:
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:192:1: error: control reaches end of non-void function=
 [-Werror=3Dreturn-type]

Warnings:
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
allnoconfig (riscv, gcc-10) =E2=80=94 FAIL, 6 errors, 1 warning, 0 section =
mismatches

Errors:
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:192:1: error: control reaches end of non-void function=
 [-Werror=3Dreturn-type]

Warnings:
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
allnoconfig (i386, gcc-10) =E2=80=94 FAIL, 6 errors, 1 warning, 0 section m=
ismatches

Errors:
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:192:1: error: control reaches end of non-void function=
 [-Werror=3Dreturn-type]

Warnings:
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 FAIL, 6 errors, 1 warning, 0 section mi=
smatches

Errors:
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:192:1: error: control reaches end of non-void function=
 [-Werror=3Dreturn-type]

Warnings:
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 FAIL, 6 errors, 1 warning, 0 section mi=
smatches

Errors:
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:192:1: error: control reaches end of non-void function=
 [-Werror=3Dreturn-type]

Warnings:
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 FAIL, 6 errors, 1 warn=
ing, 0 section mismatches

Errors:
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:192:1: error: control reaches end of non-void function=
 [-Werror=3Dreturn-type]

Warnings:
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 FAIL, 6 errors, 1 warning, 0 =
section mismatches

Errors:
    io_uring/io-wq.c:191:43: error: 'struct io_worker' has no member named =
'wq'; did you mean 'wqe'?
    io_uring/io-wq.c:191:43: error: 'struct io_worker' has no member named =
'wq'; did you mean 'wqe'?
    io_uring/io-wq.c:191:43: error: 'struct io_worker' has no member named =
'wq'; did you mean 'wqe'?
    io_uring/io-wq.c:191:43: error: 'struct io_worker' has no member named =
'wq'; did you mean 'wqe'?
    io_uring/io-wq.c:191:43: error: 'struct io_worker' has no member named =
'wq'; did you mean 'wqe'?
    io_uring/io-wq.c:192:1: error: control reaches end of non-void function=
 [-Werror=3Dreturn-type]

Warnings:
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 FAIL, 6 errors, 1 warning, 0 sectio=
n mismatches

Errors:
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:192:1: error: control reaches end of non-void function=
 [-Werror=3Dreturn-type]

Warnings:
    cc1: all warnings being treated as errors

---------------------------------------------------------------------------=
-----
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 FAIL, 6 errors, 1 warning, 0 se=
ction mismatches

Errors:
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:192:1: error: control reaches end of non-void function=
 [-Werror=3Dreturn-type]

Warnings:
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
multi_v5_defconfig (arm, gcc-10) =E2=80=94 FAIL, 6 errors, 1 warning, 0 sec=
tion mismatches

Errors:
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:192:1: error: control reaches end of non-void function=
 [-Werror=3Dreturn-type]

Warnings:
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 FAIL, 6 errors, 1 warning, 0 sec=
tion mismatches

Errors:
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:192:1: error: control reaches end of non-void function=
 [-Werror=3Dreturn-type]

Warnings:
    cc1: some warnings being treated as errors

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
omap2plus_defconfig (arm, gcc-10) =E2=80=94 FAIL, 6 errors, 1 warning, 0 se=
ction mismatches

Errors:
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:192:1: error: control reaches end of non-void function=
 [-Werror=3Dreturn-type]

Warnings:
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
rv32_defconfig (riscv, gcc-10) =E2=80=94 FAIL, 6 errors, 1 warning, 0 secti=
on mismatches

Errors:
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:192:1: error: control reaches end of non-void function=
 [-Werror=3Dreturn-type]

Warnings:
    cc1: some warnings being treated as errors

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
vexpress_defconfig (arm, gcc-10) =E2=80=94 FAIL, 6 errors, 1 warning, 0 sec=
tion mismatches

Errors:
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:192:1: error: control reaches end of non-void function=
 [-Werror=3Dreturn-type]

Warnings:
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 FAIL, 6 errors, 1 warning, 0 se=
ction mismatches

Errors:
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:192:1: error: control reaches end of non-void function=
 [-Werror=3Dreturn-type]

Warnings:
    cc1: all warnings being treated as errors

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 FAIL, 6 errors, =
1 warning, 0 section mismatches

Errors:
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:191:43: error: =E2=80=98struct io_worker=E2=80=99 has =
no member named =E2=80=98wq=E2=80=99; did you mean =E2=80=98wqe=E2=80=99?
    io_uring/io-wq.c:192:1: error: control reaches end of non-void function=
 [-Werror=3Dreturn-type]

Warnings:
    cc1: all warnings being treated as errors

---
For more info write to <info@kernelci.org>
