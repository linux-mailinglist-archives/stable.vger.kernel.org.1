Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96A87347DB
	for <lists+stable@lfdr.de>; Sun, 18 Jun 2023 20:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjFRS6G (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 18 Jun 2023 14:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjFRS6F (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Jun 2023 14:58:05 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9A61B5
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 11:58:02 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-77e2bc54dc4so52558339f.3
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 11:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687114681; x=1689706681;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K9VU2eAexXhhnBG0LEuaQHPOpciQt7gvl1MJtdfOI8s=;
        b=itF4vrEVXhJPevuOEf+PGes0Z3h5MQmhHXot3jWp9aaqrvWsOHLBvJuw9rz0QahSBP
         mAn+lFMWJTs6MBDWTALwZDwCb0QhEyjC8UYbXhrYrieuBkx4J5dePcJv3KV0Xhkzvov4
         R4kqZUlKYgrYvL+FNxVeO36j2k7XyWoWVu2sZmTiK1AtABQk3M2ilYFGviN8IQOBwr5Y
         y/cipxzzscxOdwQ0RDV9pGKP2CFumu9mLEpKseyHa2V/Inb+MojqdRAr7a6eJWdznAHn
         JMoDBPvGZ+6sh2TOejQuUl7OsOmGoso8ItSgSNRtnVtgCLeiu+vuLZVYOeAGhq//BbaR
         ihkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687114681; x=1689706681;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K9VU2eAexXhhnBG0LEuaQHPOpciQt7gvl1MJtdfOI8s=;
        b=E93Trfm6CxfMT9ywe/FFrQDUrIlhk2tEjCGm/DkHm9HXRlVh+m8y7pa2M4v5Z3aHri
         XyH2VAwWp2nNasOYYzEf467eQQ0vjWvY+w/kAagLKFnA+CMsZ85oQo5TRRs5oDU5JVex
         at7w3/lw+tPW/NE5PCqZ/bi75ABwCEHEyV7p+DIeC0R8WA68jwDeGeZYWyhInQHHRlNQ
         veZiJBYfcHE3Iy8LlNOmqHQaVT063Wy6raUOOGq/fjNHPzPEAZR1i5cI/1rpX/u6frzc
         HX1FLG/0N/zyN4ZC9ahq4EwzCVf6tpNK/LBgUpub/h90JGV5UfjdHIVBXhwwwJrma5wK
         lEbg==
X-Gm-Message-State: AC+VfDyg81CHJBcNgo4+OPkIcwvfBVvcunpbly5P6ipSEYxgSOG3mlSK
        2Oj93FQTkeSbSt/K98F2XZlPvGfdaM/I0kXe41mD4k8T
X-Google-Smtp-Source: ACHHUZ7Gvy3JfdpJQJsAM/KyET/hLOA7jWFFbBqDtovu9cqSodof5eRH2NftNXnsWoC5YPlRhafsFw==
X-Received: by 2002:a92:c907:0:b0:334:faa5:48f with SMTP id t7-20020a92c907000000b00334faa5048fmr3827314ilp.28.1687114680620;
        Sun, 18 Jun 2023 11:58:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902968200b001b5656b0bf9sm742881plp.286.2023.06.18.11.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 11:58:00 -0700 (PDT)
Message-ID: <648f53b8.170a0220.a3939.0eb4@mx.google.com>
Date:   Sun, 18 Jun 2023 11:58:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.117-59-g818c4cea959a
Subject: stable-rc/linux-5.15.y baseline: 151 runs,
 14 regressions (v5.15.117-59-g818c4cea959a)
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

stable-rc/linux-5.15.y baseline: 151 runs, 14 regressions (v5.15.117-59-g81=
8c4cea959a)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

rk3328-rock64                | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.117-59-g818c4cea959a/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.117-59-g818c4cea959a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      818c4cea959a085e4b6f3f8f31bd20ea625e9e0d =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648f1b805b44b950bf30614b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-59-g818c4cea959a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-59-g818c4cea959a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f1b805b44b950bf306150
        failing since 81 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-18T14:57:51.284359  <8>[   10.557737] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10794413_1.4.2.3.1>

    2023-06-18T14:57:51.287391  + set +x

    2023-06-18T14:57:51.392130  / # #

    2023-06-18T14:57:51.492817  export SHELL=3D/bin/sh

    2023-06-18T14:57:51.493106  #

    2023-06-18T14:57:51.593629  / # export SHELL=3D/bin/sh. /lava-10794413/=
environment

    2023-06-18T14:57:51.593854  =


    2023-06-18T14:57:51.694398  / # . /lava-10794413/environment/lava-10794=
413/bin/lava-test-runner /lava-10794413/1

    2023-06-18T14:57:51.694758  =


    2023-06-18T14:57:51.700922  / # /lava-10794413/bin/lava-test-runner /la=
va-10794413/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648f1b855b44b950bf30617d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-59-g818c4cea959a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-59-g818c4cea959a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f1b855b44b950bf306182
        failing since 81 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-18T14:58:18.625173  + <8>[   11.505596] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10794383_1.4.2.3.1>

    2023-06-18T14:58:18.625273  set +x

    2023-06-18T14:58:18.729941  / # #

    2023-06-18T14:58:18.830506  export SHELL=3D/bin/sh

    2023-06-18T14:58:18.830693  #

    2023-06-18T14:58:18.931266  / # export SHELL=3D/bin/sh. /lava-10794383/=
environment

    2023-06-18T14:58:18.931459  =


    2023-06-18T14:58:19.031991  / # . /lava-10794383/environment/lava-10794=
383/bin/lava-test-runner /lava-10794383/1

    2023-06-18T14:58:19.032341  =


    2023-06-18T14:58:19.037138  / # /lava-10794383/bin/lava-test-runner /la=
va-10794383/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648f1b707b15893d4130616d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-59-g818c4cea959a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-59-g818c4cea959a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f1b707b15893d41306172
        failing since 81 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-18T14:57:31.479193  <8>[   10.067741] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10794376_1.4.2.3.1>

    2023-06-18T14:57:31.482189  + set +x

    2023-06-18T14:57:31.583376  #

    2023-06-18T14:57:31.583672  =


    2023-06-18T14:57:31.684237  / # #export SHELL=3D/bin/sh

    2023-06-18T14:57:31.684455  =


    2023-06-18T14:57:31.785067  / # export SHELL=3D/bin/sh. /lava-10794376/=
environment

    2023-06-18T14:57:31.785306  =


    2023-06-18T14:57:31.885832  / # . /lava-10794376/environment/lava-10794=
376/bin/lava-test-runner /lava-10794376/1

    2023-06-18T14:57:31.886171  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/648f1c51175b53f598306165

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-59-g818c4cea959a/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-59-g818c4cea959a/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648f1c51175b53f598306=
166
        failing since 402 days (last pass: v5.15.37-259-gab77581473a3, firs=
t fail: v5.15.39) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648f1ca06c0c4a5e2a30616b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-59-g818c4cea959a/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-59-g818c4cea959a/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f1ca06c0c4a5e2a306170
        failing since 152 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-06-18T15:02:42.301439  + set +x<8>[   10.078522] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3673106_1.5.2.4.1>
    2023-06-18T15:02:42.302141  =

    2023-06-18T15:02:42.410715  / # #
    2023-06-18T15:02:42.513866  export SHELL=3D/bin/sh
    2023-06-18T15:02:42.514728  #
    2023-06-18T15:02:42.515172  / # export SHELL=3D/bin/sh<3>[   10.273164]=
 Bluetooth: hci0: command 0xfc18 tx timeout
    2023-06-18T15:02:42.617189  . /lava-3673106/environment
    2023-06-18T15:02:42.618196  =

    2023-06-18T15:02:42.720368  / # . /lava-3673106/environment/lava-367310=
6/bin/lava-test-runner /lava-3673106/1
    2023-06-18T15:02:42.721920   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648f1b8f1c4d06df9f306152

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-59-g818c4cea959a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-59-g818c4cea959a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f1b8f1c4d06df9f306157
        failing since 81 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-18T14:58:11.737449  + set +x

    2023-06-18T14:58:11.743913  <8>[   10.543590] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10794434_1.4.2.3.1>

    2023-06-18T14:58:11.848618  / # #

    2023-06-18T14:58:11.949336  export SHELL=3D/bin/sh

    2023-06-18T14:58:11.949584  #

    2023-06-18T14:58:12.050131  / # export SHELL=3D/bin/sh. /lava-10794434/=
environment

    2023-06-18T14:58:12.050381  =


    2023-06-18T14:58:12.150980  / # . /lava-10794434/environment/lava-10794=
434/bin/lava-test-runner /lava-10794434/1

    2023-06-18T14:58:12.151295  =


    2023-06-18T14:58:12.156490  / # /lava-10794434/bin/lava-test-runner /la=
va-10794434/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648f1b6a696eb4a3b430612e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-59-g818c4cea959a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-59-g818c4cea959a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f1b6a696eb4a3b4306133
        failing since 81 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-18T14:57:22.547636  <8>[   11.299235] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10794424_1.4.2.3.1>

    2023-06-18T14:57:22.551261  + set +x

    2023-06-18T14:57:22.659013  / # #

    2023-06-18T14:57:22.761828  export SHELL=3D/bin/sh

    2023-06-18T14:57:22.762702  #

    2023-06-18T14:57:22.864561  / # export SHELL=3D/bin/sh. /lava-10794424/=
environment

    2023-06-18T14:57:22.865379  =


    2023-06-18T14:57:22.967018  / # . /lava-10794424/environment/lava-10794=
424/bin/lava-test-runner /lava-10794424/1

    2023-06-18T14:57:22.968364  =


    2023-06-18T14:57:22.973527  / # /lava-10794424/bin/lava-test-runner /la=
va-10794424/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648f1b8886fdd637b8306145

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-59-g818c4cea959a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-59-g818c4cea959a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f1b8886fdd637b830614a
        failing since 81 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-18T14:57:52.694567  + set<8>[   10.874173] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10794420_1.4.2.3.1>

    2023-06-18T14:57:52.694680   +x

    2023-06-18T14:57:52.798841  / # #

    2023-06-18T14:57:52.899504  export SHELL=3D/bin/sh

    2023-06-18T14:57:52.899716  #

    2023-06-18T14:57:53.000267  / # export SHELL=3D/bin/sh. /lava-10794420/=
environment

    2023-06-18T14:57:53.000517  =


    2023-06-18T14:57:53.101100  / # . /lava-10794420/environment/lava-10794=
420/bin/lava-test-runner /lava-10794420/1

    2023-06-18T14:57:53.101427  =


    2023-06-18T14:57:53.105855  / # /lava-10794420/bin/lava-test-runner /la=
va-10794420/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648f1c1dd7d12eff6130612e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-59-g818c4cea959a/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-=
imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-59-g818c4cea959a/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-=
imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f1c1dd7d12eff61306133
        failing since 138 days (last pass: v5.15.81-122-gc5f8d4a5d3c8, firs=
t fail: v5.15.90-205-g5605d15db022)

    2023-06-18T15:00:37.343170  + set +x
    2023-06-18T15:00:37.343343  [    9.442323] <LAVA_SIGNAL_ENDRUN 0_dmesg =
980461_1.5.2.3.1>
    2023-06-18T15:00:37.450353  / # #
    2023-06-18T15:00:37.551781  export SHELL=3D/bin/sh
    2023-06-18T15:00:37.552170  #
    2023-06-18T15:00:37.653327  / # export SHELL=3D/bin/sh. /lava-980461/en=
vironment
    2023-06-18T15:00:37.653797  =

    2023-06-18T15:00:37.754999  / # . /lava-980461/environment/lava-980461/=
bin/lava-test-runner /lava-980461/1
    2023-06-18T15:00:37.755606  =

    2023-06-18T15:00:37.758400  / # /lava-980461/bin/lava-test-runner /lava=
-980461/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648f1b9ec4c622b50730612f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-59-g818c4cea959a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-59-g818c4cea959a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f1b9ec4c622b507306134
        failing since 81 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-18T14:58:20.965634  + <8>[   12.385976] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10794407_1.4.2.3.1>

    2023-06-18T14:58:20.966212  set +x

    2023-06-18T14:58:21.073441  / # #

    2023-06-18T14:58:21.174874  export SHELL=3D/bin/sh

    2023-06-18T14:58:21.175601  #

    2023-06-18T14:58:21.276972  / # export SHELL=3D/bin/sh. /lava-10794407/=
environment

    2023-06-18T14:58:21.277719  =


    2023-06-18T14:58:21.379215  / # . /lava-10794407/environment/lava-10794=
407/bin/lava-test-runner /lava-10794407/1

    2023-06-18T14:58:21.380313  =


    2023-06-18T14:58:21.385914  / # /lava-10794407/bin/lava-test-runner /la=
va-10794407/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3328-rock64                | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648f1dff7913b5c155306166

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-59-g818c4cea959a/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-roc=
k64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-59-g818c4cea959a/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-roc=
k64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f1dff7913b5c15530616b
        failing since 10 days (last pass: v5.15.72-38-gebe70cd7f5413, first=
 fail: v5.15.114-196-g00621f2608ac)

    2023-06-18T15:08:38.554583  [   16.023229] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3673169_1.5.2.4.1>
    2023-06-18T15:08:38.660091  =

    2023-06-18T15:08:38.762457  / # #export SHELL=3D/bin/sh
    2023-06-18T15:08:38.762919  =

    2023-06-18T15:08:38.864265  / # export SHELL=3D/bin/sh. /lava-3673169/e=
nvironment
    2023-06-18T15:08:38.864718  =

    2023-06-18T15:08:38.966139  / # . /lava-3673169/environment/lava-367316=
9/bin/lava-test-runner /lava-3673169/1
    2023-06-18T15:08:38.966829  =

    2023-06-18T15:08:38.970456  / # /lava-3673169/bin/lava-test-runner /lav=
a-3673169/1
    2023-06-18T15:08:39.001463  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648f1fb62c15b819a1306331

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-59-g818c4cea959a/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64=
-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-59-g818c4cea959a/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64=
-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f1fb72c15b819a130635e
        failing since 152 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-06-18T15:15:40.436205  + set +x
    2023-06-18T15:15:40.440410  <8>[   16.013041] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3673170_1.5.2.4.1>
    2023-06-18T15:15:40.560364  / # #
    2023-06-18T15:15:40.665927  export SHELL=3D/bin/sh
    2023-06-18T15:15:40.667437  #
    2023-06-18T15:15:40.770784  / # export SHELL=3D/bin/sh. /lava-3673170/e=
nvironment
    2023-06-18T15:15:40.772366  =

    2023-06-18T15:15:40.875776  / # . /lava-3673170/environment/lava-367317=
0/bin/lava-test-runner /lava-3673170/1
    2023-06-18T15:15:40.878498  =

    2023-06-18T15:15:40.881766  / # /lava-3673170/bin/lava-test-runner /lav=
a-3673170/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648f1e25b660f197e0306200

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-59-g818c4cea959a/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-=
pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-59-g818c4cea959a/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-=
pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f1e25b660f197e030622c
        failing since 152 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-06-18T15:09:01.795624  + set +x
    2023-06-18T15:09:01.799697  <8>[   16.163645] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 626653_1.5.2.4.1>
    2023-06-18T15:09:01.909844  / # #
    2023-06-18T15:09:02.012995  export SHELL=3D/bin/sh
    2023-06-18T15:09:02.013575  #
    2023-06-18T15:09:02.115208  / # export SHELL=3D/bin/sh. /lava-626653/en=
vironment
    2023-06-18T15:09:02.115910  =

    2023-06-18T15:09:02.217764  / # . /lava-626653/environment/lava-626653/=
bin/lava-test-runner /lava-626653/1
    2023-06-18T15:09:02.218646  =

    2023-06-18T15:09:02.222411  / # /lava-626653/bin/lava-test-runner /lava=
-626653/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/648f1df67913b5c155306140

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-59-g818c4cea959a/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-=
h2-plus-orangepi-r1.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-59-g818c4cea959a/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-=
h2-plus-orangepi-r1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f1df67913b5c155306145
        failing since 66 days (last pass: v5.15.82-124-g2b8b2c150867, first=
 fail: v5.15.105-194-g415a9d81c640)

    2023-06-18T15:07:52.848603  / # #
    2023-06-18T15:07:52.954196  export SHELL=3D/bin/sh
    2023-06-18T15:07:52.955879  #
    2023-06-18T15:07:53.059399  / # export SHELL=3D/bin/sh. /lava-3673076/e=
nvironment
    2023-06-18T15:07:53.061081  =

    2023-06-18T15:07:53.164759  / # . /lava-3673076/environment/lava-367307=
6/bin/lava-test-runner /lava-3673076/1
    2023-06-18T15:07:53.167393  =

    2023-06-18T15:07:53.173941  / # /lava-3673076/bin/lava-test-runner /lav=
a-3673076/1
    2023-06-18T15:07:53.285954  + export 'TESTRUN_ID=3D1_bootrr'
    2023-06-18T15:07:53.325781  + cd /lava-3673076/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
