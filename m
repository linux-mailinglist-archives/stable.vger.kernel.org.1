Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B8371198D
	for <lists+stable@lfdr.de>; Thu, 25 May 2023 23:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241978AbjEYVvy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 25 May 2023 17:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242064AbjEYVvv (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 25 May 2023 17:51:51 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D87F1A6
        for <stable@vger.kernel.org>; Thu, 25 May 2023 14:51:33 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2553b0938a9so188168a91.0
        for <stable@vger.kernel.org>; Thu, 25 May 2023 14:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685051492; x=1687643492;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JkCDczVv+7ylF9+2azXG9qpoVxzx5Ob+lng9pt77kuQ=;
        b=Rit2wc6Mw309OAZVKiASNkBY37NB5/oZC+5NdtTm+YVO4BiOdtQs1VXvBZEjnojNLm
         bk4K2NzvktvXY21W6HYfmz8IKC6T7SX357HN2+YvPz62VgFDgfMtZKrte6ReWVF1+LZu
         AGYA/Qr0Jp4yBBKAy73z92ea9W/DhWP51o1odLB6FHPUxrR2+GePz8HlZ4ggtT/MAwCl
         47kRzVNpVSGwbzcy3XPs8Uk6qnyCaFcDaal/S9CWSl5G84TXGGl8zAYAk8/YvJZwku/y
         r0lCwwpdHU6QX+SOKcCZV0O7cwDDZq+poLBmzc5JVJZjQuU8ZRS+FcOltnJ9jiKTTMDQ
         Zpew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685051492; x=1687643492;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JkCDczVv+7ylF9+2azXG9qpoVxzx5Ob+lng9pt77kuQ=;
        b=b6n72kDuisoo6Rf9FVW2p7wohcagoV2gMZchxdKDQWYp0Afn8MFq40BTBfYS0uWv7e
         m12gmW2dgE/MPhJqUFcU+YtoDOeVFBw3YTdb9k2A6Mb/57b6NvG5HiWIfJY9wVcu+qiw
         5u02WjqC+9LBHjJuLC0/D6OyUeYZcbTLBl8ym9Wbl1lGgEYyrGNiUHaYD58GK4rt6u4r
         5yb9JmL2w5IrNmuP4JQXsXxTYK26j6hjzkqPm7pDaljJag1+HD7laOBFjyaEd2pd3DVE
         ulXlkaUUqMIA57p47HkmG2Qbhx4/zxPL78fO3US8IwCciYdqv4wCGNduPPZJ0ef1P4eU
         GQgA==
X-Gm-Message-State: AC+VfDwbsQv7jBGJLA0dGiiXkOkePJ3p6f8VtTewnTlELqDCTs0Lvavv
        PGE0S/NobEKRAFIKXB8LJOEPUy7ZimCLFObiiWO0SQ==
X-Google-Smtp-Source: ACHHUZ6dDomV2DYegXDf8qFwLYJskAvgTMwycbS3U/0DCfEkBHQUxXqP+WaM57wrEbZXh2ATMTBU2w==
X-Received: by 2002:a17:90b:50e:b0:256:1fd4:1431 with SMTP id r14-20020a17090b050e00b002561fd41431mr169795pjz.8.1685051492306;
        Thu, 25 May 2023 14:51:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m24-20020a17090b069800b002367325203fsm3379795pjz.50.2023.05.25.14.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 14:51:31 -0700 (PDT)
Message-ID: <646fd863.170a0220.46ce5.73d5@mx.google.com>
Date:   Thu, 25 May 2023 14:51:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.112-208-g607aa828ce14c
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 178 runs,
 9 regressions (v5.15.112-208-g607aa828ce14c)
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

stable-rc/queue/5.15 baseline: 178 runs, 9 regressions (v5.15.112-208-g607a=
a828ce14c)

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

kontron-pitx-imx8m           | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.112-208-g607aa828ce14c/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.112-208-g607aa828ce14c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      607aa828ce14c14eb41236401db32725f0b58d8a =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646fa22d4079a22e042e85ec

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-208-g607aa828ce14c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-208-g607aa828ce14c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646fa22d4079a22e042e85f1
        failing since 58 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-25T17:59:57.355741  + set +x<8>[   11.546426] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10455537_1.4.2.3.1>

    2023-05-25T17:59:57.356301  =


    2023-05-25T17:59:57.464189  / # #

    2023-05-25T17:59:57.566581  export SHELL=3D/bin/sh

    2023-05-25T17:59:57.567371  #

    2023-05-25T17:59:57.669039  / # export SHELL=3D/bin/sh. /lava-10455537/=
environment

    2023-05-25T17:59:57.669837  =


    2023-05-25T17:59:57.771639  / # . /lava-10455537/environment/lava-10455=
537/bin/lava-test-runner /lava-10455537/1

    2023-05-25T17:59:57.772915  =


    2023-05-25T17:59:57.777813  / # /lava-10455537/bin/lava-test-runner /la=
va-10455537/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646fa0ff92f59824d92e85e7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-208-g607aa828ce14c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-208-g607aa828ce14c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646fa0ff92f59824d92e85ec
        failing since 58 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-25T17:54:53.199868  <8>[   10.392261] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10455507_1.4.2.3.1>

    2023-05-25T17:54:53.203620  + set +x

    2023-05-25T17:54:53.304890  #

    2023-05-25T17:54:53.305178  =


    2023-05-25T17:54:53.405751  / # #export SHELL=3D/bin/sh

    2023-05-25T17:54:53.405957  =


    2023-05-25T17:54:53.506439  / # export SHELL=3D/bin/sh. /lava-10455507/=
environment

    2023-05-25T17:54:53.506681  =


    2023-05-25T17:54:53.607230  / # . /lava-10455507/environment/lava-10455=
507/bin/lava-test-runner /lava-10455507/1

    2023-05-25T17:54:53.607519  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/646fb5e8e184d391fd2e8614

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-208-g607aa828ce14c/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-208-g607aa828ce14c/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646fb5e8e184d391fd2e8=
615
        failing since 111 days (last pass: v5.15.91-12-g3290f78df1ab, first=
 fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646faefada86d407662e85f1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-208-g607aa828ce14c/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-208-g607aa828ce14c/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646faefada86d407662e85f5
        failing since 128 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-25T18:54:05.717027  + set +x<8>[   10.035670] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3616942_1.5.2.4.1>
    2023-05-25T18:54:05.717306  =

    2023-05-25T18:54:05.824050  / # #
    2023-05-25T18:54:05.926070  export SHELL=3D/bin/sh
    2023-05-25T18:54:05.926784  #<3>[   10.123300] Bluetooth: hci0: command=
 0x0c03 tx timeout
    2023-05-25T18:54:05.927176  =

    2023-05-25T18:54:06.028716  / # export SHELL=3D/bin/sh. /lava-3616942/e=
nvironment
    2023-05-25T18:54:06.029132  =

    2023-05-25T18:54:06.130319  / # . /lava-3616942/environment/lava-361694=
2/bin/lava-test-runner /lava-3616942/1
    2023-05-25T18:54:06.130894   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646fa397a85ce3c6f12e8603

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-208-g607aa828ce14c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-208-g607aa828ce14c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646fa397a85ce3c6f12e8608
        failing since 58 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-25T18:05:58.145393  + set +x

    2023-05-25T18:05:58.151943  <8>[   10.844790] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10455511_1.4.2.3.1>

    2023-05-25T18:05:58.256208  / # #

    2023-05-25T18:05:58.356887  export SHELL=3D/bin/sh

    2023-05-25T18:05:58.357102  #

    2023-05-25T18:05:58.457630  / # export SHELL=3D/bin/sh. /lava-10455511/=
environment

    2023-05-25T18:05:58.457842  =


    2023-05-25T18:05:58.558368  / # . /lava-10455511/environment/lava-10455=
511/bin/lava-test-runner /lava-10455511/1

    2023-05-25T18:05:58.558678  =


    2023-05-25T18:05:58.563417  / # /lava-10455511/bin/lava-test-runner /la=
va-10455511/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646fa28f458dd9b5122e85eb

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-208-g607aa828ce14c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-208-g607aa828ce14c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646fa28f458dd9b5122e85f0
        failing since 58 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-25T18:01:31.702245  + set +x<8>[   11.248793] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10455508_1.4.2.3.1>

    2023-05-25T18:01:31.702431  =


    2023-05-25T18:01:31.805156  =


    2023-05-25T18:01:31.905881  / # #export SHELL=3D/bin/sh

    2023-05-25T18:01:31.906176  =


    2023-05-25T18:01:32.006778  / # export SHELL=3D/bin/sh. /lava-10455508/=
environment

    2023-05-25T18:01:32.007046  =


    2023-05-25T18:01:32.107664  / # . /lava-10455508/environment/lava-10455=
508/bin/lava-test-runner /lava-10455508/1

    2023-05-25T18:01:32.107987  =


    2023-05-25T18:01:32.113353  / # /lava-10455508/bin/lava-test-runner /la=
va-10455508/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646fa12c6834c299a22e8602

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-208-g607aa828ce14c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-208-g607aa828ce14c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646fa12c6834c299a22e8607
        failing since 58 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-25T17:55:46.068952  + <8>[    9.673793] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10455554_1.4.2.3.1>

    2023-05-25T17:55:46.069213  set +x

    2023-05-25T17:55:46.175008  / # #

    2023-05-25T17:55:46.276674  export SHELL=3D/bin/sh

    2023-05-25T17:55:46.276903  #

    2023-05-25T17:55:46.377531  / # export SHELL=3D/bin/sh. /lava-10455554/=
environment

    2023-05-25T17:55:46.378170  =


    2023-05-25T17:55:46.479532  / # . /lava-10455554/environment/lava-10455=
554/bin/lava-test-runner /lava-10455554/1

    2023-05-25T17:55:46.480474  =


    2023-05-25T17:55:46.485296  / # /lava-10455554/bin/lava-test-runner /la=
va-10455554/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-pitx-imx8m           | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/646fa389bd6e7f05852e8655

  Results:     51 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-208-g607aa828ce14c/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pit=
x-imx8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-208-g607aa828ce14c/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pit=
x-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/646fa389bd6e7f0=
5852e868b
        new failure (last pass: v5.15.112-203-ge2ce7c03de0b)
        2 lines

    2023-05-25T18:05:48.119892  kern  :emerg : Internal error: synchronous =
external abort: 96000210 [#1] PREEMPT SMP
    2023-05-25T18:05:48.120139  kern  :em<8>[   12.042588] <LAVA_SIGNAL_TES=
TCASE TEST_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D2>
    2023-05-25T18:05:48.120363  erg : Code: a90153f3 aa0003f4 2a0<8>[   12.=
055538] <LAVA_SIGNAL_ENDRUN 0_dmesg 344196_1.5.2.4.1>
    2023-05-25T18:05:48.120564  103f3 f941ac00 (b9400000)    =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646fa116ab2d3208572e8603

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-208-g607aa828ce14c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-208-g607aa828ce14c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646fa116ab2d3208572e8608
        failing since 58 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-25T17:55:13.262127  + set<8>[   11.921614] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10455563_1.4.2.3.1>

    2023-05-25T17:55:13.262232   +x

    2023-05-25T17:55:13.366555  / # #

    2023-05-25T17:55:13.467269  export SHELL=3D/bin/sh

    2023-05-25T17:55:13.467531  #

    2023-05-25T17:55:13.568190  / # export SHELL=3D/bin/sh. /lava-10455563/=
environment

    2023-05-25T17:55:13.568439  =


    2023-05-25T17:55:13.669013  / # . /lava-10455563/environment/lava-10455=
563/bin/lava-test-runner /lava-10455563/1

    2023-05-25T17:55:13.670543  =


    2023-05-25T17:55:13.675158  / # /lava-10455563/bin/lava-test-runner /la=
va-10455563/1
 =

    ... (12 line(s) more)  =

 =20
