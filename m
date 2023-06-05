Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9B9722533
	for <lists+stable@lfdr.de>; Mon,  5 Jun 2023 14:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjFEMGs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 5 Jun 2023 08:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjFEMGr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Jun 2023 08:06:47 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738789C
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 05:06:43 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6549df4321aso2062870b3a.2
        for <stable@vger.kernel.org>; Mon, 05 Jun 2023 05:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685966802; x=1688558802;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RxnqqX9vExH5L8nE5JfQV4ZPD49iaA3Mw3nZZi0hQ08=;
        b=Rm3RqL09Y4m9IBCsVF0jPimQwEMEApV4V3TTI1Zt/bS1h49dB1oGmfkCN03ih1/ZD+
         7rjdylU9QtZ+NGmwTvSLvrKO+5HyA3hPmKWotsaIZX0gvfYSb/q+uj/VkFaESlplxjee
         iliEjMIwm49Q2MjiPAbm+QE2n1iC5b35hOgkpRPxNfC+D+kuMeIzIpgKDUWiLoG31trt
         W5v7eh1Rs4QYU08pQ67VjMC4woOJL2E4fjk9ieZZE4jPmUEksMGDDp7QMaIu+7iOXoKX
         W/kJCs6BbSN5FHySWlawvsPG/gjCuLYj0wlTyOlc+mhfXePqRO68Cg3PJRVRFnhKh5XC
         fHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685966802; x=1688558802;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RxnqqX9vExH5L8nE5JfQV4ZPD49iaA3Mw3nZZi0hQ08=;
        b=bXWDkoNr0zW/skPTicJIDUnDTW7eLihBH2+rGzBiIVHeBh2L2O5IW0Moa+5R5JtpjM
         At0eF4tEF8koNBBntpG2wN9Ll791VmU56Dwn6m/lcle5C1qdMxnEKxBHFSNH9nB62zii
         bR2nxUzpBatLwL5rBA9tKYAObd2gxuz9Y3dXH/eaQNrZ6ERkxL2gn9kNYc7BQTqr5Br1
         7YPMDxhFNaM+B0NZ5FgG5aLOzzWw/swPO9139vxVEDWMrCic+2AweCERv7KQyBNNqXWi
         UyfcuP9Y7RlA1Ezqa5DBI22A0tfV5ENOTt3WB8RU6bCnDC4y/XOWgMx5TdvGSAKdW40U
         9qmw==
X-Gm-Message-State: AC+VfDxf3O6UkvKiUHCcwMOFY5FgKYnXkW8grj7hYFf6gdy5rHP6Z4AF
        o+WNUHSPqGwTGuoMbWveaMo4wP8nCDSpcYCjxDKfAA==
X-Google-Smtp-Source: ACHHUZ4JB9rQnL/7o+tiAvJBcwlnzZ1L3iBARCciJ7RdCcHEkRckz62Ix/UKTr67OPbC5wE4H0xzNw==
X-Received: by 2002:a05:6a20:4283:b0:117:1ffb:a14 with SMTP id o3-20020a056a20428300b001171ffb0a14mr1240129pzj.13.1685966802513;
        Mon, 05 Jun 2023 05:06:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r7-20020a62e407000000b006542e358721sm3817016pfh.186.2023.06.05.05.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 05:06:41 -0700 (PDT)
Message-ID: <647dcfd1.620a0220.dc243.5de5@mx.google.com>
Date:   Mon, 05 Jun 2023 05:06:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.182
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable
Subject: stable/linux-5.10.y baseline: 173 runs, 5 regressions (v5.10.182)
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

stable/linux-5.10.y baseline: 173 runs, 5 regressions (v5.10.182)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.10.y/kernel=
/v5.10.182/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.10.y
  Describe: v5.10.182
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      c7992b6c7f0e2b0a87dd8e3f488250557b077c20 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647db783e363e6237ff5def3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.182/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-c=
b317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.182/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-c=
b317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647db783e363e6237ff5d=
ef4
        new failure (last pass: v5.10.181) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647d9f16e2a21d941ff5de6b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.182/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.182/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647d9f16e2a21d941ff5de74
        failing since 137 days (last pass: v5.10.158, first fail: v5.10.164)

    2023-06-05T08:38:22.364288  <8>[   11.207209] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3641770_1.5.2.4.1>
    2023-06-05T08:38:22.470686  / # #
    2023-06-05T08:38:22.572042  export SHELL=3D/bin/sh
    2023-06-05T08:38:22.572394  #
    2023-06-05T08:38:22.673586  / # export SHELL=3D/bin/sh. /lava-3641770/e=
nvironment
    2023-06-05T08:38:22.673939  =

    2023-06-05T08:38:22.674117  / # <3>[   11.451119] Bluetooth: hci0: comm=
and 0x0c03 tx timeout
    2023-06-05T08:38:22.775270  . /lava-3641770/environment/lava-3641770/bi=
n/lava-test-runner /lava-3641770/1
    2023-06-05T08:38:22.775837  =

    2023-06-05T08:38:22.780584  / # /lava-3641770/bin/lava-test-runner /lav=
a-3641770/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647db670d862a152d3f5de36

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.182/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.182/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647db670d862a152d3f5de3f
        failing since 60 days (last pass: v5.10.176, first fail: v5.10.177)

    2023-06-05T10:18:07.264488  + set +x

    2023-06-05T10:18:07.271388  <8>[   14.420770] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10589081_1.4.2.3.1>

    2023-06-05T10:18:07.376115  / # #

    2023-06-05T10:18:07.476868  export SHELL=3D/bin/sh

    2023-06-05T10:18:07.477112  #

    2023-06-05T10:18:07.577666  / # export SHELL=3D/bin/sh. /lava-10589081/=
environment

    2023-06-05T10:18:07.577918  =


    2023-06-05T10:18:07.678499  / # . /lava-10589081/environment/lava-10589=
081/bin/lava-test-runner /lava-10589081/1

    2023-06-05T10:18:07.678901  =


    2023-06-05T10:18:07.683508  / # /lava-10589081/bin/lava-test-runner /la=
va-10589081/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/647db628672a4e2e37f5de37

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.182/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.182/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/647db628672a4e2e37f5de41
        failing since 79 days (last pass: v5.10.174, first fail: v5.10.175)

    2023-06-05T10:16:57.356475  <8>[   61.094741] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-06-05T10:16:58.380398  /lava-10589166/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/647db628672a4e2e37f5de42
        failing since 79 days (last pass: v5.10.174, first fail: v5.10.175)

    2023-06-05T10:16:56.322457  <8>[   60.060408] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-06-05T10:16:57.345495  /lava-10589166/1/../bin/lava-test-case
   =

 =20
