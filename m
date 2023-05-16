Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC087056AF
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 21:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjEPTE4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 16 May 2023 15:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEPTEq (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 16 May 2023 15:04:46 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FBF9ED4
        for <stable@vger.kernel.org>; Tue, 16 May 2023 12:04:36 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1ae3ed1b08eso341145ad.0
        for <stable@vger.kernel.org>; Tue, 16 May 2023 12:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684263875; x=1686855875;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b5DqZOVZkOCyupVUokjAmQw3YAW+nhIV78rAvHI40A8=;
        b=JTgOKnG+DaSY5LIkMg+cSKLKkIUVAdN5ue+shwcgcXmZ6wCF6RYoBt6JdMvw3tknJn
         KWlhodrjtTn2vNNUlZR5gO5QqEUoZmVStJ3DVY5Xa+oJ2fwTZTwJE6K3eOy38bzuCLEL
         NZjVmA6lnv2kBzXCZQIKMLK79FeiCSRmT82EyP6jQY9fJEvGGl0Nvj5zfkYO/mrpSFiR
         Gm+8RcjKDOcLkJ1tMSdjUi4Lh3ufDlJI2v6eRIB6d1Z+Q/8ADOl2eXn4UUxmauomlbsF
         9oMeMkJYHviY44EBre61KP70YhkNuCtQB5tiR3NPCdxl0D0O1+eeDdaTHJkoCJACiIxL
         aRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684263875; x=1686855875;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b5DqZOVZkOCyupVUokjAmQw3YAW+nhIV78rAvHI40A8=;
        b=boMYxjW0BuMmMGznhrjEslCb9Ri3zb3WI5kdZdIh8QTjCermWvyiNXHIcCJHsjPOzd
         /VmNRETJJvxxhNHdVTXXRCtDnzdiWwVoZGGnb2AQifGeqkvGix/A4qn5TTmHnChHQSq0
         12YGf8SCkEpdbBU14U1BfmoDma5xA/XKHQ5TAcosoGkmn3ZsauzzIskcIa90ndvfvPGK
         y4BnPRZsVSPDzlIyo4EN57Q7NZc1+3K3LACiAV2fpjCcP31uQlDahdGyGWyp+54SHOdB
         BoeVRPMK25Gw0zYLK+bbvRPlA2tVk1Fl13MCAYMsxoq3bYFzWBlQPySbUQT890ljtRHS
         0HlA==
X-Gm-Message-State: AC+VfDx916aaQdQDAinoJpRoELL5w30yUj7UNYfvSztLBZXREiUc1i3o
        odjYSi+RGeg2flKBamkAwoWGl1KKSMHHr6A4e/btEg==
X-Google-Smtp-Source: ACHHUZ7yoKqGwFDTDSsVQhGDd0BLx9mG+nL17Gh0Qah1IyVmmSbO1xryO7/3ZIwFI0s5SIl2CpiG9A==
X-Received: by 2002:a17:902:f547:b0:1ac:4a41:d38d with SMTP id h7-20020a170902f54700b001ac4a41d38dmr44835163plf.51.1684263874914;
        Tue, 16 May 2023 12:04:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g14-20020a1709029f8e00b001ac6b926621sm14224693plq.292.2023.05.16.12.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 12:04:34 -0700 (PDT)
Message-ID: <6463d3c2.170a0220.da8ed.c8c9@mx.google.com>
Date:   Tue, 16 May 2023 12:04:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.111-133-gea6e6bdc1959
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 176 runs,
 9 regressions (v5.15.111-133-gea6e6bdc1959)
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

stable-rc/queue/5.15 baseline: 176 runs, 9 regressions (v5.15.111-133-gea6e=
6bdc1959)

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

sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.111-133-gea6e6bdc1959/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.111-133-gea6e6bdc1959
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      ea6e6bdc19594b2fb17e76acdbeead67bfdf1fa6 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64639f5d60f1dfe6022e8612

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-133-gea6e6bdc1959/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-133-gea6e6bdc1959/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64639f5d60f1dfe6022e8617
        failing since 49 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-16T15:20:54.214177  + set<8>[   11.799955] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10336349_1.4.2.3.1>

    2023-05-16T15:20:54.214634   +x

    2023-05-16T15:20:54.321879  / # #

    2023-05-16T15:20:54.424088  export SHELL=3D/bin/sh

    2023-05-16T15:20:54.424325  #

    2023-05-16T15:20:54.524918  / # export SHELL=3D/bin/sh. /lava-10336349/=
environment

    2023-05-16T15:20:54.525146  =


    2023-05-16T15:20:54.625643  / # . /lava-10336349/environment/lava-10336=
349/bin/lava-test-runner /lava-10336349/1

    2023-05-16T15:20:54.625900  =


    2023-05-16T15:20:54.630273  / # /lava-10336349/bin/lava-test-runner /la=
va-10336349/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64639f62ff6b70d1822e85ea

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-133-gea6e6bdc1959/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-133-gea6e6bdc1959/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64639f62ff6b70d1822e85ef
        failing since 49 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-16T15:20:48.747521  <8>[   11.241311] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10336288_1.4.2.3.1>

    2023-05-16T15:20:48.750724  + set +x

    2023-05-16T15:20:48.852018  #

    2023-05-16T15:20:48.852270  =


    2023-05-16T15:20:48.952795  / # #export SHELL=3D/bin/sh

    2023-05-16T15:20:48.952963  =


    2023-05-16T15:20:49.053464  / # export SHELL=3D/bin/sh. /lava-10336288/=
environment

    2023-05-16T15:20:49.053709  =


    2023-05-16T15:20:49.154304  / # . /lava-10336288/environment/lava-10336=
288/bin/lava-test-runner /lava-10336288/1

    2023-05-16T15:20:49.154572  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64639fb9aca811a0a62e8691

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-133-gea6e6bdc1959/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-133-gea6e6bdc1959/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64639fb9aca811a0a62e8=
692
        failing since 102 days (last pass: v5.15.91-12-g3290f78df1ab, first=
 fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64639fdc2d134168bc2e85ed

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-133-gea6e6bdc1959/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-133-gea6e6bdc1959/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64639fdc2d134168bc2e85f1
        failing since 119 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-16T15:22:54.635692  <8>[    9.948919] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3593476_1.5.2.4.1>
    2023-05-16T15:22:54.745769  / # #
    2023-05-16T15:22:54.847463  export SHELL=3D/bin/sh
    2023-05-16T15:22:54.848431  #
    2023-05-16T15:22:54.950658  / # export SHELL=3D/bin/sh. /lava-3593476/e=
nvironment
    2023-05-16T15:22:54.951688  =

    2023-05-16T15:22:55.053852  / # . /lava-3593476/environment/lava-359347=
6/bin/lava-test-runner /lava-3593476/1
    2023-05-16T15:22:55.055186  =

    2023-05-16T15:22:55.060272  / # /lava-3593476/bin/lava-test-runner /lav=
a-3593476/1
    2023-05-16T15:22:55.151599  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6463a16e4df0acdfaa2e85e7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-133-gea6e6bdc1959/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-133-gea6e6bdc1959/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463a16e4df0acdfaa2e85ec
        failing since 49 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-16T15:29:34.864991  + set +x

    2023-05-16T15:29:34.871908  <8>[   10.920543] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10336343_1.4.2.3.1>

    2023-05-16T15:29:34.979566  / # #

    2023-05-16T15:29:35.081649  export SHELL=3D/bin/sh

    2023-05-16T15:29:35.082537  #

    2023-05-16T15:29:35.183925  / # export SHELL=3D/bin/sh. /lava-10336343/=
environment

    2023-05-16T15:29:35.184135  =


    2023-05-16T15:29:35.284787  / # . /lava-10336343/environment/lava-10336=
343/bin/lava-test-runner /lava-10336343/1

    2023-05-16T15:29:35.285997  =


    2023-05-16T15:29:35.291121  / # /lava-10336343/bin/lava-test-runner /la=
va-10336343/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6463a1968886583e9b2e864d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-133-gea6e6bdc1959/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-133-gea6e6bdc1959/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463a1968886583e9b2e8652
        failing since 49 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-16T15:30:07.152977  + set +x

    2023-05-16T15:30:07.159925  <8>[    8.029398] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10336327_1.4.2.3.1>

    2023-05-16T15:30:07.264800  / # #

    2023-05-16T15:30:07.365411  export SHELL=3D/bin/sh

    2023-05-16T15:30:07.365693  #

    2023-05-16T15:30:07.466172  / # export SHELL=3D/bin/sh. /lava-10336327/=
environment

    2023-05-16T15:30:07.466369  =


    2023-05-16T15:30:07.566873  / # . /lava-10336327/environment/lava-10336=
327/bin/lava-test-runner /lava-10336327/1

    2023-05-16T15:30:07.567170  =


    2023-05-16T15:30:07.572363  / # /lava-10336327/bin/lava-test-runner /la=
va-10336327/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64639f64023e8768982e85e7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-133-gea6e6bdc1959/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-133-gea6e6bdc1959/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64639f64023e8768982e85ec
        failing since 49 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-16T15:20:53.537116  + set<8>[   10.910269] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10336299_1.4.2.3.1>

    2023-05-16T15:20:53.537670   +x

    2023-05-16T15:20:53.645481  / # #

    2023-05-16T15:20:53.747887  export SHELL=3D/bin/sh

    2023-05-16T15:20:53.748669  #

    2023-05-16T15:20:53.850186  / # export SHELL=3D/bin/sh. /lava-10336299/=
environment

    2023-05-16T15:20:53.850964  =


    2023-05-16T15:20:53.952554  / # . /lava-10336299/environment/lava-10336=
299/bin/lava-test-runner /lava-10336299/1

    2023-05-16T15:20:53.953946  =


    2023-05-16T15:20:53.958729  / # /lava-10336299/bin/lava-test-runner /la=
va-10336299/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64639facbbe4e2936e2e85eb

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-133-gea6e6bdc1959/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-133-gea6e6bdc1959/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64639facbbe4e2936e2e85f0
        failing since 49 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-16T15:22:09.253272  <8>[   10.113420] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10336328_1.4.2.3.1>

    2023-05-16T15:22:09.360695  / # #

    2023-05-16T15:22:09.462811  export SHELL=3D/bin/sh

    2023-05-16T15:22:09.463495  #

    2023-05-16T15:22:09.564761  / # export SHELL=3D/bin/sh. /lava-10336328/=
environment

    2023-05-16T15:22:09.565484  =


    2023-05-16T15:22:09.667182  / # . /lava-10336328/environment/lava-10336=
328/bin/lava-test-runner /lava-10336328/1

    2023-05-16T15:22:09.668523  =


    2023-05-16T15:22:09.673115  / # /lava-10336328/bin/lava-test-runner /la=
va-10336328/1

    2023-05-16T15:22:09.679140  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/6463abe87d7c60fad82e861b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-133-gea6e6bdc1959/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h=
2-plus-orangepi-r1.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-133-gea6e6bdc1959/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h=
2-plus-orangepi-r1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463abe87d7c60fad82e8620
        failing since 105 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.90-203-gea2e94bef77e)

    2023-05-16T16:13:57.064273  <8>[    5.597674] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3593429_1.5.2.4.1>
    2023-05-16T16:13:57.186251  / # #
    2023-05-16T16:13:57.292600  export SHELL=3D/bin/sh
    2023-05-16T16:13:57.294714  #
    2023-05-16T16:13:57.398307  / # export SHELL=3D/bin/sh. /lava-3593429/e=
nvironment
    2023-05-16T16:13:57.400275  =

    2023-05-16T16:13:57.504027  / # . /lava-3593429/environment/lava-359342=
9/bin/lava-test-runner /lava-3593429/1
    2023-05-16T16:13:57.507124  =

    2023-05-16T16:13:57.523907  / # /lava-3593429/bin/lava-test-runner /lav=
a-3593429/1
    2023-05-16T16:13:57.627222  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
