Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E9977EDDC
	for <lists+stable@lfdr.de>; Thu, 17 Aug 2023 01:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347190AbjHPXf2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 16 Aug 2023 19:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347185AbjHPXfE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 16 Aug 2023 19:35:04 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FC9211E
        for <stable@vger.kernel.org>; Wed, 16 Aug 2023 16:35:02 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-564b326185bso4244287a12.2
        for <stable@vger.kernel.org>; Wed, 16 Aug 2023 16:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692228901; x=1692833701;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=x2lFqGItrrU5wnhF/1pvVOduMnppIuDejf6Yn/NUY2k=;
        b=T77lckm++Rec8Ayw7kaDAHWTDunFlTWUStR3sMuxvywNrhqeL2Fn/mVCoJQwS43jce
         s8IYbz1nar7n/otBJqu5JcxXZc9u8t5O/yzXdoPWeffwTUA47oIAMsGAPm3YqueQUyC1
         Aiz12IS/4bfeN6ozP2aIloFSZlmULPBeLxxiKUyhgKBzuek1bPbfS+DbFeb4dzVsdsjL
         yWExykgI5Fx8uHpk4QqttcDKYpk0HqGOmW3hVkdtPHSJ0trk+yNUI0bnSiNTk070xKFi
         BOyw09oOFEErPYLH92QVDqTtw69d0oQbVHblrjEW1MFZF9a0MEDj33H8C8G5a5JZgtGn
         7SvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692228901; x=1692833701;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x2lFqGItrrU5wnhF/1pvVOduMnppIuDejf6Yn/NUY2k=;
        b=OoHUuhb++31PxKLNwp+fcVomzzCTcGZEwXR/YqmDfMX0ZzgsYR/vTuWMdI8TTvKlsz
         mh76J7COoCF8iEqclkT05FFMcQJLkQz/IRSvHh/yCONNJfJIscaXtud+9innqvny6hf2
         SFqDc0B5OXDdwHIXiKkiqSWFwP8Ja/ikug1+cI2hcAqiFY+5gmud6idod05Kg3KPlB/k
         OQY4MIJmD7kk2n+5Z3FtEU7NNvjhSdRy6mBvAcaE2Nho2JPx4EmJlcuOuy47jzAyaJJU
         5L2vTGnresQeQBhfeJCQQDIVVK7gz94htXZ8ouuj345T+C+SAteQTtuY4t/5XL3Jif/E
         vd6g==
X-Gm-Message-State: AOJu0YxgRIOctxGNJPjzd/i2WS25QXY/bmLA3rOxoQZNVngKxUS/LpdM
        Do+MKo2Tmry41TWGGRyMckKpAn0B/W8o4rBenMfrZA==
X-Google-Smtp-Source: AGHT+IGy/75bUZ5uwQ3S9rZ2qK4Fp3raH5uAMmJWyUEJ19NJqcUpBjHm7hKWAW+0rAvBVr86M707mA==
X-Received: by 2002:a05:6a20:d408:b0:134:16a3:83ad with SMTP id il8-20020a056a20d40800b0013416a383admr2908355pzb.57.1692228901212;
        Wed, 16 Aug 2023 16:35:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l2-20020a62be02000000b00653fe2d527esm11573926pff.32.2023.08.16.16.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 16:35:00 -0700 (PDT)
Message-ID: <64dd5d24.620a0220.d6eae.60aa@mx.google.com>
Date:   Wed, 16 Aug 2023 16:35:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.191
X-Kernelci-Tree: stable
X-Kernelci-Branch: linux-5.10.y
Subject: stable/linux-5.10.y baseline: 121 runs, 9 regressions (v5.10.191)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-5.10.y baseline: 121 runs, 9 regressions (v5.10.191)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.10.y/kernel=
/v5.10.191/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.10.y
  Describe: v5.10.191
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      da742ebfa00c3add4a358dd79ec92161c07e1435 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd2b43334787944935b1d9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.191/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.191/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd2b43334787944935b=
1da
        new failure (last pass: v5.10.189) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd2b8bb2d0aa38a035b1e6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.191/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.191/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd2b8bb2d0aa38a035b1eb
        failing since 210 days (last pass: v5.10.158, first fail: v5.10.164)

    2023-08-16T20:03:15.137171  + set +x
    2023-08-16T20:03:15.146012  <8>[   11.204263] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3743609_1.5.2.4.1>
    2023-08-16T20:03:15.249830  / # #
    2023-08-16T20:03:15.351144  export SHELL=3D/bin/sh
    2023-08-16T20:03:15.351514  #
    2023-08-16T20:03:15.351684  / # <3>[   11.372530] Bluetooth: hci0: comm=
and 0xfc18 tx timeout
    2023-08-16T20:03:15.452726  export SHELL=3D/bin/sh. /lava-3743609/envir=
onment
    2023-08-16T20:03:15.453128  =

    2023-08-16T20:03:15.554261  / # . /lava-3743609/environment/lava-374360=
9/bin/lava-test-runner /lava-3743609/1
    2023-08-16T20:03:15.554793   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd2fdd28274f5ef335b1ea

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.191/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.191/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd2fde28274f5ef335b1ef
        failing since 133 days (last pass: v5.10.176, first fail: v5.10.177)

    2023-08-16T20:21:46.180881  + set +x

    2023-08-16T20:21:46.187501  <8>[   10.333452] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11302334_1.4.2.3.1>

    2023-08-16T20:21:46.292081  / # #

    2023-08-16T20:21:46.394063  export SHELL=3D/bin/sh

    2023-08-16T20:21:46.394256  #

    2023-08-16T20:21:46.494795  / # export SHELL=3D/bin/sh. /lava-11302334/=
environment

    2023-08-16T20:21:46.495017  =


    2023-08-16T20:21:46.595670  / # . /lava-11302334/environment/lava-11302=
334/bin/lava-test-runner /lava-11302334/1

    2023-08-16T20:21:46.596682  =


    2023-08-16T20:21:46.601313  / # /lava-11302334/bin/lava-test-runner /la=
va-11302334/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd292bef35be65f435b2ba

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.191/=
arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.191/=
arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd292bef35be65f435b2f6
        failing since 7 days (last pass: v5.10.188, first fail: v5.10.189)

    2023-08-16T19:52:43.440873  / # #
    2023-08-16T19:52:43.543873  export SHELL=3D/bin/sh
    2023-08-16T19:52:43.544652  #
    2023-08-16T19:52:43.646588  / # export SHELL=3D/bin/sh. /lava-58366/env=
ironment
    2023-08-16T19:52:43.647426  =

    2023-08-16T19:52:43.749390  / # . /lava-58366/environment/lava-58366/bi=
n/lava-test-runner /lava-58366/1
    2023-08-16T19:52:43.750689  =

    2023-08-16T19:52:43.764770  / # /lava-58366/bin/lava-test-runner /lava-=
58366/1
    2023-08-16T19:52:43.823576  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-16T19:52:43.824083  + cd /lava-58366/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd46db5240ba30bf35b205

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.191/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rz=
g2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.191/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rz=
g2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd46db5240ba30bf35b208
        failing since 20 days (last pass: v5.10.184, first fail: v5.10.188)

    2023-08-16T21:59:27.187199  + set +x
    2023-08-16T21:59:27.187417  <8>[   83.728797] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 998270_1.5.2.4.1>
    2023-08-16T21:59:27.290437  / # #
    2023-08-16T21:59:28.751779  export SHELL=3D/bin/sh
    2023-08-16T21:59:28.772304  #
    2023-08-16T21:59:28.772510  / # export SHELL=3D/bin/sh
    2023-08-16T21:59:30.656770  / # . /lava-998270/environment
    2023-08-16T21:59:34.113332  /lava-998270/bin/lava-test-runner /lava-998=
270/1
    2023-08-16T21:59:34.133967  . /lava-998270/environment
    2023-08-16T21:59:34.134077  / # /lava-998270/bin/lava-test-runner /lava=
-998270/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd2885b7027546fc35b1e6

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.191/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.191/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd2886b7027546fc35b1eb
        failing since 20 days (last pass: v5.10.185, first fail: v5.10.188)

    2023-08-16T19:52:00.501769  / # #

    2023-08-16T19:52:00.602728  export SHELL=3D/bin/sh

    2023-08-16T19:52:00.603464  #

    2023-08-16T19:52:00.704931  / # export SHELL=3D/bin/sh. /lava-11302202/=
environment

    2023-08-16T19:52:00.705656  =


    2023-08-16T19:52:00.807148  / # . /lava-11302202/environment/lava-11302=
202/bin/lava-test-runner /lava-11302202/1

    2023-08-16T19:52:00.808331  =


    2023-08-16T19:52:00.809448  / # /lava-11302202/bin/lava-test-runner /la=
va-11302202/1

    2023-08-16T19:52:00.873728  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-16T19:52:00.874195  + cd /lav<8>[   16.448361] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11302202_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64dd2d0f787dc5d41735b1d9

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.191/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.191/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64dd2d0f787dc5d41735b1df
        failing since 152 days (last pass: v5.10.174, first fail: v5.10.175)

    2023-08-16T20:09:33.540791  <8>[   61.042566] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-08-16T20:09:34.566656  /lava-11302455/1/../bin/lava-test-case

    2023-08-16T20:09:34.576009  <8>[   62.079332] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64dd2d0f787dc5d41735b1e0
        failing since 152 days (last pass: v5.10.174, first fail: v5.10.175)

    2023-08-16T20:09:32.503659  <8>[   60.004837] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-08-16T20:09:33.528945  /lava-11302455/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd289e969ff21d6635b1ee

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.191/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.191/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd289e969ff21d6635b1f3
        failing since 20 days (last pass: v5.10.185, first fail: v5.10.188)

    2023-08-16T19:52:16.454035  / # #

    2023-08-16T19:52:16.556175  export SHELL=3D/bin/sh

    2023-08-16T19:52:16.556910  #

    2023-08-16T19:52:16.658312  / # export SHELL=3D/bin/sh. /lava-11302211/=
environment

    2023-08-16T19:52:16.659023  =


    2023-08-16T19:52:16.760448  / # . /lava-11302211/environment/lava-11302=
211/bin/lava-test-runner /lava-11302211/1

    2023-08-16T19:52:16.761576  =


    2023-08-16T19:52:16.777923  / # /lava-11302211/bin/lava-test-runner /la=
va-11302211/1

    2023-08-16T19:52:16.821191  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-16T19:52:16.835547  + cd /lava-1130221<8>[   18.211897] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11302211_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
