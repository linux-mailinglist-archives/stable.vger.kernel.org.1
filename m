Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E17C729C29
	for <lists+stable@lfdr.de>; Fri,  9 Jun 2023 16:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237713AbjFIOEV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 9 Jun 2023 10:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239428AbjFIOEU (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Jun 2023 10:04:20 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBB235B3
        for <stable@vger.kernel.org>; Fri,  9 Jun 2023 07:04:16 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-65311774e52so1404650b3a.3
        for <stable@vger.kernel.org>; Fri, 09 Jun 2023 07:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686319456; x=1688911456;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zHJY9ZxAIl1qNiIEh2k4A5x0rST7MzMISMrPm4v1nm8=;
        b=G6bOLhW3leMX52H8a8Xul1InFjyg0PKOUyPBdmZFSnhrmbJ0+A9HHlMO6jkvcXIiVG
         o0lf2YiOEtwbr1uI1eghT2cLr4kgp1wzmIA+L/f/Z9w4CQSoq0mG4Nc34qloca5PhlmV
         fHSdZCeOv+DkVQNmscE6JaLhOeX1Yql9uXtn4/R+sBKIW/WV5YwZ4OZZ8qgVIMaZTS6+
         hLntBU5K+7sUAR9qbJnxil4t+cMEoQqtJMPDZnLIP2s9DMjbDFs+eGL3SErmM9FPlchU
         LEPRM5Na66KfgYXkUyHO0hwFlQAY+7I3TLr1wwV4VR0jiQIzGny1GNVeaqOmUoypma6t
         UGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686319456; x=1688911456;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zHJY9ZxAIl1qNiIEh2k4A5x0rST7MzMISMrPm4v1nm8=;
        b=iRIRT2Tg7+8xLY6XgxOHQAu9557ze7lVHuG9trnM5IJXMqLQMkCKlxmvjuzHYY5G2o
         kjzc4o/F9JUwz9Vc8HSfm6/9XdpJVbMcjoDVOKA4kIFj+IQyBBptZu7pVPGtqakWloV0
         D1r3ijAGdYsB+OuRQ6aQPk0UyhMeVgQm9iV5SLLRmlyZ3Eoimxc4aAA9+ujdS0zNeoml
         WAe1cL4Z190w+2ec3T+IKz0qxA108K6vdLZe+Ef5gqvua3cBEsEHcnqNlHg4P8aUdMIW
         pqCnV0bZqu+Kb4B/cJAPNkC3bYBiAC8nzIapClbzYIDVNWyCwDqlIB+1kJycxatVNW1s
         vbCw==
X-Gm-Message-State: AC+VfDxKi5VIEUfgyh/SbBq/fYZGeyVoUjM1+NNUzaIEO8uva+BEkIAU
        aa2cfjV1YyGHILjU7kU2jcK6EewiR9BOxy6sYX4bbg==
X-Google-Smtp-Source: ACHHUZ73726YxdoXWI1+SpF7OZXj1GkJQQ0OJ0kL7xR0+OqqM30kQJ/WOfiUOU1Omp9o0ccWBwu1Dw==
X-Received: by 2002:a05:6a21:164d:b0:10a:dd89:420f with SMTP id no13-20020a056a21164d00b0010add89420fmr1033429pzb.6.1686319455089;
        Fri, 09 Jun 2023 07:04:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x16-20020a63b210000000b0053fb4d63051sm2980533pge.54.2023.06.09.07.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:04:14 -0700 (PDT)
Message-ID: <6483315e.630a0220.532a2.6154@mx.google.com>
Date:   Fri, 09 Jun 2023 07:04:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.285
Subject: stable/linux-4.19.y baseline: 112 runs, 15 regressions (v4.19.285)
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

stable/linux-4.19.y baseline: 112 runs, 15 regressions (v4.19.285)

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

beaglebone-black          | arm    | lab-cip         | gcc-10   | omap2plus=
_defconfig          | 1          =

cubietruck                | arm    | lab-baylibre    | gcc-10   | multi_v7_=
defconfig           | 1          =

dove-cubox                | arm    | lab-pengutronix | gcc-10   | mvebu_v7_=
defconfig           | 1          =

imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | imx_v6_v7=
_defconfig          | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defconfig           | 1          =

rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 3          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-4.19.y/kernel=
/v4.19.285/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-4.19.y
  Describe: v4.19.285
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      7625843c7c86dd2d5d4bcbbc06da8cba49d09a5b =



Test Regressions
---------------- =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6482f6f615572530e2306130

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.285/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.285/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6482f6f615572530e2306135
        failing since 141 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-06-09T09:54:46.460964  + set +x

    2023-06-09T09:54:46.467406  <8>[    9.806212] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10656507_1.4.2.3.1>

    2023-06-09T09:54:46.571605  / # #

    2023-06-09T09:54:46.672235  export SHELL=3D/bin/sh

    2023-06-09T09:54:46.672427  #

    2023-06-09T09:54:46.772952  / # export SHELL=3D/bin/sh. /lava-10656507/=
environment

    2023-06-09T09:54:46.773159  =


    2023-06-09T09:54:46.873699  / # . /lava-10656507/environment/lava-10656=
507/bin/lava-test-runner /lava-10656507/1

    2023-06-09T09:54:46.873981  =


    2023-06-09T09:54:46.879370  / # /lava-10656507/bin/lava-test-runner /la=
va-10656507/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6482f6efdc8bbacd9d30612e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.285/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.285/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6482f6efdc8bbacd9d306133
        failing since 141 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-06-09T09:54:44.230601  + <8>[   12.179097] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10656488_1.4.2.3.1>

    2023-06-09T09:54:44.231540  set +x

    2023-06-09T09:54:44.335255  / # #

    2023-06-09T09:54:44.435845  export SHELL=3D/bin/sh

    2023-06-09T09:54:44.436053  #

    2023-06-09T09:54:44.536644  / # export SHELL=3D/bin/sh. /lava-10656488/=
environment

    2023-06-09T09:54:44.536851  =


    2023-06-09T09:54:44.637374  / # . /lava-10656488/environment/lava-10656=
488/bin/lava-test-runner /lava-10656488/1

    2023-06-09T09:54:44.637688  =


    2023-06-09T09:54:44.640180  / # /lava-10656488/bin/lava-test-runner /la=
va-10656488/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
at91sam9g20ek             | arm    | lab-broonie     | gcc-10   | multi_v5_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6482f83edf5bf8230730614d

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.285/=
arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.285/=
arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6482f83edf5bf8230730617a
        failing since 123 days (last pass: v4.19.271, first fail: v4.19.272)

    2023-06-09T09:59:50.850705  + set +x
    2023-06-09T09:59:50.855952  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 585405_1.5.2=
.4.1>
    2023-06-09T09:59:50.970493  / # #
    2023-06-09T09:59:51.073710  export SHELL=3D/bin/sh
    2023-06-09T09:59:51.074551  #
    2023-06-09T09:59:51.176570  / # export SHELL=3D/bin/sh. /lava-585405/en=
vironment
    2023-06-09T09:59:51.177451  =

    2023-06-09T09:59:51.279966  / # . /lava-585405/environment/lava-585405/=
bin/lava-test-runner /lava-585405/1
    2023-06-09T09:59:51.281393  =

    2023-06-09T09:59:51.287757  / # /lava-585405/bin/lava-test-runner /lava=
-585405/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beagle-xm                 | arm    | lab-baylibre    | gcc-10   | omap2plus=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6482fd0ff3bf224f1f30612f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.285/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.285/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6482fd0ff3bf224f1f306134
        failing since 136 days (last pass: v4.19.268, first fail: v4.19.271)

    2023-06-09T10:20:36.048765  + set +x<8>[   25.247406] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3652354_1.5.2.4.1>
    2023-06-09T10:20:36.049406  =

    2023-06-09T10:20:36.163095  / # #
    2023-06-09T10:20:36.265185  export SHELL=3D/bin/sh
    2023-06-09T10:20:36.266211  #
    2023-06-09T10:20:36.368708  / # export SHELL=3D/bin/sh. /lava-3652354/e=
nvironment
    2023-06-09T10:20:36.369776  =

    2023-06-09T10:20:36.472115  / # . /lava-3652354/environment/lava-365235=
4/bin/lava-test-runner /lava-3652354/1
    2023-06-09T10:20:36.473667  =

    2023-06-09T10:20:36.479140  / # /lava-3652354/bin/lava-test-runner /lav=
a-3652354/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-broonie     | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6482f883e46a732fae30614e

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.285/=
arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.285/=
arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6482f883e46a732fae306178
        failing since 141 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-06-09T10:00:56.974031  <8>[   16.994777] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 585383_1.5.2.4.1>
    2023-06-09T10:00:57.082745  / # #
    2023-06-09T10:00:57.185676  export SHELL=3D/bin/sh
    2023-06-09T10:00:57.186418  #
    2023-06-09T10:00:57.288403  / # export SHELL=3D/bin/sh. /lava-585383/en=
vironment
    2023-06-09T10:00:57.289153  =

    2023-06-09T10:00:57.391545  / # . /lava-585383/environment/lava-585383/=
bin/lava-test-runner /lava-585383/1
    2023-06-09T10:00:57.392992  =

    2023-06-09T10:00:57.396297  / # /lava-585383/bin/lava-test-runner /lava=
-585383/1
    2023-06-09T10:00:57.464792  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-cip         | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6482f8cf5cb8a35ff630614f

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.285/=
arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.285/=
arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6482f8cf5cb8a35ff6306152
        failing since 141 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-06-09T10:02:17.730466  + set +x
    2023-06-09T10:02:17.732540  <8>[    9.790258] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 957834_1.5.2.4.1>
    2023-06-09T10:02:17.841254  / # #
    2023-06-09T10:02:17.943193  export SHELL=3D/bin/sh
    2023-06-09T10:02:17.943676  #
    2023-06-09T10:02:18.045123  / # export SHELL=3D/bin/sh. /lava-957834/en=
vironment
    2023-06-09T10:02:18.045574  =

    2023-06-09T10:02:18.147059  / # . /lava-957834/environment/lava-957834/=
bin/lava-test-runner /lava-957834/1
    2023-06-09T10:02:18.147862  =

    2023-06-09T10:02:18.149408  / # /lava-957834/bin/lava-test-runner /lava=
-957834/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-cip         | gcc-10   | omap2plus=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6482fee780704d21f1306136

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.285/=
arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.285/=
arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6482fee780704d21f1306139
        failing since 23 days (last pass: v4.19.282, first fail: v4.19.283)

    2023-06-09T10:28:16.326699  + set +x<8>[   10.607582] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 957870_1.5.2.4.1>
    2023-06-09T10:28:16.327184  =

    2023-06-09T10:28:16.438967  / # #
    2023-06-09T10:28:16.541238  export SHELL=3D/bin/sh
    2023-06-09T10:28:16.541993  #
    2023-06-09T10:28:16.643810  / # export SHELL=3D/bin/sh. /lava-957870/en=
vironment
    2023-06-09T10:28:16.644590  =

    2023-06-09T10:28:16.746446  / # . /lava-957870/environment/lava-957870/=
bin/lava-test-runner /lava-957870/1
    2023-06-09T10:28:16.747678  =

    2023-06-09T10:28:16.753598  / # /lava-957870/bin/lava-test-runner /lava=
-957870/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
cubietruck                | arm    | lab-baylibre    | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6482f83cdf5bf8230730613d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.285/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.285/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6482f83cdf5bf82307306142
        failing since 141 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-06-09T10:00:05.378370  <8>[    7.254782] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3652234_1.5.2.4.1>
    2023-06-09T10:00:05.484650  / # #
    2023-06-09T10:00:05.586131  export SHELL=3D/bin/sh
    2023-06-09T10:00:05.586504  #
    2023-06-09T10:00:05.687664  / # export SHELL=3D/bin/sh. /lava-3652234/e=
nvironment
    2023-06-09T10:00:05.688029  =

    2023-06-09T10:00:05.788987  / # . /lava-3652234/environment/lava-365223=
4/bin/lava-test-runner /lava-3652234/1
    2023-06-09T10:00:05.789658  =

    2023-06-09T10:00:05.794665  / # /lava-3652234/bin/lava-test-runner /lav=
a-3652234/1
    2023-06-09T10:00:05.872154  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
dove-cubox                | arm    | lab-pengutronix | gcc-10   | mvebu_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6482f5806e7c1e34f33061b4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: mvebu_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.285/=
arm/mvebu_v7_defconfig/gcc-10/lab-pengutronix/baseline-dove-cubox.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.285/=
arm/mvebu_v7_defconfig/gcc-10/lab-pengutronix/baseline-dove-cubox.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6482f5806e7c1e34f33061b9
        failing since 141 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-06-09T09:48:31.079796  + set +x
    2023-06-09T09:48:31.080016  [    4.243513] <LAVA_SIGNAL_ENDRUN 0_dmesg =
972228_1.5.2.3.1>
    2023-06-09T09:48:31.186704  / # #
    2023-06-09T09:48:31.288568  export SHELL=3D/bin/sh
    2023-06-09T09:48:31.289188  #
    2023-06-09T09:48:31.390592  / # export SHELL=3D/bin/sh. /lava-972228/en=
vironment
    2023-06-09T09:48:31.391122  =

    2023-06-09T09:48:31.492375  / # . /lava-972228/environment/lava-972228/=
bin/lava-test-runner /lava-972228/1
    2023-06-09T09:48:31.493061  =

    2023-06-09T09:48:31.495523  / # /lava-972228/bin/lava-test-runner /lava=
-972228/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6482f7efc6a03c8f76306134

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.285/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.285/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6482f7efc6a03c8f76306139
        failing since 141 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-06-09T09:59:00.670013  / # #

    2023-06-09T09:59:00.772333  export SHELL=3D/bin/sh

    2023-06-09T09:59:00.773086  #

    2023-06-09T09:59:00.874984  / # export SHELL=3D/bin/sh. /lava-10656548/=
environment

    2023-06-09T09:59:00.875804  =


    2023-06-09T09:59:00.977802  / # . /lava-10656548/environment/lava-10656=
548/bin/lava-test-runner /lava-10656548/1

    2023-06-09T09:59:00.978990  =


    2023-06-09T09:59:00.992533  / # /lava-10656548/bin/lava-test-runner /la=
va-10656548/1

    2023-06-09T09:59:01.090445  + export 'TESTRUN_ID=3D1_bootrr'

    2023-06-09T09:59:01.090996  + cd /lava-10656548/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | imx_v6_v7=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6482f9cd5acf7381f93061d3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.285/=
arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboard-re=
vd1.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.285/=
arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboard-re=
vd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6482f9cd5acf7381f93061d8
        failing since 141 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-06-09T10:06:58.773745  + set +x[    7.336673] <LAVA_SIGNAL_ENDRUN =
0_dmesg 972241_1.5.2.3.1>
    2023-06-09T10:06:58.774056  =

    2023-06-09T10:06:58.880983  / # #
    2023-06-09T10:06:58.982927  export SHELL=3D/bin/sh
    2023-06-09T10:06:58.983401  #
    2023-06-09T10:06:59.084683  / # export SHELL=3D/bin/sh. /lava-972241/en=
vironment
    2023-06-09T10:06:59.085164  =

    2023-06-09T10:06:59.186389  / # . /lava-972241/environment/lava-972241/=
bin/lava-test-runner /lava-972241/1
    2023-06-09T10:06:59.187035  =

    2023-06-09T10:06:59.189573  / # /lava-972241/bin/lava-test-runner /lava=
-972241/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6482f7d82ad310a9ac306165

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.285/=
arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboard-rev=
d1.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.285/=
arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboard-rev=
d1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6482f7d82ad310a9ac306168
        failing since 141 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-06-09T09:58:35.717981  + set +x
    2023-06-09T09:58:35.718249  [    4.856118] <LAVA_SIGNAL_ENDRUN 0_dmesg =
972238_1.5.2.3.1>
    2023-06-09T09:58:35.824640  / # #
    2023-06-09T09:58:35.926390  export SHELL=3D/bin/sh
    2023-06-09T09:58:35.926933  #
    2023-06-09T09:58:36.028246  / # export SHELL=3D/bin/sh. /lava-972238/en=
vironment
    2023-06-09T09:58:36.028722  =

    2023-06-09T09:58:36.130135  / # . /lava-972238/environment/lava-972238/=
bin/lava-test-runner /lava-972238/1
    2023-06-09T09:58:36.130847  =

    2023-06-09T09:58:36.133522  / # /lava-972238/bin/lava-test-runner /lava=
-972238/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 3          =


  Details:     https://kernelci.org/test/plan/id/6482f7e75a14c5074530614a

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.285/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.285/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/6482f7e75a14c5074530617a
        failing since 140 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-06-09T09:59:17.212818  BusyBox v1.31.1 (2023-05-27 14:14:16 UTC)<8=
>[   12.869181] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-06-09T09:59:17.214697   multi-call binary.

    2023-06-09T09:59:17.214916  =


    2023-06-09T09:59:17.219286  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-06-09T09:59:17.219579  =


    2023-06-09T09:59:17.224506  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-06-09T09:59:17.234953  FIRST,<8>[   12.887870] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/6482f7e75a14c5074530617b
        failing since 140 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-06-09T09:59:17.194053  /lava-10656557/1/../bin/lava-test-case<8>[ =
  12.851807] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-probed RE=
SULT=3Dpass>

    2023-06-09T09:59:17.194119  =

   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6482f7e75a14c5074530618e
        failing since 140 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-06-09T09:59:13.364795  <8>[    9.022414] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-06-09T09:59:13.373768  + <8>[    9.034401] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10656557_1.5.2.3.1>

    2023-06-09T09:59:13.376337  set +x

    2023-06-09T09:59:13.480429  #

    2023-06-09T09:59:13.481573  =


    2023-06-09T09:59:13.583171  / # #export SHELL=3D/bin/sh

    2023-06-09T09:59:13.583893  =


    2023-06-09T09:59:13.685225  / # export SHELL=3D/bin/sh. /lava-10656557/=
environment

    2023-06-09T09:59:13.685976  =


    2023-06-09T09:59:13.787528  / # . /lava-10656557/environment/lava-10656=
557/bin/lava-test-runner /lava-10656557/1
 =

    ... (18 line(s) more)  =

 =20
