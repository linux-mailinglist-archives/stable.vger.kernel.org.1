Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C046F4CE7
	for <lists+stable@lfdr.de>; Wed,  3 May 2023 00:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjEBWd7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 2 May 2023 18:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEBWd6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 2 May 2023 18:33:58 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D334910E3
        for <stable@vger.kernel.org>; Tue,  2 May 2023 15:33:56 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b70ca0a84so5041381b3a.2
        for <stable@vger.kernel.org>; Tue, 02 May 2023 15:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683066836; x=1685658836;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pra1yfG0Ub6zUVa42o6v4sfJpswv9/VZz9gHqBGz1AU=;
        b=1rwDiFoZV22f33ok+IikVMEJoWlx4AItaZb3pPsVwOgQjoY32FJDACNPtZTXicFOrY
         /R77MGGO3supeRSjnVUCkfH0Nslaj28mX7WoPlp98ioO57rrFoRtgPyabYyzR7CQ9YcA
         VN3EJ7JvWsy3BvXbnHN8NzejCKdSS0MZ0fPgBeWKaTfsU6CBP1/l6Twi/qMhfDRC9fX2
         367rHcU6cgAzV4+X7kM0yndVR+T22vEQCl2+722g7IXF3lGexbEsJKZUZMy9kDPB46GU
         +XvuQ77eJnY9hXng51mdIJIekSD+z4xgjsd5LEvkyi0MciFM0AbrnbdAgki0aTHWs/15
         PM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683066836; x=1685658836;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pra1yfG0Ub6zUVa42o6v4sfJpswv9/VZz9gHqBGz1AU=;
        b=j2vt5hO7Vuf9W+T8P8v/4Rege/HxPWMfrNedB28PRJJkiz2bEM8GdNCGjzud1fKTI0
         uzIpKlB0Ryv9et5PmJKCCYLoAAXcZAl1tvfUmYupiOyR4zjfewyL+UDb4kescewvKe4H
         5L5NbISSr/uVTOpL9cHm2dzKx+Bti+IvpErcPShu5bcYgLcSrT3WEgHR7aHeoOuey/hP
         i8cohMdaeiScPqnGW4xjfA5mNsZFooL+03vmR5gZscJ2D4uKiZgO0D9yBlC99ZHyH+4K
         O0PfAqdmKS8bzCinA1s184Afi4Ddd6hpKQmDOdcV4a3U1AHVhqhWL+1WHhStZtTqpg8N
         mtrQ==
X-Gm-Message-State: AC+VfDwhXSnTRCbCBCtJGyw+cAwWUi1WG7pN5JGv1lWGQcNyg7wYS5F1
        z9wmg11jUYeJev9x8srIqnvs46ilvbjyYEOlqsY=
X-Google-Smtp-Source: ACHHUZ4ZhTD/fBb7ysQrdhQgqaMnWAh/pKoiqxe3mZRfqIZApZXURgU7sVWCXZE5/1ghAfYyp/cBeQ==
X-Received: by 2002:a05:6a00:124f:b0:63b:7954:9881 with SMTP id u15-20020a056a00124f00b0063b79549881mr26267795pfi.28.1683066835841;
        Tue, 02 May 2023 15:33:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x35-20020a056a0018a300b0063b6cccd5dfsm22370959pfh.195.2023.05.02.15.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 15:33:55 -0700 (PDT)
Message-ID: <64518fd3.050a0220.9c978.e9de@mx.google.com>
Date:   Tue, 02 May 2023 15:33:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.176-377-g36f574493abf
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 158 runs,
 8 regressions (v5.10.176-377-g36f574493abf)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/queue/5.10 baseline: 158 runs, 8 regressions (v5.10.176-377-g36f5=
74493abf)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.176-377-g36f574493abf/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.176-377-g36f574493abf
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      36f574493abfb237a71003fbc63fd0667fbc52eb =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64515f0e51d9b0b7012e85f8

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-377-g36f574493abf/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-377-g36f574493abf/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64515f0e51d9b0b7012e862d
        failing since 77 days (last pass: v5.10.167-127-g921934d621e4, firs=
t fail: v5.10.167-139-gf9519a5a1701)

    2023-05-02T19:05:31.354759  <8>[   19.654564] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 406331_1.5.2.4.1>
    2023-05-02T19:05:31.465021  / # #
    2023-05-02T19:05:31.567552  export SHELL=3D/bin/sh
    2023-05-02T19:05:31.568251  #
    2023-05-02T19:05:31.670394  / # export SHELL=3D/bin/sh. /lava-406331/en=
vironment
    2023-05-02T19:05:31.671139  =

    2023-05-02T19:05:31.773543  / # . /lava-406331/environment/lava-406331/=
bin/lava-test-runner /lava-406331/1
    2023-05-02T19:05:31.774720  =

    2023-05-02T19:05:31.778609  / # /lava-406331/bin/lava-test-runner /lava=
-406331/1
    2023-05-02T19:05:31.888269  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64515b6727702bb94b2e85fb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-377-g36f574493abf/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-377-g36f574493abf/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64515b6727702bb94b2e8600
        failing since 96 days (last pass: v5.10.165-76-g5c2e982fcf18, first=
 fail: v5.10.165-77-g4600242c13ed)

    2023-05-02T18:49:53.493784  + set +x<8>[   11.008284] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3547466_1.5.2.4.1>
    2023-05-02T18:49:53.494187  =

    2023-05-02T18:49:53.601134  / # #
    2023-05-02T18:49:53.703393  export SHELL=3D/bin/sh
    2023-05-02T18:49:53.703832  #
    2023-05-02T18:49:53.805272  / # export SHELL=3D/bin/sh. /lava-3547466/e=
nvironment
    2023-05-02T18:49:53.805879  =

    2023-05-02T18:49:53.907242  / # . /lava-3547466/environment/lava-354746=
6/bin/lava-test-runner /lava-3547466/1
    2023-05-02T18:49:53.908013  =

    2023-05-02T18:49:53.913744  / # /lava-3547466/bin/lava-test-runner /lav=
a-3547466/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64515c535508f2419a2e85e7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-377-g36f574493abf/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-377-g36f574493abf/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64515c535508f2419a2e85ec
        failing since 33 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-02T18:53:55.429012  + set +x

    2023-05-02T18:53:55.435343  <8>[   10.127110] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10178453_1.4.2.3.1>

    2023-05-02T18:53:55.539360  / # #

    2023-05-02T18:53:55.639888  export SHELL=3D/bin/sh

    2023-05-02T18:53:55.640068  #

    2023-05-02T18:53:55.740528  / # export SHELL=3D/bin/sh. /lava-10178453/=
environment

    2023-05-02T18:53:55.740746  =


    2023-05-02T18:53:55.841276  / # . /lava-10178453/environment/lava-10178=
453/bin/lava-test-runner /lava-10178453/1

    2023-05-02T18:53:55.841629  =


    2023-05-02T18:53:55.846282  / # /lava-10178453/bin/lava-test-runner /la=
va-10178453/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64515c13849f1be57b2e85f0

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-377-g36f574493abf/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-377-g36f574493abf/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64515c13849f1be57b2e85f5
        failing since 33 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-02T18:52:52.844585  + set +x

    2023-05-02T18:52:52.851657  <8>[   12.292600] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10178484_1.4.2.3.1>

    2023-05-02T18:52:52.959188  #

    2023-05-02T18:52:52.960371  =


    2023-05-02T18:52:53.062245  / # #export SHELL=3D/bin/sh

    2023-05-02T18:52:53.062962  =


    2023-05-02T18:52:53.164436  / # export SHELL=3D/bin/sh. /lava-10178484/=
environment

    2023-05-02T18:52:53.165325  =


    2023-05-02T18:52:53.267017  / # . /lava-10178484/environment/lava-10178=
484/bin/lava-test-runner /lava-10178484/1

    2023-05-02T18:52:53.268251  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64515cd7839c875db82e8623

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-377-g36f574493abf/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-377-g36f574493abf/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64515cd7839c875db82e8628
        failing since 91 days (last pass: v5.10.155-149-g63e308de12c9, firs=
t fail: v5.10.165-142-gc53eb88edf7e)

    2023-05-02T18:56:07.830142  [   15.983450] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3547654_1.5.2.4.1>
    2023-05-02T18:56:07.934592  =

    2023-05-02T18:56:07.934818  / # #[   16.066727] rockchip-drm display-su=
bsystem: [drm] Cannot find any crtc or sizes
    2023-05-02T18:56:08.036180  export SHELL=3D/bin/sh
    2023-05-02T18:56:08.036578  =

    2023-05-02T18:56:08.137970  / # export SHELL=3D/bin/sh. /lava-3547654/e=
nvironment
    2023-05-02T18:56:08.138711  =

    2023-05-02T18:56:08.240684  / # . /lava-3547654/environment/lava-354765=
4/bin/lava-test-runner /lava-3547654/1
    2023-05-02T18:56:08.241353  =

    2023-05-02T18:56:08.244721  / # /lava-3547654/bin/lava-test-runner /lav=
a-3547654/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64515f2e447c28730e2e865e

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-377-g36f574493abf/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-377-g36f574493abf/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64515f2e447c28730e2e8664
        failing since 49 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-02T19:06:05.500595  /lava-10178687/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64515f2e447c28730e2e8665
        failing since 49 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-02T19:06:03.437995  <8>[   32.922166] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-05-02T19:06:04.463891  /lava-10178687/1/../bin/lava-test-case

    2023-05-02T19:06:04.475376  <8>[   33.960245] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64515a70b438b750182e85f3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-377-g36f574493abf/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-377-g36f574493abf/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64515a70b438b750182e85f8
        failing since 89 days (last pass: v5.10.165-139-gefb57ce0f880, firs=
t fail: v5.10.165-149-ge30e8271d674)

    2023-05-02T18:45:35.464783  / # #
    2023-05-02T18:45:35.566604  export SHELL=3D/bin/sh
    2023-05-02T18:45:35.566963  #
    2023-05-02T18:45:35.668296  / # export SHELL=3D/bin/sh. /lava-3547464/e=
nvironment
    2023-05-02T18:45:35.668769  =

    2023-05-02T18:45:35.770225  / # . /lava-3547464/environment/lava-354746=
4/bin/lava-test-runner /lava-3547464/1
    2023-05-02T18:45:35.771132  =

    2023-05-02T18:45:35.776100  / # /lava-3547464/bin/lava-test-runner /lav=
a-3547464/1
    2023-05-02T18:45:35.840195  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-02T18:45:35.875027  + cd /lava-3547464/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
