Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75ED16F362E
	for <lists+stable@lfdr.de>; Mon,  1 May 2023 20:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbjEASr6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 1 May 2023 14:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbjEASr5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 1 May 2023 14:47:57 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08D12D50
        for <stable@vger.kernel.org>; Mon,  1 May 2023 11:47:34 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-528cdc9576cso1749083a12.0
        for <stable@vger.kernel.org>; Mon, 01 May 2023 11:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682966852; x=1685558852;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=skqKkfXvWunhAHyGIS/vfxsXLb1kgrjUD+4HZ56XK38=;
        b=hvJvfH3JgNf3sd9EK6Cpj2jm34KrKnoE8ahoB+dcOOfZw7NdUqtycIf4UYwqPqPFre
         +FatgEhfgQHjylXEjpDOJ0lsiPT4tP9QoC+m0oDKD0Vt7m0uZyhG65K5pVVmBu5MxEj2
         jRe2ETUcphw8Lbz6j15VyF+td2K7KO/DwzCO6I0cEsND749lw42ARSeKOsk3+BWWUDRj
         a1d4dillfGupLjDAmV+SgEVsaYTTt0zeC7AvP9Scvp7XAv5F2oJEikoJXNlkoRDUxuct
         UtUxvynLattKHJNfVt1w+/JkVHKHxKMGpYfoxEC8OogF5xbJ89qEvv81o4pM+TaTbtkx
         sQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682966852; x=1685558852;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=skqKkfXvWunhAHyGIS/vfxsXLb1kgrjUD+4HZ56XK38=;
        b=CK/sL6ddM8Nv0WxNZqFZAb7eKtAdhWJVRO6cJf1e5+N1QfGNJR5ARg5gKZ2bzSZ4IG
         SnZvzQU8V7rbKS+GVkLVy/Jc9ys3+jNtCBihFf6sczgpLNnqAH3RiHHzm2UuxYkYzYZV
         VVS7k9ImC62TCs4TS5/0sQdvm+83qNswC9aNqhGppsri8OHjpR6nYyj/Xs2mgmpH2x3o
         4dzdeajuM3gAj5Y1vSz5Zw2T1k/awqXzL5JF/INKcPG8B3xGluifQs2vLIyi4+xdQA46
         5WI/UQ1nB7CNxnM4hyLpS9Zj7ezdUxUZw9O35JQ9WOBANPvCloKSUjcNuxVxFi6J0Exq
         XggA==
X-Gm-Message-State: AC+VfDwlfJBWgvTXueWaldYXEAgbgWw2IXYdm2iuqCCJutYaup4a+Vvf
        KJLvjzzJu2nWRzvAICg3bdugcDxng4atXg9ITss=
X-Google-Smtp-Source: ACHHUZ7W5EtIlFv2l7h/sLKFzGTce9tbK3PE1jRGXZALtH1JUR8xcLlYeubQgEb7FlO3+au06SsyuQ==
X-Received: by 2002:a17:902:d489:b0:1a9:b3a8:2b0a with SMTP id c9-20020a170902d48900b001a9b3a82b0amr17877682plg.15.1682966852136;
        Mon, 01 May 2023 11:47:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j1-20020a17090276c100b001a80ae1196fsm18195565plt.39.2023.05.01.11.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 11:47:31 -0700 (PDT)
Message-ID: <64500943.170a0220.2dae3.4c1a@mx.google.com>
Date:   Mon, 01 May 2023 11:47:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.105-369-g658a97f61144
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 170 runs,
 9 regressions (v5.15.105-369-g658a97f61144)
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

stable-rc/queue/5.15 baseline: 170 runs, 9 regressions (v5.15.105-369-g658a=
97f61144)

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

rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.105-369-g658a97f61144/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.105-369-g658a97f61144
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      658a97f611440b4858437152739b950488fba911 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644fd30a500fdd19482e861f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-369-g658a97f61144/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-369-g658a97f61144/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644fd30a500fdd19482e8624
        failing since 34 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-01T14:55:48.410309  + set<8>[   11.658402] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10169639_1.4.2.3.1>

    2023-05-01T14:55:48.410418   +x

    2023-05-01T14:55:48.514857  / # #

    2023-05-01T14:55:48.615613  export SHELL=3D/bin/sh

    2023-05-01T14:55:48.615874  #

    2023-05-01T14:55:48.716473  / # export SHELL=3D/bin/sh. /lava-10169639/=
environment

    2023-05-01T14:55:48.716697  =


    2023-05-01T14:55:48.817214  / # . /lava-10169639/environment/lava-10169=
639/bin/lava-test-runner /lava-10169639/1

    2023-05-01T14:55:48.817551  =


    2023-05-01T14:55:48.822162  / # /lava-10169639/bin/lava-test-runner /la=
va-10169639/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644fd319936dae4bc92e8600

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-369-g658a97f61144/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-369-g658a97f61144/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644fd319936dae4bc92e8605
        failing since 34 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-01T14:56:10.011999  <8>[   10.004286] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10169716_1.4.2.3.1>

    2023-05-01T14:56:10.015130  + set +x

    2023-05-01T14:56:10.116666  =


    2023-05-01T14:56:10.217244  / # #export SHELL=3D/bin/sh

    2023-05-01T14:56:10.217449  =


    2023-05-01T14:56:10.317986  / # export SHELL=3D/bin/sh. /lava-10169716/=
environment

    2023-05-01T14:56:10.318201  =


    2023-05-01T14:56:10.418752  / # . /lava-10169716/environment/lava-10169=
716/bin/lava-test-runner /lava-10169716/1

    2023-05-01T14:56:10.419083  =


    2023-05-01T14:56:10.424100  / # /lava-10169716/bin/lava-test-runner /la=
va-10169716/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/644fd953915fbbb9682e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-369-g658a97f61144/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-369-g658a97f61144/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644fd953915fbbb9682e8=
5e7
        failing since 87 days (last pass: v5.15.91-12-g3290f78df1ab, first =
fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644fd42bdeb705bffa2e8617

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-369-g658a97f61144/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-369-g658a97f61144/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644fd42bdeb705bffa2e861c
        failing since 104 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-01T15:00:37.070902  <8>[   10.041940] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3545959_1.5.2.4.1>
    2023-05-01T15:00:37.180062  / # #
    2023-05-01T15:00:37.283489  export SHELL=3D/bin/sh
    2023-05-01T15:00:37.284438  #
    2023-05-01T15:00:37.285016  / # <3>[   10.193159] Bluetooth: hci0: comm=
and 0x0c03 tx timeout
    2023-05-01T15:00:37.387076  export SHELL=3D/bin/sh. /lava-3545959/envir=
onment
    2023-05-01T15:00:37.388087  =

    2023-05-01T15:00:37.490057  / # . /lava-3545959/environment/lava-354595=
9/bin/lava-test-runner /lava-3545959/1
    2023-05-01T15:00:37.496911  =

    2023-05-01T15:00:37.500644  / # /lava-3545959/bin/lava-test-runner /lav=
a-3545959/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644fd318500fdd19482e8720

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-369-g658a97f61144/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-369-g658a97f61144/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644fd318500fdd19482e8725
        failing since 34 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-01T14:56:07.585149  + set +x

    2023-05-01T14:56:07.591868  <8>[   10.306688] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10169694_1.4.2.3.1>

    2023-05-01T14:56:07.699839  / # #

    2023-05-01T14:56:07.802124  export SHELL=3D/bin/sh

    2023-05-01T14:56:07.802833  #

    2023-05-01T14:56:07.904238  / # export SHELL=3D/bin/sh. /lava-10169694/=
environment

    2023-05-01T14:56:07.904399  =


    2023-05-01T14:56:08.004920  / # . /lava-10169694/environment/lava-10169=
694/bin/lava-test-runner /lava-10169694/1

    2023-05-01T14:56:08.005172  =


    2023-05-01T14:56:08.009714  / # /lava-10169694/bin/lava-test-runner /la=
va-10169694/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644fd2f83ff101771e2e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-369-g658a97f61144/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-369-g658a97f61144/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644fd2f83ff101771e2e85eb
        failing since 34 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-01T14:55:40.953317  + set +x

    2023-05-01T14:55:40.959943  <8>[   10.116654] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10169663_1.4.2.3.1>

    2023-05-01T14:55:41.064514  / # #

    2023-05-01T14:55:41.165286  export SHELL=3D/bin/sh

    2023-05-01T14:55:41.165537  #

    2023-05-01T14:55:41.266150  / # export SHELL=3D/bin/sh. /lava-10169663/=
environment

    2023-05-01T14:55:41.266460  =


    2023-05-01T14:55:41.367092  / # . /lava-10169663/environment/lava-10169=
663/bin/lava-test-runner /lava-10169663/1

    2023-05-01T14:55:41.367432  =


    2023-05-01T14:55:41.372240  / # /lava-10169663/bin/lava-test-runner /la=
va-10169663/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644fd313500fdd19482e8707

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-369-g658a97f61144/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-369-g658a97f61144/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644fd313500fdd19482e870c
        failing since 34 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-01T14:55:56.452542  + set<8>[   11.003532] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10169662_1.4.2.3.1>

    2023-05-01T14:55:56.452948   +x

    2023-05-01T14:55:56.559850  / # #

    2023-05-01T14:55:56.661805  export SHELL=3D/bin/sh

    2023-05-01T14:55:56.662401  #

    2023-05-01T14:55:56.763620  / # export SHELL=3D/bin/sh. /lava-10169662/=
environment

    2023-05-01T14:55:56.764279  =


    2023-05-01T14:55:56.865488  / # . /lava-10169662/environment/lava-10169=
662/bin/lava-test-runner /lava-10169662/1

    2023-05-01T14:55:56.866577  =


    2023-05-01T14:55:56.871344  / # /lava-10169662/bin/lava-test-runner /la=
va-10169662/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644fd2fd3ff101771e2e85f1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-369-g658a97f61144/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-369-g658a97f61144/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644fd2fd3ff101771e2e85f6
        failing since 34 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-01T14:55:41.592012  <8>[    8.749685] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10169679_1.4.2.3.1>

    2023-05-01T14:55:41.696570  / # #

    2023-05-01T14:55:41.797333  export SHELL=3D/bin/sh

    2023-05-01T14:55:41.797595  #

    2023-05-01T14:55:41.898174  / # export SHELL=3D/bin/sh. /lava-10169679/=
environment

    2023-05-01T14:55:41.898419  =


    2023-05-01T14:55:41.999015  / # . /lava-10169679/environment/lava-10169=
679/bin/lava-test-runner /lava-10169679/1

    2023-05-01T14:55:41.999433  =


    2023-05-01T14:55:42.004097  / # /lava-10169679/bin/lava-test-runner /la=
va-10169679/1

    2023-05-01T14:55:42.009194  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644fd1beff2814c69f2e8614

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-369-g658a97f61144/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-369-g658a97f61144/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644fd1beff2814c69f2e8619
        failing since 88 days (last pass: v5.15.72-36-g40cafafcdb983, first=
 fail: v5.15.90-215-gdf99871482a0)

    2023-05-01T14:50:21.481008  [   16.043544] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3545872_1.5.2.4.1>
    2023-05-01T14:50:21.585106  =

    2023-05-01T14:50:21.585337  / # [   16.097229] rockchip-drm display-sub=
system: [drm] Cannot find any crtc or sizes
    2023-05-01T14:50:21.686779  #export SHELL=3D/bin/sh
    2023-05-01T14:50:21.687402  =

    2023-05-01T14:50:21.789021  / # export SHELL=3D/bin/sh. /lava-3545872/e=
nvironment
    2023-05-01T14:50:21.789447  =

    2023-05-01T14:50:21.890933  / # . /lava-3545872/environment/lava-354587=
2/bin/lava-test-runner /lava-3545872/1
    2023-05-01T14:50:21.891648  =

    2023-05-01T14:50:21.894125  / # /lava-3545872/bin/lava-test-runner /lav=
a-3545872/1 =

    ... (13 line(s) more)  =

 =20
