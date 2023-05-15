Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C2070265C
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 09:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbjEOHuQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 03:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjEOHuP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 03:50:15 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00991128
        for <stable@vger.kernel.org>; Mon, 15 May 2023 00:50:12 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-24df6bbf765so10590007a91.0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 00:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684137012; x=1686729012;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+iCkbsNHUtrpBzxoJ/E7er69Ay+wzGnofCSxuEspc20=;
        b=0i2es83tpnUHAebs/Y18ASmqb0YlENDCEJL7BtWVtmgW8cFBzufbNIUtSiRS0QDPDw
         PI9vnpzam2IzXB6eYRUPl87i8ofDhWF5MoEIUXR4dROAu3uwMWavjHNAxmzNNuVgzOLA
         acWLCogbnl63CxOZGnkCLVjrKO/1YclJPs0HH+VH8vZ67NfDbQyX8J1h7J6hIBCJYZmJ
         xgKc95h0yRNXCs31pUzOLpR+Uvu/wDztSTEHzXHo20hAe8BJ93kjlMw+9ZWM0aojI5AD
         gpGsl3RXX9BvmqOhKWrYsEFb3H65KnP1pk7XocxBcZ/2Kigjzug2mjz29uyfZ27lV/fM
         vhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684137012; x=1686729012;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+iCkbsNHUtrpBzxoJ/E7er69Ay+wzGnofCSxuEspc20=;
        b=gHG5I9mzrTUxKpna6oZCgGRyGthvSLKKz3ADwADznFi1CAPPlU7CBIA+zCsgqwVrLw
         R9PD5NA2poJeR3g5d6dRaRBlN8Fza7xXhU+ht2vvK7QFLkcDLFOCF9g6byDwDOOTfZ5W
         LfLRrp6FBYaJ2RkaGAjhqOrcCnHHgVlwdFldTPOzY6dqxnpTz4jqQnIeSXWayGXotWl+
         CkRLDV2e7tPMZ9hTTd1B/XRgWOPStzetBieWlVz+Czs9ahbbgXZ+JZz2jfJtymXhklMO
         8G58/vqEHJLS1tC/QnvfnupsPHJCO2OPzu+rXfIN2zwjBa1JJ1oVzncYOskBI3zRG2oJ
         xm6Q==
X-Gm-Message-State: AC+VfDzN70+VnJLKHou/2Jf4ABYok5AeUQHAPJHaz7IoIoDr9OToz8RI
        fGoK6GZqwPtgar8+KR9xUkElTMe3Fyo7hZ/L9Bg=
X-Google-Smtp-Source: ACHHUZ54PDDHDQyuIRG8lrrxiif+gD6RMGjDkEWkG9xsf4g4EnG9S+1vy0U2z4+S0QNgc01dpG3DsA==
X-Received: by 2002:a17:90a:e657:b0:24e:1ef0:8c40 with SMTP id ep23-20020a17090ae65700b0024e1ef08c40mr31714902pjb.35.1684137011893;
        Mon, 15 May 2023 00:50:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ih15-20020a17090b430f00b0024e3bce323asm21808269pjb.26.2023.05.15.00.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 00:50:11 -0700 (PDT)
Message-ID: <6461e433.170a0220.93366.9d01@mx.google.com>
Date:   Mon, 15 May 2023 00:50:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.111-118-g8409a4aad95b2
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 179 runs,
 10 regressions (v5.15.111-118-g8409a4aad95b2)
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

stable-rc/queue/5.15 baseline: 179 runs, 10 regressions (v5.15.111-118-g840=
9a4aad95b2)

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

imx8mn-ddr4-evk              | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.111-118-g8409a4aad95b2/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.111-118-g8409a4aad95b2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      8409a4aad95b2df92bf0f0d7d2af3747445d8f4f =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461adaf2b3266ae4b2e861f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-118-g8409a4aad95b2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-118-g8409a4aad95b2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461adaf2b3266ae4b2e8624
        failing since 47 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-15T03:57:22.242784  + set<8>[   11.711190] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10316353_1.4.2.3.1>

    2023-05-15T03:57:22.243366   +x

    2023-05-15T03:57:22.351391  / # #

    2023-05-15T03:57:22.454185  export SHELL=3D/bin/sh

    2023-05-15T03:57:22.454981  #

    2023-05-15T03:57:22.556840  / # export SHELL=3D/bin/sh. /lava-10316353/=
environment

    2023-05-15T03:57:22.557678  =


    2023-05-15T03:57:22.659509  / # . /lava-10316353/environment/lava-10316=
353/bin/lava-test-runner /lava-10316353/1

    2023-05-15T03:57:22.660765  =


    2023-05-15T03:57:22.665461  / # /lava-10316353/bin/lava-test-runner /la=
va-10316353/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461adb0ed3986fc5f2e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-118-g8409a4aad95b2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-118-g8409a4aad95b2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461adb0ed3986fc5f2e85eb
        failing since 47 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-15T03:57:10.944751  <8>[   10.117310] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10316348_1.4.2.3.1>

    2023-05-15T03:57:10.948360  + set +x

    2023-05-15T03:57:11.049758  =


    2023-05-15T03:57:11.150343  / # #export SHELL=3D/bin/sh

    2023-05-15T03:57:11.150575  =


    2023-05-15T03:57:11.251150  / # export SHELL=3D/bin/sh. /lava-10316348/=
environment

    2023-05-15T03:57:11.251362  =


    2023-05-15T03:57:11.351893  / # . /lava-10316348/environment/lava-10316=
348/bin/lava-test-runner /lava-10316348/1

    2023-05-15T03:57:11.352264  =


    2023-05-15T03:57:11.356877  / # /lava-10316348/bin/lava-test-runner /la=
va-10316348/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6461af59d98439359d2e87d8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-118-g8409a4aad95b2/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-118-g8409a4aad95b2/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6461af59d98439359d2e8=
7d9
        failing since 100 days (last pass: v5.15.91-12-g3290f78df1ab, first=
 fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6461b14b11c0a9d8122e862d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-118-g8409a4aad95b2/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-118-g8409a4aad95b2/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461b14b11c0a9d8122e8632
        failing since 117 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-15T04:12:42.937630  <8>[    9.972686] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3589666_1.5.2.4.1>
    2023-05-15T04:12:43.044569  / # #
    2023-05-15T04:12:43.146240  export SHELL=3D/bin/sh
    2023-05-15T04:12:43.146809  #
    2023-05-15T04:12:43.248158  / # export SHELL=3D/bin/sh. /lava-3589666/e=
nvironment
    2023-05-15T04:12:43.248515  =

    2023-05-15T04:12:43.349466  / # . /lava-3589666/environment/lava-358966=
6/bin/lava-test-runner /lava-3589666/1
    2023-05-15T04:12:43.350017  =

    2023-05-15T04:12:43.354839  / # /lava-3589666/bin/lava-test-runner /lav=
a-3589666/1
    2023-05-15T04:12:43.443097  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461ada4cea8a3a0972e860d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-118-g8409a4aad95b2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-118-g8409a4aad95b2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461ada4cea8a3a0972e8612
        failing since 47 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-15T03:57:13.469762  + set +x

    2023-05-15T03:57:13.475971  <8>[   10.263789] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10316336_1.4.2.3.1>

    2023-05-15T03:57:13.580631  / # #

    2023-05-15T03:57:13.681240  export SHELL=3D/bin/sh

    2023-05-15T03:57:13.681476  #

    2023-05-15T03:57:13.782127  / # export SHELL=3D/bin/sh. /lava-10316336/=
environment

    2023-05-15T03:57:13.782340  =


    2023-05-15T03:57:13.882871  / # . /lava-10316336/environment/lava-10316=
336/bin/lava-test-runner /lava-10316336/1

    2023-05-15T03:57:13.883142  =


    2023-05-15T03:57:13.887865  / # /lava-10316336/bin/lava-test-runner /la=
va-10316336/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461ad9fb2293f69cf2e865a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-118-g8409a4aad95b2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-118-g8409a4aad95b2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461ad9fb2293f69cf2e865f
        failing since 47 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-15T03:57:05.329136  + set +x

    2023-05-15T03:57:05.335436  <8>[   14.056847] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10316354_1.4.2.3.1>

    2023-05-15T03:57:05.437074  #

    2023-05-15T03:57:05.437417  =


    2023-05-15T03:57:05.538089  / # #export SHELL=3D/bin/sh

    2023-05-15T03:57:05.538298  =


    2023-05-15T03:57:05.638815  / # export SHELL=3D/bin/sh. /lava-10316354/=
environment

    2023-05-15T03:57:05.639024  =


    2023-05-15T03:57:05.739559  / # . /lava-10316354/environment/lava-10316=
354/bin/lava-test-runner /lava-10316354/1

    2023-05-15T03:57:05.739846  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461adbd4a7329bd0b2e85e8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-118-g8409a4aad95b2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-118-g8409a4aad95b2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461adbd4a7329bd0b2e85ed
        failing since 47 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-15T03:57:21.537172  + <8>[   10.871758] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10316405_1.4.2.3.1>

    2023-05-15T03:57:21.537660  set +x

    2023-05-15T03:57:21.645306  / # #

    2023-05-15T03:57:21.747594  export SHELL=3D/bin/sh

    2023-05-15T03:57:21.748359  #

    2023-05-15T03:57:21.849866  / # export SHELL=3D/bin/sh. /lava-10316405/=
environment

    2023-05-15T03:57:21.850639  =


    2023-05-15T03:57:21.952122  / # . /lava-10316405/environment/lava-10316=
405/bin/lava-test-runner /lava-10316405/1

    2023-05-15T03:57:21.953273  =


    2023-05-15T03:57:21.957855  / # /lava-10316405/bin/lava-test-runner /la=
va-10316405/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx8mn-ddr4-evk              | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6461b57c8c0bfd29bc2e85ec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-118-g8409a4aad95b2/arm64/defconfig/gcc-10/lab-baylibre/baseline-imx8mn-ddr=
4-evk.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-118-g8409a4aad95b2/arm64/defconfig/gcc-10/lab-baylibre/baseline-imx8mn-ddr=
4-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6461b57c8c0bfd29bc2e8=
5ed
        new failure (last pass: v5.15.111-100-g30112e7e73f2f) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461ad9ab2293f69cf2e8627

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-118-g8409a4aad95b2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-118-g8409a4aad95b2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461ad9ab2293f69cf2e862c
        failing since 47 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-15T03:57:00.153621  + set<8>[   11.628914] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10316344_1.4.2.3.1>

    2023-05-15T03:57:00.153714   +x

    2023-05-15T03:57:00.258086  / # #

    2023-05-15T03:57:00.358814  export SHELL=3D/bin/sh

    2023-05-15T03:57:00.359063  #

    2023-05-15T03:57:00.459598  / # export SHELL=3D/bin/sh. /lava-10316344/=
environment

    2023-05-15T03:57:00.459832  =


    2023-05-15T03:57:00.560439  / # . /lava-10316344/environment/lava-10316=
344/bin/lava-test-runner /lava-10316344/1

    2023-05-15T03:57:00.560830  =


    2023-05-15T03:57:00.565372  / # /lava-10316344/bin/lava-test-runner /la=
va-10316344/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/6461ab8f52a340595f2e8601

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-118-g8409a4aad95b2/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-=
h2-plus-orangepi-r1.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-118-g8409a4aad95b2/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-=
h2-plus-orangepi-r1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461ab8f52a340595f2e8606
        failing since 103 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.90-203-gea2e94bef77e)

    2023-05-15T03:48:22.559731  <8>[    5.761060] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3589568_1.5.2.4.1>
    2023-05-15T03:48:22.679302  / # #
    2023-05-15T03:48:22.784808  export SHELL=3D/bin/sh
    2023-05-15T03:48:22.786435  #
    2023-05-15T03:48:22.889986  / # export SHELL=3D/bin/sh. /lava-3589568/e=
nvironment
    2023-05-15T03:48:22.891503  =

    2023-05-15T03:48:22.995116  / # . /lava-3589568/environment/lava-358956=
8/bin/lava-test-runner /lava-3589568/1
    2023-05-15T03:48:22.997868  =

    2023-05-15T03:48:23.004263  / # /lava-3589568/bin/lava-test-runner /lav=
a-3589568/1
    2023-05-15T03:48:23.167895  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
