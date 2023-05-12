Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B68D701278
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 01:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240715AbjELXaM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 12 May 2023 19:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240422AbjELXaL (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 12 May 2023 19:30:11 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB881B8
        for <stable@vger.kernel.org>; Fri, 12 May 2023 16:30:10 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-643465067d1so7878985b3a.0
        for <stable@vger.kernel.org>; Fri, 12 May 2023 16:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683934209; x=1686526209;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6trzTPXN+WCdrySYNQn/JigQm/AnHBsxgZtUaAAb2WU=;
        b=OWv8rz6lIVhXaMKo6283fQb52PBqx/x0abKTLgedkrVIuJuJMq8VNwnIGUgjYgzam8
         QaFQ2nZ7cUhkfHA3XMK31Et4ARbqrKbFq4X8AIJ/QeG5E+9Jd8+db8xNlLjHyUFIcye1
         22EVgBbPJRPK3ALCcb5EHEzzf/2u8gjc8DQRuBDIgudgumaQqcw5Jc1i2V1n2Qz/E2sH
         L4xatiA+lwnz2vz52O0iEJ1HaPPiYrnnmOVFXU4Lxawi3X7KvIaawQVTTXVrRTcgD62L
         PPdOhoEfUwQfuATCykXnk0JJhfkpOqigrTWF/BI1ViVcdFMMyIpnfREwFw8GAhlFs9gM
         PrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683934209; x=1686526209;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6trzTPXN+WCdrySYNQn/JigQm/AnHBsxgZtUaAAb2WU=;
        b=UKQaQD8ZbxUztrJOe2hHOhE5kMZmS7UzBMqEocFx+QSyW3X9iX+uzNcCs8eaapwFJo
         71wdJqfrK8+ZUKGUN+huEUHDddHF8nFMyv4uR1pu7NPEtp3sToJsvpPI6te5O6j96ERA
         dQ8FbOkmNS6ArndVnzAvlhvKSIWNKgmuOiassrIO4i2ed+3Gz2//H6/807LTfiH+MbK5
         UUxFGqnS/9SVet8qPlLBMZH4yoywCpc/8NYnTABINOk13lDxZKcK6L6jhRKanb2UEiPl
         thJTNs70fy1UVvqGfSYfVSOejNXsG1iVr7KkGrWGmX59Bws01WE2rTESGQb02pXAZRCx
         X9Fw==
X-Gm-Message-State: AC+VfDwqoe+6QV97O8YFRjQi+twFOl7rmHKOAdNI/WH0P8W2aF1oEQ10
        ZLscaMW+8vdVi9s9Ivnl09HuxptQaixfFj8pkg8=
X-Google-Smtp-Source: ACHHUZ7xbPLAm5jh9wB4v2KX0UzzsazFJE6JRpbQ02Bzdrau8LRmyQopZ0udvZPQKHCKump0Mlonyw==
X-Received: by 2002:a17:902:c40b:b0:1aa:fd48:f5e2 with SMTP id k11-20020a170902c40b00b001aafd48f5e2mr34918694plk.32.1683934209065;
        Fri, 12 May 2023 16:30:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jj18-20020a170903049200b001a1d41d1b8asm8467238plb.194.2023.05.12.16.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 16:30:08 -0700 (PDT)
Message-ID: <645ecc00.170a0220.336bb.1f4a@mx.google.com>
Date:   Fri, 12 May 2023 16:30:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.179-337-gee575f6153d30
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 181 runs,
 8 regressions (v5.10.179-337-gee575f6153d30)
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

stable-rc/queue/5.10 baseline: 181 runs, 8 regressions (v5.10.179-337-gee57=
5f6153d30)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2711-rpi-4-b              | arm64  | lab-linaro-lkft | gcc-10   | defcon=
fig                    | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.179-337-gee575f6153d30/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.179-337-gee575f6153d30
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      ee575f6153d30f3af83d07653e5776e0f30b75e7 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2711-rpi-4-b              | arm64  | lab-linaro-lkft | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/645eb22e2801ea7f852e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-337-gee575f6153d30/arm64/defconfig/gcc-10/lab-linaro-lkft/baseline-bcm2711=
-rpi-4-b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-337-gee575f6153d30/arm64/defconfig/gcc-10/lab-linaro-lkft/baseline-bcm2711=
-rpi-4-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645eb22e2801ea7f852e8=
5e7
        new failure (last pass: v5.10.179-311-g06ff0d7f066c2) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/645e98d69e36e3408b2e8650

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-337-gee575f6153d30/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-337-gee575f6153d30/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645e98d69e36e3408b2e867f
        failing since 87 days (last pass: v5.10.167-127-g921934d621e4, firs=
t fail: v5.10.167-139-gf9519a5a1701)

    2023-05-12T19:51:32.432913  <8>[   19.052584] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 453699_1.5.2.4.1>
    2023-05-12T19:51:32.544874  / # #
    2023-05-12T19:51:32.648177  export SHELL=3D/bin/sh
    2023-05-12T19:51:32.649135  #
    2023-05-12T19:51:32.751269  / # export SHELL=3D/bin/sh. /lava-453699/en=
vironment
    2023-05-12T19:51:32.752201  =

    2023-05-12T19:51:32.854346  / # . /lava-453699/environment/lava-453699/=
bin/lava-test-runner /lava-453699/1
    2023-05-12T19:51:32.855847  =

    2023-05-12T19:51:32.860423  / # /lava-453699/bin/lava-test-runner /lava=
-453699/1
    2023-05-12T19:51:32.963831  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645e9b6d41100814cc2e861a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-337-gee575f6153d30/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-337-gee575f6153d30/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645e9b6d41100814cc2e861f
        failing since 106 days (last pass: v5.10.165-76-g5c2e982fcf18, firs=
t fail: v5.10.165-77-g4600242c13ed)

    2023-05-12T20:02:13.820070  <8>[   11.128211] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3581363_1.5.2.4.1>
    2023-05-12T20:02:13.927620  / # #
    2023-05-12T20:02:14.029373  export SHELL=3D/bin/sh
    2023-05-12T20:02:14.029729  #
    2023-05-12T20:02:14.130797  / # export SHELL=3D/bin/sh. /lava-3581363/e=
nvironment
    2023-05-12T20:02:14.131155  =

    2023-05-12T20:02:14.131316  / # <3>[   11.371745] Bluetooth: hci0: comm=
and 0xfc18 tx timeout
    2023-05-12T20:02:14.232362  . /lava-3581363/environment/lava-3581363/bi=
n/lava-test-runner /lava-3581363/1
    2023-05-12T20:02:14.232931  =

    2023-05-12T20:02:14.237846  / # /lava-3581363/bin/lava-test-runner /lav=
a-3581363/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645e98bb9e36e3408b2e85f7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-337-gee575f6153d30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-337-gee575f6153d30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645e98bb9e36e3408b2e85fc
        failing since 43 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-12T19:51:11.734763  + set +x

    2023-05-12T19:51:11.741188  <8>[   14.934293] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10299409_1.4.2.3.1>

    2023-05-12T19:51:11.845632  / # #

    2023-05-12T19:51:11.946212  export SHELL=3D/bin/sh

    2023-05-12T19:51:11.946384  #

    2023-05-12T19:51:12.046888  / # export SHELL=3D/bin/sh. /lava-10299409/=
environment

    2023-05-12T19:51:12.047088  =


    2023-05-12T19:51:12.147617  / # . /lava-10299409/environment/lava-10299=
409/bin/lava-test-runner /lava-10299409/1

    2023-05-12T19:51:12.147902  =


    2023-05-12T19:51:12.153073  / # /lava-10299409/bin/lava-test-runner /la=
va-10299409/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645e97c487be92589f2e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-337-gee575f6153d30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-337-gee575f6153d30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645e97c487be92589f2e85eb
        failing since 43 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-12T19:47:02.055514  + set +x<8>[   17.930675] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10299359_1.4.2.3.1>

    2023-05-12T19:47:02.056011  =


    2023-05-12T19:47:02.162989  #

    2023-05-12T19:47:02.164082  =


    2023-05-12T19:47:02.265746  / # #export SHELL=3D/bin/sh

    2023-05-12T19:47:02.266496  =


    2023-05-12T19:47:02.368286  / # export SHELL=3D/bin/sh. /lava-10299359/=
environment

    2023-05-12T19:47:02.368962  =


    2023-05-12T19:47:02.470485  / # . /lava-10299359/environment/lava-10299=
359/bin/lava-test-runner /lava-10299359/1

    2023-05-12T19:47:02.471806  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/645e99e9d342db88472e8676

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-337-gee575f6153d30/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-337-gee575f6153d30/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/645e99e9d342db88472e867c
        failing since 59 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-12T19:56:17.387762  <8>[   34.067274] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-05-12T19:56:18.413795  /lava-10299489/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/645e99e9d342db88472e867d
        failing since 59 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-12T19:56:17.376541  /lava-10299489/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645e9a7063492bf4492e861b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-337-gee575f6153d30/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-337-gee575f6153d30/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645e9a7063492bf4492e8620
        failing since 100 days (last pass: v5.10.165-139-gefb57ce0f880, fir=
st fail: v5.10.165-149-ge30e8271d674)

    2023-05-12T19:58:12.769592  / # #
    2023-05-12T19:58:12.872380  export SHELL=3D/bin/sh
    2023-05-12T19:58:12.872974  #
    2023-05-12T19:58:12.974432  / # export SHELL=3D/bin/sh. /lava-3581359/e=
nvironment
    2023-05-12T19:58:12.974983  =

    2023-05-12T19:58:13.076425  / # . /lava-3581359/environment/lava-358135=
9/bin/lava-test-runner /lava-3581359/1
    2023-05-12T19:58:13.077345  =

    2023-05-12T19:58:13.091330  / # /lava-3581359/bin/lava-test-runner /lav=
a-3581359/1
    2023-05-12T19:58:13.183194  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-12T19:58:13.183724  + cd /lava-3581359/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
