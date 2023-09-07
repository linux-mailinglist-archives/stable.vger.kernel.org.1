Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EA4796EFC
	for <lists+stable@lfdr.de>; Thu,  7 Sep 2023 04:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjIGCdA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 6 Sep 2023 22:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238557AbjIGCc6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 6 Sep 2023 22:32:58 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35AB1FD4
        for <stable@vger.kernel.org>; Wed,  6 Sep 2023 19:32:24 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3aa1254fb45so311928b6e.2
        for <stable@vger.kernel.org>; Wed, 06 Sep 2023 19:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694053939; x=1694658739; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0rchzppWmJgbBMQ6IsgGZZ2sBl0bdQA0YVK2p0gwV4=;
        b=Va7etpp3OAmm/2gjtMuEJR9QBAvihZ2za9j/KxqnRaqsQMFah+hCeqqBokDxjV+c/6
         9RG6uRG+iDYHmgk0HGuWcPHlnKTgowVD22LaTX/hRMFD66N7n6FnmX5wcME983qN0iq9
         XDmO6IdJU86VTUlFnu6u9j1f13FQiyGkxjZ+YuqqceV9fC+vlXRZCj13ZacOTnH040j1
         wemJRaetAlHh83ZwM/9HSxsc9vLvJH9JbWDiPU3HChhPGbYEm9Kdi2DKgzZKEOYvdpXj
         9TxZd2AGS5OqkY+0beU+nAnTwSfsX3kt3Nsy+krdqCH70DiMMbrx464+/zxd20DfLORW
         fimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694053939; x=1694658739;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y0rchzppWmJgbBMQ6IsgGZZ2sBl0bdQA0YVK2p0gwV4=;
        b=IRQBDnxEqlixgf3P/90+e+TDTCL7CutYUdQYbjuWV46SuvM0+txd3FRCDB9dbSyAtx
         NTHFXsUMK6XphH13O+JCwXJKcgooOJ14MujfjmmzyGAxHM1YtnW4Lj2IKBFZHFegk6hX
         OW9lpLousfQdOHkqIXljhh3wARaxBXQAIKr40qr/eI7QTz0rgbH6PXxTpl78G44zLQvg
         HRMvOGB2TMLjew3v5isgOMAAugii76PFXsubytxr1K3fIbs8kq5JNKDFVWY4WWE1wbgi
         UOraEX5iFflPiyjZRFIDCjFbzSqOA27tGNNDC9nURP97V9sMuEnkkWisfVIF8w6fhk48
         NRGA==
X-Gm-Message-State: AOJu0Yy3n42OXa64K5CGD0lHyuvoY79R2w7hODA7THyLeQjozLF1eMze
        5e6yY1ZDWP66c8xv/cLju5vkAkC8pgHuI4SsrHfMig==
X-Google-Smtp-Source: AGHT+IExl66lM0LRGzNQIoIeaHy5m+uy7OSHC2epGAh1GCpXPMmABiYxFkblgHQCMsQPdJyZRSKOiQ==
X-Received: by 2002:a05:6808:f88:b0:3a1:c75d:b6ab with SMTP id o8-20020a0568080f8800b003a1c75db6abmr20737321oiw.40.1694053938649;
        Wed, 06 Sep 2023 19:32:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i10-20020a633c4a000000b0056c2f1a2f6bsm828118pgn.41.2023.09.06.19.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 19:32:18 -0700 (PDT)
Message-ID: <64f93632.630a0220.8130a.3122@mx.google.com>
Date:   Wed, 06 Sep 2023 19:32:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.131
Subject: stable/linux-5.15.y baseline: 133 runs, 22 regressions (v5.15.131)
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

stable/linux-5.15.y baseline: 133 runs, 22 regressions (v5.15.131)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =

fsl-ls1028a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g+kselftest          | 1          =

fsl-ls1088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g+kselftest          | 1          =

fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g+kselftest          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g+kselftest          | 1          =

kontron-sl28-var3-ads2       | arm64  | lab-kontron   | gcc-10   | defconfi=
g+kselftest          | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =

mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =

sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.15.y/kernel=
/v5.15.131/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.15.y
  Describe: v5.15.131
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      aff03380bda4d25717170b42c92b54143aec0a36 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64f8fa73a3d24913d0286dbc

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f8fa73a3d24913d0286dc1
        failing since 160 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-06T22:18:09.897131  <8>[   12.244700] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11451342_1.4.2.3.1>

    2023-09-06T22:18:09.900939  + set +x

    2023-09-06T22:18:10.006494  #

    2023-09-06T22:18:10.007869  =


    2023-09-06T22:18:10.109544  / # #export SHELL=3D/bin/sh

    2023-09-06T22:18:10.110206  =


    2023-09-06T22:18:10.211572  / # export SHELL=3D/bin/sh. /lava-11451342/=
environment

    2023-09-06T22:18:10.212306  =


    2023-09-06T22:18:10.313689  / # . /lava-11451342/environment/lava-11451=
342/bin/lava-test-runner /lava-11451342/1

    2023-09-06T22:18:10.314810  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64f8fa72a3d24913d0286da6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f8fa72a3d24913d0286dab
        failing since 160 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-06T22:17:08.431681  <8>[   12.236744] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11451352_1.4.2.3.1>

    2023-09-06T22:17:08.540194  / # #

    2023-09-06T22:17:08.642513  export SHELL=3D/bin/sh

    2023-09-06T22:17:08.643268  #

    2023-09-06T22:17:08.744631  / # export SHELL=3D/bin/sh. /lava-11451352/=
environment

    2023-09-06T22:17:08.745319  =


    2023-09-06T22:17:08.846736  / # . /lava-11451352/environment/lava-11451=
352/bin/lava-test-runner /lava-11451352/1

    2023-09-06T22:17:08.847814  =


    2023-09-06T22:17:08.852800  / # /lava-11451352/bin/lava-test-runner /la=
va-11451352/1

    2023-09-06T22:17:08.865593  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64f8fcac03ec45a990286d8f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f8fcac03ec45a990286d94
        failing since 160 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-06T22:26:27.231382  <8>[   11.043472] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11451354_1.4.2.3.1>

    2023-09-06T22:26:27.234795  + set +x

    2023-09-06T22:26:27.341098  =


    2023-09-06T22:26:27.442907  / # #export SHELL=3D/bin/sh

    2023-09-06T22:26:27.443666  =


    2023-09-06T22:26:27.545302  / # export SHELL=3D/bin/sh. /lava-11451354/=
environment

    2023-09-06T22:26:27.546189  =


    2023-09-06T22:26:27.647728  / # . /lava-11451354/environment/lava-11451=
354/bin/lava-test-runner /lava-11451354/1

    2023-09-06T22:26:27.649064  =


    2023-09-06T22:26:27.654162  / # /lava-11451354/bin/lava-test-runner /la=
va-11451354/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/64f8faaa7b61e09b88286d7b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f8faaa7b61e09b88286d80
        failing since 41 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-09-06T22:19:37.519524  / # #

    2023-09-06T22:19:37.621822  export SHELL=3D/bin/sh

    2023-09-06T22:19:37.622547  #

    2023-09-06T22:19:37.723954  / # export SHELL=3D/bin/sh. /lava-11451369/=
environment

    2023-09-06T22:19:37.724683  =


    2023-09-06T22:19:37.826159  / # . /lava-11451369/environment/lava-11451=
369/bin/lava-test-runner /lava-11451369/1

    2023-09-06T22:19:37.827292  =


    2023-09-06T22:19:37.869487  / # /lava-11451369/bin/lava-test-runner /la=
va-11451369/1

    2023-09-06T22:19:37.952413  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-06T22:19:37.952949  + cd /lava-11451369/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f906667ef18915af286d6e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
arm64/defconfig+kselftest/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
arm64/defconfig+kselftest/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f906677ef18915af286=
d6f
        failing since 4 days (last pass: v5.15.128, first fail: v5.15.130) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls1088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f906526eb01202d3286d7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
arm64/defconfig+kselftest/gcc-10/lab-nxp/baseline-fsl-ls1088a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
arm64/defconfig+kselftest/gcc-10/lab-nxp/baseline-fsl-ls1088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f906526eb01202d3286=
d7b
        failing since 4 days (last pass: v5.15.128, first fail: v5.15.130) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f906696eb01202d3286d80

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
arm64/defconfig+kselftest/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
arm64/defconfig+kselftest/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f906696eb01202d3286=
d81
        failing since 4 days (last pass: v5.15.128, first fail: v5.15.130) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64f8fc0a18c05b8baa286d6d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f8fc0a18c05b8baa286d72
        failing since 160 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-06T22:23:47.461650  + set +x

    2023-09-06T22:23:47.467892  <8>[   12.434867] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11451346_1.4.2.3.1>

    2023-09-06T22:23:47.575369  / # #

    2023-09-06T22:23:47.677973  export SHELL=3D/bin/sh

    2023-09-06T22:23:47.678657  #

    2023-09-06T22:23:47.780376  / # export SHELL=3D/bin/sh. /lava-11451346/=
environment

    2023-09-06T22:23:47.781156  =


    2023-09-06T22:23:47.882728  / # . /lava-11451346/environment/lava-11451=
346/bin/lava-test-runner /lava-11451346/1

    2023-09-06T22:23:47.883907  =


    2023-09-06T22:23:47.888833  / # /lava-11451346/bin/lava-test-runner /la=
va-11451346/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64f8fa3ad2dde92fae286d6f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f8fa3ad2dde92fae286d74
        failing since 160 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-06T22:16:17.612074  + set +x

    2023-09-06T22:16:17.618388  <8>[   11.430984] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11451335_1.4.2.3.1>

    2023-09-06T22:16:17.722773  / # #

    2023-09-06T22:16:17.823438  export SHELL=3D/bin/sh

    2023-09-06T22:16:17.823704  #

    2023-09-06T22:16:17.924218  / # export SHELL=3D/bin/sh. /lava-11451335/=
environment

    2023-09-06T22:16:17.924424  =


    2023-09-06T22:16:18.024940  / # . /lava-11451335/environment/lava-11451=
335/bin/lava-test-runner /lava-11451335/1

    2023-09-06T22:16:18.025273  =


    2023-09-06T22:16:18.030744  / # /lava-11451335/bin/lava-test-runner /la=
va-11451335/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64f8fa6ea3d24913d0286d87

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f8fa6ea3d24913d0286d8c
        failing since 160 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-06T22:16:59.177351  + <8>[   12.149639] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11451361_1.4.2.3.1>

    2023-09-06T22:16:59.177745  set +x

    2023-09-06T22:16:59.284846  / # #

    2023-09-06T22:16:59.386828  export SHELL=3D/bin/sh

    2023-09-06T22:16:59.387037  #

    2023-09-06T22:16:59.487743  / # export SHELL=3D/bin/sh. /lava-11451361/=
environment

    2023-09-06T22:16:59.488445  =


    2023-09-06T22:16:59.589831  / # . /lava-11451361/environment/lava-11451=
361/bin/lava-test-runner /lava-11451361/1

    2023-09-06T22:16:59.590926  =


    2023-09-06T22:16:59.595707  / # /lava-11451361/bin/lava-test-runner /la=
va-11451361/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f90620b5c16b6bec286d76

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
arm64/defconfig+kselftest/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls=
.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
arm64/defconfig+kselftest/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f90620b5c16b6bec286=
d77
        failing since 4 days (last pass: v5.15.128, first fail: v5.15.130) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-sl28-var3-ads2       | arm64  | lab-kontron   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f906226bfe8d57fe286d85

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
arm64/defconfig+kselftest/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads=
2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
arm64/defconfig+kselftest/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads=
2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f906226bfe8d57fe286=
d86
        new failure (last pass: v5.15.128) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64f8fa5ad2dde92fae286d98

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f8fa5ad2dde92fae286d9d
        failing since 160 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-06T22:16:44.398642  + <8>[   13.402062] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11451353_1.4.2.3.1>

    2023-09-06T22:16:44.398762  set +x

    2023-09-06T22:16:44.503378  / # #

    2023-09-06T22:16:44.604110  export SHELL=3D/bin/sh

    2023-09-06T22:16:44.604343  #

    2023-09-06T22:16:44.704849  / # export SHELL=3D/bin/sh. /lava-11451353/=
environment

    2023-09-06T22:16:44.705087  =


    2023-09-06T22:16:44.805630  / # . /lava-11451353/environment/lava-11451=
353/bin/lava-test-runner /lava-11451353/1

    2023-09-06T22:16:44.805993  =


    2023-09-06T22:16:44.811453  / # /lava-11451353/bin/lava-test-runner /la=
va-11451353/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f90606b5c16b6bec286d6c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
arm64/defconfig+kselftest/gcc-10/lab-broonie/baseline-meson-gxl-s905x-libre=
tech-cc.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
arm64/defconfig+kselftest/gcc-10/lab-broonie/baseline-meson-gxl-s905x-libre=
tech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f90606b5c16b6bec286=
d6d
        failing since 4 days (last pass: v5.15.128, first fail: v5.15.130) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64f903b9571cb73ce3286d6e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f903b9571cb73ce3286=
d6f
        failing since 225 days (last pass: v5.15.89, first fail: v5.15.90) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f9022f5dea1f9047286d6c

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f9022f5dea1f9047286d75
        failing since 41 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-09-06T22:51:47.560074  / # #

    2023-09-06T22:51:47.660684  export SHELL=3D/bin/sh

    2023-09-06T22:51:47.660854  #

    2023-09-06T22:51:47.761403  / # export SHELL=3D/bin/sh. /lava-11451665/=
environment

    2023-09-06T22:51:47.761620  =


    2023-09-06T22:51:47.862241  / # . /lava-11451665/environment/lava-11451=
665/bin/lava-test-runner /lava-11451665/1

    2023-09-06T22:51:47.862549  =


    2023-09-06T22:51:47.873565  / # /lava-11451665/bin/lava-test-runner /la=
va-11451665/1

    2023-09-06T22:51:47.917027  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-06T22:51:47.932619  + cd /lav<8>[   15.917732] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11451665_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f9026671e545a088286d6e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f9026771e545a088286d77
        failing since 41 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-09-06T22:51:09.068551  / # #

    2023-09-06T22:51:10.146178  export SHELL=3D/bin/sh

    2023-09-06T22:51:10.147410  #

    2023-09-06T22:51:11.633856  / # export SHELL=3D/bin/sh. /lava-11451653/=
environment

    2023-09-06T22:51:11.635796  =


    2023-09-06T22:51:14.359316  / # . /lava-11451653/environment/lava-11451=
653/bin/lava-test-runner /lava-11451653/1

    2023-09-06T22:51:14.361475  =


    2023-09-06T22:51:14.376240  / # /lava-11451653/bin/lava-test-runner /la=
va-11451653/1

    2023-09-06T22:51:14.392485  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-06T22:51:14.435265  + cd /lava-114516<8>[   25.483863] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11451653_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f90622b5c16b6bec286d7b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f90622b5c16b6bec286=
d7c
        failing since 4 days (last pass: v5.15.128, first fail: v5.15.130) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f906206eb01202d3286d71

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.t=
xt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f906206eb01202d3286=
d72
        failing since 4 days (last pass: v5.15.128, first fail: v5.15.130) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f906066bfe8d57fe286d7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
arm64/defconfig+kselftest/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plu=
s.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
arm64/defconfig+kselftest/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plu=
s.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f906066bfe8d57fe286=
d7b
        failing since 4 days (last pass: v5.15.128, first fail: v5.15.130) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f90608b5c16b6bec286d70

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
arm64/defconfig+kselftest/gcc-10/lab-broonie/baseline-sun50i-h5-libretech-a=
ll-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
arm64/defconfig+kselftest/gcc-10/lab-broonie/baseline-sun50i-h5-libretech-a=
ll-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f90608b5c16b6bec286=
d71
        new failure (last pass: v5.15.128) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f90240ca12ae41cf286d6d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.131/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f90240ca12ae41cf286d76
        failing since 41 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-09-06T22:52:04.186005  / # #

    2023-09-06T22:52:04.287891  export SHELL=3D/bin/sh

    2023-09-06T22:52:04.288102  #

    2023-09-06T22:52:04.388613  / # export SHELL=3D/bin/sh. /lava-11451662/=
environment

    2023-09-06T22:52:04.388746  =


    2023-09-06T22:52:04.489212  / # . /lava-11451662/environment/lava-11451=
662/bin/lava-test-runner /lava-11451662/1

    2023-09-06T22:52:04.489415  =


    2023-09-06T22:52:04.499380  / # /lava-11451662/bin/lava-test-runner /la=
va-11451662/1

    2023-09-06T22:52:04.561461  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-06T22:52:04.561570  + cd /lava-1145166<8>[   16.846109] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11451662_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
