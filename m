Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB8D75C6F6
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 14:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjGUMh5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 08:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjGUMh4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 08:37:56 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACB11999
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 05:37:54 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b9c5e07c1bso13817585ad.2
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 05:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689943073; x=1690547873;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WeKVNpEJbU/3C25nA6sIlSz/0a/6YabUIv/yQ/gJbHQ=;
        b=NgVm2Uo8KQxAxE44crEgJ8ZZXocdA7kjpq/ZieXfKY1uBVdbwL1hxw2wl81uOjeDgx
         2/gozeSTDJGPYbNaCDTVjAwQ8t1srulnZHaAVZyyIDPynO2pOsmw4ipmpdb1fdxQ1E+f
         yKkx1OPB6d1Wa5GtlgB3oDubQY0VChQ9/w6Lz6egpGquZ890+jQaGEW1F0BW2zNUL4sY
         MmtKNr6eeDsQFjAQpBPPouLvDW6j+S9KT/YN0PixN4knM0qFBi5TH+Cyooz6RB9Mp9qa
         kErsoVciIh19p8KP6RF1ENKTcnRnXIcrGtDcnL13cui0uCbzVvu2Qn+wuIiUnskGqet3
         tf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689943073; x=1690547873;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WeKVNpEJbU/3C25nA6sIlSz/0a/6YabUIv/yQ/gJbHQ=;
        b=jT8IXCMzJK97GbofSBt99sHZ3VMMWemLPFCJrF35PmNdiXPVXHXpYGPaDKlFy6PGs3
         nx0waW/dqIpvaO6F3zmF/nxkZL+fGwmitW/z+4+5ZVbgyf3dBpK8g6CfEReCMKMVDDVp
         f1clQIPeVFkJ9C6At9LAlMMV5RUjtwVbwPorrhZTY40NquI3PG1wjMPHgrORzVwvjSdd
         wUJp3cTd0Xi4eQMWbkldiYtXiUNJb1sR9lbqFGJuPlgbTmUAU3TzMCJUdAkXWLPpr4a7
         RDPc1gzdxMCWlnOGRYDVuxnY8qEq+XaLbXEXyihJFvuzwe1lt8D/F9ujl50wgeUTcCNn
         zDOA==
X-Gm-Message-State: ABy/qLYTfAVoMFlU61dbxFzR9cZeQ08bTULBv0Nw209vv2MzjLafzYn3
        Yn8J5ButPQW4POGS3xUovvgKYKqSdW7y4oFzmhHBsw==
X-Google-Smtp-Source: APBJJlFTWRxLbzhhjNyRUC2cRDMgMraKpnszdzz4Ce1DtptZdvTiVaAyeX6DEs4hjGNNEW4sqD48DA==
X-Received: by 2002:a17:903:2646:b0:1b8:a73e:aaac with SMTP id je6-20020a170903264600b001b8a73eaaacmr1860985plb.62.1689943073520;
        Fri, 21 Jul 2023 05:37:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q2-20020a170902edc200b001b1c3542f57sm3376738plk.103.2023.07.21.05.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 05:37:52 -0700 (PDT)
Message-ID: <64ba7c20.170a0220.59afe.656b@mx.google.com>
Date:   Fri, 21 Jul 2023 05:37:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Kernel: v4.19.288-158-g5299d5c89ca8
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-4.19.y build: 7 builds: 1 failed, 6 passed,
 8 warnings (v4.19.288-158-g5299d5c89ca8)
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

stable-rc/linux-4.19.y build: 7 builds: 1 failed, 6 passed, 8 warnings (v4.=
19.288-158-g5299d5c89ca8)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.288-158-g5299d5c89ca8/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.288-158-g5299d5c89ca8
Git Commit: 5299d5c89ca823714738cf2e26456fdfde8bda91
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 4 unique architectures

Build Failure Detected:

riscv:
    defconfig: (gcc-10) FAIL

Warnings Detected:

arm:

i386:
    allnoconfig (gcc-10): 2 warnings
    i386_defconfig (gcc-10): 2 warnings

riscv:

x86_64:
    allnoconfig (gcc-10): 2 warnings
    tinyconfig (gcc-10): 2 warnings


Warnings summary:

    4    ld: warning: creating DT_TEXTREL in a PIE
    2    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'
    2    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in rea=
d-only section `.head.text'

Section mismatches summary:

    1    WARNING: modpost: Found 1 section mismatch(es).

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

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
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section =
mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section m=
ismatches

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
multi_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section=
 mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---
For more info write to <info@kernelci.org>
