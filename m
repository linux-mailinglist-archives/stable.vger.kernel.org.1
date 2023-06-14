Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238A7730185
	for <lists+stable@lfdr.de>; Wed, 14 Jun 2023 16:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbjFNOSv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 14 Jun 2023 10:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245397AbjFNOSt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Jun 2023 10:18:49 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5243E5
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 07:18:47 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-666785456adso257447b3a.3
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 07:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686752326; x=1689344326;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZhCBmi7ya5VYNjLH87zQcXwC1Zlr7rzCHC8REwbdzg=;
        b=jJe8uHDWladp9p8hYmwC1jmgvMLb0SML1Joh3qn+p0HoSkCZ86VYxMQH6S/kM6s6b3
         LMZylV2EEzR76zu6BnU3twm31vOnu524MlvVStR3LL3RZ+q7WmrQw8JiFP5oQTw1+TS1
         wRgiOYo/AmP2BfTwWis3mT9Ww0lu4cZlM06CYXmEq4om8ybFN8wV/ZsV3kbFxEJLnWjv
         V/AGN8jszNj4fBUeXk0vAZKU0sFrM1R5KQDDPI3OJmD5cZUVBeVXQKPpyQBvt7b34BbF
         01iq2UXAdaj+p0ZjaV0ctJ5d3NEdi/wgx56nQNEDEnlQXhyQsbk1OSw3XDNQ5Ur50Ws+
         a20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686752326; x=1689344326;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZZhCBmi7ya5VYNjLH87zQcXwC1Zlr7rzCHC8REwbdzg=;
        b=ddLIjOtxNVoJ1VR/kJImpmUfcJ1TV56t9kbyAaHKMsjJTyTdSSKy9gIhJjSNdB7F9A
         mvjTaqdcJIH2bHDOaZybm7uT4JjtSDoUJGDr3H+o6F56yDPAv+wd3Xk1zaBdKRiUJI0J
         QWhTcDbh+cJ3WcwbTc1L4KdY7j2cln/dnKSO15d63x/LnpzcxUJBjkaAua+ir9uqZkcZ
         8B0jXplv3wqc1T2IFzTKFaG35bdrN7ynDzOUBAAHnZP2YrrFIZyRT/LLK7oSGwY5gMDZ
         U28oUjknySGl312pPR01bGBTN5CrJOCbOrDxFNb9lWmthTtIBBCjLdzVqLmvtIvMuJ/r
         ESGQ==
X-Gm-Message-State: AC+VfDxs+xfVZ82sDQL0wt20EaVbzGSCXDm/ZQu2s5FU9HZoiTvtzoT+
        9x4pNmYWga1fNScdjzW1zksfE/bs3aB28t2uaawNAg==
X-Google-Smtp-Source: ACHHUZ6avZ+qPSkt3+rJ1S9nb4jXzuNNI6YDcnGACakqC2qPhhXYUiCPh05f4u2agMCZwTQC+QJ1Ag==
X-Received: by 2002:a17:902:b08f:b0:1b1:76dc:95ca with SMTP id p15-20020a170902b08f00b001b176dc95camr10771423plr.25.1686752326290;
        Wed, 14 Jun 2023 07:18:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c20c00b001ac2c3e54adsm6414853pll.118.2023.06.14.07.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 07:18:45 -0700 (PDT)
Message-ID: <6489cc45.170a0220.f8ae.cfbb@mx.google.com>
Date:   Wed, 14 Jun 2023 07:18:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.184
Subject: stable/linux-5.10.y baseline: 177 runs, 8 regressions (v5.10.184)
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

stable/linux-5.10.y baseline: 177 runs, 8 regressions (v5.10.184)

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

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =

rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.10.y/kernel=
/v5.10.184/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.10.y
  Describe: v5.10.184
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      a1f0beb13d9b8955e00caa48f909462fb70e6f73 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648997a5e61b48a481306145

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.184/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.184/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648997a5e61b48a48130614a
        failing since 146 days (last pass: v5.10.158, first fail: v5.10.164)

    2023-06-14T10:33:51.134546  <8>[   11.008742] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3663828_1.5.2.4.1>
    2023-06-14T10:33:51.241253  / # #
    2023-06-14T10:33:51.342702  export SHELL=3D/bin/sh
    2023-06-14T10:33:51.343064  #
    2023-06-14T10:33:51.444175  / # export SHELL=3D/bin/sh. /lava-3663828/e=
nvironment
    2023-06-14T10:33:51.444669  =

    2023-06-14T10:33:51.444865  / # . /lava-3663828/environment<3>[   11.29=
1995] Bluetooth: hci0: command 0x0c03 tx timeout
    2023-06-14T10:33:51.546009  /lava-3663828/bin/lava-test-runner /lava-36=
63828/1
    2023-06-14T10:33:51.546689  =

    2023-06-14T10:33:51.551445  / # /lava-3663828/bin/lava-test-runner /lav=
a-3663828/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6489951dd4423915b4306139

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.184/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.184/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489951dd4423915b430613e
        failing since 69 days (last pass: v5.10.176, first fail: v5.10.177)

    2023-06-14T10:23:10.543540  + set +x

    2023-06-14T10:23:10.549993  <8>[   10.892827] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10722596_1.4.2.3.1>

    2023-06-14T10:23:10.654396  / # #

    2023-06-14T10:23:10.754952  export SHELL=3D/bin/sh

    2023-06-14T10:23:10.755130  #

    2023-06-14T10:23:10.855599  / # export SHELL=3D/bin/sh. /lava-10722596/=
environment

    2023-06-14T10:23:10.855782  =


    2023-06-14T10:23:10.956253  / # . /lava-10722596/environment/lava-10722=
596/bin/lava-test-runner /lava-10722596/1

    2023-06-14T10:23:10.956549  =


    2023-06-14T10:23:10.961449  / # /lava-10722596/bin/lava-test-runner /la=
va-10722596/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64899326b0d01b1de030613b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.184/=
arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.184/=
arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64899326b0d01b1de0306=
13c
        failing since 4 days (last pass: v5.10.182, first fail: v5.10.183) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64899b4f90b254b75f30619d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.184/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.184/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64899b4f90b254b75f3061a2
        failing since 133 days (last pass: v5.10.146, first fail: v5.10.166)

    2023-06-14T10:49:43.634149  [   15.947292] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3663945_1.5.2.4.1>
    2023-06-14T10:49:43.738493  =

    2023-06-14T10:49:43.738630  / # #[   16.033223] rockchip-drm display-su=
bsystem: [drm] Cannot find any crtc or sizes
    2023-06-14T10:49:43.839902  export SHELL=3D/bin/sh
    2023-06-14T10:49:43.840236  =

    2023-06-14T10:49:43.941341  / # export SHELL=3D/bin/sh. /lava-3663945/e=
nvironment
    2023-06-14T10:49:43.941605  =

    2023-06-14T10:49:44.042734  / # . /lava-3663945/environment/lava-366394=
5/bin/lava-test-runner /lava-3663945/1
    2023-06-14T10:49:44.043471  =

    2023-06-14T10:49:44.047064  / # /lava-3663945/bin/lava-test-runner /lav=
a-3663945/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64899ba6ec7e3489ea30612f

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.184/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.184/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64899ba6ec7e3489ea306135
        failing since 88 days (last pass: v5.10.174, first fail: v5.10.175)

    2023-06-14T10:50:57.831974  <8>[   32.377329] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-06-14T10:50:58.856525  /lava-10722958/1/../bin/lava-test-case

    2023-06-14T10:50:58.867537  <8>[   33.413932] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64899ba6ec7e3489ea306136
        failing since 88 days (last pass: v5.10.174, first fail: v5.10.175)

    2023-06-14T10:50:56.795892  <8>[   31.340691] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-06-14T10:50:57.820042  /lava-10722958/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64899ee55f735c0ea630616c

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.184/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.184/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64899ee55f735c0ea6306198
        failing since 133 days (last pass: v5.10.154, first fail: v5.10.166)

    2023-06-14T11:04:48.318402  + set +x
    2023-06-14T11:04:48.322295  <8>[   17.155370] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3663954_1.5.2.4.1>
    2023-06-14T11:04:48.443536  / # #
    2023-06-14T11:04:48.549200  export SHELL=3D/bin/sh
    2023-06-14T11:04:48.550689  #
    2023-06-14T11:04:48.654168  / # export SHELL=3D/bin/sh. /lava-3663954/e=
nvironment
    2023-06-14T11:04:48.655681  =

    2023-06-14T11:04:48.759168  / # . /lava-3663954/environment/lava-366395=
4/bin/lava-test-runner /lava-3663954/1
    2023-06-14T11:04:48.762183  =

    2023-06-14T11:04:48.765953  / # /lava-3663954/bin/lava-test-runner /lav=
a-3663954/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64899b8e9dfff70f1330613c

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.184/=
arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.184/=
arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64899b8e9dfff70f13306168
        failing since 133 days (last pass: v5.10.154, first fail: v5.10.166)

    2023-06-14T10:50:26.009058  <8>[   17.239403] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 609446_1.5.2.4.1>
    2023-06-14T10:50:26.121161  / # #
    2023-06-14T10:50:26.223542  export SHELL=3D/bin/sh
    2023-06-14T10:50:26.224078  #
    2023-06-14T10:50:26.325688  / # export SHELL=3D/bin/sh. /lava-609446/en=
vironment
    2023-06-14T10:50:26.326388  =

    2023-06-14T10:50:26.428185  / # . /lava-609446/environment/lava-609446/=
bin/lava-test-runner /lava-609446/1
    2023-06-14T10:50:26.429374  =

    2023-06-14T10:50:26.432287  / # /lava-609446/bin/lava-test-runner /lava=
-609446/1
    2023-06-14T10:50:26.476309  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
