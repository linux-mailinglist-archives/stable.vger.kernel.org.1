Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86536F9154
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 12:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjEFKzh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 06:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjEFKzg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 06:55:36 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2056A559B
        for <stable@vger.kernel.org>; Sat,  6 May 2023 03:55:32 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-643b60855c8so596014b3a.2
        for <stable@vger.kernel.org>; Sat, 06 May 2023 03:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683370531; x=1685962531;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pH2Jy7A2lvNRiH3/RY4nibdKZFXbWtBDAufCncjkZ2A=;
        b=Bxtx5GWNxFyIfaeBhSsqsPnNMGtmXtaahveC/E/9ziKTBLEmMOlq/tsYwvMB/1fCEI
         9V5OMUXAVX8PuXg9zd9bVaAtA1rhgJ5zg74X7KRFnb6gzykio5bqibR3KAXiS+20YLbX
         7U3pT0w+BaAQCoJ2QC+ebLTNhXKv3L9x8Y+corF490uLwz1d2GLhsWzwr1d4VuL0JQMa
         xYHvLzCCCgU0nc3pAFb2p4kZlzMQXHhiAALKPybKYZZkh5lE+C3iff/96e9OZz3BCPFM
         hhMzGqN3OVngXw/Jd1PcEuVeLLR+Wy3f2P9oXWPe23zWYcBLgNychHHvFDm4zMaDIkfV
         Inew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683370531; x=1685962531;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pH2Jy7A2lvNRiH3/RY4nibdKZFXbWtBDAufCncjkZ2A=;
        b=gpDApuQwb5s7fjZkaYS2YuMSXKtpBBW1iizQ47a5pC9uqPKh9lbFUuJlAhJg95GRHL
         7NU7kB3CBS8FAtQhjaJU+fQF/Hf29qEZ5VN4joy/kwTWlkDLsPwHDi/V1cjSqV4jcpO+
         onugTEuHPHOskGFtu0mkPGv+O7KAuYEJdKYIJYAejRGECt0VFY0n+j4HKkUyozY/6XL0
         XFMngcnQE+e+IUYEvNSXI+8SkgAZWx9Gy3eGLYU+RttXZDesp1Jo+1iGPoy9f4lZKtOH
         QqwFsqXgZmmlaQ4YcJaQN9YY0GLozAg7GNwnEyyzbbph/8TYnuL1O5Q8yRp1Ivw77oA8
         os/w==
X-Gm-Message-State: AC+VfDzYU7V37jI+6cay9wFg6Ej/myb9N/eiQMjfbS8JjXrwX7BfGgQk
        9Ga9LuvgHjv+iU2iWcfVBILQLwwhYaTxJsmipXMN/A==
X-Google-Smtp-Source: ACHHUZ674PNY3AtXiXi05Q/PIf2kwIV1zUNx466OJ1tv8jYdkdoaQVHkObMqUEIp6mUI5hx+K5y1qg==
X-Received: by 2002:a05:6a00:ad0:b0:63b:8a91:e641 with SMTP id c16-20020a056a000ad000b0063b8a91e641mr6063629pfl.11.1683370531187;
        Sat, 06 May 2023 03:55:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v15-20020aa7808f000000b0063d3fbf4783sm2966580pff.80.2023.05.06.03.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 03:55:30 -0700 (PDT)
Message-ID: <64563222.a70a0220.c29ae.61b7@mx.google.com>
Date:   Sat, 06 May 2023 03:55:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.105-406-g93046c7116de
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 122 runs,
 7 regressions (v5.15.105-406-g93046c7116de)
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

stable-rc/queue/5.15 baseline: 122 runs, 7 regressions (v5.15.105-406-g9304=
6c7116de)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

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


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.105-406-g93046c7116de/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.105-406-g93046c7116de
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      93046c7116deca2d6eea8bd04b0728eba54ffd15 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6455fb2768a2bb06e22e861e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-406-g93046c7116de/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-406-g93046c7116de/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6455fb2768a2bb06e22e8623
        failing since 38 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-06T07:00:33.001185  + set<8>[   11.153963] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10213492_1.4.2.3.1>

    2023-05-06T07:00:33.001273   +x

    2023-05-06T07:00:33.104858  / # #

    2023-05-06T07:00:33.205465  export SHELL=3D/bin/sh

    2023-05-06T07:00:33.205652  #

    2023-05-06T07:00:33.306177  / # export SHELL=3D/bin/sh. /lava-10213492/=
environment

    2023-05-06T07:00:33.306379  =


    2023-05-06T07:00:33.406928  / # . /lava-10213492/environment/lava-10213=
492/bin/lava-test-runner /lava-10213492/1

    2023-05-06T07:00:33.407224  =


    2023-05-06T07:00:33.412086  / # /lava-10213492/bin/lava-test-runner /la=
va-10213492/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6455fb32859598becf2e8628

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-406-g93046c7116de/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-406-g93046c7116de/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6455fb32859598becf2e862d
        failing since 38 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-06T07:00:44.450668  <8>[   10.578884] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10213514_1.4.2.3.1>

    2023-05-06T07:00:44.453821  + set +x

    2023-05-06T07:00:44.555539  =


    2023-05-06T07:00:44.656211  / # #export SHELL=3D/bin/sh

    2023-05-06T07:00:44.656407  =


    2023-05-06T07:00:44.756966  / # export SHELL=3D/bin/sh. /lava-10213514/=
environment

    2023-05-06T07:00:44.757165  =


    2023-05-06T07:00:44.857680  / # . /lava-10213514/environment/lava-10213=
514/bin/lava-test-runner /lava-10213514/1

    2023-05-06T07:00:44.858057  =


    2023-05-06T07:00:44.862867  / # /lava-10213514/bin/lava-test-runner /la=
va-10213514/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6455fb1968a2bb06e22e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-406-g93046c7116de/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-406-g93046c7116de/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6455fb1968a2bb06e22e85eb
        failing since 38 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-06T07:00:30.823922  + set +x

    2023-05-06T07:00:30.830916  <8>[   10.454239] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10213455_1.4.2.3.1>

    2023-05-06T07:00:30.935300  / # #

    2023-05-06T07:00:31.035964  export SHELL=3D/bin/sh

    2023-05-06T07:00:31.036154  #

    2023-05-06T07:00:31.136678  / # export SHELL=3D/bin/sh. /lava-10213455/=
environment

    2023-05-06T07:00:31.136864  =


    2023-05-06T07:00:31.237493  / # . /lava-10213455/environment/lava-10213=
455/bin/lava-test-runner /lava-10213455/1

    2023-05-06T07:00:31.237865  =


    2023-05-06T07:00:31.242357  / # /lava-10213455/bin/lava-test-runner /la=
va-10213455/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6455fb1464685eb12c2e8605

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-406-g93046c7116de/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-406-g93046c7116de/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6455fb1464685eb12c2e860a
        failing since 38 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-06T07:00:19.104797  + set +x<8>[   10.421016] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10213472_1.4.2.3.1>

    2023-05-06T07:00:19.104909  =


    2023-05-06T07:00:19.206560  #

    2023-05-06T07:00:19.307348  / # #export SHELL=3D/bin/sh

    2023-05-06T07:00:19.307529  =


    2023-05-06T07:00:19.408027  / # export SHELL=3D/bin/sh. /lava-10213472/=
environment

    2023-05-06T07:00:19.408240  =


    2023-05-06T07:00:19.508823  / # . /lava-10213472/environment/lava-10213=
472/bin/lava-test-runner /lava-10213472/1

    2023-05-06T07:00:19.509103  =


    2023-05-06T07:00:19.514503  / # /lava-10213472/bin/lava-test-runner /la=
va-10213472/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6455fb391e676254ab2e85f7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-406-g93046c7116de/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-406-g93046c7116de/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6455fb391e676254ab2e85fc
        failing since 38 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-06T07:00:49.134171  + <8>[   12.451319] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10213533_1.4.2.3.1>

    2023-05-06T07:00:49.134256  set +x

    2023-05-06T07:00:49.238686  / # #

    2023-05-06T07:00:49.339317  export SHELL=3D/bin/sh

    2023-05-06T07:00:49.339523  #

    2023-05-06T07:00:49.440052  / # export SHELL=3D/bin/sh. /lava-10213533/=
environment

    2023-05-06T07:00:49.440242  =


    2023-05-06T07:00:49.540743  / # . /lava-10213533/environment/lava-10213=
533/bin/lava-test-runner /lava-10213533/1

    2023-05-06T07:00:49.541041  =


    2023-05-06T07:00:49.545367  / # /lava-10213533/bin/lava-test-runner /la=
va-10213533/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6455fcd506a76b5ac52e8631

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-406-g93046c7116de/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-i=
mx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-406-g93046c7116de/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-i=
mx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6455fcd506a76b5ac52e8636
        failing since 98 days (last pass: v5.15.81-121-gcb14018a85f6, first=
 fail: v5.15.90-146-gbf7101723cc0)

    2023-05-06T07:07:40.461167  + set +x
    2023-05-06T07:07:40.461355  [    9.429836] <LAVA_SIGNAL_ENDRUN 0_dmesg =
941891_1.5.2.3.1>
    2023-05-06T07:07:40.569111  / # #
    2023-05-06T07:07:40.670835  export SHELL=3D/bin/sh
    2023-05-06T07:07:40.671249  #
    2023-05-06T07:07:40.772599  / # export SHELL=3D/bin/sh. /lava-941891/en=
vironment
    2023-05-06T07:07:40.773121  =

    2023-05-06T07:07:40.874474  / # . /lava-941891/environment/lava-941891/=
bin/lava-test-runner /lava-941891/1
    2023-05-06T07:07:40.875099  =

    2023-05-06T07:07:40.878056  / # /lava-941891/bin/lava-test-runner /lava=
-941891/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6455fb1a68a2bb06e22e85f8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-406-g93046c7116de/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-406-g93046c7116de/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6455fb1a68a2bb06e22e85fd
        failing since 38 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-06T07:00:31.491577  + set +x<8>[   12.713114] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10213482_1.4.2.3.1>

    2023-05-06T07:00:31.491685  =


    2023-05-06T07:00:31.595950  / # #

    2023-05-06T07:00:31.696517  export SHELL=3D/bin/sh

    2023-05-06T07:00:31.696705  #

    2023-05-06T07:00:31.797263  / # export SHELL=3D/bin/sh. /lava-10213482/=
environment

    2023-05-06T07:00:31.797457  =


    2023-05-06T07:00:31.897998  / # . /lava-10213482/environment/lava-10213=
482/bin/lava-test-runner /lava-10213482/1

    2023-05-06T07:00:31.898337  =


    2023-05-06T07:00:31.902995  / # /lava-10213482/bin/lava-test-runner /la=
va-10213482/1
 =

    ... (12 line(s) more)  =

 =20
