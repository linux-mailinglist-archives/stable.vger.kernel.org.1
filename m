Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD7478E171
	for <lists+stable@lfdr.de>; Wed, 30 Aug 2023 23:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241446AbjH3VaO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 30 Aug 2023 17:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241500AbjH3VaN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 30 Aug 2023 17:30:13 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE49E6D
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 14:29:36 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6bf2427b947so175892a34.3
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 14:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693430912; x=1694035712; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0H0PnnZ2z46rNfkx5WayosAF9UwMVPg8E3wpuA/yUH4=;
        b=qvNMKdU20N5rdpIqsFYgjbwCGMfxsD+Hal1afsKDXB4fQotKUpfSnVgK/azi4RTK9Y
         EeYsOdC/6r+AfM70kNIeAD/iYS9bChZ2vKKwuDjqtkKIbgn8yKog0+/RypCb/uhQ5Fue
         ZYP4g5ssBdMR7YKNz/2Mxjv84X7/5buhNo6mMQuNNyUYiUPKIp90DaJ7ZSxJZYwquj+W
         VLqGhNdhsHuhVBC0dcRn/ujVH84ta0xV9tRPJQcwdypYaAyxRr/ZeJglJDtoPdkf/xAd
         4HPmCo3A1t6O6jT3dd0PPw1ppnc+MXfOyKFYv/t4ZQADaDMAkPm8xjNWADPw5YRPrDTT
         3j4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693430912; x=1694035712;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0H0PnnZ2z46rNfkx5WayosAF9UwMVPg8E3wpuA/yUH4=;
        b=j/Cyc10QJLsHvN93IWzi49TqTwaTNA9qnXDG1KWnnXH8Ma1QrwkqoMdRixrGe4CFZC
         y5Q/ohBql8l8NBVhmq1vorgHfvMmXggfVadvZs0ErUEpe1iqrAl9OaZTlzXRg7Echy21
         yrqpFy7urEcepb2C+SbVUoTyfisEhIPHpDaGoCxGo9gAHvbnXUy8/q3jK1jwVpjziRyO
         39TsnLZuimU8wGdrME2oMscs3j8a83hqIhaTVl62qyk6/Ln6ASPe4Q6UdPDytOtqDZgR
         e97TpyX023sWzgXCPZ0fyF2P5URsBCtdDf6z2PdA+Olb+E+6/+zF5uSnoeQAwkvxB1oe
         giag==
X-Gm-Message-State: AOJu0YzVb+KPZU/VIbfh5VLF27MMxIWER8ChtJahjYuGdUE8UpfjHv+5
        zSxXG+353NK0qxOOCJNI5jHwE6U3Nwu10jO2LhQ=
X-Google-Smtp-Source: AGHT+IFCboLEec3zFF17o39hZxMu//eCqCKJFxnv6073dpM5GvI9tNSjqtA3IkHPatxtVQVU62T8Bw==
X-Received: by 2002:a17:90b:1003:b0:26b:280b:d24c with SMTP id gm3-20020a17090b100300b0026b280bd24cmr2865366pjb.42.1693422819127;
        Wed, 30 Aug 2023 12:13:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d23-20020a17090a115700b00264040322desm1683741pje.40.2023.08.30.12.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 12:13:38 -0700 (PDT)
Message-ID: <64ef94e2.170a0220.a00ad.3da9@mx.google.com>
Date:   Wed, 30 Aug 2023 12:13:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.193
Subject: stable/linux-5.10.y baseline: 123 runs, 12 regressions (v5.10.193)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-5.10.y baseline: 123 runs, 12 regressions (v5.10.193)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.10.y/kernel=
/v5.10.193/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.10.y
  Describe: v5.10.193
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      4566606fe3a43e819e0a5e00eb47deccdf5427eb =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef5f9994ce12083c286df3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.193/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-sama5d4_xplained.t=
xt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.193/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-sama5d4_xplained.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef5f9994ce12083c286=
df4
        failing since 3 days (last pass: v5.10.191, first fail: v5.10.192) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef5eb8ef11a137d6286d79

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.193/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.193/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef5eb8ef11a137d6286d82
        failing since 223 days (last pass: v5.10.158, first fail: v5.10.164)

    2023-08-30T15:22:23.334809  <8>[   11.117405] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3756094_1.5.2.4.1>
    2023-08-30T15:22:23.447240  / # #
    2023-08-30T15:22:23.551374  export SHELL=3D/bin/sh
    2023-08-30T15:22:23.552688  #
    2023-08-30T15:22:23.655248  / # export SHELL=3D/bin/sh. /lava-3756094/e=
nvironment
    2023-08-30T15:22:23.656588  =

    2023-08-30T15:22:23.758975  / # . /lava-3756094/environment/lava-375609=
4/bin/lava-test-runner /lava-3756094/1
    2023-08-30T15:22:23.760991  =

    2023-08-30T15:22:23.765653  / # /lava-3756094/bin/lava-test-runner /lav=
a-3756094/1
    2023-08-30T15:22:23.847952  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef63de265b95e711286d6e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.193/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.193/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef63de265b95e711286d77
        failing since 147 days (last pass: v5.10.176, first fail: v5.10.177)

    2023-08-30T15:44:34.688941  + <8>[   10.210540] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11384792_1.4.2.3.1>

    2023-08-30T15:44:34.689034  set +x

    2023-08-30T15:44:34.790265  #

    2023-08-30T15:44:34.891048  / # #export SHELL=3D/bin/sh

    2023-08-30T15:44:34.891262  =


    2023-08-30T15:44:34.991769  / # export SHELL=3D/bin/sh. /lava-11384792/=
environment

    2023-08-30T15:44:34.991969  =


    2023-08-30T15:44:35.092481  / # . /lava-11384792/environment/lava-11384=
792/bin/lava-test-runner /lava-11384792/1

    2023-08-30T15:44:35.092800  =


    2023-08-30T15:44:35.097147  / # /lava-11384792/bin/lava-test-runner /la=
va-11384792/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef5e4a3940d48f5e286dae

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.193/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rz=
g2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.193/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rz=
g2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef5e4a3940d48f5e286db1
        failing since 34 days (last pass: v5.10.184, first fail: v5.10.188)

    2023-08-30T15:20:25.442568  + set +x
    2023-08-30T15:20:25.445803  <8>[   83.970350] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1002824_1.5.2.4.1>
    2023-08-30T15:20:25.554085  / # #
    2023-08-30T15:20:27.014955  export SHELL=3D/bin/sh
    2023-08-30T15:20:27.035589  #
    2023-08-30T15:20:27.035853  / # export SHELL=3D/bin/sh
    2023-08-30T15:20:28.988804  / # . /lava-1002824/environment
    2023-08-30T15:20:32.582133  /lava-1002824/bin/lava-test-runner /lava-10=
02824/1
    2023-08-30T15:20:32.603608  . /lava-1002824/environment
    2023-08-30T15:20:32.603964  / # /lava-1002824/bin/lava-test-runner /lav=
a-1002824/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef5e6ae0bd6372fe286d7d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.193/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774b1-hihope-rz=
g2n-ex.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.193/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774b1-hihope-rz=
g2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef5e6ae0bd6372fe286d80
        failing since 34 days (last pass: v5.10.184, first fail: v5.10.188)

    2023-08-30T15:20:53.909839  + set +x
    2023-08-30T15:20:53.910058  <8>[   84.224992] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1002818_1.5.2.4.1>
    2023-08-30T15:20:54.016036  / # #
    2023-08-30T15:20:55.478223  export SHELL=3D/bin/sh
    2023-08-30T15:20:55.498798  #
    2023-08-30T15:20:55.499008  / # export SHELL=3D/bin/sh
    2023-08-30T15:20:57.454728  / # . /lava-1002818/environment
    2023-08-30T15:21:01.053479  /lava-1002818/bin/lava-test-runner /lava-10=
02818/1
    2023-08-30T15:21:01.074272  . /lava-1002818/environment
    2023-08-30T15:21:01.074381  / # /lava-1002818/bin/lava-test-runner /lav=
a-1002818/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef5e6be0bd6372fe286d8b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.193/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.193/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef5e6be0bd6372fe286d8e
        failing since 34 days (last pass: v5.10.184, first fail: v5.10.188)

    2023-08-30T15:21:00.468385  / # #
    2023-08-30T15:21:01.930548  export SHELL=3D/bin/sh
    2023-08-30T15:21:01.951224  #
    2023-08-30T15:21:01.951432  / # export SHELL=3D/bin/sh
    2023-08-30T15:21:03.906674  / # . /lava-1002820/environment
    2023-08-30T15:21:07.505636  /lava-1002820/bin/lava-test-runner /lava-10=
02820/1
    2023-08-30T15:21:07.527303  . /lava-1002820/environment
    2023-08-30T15:21:07.527623  / # /lava-1002820/bin/lava-test-runner /lav=
a-1002820/1
    2023-08-30T15:21:07.604913  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-30T15:21:07.605380  + cd /lava-1002820/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef63f280ab2d56fa286dc6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.193/=
arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.193/=
arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef63f280ab2d56fa286dc9
        failing since 34 days (last pass: v5.10.185, first fail: v5.10.188)

    2023-08-30T15:43:48.184602  / # #
    2023-08-30T15:43:49.644466  export SHELL=3D/bin/sh
    2023-08-30T15:43:49.665142  #
    2023-08-30T15:43:49.665345  / # export SHELL=3D/bin/sh
    2023-08-30T15:43:51.618585  / # . /lava-1002946/environment
    2023-08-30T15:43:55.210700  /lava-1002946/bin/lava-test-runner /lava-10=
02946/1
    2023-08-30T15:43:55.231474  . /lava-1002946/environment
    2023-08-30T15:43:55.231628  / # /lava-1002946/bin/lava-test-runner /lav=
a-1002946/1
    2023-08-30T15:43:55.310168  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-30T15:43:55.310406  + cd /lava-1002946/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef62e6541bbca78d286d76

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.193/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.193/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef62e6541bbca78d286d7f
        failing since 34 days (last pass: v5.10.185, first fail: v5.10.188)

    2023-08-30T15:41:54.466563  / # #

    2023-08-30T15:41:54.567090  export SHELL=3D/bin/sh

    2023-08-30T15:41:54.567197  #

    2023-08-30T15:41:54.667690  / # export SHELL=3D/bin/sh. /lava-11384697/=
environment

    2023-08-30T15:41:54.667837  =


    2023-08-30T15:41:54.768355  / # . /lava-11384697/environment/lava-11384=
697/bin/lava-test-runner /lava-11384697/1

    2023-08-30T15:41:54.768537  =


    2023-08-30T15:41:54.780549  / # /lava-11384697/bin/lava-test-runner /la=
va-11384697/1

    2023-08-30T15:41:54.833989  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-30T15:41:54.834119  + cd /lav<8>[   16.426029] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11384697_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64ef5e0260daaeb1c5286d6c

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.193/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.193/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64ef5e0260daaeb1c5286d76
        failing since 166 days (last pass: v5.10.174, first fail: v5.10.175)

    2023-08-30T15:20:14.890633  <8>[   33.764052] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-08-30T15:20:15.917075  /lava-11384511/1/../bin/lava-test-case

    2023-08-30T15:20:15.927305  <8>[   34.801376] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64ef5e0260daaeb1c5286d77
        failing since 166 days (last pass: v5.10.174, first fail: v5.10.175)

    2023-08-30T15:20:14.879109  /lava-11384511/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef632c3cb5a59c52286d78

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.193/=
arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.193/=
arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef632c3cb5a59c52286d81
        failing since 3 days (last pass: v5.10.191, first fail: v5.10.192)

    2023-08-30T15:41:09.869341  / # #

    2023-08-30T15:41:11.130476  export SHELL=3D/bin/sh

    2023-08-30T15:41:11.141441  #

    2023-08-30T15:41:11.141889  / # export SHELL=3D/bin/sh

    2023-08-30T15:41:12.885844  / # . /lava-11384698/environment

    2023-08-30T15:41:16.091357  /lava-11384698/bin/lava-test-runner /lava-1=
1384698/1

    2023-08-30T15:41:16.102857  . /lava-11384698/environment

    2023-08-30T15:41:16.103187  / # /lava-11384698/bin/lava-test-runner /la=
va-11384698/1

    2023-08-30T15:41:16.157876  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-30T15:41:16.158359  + cd /lava-11384698/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef62fa2452b7e794286d6f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.193/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.193/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef62fa2452b7e794286d78
        failing since 34 days (last pass: v5.10.185, first fail: v5.10.188)

    2023-08-30T15:42:14.627913  / # #

    2023-08-30T15:42:14.730341  export SHELL=3D/bin/sh

    2023-08-30T15:42:14.731058  #

    2023-08-30T15:42:14.832477  / # export SHELL=3D/bin/sh. /lava-11384694/=
environment

    2023-08-30T15:42:14.833235  =


    2023-08-30T15:42:14.934680  / # . /lava-11384694/environment/lava-11384=
694/bin/lava-test-runner /lava-11384694/1

    2023-08-30T15:42:14.935781  =


    2023-08-30T15:42:14.952271  / # /lava-11384694/bin/lava-test-runner /la=
va-11384694/1

    2023-08-30T15:42:15.010235  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-30T15:42:15.010751  + cd /lava-1138469<8>[   18.311323] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11384694_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
