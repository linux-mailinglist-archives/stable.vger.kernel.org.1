Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FB5747494
	for <lists+stable@lfdr.de>; Tue,  4 Jul 2023 16:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjGDO4U (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 4 Jul 2023 10:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjGDO4U (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 4 Jul 2023 10:56:20 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC0EE47
        for <stable@vger.kernel.org>; Tue,  4 Jul 2023 07:56:17 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-262f7b67da8so2701614a91.0
        for <stable@vger.kernel.org>; Tue, 04 Jul 2023 07:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688482577; x=1691074577;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBwUuVxMPKKllbghy9MC4Exsmfe+1CKy/871RkQhAx8=;
        b=vpCNSQ/10nSaDW4i3nXe44m+zhs0JKK6F0LjyZjz5u8i43qohGolkmOUhPnufw2ESP
         qHVPOYl0goNbajWhSTPtlcKHGICFC/NXN8+KdSpizvhYVs/eD9WVUjv4xKRyifl0Inxl
         mBgmfVXC5E0La0M12foixBVOP+k21Tb/btXm1hONC+r2dJmjCneKYAYK9EEexw564n2D
         SDOVt5aXmSnWIAOJ521zVXFRHblGFpBu0hLGJk0kOrNzVjXGNURb0sZdck+zpTxty2yq
         9VAB5L0qCAmJq3MQcTLj8WyH1IO1a3XD6t+JDgGhWO7hQ2OhrYysHvnEXPiG+0jlrDXq
         TsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688482577; x=1691074577;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZBwUuVxMPKKllbghy9MC4Exsmfe+1CKy/871RkQhAx8=;
        b=Z08x8W/vbeDxKeM2h1fL4lqLyksqPZObWcA7gPhR8nlm4SWBLzKOeOv1E6t4Dg/5TY
         oM+mhulW6N7kMKxUWNA/Az9cMnfKpt9Ldv21cH5ZkMIhUEHKe2r/pVUmZ4ObhNB+JiGs
         SXQ+b5AmmgH1CoSA96xZVUipxb5I8AnkZvFLT99aYrRRoB0iz8axa7gRsBUy74khTlJf
         pg8y9D5NNyssYbHh8lPWv+4r8BeCSnFeL9gtIfeAv8Mnooqx/53j8cNFAOt51QYjFsIT
         cDBgzI+FFHT8DyuP9s3v3vWINy7VWEsDan6Pv1SAgc3xD0MpeaXGktfjTgmHfVCB265g
         F1VQ==
X-Gm-Message-State: ABy/qLY74LPc2fePhDex7ulilrLMH/V7tRqCR2cKBU6LAXDi4YaPy5Fo
        XkZZZXGELkdrbEVAYFo4KgjPj94rNctx3tUYhB6Kmg==
X-Google-Smtp-Source: APBJJlHDk5JsVcoyRq9z5AVbW69vqUA9uozkjnZ+Ty5i/M9hoJ5GkdQXughdyy/C9KgNTyJJjKiHIA==
X-Received: by 2002:a17:90a:694f:b0:262:ec74:bb33 with SMTP id j15-20020a17090a694f00b00262ec74bb33mr11197452pjm.46.1688482576414;
        Tue, 04 Jul 2023 07:56:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bx9-20020a17090af48900b002639cc3c064sm6092011pjb.27.2023.07.04.07.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 07:56:15 -0700 (PDT)
Message-ID: <64a4330f.170a0220.8bb81.adab@mx.google.com>
Date:   Tue, 04 Jul 2023 07:56:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15.119-18-g492521f41846
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.15.y
Subject: stable-rc/linux-5.15.y baseline: 129 runs,
 11 regressions (v5.15.119-18-g492521f41846)
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

stable-rc/linux-5.15.y baseline: 129 runs, 11 regressions (v5.15.119-18-g49=
2521f41846)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.119-18-g492521f41846/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.119-18-g492521f41846
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      492521f41846c04df93ee45e8b780dc9478d90df =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3f77eb5cb840015bb2a78

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-18-g492521f41846/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-18-g492521f41846/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3f77eb5cb840015bb2a7d
        failing since 97 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-07-04T10:41:41.234030  + set +x

    2023-07-04T10:41:41.240741  <8>[   10.566000] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11006928_1.4.2.3.1>

    2023-07-04T10:41:41.348556  / # #

    2023-07-04T10:41:41.450717  export SHELL=3D/bin/sh

    2023-07-04T10:41:41.451471  #

    2023-07-04T10:41:41.553002  / # export SHELL=3D/bin/sh. /lava-11006928/=
environment

    2023-07-04T10:41:41.553786  =


    2023-07-04T10:41:41.655304  / # . /lava-11006928/environment/lava-11006=
928/bin/lava-test-runner /lava-11006928/1

    2023-07-04T10:41:41.656533  =


    2023-07-04T10:41:41.662862  / # /lava-11006928/bin/lava-test-runner /la=
va-11006928/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3f7721a8e53f76abb2a93

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-18-g492521f41846/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-18-g492521f41846/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3f7721a8e53f76abb2a98
        failing since 97 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-07-04T10:41:33.089172  + set<8>[   11.503872] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11006958_1.4.2.3.1>

    2023-07-04T10:41:33.089703   +x

    2023-07-04T10:41:33.197026  / # #

    2023-07-04T10:41:33.299675  export SHELL=3D/bin/sh

    2023-07-04T10:41:33.300419  #

    2023-07-04T10:41:33.401981  / # export SHELL=3D/bin/sh. /lava-11006958/=
environment

    2023-07-04T10:41:33.402765  =


    2023-07-04T10:41:33.504256  / # . /lava-11006958/environment/lava-11006=
958/bin/lava-test-runner /lava-11006958/1

    2023-07-04T10:41:33.505545  =


    2023-07-04T10:41:33.510406  / # /lava-11006958/bin/lava-test-runner /la=
va-11006958/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3f77381e1b37a92bb2aaa

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-18-g492521f41846/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-18-g492521f41846/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3f77381e1b37a92bb2aaf
        failing since 97 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-07-04T10:41:30.847659  <8>[    8.436289] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11006963_1.4.2.3.1>

    2023-07-04T10:41:30.850913  + set +x

    2023-07-04T10:41:30.952729  =


    2023-07-04T10:41:31.053407  / # #export SHELL=3D/bin/sh

    2023-07-04T10:41:31.053622  =


    2023-07-04T10:41:31.154240  / # export SHELL=3D/bin/sh. /lava-11006963/=
environment

    2023-07-04T10:41:31.154464  =


    2023-07-04T10:41:31.255251  / # . /lava-11006963/environment/lava-11006=
963/bin/lava-test-runner /lava-11006963/1

    2023-07-04T10:41:31.256321  =


    2023-07-04T10:41:31.261166  / # /lava-11006963/bin/lava-test-runner /la=
va-11006963/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3fc74aa432235e6bb2af6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-18-g492521f41846/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-18-g492521f41846/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a3fc74aa432235e6bb2=
af7
        failing since 417 days (last pass: v5.15.37-259-gab77581473a3, firs=
t fail: v5.15.39) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3fa1d0af9ad4172bb2a8d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-18-g492521f41846/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-18-g492521f41846/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3fa1d0af9ad4172bb2a92
        failing since 168 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-07-04T10:52:59.660789  + set +x<8>[   10.005406] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3711029_1.5.2.4.1>
    2023-07-04T10:52:59.661040  =

    2023-07-04T10:52:59.767246  / # #
    2023-07-04T10:52:59.868482  export SHELL=3D/bin/sh
    2023-07-04T10:52:59.868969  #
    2023-07-04T10:52:59.869275  / # export SHELL=3D/bin/sh<3>[   10.193077]=
 Bluetooth: hci0: command 0x0c03 tx timeout
    2023-07-04T10:52:59.970706  . /lava-3711029/environment
    2023-07-04T10:52:59.971237  =

    2023-07-04T10:53:00.072466  / # . /lava-3711029/environment/lava-371102=
9/bin/lava-test-runner /lava-3711029/1
    2023-07-04T10:53:00.073451   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3f77a75e392d0e4bb2aac

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-18-g492521f41846/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-18-g492521f41846/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3f77a75e392d0e4bb2ab1
        failing since 97 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-07-04T10:42:19.846494  + set +x

    2023-07-04T10:42:19.853199  <8>[   10.057573] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11006986_1.4.2.3.1>

    2023-07-04T10:42:19.957550  / # #

    2023-07-04T10:42:20.058190  export SHELL=3D/bin/sh

    2023-07-04T10:42:20.058458  #

    2023-07-04T10:42:20.159029  / # export SHELL=3D/bin/sh. /lava-11006986/=
environment

    2023-07-04T10:42:20.159243  =


    2023-07-04T10:42:20.259789  / # . /lava-11006986/environment/lava-11006=
986/bin/lava-test-runner /lava-11006986/1

    2023-07-04T10:42:20.260150  =


    2023-07-04T10:42:20.264540  / # /lava-11006986/bin/lava-test-runner /la=
va-11006986/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3f76530fa727582bb2aab

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-18-g492521f41846/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-18-g492521f41846/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3f76530fa727582bb2ab0
        failing since 97 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-07-04T10:41:24.722789  + set +x

    2023-07-04T10:41:24.729699  <8>[   10.888998] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11006972_1.4.2.3.1>

    2023-07-04T10:41:24.831489  =


    2023-07-04T10:41:24.932030  / # #export SHELL=3D/bin/sh

    2023-07-04T10:41:24.932257  =


    2023-07-04T10:41:25.032746  / # export SHELL=3D/bin/sh. /lava-11006972/=
environment

    2023-07-04T10:41:25.032942  =


    2023-07-04T10:41:25.133491  / # . /lava-11006972/environment/lava-11006=
972/bin/lava-test-runner /lava-11006972/1

    2023-07-04T10:41:25.133766  =


    2023-07-04T10:41:25.138543  / # /lava-11006972/bin/lava-test-runner /la=
va-11006972/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3f77081e1b37a92bb2a92

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-18-g492521f41846/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-18-g492521f41846/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3f77081e1b37a92bb2a97
        failing since 97 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-07-04T10:41:37.046380  + <8>[   10.875310] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11006956_1.4.2.3.1>

    2023-07-04T10:41:37.047005  set +x

    2023-07-04T10:41:37.154695  / # #

    2023-07-04T10:41:37.257016  export SHELL=3D/bin/sh

    2023-07-04T10:41:37.257793  #

    2023-07-04T10:41:37.359335  / # export SHELL=3D/bin/sh. /lava-11006956/=
environment

    2023-07-04T10:41:37.360130  =


    2023-07-04T10:41:37.461911  / # . /lava-11006956/environment/lava-11006=
956/bin/lava-test-runner /lava-11006956/1

    2023-07-04T10:41:37.463174  =


    2023-07-04T10:41:37.468570  / # /lava-11006956/bin/lava-test-runner /la=
va-11006956/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3f76430fa727582bb2a97

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-18-g492521f41846/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-18-g492521f41846/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3f76430fa727582bb2a9c
        failing since 97 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-07-04T10:41:25.538766  + set<8>[   11.481054] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11006935_1.4.2.3.1>

    2023-07-04T10:41:25.538847   +x

    2023-07-04T10:41:25.643365  / # #

    2023-07-04T10:41:25.743913  export SHELL=3D/bin/sh

    2023-07-04T10:41:25.744141  #

    2023-07-04T10:41:25.844675  / # export SHELL=3D/bin/sh. /lava-11006935/=
environment

    2023-07-04T10:41:25.844898  =


    2023-07-04T10:41:25.945460  / # . /lava-11006935/environment/lava-11006=
935/bin/lava-test-runner /lava-11006935/1

    2023-07-04T10:41:25.945715  =


    2023-07-04T10:41:25.950618  / # /lava-11006935/bin/lava-test-runner /la=
va-11006935/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3f98325fa256c1abb2a7d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-18-g492521f41846/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-stm=
32mp157c-dk2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-18-g492521f41846/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-stm=
32mp157c-dk2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3f98325fa256c1abb2a82
        failing since 149 days (last pass: v5.15.59, first fail: v5.15.91-2=
1-gd8296a906e7a)

    2023-07-04T10:50:26.179358  <8>[   11.556003] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3711025_1.5.2.4.1>
    2023-07-04T10:50:26.285605  / # #
    2023-07-04T10:50:26.387501  export SHELL=3D/bin/sh
    2023-07-04T10:50:26.388048  #
    2023-07-04T10:50:26.489312  / # export SHELL=3D/bin/sh. /lava-3711025/e=
nvironment
    2023-07-04T10:50:26.489928  =

    2023-07-04T10:50:26.591441  / # . /lava-3711025/environment/lava-371102=
5/bin/lava-test-runner /lava-3711025/1
    2023-07-04T10:50:26.592089  =

    2023-07-04T10:50:26.596423  / # /lava-3711025/bin/lava-test-runner /lav=
a-3711025/1
    2023-07-04T10:50:26.665325  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/64a427366fd841a146bb2ab4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-18-g492521f41846/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-=
h2-plus-orangepi-r1.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-18-g492521f41846/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-=
h2-plus-orangepi-r1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a427366fd841a146bb2ab9
        failing since 82 days (last pass: v5.15.82-124-g2b8b2c150867, first=
 fail: v5.15.105-194-g415a9d81c640)

    2023-07-04T14:05:14.378428  / # #
    2023-07-04T14:05:14.484480  export SHELL=3D/bin/sh
    2023-07-04T14:05:14.486423  #
    2023-07-04T14:05:14.590248  / # export SHELL=3D/bin/sh. /lava-3711087/e=
nvironment
    2023-07-04T14:05:14.592293  =

    2023-07-04T14:05:14.695665  / # . /lava-3711087/environment/lava-371108=
7/bin/lava-test-runner /lava-3711087/1
    2023-07-04T14:05:14.698416  =

    2023-07-04T14:05:14.703668  / # /lava-3711087/bin/lava-test-runner /lav=
a-3711087/1
    2023-07-04T14:05:14.845214  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-04T14:05:14.846265  + cd /lava-3711087/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
