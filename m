Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9C7711A18
	for <lists+stable@lfdr.de>; Fri, 26 May 2023 00:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjEYWRu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 25 May 2023 18:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjEYWRt (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 25 May 2023 18:17:49 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530AC134
        for <stable@vger.kernel.org>; Thu, 25 May 2023 15:17:47 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64d24136685so195683b3a.1
        for <stable@vger.kernel.org>; Thu, 25 May 2023 15:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685053066; x=1687645066;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iS1CrGAw03LAIMMutu0Pt9tAbTmKFwNiQefZc+V2h1c=;
        b=JFZyGLQP1fAEO+M4uG2YD2jmvIuvyjPJbyDiFQMkH2NdhnF7N4th69sPeW0iGZYLsx
         3J2PWca7nwgGib8Q3HAmVFnOLEcD0nPlK8U85bkKlrz7ErqHgJFcbDbhdL2nucHjGbU7
         OxgRonenMTqnH3vP/caEvmoUwf0w49IPWYdhg2QSURpppZWCuaw8hXbMGQ8YRFCmrAgd
         R4ZRmeDVCn/8flVcw+uZGKL48/Mr//IJrGYnfi4WUMTIupuzSOdRxBAOfa80rG2buRha
         LpezHSz+5Dj7L1btMb+zKmCf08XMN8IHIsAXmOyJYRWspUWbzH1nUY20lUYaAS5Web/j
         UJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685053066; x=1687645066;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iS1CrGAw03LAIMMutu0Pt9tAbTmKFwNiQefZc+V2h1c=;
        b=e0C5hE9TCcRkzStiCQEMyGy6PJTnu8TId1Rux54ot+D1AX80Bqony1171+evnbik/S
         I9t/M5gS6xAihyqE3I9PMurn7kXhXvsSVj3uD+wJzxAPp/hh0OpTyxbRUA6087z4DFvW
         J48mKB3lNFZTYJXGaQ4EIpxKkpqAkpaB4ud4dyUPOYVEALrdamH2L/OCLgLVhEcVEr6N
         t2bC2FV2Az47XA3NBNJQiUCRSju0/1X9xB2XFBfUrgrU1U3IcvuFYLxMuZpevY/08nsj
         ZC9GqKjjQTeWxHimojf8Z/vT8Vh3g5TWyHgM0a0EZXPwI7KK+e6vvafRc724QirwaMjm
         CJeQ==
X-Gm-Message-State: AC+VfDzsbPe4XIPKEjvDKPlzJ6OWXiVu83jPuuE+uMeiWbuwOrLgXNLV
        dU71tjyn88s5+fq8HqVHxYLfuymN7MxHobe20maJXQ==
X-Google-Smtp-Source: ACHHUZ761A7FzRfH/71MXSl7UFzL5MlIlVY0PaIBoht2wj1FZl1G2RqyeClr0ZJvOmLgkM8KuwgaDg==
X-Received: by 2002:a05:6a00:997:b0:64f:3840:3c24 with SMTP id u23-20020a056a00099700b0064f38403c24mr5313330pfg.16.1685053066112;
        Thu, 25 May 2023 15:17:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c12-20020a62e80c000000b00640dbf177b8sm1612730pfi.37.2023.05.25.15.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 15:17:45 -0700 (PDT)
Message-ID: <646fde89.620a0220.53547.3536@mx.google.com>
Date:   Thu, 25 May 2023 15:17:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.180-158-ga824e2caa342
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 158 runs,
 6 regressions (v5.10.180-158-ga824e2caa342)
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

stable-rc/queue/5.10 baseline: 158 runs, 6 regressions (v5.10.180-158-ga824=
e2caa342)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.180-158-ga824e2caa342/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.180-158-ga824e2caa342
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      a824e2caa3422fa0aa42aee68ece343cd4412df6 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/646fb90056e7dc60172e85f8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-158-ga824e2caa342/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-158-ga824e2caa342/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646fb90056e7dc60172e8=
5f9
        new failure (last pass: v5.10.180-153-g6c958850abd5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/646fa4ac7d4f0d5c9f2e85e8

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-158-ga824e2caa342/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-158-ga824e2caa342/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646fa4ac7d4f0d5c9f2e861c
        failing since 100 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-05-25T18:10:31.211987  <8>[   20.090572] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 512843_1.5.2.4.1>
    2023-05-25T18:10:31.321451  / # #
    2023-05-25T18:10:31.423314  export SHELL=3D/bin/sh
    2023-05-25T18:10:31.423767  #
    2023-05-25T18:10:31.525671  / # export SHELL=3D/bin/sh. /lava-512843/en=
vironment
    2023-05-25T18:10:31.526392  =

    2023-05-25T18:10:31.628560  / # . /lava-512843/environment/lava-512843/=
bin/lava-test-runner /lava-512843/1
    2023-05-25T18:10:31.629464  =

    2023-05-25T18:10:31.634266  / # /lava-512843/bin/lava-test-runner /lava=
-512843/1
    2023-05-25T18:10:31.738975  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646faf8dc4a113fc402e8604

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-158-ga824e2caa342/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-158-ga824e2caa342/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646faf8dc4a113fc402e8609
        failing since 119 days (last pass: v5.10.165-76-g5c2e982fcf18, firs=
t fail: v5.10.165-77-g4600242c13ed)

    2023-05-25T18:57:04.267474  <8>[   11.191066] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3617003_1.5.2.4.1>
    2023-05-25T18:57:04.377352  / # #
    2023-05-25T18:57:04.480457  export SHELL=3D/bin/sh
    2023-05-25T18:57:04.481325  #
    2023-05-25T18:57:04.583261  / # export SHELL=3D/bin/sh. /lava-3617003/e=
nvironment
    2023-05-25T18:57:04.584175  =

    2023-05-25T18:57:04.686535  / # . /lava-3617003/environment/lava-361700=
3/bin/lava-test-runner /lava-3617003/1
    2023-05-25T18:57:04.687855  =

    2023-05-25T18:57:04.692840  / # /lava-3617003/bin/lava-test-runner /lav=
a-3617003/1
    2023-05-25T18:57:04.778882  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646fa563c3d97cc5ed2e85e9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-158-ga824e2caa342/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-158-ga824e2caa342/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646fa563c3d97cc5ed2e85ee
        failing since 56 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-25T18:13:50.389473  + <8>[   14.875569] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10456046_1.4.2.3.1>

    2023-05-25T18:13:50.389584  set +x

    2023-05-25T18:13:50.490695  #

    2023-05-25T18:13:50.591571  / # #export SHELL=3D/bin/sh

    2023-05-25T18:13:50.591780  =


    2023-05-25T18:13:50.692264  / # export SHELL=3D/bin/sh. /lava-10456046/=
environment

    2023-05-25T18:13:50.692458  =


    2023-05-25T18:13:50.792980  / # . /lava-10456046/environment/lava-10456=
046/bin/lava-test-runner /lava-10456046/1

    2023-05-25T18:13:50.793294  =


    2023-05-25T18:13:50.798420  / # /lava-10456046/bin/lava-test-runner /la=
va-10456046/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646fa569c3d97cc5ed2e862f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-158-ga824e2caa342/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-158-ga824e2caa342/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646fa569c3d97cc5ed2e8634
        failing since 56 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-25T18:13:46.225516  <8>[   14.166717] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10456008_1.4.2.3.1>

    2023-05-25T18:13:46.228821  + set +x

    2023-05-25T18:13:46.337295  / # #

    2023-05-25T18:13:46.439364  export SHELL=3D/bin/sh

    2023-05-25T18:13:46.440101  #

    2023-05-25T18:13:46.541590  / # export SHELL=3D/bin/sh. /lava-10456008/=
environment

    2023-05-25T18:13:46.542381  =


    2023-05-25T18:13:46.643846  / # . /lava-10456008/environment/lava-10456=
008/bin/lava-test-runner /lava-10456008/1

    2023-05-25T18:13:46.645271  =


    2023-05-25T18:13:46.650449  / # /lava-10456008/bin/lava-test-runner /la=
va-10456008/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646fa61c12406a6cab2e8636

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-158-ga824e2caa342/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-158-ga824e2caa342/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646fa61c12406a6cab2e863b
        failing since 112 days (last pass: v5.10.165-139-gefb57ce0f880, fir=
st fail: v5.10.165-149-ge30e8271d674)

    2023-05-25T18:16:51.220995  / # #
    2023-05-25T18:16:51.323405  export SHELL=3D/bin/sh
    2023-05-25T18:16:51.324082  #
    2023-05-25T18:16:51.425659  / # export SHELL=3D/bin/sh. /lava-3616990/e=
nvironment
    2023-05-25T18:16:51.426317  =

    2023-05-25T18:16:51.527937  / # . /lava-3616990/environment/lava-361699=
0/bin/lava-test-runner /lava-3616990/1
    2023-05-25T18:16:51.528725  =

    2023-05-25T18:16:51.546611  / # /lava-3616990/bin/lava-test-runner /lav=
a-3616990/1
    2023-05-25T18:16:51.634611  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-25T18:16:51.634980  + cd /lava-3616990/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
