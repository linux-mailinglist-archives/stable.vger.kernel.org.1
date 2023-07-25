Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10615760619
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 04:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjGYC6t (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 22:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjGYC6q (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 22:58:46 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8FCE71
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 19:58:30 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b9c5e07c1bso38492085ad.2
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 19:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690253910; x=1690858710;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vjVpeZgyQmP67DKmUgippq6XLW3Gg31kV5dWUkLLtFY=;
        b=pclom9y3nrEBpAfkg9lhHNVQcYO09ra+b3BWISyxFzHfuassTkIJBkuKTnf5m9WSTs
         gF5spz3WPHF9Az5D2d057pO6p1Wp+J2BriiytvakRgQRcSQhuMYA19Ek/X6WhGpTTlfe
         11rNp21jDFv9dBhOavsQ+oQWQ0wQbqB7bsbkPnCtLU5BmuLkuvrUPe3q0ESem5SZ69zd
         mCS52OpnWVlH1q0UQIw5+jT+kTMKCn84EnL1E1mfxsu66QPBDHl8B+gGTzafTab61XA+
         ey+Yy3iFnjijJy+FS7bzydThpBdSgSdqGN9MNeTBDYLhvxozG601Z6IQpxGna4vP6+HO
         7FfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690253910; x=1690858710;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vjVpeZgyQmP67DKmUgippq6XLW3Gg31kV5dWUkLLtFY=;
        b=E7/rPnnD6ns0q2BJGZ/gsRGkcwoZA2QB/GF/O8GYLnjIRifO3Lszqm6Rt1QGsv3iGT
         bZpUmZ0URg6rOkHARxqr5Se4koxNC/x4d20kP9UA7nnendlMVNLnxWsY92pHbUXKkCBB
         6StLOTcutGPzOP13jkPR7mzuZjk4HJViBaNwS1/bjaH9FjUEaBn/qtCFNws9gfEDNr2l
         oImYLUUaIxBx6+n5sMuZVGlwIzjsHOS04e+dHMooReoNMmkV8eu3SYApYsvN/o+L9d7p
         wL7ZL8KJU/LZqSao2wWl5nrq1l9kyKMZzGUwKt0Py6UwF4cWbgJoxOJYpSh914vpHET7
         Rhgw==
X-Gm-Message-State: ABy/qLa7D9xlzROR5MDBskNGAu81UqlH6h/JS8gW5RkJLNQPRKbX/2MA
        iI3hl6uOWDIX5n8C/si+UH9fg0dOU7i1d7Jlmi1ntHnI
X-Google-Smtp-Source: APBJJlGyIiS6xKwiCty0nuNTgs9ZBLsjVJsUtOSpjNKf4ium1Bg+U6VaZD+9LUrwNnx6kjNzg9DQDg==
X-Received: by 2002:a17:902:76c6:b0:1b8:560a:aa16 with SMTP id j6-20020a17090276c600b001b8560aaa16mr11511377plt.10.1690253909623;
        Mon, 24 Jul 2023 19:58:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b1-20020a170902d50100b001b1c4d875f5sm9624928plg.44.2023.07.24.19.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 19:58:28 -0700 (PDT)
Message-ID: <64bf3a54.170a0220.6c27d.1fce@mx.google.com>
Date:   Mon, 24 Jul 2023 19:58:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Kernel: v5.15.122
X-Kernelci-Report-Type: test
Subject: stable/linux-5.15.y baseline: 27 runs, 7 regressions (v5.15.122)
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

stable/linux-5.15.y baseline: 27 runs, 7 regressions (v5.15.122)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.15.y/kernel=
/v5.15.122/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.15.y
  Describe: v5.15.122
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      5c6a716301d915055c7bd6d935f7a4fccec2649c =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64bf068ea25a67b1e78ace3b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.122/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.122/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bf068ea25a67b1e78ace40
        failing since 116 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-07-24T23:17:17.099751  <8>[    8.157551] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11130816_1.4.2.3.1>

    2023-07-24T23:17:17.103151  + set +x

    2023-07-24T23:17:17.207653  / # #

    2023-07-24T23:17:17.308257  export SHELL=3D/bin/sh

    2023-07-24T23:17:17.308447  #

    2023-07-24T23:17:17.408966  / # export SHELL=3D/bin/sh. /lava-11130816/=
environment

    2023-07-24T23:17:17.409138  =


    2023-07-24T23:17:17.509644  / # . /lava-11130816/environment/lava-11130=
816/bin/lava-test-runner /lava-11130816/1

    2023-07-24T23:17:17.509880  =


    2023-07-24T23:17:17.515934  / # /lava-11130816/bin/lava-test-runner /la=
va-11130816/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64bf0698039dd67e558ace21

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.122/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.122/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bf0698039dd67e558ace26
        failing since 116 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-07-24T23:17:27.252438  + set<8>[   11.291998] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11130818_1.4.2.3.1>

    2023-07-24T23:17:27.252524   +x

    2023-07-24T23:17:27.356524  / # #

    2023-07-24T23:17:27.457141  export SHELL=3D/bin/sh

    2023-07-24T23:17:27.457339  #

    2023-07-24T23:17:27.557858  / # export SHELL=3D/bin/sh. /lava-11130818/=
environment

    2023-07-24T23:17:27.558025  =


    2023-07-24T23:17:27.658655  / # . /lava-11130818/environment/lava-11130=
818/bin/lava-test-runner /lava-11130818/1

    2023-07-24T23:17:27.659689  =


    2023-07-24T23:17:27.664441  / # /lava-11130818/bin/lava-test-runner /la=
va-11130818/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64bf06a2376449665d8ace24

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.122/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.122/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bf06a2376449665d8ace29
        failing since 116 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-07-24T23:17:43.055067  <8>[   10.789807] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11130820_1.4.2.3.1>

    2023-07-24T23:17:43.058434  + set +x

    2023-07-24T23:17:43.159877  #

    2023-07-24T23:17:43.160342  =


    2023-07-24T23:17:43.261093  / # #export SHELL=3D/bin/sh

    2023-07-24T23:17:43.261306  =


    2023-07-24T23:17:43.361829  / # export SHELL=3D/bin/sh. /lava-11130820/=
environment

    2023-07-24T23:17:43.362026  =


    2023-07-24T23:17:43.462559  / # . /lava-11130820/environment/lava-11130=
820/bin/lava-test-runner /lava-11130820/1

    2023-07-24T23:17:43.462993  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64bf0680d14dcb07da8ace50

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.122/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.122/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bf0680d14dcb07da8ace55
        failing since 116 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-07-24T23:17:21.850328  + set +x

    2023-07-24T23:17:21.857135  <8>[    9.906592] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11130842_1.4.2.3.1>

    2023-07-24T23:17:21.961421  / # #

    2023-07-24T23:17:22.062000  export SHELL=3D/bin/sh

    2023-07-24T23:17:22.062191  #

    2023-07-24T23:17:22.162677  / # export SHELL=3D/bin/sh. /lava-11130842/=
environment

    2023-07-24T23:17:22.162875  =


    2023-07-24T23:17:22.263393  / # . /lava-11130842/environment/lava-11130=
842/bin/lava-test-runner /lava-11130842/1

    2023-07-24T23:17:22.263704  =


    2023-07-24T23:17:22.268689  / # /lava-11130842/bin/lava-test-runner /la=
va-11130842/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64bf067b226fa9f50e8ace53

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.122/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.122/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bf067b226fa9f50e8ace58
        failing since 116 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-07-24T23:17:05.842199  <8>[   10.070568] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11130830_1.4.2.3.1>

    2023-07-24T23:17:05.845144  + set +x

    2023-07-24T23:17:05.946788  #

    2023-07-24T23:17:05.947075  =


    2023-07-24T23:17:06.047677  / # #export SHELL=3D/bin/sh

    2023-07-24T23:17:06.047939  =


    2023-07-24T23:17:06.148513  / # export SHELL=3D/bin/sh. /lava-11130830/=
environment

    2023-07-24T23:17:06.148691  =


    2023-07-24T23:17:06.249217  / # . /lava-11130830/environment/lava-11130=
830/bin/lava-test-runner /lava-11130830/1

    2023-07-24T23:17:06.249519  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64bf069a42649666c98ace1e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.122/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.122/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bf069a42649666c98ace23
        failing since 116 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-07-24T23:17:25.800687  + set<8>[   10.850466] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11130857_1.4.2.3.1>

    2023-07-24T23:17:25.801192   +x

    2023-07-24T23:17:25.909843  / # #

    2023-07-24T23:17:26.012231  export SHELL=3D/bin/sh

    2023-07-24T23:17:26.012945  #

    2023-07-24T23:17:26.114658  / # export SHELL=3D/bin/sh. /lava-11130857/=
environment

    2023-07-24T23:17:26.115340  =


    2023-07-24T23:17:26.216914  / # . /lava-11130857/environment/lava-11130=
857/bin/lava-test-runner /lava-11130857/1

    2023-07-24T23:17:26.218258  =


    2023-07-24T23:17:26.222414  / # /lava-11130857/bin/lava-test-runner /la=
va-11130857/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64bf067ad14dcb07da8ace29

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.122/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.122/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bf067ad14dcb07da8ace2e
        failing since 116 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-07-24T23:17:08.780544  + set<8>[   12.296441] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11130821_1.4.2.3.1>

    2023-07-24T23:17:08.780630   +x

    2023-07-24T23:17:08.885236  / # #

    2023-07-24T23:17:08.985850  export SHELL=3D/bin/sh

    2023-07-24T23:17:08.986074  #

    2023-07-24T23:17:09.086609  / # export SHELL=3D/bin/sh. /lava-11130821/=
environment

    2023-07-24T23:17:09.086802  =


    2023-07-24T23:17:09.187317  / # . /lava-11130821/environment/lava-11130=
821/bin/lava-test-runner /lava-11130821/1

    2023-07-24T23:17:09.187589  =


    2023-07-24T23:17:09.192734  / # /lava-11130821/bin/lava-test-runner /la=
va-11130821/1
 =

    ... (12 line(s) more)  =

 =20
