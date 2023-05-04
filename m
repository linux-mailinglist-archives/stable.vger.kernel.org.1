Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B7F6F6415
	for <lists+stable@lfdr.de>; Thu,  4 May 2023 06:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjEDEhT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 4 May 2023 00:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjEDEhT (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 4 May 2023 00:37:19 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206F1E5A
        for <stable@vger.kernel.org>; Wed,  3 May 2023 21:37:17 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1aaec6f189cso35475545ad.3
        for <stable@vger.kernel.org>; Wed, 03 May 2023 21:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683175036; x=1685767036;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yELaqqbm7Y3Wl4wd9pAxXzYI4Bvv+gI3W2NBmB/lZSA=;
        b=SKlJuujpLqWJjfk+2MDPw8HmOA3iE4GsIjcanB6SjdWMTq/3skUY92BE8BSlmMpbFF
         bC7lUOExWchhbivBqMrVE1gH0sNxSOW9jm9dTTBxn2XKaPm9OM9kjFMU+Cb6TVuoJsjt
         Mt0+/j5alMSX3C6LkwuLvxedKf3WneQCjvmCE8shkRoTDHt1xoxpEzkr/NY78MFFckmA
         4KS41PkeefxQ1NacZcLjRMM2OYJLwWEaNYK9FxgP/43xCCtsFvwGEvcfPGJcofZ7aLa8
         b97Yj8U5xURk3kJ5i156AQeqhtxkNdiWc4jwNXYVvtdfgwl5cxAP07ULnDuf9azM4tAd
         +1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683175036; x=1685767036;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yELaqqbm7Y3Wl4wd9pAxXzYI4Bvv+gI3W2NBmB/lZSA=;
        b=ToZ3JzqX6FETElk2j7uoma3Cn9p+JUARl3BeQa0YHmCQg868hb7v69U7h/ujUZhr6O
         5j0eKZcZgTReT6sLER8AUadGnStrnrNkCu8F1JyOQQc3WRwDuCOTJQqBgoBKoeMuKpWD
         Xu/omUfzi+Cazr34t6olxRhZRwwl0dvz8nc+G660Kcju9rvSHP1TSS0bVDM3Hr4Eic4J
         l9wD60MbSahEFKWhUoyam75Uv8xoRHmFGNm1nB5q9Yp4PvQjodQTp0HAtUl8+iLHzKUE
         HYT0GLavaxNXW7D2ch6Ni73/HaNznpJx+7Gq+6v8u3GJOVESw9kPzrsBx1nVRQ9+wJgg
         EEqg==
X-Gm-Message-State: AC+VfDwFumKbOBZ9IPeEpUI5Wd45U9eZsm/4nM2j4UBoEg3+HWSu8ame
        uOrZbjf1iODSyyAdjaE3seQ9tEi0e4PF/T+vR4+Fdg==
X-Google-Smtp-Source: ACHHUZ5UGFzNQtI8w6VtKbHvSY6LHGd7GWGnyKgE7sXFiMff5GTEZ+NQiX6tMzwVobbzGYvHKwTgUA==
X-Received: by 2002:a17:902:e810:b0:19d:297:f30b with SMTP id u16-20020a170902e81000b0019d0297f30bmr2905695plg.19.1683175035904;
        Wed, 03 May 2023 21:37:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902ea8b00b001a6b2813c13sm347221plb.172.2023.05.03.21.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 21:37:15 -0700 (PDT)
Message-ID: <6453367b.170a0220.f23e6.0e1f@mx.google.com>
Date:   Wed, 03 May 2023 21:37:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.176-378-gf09e1800957b
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 159 runs,
 10 regressions (v5.10.176-378-gf09e1800957b)
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

stable-rc/queue/5.10 baseline: 159 runs, 10 regressions (v5.10.176-378-gf09=
e1800957b)

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

meson-g12a-sei510            | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

rk3328-rock64                | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.176-378-gf09e1800957b/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.176-378-gf09e1800957b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      f09e1800957b172a2464db1b25c772405ccd9266 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2711-rpi-4-b              | arm64  | lab-linaro-lkft | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/645305c64034cc9eec2e8694

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-378-gf09e1800957b/arm64/defconfig/gcc-10/lab-linaro-lkft/baseline-bcm2711-=
rpi-4-b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-378-gf09e1800957b/arm64/defconfig/gcc-10/lab-linaro-lkft/baseline-bcm2711-=
rpi-4-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645305c64034cc9eec2e8=
695
        new failure (last pass: v5.10.176-377-g36f574493abf) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/645303539771ee8be52e8621

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-378-gf09e1800957b/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-378-gf09e1800957b/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645303549771ee8be52e8650
        failing since 79 days (last pass: v5.10.167-127-g921934d621e4, firs=
t fail: v5.10.167-139-gf9519a5a1701)

    2023-05-04T00:58:41.002004  <8>[   21.120176] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 409687_1.5.2.4.1>
    2023-05-04T00:58:41.110496  / # #
    2023-05-04T00:58:41.212655  export SHELL=3D/bin/sh
    2023-05-04T00:58:41.213245  #
    2023-05-04T00:58:41.315000  / # export SHELL=3D/bin/sh. /lava-409687/en=
vironment
    2023-05-04T00:58:41.315747  =

    2023-05-04T00:58:41.418187  / # . /lava-409687/environment/lava-409687/=
bin/lava-test-runner /lava-409687/1
    2023-05-04T00:58:41.419259  =

    2023-05-04T00:58:41.424036  / # /lava-409687/bin/lava-test-runner /lava=
-409687/1
    2023-05-04T00:58:41.527054  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6453029057ee5fb7742e8677

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-378-gf09e1800957b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-378-gf09e1800957b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6453029057ee5fb7742e867c
        failing since 97 days (last pass: v5.10.165-76-g5c2e982fcf18, first=
 fail: v5.10.165-77-g4600242c13ed)

    2023-05-04T00:55:36.255022  <8>[   11.260227] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3549658_1.5.2.4.1>
    2023-05-04T00:55:36.365600  / # #
    2023-05-04T00:55:36.470118  export SHELL=3D/bin/sh
    2023-05-04T00:55:36.471416  #
    2023-05-04T00:55:36.574071  / # export SHELL=3D/bin/sh. /lava-3549658/e=
nvironment
    2023-05-04T00:55:36.575412  =

    2023-05-04T00:55:36.678636  / # . /lava-3549658/environment/lava-354965=
8/bin/lava-test-runner /lava-3549658/1
    2023-05-04T00:55:36.680599  =

    2023-05-04T00:55:36.685820  / # /lava-3549658/bin/lava-test-runner /lav=
a-3549658/1
    2023-05-04T00:55:36.770235  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645304ef754fbe17a32e8601

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-378-gf09e1800957b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-378-gf09e1800957b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645304ef754fbe17a32e8606
        failing since 34 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-04T01:05:33.909785  + <8>[   10.244465] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10189928_1.4.2.3.1>

    2023-05-04T01:05:33.909878  set +x

    2023-05-04T01:05:34.011131  #

    2023-05-04T01:05:34.011522  =


    2023-05-04T01:05:34.112136  / # #export SHELL=3D/bin/sh

    2023-05-04T01:05:34.112347  =


    2023-05-04T01:05:34.212856  / # export SHELL=3D/bin/sh. /lava-10189928/=
environment

    2023-05-04T01:05:34.213077  =


    2023-05-04T01:05:34.313643  / # . /lava-10189928/environment/lava-10189=
928/bin/lava-test-runner /lava-10189928/1

    2023-05-04T01:05:34.313981  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645302d8baf5bf4e622e85e9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-378-gf09e1800957b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-378-gf09e1800957b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645302d8baf5bf4e622e85ee
        failing since 34 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-04T00:56:38.285793  <8>[   12.852686] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10189947_1.4.2.3.1>

    2023-05-04T00:56:38.288923  + set +x

    2023-05-04T00:56:38.391262  =


    2023-05-04T00:56:38.492049  / # #export SHELL=3D/bin/sh

    2023-05-04T00:56:38.492322  =


    2023-05-04T00:56:38.592943  / # export SHELL=3D/bin/sh. /lava-10189947/=
environment

    2023-05-04T00:56:38.593215  =


    2023-05-04T00:56:38.693861  / # . /lava-10189947/environment/lava-10189=
947/bin/lava-test-runner /lava-10189947/1

    2023-05-04T00:56:38.694207  =


    2023-05-04T00:56:38.699151  / # /lava-10189947/bin/lava-test-runner /la=
va-10189947/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
meson-g12a-sei510            | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6453069b0e733120fc2e8638

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-378-gf09e1800957b/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-g12a-=
sei510.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-378-gf09e1800957b/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-g12a-=
sei510.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6453069b0e733120fc2e8=
639
        new failure (last pass: v5.10.176-377-g36f574493abf) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3328-rock64                | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6453059678eb436cd32e85ed

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-378-gf09e1800957b/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-378-gf09e1800957b/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6453059678eb436cd32e85f2
        failing since 92 days (last pass: v5.10.155-149-g63e308de12c9, firs=
t fail: v5.10.165-142-gc53eb88edf7e)

    2023-05-04T01:08:17.099030  [   15.988928] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3549715_1.5.2.4.1>
    2023-05-04T01:08:17.203285  =

    2023-05-04T01:08:17.203509  / # [   16.001236] rockchip-drm display-sub=
system: [drm] Cannot find any crtc or sizes
    2023-05-04T01:08:17.304798  #export SHELL=3D/bin/sh
    2023-05-04T01:08:17.305251  =

    2023-05-04T01:08:17.406634  / # export SHELL=3D/bin/sh. /lava-3549715/e=
nvironment
    2023-05-04T01:08:17.407094  =

    2023-05-04T01:08:17.508442  / # . /lava-3549715/environment/lava-354971=
5/bin/lava-test-runner /lava-3549715/1
    2023-05-04T01:08:17.509130  =

    2023-05-04T01:08:17.512726  / # /lava-3549715/bin/lava-test-runner /lav=
a-3549715/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64530700ca763497fb2e861a

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-378-gf09e1800957b/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-378-gf09e1800957b/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64530700ca763497fb2e8620
        failing since 50 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-04T01:14:21.453916  <8>[   34.021144] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-05-04T01:14:22.479604  /lava-10190158/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64530700ca763497fb2e8621
        failing since 50 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-04T01:14:21.442022  /lava-10190158/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645302892cbbd3124c2e85e9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-378-gf09e1800957b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-378-gf09e1800957b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645302892cbbd3124c2e85ee
        failing since 91 days (last pass: v5.10.165-139-gefb57ce0f880, firs=
t fail: v5.10.165-149-ge30e8271d674)

    2023-05-04T00:55:21.688113  / # #
    2023-05-04T00:55:21.789903  export SHELL=3D/bin/sh
    2023-05-04T00:55:21.790300  #
    2023-05-04T00:55:21.891630  / # export SHELL=3D/bin/sh. /lava-3549650/e=
nvironment
    2023-05-04T00:55:21.892002  =

    2023-05-04T00:55:21.993403  / # . /lava-3549650/environment/lava-354965=
0/bin/lava-test-runner /lava-3549650/1
    2023-05-04T00:55:21.994042  =

    2023-05-04T00:55:21.999290  / # /lava-3549650/bin/lava-test-runner /lav=
a-3549650/1
    2023-05-04T00:55:22.063425  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-04T00:55:22.097973  + cd /lava-3549650/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
