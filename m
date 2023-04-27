Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC506F08E8
	for <lists+stable@lfdr.de>; Thu, 27 Apr 2023 18:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244276AbjD0QAF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Apr 2023 12:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244270AbjD0QAD (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Apr 2023 12:00:03 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C6C4C25
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 08:59:58 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-24736992dd3so5656911a91.1
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 08:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682611198; x=1685203198;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xHIA+/aAp2xPY1042GQ+ofZb3IqS9v9dyRlj7z13cHs=;
        b=Xic5Pgig+9PhQmtFcBHcq4VX3cVi1dZfZgyn2xEF59Ea18/kJyw10SjTqG5lex8dYk
         td8tLHiHHgbERrGR6AYche4LZ3gyqH+iMqxgQkmmlXvIETCCKB6HlFb+qq1Rtme+L13G
         h3gsrD5H3WIGAFiCoOSSDuxE5Q7c0WWs2Gl8ksFK9KQPLhp9c1Z9Jvcog8GCAiwhTK9b
         sdEXcny/tNM1EOBfrHX28AlyH7reHFqahLYqDY2b+7uHiAlZuDLMFUUxGPEc4qneVwHr
         dTqDAM68MBaFRhIPttQmsufykMuDD9pIS6HT3ImoHaWkmjiZ5YaVej8DNWm323oNoLy8
         K4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682611198; x=1685203198;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xHIA+/aAp2xPY1042GQ+ofZb3IqS9v9dyRlj7z13cHs=;
        b=jaUi8dDqkoGntN12k2Q+8tvfa34R1NXSSS28t4/NA4euGMazFlw0aqJ5rG4Ae4P41d
         SylQEdbtvB4JuJZ5aQcy5PQr6iRhhsphF0TTlwBfpKmINy22ZQCdz4v8/7husZ3/r7q/
         wutMal1lAsQ0n3DiZG2S1dz080H8omK7EnzethyExKO0sDaT7FEDiNs1iGQ7F0LqDgU4
         I8+PSl6w0jX0JdoGYalxbHrJ9arN4lzNRdQ+UMq/tdnbpq63LozZnmXA8If6Y5EJmrXQ
         BhUdKUeb7KroMSo7mO6koixq6vDBB2Fj04u4vS/YqfxBLZPcvBrkPp9jz3bQyazDbAqI
         Z3Fw==
X-Gm-Message-State: AC+VfDxoXJQ0ZhN9qtA19zdgjPwSOAhC47YowEOh9g2UUWonJt0WDrYI
        9Ps4MigHn96GG5LLJTPOTvOjmXGAWa/etUXQKWk=
X-Google-Smtp-Source: ACHHUZ4ie5aeQpmEaadAliKuyAriBiL23S/71LtefSSWK7r3E2O3fqMhloq70aP5qlBzm0caNthF5Q==
X-Received: by 2002:a17:90a:c302:b0:246:75c8:f071 with SMTP id g2-20020a17090ac30200b0024675c8f071mr2384841pjt.3.1682611197601;
        Thu, 27 Apr 2023 08:59:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a1-20020a17090a688100b002470ce35621sm11416339pjd.20.2023.04.27.08.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 08:59:56 -0700 (PDT)
Message-ID: <644a9bfc.170a0220.64172.6d6c@mx.google.com>
Date:   Thu, 27 Apr 2023 08:59:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.105-354-g3e32bf96dec4
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 168 runs,
 9 regressions (v5.15.105-354-g3e32bf96dec4)
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

stable-rc/queue/5.15 baseline: 168 runs, 9 regressions (v5.15.105-354-g3e32=
bf96dec4)

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
nel/v5.15.105-354-g3e32bf96dec4/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.105-354-g3e32bf96dec4
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      3e32bf96dec451dee57a0c3d3d5e684807f3e837 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a6346e0af4e222d2e85e8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-354-g3e32bf96dec4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-354-g3e32bf96dec4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a6346e0af4e222d2e85ed
        failing since 30 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-04-27T11:57:30.152378  + set +x

    2023-04-27T11:57:30.158986  <8>[   10.560286] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10141992_1.4.2.3.1>

    2023-04-27T11:57:30.263532  / # #

    2023-04-27T11:57:30.364236  export SHELL=3D/bin/sh

    2023-04-27T11:57:30.364463  #

    2023-04-27T11:57:30.465040  / # export SHELL=3D/bin/sh. /lava-10141992/=
environment

    2023-04-27T11:57:30.465249  =


    2023-04-27T11:57:30.565813  / # . /lava-10141992/environment/lava-10141=
992/bin/lava-test-runner /lava-10141992/1

    2023-04-27T11:57:30.566137  =


    2023-04-27T11:57:30.572239  / # /lava-10141992/bin/lava-test-runner /la=
va-10141992/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a63120418b0fd522e85f7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-354-g3e32bf96dec4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-354-g3e32bf96dec4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a63120418b0fd522e85fc
        failing since 30 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-04-27T11:56:40.340695  + set<8>[   10.988708] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10141967_1.4.2.3.1>

    2023-04-27T11:56:40.341342   +x

    2023-04-27T11:56:40.452894  / # #

    2023-04-27T11:56:40.554138  export SHELL=3D/bin/sh

    2023-04-27T11:56:40.555187  #

    2023-04-27T11:56:40.656911  / # export SHELL=3D/bin/sh. /lava-10141967/=
environment

    2023-04-27T11:56:40.657171  =


    2023-04-27T11:56:40.757735  / # . /lava-10141967/environment/lava-10141=
967/bin/lava-test-runner /lava-10141967/1

    2023-04-27T11:56:40.758116  =


    2023-04-27T11:56:40.762598  / # /lava-10141967/bin/lava-test-runner /la=
va-10141967/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a630fd7531b9b1a2e85f3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-354-g3e32bf96dec4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-354-g3e32bf96dec4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a630fd7531b9b1a2e85f8
        failing since 30 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-04-27T11:56:37.061316  <8>[    7.893809] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10141930_1.4.2.3.1>

    2023-04-27T11:56:37.064530  + set +x

    2023-04-27T11:56:37.165877  =


    2023-04-27T11:56:37.266435  / # #export SHELL=3D/bin/sh

    2023-04-27T11:56:37.266630  =


    2023-04-27T11:56:37.367130  / # export SHELL=3D/bin/sh. /lava-10141930/=
environment

    2023-04-27T11:56:37.367326  =


    2023-04-27T11:56:37.467857  / # . /lava-10141930/environment/lava-10141=
930/bin/lava-test-runner /lava-10141930/1

    2023-04-27T11:56:37.468150  =


    2023-04-27T11:56:37.473070  / # /lava-10141930/bin/lava-test-runner /la=
va-10141930/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/644a672a04c1f141912e8602

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-354-g3e32bf96dec4/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-354-g3e32bf96dec4/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644a672a04c1f141912e8=
603
        failing since 83 days (last pass: v5.15.91-12-g3290f78df1ab, first =
fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644a6508dd33d206b52e860a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-354-g3e32bf96dec4/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-354-g3e32bf96dec4/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a6508dd33d206b52e860f
        failing since 100 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-04-27T12:05:02.691607  <8>[    9.993114] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3537113_1.5.2.4.1>
    2023-04-27T12:05:02.802021  / # #
    2023-04-27T12:05:02.905593  export SHELL=3D/bin/sh
    2023-04-27T12:05:02.906887  #
    2023-04-27T12:05:03.009663  / # export SHELL=3D/bin/sh. /lava-3537113/e=
nvironment
    2023-04-27T12:05:03.010891  =

    2023-04-27T12:05:03.113209  / # . /lava-3537113/environment/lava-353711=
3/bin/lava-test-runner /lava-3537113/1
    2023-04-27T12:05:03.114930  =

    2023-04-27T12:05:03.119505  / # /lava-3537113/bin/lava-test-runner /lav=
a-3537113/1
    2023-04-27T12:05:03.212167  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a6308ed2273334a2e860e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-354-g3e32bf96dec4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-354-g3e32bf96dec4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a6308ed2273334a2e8613
        failing since 30 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-04-27T11:56:45.582147  + set +x

    2023-04-27T11:56:45.588539  <8>[    7.894638] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10141987_1.4.2.3.1>

    2023-04-27T11:56:45.693363  / # #

    2023-04-27T11:56:45.794042  export SHELL=3D/bin/sh

    2023-04-27T11:56:45.794277  #

    2023-04-27T11:56:45.894826  / # export SHELL=3D/bin/sh. /lava-10141987/=
environment

    2023-04-27T11:56:45.895055  =


    2023-04-27T11:56:45.995647  / # . /lava-10141987/environment/lava-10141=
987/bin/lava-test-runner /lava-10141987/1

    2023-04-27T11:56:45.995972  =


    2023-04-27T11:56:46.000697  / # /lava-10141987/bin/lava-test-runner /la=
va-10141987/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a6307dfe8d109c42e860f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-354-g3e32bf96dec4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-354-g3e32bf96dec4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a6307dfe8d109c42e8614
        failing since 30 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-04-27T11:56:40.083481  <8>[   10.854764] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10141993_1.4.2.3.1>

    2023-04-27T11:56:40.087351  + set +x

    2023-04-27T11:56:40.188916  #

    2023-04-27T11:56:40.289827  / # #export SHELL=3D/bin/sh

    2023-04-27T11:56:40.290061  =


    2023-04-27T11:56:40.390610  / # export SHELL=3D/bin/sh. /lava-10141993/=
environment

    2023-04-27T11:56:40.390848  =


    2023-04-27T11:56:40.491450  / # . /lava-10141993/environment/lava-10141=
993/bin/lava-test-runner /lava-10141993/1

    2023-04-27T11:56:40.491743  =


    2023-04-27T11:56:40.496770  / # /lava-10141993/bin/lava-test-runner /la=
va-10141993/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a630fd7531b9b1a2e85e8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-354-g3e32bf96dec4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-354-g3e32bf96dec4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a630fd7531b9b1a2e85ed
        failing since 30 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-04-27T11:56:40.545170  + set +x<8>[    8.548497] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10141968_1.4.2.3.1>

    2023-04-27T11:56:40.545254  =


    2023-04-27T11:56:40.649702  / # #

    2023-04-27T11:56:40.750310  export SHELL=3D/bin/sh

    2023-04-27T11:56:40.750506  #

    2023-04-27T11:56:40.851093  / # export SHELL=3D/bin/sh. /lava-10141968/=
environment

    2023-04-27T11:56:40.851310  =


    2023-04-27T11:56:40.951821  / # . /lava-10141968/environment/lava-10141=
968/bin/lava-test-runner /lava-10141968/1

    2023-04-27T11:56:40.952116  =


    2023-04-27T11:56:40.956950  / # /lava-10141968/bin/lava-test-runner /la=
va-10141968/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a62fd6f7235d3f22e864b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-354-g3e32bf96dec4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-354-g3e32bf96dec4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a62fd6f7235d3f22e8650
        failing since 30 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-04-27T11:56:31.223966  + <8>[   11.781384] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10141961_1.4.2.3.1>

    2023-04-27T11:56:31.224098  set +x

    2023-04-27T11:56:31.328511  / # #

    2023-04-27T11:56:31.429108  export SHELL=3D/bin/sh

    2023-04-27T11:56:31.429300  #

    2023-04-27T11:56:31.529873  / # export SHELL=3D/bin/sh. /lava-10141961/=
environment

    2023-04-27T11:56:31.530095  =


    2023-04-27T11:56:31.630644  / # . /lava-10141961/environment/lava-10141=
961/bin/lava-test-runner /lava-10141961/1

    2023-04-27T11:56:31.630972  =


    2023-04-27T11:56:31.635899  / # /lava-10141961/bin/lava-test-runner /la=
va-10141961/1
 =

    ... (12 line(s) more)  =

 =20
