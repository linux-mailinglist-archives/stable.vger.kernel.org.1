Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB567907C5
	for <lists+stable@lfdr.de>; Sat,  2 Sep 2023 14:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjIBMHq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 2 Sep 2023 08:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjIBMHp (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 2 Sep 2023 08:07:45 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8119AF
        for <stable@vger.kernel.org>; Sat,  2 Sep 2023 05:07:38 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68c576d35feso2468850b3a.2
        for <stable@vger.kernel.org>; Sat, 02 Sep 2023 05:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693656458; x=1694261258; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AFcRhAsY0w5zUoRjmNRyB7wb56WLH7V2dzQVsSjO0TM=;
        b=xJDfjgESqVEYOrL5yBocoyWVt/gcraUlkgGWXZsSHQB5ckQe+JdD4PQElvtKzcpTpi
         Tgmf/njMnfNozJvlmM6L9I9DcL4jlHBN0z42JCCuvbJNmtOFU8RA2ynKrdJwfn27G87c
         +Ie9FrCNsEozx8vl+PJaxiQdP6WfT7ZAswcgj11KvHc8FQ+TkFCEAmIG+6fZb0oN7FNY
         7RiKK/t3ZCGfkRsYNj/KKEOD54PJHs/SToNzIcUhRmGQ2mZ492QIQjCt92qO6Nht22Db
         6MuCWHYRzc+mxWEqUzdWM9HKb/fZLsxF2w0/fS07A8zHTHUcog6+s3Qq1w1BuYPrAs6y
         DLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693656458; x=1694261258;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFcRhAsY0w5zUoRjmNRyB7wb56WLH7V2dzQVsSjO0TM=;
        b=UbMRQdPsDFPowZ2pJmwLLOi96MWmVBME/xU9vSXtUp7/BRgv4OFk6tvEbUkdOKTshm
         76UYT4NZIBJQW39pbxCI61z4MJzzA5EWqxdIV+zMyFM2tU6cytVYkF7bSk4tGOEvpRfV
         0JwWavuR+TZF1+Fkk8Tt7L4IzWEli94U4u2JyxquA2Md5heUmYVdU4NpSG971Stebl9/
         pXwp8bGU89m+89KqI9bpK3XvMSfrwKymV07TGwVg2eEDnVfkGoB1zlLhT3OCIOsG+81E
         J0tdbw5rwunvxaob21BL48KmZylUrQBCT98EhT6y+dP8Otl5RfYMe9S4EDBWkJy7Krrf
         /Rxg==
X-Gm-Message-State: AOJu0YxEifjaqW7yoiJyuiwxUJgUqnU9m7NojyDPLv1DqQX+RuuAWOlg
        1so+eaS/B0BdIBF9Rs44JdRTiRJYLjFLyJbbO+o=
X-Google-Smtp-Source: AGHT+IEKJaTu2Cof9pUI1/Nkiz94HfOjt0BDHGzyrkPo20vKG1RGFWpqHgxfv0xn0SdXEjCVx8vDrw==
X-Received: by 2002:a05:6a00:398a:b0:68a:3b39:a486 with SMTP id fi10-20020a056a00398a00b0068a3b39a486mr5518600pfb.24.1693656456738;
        Sat, 02 Sep 2023 05:07:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g13-20020aa7818d000000b00687260020b1sm4435217pfi.72.2023.09.02.05.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 05:07:36 -0700 (PDT)
Message-ID: <64f32588.a70a0220.16fdb.90a8@mx.google.com>
Date:   Sat, 02 Sep 2023 05:07:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.294
Subject: stable/linux-4.19.y baseline: 100 runs, 37 regressions (v4.19.294)
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

stable/linux-4.19.y baseline: 100 runs, 37 regressions (v4.19.294)

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

at91sam9g20ek              | arm    | lab-broonie     | gcc-10   | multi_v5=
_defconfig           | 1          =

beaglebone-black           | arm    | lab-broonie     | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black           | arm    | lab-cip         | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black           | arm    | lab-broonie     | gcc-10   | omap2plu=
s_defconfig          | 1          =

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
/v4.19.294/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-4.19.y
  Describe: v4.19.294
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      dd5638bc06a6bf3f5ca1a134960911dc49484386 =



Test Regressions
---------------- =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus  | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f45b05c73a5d44286dc1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2f45b05c73a5d44286dca
        failing since 226 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-09-02T08:37:41.079264  + set +x

    2023-09-02T08:37:41.085986  <8>[   10.166497] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11409708_1.4.2.3.1>

    2023-09-02T08:37:41.190281  / # #

    2023-09-02T08:37:41.290983  export SHELL=3D/bin/sh

    2023-09-02T08:37:41.291158  #

    2023-09-02T08:37:41.391746  / # export SHELL=3D/bin/sh. /lava-11409708/=
environment

    2023-09-02T08:37:41.391893  =


    2023-09-02T08:37:41.492388  / # . /lava-11409708/environment/lava-11409=
708/bin/lava-test-runner /lava-11409708/1

    2023-09-02T08:37:41.492694  =


    2023-09-02T08:37:41.497673  / # /lava-11409708/bin/lava-test-runner /la=
va-11409708/1
 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral   | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f4a7557ae8cad3286e67

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2f4a7557ae8cad3286e70
        failing since 226 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-09-02T08:38:49.860640  <8>[   12.113325] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-09-02T08:38:49.862275  + set +x

    2023-09-02T08:38:49.868926  <8>[   12.123750] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11409728_1.4.2.3.1>

    2023-09-02T08:38:49.973432  / # #

    2023-09-02T08:38:50.074090  export SHELL=3D/bin/sh

    2023-09-02T08:38:50.074276  #

    2023-09-02T08:38:50.174802  / # export SHELL=3D/bin/sh. /lava-11409728/=
environment

    2023-09-02T08:38:50.174991  =


    2023-09-02T08:38:50.275478  / # . /lava-11409728/environment/lava-11409=
728/bin/lava-test-runner /lava-11409728/1

    2023-09-02T08:38:50.275791  =

 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
at91sam9g20ek              | arm    | lab-broonie     | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f317038d9312dc286d7f

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2f317038d9312dc286db5
        new failure (last pass: v4.19.292)

    2023-09-02T08:31:45.450781  + set +x
    2023-09-02T08:31:45.451280  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 83592_1.5.2.=
4.1>
    2023-09-02T08:31:45.563864  / # #
    2023-09-02T08:31:45.666760  export SHELL=3D/bin/sh
    2023-09-02T08:31:45.667508  #
    2023-09-02T08:31:45.769453  / # export SHELL=3D/bin/sh. /lava-83592/env=
ironment
    2023-09-02T08:31:45.770243  =

    2023-09-02T08:31:45.872163  / # . /lava-83592/environment/lava-83592/bi=
n/lava-test-runner /lava-83592/1
    2023-09-02T08:31:45.873432  =

    2023-09-02T08:31:45.877048  / # /lava-83592/bin/lava-test-runner /lava-=
83592/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-broonie     | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f4cb0aa19181ce286d86

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2f4cb0aa19181ce286db5
        failing since 226 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-09-02T08:38:58.323936  <8>[   16.676885] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 83651_1.5.2.4.1>
    2023-09-02T08:38:58.432265  / # #
    2023-09-02T08:38:58.534294  export SHELL=3D/bin/sh
    2023-09-02T08:38:58.534847  #
    2023-09-02T08:38:58.636425  / # export SHELL=3D/bin/sh. /lava-83651/env=
ironment
    2023-09-02T08:38:58.636967  =

    2023-09-02T08:38:58.738356  / # . /lava-83651/environment/lava-83651/bi=
n/lava-test-runner /lava-83651/1
    2023-09-02T08:38:58.739213  =

    2023-09-02T08:38:58.742720  / # /lava-83651/bin/lava-test-runner /lava-=
83651/1
    2023-09-02T08:38:58.810481  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-cip         | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f611c09a038d15286d71

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2f611c09a038d15286d74
        failing since 226 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-09-02T08:44:28.395723  + set +x
    2023-09-02T08:44:28.397928  <8>[    9.865108] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1004101_1.5.2.4.1>
    2023-09-02T08:44:28.504433  / # #
    2023-09-02T08:44:28.605613  export SHELL=3D/bin/sh
    2023-09-02T08:44:28.605875  #
    2023-09-02T08:44:28.706893  / # export SHELL=3D/bin/sh. /lava-1004101/e=
nvironment
    2023-09-02T08:44:28.707218  =

    2023-09-02T08:44:28.808262  / # . /lava-1004101/environment/lava-100410=
1/bin/lava-test-runner /lava-1004101/1
    2023-09-02T08:44:28.808691  =

    2023-09-02T08:44:28.810240  / # /lava-1004101/bin/lava-test-runner /lav=
a-1004101/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-broonie     | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f4d90aa19181ce286df3

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2f4d90aa19181ce286e29
        new failure (last pass: v4.19.293)

    2023-09-02T08:39:20.473819  + set +x
    2023-09-02T08:39:20.477935  <8>[   22.460915] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 83640_1.5.2.4.1>
    2023-09-02T08:39:20.590422  / # #
    2023-09-02T08:39:20.693410  export SHELL=3D/bin/sh
    2023-09-02T08:39:20.694158  #
    2023-09-02T08:39:20.796525  / # export SHELL=3D/bin/sh. /lava-83640/env=
ironment
    2023-09-02T08:39:20.797276  =

    2023-09-02T08:39:20.899462  / # . /lava-83640/environment/lava-83640/bi=
n/lava-test-runner /lava-83640/1
    2023-09-02T08:39:20.901067  =

    2023-09-02T08:39:20.905311  / # /lava-83640/bin/lava-test-runner /lava-=
83640/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
cubietruck                 | arm    | lab-baylibre    | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f4bf331938bdac286d7e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2f4bf331938bdac286d87
        failing since 226 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-09-02T08:39:18.089975  + set +x<8>[    7.340265] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3760317_1.5.2.4.1>
    2023-09-02T08:39:18.090665  =

    2023-09-02T08:39:18.201420  / # #
    2023-09-02T08:39:18.305084  export SHELL=3D/bin/sh
    2023-09-02T08:39:18.306154  #
    2023-09-02T08:39:18.408468  / # export SHELL=3D/bin/sh. /lava-3760317/e=
nvironment
    2023-09-02T08:39:18.409727  =

    2023-09-02T08:39:18.512303  / # . /lava-3760317/environment/lava-376031=
7/bin/lava-test-runner /lava-3760317/1
    2023-09-02T08:39:18.514173  =

    2023-09-02T08:39:18.520156  / # /lava-3760317/bin/lava-test-runner /lav=
a-3760317/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6q-sabrelite            | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f49c4eb3b915da286dd2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2f49c4eb3b915da286ddb
        failing since 226 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-09-02T08:38:52.866933  / # #

    2023-09-02T08:38:52.969082  export SHELL=3D/bin/sh

    2023-09-02T08:38:52.969748  #

    2023-09-02T08:38:53.071172  / # export SHELL=3D/bin/sh. /lava-11409743/=
environment

    2023-09-02T08:38:53.071871  =


    2023-09-02T08:38:53.173361  / # . /lava-11409743/environment/lava-11409=
743/bin/lava-test-runner /lava-11409743/1

    2023-09-02T08:38:53.174478  =


    2023-09-02T08:38:53.175292  / # /lava-11409743/bin/lava-test-runner /la=
va-11409743/1

    2023-09-02T08:38:53.281381  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-02T08:38:53.281876  + cd /lava-11409743/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f29414acc0ac1a286d6c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboard-re=
vd1.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboard-re=
vd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2f29414acc0ac1a286d75
        failing since 226 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-09-02T08:30:00.083765  + set +x[    7.385262] <LAVA_SIGNAL_ENDRUN =
0_dmesg 999313_1.5.2.3.1>
    2023-09-02T08:30:00.084058  =

    2023-09-02T08:30:00.191896  / # #
    2023-09-02T08:30:00.293616  export SHELL=3D/bin/sh
    2023-09-02T08:30:00.294118  #
    2023-09-02T08:30:00.395456  / # export SHELL=3D/bin/sh. /lava-999313/en=
vironment
    2023-09-02T08:30:00.395988  =

    2023-09-02T08:30:00.497262  / # . /lava-999313/environment/lava-999313/=
bin/lava-test-runner /lava-999313/1
    2023-09-02T08:30:00.497943  =

    2023-09-02T08:30:00.500737  / # /lava-999313/bin/lava-test-runner /lava=
-999313/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f475d7178dd910286db6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboard-rev=
d1.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboard-rev=
d1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2f475d7178dd910286dbf
        failing since 226 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-09-02T08:38:00.960613  + set +x
    2023-09-02T08:38:00.960805  [    4.879016] <LAVA_SIGNAL_ENDRUN 0_dmesg =
999316_1.5.2.3.1>
    2023-09-02T08:38:01.066718  / # #
    2023-09-02T08:38:01.168342  export SHELL=3D/bin/sh
    2023-09-02T08:38:01.168884  #
    2023-09-02T08:38:01.270237  / # export SHELL=3D/bin/sh. /lava-999316/en=
vironment
    2023-09-02T08:38:01.270696  =

    2023-09-02T08:38:01.372005  / # . /lava-999316/environment/lava-999316/=
bin/lava-test-runner /lava-999316/1
    2023-09-02T08:38:01.372666  =

    2023-09-02T08:38:01.374824  / # /lava-999316/bin/lava-test-runner /lava=
-999316/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6ul-14x14-evk           | arm    | lab-nxp         | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f4c4331938bdac286d8a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2f4c4331938bdac286d8d
        failing since 168 days (last pass: v4.19.260, first fail: v4.19.278)

    2023-09-02T08:39:04.308996  + set +x<8>[   22.980944] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1248842_1.5.2.4.1>
    2023-09-02T08:39:04.309289  =

    2023-09-02T08:39:04.420102  / # #
    2023-09-02T08:39:05.576136  export SHELL=3D/bin/sh
    2023-09-02T08:39:05.581779  #
    2023-09-02T08:39:07.123839  / # export SHELL=3D/bin/sh. /lava-1248842/e=
nvironment
    2023-09-02T08:39:07.129492  =

    2023-09-02T08:39:09.941634  / # . /lava-1248842/environment/lava-124884=
2/bin/lava-test-runner /lava-1248842/1
    2023-09-02T08:39:09.947676  =

    2023-09-02T08:39:09.949332  / # /lava-1248842/bin/lava-test-runner /lav=
a-1248842/1 =

    ... (15 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx7d-sdb                  | arm    | lab-nxp         | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f4c6331938bdac286d95

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2f4c6331938bdac286d98
        failing since 226 days (last pass: v4.19.267, first fail: v4.19.270)

    2023-09-02T08:39:01.216342  / # #
    2023-09-02T08:39:02.372336  export SHELL=3D/bin/sh
    2023-09-02T08:39:02.377968  #
    2023-09-02T08:39:03.920266  / # export SHELL=3D/bin/sh. /lava-1248843/e=
nvironment
    2023-09-02T08:39:03.925922  =

    2023-09-02T08:39:06.737885  / # . /lava-1248843/environment/lava-124884=
3/bin/lava-test-runner /lava-1248843/1
    2023-09-02T08:39:06.743937  =

    2023-09-02T08:39:06.757780  / # /lava-1248843/bin/lava-test-runner /lav=
a-1248843/1
    2023-09-02T08:39:06.851693  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-02T08:39:06.852085  + cd /lava-1248843/1/tests/1_bootrr =

    ... (16 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f5558d9af1081e286e23

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f2f5558d9af1081e286=
e24
        failing since 361 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f7001554915cc1286d7c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f2f7001554915cc1286=
d7d
        failing since 399 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f50d489288244d286dc0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f2f50d489288244d286=
dc1
        failing since 361 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f66241d032f082286dab

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f2f66241d032f082286=
dac
        failing since 399 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f519489288244d286e09

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f2f519489288244d286=
e0a
        failing since 477 days (last pass: v4.19.239, first fail: v4.19.242=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f6bd5b83e0ef31286e13

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f2f6bd5b83e0ef31286=
e14
        failing since 399 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f51e489288244d286e17

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f2f51e489288244d286=
e18
        failing since 477 days (last pass: v4.19.239, first fail: v4.19.242=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f5ae9c764d6281286d9a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f2f5ae9c764d6281286=
d9b
        failing since 399 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f598bb0dfb925a286d8b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f2f598bb0dfb925a286=
d8c
        failing since 361 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f6d248b99a4681286dc3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f2f6d248b99a4681286=
dc4
        failing since 399 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f520489288244d286e38

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f2f520489288244d286=
e39
        failing since 361 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f5ffd502e60c5b286d74

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f2f5ffd502e60c5b286=
d75
        failing since 399 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f52d8d9af1081e286d7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f2f52d8d9af1081e286=
d7b
        failing since 361 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f6bf48b99a4681286db1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f2f6bf48b99a4681286=
db2
        failing since 399 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f51f0c2ca24c57286d8c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f2f51f0c2ca24c57286=
d8d
        failing since 361 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f5fed502e60c5b286d71

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f2f5fed502e60c5b286=
d72
        failing since 399 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq          | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 3          =


  Details:     https://kernelci.org/test/plan/id/64f2f4a4557ae8cad3286e12

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64f2f4a4557ae8cad3286e46
        failing since 225 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-09-02T08:40:13.113507  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   10.093236] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-09-02T08:40:13.115525   multi-call binary.

    2023-09-02T08:40:13.115748  =


    2023-09-02T08:40:13.119945  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-09-02T08:40:13.120169  =


    2023-09-02T08:40:13.125338  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64f2f4a4557ae8cad3286e47
        failing since 225 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-09-02T08:40:13.094651  <8>[   10.075541] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2f4a4557ae8cad3286e5a
        failing since 225 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-09-02T08:40:09.263279  <8>[    6.244407] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-09-02T08:40:09.272487  + <8>[    6.256542] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11409746_1.5.2.3.1>

    2023-09-02T08:40:09.273060  set +x

    2023-09-02T08:40:09.378721  #

    2023-09-02T08:40:09.379799  =


    2023-09-02T08:40:09.481375  / # #export SHELL=3D/bin/sh

    2023-09-02T08:40:09.482073  =


    2023-09-02T08:40:09.583415  / # export SHELL=3D/bin/sh. /lava-11409746/=
environment

    2023-09-02T08:40:09.584121  =


    2023-09-02T08:40:09.685668  / # . /lava-11409746/environment/lava-11409=
746/bin/lava-test-runner /lava-11409746/1
 =

    ... (18 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
rk3399-gru-kevin           | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64f2f48fed51fc32d0286d74

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64f2f48fed51fc32d0286d7e
        failing since 168 days (last pass: v4.19.277, first fail: v4.19.278)

    2023-09-02T08:38:40.805476  /lava-11409703/1/../bin/lava-test-case

    2023-09-02T08:38:40.814190  <8>[   37.405224] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64f2f48fed51fc32d0286d7f
        failing since 168 days (last pass: v4.19.277, first fail: v4.19.278)

    2023-09-02T08:38:39.780268  /lava-11409703/1/../bin/lava-test-case

    2023-09-02T08:38:39.789017  <8>[   36.380491] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus     | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f428e4ee44113b286d82

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2f428e4ee44113b286dac
        failing since 226 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-09-02T08:36:19.537568  <8>[   16.002141] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 83617_1.5.2.4.1>
    2023-09-02T08:36:19.644896  / # #
    2023-09-02T08:36:19.747679  export SHELL=3D/bin/sh
    2023-09-02T08:36:19.748401  #
    2023-09-02T08:36:19.850660  / # export SHELL=3D/bin/sh. /lava-83617/env=
ironment
    2023-09-02T08:36:19.851285  =

    2023-09-02T08:36:19.953399  / # . /lava-83617/environment/lava-83617/bi=
n/lava-test-runner /lava-83617/1
    2023-09-02T08:36:19.954440  =

    2023-09-02T08:36:19.959281  / # /lava-83617/bin/lava-test-runner /lava-=
83617/1
    2023-09-02T08:36:19.990719  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64         | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f42d2976b67086286d6c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2f42d2976b67086286d75
        failing since 226 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-09-02T08:38:15.155886  / # #

    2023-09-02T08:38:15.258064  export SHELL=3D/bin/sh

    2023-09-02T08:38:15.258772  #

    2023-09-02T08:38:15.360195  / # export SHELL=3D/bin/sh. /lava-11409622/=
environment

    2023-09-02T08:38:15.360942  =


    2023-09-02T08:38:15.462391  / # . /lava-11409622/environment/lava-11409=
622/bin/lava-test-runner /lava-11409622/1

    2023-09-02T08:38:15.463384  =


    2023-09-02T08:38:15.480052  / # /lava-11409622/bin/lava-test-runner /la=
va-11409622/1

    2023-09-02T08:38:15.538193  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-02T08:38:15.538699  + cd /lava-1140962<8>[   15.634123] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11409622_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f41db7fff60188286d71

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2f41db7fff60188286d74
        failing since 226 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-09-02T08:36:30.569505  + set +x
    2023-09-02T08:36:30.570524  <8>[    3.734832] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1004084_1.5.2.4.1>
    2023-09-02T08:36:30.673462  / # #
    2023-09-02T08:36:30.774745  export SHELL=3D/bin/sh
    2023-09-02T08:36:30.775056  #
    2023-09-02T08:36:30.876059  / # export SHELL=3D/bin/sh. /lava-1004084/e=
nvironment
    2023-09-02T08:36:30.876391  =

    2023-09-02T08:36:30.977415  / # . /lava-1004084/environment/lava-100408=
4/bin/lava-test-runner /lava-1004084/1
    2023-09-02T08:36:30.977862  =

    2023-09-02T08:36:30.980433  / # /lava-1004084/bin/lava-test-runner /lav=
a-1004084/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f7b5d821b8f0a4286da5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.294/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2f7b5d821b8f0a4286da8
        failing since 226 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-09-02T08:51:48.577878  <8>[    3.726915] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1004090_1.5.2.4.1>
    2023-09-02T08:51:48.683204  / # #
    2023-09-02T08:51:48.785032  export SHELL=3D/bin/sh
    2023-09-02T08:51:48.785545  #
    2023-09-02T08:51:48.886783  / # export SHELL=3D/bin/sh. /lava-1004090/e=
nvironment
    2023-09-02T08:51:48.887356  =

    2023-09-02T08:51:48.988593  / # . /lava-1004090/environment/lava-100409=
0/bin/lava-test-runner /lava-1004090/1
    2023-09-02T08:51:48.989351  =

    2023-09-02T08:51:48.991213  / # /lava-1004090/bin/lava-test-runner /lav=
a-1004090/1
    2023-09-02T08:51:49.029278  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
