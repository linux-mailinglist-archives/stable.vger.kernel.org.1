Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1131D714C1D
	for <lists+stable@lfdr.de>; Mon, 29 May 2023 16:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjE2Ofr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 29 May 2023 10:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjE2Ofq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 29 May 2023 10:35:46 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AB4AD
        for <stable@vger.kernel.org>; Mon, 29 May 2023 07:35:44 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b01d7b3ee8so19054585ad.0
        for <stable@vger.kernel.org>; Mon, 29 May 2023 07:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685370943; x=1687962943;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4a619y16eLm9U89ZA76O04O/8h3BOQ4M0JGA2VXjIQE=;
        b=OZPrVjAA+B2h+appeYd+WpXGYUUIWXXWaHAZaiyO45OqAlv0Fmjw5DafSwOQvStIbM
         slwNCQa0vF5TQCt//NWsPUFYCILNHwVA5UhqU92UPczvknkLq17UylQCBf7soEtMVYHN
         W4N1hOfk6C+mq+9D0Gzw+tWKlGk6alVOxx4togUKD/26xXAhqtK+pgdzclyszH+ZslnF
         CuN6IqjddhFT+kYgY0PfEg6+kV+0hG6V9aJQepyPN3zD0rRxkbOEelCyydQwAoptSi6y
         mhILYDSIWXkIYf5nXh74pvhlDg5iA+FVC8ZbPQ0JWIKd7aGwAKYHJUBi3oJee6OKg5jl
         bSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685370943; x=1687962943;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4a619y16eLm9U89ZA76O04O/8h3BOQ4M0JGA2VXjIQE=;
        b=T767hzmRyp0JHtlhDoR4zrosUtMJmjRNzpeoewcZyioqyob7TcIX8OkjTHDZEa+sQk
         3uWwiY9C9mH6zk/8awy9gTeuLxjWHYhSRPmIl6x9lEBCEq++rrWCkvaarlF+dDE+pGBT
         pINhxC107sljfrQizHFbA2pBr4dY83vQkH4gjIXy8+sETF50OgVRlOu+iJiexaePlPhm
         JlWd/Nn1CgUzwgA6mS4rj+V7b3ng7/24gmpxb2CAzGXNPQXEqWYPsKmw3DjHwtdzkrMO
         97pELh/x3ANetykzXD705FEBYYDXUutsH5+O5NwSDGdyv8CX8pdO2TsvM1QJpBJtma83
         2g+A==
X-Gm-Message-State: AC+VfDxzYlCRlbiQbF4lWWtDxu45LlNwsJlmFiq1cbAsRB7vkJQxAU4j
        pVogUGOCgzhW1FKy3f77mXWakxZEQrMoLpCif61IZQ==
X-Google-Smtp-Source: ACHHUZ4VyeId84JOw1AJvlzUOP1idbEiXKq+jX4LO4DvagHh0TcSY3mWlZYaLTAjxeVJeo2xrz46rA==
X-Received: by 2002:a17:902:d509:b0:1ab:7c4:eb24 with SMTP id b9-20020a170902d50900b001ab07c4eb24mr14358472plg.22.1685370942883;
        Mon, 29 May 2023 07:35:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n13-20020a170903110d00b001a04d27ee92sm4439538plh.241.2023.05.29.07.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 07:35:42 -0700 (PDT)
Message-ID: <6474b83e.170a0220.5ed2b.6bb7@mx.google.com>
Date:   Mon, 29 May 2023 07:35:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.112-273-g076e4ddcb04e
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 160 runs,
 9 regressions (v5.15.112-273-g076e4ddcb04e)
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

stable-rc/queue/5.15 baseline: 160 runs, 9 regressions (v5.15.112-273-g076e=
4ddcb04e)

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

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =

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

odroid-xu3                   | arm    | lab-collabora | gcc-10   | exynos_d=
efconfig             | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.112-273-g076e4ddcb04e/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.112-273-g076e4ddcb04e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      076e4ddcb04e5ad3be09ec10f506800eb3cbaf66 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64748094c0ddd710732e85fd

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g076e4ddcb04e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g076e4ddcb04e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64748094c0ddd710732e8602
        failing since 61 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-29T10:37:51.734221  + <8>[   11.185481] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10507657_1.4.2.3.1>

    2023-05-29T10:37:51.734797  set +x

    2023-05-29T10:37:51.844038  / # #

    2023-05-29T10:37:51.946276  export SHELL=3D/bin/sh

    2023-05-29T10:37:51.946933  #

    2023-05-29T10:37:52.048410  / # export SHELL=3D/bin/sh. /lava-10507657/=
environment

    2023-05-29T10:37:52.048652  =


    2023-05-29T10:37:52.149448  / # . /lava-10507657/environment/lava-10507=
657/bin/lava-test-runner /lava-10507657/1

    2023-05-29T10:37:52.150594  =


    2023-05-29T10:37:52.155346  / # /lava-10507657/bin/lava-test-runner /la=
va-10507657/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6474808d448495f3fe2e86ac

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g076e4ddcb04e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g076e4ddcb04e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6474808d448495f3fe2e86b1
        failing since 61 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-29T10:37:43.375169  <8>[   11.344144] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10507650_1.4.2.3.1>

    2023-05-29T10:37:43.378498  + set +x

    2023-05-29T10:37:43.479893  =


    2023-05-29T10:37:43.580528  / # #export SHELL=3D/bin/sh

    2023-05-29T10:37:43.580721  =


    2023-05-29T10:37:43.681232  / # export SHELL=3D/bin/sh. /lava-10507650/=
environment

    2023-05-29T10:37:43.681422  =


    2023-05-29T10:37:43.781957  / # . /lava-10507650/environment/lava-10507=
650/bin/lava-test-runner /lava-10507650/1

    2023-05-29T10:37:43.782279  =


    2023-05-29T10:37:43.787457  / # /lava-10507650/bin/lava-test-runner /la=
va-10507650/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647481dd14e6ad44f02e8611

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g076e4ddcb04e/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91s=
am9g20ek.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g076e4ddcb04e/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91s=
am9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647481dd14e6ad44f02e8=
612
        new failure (last pass: v5.15.112-273-gd9a33ebea341) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6474864a78387254c72e8607

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g076e4ddcb04e/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g076e4ddcb04e/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6474864a78387254c72e8=
608
        failing since 115 days (last pass: v5.15.91-12-g3290f78df1ab, first=
 fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647483a260b0a74c532e85f1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g076e4ddcb04e/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g076e4ddcb04e/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647483a260b0a74c532e85f6
        failing since 132 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-29T10:51:03.291540  <8>[   10.074227] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3629608_1.5.2.4.1>
    2023-05-29T10:51:03.403779  / # #
    2023-05-29T10:51:03.507836  export SHELL=3D/bin/sh
    2023-05-29T10:51:03.509013  #
    2023-05-29T10:51:03.611590  / # export SHELL=3D/bin/sh. /lava-3629608/e=
nvironment
    2023-05-29T10:51:03.612797  =

    2023-05-29T10:51:03.715803  / # . /lava-3629608/environment/lava-362960=
8/bin/lava-test-runner /lava-3629608/1
    2023-05-29T10:51:03.717544  =

    2023-05-29T10:51:03.723011  / # /lava-3629608/bin/lava-test-runner /lav=
a-3629608/1
    2023-05-29T10:51:03.811223  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647480da77e87d46602e86d4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g076e4ddcb04e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g076e4ddcb04e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647480da77e87d46602e86d9
        failing since 61 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-29T10:39:04.794730  + set +x

    2023-05-29T10:39:04.801538  <8>[   10.369161] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10507686_1.4.2.3.1>

    2023-05-29T10:39:04.905450  / # #

    2023-05-29T10:39:05.006087  export SHELL=3D/bin/sh

    2023-05-29T10:39:05.006286  #

    2023-05-29T10:39:05.106832  / # export SHELL=3D/bin/sh. /lava-10507686/=
environment

    2023-05-29T10:39:05.107059  =


    2023-05-29T10:39:05.207610  / # . /lava-10507686/environment/lava-10507=
686/bin/lava-test-runner /lava-10507686/1

    2023-05-29T10:39:05.207897  =


    2023-05-29T10:39:05.213105  / # /lava-10507686/bin/lava-test-runner /la=
va-10507686/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64748084448495f3fe2e8697

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g076e4ddcb04e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g076e4ddcb04e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64748084448495f3fe2e869c
        failing since 61 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-29T10:37:43.881670  <8>[   10.963346] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10507666_1.4.2.3.1>

    2023-05-29T10:37:43.884662  + set +x

    2023-05-29T10:37:43.990032  / # #

    2023-05-29T10:37:44.090577  export SHELL=3D/bin/sh

    2023-05-29T10:37:44.090814  #

    2023-05-29T10:37:44.191439  / # export SHELL=3D/bin/sh. /lava-10507666/=
environment

    2023-05-29T10:37:44.191624  =


    2023-05-29T10:37:44.292200  / # . /lava-10507666/environment/lava-10507=
666/bin/lava-test-runner /lava-10507666/1

    2023-05-29T10:37:44.292553  =


    2023-05-29T10:37:44.297891  / # /lava-10507666/bin/lava-test-runner /la=
va-10507666/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64748079a0e0f28e6c2e8670

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g076e4ddcb04e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g076e4ddcb04e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64748079a0e0f28e6c2e8675
        failing since 61 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-29T10:37:39.683257  + set<8>[    8.530516] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10507678_1.4.2.3.1>

    2023-05-29T10:37:39.683341   +x

    2023-05-29T10:37:39.787353  / # #

    2023-05-29T10:37:39.887909  export SHELL=3D/bin/sh

    2023-05-29T10:37:39.888091  #

    2023-05-29T10:37:39.988563  / # export SHELL=3D/bin/sh. /lava-10507678/=
environment

    2023-05-29T10:37:39.988733  =


    2023-05-29T10:37:40.089218  / # . /lava-10507678/environment/lava-10507=
678/bin/lava-test-runner /lava-10507678/1

    2023-05-29T10:37:40.089505  =


    2023-05-29T10:37:40.094400  / # /lava-10507678/bin/lava-test-runner /la=
va-10507678/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
odroid-xu3                   | arm    | lab-collabora | gcc-10   | exynos_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/6474818d861b9f27cc2e8616

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: exynos_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g076e4ddcb04e/arm/exynos_defconfig/gcc-10/lab-collabora/baseline-odroi=
d-xu3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g076e4ddcb04e/arm/exynos_defconfig/gcc-10/lab-collabora/baseline-odroi=
d-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6474818d861b9f27cc2e8=
617
        new failure (last pass: v5.15.112-286-gb4a5fdb6a8b48) =

 =20
