Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45D571398C
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 15:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjE1NV3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 09:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjE1NV1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 09:21:27 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE77DE
        for <stable@vger.kernel.org>; Sun, 28 May 2023 06:21:22 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64d2467d640so2918741b3a.1
        for <stable@vger.kernel.org>; Sun, 28 May 2023 06:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685280081; x=1687872081;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cJ/li8T3S6jktfaiOjql2UDeddWn7tym0f8HAS4XcO4=;
        b=LYbRHNKJKCfy1BilgA27KTpXafS0QTZRIPLjT5Dom/uKHcF3oSAlYhJ52Mv7badCNj
         97tdF6dwh+bTh78j+bSz3StKvfKgOvSHkm/XMsY7nuCC5UIq2PIhZH1PKeh0jPlFaj4l
         1EQV81LpThhyb+sxppwGiCrHM6LVILZTzvAeXLynS13HrhjJtuAdtjkZuBIKEH471Jau
         7btQJwMFgLjZ4RlB8rJvbar2/Cdn5LyWncexAJZn1J7uK+22l8Kn1wUZQx3UfBnbig3E
         44gJqlouDCUOpgM8jupzMEV7I7P21V/wkzru0upQ+p9NGiL0wo4XNYylXzFxoVeYRpNY
         eSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685280081; x=1687872081;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cJ/li8T3S6jktfaiOjql2UDeddWn7tym0f8HAS4XcO4=;
        b=NJ8TB9kFR+0kuMycISSAGz48JdyADq42NygRlGad7udoplD6bbLqg8TGjafFqSSDcc
         1MTh8ijLiee4j7oyRXr3EiKla8d+8wb1mAeOj5lGyCwe5zpl6OnMBuI6JkistJsL4pJi
         qpaCR0xTdXjELPK3DxQmcqJ94S0IO4ePJfSBYhOKXsXHBsZeiBOKkrx0mK8J6JkvAzLD
         oyOdS1yO3bHjHMofX8nt/BmUfR3fMVhooA6LySiwwJd45DBz0rNT2ZVbd4VYLE6oSW3W
         1SqB1EnF9VQ6TWKZxKlEJPetR29aTqinHeWMeZtCNZdUIXrVdJCiylubYwFIgZJKUzPM
         2bQA==
X-Gm-Message-State: AC+VfDwQbFvvwqVWgWS0lIjFtDBpTZpwdojmwhLwcYP/M8sfAPMoLCa5
        i6B3JqEOVBtiLkk1DkOlKhtnHOWDyWUJXAwJbGo=
X-Google-Smtp-Source: ACHHUZ4lsnWu3Cu9GD7kRkz0PeKPzou4zMbmkcZay5/r9Uxmy83IFr1LaPdW5fKUUstNtXqFbN8WVw==
X-Received: by 2002:a05:6a20:6f0e:b0:10b:40a9:ec48 with SMTP id gt14-20020a056a206f0e00b0010b40a9ec48mr5189912pzb.29.1685280081006;
        Sun, 28 May 2023 06:21:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b19-20020a639313000000b0051b0e564963sm5486724pge.49.2023.05.28.06.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 06:21:20 -0700 (PDT)
Message-ID: <64735550.630a0220.23274.a805@mx.google.com>
Date:   Sun, 28 May 2023 06:21:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.180-180-gd9e4f23ab2d5
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 170 runs,
 7 regressions (v5.10.180-180-gd9e4f23ab2d5)
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

stable-rc/queue/5.10 baseline: 170 runs, 7 regressions (v5.10.180-180-gd9e4=
f23ab2d5)

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
nel/v5.10.180-180-gd9e4f23ab2d5/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.180-180-gd9e4f23ab2d5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      d9e4f23ab2d5bc27bf6a6b08fc9b8ffdec732a69 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64731ea1af859e1a122e8665

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-180-gd9e4f23ab2d5/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-180-gd9e4f23ab2d5/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64731ea1af859e1a122e869b
        failing since 103 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-05-28T09:27:45.144046  <8>[   19.076050] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 524511_1.5.2.4.1>
    2023-05-28T09:27:45.251132  / # #
    2023-05-28T09:27:45.352814  export SHELL=3D/bin/sh
    2023-05-28T09:27:45.353305  #
    2023-05-28T09:27:45.454591  / # export SHELL=3D/bin/sh. /lava-524511/en=
vironment
    2023-05-28T09:27:45.455061  =

    2023-05-28T09:27:45.556397  / # . /lava-524511/environment/lava-524511/=
bin/lava-test-runner /lava-524511/1
    2023-05-28T09:27:45.557133  =

    2023-05-28T09:27:45.562009  / # /lava-524511/bin/lava-test-runner /lava=
-524511/1
    2023-05-28T09:27:45.658845  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64731f5fbe982910272e85ee

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-180-gd9e4f23ab2d5/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-180-gd9e4f23ab2d5/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64731f5fbe982910272e85f3
        failing since 121 days (last pass: v5.10.165-76-g5c2e982fcf18, firs=
t fail: v5.10.165-77-g4600242c13ed)

    2023-05-28T09:30:59.653228  <8>[   11.035499] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3625675_1.5.2.4.1>
    2023-05-28T09:30:59.763364  / # #
    2023-05-28T09:30:59.867010  export SHELL=3D/bin/sh
    2023-05-28T09:30:59.868143  #
    2023-05-28T09:30:59.970629  / # export SHELL=3D/bin/sh. /lava-3625675/e=
nvironment
    2023-05-28T09:30:59.971718  =

    2023-05-28T09:31:00.074131  / # . /lava-3625675/environment/lava-362567=
5/bin/lava-test-runner /lava-3625675/1
    2023-05-28T09:31:00.075841  =

    2023-05-28T09:31:00.080671  / # /lava-3625675/bin/lava-test-runner /lav=
a-3625675/1
    2023-05-28T09:31:00.166620  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64731cb4691cad8f4d2e869a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-180-gd9e4f23ab2d5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-180-gd9e4f23ab2d5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64731cb4691cad8f4d2e869f
        failing since 58 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-28T09:19:29.988836  + set +x

    2023-05-28T09:19:29.995230  <8>[   15.367736] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10491649_1.4.2.3.1>

    2023-05-28T09:19:30.099527  / # #

    2023-05-28T09:19:30.200108  export SHELL=3D/bin/sh

    2023-05-28T09:19:30.200307  #

    2023-05-28T09:19:30.300858  / # export SHELL=3D/bin/sh. /lava-10491649/=
environment

    2023-05-28T09:19:30.301051  =


    2023-05-28T09:19:30.401612  / # . /lava-10491649/environment/lava-10491=
649/bin/lava-test-runner /lava-10491649/1

    2023-05-28T09:19:30.401955  =


    2023-05-28T09:19:30.407090  / # /lava-10491649/bin/lava-test-runner /la=
va-10491649/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64731c9d71e39cf3992e86a4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-180-gd9e4f23ab2d5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-180-gd9e4f23ab2d5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64731c9d71e39cf3992e86a9
        failing since 58 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-28T09:19:09.367863  + set +x<8>[   13.326471] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10491638_1.4.2.3.1>

    2023-05-28T09:19:09.367992  =


    2023-05-28T09:19:09.470582  #

    2023-05-28T09:19:09.571544  / # #export SHELL=3D/bin/sh

    2023-05-28T09:19:09.571837  =


    2023-05-28T09:19:09.672479  / # export SHELL=3D/bin/sh. /lava-10491638/=
environment

    2023-05-28T09:19:09.672773  =


    2023-05-28T09:19:09.773389  / # . /lava-10491638/environment/lava-10491=
638/bin/lava-test-runner /lava-10491638/1

    2023-05-28T09:19:09.773836  =


    2023-05-28T09:19:09.779011  / # /lava-10491638/bin/lava-test-runner /la=
va-10491638/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64731fe62eac3e35ee2e8602

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-180-gd9e4f23ab2d5/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-180-gd9e4f23ab2d5/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64731fe62eac3e35ee2e8608
        failing since 75 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-28T09:33:20.304701  <8>[   34.005775] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-05-28T09:33:21.328165  /lava-10491748/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64731fe62eac3e35ee2e8609
        failing since 75 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-28T09:33:20.293053  /lava-10491748/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64731f4d6ef44374322e8677

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-180-gd9e4f23ab2d5/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-180-gd9e4f23ab2d5/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64731f4d6ef44374322e867c
        failing since 115 days (last pass: v5.10.165-139-gefb57ce0f880, fir=
st fail: v5.10.165-149-ge30e8271d674)

    2023-05-28T09:30:28.469593  <8>[    8.456349] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3625671_1.5.2.4.1>
    2023-05-28T09:30:28.587627  / # #
    2023-05-28T09:30:28.689316  export SHELL=3D/bin/sh
    2023-05-28T09:30:28.689665  #
    2023-05-28T09:30:28.790970  / # export SHELL=3D/bin/sh. /lava-3625671/e=
nvironment
    2023-05-28T09:30:28.791319  =

    2023-05-28T09:30:28.892652  / # . /lava-3625671/environment/lava-362567=
1/bin/lava-test-runner /lava-3625671/1
    2023-05-28T09:30:28.893251  =

    2023-05-28T09:30:28.900243  / # /lava-3625671/bin/lava-test-runner /lav=
a-3625671/1
    2023-05-28T09:30:28.964292  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
