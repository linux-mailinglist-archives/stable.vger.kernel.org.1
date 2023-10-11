Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78EC7C4742
	for <lists+stable@lfdr.de>; Wed, 11 Oct 2023 03:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344546AbjJKB3s (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 10 Oct 2023 21:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344484AbjJKB3r (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Oct 2023 21:29:47 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDFF8F
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 18:29:42 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-27758c8f579so3951513a91.0
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 18:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696987782; x=1697592582; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cLHAiKyW7zP/jQ9sMb+MxHP2RY0BilTeZtC6oFBNFPg=;
        b=vK85F93iKJgcp+A7DII/hoci5zyEdiWOKhS8IYGf+hLtoSnEHFrPpBs/kLeHut/UuM
         lGhn5EQYV3WYTTRVfP/sWAJSSQJucxXETYUfGCVB91T2pVB9t295emQqeH7IW6UgiDAU
         q/Zd92IqE4N/piTckkCkFGWK8Wbm8KF4o6dmxGAmO8pJahEsWhEoifva1DUfL1A0XR95
         6sEL8iTRF3427M/ZqkD21YpkcMjbvMafz7ixA2t5wY5jlD2asRo9lotXm6079z+lxfuq
         IDufJP6/xxpioPoQzgVqxD/Be5E233LZJkJCNzDgBhcIgrG+UDWmvll1IDUP249WuxrE
         7CTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696987782; x=1697592582;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cLHAiKyW7zP/jQ9sMb+MxHP2RY0BilTeZtC6oFBNFPg=;
        b=eE6q8BBYS4CsdQYU6ASamhmicEdFckci25NOUvhJrJBWqfdd8RFyGR/MrTf340Yg8J
         xl/lFo9z2kZFZCv77i9dGIZq23JUTXjjna48k5K6R9lPf0PRWOdPa7zzcWdHaxDOH1s1
         dXy+yqdCnydr0FgoK1ZF+2sEVRtX/r1+6DgkuuIVKVm68di+1Dui5DP3WUa5OWRLg6ty
         ccyzRP6UIBcyTJUnOkEp88OZgTPT+tX71Ho/hkNB96ydo4JO59ZbO2bxqdXXQjH4MeD4
         fPQiOaMFWrjSCP9rYFAsrQwDKvKIbF8Q5yYAVyJiXqAqz3G+MMvkVbEAKgaWsitwEuVd
         qj+w==
X-Gm-Message-State: AOJu0YyS3FDqzfBDXpF1X+vYs6rX556dVZt6i3U/qgeSkapvCo8ksv6/
        Z0yiZ/AvYGprcZxa0IY4iaOFNhfKo1zoA6SHn79Hhw==
X-Google-Smtp-Source: AGHT+IEw6zhZO+5qlW9YSfeY5eshU2obgySz5Nq4tXd8W644D6pHyWZBSMUopZsHaPqPqugM7828Tw==
X-Received: by 2002:a17:90a:b387:b0:274:4e9b:7a1a with SMTP id e7-20020a17090ab38700b002744e9b7a1amr16566193pjr.44.1696987780963;
        Tue, 10 Oct 2023 18:29:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w23-20020a17090a029700b0026801e06ac1sm11760252pja.30.2023.10.10.18.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 18:29:39 -0700 (PDT)
Message-ID: <6525fa83.170a0220.e8843.2ff0@mx.google.com>
Date:   Tue, 10 Oct 2023 18:29:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.296
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable
Subject: stable/linux-4.19.y baseline: 126 runs, 59 regressions (v4.19.296)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-4.19.y baseline: 126 runs, 59 regressions (v4.19.296)

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

qemu_arm-vexpress-a15      | arm    | lab-baylibre    | gcc-10   | vexpress=
_defconfig           | 1          =

qemu_arm-vexpress-a9       | arm    | lab-baylibre    | gcc-10   | vexpress=
_defconfig           | 1          =

qemu_arm-virt-gicv2        | arm    | lab-baylibre    | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm-virt-gicv2-uefi   | arm    | lab-baylibre    | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm-virt-gicv3        | arm    | lab-baylibre    | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm-virt-gicv3-uefi   | arm    | lab-baylibre    | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-baylibre    | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-baylibre    | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-baylibre    | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-baylibre    | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-baylibre    | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-baylibre    | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-baylibre    | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-baylibre    | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

qemu_i386                  | i386   | lab-baylibre    | gcc-10   | i386_def=
config               | 1          =

qemu_i386-uefi             | i386   | lab-baylibre    | gcc-10   | i386_def=
config               | 1          =

qemu_x86_64                | x86_64 | lab-baylibre    | gcc-10   | x86_64_d=
efconfig             | 1          =

qemu_x86_64                | x86_64 | lab-baylibre    | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

qemu_x86_64-uefi           | x86_64 | lab-baylibre    | gcc-10   | x86_64_d=
efconfig             | 1          =

qemu_x86_64-uefi           | x86_64 | lab-baylibre    | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a7796-m3ulcb             | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

rk3288-veyron-jaq          | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 3          =

rk3399-gru-kevin           | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun50i-a64-pine64-plus     | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64         | arm64  | lab-clabbe      | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64         | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

sun8i-a33-olinuxino        | arm    | lab-clabbe      | gcc-10   | multi_v7=
_defconfig           | 1          =

sun8i-a83t-bananapi-m3     | arm    | lab-clabbe      | gcc-10   | multi_v7=
_defconfig           | 1          =

sun8i-h3-orangepi-pc       | arm    | lab-clabbe      | gcc-10   | multi_v7=
_defconfig           | 1          =

zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-4.19.y/kernel=
/v4.19.296/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-4.19.y
  Describe: v4.19.296
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      1b540579cf668bd805cdcca5285f579dcf6e4312 =



Test Regressions
---------------- =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus  | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c8036caed70fdfefcf4d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525c8036caed70fdfefcf56
        failing since 265 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-10-10T21:55:21.030392  + set<8>[   11.496365] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11729890_1.4.2.3.1>

    2023-10-10T21:55:21.030508   +x

    2023-10-10T21:55:21.132503  #

    2023-10-10T21:55:21.233267  / # #export SHELL=3D/bin/sh

    2023-10-10T21:55:21.233468  =


    2023-10-10T21:55:21.333942  / # export SHELL=3D/bin/sh. /lava-11729890/=
environment

    2023-10-10T21:55:21.334141  =


    2023-10-10T21:55:21.434656  / # . /lava-11729890/environment/lava-11729=
890/bin/lava-test-runner /lava-11729890/1

    2023-10-10T21:55:21.434944  =


    2023-10-10T21:55:21.439666  / # /lava-11729890/bin/lava-test-runner /la=
va-11729890/1
 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral   | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c7f277b6315652efcefa

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525c7f277b6315652efcf03
        failing since 265 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-10-10T21:53:40.544083  + set +x

    2023-10-10T21:53:40.550618  <8>[    9.368262] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11729863_1.4.2.3.1>

    2023-10-10T21:53:40.657619  / # #

    2023-10-10T21:53:40.759943  export SHELL=3D/bin/sh

    2023-10-10T21:53:40.760867  #

    2023-10-10T21:53:40.862411  / # export SHELL=3D/bin/sh. /lava-11729863/=
environment

    2023-10-10T21:53:40.863151  =


    2023-10-10T21:53:40.964812  / # . /lava-11729863/environment/lava-11729=
863/bin/lava-test-runner /lava-11729863/1

    2023-10-10T21:53:40.965928  =


    2023-10-10T21:53:40.971161  / # /lava-11729863/bin/lava-test-runner /la=
va-11729863/1
 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-broonie     | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c9c6bd1466aeaaefcf4a

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525c9c6bd1466aeaaefcf79
        failing since 265 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-10-10T22:01:02.003401  <8>[   14.462437] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 162358_1.5.2.4.1>
    2023-10-10T22:01:02.112505  / # #
    2023-10-10T22:01:02.214381  export SHELL=3D/bin/sh
    2023-10-10T22:01:02.214801  #
    2023-10-10T22:01:02.316084  / # export SHELL=3D/bin/sh<6>[   14.674916]=
 usb 1-1: new low-speed USB device number 3 usi. /lava-162358/environment
    2023-10-10T22:01:02.316480  ng musb-hdrc
    2023-10-10T22:01:02.316712  =

    2023-10-10T22:01:02.417970  / # . /lava-162358/environment/lava-162358/=
bin/lava-test-runner /lava-162358/1
    2023-10-10T22:01:02.418601  =

    2023-10-10T22:01:02.418825  / # <3>[   14.824898] usb 1-1: device descr=
iptor read/64, error -71 =

    ... (17 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-cip         | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525cc58c3eef25d65efcf49

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525cc58c3eef25d65efcf50
        failing since 265 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-10-10T22:12:03.969725  + set +x
    2023-10-10T22:12:03.971900  <8>[    9.896831] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1019138_1.5.2.4.1>
    2023-10-10T22:12:04.080580  / # #
    2023-10-10T22:12:04.182523  export SHELL=3D/bin/sh
    2023-10-10T22:12:04.183027  #
    2023-10-10T22:12:04.284436  / # export SHELL=3D/bin/sh. /lava-1019138/e=
nvironment
    2023-10-10T22:12:04.284908  =

    2023-10-10T22:12:04.386342  / # . /lava-1019138/environment/lava-101913=
8/bin/lava-test-runner /lava-1019138/1
    2023-10-10T22:12:04.387185  =

    2023-10-10T22:12:04.388579  / # /lava-1019138/bin/lava-test-runner /lav=
a-1019138/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6q-sabrelite            | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c975ffdd7eb6f0efcf4e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525c975ffdd7eb6f0efcf57
        failing since 265 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-10-10T22:00:25.333637  / # #

    2023-10-10T22:00:25.435672  export SHELL=3D/bin/sh

    2023-10-10T22:00:25.436304  #

    2023-10-10T22:00:25.537656  / # export SHELL=3D/bin/sh. /lava-11730108/=
environment

    2023-10-10T22:00:25.538341  =


    2023-10-10T22:00:25.639791  / # . /lava-11730108/environment/lava-11730=
108/bin/lava-test-runner /lava-11730108/1

    2023-10-10T22:00:25.640854  =


    2023-10-10T22:00:25.642037  / # /lava-11730108/bin/lava-test-runner /la=
va-11730108/1

    2023-10-10T22:00:25.763216  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-10T22:00:25.763699  + cd /lava-11730108/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c85680cf7a7f08efcf1d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboard-re=
vd1.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboard-re=
vd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525c85680cf7a7f08efcf26
        failing since 265 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-10-10T21:55:22.153611  + set +x[    7.299793] <LAVA_SIGNAL_ENDRUN =
0_dmesg 1002959_1.5.2.3.1>
    2023-10-10T21:55:22.153794  =

    2023-10-10T21:55:22.260602  / # #
    2023-10-10T21:55:22.362299  export SHELL=3D/bin/sh
    2023-10-10T21:55:22.362784  #
    2023-10-10T21:55:22.464090  / # export SHELL=3D/bin/sh. /lava-1002959/e=
nvironment
    2023-10-10T21:55:22.464617  =

    2023-10-10T21:55:22.565981  / # . /lava-1002959/environment/lava-100295=
9/bin/lava-test-runner /lava-1002959/1
    2023-10-10T21:55:22.566672  =

    2023-10-10T21:55:22.569401  / # /lava-1002959/bin/lava-test-runner /lav=
a-1002959/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c959b329e1e7f4efcf35

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboard-rev=
d1.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboard-rev=
d1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525c959b329e1e7f4efcf3e
        failing since 265 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-10-10T21:59:40.707366  + set +x
    2023-10-10T21:59:40.707528  [    4.968167] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1002964_1.5.2.3.1>
    2023-10-10T21:59:40.813973  / # #
    2023-10-10T21:59:40.915627  export SHELL=3D/bin/sh
    2023-10-10T21:59:40.916168  #
    2023-10-10T21:59:41.017515  / # export SHELL=3D/bin/sh. /lava-1002964/e=
nvironment
    2023-10-10T21:59:41.018066  =

    2023-10-10T21:59:41.119478  / # . /lava-1002964/environment/lava-100296=
4/bin/lava-test-runner /lava-1002964/1
    2023-10-10T21:59:41.120159  =

    2023-10-10T21:59:41.122458  / # /lava-1002964/bin/lava-test-runner /lav=
a-1002964/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6ul-14x14-evk           | arm    | lab-nxp         | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c9e05f57a1f9ecefcef3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525c9e05f57a1f9ecefcefa
        failing since 207 days (last pass: v4.19.260, first fail: v4.19.278)

    2023-10-10T22:01:53.777669  + set +x<8>[   23.348558] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1254041_1.5.2.4.1>
    2023-10-10T22:01:53.778075  =

    2023-10-10T22:01:53.889714  / # #
    2023-10-10T22:01:55.046019  export SHELL=3D/bin/sh
    2023-10-10T22:01:55.051691  #
    2023-10-10T22:01:56.593690  / # export SHELL=3D/bin/sh. /lava-1254041/e=
nvironment
    2023-10-10T22:01:56.599357  =

    2023-10-10T22:01:59.411775  / # . /lava-1254041/environment/lava-125404=
1/bin/lava-test-runner /lava-1254041/1
    2023-10-10T22:01:59.417749  =

    2023-10-10T22:01:59.419422  / # /lava-1254041/bin/lava-test-runner /lav=
a-1254041/1 =

    ... (15 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx7d-sdb                  | arm    | lab-nxp         | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c9908a9703533cefcf3b

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525c9908a9703533cefcf42
        failing since 265 days (last pass: v4.19.267, first fail: v4.19.270)

    2023-10-10T22:00:27.317448  / # #
    2023-10-10T22:00:28.473381  export SHELL=3D/bin/sh
    2023-10-10T22:00:28.479026  #
    2023-10-10T22:00:30.021182  / # export SHELL=3D/bin/sh. /lava-1254042/e=
nvironment
    2023-10-10T22:00:30.026871  =

    2023-10-10T22:00:32.838650  / # . /lava-1254042/environment/lava-125404=
2/bin/lava-test-runner /lava-1254042/1
    2023-10-10T22:00:32.845018  =

    2023-10-10T22:00:32.858863  / # /lava-1254042/bin/lava-test-runner /lav=
a-1254042/1
    2023-10-10T22:00:32.951778  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-10T22:00:32.952194  + cd /lava-1254042/1/tests/1_bootrr =

    ... (16 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm-vexpress-a15      | arm    | lab-baylibre    | gcc-10   | vexpress=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c7c289026fdcc3efcefc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: vexpress_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm/vexpress_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-vexpress-a15.t=
xt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm/vexpress_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-vexpress-a15.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c7c289026fdcc3efc=
efd
        new failure (last pass: v4.19.288) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm-vexpress-a9       | arm    | lab-baylibre    | gcc-10   | vexpress=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c7c3c7594e1f2befcf10

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: vexpress_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm/vexpress_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-vexpress-a9.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm/vexpress_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-vexpress-a9.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c7c3c7594e1f2befc=
f11
        new failure (last pass: v4.19.288) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv2        | arm    | lab-baylibre    | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c9409568574602efcf21

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c9409568574602efc=
f22
        new failure (last pass: v4.19.288) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv2-uefi   | arm    | lab-baylibre    | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c9419568574602efcf24

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-virt-gicv2-uef=
i.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-virt-gicv2-uef=
i.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c9419568574602efc=
f25
        new failure (last pass: v4.19.288) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv3        | arm    | lab-baylibre    | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c9439568574602efcf97

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c9439568574602efc=
f98
        new failure (last pass: v4.19.288) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv3-uefi   | arm    | lab-baylibre    | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c9429568574602efcf7e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-virt-gicv3-uef=
i.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-virt-gicv3-uef=
i.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c9429568574602efc=
f7f
        new failure (last pass: v4.19.288) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-baylibre    | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c88a1ae6155ef9efcf04

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-vi=
rt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-vi=
rt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c88a1ae6155ef9efc=
f05
        failing since 516 days (last pass: v4.19.239, first fail: v4.19.242=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-baylibre    | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c8f05347e0f599efcef9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c8f05347e0f599efc=
efa
        failing since 516 days (last pass: v4.19.239, first fail: v4.19.242=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525cb230784e70a88efcf83

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525cb230784e70a88efc=
f84
        failing since 516 days (last pass: v4.19.239, first fail: v4.19.242=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525cc8dd5dff6f0f7efceff

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525cc8dd5dff6f0f7efc=
f00
        failing since 516 days (last pass: v4.19.239, first fail: v4.19.242=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c9aaa12dd11ba9efcf25

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c9aaa12dd11ba9efc=
f26
        failing since 516 days (last pass: v4.19.239, first fail: v4.19.242=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525cafc332e9d454aefcf6f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525cafc332e9d454aefc=
f70
        failing since 516 days (last pass: v4.19.239, first fail: v4.19.242=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-baylibre    | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c88b1ae6155ef9efcf07

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-vi=
rt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-vi=
rt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c88b1ae6155ef9efc=
f08
        failing since 516 days (last pass: v4.19.239, first fail: v4.19.242=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-baylibre    | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c8ef5347e0f599efcef6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c8ef5347e0f599efc=
ef7
        failing since 516 days (last pass: v4.19.239, first fail: v4.19.242=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525cb240784e70a88efcf91

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525cb240784e70a88efc=
f92
        failing since 516 days (last pass: v4.19.239, first fail: v4.19.242=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525cc8c5af85aab90efcf0a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525cc8c5af85aab90efc=
f0b
        failing since 516 days (last pass: v4.19.239, first fail: v4.19.242=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c9b0a12dd11ba9efcf7f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c9b0a12dd11ba9efc=
f80
        failing since 516 days (last pass: v4.19.239, first fail: v4.19.242=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525cac889835b9aa9efcf7d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525cac889835b9aa9efc=
f7e
        failing since 516 days (last pass: v4.19.239, first fail: v4.19.242=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-baylibre    | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c87765c168ab08efcf35

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-vi=
rt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-vi=
rt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c87765c168ab08efc=
f36
        failing since 516 days (last pass: v4.19.239, first fail: v4.19.242=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-baylibre    | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c9045347e0f599efcf45

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c9045347e0f599efc=
f46
        failing since 516 days (last pass: v4.19.239, first fail: v4.19.242=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525cb220784e70a88efcf7f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525cb220784e70a88efc=
f80
        failing since 516 days (last pass: v4.19.239, first fail: v4.19.242=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525cc8a5af85aab90efcefc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525cc8a5af85aab90efc=
efd
        failing since 516 days (last pass: v4.19.239, first fail: v4.19.242=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c9a89fe8e13148efcf5e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c9a89fe8e13148efc=
f5f
        failing since 516 days (last pass: v4.19.239, first fail: v4.19.242=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525cb0465b6cf8e24efcf00

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525cb0465b6cf8e24efc=
f01
        failing since 516 days (last pass: v4.19.239, first fail: v4.19.242=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-baylibre    | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c88c1ae6155ef9efcf0a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-vi=
rt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-vi=
rt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c88c1ae6155ef9efc=
f0b
        failing since 516 days (last pass: v4.19.239, first fail: v4.19.242=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-baylibre    | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c8ee5347e0f599efcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c8ee5347e0f599efc=
ef4
        failing since 516 days (last pass: v4.19.239, first fail: v4.19.242=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525cb4ba639624593efcfae

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525cb4ba639624593efc=
faf
        failing since 516 days (last pass: v4.19.239, first fail: v4.19.242=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525cbc3f5ae9fab23efcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525cbc3f5ae9fab23efc=
ef4
        failing since 516 days (last pass: v4.19.239, first fail: v4.19.242=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c9ec5f57a1f9ecefd1df

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c9ec5f57a1f9ecefd=
1e0
        failing since 516 days (last pass: v4.19.239, first fail: v4.19.242=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525ca70f0fcf61afdefcf26

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525ca70f0fcf61afdefc=
f27
        failing since 516 days (last pass: v4.19.239, first fail: v4.19.242=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_i386                  | i386   | lab-baylibre    | gcc-10   | i386_def=
config               | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c83b7ffcfaaecaefcef8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_i386.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_i386.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c83b7ffcfaaecaefc=
ef9
        new failure (last pass: v4.19.288) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_i386-uefi             | i386   | lab-baylibre    | gcc-10   | i386_def=
config               | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c83a80cf7a7f08efcefa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_i386-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_i386-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c83a80cf7a7f08efc=
efb
        new failure (last pass: v4.19.288) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_x86_64                | x86_64 | lab-baylibre    | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c74e4fbaee04d7efcf4c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c74e4fbaee04d7efc=
f4d
        new failure (last pass: v4.19.288) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_x86_64                | x86_64 | lab-baylibre    | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c7c5c7594e1f2befcf16

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-baylibre/baseline-qemu_x8=
6_64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-baylibre/baseline-qemu_x8=
6_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c7c5c7594e1f2befc=
f17
        new failure (last pass: v4.19.288) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi           | x86_64 | lab-baylibre    | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c74c4fbaee04d7efcf46

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qemu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qemu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c74c4fbaee04d7efc=
f47
        new failure (last pass: v4.19.288) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi           | x86_64 | lab-baylibre    | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c7c689026fdcc3efcf07

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-baylibre/baseline-qemu_x8=
6_64-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-baylibre/baseline-qemu_x8=
6_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c7c689026fdcc3efc=
f08
        new failure (last pass: v4.19.288) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
r8a7796-m3ulcb             | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c91ea1aaa70696efcf12

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7796-m3ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7796-m3ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525c91ea1aaa70696efcf1b
        failing since 265 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-10-10T22:02:50.502780  / # #

    2023-10-10T22:02:50.603227  export SHELL=3D/bin/sh

    2023-10-10T22:02:50.603337  #

    2023-10-10T22:02:50.703718  / # export SHELL=3D/bin/sh. /lava-11729992/=
environment

    2023-10-10T22:02:50.703809  =


    2023-10-10T22:02:50.804221  / # . /lava-11729992/environment/lava-11729=
992/bin/lava-test-runner /lava-11729992/1

    2023-10-10T22:02:50.804398  =


    2023-10-10T22:02:50.816352  / # /lava-11729992/bin/lava-test-runner /la=
va-11729992/1

    2023-10-10T22:02:50.870435  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-10T22:02:50.870503  + cd /lav<8>[    9.037998] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11729992_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq          | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 3          =


  Details:     https://kernelci.org/test/plan/id/6525c971acd9cd0c76efcf41

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/6525c971acd9cd0c76efcf75
        failing since 264 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-10-10T22:04:12.755044  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[    9.869835] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-10-10T22:04:12.756873   multi-call binary.

    2023-10-10T22:04:12.757098  =


    2023-10-10T22:04:12.761325  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-10-10T22:04:12.761544  =


    2023-10-10T22:04:12.766560  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-10-10T22:04:12.777081  FIRST,<8>[    9.888579] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/6525c971acd9cd0c76efcf76
        failing since 264 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-10-10T22:04:12.736123  <8>[    9.852303] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525c971acd9cd0c76efcf89
        failing since 264 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-10-10T22:04:08.903573  <8>[    6.019960] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-10-10T22:04:08.913273  + <8>[    6.032176] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11730101_1.5.2.3.1>

    2023-10-10T22:04:08.913499  set +x

    2023-10-10T22:04:09.019807  =


    2023-10-10T22:04:09.121418  / # #export SHELL=3D/bin/sh

    2023-10-10T22:04:09.122147  =


    2023-10-10T22:04:09.223527  / # export SHELL=3D/bin/sh. /lava-11730101/=
environment

    2023-10-10T22:04:09.224335  =


    2023-10-10T22:04:09.325817  / # . /lava-11730101/environment/lava-11730=
101/bin/lava-test-runner /lava-11730101/1

    2023-10-10T22:04:09.326881  =

 =

    ... (17 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
rk3399-gru-kevin           | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6525c8c95cec26deabefcf14

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6525c8c95cec26deabefcf1e
        failing since 207 days (last pass: v4.19.277, first fail: v4.19.278)

    2023-10-10T21:58:44.703633  /lava-11729969/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6525c8c95cec26deabefcf1f
        failing since 207 days (last pass: v4.19.277, first fail: v4.19.278)

    2023-10-10T21:58:42.665109  <8>[   35.521209] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-10-10T21:58:43.679300  /lava-11729969/1/../bin/lava-test-case

    2023-10-10T21:58:43.687125  <8>[   36.544098] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus     | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525ccff6552121d7fefcf97

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525ccff6552121d7fefcfc1
        failing since 265 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-10-10T22:14:47.775005  <8>[   15.937742] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 162334_1.5.2.4.1>
    2023-10-10T22:14:47.881869  / # #
    2023-10-10T22:14:47.984385  export SHELL=3D/bin/sh
    2023-10-10T22:14:47.984958  #
    2023-10-10T22:14:48.086757  / # export SHELL=3D/bin/sh. /lava-162334/en=
vironment
    2023-10-10T22:14:48.087481  =

    2023-10-10T22:14:48.189422  / # . /lava-162334/environment/lava-162334/=
bin/lava-test-runner /lava-162334/1
    2023-10-10T22:14:48.190311  =

    2023-10-10T22:14:48.194546  / # /lava-162334/bin/lava-test-runner /lava=
-162334/1
    2023-10-10T22:14:48.226182  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64         | arm64  | lab-clabbe      | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c912082870e1bbefcf09

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525c912082870e1bbefcf12
        failing since 265 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-10-10T21:58:27.383128  <8>[   15.163314] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 437880_1.5.2.4.1>
    2023-10-10T21:58:27.488165  / # #
    2023-10-10T21:58:27.589817  export SHELL=3D/bin/sh
    2023-10-10T21:58:27.590362  #
    2023-10-10T21:58:27.691371  / # export SHELL=3D/bin/sh. /lava-437880/en=
vironment
    2023-10-10T21:58:27.692041  =

    2023-10-10T21:58:27.793007  / # . /lava-437880/environment/lava-437880/=
bin/lava-test-runner /lava-437880/1
    2023-10-10T21:58:27.793965  =

    2023-10-10T21:58:27.798394  / # /lava-437880/bin/lava-test-runner /lava=
-437880/1
    2023-10-10T21:58:27.868522  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64         | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c9339568574602efcf14

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525c9339568574602efcf1d
        failing since 265 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-10-10T22:03:11.750773  / # #

    2023-10-10T22:03:11.852871  export SHELL=3D/bin/sh

    2023-10-10T22:03:11.853592  #

    2023-10-10T22:03:11.954784  / # export SHELL=3D/bin/sh. /lava-11729996/=
environment

    2023-10-10T22:03:11.955623  =


    2023-10-10T22:03:12.056820  / # . /lava-11729996/environment/lava-11729=
996/bin/lava-test-runner /lava-11729996/1

    2023-10-10T22:03:12.057011  =


    2023-10-10T22:03:12.058381  / # /lava-11729996/bin/lava-test-runner /la=
va-11729996/1

    2023-10-10T22:03:12.131261  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-10T22:03:12.131329  + cd /lava-1172999<8>[   15.620963] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11729996_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
sun8i-a33-olinuxino        | arm    | lab-clabbe      | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525ca2bee433f0b11efcef3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm/multi_v7_defconfig/gcc-10/lab-clabbe/baseline-sun8i-a33-olinuxino.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm/multi_v7_defconfig/gcc-10/lab-clabbe/baseline-sun8i-a33-olinuxino.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525ca2bee433f0b11efcefc
        failing since 265 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-10-10T22:02:41.951763  + set +x<8>[   17.226995] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 437885_1.5.2.4.1>
    2023-10-10T22:02:41.952051  =

    2023-10-10T22:02:42.058702  / # #
    2023-10-10T22:02:42.160237  export SHELL=3D/bin/sh
    2023-10-10T22:02:42.160870  #
    2023-10-10T22:02:42.261788  / # export SHELL=3D/bin/sh. /lava-437885/en=
vironment
    2023-10-10T22:02:42.262300  =

    2023-10-10T22:02:42.363302  / # . /lava-437885/environment/lava-437885/=
bin/lava-test-runner /lava-437885/1
    2023-10-10T22:02:42.364199  =

    2023-10-10T22:02:42.367398  / # /lava-437885/bin/lava-test-runner /lava=
-437885/1 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
sun8i-a83t-bananapi-m3     | arm    | lab-clabbe      | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c94ef277f14517efcf03

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm/multi_v7_defconfig/gcc-10/lab-clabbe/baseline-sun8i-a83t-bananapi-m3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm/multi_v7_defconfig/gcc-10/lab-clabbe/baseline-sun8i-a83t-bananapi-m3.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525c94ef277f14517efcf0c
        failing since 265 days (last pass: v4.19.258, first fail: v4.19.270)

    2023-10-10T21:59:22.257923  [    6.076907] <LAVA_SIGNAL_ENDRUN 0_dmesg =
437882_1.5.2.4.1>
    2023-10-10T21:59:22.363510  / # #
    2023-10-10T21:59:22.465407  export SHELL=3D/bin/sh
    2023-10-10T21:59:22.466166  #
    2023-10-10T21:59:22.567183  / # export SHELL=3D/bin/sh. /lava-437882/en=
vironment
    2023-10-10T21:59:22.567846  =

    2023-10-10T21:59:22.668994  / # . /lava-437882/environment/lava-437882/=
bin/lava-test-runner /lava-437882/1
    2023-10-10T21:59:22.670022  =

    2023-10-10T21:59:22.672839  / # /lava-437882/bin/lava-test-runner /lava=
-437882/1
    2023-10-10T21:59:22.752874  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
sun8i-h3-orangepi-pc       | arm    | lab-clabbe      | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c963ffdd7eb6f0efcef5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm/multi_v7_defconfig/gcc-10/lab-clabbe/baseline-sun8i-h3-orangepi-pc.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm/multi_v7_defconfig/gcc-10/lab-clabbe/baseline-sun8i-h3-orangepi-pc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525c963ffdd7eb6f0efcefe
        failing since 265 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-10-10T21:59:49.815881  + set +x
    2023-10-10T21:59:49.817866  <8>[   14.325320] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 437883_1.5.2.4.1>
    2023-10-10T21:59:49.925203  / # #
    2023-10-10T21:59:50.026824  export SHELL=3D/bin/sh
    2023-10-10T21:59:50.027374  #
    2023-10-10T21:59:50.128371  / # export SHELL=3D/bin/sh. /lava-437883/en=
vironment
    2023-10-10T21:59:50.128954  =

    2023-10-10T21:59:50.229969  / # . /lava-437883/environment/lava-437883/=
bin/lava-test-runner /lava-437883/1
    2023-10-10T21:59:50.230859  =

    2023-10-10T21:59:50.232662  / # /lava-437883/bin/lava-test-runner /lava=
-437883/1 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c8ac70ba80a70eefcf05

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525c8ac70ba80a70eefcf0c
        failing since 265 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-10-10T21:56:40.446845  <8>[    3.721534] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1019124_1.5.2.4.1>
    2023-10-10T21:56:40.551834  / # #
    2023-10-10T21:56:40.653405  export SHELL=3D/bin/sh
    2023-10-10T21:56:40.653829  #
    2023-10-10T21:56:40.754950  / # export SHELL=3D/bin/sh. /lava-1019124/e=
nvironment
    2023-10-10T21:56:40.755418  =

    2023-10-10T21:56:40.856569  / # . /lava-1019124/environment/lava-101912=
4/bin/lava-test-runner /lava-1019124/1
    2023-10-10T21:56:40.857203  =

    2023-10-10T21:56:40.859341  / # /lava-1019124/bin/lava-test-runner /lav=
a-1019124/1
    2023-10-10T21:56:40.897442  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525ca6432341bc88defcfa9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.296/=
arm64/defconfig/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525ca6432341bc88defcfb0
        failing since 265 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-10-10T22:03:57.065968  <8>[    3.715074] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1019129_1.5.2.4.1>
    2023-10-10T22:03:57.170759  / # #
    2023-10-10T22:03:57.272011  export SHELL=3D/bin/sh
    2023-10-10T22:03:57.272306  #
    2023-10-10T22:03:57.373278  / # export SHELL=3D/bin/sh. /lava-1019129/e=
nvironment
    2023-10-10T22:03:57.373627  =

    2023-10-10T22:03:57.474625  / # . /lava-1019129/environment/lava-101912=
9/bin/lava-test-runner /lava-1019129/1
    2023-10-10T22:03:57.475080  =

    2023-10-10T22:03:57.477720  / # /lava-1019129/bin/lava-test-runner /lav=
a-1019129/1
    2023-10-10T22:03:57.514646  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
