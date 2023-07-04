Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008947474F3
	for <lists+stable@lfdr.de>; Tue,  4 Jul 2023 17:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjGDPIN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 4 Jul 2023 11:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjGDPIM (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 4 Jul 2023 11:08:12 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C24DE6
        for <stable@vger.kernel.org>; Tue,  4 Jul 2023 08:08:10 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-262fa79e97fso2620518a91.2
        for <stable@vger.kernel.org>; Tue, 04 Jul 2023 08:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688483289; x=1691075289;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qtM7YlX40DnaBX+93lVDcGrZHwW1VSG0evpOPg36VAY=;
        b=RlcpwhPhgxRsKLroQlcTv78k6e3xQ2rvwbmSlLg+bgdknlD5i1ZltG/JAegXtrdQRO
         160TKNdmjUq5YLXGbWLmrvhLJq3r4bicZqFpc56LStiH5BMOSQxXLOB7s7ST8AAs687c
         oVWbwZCvB1p1b80PYyGgoyRUZUr/xZjgoTck0KJ1qIHjU+XekkabLYXw4kjvxWR7d80f
         NTRF2yGxFosAK8qcGgPfp1laJvlYHN948G/KDcJGW3K7MHwJ77QVg9UPKABuSg/WNUyF
         zSR3JdfC2XiQFqcsX3gQUwgteCh9r1Gyz/Ww/HpIbPQerOGhBah4r5VCcHykfvAZoxpw
         ddyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688483289; x=1691075289;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qtM7YlX40DnaBX+93lVDcGrZHwW1VSG0evpOPg36VAY=;
        b=aodzVsiZokAczcGE5GkP6DOT05zJPbn3/l6WKf/Z4AJo7XSzuHU1jTuRucccIAufiC
         7qDtFL9/Ltxm9wO7Lc5JZJDu08ZjDTxdU4afOUPs0R5nKnwkBuvwDHWrIFphwHUOVtln
         2gtzpx1l+j/FzbyvBYcJNrOJ8JPdy9ct2h1KWbM6zCGmXegY9kbfh8U2fV5U7YDvP5YQ
         H3ecHY3M/N+Ep7sipKthYQc7tMX2YlOz9We23GlD8I4PpCn/KApQGX7e3SXJuVIwOFcC
         SSkvcgUPYTMz1KeJH3doOIiQgMzrT1YKKQoJKkkqsaLMy26sQp+I/Mpf+ireWALoyrvr
         cAvw==
X-Gm-Message-State: ABy/qLawWxvu9V+sFhocSQUvwLEgy2ivI5cuHtElAYA4eY11BJkLazSK
        VVFRk4Ifm7dvbdFJC9DydBfwnjFtr4M2moqxzlb2OQ==
X-Google-Smtp-Source: APBJJlGLZdftXDDHuSYhDkG7IEQLptujtcNDS1o3O3IOqJE+T1s7lvI1pQsBh8i1gPxKXtcd4K+5NQ==
X-Received: by 2002:a17:90b:4fc2:b0:260:d8c0:ae79 with SMTP id qa2-20020a17090b4fc200b00260d8c0ae79mr9505980pjb.35.1688483289354;
        Tue, 04 Jul 2023 08:08:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 19-20020a17090a1a1300b0023fcece8067sm18547598pjk.2.2023.07.04.08.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 08:08:08 -0700 (PDT)
Message-ID: <64a435d8.170a0220.6644.4323@mx.google.com>
Date:   Tue, 04 Jul 2023 08:08:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.37-14-g185484ee4c4f
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y
Subject: stable-rc/linux-6.1.y baseline: 168 runs,
 9 regressions (v6.1.37-14-g185484ee4c4f)
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

stable-rc/linux-6.1.y baseline: 168 runs, 9 regressions (v6.1.37-14-g185484=
ee4c4f)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.37-14-g185484ee4c4f/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.37-14-g185484ee4c4f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      185484ee4c4f93669a3a7b324d356d643fdbfe35 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a4009a95ad04d95fbb2a99

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
14-g185484ee4c4f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-acer-chromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
14-g185484ee4c4f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-acer-chromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a4009a95ad04d95fbb2=
a9a
        failing since 0 day (last pass: v6.1.37, first fail: v6.1.37-12-g86=
236a041c0f) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3ff9e66462e41bcbb2a97

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
14-g185484ee4c4f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
14-g185484ee4c4f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3ff9e66462e41bcbb2a9c
        failing since 95 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-04T11:16:58.417056  + set +x

    2023-07-04T11:16:58.423895  <8>[    8.040218] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11007361_1.4.2.3.1>

    2023-07-04T11:16:58.525926  #

    2023-07-04T11:16:58.526250  =


    2023-07-04T11:16:58.626879  / # #export SHELL=3D/bin/sh

    2023-07-04T11:16:58.627065  =


    2023-07-04T11:16:58.727548  / # export SHELL=3D/bin/sh. /lava-11007361/=
environment

    2023-07-04T11:16:58.727765  =


    2023-07-04T11:16:58.828321  / # . /lava-11007361/environment/lava-11007=
361/bin/lava-test-runner /lava-11007361/1

    2023-07-04T11:16:58.828665  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3ff958d452d611fbb2a96

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
14-g185484ee4c4f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
14-g185484ee4c4f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3ff958d452d611fbb2a9b
        failing since 95 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-04T11:16:27.681640  + set<8>[   11.225424] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11007344_1.4.2.3.1>

    2023-07-04T11:16:27.682122   +x

    2023-07-04T11:16:27.789673  / # #

    2023-07-04T11:16:27.891983  export SHELL=3D/bin/sh

    2023-07-04T11:16:27.892823  #

    2023-07-04T11:16:27.994423  / # export SHELL=3D/bin/sh. /lava-11007344/=
environment

    2023-07-04T11:16:27.995217  =


    2023-07-04T11:16:28.097023  / # . /lava-11007344/environment/lava-11007=
344/bin/lava-test-runner /lava-11007344/1

    2023-07-04T11:16:28.098277  =


    2023-07-04T11:16:28.103591  / # /lava-11007344/bin/lava-test-runner /la=
va-11007344/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3ff7dbaa33f2051bb2aad

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
14-g185484ee4c4f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
14-g185484ee4c4f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3ff7dbaa33f2051bb2ab2
        failing since 95 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-04T11:15:56.815524  <8>[   10.604487] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11007295_1.4.2.3.1>

    2023-07-04T11:15:56.819040  + set +x

    2023-07-04T11:15:56.920625  =


    2023-07-04T11:15:57.021270  / # #export SHELL=3D/bin/sh

    2023-07-04T11:15:57.021515  =


    2023-07-04T11:15:57.122057  / # export SHELL=3D/bin/sh. /lava-11007295/=
environment

    2023-07-04T11:15:57.122297  =


    2023-07-04T11:15:57.222828  / # . /lava-11007295/environment/lava-11007=
295/bin/lava-test-runner /lava-11007295/1

    2023-07-04T11:15:57.223111  =


    2023-07-04T11:15:57.227787  / # /lava-11007295/bin/lava-test-runner /la=
va-11007295/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64a4001e4dbdf5f798bb2b6a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
14-g185484ee4c4f/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
14-g185484ee4c4f/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a4001e4dbdf5f798bb2=
b6b
        failing since 26 days (last pass: v6.1.31-40-g7d0a9678d276, first f=
ail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3ff871b7c06b178bb2a75

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
14-g185484ee4c4f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
14-g185484ee4c4f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3ff871b7c06b178bb2a7a
        failing since 95 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-04T11:16:49.445243  + set +x

    2023-07-04T11:16:49.451555  <8>[   11.174132] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11007377_1.4.2.3.1>

    2023-07-04T11:16:49.555948  / # #

    2023-07-04T11:16:49.656537  export SHELL=3D/bin/sh

    2023-07-04T11:16:49.656728  #

    2023-07-04T11:16:49.757210  / # export SHELL=3D/bin/sh. /lava-11007377/=
environment

    2023-07-04T11:16:49.757415  =


    2023-07-04T11:16:49.857921  / # . /lava-11007377/environment/lava-11007=
377/bin/lava-test-runner /lava-11007377/1

    2023-07-04T11:16:49.858215  =


    2023-07-04T11:16:49.863413  / # /lava-11007377/bin/lava-test-runner /la=
va-11007377/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3ff8a1b7c06b178bb2a83

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
14-g185484ee4c4f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
14-g185484ee4c4f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3ff8a1b7c06b178bb2a88
        failing since 95 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-04T11:16:11.444472  <8>[   10.808095] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11007298_1.4.2.3.1>

    2023-07-04T11:16:11.448037  + set +x

    2023-07-04T11:16:11.549441  #

    2023-07-04T11:16:11.549660  =


    2023-07-04T11:16:11.650318  / # #export SHELL=3D/bin/sh

    2023-07-04T11:16:11.650479  =


    2023-07-04T11:16:11.751070  / # export SHELL=3D/bin/sh. /lava-11007298/=
environment

    2023-07-04T11:16:11.751259  =


    2023-07-04T11:16:11.851763  / # . /lava-11007298/environment/lava-11007=
298/bin/lava-test-runner /lava-11007298/1

    2023-07-04T11:16:11.852004  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3ff9fcba92ae1fdbb2a97

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
14-g185484ee4c4f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
14-g185484ee4c4f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3ff9fcba92ae1fdbb2a9c
        failing since 95 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-04T11:16:26.658217  + set<8>[   11.451890] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11007351_1.4.2.3.1>

    2023-07-04T11:16:26.658934   +x

    2023-07-04T11:16:26.767042  / # #

    2023-07-04T11:16:26.869756  export SHELL=3D/bin/sh

    2023-07-04T11:16:26.870571  #

    2023-07-04T11:16:26.972157  / # export SHELL=3D/bin/sh. /lava-11007351/=
environment

    2023-07-04T11:16:26.973041  =


    2023-07-04T11:16:27.074691  / # . /lava-11007351/environment/lava-11007=
351/bin/lava-test-runner /lava-11007351/1

    2023-07-04T11:16:27.075897  =


    2023-07-04T11:16:27.080606  / # /lava-11007351/bin/lava-test-runner /la=
va-11007351/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3ff85017c799954bb2ab8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
14-g185484ee4c4f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
14-g185484ee4c4f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3ff85017c799954bb2abd
        failing since 95 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-04T11:16:08.371106  <8>[   11.420194] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11007296_1.4.2.3.1>

    2023-07-04T11:16:08.475407  / # #

    2023-07-04T11:16:08.576012  export SHELL=3D/bin/sh

    2023-07-04T11:16:08.576245  #

    2023-07-04T11:16:08.676800  / # export SHELL=3D/bin/sh. /lava-11007296/=
environment

    2023-07-04T11:16:08.676997  =


    2023-07-04T11:16:08.777511  / # . /lava-11007296/environment/lava-11007=
296/bin/lava-test-runner /lava-11007296/1

    2023-07-04T11:16:08.777809  =


    2023-07-04T11:16:08.782088  / # /lava-11007296/bin/lava-test-runner /la=
va-11007296/1

    2023-07-04T11:16:08.789122  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =20
