Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D1977A45A
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 02:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjHMAmn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 20:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjHMAmm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 20:42:42 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363A510DB
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 17:42:44 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bbf8cb694aso28102535ad.3
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 17:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691887363; x=1692492163;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aOhzTFbidrjBByqUIWgLegIK6xy9R+TVhvhgH6su7YI=;
        b=KUO7cdfucly1Ej4AKc6G2+AATwsGPHdZV7+aAMMnwzq3+v58Q3fQNlXoIxx+6V+AWB
         QgphQTTvvGqIE8tL3mMNdEwn/rV3m3nNK2+O4yB2odURDZnKAMwvkPbD2QGT7EUrVbEg
         77QCP6JEQ2V9vaLOxM+LN64TGeLOk6kK0oEqX2HjDLlqBqBR0eUdU77F7xJMi6PUjGIx
         vSi0PI8VW5SfH85UuDkz93Zfr8ks+IJN+GamGy2mokbxKtUXOcTUuMWOkEinRJ4qqYIK
         yS+HBEmtL5FCTKWH8n6v/bRJ5EEEG5P9eaWqdwL0UqeA4w7OgjhGEk/WsTL8+ikmLsLj
         9Q2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691887363; x=1692492163;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aOhzTFbidrjBByqUIWgLegIK6xy9R+TVhvhgH6su7YI=;
        b=QGbUdJobYyAb6b3ctXv5Z+WtInWsL7zt+Sf/gkiMpgPrKeKw69bECWcowXL9BErHk2
         lU0tDwUesGpiDGbRy43JEaynYbdJjrMjH0my+U0B46QtNCYJcM7pNrnOnlMiatsZaFZu
         9/m6OYOQ7Z0i/niBoXtyuHmORKcM+OZ2aUF7gOm6QhL04B4B3K2ZzUX4rj/ykgR1Q6OL
         qfR6CLhmmSSlNqa+l9co8ZT4gdN37tRK3S8yVB5XnoWXsrjGZBuyuLEv8yFGZQRwC0CB
         INehBrAECPV5id5liga3ceIY7Vb5MVVo6LK57N5ibTDtzFsHOGsYf3LO6bMpZXcx4hEa
         8qbw==
X-Gm-Message-State: AOJu0YyxtIuztb4PE6Kg2TnGprf2YmQKnU5VAR6vl7sySjfBWF0JhTe8
        XctqNpQfZZSyI4HLochR1rcKlbdP3oRQB/vfxG4wNA==
X-Google-Smtp-Source: AGHT+IEc/DYvLRMeVpRflkPSPWWIZ6FMujfj2gUAUuDfnh4EQSxry11rCvZ21ERFcVunOTqi9hAJZw==
X-Received: by 2002:a17:903:11d0:b0:1b8:4f93:b210 with SMTP id q16-20020a17090311d000b001b84f93b210mr7081629plh.45.1691887362870;
        Sat, 12 Aug 2023 17:42:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c10c00b001b7cbc5871csm6441657pli.53.2023.08.12.17.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 17:42:42 -0700 (PDT)
Message-ID: <64d82702.170a0220.c74fe.b6eb@mx.google.com>
Date:   Sat, 12 Aug 2023 17:42:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.126-71-ge089901a2a7ef
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.15.y
Subject: stable-rc/linux-5.15.y baseline: 123 runs,
 12 regressions (v5.15.126-71-ge089901a2a7ef)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.15.y baseline: 123 runs, 12 regressions (v5.15.126-71-ge0=
89901a2a7ef)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

beagle-xm                 | arm    | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig          | 1          =

cubietruck                | arm    | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig           | 1          =

fsl-ls2088a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =

fsl-lx2160a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =

hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

r8a77960-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.126-71-ge089901a2a7ef/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.126-71-ge089901a2a7ef
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      e089901a2a7efb6b0a441ce72a1a1d6ed9ee9755 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d7f3ec6a499e525f35b219

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-71-ge089901a2a7ef/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-71-ge089901a2a7ef/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d7f3ec6a499e525f35b21e
        failing since 136 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-12T21:04:20.156358  <8>[   12.367666] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11274181_1.4.2.3.1>

    2023-08-12T21:04:20.159468  + set +x

    2023-08-12T21:04:20.260899  #

    2023-08-12T21:04:20.261192  =


    2023-08-12T21:04:20.361924  / # #export SHELL=3D/bin/sh

    2023-08-12T21:04:20.362622  =


    2023-08-12T21:04:20.463960  / # export SHELL=3D/bin/sh. /lava-11274181/=
environment

    2023-08-12T21:04:20.464649  =


    2023-08-12T21:04:20.566047  / # . /lava-11274181/environment/lava-11274=
181/bin/lava-test-runner /lava-11274181/1

    2023-08-12T21:04:20.567248  =

 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d7f3cac49f18dbe935b1e4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-71-ge089901a2a7ef/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-71-ge089901a2a7ef/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d7f3cac49f18dbe935b1e9
        failing since 136 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-12T21:04:01.187291  <8>[   13.449433] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11274174_1.4.2.3.1>

    2023-08-12T21:04:01.190616  + set +x

    2023-08-12T21:04:01.292422  #

    2023-08-12T21:04:01.292686  =


    2023-08-12T21:04:01.393271  / # #export SHELL=3D/bin/sh

    2023-08-12T21:04:01.393496  =


    2023-08-12T21:04:01.494025  / # export SHELL=3D/bin/sh. /lava-11274174/=
environment

    2023-08-12T21:04:01.494223  =


    2023-08-12T21:04:01.594795  / # . /lava-11274174/environment/lava-11274=
174/bin/lava-test-runner /lava-11274174/1

    2023-08-12T21:04:01.595092  =

 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beagle-xm                 | arm    | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d7f8ab043cde000a35b1f3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-71-ge089901a2a7ef/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-71-ge089901a2a7ef/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d7f8ab043cde000a35b=
1f4
        failing since 18 days (last pass: v5.15.120, first fail: v5.15.122-=
79-g3bef1500d246a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
cubietruck                | arm    | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d7f5f2be0b26533035b1e0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-71-ge089901a2a7ef/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-71-ge089901a2a7ef/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d7f5f2be0b26533035b1e5
        failing since 207 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-08-12T21:13:01.205278  <8>[    9.973460] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3739709_1.5.2.4.1>
    2023-08-12T21:13:01.312232  / # #
    2023-08-12T21:13:01.413397  export SHELL=3D/bin/sh
    2023-08-12T21:13:01.413738  #
    2023-08-12T21:13:01.514874  / # export SHELL=3D/bin/sh. /lava-3739709/e=
nvironment
    2023-08-12T21:13:01.515331  =

    2023-08-12T21:13:01.515525  <3>[   10.194197] Bluetooth: hci0: command =
0xfc18 tx timeout
    2023-08-12T21:13:01.616729  / # . /lava-3739709/environment/lava-373970=
9/bin/lava-test-runner /lava-3739709/1
    2023-08-12T21:13:01.617763  =

    2023-08-12T21:13:01.622244  / # /lava-3739709/bin/lava-test-runner /lav=
a-3739709/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
fsl-ls2088a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64d7f6590547bd20e135b266

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-71-ge089901a2a7ef/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rd=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-71-ge089901a2a7ef/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rd=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d7f6590547bd20e135b269
        failing since 29 days (last pass: v5.15.67, first fail: v5.15.119-1=
6-g66130849c020f)

    2023-08-12T21:14:39.675463  + [   14.809775] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1243278_1.5.2.4.1>
    2023-08-12T21:14:39.675759  set +x
    2023-08-12T21:14:39.780973  =

    2023-08-12T21:14:39.882255  / # #export SHELL=3D/bin/sh
    2023-08-12T21:14:39.882646  =

    2023-08-12T21:14:39.983511  / # export SHELL=3D/bin/sh. /lava-1243278/e=
nvironment
    2023-08-12T21:14:39.984095  =

    2023-08-12T21:14:40.085159  / # . /lava-1243278/environment/lava-124327=
8/bin/lava-test-runner /lava-1243278/1
    2023-08-12T21:14:40.085933  =

    2023-08-12T21:14:40.089173  / # /lava-1243278/bin/lava-test-runner /lav=
a-1243278/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
fsl-lx2160a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64d7f642b2d810cc5635b202

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-71-ge089901a2a7ef/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rd=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-71-ge089901a2a7ef/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rd=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d7f642b2d810cc5635b205
        failing since 162 days (last pass: v5.15.79, first fail: v5.15.98)

    2023-08-12T21:14:34.291267  [   11.108835] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1243275_1.5.2.4.1>
    2023-08-12T21:14:34.396831  =

    2023-08-12T21:14:34.498481  / # #export SHELL=3D/bin/sh
    2023-08-12T21:14:34.499016  =

    2023-08-12T21:14:34.600142  / # export SHELL=3D/bin/sh. /lava-1243275/e=
nvironment
    2023-08-12T21:14:34.600664  =

    2023-08-12T21:14:34.701688  / # . /lava-1243275/environment/lava-124327=
5/bin/lava-test-runner /lava-1243275/1
    2023-08-12T21:14:34.702461  =

    2023-08-12T21:14:34.705335  / # /lava-1243275/bin/lava-test-runner /lav=
a-1243275/1
    2023-08-12T21:14:34.722361  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d7f583aec3d818e835b266

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-71-ge089901a2a7ef/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-71-ge089901a2a7ef/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d7f583aec3d818e835b26b
        failing since 136 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-12T21:11:11.323469  <8>[   10.820389] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11274179_1.4.2.3.1>

    2023-08-12T21:11:11.328231  + set +x

    2023-08-12T21:11:11.434517  #

    2023-08-12T21:11:11.435760  =


    2023-08-12T21:11:11.537487  / # #export SHELL=3D/bin/sh

    2023-08-12T21:11:11.538217  =


    2023-08-12T21:11:11.639610  / # export SHELL=3D/bin/sh. /lava-11274179/=
environment

    2023-08-12T21:11:11.640337  =


    2023-08-12T21:11:11.741896  / # . /lava-11274179/environment/lava-11274=
179/bin/lava-test-runner /lava-11274179/1

    2023-08-12T21:11:11.742273  =

 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d7f3c602e2ab59d835b238

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-71-ge089901a2a7ef/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-71-ge089901a2a7ef/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d7f3c602e2ab59d835b23d
        failing since 136 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-12T21:04:01.493900  + set<8>[   11.068559] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11274194_1.4.2.3.1>

    2023-08-12T21:04:01.493983   +x

    2023-08-12T21:04:01.598172  / # #

    2023-08-12T21:04:01.698898  export SHELL=3D/bin/sh

    2023-08-12T21:04:01.699132  #

    2023-08-12T21:04:01.799660  / # export SHELL=3D/bin/sh. /lava-11274194/=
environment

    2023-08-12T21:04:01.799869  =


    2023-08-12T21:04:01.900437  / # . /lava-11274194/environment/lava-11274=
194/bin/lava-test-runner /lava-11274194/1

    2023-08-12T21:04:01.900761  =


    2023-08-12T21:04:01.906089  / # /lava-11274194/bin/lava-test-runner /la=
va-11274194/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d7f3cc249edf213435b200

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-71-ge089901a2a7ef/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-71-ge089901a2a7ef/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d7f3cc249edf213435b205
        failing since 136 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-12T21:04:01.935088  + set<8>[   17.615357] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11274199_1.4.2.3.1>

    2023-08-12T21:04:01.935192   +x

    2023-08-12T21:04:02.039767  / # #

    2023-08-12T21:04:02.140393  export SHELL=3D/bin/sh

    2023-08-12T21:04:02.140566  #

    2023-08-12T21:04:02.241029  / # export SHELL=3D/bin/sh. /lava-11274199/=
environment

    2023-08-12T21:04:02.241208  =


    2023-08-12T21:04:02.341688  / # . /lava-11274199/environment/lava-11274=
199/bin/lava-test-runner /lava-11274199/1

    2023-08-12T21:04:02.341973  =


    2023-08-12T21:04:02.346515  / # /lava-11274199/bin/lava-test-runner /la=
va-11274199/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a77960-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64d7f5cebaf22803c235b234

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-71-ge089901a2a7ef/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-71-ge089901a2a7ef/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d7f5cebaf22803c235b239
        failing since 24 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-08-12T21:14:20.391208  / # #

    2023-08-12T21:14:20.491713  export SHELL=3D/bin/sh

    2023-08-12T21:14:20.491822  #

    2023-08-12T21:14:20.592273  / # export SHELL=3D/bin/sh. /lava-11274292/=
environment

    2023-08-12T21:14:20.592375  =


    2023-08-12T21:14:20.692780  / # . /lava-11274292/environment/lava-11274=
292/bin/lava-test-runner /lava-11274292/1

    2023-08-12T21:14:20.692960  =


    2023-08-12T21:14:20.704901  / # /lava-11274292/bin/lava-test-runner /la=
va-11274292/1

    2023-08-12T21:14:20.758544  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-12T21:14:20.758604  + cd /lav<8>[   15.965633] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11274292_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64d7f6215309a8120035b228

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-71-ge089901a2a7ef/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-71-ge089901a2a7ef/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d7f6215309a8120035b22d
        failing since 24 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-08-12T21:14:32.282738  / # #

    2023-08-12T21:14:33.362955  export SHELL=3D/bin/sh

    2023-08-12T21:14:33.364912  #

    2023-08-12T21:14:34.854111  / # export SHELL=3D/bin/sh. /lava-11274300/=
environment

    2023-08-12T21:14:34.856108  =


    2023-08-12T21:14:37.580954  / # . /lava-11274300/environment/lava-11274=
300/bin/lava-test-runner /lava-11274300/1

    2023-08-12T21:14:37.582946  =


    2023-08-12T21:14:37.591298  / # /lava-11274300/bin/lava-test-runner /la=
va-11274300/1

    2023-08-12T21:14:37.653831  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-12T21:14:37.654361  + cd /lava-112743<8>[   25.504546] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11274300_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64d7f5f9be0b26533035b20c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-71-ge089901a2a7ef/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-71-ge089901a2a7ef/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d7f5f9be0b26533035b211
        failing since 24 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-08-12T21:14:34.150599  / # #

    2023-08-12T21:14:34.252759  export SHELL=3D/bin/sh

    2023-08-12T21:14:34.253510  #

    2023-08-12T21:14:34.354949  / # export SHELL=3D/bin/sh. /lava-11274296/=
environment

    2023-08-12T21:14:34.355659  =


    2023-08-12T21:14:34.457135  / # . /lava-11274296/environment/lava-11274=
296/bin/lava-test-runner /lava-11274296/1

    2023-08-12T21:14:34.458253  =


    2023-08-12T21:14:34.474814  / # /lava-11274296/bin/lava-test-runner /la=
va-11274296/1

    2023-08-12T21:14:34.532957  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-12T21:14:34.533456  + cd /lava-1127429<8>[   16.839040] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11274296_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
