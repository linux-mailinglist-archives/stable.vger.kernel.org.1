Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9C2739108
	for <lists+stable@lfdr.de>; Wed, 21 Jun 2023 22:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjFUUsY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 21 Jun 2023 16:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjFUUsY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Jun 2023 16:48:24 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7261713
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 13:48:21 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-54fbcfe65caso5006981a12.1
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 13:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687380501; x=1689972501;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOsYWJplcl7VGNo2ZPRcMOCxTP0tnToUme8pNVhZz/0=;
        b=I8jbsvyGiMEyJ9CaOl7Qx3P7p/2pPfHSKjGiH0IAVmuil/HHfMz/QyvUx3rRKe3RgL
         McmxaLLxuH/ezJs4k2brprDA8N0AiOX5s8u0uaGUUYw6JXKzll1nW02nSSybyU/EOlPh
         BQQTVdbJDtVrrd7QTZiXRamGDg6vn3oa2ACAubuP/Qcu3QBhDM92hvpFcPdf4INZOo8R
         1ptucN+5pv4I9zXCSNTnp9b+yfAS4/qtkGf+wVt9n611T4KLwEb+U4fomZnFjyx7gdoZ
         rzCNCrCDEFrufDqKPxlOhEVXaMAUjHcL4OCU6x16NOZLzqAPK0xbnH2j3fQBqKZTTxA3
         tf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687380501; x=1689972501;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZOsYWJplcl7VGNo2ZPRcMOCxTP0tnToUme8pNVhZz/0=;
        b=PANirLLCyUgP9PVGWcFRqSVl0/Me6t0qZblmYmD6ufaEzhJbfjDLuUAm91uQlAOkub
         kyevxL4C3buDkTU8si4HnPMRpGp1qu6KyXwCzCzAbQqOmn7L17VEp7h0kyyl6p86/Rj2
         lqOXG40gZzMg0PHu/UHLrstHKSgYQ4SL1nozZtnbRoVDQirm+eAK9xfOxq5EalYlEgER
         ZqJGri5BhRdcHxWpVFOCvn63/6OlN3z3UKzZObK726GWJI2VteEf+KcGPTXypFrdzsPq
         OsU8SNLP1D7GgqNy2ppTqyi4NjJhzBkokSHT6SgrJzQN/lCQ5rHI1HULuiYs8sq1SiAT
         Yyzg==
X-Gm-Message-State: AC+VfDw09CS0Q7o+nqtVKm5avmDRjsegK8MflfEMc07sSeXHjdY/O/Vf
        UZekGonHMzLZ3Hy8UCmRyrEJSiaICj1W+b3paznUWw==
X-Google-Smtp-Source: ACHHUZ7gTrYwKLOXOpUVWvtIm4mtqFbzLizGzXmUF4zRmZw4ymiYeVyNILQmn2Qwb0bOv+lCZWZq6A==
X-Received: by 2002:a17:902:e84d:b0:1ac:85b0:1bd8 with SMTP id t13-20020a170902e84d00b001ac85b01bd8mr24711834plg.34.1687380500444;
        Wed, 21 Jun 2023 13:48:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c20d00b001b6a37c49a6sm977459pll.268.2023.06.21.13.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 13:48:20 -0700 (PDT)
Message-ID: <64936214.170a0220.b11a1.29bc@mx.google.com>
Date:   Wed, 21 Jun 2023 13:48:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.287
Subject: stable/linux-4.19.y baseline: 102 runs, 12 regressions (v4.19.287)
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

stable/linux-4.19.y baseline: 102 runs, 12 regressions (v4.19.287)

Regressions Summary
-------------------

platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =

at91sam9g20ek             | arm    | lab-broonie     | gcc-10   | multi_v5_=
defconfig           | 1          =

beagle-xm                 | arm    | lab-baylibre    | gcc-10   | omap2plus=
_defconfig          | 1          =

beaglebone-black          | arm    | lab-broonie     | gcc-10   | multi_v7_=
defconfig           | 1          =

beaglebone-black          | arm    | lab-cip         | gcc-10   | multi_v7_=
defconfig           | 1          =

cubietruck                | arm    | lab-baylibre    | gcc-10   | multi_v7_=
defconfig           | 1          =

dove-cubox                | arm    | lab-pengutronix | gcc-10   | mvebu_v7_=
defconfig           | 1          =

imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =

rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 3          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-4.19.y/kernel=
/v4.19.287/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-4.19.y
  Describe: v4.19.287
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      10c994966905ff07bc3cca4c6802da6e94152b83 =



Test Regressions
---------------- =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6493299eb8c5ba5cf330617b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.287/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.287/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6493299eb8c5ba5cf3306184
        failing since 154 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-06-21T16:47:18.854521  + set +x<8>[   11.023102] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10847348_1.4.2.3.1>

    2023-06-21T16:47:18.854678  =


    2023-06-21T16:47:18.957093  #

    2023-06-21T16:47:18.957473  =


    2023-06-21T16:47:19.058150  / # #export SHELL=3D/bin/sh

    2023-06-21T16:47:19.058404  =


    2023-06-21T16:47:19.159028  / # export SHELL=3D/bin/sh. /lava-10847348/=
environment

    2023-06-21T16:47:19.159256  =


    2023-06-21T16:47:19.259841  / # . /lava-10847348/environment/lava-10847=
348/bin/lava-test-runner /lava-10847348/1

    2023-06-21T16:47:19.260134  =

 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64932a252465f0fbc4306133

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.287/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.287/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64932a252465f0fbc430613c
        failing since 154 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-06-21T16:49:24.589999  + set +x

    2023-06-21T16:49:24.595922  <8>[   12.101624] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10847416_1.4.2.3.1>

    2023-06-21T16:49:24.704028  #

    2023-06-21T16:49:24.705553  =


    2023-06-21T16:49:24.807525  / # #export SHELL=3D/bin/sh

    2023-06-21T16:49:24.808327  =


    2023-06-21T16:49:24.910053  / # export SHELL=3D/bin/sh. /lava-10847416/=
environment

    2023-06-21T16:49:24.910842  =


    2023-06-21T16:49:25.012424  / # . /lava-10847416/environment/lava-10847=
416/bin/lava-test-runner /lava-10847416/1

    2023-06-21T16:49:25.013655  =

 =

    ... (14 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
at91sam9g20ek             | arm    | lab-broonie     | gcc-10   | multi_v5_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/649329ffc85d12aebb30617c

  Results:     41 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.287/=
arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.287/=
arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649329ffc85d12aebb3061af
        new failure (last pass: v4.19.286)

    2023-06-21T16:48:23.515226  + set +x
    2023-06-21T16:48:23.519727  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 646678_1.5.2=
.4.1>
    2023-06-21T16:48:23.633034  / # #
    2023-06-21T16:48:23.735839  export SHELL=3D/bin/sh
    2023-06-21T16:48:23.736591  #
    2023-06-21T16:48:23.838554  / # export SHELL=3D/bin/sh. /lava-646678/en=
vironment
    2023-06-21T16:48:23.839391  =

    2023-06-21T16:48:23.941384  / # . /lava-646678/environment/lava-646678/=
bin/lava-test-runner /lava-646678/1
    2023-06-21T16:48:23.942675  =

    2023-06-21T16:48:23.949232  / # /lava-646678/bin/lava-test-runner /lava=
-646678/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beagle-xm                 | arm    | lab-baylibre    | gcc-10   | omap2plus=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64932aeb1d444d36be306135

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.287/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.287/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64932aeb1d444d36be30613e
        failing since 148 days (last pass: v4.19.268, first fail: v4.19.271)

    2023-06-21T16:52:36.118637  + set +x<8>[   25.277832] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3684044_1.5.2.4.1>
    2023-06-21T16:52:36.118911  =

    2023-06-21T16:52:36.229408  / # #
    2023-06-21T16:52:36.330802  export SHELL=3D/bin/sh
    2023-06-21T16:52:36.331259  #
    2023-06-21T16:52:36.432479  / # export SHELL=3D/bin/sh. /lava-3684044/e=
nvironment
    2023-06-21T16:52:36.432918  =

    2023-06-21T16:52:36.534183  / # . /lava-3684044/environment/lava-368404=
4/bin/lava-test-runner /lava-3684044/1
    2023-06-21T16:52:36.534843  =

    2023-06-21T16:52:36.540257  / # /lava-3684044/bin/lava-test-runner /lav=
a-3684044/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-broonie     | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64932bb47651881481306181

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.287/=
arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.287/=
arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64932bb476518814813061ae
        failing since 154 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-06-21T16:55:43.529917  <8>[   16.321192] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 646796_1.5.2.4.1>
    2023-06-21T16:55:43.640218  / # #
    2023-06-21T16:55:43.742118  export SHELL=3D/bin/sh
    2023-06-21T16:55:43.742754  #
    2023-06-21T16:55:43.844206  / # export SHELL=3D/bin/sh. /lava-646796/en=
vironment
    2023-06-21T16:55:43.844649  =

    2023-06-21T16:55:43.946191  / # . /lava-646796/environment/lava-646796/=
bin/lava-test-runner /lava-646796/1
    2023-06-21T16:55:43.947071  =

    2023-06-21T16:55:43.951176  / # /lava-646796/bin/lava-test-runner /lava=
-646796/1
    2023-06-21T16:55:44.018170  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-cip         | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64932ef68d7a179566306136

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.287/=
arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.287/=
arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64932ef68d7a17956630613d
        failing since 154 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-06-21T17:09:36.013354  + set +x
    2023-06-21T17:09:36.015360  <8>[    9.796817] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 969920_1.5.2.4.1>
    2023-06-21T17:09:36.123960  / # #
    2023-06-21T17:09:36.225982  export SHELL=3D/bin/sh
    2023-06-21T17:09:36.226500  #
    2023-06-21T17:09:36.327939  / # export SHELL=3D/bin/sh. /lava-969920/en=
vironment
    2023-06-21T17:09:36.328437  =

    2023-06-21T17:09:36.429870  / # . /lava-969920/environment/lava-969920/=
bin/lava-test-runner /lava-969920/1
    2023-06-21T17:09:36.430733  =

    2023-06-21T17:09:36.432239  / # /lava-969920/bin/lava-test-runner /lava=
-969920/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
cubietruck                | arm    | lab-baylibre    | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64932cc02133353cd5306154

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.287/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.287/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64932cc02133353cd530615d
        failing since 154 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-06-21T17:00:29.524335  + set +x<8>[    7.333203] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3684082_1.5.2.4.1>
    2023-06-21T17:00:29.525199  =

    2023-06-21T17:00:29.634622  / # #
    2023-06-21T17:00:29.738031  export SHELL=3D/bin/sh
    2023-06-21T17:00:29.738969  #
    2023-06-21T17:00:29.841011  / # export SHELL=3D/bin/sh. /lava-3684082/e=
nvironment
    2023-06-21T17:00:29.841935  =

    2023-06-21T17:00:29.943858  / # . /lava-3684082/environment/lava-368408=
2/bin/lava-test-runner /lava-3684082/1
    2023-06-21T17:00:29.945401  =

    2023-06-21T17:00:29.950132  / # /lava-3684082/bin/lava-test-runner /lav=
a-3684082/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
dove-cubox                | arm    | lab-pengutronix | gcc-10   | mvebu_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/649327d1da461140d3306134

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: mvebu_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.287/=
arm/mvebu_v7_defconfig/gcc-10/lab-pengutronix/baseline-dove-cubox.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.287/=
arm/mvebu_v7_defconfig/gcc-10/lab-pengutronix/baseline-dove-cubox.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649327d1da461140d330613d
        failing since 154 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-06-21T16:39:26.942297  + set +x
    2023-06-21T16:39:26.942557  [    4.237572] <LAVA_SIGNAL_ENDRUN 0_dmesg =
984327_1.5.2.3.1>
    2023-06-21T16:39:27.049109  / # #
    2023-06-21T16:39:27.150824  export SHELL=3D/bin/sh
    2023-06-21T16:39:27.151339  #
    2023-06-21T16:39:27.252665  / # export SHELL=3D/bin/sh. /lava-984327/en=
vironment
    2023-06-21T16:39:27.253172  =

    2023-06-21T16:39:27.354466  / # . /lava-984327/environment/lava-984327/=
bin/lava-test-runner /lava-984327/1
    2023-06-21T16:39:27.355097  =

    2023-06-21T16:39:27.357814  / # /lava-984327/bin/lava-test-runner /lava=
-984327/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64932b5903683f94db30614a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.287/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.287/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64932b5903683f94db306153
        failing since 154 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-06-21T16:54:39.957425  / # #

    2023-06-21T16:54:40.060024  export SHELL=3D/bin/sh

    2023-06-21T16:54:40.060822  #

    2023-06-21T16:54:40.162784  / # export SHELL=3D/bin/sh. /lava-10847452/=
environment

    2023-06-21T16:54:40.163541  =


    2023-06-21T16:54:40.265192  / # . /lava-10847452/environment/lava-10847=
452/bin/lava-test-runner /lava-10847452/1

    2023-06-21T16:54:40.266142  =


    2023-06-21T16:54:40.280565  / # /lava-10847452/bin/lava-test-runner /la=
va-10847452/1

    2023-06-21T16:54:40.377384  + export 'TESTRUN_ID=3D1_bootrr'

    2023-06-21T16:54:40.377932  + cd /lava-10847452/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 3          =


  Details:     https://kernelci.org/test/plan/id/64932b4a3e95a4ba63306134

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.287/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.287/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64932b4a3e95a4ba63306168
        failing since 152 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-06-21T16:55:07.737104   multi-call binary.

    2023-06-21T16:55:07.737321  =


    2023-06-21T16:55:07.741548  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-06-21T16:55:07.741765  =


    2023-06-21T16:55:07.747105  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64932b4a3e95a4ba63306169
        failing since 152 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-06-21T16:55:07.716480  /lava-10847453/1/../bin/lava-test-case<8>[ =
   9.789714] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-probed RE=
SULT=3Dpass>

    2023-06-21T16:55:07.716533  =


    2023-06-21T16:55:07.735080  BusyBox v1.31.1 (2023-06-09 10:32:04 UTC)<8=
>[    9.807105] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64932b4a3e95a4ba6330617c
        failing since 152 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-06-21T16:55:03.883329  <8>[    5.956529] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-06-21T16:55:03.892755  + <8>[    5.968771] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10847453_1.5.2.3.1>

    2023-06-21T16:55:03.895907  set +x

    2023-06-21T16:55:03.999239  #

    2023-06-21T16:55:04.000334  =


    2023-06-21T16:55:04.101780  / # #export SHELL=3D/bin/sh

    2023-06-21T16:55:04.102479  =


    2023-06-21T16:55:04.203826  / # export SHELL=3D/bin/sh. /lava-10847453/=
environment

    2023-06-21T16:55:04.204133  =


    2023-06-21T16:55:04.305113  / # . /lava-10847453/environment/lava-10847=
453/bin/lava-test-runner /lava-10847453/1
 =

    ... (18 line(s) more)  =

 =20
