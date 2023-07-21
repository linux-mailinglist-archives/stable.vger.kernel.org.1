Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DB075C9AB
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 16:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjGUOSQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 10:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjGUOR7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 10:17:59 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283DC2D4A
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:17:55 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bb1baf55f5so14961715ad.0
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689949074; x=1690553874;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3KDVlrghaGw8634LcPRX07bWjDPu8sw2z0/PhvJ9WwM=;
        b=yo66IYLa6CDCDQELZZPtbTOsrcWyWn2tjuaepEKeY6d9eYyRtZ1EgQdbAARhzaf5PN
         19aG+Lnd39bXE4SSXNFY1krYNdNnTtn/r6Z2tzinBA1fnw9AXW0nhxEWw6GNIt4swAtN
         pAknCc4aTlj572JlsSU+QTMGiPdCDtrabK0w/vwOHENTbMkWNJiZt5AbcGVmJiYLiG0Y
         U0JrYZX31t+wXb8nnySDITorXNlGBVtm1nt2PwGodojP51zd/XaFad3JYowrKrqDXT5V
         m/gUULamJ2ERNMlqwx6nm6ah1mZeIa0FcYqPTNHsVMUvdqjZ+hhxyChxsmPJk01cT/x5
         XJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689949074; x=1690553874;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3KDVlrghaGw8634LcPRX07bWjDPu8sw2z0/PhvJ9WwM=;
        b=UArlgC7ZvC4d92WiGOxR245G9jz1OxHkt6Ckg859mFbBzgZwL0fjv3DbKPFEbO0nIX
         R9t5v/bqaZuNFTENNDIBs22R5yUwG05+n18x4/iLG9Ddx4fBK5NT3xtuDHruAgJqY9sx
         e01McTvbP0PC8y3dhkJj+3Ok8QpVfHc94dMKsr5jsXqT3itzM5DyU54lNkN/UDLIyrpg
         PLI6cKCeW4Q362eHAHkI7BUuCROJlyquhxoHKffJYrl4gJXL3OvNsrmOB8GzsYgljZWr
         rmgyDjreQnClYYibcWzU6BiSqfcN/T7bC+Q9YZOGUtuOVTzNxm0rwFdBCM+j/h5DevTg
         HwrA==
X-Gm-Message-State: ABy/qLayyZUEWyKT2nDXJzAOtjP4aPlJBoZA70ZkrPXQNBudlm+jewee
        4dPWB1/rnp/A9Lbxz22DwSfBaTUETiTlmJ9In4/vIQ==
X-Google-Smtp-Source: APBJJlEwWy3Th1B85JrW/iXlqEmhhezbP5qQp3Lk5IOL6OhJ7H4MZAzGEAYlF93Z5Ruvx2NkOdZ6vw==
X-Received: by 2002:a17:903:24c:b0:1bb:1504:b659 with SMTP id j12-20020a170903024c00b001bb1504b659mr2576845plh.40.1689949074235;
        Fri, 21 Jul 2023 07:17:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a20-20020a1709027d9400b001a5fccab02dsm3532957plm.177.2023.07.21.07.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 07:17:53 -0700 (PDT)
Message-ID: <64ba9391.170a0220.4869c.66e6@mx.google.com>
Date:   Fri, 21 Jul 2023 07:17:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Kernel: v5.15.120-461-gf00f5bd44794
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-5.15.y build: 4 builds: 0 failed, 4 passed,
 1 warning (v5.15.120-461-gf00f5bd44794)
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

stable-rc/linux-5.15.y build: 4 builds: 0 failed, 4 passed, 1 warning (v5.1=
5.120-461-gf00f5bd44794)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.15.=
y/kernel/v5.15.120-461-gf00f5bd44794/

Tree: stable-rc
Branch: linux-5.15.y
Git Describe: v5.15.120-461-gf00f5bd44794
Git Commit: f00f5bd447944c43362d06c5029e5c78ae14d2da
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 4 unique architectures

Warnings Detected:

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
nommu_k210_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, =
0 section mismatches

---------------------------------------------------------------------------=
-----
tinyconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

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
