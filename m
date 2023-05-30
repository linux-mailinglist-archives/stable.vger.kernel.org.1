Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DE0716A7E
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 19:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjE3RLb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 13:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjE3RLa (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 13:11:30 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135C6E4E
        for <stable@vger.kernel.org>; Tue, 30 May 2023 10:10:47 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b01d3bb571so25897645ad.2
        for <stable@vger.kernel.org>; Tue, 30 May 2023 10:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685466646; x=1688058646;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mh9qAywpfD9/fnmrHlUZVgEgBDwkH3PSli5EBinT3Ug=;
        b=2MqPyh6sPIshpV+bnb62wvIdqJyKaUrt1aQfzIf85MJPzlMO1Zmk3D//haoGgbKYzr
         dv+L8Gds/AigSG5ubllVjwiPgOC7o2t+RjK4HXbDhqZb+D1QAWihYcdrT45LWbwfi0k1
         MKmS5lSOZR4n8TGFMJLgpaFM1lBygls1pnke00XcXdBQKtX0R2AdUf0NPy1d9P9Cq69c
         xP0Uvqpkph+s6lk156hMP1VREauY5FpwnomUtpPeW+vdZ+hDztbipZJnzuE5xBLdlUwT
         TpvBU7NG9rctlQgNsX5vCAqvRBwPb3ehoKs61DSGPMPk5Lo6m20DibeQEM0AQJ3UNrys
         HWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685466646; x=1688058646;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mh9qAywpfD9/fnmrHlUZVgEgBDwkH3PSli5EBinT3Ug=;
        b=RUDX+SK7ruCOLUobPFvZrKxf5LElJLii7eCYMOg+TkhmbzM+Jf57vDxa2jhl3u1zeX
         5Hs5WKtFDD9hF9eGirEzuL/XWhBb+yrzngBwvr32AGDjMCN+im0zibgk/YIDlIp6UIQp
         xBgOTzIRNqzqxkGZEPhJ+3K2ktZs+FzU1Q5k0IDelnPJmimmzPVF7VOdHTQ4+Xl7B2LG
         XeiJeZAztxslcPs+ZB0nqb6Wz1PxreEPKe5w6wfpRSXa43Dm7H0InLpr3joj/V9XhcjB
         /HzB6/Vmtl/+HW/qT4gV0x7tLEoVntvX8qA4j0uzWL0iWk+79I1cd3JySRqLBwhDM/nh
         Rj+g==
X-Gm-Message-State: AC+VfDxhUA63OpQE/BKRVlgqGs2F0oOQ8mDqKom+E5CQ7J+ZGzobxOfE
        d0kenenMGVZxVafjSVV32A4nxRYasX7pb/BiZ2ypLA==
X-Google-Smtp-Source: ACHHUZ7Xb/5vuL27gA4YpLLJ5YA2V39D+g05iymx74eBeVUwg8k69mM3GLXodXg1AffKhHdHR9sL0g==
X-Received: by 2002:a17:903:1cf:b0:1af:eea0:4f35 with SMTP id e15-20020a17090301cf00b001afeea04f35mr2968314plh.2.1685466645367;
        Tue, 30 May 2023 10:10:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p23-20020a170902a41700b001afd6647a77sm10504068plq.155.2023.05.30.10.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 10:10:44 -0700 (PDT)
Message-ID: <64762e14.170a0220.fd5e7.37e5@mx.google.com>
Date:   Tue, 30 May 2023 10:10:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable
X-Kernelci-Kernel: v4.19.284
X-Kernelci-Report-Type: test
Subject: stable/linux-4.19.y baseline: 105 runs, 26 regressions (v4.19.284)
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

stable/linux-4.19.y baseline: 105 runs, 26 regressions (v4.19.284)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =

cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

dove-cubox                   | arm    | lab-pengutronix | gcc-10   | mvebu_=
v7_defconfig           | 1          =

imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 3          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

sun8i-a33-olinuxino          | arm    | lab-clabbe      | gcc-10   | multi_=
v7_defconfig           | 1          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-4.19.y/kernel=
/v4.19.284/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-4.19.y
  Describe: v4.19.284
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      a8b7a32a3427d592a38cb0ed9c33088d44c82840 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6475fb2d87f5a3dc2b2e85fe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6475fb2d87f5a3dc2b2e8603
        failing since 131 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-05-30T13:30:35.187497  + set +x

    2023-05-30T13:30:35.193084  <8>[   10.299669] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10524708_1.4.2.3.1>

    2023-05-30T13:30:35.301256  #

    2023-05-30T13:30:35.302465  =


    2023-05-30T13:30:35.404887  / # #export SHELL=3D/bin/sh

    2023-05-30T13:30:35.405713  =


    2023-05-30T13:30:35.507449  / # export SHELL=3D/bin/sh. /lava-10524708/=
environment

    2023-05-30T13:30:35.508122  =


    2023-05-30T13:30:35.609456  / # . /lava-10524708/environment/lava-10524=
708/bin/lava-test-runner /lava-10524708/1

    2023-05-30T13:30:35.610490  =

 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6475fb2c356f6bbdee2e85eb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6475fb2c356f6bbdee2e85f0
        failing since 131 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-05-30T13:30:45.184555  + set<8>[   12.388932] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10524714_1.4.2.3.1>

    2023-05-30T13:30:45.184649   +x

    2023-05-30T13:30:45.286503  =


    2023-05-30T13:30:45.387147  / # #export SHELL=3D/bin/sh

    2023-05-30T13:30:45.387345  =


    2023-05-30T13:30:45.487860  / # export SHELL=3D/bin/sh. /lava-10524714/=
environment

    2023-05-30T13:30:45.488062  =


    2023-05-30T13:30:45.588586  / # . /lava-10524714/environment/lava-10524=
714/bin/lava-test-runner /lava-10524714/1

    2023-05-30T13:30:45.588890  =


    2023-05-30T13:30:45.593699  / # /lava-10524714/bin/lava-test-runner /la=
va-10524714/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6475ff38417366c32b2e8622

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6475ff38417366c32b2e864d
        failing since 132 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-05-30T13:49:59.002953  <8>[   11.903032] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 535627_1.5.2.4.1>
    2023-05-30T13:49:59.110614  / # #
    2023-05-30T13:49:59.212608  export SHELL=3D/bin/sh
    2023-05-30T13:49:59.213237  #
    2023-05-30T13:49:59.314861  / # export SHELL=3D/bin/sh. /lava-535627/en=
vironment
    2023-05-30T13:49:59.315362  =

    2023-05-30T13:49:59.417393  / # . /lava-535627/environment/lava-535627/=
bin/lava-test-runner /lava-535627/1
    2023-05-30T13:49:59.418444  =

    2023-05-30T13:49:59.422325  / # /lava-535627/bin/lava-test-runner /lava=
-535627/1
    2023-05-30T13:49:59.490439  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6475fe773ea9e675fd2e8600

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6475fe773ea9e675fd2e8603
        failing since 132 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-05-30T13:46:40.056579  / # #
    2023-05-30T13:46:40.157981  export SHELL=3D/bin/sh
    2023-05-30T13:46:40.158335  #
    2023-05-30T13:46:40.259470  / # export SHELL=3D/bin/sh. /lava-947180/en=
vironment
    2023-05-30T13:46:40.259799  =

    2023-05-30T13:46:40.360798  / # . /lava-947180/environment/lava-947180/=
bin/lava-test-runner /lava-947180/1
    2023-05-30T13:46:40.361465  =

    2023-05-30T13:46:40.368549  / # /lava-947180/bin/lava-test-runner /lava=
-947180/1
    2023-05-30T13:46:40.432618  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-30T13:46:40.470545  + cd /lava-947180/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6475fcefd7495b7a562e8615

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6475fcefd7495b7a562e861a
        failing since 131 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-05-30T13:40:47.387923  <8>[    7.364564] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3631310_1.5.2.4.1>
    2023-05-30T13:40:47.498514  / # #
    2023-05-30T13:40:47.602455  export SHELL=3D/bin/sh
    2023-05-30T13:40:47.603724  #
    2023-05-30T13:40:47.706404  / # export SHELL=3D/bin/sh. /lava-3631310/e=
nvironment
    2023-05-30T13:40:47.707509  =

    2023-05-30T13:40:47.810205  / # . /lava-3631310/environment/lava-363131=
0/bin/lava-test-runner /lava-3631310/1
    2023-05-30T13:40:47.811897  =

    2023-05-30T13:40:47.816961  / # /lava-3631310/bin/lava-test-runner /lav=
a-3631310/1
    2023-05-30T13:40:47.902784  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
dove-cubox                   | arm    | lab-pengutronix | gcc-10   | mvebu_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6475fa73ed5316357a2e85ee

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: mvebu_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm/mvebu_v7_defconfig/gcc-10/lab-pengutronix/baseline-dove-cubox.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm/mvebu_v7_defconfig/gcc-10/lab-pengutronix/baseline-dove-cubox.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6475fa73ed5316357a2e85f3
        failing since 131 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-05-30T13:30:09.904123  + set +x
    2023-05-30T13:30:09.904299  [    4.233055] <LAVA_SIGNAL_ENDRUN 0_dmesg =
962676_1.5.2.3.1>
    2023-05-30T13:30:10.011156  / # #
    2023-05-30T13:30:10.113270  export SHELL=3D/bin/sh
    2023-05-30T13:30:10.113755  #
    2023-05-30T13:30:10.215032  / # export SHELL=3D/bin/sh. /lava-962676/en=
vironment
    2023-05-30T13:30:10.215575  =

    2023-05-30T13:30:10.316820  / # . /lava-962676/environment/lava-962676/=
bin/lava-test-runner /lava-962676/1
    2023-05-30T13:30:10.317391  =

    2023-05-30T13:30:10.320245  / # /lava-962676/bin/lava-test-runner /lava=
-962676/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6475fcd8d7495b7a562e85e6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6475fcd8d7495b7a562e85eb
        failing since 132 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-05-30T13:40:30.747847  / # #

    2023-05-30T13:40:30.850257  export SHELL=3D/bin/sh

    2023-05-30T13:40:30.851041  #

    2023-05-30T13:40:30.952914  / # export SHELL=3D/bin/sh. /lava-10524826/=
environment

    2023-05-30T13:40:30.953616  =


    2023-05-30T13:40:31.055572  / # . /lava-10524826/environment/lava-10524=
826/bin/lava-test-runner /lava-10524826/1

    2023-05-30T13:40:31.056757  =


    2023-05-30T13:40:31.071937  / # /lava-10524826/bin/lava-test-runner /la=
va-10524826/1

    2023-05-30T13:40:31.169199  + export 'TESTRUN_ID=3D1_bootrr'

    2023-05-30T13:40:31.169729  + cd /lava-10524826/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6475fc03e14902e2982e8604

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboard-re=
vd1.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboard-re=
vd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6475fc03e14902e2982e8609
        failing since 132 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-05-30T13:36:56.358643  + set +x[    7.223292] <LAVA_SIGNAL_ENDRUN =
0_dmesg 962680_1.5.2.3.1>
    2023-05-30T13:36:56.358806  =

    2023-05-30T13:36:56.466714  / # #
    2023-05-30T13:36:56.568514  export SHELL=3D/bin/sh
    2023-05-30T13:36:56.569015  #
    2023-05-30T13:36:56.670222  / # export SHELL=3D/bin/sh. /lava-962680/en=
vironment
    2023-05-30T13:36:56.670718  =

    2023-05-30T13:36:56.772041  / # . /lava-962680/environment/lava-962680/=
bin/lava-test-runner /lava-962680/1
    2023-05-30T13:36:56.772783  =

    2023-05-30T13:36:56.775598  / # /lava-962680/bin/lava-test-runner /lava=
-962680/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6475fccc97c6d8775b2e85f4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboard-rev=
d1.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboard-rev=
d1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6475fccc97c6d8775b2e85f9
        failing since 132 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-05-30T13:40:15.770650  + set +x
    2023-05-30T13:40:15.770806  [    4.895174] <LAVA_SIGNAL_ENDRUN 0_dmesg =
962685_1.5.2.3.1>
    2023-05-30T13:40:15.876605  / # #
    2023-05-30T13:40:15.978238  export SHELL=3D/bin/sh
    2023-05-30T13:40:15.978671  #
    2023-05-30T13:40:16.080101  / # export SHELL=3D/bin/sh. /lava-962685/en=
vironment
    2023-05-30T13:40:16.081610  =

    2023-05-30T13:40:16.183806  / # . /lava-962685/environment/lava-962685/=
bin/lava-test-runner /lava-962685/1
    2023-05-30T13:40:16.184404  =

    2023-05-30T13:40:16.187225  / # /lava-962685/bin/lava-test-runner /lava=
-962685/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6475fbce66851681ad2e85f8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6475fbce66851681ad2e8=
5f9
        failing since 383 days (last pass: v4.19.239, first fail: v4.19.242=
) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6475fc64dc484a92da2e8635

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6475fc64dc484a92da2e8=
636
        failing since 383 days (last pass: v4.19.239, first fail: v4.19.242=
) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6475fbcb66851681ad2e85ef

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6475fbcb66851681ad2e8=
5f0
        failing since 267 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6475fb95004fdb0f502e8600

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6475fb95004fdb0f502e8=
601
        failing since 267 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6475fbcd66851681ad2e85f5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6475fbcd66851681ad2e8=
5f6
        failing since 267 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6475fbbe492c51c5e32e8646

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6475fbbe492c51c5e32e8=
647
        failing since 267 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6475fbcc66851681ad2e85f2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6475fbcc66851681ad2e8=
5f3
        failing since 267 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6475fbbd492c51c5e32e8643

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6475fbbd492c51c5e32e8=
644
        failing since 267 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6475fc61dc484a92da2e862f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6475fc61dc484a92da2e8=
630
        failing since 13 days (last pass: v4.19.282, first fail: v4.19.283) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 3          =


  Details:     https://kernelci.org/test/plan/id/6475fcde97c6d8775b2e8635

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/6475fcde97c6d8775b2e8665
        failing since 130 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-05-30T13:40:25.858515  BusyBox v1.31.1 (2023-05-27 14:14:16 UTC)<8=
>[   13.216951] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-05-30T13:40:25.860432   multi-call binary.

    2023-05-30T13:40:25.860653  =


    2023-05-30T13:40:25.864918  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-05-30T13:40:25.865138  =


    2023-05-30T13:40:25.870279  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/6475fcde97c6d8775b2e8666
        failing since 130 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-05-30T13:40:25.839842  <8>[   13.199568] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6475fcde97c6d8775b2e8679
        failing since 130 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-05-30T13:40:22.012308  <8>[    9.372222] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-05-30T13:40:22.021581  + <8>[    9.384232] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10524823_1.5.2.3.1>

    2023-05-30T13:40:22.022106  set +x

    2023-05-30T13:40:22.127975  =


    2023-05-30T13:40:22.229568  / # #export SHELL=3D/bin/sh

    2023-05-30T13:40:22.230277  =


    2023-05-30T13:40:22.331664  / # export SHELL=3D/bin/sh. /lava-10524823/=
environment

    2023-05-30T13:40:22.332370  =


    2023-05-30T13:40:22.433718  / # . /lava-10524823/environment/lava-10524=
823/bin/lava-test-runner /lava-10524823/1

    2023-05-30T13:40:22.434724  =

 =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64761a07f454f416f22e8607

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64761a07f454f416f22e862d
        failing since 132 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-05-30T15:44:29.799634  <8>[   15.997439] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 535531_1.5.2.4.1>
    2023-05-30T15:44:29.906681  / # #
    2023-05-30T15:44:30.009417  export SHELL=3D/bin/sh
    2023-05-30T15:44:30.009969  #
    2023-05-30T15:44:30.111384  / # export SHELL=3D/bin/sh. /lava-535531/en=
vironment
    2023-05-30T15:44:30.112117  =

    2023-05-30T15:44:30.214325  / # . /lava-535531/environment/lava-535531/=
bin/lava-test-runner /lava-535531/1
    2023-05-30T15:44:30.215466  =

    2023-05-30T15:44:30.219802  / # /lava-535531/bin/lava-test-runner /lava=
-535531/1
    2023-05-30T15:44:30.251505  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6475fb2c356f6bbdee2e85f6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6475fb2c356f6bbdee2e85fb
        failing since 132 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-05-30T13:31:04.533874  / # #

    2023-05-30T13:31:04.635739  export SHELL=3D/bin/sh

    2023-05-30T13:31:04.636602  #

    2023-05-30T13:31:04.738258  / # export SHELL=3D/bin/sh. /lava-10524776/=
environment

    2023-05-30T13:31:04.738979  =


    2023-05-30T13:31:04.840424  / # . /lava-10524776/environment/lava-10524=
776/bin/lava-test-runner /lava-10524776/1

    2023-05-30T13:31:04.841522  =


    2023-05-30T13:31:04.858288  / # /lava-10524776/bin/lava-test-runner /la=
va-10524776/1

    2023-05-30T13:31:04.902142  + export 'TESTRUN_ID=3D1_bootrr'

    2023-05-30T13:31:04.917073  + cd /lava-1052477<8>[   15.615275] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 10524776_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-a33-olinuxino          | arm    | lab-clabbe      | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6475fcf542f96aea542e85e6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm/multi_v7_defconfig/gcc-10/lab-clabbe/baseline-sun8i-a33-olinuxino.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm/multi_v7_defconfig/gcc-10/lab-clabbe/baseline-sun8i-a33-olinuxino.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6475fcf542f96aea542e85eb
        failing since 132 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-05-30T13:40:46.591812  + set +x
    2023-05-30T13:40:46.593045  <8>[   17.371591] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 435115_1.5.2.4.1>
    2023-05-30T13:40:46.700951  / # #
    2023-05-30T13:40:46.803067  export SHELL=3D/bin/sh
    2023-05-30T13:40:46.803605  #
    2023-05-30T13:40:46.905132  / # export SHELL=3D/bin/sh. /lava-435115/en=
vironment
    2023-05-30T13:40:46.905653  =

    2023-05-30T13:40:47.007223  / # . /lava-435115/environment/lava-435115/=
bin/lava-test-runner /lava-435115/1
    2023-05-30T13:40:47.008136  =

    2023-05-30T13:40:47.011325  / # /lava-435115/bin/lava-test-runner /lava=
-435115/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6475fce4d7495b7a562e8606

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-libretech-all-=
h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-libretech-all-=
h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6475fce4d7495b7a562e860b
        failing since 132 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-05-30T13:40:35.174111  / # #
    2023-05-30T13:40:35.275966  export SHELL=3D/bin/sh
    2023-05-30T13:40:35.276437  #
    2023-05-30T13:40:35.377834  / # export SHELL=3D/bin/sh. /lava-3631319/e=
nvironment
    2023-05-30T13:40:35.378346  =

    2023-05-30T13:40:35.479748  / # . /lava-3631319/environment/lava-363131=
9/bin/lava-test-runner /lava-3631319/1
    2023-05-30T13:40:35.480550  =

    2023-05-30T13:40:35.484833  / # /lava-3631319/bin/lava-test-runner /lav=
a-3631319/1
    2023-05-30T13:40:35.604714  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-30T13:40:35.605072  + cd /lava-3631319/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6475fb2b87f5a3dc2b2e85ee

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm64/defconfig/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.284/=
arm64/defconfig/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6475fb2b87f5a3dc2b2e85f1
        failing since 132 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-05-30T13:31:03.816700  + set +x
    2023-05-30T13:31:03.817706  <8>[    3.738797] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 947171_1.5.2.4.1>
    2023-05-30T13:31:03.923562  / # #
    2023-05-30T13:31:04.024736  export SHELL=3D/bin/sh
    2023-05-30T13:31:04.024969  #
    2023-05-30T13:31:04.125982  / # export SHELL=3D/bin/sh. /lava-947171/en=
vironment
    2023-05-30T13:31:04.126348  =

    2023-05-30T13:31:04.227342  / # . /lava-947171/environment/lava-947171/=
bin/lava-test-runner /lava-947171/1
    2023-05-30T13:31:04.227757  =

    2023-05-30T13:31:04.230622  / # /lava-947171/bin/lava-test-runner /lava=
-947171/1 =

    ... (13 line(s) more)  =

 =20
