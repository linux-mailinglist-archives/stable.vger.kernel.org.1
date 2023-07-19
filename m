Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FD775A2AD
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 01:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjGSXOr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 19 Jul 2023 19:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjGSXOp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 19 Jul 2023 19:14:45 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9021701
        for <stable@vger.kernel.org>; Wed, 19 Jul 2023 16:14:42 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b9c368f4b5so9330955ad.0
        for <stable@vger.kernel.org>; Wed, 19 Jul 2023 16:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689808482; x=1692400482;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M1zrbhGbyOB0CG5mTIdwAprBeeKNojnZ4nt2zW7qkXw=;
        b=cqr1KtwWNiPAZiDY/xWut+m09ooMona2z2ZvCWbiOEmrlmClPpbIivah/UNppbhYPN
         ZsuZ7lahpXrRYgYEvzriFyS8hR0Euh0ZyCQNBPVKphdOI/sAxEK31OEchlDCsVsnMnxe
         Ywk11uHyDeQiB8tJzPn+ij90Lg0QBiKcZOqazRH3+tbBpTcZKJWUlLBDr++iwaKcITSx
         3AHs1Vtigw7TAYDwc0cDwowcPeqs8HTygDE/nyqBW6ZrEPeLGvL7FY9YLbByDEISVEpP
         qKmKxQBJVpv99OWpbAxVui/stL4SAfRSqZskyILGlnG70Dwl1dgIZxZpx3AP0aPk9bZj
         L0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689808482; x=1692400482;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1zrbhGbyOB0CG5mTIdwAprBeeKNojnZ4nt2zW7qkXw=;
        b=IRYWhyoPhNxV1ssABd+KXDabQ9jtCtkMnBxJV2n8qTlb/ifW8x6ARw6lL84uICtHLm
         PztndmxHJ5X3Md9IywBysqyLiTddAj4C4NtD9UXBPi/UfiTJCSDbMgnbgNrQO1Ea6gmZ
         RVsQ7NCjR0wVaXwNCKEXmDl8OGDryc+0fs0CscmtxcTARdRtDTq/AdKV5KTsAoKDYF+H
         /1UNX2w8RHlGAUeZjK/bAaXfpsBizPTIRGUCJBTknn2cstsYTbPg02GCStB250OtG3WN
         UBP8bo6bQ3EMY1Ys2FzPpsDD9+Mc2yhOf6aArrhUd6mWaZI6oQkZOf226PZ65wEfAurD
         kpPQ==
X-Gm-Message-State: ABy/qLZBaPamfYxy5OistFw8MbaJI1mYgViAK9YPI1dwQItAGwWk/k4Y
        ZxzWRZA+iscDt8b6X32EEoSgfwNua9iw4EKpoBMMGQ==
X-Google-Smtp-Source: APBJJlGX1jeUaLZ2ZBRgK8Tk9S8qSO8aTE+lm9a073pNIGKNtduaiORYIryxuedOHxF3J9r8Jo0DYg==
X-Received: by 2002:a17:902:d355:b0:1b8:ad90:7af8 with SMTP id l21-20020a170902d35500b001b8ad907af8mr4398433plk.17.1689808481222;
        Wed, 19 Jul 2023 16:14:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o1-20020a170902bcc100b001a183ade911sm4527957pls.56.2023.07.19.16.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 16:14:40 -0700 (PDT)
Message-ID: <64b86e60.170a0220.290fa.a7f7@mx.google.com>
Date:   Wed, 19 Jul 2023 16:14:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Kernel: v5.15.120
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.15.y baseline: 160 runs, 17 regressions (v5.15.120)
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

stable-rc/linux-5.15.y baseline: 160 runs, 17 regressions (v5.15.120)

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

cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

fsl-ls2088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

fsl-lx2160a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

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

r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

rk3328-rock64                | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

stm32mp157c-dk2              | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

sun50i-h6-pine-h64           | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.120/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.120
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      d54cfc420586425d418a53871290cc4a59d33501 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b838c717776a8a478ace3b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b838c717776a8a478ace40
        failing since 112 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-07-19T19:25:42.723999  <8>[    8.291165] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11114545_1.4.2.3.1>

    2023-07-19T19:25:42.727513  + set +x

    2023-07-19T19:25:42.831432  / # #

    2023-07-19T19:25:42.931978  export SHELL=3D/bin/sh

    2023-07-19T19:25:42.932163  #

    2023-07-19T19:25:43.032694  / # export SHELL=3D/bin/sh. /lava-11114545/=
environment

    2023-07-19T19:25:43.032934  =


    2023-07-19T19:25:43.133550  / # . /lava-11114545/environment/lava-11114=
545/bin/lava-test-runner /lava-11114545/1

    2023-07-19T19:25:43.133828  =


    2023-07-19T19:25:43.139321  / # /lava-11114545/bin/lava-test-runner /la=
va-11114545/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b838c86e0794ad208ace5f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b838c86e0794ad208ace64
        failing since 112 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-07-19T19:25:37.551836  + set<8>[   13.069000] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11114558_1.4.2.3.1>

    2023-07-19T19:25:37.552080   +x

    2023-07-19T19:25:37.657057  / # #

    2023-07-19T19:25:37.758419  export SHELL=3D/bin/sh

    2023-07-19T19:25:37.758828  #

    2023-07-19T19:25:37.859741  / # export SHELL=3D/bin/sh. /lava-11114558/=
environment

    2023-07-19T19:25:37.860125  =


    2023-07-19T19:25:37.961104  / # . /lava-11114558/environment/lava-11114=
558/bin/lava-test-runner /lava-11114558/1

    2023-07-19T19:25:37.961752  =


    2023-07-19T19:25:37.967008  / # /lava-11114558/bin/lava-test-runner /la=
va-11114558/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b838b317776a8a478ace1c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b838b317776a8a478ace21
        failing since 112 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-07-19T19:25:33.700926  <8>[   10.530395] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11114527_1.4.2.3.1>

    2023-07-19T19:25:33.704030  + set +x

    2023-07-19T19:25:33.809844  =


    2023-07-19T19:25:33.911602  / # #export SHELL=3D/bin/sh

    2023-07-19T19:25:33.912387  =


    2023-07-19T19:25:34.014063  / # export SHELL=3D/bin/sh. /lava-11114527/=
environment

    2023-07-19T19:25:34.014845  =


    2023-07-19T19:25:34.116566  / # . /lava-11114527/environment/lava-11114=
527/bin/lava-test-runner /lava-11114527/1

    2023-07-19T19:25:34.117703  =


    2023-07-19T19:25:34.123450  / # /lava-11114527/bin/lava-test-runner /la=
va-11114527/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b83ad3b6b2e66bab8ace5e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b83ad3b6b2e66bab8ace63
        failing since 183 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-07-19T19:34:23.055150  <8>[   10.045896] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3723522_1.5.2.4.1>
    2023-07-19T19:34:23.166333  / # #
    2023-07-19T19:34:23.270177  export SHELL=3D/bin/sh
    2023-07-19T19:34:23.271344  #
    2023-07-19T19:34:23.373831  / # export SHELL=3D/bin/sh. /lava-3723522/e=
nvironment
    2023-07-19T19:34:23.374923  =

    2023-07-19T19:34:23.375635  / # . /lava-3723522/environment<3>[   10.35=
2928] Bluetooth: hci0: command 0x0c03 tx timeout
    2023-07-19T19:34:23.478359  /lava-3723522/bin/lava-test-runner /lava-37=
23522/1
    2023-07-19T19:34:23.480021  =

    2023-07-19T19:34:23.484817  / # /lava-3723522/bin/lava-test-runner /lav=
a-3723522/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b83cabb82ffc8be38aceca

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b83cabb82ffc8be38acecd
        failing since 5 days (last pass: v5.15.67, first fail: v5.15.119-16=
-g66130849c020f)

    2023-07-19T19:42:16.263334  [   16.716023] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1237693_1.5.2.4.1>
    2023-07-19T19:42:16.368612  =

    2023-07-19T19:42:16.469774  / # #export SHELL=3D/bin/sh
    2023-07-19T19:42:16.470196  =

    2023-07-19T19:42:16.571159  / # export SHELL=3D/bin/sh. /lava-1237693/e=
nvironment
    2023-07-19T19:42:16.571583  =

    2023-07-19T19:42:16.672545  / # . /lava-1237693/environment/lava-123769=
3/bin/lava-test-runner /lava-1237693/1
    2023-07-19T19:42:16.673251  =

    2023-07-19T19:42:16.677640  / # /lava-1237693/bin/lava-test-runner /lav=
a-1237693/1
    2023-07-19T19:42:16.700690  + export 'TESTRUN_[   17.152121] <LAVA_SIGN=
AL_STARTRUN 1_bootrr 1237693_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b83cbf475b0f2de88ace71

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b83cbf475b0f2de88ace74
        failing since 137 days (last pass: v5.15.79, first fail: v5.15.98)

    2023-07-19T19:42:33.796273  [   10.296861] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1237694_1.5.2.4.1>
    2023-07-19T19:42:33.901913  =

    2023-07-19T19:42:34.003099  / # #export SHELL=3D/bin/sh
    2023-07-19T19:42:34.003515  =

    2023-07-19T19:42:34.104440  / # export SHELL=3D/bin/sh. /lava-1237694/e=
nvironment
    2023-07-19T19:42:34.104851  =

    2023-07-19T19:42:34.205804  / # . /lava-1237694/environment/lava-123769=
4/bin/lava-test-runner /lava-1237694/1
    2023-07-19T19:42:34.206457  =

    2023-07-19T19:42:34.209479  / # /lava-1237694/bin/lava-test-runner /lav=
a-1237694/1
    2023-07-19T19:42:34.226471  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b838b31d90532c788ace3d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b838b31d90532c788ace42
        failing since 112 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-07-19T19:25:26.254430  + <8>[   10.201652] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11114520_1.4.2.3.1>

    2023-07-19T19:25:26.254552  set +x

    2023-07-19T19:25:26.356096  #

    2023-07-19T19:25:26.457032  / # #export SHELL=3D/bin/sh

    2023-07-19T19:25:26.457269  =


    2023-07-19T19:25:26.557829  / # export SHELL=3D/bin/sh. /lava-11114520/=
environment

    2023-07-19T19:25:26.558064  =


    2023-07-19T19:25:26.658649  / # . /lava-11114520/environment/lava-11114=
520/bin/lava-test-runner /lava-11114520/1

    2023-07-19T19:25:26.659012  =


    2023-07-19T19:25:26.663480  / # /lava-11114520/bin/lava-test-runner /la=
va-11114520/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b838b58c3d7d7e498ace1f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b838b58c3d7d7e498ace24
        failing since 112 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-07-19T19:25:17.145176  + set +x

    2023-07-19T19:25:17.151722  <8>[   10.464998] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11114531_1.4.2.3.1>

    2023-07-19T19:25:17.259824  / # #

    2023-07-19T19:25:17.362186  export SHELL=3D/bin/sh

    2023-07-19T19:25:17.362938  #

    2023-07-19T19:25:17.464319  / # export SHELL=3D/bin/sh. /lava-11114531/=
environment

    2023-07-19T19:25:17.465036  =


    2023-07-19T19:25:17.566407  / # . /lava-11114531/environment/lava-11114=
531/bin/lava-test-runner /lava-11114531/1

    2023-07-19T19:25:17.567601  =


    2023-07-19T19:25:17.573186  / # /lava-11114531/bin/lava-test-runner /la=
va-11114531/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b838c617776a8a478ace30

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b838c617776a8a478ace35
        failing since 112 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-07-19T19:25:40.590738  + set<8>[   10.779853] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11114536_1.4.2.3.1>

    2023-07-19T19:25:40.590817   +x

    2023-07-19T19:25:40.695322  / # #

    2023-07-19T19:25:40.795829  export SHELL=3D/bin/sh

    2023-07-19T19:25:40.795968  #

    2023-07-19T19:25:40.896473  / # export SHELL=3D/bin/sh. /lava-11114536/=
environment

    2023-07-19T19:25:40.896641  =


    2023-07-19T19:25:40.997121  / # . /lava-11114536/environment/lava-11114=
536/bin/lava-test-runner /lava-11114536/1

    2023-07-19T19:25:40.997346  =


    2023-07-19T19:25:41.002457  / # /lava-11114536/bin/lava-test-runner /la=
va-11114536/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b83a7e25ef6852c38ace2b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b83a7e25ef6852c38ace30
        failing since 170 days (last pass: v5.15.81-122-gc5f8d4a5d3c8, firs=
t fail: v5.15.90-205-g5605d15db022)

    2023-07-19T19:33:10.677702  + set +x
    2023-07-19T19:33:10.677918  [    9.501691] <LAVA_SIGNAL_ENDRUN 0_dmesg =
995768_1.5.2.3.1>
    2023-07-19T19:33:10.784951  / # #
    2023-07-19T19:33:10.886500  export SHELL=3D/bin/sh
    2023-07-19T19:33:10.886918  #
    2023-07-19T19:33:10.988142  / # export SHELL=3D/bin/sh. /lava-995768/en=
vironment
    2023-07-19T19:33:10.988688  =

    2023-07-19T19:33:11.090111  / # . /lava-995768/environment/lava-995768/=
bin/lava-test-runner /lava-995768/1
    2023-07-19T19:33:11.090688  =

    2023-07-19T19:33:11.093903  / # /lava-995768/bin/lava-test-runner /lava=
-995768/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b838b3ef1dde25668ace4f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-len=
ovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-len=
ovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b838b3ef1dde25668ace54
        failing since 112 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-07-19T19:25:11.293508  <8>[   11.906613] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11114519_1.4.2.3.1>

    2023-07-19T19:25:11.398069  / # #

    2023-07-19T19:25:11.498625  export SHELL=3D/bin/sh

    2023-07-19T19:25:11.498809  #

    2023-07-19T19:25:11.599268  / # export SHELL=3D/bin/sh. /lava-11114519/=
environment

    2023-07-19T19:25:11.599457  =


    2023-07-19T19:25:11.699977  / # . /lava-11114519/environment/lava-11114=
519/bin/lava-test-runner /lava-11114519/1

    2023-07-19T19:25:11.700218  =


    2023-07-19T19:25:11.704827  / # /lava-11114519/bin/lava-test-runner /la=
va-11114519/1

    2023-07-19T19:25:11.710368  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b83c3ae95e9010878ace31

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b83c3ae95e9010878ace36
        new failure (last pass: v5.15.120-274-g478387c57e172)

    2023-07-19T19:42:12.441663  / # #

    2023-07-19T19:42:12.543786  export SHELL=3D/bin/sh

    2023-07-19T19:42:12.544465  #

    2023-07-19T19:42:12.645865  / # export SHELL=3D/bin/sh. /lava-11114634/=
environment

    2023-07-19T19:42:12.646536  =


    2023-07-19T19:42:12.747923  / # . /lava-11114634/environment/lava-11114=
634/bin/lava-test-runner /lava-11114634/1

    2023-07-19T19:42:12.748907  =


    2023-07-19T19:42:12.765960  / # /lava-11114634/bin/lava-test-runner /la=
va-11114634/1

    2023-07-19T19:42:12.814480  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-19T19:42:12.814977  + cd /lav<8>[   15.953293] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11114634_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b83c78694505ae468ace7f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b83c78694505ae468ace84
        new failure (last pass: v5.15.120-274-g478387c57e172)

    2023-07-19T19:41:29.128804  / # #

    2023-07-19T19:41:30.208673  export SHELL=3D/bin/sh

    2023-07-19T19:41:30.210487  #

    2023-07-19T19:41:31.697240  / # export SHELL=3D/bin/sh. /lava-11114639/=
environment

    2023-07-19T19:41:31.698502  =


    2023-07-19T19:41:34.421089  / # . /lava-11114639/environment/lava-11114=
639/bin/lava-test-runner /lava-11114639/1

    2023-07-19T19:41:34.423073  =


    2023-07-19T19:41:34.437500  / # /lava-11114639/bin/lava-test-runner /la=
va-11114639/1

    2023-07-19T19:41:34.496705  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-19T19:41:34.497208  + <8>[   25.521711] <LAVA_SIGNAL_STARTRUN 1=
_bootrr 11114639_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3328-rock64                | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b83c41e95e9010878ace44

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b83c41e95e9010878ace49
        failing since 41 days (last pass: v5.15.72-38-gebe70cd7f5413, first=
 fail: v5.15.114-196-g00621f2608ac)

    2023-07-19T19:40:29.203206  [   16.089593] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3723547_1.5.2.4.1>
    2023-07-19T19:40:29.307348  =

    2023-07-19T19:40:29.307487  / # #[   16.159722] rockchip-drm display-su=
bsystem: [drm] Cannot find any crtc or sizes
    2023-07-19T19:40:29.408799  export SHELL=3D/bin/sh
    2023-07-19T19:40:29.409236  =

    2023-07-19T19:40:29.510599  / # export SHELL=3D/bin/sh. /lava-3723547/e=
nvironment
    2023-07-19T19:40:29.511145  =

    2023-07-19T19:40:29.613007  / # . /lava-3723547/environment/lava-372354=
7/bin/lava-test-runner /lava-3723547/1
    2023-07-19T19:40:29.614233  =

    2023-07-19T19:40:29.617489  / # /lava-3723547/bin/lava-test-runner /lav=
a-3723547/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
stm32mp157c-dk2              | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b83a882b9402bfc78ace2e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-stm32mp157c-dk2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-stm32mp157c-dk2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b83a882b9402bfc78ace33
        failing since 165 days (last pass: v5.15.59, first fail: v5.15.91-2=
1-gd8296a906e7a)

    2023-07-19T19:33:13.652794  <8>[   13.909870] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3723517_1.5.2.4.1>
    2023-07-19T19:33:13.758557  / # #
    2023-07-19T19:33:13.860366  export SHELL=3D/bin/sh
    2023-07-19T19:33:13.861213  #
    2023-07-19T19:33:13.963070  / # export SHELL=3D/bin/sh. /lava-3723517/e=
nvironment
    2023-07-19T19:33:13.963684  =

    2023-07-19T19:33:14.065490  / # . /lava-3723517/environment/lava-372351=
7/bin/lava-test-runner /lava-3723517/1
    2023-07-19T19:33:14.066478  =

    2023-07-19T19:33:14.070891  / # /lava-3723517/bin/lava-test-runner /lav=
a-3723517/1
    2023-07-19T19:33:14.138957  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b83c4899c1fc59d88ace3f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b83c4899c1fc59d88ace44
        new failure (last pass: v5.15.120-274-g478387c57e172)

    2023-07-19T19:40:37.167007  / # #
    2023-07-19T19:40:37.268694  export SHELL=3D/bin/sh
    2023-07-19T19:40:37.269056  #
    2023-07-19T19:40:37.370368  / # export SHELL=3D/bin/sh. /lava-3723548/e=
nvironment
    2023-07-19T19:40:37.370720  =

    2023-07-19T19:40:37.472079  / # . /lava-3723548/environment/lava-372354=
8/bin/lava-test-runner /lava-3723548/1
    2023-07-19T19:40:37.472685  =

    2023-07-19T19:40:37.478185  / # /lava-3723548/bin/lava-test-runner /lav=
a-3723548/1
    2023-07-19T19:40:37.510458  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-19T19:40:37.550157  + cd /lava-3723548<8>[   17.035758] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 3723548_1.5.2.4.5> =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b83c4e7a699edc6a8acecd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b83c4e7a699edc6a8aced2
        new failure (last pass: v5.15.120-274-g478387c57e172)

    2023-07-19T19:42:29.981424  / # #

    2023-07-19T19:42:30.083289  export SHELL=3D/bin/sh

    2023-07-19T19:42:30.084014  #

    2023-07-19T19:42:30.185411  / # export SHELL=3D/bin/sh. /lava-11114629/=
environment

    2023-07-19T19:42:30.186036  =


    2023-07-19T19:42:30.287285  / # . /lava-11114629/environment/lava-11114=
629/bin/lava-test-runner /lava-11114629/1

    2023-07-19T19:42:30.288409  =


    2023-07-19T19:42:30.289710  / # /lava-11114629/bin/lava-test-runner /la=
va-11114629/1

    2023-07-19T19:42:30.363714  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-19T19:42:30.364175  + cd /lava-1111462<8>[   16.878999] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11114629_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
