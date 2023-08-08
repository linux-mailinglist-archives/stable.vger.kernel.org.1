Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D56774F01
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 01:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjHHXLo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 8 Aug 2023 19:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjHHXLo (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 Aug 2023 19:11:44 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559FE1995
        for <stable@vger.kernel.org>; Tue,  8 Aug 2023 16:11:42 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-686e29b058cso4476865b3a.1
        for <stable@vger.kernel.org>; Tue, 08 Aug 2023 16:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691536301; x=1692141101;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OHpKbGWOv0XyJFwVi9pQl743CcsSSxaG3rDMy9sym9g=;
        b=fCTq0aj0Q0pyMQdIPkaZm7xgKxjQLJS1vuxgLGHdWf/g6W7Z48k+7MeVJHmQw4Gliy
         pDlmxTAs1gciyVgPts40uoC8FWMPODpoz4u/X6rtMZ125viaINIhlevMXrepar2y2k5q
         QDA1djuh58Dt1gW2e16yK0Wl7iVsEIHDahBnAOPHTviqrPlKT+JsAGhZyf0lgYCdSmav
         D+riFJPjUa7Bfbu12o4VGG0xtbGKeKE2iI8LqKsFvfYAma5UfaxknZ04ZfLfA6veOO9W
         BUNWvZzQMOvGTFKyN/31SVAG5i98oL275ydxOx1UfWa++9YvaCzBy1vmQpfM4/xLXxtK
         h3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691536301; x=1692141101;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OHpKbGWOv0XyJFwVi9pQl743CcsSSxaG3rDMy9sym9g=;
        b=BZIulYoLrAkzloZNXYA2qovauuylJvHnT1DL6/GEsafTVq4xisFFmsIA1RrIkrtCHg
         XaJv5rbiqchmmvLfvGu6d+RJ5W8p9TdpuR/PzUWAfANSdnnuFcP7oTlrtmzFD/yIWEFa
         mt84GA9wU+R7VR4o3YC4MIDoz8q0HV/xhNSJlMOQ9IHnsWFdWtkwF+yiH3MBCojrrLbs
         L1riXhPMGAwLyOf8cBh7nQmthFtUiJ/0QpJgoMkPQrAyfL1GN/hB72EypQsXzAqsPb8G
         BmABSIk2u5xtvjNLKSj4rp/07D16DIH9OVSk2nKMa0bXTRO87OVMMUVfuxBVGRaLzxoy
         26AQ==
X-Gm-Message-State: AOJu0YzMfcZ85oycwSAJ0+TO40koPx2+I/CCCkAq/7zydseL87FbAvZq
        hYZGAtQrFtLIuyRzMY1X6odn+7DbaJRfLA1I4BHeVg==
X-Google-Smtp-Source: AGHT+IHXk788kkT82tObh/7Pu4yKfDemvNMGNvYHZ23hokN/D428WCbhQU5MEmVIUhPl6l851NScUA==
X-Received: by 2002:a05:6a21:3281:b0:13d:ea25:9642 with SMTP id yt1-20020a056a21328100b0013dea259642mr1167284pzb.6.1691536301071;
        Tue, 08 Aug 2023 16:11:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ff17-20020a056a002f5100b006875493da20sm8620063pfb.3.2023.08.08.16.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 16:11:40 -0700 (PDT)
Message-ID: <64d2cbac.050a0220.118e5.fc92@mx.google.com>
Date:   Tue, 08 Aug 2023 16:11:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.4.252
X-Kernelci-Tree: stable
X-Kernelci-Branch: linux-5.4.y
Subject: stable/linux-5.4.y baseline: 107 runs, 25 regressions (v5.4.252)
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

stable/linux-5.4.y baseline: 107 runs, 25 regressions (v5.4.252)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-R721T-grunt             | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

fsl-ls1028a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

imx6ul-14x14-evk             | arm    | lab-nxp       | gcc-10   | multi_v7=
_defconfig           | 1          =

imx7d-sdb                    | arm    | lab-nxp       | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.4.y/kernel/=
v5.4.252/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.4.y
  Describe: v5.4.252
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      21732fd224978ebddf4bded7cb99663d2be1e732 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-R721T-grunt             | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d29884b251d112ae35b24e

  Results:     17 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/x8=
6_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-R72=
1T-grunt.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/x8=
6_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-R72=
1T-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/64d29884b251d11=
2ae35b261
        new failure (last pass: v5.4.251)
        1 lines

    2023-08-08T19:32:58.849585  kern  :emerg : do_IRQ: 1.55 No irq handler =
for vector
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d29af080445576aa35b210

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d29af080445576aa35b215
        failing since 202 days (last pass: v5.4.224, first fail: v5.4.229)

    2023-08-08T19:43:22.636250  <8>[    9.845397] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3733172_1.5.2.4.1>
    2023-08-08T19:43:22.742449  / # #
    2023-08-08T19:43:22.843921  export SHELL=3D/bin/sh
    2023-08-08T19:43:22.844293  #
    2023-08-08T19:43:22.945498  / # export SHELL=3D/bin/sh. /lava-3733172/e=
nvironment
    2023-08-08T19:43:22.945877  =

    2023-08-08T19:43:23.047121  / # . /lava-3733172/environment/lava-373317=
2/bin/lava-test-runner /lava-3733172/1
    2023-08-08T19:43:23.047730  =

    2023-08-08T19:43:23.052724  / # /lava-3733172/bin/lava-test-runner /lav=
a-3733172/1
    2023-08-08T19:43:23.129884  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d29ac4fb1866927135b1e2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d29ac4fb1866927135b1e5
        failing since 158 days (last pass: v5.4.225, first fail: v5.4.234)

    2023-08-08T19:42:49.546340  + [   15.624151] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1241778_1.5.2.4.1>
    2023-08-08T19:42:49.546644  set +x
    2023-08-08T19:42:49.652706  =

    2023-08-08T19:42:49.753999  / # #export SHELL=3D/bin/sh
    2023-08-08T19:42:49.754451  =

    2023-08-08T19:42:49.855425  / # export SHELL=3D/bin/sh. /lava-1241778/e=
nvironment
    2023-08-08T19:42:49.855845  =

    2023-08-08T19:42:49.956850  / # . /lava-1241778/environment/lava-124177=
8/bin/lava-test-runner /lava-1241778/1
    2023-08-08T19:42:49.957579  =

    2023-08-08T19:42:49.960416  / # /lava-1241778/bin/lava-test-runner /lav=
a-1241778/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2986cb251d112ae35b1e7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/x8=
6_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-=
12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/x8=
6_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-=
12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2986cb251d112ae35b1ec
        failing since 131 days (last pass: v5.4.238, first fail: v5.4.239)

    2023-08-08T19:33:22.776664  + set +x<8>[    9.967391] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11236014_1.4.2.3.1>

    2023-08-08T19:33:22.777128  =


    2023-08-08T19:33:22.884855  #

    2023-08-08T19:33:22.988078  / # #export SHELL=3D/bin/sh

    2023-08-08T19:33:22.988265  =


    2023-08-08T19:33:23.088721  / # export SHELL=3D/bin/sh. /lava-11236014/=
environment

    2023-08-08T19:33:23.088885  =


    2023-08-08T19:33:23.189351  / # . /lava-11236014/environment/lava-11236=
014/bin/lava-test-runner /lava-11236014/1

    2023-08-08T19:33:23.189585  =


    2023-08-08T19:33:23.194394  / # /lava-11236014/bin/lava-test-runner /la=
va-11236014/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2986bbdea69d58835b1db

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/x8=
6_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-=
14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/x8=
6_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-=
14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2986bbdea69d58835b1e0
        failing since 131 days (last pass: v5.4.238, first fail: v5.4.239)

    2023-08-08T19:33:17.668936  <8>[   10.366071] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11235997_1.4.2.3.1>

    2023-08-08T19:33:17.671908  + set +x

    2023-08-08T19:33:17.776522  / # #

    2023-08-08T19:33:17.877212  export SHELL=3D/bin/sh

    2023-08-08T19:33:17.877437  #

    2023-08-08T19:33:17.977967  / # export SHELL=3D/bin/sh. /lava-11235997/=
environment

    2023-08-08T19:33:17.978166  =


    2023-08-08T19:33:18.078695  / # . /lava-11235997/environment/lava-11235=
997/bin/lava-test-runner /lava-11235997/1

    2023-08-08T19:33:18.078999  =


    2023-08-08T19:33:18.084336  / # /lava-11235997/bin/lava-test-runner /la=
va-11235997/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6ul-14x14-evk             | arm    | lab-nxp       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d29aea09fa02ca9235b1fa

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d29aea09fa02ca9235b1fd
        failing since 144 days (last pass: v5.4.213, first fail: v5.4.237)

    2023-08-08T19:43:20.239244  + set +x
    2023-08-08T19:43:20.242417  <8>[   25.797332] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1241780_1.5.2.4.1>
    2023-08-08T19:43:20.353207  / # #
    2023-08-08T19:43:21.509412  export SHELL=3D/bin/sh
    2023-08-08T19:43:21.515022  #
    2023-08-08T19:43:23.057338  / # export SHELL=3D/bin/sh. /lava-1241780/e=
nvironment
    2023-08-08T19:43:23.063030  =

    2023-08-08T19:43:25.874983  / # . /lava-1241780/environment/lava-124178=
0/bin/lava-test-runner /lava-1241780/1
    2023-08-08T19:43:25.880990  =

    2023-08-08T19:43:25.882531  / # /lava-1241780/bin/lava-test-runner /lav=
a-1241780/1 =

    ... (18 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx7d-sdb                    | arm    | lab-nxp       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d29ae8193e5c6e2635b1fa

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d29ae8193e5c6e2635b1fd
        failing since 202 days (last pass: v5.4.224, first fail: v5.4.229)

    2023-08-08T19:43:16.274005  / # #
    2023-08-08T19:43:17.429876  export SHELL=3D/bin/sh
    2023-08-08T19:43:17.435474  #
    2023-08-08T19:43:18.977681  / # export SHELL=3D/bin/sh. /lava-1241779/e=
nvironment
    2023-08-08T19:43:18.983341  =

    2023-08-08T19:43:21.795442  / # . /lava-1241779/environment/lava-124177=
9/bin/lava-test-runner /lava-1241779/1
    2023-08-08T19:43:21.801434  =

    2023-08-08T19:43:21.815562  / # /lava-1241779/bin/lava-test-runner /lav=
a-1241779/1
    2023-08-08T19:43:21.909534  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-08T19:43:21.909842  + cd /lava-1241779/1/tests/1_bootrr =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d29acefb1866927135b208

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-=
gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-=
gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d29acefb1866927135b=
209
        failing since 456 days (last pass: v5.4.190, first fail: v5.4.192) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d29c36a4eeb0294735b1df

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d29c36a4eeb0294735b=
1e0
        failing since 456 days (last pass: v5.4.190, first fail: v5.4.192) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d29af909fa02ca9235b356

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-vir=
t-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-vir=
t-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d29af909fa02ca9235b=
357
        failing since 456 days (last pass: v5.4.190, first fail: v5.4.192) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d29c4d9cec440b7235b253

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d29c4d9cec440b7235b=
254
        failing since 456 days (last pass: v5.4.190, first fail: v5.4.192) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d29ab90c9981e2ad35b27f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-=
gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-=
gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d29ab90c9981e2ad35b=
280
        failing since 456 days (last pass: v5.4.190, first fail: v5.4.192) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d29cead353e7e77735b224

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d29cead353e7e77735b=
225
        failing since 374 days (last pass: v5.4.180, first fail: v5.4.208) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d29ad180445576aa35b1e7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-vir=
t-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-vir=
t-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d29ad180445576aa35b=
1e8
        failing since 456 days (last pass: v5.4.190, first fail: v5.4.192) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d29c4d450375e26635b1f5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d29c4d450375e26635b=
1f6
        failing since 374 days (last pass: v5.4.180, first fail: v5.4.208) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d29abafb1866927135b1dc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-=
gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-=
gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d29abafb1866927135b=
1dd
        failing since 456 days (last pass: v5.4.190, first fail: v5.4.192) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d29c3ca4eeb0294735b1e2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d29c3ca4eeb0294735b=
1e3
        failing since 307 days (last pass: v5.4.180, first fail: v5.4.216) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d29af909fa02ca9235b353

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-vir=
t-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-vir=
t-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d29af909fa02ca9235b=
354
        failing since 456 days (last pass: v5.4.190, first fail: v5.4.192) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d29c25a4eeb0294735b1d9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d29c25a4eeb0294735b=
1da
        failing since 307 days (last pass: v5.4.180, first fail: v5.4.216) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d29ad438ceb3280b35b1fb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-=
gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-=
gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d29ad438ceb3280b35b=
1fc
        failing since 456 days (last pass: v5.4.190, first fail: v5.4.192) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d29c23767de319b135b2a7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d29c23767de319b135b=
2a8
        failing since 307 days (last pass: v5.4.180, first fail: v5.4.216) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d29b0d3f8094dbe735b1db

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-vir=
t-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-vir=
t-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d29b0d3f8094dbe735b=
1dc
        failing since 456 days (last pass: v5.4.190, first fail: v5.4.192) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d29bc120b92821bd35b1f0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d29bc120b92821bd35b=
1f1
        failing since 307 days (last pass: v5.4.180, first fail: v5.4.216) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64d299c4b71618ea2a35b1ef

  Results:     82 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-kev=
in.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.4.y/v5.4.252/ar=
m64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-kev=
in.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64d299c4b71618ea2a35b1f5
        failing since 144 days (last pass: v5.4.235, first fail: v5.4.237)

    2023-08-08T19:38:34.395949  /lava-11236072/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64d299c4b71618ea2a35b1f6
        failing since 144 days (last pass: v5.4.235, first fail: v5.4.237)

    2023-08-08T19:38:32.361934  <8>[   30.334562] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-08-08T19:38:33.373969  /lava-11236072/1/../bin/lava-test-case

    2023-08-08T19:38:33.382296  <8>[   31.357729] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20
