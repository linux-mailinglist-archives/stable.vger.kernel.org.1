Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C8B744B15
	for <lists+stable@lfdr.de>; Sat,  1 Jul 2023 22:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjGAUtI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 1 Jul 2023 16:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGAUtI (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 1 Jul 2023 16:49:08 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD1E1985
        for <stable@vger.kernel.org>; Sat,  1 Jul 2023 13:49:06 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b88e5b3834so488135ad.3
        for <stable@vger.kernel.org>; Sat, 01 Jul 2023 13:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688244545; x=1690836545;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Sr9Uvw+caP4syAK0HjcY4FRGBkV6VaNVtRxEPNgiONs=;
        b=2vQ/xzWiKdVvSBSpsMWvT27+W68iIFpSy7p2higC8g/75M9ui33OULoL8fXfTx0Osd
         Xn3B35rDnREpvAwjRljrAFS19KJx38lSUu7073NTSeTFxwqe7u/FQU8mMRpbg5OWZG1y
         S6d2ec/UNQfX3tnkunkbEz0WC9Wme+NVtnS2G9wIzCwVcNYlG2p6gzjd8NMlZU2lPwNJ
         1+l+p5kPSoIWATYa2BNadDZofLH/1H2JPqzzNo1Vc/FKcfQDLj303ZJfHJ0GTTzeWZJQ
         OzhJ6nQ9Y1zWxQX/mEY7NEL6RfYTjJsN+akBncnthhB3b4cTGDJP6IU2kIg0qnW9/vfC
         7S9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688244545; x=1690836545;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sr9Uvw+caP4syAK0HjcY4FRGBkV6VaNVtRxEPNgiONs=;
        b=UEE9iA0WNPNys64MPA612IONu2i3QvBqG+7AgwsZcO82a6UUO45e/+We/LSIcyt8iX
         xNWDJ1FbgVfm/+UwxiHQD1yPjfWqdXmvJKUhS5mKMCY3vAb9D0VQz7fVZCEV2C5va7F+
         jxz90bjwoNl0JqFpr0TH4I7pb3RcypkOwXfBVuVa+CFyDNihw1gevmtsZae+PFt0f1lY
         D0vvnDhbBoXAYHXCPXnpFtBvmhXqqVbN22elrFHYXzrb2VhMah6mLZWpKpofia/msV0O
         GygGNsN34xisLPdLLfTyONFR9sr+BA9YgKNcGhIiZZNFjDupvk6QUJtMmE61tnR/kF22
         K9Bg==
X-Gm-Message-State: ABy/qLZCPmS2WPR93UI9S2o+872KSdKEanKAZPZgDOTlbF4ol2Orlkfh
        xMYUiRd7+5ehRdiBHpzCLIg84zFevgRVUdFC3BUedQ==
X-Google-Smtp-Source: APBJJlHFSBE1SuTKrLf2dTZqM1uuvOMVMXad9HQpBL1Bp9tDyhZeyf+Q4aS98KkWQ3wZ5kdKYfqw6Q==
X-Received: by 2002:a17:902:e5c1:b0:1b8:5ab2:49a4 with SMTP id u1-20020a170902e5c100b001b85ab249a4mr5097181plf.53.1688244545050;
        Sat, 01 Jul 2023 13:49:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902d3c500b001b1a2bf5277sm6513718plb.39.2023.07.01.13.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 13:49:04 -0700 (PDT)
Message-ID: <64a09140.170a0220.a3e0e.d1dc@mx.google.com>
Date:   Sat, 01 Jul 2023 13:49:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.37
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y
Subject: stable-rc/linux-6.1.y baseline: 97 runs, 8 regressions (v6.1.37)
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

stable-rc/linux-6.1.y baseline: 97 runs, 8 regressions (v6.1.37)

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

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.37/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.37
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      0f4ac6b4c5f00f45b7a429c8a5b028a598c6400c =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a059439910f04025bb2a7c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a059439910f04025bb2a81
        failing since 93 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-01T16:49:55.477706  + set +x

    2023-07-01T16:49:55.484224  <8>[   10.411760] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10976926_1.4.2.3.1>

    2023-07-01T16:49:55.588619  / # #

    2023-07-01T16:49:55.689214  export SHELL=3D/bin/sh

    2023-07-01T16:49:55.689387  #

    2023-07-01T16:49:55.789909  / # export SHELL=3D/bin/sh. /lava-10976926/=
environment

    2023-07-01T16:49:55.790075  =


    2023-07-01T16:49:55.890596  / # . /lava-10976926/environment/lava-10976=
926/bin/lava-test-runner /lava-10976926/1

    2023-07-01T16:49:55.890858  =


    2023-07-01T16:49:55.896601  / # /lava-10976926/bin/lava-test-runner /la=
va-10976926/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a0593c4aa7cb1602bb2a76

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a0593c4aa7cb1602bb2a7b
        failing since 93 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-01T16:49:41.636987  + set<8>[    9.044994] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10976934_1.4.2.3.1>

    2023-07-01T16:49:41.637567   +x

    2023-07-01T16:49:41.745405  / # #

    2023-07-01T16:49:41.847937  export SHELL=3D/bin/sh

    2023-07-01T16:49:41.848762  #

    2023-07-01T16:49:41.950421  / # export SHELL=3D/bin/sh. /lava-10976934/=
environment

    2023-07-01T16:49:41.951217  =


    2023-07-01T16:49:42.052737  / # . /lava-10976934/environment/lava-10976=
934/bin/lava-test-runner /lava-10976934/1

    2023-07-01T16:49:42.053968  =


    2023-07-01T16:49:42.058967  / # /lava-10976934/bin/lava-test-runner /la=
va-10976934/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a05921b08d8e6838bb2a97

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a05921b08d8e6838bb2a9c
        failing since 93 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-01T16:49:18.660938  <8>[    9.759106] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10976879_1.4.2.3.1>

    2023-07-01T16:49:18.664407  + set +x

    2023-07-01T16:49:18.768831  #

    2023-07-01T16:49:18.769544  =


    2023-07-01T16:49:18.870791  / # #export SHELL=3D/bin/sh

    2023-07-01T16:49:18.871607  =


    2023-07-01T16:49:18.973123  / # export SHELL=3D/bin/sh. /lava-10976879/=
environment

    2023-07-01T16:49:18.974158  =


    2023-07-01T16:49:19.075724  / # . /lava-10976879/environment/lava-10976=
879/bin/lava-test-runner /lava-10976879/1

    2023-07-01T16:49:19.077043  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64a05b4e8ebacd381abb2aac

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a05b4e8ebacd381abb2=
aad
        failing since 23 days (last pass: v6.1.31-40-g7d0a9678d276, first f=
ail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a059324643b4a732bb2a77

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a059324643b4a732bb2a7c
        failing since 93 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-01T16:49:43.289730  + set +x

    2023-07-01T16:49:43.296598  <8>[   10.733280] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10976859_1.4.2.3.1>

    2023-07-01T16:49:43.404606  / # #

    2023-07-01T16:49:43.506749  export SHELL=3D/bin/sh

    2023-07-01T16:49:43.507562  #

    2023-07-01T16:49:43.608916  / # export SHELL=3D/bin/sh. /lava-10976859/=
environment

    2023-07-01T16:49:43.609281  =


    2023-07-01T16:49:43.710173  / # . /lava-10976859/environment/lava-10976=
859/bin/lava-test-runner /lava-10976859/1

    2023-07-01T16:49:43.710918  =


    2023-07-01T16:49:43.715622  / # /lava-10976859/bin/lava-test-runner /la=
va-10976859/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a0592982caca6b68bb2a89

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a0592982caca6b68bb2a8e
        failing since 93 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-01T16:49:24.718776  <8>[   10.819017] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10976927_1.4.2.3.1>

    2023-07-01T16:49:24.722148  + set +x

    2023-07-01T16:49:24.829666  / # #

    2023-07-01T16:49:24.931731  export SHELL=3D/bin/sh

    2023-07-01T16:49:24.932401  #

    2023-07-01T16:49:25.033832  / # export SHELL=3D/bin/sh. /lava-10976927/=
environment

    2023-07-01T16:49:25.034513  =


    2023-07-01T16:49:25.135895  / # . /lava-10976927/environment/lava-10976=
927/bin/lava-test-runner /lava-10976927/1

    2023-07-01T16:49:25.137063  =


    2023-07-01T16:49:25.142576  / # /lava-10976927/bin/lava-test-runner /la=
va-10976927/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a05931419e959551bb2ac9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a05931419e959551bb2ace
        failing since 93 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-01T16:49:34.378033  + set<8>[   11.342163] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10976872_1.4.2.3.1>

    2023-07-01T16:49:34.378624   +x

    2023-07-01T16:49:34.486867  / # #

    2023-07-01T16:49:34.589582  export SHELL=3D/bin/sh

    2023-07-01T16:49:34.590399  #

    2023-07-01T16:49:34.692015  / # export SHELL=3D/bin/sh. /lava-10976872/=
environment

    2023-07-01T16:49:34.692851  =


    2023-07-01T16:49:34.794551  / # . /lava-10976872/environment/lava-10976=
872/bin/lava-test-runner /lava-10976872/1

    2023-07-01T16:49:34.795825  =


    2023-07-01T16:49:34.800907  / # /lava-10976872/bin/lava-test-runner /la=
va-10976872/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a059444aa7cb1602bb2aca

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a059444aa7cb1602bb2acf
        failing since 93 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-01T16:49:52.129439  + set +x<8>[   10.994430] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10976936_1.4.2.3.1>

    2023-07-01T16:49:52.129891  =


    2023-07-01T16:49:52.237753  / # #

    2023-07-01T16:49:52.339697  export SHELL=3D/bin/sh

    2023-07-01T16:49:52.340416  #

    2023-07-01T16:49:52.441728  / # export SHELL=3D/bin/sh. /lava-10976936/=
environment

    2023-07-01T16:49:52.442525  =


    2023-07-01T16:49:52.543916  / # . /lava-10976936/environment/lava-10976=
936/bin/lava-test-runner /lava-10976936/1

    2023-07-01T16:49:52.544174  =


    2023-07-01T16:49:52.548978  / # /lava-10976936/bin/lava-test-runner /la=
va-10976936/1
 =

    ... (12 line(s) more)  =

 =20
