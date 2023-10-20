Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4FD7D19A6
	for <lists+stable@lfdr.de>; Sat, 21 Oct 2023 01:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjJTXhU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 19:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjJTXhU (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 19:37:20 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EB5D4C
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 16:37:15 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c9e95aa02dso10867045ad.0
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 16:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697845034; x=1698449834; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S8+06WTM6JfcxYUnFB3+2ifQVkoALNZwD1G/BelCpZQ=;
        b=AcJC5Ff2hG8WwV5zkdTiQqC7MW5uDGuNTN1IOI8dcjZKHnO/Ez8cidMsXlsF7mcAEg
         VgJE8bKQB80VWzh14Gfw9e2E7Wwi5adpd3PDg1JsfzgCidJgghDaZg0B3qyOibIEk5tb
         28lAnY+WyBoYmwcBUOhqHyX9iwYTn3SdUK/rT7uzT6BCYsCveQjfXvtdpc5IX8AHYsLb
         8g7gxJbi8iTpEI+Kemk3OJQRcxhXlFGbPaXyEPISv7pBOZy4AERWolMEqHr/iDuXygC6
         oTFynQCfm4M3xxv5v/609m7DPyzwD63vjWtpCEkREI3Pqy1h7lW17Dy8e4sgNvUi/lp3
         AX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697845034; x=1698449834;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S8+06WTM6JfcxYUnFB3+2ifQVkoALNZwD1G/BelCpZQ=;
        b=JCtvSP7UaWoe8P0oQz/g8LXGGqAhl3gBX1nAbqNN9DBYEXvbtIDSOQ8rsdf2NQA0oP
         XdmQ0C9IypVAVIKi3ErRhx5/evZbk9n4fCMy/ZFKMkWYDaYF4yQFDFnRmsuwe5i9yA1r
         3D6WrS8WSkUI0P0y1d1cKUhyuMCNap2qKAizJ+KhtMuDn3Mr0F9nxlWoRrK6BXZyp4yt
         C2R5XsQ6mmwD4y8LnXz6c/4NIAN64Azx8qK3TmL/AOyPzRssDU8MaoH94E2bgmG9JwAR
         bJ7mFoPQjYCf6v4oAtPWsNtGVVvEr6ftND+T9oOtTNiMouwGUjQEoxe3frH3muP2GY1Z
         +F+A==
X-Gm-Message-State: AOJu0Yza6FbKKOg/4lRCdNNA9z2A4mkb8zPUs8BiBZXyrP1o5NBVASiX
        9VxIiwwpyjxWysxtG7kmB8iBOciqb8aLwNF87jOCkA==
X-Google-Smtp-Source: AGHT+IHy4shrHdf8SjpPB5oSj+Teu3JOfIwKGbiFFB9nhMRhJWoV9nVDfDUTGc8LI6os9o2iPGkkPg==
X-Received: by 2002:a17:903:32d2:b0:1c6:d0a:cf01 with SMTP id i18-20020a17090332d200b001c60d0acf01mr9623587plr.11.1697845033527;
        Fri, 20 Oct 2023 16:37:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001acae9734c0sm2047732pli.266.2023.10.20.16.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 16:37:12 -0700 (PDT)
Message-ID: <65330f28.170a0220.29b6f4.7d31@mx.google.com>
Date:   Fri, 20 Oct 2023 16:37:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15.136
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable
Subject: stable/linux-5.15.y baseline: 262 runs, 19 regressions (v5.15.136)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-5.15.y baseline: 262 runs, 19 regressions (v5.15.136)

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

bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

meson-gxbb-p200              | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-clabbe    | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-clabbe    | gcc-10   | defconfi=
g+kselftest          | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.15.y/kernel=
/v5.15.136/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.15.y
  Describe: v5.15.136
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      00c03985402ee5e9dffa643f45b9291274bf4070 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532dac9dcb1d2e305efcef7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6532dac9dcb1d2e305efcf00
        failing since 204 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-10-20T19:55:03.199289  <8>[   10.451350] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11832499_1.4.2.3.1>

    2023-10-20T19:55:03.202615  + set +x

    2023-10-20T19:55:03.308363  / # #

    2023-10-20T19:55:03.409128  export SHELL=3D/bin/sh

    2023-10-20T19:55:03.409495  #

    2023-10-20T19:55:03.510051  / # export SHELL=3D/bin/sh. /lava-11832499/=
environment

    2023-10-20T19:55:03.510229  =


    2023-10-20T19:55:03.610749  / # . /lava-11832499/environment/lava-11832=
499/bin/lava-test-runner /lava-11832499/1

    2023-10-20T19:55:03.611113  =


    2023-10-20T19:55:03.616903  / # /lava-11832499/bin/lava-test-runner /la=
va-11832499/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532dacee26f34883eefcf08

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6532dacee26f34883eefcf11
        failing since 204 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-10-20T19:53:43.071829  + <8>[   11.841420] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11832549_1.4.2.3.1>

    2023-10-20T19:53:43.071914  set +x

    2023-10-20T19:53:43.175904  / # #

    2023-10-20T19:53:43.276571  export SHELL=3D/bin/sh

    2023-10-20T19:53:43.276759  #

    2023-10-20T19:53:43.377295  / # export SHELL=3D/bin/sh. /lava-11832549/=
environment

    2023-10-20T19:53:43.377516  =


    2023-10-20T19:53:43.478074  / # . /lava-11832549/environment/lava-11832=
549/bin/lava-test-runner /lava-11832549/1

    2023-10-20T19:53:43.478364  =


    2023-10-20T19:53:43.483477  / # /lava-11832549/bin/lava-test-runner /la=
va-11832549/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532dac69ab6cc4ee2efcf2b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6532dac69ab6cc4ee2efcf34
        failing since 204 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-10-20T19:53:33.254053  <8>[    9.930145] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11832516_1.4.2.3.1>

    2023-10-20T19:53:33.257287  + set +x

    2023-10-20T19:53:33.358683  =


    2023-10-20T19:53:33.459284  / # #export SHELL=3D/bin/sh

    2023-10-20T19:53:33.459462  =


    2023-10-20T19:53:33.560035  / # export SHELL=3D/bin/sh. /lava-11832516/=
environment

    2023-10-20T19:53:33.560230  =


    2023-10-20T19:53:33.660716  / # . /lava-11832516/environment/lava-11832=
516/bin/lava-test-runner /lava-11832516/1

    2023-10-20T19:53:33.661048  =


    2023-10-20T19:53:33.666175  / # /lava-11832516/bin/lava-test-runner /la=
va-11832516/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/6532d87988d87ea8e4efcf9c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6532d87988d87ea8e4efcfa5
        failing since 85 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-10-20T19:47:53.730915  / # #

    2023-10-20T19:47:53.832864  export SHELL=3D/bin/sh

    2023-10-20T19:47:53.833449  #

    2023-10-20T19:47:53.934696  / # export SHELL=3D/bin/sh. /lava-11832401/=
environment

    2023-10-20T19:47:53.935406  =


    2023-10-20T19:47:54.036668  / # . /lava-11832401/environment/lava-11832=
401/bin/lava-test-runner /lava-11832401/1

    2023-10-20T19:47:54.036922  =


    2023-10-20T19:47:54.039618  / # /lava-11832401/bin/lava-test-runner /la=
va-11832401/1

    2023-10-20T19:47:54.119446  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-20T19:47:54.157436  + cd /lava-11832401/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6532dbc6efea9a6134efcf3e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6532dbc6efea9a6134efc=
f3f
        failing since 198 days (last pass: v5.15.105, first fail: v5.15.106=
) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532daaabceb995fd9efcf2a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6532daaabceb995fd9efcf33
        failing since 204 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-10-20T19:53:03.109136  + <8>[   10.794629] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11832465_1.4.2.3.1>

    2023-10-20T19:53:03.109249  set +x

    2023-10-20T19:53:03.211652  =


    2023-10-20T19:53:03.312213  / # #export SHELL=3D/bin/sh

    2023-10-20T19:53:03.312415  =


    2023-10-20T19:53:03.412969  / # export SHELL=3D/bin/sh. /lava-11832465/=
environment

    2023-10-20T19:53:03.413191  =


    2023-10-20T19:53:03.513777  / # . /lava-11832465/environment/lava-11832=
465/bin/lava-test-runner /lava-11832465/1

    2023-10-20T19:53:03.514201  =


    2023-10-20T19:53:03.518939  / # /lava-11832465/bin/lava-test-runner /la=
va-11832465/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6532dbeb1f81c65cb5efcef4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6532dbeb1f81c65cb5efcefd
        failing since 204 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-10-20T19:58:11.977568  + set +x<8>[   12.465931] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11832637_1.4.2.3.1>

    2023-10-20T19:58:11.977650  =


    2023-10-20T19:58:12.081782  / # #

    2023-10-20T19:58:12.182457  export SHELL=3D/bin/sh

    2023-10-20T19:58:12.182648  #

    2023-10-20T19:58:12.283184  / # export SHELL=3D/bin/sh. /lava-11832637/=
environment

    2023-10-20T19:58:12.283362  =


    2023-10-20T19:58:12.383853  / # . /lava-11832637/environment/lava-11832=
637/bin/lava-test-runner /lava-11832637/1

    2023-10-20T19:58:12.384142  =


    2023-10-20T19:58:12.389459  / # /lava-11832637/bin/lava-test-runner /la=
va-11832637/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532daa9e4e760a621efcf10

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6532daa9e4e760a621efcf19
        failing since 204 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-10-20T19:52:57.673726  <8>[   10.428088] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11832481_1.4.2.3.1>

    2023-10-20T19:52:57.676973  + set +x

    2023-10-20T19:52:57.781813  / # #

    2023-10-20T19:52:57.882375  export SHELL=3D/bin/sh

    2023-10-20T19:52:57.882533  #

    2023-10-20T19:52:57.983126  / # export SHELL=3D/bin/sh. /lava-11832481/=
environment

    2023-10-20T19:52:57.983317  =


    2023-10-20T19:52:58.083845  / # . /lava-11832481/environment/lava-11832=
481/bin/lava-test-runner /lava-11832481/1

    2023-10-20T19:52:58.084124  =


    2023-10-20T19:52:58.089650  / # /lava-11832481/bin/lava-test-runner /la=
va-11832481/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532dabd4775532fa0efcf2b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6532dabd4775532fa0efcf34
        failing since 204 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-10-20T19:53:12.837677  + set<8>[   11.348756] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11832498_1.4.2.3.1>

    2023-10-20T19:53:12.838107   +x

    2023-10-20T19:53:12.945336  / # #

    2023-10-20T19:53:13.047291  export SHELL=3D/bin/sh

    2023-10-20T19:53:13.047909  #

    2023-10-20T19:53:13.149296  / # export SHELL=3D/bin/sh. /lava-11832498/=
environment

    2023-10-20T19:53:13.149975  =


    2023-10-20T19:53:13.251878  / # . /lava-11832498/environment/lava-11832=
498/bin/lava-test-runner /lava-11832498/1

    2023-10-20T19:53:13.253243  =


    2023-10-20T19:53:13.257681  / # /lava-11832498/bin/lava-test-runner /la=
va-11832498/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532daabbceb995fd9efcf38

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6532daabbceb995fd9efcf41
        failing since 204 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-10-20T19:53:00.624913  <8>[   12.433489] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11832486_1.4.2.3.1>

    2023-10-20T19:53:00.729701  / # #

    2023-10-20T19:53:00.830296  export SHELL=3D/bin/sh

    2023-10-20T19:53:00.830488  #

    2023-10-20T19:53:00.930979  / # export SHELL=3D/bin/sh. /lava-11832486/=
environment

    2023-10-20T19:53:00.931171  =


    2023-10-20T19:53:01.031658  / # . /lava-11832486/environment/lava-11832=
486/bin/lava-test-runner /lava-11832486/1

    2023-10-20T19:53:01.031924  =


    2023-10-20T19:53:01.036158  / # /lava-11832486/bin/lava-test-runner /la=
va-11832486/1

    2023-10-20T19:53:01.041912  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6532dbd67b445ba4afefcef3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6532dbd67b445ba4afefcefc
        failing since 204 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-10-20T19:58:08.058096  + <8>[   12.702937] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11832597_1.4.2.3.1>

    2023-10-20T19:58:08.058182  set +x

    2023-10-20T19:58:08.162352  / # #

    2023-10-20T19:58:08.262929  export SHELL=3D/bin/sh

    2023-10-20T19:58:08.263107  #

    2023-10-20T19:58:08.363607  / # export SHELL=3D/bin/sh. /lava-11832597/=
environment

    2023-10-20T19:58:08.363865  =


    2023-10-20T19:58:08.464493  / # . /lava-11832597/environment/lava-11832=
597/bin/lava-test-runner /lava-11832597/1

    2023-10-20T19:58:08.464753  =


    2023-10-20T19:58:08.469381  / # /lava-11832597/bin/lava-test-runner /la=
va-11832597/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxbb-p200              | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6532d968498f90c36defcf0e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p200.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6532d968498f90c36defc=
f0f
        new failure (last pass: v5.15.119) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6532dcdf3891509a66efcef9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6532dcdf3891509a66efc=
efa
        failing since 269 days (last pass: v5.15.89, first fail: v5.15.90) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6532d851601f841a1defcf27

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6532d851601f841a1defcf30
        failing since 85 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-10-20T19:47:25.611387  / # #

    2023-10-20T19:47:25.711833  export SHELL=3D/bin/sh

    2023-10-20T19:47:25.711951  #

    2023-10-20T19:47:25.812424  / # export SHELL=3D/bin/sh. /lava-11832407/=
environment

    2023-10-20T19:47:25.812540  =


    2023-10-20T19:47:25.913041  / # . /lava-11832407/environment/lava-11832=
407/bin/lava-test-runner /lava-11832407/1

    2023-10-20T19:47:25.913247  =


    2023-10-20T19:47:25.925060  / # /lava-11832407/bin/lava-test-runner /la=
va-11832407/1

    2023-10-20T19:47:25.978958  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-20T19:47:25.979034  + cd /lav<8>[   15.973726] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11832407_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6532d88100f6497ee3efcf7f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6532d88100f6497ee3efcf88
        failing since 85 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-10-20T19:44:15.521886  / # #

    2023-10-20T19:44:16.596319  export SHELL=3D/bin/sh

    2023-10-20T19:44:16.597921  #

    2023-10-20T19:44:18.085678  / # export SHELL=3D/bin/sh. /lava-11832416/=
environment

    2023-10-20T19:44:18.086993  =


    2023-10-20T19:44:20.807359  / # . /lava-11832416/environment/lava-11832=
416/bin/lava-test-runner /lava-11832416/1

    2023-10-20T19:44:20.809460  =


    2023-10-20T19:44:20.820277  / # /lava-11832416/bin/lava-test-runner /la=
va-11832416/1

    2023-10-20T19:44:20.882102  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-20T19:44:20.882550  + cd /lava-118324<8>[   25.536734] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11832416_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-clabbe    | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6532d87300f6497ee3efcef5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6532d87300f6497ee3efcefe
        failing since 85 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-10-20T19:43:26.072688  / # #
    2023-10-20T19:43:26.174761  export SHELL=3D/bin/sh
    2023-10-20T19:43:26.175660  #
    2023-10-20T19:43:26.276873  / # export SHELL=3D/bin/sh. /lava-439430/en=
vironment
    2023-10-20T19:43:26.277519  =

    2023-10-20T19:43:26.378508  / # . /lava-439430/environment/lava-439430/=
bin/lava-test-runner /lava-439430/1
    2023-10-20T19:43:26.379471  =

    2023-10-20T19:43:26.396955  / # /lava-439430/bin/lava-test-runner /lava=
-439430/1
    2023-10-20T19:43:26.454200  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-20T19:43:26.454577  + cd /lava-439430/<8>[   16.579613] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 439430_1.5.2.4.5> =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-clabbe    | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6532ddc4f03c3b712fefcf13

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
arm64/defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
arm64/defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6532ddc4f03c3b712fefcf1c
        failing since 9 days (last pass: v5.15.107, first fail: v5.15.135)

    2023-10-20T20:06:19.479169  <8>[   22.773091] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 439451_1.5.2.4.1>
    2023-10-20T20:06:19.583499  / # #
    2023-10-20T20:06:19.685023  export SHELL=3D/bin/sh
    2023-10-20T20:06:19.685535  #
    2023-10-20T20:06:19.786661  / # export SHELL=3D/bin/sh. /lava-439451/en=
vironment
    2023-10-20T20:06:19.787211  =

    2023-10-20T20:06:19.888175  / # . /lava-439451/environment/lava-439451/=
bin/lava-test-runner /lava-439451/1
    2023-10-20T20:06:19.888857  =

    2023-10-20T20:06:19.894612  / # /lava-439451/bin/lava-test-runner /lava=
-439451/1
    2023-10-20T20:06:20.082731  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6532d865e556e81d9defcf27

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6532d865e556e81d9defcf30
        failing since 85 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-10-20T19:47:40.611581  / # #

    2023-10-20T19:47:40.713695  export SHELL=3D/bin/sh

    2023-10-20T19:47:40.714416  #

    2023-10-20T19:47:40.815853  / # export SHELL=3D/bin/sh. /lava-11832408/=
environment

    2023-10-20T19:47:40.816606  =


    2023-10-20T19:47:40.918086  / # . /lava-11832408/environment/lava-11832=
408/bin/lava-test-runner /lava-11832408/1

    2023-10-20T19:47:40.919179  =


    2023-10-20T19:47:40.935905  / # /lava-11832408/bin/lava-test-runner /la=
va-11832408/1

    2023-10-20T19:47:40.994645  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-20T19:47:40.995168  + cd /lava-1183240<8>[   16.833693] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11832408_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/6532d7ec5d860d9aafefcf07

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-orangepi-r1.=
txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.136/=
arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-orangepi-r1.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6532d7ec5d860d9aafefcf10
        failing since 260 days (last pass: v5.15.82, first fail: v5.15.91)

    2023-10-20T19:41:16.745866  <8>[    5.730001] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3808269_1.5.2.4.1>
    2023-10-20T19:41:16.850558  / # #
    2023-10-20T19:41:16.951728  export SHELL=3D/bin/sh
    2023-10-20T19:41:16.952087  #
    2023-10-20T19:41:17.052912  / # export SHELL=3D/bin/sh. /lava-3808269/e=
nvironment
    2023-10-20T19:41:17.053274  =

    2023-10-20T19:41:17.154095  / # . /lava-3808269/environment/lava-380826=
9/bin/lava-test-runner /lava-3808269/1
    2023-10-20T19:41:17.154698  =

    2023-10-20T19:41:17.197149  / # /lava-3808269/bin/lava-test-runner /lav=
a-3808269/1
    2023-10-20T19:41:17.273085  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
