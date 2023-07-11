Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABB774FB8A
	for <lists+stable@lfdr.de>; Wed, 12 Jul 2023 00:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjGKW7Z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 18:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjGKW7X (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 18:59:23 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EF010EA
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 15:59:18 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b89600a37fso32567205ad.2
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 15:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689116357; x=1691708357;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=afb8uHjRGcFw4aSaE/pMhXr84PNyJ7lZsHux8czrdy0=;
        b=bItZtCgadf+sJjqGJfojqPKsk2DcmblsOtqfEfo9JDeNZ37w6EbIDrpZbrg9ZurHOx
         nfpQHOXtd7TsD57cgbms4Am6lzQJT7FqiJMNM7BVOacYcZgx1kJduiTOLVnGSZIY4iDX
         C8vtrb47ofjY+3pZhmnV61IAT9vMiV9CA7IzrubQ/yu/x4vO/nNRVf1AdxY/ILyZtZrp
         RL6NU0Wg9qFesBce+dm6uxUXJi/Ye/I8MWjdhke41SVNuxhMxFUBHA2+WcE1rjAyBKXZ
         wYjlAyCU4srkXr9Xv1NtuFlboajBwnA2qnDUx1yl1YHdsoUaVsE+ZDf8aw87N7miBA85
         7/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689116357; x=1691708357;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=afb8uHjRGcFw4aSaE/pMhXr84PNyJ7lZsHux8czrdy0=;
        b=hmgB3Z/STy04iHnGn2oV69ew2Vvu5WNzgx8Yq7bwhzbXpEeOakrKGR6/9OBmlGfcPq
         cPfR9D8GKISriBwtZ17r/16TFLAME6cfFXRVqlRdSdCMvrTyHDrf3i/PGS/CWIYfyAIu
         NbSzqGbI0QSJNwi8GTCi63L43LH/BDFt6iq4steKSAnfUCjqaYBsoWoJ22jRLpOgTkKy
         r2rTFsDJFllzKYTrAfrgz/KlaJcqjdGPl5W23yyxozl+f9IKBXefJ8sXq4qBlWjkGzsd
         vbzDt/Y3rA3UNQdQEHgiR2oNPD5xnhbMtjsGMcusk+AFZccRG3xWu6XAfJekeIPhpRvx
         o4UA==
X-Gm-Message-State: ABy/qLb+HEhBsl/zPmuQ9rEH6gXAGOnxgJjpmKgjCsY7i4GDqCvUsmr3
        SwT78PgUroVfrN8eID+QkAPBL5NdIHeq8wCumqQV+A==
X-Google-Smtp-Source: APBJJlHWVtNMzqwMGGM4HVbnN6HFE8zy1tPtnUhB7iTcDhUW2/kkSFSOjnJbSI3ek6w9CEkRSkcMhQ==
X-Received: by 2002:a17:902:daca:b0:1b8:902c:f8e8 with SMTP id q10-20020a170902daca00b001b8902cf8e8mr17520319plx.60.1689116357420;
        Tue, 11 Jul 2023 15:59:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x21-20020a170902ea9500b001b03f208323sm2448689plb.64.2023.07.11.15.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 15:59:16 -0700 (PDT)
Message-ID: <64addec4.170a0220.40e91.5f30@mx.google.com>
Date:   Tue, 11 Jul 2023 15:59:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15.120-274-g478387c57e172
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-5.15.y
Subject: stable-rc/linux-5.15.y build: 18 builds: 0 failed, 18 passed,
 1 warning (v5.15.120-274-g478387c57e172)
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

stable-rc/linux-5.15.y build: 18 builds: 0 failed, 18 passed, 1 warning (v5=
.15.120-274-g478387c57e172)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.15.=
y/kernel/v5.15.120-274-g478387c57e172/

Tree: stable-rc
Branch: linux-5.15.y
Git Describe: v5.15.120-274-g478387c57e172
Git Commit: 478387c57e172d08b97a3998979210735a56ba69
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 6 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

riscv:

x86_64:
    x86_64_defconfig+x86-chromebook (gcc-10): 1 warning


Warnings summary:

    1    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unr=
eachable instruction

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches

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
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
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
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
1 warning, 0 section mismatches

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction

---
For more info write to <info@kernelci.org>
