Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539B06FFB0F
	for <lists+stable@lfdr.de>; Thu, 11 May 2023 22:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239034AbjEKUIK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 11 May 2023 16:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238915AbjEKUIJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 11 May 2023 16:08:09 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4BD10EC
        for <stable@vger.kernel.org>; Thu, 11 May 2023 13:08:07 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1aaf91ae451so85125665ad.1
        for <stable@vger.kernel.org>; Thu, 11 May 2023 13:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683835686; x=1686427686;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QHFmzkHu9nTrsroH613EQcwiouD8vTVHY9a+h0boMzA=;
        b=FQFX9x3Vmm2DJ3vxEW5u5nxvUSP1bJgM9y6dSg6RroIeZGBHcTvygl41tFOgOi/hOs
         7B6g5eSw4qkVzNNz9R6WKXAgj1B6sVaWBXJMme5Hc+9N5TU7/sOt1z9GeyeDblT58sCu
         Wjovlw0e/XpVpkOGuUiul69pj08LRTF5u1SxcLPDP6QHEWEiYIT2uH+1Cdcu8gWHqo3I
         5Oq4BXm06Qz/Do21PxovapshBNfp7FezFOP/9ke02jyHEpXbJxXMpr7+4SCzqUR42ZVh
         mQ3duD3F3dLIVEWfalf0pfjTs3+4cd9elvSsIsbc04kIHNcfOP31NWL/x8Da5oc/qwMW
         CneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683835686; x=1686427686;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QHFmzkHu9nTrsroH613EQcwiouD8vTVHY9a+h0boMzA=;
        b=CVURTN8yVeTl7fS8J1yzVzpyeaXvxgLYMAbI4n5VeW7pMdIl23prJMbTa35n7vXaMm
         3cAPKDDPj4cT+EsnYFoHhUUoklncnSQef87HfJckTy9Kpuq2xSx/H5Um4GVFN5Y/0VqL
         cZDMnVho0xCAuHEgwmBV6CV2+5b9dcxcQPTJxvnNWYqLK0I9ITF9vKMDfq4hQllJdgw4
         sb9zPhxTbekr1Hbcr0Iij7zXqwWxxytcJz8qgT17wjH50mjfOyYCeewjtirRUwv91SIr
         WtPPwQ8UTX2F7e7xJKnrbHCVytYp9cQTXkHMQb/ogMa7cspUGsFmSgXHxboD9GffskmU
         KMeg==
X-Gm-Message-State: AC+VfDw2mauE6f4WDazDVNLqKs3zizvQ+88WDgagCNommWtdQqHpzf7e
        /U3tzxLBxZACSeKPPedve2r4NHc8O99exJFJcet9dg==
X-Google-Smtp-Source: ACHHUZ7yEQsvE3yhLqI9Z1V4mgVG4tAeC0g+B9TvUnpJrfnCWBTqTiviOC/fkZz+q3qLqS6JyxKpQw==
X-Received: by 2002:a17:902:b110:b0:1aa:f6ed:973d with SMTP id q16-20020a170902b11000b001aaf6ed973dmr19525596plr.55.1683835686427;
        Thu, 11 May 2023 13:08:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d23-20020a170902729700b001a3d041ca71sm6336435pll.275.2023.05.11.13.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 13:08:05 -0700 (PDT)
Message-ID: <645d4b25.170a0220.d335b.c450@mx.google.com>
Date:   Thu, 11 May 2023 13:08:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable
X-Kernelci-Kernel: v6.1.28
X-Kernelci-Report-Type: test
Subject: stable/linux-6.1.y baseline: 176 runs, 10 regressions (v6.1.28)
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

stable/linux-6.1.y baseline: 176 runs, 10 regressions (v6.1.28)

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

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-6.1.y/kernel/=
v6.1.28/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-6.1.y
  Describe: v6.1.28
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      bf4ad6fa4e5332e53913b073d0219319a4091619 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d18e2c2188ae1e72e8631

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.28/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.28/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d18e2c2188ae1e72e8636
        failing since 42 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-11T16:33:15.797344  + set +x

    2023-05-11T16:33:15.803979  <8>[   10.232259] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10285230_1.4.2.3.1>

    2023-05-11T16:33:15.908229  / # #

    2023-05-11T16:33:16.008885  export SHELL=3D/bin/sh

    2023-05-11T16:33:16.009077  #

    2023-05-11T16:33:16.109620  / # export SHELL=3D/bin/sh. /lava-10285230/=
environment

    2023-05-11T16:33:16.109831  =


    2023-05-11T16:33:16.210383  / # . /lava-10285230/environment/lava-10285=
230/bin/lava-test-runner /lava-10285230/1

    2023-05-11T16:33:16.210685  =


    2023-05-11T16:33:16.216011  / # /lava-10285230/bin/lava-test-runner /la=
va-10285230/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d17da4f702a6bb02e863d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.28/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.28/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d17da4f702a6bb02e8642
        failing since 42 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-11T16:28:52.160970  + set<8>[    9.080561] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10285232_1.4.2.3.1>

    2023-05-11T16:28:52.161428   +x

    2023-05-11T16:28:52.268890  / # #

    2023-05-11T16:28:52.371067  export SHELL=3D/bin/sh

    2023-05-11T16:28:52.371324  #

    2023-05-11T16:28:52.471922  / # export SHELL=3D/bin/sh. /lava-10285232/=
environment

    2023-05-11T16:28:52.472168  =


    2023-05-11T16:28:52.572743  / # . /lava-10285232/environment/lava-10285=
232/bin/lava-test-runner /lava-10285232/1

    2023-05-11T16:28:52.573020  =


    2023-05-11T16:28:52.578212  / # /lava-10285232/bin/lava-test-runner /la=
va-10285232/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d17ed8808876e5a2e867d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.28/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.28/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d17ed8808876e5a2e8682
        failing since 42 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-11T16:29:10.895645  <8>[   10.996930] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10285277_1.4.2.3.1>

    2023-05-11T16:29:10.899258  + set +x

    2023-05-11T16:29:11.000835  =


    2023-05-11T16:29:11.101490  / # #export SHELL=3D/bin/sh

    2023-05-11T16:29:11.101702  =


    2023-05-11T16:29:11.202280  / # export SHELL=3D/bin/sh. /lava-10285277/=
environment

    2023-05-11T16:29:11.202462  =


    2023-05-11T16:29:11.303045  / # . /lava-10285277/environment/lava-10285=
277/bin/lava-test-runner /lava-10285277/1

    2023-05-11T16:29:11.303399  =


    2023-05-11T16:29:11.308539  / # /lava-10285277/bin/lava-test-runner /la=
va-10285277/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d17b9dde356bb642e85ed

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.28/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.28/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d17b9dde356bb642e85f2
        failing since 42 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-11T16:28:34.807691  + set +x

    2023-05-11T16:28:34.813632  <8>[   10.822074] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10285220_1.4.2.3.1>

    2023-05-11T16:28:34.918283  / # #

    2023-05-11T16:28:35.018913  export SHELL=3D/bin/sh

    2023-05-11T16:28:35.019103  #

    2023-05-11T16:28:35.119667  / # export SHELL=3D/bin/sh. /lava-10285220/=
environment

    2023-05-11T16:28:35.119917  =


    2023-05-11T16:28:35.220436  / # . /lava-10285220/environment/lava-10285=
220/bin/lava-test-runner /lava-10285220/1

    2023-05-11T16:28:35.220723  =


    2023-05-11T16:28:35.224789  / # /lava-10285220/bin/lava-test-runner /la=
va-10285220/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d17dbff2e42b79c2e85fa

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.28/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.28/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d17dbff2e42b79c2e85ff
        failing since 42 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-11T16:28:50.836559  <8>[    8.087470] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10285279_1.4.2.3.1>

    2023-05-11T16:28:50.840284  + set +x

    2023-05-11T16:28:50.941836  #

    2023-05-11T16:28:50.942318  =


    2023-05-11T16:28:51.043282  / # #export SHELL=3D/bin/sh

    2023-05-11T16:28:51.044054  =


    2023-05-11T16:28:51.145470  / # export SHELL=3D/bin/sh. /lava-10285279/=
environment

    2023-05-11T16:28:51.146218  =


    2023-05-11T16:28:51.247736  / # . /lava-10285279/environment/lava-10285=
279/bin/lava-test-runner /lava-10285279/1

    2023-05-11T16:28:51.248973  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d17e44ececcf2422e860f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.28/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.28/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d17e44ececcf2422e8614
        failing since 42 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-11T16:29:00.310307  + set +x<8>[   11.908995] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10285273_1.4.2.3.1>

    2023-05-11T16:29:00.310520  =


    2023-05-11T16:29:00.416152  / # #

    2023-05-11T16:29:00.516949  export SHELL=3D/bin/sh

    2023-05-11T16:29:00.517157  #

    2023-05-11T16:29:00.617677  / # export SHELL=3D/bin/sh. /lava-10285273/=
environment

    2023-05-11T16:29:00.617919  =


    2023-05-11T16:29:00.718536  / # . /lava-10285273/environment/lava-10285=
273/bin/lava-test-runner /lava-10285273/1

    2023-05-11T16:29:00.718879  =


    2023-05-11T16:29:00.723320  / # /lava-10285273/bin/lava-test-runner /la=
va-10285273/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d17c5dde356bb642e8649

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.28/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.28/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d17c5dde356bb642e864e
        failing since 42 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-11T16:28:41.681049  <8>[   11.959340] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10285226_1.4.2.3.1>

    2023-05-11T16:28:41.786127  / # #

    2023-05-11T16:28:41.886807  export SHELL=3D/bin/sh

    2023-05-11T16:28:41.887048  #

    2023-05-11T16:28:41.987565  / # export SHELL=3D/bin/sh. /lava-10285226/=
environment

    2023-05-11T16:28:41.987819  =


    2023-05-11T16:28:42.088359  / # . /lava-10285226/environment/lava-10285=
226/bin/lava-test-runner /lava-10285226/1

    2023-05-11T16:28:42.088648  =


    2023-05-11T16:28:42.093180  / # /lava-10285226/bin/lava-test-runner /la=
va-10285226/1

    2023-05-11T16:28:42.099966  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/645d1539359197a2242e85f7

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.28/arm=
64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui-ja=
cuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.28/arm=
64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui-ja=
cuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/645d1539359197a2242e8613
        new failure (last pass: v6.1.27)

    2023-05-11T16:17:49.362761  <8>[   21.965550] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-driver-present RESULT=3Dpass>

    2023-05-11T16:17:50.379883  /lava-10285129/1/../bin/lava-test-case

    2023-05-11T16:17:50.386247  <8>[   22.992506] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d153a359197a2242e869f
        new failure (last pass: v6.1.27)

    2023-05-11T16:17:44.917503  + set +x

    2023-05-11T16:17:44.923917  <8>[   17.528870] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10285129_1.5.2.3.1>

    2023-05-11T16:17:45.034876  / # #

    2023-05-11T16:17:45.137151  export SHELL=3D/bin/sh

    2023-05-11T16:17:45.137888  #

    2023-05-11T16:17:45.239268  / # export SHELL=3D/bin/sh. /lava-10285129/=
environment

    2023-05-11T16:17:45.239900  =


    2023-05-11T16:17:45.341277  / # . /lava-10285129/environment/lava-10285=
129/bin/lava-test-runner /lava-10285129/1

    2023-05-11T16:17:45.342560  =


    2023-05-11T16:17:45.347906  / # /lava-10285129/bin/lava-test-runner /la=
va-10285129/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/645d160cd69d9420612e85f0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.28/mip=
s/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.28/mip=
s/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645d160cd69d9420612e8=
5f1
        new failure (last pass: v6.1.27) =

 =20
