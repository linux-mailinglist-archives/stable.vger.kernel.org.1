Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6012478E119
	for <lists+stable@lfdr.de>; Wed, 30 Aug 2023 23:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240702AbjH3VBv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 30 Aug 2023 17:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbjH3VBv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 30 Aug 2023 17:01:51 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034C1E45
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 14:01:14 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c1e128135aso712595ad.3
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 14:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693429195; x=1694033995; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Snoc4ixs1gtff3BdEB9KCOZOSY26ER7oOWYbWHYAPjo=;
        b=cJ2QnPyKl2OBI5KsUlQFQuE6AzSUnbOI7OtIznoQiJhlfuSyg8+zMm1jjN14A+1QMB
         dxKypE5WuGmYjzHXgrDz/lknZEwEn/fWdnGkxud0STAkLTWagqTNNupyF1xRSk9qE0Ny
         5zcMS8qkXG+BNoeJoEXDtVGrr2+di/XzoaIVjiQ+70Zef6xMewfWWS5RJ+WBbgcFMGJE
         pE2UxdObPvWkP00CWbDA+QB/v7JcXxqB+aFpodT/L1AZS1L3nCLCNO8aJKm50+8WJWpU
         6aAi47YQ0gt7m2uoMEEhSA17vcvD7CD2XDWt1ZIBayJkF+T0xuSlmmAE1RSuAIFKiPGm
         U6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693429195; x=1694033995;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Snoc4ixs1gtff3BdEB9KCOZOSY26ER7oOWYbWHYAPjo=;
        b=lMmP1sG2mBjnv4nv1qCj/Pe1BsNaP9dfKtPteUWpBD+dmASE0jMEH8huPKd0aDYqBH
         QCx1/0epWhRIFAZYvLPzoMltGStQlNzYD/0PKNi6xXaSZBpkSEpNvZjp41twsItJi7b+
         nN6McBCSI1o2hy3PcLoHMjHhvZOAixZgvippkYaBWg3W5jg9ngnk8Aq49LPDvz8jiTyI
         ehD2h9WeubjK4UBHExrJ7iF2649pYfWfQRunQqiI1QQpsp6I+NHh9e1YmKg7oDrzLOpD
         nV7GHXttHu1t9VpBuRyZqHtirFxDoxhR+ckQ6yCknP/sGxtZSsCYtYaPKtWJLNiRcfel
         8kdw==
X-Gm-Message-State: AOJu0YyjWhRqTYrtfxi32BE40RB9JkmsQ1BgM7MZrBP/P1OA/XFQnjcD
        wovCkMXBzCkLjWtM9D784b9nC9T7x6UiK6jZ/EE=
X-Google-Smtp-Source: AGHT+IEuHVV3x78zWEjMoi2OWm71tBwjkqJ6cJRpbruFtGO1sF7BdaE4vVHLoR9SDIxct4HbLjnwxA==
X-Received: by 2002:a17:90a:49cf:b0:26f:b228:faea with SMTP id l15-20020a17090a49cf00b0026fb228faeamr3117182pjm.18.1693429194772;
        Wed, 30 Aug 2023 13:59:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s7-20020a17090a5d0700b0026b12768e46sm29577pji.42.2023.08.30.13.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 13:59:54 -0700 (PDT)
Message-ID: <64efadca.170a0220.d4150.00e2@mx.google.com>
Date:   Wed, 30 Aug 2023 13:59:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.293
Subject: stable/linux-4.19.y baseline: 101 runs, 36 regressions (v4.19.293)
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

stable/linux-4.19.y baseline: 101 runs, 36 regressions (v4.19.293)

Regressions Summary
-------------------

platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus  | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C523NA-A20057-coral   | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beaglebone-black           | arm    | lab-broonie     | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black           | arm    | lab-cip         | gcc-10   | multi_v7=
_defconfig           | 1          =

cubietruck                 | arm    | lab-baylibre    | gcc-10   | multi_v7=
_defconfig           | 1          =

imx6q-sabrelite            | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 1          =

imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | imx_v6_v=
7_defconfig          | 1          =

imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | multi_v7=
_defconfig           | 1          =

imx6ul-14x14-evk           | arm    | lab-nxp         | gcc-10   | multi_v7=
_defconfig           | 1          =

imx7d-sdb                  | arm    | lab-nxp         | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a7796-m3ulcb             | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

rk3288-veyron-jaq          | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 3          =

rk3399-gru-kevin           | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun50i-a64-pine64-plus     | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64         | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g                    | 1          =

zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-4.19.y/kernel=
/v4.19.293/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-4.19.y
  Describe: v4.19.293
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      c9852b4dedfce0212d9c06d0d43f04626c6938b1 =



Test Regressions
---------------- =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus  | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef7b6c2a982c3803286dbf

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef7b6c2a982c3803286dc8
        failing since 224 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-08-30T17:24:44.954260  + set +x<8>[   10.546356] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11385589_1.4.2.3.1>

    2023-08-30T17:24:44.954741  =


    2023-08-30T17:24:45.063018  =


    2023-08-30T17:24:45.165059  / # #export SHELL=3D/bin/sh

    2023-08-30T17:24:45.165843  =


    2023-08-30T17:24:45.267486  / # export SHELL=3D/bin/sh. /lava-11385589/=
environment

    2023-08-30T17:24:45.268275  =


    2023-08-30T17:24:45.369817  / # . /lava-11385589/environment/lava-11385=
589/bin/lava-test-runner /lava-11385589/1

    2023-08-30T17:24:45.370976  =


    2023-08-30T17:24:45.373232  / # /lava-11385589/bin/lava-test-runner /la=
va-11385589/1
 =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral   | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef7b66d0ad025335286d88

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef7b66d0ad025335286d91
        failing since 224 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-08-30T17:25:50.330411  + set +x

    2023-08-30T17:25:50.337268  <8>[   11.896504] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11385592_1.4.2.3.1>

    2023-08-30T17:25:50.443132  / # #

    2023-08-30T17:25:50.543760  export SHELL=3D/bin/sh

    2023-08-30T17:25:50.543981  #

    2023-08-30T17:25:50.644529  / # export SHELL=3D/bin/sh. /lava-11385592/=
environment

    2023-08-30T17:25:50.644742  =


    2023-08-30T17:25:50.745299  / # . /lava-11385592/environment/lava-11385=
592/bin/lava-test-runner /lava-11385592/1

    2023-08-30T17:25:50.745639  =


    2023-08-30T17:25:50.745745  / # /lava-11385592/bin/lava-test-runner /la=
va-11385592/1<4>[   12.296906] i2c_designware i2c_designware.5: timeout in =
disabling adapter
 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-broonie     | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef7d0ecd94d7eb89286d87

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef7d0ecd94d7eb89286db4
        failing since 224 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-08-30T17:31:16.084963  <8>[   15.221647] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 79607_1.5.2.4.1>
    2023-08-30T17:31:16.192617  / # #
    2023-08-30T17:31:16.295852  export SHELL=3D/bin/sh
    2023-08-30T17:31:16.296679  #
    2023-08-30T17:31:16.399046  / # export SHELL=3D/bin/sh. /lava-79607/env=
ironment
    2023-08-30T17:31:16.399787  =

    2023-08-30T17:31:16.502244  / # . /lava-79607/environment/lava-79607/bi=
n/lava-test-runner /lava-79607/1
    2023-08-30T17:31:16.503422  =

    2023-08-30T17:31:16.507656  / # /lava-79607/bin/lava-test-runner /lava-=
79607/1
    2023-08-30T17:31:16.575880  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-cip         | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef7e054aa07a6bec286d8a

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef7e054aa07a6bec286d8d
        failing since 224 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-08-30T17:35:14.420669  / # #
    2023-08-30T17:35:14.524401  export SHELL=3D/bin/sh
    2023-08-30T17:35:14.525428  #
    2023-08-30T17:35:14.627674  / # export SHELL=3D/bin/sh. /lava-1002975/e=
nvironment
    2023-08-30T17:35:14.628651  =

    2023-08-30T17:35:14.731108  / # . /lava-1002975/environment/lava-100297=
5/bin/lava-test-runner /lava-1002975/1
    2023-08-30T17:35:14.732815  =

    2023-08-30T17:35:14.743363  / # /lava-1002975/bin/lava-test-runner /lav=
a-1002975/1
    2023-08-30T17:35:14.842334  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-30T17:35:14.842913  + cd /lava-1002975/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
cubietruck                 | arm    | lab-baylibre    | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef7d13149bbb36c8286d86

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef7d13149bbb36c8286d8f
        failing since 224 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-08-30T17:31:39.489298  <8>[    7.317972] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3756556_1.5.2.4.1>
    2023-08-30T17:31:39.595837  / # #
    2023-08-30T17:31:39.697652  export SHELL=3D/bin/sh
    2023-08-30T17:31:39.698299  #
    2023-08-30T17:31:39.800092  / # export SHELL=3D/bin/sh. /lava-3756556/e=
nvironment
    2023-08-30T17:31:39.801309  =

    2023-08-30T17:31:39.903510  / # . /lava-3756556/environment/lava-375655=
6/bin/lava-test-runner /lava-3756556/1
    2023-08-30T17:31:39.904049  =

    2023-08-30T17:31:39.908884  / # /lava-3756556/bin/lava-test-runner /lav=
a-3756556/1
    2023-08-30T17:31:39.984424  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6q-sabrelite            | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef7ce5bec817feb7286d6d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef7ce5bec817feb7286d76
        failing since 224 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-08-30T17:31:16.944466  / # #

    2023-08-30T17:31:17.046556  export SHELL=3D/bin/sh

    2023-08-30T17:31:17.047247  #

    2023-08-30T17:31:17.148718  / # export SHELL=3D/bin/sh. /lava-11385649/=
environment

    2023-08-30T17:31:17.149406  =


    2023-08-30T17:31:17.250899  / # . /lava-11385649/environment/lava-11385=
649/bin/lava-test-runner /lava-11385649/1

    2023-08-30T17:31:17.251997  =


    2023-08-30T17:31:17.268715  / # /lava-11385649/bin/lava-test-runner /la=
va-11385649/1

    2023-08-30T17:31:17.359558  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-30T17:31:17.360051  + cd /lava-11385649/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef7b18610807c4be286d8d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboard-re=
vd1.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboard-re=
vd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef7b18610807c4be286d96
        failing since 224 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-08-30T17:23:25.399989  + set +x[    7.309823] <LAVA_SIGNAL_ENDRUN =
0_dmesg 999022_1.5.2.3.1>
    2023-08-30T17:23:25.400250  =

    2023-08-30T17:23:25.507373  / # #
    2023-08-30T17:23:25.609108  export SHELL=3D/bin/sh
    2023-08-30T17:23:25.609601  #
    2023-08-30T17:23:25.710941  / # export SHELL=3D/bin/sh. /lava-999022/en=
vironment
    2023-08-30T17:23:25.711440  =

    2023-08-30T17:23:25.812923  / # . /lava-999022/environment/lava-999022/=
bin/lava-test-runner /lava-999022/1
    2023-08-30T17:23:25.813553  =

    2023-08-30T17:23:25.816329  / # /lava-999022/bin/lava-test-runner /lava=
-999022/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef7cbe5225b634a0286d80

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboard-rev=
d1.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboard-rev=
d1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef7cbe5225b634a0286d89
        failing since 224 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-08-30T17:30:26.018039  + set +x
    2023-08-30T17:30:26.018278  [    4.944414] <LAVA_SIGNAL_ENDRUN 0_dmesg =
999026_1.5.2.3.1>
    2023-08-30T17:30:26.124596  / # #
    2023-08-30T17:30:26.226307  export SHELL=3D/bin/sh
    2023-08-30T17:30:26.226797  #
    2023-08-30T17:30:26.327949  / # export SHELL=3D/bin/sh. /lava-999026/en=
vironment
    2023-08-30T17:30:26.328418  =

    2023-08-30T17:30:26.429675  / # . /lava-999026/environment/lava-999026/=
bin/lava-test-runner /lava-999026/1
    2023-08-30T17:30:26.430378  =

    2023-08-30T17:30:26.432735  / # /lava-999026/bin/lava-test-runner /lava=
-999026/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6ul-14x14-evk           | arm    | lab-nxp         | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef7d1f85e3bec926286d72

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef7d1f85e3bec926286d75
        failing since 166 days (last pass: v4.19.260, first fail: v4.19.278)

    2023-08-30T17:31:51.241014  + set +x<8>[   23.139476] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1248079_1.5.2.4.1>
    2023-08-30T17:31:51.241311  =

    2023-08-30T17:31:51.351854  / # #
    2023-08-30T17:31:52.507798  export SHELL=3D/bin/sh
    2023-08-30T17:31:52.513388  #
    2023-08-30T17:31:54.055467  / # export SHELL=3D/bin/sh. /lava-1248079/e=
nvironment
    2023-08-30T17:31:54.061136  =

    2023-08-30T17:31:56.873143  / # . /lava-1248079/environment/lava-124807=
9/bin/lava-test-runner /lava-1248079/1
    2023-08-30T17:31:56.879186  =

    2023-08-30T17:31:56.880944  / # /lava-1248079/bin/lava-test-runner /lav=
a-1248079/1 =

    ... (15 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx7d-sdb                  | arm    | lab-nxp         | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef7d0bcd94d7eb89286d79

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef7d0bcd94d7eb89286d7c
        failing since 224 days (last pass: v4.19.267, first fail: v4.19.270)

    2023-08-30T17:31:30.600565  / # #
    2023-08-30T17:31:31.756885  export SHELL=3D/bin/sh
    2023-08-30T17:31:31.762553  #
    2023-08-30T17:31:33.304943  / # export SHELL=3D/bin/sh. /lava-1248078/e=
nvironment
    2023-08-30T17:31:33.310601  =

    2023-08-30T17:31:33.310898  / # . /lava-1248078/environment
    2023-08-30T17:31:36.122606  / # /lava-1248078/bin/lava-test-runner /lav=
a-1248078/1
    2023-08-30T17:31:36.139855  /lava-1248078/bin/lava-test-runner /lava-12=
48078/1
    2023-08-30T17:31:36.237905  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-30T17:31:36.238340  + cd /lava-1248078/1/tests/1_bootrr =

    ... (16 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef7e9b98e8cb1fe1286d73

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef7e9b98e8cb1fe1286=
d74
        failing since 359 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef7f8a0eed4cc6f8286d7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef7f8a0eed4cc6f8286=
d7b
        failing since 397 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef7d2d85e3bec926286d88

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef7d2d85e3bec926286=
d89
        failing since 359 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef7dff4aa07a6bec286d80

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef7dff4aa07a6bec286=
d81
        failing since 397 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef7f4ff2bf8fb254286d90

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef7f4ff2bf8fb254286=
d91
        failing since 359 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef7f9f8d26950b62286d82

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef7f9f8d26950b62286=
d83
        failing since 397 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef7d3785e3bec926286d9a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef7d3785e3bec926286=
d9b
        failing since 359 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef7e28a1c94b06d0286d6c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef7e28a1c94b06d0286=
d6d
        failing since 397 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef7e4b874c225224286d6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef7e4b874c225224286=
d6e
        failing since 359 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef7fdb04d7ef1316286d99

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef7fdb04d7ef1316286=
d9a
        failing since 397 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef7d181ad69e282b286d6c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef7d181ad69e282b286=
d6d
        failing since 359 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef7e6d510e159aac286d6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef7e6d510e159aac286=
d6e
        failing since 397 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef7e735ccae92044286d75

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef7e735ccae92044286=
d76
        failing since 359 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef8003ace74c92d9286d97

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef8003ace74c92d9286=
d98
        failing since 397 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef7d1985e3bec926286d6c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef7d1985e3bec926286=
d6d
        failing since 359 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef7e6e1743085838286d6e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef7e6e1743085838286=
d6f
        failing since 397 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
r8a7796-m3ulcb             | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef7baac7368cab01286d9c

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7796-m3ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7796-m3ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef7baac7368cab01286da5
        failing since 223 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-08-30T17:27:26.360019  / # #

    2023-08-30T17:27:26.462214  export SHELL=3D/bin/sh

    2023-08-30T17:27:26.462950  #

    2023-08-30T17:27:26.564309  / # export SHELL=3D/bin/sh. /lava-11385629/=
environment

    2023-08-30T17:27:26.565083  =


    2023-08-30T17:27:26.666456  / # . /lava-11385629/environment/lava-11385=
629/bin/lava-test-runner /lava-11385629/1

    2023-08-30T17:27:26.667570  =


    2023-08-30T17:27:26.684202  / # /lava-11385629/bin/lava-test-runner /la=
va-11385629/1

    2023-08-30T17:27:26.732944  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-30T17:27:26.733436  + cd /lav<8>[   13.402523] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11385629_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq          | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 3          =


  Details:     https://kernelci.org/test/plan/id/64ef7cd7c47eac878e286df3

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64ef7cd7c47eac878e286e27
        failing since 222 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-08-30T17:32:17.548151  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   11.042291] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-08-30T17:32:17.549955   multi-call binary.

    2023-08-30T17:32:17.550174  =


    2023-08-30T17:32:17.554478  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-08-30T17:32:17.554720  =


    2023-08-30T17:32:17.559849  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64ef7cd7c47eac878e286e28
        failing since 222 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-08-30T17:32:17.529367  <8>[   11.024761] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef7cd7c47eac878e286e3b
        failing since 222 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-08-30T17:32:13.702939  <8>[    7.198614] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-08-30T17:32:13.712247  + <8>[    7.210663] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11385646_1.5.2.3.1>

    2023-08-30T17:32:13.712945  set +x

    2023-08-30T17:32:13.818424  #

    2023-08-30T17:32:13.819471  =


    2023-08-30T17:32:13.921010  / # #export SHELL=3D/bin/sh

    2023-08-30T17:32:13.921782  =


    2023-08-30T17:32:14.022602  / # export SHELL=3D/bin/sh. /lava-11385646/=
environment

    2023-08-30T17:32:14.023248  =


    2023-08-30T17:32:14.124520  / # . /lava-11385646/environment/lava-11385=
646/bin/lava-test-runner /lava-11385646/1
 =

    ... (18 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
rk3399-gru-kevin           | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64ef7c917f09aa0bf3286dc3

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64ef7c917f09aa0bf3286dcd
        failing since 166 days (last pass: v4.19.277, first fail: v4.19.278)

    2023-08-30T17:30:00.491199  /lava-11385638/1/../bin/lava-test-case

    2023-08-30T17:30:00.499798  <8>[   37.261554] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64ef7c917f09aa0bf3286dce
        failing since 166 days (last pass: v4.19.277, first fail: v4.19.278)

    2023-08-30T17:29:59.465104  /lava-11385638/1/../bin/lava-test-case

    2023-08-30T17:29:59.474588  <8>[   36.236483] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus     | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef7bd285e36c77d2286d6f

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef7bd285e36c77d2286d99
        failing since 224 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-08-30T17:26:04.250076  <8>[   15.948023] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 79571_1.5.2.4.1>
    2023-08-30T17:26:04.357800  / # #
    2023-08-30T17:26:04.460738  export SHELL=3D/bin/sh
    2023-08-30T17:26:04.461461  #
    2023-08-30T17:26:04.563406  / # export SHELL=3D/bin/sh. /lava-79571/env=
ironment
    2023-08-30T17:26:04.564132  =

    2023-08-30T17:26:04.666493  / # . /lava-79571/environment/lava-79571/bi=
n/lava-test-runner /lava-79571/1
    2023-08-30T17:26:04.667678  =

    2023-08-30T17:26:04.672315  / # /lava-79571/bin/lava-test-runner /lava-=
79571/1
    2023-08-30T17:26:04.703804  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64         | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef7bbe6de23cdf22286db7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef7bbe6de23cdf22286dc0
        failing since 224 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-08-30T17:27:37.269362  / # #

    2023-08-30T17:27:37.371505  export SHELL=3D/bin/sh

    2023-08-30T17:27:37.372225  #

    2023-08-30T17:27:37.473701  / # export SHELL=3D/bin/sh. /lava-11385630/=
environment

    2023-08-30T17:27:37.474421  =


    2023-08-30T17:27:37.575865  / # . /lava-11385630/environment/lava-11385=
630/bin/lava-test-runner /lava-11385630/1

    2023-08-30T17:27:37.576989  =


    2023-08-30T17:27:37.593731  / # /lava-11385630/bin/lava-test-runner /la=
va-11385630/1

    2023-08-30T17:27:37.651781  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-30T17:27:37.652294  + cd /lava-1138563<8>[   15.626945] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11385630_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef7bb397f0e1d29e286da1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef7bb397f0e1d29e286da4
        failing since 224 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-08-30T17:25:47.405800  + set +x
    2023-08-30T17:25:47.406895  <8>[    3.741661] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1002965_1.5.2.4.1>
    2023-08-30T17:25:47.511794  / # #
    2023-08-30T17:25:47.613100  export SHELL=3D/bin/sh
    2023-08-30T17:25:47.613409  #
    2023-08-30T17:25:47.714385  / # export SHELL=3D/bin/sh. /lava-1002965/e=
nvironment
    2023-08-30T17:25:47.714649  =

    2023-08-30T17:25:47.815627  / # . /lava-1002965/environment/lava-100296=
5/bin/lava-test-runner /lava-1002965/1
    2023-08-30T17:25:47.816033  =

    2023-08-30T17:25:47.818865  / # /lava-1002965/bin/lava-test-runner /lav=
a-1002965/1 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef7c6611c93e4b15286d6c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.293/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef7c6611c93e4b15286d6f
        failing since 224 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-08-30T17:28:53.961477  <8>[    3.744986] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1002966_1.5.2.4.1>
    2023-08-30T17:28:54.067139  / # #
    2023-08-30T17:28:54.169002  export SHELL=3D/bin/sh
    2023-08-30T17:28:54.169438  #
    2023-08-30T17:28:54.270798  / # export SHELL=3D/bin/sh. /lava-1002966/e=
nvironment
    2023-08-30T17:28:54.271283  =

    2023-08-30T17:28:54.372725  / # . /lava-1002966/environment/lava-100296=
6/bin/lava-test-runner /lava-1002966/1
    2023-08-30T17:28:54.373479  =

    2023-08-30T17:28:54.375755  / # /lava-1002966/bin/lava-test-runner /lav=
a-1002966/1
    2023-08-30T17:28:54.412769  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
