Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69FE6F1D82
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 19:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346262AbjD1ReK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 13:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346442AbjD1ReH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 13:34:07 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669005FD0
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 10:34:05 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1a6715ee82fso2385865ad.1
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 10:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682703244; x=1685295244;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IuxmU+LpHDqQ5f6PPtw6C22SjK+JNDncfmdnHbzAgJ0=;
        b=XpIi5Eji/zqfhLyIfUbrDgP5MFg3S+s9nOgOL+d9a64cyFB5gTZWJRZOuvM5Xf80Mw
         nt+hVSZb2Uv/4+P5IJ7AkJnepb2u+4LwngrdbOCT6MoJblKNDlkKIWc1hr3eCyBtQkKt
         +FqWXddOefYES6jayhrMxgbYntzBAzSNmTHDOLx17503G57wL1YIfBGp6I7WuS1BXjpV
         1sRDXv9rgdUd/ScCxmJQjNJU3kHoHdczspBVCZWimUvlmJbBJz49/gs5fCDEjD5bNKzA
         Wjmx/te5icfCk4A8xnWrR5dBv7QxWuPdO006ZJhvo7TER+J0yCmvMXgYwDNyHJhUjIN6
         qlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682703244; x=1685295244;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IuxmU+LpHDqQ5f6PPtw6C22SjK+JNDncfmdnHbzAgJ0=;
        b=RAm82EIjsOWEy8vi+mBktc37zFujphjfeQqOc+hZ95KDte+2648Ei6KnUqIByI9yGK
         XNkfy0bwPLhtZ4+ZaOcZD7fbBU5EWumWVO74lQo+vays8MIL2/oEda8RyTnxRetyqZin
         a8xYTJ1/m1dGNZI9EikrDTlPs4JFsdbpWXoAzNlJWg1H3eKI9k00kUeiySO64AGZD9zp
         Xxl/W/tt00MUbOv8LWzi5W7ASoB52dFeemiWbcDHF9zF9jx+2mUnyxqLe5Vu7IYqBd+r
         C1xM8zzlypSrzsXgJL/JEP35UqSE9ns3yndaXaqbDo97KveN4PDlkiN7VIvME0EWBV51
         50bw==
X-Gm-Message-State: AC+VfDz0Dm7n5jp0kTU2P2MLAHJf/JlsS+lpLKA3A4/zSCgG9Gxdo25M
        pzuekhMPpcGrx00kXBisQ2C4SBkzSwSPnVJakoQ=
X-Google-Smtp-Source: ACHHUZ7WEc0LKfoxKsaQphB3C+bkSc6MI1jOzcVvXaY3tbQueKg2QYjmIYU8Ki930ZiAqxXMHAO3kQ==
X-Received: by 2002:a17:902:d48e:b0:1a6:7510:170a with SMTP id c14-20020a170902d48e00b001a67510170amr6964997plg.11.1682703244447;
        Fri, 28 Apr 2023 10:34:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k7-20020a170902ba8700b001a6d4ea7301sm1928167pls.251.2023.04.28.10.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 10:34:03 -0700 (PDT)
Message-ID: <644c038b.170a0220.5e3cf.502d@mx.google.com>
Date:   Fri, 28 Apr 2023 10:34:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.176-373-g8415c0f9308b
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.10.y baseline: 167 runs,
 5 regressions (v5.10.176-373-g8415c0f9308b)
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

stable-rc/linux-5.10.y baseline: 167 runs, 5 regressions (v5.10.176-373-g84=
15c0f9308b)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.176-373-g8415c0f9308b/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.176-373-g8415c0f9308b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      8415c0f9308b2ea53507909d35a35f0e69e18a6d =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644bce78c9d27636972e85eb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
76-373-g8415c0f9308b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
76-373-g8415c0f9308b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bce78c9d27636972e85f0
        failing since 100 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-04-28T13:47:22.771729  <8>[   11.136650] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3541093_1.5.2.4.1>
    2023-04-28T13:47:22.882070  / # #
    2023-04-28T13:47:22.985660  export SHELL=3D/bin/sh
    2023-04-28T13:47:22.986985  #
    2023-04-28T13:47:23.089541  / # export SHELL=3D/bin/sh. /lava-3541093/e=
nvironment
    2023-04-28T13:47:23.090897  =

    2023-04-28T13:47:23.193424  / # . /lava-3541093/environment/lava-354109=
3/bin/lava-test-runner /lava-3541093/1
    2023-04-28T13:47:23.195068  =

    2023-04-28T13:47:23.195533  / # /lava-3541093/bin/lava-test-runner /lav=
a-3541093/1<3>[   11.531706] Bluetooth: hci0: command 0xfc18 tx timeout
    2023-04-28T13:47:23.199921   =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bc9552f08631bc12e8639

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
76-373-g8415c0f9308b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
76-373-g8415c0f9308b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bc9552f08631bc12e863e
        failing since 30 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-04-28T13:25:32.003876  + set +x

    2023-04-28T13:25:32.010306  <8>[   14.935846] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10151592_1.4.2.3.1>

    2023-04-28T13:25:32.115055  / # #

    2023-04-28T13:25:32.215773  export SHELL=3D/bin/sh

    2023-04-28T13:25:32.216008  #

    2023-04-28T13:25:32.316559  / # export SHELL=3D/bin/sh. /lava-10151592/=
environment

    2023-04-28T13:25:32.316819  =


    2023-04-28T13:25:32.417409  / # . /lava-10151592/environment/lava-10151=
592/bin/lava-test-runner /lava-10151592/1

    2023-04-28T13:25:32.417733  =


    2023-04-28T13:25:32.422128  / # /lava-10151592/bin/lava-test-runner /la=
va-10151592/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bc96612b85de2b42e8659

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
76-373-g8415c0f9308b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
76-373-g8415c0f9308b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bc96612b85de2b42e865e
        failing since 30 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-04-28T13:25:34.762516  <8>[   12.534496] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10151578_1.4.2.3.1>

    2023-04-28T13:25:34.765290  + set +x

    2023-04-28T13:25:34.866751  =


    2023-04-28T13:25:34.967391  / # #export SHELL=3D/bin/sh

    2023-04-28T13:25:34.967573  =


    2023-04-28T13:25:35.068139  / # export SHELL=3D/bin/sh. /lava-10151578/=
environment

    2023-04-28T13:25:35.068314  =


    2023-04-28T13:25:35.168932  / # . /lava-10151578/environment/lava-10151=
578/bin/lava-test-runner /lava-10151578/1

    2023-04-28T13:25:35.169243  =


    2023-04-28T13:25:35.174206  / # /lava-10151578/bin/lava-test-runner /la=
va-10151578/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644bc8116e4fae1b052e860b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
76-373-g8415c0f9308b/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-ro=
ck64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
76-373-g8415c0f9308b/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-ro=
ck64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bc8116e4fae1b052e8610
        new failure (last pass: v5.10.147)

    2023-04-28T13:20:04.842434  [   15.947795] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3541038_1.5.2.4.1>
    2023-04-28T13:20:04.947073  =

    2023-04-28T13:20:04.947300  / # #[   16.030552] rockchip-drm display-su=
bsystem: [drm] Cannot find any crtc or sizes
    2023-04-28T13:20:05.048700  export SHELL=3D/bin/sh
    2023-04-28T13:20:05.049118  =

    2023-04-28T13:20:05.150455  / # export SHELL=3D/bin/sh. /lava-3541038/e=
nvironment
    2023-04-28T13:20:05.150912  =

    2023-04-28T13:20:05.252307  / # . /lava-3541038/environment/lava-354103=
8/bin/lava-test-runner /lava-3541038/1
    2023-04-28T13:20:05.253039  =

    2023-04-28T13:20:05.256541  / # /lava-3541038/bin/lava-test-runner /lav=
a-3541038/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644bce4ef038d5112d2e85f0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
76-373-g8415c0f9308b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-st=
m32mp157c-dk2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
76-373-g8415c0f9308b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-st=
m32mp157c-dk2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bce4ef038d5112d2e85f5
        failing since 84 days (last pass: v5.10.147, first fail: v5.10.166-=
10-g6278b8c9832e)

    2023-04-28T13:46:41.998999  <8>[   19.137562] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3541089_1.5.2.4.1>
    2023-04-28T13:46:42.105355  / # #
    2023-04-28T13:46:42.206836  export SHELL=3D/bin/sh
    2023-04-28T13:46:42.207178  #
    2023-04-28T13:46:42.308361  / # export SHELL=3D/bin/sh. /lava-3541089/e=
nvironment
    2023-04-28T13:46:42.308714  =

    2023-04-28T13:46:42.409910  / # . /lava-3541089/environment/lava-354108=
9/bin/lava-test-runner /lava-3541089/1
    2023-04-28T13:46:42.410426  =

    2023-04-28T13:46:42.415039  / # /lava-3541089/bin/lava-test-runner /lav=
a-3541089/1
    2023-04-28T13:46:42.479979  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
