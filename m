Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12BD76B60E
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 15:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjHANlU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 09:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjHANlT (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 09:41:19 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A185D1BF5
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 06:41:16 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bb119be881so48099185ad.3
        for <stable@vger.kernel.org>; Tue, 01 Aug 2023 06:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690897275; x=1691502075;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6RlHonESs0DqpFfJO5NwPSeExaBjZ9zBGiyhprUdPAc=;
        b=uWh6wFHWeauiJwzg0A+Gg0k83BtpXmmy54BYLHH3Ts0+NXYMpDd5BtEP23S++8zpar
         i4Cbi4bCyHTAHRsmItHh2XTbqabqxp2E8DHZp36VdxtUUwj1BklQP31TXmSpOnJzP6i9
         DBCJiN9HNbNbfUMt+gHlbo8q9wIhbyMSbUP3JlYIZ2y3bnvGb0uyn83OzTdv3HHW9hvI
         sLEQ9hTzY+QRTBg79D5tjh6QcUlJveAPu3M2gNDRI4gDdVYzvDZAdH5X2G+xub0FdwUy
         KuNpCZnB3GkFvZj99/RpM9vD0gtD1Y9cQBtpPvyxGxKamGyIC0JudJN6APSgHJbPPOhl
         nnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690897275; x=1691502075;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6RlHonESs0DqpFfJO5NwPSeExaBjZ9zBGiyhprUdPAc=;
        b=gUhLC/47vFvEvKFQjBQN0/hMZSggtNrRbWT+DL7Jh1aMmmIOdV+3NCK3cNf7I+aWfE
         jas3nxfkXUal0iakTt/H5NvnXDYCPn60HSdxNzqq3MHs9287VyhB1pxGN4CyZBi31kfE
         qnw0usci3k1V0qMWDTXO9pgtN2lMtzUf5Cn2dFWmGxjlFSMrWCBos/D7BM4XL/87Q8BD
         c1CDHXfxlJjSmVe0LPm3hi/YIhAAe2E639yQzqWvqW6stfm1cc+HVDeCdqWOzTVoKR9Z
         sZ53XiuSoJys0LBqkuWREEYnaVeSis7HTDbTR3hi2qDJkeIIumHJa/q5b1cOQvNLCMz+
         ynPA==
X-Gm-Message-State: ABy/qLZn3LmCROsHW5SsKScAG/Jnq8ta8fGNZCnWcwdcGgton84Fw7/t
        Z0a0D8QMMLKxDqRDgINQAX5sJl6UpFFm/SwcAtAYOA==
X-Google-Smtp-Source: APBJJlHMY+RvyFlDXwN5iQNxfKTa6znBteTexEebNwCNtsdrL4465N2JCrh6VDLafGjb5ycdHO7qZQ==
X-Received: by 2002:a17:902:da81:b0:1b8:36a8:faf9 with SMTP id j1-20020a170902da8100b001b836a8faf9mr15908955plx.38.1690897275293;
        Tue, 01 Aug 2023 06:41:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 29-20020a17090a1a5d00b0025c2c398d33sm8300516pjl.39.2023.08.01.06.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 06:41:14 -0700 (PDT)
Message-ID: <64c90b7a.170a0220.970d.0144@mx.google.com>
Date:   Tue, 01 Aug 2023 06:41:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Kernel: v6.1.42-229-g9f9cafb143051
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-6.1.y baseline: 130 runs,
 13 regressions (v6.1.42-229-g9f9cafb143051)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.1.y baseline: 130 runs, 13 regressions (v6.1.42-229-g9f9c=
afb143051)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

at91-sama5d4_xplained        | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx6dl-riotboard             | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.42-229-g9f9cafb143051/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.42-229-g9f9cafb143051
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      9f9cafb1430514f7d57ecf2ad5ee78b2ce5e3906 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8d731f14e35df238ace64

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
229-g9f9cafb143051/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-acer-chromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
229-g9f9cafb143051/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-acer-chromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64c8d731f14e35df238ac=
e65
        new failure (last pass: v6.1.42-221-gf40ed79b9e80) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8d71bd89253909f8ace1d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
229-g9f9cafb143051/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
229-g9f9cafb143051/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8d71bd89253909f8ace22
        failing since 123 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-01T09:57:35.351467  + set +x

    2023-08-01T09:57:35.358746  <8>[   10.867009] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11182503_1.4.2.3.1>

    2023-08-01T09:57:35.463040  / # #

    2023-08-01T09:57:35.563580  export SHELL=3D/bin/sh

    2023-08-01T09:57:35.563747  #

    2023-08-01T09:57:35.664250  / # export SHELL=3D/bin/sh. /lava-11182503/=
environment

    2023-08-01T09:57:35.664413  =


    2023-08-01T09:57:35.765067  / # . /lava-11182503/environment/lava-11182=
503/bin/lava-test-runner /lava-11182503/1

    2023-08-01T09:57:35.765302  =


    2023-08-01T09:57:35.771428  / # /lava-11182503/bin/lava-test-runner /la=
va-11182503/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8d72ef14e35df238ace39

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
229-g9f9cafb143051/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
229-g9f9cafb143051/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8d72ef14e35df238ace3e
        failing since 123 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-01T09:57:43.320616  + <8>[   11.751714] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11182486_1.4.2.3.1>

    2023-08-01T09:57:43.320695  set +x

    2023-08-01T09:57:43.424658  / # #

    2023-08-01T09:57:43.525291  export SHELL=3D/bin/sh

    2023-08-01T09:57:43.525474  #

    2023-08-01T09:57:43.625951  / # export SHELL=3D/bin/sh. /lava-11182486/=
environment

    2023-08-01T09:57:43.626138  =


    2023-08-01T09:57:43.726681  / # . /lava-11182486/environment/lava-11182=
486/bin/lava-test-runner /lava-11182486/1

    2023-08-01T09:57:43.726955  =


    2023-08-01T09:57:43.731757  / # /lava-11182486/bin/lava-test-runner /la=
va-11182486/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8d71ce892962dc38ace61

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
229-g9f9cafb143051/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
229-g9f9cafb143051/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8d71ce892962dc38ace66
        failing since 123 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-01T09:57:40.614554  <8>[   10.689147] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11182495_1.4.2.3.1>

    2023-08-01T09:57:40.617857  + set +x

    2023-08-01T09:57:40.722878  #

    2023-08-01T09:57:40.724151  =


    2023-08-01T09:57:40.826050  / # #export SHELL=3D/bin/sh

    2023-08-01T09:57:40.826742  =


    2023-08-01T09:57:40.928246  / # export SHELL=3D/bin/sh. /lava-11182495/=
environment

    2023-08-01T09:57:40.929040  =


    2023-08-01T09:57:41.030730  / # . /lava-11182495/environment/lava-11182=
495/bin/lava-test-runner /lava-11182495/1

    2023-08-01T09:57:41.031810  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91-sama5d4_xplained        | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8dba070e78976328ace74

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
229-g9f9cafb143051/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91=
-sama5d4_xplained.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
229-g9f9cafb143051/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91=
-sama5d4_xplained.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64c8dba070e78976328ac=
e75
        new failure (last pass: v6.1.42-221-gf40ed79b9e80) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8d725d89253909f8ace2e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
229-g9f9cafb143051/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
229-g9f9cafb143051/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64c8d725d89253909f8ac=
e2f
        failing since 54 days (last pass: v6.1.31-40-g7d0a9678d276, first f=
ail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8d706bbd7e724298ace64

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
229-g9f9cafb143051/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
229-g9f9cafb143051/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8d706bbd7e724298ace69
        failing since 123 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-01T09:57:20.172199  + set +x

    2023-08-01T09:57:20.178357  <8>[   10.560734] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11182505_1.4.2.3.1>

    2023-08-01T09:57:20.282620  / # #

    2023-08-01T09:57:20.383263  export SHELL=3D/bin/sh

    2023-08-01T09:57:20.383462  #

    2023-08-01T09:57:20.483989  / # export SHELL=3D/bin/sh. /lava-11182505/=
environment

    2023-08-01T09:57:20.484190  =


    2023-08-01T09:57:20.584756  / # . /lava-11182505/environment/lava-11182=
505/bin/lava-test-runner /lava-11182505/1

    2023-08-01T09:57:20.585020  =


    2023-08-01T09:57:20.589340  / # /lava-11182505/bin/lava-test-runner /la=
va-11182505/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8d71ae892962dc38ace4b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
229-g9f9cafb143051/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
229-g9f9cafb143051/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8d71ae892962dc38ace50
        failing since 123 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-01T09:57:35.154498  + set<8>[   11.350395] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11182524_1.4.2.3.1>

    2023-08-01T09:57:35.154604   +x

    2023-08-01T09:57:35.258620  / # #

    2023-08-01T09:57:35.359190  export SHELL=3D/bin/sh

    2023-08-01T09:57:35.359343  #

    2023-08-01T09:57:35.459818  / # export SHELL=3D/bin/sh. /lava-11182524/=
environment

    2023-08-01T09:57:35.460000  =


    2023-08-01T09:57:35.560540  / # . /lava-11182524/environment/lava-11182=
524/bin/lava-test-runner /lava-11182524/1

    2023-08-01T09:57:35.560844  =


    2023-08-01T09:57:35.565788  / # /lava-11182524/bin/lava-test-runner /la=
va-11182524/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-riotboard             | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8da81f03b74e05e8ace94

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
229-g9f9cafb143051/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-i=
mx6dl-riotboard.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
229-g9f9cafb143051/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-i=
mx6dl-riotboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8da81f03b74e05e8ace99
        failing since 0 day (last pass: v6.1.41-184-gb3f8a9d2b1371, first f=
ail: v6.1.42-221-gf40ed79b9e80)

    2023-08-01T10:12:00.168894  + set[   15.011761] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 996743_1.5.2.3.1>
    2023-08-01T10:12:00.169129   +x
    2023-08-01T10:12:00.275236  / # #
    2023-08-01T10:12:00.377082  export SHELL=3D/bin/sh
    2023-08-01T10:12:00.377584  #
    2023-08-01T10:12:00.478877  / # export SHELL=3D/bin/sh. /lava-996743/en=
vironment
    2023-08-01T10:12:00.479388  =

    2023-08-01T10:12:00.580719  / # . /lava-996743/environment/lava-996743/=
bin/lava-test-runner /lava-996743/1
    2023-08-01T10:12:00.581505  =

    2023-08-01T10:12:00.584504  / # /lava-996743/bin/lava-test-runner /lava=
-996743/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8d71be892962dc38ace56

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
229-g9f9cafb143051/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
229-g9f9cafb143051/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8d71be892962dc38ace5b
        failing since 123 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-01T09:57:30.306596  <8>[   11.006053] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11182530_1.4.2.3.1>

    2023-08-01T09:57:30.410861  / # #

    2023-08-01T09:57:30.511565  export SHELL=3D/bin/sh

    2023-08-01T09:57:30.511747  #

    2023-08-01T09:57:30.612214  / # export SHELL=3D/bin/sh. /lava-11182530/=
environment

    2023-08-01T09:57:30.612409  =


    2023-08-01T09:57:30.712888  / # . /lava-11182530/environment/lava-11182=
530/bin/lava-test-runner /lava-11182530/1

    2023-08-01T09:57:30.713150  =


    2023-08-01T09:57:30.717847  / # /lava-11182530/bin/lava-test-runner /la=
va-11182530/1

    2023-08-01T09:57:30.724461  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c904751c01eadf0f8ace26

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
229-g9f9cafb143051/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
229-g9f9cafb143051/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c904751c01eadf0f8ace2b
        failing since 14 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-01T13:12:35.969767  / # #

    2023-08-01T13:12:36.071875  export SHELL=3D/bin/sh

    2023-08-01T13:12:36.072576  #

    2023-08-01T13:12:36.174013  / # export SHELL=3D/bin/sh. /lava-11182426/=
environment

    2023-08-01T13:12:36.174716  =


    2023-08-01T13:12:36.276161  / # . /lava-11182426/environment/lava-11182=
426/bin/lava-test-runner /lava-11182426/1

    2023-08-01T13:12:36.277291  =


    2023-08-01T13:12:36.294185  / # /lava-11182426/bin/lava-test-runner /la=
va-11182426/1

    2023-08-01T13:12:36.342424  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-01T13:12:36.342922  + cd /lav<8>[   19.124489] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11182426_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8d5d12f165001678ace73

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
229-g9f9cafb143051/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
229-g9f9cafb143051/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8d5d12f165001678ace78
        failing since 14 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-01T09:52:24.716608  / # #

    2023-08-01T09:52:25.797145  export SHELL=3D/bin/sh

    2023-08-01T09:52:25.798902  #

    2023-08-01T09:52:27.287707  / # export SHELL=3D/bin/sh. /lava-11182427/=
environment

    2023-08-01T09:52:27.289501  =


    2023-08-01T09:52:30.013868  / # . /lava-11182427/environment/lava-11182=
427/bin/lava-test-runner /lava-11182427/1

    2023-08-01T09:52:30.016234  =


    2023-08-01T09:52:30.023139  / # /lava-11182427/bin/lava-test-runner /la=
va-11182427/1

    2023-08-01T09:52:30.084359  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-01T09:52:30.084866  + cd /lav<8>[   28.495680] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11182427_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8d5cb2f165001678ace1d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
229-g9f9cafb143051/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
229-g9f9cafb143051/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8d5cb2f165001678ace22
        failing since 14 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-01T09:53:23.998135  / # #

    2023-08-01T09:53:24.100293  export SHELL=3D/bin/sh

    2023-08-01T09:53:24.101042  #

    2023-08-01T09:53:24.202294  / # export SHELL=3D/bin/sh. /lava-11182434/=
environment

    2023-08-01T09:53:24.202924  =


    2023-08-01T09:53:24.304203  / # . /lava-11182434/environment/lava-11182=
434/bin/lava-test-runner /lava-11182434/1

    2023-08-01T09:53:24.305215  =


    2023-08-01T09:53:24.306417  / # /lava-11182434/bin/lava-test-runner /la=
va-11182434/1

    2023-08-01T09:53:24.388641  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-01T09:53:24.389182  + cd /lava-1118243<8>[   17.011735] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11182434_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
