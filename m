Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910F475C697
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 14:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjGUMJd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 08:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjGUMJc (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 08:09:32 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009001701
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 05:09:31 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-666e6ecb52dso1250122b3a.2
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 05:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689941371; x=1690546171;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bmp/j6+np98/sp/Cc1Em7RWFxbZAki8bB6/7dGscILY=;
        b=uvSJ9RiPZ//qN/6pU3rqBtohnSu4PNGfW8a6wUTGqGcd9EGqWAmtUOBj2fwKk7yQ/i
         ycpwjAWchERAQgaG8oHmoriveq30bcaTcoMEf5TKJLyBpgQD2grr9jFKo6Nq2JEw7yNJ
         5mId11oDkLdE+4/ph4zFOsB0Qbr+89lGOC+TpFgSBXiofn2oljTJov2pVEfb4NiGEoTo
         sC0vxPmp9HjPxHNI5SZRRy64S8LnOxrU3uPItSBc9T+nEDZIEcoDZARPSissVE00B6+x
         NiM6XNuLIjXCGCz+F89qpYkOSUQ/8aX1P4RkHKhxvIGUMg9L4zIXHUHsWLcvTz8Qj9bw
         kISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689941371; x=1690546171;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bmp/j6+np98/sp/Cc1Em7RWFxbZAki8bB6/7dGscILY=;
        b=RKHwGVJX2rHJ33NUJ5IBqfq+S+GJHaY6HJrLc/48fSDMWKbRvMT9H0bEiN43UZ3qqs
         r8GBFnlaDyErKJNt2MA82tab04aBBfiiJ7yslDuKmuzSTUAqaPBrFg52NDc8uxYTxk8c
         Nij4MgdeuCh680neLhBx62/GVRGc5gH8Z5nNL6aPgpqoFFhRDG+TxmjP8zwZ2LzrFoh6
         VIveuRlQQanMUUtUAnK8dieoA1FOp+7vQxcfMVFHfXEGD85W+8E7vUNRvQUjg7Jq3kpa
         p2ufq/MMw+oR+dS9p5P8IO6HrFMsL5m96Y2If8eQ+DuAyv3hUNYAsbFIUqRlXRMvGxjf
         eIVg==
X-Gm-Message-State: ABy/qLZpA5ADAUuOuBXO/318QXvQ+RlX/1ZtJ2vkDHHzEmnhA1FIwv2S
        P9BCVg3AtNIyA7OK90f9A9RZgg+ZnSy8o+VMvq68iA==
X-Google-Smtp-Source: APBJJlFdDOpjl2v1dcRpC97UK+dmbDQ/Lnl83ZCejtUqOhLhVaRyk+FIb/jZAXNWDBAcVkij8IhyjA==
X-Received: by 2002:a05:6a20:394a:b0:133:2fb2:9170 with SMTP id r10-20020a056a20394a00b001332fb29170mr1734647pzg.2.1689941370998;
        Fri, 21 Jul 2023 05:09:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x42-20020a056a000bea00b006815fbe3240sm2983923pfu.11.2023.07.21.05.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 05:09:30 -0700 (PDT)
Message-ID: <64ba757a.050a0220.99d02.577b@mx.google.com>
Date:   Fri, 21 Jul 2023 05:09:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.4.y
X-Kernelci-Kernel: v5.4.249-239-g7cc6d2448300
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-5.4.y build: 5 builds: 0 failed, 5 passed,
 4 warnings (v5.4.249-239-g7cc6d2448300)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.4.y build: 5 builds: 0 failed, 5 passed, 4 warnings (v5.4=
.249-239-g7cc6d2448300)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.4.y=
/kernel/v5.4.249-239-g7cc6d2448300/

Tree: stable-rc
Branch: linux-5.4.y
Git Describe: v5.4.249-239-g7cc6d2448300
Git Commit: 7cc6d24483006221e3d5f3a9353738ef5bab2d56
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 4 unique architectures

Warnings Detected:

arc:

arm:

i386:
    allnoconfig (gcc-10): 2 warnings
    tinyconfig (gcc-10): 2 warnings

mips:


Warnings summary:

    2    ld: warning: creating DT_TEXTREL in a PIE
    2    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in rea=
d-only section `.head.text'

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
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
tinyconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section m=
ismatches

Warnings:
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---
For more info write to <info@kernelci.org>
