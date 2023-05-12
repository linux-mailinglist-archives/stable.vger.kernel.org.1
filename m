Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52259700123
	for <lists+stable@lfdr.de>; Fri, 12 May 2023 09:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240111AbjELHLz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 12 May 2023 03:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240125AbjELHLM (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 12 May 2023 03:11:12 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A26D11614
        for <stable@vger.kernel.org>; Fri, 12 May 2023 00:09:07 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64ab2a37812so2711202b3a.1
        for <stable@vger.kernel.org>; Fri, 12 May 2023 00:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683875346; x=1686467346;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B/blog8KezUoRG1FYkrrvzaYRFTXC9tJJytN4l1VPRg=;
        b=Z3pBm43mvyHkVr1wMAIYhptv+AmKzMzeMGG4WoW0ienORREb2K+IKJiw0kwi4q2WTe
         dvrBBjYQEPyZqMZ1WFyaRRF0OsoNQMrHQIPE+rfSYh29GhVaqcg0McaQF9UfGGjWjNsQ
         j7Jp357PoYNyibWQb3xKm382HzujJxqov+z+DhfQOkUDmrJHXrABc8St1ZHCTZRNu6i5
         kr9dlSkHWlADgq1OV4RAxcz7hxfJWlubEonHnV0MMhET3sYtIt0Xah7q3Zk7VSI8NXP8
         XLUSh3GreuWkJ6nHu6Sdr8Gmfl4rYa/Z7GNi35Hm2wP4pGVI6HPv2swnbJb92bYCcDKk
         LsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683875346; x=1686467346;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/blog8KezUoRG1FYkrrvzaYRFTXC9tJJytN4l1VPRg=;
        b=SZzWr7Ju7Lxjli5NskxxbXRofAm3jtUF1ezU/3qdKLqTYZhjbZeBH5Xojfct79LnC0
         g2sPC3sld4wFbk4B08nesXvwhmkwybAidfS8rOSz6xEH+ZpMeJgjXG/XonSV9ILz+2Vi
         5XvCIVitpaYE2nV9oJve1nMO5Zpl6ZS6CUOqhuoKHLo14IbeR+WfMk3cjiC5rh5XTeKZ
         9IntdVnWL8x/IrNqAfF+7KNJarlK2b3ytBAWBKbBB1xY/8k0RN2OHM89XbtKcdvOdlP6
         ZWXGMbiKAvdXsSrNTOdHzNU6C6wOhhGUPLO0ECLoNQw7pwpC/+6d+xTpEwtbKzSHLuJ+
         t6BQ==
X-Gm-Message-State: AC+VfDx3DYZNPUMTDLC0RWkPv8E4MKZBNbdAjebeMuFUewr8yXOEqYWk
        Ia13yQCPSqT0xq403kX1fEzc8STvsWBJKTMYBBMS+Q==
X-Google-Smtp-Source: ACHHUZ5x9eeeCQ5A90I5DuESd7wFsApOsoEqRbgiPQZTYRPgeSDrffqNy5o8MXEJNfAQoSQhqKnxmQ==
X-Received: by 2002:a17:902:f54c:b0:1ac:3b69:bb9c with SMTP id h12-20020a170902f54c00b001ac3b69bb9cmr30649656plf.28.1683875346015;
        Fri, 12 May 2023 00:09:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902e88300b001aaffe15f39sm7147694plg.30.2023.05.12.00.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 00:09:05 -0700 (PDT)
Message-ID: <645de611.170a0220.bb693.edc9@mx.google.com>
Date:   Fri, 12 May 2023 00:09:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.179-311-g06ff0d7f066c2
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 181 runs,
 8 regressions (v5.10.179-311-g06ff0d7f066c2)
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

stable-rc/queue/5.10 baseline: 181 runs, 8 regressions (v5.10.179-311-g06ff=
0d7f066c2)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

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
nel/v5.10.179-311-g06ff0d7f066c2/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.179-311-g06ff0d7f066c2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      06ff0d7f066c23b0d2525c5a58a7d2722efeb4be =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645db3cf30008a72aa2e8643

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-311-g06ff0d7f066c2/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at9=
1-sama5d4_xplained.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-311-g06ff0d7f066c2/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at9=
1-sama5d4_xplained.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645db3cf30008a72aa2e8=
644
        new failure (last pass: v5.10.176-650-gfaca4b1ce4622) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/645db093f4d97128212e85ef

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-311-g06ff0d7f066c2/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-311-g06ff0d7f066c2/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645db093f4d97128212e8625
        failing since 87 days (last pass: v5.10.167-127-g921934d621e4, firs=
t fail: v5.10.167-139-gf9519a5a1701)

    2023-05-12T03:20:27.451058  <8>[   16.255859] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 449327_1.5.2.4.1>
    2023-05-12T03:20:27.562399  / # #
    2023-05-12T03:20:27.664843  export SHELL=3D/bin/sh
    2023-05-12T03:20:27.665389  #
    2023-05-12T03:20:27.767149  / # export SHELL=3D/bin/sh. /lava-449327/en=
vironment
    2023-05-12T03:20:27.767745  =

    2023-05-12T03:20:27.870239  / # . /lava-449327/environment/lava-449327/=
bin/lava-test-runner /lava-449327/1
    2023-05-12T03:20:27.871108  =

    2023-05-12T03:20:27.874896  / # /lava-449327/bin/lava-test-runner /lava=
-449327/1
    2023-05-12T03:20:27.974042  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645db2f4f8db751f752e866a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-311-g06ff0d7f066c2/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-311-g06ff0d7f066c2/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645db2f4f8db751f752e866f
        failing since 105 days (last pass: v5.10.165-76-g5c2e982fcf18, firs=
t fail: v5.10.165-77-g4600242c13ed)

    2023-05-12T03:30:51.208348  <8>[   11.072908] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3578241_1.5.2.4.1>
    2023-05-12T03:30:51.315137  / # #
    2023-05-12T03:30:51.416634  export SHELL=3D/bin/sh
    2023-05-12T03:30:51.416997  #
    2023-05-12T03:30:51.518387  / # export SHELL=3D/bin/sh. /lava-3578241/e=
nvironment
    2023-05-12T03:30:51.518909  =

    2023-05-12T03:30:51.620296  / # . /lava-3578241/environment/lava-357824=
1/bin/lava-test-runner /lava-3578241/1
    2023-05-12T03:30:51.620817  =

    2023-05-12T03:30:51.620947  / # /lava-3578241/bin/lava-test-runner /lav=
a-3578241/1<3>[   11.451463] Bluetooth: hci0: command 0xfc18 tx timeout
    2023-05-12T03:30:51.625844   =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645db0915cc196cac62e85fc

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-311-g06ff0d7f066c2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-311-g06ff0d7f066c2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645db0915cc196cac62e8601
        failing since 42 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-12T03:20:43.210737  + set +x

    2023-05-12T03:20:43.216716  <8>[   14.740816] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10289853_1.4.2.3.1>

    2023-05-12T03:20:43.321331  / # #

    2023-05-12T03:20:43.421894  export SHELL=3D/bin/sh

    2023-05-12T03:20:43.422115  #

    2023-05-12T03:20:43.522673  / # export SHELL=3D/bin/sh. /lava-10289853/=
environment

    2023-05-12T03:20:43.522879  =


    2023-05-12T03:20:43.623425  / # . /lava-10289853/environment/lava-10289=
853/bin/lava-test-runner /lava-10289853/1

    2023-05-12T03:20:43.623750  =


    2023-05-12T03:20:43.628621  / # /lava-10289853/bin/lava-test-runner /la=
va-10289853/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645db0935cc196cac62e8607

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-311-g06ff0d7f066c2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-311-g06ff0d7f066c2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645db0935cc196cac62e860c
        failing since 42 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-12T03:20:35.634764  <8>[   14.148758] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10289873_1.4.2.3.1>

    2023-05-12T03:20:35.638425  + set +x

    2023-05-12T03:20:35.739817  =


    2023-05-12T03:20:35.840369  / # #export SHELL=3D/bin/sh

    2023-05-12T03:20:35.840620  =


    2023-05-12T03:20:35.941088  / # export SHELL=3D/bin/sh. /lava-10289873/=
environment

    2023-05-12T03:20:35.941271  =


    2023-05-12T03:20:36.041789  / # . /lava-10289873/environment/lava-10289=
873/bin/lava-test-runner /lava-10289873/1

    2023-05-12T03:20:36.042053  =


    2023-05-12T03:20:36.047089  / # /lava-10289873/bin/lava-test-runner /la=
va-10289873/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/645db587fba640c3882e8635

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-311-g06ff0d7f066c2/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-311-g06ff0d7f066c2/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/645db587fba640c3882e863b
        failing since 59 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-12T03:41:52.800275  /lava-10290190/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/645db587fba640c3882e863c
        failing since 59 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-12T03:41:51.763922  /lava-10290190/1/../bin/lava-test-case

    2023-05-12T03:41:51.775487  <8>[   34.430351] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645db2e25fbd6eff422e8605

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-311-g06ff0d7f066c2/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-311-g06ff0d7f066c2/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645db2e25fbd6eff422e860a
        failing since 99 days (last pass: v5.10.165-139-gefb57ce0f880, firs=
t fail: v5.10.165-149-ge30e8271d674)

    2023-05-12T03:30:15.748882  / # #
    2023-05-12T03:30:15.850716  export SHELL=3D/bin/sh
    2023-05-12T03:30:15.851086  #
    2023-05-12T03:30:15.952403  / # export SHELL=3D/bin/sh. /lava-3578237/e=
nvironment
    2023-05-12T03:30:15.952817  =

    2023-05-12T03:30:16.054166  / # . /lava-3578237/environment/lava-357823=
7/bin/lava-test-runner /lava-3578237/1
    2023-05-12T03:30:16.054786  =

    2023-05-12T03:30:16.059821  / # /lava-3578237/bin/lava-test-runner /lav=
a-3578237/1
    2023-05-12T03:30:16.157683  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-12T03:30:16.158173  + cd /lava-3578237/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
