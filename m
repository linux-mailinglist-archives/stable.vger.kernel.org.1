Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E520C70187B
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 19:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjEMRbo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 13:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjEMRbm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 13:31:42 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670E92D7F
        for <stable@vger.kernel.org>; Sat, 13 May 2023 10:31:40 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-24e5d5782edso10407724a91.0
        for <stable@vger.kernel.org>; Sat, 13 May 2023 10:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683999099; x=1686591099;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7keErL5Hpp8pw30OPMMtujslbisayhkSQon+WRbYWuM=;
        b=0vMJvT0rfj63bXuWSDuC/ND4BnPxeH/P7oPSFF1dNeVKsxpoIoUdQ4CgOMDuekW9V1
         yj45vETvAFTayiMgQbVrOlR+gXKShxysYu6uvdiMOAsNY5Qvq7gneSoYDaT2o7cl9fqu
         g8XvujGYnlkSoPEAiLidv8grTSbtSrmFHQRi0QN2xTEX0YZbxkNQ5Ty+kXv9wKUGGG6K
         SUcA41RnY9eV+qOu1N0SxqG+h0HvGUBY2kPlBtzx+Z9iy8nvL1l3vdGcLVuLkW/lZSWP
         9X5lxOa3Llg5gjO1yqPRMVq53z7GdkMgJU81BzxSD/qsb5GViy0Aw14QrrTZZZJmHMxj
         Ef6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683999099; x=1686591099;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7keErL5Hpp8pw30OPMMtujslbisayhkSQon+WRbYWuM=;
        b=BJq41+B92zj+S13dra/Bl1tYnuV2N/iUyI29u5rsRw8WLromZ9Ahk4x5Jyf+x1kb2C
         Ol/NWuYRvjoXIhDPQMUj3HXwLK2WJTH13LeFxAl/c60XPHGxuaqCpCij9MhpXiIFu+rl
         wjjOr5dxoRqMy0izwZ7AIrubxaq7FfdMnPDn6ZYXiYF+MdeyyDuAdd3/UQdloQvmkXEq
         fNX+RCU0xSAOMx6YBMAMSNZkdzullJ8zsFeWgEAM+XiV6cNAxDQeL8FPOQ4WNV72KJOQ
         hmDrcCZRcp+UnCkAwhcAjH6fs3srrDhIrWsTCzfaWEJIzsPz6OZtcwuOiqj1XNjcIfPH
         bKRw==
X-Gm-Message-State: AC+VfDxQ3zVhUaiG2uh3wWcw7a4MPYrsMqmUzLxQ7Voky0WfW7gOu9Fk
        l7l4oX693dxkS6CwODW9csvHAa+zVb+G4CgoJXo=
X-Google-Smtp-Source: ACHHUZ40MDQng3F1/6lDEquWCS5L+bVj663tN8oMJ40M8HoN1I8p1wjypUbI/zsxoAt2LKUXI2Twig==
X-Received: by 2002:a17:90b:3a8c:b0:247:40f1:79d7 with SMTP id om12-20020a17090b3a8c00b0024740f179d7mr27986432pjb.34.1683999099113;
        Sat, 13 May 2023 10:31:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b13-20020a17090acc0d00b0023d386e4806sm5570762pju.57.2023.05.13.10.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 10:31:38 -0700 (PDT)
Message-ID: <645fc97a.170a0220.0d09.a011@mx.google.com>
Date:   Sat, 13 May 2023 10:31:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.111-100-g3aa39de064108
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 181 runs,
 9 regressions (v5.15.111-100-g3aa39de064108)
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

stable-rc/queue/5.15 baseline: 181 runs, 9 regressions (v5.15.111-100-g3aa3=
9de064108)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
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

sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.111-100-g3aa39de064108/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.111-100-g3aa39de064108
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      3aa39de0641081f28e925e69967e0818a6786ebe =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f970873f25888702e863b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g3aa39de064108/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g3aa39de064108/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f970873f25888702e8640
        failing since 46 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-13T13:56:03.531565  + set<8>[   10.874145] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10305413_1.4.2.3.1>

    2023-05-13T13:56:03.531679   +x

    2023-05-13T13:56:03.636401  / # #

    2023-05-13T13:56:03.737113  export SHELL=3D/bin/sh

    2023-05-13T13:56:03.737342  #

    2023-05-13T13:56:03.837934  / # export SHELL=3D/bin/sh. /lava-10305413/=
environment

    2023-05-13T13:56:03.838196  =


    2023-05-13T13:56:03.938755  / # . /lava-10305413/environment/lava-10305=
413/bin/lava-test-runner /lava-10305413/1

    2023-05-13T13:56:03.939108  =


    2023-05-13T13:56:03.943762  / # /lava-10305413/bin/lava-test-runner /la=
va-10305413/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f9716ec0856fec02e8614

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g3aa39de064108/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g3aa39de064108/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f9716ec0856fec02e8619
        failing since 46 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-13T13:56:30.515281  <8>[   11.066495] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10305429_1.4.2.3.1>

    2023-05-13T13:56:30.518660  + set +x

    2023-05-13T13:56:30.620140  #

    2023-05-13T13:56:30.620432  =


    2023-05-13T13:56:30.721099  / # #export SHELL=3D/bin/sh

    2023-05-13T13:56:30.721284  =


    2023-05-13T13:56:30.821775  / # export SHELL=3D/bin/sh. /lava-10305429/=
environment

    2023-05-13T13:56:30.822004  =


    2023-05-13T13:56:30.922583  / # . /lava-10305429/environment/lava-10305=
429/bin/lava-test-runner /lava-10305429/1

    2023-05-13T13:56:30.922981  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/645f962e10af9a006f2e85f3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g3aa39de064108/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g3aa39de064108/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645f962e10af9a006f2e8=
5f4
        failing since 99 days (last pass: v5.15.91-12-g3290f78df1ab, first =
fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645f97c11595d4d6f92e862e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g3aa39de064108/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g3aa39de064108/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f97c11595d4d6f92e8633
        failing since 116 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-13T13:59:16.349200  + set +x<8>[    9.990288] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3584431_1.5.2.4.1>
    2023-05-13T13:59:16.349425  =

    2023-05-13T13:59:16.455535  / # #
    2023-05-13T13:59:16.556987  export SHELL=3D/bin/sh
    2023-05-13T13:59:16.557361  #
    2023-05-13T13:59:16.658450  / # export SHELL=3D/bin/sh. /lava-3584431/e=
nvironment
    2023-05-13T13:59:16.658813  =

    2023-05-13T13:59:16.759757  / # . /lava-3584431/environment/lava-358443=
1/bin/lava-test-runner /lava-3584431/1
    2023-05-13T13:59:16.760630  =

    2023-05-13T13:59:16.765558  / # /lava-3584431/bin/lava-test-runner /lav=
a-3584431/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f96fe73f25888702e8600

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g3aa39de064108/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g3aa39de064108/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f96fe73f25888702e8605
        failing since 46 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-13T13:56:01.624850  + <8>[   10.227102] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10305412_1.4.2.3.1>

    2023-05-13T13:56:01.624933  set +x

    2023-05-13T13:56:01.726310  =


    2023-05-13T13:56:01.826874  / # #export SHELL=3D/bin/sh

    2023-05-13T13:56:01.827093  =


    2023-05-13T13:56:01.927646  / # export SHELL=3D/bin/sh. /lava-10305412/=
environment

    2023-05-13T13:56:01.927904  =


    2023-05-13T13:56:02.028409  / # . /lava-10305412/environment/lava-10305=
412/bin/lava-test-runner /lava-10305412/1

    2023-05-13T13:56:02.028711  =


    2023-05-13T13:56:02.033587  / # /lava-10305412/bin/lava-test-runner /la=
va-10305412/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f9717ec0856fec02e8636

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g3aa39de064108/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g3aa39de064108/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f9717ec0856fec02e863b
        failing since 46 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-13T13:56:14.709000  <8>[    8.036420] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10305454_1.4.2.3.1>

    2023-05-13T13:56:14.712681  + set +x

    2023-05-13T13:56:14.816888  / # #

    2023-05-13T13:56:14.917515  export SHELL=3D/bin/sh

    2023-05-13T13:56:14.917715  #

    2023-05-13T13:56:15.018215  / # export SHELL=3D/bin/sh. /lava-10305454/=
environment

    2023-05-13T13:56:15.018423  =


    2023-05-13T13:56:15.118989  / # . /lava-10305454/environment/lava-10305=
454/bin/lava-test-runner /lava-10305454/1

    2023-05-13T13:56:15.119312  =


    2023-05-13T13:56:15.124426  / # /lava-10305454/bin/lava-test-runner /la=
va-10305454/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f97166950515fd72e8617

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g3aa39de064108/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g3aa39de064108/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f97166950515fd72e861c
        failing since 46 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-13T13:56:25.248235  + set<8>[   10.824881] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10305418_1.4.2.3.1>

    2023-05-13T13:56:25.248319   +x

    2023-05-13T13:56:25.352730  / # #

    2023-05-13T13:56:25.453322  export SHELL=3D/bin/sh

    2023-05-13T13:56:25.453478  #

    2023-05-13T13:56:25.553967  / # export SHELL=3D/bin/sh. /lava-10305418/=
environment

    2023-05-13T13:56:25.554166  =


    2023-05-13T13:56:25.654738  / # . /lava-10305418/environment/lava-10305=
418/bin/lava-test-runner /lava-10305418/1

    2023-05-13T13:56:25.655009  =


    2023-05-13T13:56:25.659846  / # /lava-10305418/bin/lava-test-runner /la=
va-10305418/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f97116950515fd72e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g3aa39de064108/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g3aa39de064108/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f97116950515fd72e85eb
        failing since 46 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-13T13:56:14.453916  + set<8>[   11.831626] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10305459_1.4.2.3.1>

    2023-05-13T13:56:14.454000   +x

    2023-05-13T13:56:14.558086  / # #

    2023-05-13T13:56:14.658816  export SHELL=3D/bin/sh

    2023-05-13T13:56:14.659025  #

    2023-05-13T13:56:14.759606  / # export SHELL=3D/bin/sh. /lava-10305459/=
environment

    2023-05-13T13:56:14.759821  =


    2023-05-13T13:56:14.860424  / # . /lava-10305459/environment/lava-10305=
459/bin/lava-test-runner /lava-10305459/1

    2023-05-13T13:56:14.860790  =


    2023-05-13T13:56:14.865347  / # /lava-10305459/bin/lava-test-runner /la=
va-10305459/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/645f9be5ea9a40dd5c2e85fd

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g3aa39de064108/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64=
-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g3aa39de064108/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64=
-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f9be5ea9a40dd5c2e862a
        failing since 115 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-13T14:16:21.301441  + set +x
    2023-05-13T14:16:21.305522  <8>[   16.105459] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3584480_1.5.2.4.1>
    2023-05-13T14:16:21.425756  / # #
    2023-05-13T14:16:21.531277  export SHELL=3D/bin/sh
    2023-05-13T14:16:21.532787  #
    2023-05-13T14:16:21.636203  / # export SHELL=3D/bin/sh. /lava-3584480/e=
nvironment
    2023-05-13T14:16:21.637713  =

    2023-05-13T14:16:21.741091  / # . /lava-3584480/environment/lava-358448=
0/bin/lava-test-runner /lava-3584480/1
    2023-05-13T14:16:21.743855  =

    2023-05-13T14:16:21.747075  / # /lava-3584480/bin/lava-test-runner /lav=
a-3584480/1 =

    ... (12 line(s) more)  =

 =20
