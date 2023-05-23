Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A687D70D25E
	for <lists+stable@lfdr.de>; Tue, 23 May 2023 05:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjEWDaI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 23:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjEWDaH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 23:30:07 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7162490
        for <stable@vger.kernel.org>; Mon, 22 May 2023 20:30:04 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64d2da69fdfso5200612b3a.0
        for <stable@vger.kernel.org>; Mon, 22 May 2023 20:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684812603; x=1687404603;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/bN49ieH2zJOeGgywu81ifRvr3Ka4R7Fb+fRxIuLZY=;
        b=HUL2B3pTMcwFCNKM8E/0mxTgyax/WPIfbXctIVwj9JlIlUQVtK1EqJGqyG39onz6VR
         zlb/q+gwwwWv6CzgzsCVKDqK389T4oYaulBWJpj7v3hJ7Jgi2xVG2gZPLFfaLYq/VGKI
         qgz1tlUNfY5FivHOQljoutcseBGvu2Bm7GA1rtdFGMfuPzUxJmYMMcGylWzGLyEL50Im
         id/4DSQIyhwSIcNuvnUNlw2S44LCoEEfvGOu4jrIMDJAKWN0YmwnNmFv9AMJMgQZtzIX
         0CcHyxGkm+Tx7xTm6odR4LDXVnk1JZoLECHMCD4m2RNWILClLJjN4Iwwoq63w9L13rvK
         MCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684812603; x=1687404603;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q/bN49ieH2zJOeGgywu81ifRvr3Ka4R7Fb+fRxIuLZY=;
        b=J0r/bSM3iZNUeMvpWXvudPJtNU2XKGFZ01Ko/o5o9IVFFNS8MZGLCUFWxwq7EBPmf4
         wrnsy9uD5U5JWaoYk3/PSl1jSYgHkIoZE0YOwFqbzCkqquzT0pErZZbsJpZbrDGxAHTF
         KS7i38znkB0ZG6r6edRGG9namzZmXSmugTTe4luQIGjxDs0cRaB8LRQqZAsJhEyWPmRw
         zH8oC3YipQ2nOZUDerYu7DRuSsJE2x7tOqN2vR3mwZZry7lBWiqriQhCls7ZcJdVSip7
         2Lc/1nvXsROmS6hfTdQEakKoCiI5RFOc06LS9aYfNhTTnrYiiNNR9N+jGqDTnAcWJ3ni
         +2PA==
X-Gm-Message-State: AC+VfDxuYvc2BlTb5le86i69eCuVDO0re+D3EJmSX40ukLB3yD67/v3l
        dMCA4ijPmh6l69KE1v4fe82iLnH5odQPOGzWxFeJjw==
X-Google-Smtp-Source: ACHHUZ737C8h/JSb90LER6aE3O4DWtI/n7J8tH1Vb/pZ1E0trKbDwbtcubhebnjX+NHaJlhrw3RhMQ==
X-Received: by 2002:a05:6a20:3d0a:b0:10b:ecde:2918 with SMTP id y10-20020a056a203d0a00b0010becde2918mr4256571pzi.32.1684812603125;
        Mon, 22 May 2023 20:30:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c6-20020a63ea06000000b00530704f3a53sm5031515pgi.30.2023.05.22.20.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 20:30:02 -0700 (PDT)
Message-ID: <646c333a.630a0220.54132.8f1b@mx.google.com>
Date:   Mon, 22 May 2023 20:30:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.4.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.4.243-116-gf4eb6582b005
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.4.y baseline: 141 runs,
 17 regressions (v5.4.243-116-gf4eb6582b005)
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

stable-rc/linux-5.4.y baseline: 141 runs, 17 regressions (v5.4.243-116-gf4e=
b6582b005)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hifive-unleashed-a00         | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.4.y/kern=
el/v5.4.243-116-gf4eb6582b005/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.4.y
  Describe: v5.4.243-116-gf4eb6582b005
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      f4eb6582b005fd3bea06aea1a40239790d33168c =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hifive-unleashed-a00         | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/646bf8152c6313388b2e85fa

  Results:     3 PASS, 2 FAIL, 2 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.243=
-116-gf4eb6582b005/riscv/defconfig/gcc-10/lab-baylibre/baseline-hifive-unle=
ashed-a00.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.243=
-116-gf4eb6582b005/riscv/defconfig/gcc-10/lab-baylibre/baseline-hifive-unle=
ashed-a00.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/riscv/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/646bf8152c631338=
8b2e8603
        failing since 215 days (last pass: v5.4.219, first fail: v5.4.219-2=
67-g4a976f825745)
        3 lines

    2023-05-22T23:17:19.731760  / # =

    2023-05-22T23:17:19.732605  =

    2023-05-22T23:17:21.798394  / # #
    2023-05-22T23:17:21.799686  #
    2023-05-22T23:17:23.809395  / # export SHELL=3D/bin/sh
    2023-05-22T23:17:23.809826  export SHELL=3D/bin/sh
    2023-05-22T23:17:25.825467  / # . /lava-3610110/environment
    2023-05-22T23:17:25.825890  . /lava-3610110/environment
    2023-05-22T23:17:27.841716  / # /lava-3610110/bin/lava-test-runner /lav=
a-3610110/0
    2023-05-22T23:17:27.842873  /lava-3610110/bin/lava-test-runner /lava-36=
10110/0 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646bfb21453c6ef86c2e85f3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.243=
-116-gf4eb6582b005/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.243=
-116-gf4eb6582b005/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646bfb21453c6ef86c2e85f8
        failing since 53 days (last pass: v5.4.238, first fail: v5.4.238)

    2023-05-22T23:30:22.909402  + set<8>[   10.629766] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10418675_1.4.2.3.1>

    2023-05-22T23:30:22.909524   +x

    2023-05-22T23:30:23.011275  #

    2023-05-22T23:30:23.112283  / # #export SHELL=3D/bin/sh

    2023-05-22T23:30:23.112674  =


    2023-05-22T23:30:23.213532  / # export SHELL=3D/bin/sh. /lava-10418675/=
environment

    2023-05-22T23:30:23.214022  =


    2023-05-22T23:30:23.314889  / # . /lava-10418675/environment/lava-10418=
675/bin/lava-test-runner /lava-10418675/1

    2023-05-22T23:30:23.315263  =


    2023-05-22T23:30:23.320186  / # /lava-10418675/bin/lava-test-runner /la=
va-10418675/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646bfaf83696d143602e85e6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.243=
-116-gf4eb6582b005/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.243=
-116-gf4eb6582b005/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646bfaf83696d143602e85eb
        failing since 53 days (last pass: v5.4.238, first fail: v5.4.238)

    2023-05-22T23:29:46.395279  <8>[   12.742274] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10418629_1.4.2.3.1>

    2023-05-22T23:29:46.398052  + set +x

    2023-05-22T23:29:46.499441  #

    2023-05-22T23:29:46.499767  =


    2023-05-22T23:29:46.600387  / # #export SHELL=3D/bin/sh

    2023-05-22T23:29:46.600575  =


    2023-05-22T23:29:46.701043  / # export SHELL=3D/bin/sh. /lava-10418629/=
environment

    2023-05-22T23:29:46.701243  =


    2023-05-22T23:29:46.801774  / # . /lava-10418629/environment/lava-10418=
629/bin/lava-test-runner /lava-10418629/1

    2023-05-22T23:29:46.802057  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/646bfe87ef267a677c2e85e9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.243=
-116-gf4eb6582b005/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.243=
-116-gf4eb6582b005/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646bfe87ef267a677c2e8=
5ea
        failing since 272 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-390-g1cece69eaa88) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/646bfee65bda0e77b92e85ea

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.243=
-116-gf4eb6582b005/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.243=
-116-gf4eb6582b005/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646bfee65bda0e77b92e8=
5eb
        failing since 272 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-390-g1cece69eaa88) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/646bfe2a99435273352e85fd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.243=
-116-gf4eb6582b005/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.243=
-116-gf4eb6582b005/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646bfe2a99435273352e8=
5fe
        failing since 272 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-390-g1cece69eaa88) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/646bfe8845ea8c73c02e85f5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.243=
-116-gf4eb6582b005/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.243=
-116-gf4eb6582b005/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646bfe8845ea8c73c02e8=
5f6
        failing since 378 days (last pass: v5.4.191-85-ga4a4cbb41380, first=
 fail: v5.4.191-118-g7dae5fe9ddc0) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/646bff0f374c96a6c62e85f3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.243=
-116-gf4eb6582b005/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.243=
-116-gf4eb6582b005/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646bff0f374c96a6c62e8=
5f4
        failing since 378 days (last pass: v5.4.191-85-ga4a4cbb41380, first=
 fail: v5.4.191-118-g7dae5fe9ddc0) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/646bfea1205a0167a32e85ed

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.243=
-116-gf4eb6582b005/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.243=
-116-gf4eb6582b005/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646bfea1205a0167a32e8=
5ee
        failing since 378 days (last pass: v5.4.191-85-ga4a4cbb41380, first=
 fail: v5.4.191-118-g7dae5fe9ddc0) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/646bfe868bfdefed432e85fb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.243=
-116-gf4eb6582b005/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.243=
-116-gf4eb6582b005/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646bfe868bfdefed432e8=
5fc
        failing since 292 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.209) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/646bfe70c4fcaa5bf92e869c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.243=
-116-gf4eb6582b005/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.243=
-116-gf4eb6582b005/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646bfe70c4fcaa5bf92e8=
69d
        failing since 292 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.209) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/646bfe2999435273352e85f6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.243=
-116-gf4eb6582b005/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.243=
-116-gf4eb6582b005/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646bfe2999435273352e8=
5f7
        failing since 292 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.209) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/646bfe8524c783a9192e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.243=
-116-gf4eb6582b005/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.243=
-116-gf4eb6582b005/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646bfe8524c783a9192e8=
5e7
        failing since 272 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-390-g1cece69eaa88) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/646bfe6fc4fcaa5bf92e868e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.243=
-116-gf4eb6582b005/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.243=
-116-gf4eb6582b005/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646bfe6fc4fcaa5bf92e8=
68f
        failing since 272 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-390-g1cece69eaa88) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/646bfe2b47d276a5c72e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.243=
-116-gf4eb6582b005/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.243=
-116-gf4eb6582b005/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646bfe2b47d276a5c72e8=
5e7
        failing since 272 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-390-g1cece69eaa88) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646bfbe7ebe9e32ccd2e861e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.243=
-116-gf4eb6582b005/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.243=
-116-gf4eb6582b005/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646bfbe7ebe9e32ccd2e8623
        failing since 125 days (last pass: v5.4.227, first fail: v5.4.228-6=
59-gb3b34c474ec7)

    2023-05-22T23:33:28.298089  <8>[    7.709979] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3610362_1.5.2.4.1>
    2023-05-22T23:33:28.402584  / # #
    2023-05-22T23:33:28.505107  export SHELL=3D/bin/sh
    2023-05-22T23:33:28.505846  #
    2023-05-22T23:33:28.607516  / # export SHELL=3D/bin/sh. /lava-3610362/e=
nvironment
    2023-05-22T23:33:28.608293  =

    2023-05-22T23:33:28.710121  / # . /lava-3610362/environment/lava-361036=
2/bin/lava-test-runner /lava-3610362/1
    2023-05-22T23:33:28.711269  =

    2023-05-22T23:33:28.728337  / # /lava-3610362/bin/lava-test-runner /lav=
a-3610362/1
    2023-05-22T23:33:28.776331  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/646bfb14daa61e770a2e85fc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.243=
-116-gf4eb6582b005/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h=
3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.243=
-116-gf4eb6582b005/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h=
3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646bfb14daa61e770a2e8601
        failing since 125 days (last pass: v5.4.227, first fail: v5.4.228-6=
59-gb3b34c474ec7)

    2023-05-22T23:29:59.218096  / # #
    2023-05-22T23:29:59.320497  export SHELL=3D/bin/sh
    2023-05-22T23:29:59.321069  #
    2023-05-22T23:29:59.422515  / # export SHELL=3D/bin/sh. /lava-3610314/e=
nvironment
    2023-05-22T23:29:59.423104  =

    2023-05-22T23:29:59.524576  / # . /lava-3610314/environment/lava-361031=
4/bin/lava-test-runner /lava-3610314/1
    2023-05-22T23:29:59.525429  =

    2023-05-22T23:29:59.542441  / # /lava-3610314/bin/lava-test-runner /lav=
a-3610314/1
    2023-05-22T23:29:59.614243  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-22T23:29:59.614653  + cd /lava-3610314/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
