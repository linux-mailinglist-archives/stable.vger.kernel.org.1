Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040D66FEAEA
	for <lists+stable@lfdr.de>; Thu, 11 May 2023 06:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbjEKEsY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 11 May 2023 00:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236884AbjEKEsW (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 11 May 2023 00:48:22 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8C330D5
        for <stable@vger.kernel.org>; Wed, 10 May 2023 21:48:20 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ab1b79d3a7so56195155ad.3
        for <stable@vger.kernel.org>; Wed, 10 May 2023 21:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683780499; x=1686372499;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wr0YJ3gxNmWaDhsyMV8KBR6LpkIIIRfrIxIPSVcB0IU=;
        b=a6zpbfd7Ti21YAPNylDMVUjy+Nnpvhpl75WW6kEUdv+kRVf7HcjEDTEe3v/Tl2YYuC
         kZJ1kUav9hkf+BFGf0sl6Kd5fPKUSlo6cb66bxz2wAIzgSCR84Wj/yc6ThXV6hAdVEZW
         o/DUsjCrndnVHuk2s7qYgHWnpJUXdBerM3QEMkreQfjRoSoppRtKRSu5nHE0aV5vxG0G
         JWe7KmxZbrYONfUd6gK316z6f0mGLlzHkbJiX+/3CvnBeqwCrBX7TasYos21JOiBET7e
         vMRymD/3BOHnp3Wzf3XWiKSUBO5nHYiKGxLyG9ra83sVfsuA3AKOcita1kIAFb8rxlW3
         1f2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683780499; x=1686372499;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wr0YJ3gxNmWaDhsyMV8KBR6LpkIIIRfrIxIPSVcB0IU=;
        b=iQUGVbX1qsOFv7p4NEm/RsNT5C1eO6CBpfsY7iOZUvaLkd+Nsf4lyLbC+XbpcEHwSF
         H9zoEqvt6wemTYHKj63HBNNcwy5qJTwG+Ur9xH7UNcwFS56fvHiUH9/sMPEMvrmtZy2R
         83WoFLVLxkCdjKgk8/nVMTTm7bOS9ZzS/DK9MJQU93cWhI1rRzrbOh/LadNaGhEiINvs
         EdGcdnzdch1qbR/f1vyNfpN1ItufL4jC7B6B7a1Yb8g/GNDDOKoL3x/wLgm4XWRZmZGy
         ld+I4+XgXtD+Hzd3CcyismyCgijrIgKL7NUJ8WPWt5e5g4w1YRkmbHKgZ0UZkWcy/hzO
         6v7A==
X-Gm-Message-State: AC+VfDyoGEAjGBgexSGmWIzeQjXru9sC+Q7ht4lPL1IXO04uQA7r+r/R
        WCH1GYfnFdS3see1uTD9K5hH2AZnNWAe5Avkl6RlAw==
X-Google-Smtp-Source: ACHHUZ4jEV+CfjAr2/3CLH2oTlQRLsZgMUJgReN6UoKUQ67cxESAjydc5Z7wsOL7Mi0WlplTRqXO0g==
X-Received: by 2002:a17:902:8c87:b0:1a9:8d57:6d6c with SMTP id t7-20020a1709028c8700b001a98d576d6cmr16272963plo.24.1683780499112;
        Wed, 10 May 2023 21:48:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902f39100b001a804b16e38sm4727355ple.150.2023.05.10.21.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 21:48:18 -0700 (PDT)
Message-ID: <645c7392.170a0220.ad026.a6dc@mx.google.com>
Date:   Wed, 10 May 2023 21:48:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.179
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.10.y baseline: 180 runs, 6 regressions (v5.10.179)
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

stable-rc/linux-5.10.y baseline: 180 runs, 6 regressions (v5.10.179)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.179/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.179
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      f1b32fda06d2cfb8eea9680b0ba7a8b0d5b81eeb =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/645c3f97d4fa4521a12e861e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
79/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
79/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c3f97d4fa4521a12e8621
        failing since 68 days (last pass: v5.10.155, first fail: v5.10.172)

    2023-05-11T01:05:56.454123  [   14.893259] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1218201_1.5.2.4.1>
    2023-05-11T01:05:56.560346  / # #
    2023-05-11T01:05:56.662107  export SHELL=3D/bin/sh
    2023-05-11T01:05:56.662659  #
    2023-05-11T01:05:56.764056  / # export SHELL=3D/bin/sh. /lava-1218201/e=
nvironment
    2023-05-11T01:05:56.764568  =

    2023-05-11T01:05:56.866027  / # . /lava-1218201/environment/lava-121820=
1/bin/lava-test-runner /lava-1218201/1
    2023-05-11T01:05:56.866885  =

    2023-05-11T01:05:56.868507  / # /lava-1218201/bin/lava-test-runner /lav=
a-1218201/1
    2023-05-11T01:05:56.886866  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645c432bad9af42def2e860c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
79/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
79/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c432bad9af42def2e8611
        failing since 43 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-05-11T01:21:35.352541  + set +x

    2023-05-11T01:21:35.359077  <8>[   14.619731] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10273957_1.4.2.3.1>

    2023-05-11T01:21:35.462927  / # #

    2023-05-11T01:21:35.563577  export SHELL=3D/bin/sh

    2023-05-11T01:21:35.563810  #

    2023-05-11T01:21:35.664365  / # export SHELL=3D/bin/sh. /lava-10273957/=
environment

    2023-05-11T01:21:35.664605  =


    2023-05-11T01:21:35.765182  / # . /lava-10273957/environment/lava-10273=
957/bin/lava-test-runner /lava-10273957/1

    2023-05-11T01:21:35.765485  =


    2023-05-11T01:21:35.770560  / # /lava-10273957/bin/lava-test-runner /la=
va-10273957/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645c410c3212c94eb72e85eb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
79/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
79/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645c410c3212c94eb72e8=
5ec
        new failure (last pass: v5.10.176-651-g9f10a95a08702) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/645c42d8ba9233632f2e8620

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
79/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gr=
u-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
79/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gr=
u-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/645c42d8ba9233632f2e8626
        failing since 58 days (last pass: v5.10.173, first fail: v5.10.173-=
4-g955623617f2f)

    2023-05-11T01:20:13.297463  <8>[   34.052702] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-05-11T01:20:14.322365  /lava-10274133/1/../bin/lava-test-case

    2023-05-11T01:20:14.333334  <8>[   35.089427] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/645c42d8ba9233632f2e8627
        failing since 58 days (last pass: v5.10.173, first fail: v5.10.173-=
4-g955623617f2f)

    2023-05-11T01:20:13.286404  /lava-10274133/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/645c4079e16c6b16252e8667

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
79/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
79/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c4079e16c6b16252e8693
        failing since 100 days (last pass: v5.10.158-107-g6b6a42c25ed4, fir=
st fail: v5.10.165-144-g930bc29c79c4)

    2023-05-11T01:09:54.633712  + set +x
    2023-05-11T01:09:54.636886  <8>[   17.076496] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3573266_1.5.2.4.1>
    2023-05-11T01:09:54.776196  / # #
    2023-05-11T01:09:54.887426  export SHELL=3D/bin/sh
    2023-05-11T01:09:54.889023  #
    2023-05-11T01:09:54.992341  / # export SHELL=3D/bin/sh. /lava-3573266/e=
nvironment
    2023-05-11T01:09:54.993904  =

    2023-05-11T01:09:55.097583  / # . /lava-3573266/environment/lava-357326=
6/bin/lava-test-runner /lava-3573266/1
    2023-05-11T01:09:55.100485  =

    2023-05-11T01:09:55.102844  / # /lava-3573266/bin/lava-test-runner /lav=
a-3573266/1 =

    ... (12 line(s) more)  =

 =20
