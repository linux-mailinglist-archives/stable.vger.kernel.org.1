Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F14A6F99A6
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 18:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjEGQSs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 12:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEGQSr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 12:18:47 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194C017FF7
        for <stable@vger.kernel.org>; Sun,  7 May 2023 09:18:46 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1aaf70676b6so25042485ad.3
        for <stable@vger.kernel.org>; Sun, 07 May 2023 09:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683476325; x=1686068325;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PyYrX/SNOZaTaeG/NvB57F9qbAMyvmgYhfAljMvlrDc=;
        b=akYl9jIcRq+j4MSq5JWirCfZ7B78rxTJXLwPBJgZPtreBS04OWzpxx+s8ZbHUlLdNL
         NOvkRzm2lLCyQlKAhP6YJAeQL/oj/9nRmNJPhMsDbaB/Wt3htWqV6JEXwhxHrJBIbLGq
         nJA2F5dPSiJEC4nmF3TRJbBoB+TMRHS38peA2g9YeNxyBQ7rcByDwLCjjdvTFhTZXFP8
         MH0zyPxfWPIVAE+GVN1L2cd0jF6As0ryhk1iT+5PUVg8nymRCX0Y9Qeje/50jlU6dL/d
         MY6hLTXVZR1wqXyz+8D1B1jBnjmLWZyOQDTjfBc+h7vvES4Rs75iQFbF7bY3mtktYlhs
         gTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683476325; x=1686068325;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PyYrX/SNOZaTaeG/NvB57F9qbAMyvmgYhfAljMvlrDc=;
        b=FXGIpH4wCsYMjpzOjXvMNNQO3Q8fklHSaV2OeGV4I2MQs0T7RKxkyIADAQFxC3dA5+
         6VaD1J6BpXRe98ZEEIyijAGP1PfoCq00Z18YdPJ4LrPPlFTCmhNRoPpeBytbFN/lEYMo
         fJrgOx0ekCUwEGaCDaaIZLf+zwjB+JUeKeryNwdrwMvW7yyhbzjNVitxyDSIEeTDX2HC
         VDd03jTdNvUb/AXV2PgQ0eq3JvcFjDhoVcdQO1whHA+MjyW7PSI1aI3Cr5xeKp4p6CIw
         hzh91uGFwqV1IyMPA4lhMzHFeEFL2n5PFvSCJTLhhSa7s86z1j8leTFIvQlsZeJYgacO
         n0oA==
X-Gm-Message-State: AC+VfDzKLvu7Qc9BaScnA3N5spBEsOQD9CUI3ts0ptN7FVhHE8mJ14Pd
        gdpt1DFiWNqFxVgljXcM48PpMfxngrNvyVLJUw4llw==
X-Google-Smtp-Source: ACHHUZ53yOpLb6tckPt67JSEwGKvI4CYyQfa7LJAh3iI6/7Z8gt6Uehryz5o0cFYCdKaH1Ttsrxl8A==
X-Received: by 2002:a17:902:ce83:b0:1a6:6b9d:5e0f with SMTP id f3-20020a170902ce8300b001a66b9d5e0fmr9026845plg.17.1683476325038;
        Sun, 07 May 2023 09:18:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t13-20020a1709027fcd00b001a9b7584824sm5419203plb.159.2023.05.07.09.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 09:18:44 -0700 (PDT)
Message-ID: <6457cf64.170a0220.b47ec.966f@mx.google.com>
Date:   Sun, 07 May 2023 09:18:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.176-643-g4634359d0497b
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 128 runs,
 6 regressions (v5.10.176-643-g4634359d0497b)
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

stable-rc/queue/5.10 baseline: 128 runs, 6 regressions (v5.10.176-643-g4634=
359d0497b)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

qemu_x86_64-uefi             | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig             | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.176-643-g4634359d0497b/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.176-643-g4634359d0497b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      4634359d0497b92d9b17c2b39721c0d1216dbde3 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/645797800a178dd30b2e8615

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-643-g4634359d0497b/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-643-g4634359d0497b/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645797800a178dd30b2e8644
        failing since 82 days (last pass: v5.10.167-127-g921934d621e4, firs=
t fail: v5.10.167-139-gf9519a5a1701)

    2023-05-07T12:20:01.932826  <8>[   20.139439] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 422613_1.5.2.4.1>
    2023-05-07T12:20:02.043183  / # #
    2023-05-07T12:20:02.146222  export SHELL=3D/bin/sh
    2023-05-07T12:20:02.147101  #
    2023-05-07T12:20:02.249252  / # export SHELL=3D/bin/sh. /lava-422613/en=
vironment
    2023-05-07T12:20:02.249938  =

    2023-05-07T12:20:02.351663  / # . /lava-422613/environment/lava-422613/=
bin/lava-test-runner /lava-422613/1
    2023-05-07T12:20:02.352781  =

    2023-05-07T12:20:02.357087  / # /lava-422613/bin/lava-test-runner /lava=
-422613/1
    2023-05-07T12:20:02.460634  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64579610766844575d2e8603

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-643-g4634359d0497b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-643-g4634359d0497b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64579610766844575d2e8608
        failing since 38 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-07T12:13:56.035640  + <8>[   10.404926] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10226790_1.4.2.3.1>

    2023-05-07T12:13:56.035721  set +x

    2023-05-07T12:13:56.137083  =


    2023-05-07T12:13:56.237657  / # #export SHELL=3D/bin/sh

    2023-05-07T12:13:56.237878  =


    2023-05-07T12:13:56.338416  / # export SHELL=3D/bin/sh. /lava-10226790/=
environment

    2023-05-07T12:13:56.338634  =


    2023-05-07T12:13:56.439183  / # . /lava-10226790/environment/lava-10226=
790/bin/lava-test-runner /lava-10226790/1

    2023-05-07T12:13:56.439470  =


    2023-05-07T12:13:56.444471  / # /lava-10226790/bin/lava-test-runner /la=
va-10226790/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64579601d54d5cab7a2e8615

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-643-g4634359d0497b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-643-g4634359d0497b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64579601d54d5cab7a2e861a
        failing since 38 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-07T12:13:39.251776  + set +x

    2023-05-07T12:13:39.258397  <8>[   13.376986] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10226793_1.4.2.3.1>

    2023-05-07T12:13:39.365914  =


    2023-05-07T12:13:39.467701  / # #export SHELL=3D/bin/sh

    2023-05-07T12:13:39.468424  =


    2023-05-07T12:13:39.569921  / # export SHELL=3D/bin/sh. /lava-10226793/=
environment

    2023-05-07T12:13:39.570548  =


    2023-05-07T12:13:39.671884  / # . /lava-10226793/environment/lava-10226=
793/bin/lava-test-runner /lava-10226793/1

    2023-05-07T12:13:39.673409  =


    2023-05-07T12:13:39.678733  / # /lava-10226793/bin/lava-test-runner /la=
va-10226793/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi             | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/64579978d0d925bd032e8613

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-643-g4634359d0497b/x86_64/x86_64_defconfig/gcc-10/lab-collabora/baseline-q=
emu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-643-g4634359d0497b/x86_64/x86_64_defconfig/gcc-10/lab-collabora/baseline-q=
emu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64579978d0d925bd032e8=
614
        new failure (last pass: v5.10.176-639-g1bcbd29cf5f8) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64579fdad8dabacb742e8649

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-643-g4634359d0497b/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-643-g4634359d0497b/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64579fdad8dabacb742e864f
        failing since 54 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-07T12:55:33.991594  <8>[   33.888901] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-05-07T12:55:35.016667  /lava-10227122/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64579fdad8dabacb742e8650
        failing since 54 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-07T12:55:33.979706  /lava-10227122/1/../bin/lava-test-case
   =

 =20
