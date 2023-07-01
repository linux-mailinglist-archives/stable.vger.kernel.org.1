Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CAB744AF3
	for <lists+stable@lfdr.de>; Sat,  1 Jul 2023 21:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjGATdK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 1 Jul 2023 15:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGATdK (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 1 Jul 2023 15:33:10 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0BD171D
        for <stable@vger.kernel.org>; Sat,  1 Jul 2023 12:33:07 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b7fb1a82c4so16801655ad.1
        for <stable@vger.kernel.org>; Sat, 01 Jul 2023 12:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688239986; x=1690831986;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I/8l738EUUAXJ5e2/uIEr+7hFWyXptq5eh4TPUYpR9o=;
        b=b0cc7Ne37yMCyvMx+YHuKLlwzmvO+SwiRNb9oe0DdZMTJENUH3OS0N9OvpFKE5fk8l
         OOMOs05h0yxirpTzAJZ9RHXBOjDMbDJnHZfz5K2qherQyLFcjaIgIACT6C/AWxoH6mwW
         jEHfidh8c1PB8ygrjWMnmNLCrI6ZMyWoqTir0iaMMtbw0U4FiyAukwW48sPDxP/EQI29
         D93Hq6MeYmJxSdJgQYxXpLJXirSIgRHkWapi7nAQahcGodJDwTQwytEk8VwrSiGurAMv
         vHQH0CYbL9o9s7ct7SrzXaM3T1Pee81ckXlITtCiwdmDjcVa3x4wFG85cfuVbfARDb7m
         D4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688239986; x=1690831986;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/8l738EUUAXJ5e2/uIEr+7hFWyXptq5eh4TPUYpR9o=;
        b=PR6+6vDpXssAPAUMeksUp0L7RXK+M15q/zbWMKffDwhCUk1/I/scolOACo+id/ZBxk
         cWDFB0uxTKYKz46H+BOTjpp43k9QFToOj64IfDT92xXPO7HYgy6GH/GOjheH76VsTPB5
         OnubR9Qs2ajkmHMf8dyNi1mOJFlzjbeOIsAEImlzsbMOvmuXboBzKbn4WW3BbbMwSkm7
         k2o6iBBATfVRcxozhbo6pWqNO0kv+ZhEy08lE84nPMBZbEKuJ/UhuGGBO7hUx4FVQ2Xc
         1rlaLnkRqPjT2BVclBBCghn//tU3qlWUgI+Z+W+47rF5+zL7gUHk2r6VA7h0XWhy7FGZ
         PPBQ==
X-Gm-Message-State: ABy/qLYcpAbPVXMHftQwSFKmZdEFFEgK6O5DCbUw00Mye3skhXqQBYpP
        WZ82/g7xlV097rSdrlw9JeZRJHeU9ta6Pw8onxpO5Q==
X-Google-Smtp-Source: APBJJlHniAY4WOkeDrePUeHWwIEe5AuT1gqQPZ+GVxBCHG1VgCiRnfpjwPHw4Yhh/31mjHnVT1LHgA==
X-Received: by 2002:a17:902:f683:b0:1ae:6cf0:94eb with SMTP id l3-20020a170902f68300b001ae6cf094ebmr4971893plg.5.1688239986094;
        Sat, 01 Jul 2023 12:33:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jm24-20020a17090304d800b001aaecc15d66sm12622385plb.289.2023.07.01.12.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 12:33:05 -0700 (PDT)
Message-ID: <64a07f71.170a0220.27c42.85db@mx.google.com>
Date:   Sat, 01 Jul 2023 12:33:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15.119
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.15.y
Subject: stable-rc/linux-5.15.y baseline: 145 runs, 14 regressions (v5.15.119)
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

stable-rc/linux-5.15.y baseline: 145 runs, 14 regressions (v5.15.119)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

rk3328-rock64                | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.119/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.119
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      4af60700a60cc45ee4fb6d579cccf1b7bca20c34 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c2da985926fa8aaedacc3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c2da985926fa8aaedaccc
        failing since 91 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-07-01T15:31:07.283269  <8>[   10.593000] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10975889_1.4.2.3.1>

    2023-07-01T15:31:07.286384  + set +x

    2023-07-01T15:31:07.394194  / # #

    2023-07-01T15:31:07.496423  export SHELL=3D/bin/sh

    2023-07-01T15:31:07.497171  #

    2023-07-01T15:31:07.598665  / # export SHELL=3D/bin/sh. /lava-10975889/=
environment

    2023-07-01T15:31:07.599427  =


    2023-07-01T15:31:07.701040  / # . /lava-10975889/environment/lava-10975=
889/bin/lava-test-runner /lava-10975889/1

    2023-07-01T15:31:07.702216  =


    2023-07-01T15:31:07.708645  / # /lava-10975889/bin/lava-test-runner /la=
va-10975889/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c2d9d5ff8d4fa13edacea

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c2d9d5ff8d4fa13edacf3
        failing since 91 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-07-01T15:30:03.284240  + set +x<8>[   11.115056] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10975823_1.4.2.3.1>

    2023-07-01T15:30:03.284318  =


    2023-07-01T15:30:03.388949  / # #

    2023-07-01T15:30:03.489533  export SHELL=3D/bin/sh

    2023-07-01T15:30:03.489717  #

    2023-07-01T15:30:03.590192  / # export SHELL=3D/bin/sh. /lava-10975823/=
environment

    2023-07-01T15:30:03.590382  =


    2023-07-01T15:30:03.690879  / # . /lava-10975823/environment/lava-10975=
823/bin/lava-test-runner /lava-10975823/1

    2023-07-01T15:30:03.691162  =


    2023-07-01T15:30:03.696069  / # /lava-10975823/bin/lava-test-runner /la=
va-10975823/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c2d991b255eb9e7edad1b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c2d991b255eb9e7edad24
        failing since 91 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-28T12:54:31.867507  <8>[   10.643445] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10937501_1.4.2.3.1>

    2023-06-28T12:54:31.871191  + set +x

    2023-06-28T12:54:31.976780  #

    2023-06-28T12:54:31.978137  =


    2023-06-28T12:54:32.080096  / # #export SHELL=3D/bin/sh

    2023-06-28T12:54:32.080928  =


    2023-06-28T12:54:32.182667  / # export SHELL=3D/bin/sh. /lava-10937501/=
environment

    2023-06-28T12:54:32.183458  =


    2023-06-28T12:54:32.285235  / # . /lava-10937501/environment/lava-10937=
501/bin/lava-test-runner /lava-10937501/1

    2023-06-28T12:54:32.286627  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64a046fed6f51f68e5bb2a97

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a046fed6f51f68e5bb2=
a98
        failing since 415 days (last pass: v5.15.37-259-gab77581473a3, firs=
t fail: v5.15.39) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64a0474f1dca61686cbb2a95

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a0474f1dca61686cbb2a9a
        failing since 165 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-07-01T15:33:26.316784  <8>[    9.930479] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3705230_1.5.2.4.1>
    2023-07-01T15:33:26.423287  / # #
    2023-07-01T15:33:26.524493  export SHELL=3D/bin/sh
    2023-07-01T15:33:26.524844  #
    2023-07-01T15:33:26.524997  / # export SHELL=3D/bin/sh<3>[   10.113039]=
 Bluetooth: hci0: command 0xfc18 tx timeout
    2023-07-01T15:33:26.626127  . /lava-3705230/environment
    2023-07-01T15:33:26.626725  =

    2023-07-01T15:33:26.728348  / # . /lava-3705230/environment/lava-370523=
0/bin/lava-test-runner /lava-3705230/1
    2023-07-01T15:33:26.729410  =

    2023-07-01T15:33:26.734216  / # /lava-3705230/bin/lava-test-runner /lav=
a-3705230/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c2d8d1b85e3ff01edacec

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c2d8d1b85e3ff01edacf5
        failing since 91 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-07-01T15:30:20.366699  + set +x

    2023-07-01T15:30:20.372817  <8>[   10.149953] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10975839_1.4.2.3.1>

    2023-07-01T15:30:20.477300  / # #

    2023-07-01T15:30:20.579358  export SHELL=3D/bin/sh

    2023-07-01T15:30:20.580010  #

    2023-07-01T15:30:20.681245  / # export SHELL=3D/bin/sh. /lava-10975839/=
environment

    2023-07-01T15:30:20.681428  =


    2023-07-01T15:30:20.781902  / # . /lava-10975839/environment/lava-10975=
839/bin/lava-test-runner /lava-10975839/1

    2023-07-01T15:30:20.782195  =


    2023-07-01T15:30:20.786801  / # /lava-10975839/bin/lava-test-runner /la=
va-10975839/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c2d8503d3409951edacce

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c2d8503d3409951edacd7
        failing since 91 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-07-01T15:30:15.458635  + set +x

    2023-07-01T15:30:15.465107  <8>[   10.525129] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10975835_1.4.2.3.1>

    2023-07-01T15:30:15.573092  / # #

    2023-07-01T15:30:15.675311  export SHELL=3D/bin/sh

    2023-07-01T15:30:15.675992  #

    2023-07-01T15:30:15.777379  / # export SHELL=3D/bin/sh. /lava-10975835/=
environment

    2023-07-01T15:30:15.778152  =


    2023-07-01T15:30:15.879610  / # . /lava-10975835/environment/lava-10975=
835/bin/lava-test-runner /lava-10975835/1

    2023-07-01T15:30:15.880868  =


    2023-07-01T15:30:15.886146  / # /lava-10975835/bin/lava-test-runner /la=
va-10975835/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c2da3eabcdc9c82edace0

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c2da3eabcdc9c82edace9
        failing since 91 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-07-01T15:30:18.571073  + <8>[   11.226208] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10975840_1.4.2.3.1>

    2023-07-01T15:30:18.571490  set +x

    2023-07-01T15:30:18.679385  / # #

    2023-07-01T15:30:18.781642  export SHELL=3D/bin/sh

    2023-07-01T15:30:18.782391  #

    2023-07-01T15:30:18.883767  / # export SHELL=3D/bin/sh. /lava-10975840/=
environment

    2023-07-01T15:30:18.884607  =


    2023-07-01T15:30:18.985912  / # . /lava-10975840/environment/lava-10975=
840/bin/lava-test-runner /lava-10975840/1

    2023-07-01T15:30:18.986239  =


    2023-07-01T15:30:18.991027  / # /lava-10975840/bin/lava-test-runner /la=
va-10975840/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/649c2e0d1504f15401edad5a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c2e0d1504f15401edad63
        failing since 148 days (last pass: v5.15.81-122-gc5f8d4a5d3c8, firs=
t fail: v5.15.90-205-g5605d15db022)

    2023-07-01T15:32:39.867040  + set +x
    2023-07-01T15:32:39.867211  [    9.480697] <LAVA_SIGNAL_ENDRUN 0_dmesg =
991833_1.5.2.3.1>
    2023-07-01T15:32:39.974017  / # #
    2023-07-01T15:32:40.075822  export SHELL=3D/bin/sh
    2023-07-01T15:32:40.076532  #
    2023-07-01T15:32:40.177892  / # export SHELL=3D/bin/sh. /lava-991833/en=
vironment
    2023-07-01T15:32:40.178479  =

    2023-07-01T15:32:40.279920  / # . /lava-991833/environment/lava-991833/=
bin/lava-test-runner /lava-991833/1
    2023-07-01T15:32:40.280497  =

    2023-07-01T15:32:40.283233  / # /lava-991833/bin/lava-test-runner /lava=
-991833/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c2da0f2d2315861edace6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-len=
ovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-len=
ovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c2da0f2d2315861edacef
        failing since 91 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-07-01T15:29:55.635381  <8>[   11.220266] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10975887_1.4.2.3.1>

    2023-07-01T15:29:55.743153  / # #

    2023-07-01T15:29:55.845352  export SHELL=3D/bin/sh

    2023-07-01T15:29:55.845985  #

    2023-07-01T15:29:55.947281  / # export SHELL=3D/bin/sh. /lava-10975887/=
environment

    2023-07-01T15:29:55.947995  =


    2023-07-01T15:29:56.049446  / # . /lava-10975887/environment/lava-10975=
887/bin/lava-test-runner /lava-10975887/1

    2023-07-01T15:29:56.050575  =


    2023-07-01T15:29:56.055671  / # /lava-10975887/bin/lava-test-runner /la=
va-10975887/1

    2023-07-01T15:29:56.061067  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3328-rock64                | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649c314ae44c65d713edacfa

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c314ae44c65d713edad03
        failing since 20 days (last pass: v5.15.72-38-gebe70cd7f5413, first=
 fail: v5.15.114-196-g00621f2608ac)

    2023-06-28T13:10:22.486137  [   15.993886] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3697865_1.5.2.4.1>
    2023-06-28T13:10:22.589719  =

    2023-06-28T13:10:22.589870  / # #[   16.092980] rockchip-drm display-su=
bsystem: [drm] Cannot find any crtc or sizes
    2023-06-28T13:10:22.691028  export SHELL=3D/bin/sh
    2023-06-28T13:10:22.691548  =

    2023-06-28T13:10:22.792914  / # export SHELL=3D/bin/sh. /lava-3697865/e=
nvironment
    2023-06-28T13:10:22.793296  =

    2023-06-28T13:10:22.894423  / # . /lava-3697865/environment/lava-369786=
5/bin/lava-test-runner /lava-3697865/1
    2023-06-28T13:10:22.894918  =

    2023-06-28T13:10:22.898282  / # /lava-3697865/bin/lava-test-runner /lav=
a-3697865/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649c32949e2d3b3e9eedacd2

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c32949e2d3b3e9eedad01
        failing since 162 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-06-28T13:15:44.002416  + set +x
    2023-06-28T13:15:44.006548  <8>[   16.206226] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3697847_1.5.2.4.1>
    2023-06-28T13:15:44.126657  / # #
    2023-06-28T13:15:44.232257  export SHELL=3D/bin/sh
    2023-06-28T13:15:44.233772  #
    2023-06-28T13:15:44.337122  / # export SHELL=3D/bin/sh. /lava-3697847/e=
nvironment
    2023-06-28T13:15:44.338626  =

    2023-06-28T13:15:44.442072  / # . /lava-3697847/environment/lava-369784=
7/bin/lava-test-runner /lava-3697847/1
    2023-06-28T13:15:44.444756  =

    2023-06-28T13:15:44.448074  / # /lava-3697847/bin/lava-test-runner /lav=
a-3697847/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649c3158541e280a0eedacd1

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c3159541e280a0eedacfe
        failing since 162 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-06-28T13:10:20.164823  + set +x
    2023-06-28T13:10:20.168810  <8>[   16.212468] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 672780_1.5.2.4.1>
    2023-06-28T13:10:20.279864  / # #
    2023-06-28T13:10:20.382823  export SHELL=3D/bin/sh
    2023-06-28T13:10:20.383626  #
    2023-06-28T13:10:20.486028  / # export SHELL=3D/bin/sh. /lava-672780/en=
vironment
    2023-06-28T13:10:20.486743  =

    2023-06-28T13:10:20.589217  / # . /lava-672780/environment/lava-672780/=
bin/lava-test-runner /lava-672780/1
    2023-06-28T13:10:20.590356  =

    2023-06-28T13:10:20.594820  / # /lava-672780/bin/lava-test-runner /lava=
-672780/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/64a04844747d190062bb2a8f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-orangepi-=
r1.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-orangepi-=
r1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a04844747d190062bb2a94
        failing since 79 days (last pass: v5.15.82-124-g2b8b2c150867, first=
 fail: v5.15.105-194-g415a9d81c640)

    2023-07-01T15:37:17.555399  / # #
    2023-07-01T15:37:17.662207  export SHELL=3D/bin/sh
    2023-07-01T15:37:17.663776  #
    2023-07-01T15:37:17.767016  / # export SHELL=3D/bin/sh. /lava-3705239/e=
nvironment
    2023-07-01T15:37:17.768606  =

    2023-07-01T15:37:17.871953  / # . /lava-3705239/environment/lava-370523=
9/bin/lava-test-runner /lava-3705239/1
    2023-07-01T15:37:17.874550  =

    2023-07-01T15:37:17.885480  / # /lava-3705239/bin/lava-test-runner /lav=
a-3705239/1
    2023-07-01T15:37:18.006290  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-01T15:37:18.007342  + cd /lava-3705239/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
