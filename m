Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2365A714CF1
	for <lists+stable@lfdr.de>; Mon, 29 May 2023 17:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjE2PZH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 29 May 2023 11:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjE2PZG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 29 May 2023 11:25:06 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6155BE5
        for <stable@vger.kernel.org>; Mon, 29 May 2023 08:25:03 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-52cb78647ecso2100596a12.1
        for <stable@vger.kernel.org>; Mon, 29 May 2023 08:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685373902; x=1687965902;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XLs9X9Ttge0epQUFzFN8aly3Uv/XMAaI5PzRKwgzTyA=;
        b=0TibXPD9EKtQo6y4A9T/P1YeeWcFa//UjK08iT9tdq9EoiN8moe1OXVYHl+JcdKGSs
         U+83Yj/1NIcC6vQZvR3AfgT5qKJIqYYUhtL7FrWZvSLpkkZLue57pcn2URqL+LtpZPSI
         klUUniU0gRUocwM5ZVTYT1UyCgI4qQEsPllOG9pG0h55kpK2K9u4jUNwSLEdQ/UPkyQV
         wXTtNf3FhbIYosmZmP8YfgRag/oYxoQiS7nHqxeOYegGvH/P/JEhIZET+7fSmDWmG4L6
         JbTg/mjxgaNW/U6DuGr+pz2taAqDdLYKtnwTY8zotzR5VlGnoJx9BBBXxtGT5ecdfudd
         +NYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685373902; x=1687965902;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XLs9X9Ttge0epQUFzFN8aly3Uv/XMAaI5PzRKwgzTyA=;
        b=JsUb0drecuYjIjp2S4C8QFVMuE9kBiglPFIQCmFu2a3NGG+KyMj90wY6JXC6Z4eFmx
         AXreSWcAWNSyafJ645WS1Fig8USIOpEBuUwS8AYMLAqJvoTOY0k0ejc106EYSRYilEJy
         DfsO439Wjcgwq6FN0FFNwqvVdAhlEoAbYV3v43n91oyK9ImgVpXKA1vVOn36HAUqwjTQ
         g1r8u5Z5Hest9wNHMKsWUQ0aPyrYFTHWMFcG/U0Dfqvnd36PPD4RgnvpSBhMDaPKdw2k
         5MFcTrh2iEBPZiKWKj5bdzkLpssxpROtahTr/ACk0sevHKoGRV45ApQ65UaRtxHL9rXq
         dZpg==
X-Gm-Message-State: AC+VfDyYUaIBCH7Y24w3IYtw08G5ntkfVXDBquLibiSl3On7+Q6kHByp
        0WxnpR1EvACTo078X8f/BxGH4hdb4q0xC5uCAri7Rw==
X-Google-Smtp-Source: ACHHUZ7bwDyPDUumAq3Svhx8NsVKW2RVs2wVD31YuZaz6IgQyWSSFl9S+0rLJJRmSBU0WduRkklH2g==
X-Received: by 2002:a17:902:e5d0:b0:1a9:9ace:3e74 with SMTP id u16-20020a170902e5d000b001a99ace3e74mr13694005plf.65.1685373902307;
        Mon, 29 May 2023 08:25:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jf11-20020a170903268b00b001b03f89daffsm2632319plb.110.2023.05.29.08.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 08:25:01 -0700 (PDT)
Message-ID: <6474c3cd.170a0220.e8620.3def@mx.google.com>
Date:   Mon, 29 May 2023 08:25:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.180-211-gd08ac8b9f867
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 156 runs,
 7 regressions (v5.10.180-211-gd08ac8b9f867)
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

stable-rc/queue/5.10 baseline: 156 runs, 7 regressions (v5.10.180-211-gd08a=
c8b9f867)

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

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.180-211-gd08ac8b9f867/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.180-211-gd08ac8b9f867
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      d08ac8b9f86760afc6d32c6bb959aaf64420a487 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6474904aa0364764262e8619

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-gd08ac8b9f867/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-gd08ac8b9f867/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6474904aa0364764262e864a
        failing since 104 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-05-29T11:44:54.510945  <8>[   20.173273] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 530920_1.5.2.4.1>
    2023-05-29T11:44:54.622243  / # #
    2023-05-29T11:44:54.725343  export SHELL=3D/bin/sh
    2023-05-29T11:44:54.725895  #
    2023-05-29T11:44:54.827739  / # export SHELL=3D/bin/sh. /lava-530920/en=
vironment
    2023-05-29T11:44:54.828863  =

    2023-05-29T11:44:54.931628  / # . /lava-530920/environment/lava-530920/=
bin/lava-test-runner /lava-530920/1
    2023-05-29T11:44:54.932569  =

    2023-05-29T11:44:54.938498  / # /lava-530920/bin/lava-test-runner /lava=
-530920/1
    2023-05-29T11:44:55.041275  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6474913c0cf446a6d92e867f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-gd08ac8b9f867/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-gd08ac8b9f867/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6474913c0cf446a6d92e8684
        failing since 122 days (last pass: v5.10.165-76-g5c2e982fcf18, firs=
t fail: v5.10.165-77-g4600242c13ed)

    2023-05-29T11:48:49.017880  <8>[   11.077765] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3629752_1.5.2.4.1>
    2023-05-29T11:48:49.129161  / # #
    2023-05-29T11:48:49.233384  export SHELL=3D/bin/sh
    2023-05-29T11:48:49.234905  #
    2023-05-29T11:48:49.337581  / # export SHELL=3D/bin/sh. /lava-3629752/e=
nvironment
    2023-05-29T11:48:49.338691  =

    2023-05-29T11:48:49.339264  / # . /lava-3629752/environment<3>[   11.37=
1943] Bluetooth: hci0: command 0x0c03 tx timeout
    2023-05-29T11:48:49.441966  /lava-3629752/bin/lava-test-runner /lava-36=
29752/1
    2023-05-29T11:48:49.443923  =

    2023-05-29T11:48:49.448411  / # /lava-3629752/bin/lava-test-runner /lav=
a-3629752/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64748d9bc0915d84f42e85fe

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-gd08ac8b9f867/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-gd08ac8b9f867/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64748d9bc0915d84f42e8603
        failing since 60 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-29T11:33:35.438964  + set +x

    2023-05-29T11:33:35.445492  <8>[   14.741786] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10508218_1.4.2.3.1>

    2023-05-29T11:33:35.549897  / # #

    2023-05-29T11:33:35.650530  export SHELL=3D/bin/sh

    2023-05-29T11:33:35.650737  #

    2023-05-29T11:33:35.751283  / # export SHELL=3D/bin/sh. /lava-10508218/=
environment

    2023-05-29T11:33:35.751475  =


    2023-05-29T11:33:35.852013  / # . /lava-10508218/environment/lava-10508=
218/bin/lava-test-runner /lava-10508218/1

    2023-05-29T11:33:35.852304  =


    2023-05-29T11:33:35.856859  / # /lava-10508218/bin/lava-test-runner /la=
va-10508218/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64748d464f5432b5fc2e8626

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-gd08ac8b9f867/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-gd08ac8b9f867/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64748d464f5432b5fc2e862b
        failing since 60 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-29T11:32:11.857393  <8>[   12.415494] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10508258_1.4.2.3.1>

    2023-05-29T11:32:11.860220  + set +x

    2023-05-29T11:32:11.961317  #

    2023-05-29T11:32:12.061992  / # #export SHELL=3D/bin/sh

    2023-05-29T11:32:12.062144  =


    2023-05-29T11:32:12.162607  / # export SHELL=3D/bin/sh. /lava-10508258/=
environment

    2023-05-29T11:32:12.162747  =


    2023-05-29T11:32:12.263213  / # . /lava-10508258/environment/lava-10508=
258/bin/lava-test-runner /lava-10508258/1

    2023-05-29T11:32:12.263437  =


    2023-05-29T11:32:12.268541  / # /lava-10508258/bin/lava-test-runner /la=
va-10508258/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64748e878da7dab8ff2e8614

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-gd08ac8b9f867/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-gd08ac8b9f867/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64748e878da7dab8ff2e861a
        failing since 76 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-29T11:37:21.680686  /lava-10508295/1/../bin/lava-test-case

    2023-05-29T11:37:21.692413  <8>[   33.338030] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64748e878da7dab8ff2e861b
        failing since 76 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-29T11:37:20.645498  /lava-10508295/1/../bin/lava-test-case

    2023-05-29T11:37:20.657223  <8>[   32.302506] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6474910fafd76047f82e8601

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-gd08ac8b9f867/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-gd08ac8b9f867/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6474910fafd76047f82e8606
        failing since 116 days (last pass: v5.10.165-139-gefb57ce0f880, fir=
st fail: v5.10.165-149-ge30e8271d674)

    2023-05-29T11:48:08.360660  / # #
    2023-05-29T11:48:08.462323  export SHELL=3D/bin/sh
    2023-05-29T11:48:08.462668  #
    2023-05-29T11:48:08.563977  / # export SHELL=3D/bin/sh. /lava-3629748/e=
nvironment
    2023-05-29T11:48:08.564391  =

    2023-05-29T11:48:08.665729  / # . /lava-3629748/environment/lava-362974=
8/bin/lava-test-runner /lava-3629748/1
    2023-05-29T11:48:08.666326  =

    2023-05-29T11:48:08.672021  / # /lava-3629748/bin/lava-test-runner /lav=
a-3629748/1
    2023-05-29T11:48:08.736087  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-29T11:48:08.775917  + cd /lava-3629748/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
