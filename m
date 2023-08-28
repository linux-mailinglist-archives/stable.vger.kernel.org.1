Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E20878AF37
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 13:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjH1LoK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 07:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbjH1Lnu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 07:43:50 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5CA126
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 04:43:43 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bc0d39b52cso16870315ad.2
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 04:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693223022; x=1693827822;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OXOnWWtZUQLWnYojNhjvWkAK0waTy7x25ZI+W88NIEA=;
        b=5cAPEpyVJYCh7l2OCbllr6ifUxblK/l4uNxFbr2B56Bzoq0IKOXn610h0QmJJawesb
         25fA4w2SZNO1nhBXEDW6lCudeBs5I5w/w6AtfhUKRkBwvzFVARCWyG+wLbudATO44D06
         21ecOh8RKJdocq8wM+p91Q0bOzBW8XljtjkQxjbMH6VsnZHx3Kn9VdHVlPQacnkFiJkY
         8df4HpeQsdyYXu0lA0Ucc+FpPh3kGf4cVRcMMoFQboyZeg7TOsvEMmsmH191UxX3Ifbf
         BD42llHXqyPfL/JmNcSouEcSAXLkM9+6hj93m1uR9qO90a20NXopJsNP9XyxaN3qlOrw
         6Z0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693223022; x=1693827822;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OXOnWWtZUQLWnYojNhjvWkAK0waTy7x25ZI+W88NIEA=;
        b=kCXbFZY/pAYZK6xpb+XBsQ2dQOYuPaThX6s4gjPa3O909W+e0s9+tsBErLvlUK5FzP
         X8MVCuzxXFsEbw7Xz2WnqZLCNqTYdIu/643ObTZxfrqgn6lm1KaY4C0W4yK9j7hq/9tl
         i82f7JKtTO8BBuqvJolZlBiU89B4NJvpBO6H8AMqOZUZsyE6161f5Gb0C03SXnGHriF4
         VmomaEjUAKbICMyidlK2OtVHSmH0WnNaE0MLASebVRdH0MJxqxgNPyeyYadGf1WqH3k1
         o9rFpHt5ATmUUnbqw1GKGrSeyXnsE7FlUM+88uutMXAuw7z+PbpUNr9EWGRKx8k+SxCl
         OZiw==
X-Gm-Message-State: AOJu0YzArMXYgoYr37GF50CUOfGbOTV/lQqAxkLWsnwDexApukbz3hqh
        Q5B3tg/uziTDrAwZn9B8ORmbheTXqCaEJFMhYjY=
X-Google-Smtp-Source: AGHT+IH3OFYWhbRHq2E8J9cC6kaFcOvAFTbr9UsQ4V0FakGW61gIL6tFpvYqme86kvlHVdFaQAZjBA==
X-Received: by 2002:a17:90a:3d85:b0:26d:3d86:9a8e with SMTP id i5-20020a17090a3d8500b0026d3d869a8emr20174843pjc.25.1693223021924;
        Mon, 28 Aug 2023 04:43:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jh12-20020a170903328c00b001bf5c12e9fesm7152371plb.125.2023.08.28.04.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 04:43:41 -0700 (PDT)
Message-ID: <64ec886d.170a0220.4b33e.aba0@mx.google.com>
Date:   Mon, 28 Aug 2023 04:43:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.192-85-gdb025f893b6a
Subject: stable-rc/linux-5.10.y baseline: 125 runs,
 11 regressions (v5.10.192-85-gdb025f893b6a)
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

stable-rc/linux-5.10.y baseline: 125 runs, 11 regressions (v5.10.192-85-gdb=
025f893b6a)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

hp-14-db0003na-grunt         | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.192-85-gdb025f893b6a/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.192-85-gdb025f893b6a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      db025f893b6a63fb6763de17c15fba074863a27d =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec5401dd0ef668f2286d89

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gdb025f893b6a/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gdb025f893b6a/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec5401dd0ef668f2286d8c
        failing since 41 days (last pass: v5.10.142, first fail: v5.10.186-=
332-gf98a4d3a5cec)

    2023-08-28T07:59:43.524732  [   10.289131] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1247080_1.5.2.4.1>
    2023-08-28T07:59:43.630109  =

    2023-08-28T07:59:43.731284  / # #export SHELL=3D/bin/sh
    2023-08-28T07:59:43.731723  =

    2023-08-28T07:59:43.832691  / # export SHELL=3D/bin/sh. /lava-1247080/e=
nvironment
    2023-08-28T07:59:43.833401  =

    2023-08-28T07:59:43.934705  / # . /lava-1247080/environment/lava-124708=
0/bin/lava-test-runner /lava-1247080/1
    2023-08-28T07:59:43.935542  =

    2023-08-28T07:59:43.939882  / # /lava-1247080/bin/lava-test-runner /lav=
a-1247080/1
    2023-08-28T07:59:43.961585  + export 'TESTRUN_[   10.725032] <LAVA_SIGN=
AL_STARTRUN 1_bootrr 1247080_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec5407b20221e47f286db9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gdb025f893b6a/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gdb025f893b6a/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec5407b20221e47f286dbc
        failing since 177 days (last pass: v5.10.155, first fail: v5.10.172)

    2023-08-28T07:59:40.170484  [   16.191639] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1247082_1.5.2.4.1>
    2023-08-28T07:59:40.275741  =

    2023-08-28T07:59:40.376992  / # #export SHELL=3D/bin/sh
    2023-08-28T07:59:40.377402  =

    2023-08-28T07:59:40.478394  / # export SHELL=3D/bin/sh. /lava-1247082/e=
nvironment
    2023-08-28T07:59:40.478851  =

    2023-08-28T07:59:40.579860  / # . /lava-1247082/environment/lava-124708=
2/bin/lava-test-runner /lava-1247082/1
    2023-08-28T07:59:40.580624  =

    2023-08-28T07:59:40.584630  / # /lava-1247082/bin/lava-test-runner /lav=
a-1247082/1
    2023-08-28T07:59:40.598888  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-14-db0003na-grunt         | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec51a8d4efd5ddd2286dd0

  Results:     17 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gdb025f893b6a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-14-db0003na-grunt.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gdb025f893b6a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-14-db0003na-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/64ec51a8d4efd5d=
dd2286dd3
        new failure (last pass: v5.10.192)
        1 lines

    2023-08-28T07:49:53.911488  kern  :emerg : __common_interrupt: 1.55 No =
irq handler for vector

    2023-08-28T07:49:53.921762  <8>[    7.775119] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D1>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec51b20cdfe83fbb286d9e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gdb025f893b6a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gdb025f893b6a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec51b20cdfe83fbb286da7
        failing since 152 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-28T07:50:04.279325  + set +x

    2023-08-28T07:50:04.285987  <8>[   15.063198] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11370411_1.4.2.3.1>

    2023-08-28T07:50:04.390071  / # #

    2023-08-28T07:50:04.490650  export SHELL=3D/bin/sh

    2023-08-28T07:50:04.490832  #

    2023-08-28T07:50:04.591361  / # export SHELL=3D/bin/sh. /lava-11370411/=
environment

    2023-08-28T07:50:04.591575  =


    2023-08-28T07:50:04.692090  / # . /lava-11370411/environment/lava-11370=
411/bin/lava-test-runner /lava-11370411/1

    2023-08-28T07:50:04.692425  =


    2023-08-28T07:50:04.697028  / # /lava-11370411/bin/lava-test-runner /la=
va-11370411/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec51ac8093df70a4286d96

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gdb025f893b6a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gdb025f893b6a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec51ac8093df70a4286d9f
        failing since 152 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-28T07:49:51.533529  <8>[   12.957785] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11370373_1.4.2.3.1>

    2023-08-28T07:49:51.536689  + set +x

    2023-08-28T07:49:51.641820  #

    2023-08-28T07:49:51.643108  =


    2023-08-28T07:49:51.744983  / # #export SHELL=3D/bin/sh

    2023-08-28T07:49:51.745707  =


    2023-08-28T07:49:51.847368  / # export SHELL=3D/bin/sh. /lava-11370373/=
environment

    2023-08-28T07:49:51.848091  =


    2023-08-28T07:49:51.949568  / # . /lava-11370373/environment/lava-11370=
373/bin/lava-test-runner /lava-11370373/1

    2023-08-28T07:49:51.950760  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec54356c848f8bac286d9b

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gdb025f893b6a/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.=
txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gdb025f893b6a/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec54356c848f8bac286dd9
        failing since 6 days (last pass: v5.10.191, first fail: v5.10.190-1=
23-gec001faa2c729)

    2023-08-28T08:00:32.570102  / # #
    2023-08-28T08:00:32.672852  export SHELL=3D/bin/sh
    2023-08-28T08:00:32.673623  #
    2023-08-28T08:00:32.775500  / # export SHELL=3D/bin/sh. /lava-74414/env=
ironment
    2023-08-28T08:00:32.776282  =

    2023-08-28T08:00:32.878188  / # . /lava-74414/environment/lava-74414/bi=
n/lava-test-runner /lava-74414/1
    2023-08-28T08:00:32.879445  =

    2023-08-28T08:00:32.894285  / # /lava-74414/bin/lava-test-runner /lava-=
74414/1
    2023-08-28T08:00:32.952085  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-28T08:00:32.952580  + cd /lava-74414/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec54d293b2cbdc78286eac

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gdb025f893b6a/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baselin=
e-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gdb025f893b6a/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baselin=
e-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec54d293b2cbdc78286eaf
        failing since 41 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-28T08:03:15.089853  + set +x
    2023-08-28T08:03:15.090416  <8>[   84.007005] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1001914_1.5.2.4.1>
    2023-08-28T08:03:15.199148  / # #
    2023-08-28T08:03:16.670063  export SHELL=3D/bin/sh
    2023-08-28T08:03:16.691268  #
    2023-08-28T08:03:16.691819  / # export SHELL=3D/bin/sh
    2023-08-28T08:03:18.657799  / # . /lava-1001914/environment
    2023-08-28T08:03:22.274891  /lava-1001914/bin/lava-test-runner /lava-10=
01914/1
    2023-08-28T08:03:22.296411  . /lava-1001914/environment
    2023-08-28T08:03:22.296674  / # /lava-1001914/bin/lava-test-runner /lav=
a-1001914/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec5429c5e6767b22286d6e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gdb025f893b6a/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.=
txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gdb025f893b6a/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec5429c5e6767b22286d71
        failing since 41 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-28T08:00:11.780756  / # #
    2023-08-28T08:00:13.243547  export SHELL=3D/bin/sh
    2023-08-28T08:00:13.264229  #
    2023-08-28T08:00:13.264455  / # export SHELL=3D/bin/sh
    2023-08-28T08:00:15.221110  / # . /lava-1001911/environment
    2023-08-28T08:00:18.820672  /lava-1001911/bin/lava-test-runner /lava-10=
01911/1
    2023-08-28T08:00:18.841443  . /lava-1001911/environment
    2023-08-28T08:00:18.841555  / # /lava-1001911/bin/lava-test-runner /lav=
a-1001911/1
    2023-08-28T08:00:18.920500  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-28T08:00:18.920783  + cd /lava-1001911/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec552c5a94043ee0286d9c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gdb025f893b6a/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baselin=
e-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gdb025f893b6a/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baselin=
e-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec552c5a94043ee0286d9f
        failing since 41 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-28T08:04:29.373134  / # #
    2023-08-28T08:04:30.835659  export SHELL=3D/bin/sh
    2023-08-28T08:04:30.856232  #
    2023-08-28T08:04:30.856462  / # export SHELL=3D/bin/sh
    2023-08-28T08:04:32.812437  / # . /lava-1001917/environment
    2023-08-28T08:04:36.412906  /lava-1001917/bin/lava-test-runner /lava-10=
01917/1
    2023-08-28T08:04:36.433655  . /lava-1001917/environment
    2023-08-28T08:04:36.433767  / # /lava-1001917/bin/lava-test-runner /lav=
a-1001917/1
    2023-08-28T08:04:36.511993  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-28T08:04:36.512214  + cd /lava-1001917/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec53c0f60d37ce41286dff

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gdb025f893b6a/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-ro=
ck-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gdb025f893b6a/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-ro=
ck-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec53c0f60d37ce41286e08
        failing since 3 days (last pass: v5.10.191, first fail: v5.10.190-1=
36-gda59b7b5c515e)

    2023-08-28T07:58:32.607997  / # #

    2023-08-28T07:58:33.869332  export SHELL=3D/bin/sh

    2023-08-28T07:58:33.880271  #

    2023-08-28T07:58:33.880744  / # export SHELL=3D/bin/sh

    2023-08-28T07:58:35.624473  / # . /lava-11370437/environment

    2023-08-28T07:58:38.830480  /lava-11370437/bin/lava-test-runner /lava-1=
1370437/1

    2023-08-28T07:58:38.841967  . /lava-11370437/environment

    2023-08-28T07:58:38.845845  / # /lava-11370437/bin/lava-test-runner /la=
va-11370437/1

    2023-08-28T07:58:38.896695  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-28T07:58:38.897249  + cd /lava-11370437/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec53a3f60d37ce41286d6d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gdb025f893b6a/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gdb025f893b6a/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec53a3f60d37ce41286d76
        failing since 41 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-28T07:59:52.124088  / # #

    2023-08-28T07:59:52.226257  export SHELL=3D/bin/sh

    2023-08-28T07:59:52.226952  #

    2023-08-28T07:59:52.328340  / # export SHELL=3D/bin/sh. /lava-11370435/=
environment

    2023-08-28T07:59:52.329083  =


    2023-08-28T07:59:52.430521  / # . /lava-11370435/environment/lava-11370=
435/bin/lava-test-runner /lava-11370435/1

    2023-08-28T07:59:52.431592  =


    2023-08-28T07:59:52.448445  / # /lava-11370435/bin/lava-test-runner /la=
va-11370435/1

    2023-08-28T07:59:52.506571  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-28T07:59:52.507068  + cd /lava-1137043<8>[   18.328192] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11370435_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
