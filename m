Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DF77473CB
	for <lists+stable@lfdr.de>; Tue,  4 Jul 2023 16:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjGDON0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 4 Jul 2023 10:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjGDONV (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 4 Jul 2023 10:13:21 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D411712
        for <stable@vger.kernel.org>; Tue,  4 Jul 2023 07:13:15 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-517bdc9e81dso2115654a12.1
        for <stable@vger.kernel.org>; Tue, 04 Jul 2023 07:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688479995; x=1691071995;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=prBxF+brpw+9yiSaPNB7mLYN4S1f3l+CroAw/dUVH/c=;
        b=IbFrLjkfNiJXxjdQzRD2Exj3M7YmguOaGoGJU1OiBFN1K0zjNt+a4UNLXdsNm4oWo7
         yYS1kZBS9lAuEN7DnG/htHK2EUEpqTHP291rzcvjH4WtCyprW4Z9XhSAsNXweCMGsKYg
         9L2nd/z0qQb9sQERCHAR+5PX3kWkgsvwQWmtOnANV2MyD6ddXLdPPJtOwDRfdv3opcPG
         I/5KjzbmstW6T6bikdPd9eRSRL7DbKBtBjineYO+9PtpdCL9nDjsvbgKG+vaFaSOI4c/
         eIK5fSmFVk40blNE8c6Rix6zJbtDAzXcucSd5OeWlvcEn8Li3DIhtGH+b+dTw/tIoZM6
         etcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688479995; x=1691071995;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=prBxF+brpw+9yiSaPNB7mLYN4S1f3l+CroAw/dUVH/c=;
        b=ac8eviMtQhPkIMbilrGLWK580tpEKvfU2IJ4gSGlIRztAieKc/CRGCAYK5DCY0kN5Z
         GTvxPmjm51+huIf+7seljEbh0hqyErZ3bxLSrcu0SS4sDcNlBNrvOhhevkQ7WD0ae2aC
         /1Ne89vYhW26Ck8fQOzwIcusUcBEtjm0TjnaLFI77Fsbp7YY9c2M3sT7iiWn1j7URwbp
         ui0U4/TtfGAwFGBZHIX0n1MAraieoOSN3TvQhB7C4S2ZbxNRDCWsIw6BZEp822mOpF+e
         sddBQ4tOBU8y8dC/OhFXHJoBX66Que6db+aJoYDCqP5p4ylOYI+pZysglBBiqtKtfv/5
         oZLQ==
X-Gm-Message-State: ABy/qLYh19gyl8jAPxgWNatvdFIedl6yJHW1caWq+m0p73c6UA9Csbl3
        GizFxevC4HvD4rcSIG6y2AdjsfQbflteWSSm1iEsJw==
X-Google-Smtp-Source: APBJJlFpYtrObtan84q2pX5Z84ftB+6fLymSk/UQvUia87SbgAcQrf8U/+6x11dHW18O14DQtgE5gw==
X-Received: by 2002:a05:6a20:3d90:b0:12d:ba1e:d763 with SMTP id s16-20020a056a203d9000b0012dba1ed763mr11680770pzi.7.1688479994642;
        Tue, 04 Jul 2023 07:13:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e18-20020a62aa12000000b00666d7ef2310sm12026662pff.94.2023.07.04.07.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 07:13:13 -0700 (PDT)
Message-ID: <64a428f9.620a0220.b0cc8.7d22@mx.google.com>
Date:   Tue, 04 Jul 2023 07:13:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.288-8-gcce880c1647e
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.19.y
Subject: stable-rc/linux-4.19.y baseline: 130 runs,
 21 regressions (v4.19.288-8-gcce880c1647e)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-4.19.y baseline: 130 runs, 21 regressions (v4.19.288-8-gcce=
880c1647e)

Regressions Summary
-------------------

platform                   | arch  | lab           | compiler | defconfig  =
           | regressions
---------------------------+-------+---------------+----------+------------=
-----------+------------
beaglebone-black           | arm   | lab-cip       | gcc-10   | omap2plus_d=
efconfig   | 1          =

cubietruck                 | arm   | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig    | 1          =

da850-lcdk                 | arm   | lab-baylibre  | gcc-10   | davinci_all=
_defconfig | 2          =

meson-gxl-s905d-p230       | arm64 | lab-baylibre  | gcc-10   | defconfig  =
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
nel/v4.19.288-8-gcce880c1647e/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.288-8-gcce880c1647e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      cce880c1647ed071e6cc72dd2d6df5d6f1a75216 =



Test Regressions
---------------- =



platform                   | arch  | lab           | compiler | defconfig  =
           | regressions
---------------------------+-------+---------------+----------+------------=
-----------+------------
beaglebone-black           | arm   | lab-cip       | gcc-10   | omap2plus_d=
efconfig   | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3f9737b8d93e645bb2b8c

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebo=
ne-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebo=
ne-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3f9737b8d93e645bb2b8f
        new failure (last pass: v4.19.288-8-g4d52374bfbe40)

    2023-07-04T10:49:48.734932  + set +x<8>[   10.513332] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 981389_1.5.2.4.1>
    2023-07-04T10:49:48.735421  =

    2023-07-04T10:49:48.848634  / # #
    2023-07-04T10:49:48.951270  export SHELL=3D/bin/sh
    2023-07-04T10:49:48.951997  #
    2023-07-04T10:49:49.053856  / # export SHELL=3D/bin/sh. /lava-981389/en=
vironment
    2023-07-04T10:49:49.054573  =

    2023-07-04T10:49:49.156462  / # . /lava-981389/environment/lava-981389/=
bin/lava-test-runner /lava-981389/1
    2023-07-04T10:49:49.157747  =

    2023-07-04T10:49:49.164525  / # /lava-981389/bin/lava-test-runner /lava=
-981389/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch  | lab           | compiler | defconfig  =
           | regressions
---------------------------+-------+---------------+----------+------------=
-----------+------------
cubietruck                 | arm   | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig    | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3efbafcfb837157bb2a7e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3efbafcfb837157bb2a83
        failing since 168 days (last pass: v4.19.268-50-gbf741d1d7e6d, firs=
t fail: v4.19.269-522-gc75d2b5524ab)

    2023-07-04T10:08:47.205754  <8>[    7.314794] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3710784_1.5.2.4.1>
    2023-07-04T10:08:47.316550  / # #
    2023-07-04T10:08:47.419903  export SHELL=3D/bin/sh
    2023-07-04T10:08:47.420869  #
    2023-07-04T10:08:47.523087  / # export SHELL=3D/bin/sh. /lava-3710784/e=
nvironment
    2023-07-04T10:08:47.524153  =

    2023-07-04T10:08:47.626545  / # . /lava-3710784/environment/lava-371078=
4/bin/lava-test-runner /lava-3710784/1
    2023-07-04T10:08:47.628213  =

    2023-07-04T10:08:47.633184  / # /lava-3710784/bin/lava-test-runner /lav=
a-3710784/1
    2023-07-04T10:08:47.714065  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch  | lab           | compiler | defconfig  =
           | regressions
---------------------------+-------+---------------+----------+------------=
-----------+------------
da850-lcdk                 | arm   | lab-baylibre  | gcc-10   | davinci_all=
_defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/64a3ef684f609a27d2bb2a75

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: davinci_all_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm/davinci_all_defconfig/gcc-10/lab-baylibre/baseline-d=
a850-lcdk.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm/davinci_all_defconfig/gcc-10/lab-baylibre/baseline-d=
a850-lcdk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/64a3ef684f609a2=
7d2bb2a7c
        new failure (last pass: v4.19.288-8-g4d52374bfbe40)
        4 lines

    2023-07-04T10:07:16.461292  kern  :emerg : page:c6f51000 count:0 mapcou=
nt:-128 mapping:00000000 index:0x4
    2023-07-04T10:07:16.462018  kern  :emerg : flags: 0x0()
    2023-07-04T10:07:16.462454  kern  :emerg : page:c6f59000 count:0 mapcou=
nt:-128 mapping:00000000 index:0x4
    2023-07-04T10:07:16.464403  kern  :emerg : flags: 0x0()
    2023-07-04T10:07:16.529996  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Deme=
rg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D4>
    2023-07-04T10:07:16.530683  + set +x   =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/64a3ef684f609a2=
7d2bb2a7d
        new failure (last pass: v4.19.288-8-g4d52374bfbe40)
        6 lines

    2023-07-04T10:07:16.277752  kern  :alert : BUG: Bad page state in proce=
ss swapper  pfn:c3400
    2023-07-04T10:07:16.279210  kern  :alert : raw: 00000000 00000100 00000=
200 00000000 00000004 0000000a ffffff7f 00000000
    2023-07-04T10:07:16.279922  kern  :alert : page dumped because: nonzero=
 mapcount
    2023-07-04T10:07:16.280722  kern  :alert : BUG: Bad page state in proce=
ss swapper  pfn:c3800
    2023-07-04T10:07:16.281253  kern  :alert : raw: 00000000 00000100 00000=
200 00000000 00000004 0000000a ffffff7f 00000000
    2023-07-04T10:07:16.282374  kern  :alert : page dumped because: nonzero=
 mapcount
    2023-07-04T10:07:16.320799  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dale=
rt RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D6>   =

 =



platform                   | arch  | lab           | compiler | defconfig  =
           | regressions
---------------------------+-------+---------------+----------+------------=
-----------+------------
meson-gxl-s905d-p230       | arm64 | lab-baylibre  | gcc-10   | defconfig  =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3f6e6bc44a476e3bb2a86

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl-s=
905d-p230.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl-s=
905d-p230.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3f6e6bc44a476e3bb2a8b
        new failure (last pass: v4.19.288-8-g4d52374bfbe40)

    2023-07-04T10:39:12.383671  + set +x<8>[   16.220753] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3710935_1.5.2.4.1>
    2023-07-04T10:39:12.384303  =

    2023-07-04T10:39:12.493031  / # #
    2023-07-04T10:39:12.596606  export SHELL=3D/bin/sh
    2023-07-04T10:39:12.597595  #
    2023-07-04T10:39:12.699812  / # export SHELL=3D/bin/sh. /lava-3710935/e=
nvironment
    2023-07-04T10:39:12.700862  =

    2023-07-04T10:39:12.803025  / # . /lava-3710935/environment/lava-371093=
5/bin/lava-test-runner /lava-3710935/1
    2023-07-04T10:39:12.804475  =

    2023-07-04T10:39:12.808148  / # /lava-3710935/bin/lava-test-runner /lav=
a-3710935/1 =

    ... (13 line(s) more)  =

 =



platform                   | arch  | lab           | compiler | defconfig  =
           | regressions
---------------------------+-------+---------------+----------+------------=
-----------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-baylibre  | gcc-10   | defconfig  =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3f7f495c945ad58bb2ade

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a3f7f495c945ad58bb2=
adf
        failing since 419 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-89-g71a9ee8b0cfd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
           | regressions
---------------------------+-------+---------------+----------+------------=
-----------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig  =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3f9eb0fbff9eed7bb2a7f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a3f9eb0fbff9eed7bb2=
a80
        failing since 419 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-89-g71a9ee8b0cfd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
           | regressions
---------------------------+-------+---------------+----------+------------=
-----------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig  =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3f86c871c1d9cd9bb2a91

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a3f86c871c1d9cd9bb2=
a92
        failing since 419 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-89-g71a9ee8b0cfd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
           | regressions
---------------------------+-------+---------------+----------+------------=
-----------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig  =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3f7f7d6fa13cee5bb2a76

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a3f7f7d6fa13cee5bb2=
a77
        failing since 419 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-89-g71a9ee8b0cfd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
           | regressions
---------------------------+-------+---------------+----------+------------=
-----------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3faa0000f3c4d18bb2a81

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a3faa0000f3c4d18bb2=
a82
        failing since 419 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-89-g71a9ee8b0cfd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
           | regressions
---------------------------+-------+---------------+----------+------------=
-----------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3f88128d2589fdbbb2b05

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a3f88128d2589fdbbb2=
b06
        failing since 419 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-89-g71a9ee8b0cfd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
           | regressions
---------------------------+-------+---------------+----------+------------=
-----------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-baylibre  | gcc-10   | defconfig  =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3f7f895c945ad58bb2ae7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a3f7f895c945ad58bb2=
ae8
        failing since 419 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-89-g71a9ee8b0cfd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
           | regressions
---------------------------+-------+---------------+----------+------------=
-----------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig  =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3fab428cb5c5d1cbb2a76

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a3fab428cb5c5d1cbb2=
a77
        failing since 419 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-89-g71a9ee8b0cfd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
           | regressions
---------------------------+-------+---------------+----------+------------=
-----------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig  =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3f88900e565505ebb2a75

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a3f88900e565505ebb2=
a76
        failing since 419 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-89-g71a9ee8b0cfd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
           | regressions
---------------------------+-------+---------------+----------+------------=
-----------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig  =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3f7f68e336fa638bb2a9d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a3f7f68e336fa638bb2=
a9e
        failing since 419 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-89-g71a9ee8b0cfd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
           | regressions
---------------------------+-------+---------------+----------+------------=
-----------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3fa9fc64015302bbb2a8a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a3fa9fc64015302bbb2=
a8b
        failing since 419 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-89-g71a9ee8b0cfd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
           | regressions
---------------------------+-------+---------------+----------+------------=
-----------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3f880c5ced886eebb2a77

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a3f880c5ced886eebb2=
a78
        failing since 419 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-89-g71a9ee8b0cfd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
           | regressions
---------------------------+-------+---------------+----------+------------=
-----------+------------
r8a7795-salvator-x         | arm64 | lab-baylibre  | gcc-10   | defconfig  =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3f6eed4733d66dabb2a7f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm64/defconfig/gcc-10/lab-baylibre/baseline-r8a7795-sal=
vator-x.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm64/defconfig/gcc-10/lab-baylibre/baseline-r8a7795-sal=
vator-x.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3f6eed4733d66dabb2a84
        failing since 26 days (last pass: v4.19.261-20-g5644b22533b36, firs=
t fail: v4.19.284-89-ga1cebe658474)

    2023-07-04T10:39:19.413155  + set +x
    2023-07-04T10:39:19.416297  <8>[    8.083678] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3710941_1.5.2.4.1>
    2023-07-04T10:39:19.523028  / # #
    2023-07-04T10:39:19.624771  export SHELL=3D/bin/sh
    2023-07-04T10:39:19.625290  #
    2023-07-04T10:39:19.726613  / # export SHELL=3D/bin/sh. /lava-3710941/e=
nvironment
    2023-07-04T10:39:19.727178  =

    2023-07-04T10:39:19.828428  / # . /lava-3710941/environment/lava-371094=
1/bin/lava-test-runner /lava-3710941/1
    2023-07-04T10:39:19.829200  =

    2023-07-04T10:39:19.832829  / # /lava-3710941/bin/lava-test-runner /lav=
a-3710941/1 =

    ... (13 line(s) more)  =

 =



platform                   | arch  | lab           | compiler | defconfig  =
           | regressions
---------------------------+-------+---------------+----------+------------=
-----------+------------
rk3328-rock64              | arm64 | lab-baylibre  | gcc-10   | defconfig  =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3f71694192042b6bb2a8c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a3f71694192042b6bb2=
a8d
        failing since 26 days (last pass: v4.19.266-115-gf65c47c3f336, firs=
t fail: v4.19.284-89-ga1cebe658474) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
           | regressions
---------------------------+-------+---------------+----------+------------=
-----------+------------
sun50i-a64-pine64-plus     | arm64 | lab-baylibre  | gcc-10   | defconfig  =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3f9cf8d2f5cf1ecbb2ad2

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-=
pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-=
pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3f9cf8d2f5cf1ecbb2af8
        failing since 168 days (last pass: v4.19.265-42-ga2d8c749b30c, firs=
t fail: v4.19.269-522-gc75d2b5524ab)

    2023-07-04T10:51:08.578177  <8>[   15.929797] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3710936_1.5.2.4.1>
    2023-07-04T10:51:08.701015  / # #
    2023-07-04T10:51:08.807717  export SHELL=3D/bin/sh
    2023-07-04T10:51:08.809321  #
    2023-07-04T10:51:08.912912  / # export SHELL=3D/bin/sh. /lava-3710936/e=
nvironment
    2023-07-04T10:51:08.914637  =

    2023-07-04T10:51:09.018365  / # . /lava-3710936/environment/lava-371093=
6/bin/lava-test-runner /lava-3710936/1
    2023-07-04T10:51:09.021428  =

    2023-07-04T10:51:09.024746  / # /lava-3710936/bin/lava-test-runner /lav=
a-3710936/1
    2023-07-04T10:51:09.055765  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch  | lab           | compiler | defconfig  =
           | regressions
---------------------------+-------+---------------+----------+------------=
-----------+------------
sun50i-a64-pine64-plus     | arm64 | lab-broonie   | gcc-10   | defconfig  =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3f7425f2c6395f6bb2a91

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-p=
ine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-8-gcce880c1647e/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-p=
ine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3f7425f2c6395f6bb2ab6
        failing since 168 days (last pass: v4.19.265-42-ga2d8c749b30c, firs=
t fail: v4.19.269-522-gc75d2b5524ab)

    2023-07-04T10:40:26.954027  <8>[   15.958884] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 695096_1.5.2.4.1>
    2023-07-04T10:40:27.062045  / # #
    2023-07-04T10:40:27.165016  export SHELL=3D/bin/sh
    2023-07-04T10:40:27.165741  #
    2023-07-04T10:40:27.267890  / # export SHELL=3D/bin/sh. /lava-695096/en=
vironment
    2023-07-04T10:40:27.268622  =

    2023-07-04T10:40:27.371000  / # . /lava-695096/environment/lava-695096/=
bin/lava-test-runner /lava-695096/1
    2023-07-04T10:40:27.372192  =

    2023-07-04T10:40:27.376611  / # /lava-695096/bin/lava-test-runner /lava=
-695096/1
    2023-07-04T10:40:27.407906  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
