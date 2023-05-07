Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CED6F9C84
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 00:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjEGWj4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 18:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjEGWj4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 18:39:56 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EC0100DF
        for <stable@vger.kernel.org>; Sun,  7 May 2023 15:39:52 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1aaf7067647so25717455ad.0
        for <stable@vger.kernel.org>; Sun, 07 May 2023 15:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683499191; x=1686091191;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=APvP4hwE/RPNOwva5kPLp3Nqr5CWYUZ1kVY6hXlHG3k=;
        b=i9sArMwesB30XnlC8S7xCl21MFVT9mfT1gU1t24LC6CGfWZMuMb9qBRW0FWLGeoP8w
         5BklMvT3Jemw/RV5ZkEZXPaRWdIvr903D6jlN8eUqluU6DJLzMBvIkMwUybDoHEHC/pd
         tvoZWhz2YqnNYa8hZgqUFzibbobfQqUewAxPpGEvSDr3ITL/wLm0RLrCcTo76LgrpChN
         /GAoPdkG5272nL2x6tpHBDSIhxzgjAkB74/iwS2Fs4xseT+sWr1rdGMq9ZoMzdWpLNYz
         /6tgye/erSjv8io7seE39rawntspSR+5LkpIqGKWtNFg2EVMZLdk6xEY6X8yUCzIfVcN
         zdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683499191; x=1686091191;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=APvP4hwE/RPNOwva5kPLp3Nqr5CWYUZ1kVY6hXlHG3k=;
        b=C0KvGrs1/wIGYwQ+Utw88oTJ/KNRAi4yNeGGUqdX6J9WQkErdx5IPp1+mUMMOKxxPd
         eKj4JJsX2GqZzMp9O9pggGQ4We+QUael+KMQsgKFhNgC4bKwHfQBG3VMfZGYhh2WqhOJ
         /SynhoCBl73ISC6PZHS/EVYE8GkmbOVBP0kaa4zFGQrj7D7BgTkgMq2T/FacJXc3cQOm
         oUSt2st6jzA59Sw+DYeBJkMQ8OgTNwFFzBTnJEJKHlZuf9omAckITzfbnc+tN4bcKNhf
         D8eRDmJLSSQKurTKtShN65GGYH/ZM1fqDIZ6WFXgpqL4rdWBiloGJC+wtdxwXMTd9jlp
         gUaA==
X-Gm-Message-State: AC+VfDzgQodhquGjt9/b5lpuLbRKo7O83nLhebVHhwAb9YPdMzLBL8W/
        rehyFH4Mdju5Bwu6GzQqrdLszvNOxW0MUAC+wozrKA==
X-Google-Smtp-Source: ACHHUZ5I/P9ijBHf0LgtMdBtzQN4ahnAA5D4ycLYe15CMhhLHTeaNz6q76r+4Whwj+7vQVqbsgzN3A==
X-Received: by 2002:a17:902:6b03:b0:1a6:a1ec:53a3 with SMTP id o3-20020a1709026b0300b001a6a1ec53a3mr8727977plk.3.1683499190823;
        Sun, 07 May 2023 15:39:50 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902bc4900b001ac55a5e5eesm3296407plz.121.2023.05.07.15.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 15:39:50 -0700 (PDT)
Message-ID: <645828b6.170a0220.eaf25.5075@mx.google.com>
Date:   Sun, 07 May 2023 15:39:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.176-650-gfaca4b1ce4622
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 121 runs,
 6 regressions (v5.10.176-650-gfaca4b1ce4622)
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

stable-rc/queue/5.10 baseline: 121 runs, 6 regressions (v5.10.176-650-gfaca=
4b1ce4622)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.176-650-gfaca4b1ce4622/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.176-650-gfaca4b1ce4622
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      faca4b1ce46226db1a75e6c88b06c69fd8a7663f =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6457f3cae35737be692e8601

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-650-gfaca4b1ce4622/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-650-gfaca4b1ce4622/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457f3cae35737be692e8633
        failing since 82 days (last pass: v5.10.167-127-g921934d621e4, firs=
t fail: v5.10.167-139-gf9519a5a1701)

    2023-05-07T18:53:42.775963  <8>[   19.634609] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 424550_1.5.2.4.1>
    2023-05-07T18:53:42.888610  / # #
    2023-05-07T18:53:42.992004  export SHELL=3D/bin/sh
    2023-05-07T18:53:42.992912  #
    2023-05-07T18:53:43.094975  / # export SHELL=3D/bin/sh. /lava-424550/en=
vironment
    2023-05-07T18:53:43.095828  =

    2023-05-07T18:53:43.197970  / # . /lava-424550/environment/lava-424550/=
bin/lava-test-runner /lava-424550/1
    2023-05-07T18:53:43.199317  =

    2023-05-07T18:53:43.203134  / # /lava-424550/bin/lava-test-runner /lava=
-424550/1
    2023-05-07T18:53:43.311298  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457f1fe61f2dc14ac2e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-650-gfaca4b1ce4622/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-650-gfaca4b1ce4622/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457f1fe61f2dc14ac2e85eb
        failing since 38 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-07T18:45:58.884089  + set +x

    2023-05-07T18:45:58.890211  <8>[   15.367906] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10231298_1.4.2.3.1>

    2023-05-07T18:45:58.994644  / # #

    2023-05-07T18:45:59.095339  export SHELL=3D/bin/sh

    2023-05-07T18:45:59.095549  #

    2023-05-07T18:45:59.196081  / # export SHELL=3D/bin/sh. /lava-10231298/=
environment

    2023-05-07T18:45:59.196294  =


    2023-05-07T18:45:59.296785  / # . /lava-10231298/environment/lava-10231=
298/bin/lava-test-runner /lava-10231298/1

    2023-05-07T18:45:59.297124  =


    2023-05-07T18:45:59.302468  / # /lava-10231298/bin/lava-test-runner /la=
va-10231298/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457f1fb0512656c372e85f7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-650-gfaca4b1ce4622/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-650-gfaca4b1ce4622/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457f1fb0512656c372e85fc
        failing since 38 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-07T18:46:04.783594  + set<8>[   11.816471] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10231300_1.4.2.3.1>

    2023-05-07T18:46:04.783680   +x

    2023-05-07T18:46:04.885247  #

    2023-05-07T18:46:04.986093  / # #export SHELL=3D/bin/sh

    2023-05-07T18:46:04.986312  =


    2023-05-07T18:46:05.086862  / # export SHELL=3D/bin/sh. /lava-10231300/=
environment

    2023-05-07T18:46:05.087035  =


    2023-05-07T18:46:05.187603  / # . /lava-10231300/environment/lava-10231=
300/bin/lava-test-runner /lava-10231300/1

    2023-05-07T18:46:05.187856  =


    2023-05-07T18:46:05.192932  / # /lava-10231300/bin/lava-test-runner /la=
va-10231300/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6457f1d6b9dd21b9a62e85f8

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-650-gfaca4b1ce4622/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-650-gfaca4b1ce4622/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6457f1d6b9dd21b9a62e85fe
        failing since 54 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-07T18:45:34.507641  /lava-10231233/1/../bin/lava-test-case

    2023-05-07T18:45:34.518382  <8>[   33.419365] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6457f1d6b9dd21b9a62e85ff
        failing since 54 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-07T18:45:33.471568  /lava-10231233/1/../bin/lava-test-case

    2023-05-07T18:45:33.482340  <8>[   32.383513] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6457f3420b62fdfd7c2e862a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-650-gfaca4b1ce4622/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-650-gfaca4b1ce4622/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457f3420b62fdfd7c2e862f
        failing since 94 days (last pass: v5.10.165-139-gefb57ce0f880, firs=
t fail: v5.10.165-149-ge30e8271d674)

    2023-05-07T18:51:27.582556  / # #
    2023-05-07T18:51:27.684219  export SHELL=3D/bin/sh
    2023-05-07T18:51:27.684585  #
    2023-05-07T18:51:27.785873  / # export SHELL=3D/bin/sh. /lava-3561760/e=
nvironment
    2023-05-07T18:51:27.786241  =

    2023-05-07T18:51:27.887576  / # . /lava-3561760/environment/lava-356176=
0/bin/lava-test-runner /lava-3561760/1
    2023-05-07T18:51:27.888184  =

    2023-05-07T18:51:27.893957  / # /lava-3561760/bin/lava-test-runner /lav=
a-3561760/1
    2023-05-07T18:51:27.991811  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-07T18:51:27.992329  + cd /lava-3561760/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
