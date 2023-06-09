Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D92372A296
	for <lists+stable@lfdr.de>; Fri,  9 Jun 2023 20:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjFISv4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 9 Jun 2023 14:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjFISvz (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Jun 2023 14:51:55 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A4535B3
        for <stable@vger.kernel.org>; Fri,  9 Jun 2023 11:51:54 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-650c8cb68aeso1842972b3a.3
        for <stable@vger.kernel.org>; Fri, 09 Jun 2023 11:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686336713; x=1688928713;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pvUZPmo79YmFi7auHa3c4j0wwWm+x+QIWOGjpetJFWM=;
        b=m+tL+BClOWUBVmidFpTuskh/Aeo+ujtQnfnRIha2qqXR9mT2yxMELesE3H+BfIoThk
         088rQYemje5PnzNAjvcopOa4bLzPbuhq7+90JVWgMw3yuPo9qR2aWZBKXzKBqHSoPtoT
         ScNXdlgArMqvMcLLE4XbN3L5nrohjZvUbAZRR/dPjfYNl/HQQ3sh1O6yKEpwPR422arV
         xIsxFq3xwYCEYfDPpvHyNWJaT4yjAZjrbZG2XSKUI+MiSG4AC4u75I/GeXYx8U+GZ3zT
         78Vujatv1Z4GNjOzrEIhqEEk9jZ1psbFTl10+3LckUI6u6Hnxdc2EYh+QhwknK5HeSa7
         vz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686336713; x=1688928713;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pvUZPmo79YmFi7auHa3c4j0wwWm+x+QIWOGjpetJFWM=;
        b=d6PpOa7o16JeeKln0eH1k0z8cUcbj2+eDlF9IaAmgI6hdGL7c6QMSoGZalJ/NuaseO
         5XTCEMVJy2jKmy42jwBmDuV7d8mBZSHr24VWDAaphCukrVs6VtsQUoWyFccYEa+dLZi4
         exBcFHTWJROu29N7U91KZ2kiUeVAdaxo8/naTISHgnKXRCfHaRU1N7CXHFxQDi+yni4Y
         YN++1JbBTlKXbQcMz+3dikBnfkok14+ORz3aLmQnrCXe4aqKAn39psRM2FpcQsr6Zdoq
         1ot32xcypnSC81MoucU/Wk7sS4vewIM7OkMB1J3LEdrY7eI1F4wV42X9NgXDkPL3r8ys
         /Apw==
X-Gm-Message-State: AC+VfDzwnkf4NlF7RkQkIuqO33QGIbp+A6hJhi4f50ZLcZctlO0NrZjJ
        h8KHharb2mJgCHHbne5bcYIHPw7cRGIzrxD3wZxuaA==
X-Google-Smtp-Source: ACHHUZ74/8GCrI1kpcFCTVarmXl1cFByhYVTh5nEU+HtN2hDTGc1eepgq1Ke5AnV2zcVBrpDkOEpJw==
X-Received: by 2002:a05:6a21:339c:b0:10f:a954:47d1 with SMTP id yy28-20020a056a21339c00b0010fa95447d1mr1867827pzb.38.1686336713376;
        Fri, 09 Jun 2023 11:51:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 17-20020a630011000000b00542d7720a6fsm3259613pga.88.2023.06.09.11.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 11:51:52 -0700 (PDT)
Message-ID: <648374c8.630a0220.b8ec.77c2@mx.google.com>
Date:   Fri, 09 Jun 2023 11:51:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.183
Subject: stable-rc/linux-5.10.y baseline: 117 runs, 4 regressions (v5.10.183)
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

stable-rc/linux-5.10.y baseline: 117 runs, 4 regressions (v5.10.183)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.183/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.183
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      7356714b95aa6b186430289090a7fe5bdff2cf18 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648340c99a2c44c80730613f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648340c99a2c44c807306144
        failing since 142 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-06-09T15:09:30.134424  + set +x<8>[   11.107848] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3653466_1.5.2.4.1>
    2023-06-09T15:09:30.135250  =

    2023-06-09T15:09:30.244921  / # #
    2023-06-09T15:09:30.348843  export SHELL=3D/bin/sh
    2023-06-09T15:09:30.349986  #
    2023-06-09T15:09:30.350607  / # export SHELL=3D/bin/sh<3>[   11.292014]=
 Bluetooth: hci0: command 0xfc18 tx timeout
    2023-06-09T15:09:30.452823  . /lava-3653466/environment
    2023-06-09T15:09:30.453976  =

    2023-06-09T15:09:30.556174  / # . /lava-3653466/environment/lava-365346=
6/bin/lava-test-runner /lava-3653466/1
    2023-06-09T15:09:30.557844   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64833c4b3b4840460830613a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64833c4b3b4840460830613f
        failing since 72 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-06-09T14:50:51.987972  + set +x

    2023-06-09T14:50:51.994387  <8>[   14.863024] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10660461_1.4.2.3.1>

    2023-06-09T14:50:52.098801  / # #

    2023-06-09T14:50:52.199490  export SHELL=3D/bin/sh

    2023-06-09T14:50:52.199752  #

    2023-06-09T14:50:52.300377  / # export SHELL=3D/bin/sh. /lava-10660461/=
environment

    2023-06-09T14:50:52.300593  =


    2023-06-09T14:50:52.401198  / # . /lava-10660461/environment/lava-10660=
461/bin/lava-test-runner /lava-10660461/1

    2023-06-09T14:50:52.401525  =


    2023-06-09T14:50:52.406507  / # /lava-10660461/bin/lava-test-runner /la=
va-10660461/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64833c10ea735cf5a230616c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64833c10ea735cf5a2306171
        failing since 72 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-06-09T14:49:30.655004  <8>[   12.735944] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10660410_1.4.2.3.1>

    2023-06-09T14:49:30.657925  + set +x

    2023-06-09T14:49:30.759158  #

    2023-06-09T14:49:30.759575  =


    2023-06-09T14:49:30.860116  / # #export SHELL=3D/bin/sh

    2023-06-09T14:49:30.860343  =


    2023-06-09T14:49:30.960908  / # export SHELL=3D/bin/sh. /lava-10660410/=
environment

    2023-06-09T14:49:30.961150  =


    2023-06-09T14:49:31.061796  / # . /lava-10660410/environment/lava-10660=
410/bin/lava-test-runner /lava-10660410/1

    2023-06-09T14:49:31.062145  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6483407c7e0d1f0c1a30615a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-stm32mp157c-dk2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-stm32mp157c-dk2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6483407c7e0d1f0c1a30615f
        failing since 126 days (last pass: v5.10.147, first fail: v5.10.166=
-10-g6278b8c9832e)

    2023-06-09T15:08:23.972389  <8>[   11.603891] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3653462_1.5.2.4.1>
    2023-06-09T15:08:24.078393  / # #
    2023-06-09T15:08:24.180574  export SHELL=3D/bin/sh
    2023-06-09T15:08:24.181311  #
    2023-06-09T15:08:24.282745  / # export SHELL=3D/bin/sh. /lava-3653462/e=
nvironment
    2023-06-09T15:08:24.283449  =

    2023-06-09T15:08:24.385494  / # . /lava-3653462/environment/lava-365346=
2/bin/lava-test-runner /lava-3653462/1
    2023-06-09T15:08:24.386202  =

    2023-06-09T15:08:24.390508  / # /lava-3653462/bin/lava-test-runner /lav=
a-3653462/1
    2023-06-09T15:08:24.456416  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
