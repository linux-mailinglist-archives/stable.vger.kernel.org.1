Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676BE705868
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 22:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjEPUN1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 16 May 2023 16:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjEPUN1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 16 May 2023 16:13:27 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5033A9D
        for <stable@vger.kernel.org>; Tue, 16 May 2023 13:13:18 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64384274895so10389433b3a.2
        for <stable@vger.kernel.org>; Tue, 16 May 2023 13:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684267997; x=1686859997;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5/5xgqwR540EAwZCJDIShUJmR55YS8KJ5r/8zsWjnp8=;
        b=IecVav1xvi8Syz9MLFUw86CPhjYjSusioaAiY31qT0k4c9430gNWoByPU/4uSHeOkP
         J5NSILJr95/V/ptJ206G/aPB/1lH7OUZ8V8J9PC8QrNMzpS+kdyDeqLkAo2iEcyGuXdK
         oqoloDRslNj8jzrSt5u7oMi92LjQefkLpKT5k2lqTDGhO/67rzNKJ+P51dnDZGhZKre2
         tUXazw8Wj8KwPNTZuyifrJrQ7iVayIsr2Q7VPSS69veIJey+DDAhkpLJorwIHDLKHOn5
         2Ji6rCzSYmO705nzbqNDXdIK/b3t1ceRRo5tGVaL81kvhS6Iaj1JwPYG3yhl6XZFDP1h
         nf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684267997; x=1686859997;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5/5xgqwR540EAwZCJDIShUJmR55YS8KJ5r/8zsWjnp8=;
        b=Q49YSpnIF0KSEKwGRDJUoYmqUmA1cTeVfXP72XvqQlqDjuWeDDauSUfjRQrb/BSlnA
         p9VgHVZEcippXmCJTacSb/eRtMFvD8xoFfWbn/CXoA1sg5cYHWKd2C9Sg97j0h0zZCSL
         wGPBdLNsx080rKgJ6S/v7B6qd2quh1RWVmN0B6jnr7Qw5FFNAoEuEDt/AsfljRdavtWr
         QBu/rGPgNBU4w13+wwdm2xV4ahXlE/mpuLHua5GkN4UqwR9Y04k4eiCOJCaVclZRxtz2
         P97o2cLSPO5BwdxC2Tis6llRCigbLSRSYbAkBCd6fO5PmwxQIvhDuEAssmvrAZfN099Y
         E57A==
X-Gm-Message-State: AC+VfDzGwKBLyiOKqR9Cy3uREJNSorQSYRCbSVPvRWsHsAThZ8EYejpP
        VCFaZ8DG4OvJDv/I+V7KyjBh1kf0JGoNvb14ywYA2w==
X-Google-Smtp-Source: ACHHUZ4NrfcYPFoH2Zo+4zbCfMkuXYTV26aShchyTS4KokeZ3YVFRCNGu3dmGGzEovp8DonIknIrXw==
X-Received: by 2002:a05:6a00:1a56:b0:646:2e83:6b2e with SMTP id h22-20020a056a001a5600b006462e836b2emr37677810pfv.31.1684267997286;
        Tue, 16 May 2023 13:13:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s22-20020a62e716000000b0063f3aac78b9sm13862389pfh.79.2023.05.16.13.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 13:13:16 -0700 (PDT)
Message-ID: <6463e3dc.620a0220.e7d6e.bf86@mx.google.com>
Date:   Tue, 16 May 2023 13:13:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.179-379-gb896ac5c5640
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 156 runs,
 6 regressions (v5.10.179-379-gb896ac5c5640)
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

stable-rc/queue/5.10 baseline: 156 runs, 6 regressions (v5.10.179-379-gb896=
ac5c5640)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.179-379-gb896ac5c5640/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.179-379-gb896ac5c5640
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b896ac5c56405ad46b12341eb75bfbfed5a9a15b =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6463ae12cf9b8e4cb12e8614

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-379-gb896ac5c5640/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-379-gb896ac5c5640/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6463ae12cf9b8e4cb12e8=
615
        new failure (last pass: v5.10.179-367-g5e75c5f5c701) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6463ad65ec87f1af182e85e9

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-379-gb896ac5c5640/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-379-gb896ac5c5640/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463ad66ec87f1af182e861c
        failing since 91 days (last pass: v5.10.167-127-g921934d621e4, firs=
t fail: v5.10.167-139-gf9519a5a1701)

    2023-05-16T16:20:35.536548  <8>[   19.743547] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 466886_1.5.2.4.1>
    2023-05-16T16:20:35.648619  / # #
    2023-05-16T16:20:35.751950  export SHELL=3D/bin/sh
    2023-05-16T16:20:35.752928  #
    2023-05-16T16:20:35.854999  / # export SHELL=3D/bin/sh. /lava-466886/en=
vironment
    2023-05-16T16:20:35.855940  =

    2023-05-16T16:20:35.958109  / # . /lava-466886/environment/lava-466886/=
bin/lava-test-runner /lava-466886/1
    2023-05-16T16:20:35.959595  =

    2023-05-16T16:20:35.964343  / # /lava-466886/bin/lava-test-runner /lava=
-466886/1
    2023-05-16T16:20:36.066046  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6463b273c8bffd9ad02e85f4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-379-gb896ac5c5640/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-379-gb896ac5c5640/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463b273c8bffd9ad02e85f9
        failing since 110 days (last pass: v5.10.165-76-g5c2e982fcf18, firs=
t fail: v5.10.165-77-g4600242c13ed)

    2023-05-16T16:42:17.853552  + set +x<8>[   11.125526] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3593862_1.5.2.4.1>
    2023-05-16T16:42:17.854316  =

    2023-05-16T16:42:17.965094  / # #
    2023-05-16T16:42:18.068788  export SHELL=3D/bin/sh
    2023-05-16T16:42:18.069823  #
    2023-05-16T16:42:18.171992  / # export SHELL=3D/bin/sh. /lava-3593862/e=
nvironment
    2023-05-16T16:42:18.173237  =

    2023-05-16T16:42:18.173927  / # <3>[   11.371588] Bluetooth: hci0: comm=
and 0x0c03 tx timeout
    2023-05-16T16:42:18.276191  . /lava-3593862/environment/lava-3593862/bi=
n/lava-test-runner /lava-3593862/1
    2023-05-16T16:42:18.278106   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6463aef8b6633f3a7c2e8606

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-379-gb896ac5c5640/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-379-gb896ac5c5640/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463aef8b6633f3a7c2e860b
        failing since 47 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-16T16:27:26.912377  + <8>[   15.996048] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10337497_1.4.2.3.1>

    2023-05-16T16:27:26.912495  set +x

    2023-05-16T16:27:27.014082  #

    2023-05-16T16:27:27.114964  / # #export SHELL=3D/bin/sh

    2023-05-16T16:27:27.115241  =


    2023-05-16T16:27:27.215808  / # export SHELL=3D/bin/sh. /lava-10337497/=
environment

    2023-05-16T16:27:27.216069  =


    2023-05-16T16:27:27.316699  / # . /lava-10337497/environment/lava-10337=
497/bin/lava-test-runner /lava-10337497/1

    2023-05-16T16:27:27.317046  =


    2023-05-16T16:27:27.322287  / # /lava-10337497/bin/lava-test-runner /la=
va-10337497/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6463ae8eac1fab0ec12e85f0

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-379-gb896ac5c5640/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-379-gb896ac5c5640/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463ae8eac1fab0ec12e85f5
        failing since 47 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-16T16:25:39.565498  + set +x

    2023-05-16T16:25:39.572004  <8>[   13.759099] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10337503_1.4.2.3.1>

    2023-05-16T16:25:39.676953  / # #

    2023-05-16T16:25:39.777663  export SHELL=3D/bin/sh

    2023-05-16T16:25:39.777934  #

    2023-05-16T16:25:39.878505  / # export SHELL=3D/bin/sh. /lava-10337503/=
environment

    2023-05-16T16:25:39.878765  =


    2023-05-16T16:25:39.979396  / # . /lava-10337503/environment/lava-10337=
503/bin/lava-test-runner /lava-10337503/1

    2023-05-16T16:25:39.979771  =


    2023-05-16T16:25:39.985150  / # /lava-10337503/bin/lava-test-runner /la=
va-10337503/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6463b1744d6881a38d2e85e6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-379-gb896ac5c5640/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-379-gb896ac5c5640/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463b1744d6881a38d2e85eb
        failing since 103 days (last pass: v5.10.165-139-gefb57ce0f880, fir=
st fail: v5.10.165-149-ge30e8271d674)

    2023-05-16T16:37:43.186514  / # #
    2023-05-16T16:37:43.288178  export SHELL=3D/bin/sh
    2023-05-16T16:37:43.288539  #
    2023-05-16T16:37:43.389847  / # export SHELL=3D/bin/sh. /lava-3593858/e=
nvironment
    2023-05-16T16:37:43.390195  =

    2023-05-16T16:37:43.491518  / # . /lava-3593858/environment/lava-359385=
8/bin/lava-test-runner /lava-3593858/1
    2023-05-16T16:37:43.492134  =

    2023-05-16T16:37:43.497789  / # /lava-3593858/bin/lava-test-runner /lav=
a-3593858/1
    2023-05-16T16:37:43.595751  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-16T16:37:43.596231  + cd /lava-3593858/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
