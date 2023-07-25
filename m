Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E4D76094A
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 07:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjGYFbr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 01:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjGYFbo (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 01:31:44 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF2C1FD3
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 22:31:13 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b9e478e122so4784332a34.1
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 22:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690263060; x=1690867860;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W2YPhZQwyBNX4ATNnd9vS8c/rYIhqiwixrqGCpMznOk=;
        b=TJTrvphjXxhRncsq3P8tRzJz9ba9TuvC698gbE+8ZXhgAJingeXMWdSvc72TiJx5G1
         G3g9156IlpNNk/bw6BN+L8M4CAHolE/GjUtOPzOeDzffWMTF/oQcUjehR5j7K1tX1yi2
         3Wb/ZvlH7l1WHw+uc/33DUqviXy2KsINOncRdfQgNVacmsDu59GzeK2l3XgxeSmM+bJL
         fx879vdsTdCsoWySeRSyKAc6Jq2Hrnb4BIchIqCT3yVmK/nApW1jx7v4B5q8G3eV9Qyb
         jOoW4XXlfLhFVyfjf6xGvJ39X0NKWuF3aak5qS+5No/jYFUuOob6C9Pja3eRQaWNpLLa
         +u3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690263060; x=1690867860;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W2YPhZQwyBNX4ATNnd9vS8c/rYIhqiwixrqGCpMznOk=;
        b=Vf000u+ugaqS8aYa8DEKTywgSU9/uK1NPfauFNLpxZcWsaGBjEYAm2huTyA6G+9mrR
         Y/2icePQXL73GMD5z8YQXcqbpeS6SyESj3dvk9PEglEq3pxBKFwu4iI8AkXs9pXgHYXw
         hSSLqE/uiCS3hu2RAjrFvA9IWPVw7DpXucsQnMAZ8vFmITmQT2MNThOp+5ViaOYDE3EI
         s7A6aE/t+rwsIIio7Dxz5b95AdQoz8Jd9bbm/afxu9eJWbjhUTfahGKAAt3i0TqsL4GO
         dJtFM0h1sA3BAWK2asuWNEvz35qEYS1P40AB0JLdm/BECmZJnLGVUWbQLiF5KxOp2JzF
         rcZg==
X-Gm-Message-State: ABy/qLYsoR/MqNtX4wfFI3LYxXPsNrUffKOqL2SkHHlRDPvOLkEATbya
        FViRzB/NNXECe3QfuBB7NcRjEcYhmvqwx9Dy54BulpUT
X-Google-Smtp-Source: APBJJlE9biCOJitbqqQD8wXCYfF37IUZv01dFd7pVTVoFiE8SLB3zkG9KojzLJu5BdjwtzKD1gHsUw==
X-Received: by 2002:a9d:7407:0:b0:6b7:4efe:a9a4 with SMTP id n7-20020a9d7407000000b006b74efea9a4mr10349596otk.23.1690263060185;
        Mon, 24 Jul 2023 22:31:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z24-20020a63ac58000000b005533b6cb3a6sm9520994pgn.16.2023.07.24.22.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 22:30:59 -0700 (PDT)
Message-ID: <64bf5e13.630a0220.aea75.0da2@mx.google.com>
Date:   Mon, 24 Jul 2023 22:30:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Kernel: v4.19.289-218-g1cf0365815540
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-4.19.y baseline: 48 runs,
 3 regressions (v4.19.289-218-g1cf0365815540)
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

stable-rc/linux-4.19.y baseline: 48 runs, 3 regressions (v4.19.289-218-g1cf=
0365815540)

Regressions Summary
-------------------

platform                 | arch | lab          | compiler | defconfig      =
     | regressions
-------------------------+------+--------------+----------+----------------=
-----+------------
beaglebone-black         | arm  | lab-cip      | gcc-10   | omap2plus_defco=
nfig | 1          =

cubietruck               | arm  | lab-baylibre | gcc-10   | multi_v7_defcon=
fig  | 1          =

imx6q-var-dt6customboard | arm  | lab-baylibre | gcc-10   | multi_v7_defcon=
fig  | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.19.y/ker=
nel/v4.19.289-218-g1cf0365815540/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.289-218-g1cf0365815540
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      1cf0365815540b3e2db00b630d9519430a31b3bc =



Test Regressions
---------------- =



platform                 | arch | lab          | compiler | defconfig      =
     | regressions
-------------------------+------+--------------+----------+----------------=
-----+------------
beaglebone-black         | arm  | lab-cip      | gcc-10   | omap2plus_defco=
nfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64bf2b5933738d08d68ace1c

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
89-218-g1cf0365815540/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beagl=
ebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
89-218-g1cf0365815540/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beagl=
ebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bf2b5933738d08d68ace1f
        new failure (last pass: v4.19.288-158-g5299d5c89ca8)

    2023-07-25T01:53:57.849639  + set +x
    2023-07-25T01:53:57.851630  <8>[   11.479339] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 988777_1.5.2.4.1>
    2023-07-25T01:53:57.963678  / # #
    2023-07-25T01:53:58.065606  export SHELL=3D/bin/sh
    2023-07-25T01:53:58.066070  #
    2023-07-25T01:53:58.167520  / # export SHELL=3D/bin/sh. /lava-988777/en=
vironment
    2023-07-25T01:53:58.167994  =

    2023-07-25T01:53:58.269438  / # . /lava-988777/environment/lava-988777/=
bin/lava-test-runner /lava-988777/1
    2023-07-25T01:53:58.270383  =

    2023-07-25T01:53:58.272664  / # /lava-988777/bin/lava-test-runner /lava=
-988777/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch | lab          | compiler | defconfig      =
     | regressions
-------------------------+------+--------------+----------+----------------=
-----+------------
cubietruck               | arm  | lab-baylibre | gcc-10   | multi_v7_defcon=
fig  | 1          =


  Details:     https://kernelci.org/test/plan/id/64bf2627d251dce6be8acec5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
89-218-g1cf0365815540/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
89-218-g1cf0365815540/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bf2627d251dce6be8aceca
        failing since 188 days (last pass: v4.19.268-50-gbf741d1d7e6d, firs=
t fail: v4.19.269-522-gc75d2b5524ab)

    2023-07-25T01:32:05.395802  <8>[    7.338741] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3724511_1.5.2.4.1>
    2023-07-25T01:32:05.505433  / # #
    2023-07-25T01:32:05.609236  export SHELL=3D/bin/sh
    2023-07-25T01:32:05.610397  #
    2023-07-25T01:32:05.712773  / # export SHELL=3D/bin/sh. /lava-3724511/e=
nvironment
    2023-07-25T01:32:05.713940  =

    2023-07-25T01:32:05.816381  / # . /lava-3724511/environment/lava-372451=
1/bin/lava-test-runner /lava-3724511/1
    2023-07-25T01:32:05.818178  =

    2023-07-25T01:32:05.823147  / # /lava-3724511/bin/lava-test-runner /lav=
a-3724511/1
    2023-07-25T01:32:05.907259  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch | lab          | compiler | defconfig      =
     | regressions
-------------------------+------+--------------+----------+----------------=
-----+------------
imx6q-var-dt6customboard | arm  | lab-baylibre | gcc-10   | multi_v7_defcon=
fig  | 1          =


  Details:     https://kernelci.org/test/plan/id/64bf25e9d251dce6be8ace7f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
89-218-g1cf0365815540/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-i=
mx6q-var-dt6customboard.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
89-218-g1cf0365815540/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-i=
mx6q-var-dt6customboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bf25e9d251dce6be8ace84
        failing since 13 days (last pass: v4.19.254, first fail: v4.19.288-=
88-g86b58f64d958)

    2023-07-25T01:30:57.577234  / # #
    2023-07-25T01:30:57.679092  export SHELL=3D/bin/sh
    2023-07-25T01:30:57.679532  #
    2023-07-25T01:30:57.780849  / # export SHELL=3D/bin/sh. /lava-3724509/e=
nvironment
    2023-07-25T01:30:57.781204  =

    2023-07-25T01:30:57.882545  / # . /lava-3724509/environment/lava-372450=
9/bin/lava-test-runner /lava-3724509/1
    2023-07-25T01:30:57.883161  =

    2023-07-25T01:30:57.889372  / # /lava-3724509/bin/lava-test-runner /lav=
a-3724509/1
    2023-07-25T01:30:57.998348  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-25T01:30:57.998697  + cd /lava-3724509/1/tests/1_bootrr =

    ... (16 line(s) more)  =

 =20
