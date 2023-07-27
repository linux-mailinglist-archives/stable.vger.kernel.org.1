Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709EF765276
	for <lists+stable@lfdr.de>; Thu, 27 Jul 2023 13:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjG0Lc3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Jul 2023 07:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjG0Lc0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Jul 2023 07:32:26 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106CF359C
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 04:31:59 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b9c5e07c1bso6658395ad.2
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 04:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690457518; x=1691062318;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Xa+X0BYHnr6QdsZ5Slgv40Y5NwYYe77sUfNGLHEYW38=;
        b=O9oxK1stB9Wbac+C+iqllbL5ODc3QM5cIsdnpjbFHkms+KnFoKAv3lkJfp2vqsp32T
         GvlmMSjNQDZhHBst6Vi+rasYz6bwxe1jZyq0GOUDoqMHWOdmmD4/ayaNQEjNIrG+tMa5
         kK7BnuoDkhit4JvSOTuWlftTyigBeaZEsKcPhcQQhbdoMrwhPwIi1c3vBPCL4yC28REs
         FvRwt5pYI5PwyBaslzzSyU4MgyVwe7AscNgow9Rz+7dkaA8cc+KH01zVvw2EhUmMz8V/
         LDwMvY326XIalWtnEAys6T11qdnaeyN4A0w4exIoO8fEnldiVh6ryDibvUfdOcx8n0Nj
         KWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690457518; x=1691062318;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xa+X0BYHnr6QdsZ5Slgv40Y5NwYYe77sUfNGLHEYW38=;
        b=P9kraIaL+5Xzm7WBEF4MCf4jJz9Gb5kxMqyEE5nO8+MTXTT68D5biriXV7j5JYOvfo
         4kVjL4RtB7nqB2eobgJ/Zc2sXq7oXtLO1zs+h5mSOQJ0IOVFxPlz5Q6EqTf64HOhtLCD
         pbeEdeu/LxXKqUdBPBxRcExm8mYb88y3m7XJ5FrWsIDJAeemf1t4NrxAYr0KYQhcRPJx
         Beu6mmQsox07DpE1kERMU7EiC5DwLMPI0ywx4WcYCDf05yqN5KxW6Db0YAVbDNy4+M4F
         8EluzGn5TI0M96In4NZnVZcGjqP1CRkHzRSABiAk3HE5TeILSRsI3ZvGSbp60fgatjas
         y8ig==
X-Gm-Message-State: ABy/qLaaRc6Yf5noqWgxwm/l6AybwfBAQZro7UaQKnGOEFnCINZWhxfs
        xPAvd3iZBmyzJ8PCpkBNbCySz0gIf/GoutjEtByhdw==
X-Google-Smtp-Source: APBJJlH+4g6IO6VxLHsngSkrRM5qFR0sOcUgBBpRFmvpKjMo+W0PZVif6H/WSTeuZhL7fmQCU5MKdw==
X-Received: by 2002:a17:902:e88a:b0:1bb:1e69:28c0 with SMTP id w10-20020a170902e88a00b001bb1e6928c0mr5702661plg.30.1690457517946;
        Thu, 27 Jul 2023 04:31:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g4-20020a170902c38400b001b85bb5fd77sm1395094plg.119.2023.07.27.04.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 04:31:57 -0700 (PDT)
Message-ID: <64c255ad.170a0220.afb8b.2189@mx.google.com>
Date:   Thu, 27 Jul 2023 04:31:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Kernel: v5.10.188
X-Kernelci-Report-Type: test
Subject: stable/linux-5.10.y baseline: 129 runs, 10 regressions (v5.10.188)
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

stable/linux-5.10.y baseline: 129 runs, 10 regressions (v5.10.188)

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

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.10.y/kernel=
/v5.10.188/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.10.y
  Describe: v5.10.188
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      3602dbc57b556eff2456715301d35a1ef8964bba =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64c2261c839b2b310d8ace26

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.188/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-sama5d4_xplained.t=
xt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.188/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-sama5d4_xplained.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64c2261c839b2b310d8ac=
e27
        new failure (last pass: v5.10.184) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64c2253f986ee992188ace26

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.188/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.188/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c2253f986ee992188ace2b
        failing since 189 days (last pass: v5.10.158, first fail: v5.10.164)

    2023-07-27T08:05:03.891047  <8>[   11.049503] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-07-27T08:05:03.891326  + set +x
    2023-07-27T08:05:03.898134  <8>[   11.060265] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3725591_1.5.2.4.1>
    2023-07-27T08:05:04.005445  / # #
    2023-07-27T08:05:04.107022  export SHELL=3D/bin/sh
    2023-07-27T08:05:04.107579  #
    2023-07-27T08:05:04.209036  / # export SHELL=3D/bin/sh. /lava-3725591/e=
nvironment
    2023-07-27T08:05:04.209469  =

    2023-07-27T08:05:04.310776  / # . /lava-3725591/environment/lava-372559=
1/bin/lava-test-runner /lava-3725591/1
    2023-07-27T08:05:04.311559   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c221bc11ec8a0efe8ace89

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.188/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.188/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c221bc11ec8a0efe8ace8e
        failing since 112 days (last pass: v5.10.176, first fail: v5.10.177)

    2023-07-27T07:50:38.046893  + set +x

    2023-07-27T07:50:38.053239  <8>[   10.234121] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11149344_1.4.2.3.1>

    2023-07-27T07:50:38.157719  / # #

    2023-07-27T07:50:38.258316  export SHELL=3D/bin/sh

    2023-07-27T07:50:38.258489  #

    2023-07-27T07:50:38.359003  / # export SHELL=3D/bin/sh. /lava-11149344/=
environment

    2023-07-27T07:50:38.359166  =


    2023-07-27T07:50:38.459667  / # . /lava-11149344/environment/lava-11149=
344/bin/lava-test-runner /lava-11149344/1

    2023-07-27T07:50:38.459900  =


    2023-07-27T07:50:38.464860  / # /lava-11149344/bin/lava-test-runner /la=
va-11149344/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64c226b506a3b10f178ace1d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.188/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rz=
g2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.188/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rz=
g2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c226b506a3b10f178ace20
        new failure (last pass: v5.10.184)

    2023-07-27T08:11:02.749730  + set +x
    2023-07-27T08:11:02.749945  <8>[   83.706716] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 989545_1.5.2.4.1>
    2023-07-27T08:11:02.855825  / # #
    2023-07-27T08:11:04.318306  export SHELL=3D/bin/sh
    2023-07-27T08:11:04.338858  #
    2023-07-27T08:11:04.339062  / # export SHELL=3D/bin/sh
    2023-07-27T08:11:06.224362  / # . /lava-989545/environment
    2023-07-27T08:11:09.681521  /lava-989545/bin/lava-test-runner /lava-989=
545/1
    2023-07-27T08:11:09.702305  . /lava-989545/environment
    2023-07-27T08:11:09.702415  / # /lava-989545/bin/lava-test-runner /lava=
-989545/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64c2258adc392b40e38ace76

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.188/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774b1-hihope-rz=
g2n-ex.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.188/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774b1-hihope-rz=
g2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c2258adc392b40e38ace79
        new failure (last pass: v5.10.184)

    2023-07-27T08:06:11.609867  + set +x
    2023-07-27T08:06:11.610084  <8>[   83.990576] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 989544_1.5.2.4.1>
    2023-07-27T08:06:11.715962  / # #
    2023-07-27T08:06:13.177824  export SHELL=3D/bin/sh
    2023-07-27T08:06:13.198496  #
    2023-07-27T08:06:13.198703  / # export SHELL=3D/bin/sh
    2023-07-27T08:06:15.085178  / # . /lava-989544/environment
    2023-07-27T08:06:18.544153  /lava-989544/bin/lava-test-runner /lava-989=
544/1
    2023-07-27T08:06:18.565053  . /lava-989544/environment
    2023-07-27T08:06:18.565163  / # /lava-989544/bin/lava-test-runner /lava=
-989544/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64c225895e0c4fdcb68ace27

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.188/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.188/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c225895e0c4fdcb68ace2a
        new failure (last pass: v5.10.184)

    2023-07-27T08:06:02.762439  / # #
    2023-07-27T08:06:04.225192  export SHELL=3D/bin/sh
    2023-07-27T08:06:04.245683  #
    2023-07-27T08:06:04.245865  / # export SHELL=3D/bin/sh
    2023-07-27T08:06:06.130818  / # . /lava-989543/environment
    2023-07-27T08:06:09.588637  /lava-989543/bin/lava-test-runner /lava-989=
543/1
    2023-07-27T08:06:09.609405  . /lava-989543/environment
    2023-07-27T08:06:09.609516  / # /lava-989543/bin/lava-test-runner /lava=
-989543/1
    2023-07-27T08:06:09.643426  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-27T08:06:09.692734  + cd /lava-989543/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c22679afc5331a898ace37

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.188/=
arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.188/=
arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c22679afc5331a898ace3a
        new failure (last pass: v5.10.185)

    2023-07-27T08:10:03.392455  / # #
    2023-07-27T08:10:04.854912  export SHELL=3D/bin/sh
    2023-07-27T08:10:04.875461  #
    2023-07-27T08:10:04.875669  / # export SHELL=3D/bin/sh
    2023-07-27T08:10:06.761310  / # . /lava-989548/environment
    2023-07-27T08:10:10.219881  /lava-989548/bin/lava-test-runner /lava-989=
548/1
    2023-07-27T08:10:10.240701  . /lava-989548/environment
    2023-07-27T08:10:10.240812  / # /lava-989548/bin/lava-test-runner /lava=
-989548/1
    2023-07-27T08:10:10.273246  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-27T08:10:10.322011  + cd /lava-989548/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64c225137479bd84f18ace2c

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.188/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.188/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64c225137479bd84f18ace32
        failing since 131 days (last pass: v5.10.174, first fail: v5.10.175)

    2023-07-27T08:04:01.805576  <8>[   34.120666] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-07-27T08:04:02.829071  /lava-11149425/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64c225137479bd84f18ace33
        failing since 131 days (last pass: v5.10.174, first fail: v5.10.175)

    2023-07-27T08:04:01.794042  /lava-11149425/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c224d07881e83c1b8aceea

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.188/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.188/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c224d07881e83c1b8aceef
        new failure (last pass: v5.10.185)

    2023-07-27T08:05:00.343454  / # #

    2023-07-27T08:05:00.445188  export SHELL=3D/bin/sh

    2023-07-27T08:05:00.445823  #

    2023-07-27T08:05:00.547042  / # export SHELL=3D/bin/sh. /lava-11149440/=
environment

    2023-07-27T08:05:00.547660  =


    2023-07-27T08:05:00.648839  / # . /lava-11149440/environment/lava-11149=
440/bin/lava-test-runner /lava-11149440/1

    2023-07-27T08:05:00.649765  =


    2023-07-27T08:05:00.657378  / # /lava-11149440/bin/lava-test-runner /la=
va-11149440/1

    2023-07-27T08:05:00.723409  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-27T08:05:00.723895  + cd /lava-1114944<8>[   18.329590] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11149440_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
