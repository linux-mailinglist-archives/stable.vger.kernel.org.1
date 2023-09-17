Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149567A3589
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 14:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjIQMhD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 08:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbjIQMgz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 08:36:55 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08604186
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 05:36:49 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-5736caaf151so2139598eaf.3
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 05:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694954208; x=1695559008; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y+CnvRIOelGw3uF/P4azHItPdlZEV4t0Dhg+RNqWCc0=;
        b=eMCJfoGaMAyxj45e+1mH/0QR94gbdyFsi+IDW+q0XTHgP15N98nNCKg7SMdqKzKtub
         8Rec9GY6ziRg20laKpk+hV1b7L+aJyFwjj4gfsv9taBp2eFWz8RGTmuUaEwPIm6KyNZi
         CgJGJPAqhCh2XKDiOflSuBvMQ+TgkU32HSMD4EdPJtsaC+Ensu62Ok8VdB0DWmHF/IVA
         uj+qg1xRK3Rf1ihlY1UnblAVekVcIhZsWv0VP0BMSUCuXti7nyISSP/GUkmnWRhrsYsJ
         6Z2j8E6qAXxYhOB33VbMy38HTea4QzaUJn0b6xRyWRdg8yxZRyzPYpYUW5MzFTvYIxaU
         yOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694954208; x=1695559008;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+CnvRIOelGw3uF/P4azHItPdlZEV4t0Dhg+RNqWCc0=;
        b=F65VxastT22hiQrAbrIu//2T5Z+j3tUY7G+w1QWV5IN+bnoMjL0s/WA95yB7onr9a9
         l+vBsPRFar8KTKmAA5HtfezGGC+3R/vl0FudiGYM4If2fzq/iK436r2N04W07eDuf1e2
         In+ZDBGBC7YqU59KX75Tsf5TOjOjDi9/VWmtlXWYshzgq4dBdcSfo8oW56ikJAkZQT/A
         N1/u194EUYRoK6+UzkqdVMSwgj2Te3HbS4ZDtFT1GSFFvDjG5zthGAc0YE+5p4jVvkn2
         3cikQZpZLfeAvOqG65LOzy9lrpHxjtvgy9A7RkSDUNPYnyN7YcSZMcfuKlemYz2Rznt/
         ISBw==
X-Gm-Message-State: AOJu0Yxea31LqiB4boGT+yWvewhgT5r2hW0d2fIjwhILO+TCTDCTv3wy
        sA7m7b9SoTK87jbqzB95l//2dK4WF6uyW5UJDhXzmA==
X-Google-Smtp-Source: AGHT+IH8KWIiMv9bfL59sX+WcXao6M7SuWk32FL8lWga1r/1oe+uSUIumDT2BlSNphApzRCzzGaHjw==
X-Received: by 2002:a05:6870:d0cd:b0:1c0:d0e8:8ff9 with SMTP id k13-20020a056870d0cd00b001c0d0e88ff9mr7417733oaa.16.1694954207673;
        Sun, 17 Sep 2023 05:36:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i7-20020a63b307000000b00563590be25esm4667935pgf.29.2023.09.17.05.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 05:36:47 -0700 (PDT)
Message-ID: <6506f2df.630a0220.9b314.f192@mx.google.com>
Date:   Sun, 17 Sep 2023 05:36:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.52-814-g5e5c3289d389
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-6.1.y baseline: 116 runs,
 9 regressions (v6.1.52-814-g5e5c3289d389)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.1.y baseline: 116 runs, 9 regressions (v6.1.52-814-g5e5c3=
289d389)

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

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.52-814-g5e5c3289d389/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.52-814-g5e5c3289d389
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      5e5c3289d3893fe13c2783ba8ecb76038405e19a =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6506c0976afcf6defa8a0a5e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
814-g5e5c3289d389/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
814-g5e5c3289d389/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6506c0976afcf6defa8a0a67
        failing since 170 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-17T09:03:23.895074  <8>[    8.112385] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11552094_1.4.2.3.1>

    2023-09-17T09:03:23.898549  + set +x

    2023-09-17T09:03:24.002901  / # #

    2023-09-17T09:03:24.103446  export SHELL=3D/bin/sh

    2023-09-17T09:03:24.103657  #

    2023-09-17T09:03:24.204137  / # export SHELL=3D/bin/sh. /lava-11552094/=
environment

    2023-09-17T09:03:24.204320  =


    2023-09-17T09:03:24.304799  / # . /lava-11552094/environment/lava-11552=
094/bin/lava-test-runner /lava-11552094/1

    2023-09-17T09:03:24.305101  =


    2023-09-17T09:03:24.310863  / # /lava-11552094/bin/lava-test-runner /la=
va-11552094/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6506c0a38a8702ea198a0abd

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
814-g5e5c3289d389/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
814-g5e5c3289d389/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6506c0a38a8702ea198a0ac6
        failing since 170 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-17T09:02:12.647251  + set<8>[   11.669375] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11552124_1.4.2.3.1>

    2023-09-17T09:02:12.647875   +x

    2023-09-17T09:02:12.755916  / # #

    2023-09-17T09:02:12.858417  export SHELL=3D/bin/sh

    2023-09-17T09:02:12.859422  #

    2023-09-17T09:02:12.961145  / # export SHELL=3D/bin/sh. /lava-11552124/=
environment

    2023-09-17T09:02:12.961981  =


    2023-09-17T09:02:13.063656  / # . /lava-11552124/environment/lava-11552=
124/bin/lava-test-runner /lava-11552124/1

    2023-09-17T09:02:13.064939  =


    2023-09-17T09:02:13.070284  / # /lava-11552124/bin/lava-test-runner /la=
va-11552124/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6506c0956afcf6defa8a0a52

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
814-g5e5c3289d389/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
814-g5e5c3289d389/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6506c0956afcf6defa8a0a5b
        failing since 170 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-17T09:01:53.888354  <8>[   10.489305] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11552089_1.4.2.3.1>

    2023-09-17T09:01:53.891413  + set +x

    2023-09-17T09:01:53.992933  =


    2023-09-17T09:01:54.093516  / # #export SHELL=3D/bin/sh

    2023-09-17T09:01:54.093730  =


    2023-09-17T09:01:54.194261  / # export SHELL=3D/bin/sh. /lava-11552089/=
environment

    2023-09-17T09:01:54.194416  =


    2023-09-17T09:01:54.294972  / # . /lava-11552089/environment/lava-11552=
089/bin/lava-test-runner /lava-11552089/1

    2023-09-17T09:01:54.295212  =


    2023-09-17T09:01:54.300269  / # /lava-11552089/bin/lava-test-runner /la=
va-11552089/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6506c1cd540451c6e68a0a81

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
814-g5e5c3289d389/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
814-g5e5c3289d389/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6506c1cd540451c6e68a0=
a82
        failing since 101 days (last pass: v6.1.31-40-g7d0a9678d276, first =
fail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6506c09a070606057c8a0a69

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
814-g5e5c3289d389/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
814-g5e5c3289d389/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6506c09a070606057c8a0a72
        failing since 170 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-17T09:03:27.040757  + set +x

    2023-09-17T09:03:27.047454  <8>[   10.693198] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11552108_1.4.2.3.1>

    2023-09-17T09:03:27.151715  / # #

    2023-09-17T09:03:27.252402  export SHELL=3D/bin/sh

    2023-09-17T09:03:27.252582  #

    2023-09-17T09:03:27.353046  / # export SHELL=3D/bin/sh. /lava-11552108/=
environment

    2023-09-17T09:03:27.353249  =


    2023-09-17T09:03:27.453796  / # . /lava-11552108/environment/lava-11552=
108/bin/lava-test-runner /lava-11552108/1

    2023-09-17T09:03:27.454122  =


    2023-09-17T09:03:27.458510  / # /lava-11552108/bin/lava-test-runner /la=
va-11552108/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6506c0882addc708978a0a7b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
814-g5e5c3289d389/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
814-g5e5c3289d389/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6506c0882addc708978a0a84
        failing since 170 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-17T09:02:04.426306  + set<8>[   11.098326] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11552100_1.4.2.3.1>

    2023-09-17T09:02:04.426784   +x

    2023-09-17T09:02:04.534660  / # #

    2023-09-17T09:02:04.635344  export SHELL=3D/bin/sh

    2023-09-17T09:02:04.635635  #

    2023-09-17T09:02:04.736434  / # export SHELL=3D/bin/sh. /lava-11552100/=
environment

    2023-09-17T09:02:04.737233  =


    2023-09-17T09:02:04.838763  / # . /lava-11552100/environment/lava-11552=
100/bin/lava-test-runner /lava-11552100/1

    2023-09-17T09:02:04.840000  =


    2023-09-17T09:02:04.844750  / # /lava-11552100/bin/lava-test-runner /la=
va-11552100/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6506c0958a8702ea198a0a7e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
814-g5e5c3289d389/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
814-g5e5c3289d389/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6506c0958a8702ea198a0a87
        failing since 170 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-17T09:01:52.567397  <8>[   12.232521] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11552133_1.4.2.3.1>

    2023-09-17T09:01:52.671953  / # #

    2023-09-17T09:01:52.772554  export SHELL=3D/bin/sh

    2023-09-17T09:01:52.772739  #

    2023-09-17T09:01:52.873233  / # export SHELL=3D/bin/sh. /lava-11552133/=
environment

    2023-09-17T09:01:52.873430  =


    2023-09-17T09:01:52.973971  / # . /lava-11552133/environment/lava-11552=
133/bin/lava-test-runner /lava-11552133/1

    2023-09-17T09:01:52.974281  =


    2023-09-17T09:01:52.978911  / # /lava-11552133/bin/lava-test-runner /la=
va-11552133/1

    2023-09-17T09:01:52.985665  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6506f105050e43158d8a0a47

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
814-g5e5c3289d389/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
814-g5e5c3289d389/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6506f105050e43158d8a0a50
        failing since 61 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-09-17T12:32:55.400027  / # #

    2023-09-17T12:32:55.502378  export SHELL=3D/bin/sh

    2023-09-17T12:32:55.503160  #

    2023-09-17T12:32:55.605004  / # export SHELL=3D/bin/sh. /lava-11552154/=
environment

    2023-09-17T12:32:55.605716  =


    2023-09-17T12:32:55.707173  / # . /lava-11552154/environment/lava-11552=
154/bin/lava-test-runner /lava-11552154/1

    2023-09-17T12:32:55.708449  =


    2023-09-17T12:32:55.723076  / # /lava-11552154/bin/lava-test-runner /la=
va-11552154/1

    2023-09-17T12:32:55.773333  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-17T12:32:55.773854  + cd /lava-115521<8>[   19.027160] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11552154_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6506c0cc3cdcf0a9a98a0a59

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
814-g5e5c3289d389/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
814-g5e5c3289d389/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6506c0cc3cdcf0a9a98a0a62
        failing since 61 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-09-17T09:07:22.334213  / # #

    2023-09-17T09:07:22.436346  export SHELL=3D/bin/sh

    2023-09-17T09:07:22.437048  #

    2023-09-17T09:07:22.538374  / # export SHELL=3D/bin/sh. /lava-11552152/=
environment

    2023-09-17T09:07:22.539092  =


    2023-09-17T09:07:22.640538  / # . /lava-11552152/environment/lava-11552=
152/bin/lava-test-runner /lava-11552152/1

    2023-09-17T09:07:22.641612  =


    2023-09-17T09:07:22.647361  / # /lava-11552152/bin/lava-test-runner /la=
va-11552152/1

    2023-09-17T09:07:22.688323  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-17T09:07:22.721468  + cd /lava-1155215<8>[   18.829243] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11552152_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
