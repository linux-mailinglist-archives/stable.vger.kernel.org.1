Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175927C47C3
	for <lists+stable@lfdr.de>; Wed, 11 Oct 2023 04:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344739AbjJKC2k (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 10 Oct 2023 22:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344584AbjJKC2j (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Oct 2023 22:28:39 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E0492
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 19:28:33 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c87a85332bso53148505ad.2
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 19:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696991312; x=1697596112; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EDZj/2w0+XOQTcMNmwYakSJJIseC7JyvsaxCfIY+d7Q=;
        b=OK2+xDeY8lobR6UqEgPrBeWldoKXjgMca286XWMtSDw9NbmuoDrbUvStAH/+apL7cj
         GpzVeXBjCMGxLxZ/3XcpawJLHWFh35n14hGy+meY9Rnty/C5qdnZe0Adq+lprWPZaFU+
         OjTviIlSD52wzauDlJE9JzVDc1BbCxTLXW/8NeO+HJTjXSuKrMIVTGoXZTmKYmR1ipy5
         B6QacwdzWOJTpMy0+PBYDmG2wUjxGPYw2x3LAQ2AsW5LXWD/OkBsnInYGx8HS229aZ6Y
         xN31q0iliOrsR/LoFlZFXWlSWjeDsia/CYcwV8QqIXyAdX5/7HQGAReVVnNgmj7JEdJu
         gQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696991312; x=1697596112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EDZj/2w0+XOQTcMNmwYakSJJIseC7JyvsaxCfIY+d7Q=;
        b=I9B+Hv6bcAA3JA3pZgm+wsvNdTNcd0jqaQXZ296RsBAEKQGv/sOdSrW2HFnqMQNHWa
         Qh6zJ7HaWJPrHMYvQ0md/GWYz9yO74m1ox1JAt6eJOP10NYeioOBQ3t1m8lbknTd0MTt
         d2E/AioTu3ZuR4qJwMeOx6mz5X6N1Y+6AyDc0T9TDPE2d9lTivpd9KT2QNYe63PVGEqm
         S9oO9Uq0IzE4Ud6XLf9jetNhx+hdI/qTEkp3aclF3mG8k5TPAB/I5NYDdvUotYe72bx0
         gn7bGVMX0nYxTpgCXQtXqMA7guW/9J1bRT3rSHOcma5zfMnkzbeK+MFRrBGuHWpjk5uR
         thUA==
X-Gm-Message-State: AOJu0Yy4Wn7gjSs0dAKl46Y3iDmQAmR0hCb1apC2VS/UDfbVggf7IGwO
        4RL7slNuOb4PLrD3bLQyo7phJ+2Lz1AEIml9uSamjA==
X-Google-Smtp-Source: AGHT+IE50Q0YRC+X0F7j4dWb7aWs0HPOKc7O1Q3BjT+eTFQjFSn71J3/ITEnKyfxAg1wkge85TZEKA==
X-Received: by 2002:a17:902:d481:b0:1c8:7d21:fc50 with SMTP id c1-20020a170902d48100b001c87d21fc50mr18884302plg.56.1696991311822;
        Tue, 10 Oct 2023 19:28:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jh19-20020a170903329300b001b3bf8001a9sm12623921plb.48.2023.10.10.19.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 19:28:31 -0700 (PDT)
Message-ID: <6526084f.170a0220.c9a08.41c1@mx.google.com>
Date:   Tue, 10 Oct 2023 19:28:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.198
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable
Subject: stable/linux-5.10.y baseline: 163 runs, 38 regressions (v5.10.198)
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

stable/linux-5.10.y baseline: 163 runs, 38 regressions (v5.10.198)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm-vexpress-a15        | arm    | lab-baylibre  | gcc-10   | vexpress=
_defconfig           | 1          =

qemu_arm-vexpress-a9         | arm    | lab-baylibre  | gcc-10   | vexpress=
_defconfig           | 1          =

qemu_arm-virt-gicv2          | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm-virt-gicv2-uefi     | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm-virt-gicv3          | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm-virt-gicv3-uefi     | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_i386                    | i386   | lab-baylibre  | gcc-10   | i386_def=
config               | 1          =

qemu_i386-uefi               | i386   | lab-baylibre  | gcc-10   | i386_def=
config               | 1          =

qemu_riscv64                 | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_smp8_riscv64            | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_x86_64                  | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efconfig             | 1          =

qemu_x86_64                  | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

qemu_x86_64-uefi             | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efconfig             | 1          =

qemu_x86_64-uefi             | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efconfig             | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

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

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-clabbe    | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun8i-a83t-bananapi-m3       | arm    | lab-clabbe    | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.10.y/kernel=
/v5.10.198/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.10.y
  Describe: v5.10.198
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      a8d812240fdd12949c8344379b01d340e36726ba =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6525d5170a1e2a4780efcf87

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525d5170a1e2a4780efcf90
        failing since 188 days (last pass: v5.10.176, first fail: v5.10.177)

    2023-10-10T22:49:33.207218  + set +x

    2023-10-10T22:49:33.213899  <8>[   14.409099] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11730929_1.4.2.3.1>

    2023-10-10T22:49:33.318360  / # #

    2023-10-10T22:49:33.418915  export SHELL=3D/bin/sh

    2023-10-10T22:49:33.419098  #

    2023-10-10T22:49:33.519611  / # export SHELL=3D/bin/sh. /lava-11730929/=
environment

    2023-10-10T22:49:33.519797  =


    2023-10-10T22:49:33.620409  / # . /lava-11730929/environment/lava-11730=
929/bin/lava-test-runner /lava-11730929/1

    2023-10-10T22:49:33.621485  =


    2023-10-10T22:49:33.625672  / # /lava-11730929/bin/lava-test-runner /la=
va-11730929/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525dafee0c889bf25efcefc

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525dafee0c889bf25efcf3c
        failing since 17 days (last pass: v5.10.196, first fail: v5.10.197)

    2023-10-10T23:14:46.541109  / # #
    2023-10-10T23:14:46.643025  export SHELL=3D/bin/sh
    2023-10-10T23:14:46.643540  #
    2023-10-10T23:14:46.745006  / # export SHELL=3D/bin/sh. /lava-162894/en=
vironment
    2023-10-10T23:14:46.745459  =

    2023-10-10T23:14:46.846897  / # . /lava-162894/environment/lava-162894/=
bin/lava-test-runner /lava-162894/1
    2023-10-10T23:14:46.847653  =

    2023-10-10T23:14:46.854118  / # /lava-162894/bin/lava-test-runner /lava=
-162894/1
    2023-10-10T23:14:46.886193  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-10T23:14:46.924979  + cd /lava-162894/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-vexpress-a15        | arm    | lab-baylibre  | gcc-10   | vexpress=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525d318932266fb07efcf1f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: vexpress_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm/vexpress_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-vexpress-a15.t=
xt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm/vexpress_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-vexpress-a15.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525d318932266fb07efc=
f20
        new failure (last pass: v5.10.186) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-vexpress-a9         | arm    | lab-baylibre  | gcc-10   | vexpress=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525d31918dace2123efcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: vexpress_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm/vexpress_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-vexpress-a9.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm/vexpress_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-vexpress-a9.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525d31918dace2123efc=
ef4
        new failure (last pass: v5.10.186) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv2          | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525d6c82f3d71875fefcf0f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525d6c82f3d71875fefc=
f10
        new failure (last pass: v5.10.186) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv2-uefi     | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525d6cac1e2703b82efcefa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-virt-gicv2-uef=
i.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-virt-gicv2-uef=
i.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525d6cac1e2703b82efc=
efb
        new failure (last pass: v5.10.186) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv3          | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525d6c9c1e2703b82efcef4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525d6c9c1e2703b82efc=
ef5
        new failure (last pass: v5.10.186) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv3-uefi     | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525d6cb2f3d71875fefcf1b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-virt-gicv3-uef=
i.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-virt-gicv3-uef=
i.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525d6cb2f3d71875fefc=
f1c
        new failure (last pass: v5.10.186) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525d6c74083abf981efcf55

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525d6c74083abf981efc=
f56
        new failure (last pass: v5.10.185) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525d72ba7ba693e12efcf01

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-vi=
rt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-vi=
rt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525d72ba7ba693e12efc=
f02
        new failure (last pass: v5.10.184) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525d6c44083abf981efcf4f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525d6c44083abf981efc=
f50
        new failure (last pass: v5.10.185) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525d72a461c391796efcef4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-vi=
rt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-vi=
rt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525d72a461c391796efc=
ef5
        new failure (last pass: v5.10.184) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525d6c62f3d71875fefcf07

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525d6c62f3d71875fefc=
f08
        new failure (last pass: v5.10.185) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525d728b54d0679a2efcf01

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-vi=
rt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-vi=
rt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525d728b54d0679a2efc=
f02
        new failure (last pass: v5.10.184) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525d6b21958a28d88efcf0b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525d6b21958a28d88efc=
f0c
        new failure (last pass: v5.10.185) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525d729b54d0679a2efcf07

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-vi=
rt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-vi=
rt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525d729b54d0679a2efc=
f08
        new failure (last pass: v5.10.184) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_i386                    | i386   | lab-baylibre  | gcc-10   | i386_def=
config               | 1          =


  Details:     https://kernelci.org/test/plan/id/6525d3e195437cbd08efcf1a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_i386.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_i386.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525d3e195437cbd08efc=
f1b
        new failure (last pass: v5.10.186) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_i386-uefi               | i386   | lab-baylibre  | gcc-10   | i386_def=
config               | 1          =


  Details:     https://kernelci.org/test/plan/id/6525d3e095437cbd08efcf17

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_i386-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_i386-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525d3e095437cbd08efc=
f18
        new failure (last pass: v5.10.186) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_riscv64                 | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525d383a19ab05558efcf09

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
riscv/defconfig/gcc-10/lab-baylibre/baseline-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
riscv/defconfig/gcc-10/lab-baylibre/baseline-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/riscv/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525d383a19ab05558efc=
f0a
        new failure (last pass: v5.10.186) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_smp8_riscv64            | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525d3842e6bbe0c5fefcf60

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
riscv/defconfig/gcc-10/lab-baylibre/baseline-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
riscv/defconfig/gcc-10/lab-baylibre/baseline-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/riscv/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525d3842e6bbe0c5fefc=
f61
        new failure (last pass: v5.10.186) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64                  | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/6525d458c4ba3f1229efcf06

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525d458c4ba3f1229efc=
f07
        new failure (last pass: v5.10.186) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64                  | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6525d4d377b147a768efcf7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-baylibre/baseline-qemu_x8=
6_64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-baylibre/baseline-qemu_x8=
6_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525d4d377b147a768efc=
f7b
        new failure (last pass: v5.10.186) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi             | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/6525d45ac4ba3f1229efcf0c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qemu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qemu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525d45ac4ba3f1229efc=
f0d
        new failure (last pass: v5.10.186) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi             | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6525d4d177b147a768efcf74

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-baylibre/baseline-qemu_x8=
6_64-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-baylibre/baseline-qemu_x8=
6_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525d4d177b147a768efc=
f75
        new failure (last pass: v5.10.186) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/6525d459c4ba3f1229efcf09

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qemu_x86_64-uefi-mixed=
.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qemu_x86_64-uefi-mixed=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525d459c4ba3f1229efc=
f0a
        new failure (last pass: v5.10.186) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6525d4d2adf964bcc7efcf0b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-baylibre/baseline-qemu_x8=
6_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-baylibre/baseline-qemu_x8=
6_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525d4d2adf964bcc7efc=
f0c
        new failure (last pass: v5.10.186) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525e3cb327092d507efcef6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525e3cb327092d507efcefd
        failing since 45 days (last pass: v5.10.185, first fail: v5.10.192)

    2023-10-10T23:52:20.922103  + set +x
    2023-10-10T23:52:20.925316  <8>[   83.970064] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1019270_1.5.2.4.1>
    2023-10-10T23:52:21.032368  / # #
    2023-10-10T23:52:22.495300  export SHELL=3D/bin/sh
    2023-10-10T23:52:22.516009  #
    2023-10-10T23:52:22.516203  / # export SHELL=3D/bin/sh
    2023-10-10T23:52:24.469142  / # . /lava-1019270/environment
    2023-10-10T23:52:28.065222  /lava-1019270/bin/lava-test-runner /lava-10=
19270/1
    2023-10-10T23:52:28.087021  . /lava-1019270/environment
    2023-10-10T23:52:28.087458  / # /lava-1019270/bin/lava-test-runner /lav=
a-1019270/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525e60dc9421a176eefcf38

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rz=
g2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rz=
g2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525e60dc9421a176eefcf3f
        failing since 75 days (last pass: v5.10.184, first fail: v5.10.188)

    2023-10-11T00:01:53.652917  + set +x
    2023-10-11T00:01:53.653035  <8>[   83.849438] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1019302_1.5.2.4.1>
    2023-10-11T00:01:53.759072  / # #
    2023-10-11T00:01:55.217856  export SHELL=3D/bin/sh
    2023-10-11T00:01:55.238281  #
    2023-10-11T00:01:55.238430  / # export SHELL=3D/bin/sh
    2023-10-11T00:01:57.189813  / # . /lava-1019302/environment
    2023-10-11T00:02:00.781094  /lava-1019302/bin/lava-test-runner /lava-10=
19302/1
    2023-10-11T00:02:00.801732  . /lava-1019302/environment
    2023-10-11T00:02:00.801847  / # /lava-1019302/bin/lava-test-runner /lav=
a-1019302/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525d9a972ae02923defcfc9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774b1-hihope-rz=
g2n-ex.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774b1-hihope-rz=
g2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525d9a972ae02923defcfd0
        failing since 75 days (last pass: v5.10.184, first fail: v5.10.188)

    2023-10-10T23:08:48.849601  + set +x
    2023-10-10T23:08:48.849715  <8>[   84.222571] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1019304_1.5.2.4.1>
    2023-10-10T23:08:48.955406  / # #
    2023-10-10T23:08:50.414782  export SHELL=3D/bin/sh
    2023-10-10T23:08:50.435293  #
    2023-10-10T23:08:50.435529  / # export SHELL=3D/bin/sh
    2023-10-10T23:08:52.388104  / # . /lava-1019304/environment
    2023-10-10T23:08:55.980224  /lava-1019304/bin/lava-test-runner /lava-10=
19304/1
    2023-10-10T23:08:56.000864  . /lava-1019304/environment
    2023-10-10T23:08:56.000996  / # /lava-1019304/bin/lava-test-runner /lav=
a-1019304/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525d799c7ebb69a6befd016

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525d799c7ebb69a6befd01d
        failing since 75 days (last pass: v5.10.185, first fail: v5.10.188)

    2023-10-10T23:00:23.220209  / # #
    2023-10-10T23:00:24.679441  export SHELL=3D/bin/sh
    2023-10-10T23:00:24.699887  #
    2023-10-10T23:00:24.700036  / # export SHELL=3D/bin/sh
    2023-10-10T23:00:26.651475  / # . /lava-1019277/environment
    2023-10-10T23:00:30.242411  /lava-1019277/bin/lava-test-runner /lava-10=
19277/1
    2023-10-10T23:00:30.263017  . /lava-1019277/environment
    2023-10-10T23:00:30.263137  / # /lava-1019277/bin/lava-test-runner /lav=
a-1019277/1
    2023-10-10T23:00:30.342961  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-10T23:00:30.343091  + cd /lava-1019277/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525d876fe127a3772efcf1b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525d876fe127a3772efcf22
        failing since 75 days (last pass: v5.10.184, first fail: v5.10.188)

    2023-10-10T23:03:57.525292  / # #
    2023-10-10T23:03:58.984039  export SHELL=3D/bin/sh
    2023-10-10T23:03:59.004476  #
    2023-10-10T23:03:59.004636  / # export SHELL=3D/bin/sh
    2023-10-10T23:04:00.956354  / # . /lava-1019303/environment
    2023-10-10T23:04:04.547481  /lava-1019303/bin/lava-test-runner /lava-10=
19303/1
    2023-10-10T23:04:04.568100  . /lava-1019303/environment
    2023-10-10T23:04:04.568232  / # /lava-1019303/bin/lava-test-runner /lav=
a-1019303/1
    2023-10-10T23:04:04.647874  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-10T23:04:04.648079  + cd /lava-1019303/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525d6e0463f799f81efcf0c

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525d6e1463f799f81efcf15
        failing since 75 days (last pass: v5.10.185, first fail: v5.10.188)

    2023-10-10T23:01:52.498217  / # #

    2023-10-10T23:01:52.600378  export SHELL=3D/bin/sh

    2023-10-10T23:01:52.601074  #

    2023-10-10T23:01:52.702483  / # export SHELL=3D/bin/sh. /lava-11731099/=
environment

    2023-10-10T23:01:52.703197  =


    2023-10-10T23:01:52.804628  / # . /lava-11731099/environment/lava-11731=
099/bin/lava-test-runner /lava-11731099/1

    2023-10-10T23:01:52.805697  =


    2023-10-10T23:01:52.822604  / # /lava-11731099/bin/lava-test-runner /la=
va-11731099/1

    2023-10-10T23:01:52.872344  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-10T23:01:52.872850  + cd /lav<8>[   16.413590] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11731099_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6525d791d7c310b9faefcf5e

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6525d791d7c310b9faefcf68
        failing since 207 days (last pass: v5.10.174, first fail: v5.10.175)

    2023-10-10T23:01:39.596014  <8>[   34.343910] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-10-10T23:01:40.620839  /lava-11731140/1/../bin/lava-test-case

    2023-10-10T23:01:40.630715  <8>[   35.379670] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6525d791d7c310b9faefcf69
        failing since 207 days (last pass: v5.10.174, first fail: v5.10.175)

    2023-10-10T23:01:38.560052  <8>[   33.307170] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-10-10T23:01:39.584647  /lava-11731140/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525d72811517c5c2befcf2c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525d72811517c5c2befcf35
        failing since 45 days (last pass: v5.10.191, first fail: v5.10.192)

    2023-10-10T22:58:21.949123  / # #

    2023-10-10T22:58:23.210406  export SHELL=3D/bin/sh

    2023-10-10T22:58:23.221324  #

    2023-10-10T22:58:23.221790  / # export SHELL=3D/bin/sh

    2023-10-10T22:58:24.965624  / # . /lava-11731103/environment

    2023-10-10T22:58:28.163316  /lava-11731103/bin/lava-test-runner /lava-1=
1731103/1

    2023-10-10T22:58:28.174665  . /lava-11731103/environment

    2023-10-10T22:58:28.174964  / # /lava-11731103/bin/lava-test-runner /la=
va-11731103/1

    2023-10-10T22:58:28.229550  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-10T22:58:28.230032  + cd /lava-11731103/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-clabbe    | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525d6d3c1e2703b82efcf14

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525d6d3c1e2703b82efcf1d
        new failure (last pass: v5.10.177)

    2023-10-10T22:57:18.411102  <8>[   17.034767] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 437929_1.5.2.4.1>
    2023-10-10T22:57:18.517464  / # #
    2023-10-10T22:57:18.619167  export SHELL=3D/bin/sh
    2023-10-10T22:57:18.619824  #
    2023-10-10T22:57:18.721035  / # export SHELL=3D/bin/sh. /lava-437929/en=
vironment
    2023-10-10T22:57:18.721642  =

    2023-10-10T22:57:18.822696  / # . /lava-437929/environment/lava-437929/=
bin/lava-test-runner /lava-437929/1
    2023-10-10T22:57:18.823607  =

    2023-10-10T22:57:18.826413  / # /lava-437929/bin/lava-test-runner /lava=
-437929/1
    2023-10-10T22:57:18.858387  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525d6f4ff04f2ac90efcf34

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525d6f4ff04f2ac90efcf3d
        new failure (last pass: v5.10.177)

    2023-10-10T23:02:05.967475  / # #

    2023-10-10T23:02:06.069591  export SHELL=3D/bin/sh

    2023-10-10T23:02:06.070275  #

    2023-10-10T23:02:06.171587  / # export SHELL=3D/bin/sh. /lava-11731097/=
environment

    2023-10-10T23:02:06.172321  =


    2023-10-10T23:02:06.273740  / # . /lava-11731097/environment/lava-11731=
097/bin/lava-test-runner /lava-11731097/1

    2023-10-10T23:02:06.274809  =


    2023-10-10T23:02:06.292184  / # /lava-11731097/bin/lava-test-runner /la=
va-11731097/1

    2023-10-10T23:02:06.336325  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-10T23:02:06.349899  + cd /lava-1173109<8>[   18.244471] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11731097_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-a83t-bananapi-m3       | arm    | lab-clabbe    | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525d6e921280242f7efcf0f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm/multi_v7_defconfig/gcc-10/lab-clabbe/baseline-sun8i-a83t-bananapi-m3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.198/=
arm/multi_v7_defconfig/gcc-10/lab-clabbe/baseline-sun8i-a83t-bananapi-m3.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525d6e921280242f7efcf18
        failing since 279 days (last pass: v5.10.143, first fail: v5.10.162)

    2023-10-10T22:57:30.693077  / # [   15.879408] brcmfmac: brcmf_sdio_htc=
lk: HT Avail tim#
    2023-10-10T22:57:30.794910  export SHELL=3D/bin/sh
    2023-10-10T22:57:30.795612  eout (1000000): clkctl 0x50
    2023-10-10T22:57:30.795887  [   15.943592] usb-storage 2-1.1:1.0: USB M=
ass Storage device detected
    2023-10-10T22:57:30.796117  [   15.951822] scsi host0: usb-storage 2-1.=
1:1.0
    2023-10-10T22:57:30.796336  #[   15.964304] usbcore: registered new int=
erface driver uas
    2023-10-10T22:57:30.796560  =

    2023-10-10T22:57:30.897570  / # export SHELL=3D/bin/sh. /lava-437935/en=
vironment
    2023-10-10T22:57:30.898260  =

    2023-10-10T22:57:30.999349  / # . /lava-437935/environment/lava-437935/=
bin/lava-test-runner /lava-437935/1 =

    ... (21 line(s) more)  =

 =20
