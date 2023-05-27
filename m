Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D2D71314A
	for <lists+stable@lfdr.de>; Sat, 27 May 2023 03:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237211AbjE0BHh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 26 May 2023 21:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjE0BHg (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 26 May 2023 21:07:36 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4511BC
        for <stable@vger.kernel.org>; Fri, 26 May 2023 18:07:27 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-534696e4e0aso855792a12.0
        for <stable@vger.kernel.org>; Fri, 26 May 2023 18:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685149647; x=1687741647;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9MDwhNhGuXjKundYbLKmabPxc2i/QJz9+NNvYrzwmug=;
        b=oT66OTcZyFn08halhfS8zOTH0UboPaBVen5pKfYg73rb3kpOidDIrlO74ZcIOGW1Zj
         a41+CJxXoePHjkq1OcasY4rZvXlJHZVniac8RmSqKWkeQGe5Rv4E8YrMMz61KmQGtZCH
         PAhJeOBDT/0EIX8ZlNAaUaA7id0I3jUf5RrBGrm4SIpG/DJ7aXM9ab4eu9Z0CJU9iVNr
         nFNvsWhCZRsusIndAPojkjeXQ5/EZz8AEr5TfaICseqnnjKi+G35Zlww8GJ61u7/T90k
         FIKe1C7+eMaPjCm3xnhQCZn+8J/Yt3nQ3/n5uno09u6FgyOgkyMawp5QhJtcwMDF8Bz8
         ghiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685149647; x=1687741647;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9MDwhNhGuXjKundYbLKmabPxc2i/QJz9+NNvYrzwmug=;
        b=IsVXeB5m0wWYAdein3FioE0RYimgNN2kRhjCLnhxQF0X9l1Ql9LjByIK4r3qm2nmv2
         bxDfj9hJe0/FS/z3Akye03Ll+7NGeky5j0e1o3X6Jfsfkvr7HI5g4slaAqsiKDXlbTiF
         KupMvPKfkvuZJTUugn+5HlNvz8aySdyTFSfvQU1X3yGyZMVRb6SLUqGNrKY1UUU4SVA7
         Ec7jYoehpBNbgwmkij71hcT/jRWMOCMf85GaLvq+F55ZYZwAgrKnBcH/87NLA14TiFI6
         RM5IOfsfY23fpzzeTE0N2n7PHzZ4MWCz5Xq+Xg+7XsqbilNqIteG733QtB/ewKz1Jg5e
         hoSA==
X-Gm-Message-State: AC+VfDx8VVvZAl3knTzzKEaWzQdzkmcSOIIuPiM7MihwwaW5YX7or/L6
        oUQ82ED07NreQtrmEsfPvW0bLlTq0NqUEmVIWwhn0w==
X-Google-Smtp-Source: ACHHUZ68V1+Pa0f/uvyKDiS3Rewtu/pw66b3MJR6tyq+IrAkXOEO2uJ6S1mCUwwbv2iwzJmi6lg2tA==
X-Received: by 2002:a17:903:41d0:b0:1b0:e0a:b7ab with SMTP id u16-20020a17090341d000b001b00e0ab7abmr4876043ple.31.1685149646566;
        Fri, 26 May 2023 18:07:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902bd4b00b001ab2b415bdbsm3799334plx.45.2023.05.26.18.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 18:07:26 -0700 (PDT)
Message-ID: <647157ce.170a0220.bcf10.8ebb@mx.google.com>
Date:   Fri, 26 May 2023 18:07:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.112-223-g2be1bc05e2ff
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 166 runs,
 8 regressions (v5.15.112-223-g2be1bc05e2ff)
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

stable-rc/queue/5.15 baseline: 166 runs, 8 regressions (v5.15.112-223-g2be1=
bc05e2ff)

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


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.112-223-g2be1bc05e2ff/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.112-223-g2be1bc05e2ff
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      2be1bc05e2ff350a17fa4145266d99840e11eecd =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647120a39e65e161042e85f6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-223-g2be1bc05e2ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-223-g2be1bc05e2ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647120a39e65e161042e85fb
        failing since 59 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-26T21:11:45.528069  + set<8>[   11.176326] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10473038_1.4.2.3.1>

    2023-05-26T21:11:45.528574   +x

    2023-05-26T21:11:45.636637  / # #

    2023-05-26T21:11:45.739023  export SHELL=3D/bin/sh

    2023-05-26T21:11:45.739256  #

    2023-05-26T21:11:45.839939  / # export SHELL=3D/bin/sh. /lava-10473038/=
environment

    2023-05-26T21:11:45.840919  =


    2023-05-26T21:11:45.942535  / # . /lava-10473038/environment/lava-10473=
038/bin/lava-test-runner /lava-10473038/1

    2023-05-26T21:11:45.943759  =


    2023-05-26T21:11:45.948535  / # /lava-10473038/bin/lava-test-runner /la=
va-10473038/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647120a1e37b43e0ee2e8656

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-223-g2be1bc05e2ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-223-g2be1bc05e2ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647120a1e37b43e0ee2e865b
        failing since 59 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-26T21:11:44.582443  <8>[   10.191834] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10473017_1.4.2.3.1>

    2023-05-26T21:11:44.586164  + set +x

    2023-05-26T21:11:44.692105  =


    2023-05-26T21:11:44.794179  / # #export SHELL=3D/bin/sh

    2023-05-26T21:11:44.795014  =


    2023-05-26T21:11:44.896564  / # export SHELL=3D/bin/sh. /lava-10473017/=
environment

    2023-05-26T21:11:44.897324  =


    2023-05-26T21:11:44.998932  / # . /lava-10473017/environment/lava-10473=
017/bin/lava-test-runner /lava-10473017/1

    2023-05-26T21:11:45.000165  =


    2023-05-26T21:11:45.005318  / # /lava-10473017/bin/lava-test-runner /la=
va-10473017/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6471245df221fe49a92e85fc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-223-g2be1bc05e2ff/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-223-g2be1bc05e2ff/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6471245df221fe49a92e8=
5fd
        failing since 112 days (last pass: v5.15.91-12-g3290f78df1ab, first=
 fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64712473f221fe49a92e86bd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-223-g2be1bc05e2ff/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-223-g2be1bc05e2ff/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64712473f221fe49a92e86c2
        failing since 129 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-26T21:27:59.753803  <8>[   10.032702] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3621169_1.5.2.4.1>
    2023-05-26T21:27:59.865312  / # #
    2023-05-26T21:27:59.968737  export SHELL=3D/bin/sh
    2023-05-26T21:27:59.969647  #
    2023-05-26T21:28:00.071559  / # export SHELL=3D/bin/sh. /lava-3621169/e=
nvironment
    2023-05-26T21:28:00.072531  =

    2023-05-26T21:28:00.174619  / # . /lava-3621169/environment/lava-362116=
9/bin/lava-test-runner /lava-3621169/1
    2023-05-26T21:28:00.176377  =

    2023-05-26T21:28:00.180986  / # /lava-3621169/bin/lava-test-runner /lav=
a-3621169/1
    2023-05-26T21:28:00.273994  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647120dbbe6f85fc9e2e8617

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-223-g2be1bc05e2ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-223-g2be1bc05e2ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647120dbbe6f85fc9e2e861c
        failing since 59 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-26T21:12:43.883482  + <8>[   10.459151] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10473018_1.4.2.3.1>

    2023-05-26T21:12:43.883721  set +x

    2023-05-26T21:12:43.986434  =


    2023-05-26T21:12:44.087098  / # #export SHELL=3D/bin/sh

    2023-05-26T21:12:44.087428  =


    2023-05-26T21:12:44.188062  / # export SHELL=3D/bin/sh. /lava-10473018/=
environment

    2023-05-26T21:12:44.188290  =


    2023-05-26T21:12:44.288863  / # . /lava-10473018/environment/lava-10473=
018/bin/lava-test-runner /lava-10473018/1

    2023-05-26T21:12:44.289201  =


    2023-05-26T21:12:44.293908  / # /lava-10473018/bin/lava-test-runner /la=
va-10473018/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647120934b1d38b02d2e8662

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-223-g2be1bc05e2ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-223-g2be1bc05e2ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647120934b1d38b02d2e8667
        failing since 59 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-26T21:11:39.373788  <8>[   11.066868] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10473056_1.4.2.3.1>

    2023-05-26T21:11:39.377003  + set +x

    2023-05-26T21:11:39.481470  / # #

    2023-05-26T21:11:39.582052  export SHELL=3D/bin/sh

    2023-05-26T21:11:39.582243  #

    2023-05-26T21:11:39.682725  / # export SHELL=3D/bin/sh. /lava-10473056/=
environment

    2023-05-26T21:11:39.682940  =


    2023-05-26T21:11:39.783437  / # . /lava-10473056/environment/lava-10473=
056/bin/lava-test-runner /lava-10473056/1

    2023-05-26T21:11:39.783722  =


    2023-05-26T21:11:39.788205  / # /lava-10473056/bin/lava-test-runner /la=
va-10473056/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647120a07e1b3f15d52e85f2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-223-g2be1bc05e2ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-223-g2be1bc05e2ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647120a07e1b3f15d52e85f7
        failing since 59 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-26T21:11:36.274194  + <8>[   11.302786] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10473066_1.4.2.3.1>

    2023-05-26T21:11:36.274301  set +x

    2023-05-26T21:11:36.378016  / # #

    2023-05-26T21:11:36.478623  export SHELL=3D/bin/sh

    2023-05-26T21:11:36.478820  #

    2023-05-26T21:11:36.579304  / # export SHELL=3D/bin/sh. /lava-10473066/=
environment

    2023-05-26T21:11:36.579509  =


    2023-05-26T21:11:36.680130  / # . /lava-10473066/environment/lava-10473=
066/bin/lava-test-runner /lava-10473066/1

    2023-05-26T21:11:36.680457  =


    2023-05-26T21:11:36.685292  / # /lava-10473066/bin/lava-test-runner /la=
va-10473066/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647120868ba7189da92e8677

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-223-g2be1bc05e2ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-223-g2be1bc05e2ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647120868ba7189da92e867c
        failing since 59 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-26T21:11:17.070288  + set<8>[    9.135744] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10473030_1.4.2.3.1>

    2023-05-26T21:11:17.070812   +x

    2023-05-26T21:11:17.178308  / # #

    2023-05-26T21:11:17.280582  export SHELL=3D/bin/sh

    2023-05-26T21:11:17.280776  #

    2023-05-26T21:11:17.381338  / # export SHELL=3D/bin/sh. /lava-10473030/=
environment

    2023-05-26T21:11:17.382205  =


    2023-05-26T21:11:17.483932  / # . /lava-10473030/environment/lava-10473=
030/bin/lava-test-runner /lava-10473030/1

    2023-05-26T21:11:17.485347  =


    2023-05-26T21:11:17.490006  / # /lava-10473030/bin/lava-test-runner /la=
va-10473030/1
 =

    ... (12 line(s) more)  =

 =20
