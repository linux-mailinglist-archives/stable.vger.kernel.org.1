Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2749A7916E4
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 14:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbjIDMLZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 08:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjIDMLY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 08:11:24 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98378197
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 05:11:19 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bf6ea270b2so5065505ad.0
        for <stable@vger.kernel.org>; Mon, 04 Sep 2023 05:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693829478; x=1694434278; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wEdHwLwKiW8lLu8dPghToHO9/v8gffRBWA/R0eAesu0=;
        b=sbeqFW/+SeWUirC6Kp89LVT97KL+CcH1TbS3wrn8QDyvLUe4UmlVGHmvYdI7fjv/2X
         aCkGImhkV2M7sjXt4WJyR0MaUCHpca/qXdM6N/VYLZCM7b+ZcsfRYu+Jso74Wj/5wzPm
         FlY7dCAv2xjrYQ9EILd051HcmQmb9rI+gosUQTwjeuOTxe+N2nO87uOZSUqpeT9H6UAL
         XjQ4n61iG1ki6paUG0P8roAOXftkCzJbXqrGMDhl7DlWtBgX7uW+wcp6wOFF2bIIZxNI
         OaRpwFf+ohcd6iv48ZXoZlmb7SMxu+r1QNJFpUF4xF4YNjrMNq1NTDTlNGGMag3We9pC
         LK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693829478; x=1694434278;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wEdHwLwKiW8lLu8dPghToHO9/v8gffRBWA/R0eAesu0=;
        b=WuHggNnHthdxe8QY3rWx4TF8c74u0jRX5M8MfN3YtZL3ieNFi9udfv0kstbheAX3+M
         /7aM5MapNELoC/OOuJ7dOzUFIlDLGPBL8SDOndT1zHH9T/oQOr1qTb87m6eGM3dqKQVj
         G1Anf4C1c+gEKmoOh8+sfSE1xrUPe0s6IWBI/pDIa/XpLPq4RJVcB98Rz5FlKjxKUYD+
         sihA67VqO6wZ2q3zKerMFqL0/VOIH8DSSBwuoClK9W5QIdL8rz5VEUtQ7Bcizqxj6+rC
         gF3RgumUch7QseuGTiyh0lkwk+QWi/8WtmlOYiUlvNucEKbTjQUZmr+hakk4CZ0W/4Sx
         EnnA==
X-Gm-Message-State: AOJu0YzsGcuFZKKf8pQPpeEOGNJYfWA1UkemU2w/q2BvCw+936uIyHUQ
        QYKO+YuFytcirCb2FX2YYLjEUzo3axWZupxQqm0=
X-Google-Smtp-Source: AGHT+IFDVfJMMkVhKUYhvS9LQZO5NPinXoDlydKRdgLfBhspDCblhH0rMx8QCVz7U18arSzUg4HHPA==
X-Received: by 2002:a17:902:6a86:b0:1bf:3c10:1d72 with SMTP id n6-20020a1709026a8600b001bf3c101d72mr6761537plk.66.1693829478016;
        Mon, 04 Sep 2023 05:11:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902d48d00b001bd28b9c3ddsm7469198plg.299.2023.09.04.05.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 05:11:17 -0700 (PDT)
Message-ID: <64f5c965.170a0220.8b8d5.e8b9@mx.google.com>
Date:   Mon, 04 Sep 2023 05:11:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.194-24-g1be601d24d330
Subject: stable-rc/linux-5.10.y baseline: 126 runs,
 14 regressions (v5.10.194-24-g1be601d24d330)
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

stable-rc/linux-5.10.y baseline: 126 runs, 14 regressions (v5.10.194-24-g1b=
e601d24d330)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

meson-g12b-odroid-n2         | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.194-24-g1be601d24d330/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.194-24-g1be601d24d330
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      1be601d24d330a2c43ee62de09931f937d7f8549 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64f599a92d9d7a5cb0286e25

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-g1be601d24d330/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at=
91-sama5d4_xplained.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-g1be601d24d330/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at=
91-sama5d4_xplained.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f599a92d9d7a5cb0286=
e26
        new failure (last pass: v5.10.194) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64f598e09fcad6f7d3286d82

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-g1be601d24d330/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-g1be601d24d330/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f598e09fcad6f7d3286d87
        failing since 229 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-09-04T08:43:51.443983  <8>[   11.125865] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3762547_1.5.2.4.1>
    2023-09-04T08:43:51.550939  / # #
    2023-09-04T08:43:51.652152  export SHELL=3D/bin/sh
    2023-09-04T08:43:51.652512  #
    2023-09-04T08:43:51.753605  / # export SHELL=3D/bin/sh. /lava-3762547/e=
nvironment
    2023-09-04T08:43:51.753960  =

    2023-09-04T08:43:51.855059  / # . /lava-3762547/environment/lava-376254=
7/bin/lava-test-runner /lava-3762547/1
    2023-09-04T08:43:51.855591  =

    2023-09-04T08:43:51.855728  / # <3>[   11.451678] Bluetooth: hci0: comm=
and 0x0c03 tx timeout
    2023-09-04T08:43:51.860404  /lava-3762547/bin/lava-test-runner /lava-37=
62547/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f59824a41f73d195286d87

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-g1be601d24d330/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rd=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-g1be601d24d330/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rd=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f59824a41f73d195286d8a
        failing since 48 days (last pass: v5.10.142, first fail: v5.10.186-=
332-gf98a4d3a5cec)

    2023-09-04T08:40:41.615365  [    9.739984] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1249077_1.5.2.4.1>
    2023-09-04T08:40:41.720558  =

    2023-09-04T08:40:41.821715  / # #export SHELL=3D/bin/sh
    2023-09-04T08:40:41.822147  =

    2023-09-04T08:40:41.923089  / # export SHELL=3D/bin/sh. /lava-1249077/e=
nvironment
    2023-09-04T08:40:41.923540  =

    2023-09-04T08:40:42.024503  / # . /lava-1249077/environment/lava-124907=
7/bin/lava-test-runner /lava-1249077/1
    2023-09-04T08:40:42.025206  =

    2023-09-04T08:40:42.029545  / # /lava-1249077/bin/lava-test-runner /lav=
a-1249077/1
    2023-09-04T08:40:42.051885  + export 'TESTRUN_[   10.175364] <LAVA_SIGN=
AL_STARTRUN 1_bootrr 1249077_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f595e7d5f87ce937286daf

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-g1be601d24d330/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-g1be601d24d330/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f595e7d5f87ce937286db4
        failing since 159 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-09-04T08:31:28.049013  + <8>[   14.221127] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11428427_1.4.2.3.1>

    2023-09-04T08:31:28.049097  set +x

    2023-09-04T08:31:28.150442  =


    2023-09-04T08:31:28.251012  / # #export SHELL=3D/bin/sh

    2023-09-04T08:31:28.251164  =


    2023-09-04T08:31:28.351681  / # export SHELL=3D/bin/sh. /lava-11428427/=
environment

    2023-09-04T08:31:28.351825  =


    2023-09-04T08:31:28.452356  / # . /lava-11428427/environment/lava-11428=
427/bin/lava-test-runner /lava-11428427/1

    2023-09-04T08:31:28.452597  =


    2023-09-04T08:31:28.457043  / # /lava-11428427/bin/lava-test-runner /la=
va-11428427/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f595ec23b70bee3a286d6d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-g1be601d24d330/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-g1be601d24d330/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f595ec23b70bee3a286d72
        failing since 159 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-09-04T08:32:37.368435  + set +x

    2023-09-04T08:32:37.374830  <8>[   12.589556] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11428411_1.4.2.3.1>

    2023-09-04T08:32:37.476544  #

    2023-09-04T08:32:37.476825  =


    2023-09-04T08:32:37.577401  / # #export SHELL=3D/bin/sh

    2023-09-04T08:32:37.577609  =


    2023-09-04T08:32:37.678159  / # export SHELL=3D/bin/sh. /lava-11428411/=
environment

    2023-09-04T08:32:37.678376  =


    2023-09-04T08:32:37.778908  / # . /lava-11428411/environment/lava-11428=
411/bin/lava-test-runner /lava-11428411/1

    2023-09-04T08:32:37.779244  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f598608e06a091ef286d70

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-g1be601d24d330/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-g1be601d24d330/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f598608e06a091ef286da1
        failing since 3 days (last pass: v5.10.192-85-gc40f751018f92, first=
 fail: v5.10.193-12-ge25611a229ff9)

    2023-09-04T08:41:49.329986  <8>[   15.553585] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 85760_1.5.2.4.1>
    2023-09-04T08:41:49.438415  / # #
    2023-09-04T08:41:49.541200  export SHELL=3D/bin/sh
    2023-09-04T08:41:49.541962  #
    2023-09-04T08:41:49.643935  / # export SHELL=3D/bin/sh. /lava-85760/env=
ironment
    2023-09-04T08:41:49.644742  =

    2023-09-04T08:41:49.746732  / # . /lava-85760/environment/lava-85760/bi=
n/lava-test-runner /lava-85760/1
    2023-09-04T08:41:49.747998  =

    2023-09-04T08:41:49.762349  / # /lava-85760/bin/lava-test-runner /lava-=
85760/1
    2023-09-04T08:41:49.821182  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-g12b-odroid-n2         | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f598f29fcad6f7d3286d8f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-g1be601d24d330/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-g12=
b-odroid-n2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-g1be601d24d330/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-g12=
b-odroid-n2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f598f29fcad6f7d3286=
d90
        new failure (last pass: v5.10.194) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f598694aa90a8a97286d71

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-g1be601d24d330/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hihop=
e-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-g1be601d24d330/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hihop=
e-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f598694aa90a8a97286d74
        failing since 33 days (last pass: v5.10.186-10-g5f99a36aeb1c, first=
 fail: v5.10.188-107-gc262f74329e1)

    2023-09-04T08:41:56.273659  + set +x
    2023-09-04T08:41:56.274148  <8>[   84.063201] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1004752_1.5.2.4.1>
    2023-09-04T08:41:56.383357  / # #
    2023-09-04T08:41:57.848473  export SHELL=3D/bin/sh
    2023-09-04T08:41:57.869607  #
    2023-09-04T08:41:57.870130  / # export SHELL=3D/bin/sh
    2023-09-04T08:41:59.827233  / # . /lava-1004752/environment
    2023-09-04T08:42:03.437093  /lava-1004752/bin/lava-test-runner /lava-10=
04752/1
    2023-09-04T08:42:03.459073  . /lava-1004752/environment
    2023-09-04T08:42:03.459544  / # /lava-1004752/bin/lava-test-runner /lav=
a-1004752/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64f598bc6cfd63e579286df5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-g1be601d24d330/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-g1be601d24d330/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f598bc6cfd63e579286df8
        failing since 48 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-04T08:43:22.997007  + set +x
    2023-09-04T08:43:22.997174  <8>[   84.002962] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1004760_1.5.2.4.1>
    2023-09-04T08:43:23.099948  / # #
    2023-09-04T08:43:24.560084  export SHELL=3D/bin/sh
    2023-09-04T08:43:24.580520  #
    2023-09-04T08:43:24.580659  / # export SHELL=3D/bin/sh
    2023-09-04T08:43:26.533009  / # . /lava-1004760/environment
    2023-09-04T08:43:30.125584  /lava-1004760/bin/lava-test-runner /lava-10=
04760/1
    2023-09-04T08:43:30.146402  . /lava-1004760/environment
    2023-09-04T08:43:30.146540  / # /lava-1004760/bin/lava-test-runner /lav=
a-1004760/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64f59a88bbb547cec9286da6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-g1be601d24d330/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-g1be601d24d330/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f59a88bbb547cec9286da9
        failing since 48 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-04T08:51:00.832072  + set +x
    2023-09-04T08:51:00.832193  <8>[   84.219197] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1004762_1.5.2.4.1>
    2023-09-04T08:51:00.937957  / # #
    2023-09-04T08:51:02.397725  export SHELL=3D/bin/sh
    2023-09-04T08:51:02.418158  #
    2023-09-04T08:51:02.418310  / # export SHELL=3D/bin/sh
    2023-09-04T08:51:04.370982  / # . /lava-1004762/environment
    2023-09-04T08:51:07.963266  /lava-1004762/bin/lava-test-runner /lava-10=
04762/1
    2023-09-04T08:51:07.983912  . /lava-1004762/environment
    2023-09-04T08:51:07.984038  / # /lava-1004762/bin/lava-test-runner /lav=
a-1004762/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f59882ff556114a4286d7a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-g1be601d24d330/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-g1be601d24d330/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f59882ff556114a4286d7d
        failing since 48 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-04T08:42:08.546519  / # #
    2023-09-04T08:42:10.006686  export SHELL=3D/bin/sh
    2023-09-04T08:42:10.027148  #
    2023-09-04T08:42:10.027297  / # export SHELL=3D/bin/sh
    2023-09-04T08:42:11.980096  / # . /lava-1004754/environment
    2023-09-04T08:42:15.573069  /lava-1004754/bin/lava-test-runner /lava-10=
04754/1
    2023-09-04T08:42:15.593656  . /lava-1004754/environment
    2023-09-04T08:42:15.593763  / # /lava-1004754/bin/lava-test-runner /lav=
a-1004754/1
    2023-09-04T08:42:15.670721  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-04T08:42:15.670934  + cd /lava-1004754/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64f59970d02ab20b1a286d6c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-g1be601d24d330/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-g1be601d24d330/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f59970d02ab20b1a286d6f
        failing since 48 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-04T08:46:18.284795  / # #
    2023-09-04T08:46:19.744306  export SHELL=3D/bin/sh
    2023-09-04T08:46:19.764794  #
    2023-09-04T08:46:19.764974  / # export SHELL=3D/bin/sh
    2023-09-04T08:46:21.716995  / # . /lava-1004758/environment
    2023-09-04T08:46:25.308910  /lava-1004758/bin/lava-test-runner /lava-10=
04758/1
    2023-09-04T08:46:25.329693  . /lava-1004758/environment
    2023-09-04T08:46:25.329837  / # /lava-1004758/bin/lava-test-runner /lav=
a-1004758/1
    2023-09-04T08:46:25.406156  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-04T08:46:25.406381  + cd /lava-1004758/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f597eac6395c1d07286e40

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-g1be601d24d330/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-r=
ock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-g1be601d24d330/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-r=
ock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f597eac6395c1d07286e45
        failing since 10 days (last pass: v5.10.191, first fail: v5.10.190-=
136-gda59b7b5c515e)

    2023-09-04T08:40:01.038991  / # #

    2023-09-04T08:40:02.299536  export SHELL=3D/bin/sh

    2023-09-04T08:40:02.310453  #

    2023-09-04T08:40:02.310913  / # export SHELL=3D/bin/sh

    2023-09-04T08:40:04.054213  / # . /lava-11428458/environment

    2023-09-04T08:40:07.258459  /lava-11428458/bin/lava-test-runner /lava-1=
1428458/1

    2023-09-04T08:40:07.269854  . /lava-11428458/environment

    2023-09-04T08:40:07.272920  / # /lava-11428458/bin/lava-test-runner /la=
va-11428458/1

    2023-09-04T08:40:07.324655  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-04T08:40:07.325139  + cd /lava-11428458/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f597c5f628bcc4c8286dca

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-g1be601d24d330/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-g1be601d24d330/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f597c5f628bcc4c8286dcf
        failing since 48 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-04T08:40:59.323206  / # #

    2023-09-04T08:40:59.425242  export SHELL=3D/bin/sh

    2023-09-04T08:40:59.425947  #

    2023-09-04T08:40:59.527332  / # export SHELL=3D/bin/sh. /lava-11428463/=
environment

    2023-09-04T08:40:59.528041  =


    2023-09-04T08:40:59.629436  / # . /lava-11428463/environment/lava-11428=
463/bin/lava-test-runner /lava-11428463/1

    2023-09-04T08:40:59.630516  =


    2023-09-04T08:40:59.647448  / # /lava-11428463/bin/lava-test-runner /la=
va-11428463/1

    2023-09-04T08:40:59.689470  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-04T08:40:59.705278  + cd /lava-1142846<8>[   18.167079] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11428463_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
