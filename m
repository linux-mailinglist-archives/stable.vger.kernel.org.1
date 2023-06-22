Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BA073A1B9
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 15:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjFVNOn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 09:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjFVNOZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 09:14:25 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2476D1FEB
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 06:14:10 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-54faf8db79fso2934487a12.0
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 06:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687439650; x=1690031650;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7tmdOIV2dThlLAkN2HzS34HsYD3NA2k4AxbDvmRlZ0s=;
        b=Op9hYivlaR2hxXzVCqkxRLiHHnSJWZ/IkWQb7n7kc4+h+q8/MsVXtrY7Xw/nX3MCET
         y+iYoMdHEnCWfb9SdXBqtsXQZdZ9MLEMdyBSZIv26JgZoy5toYtfppTRe8zjTdj/fzDh
         0vB6cmxpIaUhXga+iWKorGWgqOaQQbQniQHCGuNupyj3HjJvo7yKRsy2WSw+JuYInT8G
         A+c1QocBqP7R6+hXzLLN5gZJI063Np6Xfs2VW/Zze1s2ywgp7qUYBzxImXQSerpTZbQU
         srDK422SwPqRYcCi4isYYzwkCjXPpdNztcNewTeum5YqIIO0HmCBZnZM+GZgRYbylSmk
         d+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687439650; x=1690031650;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7tmdOIV2dThlLAkN2HzS34HsYD3NA2k4AxbDvmRlZ0s=;
        b=M/qdG4UIY8j4vueWYtPyVY7AQn9UH8RuxF8kP08yo8uIqwVMgklQsNJC8KWp7X4IIG
         gIV+UW1Mdaq2BovYj8PdQ+Ni700pp7VJYweuV+WwqXDpJErb6e6r2sTMLoNN+kg3NgfL
         udMY+SWpFaijo35IGm2qN7toal/Bge9wuXmTtDqRd2zz3itNQzKRV5b9QK1hhVG36Nra
         eoUKkfI43MSC8Di5j1NiqiEv1/ES+AIDQgsd0SwN5p19JLpFX1Nb5zN36brfK9+ndXQd
         CU8o8i20BL1tOmKtWOdzaLuTlfeTnWR7Ug0sM3jF5xtBRT2a+VBVBoJLdHs2l6pfrtkX
         Vllg==
X-Gm-Message-State: AC+VfDwRG7FaYjadF0E5ppIBbzAG/AWodnByA3m02Kq0/WINAkOEFtrw
        ADDAJBcPxEaDImZwJpFlRcuvmpICAyIsojl20NWlcA==
X-Google-Smtp-Source: ACHHUZ5vhl0aJncbIbHEN3kAzKeI+aewUGyOUPKY9B4cfx+pMyDLV43dGOzlxtD0e0vVSSpCxYayXQ==
X-Received: by 2002:a17:90a:6f44:b0:25b:e747:103 with SMTP id d62-20020a17090a6f4400b0025be7470103mr14760326pjk.26.1687439649151;
        Thu, 22 Jun 2023 06:14:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z33-20020a634c21000000b00543e9e17207sm4805503pga.30.2023.06.22.06.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 06:14:08 -0700 (PDT)
Message-ID: <64944920.630a0220.ac88e.aa68@mx.google.com>
Date:   Thu, 22 Jun 2023 06:14:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.287-9-gfe2f114223c6
Subject: stable-rc/linux-4.19.y baseline: 125 runs,
 22 regressions (v4.19.287-9-gfe2f114223c6)
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

stable-rc/linux-4.19.y baseline: 125 runs, 22 regressions (v4.19.287-9-gfe2=
f114223c6)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

dell-latitude...4305U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

meson-gxl-s905d-p230         | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a7795-salvator-x           | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.19.y/ker=
nel/v4.19.287-9-gfe2f114223c6/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.287-9-gfe2f114223c6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      fe2f114223c6a057f2752a7450af835d943cf580 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64940fd6e38a2d6c5e30614d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64940fd6e38a2d6c5e306=
14e
        new failure (last pass: v4.19.287) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64940e411c8759dce530616f

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64940e411c8759dce53061a5
        failing since 0 day (last pass: v4.19.286-50-g3e62ea320ab2, first f=
ail: v4.19.287)

    2023-06-22T09:02:18.466711  + set +x<8>[   16.713260] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 650923_1.5.2.4.1>
    2023-06-22T09:02:18.467106  =

    2023-06-22T09:02:18.579121  / # #
    2023-06-22T09:02:18.682822  export SHELL=3D/bin/sh
    2023-06-22T09:02:18.683480  #
    2023-06-22T09:02:18.785484  / # export SHELL=3D/bin/sh. /lava-650923/en=
vironment
    2023-06-22T09:02:18.786339  =

    2023-06-22T09:02:18.888623  / # . /lava-650923/environment/lava-650923/=
bin/lava-test-runner /lava-650923/1
    2023-06-22T09:02:18.890034  =

    2023-06-22T09:02:18.893197  / # /lava-650923/bin/lava-test-runner /lava=
-650923/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64940e3d1c8759dce5306130

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebo=
ne-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebo=
ne-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64940e3d1c8759dce5306137
        failing since 0 day (last pass: v4.19.286-50-g3e62ea320ab2, first f=
ail: v4.19.287)

    2023-06-22T09:02:21.805423  / # #
    2023-06-22T09:02:21.908671  export SHELL=3D/bin/sh
    2023-06-22T09:02:21.909699  #
    2023-06-22T09:02:22.011965  / # export SHELL=3D/bin/sh. /lava-970997/en=
vironment
    2023-06-22T09:02:22.013035  =

    2023-06-22T09:02:22.115458  / # . /lava-970997/environment/lava-970997/=
bin/lava-test-runner /lava-970997/1
    2023-06-22T09:02:22.117063  =

    2023-06-22T09:02:22.157819  / # /lava-970997/bin/lava-test-runner /lava=
-970997/1
    2023-06-22T09:02:22.345920  + export 'TESTRUN_ID=3D1_bootrr'
    2023-06-22T09:02:22.346492  + cd /lava-970997/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64940efeb0f451b0b930615d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64940efeb0f451b0b9306166
        failing since 156 days (last pass: v4.19.268-50-gbf741d1d7e6d, firs=
t fail: v4.19.269-522-gc75d2b5524ab)

    2023-06-22T09:05:50.375408  + set +x<8>[    7.298765] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3686576_1.5.2.4.1>
    2023-06-22T09:05:50.376065  =

    2023-06-22T09:05:50.484688  / # #
    2023-06-22T09:05:50.587630  export SHELL=3D/bin/sh
    2023-06-22T09:05:50.588495  #
    2023-06-22T09:05:50.690307  / # export SHELL=3D/bin/sh. /lava-3686576/e=
nvironment
    2023-06-22T09:05:50.690709  =

    2023-06-22T09:05:50.792032  / # . /lava-3686576/environment/lava-368657=
6/bin/lava-test-runner /lava-3686576/1
    2023-06-22T09:05:50.793853  =

    2023-06-22T09:05:50.798396  / # /lava-3686576/bin/lava-test-runner /lav=
a-3686576/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
dell-latitude...4305U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649412633001b5e6da306145

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-dell-latitude-5400-4305U-sarien.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-dell-latitude-5400-4305U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649412633001b5e6da306=
146
        new failure (last pass: v4.19.287) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905d-p230         | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64940faf8b8e5c9a0530616f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl-s=
905d-p230.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl-s=
905d-p230.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64940faf8b8e5c9a05306178
        new failure (last pass: v4.19.287)

    2023-06-22T09:08:50.279567  + set +x<8>[   16.267267] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3686607_1.5.2.4.1>
    2023-06-22T09:08:50.279792  =

    2023-06-22T09:08:50.386486  / # #
    2023-06-22T09:08:50.490453  export SHELL=3D/bin/sh
    2023-06-22T09:08:50.491790  #
    2023-06-22T09:08:50.593923  / # export SHELL=3D/bin/sh. /lava-3686607/e=
nvironment
    2023-06-22T09:08:50.594939  =

    2023-06-22T09:08:50.697040  / # . /lava-3686607/environment/lava-368660=
7/bin/lava-test-runner /lava-3686607/1
    2023-06-22T09:08:50.697675  =

    2023-06-22T09:08:50.701612  / # /lava-3686607/bin/lava-test-runner /lav=
a-3686607/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649410a1455a7a9da1306160

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649410a1455a7a9da1306=
161
        failing since 407 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-89-g71a9ee8b0cfd) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649412ddf12ebdc97d306133

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649412ddf12ebdc97d306=
134
        failing since 407 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-89-g71a9ee8b0cfd) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649410b5d1cd26631830615f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649410b5d1cd266318306=
160
        failing since 407 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-89-g71a9ee8b0cfd) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649410a4455a7a9da1306166

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649410a4455a7a9da1306=
167
        failing since 407 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-89-g71a9ee8b0cfd) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64941408518e8205ad306168

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64941408518e8205ad306=
169
        failing since 407 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-89-g71a9ee8b0cfd) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6494110c399ba34de9306131

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6494110c399ba34de9306=
132
        failing since 407 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-89-g71a9ee8b0cfd) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649410a3d1cd266318306136

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649410a3d1cd266318306=
137
        failing since 407 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-89-g71a9ee8b0cfd) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649412deed238ca94230612f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649412deed238ca942306=
130
        failing since 407 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-89-g71a9ee8b0cfd) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649410c868f01f850330612e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649410c868f01f8503306=
12f
        failing since 407 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-89-g71a9ee8b0cfd) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649410a0ae521ff8a830615b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649410a0ae521ff8a8306=
15c
        failing since 407 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-89-g71a9ee8b0cfd) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649412b4f57b7f7dcc306148

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649412b4f57b7f7dcc306=
149
        failing since 407 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-89-g71a9ee8b0cfd) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649410b4d1cd266318306159

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649410b4d1cd266318306=
15a
        failing since 407 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-89-g71a9ee8b0cfd) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7795-salvator-x           | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64940f8fb6e4a383bf306136

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm64/defconfig/gcc-10/lab-baylibre/baseline-r8a7795-sal=
vator-x.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm64/defconfig/gcc-10/lab-baylibre/baseline-r8a7795-sal=
vator-x.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64940f8fb6e4a383bf30613f
        failing since 14 days (last pass: v4.19.261-20-g5644b22533b36, firs=
t fail: v4.19.284-89-ga1cebe658474)

    2023-06-22T09:08:26.033113  + set +x
    2023-06-22T09:08:26.036213  <8>[   12.033810] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3686618_1.5.2.4.1>
    2023-06-22T09:08:26.142550  / # #
    2023-06-22T09:08:26.245215  export SHELL=3D/bin/sh
    2023-06-22T09:08:26.245807  #
    2023-06-22T09:08:26.347456  / # export SHELL=3D/bin/sh. /lava-3686618/e=
nvironment
    2023-06-22T09:08:26.348040  =

    2023-06-22T09:08:26.449918  / # . /lava-3686618/environment/lava-368661=
8/bin/lava-test-runner /lava-3686618/1
    2023-06-22T09:08:26.451113  =

    2023-06-22T09:08:26.454756  / # /lava-3686618/bin/lava-test-runner /lav=
a-3686618/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64940fcbbab638dfc0306131

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64940fcbbab638dfc0306=
132
        failing since 14 days (last pass: v4.19.266-115-gf65c47c3f336, firs=
t fail: v4.19.284-89-ga1cebe658474) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649410463fb603947a306150

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-=
pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-=
pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649410473fb603947a306178
        failing since 156 days (last pass: v4.19.265-42-ga2d8c749b30c, firs=
t fail: v4.19.269-522-gc75d2b5524ab)

    2023-06-22T09:10:59.202453  <8>[   15.885032] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3686619_1.5.2.4.1>
    2023-06-22T09:10:59.321795  / # #
    2023-06-22T09:10:59.427627  export SHELL=3D/bin/sh
    2023-06-22T09:10:59.429273  #
    2023-06-22T09:10:59.532815  / # export SHELL=3D/bin/sh. /lava-3686619/e=
nvironment
    2023-06-22T09:10:59.534415  =

    2023-06-22T09:10:59.638108  / # . /lava-3686619/environment/lava-368661=
9/bin/lava-test-runner /lava-3686619/1
    2023-06-22T09:10:59.640987  =

    2023-06-22T09:10:59.644012  / # /lava-3686619/bin/lava-test-runner /lav=
a-3686619/1
    2023-06-22T09:10:59.675414  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649411933653d13aa230614b

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-p=
ine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
87-9-gfe2f114223c6/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-p=
ine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649411933653d13aa2306175
        failing since 156 days (last pass: v4.19.265-42-ga2d8c749b30c, firs=
t fail: v4.19.269-522-gc75d2b5524ab)

    2023-06-22T09:16:29.446182  <8>[   15.938139] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 651083_1.5.2.4.1>
    2023-06-22T09:16:29.551577  / # #
    2023-06-22T09:16:29.653550  export SHELL=3D/bin/sh
    2023-06-22T09:16:29.654115  #
    2023-06-22T09:16:29.755503  / # export SHELL=3D/bin/sh. /lava-651083/en=
vironment
    2023-06-22T09:16:29.756167  =

    2023-06-22T09:16:29.857742  / # . /lava-651083/environment/lava-651083/=
bin/lava-test-runner /lava-651083/1
    2023-06-22T09:16:29.858542  =

    2023-06-22T09:16:29.862663  / # /lava-651083/bin/lava-test-runner /lava=
-651083/1
    2023-06-22T09:16:29.894339  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
