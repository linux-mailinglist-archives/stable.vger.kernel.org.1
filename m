Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AE36F0669
	for <lists+stable@lfdr.de>; Thu, 27 Apr 2023 15:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243588AbjD0NMY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Apr 2023 09:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243404AbjD0NMX (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Apr 2023 09:12:23 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED44F0
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 06:12:22 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63b46186c03so9806130b3a.3
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 06:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682601141; x=1685193141;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EYaod5zDmjpaeXKhNym/0+hkxBBxUK7U07nVz/BHmgw=;
        b=GcjT1/c2SB7mG+HUHxgGIKGg1s+V7YwV0yrROK0txBGwhAM7UUV1VtZiWVESrWQyC9
         POL06fvJFqB9IzLc9Q1A07EwB1Tp7l70t9Pv22SIZ9ys8I1s/jaSsY4LZdQne8EI6aIB
         9qGq+hPCfNJ2i8hMlzkVS+B43VnOXw8aSz7i0aSjiR/3r6L9Za2YAdXOm9403fwZjRcS
         Rm4DLNXNmUSgeZ71MFJ9pqa54Yl77z0JGSD1r0zr8S60vnPXjnWNdiRkEZKCu3wmQItx
         qk0/sAdwsfHVNwLvlV7eRlCkp+Q96BLPVogfvXrZzmFnDHbdArTdqKdgT7SXtauZ8T48
         g9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682601141; x=1685193141;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EYaod5zDmjpaeXKhNym/0+hkxBBxUK7U07nVz/BHmgw=;
        b=kJIRtVucSbr/eNxP3XdL41TyyoAQMT/VhN9nVjX4TCo6C0UDdQ71q76X3HVWV8NjEu
         7wXRxL8N3joAjcrSXn8tAZXhz+2ZXohDNA7Hu26/MSBGljMN2fT3miXaMK2QMcTTnm8x
         R9EpqSw59gDvwlIUZx4aCEgYDSIP4FVjsN5VDYep27HNn5V4jStC7Ywykr+fd5BDmJfn
         Gy12fYvnY8mBpVHm+RsSAhjzAoSZwXjyeuKIV/pyDpu71iccDcbvS/JJX4oyMeAwKpQt
         8S+WlwHcX/vvjnFFhPTK/lPPHGVUEl1B3jOk1dowQMbGCEzt2gEa7PeVdkKruWNK2Tvm
         7Aqg==
X-Gm-Message-State: AC+VfDxcez5TTtDDt1Mz+qxr2FX6boAkP+Gd6jrVIcNPQO0A5NIZMpLs
        F0UjA83tCotDfm7K2VzI15i+X+xDNVKJQpmOAzgC6g==
X-Google-Smtp-Source: ACHHUZ7VlCgRiXBKBl+MrtDdc+M0nSvKY8ziPBVyEEbwzzNcwYKy4eEwfUfS2v9qq1p527wlKpRGcg==
X-Received: by 2002:a05:6a21:398e:b0:f0:3917:5b20 with SMTP id ad14-20020a056a21398e00b000f039175b20mr1997632pzc.31.1682601141145;
        Thu, 27 Apr 2023 06:12:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k24-20020a6568d8000000b00520b677c645sm11486391pgt.41.2023.04.27.06.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 06:12:20 -0700 (PDT)
Message-ID: <644a74b4.650a0220.505a2.76e4@mx.google.com>
Date:   Thu, 27 Apr 2023 06:12:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.176-364-g4696eda40cdc
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 140 runs,
 8 regressions (v5.10.176-364-g4696eda40cdc)
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

stable-rc/queue/5.10 baseline: 140 runs, 8 regressions (v5.10.176-364-g4696=
eda40cdc)

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
nel/v5.10.176-364-g4696eda40cdc/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.176-364-g4696eda40cdc
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      4696eda40cdc0bf402c28729f691817b7befe687 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2711-rpi-4-b              | arm64  | lab-linaro-lkft | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644a43a8303a83f79f2e8644

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-364-g4696eda40cdc/arm64/defconfig/gcc-10/lab-linaro-lkft/baseline-bcm2711-=
rpi-4-b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-364-g4696eda40cdc/arm64/defconfig/gcc-10/lab-linaro-lkft/baseline-bcm2711-=
rpi-4-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644a43a8303a83f79f2e8=
645
        new failure (last pass: v5.10.176-359-g7760085da5bd1) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/644a3dce45f3dbac152e8616

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-364-g4696eda40cdc/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-364-g4696eda40cdc/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a3dce45f3dbac152e864a
        failing since 72 days (last pass: v5.10.167-127-g921934d621e4, firs=
t fail: v5.10.167-139-gf9519a5a1701)

    2023-04-27T09:17:46.198682  <8>[   19.092580] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 393241_1.5.2.4.1>
    2023-04-27T09:17:46.309310  / # #
    2023-04-27T09:17:46.411800  export SHELL=3D/bin/sh
    2023-04-27T09:17:46.412472  #
    2023-04-27T09:17:46.514693  / # export SHELL=3D/bin/sh. /lava-393241/en=
vironment
    2023-04-27T09:17:46.515368  =

    2023-04-27T09:17:46.617281  / # . /lava-393241/environment/lava-393241/=
bin/lava-test-runner /lava-393241/1
    2023-04-27T09:17:46.618283  =

    2023-04-27T09:17:46.622916  / # /lava-393241/bin/lava-test-runner /lava=
-393241/1
    2023-04-27T09:17:46.726968  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644a3fa9e32c50b3d52e85f4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-364-g4696eda40cdc/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-364-g4696eda40cdc/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a3fa9e32c50b3d52e85f9
        failing since 90 days (last pass: v5.10.165-76-g5c2e982fcf18, first=
 fail: v5.10.165-77-g4600242c13ed)

    2023-04-27T09:25:51.463730  + set +x<8>[   11.105794] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3536642_1.5.2.4.1>
    2023-04-27T09:25:51.463915  =

    2023-04-27T09:25:51.569992  / # #
    2023-04-27T09:25:51.671451  export SHELL=3D/bin/sh
    2023-04-27T09:25:51.671822  #
    2023-04-27T09:25:51.773056  / # export SHELL=3D/bin/sh. /lava-3536642/e=
nvironment
    2023-04-27T09:25:51.773425  =

    2023-04-27T09:25:51.874697  / # . /lava-3536642/environment/lava-353664=
2/bin/lava-test-runner /lava-3536642/1
    2023-04-27T09:25:51.875260  =

    2023-04-27T09:25:51.881264  / # /lava-3536642/bin/lava-test-runner /lav=
a-3536642/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a3fc64f8e8d1e912e85ea

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-364-g4696eda40cdc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-364-g4696eda40cdc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a3fc64f8e8d1e912e85ef
        failing since 27 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-04-27T09:26:19.831277  + set +x

    2023-04-27T09:26:19.837513  <8>[   14.937131] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10140716_1.4.2.3.1>

    2023-04-27T09:26:19.941920  / # #

    2023-04-27T09:26:20.042691  export SHELL=3D/bin/sh

    2023-04-27T09:26:20.042944  #

    2023-04-27T09:26:20.143507  / # export SHELL=3D/bin/sh. /lava-10140716/=
environment

    2023-04-27T09:26:20.143702  =


    2023-04-27T09:26:20.244292  / # . /lava-10140716/environment/lava-10140=
716/bin/lava-test-runner /lava-10140716/1

    2023-04-27T09:26:20.244574  =


    2023-04-27T09:26:20.248652  / # /lava-10140716/bin/lava-test-runner /la=
va-10140716/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a3f90849062085e2e861a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-364-g4696eda40cdc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-364-g4696eda40cdc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a3f90849062085e2e861f
        failing since 27 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-04-27T09:25:18.378163  <8>[   12.915566] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10140666_1.4.2.3.1>

    2023-04-27T09:25:18.381332  + set +x

    2023-04-27T09:25:18.483071  =


    2023-04-27T09:25:18.583684  / # #export SHELL=3D/bin/sh

    2023-04-27T09:25:18.583897  =


    2023-04-27T09:25:18.684427  / # export SHELL=3D/bin/sh. /lava-10140666/=
environment

    2023-04-27T09:25:18.684657  =


    2023-04-27T09:25:18.785229  / # . /lava-10140666/environment/lava-10140=
666/bin/lava-test-runner /lava-10140666/1

    2023-04-27T09:25:18.785535  =


    2023-04-27T09:25:18.790218  / # /lava-10140666/bin/lava-test-runner /la=
va-10140666/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/644a445d88ed96b2e62e85f7

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-364-g4696eda40cdc/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-364-g4696eda40cdc/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/644a445d88ed96b2e62e85fd
        failing since 44 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-04-27T09:45:57.368378  /lava-10140861/1/../bin/lava-test-case

    2023-04-27T09:45:57.379777  <8>[   34.997093] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/644a445d88ed96b2e62e85fe
        failing since 44 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-04-27T09:45:56.331008  /lava-10140861/1/../bin/lava-test-case

    2023-04-27T09:45:56.342450  <8>[   33.959805] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644a704c5d995538dc2e85fb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-364-g4696eda40cdc/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-364-g4696eda40cdc/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a704c5d995538dc2e8600
        failing since 84 days (last pass: v5.10.165-139-gefb57ce0f880, firs=
t fail: v5.10.165-149-ge30e8271d674)

    2023-04-27T12:53:05.696805  / # #
    2023-04-27T12:53:05.798460  export SHELL=3D/bin/sh
    2023-04-27T12:53:05.798811  #
    2023-04-27T12:53:05.900082  / # export SHELL=3D/bin/sh. /lava-3536646/e=
nvironment
    2023-04-27T12:53:05.900453  =

    2023-04-27T12:53:06.001864  / # . /lava-3536646/environment/lava-353664=
6/bin/lava-test-runner /lava-3536646/1
    2023-04-27T12:53:06.002614  =

    2023-04-27T12:53:06.009274  / # /lava-3536646/bin/lava-test-runner /lav=
a-3536646/1
    2023-04-27T12:53:06.107157  + export 'TESTRUN_ID=3D1_bootrr'
    2023-04-27T12:53:06.107438  + cd /lava-3536646/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
