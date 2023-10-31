Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D8D7DD6A5
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 20:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjJaTZA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 15:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjJaTY7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 15:24:59 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54ABCC2
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 12:24:57 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b1ef786b7fso6053526b3a.3
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 12:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698780296; x=1699385096; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LY6AnzVTp4a+Qy1fbeNmQHTLwpHF+3rq1bErLmEZLzs=;
        b=ii8PiyEetu6oFIRgGGRgMjwwI3aqRO0aLZGrrVbuNlooIs29WYcJm505i48MbxPU+Q
         1y5tMAIXIJyoZdkIbAsE3Dr5VCsxqz2vwpETWKNFkC9jww6czSWDjCG43q1VbRRIjA9F
         WaQIPKcZ+AWzF7wt8Sqo4MR3LO5lDk7f1wZGGDQJyKj2eyI6+fRav9zXvUcoIowaepON
         4F+5sS3fHvxY3MdI2fKc5CCNKuXT51fuYczjwTeme4mAXOJsFG3LgNPvmSQEX3EUPkHV
         /bUnEGZ2DR3UO5bRSlmmm4BIto+pYxSJxFmABdDKA5o8NA/TKzaye5SUC4WwxQ8VtH/k
         ytSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698780296; x=1699385096;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LY6AnzVTp4a+Qy1fbeNmQHTLwpHF+3rq1bErLmEZLzs=;
        b=N6JDLm3C/stoztZjMAPlZi9ytRlrvCGWgZKziJXsFeVuW1e+pHYEmrK0wXDVCcpywo
         eg1dW9MuyLi2Xri7CnOa63GY+6b4arwEZV3onTmZt6WXbbOE44ixYcXpjTGSPHTP9mnF
         nD76vPSEAInc2kReZ3cTQP9dXj7l9CGihLs1+2Mg5r1TXGp16mY+pA8nlvd/bT46OBj2
         rRACQtfGhoGPVxZue5IxAYQt2BDLxffyhYqFHF8C8yhppyXiX3917ifgm/KpbpKTaryJ
         KQ4Kw3NRGAsodjjSsoECjNWEKIKys9uT722E7ST6Vx9Fx+jSiknqHn9N8K5OCSDs8pYw
         GdXw==
X-Gm-Message-State: AOJu0Yw8gEf8B/7oE61oWtvXn/Bsdab5O93Rf+ACUzykJyG+3A980Wlf
        JgP6YyyKZlW78IhkcqE8KHyHgtJiJmjgI8cRdnfwgw==
X-Google-Smtp-Source: AGHT+IHQZjqc6XYXp38pPGCs1uTwksu6+GJYQ8Npjfes23LzvPWrUqiVVRxUIdJmfDFuB/sxZDfdIw==
X-Received: by 2002:a05:6a00:2d82:b0:6b2:6835:2a7f with SMTP id fb2-20020a056a002d8200b006b268352a7fmr15075006pfb.22.1698780296394;
        Tue, 31 Oct 2023 12:24:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u17-20020a056a00099100b006be4bb0d2dcsm905pfg.149.2023.10.31.12.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 12:24:55 -0700 (PDT)
Message-ID: <65415487.050a0220.47b30.0011@mx.google.com>
Date:   Tue, 31 Oct 2023 12:24:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.297-40-g79ba95be7c78
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-4.19.y baseline: 130 runs,
 4 regressions (v4.19.297-40-g79ba95be7c78)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-4.19.y baseline: 130 runs, 4 regressions (v4.19.297-40-g79b=
a95be7c78)

Regressions Summary
-------------------

platform               | arch  | lab          | compiler | defconfig       =
    | regressions
-----------------------+-------+--------------+----------+-----------------=
----+------------
beaglebone-black       | arm   | lab-cip      | gcc-10   | omap2plus_defcon=
fig | 1          =

meson-gxm-q200         | arm64 | lab-baylibre | gcc-10   | defconfig       =
    | 1          =

sun50i-a64-pine64-plus | arm64 | lab-baylibre | gcc-10   | defconfig       =
    | 1          =

sun50i-a64-pine64-plus | arm64 | lab-broonie  | gcc-10   | defconfig       =
    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.19.y/ker=
nel/v4.19.297-40-g79ba95be7c78/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.297-40-g79ba95be7c78
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      79ba95be7c783391caf279ac2c334da8f3139d39 =



Test Regressions
---------------- =



platform               | arch  | lab          | compiler | defconfig       =
    | regressions
-----------------------+-------+--------------+----------+-----------------=
----+------------
beaglebone-black       | arm   | lab-cip      | gcc-10   | omap2plus_defcon=
fig | 1          =


  Details:     https://kernelci.org/test/plan/id/6541298a23f7348b5befcefe

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
97-40-g79ba95be7c78/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beagleb=
one-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
97-40-g79ba95be7c78/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beagleb=
one-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6541298b23f7348b5befcf1c
        new failure (last pass: v4.19.297)

    2023-10-31T16:20:58.588262  / # #
    2023-10-31T16:20:58.689270  export SHELL=3D/bin/sh
    2023-10-31T16:20:58.689677  #
    2023-10-31T16:20:58.790577  / # export SHELL=3D/bin/sh. /lava-1030132/e=
nvironment
    2023-10-31T16:20:58.791025  =

    2023-10-31T16:20:58.891835  / # . /lava-1030132/environment/lava-103013=
2/bin/lava-test-runner /lava-1030132/1
    2023-10-31T16:20:58.892355  =

    2023-10-31T16:20:58.932900  / # /lava-1030132/bin/lava-test-runner /lav=
a-1030132/1
    2023-10-31T16:20:59.114813  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-31T16:20:59.115002  + cd /lava-1030132/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform               | arch  | lab          | compiler | defconfig       =
    | regressions
-----------------------+-------+--------------+----------+-----------------=
----+------------
meson-gxm-q200         | arm64 | lab-baylibre | gcc-10   | defconfig       =
    | 1          =


  Details:     https://kernelci.org/test/plan/id/6541236600b9172dadefcef4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
97-40-g79ba95be7c78/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-=
q200.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
97-40-g79ba95be7c78/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-=
q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/6541236600b9172=
dadefcef7
        failing since 15 days (last pass: v4.19.288, first fail: v4.19.296-=
42-gb3c2ae79aa73)
        1 lines

    2023-10-31T15:55:03.279917  kern  :emerg : Disabling IRQ #18
    2023-10-31T15:55:03.280401  <4>[   49.509638] ------------[ cut here ]-=
-----------
    2023-10-31T15:55:03.280617  <4>[   49.509731] WARNING: CPU: 0 PID: 0 at=
 drivers/mmc/host/meson-gx-mmc.c:1040 meson_mmc_irq+0x1c8/0x1dc
    2023-10-31T15:55:03.280819  <8>[   49.511918] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D1>   =

 =



platform               | arch  | lab          | compiler | defconfig       =
    | regressions
-----------------------+-------+--------------+----------+-----------------=
----+------------
sun50i-a64-pine64-plus | arm64 | lab-baylibre | gcc-10   | defconfig       =
    | 1          =


  Details:     https://kernelci.org/test/plan/id/6541236583c58919b0efcf17

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
97-40-g79ba95be7c78/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64=
-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
97-40-g79ba95be7c78/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64=
-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6541236583c58919b0efcf41
        failing since 287 days (last pass: v4.19.265-42-ga2d8c749b30c, firs=
t fail: v4.19.269-522-gc75d2b5524ab)

    2023-10-31T15:54:31.726180  <8>[   15.907880] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3819654_1.5.2.4.1>
    2023-10-31T15:54:31.830904  / # #
    2023-10-31T15:54:31.933761  export SHELL=3D/bin/sh
    2023-10-31T15:54:31.934800  #
    2023-10-31T15:54:32.036325  / # export SHELL=3D/bin/sh. /lava-3819654/e=
nvironment
    2023-10-31T15:54:32.037138  =

    2023-10-31T15:54:32.138542  / # . /lava-3819654/environment/lava-381965=
4/bin/lava-test-runner /lava-3819654/1
    2023-10-31T15:54:32.139972  =

    2023-10-31T15:54:32.144281  / # /lava-3819654/bin/lava-test-runner /lav=
a-3819654/1
    2023-10-31T15:54:32.176083  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform               | arch  | lab          | compiler | defconfig       =
    | regressions
-----------------------+-------+--------------+----------+-----------------=
----+------------
sun50i-a64-pine64-plus | arm64 | lab-broonie  | gcc-10   | defconfig       =
    | 1          =


  Details:     https://kernelci.org/test/plan/id/6541236017dce8bb90efcf1a

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
97-40-g79ba95be7c78/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-=
pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
97-40-g79ba95be7c78/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-=
pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6541236017dce8bb90efcf40
        failing since 287 days (last pass: v4.19.265-42-ga2d8c749b30c, firs=
t fail: v4.19.269-522-gc75d2b5524ab)

    2023-10-31T15:54:39.627183  <8>[   15.926005] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 210402_1.5.2.4.1>
    2023-10-31T15:54:39.731186  / # #
    2023-10-31T15:54:39.832697  export SHELL=3D/bin/sh
    2023-10-31T15:54:39.833184  #
    2023-10-31T15:54:39.934435  / # export SHELL=3D/bin/sh. /lava-210402/en=
vironment
    2023-10-31T15:54:39.934846  =

    2023-10-31T15:54:40.036238  / # . /lava-210402/environment/lava-210402/=
bin/lava-test-runner /lava-210402/1
    2023-10-31T15:54:40.036832  =

    2023-10-31T15:54:40.040978  / # /lava-210402/bin/lava-test-runner /lava=
-210402/1
    2023-10-31T15:54:40.072116  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
