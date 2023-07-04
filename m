Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B332F746649
	for <lists+stable@lfdr.de>; Tue,  4 Jul 2023 02:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjGDAA5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 20:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGDAAy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 20:00:54 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C2A13D
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 17:00:51 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b71ee710edso3961613a34.2
        for <stable@vger.kernel.org>; Mon, 03 Jul 2023 17:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688428850; x=1691020850;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mA+TuQr6+pjIkVpdH0W5Vbs5Z+JngCDbXGuq9KIaRTo=;
        b=PleZq1QLvlR7x/dCpCH4UoG+RDcrY63odF/AhmBa/IVEVHJBms1mw0mTUlsyrAqXN0
         s6c9DDr+02ADJMPFQN1xGojDYlgRQdGnzXo3cnqVwDmDrRVpqDYS0Fu3tTrds1sGarR3
         aoySSsHM6Yc5RS/5IEBytXiT0l9w3LtHR8QwaBhUqdMVW9o44KqTgg5vkNYxBC9rnH6e
         0PE45pSC11KSaXAHM0An16/KiKWLPBBO2LY9Xi9EEpqeHw0//1WcUt9GCdg3lIMHlAwT
         HSFPmPeqLVXEyozA5JsoKnb3DzluX/4gbPq250w8tmghQza4rJS3dAHQk4CmNHcDd2Z4
         xXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688428850; x=1691020850;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mA+TuQr6+pjIkVpdH0W5Vbs5Z+JngCDbXGuq9KIaRTo=;
        b=bQW5cVg0Hngkz3qV3kOPawWnVdo4MWMgiIzbgUA8dZXa8MRKiXMsd3yR2sjj+0dogm
         a9Au0G2XEMaATsk+XM3PTnArxOe6wujW7H41hRgQWWVeXDsaW1Lewg2cBY5rNZO+7TUq
         YPez8GYxjkPREt2H/naHlljC2FBNxoGn0agHwxkUb4iTpy1gg9fRoBEJ/UNtfbviz/4U
         HXJkLjuiEolKQE5Pp0DSFCKM5d9uGq7R8D4AiyhEi7poUorKp7NczMsiVNLcCXlvayqv
         tUUMzD86XrJRlN52SQ/BQqHymGPNLIX2xAjGyi5z1XG9zyBt5DMpHEdqHoxXVFBmzVxM
         8k3A==
X-Gm-Message-State: ABy/qLbY+3NOjyAPB0stB5EjThpoRsI313OCWWG5gcVqQ3i/zB3aIswn
        97IuzmKA6BmAXqr/thRn3JTJGF7f4n+Y0E5mrngo6g==
X-Google-Smtp-Source: APBJJlHhxu4plq4wlZuy5uh9BcDnoSynwqwWEWCVu5zbpXeQbGr5iaBknd9mwpqvYsUtHmUa9ONsZA==
X-Received: by 2002:a05:6358:9d81:b0:12f:2573:45b4 with SMTP id d1-20020a0563589d8100b0012f257345b4mr7199156rwo.26.1688428850307;
        Mon, 03 Jul 2023 17:00:50 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jw19-20020a170903279300b001b7ed16c7ffsm15045063plb.306.2023.07.03.17.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 17:00:49 -0700 (PDT)
Message-ID: <64a36131.170a0220.b3928.dc01@mx.google.com>
Date:   Mon, 03 Jul 2023 17:00:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.288-8-g4d52374bfbe40
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.19.y
Subject: stable-rc/linux-4.19.y baseline: 129 runs,
 19 regressions (v4.19.288-8-g4d52374bfbe40)
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

stable-rc/linux-4.19.y baseline: 129 runs, 19 regressions (v4.19.288-8-g4d5=
2374bfbe40)

Regressions Summary
-------------------

platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
at91sam9g20ek              | arm   | lab-broonie   | gcc-10   | multi_v5_de=
fconfig | 1          =

cubietruck                 | arm   | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig | 1          =

meson-gxbb-p200            | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =

r8a7795-salvator-x         | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =

rk3328-rock64              | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =

sun50i-a64-pine64-plus     | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =

sun50i-a64-pine64-plus     | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.19.y/ker=
nel/v4.19.288-8-g4d52374bfbe40/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.288-8-g4d52374bfbe40
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      4d52374bfbe40fe32dc25403ada425827537346a =



Test Regressions
---------------- =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
at91sam9g20ek              | arm   | lab-broonie   | gcc-10   | multi_v5_de=
fconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64a32863acbba4fac6bb2a98

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91=
sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91=
sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a32863acbba4fac6bb2aca
        failing since 3 days (last pass: v4.19.287, first fail: v4.19.288-6=
-g9430a6475aa0)

    2023-07-03T19:57:47.280454  + set +x
    2023-07-03T19:57:47.285638  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 691482_1.5.2=
.4.1>
    2023-07-03T19:57:47.398648  / # #
    2023-07-03T19:57:47.501458  export SHELL=3D/bin/sh
    2023-07-03T19:57:47.502332  #
    2023-07-03T19:57:47.604356  / # export SHELL=3D/bin/sh. /lava-691482/en=
vironment
    2023-07-03T19:57:47.605224  =

    2023-07-03T19:57:47.707251  / # . /lava-691482/environment/lava-691482/=
bin/lava-test-runner /lava-691482/1
    2023-07-03T19:57:47.708536  =

    2023-07-03T19:57:47.715086  / # /lava-691482/bin/lava-test-runner /lava=
-691482/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
cubietruck                 | arm   | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64a32a701f8cd03eb2bb2a93

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a32a701f8cd03eb2bb2a98
        failing since 167 days (last pass: v4.19.268-50-gbf741d1d7e6d, firs=
t fail: v4.19.269-522-gc75d2b5524ab)

    2023-07-03T20:06:48.213086  + set +x<8>[    7.327465] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3708311_1.5.2.4.1>
    2023-07-03T20:06:48.213653  =

    2023-07-03T20:06:48.324187  / # #
    2023-07-03T20:06:48.427176  export SHELL=3D/bin/sh
    2023-07-03T20:06:48.428050  #
    2023-07-03T20:06:48.530133  / # export SHELL=3D/bin/sh. /lava-3708311/e=
nvironment
    2023-07-03T20:06:48.531124  =

    2023-07-03T20:06:48.633286  / # . /lava-3708311/environment/lava-370831=
1/bin/lava-test-runner /lava-3708311/1
    2023-07-03T20:06:48.634699  =

    2023-07-03T20:06:48.639419  / # /lava-3708311/bin/lava-test-runner /lav=
a-3708311/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
meson-gxbb-p200            | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/64a32cad888e0dba8fbb2a76

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb=
-p200.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb=
-p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a32cad888e0dba8fbb2a7b
        new failure (last pass: v4.19.288-6-g9430a6475aa0)

    2023-07-03T20:16:15.619356  / # #
    2023-07-03T20:16:15.724809  export SHELL=3D/bin/sh
    2023-07-03T20:16:15.726607  #
    2023-07-03T20:16:15.830092  / # export SHELL=3D/bin/sh. /lava-3708357/e=
nvironment
    2023-07-03T20:16:15.831998  =

    2023-07-03T20:16:15.936221  / # . /lava-3708357/environment/lava-370835=
7/bin/lava-test-runner /lava-3708357/1
    2023-07-03T20:16:15.940016  =

    2023-07-03T20:16:15.955865  / # /lava-3708357/bin/lava-test-runner /lav=
a-3708357/1
    2023-07-03T20:16:16.004612  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-03T20:16:16.006288  + cd /lava-3708357/1/tests/1_bootrr =

    ... (11 line(s) more)  =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/64a32cdddefee2509cbb2ae6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64=
-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64=
-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a32cdddefee2509cbb2=
ae7
        failing since 419 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-89-g71a9ee8b0cfd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/64a32e1d071c4eff24bb2ae3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-=
virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-=
virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a32e1d071c4eff24bb2=
ae4
        failing since 419 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-89-g71a9ee8b0cfd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/64a32cdf00695c81d0bb2a78

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm6=
4-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm6=
4-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a32cdf00695c81d0bb2=
a79
        failing since 419 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-89-g71a9ee8b0cfd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/64a32cdbfe09a7f52fbb2a9c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64=
-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64=
-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a32cdbfe09a7f52fbb2=
a9d
        failing since 308 days (last pass: v4.19.230-41-g73351b9c55d9, firs=
t fail: v4.19.256-37-g34c3cf0160a8) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/64a32e0937934bd50fbb2aa6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-=
virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-=
virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a32e0937934bd50fbb2=
aa7
        failing since 308 days (last pass: v4.19.230-41-g73351b9c55d9, firs=
t fail: v4.19.256-37-g34c3cf0160a8) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/64a32cd81bef4d9825bb2ac4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm6=
4-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm6=
4-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a32cd81bef4d9825bb2=
ac5
        failing since 308 days (last pass: v4.19.230-41-g73351b9c55d9, firs=
t fail: v4.19.256-37-g34c3cf0160a8) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/64a32cdc1bef4d9825bb2acc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64=
-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64=
-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a32cdc1bef4d9825bb2=
acd
        failing since 419 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-89-g71a9ee8b0cfd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/64a32e0bbff4d49148bb2aa8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-=
virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-=
virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a32e0bbff4d49148bb2=
aa9
        failing since 419 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-89-g71a9ee8b0cfd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/64a32cdedefee2509cbb2ae9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm6=
4-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm6=
4-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a32cdedefee2509cbb2=
aea
        failing since 419 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-89-g71a9ee8b0cfd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/64a32cde3e28f67647bb2a75

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64=
-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64=
-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a32cde3e28f67647bb2=
a76
        failing since 419 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-89-g71a9ee8b0cfd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/64a32e32771056ef47bb2a97

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-=
virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-=
virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a32e32771056ef47bb2=
a98
        failing since 419 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-89-g71a9ee8b0cfd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/64a32ce066a4425275bb2a77

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm6=
4-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm6=
4-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a32ce066a4425275bb2=
a78
        failing since 419 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-89-g71a9ee8b0cfd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
r8a7795-salvator-x         | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/64a32bd79622a630fabb2a9c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm64/defconfig/gcc-10/lab-baylibre/baseline-r8a7795-sa=
lvator-x.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm64/defconfig/gcc-10/lab-baylibre/baseline-r8a7795-sa=
lvator-x.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a32bd79622a630fabb2aa1
        failing since 25 days (last pass: v4.19.261-20-g5644b22533b36, firs=
t fail: v4.19.284-89-ga1cebe658474)

    2023-07-03T20:12:56.515447  + set +x
    2023-07-03T20:12:56.518601  <8>[    8.757230] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3708354_1.5.2.4.1>
    2023-07-03T20:12:56.625042  / # #
    2023-07-03T20:12:56.727889  export SHELL=3D/bin/sh
    2023-07-03T20:12:56.728661  #
    2023-07-03T20:12:56.830547  / # export SHELL=3D/bin/sh. /lava-3708354/e=
nvironment
    2023-07-03T20:12:56.831044  =

    2023-07-03T20:12:56.932422  / # . /lava-3708354/environment/lava-370835=
4/bin/lava-test-runner /lava-3708354/1
    2023-07-03T20:12:56.933191  =

    2023-07-03T20:12:56.936985  / # /lava-3708354/bin/lava-test-runner /lav=
a-3708354/1 =

    ... (13 line(s) more)  =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
rk3328-rock64              | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/64a32bff6e286bb638bb2aa3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-roc=
k64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-roc=
k64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a32bff6e286bb638bb2=
aa4
        failing since 25 days (last pass: v4.19.266-115-gf65c47c3f336, firs=
t fail: v4.19.284-89-ga1cebe658474) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
sun50i-a64-pine64-plus     | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/64a32cea00695c81d0bb2a8e

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64=
-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64=
-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a32cea00695c81d0bb2ab2
        failing since 167 days (last pass: v4.19.265-42-ga2d8c749b30c, firs=
t fail: v4.19.269-522-gc75d2b5524ab)

    2023-07-03T20:16:51.324193  <8>[   15.912822] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3708362_1.5.2.4.1>
    2023-07-03T20:16:51.448888  / # #
    2023-07-03T20:16:51.555636  export SHELL=3D/bin/sh
    2023-07-03T20:16:51.557427  #
    2023-07-03T20:16:51.661619  / # export SHELL=3D/bin/sh. /lava-3708362/e=
nvironment
    2023-07-03T20:16:51.663385  =

    2023-07-03T20:16:51.767933  / # . /lava-3708362/environment/lava-370836=
2/bin/lava-test-runner /lava-3708362/1
    2023-07-03T20:16:51.771669  =

    2023-07-03T20:16:51.774010  / # /lava-3708362/bin/lava-test-runner /lav=
a-3708362/1
    2023-07-03T20:16:51.805837  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
sun50i-a64-pine64-plus     | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3362c074e7937e0bb2b63

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-=
pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-g4d52374bfbe40/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-=
pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3362c074e7937e0bb2b89
        failing since 167 days (last pass: v4.19.265-42-ga2d8c749b30c, firs=
t fail: v4.19.269-522-gc75d2b5524ab)

    2023-07-03T20:56:40.976703  <8>[   15.938870] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 691605_1.5.2.4.1>
    2023-07-03T20:56:41.082402  / # #
    2023-07-03T20:56:41.184543  export SHELL=3D/bin/sh
    2023-07-03T20:56:41.185215  #
    2023-07-03T20:56:41.287030  / # export SHELL=3D/bin/sh. /lava-691605/en=
vironment
    2023-07-03T20:56:41.287981  =

    2023-07-03T20:56:41.389664  / # . /lava-691605/environment/lava-691605/=
bin/lava-test-runner /lava-691605/1
    2023-07-03T20:56:41.390551  =

    2023-07-03T20:56:41.394209  / # /lava-691605/bin/lava-test-runner /lava=
-691605/1
    2023-07-03T20:56:41.426134  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
