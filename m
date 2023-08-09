Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDA8776439
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 17:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjHIPmM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 11:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbjHIPmG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 11:42:06 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E5B2113
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 08:42:04 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-686f090310dso6750409b3a.0
        for <stable@vger.kernel.org>; Wed, 09 Aug 2023 08:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691595724; x=1692200524;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Pl9khlnsvKLqQ6pu3H12bEsjoLEmJXsy2NtDCBVZyqk=;
        b=NsWQPXdryrYNuDrvmR6D3GKTYKNP01Yd0oqZ0OII5zxDEfLkH64f1dJq8Vdresly9v
         FoqXaEKNdC3ww4ZLDwlah+rCYVW2j00XqHDUUgpWFDxa7ZzJXchy1ZebRnMZJgBdYEpc
         Q5Vv9abDq6gfKqcK7PTYqgiOBxyiJQpHxYNfRueb0wjth2VdgPuAB8qHs02Ke89G52hp
         cbJwJMnmD5d4z91gwpv+Ku7XBgcTAzx5hUMfABLkwaU6TCQrcSManlnQn87JtZydIxt8
         l/V/ZuzLwIFIWnf+CfFPUhJLQbkBjitneK/sNlw3adqmAPq+5WnfLEh/z6V+vG/CB9MU
         MZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691595724; x=1692200524;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pl9khlnsvKLqQ6pu3H12bEsjoLEmJXsy2NtDCBVZyqk=;
        b=LuJBV93so1ewmDKkaVfxNXbFey9jtkLnhyE8AwYodD+iptFd3aJux7yu3Bnlr0mElW
         2Xr3cFT2u5mROMfFAxpypRidz+pA2ulyoX/kwLd0mfbHSBmtUUYhMDUYWd0LNEVw4cCw
         og3PNhgCoUKlN/p+5qgqPUuCqNMB00BF2PZtdkex5eaumUfGdLoY9SzPUF0w12x6HT+l
         ybk3kNapXKI/5XWFhdGINN5Gv2RN/cSr46oy8MY7+xr9c1Eoz9CYwqHsYxB2kJz30t2j
         prYK7WVegZLzCaKgi2Xu3UwN4dmKIbIUBwiH+jaPhhsn1Rb0F+FRy+qZqy12EuN5UDuS
         lSsQ==
X-Gm-Message-State: AOJu0Yxd+y4aWawbtA6dEEkHrSYUelRcklnOJ9F9rTPeRo+ikScWpKmp
        uCk0RgkMiqmI0+s94uFvLE0NyLUGpD0hgDQkunj/PA==
X-Google-Smtp-Source: AGHT+IHn++JcrbLb44i3ZbzCm2VCws/I4AWH8M0gFg0E9ce+RtVx2JH6JHreOaDhPyEU/gvVcdhcnQ==
X-Received: by 2002:a05:6a00:1a0f:b0:67b:8602:aa1e with SMTP id g15-20020a056a001a0f00b0067b8602aa1emr3477904pfv.28.1691595721726;
        Wed, 09 Aug 2023 08:42:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z29-20020a637e1d000000b00565009a97f0sm4475386pgc.17.2023.08.09.08.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 08:42:00 -0700 (PDT)
Message-ID: <64d3b3c8.630a0220.57328.8be0@mx.google.com>
Date:   Wed, 09 Aug 2023 08:42:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.44-128-g02a4c6c322d1
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-6.1.y
Subject: stable-rc/linux-6.1.y baseline: 109 runs,
 9 regressions (v6.1.44-128-g02a4c6c322d1)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.1.y baseline: 109 runs, 9 regressions (v6.1.44-128-g02a4c=
6c322d1)

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

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.44-128-g02a4c6c322d1/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.44-128-g02a4c6c322d1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      02a4c6c322d10efeb08678f761fcd1710bf2e197 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d382045774a3410135b20e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
128-g02a4c6c322d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-acer-chromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
128-g02a4c6c322d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-acer-chromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d382045774a3410135b=
20f
        new failure (last pass: v6.1.44-117-g74848b090997c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d381f1be53b402d235b1e9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
128-g02a4c6c322d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
128-g02a4c6c322d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d381f1be53b402d235b1ee
        failing since 131 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-09T12:09:38.202649  + set +x

    2023-08-09T12:09:38.209572  <8>[   10.236664] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11244681_1.4.2.3.1>

    2023-08-09T12:09:38.311462  =


    2023-08-09T12:09:38.412063  / # #export SHELL=3D/bin/sh

    2023-08-09T12:09:38.412291  =


    2023-08-09T12:09:38.512794  / # export SHELL=3D/bin/sh. /lava-11244681/=
environment

    2023-08-09T12:09:38.512998  =


    2023-08-09T12:09:38.613507  / # . /lava-11244681/environment/lava-11244=
681/bin/lava-test-runner /lava-11244681/1

    2023-08-09T12:09:38.613792  =


    2023-08-09T12:09:38.620108  / # /lava-11244681/bin/lava-test-runner /la=
va-11244681/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d381edbe53b402d235b1db

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
128-g02a4c6c322d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
128-g02a4c6c322d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d381edbe53b402d235b1e0
        failing since 131 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-09T12:09:01.082171  + set<8>[   11.279551] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11244641_1.4.2.3.1>

    2023-08-09T12:09:01.082280   +x

    2023-08-09T12:09:01.186455  / # #

    2023-08-09T12:09:01.287070  export SHELL=3D/bin/sh

    2023-08-09T12:09:01.287290  #

    2023-08-09T12:09:01.387847  / # export SHELL=3D/bin/sh. /lava-11244641/=
environment

    2023-08-09T12:09:01.388060  =


    2023-08-09T12:09:01.488639  / # . /lava-11244641/environment/lava-11244=
641/bin/lava-test-runner /lava-11244641/1

    2023-08-09T12:09:01.488928  =


    2023-08-09T12:09:01.493391  / # /lava-11244641/bin/lava-test-runner /la=
va-11244641/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d381ef697583df4335b209

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
128-g02a4c6c322d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
128-g02a4c6c322d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d381ef697583df4335b20e
        failing since 131 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-09T12:08:59.621165  <8>[    9.974545] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11244654_1.4.2.3.1>

    2023-08-09T12:08:59.624251  + set +x

    2023-08-09T12:08:59.725944  #

    2023-08-09T12:08:59.726268  =


    2023-08-09T12:08:59.826958  / # #export SHELL=3D/bin/sh

    2023-08-09T12:08:59.827145  =


    2023-08-09T12:08:59.927670  / # export SHELL=3D/bin/sh. /lava-11244654/=
environment

    2023-08-09T12:08:59.927858  =


    2023-08-09T12:09:00.028365  / # . /lava-11244654/environment/lava-11244=
654/bin/lava-test-runner /lava-11244654/1

    2023-08-09T12:09:00.028622  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d37fc557fe483dac35b1e5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
128-g02a4c6c322d1/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
128-g02a4c6c322d1/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d37fc557fe483dac35b=
1e6
        failing since 62 days (last pass: v6.1.31-40-g7d0a9678d276, first f=
ail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d381eb697583df4335b1db

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
128-g02a4c6c322d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
128-g02a4c6c322d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d381eb697583df4335b1e0
        failing since 131 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-09T12:08:46.922240  + set +x

    2023-08-09T12:08:46.929141  <8>[   10.199865] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11244638_1.4.2.3.1>

    2023-08-09T12:08:47.036477  / # #

    2023-08-09T12:08:47.138664  export SHELL=3D/bin/sh

    2023-08-09T12:08:47.139519  #

    2023-08-09T12:08:47.240859  / # export SHELL=3D/bin/sh. /lava-11244638/=
environment

    2023-08-09T12:08:47.241713  =


    2023-08-09T12:08:47.343259  / # . /lava-11244638/environment/lava-11244=
638/bin/lava-test-runner /lava-11244638/1

    2023-08-09T12:08:47.344675  =


    2023-08-09T12:08:47.348922  / # /lava-11244638/bin/lava-test-runner /la=
va-11244638/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d381eab195964f3035b1e8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
128-g02a4c6c322d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
128-g02a4c6c322d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d381eab195964f3035b1ed
        failing since 131 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-09T12:08:58.700137  + set<8>[   11.834383] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11244651_1.4.2.3.1>

    2023-08-09T12:08:58.700221   +x

    2023-08-09T12:08:58.804593  / # #

    2023-08-09T12:08:58.905116  export SHELL=3D/bin/sh

    2023-08-09T12:08:58.905305  #

    2023-08-09T12:08:59.005882  / # export SHELL=3D/bin/sh. /lava-11244651/=
environment

    2023-08-09T12:08:59.006044  =


    2023-08-09T12:08:59.106600  / # . /lava-11244651/environment/lava-11244=
651/bin/lava-test-runner /lava-11244651/1

    2023-08-09T12:08:59.106849  =


    2023-08-09T12:08:59.111602  / # /lava-11244651/bin/lava-test-runner /la=
va-11244651/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d381e4e41eab1d3035b1e7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
128-g02a4c6c322d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
128-g02a4c6c322d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d381e4e41eab1d3035b1ec
        failing since 131 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-09T12:08:36.636436  + set<8>[   12.234584] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11244653_1.4.2.3.1>

    2023-08-09T12:08:36.636556   +x

    2023-08-09T12:08:36.741415  / # #

    2023-08-09T12:08:36.842006  export SHELL=3D/bin/sh

    2023-08-09T12:08:36.842225  #

    2023-08-09T12:08:36.942816  / # export SHELL=3D/bin/sh. /lava-11244653/=
environment

    2023-08-09T12:08:36.943055  =


    2023-08-09T12:08:37.043617  / # . /lava-11244653/environment/lava-11244=
653/bin/lava-test-runner /lava-11244653/1

    2023-08-09T12:08:37.043947  =


    2023-08-09T12:08:37.047855  / # /lava-11244653/bin/lava-test-runner /la=
va-11244653/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d38e835470762d9535b2c2

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
128-g02a4c6c322d1/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
128-g02a4c6c322d1/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d38e835470762d9535b2c7
        failing since 22 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-09T13:04:19.459620  / # #

    2023-08-09T13:04:19.561845  export SHELL=3D/bin/sh

    2023-08-09T13:04:19.562548  #

    2023-08-09T13:04:19.663898  / # export SHELL=3D/bin/sh. /lava-11244427/=
environment

    2023-08-09T13:04:19.664602  =


    2023-08-09T13:04:19.765951  / # . /lava-11244427/environment/lava-11244=
427/bin/lava-test-runner /lava-11244427/1

    2023-08-09T13:04:19.766905  =


    2023-08-09T13:04:19.767905  / # /lava-11244427/bin/lava-test-runner /la=
va-11244427/1

    2023-08-09T13:04:19.831780  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-09T13:04:19.832286  + cd /lav<8>[   19.114868] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11244427_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =20
