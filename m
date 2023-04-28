Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047136F1E77
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 21:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346569AbjD1TAs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 15:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346618AbjD1TAi (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 15:00:38 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1453461A2
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 12:00:07 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64115e652eeso14746650b3a.0
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 12:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682708406; x=1685300406;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4wEUsqGWfenfbSO9v2rEuFf+ZNOCWJyIiH9LjPV/e1o=;
        b=tHoM08IPkdRV2ntbASQvGV5BJ/KmmnfNqgG25r7oaqmQmyYYycszA/eUlbunzgAAFq
         LxBE9wFrBLTeVEGDhqwZL70/pEYTMT2G9cjv/ty7Wxhq0BuSOD/lDl2aeRBeB+yefkiv
         OpfgN+T6T8q6sTlEQxzijsDSc+YMnXs5cBoVlfUM8SlHu84tt8DX/43Vwd+aTnyfJ47z
         LNfqyRJuZ5YUBhWRhaYt/6xyLoH+qcOc4wlrJE4itYiBwuRaYLiudVLjSIRhHNfyI5mX
         ibPd1MZfdU3uZWztek4HMPdvQip/s70QHSF7Vwzn+UmfuHAY5rcwEERbvynCrYEn/RWD
         gjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682708406; x=1685300406;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4wEUsqGWfenfbSO9v2rEuFf+ZNOCWJyIiH9LjPV/e1o=;
        b=jSzYvaS9LrHf3AmTVOKVb1XPvb00txn14dT/9PcQY/Xpi7iTW1suRy5XVqYfJ5dSfb
         8NvJWb/24DeIyY4wTTwjMYV+i7VIMCAUTvGsB74YV60D3/elEgncsWWSpU9ThwdzIx8v
         iqSOlFj78uSN7/ngxnCrKx5lpdEc0SVH+frqSu0HabCfPmd38V9F8JJFKFAWo6XBmHZY
         1tzmC7PG+DB05f9Vwzjd16wsy4viQzz4+aF0XFlKi7qEiz1QRK7hCnIlp5qDWzqBkX95
         ycXxBfHQWzWzwb7CFx0qRI3vNjv594R7ftdmGMKCE/CDp5zncFhPw8ElWRkonJj6Lsgp
         EeCg==
X-Gm-Message-State: AC+VfDxHYM31dxdlB2eig+eVFkLPVtavxoG0zOVkhVO6+YECrVT//WL8
        LIE4c6UbA50jQvSNKO1IyZT8M2RSQI0rBRvqjjg=
X-Google-Smtp-Source: ACHHUZ7DXKf45byMWZmgc8doArANgxTTHqzsaDM3DyhfypuA+vL9oBaU780ivsr8r1xAmm61H12KlA==
X-Received: by 2002:a17:902:f64b:b0:1a9:7cb3:70d1 with SMTP id m11-20020a170902f64b00b001a97cb370d1mr6419379plg.34.1682708405645;
        Fri, 28 Apr 2023 12:00:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a18-20020a170902ecd200b001a9a8983a15sm3996730plh.231.2023.04.28.12.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 12:00:05 -0700 (PDT)
Message-ID: <644c17b5.170a0220.27e55.a0e2@mx.google.com>
Date:   Fri, 28 Apr 2023 12:00:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.22-591-g58b654bf36db
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-6.1.y baseline: 112 runs,
 10 regressions (v6.1.22-591-g58b654bf36db)
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

stable-rc/linux-6.1.y baseline: 112 runs, 10 regressions (v6.1.22-591-g58b6=
54bf36db)

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

bcm2835-rpi-b-rev2           | arm    | lab-broonie   | gcc-10   | bcm2835_=
defconfig            | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

odroid-xu3                   | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.22-591-g58b654bf36db/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.22-591-g58b654bf36db
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      58b654bf36db7c89178300adbb034ce63301b685 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bde5c654de3556e2e86d3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
591-g58b654bf36db/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
591-g58b654bf36db/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bde5c654de3556e2e86d8
        failing since 29 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-04-28T14:55:15.524159  + set +x

    2023-04-28T14:55:15.530928  <8>[   10.882611] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10152307_1.4.2.3.1>

    2023-04-28T14:55:15.639239  / # #

    2023-04-28T14:55:15.741806  export SHELL=3D/bin/sh

    2023-04-28T14:55:15.742631  #

    2023-04-28T14:55:15.844198  / # export SHELL=3D/bin/sh. /lava-10152307/=
environment

    2023-04-28T14:55:15.845021  =


    2023-04-28T14:55:15.946810  / # . /lava-10152307/environment/lava-10152=
307/bin/lava-test-runner /lava-10152307/1

    2023-04-28T14:55:15.948119  =


    2023-04-28T14:55:15.953940  / # /lava-10152307/bin/lava-test-runner /la=
va-10152307/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bde5e7153ca809d2e85f5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
591-g58b654bf36db/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
591-g58b654bf36db/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bde5e7153ca809d2e85fa
        failing since 29 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-04-28T14:55:10.119848  + set<8>[   11.451922] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10152376_1.4.2.3.1>

    2023-04-28T14:55:10.120425   +x

    2023-04-28T14:55:10.227955  / # #

    2023-04-28T14:55:10.330099  export SHELL=3D/bin/sh

    2023-04-28T14:55:10.330889  #

    2023-04-28T14:55:10.432334  / # export SHELL=3D/bin/sh. /lava-10152376/=
environment

    2023-04-28T14:55:10.432612  =


    2023-04-28T14:55:10.533560  / # . /lava-10152376/environment/lava-10152=
376/bin/lava-test-runner /lava-10152376/1

    2023-04-28T14:55:10.534831  =


    2023-04-28T14:55:10.539864  / # /lava-10152376/bin/lava-test-runner /la=
va-10152376/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bde5c7153ca809d2e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
591-g58b654bf36db/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
591-g58b654bf36db/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bde5c7153ca809d2e85eb
        failing since 29 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-04-28T14:55:07.275327  <8>[    7.816749] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10152374_1.4.2.3.1>

    2023-04-28T14:55:07.278622  + set +x

    2023-04-28T14:55:07.380900  #

    2023-04-28T14:55:07.382355  =


    2023-04-28T14:55:07.484323  / # #export SHELL=3D/bin/sh

    2023-04-28T14:55:07.485157  =


    2023-04-28T14:55:07.586873  / # export SHELL=3D/bin/sh. /lava-10152374/=
environment

    2023-04-28T14:55:07.587719  =


    2023-04-28T14:55:07.689647  / # . /lava-10152374/environment/lava-10152=
374/bin/lava-test-runner /lava-10152374/1

    2023-04-28T14:55:07.691012  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2835-rpi-b-rev2           | arm    | lab-broonie   | gcc-10   | bcm2835_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/644bde970b66fd40222e860a

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
591-g58b654bf36db/arm/bcm2835_defconfig/gcc-10/lab-broonie/baseline-bcm2835=
-rpi-b-rev2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
591-g58b654bf36db/arm/bcm2835_defconfig/gcc-10/lab-broonie/baseline-bcm2835=
-rpi-b-rev2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bde970b66fd40222e8639
        failing since 9 days (last pass: v6.1.22-178-gf8a7fa4a96bb, first f=
ail: v6.1.22-480-g90c08f549ee7)

    2023-04-28T14:55:57.725960  + set +x
    2023-04-28T14:55:57.729734  <8>[   18.307325] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 398527_1.5.2.4.1>
    2023-04-28T14:55:57.846660  / # #
    2023-04-28T14:55:57.949885  export SHELL=3D/bin/sh
    2023-04-28T14:55:57.950813  #
    2023-04-28T14:55:58.052978  / # export SHELL=3D/bin/sh. /lava-398527/en=
vironment
    2023-04-28T14:55:58.053917  =

    2023-04-28T14:55:58.156280  / # . /lava-398527/environment/lava-398527/=
bin/lava-test-runner /lava-398527/1
    2023-04-28T14:55:58.157874  =

    2023-04-28T14:55:58.164014  / # /lava-398527/bin/lava-test-runner /lava=
-398527/1 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bde4b654de3556e2e85e7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
591-g58b654bf36db/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
591-g58b654bf36db/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bde4b654de3556e2e85ec
        failing since 29 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-04-28T14:54:54.157474  + set +x

    2023-04-28T14:54:54.164300  <8>[   10.487977] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10152370_1.4.2.3.1>

    2023-04-28T14:54:54.268935  / # #

    2023-04-28T14:54:54.369561  export SHELL=3D/bin/sh

    2023-04-28T14:54:54.369778  #

    2023-04-28T14:54:54.470290  / # export SHELL=3D/bin/sh. /lava-10152370/=
environment

    2023-04-28T14:54:54.470494  =


    2023-04-28T14:54:54.571053  / # . /lava-10152370/environment/lava-10152=
370/bin/lava-test-runner /lava-10152370/1

    2023-04-28T14:54:54.571345  =


    2023-04-28T14:54:54.575490  / # /lava-10152370/bin/lava-test-runner /la=
va-10152370/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bde49ef26c2cf622e8607

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
591-g58b654bf36db/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
591-g58b654bf36db/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bde49ef26c2cf622e860c
        failing since 29 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-04-28T14:54:47.671392  <8>[    7.925983] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10152349_1.4.2.3.1>

    2023-04-28T14:54:47.675016  + set +x

    2023-04-28T14:54:47.783274  / # #

    2023-04-28T14:54:47.885704  export SHELL=3D/bin/sh

    2023-04-28T14:54:47.886491  #

    2023-04-28T14:54:47.987986  / # export SHELL=3D/bin/sh. /lava-10152349/=
environment

    2023-04-28T14:54:47.988741  =


    2023-04-28T14:54:48.090168  / # . /lava-10152349/environment/lava-10152=
349/bin/lava-test-runner /lava-10152349/1

    2023-04-28T14:54:48.091230  =


    2023-04-28T14:54:48.096495  / # /lava-10152349/bin/lava-test-runner /la=
va-10152349/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bde5c4254bc76532e85f1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
591-g58b654bf36db/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
591-g58b654bf36db/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bde5c4254bc76532e85f6
        failing since 29 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-04-28T14:55:16.680856  + set<8>[   10.938944] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10152383_1.4.2.3.1>

    2023-04-28T14:55:16.680969   +x

    2023-04-28T14:55:16.785751  / # #

    2023-04-28T14:55:16.886407  export SHELL=3D/bin/sh

    2023-04-28T14:55:16.886600  #

    2023-04-28T14:55:16.987150  / # export SHELL=3D/bin/sh. /lava-10152383/=
environment

    2023-04-28T14:55:16.987345  =


    2023-04-28T14:55:17.087860  / # . /lava-10152383/environment/lava-10152=
383/bin/lava-test-runner /lava-10152383/1

    2023-04-28T14:55:17.088187  =


    2023-04-28T14:55:17.092850  / # /lava-10152383/bin/lava-test-runner /la=
va-10152383/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bde6ed84f1afedb2e8606

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
591-g58b654bf36db/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
591-g58b654bf36db/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bde6ed84f1afedb2e860b
        failing since 29 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-04-28T14:55:17.660834  + set<8>[   10.865750] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10152317_1.4.2.3.1>

    2023-04-28T14:55:17.660922   +x

    2023-04-28T14:55:17.765612  / # #

    2023-04-28T14:55:17.866220  export SHELL=3D/bin/sh

    2023-04-28T14:55:17.866425  #

    2023-04-28T14:55:17.966949  / # export SHELL=3D/bin/sh. /lava-10152317/=
environment

    2023-04-28T14:55:17.967156  =


    2023-04-28T14:55:18.067717  / # . /lava-10152317/environment/lava-10152=
317/bin/lava-test-runner /lava-10152317/1

    2023-04-28T14:55:18.068041  =


    2023-04-28T14:55:18.073127  / # /lava-10152317/bin/lava-test-runner /la=
va-10152317/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
odroid-xu3                   | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644be4b97bd08efaf92e8611

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
591-g58b654bf36db/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-odro=
id-xu3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
591-g58b654bf36db/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-odro=
id-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644be4b97bd08efaf92e8=
612
        new failure (last pass: v6.1.22-588-gf4ffa542abc9) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/644bdf4aeccd441fcf2e85f6

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
591-g58b654bf36db/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_m=
ips-malta.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
591-g58b654bf36db/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_m=
ips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/mipsel/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/644bdf4aeccd441=
fcf2e85fe
        failing since 0 day (last pass: v6.1.22-574-ge4ff6ff54dea, first fa=
il: v6.1.22-588-gf4ffa542abc9)
        1 lines

    2023-04-28T14:59:00.565545  kern  :alert : CPU 0 Unable to handle kerne=
l paging request at virtual address 326781d8, epc =3D=3D 80202234, ra =3D=
=3D 80204b84
    2023-04-28T14:59:00.565725  =


    2023-04-28T14:59:00.600724  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dale=
rt RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D1>
    2023-04-28T14:59:00.600946  =

   =

 =20
