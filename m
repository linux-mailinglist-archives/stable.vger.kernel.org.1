Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0A97898C5
	for <lists+stable@lfdr.de>; Sat, 26 Aug 2023 21:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjHZTMd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 26 Aug 2023 15:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjHZTMH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 26 Aug 2023 15:12:07 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E8AE4B
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 12:12:03 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bf11b1c7d0so20406225ad.0
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 12:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693077122; x=1693681922;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m/DrTtygSjy1kBcrRD8aL1owDT2x1Uak50DiclfHiVk=;
        b=irFNof9sUTPtb1gN3Rn93XZXbiSriWLu4bOq2/WHMyGLiMB5k7W93kk32aIKDHaMrL
         FMwBlEXLc/kCEd+0Ylkb/oRufqWNQbyZHCPE/0C0yv/J4abpPxKG3TA3z/OcVfkZ3LDC
         4pjv967qxQAN6ZJye8/+A084Xli+ZrFkVg9R0YYCLwMGwEwZHdCs/4+MP5cttgDkfzHF
         yHehecF265vg7VQfD5WgGJbGrGkmflIwFVLlhMF9IHx9AH8T1c0cwHPcJOg9Xn8UuTwy
         fq/DU9zF2C9HtNpJ2g7WBja/1gZ4vCDA/TJZbPAWdupNMQfoyznW7Ef9HGVaxZyFLOqz
         cBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693077122; x=1693681922;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m/DrTtygSjy1kBcrRD8aL1owDT2x1Uak50DiclfHiVk=;
        b=buOaYn226Mn7q8PZqVryNhDXK3w7ZiJbjFMZNkzw9VVLB3KmdLRuvU1O63EA1ljAXW
         paHVvsZYaBKmDtibngp2t0LGahHKc5/xmmASnZl/7761fUzgXqtag/OQbZtVLSJCUIGV
         AoSTMCykdULt43i5HwjQlD78djwgAoJON2vRcKH/pTf2a+Mxj9S+IRkHefmoUnaihOx8
         YXoZQYl1KS2ExqeNLA8gKQlHVkEBMeHxeGrA00R5sXmQYtSM6jYu3X6quhIp3PwJQ8xY
         LmLrptPQadqRHbCfa8QnZTaQMkIZ7AQp4d4m1BJuDzQ+vK8F8bCAJS5YvzIoLP9+E6wN
         2ZCw==
X-Gm-Message-State: AOJu0YzPrORlBaDVxIvBt3apqMa0qKyOkzo2gVkG7If2SEA7vG5G8rjJ
        bV67PL3BfToP2MstXuyGT9u0y7Ku4RhaU8+RGuk=
X-Google-Smtp-Source: AGHT+IGyWUtG++b+cBl90gJ9LTymhI7inpsosUvC5gOlc8z2lAr9gasfqt1BaR2mqVoiKT3+MjghNA==
X-Received: by 2002:a17:902:ab14:b0:1b9:c61c:4c01 with SMTP id ik20-20020a170902ab1400b001b9c61c4c01mr30974798plb.9.1693077122030;
        Sat, 26 Aug 2023 12:12:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t8-20020a1709027fc800b001bdcafcf8d3sm4117120plb.69.2023.08.26.12.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 12:12:01 -0700 (PDT)
Message-ID: <64ea4e81.170a0220.a154.6e0e@mx.google.com>
Date:   Sat, 26 Aug 2023 12:12:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.192
Subject: stable/linux-5.10.y baseline: 126 runs, 12 regressions (v5.10.192)
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

stable/linux-5.10.y baseline: 126 runs, 12 regressions (v5.10.192)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.10.y/kernel=
/v5.10.192/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.10.y
  Describe: v5.10.192
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      1599cb60bace881ce05fa520e5251be341e380d2 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea1e94d8d26dfa82286d92

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.192/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-sama5d4_xplained.t=
xt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.192/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-sama5d4_xplained.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ea1e94d8d26dfa82286=
d93
        new failure (last pass: v5.10.191) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea1dcd65a80ef610286db7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.192/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.192/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea1dcd65a80ef610286dbc
        failing since 219 days (last pass: v5.10.158, first fail: v5.10.164)

    2023-08-26T15:43:45.520324  <8>[   11.240275] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3751247_1.5.2.4.1>
    2023-08-26T15:43:45.633358  / # #
    2023-08-26T15:43:45.736287  export SHELL=3D/bin/sh
    2023-08-26T15:43:45.737199  #
    2023-08-26T15:43:45.737682  / # export SHELL=3D/bin/sh<3>[   11.451877]=
 Bluetooth: hci0: command 0x0c03 tx timeout
    2023-08-26T15:43:45.839697  . /lava-3751247/environment
    2023-08-26T15:43:45.840602  =

    2023-08-26T15:43:45.942598  / # . /lava-3751247/environment/lava-375124=
7/bin/lava-test-runner /lava-3751247/1
    2023-08-26T15:43:45.943957  =

    2023-08-26T15:43:45.948691  / # /lava-3751247/bin/lava-test-runner /lav=
a-3751247/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea1af9b93697456b286d6c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.192/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.192/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea1af9b93697456b286d71
        failing since 143 days (last pass: v5.10.176, first fail: v5.10.177)

    2023-08-26T15:33:07.209650  + set +x

    2023-08-26T15:33:07.215893  <8>[   10.383368] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11363076_1.4.2.3.1>

    2023-08-26T15:33:07.320232  / # #

    2023-08-26T15:33:07.420846  export SHELL=3D/bin/sh

    2023-08-26T15:33:07.421078  #

    2023-08-26T15:33:07.521594  / # export SHELL=3D/bin/sh. /lava-11363076/=
environment

    2023-08-26T15:33:07.521768  =


    2023-08-26T15:33:07.622269  / # . /lava-11363076/environment/lava-11363=
076/bin/lava-test-runner /lava-11363076/1

    2023-08-26T15:33:07.622497  =


    2023-08-26T15:33:07.627025  / # /lava-11363076/bin/lava-test-runner /la=
va-11363076/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea1d5bf8c55cf217286d87

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.192/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rz=
g2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.192/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rz=
g2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea1d5bf8c55cf217286d8e
        failing since 30 days (last pass: v5.10.184, first fail: v5.10.188)

    2023-08-26T15:41:55.877728  + set +x
    2023-08-26T15:41:55.878275  <8>[   83.982565] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1001145_1.5.2.4.1>
    2023-08-26T15:41:55.987142  / # #
    2023-08-26T15:41:57.457855  export SHELL=3D/bin/sh
    2023-08-26T15:41:57.479169  #
    2023-08-26T15:41:57.479732  / # export SHELL=3D/bin/sh
    2023-08-26T15:41:59.446465  / # . /lava-1001145/environment
    2023-08-26T15:42:03.054713  /lava-1001145/bin/lava-test-runner /lava-10=
01145/1
    2023-08-26T15:42:03.076845  . /lava-1001145/environment
    2023-08-26T15:42:03.077334  / # /lava-1001145/bin/lava-test-runner /lav=
a-1001145/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea1e231259653875286db0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.192/=
arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.192/=
arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea1e231259653875286db7
        new failure (last pass: v5.10.185)

    2023-08-26T15:45:19.715886  + set +x
    2023-08-26T15:45:19.716468  <8>[   83.998926] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1001151_1.5.2.4.1>
    2023-08-26T15:45:19.824822  / # #
    2023-08-26T15:45:21.295697  export SHELL=3D/bin/sh
    2023-08-26T15:45:21.317025  #
    2023-08-26T15:45:21.317584  / # export SHELL=3D/bin/sh
    2023-08-26T15:45:23.282503  / # . /lava-1001151/environment
    2023-08-26T15:45:26.894222  /lava-1001151/bin/lava-test-runner /lava-10=
01151/1
    2023-08-26T15:45:26.916357  . /lava-1001151/environment
    2023-08-26T15:45:26.916824  / # /lava-1001151/bin/lava-test-runner /lav=
a-1001151/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea1df11259653875286d80

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.192/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.192/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea1df11259653875286d87
        failing since 30 days (last pass: v5.10.184, first fail: v5.10.188)

    2023-08-26T15:44:15.902534  / # #
    2023-08-26T15:44:17.361872  export SHELL=3D/bin/sh
    2023-08-26T15:44:17.382334  #
    2023-08-26T15:44:17.382467  / # export SHELL=3D/bin/sh
    2023-08-26T15:44:19.335017  / # . /lava-1001143/environment
    2023-08-26T15:44:22.928067  /lava-1001143/bin/lava-test-runner /lava-10=
01143/1
    2023-08-26T15:44:22.948660  . /lava-1001143/environment
    2023-08-26T15:44:22.948769  / # /lava-1001143/bin/lava-test-runner /lav=
a-1001143/1
    2023-08-26T15:44:23.025599  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-26T15:44:23.025811  + cd /lava-1001143/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea1edeebaa23fea6286d8e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.192/=
arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.192/=
arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea1edeebaa23fea6286d95
        failing since 30 days (last pass: v5.10.185, first fail: v5.10.188)

    2023-08-26T15:48:13.476832  / # #
    2023-08-26T15:48:14.938091  export SHELL=3D/bin/sh
    2023-08-26T15:48:14.958591  #
    2023-08-26T15:48:14.958796  / # export SHELL=3D/bin/sh
    2023-08-26T15:48:16.913723  / # . /lava-1001148/environment
    2023-08-26T15:48:20.509828  /lava-1001148/bin/lava-test-runner /lava-10=
01148/1
    2023-08-26T15:48:20.530552  . /lava-1001148/environment
    2023-08-26T15:48:20.530664  / # /lava-1001148/bin/lava-test-runner /lav=
a-1001148/1
    2023-08-26T15:48:20.564703  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-26T15:48:20.612941  + cd /lava-1001148/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea1d0a066c74fc41286e30

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.192/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.192/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea1d0a066c74fc41286e35
        failing since 30 days (last pass: v5.10.185, first fail: v5.10.188)

    2023-08-26T15:42:10.015050  / # #

    2023-08-26T15:42:10.117089  export SHELL=3D/bin/sh

    2023-08-26T15:42:10.117794  #

    2023-08-26T15:42:10.219264  / # export SHELL=3D/bin/sh. /lava-11363272/=
environment

    2023-08-26T15:42:10.219978  =


    2023-08-26T15:42:10.321465  / # . /lava-11363272/environment/lava-11363=
272/bin/lava-test-runner /lava-11363272/1

    2023-08-26T15:42:10.322557  =


    2023-08-26T15:42:10.339110  / # /lava-11363272/bin/lava-test-runner /la=
va-11363272/1

    2023-08-26T15:42:10.387966  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-26T15:42:10.388479  + cd /lav<8>[   16.494168] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11363272_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64ea1d59f604042d8c286d79

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.192/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.192/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64ea1d59f604042d8c286d7f
        failing since 162 days (last pass: v5.10.174, first fail: v5.10.175)

    2023-08-26T15:41:56.903436  <8>[   61.067478] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-08-26T15:41:57.927631  /lava-11363256/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64ea1d59f604042d8c286d80
        failing since 162 days (last pass: v5.10.174, first fail: v5.10.175)

    2023-08-26T15:41:56.892174  /lava-11363256/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea1d308d384340a1286f26

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.192/=
arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.192/=
arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea1d308d384340a1286f2f
        new failure (last pass: v5.10.191)

    2023-08-26T15:41:24.170123  / # #

    2023-08-26T15:41:25.430240  export SHELL=3D/bin/sh

    2023-08-26T15:41:25.441118  #

    2023-08-26T15:41:25.441575  / # export SHELL=3D/bin/sh

    2023-08-26T15:41:27.179071  / # . /lava-11363274/environment

    2023-08-26T15:41:30.379309  /lava-11363274/bin/lava-test-runner /lava-1=
1363274/1

    2023-08-26T15:41:30.390679  . /lava-11363274/environment

    2023-08-26T15:41:30.390989  / # /lava-11363274/bin/lava-test-runner /la=
va-11363274/1

    2023-08-26T15:41:30.444806  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-26T15:41:30.445281  + cd /lava-11363274/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea1d09066c74fc41286e25

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.192/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.192/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea1d09066c74fc41286e2a
        failing since 30 days (last pass: v5.10.185, first fail: v5.10.188)

    2023-08-26T15:42:20.868964  / # #

    2023-08-26T15:42:20.970925  export SHELL=3D/bin/sh

    2023-08-26T15:42:20.971141  #

    2023-08-26T15:42:21.071658  / # export SHELL=3D/bin/sh. /lava-11363271/=
environment

    2023-08-26T15:42:21.071852  =


    2023-08-26T15:42:21.172354  / # . /lava-11363271/environment/lava-11363=
271/bin/lava-test-runner /lava-11363271/1

    2023-08-26T15:42:21.172565  =


    2023-08-26T15:42:21.182532  / # /lava-11363271/bin/lava-test-runner /la=
va-11363271/1

    2023-08-26T15:42:21.245408  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-26T15:42:21.245556  + cd /lava-1136327<8>[   18.341795] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11363271_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
