Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCF47029B6
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 11:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjEOJ5m (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 05:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240214AbjEOJ5b (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 05:57:31 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3718210E7
        for <stable@vger.kernel.org>; Mon, 15 May 2023 02:57:29 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6439d505274so7770472b3a.0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 02:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684144648; x=1686736648;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Xjbgvlu4i4StcMZYaWBWUon5Vq3lzLh2mvBnAwcZP9c=;
        b=CwKL1+XwRSb8Tx30UagbmkzlLiaDKy3D4TZT5f3XJI4r/K86kmWuAZZeY2paZsVRR7
         tWQXoomR1rOWnUJCLayPRHtn9ObiF85KnjDhasGAI9dW/JOc6sjh/d3BApISaReZQejZ
         A5daaD0ZADEXxML6oLirdri1j3goVcu5pF7PKVOFDGCgVuK9aTc3WuqiJW1OoYmP3abo
         QblAmbJiPKep9tE3bdtU2nMop/tuDJ4Q7Gfz44NMBxGhrCYcxGCSGmz5CqxuN0+p8jzE
         SoOgNoR2l2EhQq2Ci5zs0pTwJEY+QNUfQYp+LzCqBfoeZLQU3CVejOrK+al86rAYxieY
         JtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684144648; x=1686736648;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xjbgvlu4i4StcMZYaWBWUon5Vq3lzLh2mvBnAwcZP9c=;
        b=IZTy81ZChrWV0Imrf9ASYXftIfQ5Zq/j5R8xt0qxajuG6nzQVzjPFrbi2TmAkO1oW5
         3pP8G2cdYeEotkF5JQGsP2YHk12SUu9ogf1mN+w5AhDxEitq/+081Yk1B0BIDlwXZemi
         hERylD6hk/uTjpjf9zW1v/qIkmStyUozIcAl78EXoVnheZqHkoaiC5yMUoOL77AjfRdn
         r8IIzOlpdGlzw0n1ectTa9+jBF5JJkhbvGEgCBHHaErisbLOve3vdJ0LnSUbRTvWoUfS
         GRpD8jxe+VXFI8bEJUBItP4VuA5kVqeOfTbtPFn9QXV3HkcHZ5EMnSKogl9FsWWqAe1x
         GvCw==
X-Gm-Message-State: AC+VfDy7i67LO+2n1YIVVYM+B9AYX2eY30lfXiExpHmUe2dXTTWiyx9D
        cQDzE49YU4afE86Rp2PKOLcvS+yRIlIIW37RD/grvg==
X-Google-Smtp-Source: ACHHUZ4q+l/9Ed6j8QNY3pSW9WjNgD7HX636CPzRSXYMOUnCWepI6HDTlkhcodhgTQJW27SebfbgMg==
X-Received: by 2002:a05:6a00:814:b0:64c:ae1c:3385 with SMTP id m20-20020a056a00081400b0064cae1c3385mr1915685pfk.32.1684144648075;
        Mon, 15 May 2023 02:57:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i2-20020aa79082000000b0062dba4e4706sm11058252pfa.191.2023.05.15.02.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 02:57:27 -0700 (PDT)
Message-ID: <64620207.a70a0220.59803.4635@mx.google.com>
Date:   Mon, 15 May 2023 02:57:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.179-371-g9e6419498e1a0
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 169 runs,
 7 regressions (v5.10.179-371-g9e6419498e1a0)
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

stable-rc/queue/5.10 baseline: 169 runs, 7 regressions (v5.10.179-371-g9e64=
19498e1a0)

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
nel/v5.10.179-371-g9e6419498e1a0/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.179-371-g9e6419498e1a0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      9e6419498e1a022a060706a374ffcb44aad650e3 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6461cfb98bbcb5a9432e85e6

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-371-g9e6419498e1a0/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-371-g9e6419498e1a0/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461cfb98bbcb5a9432e861a
        failing since 90 days (last pass: v5.10.167-127-g921934d621e4, firs=
t fail: v5.10.167-139-gf9519a5a1701)

    2023-05-15T06:22:30.168371  <8>[   19.177314] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 459620_1.5.2.4.1>
    2023-05-15T06:22:30.277142  / # #
    2023-05-15T06:22:30.379536  export SHELL=3D/bin/sh
    2023-05-15T06:22:30.379971  #
    2023-05-15T06:22:30.481655  / # export SHELL=3D/bin/sh. /lava-459620/en=
vironment
    2023-05-15T06:22:30.482097  =

    2023-05-15T06:22:30.583666  / # . /lava-459620/environment/lava-459620/=
bin/lava-test-runner /lava-459620/1
    2023-05-15T06:22:30.584546  =

    2023-05-15T06:22:30.588918  / # /lava-459620/bin/lava-test-runner /lava=
-459620/1
    2023-05-15T06:22:30.691024  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6461d1b58ecdc3892e2e85f0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-371-g9e6419498e1a0/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-371-g9e6419498e1a0/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461d1b58ecdc3892e2e85f5
        failing since 108 days (last pass: v5.10.165-76-g5c2e982fcf18, firs=
t fail: v5.10.165-77-g4600242c13ed)

    2023-05-15T06:30:42.791249  #
    2023-05-15T06:30:42.894648  export SHELL=3D/bin/sh
    2023-05-15T06:30:42.895710  #
    2023-05-15T06:30:42.997884  / # export SHELL=3D/bin/sh. /lava-3590646/e=
nvironment
    2023-05-15T06:30:42.998714  =

    2023-05-15T06:30:43.101058  / # . /lava-3590646/environment/lava-359064=
6/bin/lava-test-runner /lava-3590646/1
    2023-05-15T06:30:43.103036  =

    2023-05-15T06:30:43.107437  / # /lava-3590646/bin/lava-test-runner /lav=
a-3590646/1
    2023-05-15T06:30:43.193767  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-15T06:30:43.199041  + cd /lava-3590646/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461d01c6857649dd82e8627

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-371-g9e6419498e1a0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-371-g9e6419498e1a0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461d01c6857649dd82e862c
        failing since 45 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-15T06:24:17.693784  + <8>[   11.748073] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10317932_1.4.2.3.1>

    2023-05-15T06:24:17.693910  set +x

    2023-05-15T06:24:17.798423  / # #

    2023-05-15T06:24:17.899027  export SHELL=3D/bin/sh

    2023-05-15T06:24:17.899207  #

    2023-05-15T06:24:17.999731  / # export SHELL=3D/bin/sh. /lava-10317932/=
environment

    2023-05-15T06:24:17.999926  =


    2023-05-15T06:24:18.100425  / # /lava-10317932/bin/lava-test-runner /la=
va-10317932/1

    2023-05-15T06:24:18.100728  . /lava-10317932/environment

    2023-05-15T06:24:18.105172  / # /lava-10317932/bin/lava-test-runner /la=
va-10317932/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461d0156857649dd82e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-371-g9e6419498e1a0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-371-g9e6419498e1a0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461d0156857649dd82e85eb
        failing since 45 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-15T06:24:05.836042  <8>[   13.932940] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10317941_1.4.2.3.1>

    2023-05-15T06:24:05.839374  + set +x

    2023-05-15T06:24:05.940702  #

    2023-05-15T06:24:05.940929  =


    2023-05-15T06:24:06.041498  / # #export SHELL=3D/bin/sh

    2023-05-15T06:24:06.041686  =


    2023-05-15T06:24:06.142193  / # export SHELL=3D/bin/sh. /lava-10317941/=
environment

    2023-05-15T06:24:06.142382  =


    2023-05-15T06:24:06.242939  / # . /lava-10317941/environment/lava-10317=
941/bin/lava-test-runner /lava-10317941/1

    2023-05-15T06:24:06.243274  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6461d1541c18d8d5ca2e8612

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-371-g9e6419498e1a0/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-371-g9e6419498e1a0/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6461d1541c18d8d5ca2e8618
        failing since 62 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-15T06:29:22.240693  /lava-10318000/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6461d1541c18d8d5ca2e8619
        failing since 62 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-15T06:29:20.178431  <8>[   31.375612] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-05-15T06:29:21.204133  /lava-10318000/1/../bin/lava-test-case

    2023-05-15T06:29:21.214158  <8>[   32.412221] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6461d0e2f75e34631e2e8640

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-371-g9e6419498e1a0/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-371-g9e6419498e1a0/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461d0e2f75e34631e2e8645
        failing since 102 days (last pass: v5.10.165-139-gefb57ce0f880, fir=
st fail: v5.10.165-149-ge30e8271d674)

    2023-05-15T06:27:06.354884  / # #
    2023-05-15T06:27:06.456836  export SHELL=3D/bin/sh
    2023-05-15T06:27:06.457625  #
    2023-05-15T06:27:06.559285  / # export SHELL=3D/bin/sh. /lava-3590653/e=
nvironment
    2023-05-15T06:27:06.559961  =

    2023-05-15T06:27:06.661582  / # . /lava-3590653/environment/lava-359065=
3/bin/lava-test-runner /lava-3590653/1
    2023-05-15T06:27:06.662547  =

    2023-05-15T06:27:06.680592  / # /lava-3590653/bin/lava-test-runner /lav=
a-3590653/1
    2023-05-15T06:27:06.785423  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-15T06:27:06.786297  + cd /lava-3590653/1/tests/1_bootrr =

    ... (9 line(s) more)  =

 =20
