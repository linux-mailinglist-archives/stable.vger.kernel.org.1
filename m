Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687416FC3E0
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 12:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbjEIKaj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 06:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjEIKai (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 06:30:38 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77EFDC58
        for <stable@vger.kernel.org>; Tue,  9 May 2023 03:30:36 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6434e65d808so6000927b3a.3
        for <stable@vger.kernel.org>; Tue, 09 May 2023 03:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683628236; x=1686220236;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r25IzfELsZY6/oYNhAs19vrDIJf1x1EIDes/yw2Q160=;
        b=VJ0D9TlaFpE9QMsQNK5xKQPM3h4PEiCvCSraKFqjIWe9s0uTNQgPHu0D97gpsjWPus
         qp2DQOokpMBpOatvFZTviV0IrQp8ROE2IscwLZparmrx4BzMR5UC0DmCaED/OcVP9nm+
         G7CkkenATSn9y1kgQ907xTitXaziMQ6O53X7v1ebveWhjXvPWuplfns2xlhVoK5saISa
         L4IQwPmRbl8uxrERwDQtZ+LWoX5FFDGrE+9w6yerS8kF7b0sqLELdB3NMhOjmpI/0hy7
         79y3TDJ+olNq7rP5q9J3jbyKWUsciDN6e+4tf2GafjHltuhseeaZoPnIVPlVttH1HHZO
         zpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683628236; x=1686220236;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r25IzfELsZY6/oYNhAs19vrDIJf1x1EIDes/yw2Q160=;
        b=bxMSgCuKp1d0+2XEdmy/CB1BzM90Hpsqjy5bmkustmaNBBnBhA5wc5M9gGFN8Lr2Lk
         cvCb85Lu1acuWN5ikWzqOU6Af0V1ZXj6+nzSRZVkCUUYNtLhildvIggQSR9nGi6LVL0v
         ip5ABYiHcmzQ5Gkw4sM6DyCfxfNSg9c+V1syRr1UId3Gp2PecI03FL6llTUG3pOFOV9E
         dhswFm4Lg18EJjm4xA9sFKgxlyBWBPsvQIEUu+oNfQW9WuxrukzUOdnAY8Jdw9ewXEH0
         UO+NTqR5bqFgUNxh5fTv2iJrQar9/co76pPed+BTRQYhABzvs03dKlbSpuC2hWKH/wNP
         7AQQ==
X-Gm-Message-State: AC+VfDxn+Ne2HTQiUmOPkDSjW6y7M97TYz+Rp4tvO80961nZs6TYuFIm
        sl8gx8thvcviC/gSWRpblAFPS3OgVPok72gcQJqjGg==
X-Google-Smtp-Source: ACHHUZ7rGI8nk1LGBILznbFkm1nAn5eRORGsoCkyTjcFgvo/F11bbXvLtbd24E8L1E/nxy8UeAEymA==
X-Received: by 2002:a05:6a00:2408:b0:63f:18ae:1d5f with SMTP id z8-20020a056a00240800b0063f18ae1d5fmr16931806pfh.29.1683628235299;
        Tue, 09 May 2023 03:30:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s145-20020a632c97000000b0050bc4ca9024sm1014807pgs.65.2023.05.09.03.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 03:30:34 -0700 (PDT)
Message-ID: <645a20ca.630a0220.336ca.1ba4@mx.google.com>
Date:   Tue, 09 May 2023 03:30:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.176-657-g136d893091a8
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 156 runs,
 6 regressions (v5.10.176-657-g136d893091a8)
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

stable-rc/queue/5.10 baseline: 156 runs, 6 regressions (v5.10.176-657-g136d=
893091a8)

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
nel/v5.10.176-657-g136d893091a8/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.176-657-g136d893091a8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      136d893091a8fe99c6c7eb99dc5299ddb4f85d3b =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6459f0978a44a758642e8617

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-657-g136d893091a8/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-657-g136d893091a8/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459f0978a44a758642e864d
        failing since 84 days (last pass: v5.10.167-127-g921934d621e4, firs=
t fail: v5.10.167-139-gf9519a5a1701)

    2023-05-09T07:04:35.181438  <8>[   19.385139] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 433580_1.5.2.4.1>
    2023-05-09T07:04:35.289636  / # #
    2023-05-09T07:04:35.392446  export SHELL=3D/bin/sh
    2023-05-09T07:04:35.393190  #
    2023-05-09T07:04:35.495037  / # export SHELL=3D/bin/sh. /lava-433580/en=
vironment
    2023-05-09T07:04:35.495782  =

    2023-05-09T07:04:35.598217  / # . /lava-433580/environment/lava-433580/=
bin/lava-test-runner /lava-433580/1
    2023-05-09T07:04:35.599329  =

    2023-05-09T07:04:35.604442  / # /lava-433580/bin/lava-test-runner /lava=
-433580/1
    2023-05-09T07:04:35.699557  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459ec9781fd0ca0632e8610

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-657-g136d893091a8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-657-g136d893091a8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459ec9781fd0ca0632e8614
        failing since 39 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-09T06:47:40.476513  + set +x

    2023-05-09T06:47:40.482645  <8>[   10.262346] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10251576_1.4.2.3.1>

    2023-05-09T06:47:40.587044  / # #

    2023-05-09T06:47:40.687694  export SHELL=3D/bin/sh

    2023-05-09T06:47:40.687891  #

    2023-05-09T06:47:40.788524  / # export SHELL=3D/bin/sh. /lava-10251576/=
environment

    2023-05-09T06:47:40.789317  =


    2023-05-09T06:47:40.890782  / # . /lava-10251576/environment/lava-10251=
576/bin/lava-test-runner /lava-10251576/1

    2023-05-09T06:47:40.891950  =


    2023-05-09T06:47:40.896528  / # /lava-10251576/bin/lava-test-runner /la=
va-10251576/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459ec8db4cb930d932e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-657-g136d893091a8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-657-g136d893091a8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459ec8db4cb930d932e85eb
        failing since 39 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-09T06:47:27.389085  + set<8>[   12.955355] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10251582_1.4.2.3.1>

    2023-05-09T06:47:27.389577   +x

    2023-05-09T06:47:27.498457  #

    2023-05-09T06:47:27.601360  / # #export SHELL=3D/bin/sh

    2023-05-09T06:47:27.602163  =


    2023-05-09T06:47:27.703730  / # export SHELL=3D/bin/sh. /lava-10251582/=
environment

    2023-05-09T06:47:27.704602  =


    2023-05-09T06:47:27.806276  / # . /lava-10251582/environment/lava-10251=
582/bin/lava-test-runner /lava-10251582/1

    2023-05-09T06:47:27.808440  =


    2023-05-09T06:47:27.813273  / # /lava-10251582/bin/lava-test-runner /la=
va-10251582/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6459eede6c620591ff2e8616

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-657-g136d893091a8/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-657-g136d893091a8/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6459eede6c620591ff2e861c
        failing since 56 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-09T06:57:25.764570  /lava-10251962/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6459eede6c620591ff2e861d
        failing since 56 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-09T06:57:23.702199  <8>[   31.397571] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-05-09T06:57:24.727628  /lava-10251962/1/../bin/lava-test-case

    2023-05-09T06:57:24.737408  <8>[   32.435451] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6459ee48ef60e61c762e866c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-657-g136d893091a8/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-657-g136d893091a8/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459ee48ef60e61c762e8671
        failing since 96 days (last pass: v5.10.165-139-gefb57ce0f880, firs=
t fail: v5.10.165-149-ge30e8271d674)

    2023-05-09T06:54:40.990650  / # #
    2023-05-09T06:54:41.092569  export SHELL=3D/bin/sh
    2023-05-09T06:54:41.092994  #
    2023-05-09T06:54:41.194285  / # export SHELL=3D/bin/sh. /lava-3567253/e=
nvironment
    2023-05-09T06:54:41.194724  =

    2023-05-09T06:54:41.296039  / # . /lava-3567253/environment/lava-356725=
3/bin/lava-test-runner /lava-3567253/1
    2023-05-09T06:54:41.296764  =

    2023-05-09T06:54:41.314539  / # /lava-3567253/bin/lava-test-runner /lav=
a-3567253/1
    2023-05-09T06:54:41.406579  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-09T06:54:41.407148  + cd /lava-3567253/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
