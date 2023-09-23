Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257D57AC2A5
	for <lists+stable@lfdr.de>; Sat, 23 Sep 2023 16:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjIWO0c (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 23 Sep 2023 10:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjIWO0b (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 23 Sep 2023 10:26:31 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2858C9F
        for <stable@vger.kernel.org>; Sat, 23 Sep 2023 07:26:22 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68fb85afef4so3162876b3a.1
        for <stable@vger.kernel.org>; Sat, 23 Sep 2023 07:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695479181; x=1696083981; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wzM8ocNyc1GJBne6uLZNPxsiGVSfE1a5B8cROe7Te2s=;
        b=aWeOZ4jcbpxoX2qU7EDKw3xcNKvxS0zrb7LHdXVs65aOZdtNGUU952esW8X1aFcGOi
         oFwpbYa/eqPwhaCAo07vn5IybdfE8hlQrPTz+kaCr+VvoQn2huUICbwn0a7PUBWpul0a
         l6gFjcSf0Ai71vFX7Jgarb5TRgcLDfRdjNQs5n21tAgeiJtkg2pdQpUI91F6XV+djMsG
         QEZgkz39E3vIas7tw5sknBNNuYaE68E+bNbt04hSgg2jqTCzIp4NWQ0/Geml1f/5ps+E
         xYJgaLEqjddYCp0gjskWeFn/+LTxtxFvvhDJeqfqZUNRZC0yIdb4M05BQ1nbx0yua928
         F7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695479181; x=1696083981;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wzM8ocNyc1GJBne6uLZNPxsiGVSfE1a5B8cROe7Te2s=;
        b=qV5dt3Kp1OMkhlFEl7Puun2eDTzQjXtBWzvZHaGZxELwQ338/y0vzlLo7sVHWsmes8
         C969Qq9DggFfjBB4RaE5J1N9JtaeDZ+L/obaOlhDe8Ef5Pn07N1BLIdzGU4pMNYaSRnI
         jWLYGWF7sEellTRxyPNWLBd8kjMq0EVAvwyfX615JSdY2l8Y362hwOr4edjCarU+yNW/
         E+2Rbg604NqF++L0zUNR954qmLn1+GYYgtm4b7mztt1eYiD88y/EB0jh66qMfRQ12wDB
         zM+6PpSm9X0EAASo1aX4efrNnPBA2kuGdNxTMqq61AoclQ4wDgIoVBEZmku4MpzmBKLv
         OEXQ==
X-Gm-Message-State: AOJu0Yye/W+H2N14QsmNGUhTvC2FaRhEcGbAV2Dt7NFRhmets3cNxZag
        Ucxfqm12vxdCDvbqzdMmqgPjRaLof0xqfHbkHmojbg==
X-Google-Smtp-Source: AGHT+IEPcDqtSDPh2rs4+ZlIkZSITwYFjTCixaD48mYv8nZHIO3PagRzkLOijWF96EKe5h3PsgO9AQ==
X-Received: by 2002:a05:6a20:394b:b0:14d:29f6:18c3 with SMTP id r11-20020a056a20394b00b0014d29f618c3mr2063767pzg.20.1695479180234;
        Sat, 23 Sep 2023 07:26:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w3-20020aa78583000000b0068fc6570874sm4997005pfn.9.2023.09.23.07.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 07:26:19 -0700 (PDT)
Message-ID: <650ef58b.a70a0220.07f6.83f6@mx.google.com>
Date:   Sat, 23 Sep 2023 07:26:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable
X-Kernelci-Kernel: v4.19.295
X-Kernelci-Report-Type: test
Subject: stable/linux-4.19.y baseline: 99 runs, 36 regressions (v4.19.295)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-4.19.y baseline: 99 runs, 36 regressions (v4.19.295)

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
/v4.19.295/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-4.19.y
  Describe: v4.19.295
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      780225545de40d45936ab607516733d16d4e6ac4 =



Test Regressions
---------------- =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus  | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec373a44d2a3ef38a0a42

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ec373a44d2a3ef38a0a4b
        failing since 247 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-09-23T10:52:40.827350  + set +x<8>[    7.527878] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11601397_1.4.2.3.1>

    2023-09-23T10:52:40.827937  =


    2023-09-23T10:52:40.935580  #

    2023-09-23T10:52:40.936821  =


    2023-09-23T10:52:41.038898  / # #export SHELL=3D/bin/sh

    2023-09-23T10:52:41.039724  =


    2023-09-23T10:52:41.141367  / # export SHELL=3D/bin/sh. /lava-11601397/=
environment

    2023-09-23T10:52:41.142171  =


    2023-09-23T10:52:41.243932  / # . /lava-11601397/environment/lava-11601=
397/bin/lava-test-runner /lava-11601397/1

    2023-09-23T10:52:41.245198  =

 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral   | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec36960492ed3da8a0a66

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ec36960492ed3da8a0a6f
        failing since 247 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-09-23T10:52:12.508405  + <8>[   12.110261] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11601394_1.4.2.3.1>

    2023-09-23T10:52:12.511342  set +x

    2023-09-23T10:52:12.615919  / # #

    2023-09-23T10:52:12.718068  export SHELL=3D/bin/sh

    2023-09-23T10:52:12.718928  #

    2023-09-23T10:52:12.820432  / # export SHELL=3D/bin/sh. /lava-11601394/=
environment

    2023-09-23T10:52:12.821183  =


    2023-09-23T10:52:12.922760  / # . /lava-11601394/environment/lava-11601=
394/bin/lava-test-runner /lava-11601394/1

    2023-09-23T10:52:12.923948  =


    2023-09-23T10:52:12.926287  / # /lava-11601394/bin/lava-test-runner /la=
va-11601394/1
 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
at91sam9g20ek              | arm    | lab-broonie     | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec36069465957038a0aa4

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ec36169465957038a0ada
        failing since 21 days (last pass: v4.19.292, first fail: v4.19.294)

    2023-09-23T10:51:37.688509  + set +x
    2023-09-23T10:51:37.688976  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 127312_1.5.2=
.4.1>
    2023-09-23T10:51:37.802341  / # #
    2023-09-23T10:51:37.905458  export SHELL=3D/bin/sh
    2023-09-23T10:51:37.906292  #
    2023-09-23T10:51:38.008298  / # export SHELL=3D/bin/sh. /lava-127312/en=
vironment
    2023-09-23T10:51:38.009099  =

    2023-09-23T10:51:38.111236  / # . /lava-127312/environment/lava-127312/=
bin/lava-test-runner /lava-127312/1
    2023-09-23T10:51:38.112579  =

    2023-09-23T10:51:38.116136  / # /lava-127312/bin/lava-test-runner /lava=
-127312/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-broonie     | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec4a61fca29de3f8a0aa4

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ec4a61fca29de3f8a0ad2
        failing since 247 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-09-23T10:56:48.159950  <8>[   14.791947] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 127365_1.5.2.4.1>
    2023-09-23T10:56:48.266384  / # #
    2023-09-23T10:56:48.367806  export SHELL=3D/bin/sh
    2023-09-23T10:56:48.368111  #
    2023-09-23T10:56:48.469236  / # export SHELL=3D/bin/sh. /lava-127365/en=
vironment
    2023-09-23T10:56:48.469552  =

    2023-09-23T10:56:48.570740  / # . /lava-127365/environment/lava-127365/=
bin/lava-test-runner /lava-127365/1
    2023-09-23T10:56:48.571279  =

    2023-09-23T10:56:48.575335  / # /lava-127365/bin/lava-test-runner /lava=
-127365/1
    2023-09-23T10:56:48.643141  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-cip         | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec4aaa3f23117768a0a56

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ec4aaa3f23117768a0a5d
        failing since 247 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-09-23T10:56:58.446913  <8>[    8.928147] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1012321_1.5.2.4.1>
    2023-09-23T10:56:58.556386  / # #
    2023-09-23T10:56:58.659052  export SHELL=3D/bin/sh
    2023-09-23T10:56:58.659754  #
    2023-09-23T10:56:58.761610  / # export SHELL=3D/bin/sh. /lava-1012321/e=
nvironment
    2023-09-23T10:56:58.762318  =

    2023-09-23T10:56:58.864167  / # . /lava-1012321/environment/lava-101232=
1/bin/lava-test-runner /lava-1012321/1
    2023-09-23T10:56:58.865360  =

    2023-09-23T10:56:58.871670  / # /lava-1012321/bin/lava-test-runner /lav=
a-1012321/1
    2023-09-23T10:56:58.938215  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6q-sabrelite            | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec46b7e4f22d8c58a0a5b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ec46b7e4f22d8c58a0a64
        failing since 247 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-09-23T10:56:32.341217  / # #

    2023-09-23T10:56:32.443778  export SHELL=3D/bin/sh

    2023-09-23T10:56:32.444541  #

    2023-09-23T10:56:32.546318  / # export SHELL=3D/bin/sh. /lava-11601449/=
environment

    2023-09-23T10:56:32.547147  =


    2023-09-23T10:56:32.648930  / # . /lava-11601449/environment/lava-11601=
449/bin/lava-test-runner /lava-11601449/1

    2023-09-23T10:56:32.650126  =


    2023-09-23T10:56:32.666418  / # /lava-11601449/bin/lava-test-runner /la=
va-11601449/1

    2023-09-23T10:56:32.770516  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-23T10:56:32.771083  + cd /lava-11601449/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec37b841ac3c5c78a0a6c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboard-re=
vd1.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboard-re=
vd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ec37b841ac3c5c78a0a75
        failing since 247 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-09-23T10:52:31.829578  + set +x
    2023-09-23T10:52:31.829761  [    7.295522] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1001432_1.5.2.3.1>
    2023-09-23T10:52:31.937200  / # #
    2023-09-23T10:52:32.039093  export SHELL=3D/bin/sh
    2023-09-23T10:52:32.039567  #
    2023-09-23T10:52:32.140779  / # export SHELL=3D/bin/sh. /lava-1001432/e=
nvironment
    2023-09-23T10:52:32.141252  =

    2023-09-23T10:52:32.242541  / # . /lava-1001432/environment/lava-100143=
2/bin/lava-test-runner /lava-1001432/1
    2023-09-23T10:52:32.243170  =

    2023-09-23T10:52:32.246159  / # /lava-1001432/bin/lava-test-runner /lav=
a-1001432/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec444a228a472dd8a0ad8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboard-rev=
d1.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboard-rev=
d1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ec444a228a472dd8a0ae1
        failing since 247 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-09-23T10:55:53.533042  + set +x
    2023-09-23T10:55:53.533218  [    4.986421] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1001435_1.5.2.3.1>
    2023-09-23T10:55:53.639504  / # #
    2023-09-23T10:55:53.741265  export SHELL=3D/bin/sh
    2023-09-23T10:55:53.741747  #
    2023-09-23T10:55:53.843000  / # export SHELL=3D/bin/sh. /lava-1001435/e=
nvironment
    2023-09-23T10:55:53.843486  =

    2023-09-23T10:55:53.944831  / # . /lava-1001435/environment/lava-100143=
5/bin/lava-test-runner /lava-1001435/1
    2023-09-23T10:55:53.945642  =

    2023-09-23T10:55:53.947718  / # /lava-1001435/bin/lava-test-runner /lav=
a-1001435/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6ul-14x14-evk           | arm    | lab-nxp         | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec4906fdb91ccaa8a0a6e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ec4906fdb91ccaa8a0a75
        failing since 189 days (last pass: v4.19.260, first fail: v4.19.278)

    2023-09-23T10:56:55.589388  + set +x<8>[   23.257438] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1252736_1.5.2.4.1>
    2023-09-23T10:56:55.589685  =

    2023-09-23T10:56:55.699726  / # #
    2023-09-23T10:56:56.855769  export SHELL=3D/bin/sh
    2023-09-23T10:56:56.861433  #
    2023-09-23T10:56:58.403685  / # export SHELL=3D/bin/sh. /lava-1252736/e=
nvironment
    2023-09-23T10:56:58.409353  =

    2023-09-23T10:57:01.223295  / # . /lava-1252736/environment/lava-125273=
6/bin/lava-test-runner /lava-1252736/1
    2023-09-23T10:57:01.229263  =

    2023-09-23T10:57:01.231068  / # /lava-1252736/bin/lava-test-runner /lav=
a-1252736/1 =

    ... (15 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx7d-sdb                  | arm    | lab-nxp         | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec47c6fdb91ccaa8a0a5a

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ec47c6fdb91ccaa8a0a61
        failing since 247 days (last pass: v4.19.267, first fail: v4.19.270)

    2023-09-23T10:56:47.040859  / # #
    2023-09-23T10:56:48.196790  export SHELL=3D/bin/sh
    2023-09-23T10:56:48.202421  #
    2023-09-23T10:56:49.744650  / # export SHELL=3D/bin/sh. /lava-1252735/e=
nvironment
    2023-09-23T10:56:49.750281  =

    2023-09-23T10:56:52.562723  / # . /lava-1252735/environment/lava-125273=
5/bin/lava-test-runner /lava-1252735/1
    2023-09-23T10:56:52.568630  =

    2023-09-23T10:56:52.580287  / # /lava-1252735/bin/lava-test-runner /lav=
a-1252735/1
    2023-09-23T10:56:52.676113  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-23T10:56:52.676481  + cd /lava-1252735/1/tests/1_bootrr =

    ... (16 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec8dd134ca1f8f48a0a72

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650ec8dd134ca1f8f48a0=
a73
        failing since 382 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/650ecb6c95d9f929158a0a50

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650ecb6c95d9f929158a0=
a51
        failing since 420 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec5078e14463d678a0a42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650ec5078e14463d678a0=
a43
        failing since 382 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec5bb643cf9a3148a0a65

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650ec5bb643cf9a3148a0=
a66
        failing since 420 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec955deeed4ddb98a0abd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650ec955deeed4ddb98a0=
abe
        failing since 382 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/650ecabd024ff006308a0a42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650ecabd024ff006308a0=
a43
        failing since 420 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec56655660a87ba8a0a75

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650ec56655660a87ba8a0=
a76
        failing since 382 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec57fd4a29c2a0c8a0a48

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650ec57fd4a29c2a0c8a0=
a49
        failing since 420 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650eca04adae56edbb8a0b91

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650eca04adae56edbb8a0=
b92
        failing since 382 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/650eca6db329195f2e8a0a46

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650eca6db329195f2e8a0=
a47
        failing since 420 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec57b43c8798bc48a0a45

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650ec57b43c8798bc48a0=
a46
        failing since 382 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec58fd4a29c2a0c8a0a4e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650ec58fd4a29c2a0c8a0=
a4f
        failing since 420 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec9194fd9eee01d8a0a81

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650ec9194fd9eee01d8a0=
a82
        failing since 382 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/650eca4521f132f6078a0a81

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650eca4521f132f6078a0=
a82
        failing since 420 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec52a8e14463d678a0a56

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650ec52a8e14463d678a0=
a57
        failing since 382 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec58e43c8798bc48a0a4b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650ec58e43c8798bc48a0=
a4c
        failing since 420 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
r8a7796-m3ulcb             | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec3da590168a2428a0a42

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7796-m3ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7796-m3ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ec3da590168a2428a0a4b
        failing since 247 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-09-23T10:58:17.219123  / # #

    2023-09-23T10:58:17.321320  export SHELL=3D/bin/sh

    2023-09-23T10:58:17.322039  #

    2023-09-23T10:58:17.423371  / # export SHELL=3D/bin/sh. /lava-11601423/=
environment

    2023-09-23T10:58:17.424105  =


    2023-09-23T10:58:17.525513  / # . /lava-11601423/environment/lava-11601=
423/bin/lava-test-runner /lava-11601423/1

    2023-09-23T10:58:17.526593  =


    2023-09-23T10:58:17.543167  / # /lava-11601423/bin/lava-test-runner /la=
va-11601423/1

    2023-09-23T10:58:17.593101  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-23T10:58:17.593614  + cd /lav<8>[   13.001631] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11601423_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq          | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 3          =


  Details:     https://kernelci.org/test/plan/id/650ec466adc8dc7f188a0a42

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/650ec466adc8dc7f188a0a76
        failing since 246 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-09-23T11:00:37.828977  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   12.395866] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-09-23T11:00:37.830850   multi-call binary.

    2023-09-23T11:00:37.830902  =


    2023-09-23T11:00:37.835389  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-09-23T11:00:37.835608  =


    2023-09-23T11:00:37.840693  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/650ec466adc8dc7f188a0a77
        failing since 246 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-09-23T11:00:37.810290  /lava-11601452/1/../bin/lava-test-case<8>[ =
  12.378592] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-probed RE=
SULT=3Dpass>

    2023-09-23T11:00:37.810341  =

   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ec466adc8dc7f188a0a8a
        failing since 246 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-09-23T11:00:33.977682  <8>[    8.545980] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-09-23T11:00:33.986910  + <8>[    8.558176] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11601452_1.5.2.3.1>

    2023-09-23T11:00:33.987476  set +x

    2023-09-23T11:00:34.093576  =


    2023-09-23T11:00:34.195096  / # #export SHELL=3D/bin/sh

    2023-09-23T11:00:34.195799  =


    2023-09-23T11:00:34.297096  / # export SHELL=3D/bin/sh. /lava-11601452/=
environment

    2023-09-23T11:00:34.297807  =


    2023-09-23T11:00:34.399239  / # . /lava-11601452/environment/lava-11601=
452/bin/lava-test-runner /lava-11601452/1

    2023-09-23T11:00:34.400362  =

 =

    ... (17 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
rk3399-gru-kevin           | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/650ec489f15b3bc4ff8a0a50

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/650ec489f15b3bc4ff8a0a5a
        failing since 189 days (last pass: v4.19.277, first fail: v4.19.278)

    2023-09-23T10:56:52.282141  <8>[   36.394127] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-09-23T10:56:53.296773  /lava-11601433/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/650ec489f15b3bc4ff8a0a5b
        failing since 189 days (last pass: v4.19.277, first fail: v4.19.278)

    2023-09-23T10:56:52.272072  /lava-11601433/1/../bin/lava-test-case
   =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus     | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec413a228a472dd8a0a53

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ec413a228a472dd8a0a7b
        failing since 247 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-09-23T10:54:36.458436  <8>[   15.928692] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 127343_1.5.2.4.1>
    2023-09-23T10:54:36.564172  / # #
    2023-09-23T10:54:36.666122  export SHELL=3D/bin/sh
    2023-09-23T10:54:36.666724  #
    2023-09-23T10:54:36.768290  / # export SHELL=3D/bin/sh. /lava-127343/en=
vironment
    2023-09-23T10:54:36.768778  =

    2023-09-23T10:54:36.870092  / # . /lava-127343/environment/lava-127343/=
bin/lava-test-runner /lava-127343/1
    2023-09-23T10:54:36.870864  =

    2023-09-23T10:54:36.875567  / # /lava-127343/bin/lava-test-runner /lava=
-127343/1
    2023-09-23T10:54:36.906907  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64         | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec3d836b6d853078a0a51

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ec3d836b6d853078a0a5a
        failing since 247 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-09-23T10:58:31.882345  / # #

    2023-09-23T10:58:31.984641  export SHELL=3D/bin/sh

    2023-09-23T10:58:31.985363  #

    2023-09-23T10:58:32.086778  / # export SHELL=3D/bin/sh. /lava-11601421/=
environment

    2023-09-23T10:58:32.087511  =


    2023-09-23T10:58:32.189011  / # . /lava-11601421/environment/lava-11601=
421/bin/lava-test-runner /lava-11601421/1

    2023-09-23T10:58:32.190127  =


    2023-09-23T10:58:32.206738  / # /lava-11601421/bin/lava-test-runner /la=
va-11601421/1

    2023-09-23T10:58:32.264577  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-23T10:58:32.265091  + cd /lava-1160142<8>[   15.634000] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11601421_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec3e7590168a2428a0a5a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ec3e7590168a2428a0a61
        failing since 247 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-09-23T10:54:17.585463  <8>[    3.754749] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1012311_1.5.2.4.1>
    2023-09-23T10:54:17.690284  / # #
    2023-09-23T10:54:17.791704  export SHELL=3D/bin/sh
    2023-09-23T10:54:17.792082  #
    2023-09-23T10:54:17.893200  / # export SHELL=3D/bin/sh. /lava-1012311/e=
nvironment
    2023-09-23T10:54:17.893570  =

    2023-09-23T10:54:17.994471  / # . /lava-1012311/environment/lava-101231=
1/bin/lava-test-runner /lava-1012311/1
    2023-09-23T10:54:17.994959  =

    2023-09-23T10:54:17.997272  / # /lava-1012311/bin/lava-test-runner /lav=
a-1012311/1
    2023-09-23T10:54:18.034323  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec59e43c8798bc48a0a6b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.295/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ec59e43c8798bc48a0a72
        failing since 247 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-09-23T11:01:33.161183  <8>[    3.711325] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1012318_1.5.2.4.1>
    2023-09-23T11:01:33.265767  / # #
    2023-09-23T11:01:33.367015  export SHELL=3D/bin/sh
    2023-09-23T11:01:33.367310  #
    2023-09-23T11:01:33.468302  / # export SHELL=3D/bin/sh. /lava-1012318/e=
nvironment
    2023-09-23T11:01:33.468592  =

    2023-09-23T11:01:33.569585  / # . /lava-1012318/environment/lava-101231=
8/bin/lava-test-runner /lava-1012318/1
    2023-09-23T11:01:33.569982  =

    2023-09-23T11:01:33.573021  / # /lava-1012318/bin/lava-test-runner /lav=
a-1012318/1
    2023-09-23T11:01:33.610027  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =20
