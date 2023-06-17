Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73ABF7341BF
	for <lists+stable@lfdr.de>; Sat, 17 Jun 2023 16:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbjFQOy2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 17 Jun 2023 10:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjFQOy1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Jun 2023 10:54:27 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A848F1FD4
        for <stable@vger.kernel.org>; Sat, 17 Jun 2023 07:54:25 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-51452556acdso837882a12.2
        for <stable@vger.kernel.org>; Sat, 17 Jun 2023 07:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687013665; x=1689605665;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DyorRlpkqVZLNqb7cU7GHL5TvUOr10jjqBnW0ungHfY=;
        b=zlrkQvYPpUkQThMeHKJBJW4WZei6F6QXo0nMrlUtaUL2iwSif72qFIQIWH6yYVczc2
         BuBu6SWMKfvrZr8OjD1rkc4zt99HTjZpZlUhHZaZF4NHoTPdRsK+S19KEZc7/hM4KjWE
         RBahbXDQWKQxorSyOq+hYTEuUV71kT4LcJFhzw5L2+OWfNwI6pXIiJujT/qBaK04LM5H
         dWQQHLHoyTrmzl1ZMbPRmU1aKUx7ZpI9Kj7XM2HHYBWzdRJOky9T9+qlGXiyEa74g7vV
         z7jxC7L0vZ9XjxqeNhcZwglua9+7dy/mXlIjwTl1+FTt5YWy2NMDET7HlpDJGGVRUv6w
         X8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687013665; x=1689605665;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DyorRlpkqVZLNqb7cU7GHL5TvUOr10jjqBnW0ungHfY=;
        b=EVPLGEo9MP4CRXX6ziQz2AimScWS273T6fPJWg/11UJT2XSeLezfDwzi2FtrYDkYH2
         eFTxy9OJ7nnhpIBSUls2XEeI/QWlVgAaY6Js7s9D8yo2i0QiJ4zrnZsl8IET/yToSkAS
         bXFYXDqdqpQ7PclRVysqGjTsX1rPveTx8+cf+F9BpfR/K5KQlRagjPzwLIbudRFj2E+/
         yoqkHOi+HJNDE336EStimRZSzbdvMhidIQeuuSqZdhk1xlSyShe8QtbYXOQN4in9vNSR
         tKvSreAaZowC8nFs3qtnEi5NZYH/HeeVTvzzwPxz04RxcjcsHWdxtFpsPEKCA0fIUCw2
         VwWw==
X-Gm-Message-State: AC+VfDwl2fIMIIMNuJAvaYUV3ZoRbJYZ1BdFqmM5V4zagiL91ikaw7wa
        nW/PW5uZvICe7d+OHRRR7IL6dyWiweaJyLsb6bb6wA==
X-Google-Smtp-Source: ACHHUZ4VpYDnQvP2xNzhGfdTuq5gqBKB4T8bYjxxfb2MKi1JYOgGw+6w3gvgVqSi3m6bJww82ikkgw==
X-Received: by 2002:a17:90a:1382:b0:25b:f862:43a6 with SMTP id i2-20020a17090a138200b0025bf86243a6mr3084683pja.21.1687013664468;
        Sat, 17 Jun 2023 07:54:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id gl12-20020a17090b120c00b0025e7f7b46c3sm3030840pjb.25.2023.06.17.07.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 07:54:23 -0700 (PDT)
Message-ID: <648dc91f.170a0220.b74bd.5e2c@mx.google.com>
Date:   Sat, 17 Jun 2023 07:54:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.184-42-ged09c5d9be30
Subject: stable-rc/linux-5.10.y baseline: 174 runs,
 9 regressions (v5.10.184-42-ged09c5d9be30)
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

stable-rc/linux-5.10.y baseline: 174 runs, 9 regressions (v5.10.184-42-ged0=
9c5d9be30)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =

r8a77950-salvator-x          | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.184-42-ged09c5d9be30/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.184-42-ged09c5d9be30
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      ed09c5d9be305fbd84ea11903ede202521aae9be =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648d929fcdbd65ebff30624c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-42-ged09c5d9be30/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-42-ged09c5d9be30/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648d929fcdbd65ebff306=
24d
        new failure (last pass: v5.10.183-69-g32cae866b182) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648d92eb96088ee53630614b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-42-ged09c5d9be30/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-42-ged09c5d9be30/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648d92eb96088ee536306150
        failing since 150 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-06-17T11:02:46.958510  <8>[   11.105323] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3671731_1.5.2.4.1>
    2023-06-17T11:02:47.067867  / # #
    2023-06-17T11:02:47.170991  export SHELL=3D/bin/sh
    2023-06-17T11:02:47.171857  #
    2023-06-17T11:02:47.172317  / # export SHELL=3D/bin/sh<3>[   11.292316]=
 Bluetooth: hci0: command 0x0c03 tx timeout
    2023-06-17T11:02:47.274376  . /lava-3671731/environment
    2023-06-17T11:02:47.275282  =

    2023-06-17T11:02:47.377307  / # . /lava-3671731/environment/lava-367173=
1/bin/lava-test-runner /lava-3671731/1
    2023-06-17T11:02:47.378932  =

    2023-06-17T11:02:47.384143  / # /lava-3671731/bin/lava-test-runner /lav=
a-3671731/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648d903afc2494eaaa306133

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-42-ged09c5d9be30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-42-ged09c5d9be30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648d903afc2494eaaa306138
        failing since 80 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-06-17T10:51:36.156977  + set +x

    2023-06-17T10:51:36.163178  <8>[   14.865306] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10777945_1.4.2.3.1>

    2023-06-17T10:51:36.271194  / # #

    2023-06-17T10:51:36.373604  export SHELL=3D/bin/sh

    2023-06-17T10:51:36.374313  #

    2023-06-17T10:51:36.475612  / # export SHELL=3D/bin/sh. /lava-10777945/=
environment

    2023-06-17T10:51:36.476375  =


    2023-06-17T10:51:36.577748  / # . /lava-10777945/environment/lava-10777=
945/bin/lava-test-runner /lava-10777945/1

    2023-06-17T10:51:36.578812  =


    2023-06-17T10:51:36.583144  / # /lava-10777945/bin/lava-test-runner /la=
va-10777945/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648d9047df122d211e306155

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-42-ged09c5d9be30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-42-ged09c5d9be30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648d9047df122d211e30615a
        failing since 80 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-06-17T10:51:40.418899  <8>[   12.943433] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10777953_1.4.2.3.1>

    2023-06-17T10:51:40.422112  + set +x

    2023-06-17T10:51:40.523320  /#

    2023-06-17T10:51:40.624108   # #export SHELL=3D/bin/sh

    2023-06-17T10:51:40.624319  =


    2023-06-17T10:51:40.724802  / # export SHELL=3D/bin/sh. /lava-10777953/=
environment

    2023-06-17T10:51:40.724983  =


    2023-06-17T10:51:40.825466  / # . /lava-10777953/environment/lava-10777=
953/bin/lava-test-runner /lava-10777953/1

    2023-06-17T10:51:40.825677  =


    2023-06-17T10:51:40.830556  / # /lava-10777953/bin/lava-test-runner /la=
va-10777953/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648d913d9d70ced193306143

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-42-ged09c5d9be30/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-=
iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-42-ged09c5d9be30/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-=
iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648d913d9d70ced193306=
144
        new failure (last pass: v5.10.183-69-g32cae866b182) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77950-salvator-x          | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648d993ffdd599077330617d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-42-ged09c5d9be30/arm64/defconfig/gcc-10/lab-baylibre/baseline-r8a77950-s=
alvator-x.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-42-ged09c5d9be30/arm64/defconfig/gcc-10/lab-baylibre/baseline-r8a77950-s=
alvator-x.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648d993ffdd5990773306=
17e
        new failure (last pass: v5.10.183-69-g32cae866b182) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648d988c91dd9dc43c30613a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-42-ged09c5d9be30/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-roc=
k64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-42-ged09c5d9be30/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-roc=
k64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648d988c91dd9dc43c30613f
        failing since 49 days (last pass: v5.10.147, first fail: v5.10.176-=
373-g8415c0f9308b)

    2023-06-17T11:26:51.465265  [   15.920241] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3671899_1.5.2.4.1>
    2023-06-17T11:26:51.569818  =

    2023-06-17T11:26:51.671321  / # #export SHELL=3D/bin/sh
    2023-06-17T11:26:51.671765  =

    2023-06-17T11:26:51.672009  / # export SHELL=3D/bin/sh[   16.093314] ro=
ckchip-drm display-subsystem: [drm] Cannot find any crtc or sizes
    2023-06-17T11:26:51.773335  . /lava-3671899/environment
    2023-06-17T11:26:51.773783  =

    2023-06-17T11:26:51.875152  / # . /lava-3671899/environment/lava-367189=
9/bin/lava-test-runner /lava-3671899/1
    2023-06-17T11:26:51.876105  =

    2023-06-17T11:26:51.879534  / # /lava-3671899/bin/lava-test-runner /lav=
a-3671899/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648d9a34ea4146d05a306146

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-42-ged09c5d9be30/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64=
-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-42-ged09c5d9be30/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64=
-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648d9a35ea4146d05a306172
        failing since 137 days (last pass: v5.10.158-107-g6b6a42c25ed4, fir=
st fail: v5.10.165-144-g930bc29c79c4)

    2023-06-17T11:33:53.581804  + set +x
    2023-06-17T11:33:53.585875  <8>[   17.062787] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3671838_1.5.2.4.1>
    2023-06-17T11:33:53.707260  / # #
    2023-06-17T11:33:53.812805  export SHELL=3D/bin/sh
    2023-06-17T11:33:53.814309  #
    2023-06-17T11:33:53.917873  / # export SHELL=3D/bin/sh. /lava-3671838/e=
nvironment
    2023-06-17T11:33:53.919376  =

    2023-06-17T11:33:54.022859  / # . /lava-3671838/environment/lava-367183=
8/bin/lava-test-runner /lava-3671838/1
    2023-06-17T11:33:54.025731  =

    2023-06-17T11:33:54.028979  / # /lava-3671838/bin/lava-test-runner /lav=
a-3671838/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648d9846f5c6e1d3513061dc

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-42-ged09c5d9be30/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-=
pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-42-ged09c5d9be30/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-=
pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648d9846f5c6e1d351306208
        failing since 137 days (last pass: v5.10.158-107-g6b6a42c25ed4, fir=
st fail: v5.10.165-144-g930bc29c79c4)

    2023-06-17T11:25:26.459278  + set +x
    2023-06-17T11:25:26.463263  <8>[   17.206617] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 625190_1.5.2.4.1>
    2023-06-17T11:25:26.573427  / # #
    2023-06-17T11:25:26.675061  export SHELL=3D/bin/sh
    2023-06-17T11:25:26.675476  #
    2023-06-17T11:25:26.776802  / # export SHELL=3D/bin/sh. /lava-625190/en=
vironment
    2023-06-17T11:25:26.777135  =

    2023-06-17T11:25:26.878394  / # . /lava-625190/environment/lava-625190/=
bin/lava-test-runner /lava-625190/1
    2023-06-17T11:25:26.878852  =

    2023-06-17T11:25:26.883868  / # /lava-625190/bin/lava-test-runner /lava=
-625190/1 =

    ... (12 line(s) more)  =

 =20
