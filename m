Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA7F6F4C11
	for <lists+stable@lfdr.de>; Tue,  2 May 2023 23:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjEBVVW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 2 May 2023 17:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjEBVVU (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 2 May 2023 17:21:20 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D9F10DE
        for <stable@vger.kernel.org>; Tue,  2 May 2023 14:20:52 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1aad5245632so27561375ad.3
        for <stable@vger.kernel.org>; Tue, 02 May 2023 14:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683062452; x=1685654452;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rStwVQ+sSvIO2AuQOFADWkCGseFeR8z7Rc0ZjP44LZM=;
        b=TwOgT3HyYk8ASDs7/z/9fB+xwAxbAGJeLuUrow/K+eQeLCmQ6B73xsLFo4zjr9OnEx
         +k7u2Td1cnNpBKvzG3WxzChoTVxNEXumc+Ifjht2h0fc86ksnmNZknGm28v4aqkP5L3t
         T+50u2xk64jPrM4sHQy2YEhe8sBiGlOzFmU5I18SqBQ5Lidui3yTvKgFABw8qQNgE0Pc
         xBGQWq5PlN4IL6QlmHHZHKst8FbiJeDhLOaVIV9z7a7ia/WfJLqSIMtbkTVZzjazHF6K
         m0iy5xqdKqHXpJHwYeauDxlvaMqARzqnxk/EpkRemd6ecd51RHbH5Dltau9TkHx0XWdR
         uq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683062452; x=1685654452;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rStwVQ+sSvIO2AuQOFADWkCGseFeR8z7Rc0ZjP44LZM=;
        b=hS131qOHq4Wh20P9ZooR2W9X1TeRoo7gjhFxH7UeMbw4eVc0ieRXeEDfC9I99gSuX0
         yRAL987lboInZsb6Wn0WHc2x5rPrNBhuyjyHKIqmn2fuAC5/mLpMUuuDla6heHYcsUpB
         QUHsQGVIYQZDEu5l+kBGKtOH5+kHz3ZAaHQnTs1DWlt2wvZhHa+VdF/5sE1kBD9bFXGu
         Pd4ueBv5oCGTToetbWQ8jzud+LtMu/yD3/MR69psQNLtsKfKv103w7MMacrO/uJFa7v0
         VmZ4pECju9Cxx4pk7H7+JwUqpppq4yUK41hiiTX2BQGSD6Y/nrqH2KMPLqn45cQq0ki0
         HM5A==
X-Gm-Message-State: AC+VfDwLvq/QyP2OjmtgewXLFEUh/rpgD+d7Mn/v5DW+yqLV+GrKiIEO
        T5TrWpNFVGFy1/mZPw39CmfFUmMLynrMJc3gjj8=
X-Google-Smtp-Source: ACHHUZ5S5CxIi364BLDU/g8O/bqS4dWAZGy8zBhNTUKq1TIfmQtR3PXVw3+degetbObdxpqbCqbvvw==
X-Received: by 2002:a17:902:da84:b0:1a6:d774:339a with SMTP id j4-20020a170902da8400b001a6d774339amr20861707plx.4.1683062451727;
        Tue, 02 May 2023 14:20:51 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e10-20020a170902b78a00b001aafdf8063dsm3548902pls.157.2023.05.02.14.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 14:20:50 -0700 (PDT)
Message-ID: <64517eb2.170a0220.3c69b.7b2e@mx.google.com>
Date:   Tue, 02 May 2023 14:20:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.105-370-g63bef32a2e80
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 165 runs,
 9 regressions (v5.15.105-370-g63bef32a2e80)
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

stable-rc/queue/5.15 baseline: 165 runs, 9 regressions (v5.15.105-370-g63be=
f32a2e80)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.105-370-g63bef32a2e80/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.105-370-g63bef32a2e80
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      63bef32a2e8010be20db2632fc1c68ec40d5c262 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64514bec26ea8220ee2e8651

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-370-g63bef32a2e80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-370-g63bef32a2e80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64514bec26ea8220ee2e8656
        failing since 35 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-02T17:43:48.951363  + set<8>[   10.956228] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10177023_1.4.2.3.1>

    2023-05-02T17:43:48.951950   +x

    2023-05-02T17:43:49.060243  / # #

    2023-05-02T17:43:49.162741  export SHELL=3D/bin/sh

    2023-05-02T17:43:49.163662  #

    2023-05-02T17:43:49.265366  / # export SHELL=3D/bin/sh. /lava-10177023/=
environment

    2023-05-02T17:43:49.266212  =


    2023-05-02T17:43:49.368187  / # . /lava-10177023/environment/lava-10177=
023/bin/lava-test-runner /lava-10177023/1

    2023-05-02T17:43:49.369596  =


    2023-05-02T17:43:49.374328  / # /lava-10177023/bin/lava-test-runner /la=
va-10177023/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64514ad121474da1e12e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-370-g63bef32a2e80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-370-g63bef32a2e80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64514ad121474da1e12e85eb
        failing since 35 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-02T17:39:07.533403  <8>[   10.631364] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10176977_1.4.2.3.1>

    2023-05-02T17:39:07.536173  + set +x

    2023-05-02T17:39:07.637667  #

    2023-05-02T17:39:07.637928  =


    2023-05-02T17:39:07.738510  / # #export SHELL=3D/bin/sh

    2023-05-02T17:39:07.738701  =


    2023-05-02T17:39:07.839167  / # export SHELL=3D/bin/sh. /lava-10176977/=
environment

    2023-05-02T17:39:07.839364  =


    2023-05-02T17:39:07.939873  / # . /lava-10176977/environment/lava-10176=
977/bin/lava-test-runner /lava-10176977/1

    2023-05-02T17:39:07.940481  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/645149e4e8ac5e7a962e85ef

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-370-g63bef32a2e80/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-370-g63bef32a2e80/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645149e4e8ac5e7a962e8=
5f0
        failing since 88 days (last pass: v5.15.91-12-g3290f78df1ab, first =
fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64514683619aa686502e85fc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-370-g63bef32a2e80/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-370-g63bef32a2e80/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64514683619aa686502e8601
        failing since 105 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-02T17:20:56.933360  + set +x<8>[   10.158649] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3546675_1.5.2.4.1>
    2023-05-02T17:20:56.934168  =

    2023-05-02T17:20:57.045215  / # #
    2023-05-02T17:20:57.149629  export SHELL=3D/bin/sh
    2023-05-02T17:20:57.151003  #<3>[   10.272966] Bluetooth: hci0: command=
 0x0c03 tx timeout
    2023-05-02T17:20:57.151644  =

    2023-05-02T17:20:57.253897  / # export SHELL=3D/bin/sh. /lava-3546675/e=
nvironment
    2023-05-02T17:20:57.255320  =

    2023-05-02T17:20:57.357704  / # . /lava-3546675/environment/lava-354667=
5/bin/lava-test-runner /lava-3546675/1
    2023-05-02T17:20:57.359447   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64514bdf396604aac02e861a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-370-g63bef32a2e80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-370-g63bef32a2e80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64514bdf396604aac02e861f
        failing since 35 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-02T17:43:43.287686  + set +x

    2023-05-02T17:43:43.293746  <8>[   10.141254] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10176993_1.4.2.3.1>

    2023-05-02T17:43:43.400868  / # #

    2023-05-02T17:43:43.503112  export SHELL=3D/bin/sh

    2023-05-02T17:43:43.503833  #

    2023-05-02T17:43:43.605342  / # export SHELL=3D/bin/sh. /lava-10176993/=
environment

    2023-05-02T17:43:43.606145  =


    2023-05-02T17:43:43.707742  / # . /lava-10176993/environment/lava-10176=
993/bin/lava-test-runner /lava-10176993/1

    2023-05-02T17:43:43.708884  =


    2023-05-02T17:43:43.713594  / # /lava-10176993/bin/lava-test-runner /la=
va-10176993/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64514c3e59269307f52e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-370-g63bef32a2e80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-370-g63bef32a2e80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64514c3e59269307f52e85eb
        failing since 35 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-02T17:45:13.196410  + set<8>[   10.660283] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10176955_1.4.2.3.1>

    2023-05-02T17:45:13.196845   +x

    2023-05-02T17:45:13.303555  /#

    2023-05-02T17:45:13.406088   # #export SHELL=3D/bin/sh

    2023-05-02T17:45:13.406860  =


    2023-05-02T17:45:13.508236  / # export SHELL=3D/bin/sh. /lava-10176955/=
environment

    2023-05-02T17:45:13.508975  =


    2023-05-02T17:45:13.610425  / # . /lava-10176955/environment/lava-10176=
955/bin/lava-test-runner /lava-10176955/1

    2023-05-02T17:45:13.611579  =


    2023-05-02T17:45:13.616681  / # /lava-10176955/bin/lava-test-runner /la=
va-10176955/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64514ac98e727f0e932e85f1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-370-g63bef32a2e80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-370-g63bef32a2e80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64514ac98e727f0e932e85f6
        failing since 35 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-02T17:38:57.587418  + set<8>[   11.271608] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10177032_1.4.2.3.1>

    2023-05-02T17:38:57.587528   +x

    2023-05-02T17:38:57.692204  / # #

    2023-05-02T17:38:57.792777  export SHELL=3D/bin/sh

    2023-05-02T17:38:57.793066  #

    2023-05-02T17:38:57.893897  / # export SHELL=3D/bin/sh. /lava-10177032/=
environment

    2023-05-02T17:38:57.894924  =


    2023-05-02T17:38:57.996778  / # . /lava-10177032/environment/lava-10177=
032/bin/lava-test-runner /lava-10177032/1

    2023-05-02T17:38:57.998087  =


    2023-05-02T17:38:58.003173  / # /lava-10177032/bin/lava-test-runner /la=
va-10177032/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64514ab22531fc77fc2e8637

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-370-g63bef32a2e80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-370-g63bef32a2e80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64514ab22531fc77fc2e863c
        failing since 35 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-02T17:38:47.791881  + set<8>[   11.288188] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10177014_1.4.2.3.1>

    2023-05-02T17:38:47.792001   +x

    2023-05-02T17:38:47.896539  / # #

    2023-05-02T17:38:47.997301  export SHELL=3D/bin/sh

    2023-05-02T17:38:47.997543  #

    2023-05-02T17:38:48.098110  / # export SHELL=3D/bin/sh. /lava-10177014/=
environment

    2023-05-02T17:38:48.098328  =


    2023-05-02T17:38:48.198877  / # . /lava-10177014/environment/lava-10177=
014/bin/lava-test-runner /lava-10177014/1

    2023-05-02T17:38:48.199251  =


    2023-05-02T17:38:48.204361  / # /lava-10177014/bin/lava-test-runner /la=
va-10177014/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64514a8ba14c10f2a12e86c7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-370-g63bef32a2e80/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-370-g63bef32a2e80/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64514a8ba14c10f2a12e86cc
        failing since 89 days (last pass: v5.15.72-36-g40cafafcdb983, first=
 fail: v5.15.90-215-gdf99871482a0)

    2023-05-02T17:38:05.134606  [   16.038476] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3546796_1.5.2.4.1>
    2023-05-02T17:38:05.239173  =

    2023-05-02T17:38:05.340708  / # #export SHELL=3D/bin/sh
    2023-05-02T17:38:05.341154  =

    2023-05-02T17:38:05.341386  / # [   16.161026] rockchip-drm display-sub=
system: [drm] Cannot find any crtc or sizes
    2023-05-02T17:38:05.442734  export SHELL=3D/bin/sh. /lava-3546796/envir=
onment
    2023-05-02T17:38:05.443208  =

    2023-05-02T17:38:05.544631  / # . /lava-3546796/environment/lava-354679=
6/bin/lava-test-runner /lava-3546796/1
    2023-05-02T17:38:05.545354  =

    2023-05-02T17:38:05.548773  / # /lava-3546796/bin/lava-test-runner /lav=
a-3546796/1 =

    ... (13 line(s) more)  =

 =20
