Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D30729E3C
	for <lists+stable@lfdr.de>; Fri,  9 Jun 2023 17:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241269AbjFIPXS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 9 Jun 2023 11:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241482AbjFIPXD (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Jun 2023 11:23:03 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAD61FF3
        for <stable@vger.kernel.org>; Fri,  9 Jun 2023 08:22:59 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-256a41d3e81so775418a91.1
        for <stable@vger.kernel.org>; Fri, 09 Jun 2023 08:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686324179; x=1688916179;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SIOygPzMStVGMCKTKAMDG/MUn38Yan6wvQQWAPCOG5Q=;
        b=uYIZGARtov9UWSMJbx8MaZwDIxWjM3q6dpVbde8lROTEPPLsIwkKlnDKQ/8RxCNp8G
         MCDZaNck7GlyWMSQIYfrxuyAHiXtDozit/v/D0kfyWtxPdLzIQWg/bRZO2Xf52q8l8Cs
         rWXadTxXsMrHJnEDa7EESV/CwbXqA4UKZYreDOfAx8rS25WZNJq+pehOZ05CCk8INDLG
         a5Xwdz742gTvr3yAh1waoyppqQdNJ0+gOoZvMB99YdP33qh+L/mvHDy/GDq3OH6oBGYO
         BdJVktyReWFst78Yz9vyLkc8Cps8K8zv0E9yScaDIHiGiJ4M5nIrghsKmHrnYabqeZuN
         5xRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686324179; x=1688916179;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SIOygPzMStVGMCKTKAMDG/MUn38Yan6wvQQWAPCOG5Q=;
        b=PR+FK4sXX67dTBaY9vytOyyuipS9xJx4zd7vuqX/nGO41XXYy/FdS7Gx6IUeEWG5yw
         WmLIcm2ovYMIBMFkovQnsPjmWdnL12dLI8SIYb9p7/h07B0Yer52GRWBhc5LU8wtAjBm
         Uf4wOZKxOVhPbJ8rd6XhseMnKL2d9JGbuTbnmeREISDZsV6tf0bYlmM5PLdQGfUNbwB+
         0YgGZZFAQ9XRwj8EceDI7c7/wIDVymG2PaSGBu9/8x3Dltka5CtBhzLrc3jiMYmwHkfl
         G5x50BDhaN/d5dQ/ZGZo0iW3G4Nx5FCCFu3ct3/qkvDTmcxucOg11UQGgu/CSMTWuJ31
         r/Ow==
X-Gm-Message-State: AC+VfDxWKEMMZOWgyUYxbHAWtA76qAv1pUlgqlqiMA1cXY1Fqqzj0o+C
        k0XWpgfKcBuL8epkGKNPCJlDn5pSkwD8GrVv54VIeQ==
X-Google-Smtp-Source: ACHHUZ5rkjtjyvd6Lc1HEXSqIw7ptSQCQFR4ezZrEeVYiUu3o/+6Xswjr4DCqroVF86QYbcPylwoBg==
X-Received: by 2002:a17:90b:3b52:b0:259:17ba:e89a with SMTP id ot18-20020a17090b3b5200b0025917bae89amr1461894pjb.34.1686324178687;
        Fri, 09 Jun 2023 08:22:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k19-20020a6568d3000000b00543b4433aa9sm2859498pgt.36.2023.06.09.08.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 08:22:58 -0700 (PDT)
Message-ID: <648343d2.650a0220.bb212.5c12@mx.google.com>
Date:   Fri, 09 Jun 2023 08:22:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.183
Subject: stable/linux-5.10.y baseline: 143 runs, 8 regressions (v5.10.183)
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

stable/linux-5.10.y baseline: 143 runs, 8 regressions (v5.10.183)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.10.y/kernel=
/v5.10.183/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.10.y
  Describe: v5.10.183
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      7356714b95aa6b186430289090a7fe5bdff2cf18 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64831185e82b1fe453306188

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.183/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.183/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64831185e82b1fe453306=
189
        new failure (last pass: v5.10.182) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64830d93711e94642830615f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.183/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.183/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64830d93711e946428306=
160
        new failure (last pass: v5.10.182) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648310d247779dfdb3306140

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.183/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.183/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648310d247779dfdb3306145
        failing since 141 days (last pass: v5.10.158, first fail: v5.10.164)

    2023-06-09T11:44:10.810816  + set +x<8>[   11.168450] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3652667_1.5.2.4.1>
    2023-06-09T11:44:10.811068  =

    2023-06-09T11:44:10.918204  / # #
    2023-06-09T11:44:11.019786  export SHELL=3D/bin/sh
    2023-06-09T11:44:11.020589  #
    2023-06-09T11:44:11.122477  / # export SHELL=3D/bin/sh. /lava-3652667/e=
nvironment
    2023-06-09T11:44:11.123402  =

    2023-06-09T11:44:11.225087  / # . /lava-3652667/environment/lava-365266=
7/bin/lava-test-runner /lava-3652667/1
    2023-06-09T11:44:11.226512  =

    2023-06-09T11:44:11.233051  / # /lava-3652667/bin/lava-test-runner /lav=
a-3652667/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64830e67734b8634633061a6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.183/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.183/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64830e67734b8634633061ab
        failing since 65 days (last pass: v5.10.176, first fail: v5.10.177)

    2023-06-09T11:34:51.770111  + set +x

    2023-06-09T11:34:51.776848  <8>[   14.802975] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10657648_1.4.2.3.1>

    2023-06-09T11:34:51.884988  / # #

    2023-06-09T11:34:51.987315  export SHELL=3D/bin/sh

    2023-06-09T11:34:51.988093  #

    2023-06-09T11:34:52.089545  / # export SHELL=3D/bin/sh. /lava-10657648/=
environment

    2023-06-09T11:34:52.090269  =


    2023-06-09T11:34:52.191753  / # . /lava-10657648/environment/lava-10657=
648/bin/lava-test-runner /lava-10657648/1

    2023-06-09T11:34:52.192984  =


    2023-06-09T11:34:52.198564  / # /lava-10657648/bin/lava-test-runner /la=
va-10657648/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64831c3045cc69c1c630614e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.183/=
arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.183/=
arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64831c3045cc69c1c6306=
14f
        new failure (last pass: v5.10.182) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64830b94c0d659d98730613c

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.183/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.183/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64830b94c0d659d987306142
        failing since 83 days (last pass: v5.10.174, first fail: v5.10.175)

    2023-06-09T11:23:09.687965  /lava-10657373/1/../bin/lava-test-case

    2023-06-09T11:23:09.698457  <8>[   35.102970] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64830b94c0d659d987306143
        failing since 83 days (last pass: v5.10.174, first fail: v5.10.175)

    2023-06-09T11:23:07.630344  <8>[   33.032273] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-06-09T11:23:08.650845  /lava-10657373/1/../bin/lava-test-case

    2023-06-09T11:23:08.661758  <8>[   34.065582] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648310629fcbcfb1d230618f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.183/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-stm32mp157c-dk2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.183/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-stm32mp157c-dk2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648310629fcbcfb1d2306194
        failing since 128 days (last pass: v5.10.129, first fail: v5.10.166)

    2023-06-09T11:43:20.498855  <8>[   18.793094] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3652661_1.5.2.4.1>
    2023-06-09T11:43:20.605853  / # #
    2023-06-09T11:43:20.707879  export SHELL=3D/bin/sh
    2023-06-09T11:43:20.708339  #
    2023-06-09T11:43:20.809746  / # export SHELL=3D/bin/sh. /lava-3652661/e=
nvironment
    2023-06-09T11:43:20.810580  =

    2023-06-09T11:43:20.912525  / # . /lava-3652661/environment/lava-365266=
1/bin/lava-test-runner /lava-3652661/1
    2023-06-09T11:43:20.913159  =

    2023-06-09T11:43:20.916951  / # /lava-3652661/bin/lava-test-runner /lav=
a-3652661/1
    2023-06-09T11:43:20.984031  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
