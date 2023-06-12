Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D14572C50E
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 14:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbjFLMwo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 08:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbjFLMwn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 08:52:43 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C59E10F5
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 05:52:16 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b3c578c602so8020275ad.2
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 05:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686574335; x=1689166335;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=12eMtIEqIET/QnQ5nD3ymHPnJ2KAQRwasnt4/2z4kZE=;
        b=nraF7cAs1RSwVTTdBT9AmOJY5KByoOtvyUDgzAVZksZpD4PfXnFzAPlP2A3siRyeka
         zZ/K1BT31s9g/3Ndsr0qdhlogYdG8Dd1klXoxVVvBtUnuuKk3JkCYg2SY96fvYyBfNCn
         XpyJcQM1b+Lz0fzuGaoBEoM63o/H+YpBonm9G5s7M91/KqTsLWRmdRtSHt5U7yi7ydzZ
         /pU3gLeoVzXJmDl1Mler3eH0uZyIfuGu4m69YdvSvxf4tzfoc46iiQS3teYeB+cgSr5D
         j2+8/9E3U0hhAwXd0s2ChUuIPxkGL4d9iVGgmCTxrljLFRObfCeh/i1aV1buLQanTuVd
         eCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574335; x=1689166335;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=12eMtIEqIET/QnQ5nD3ymHPnJ2KAQRwasnt4/2z4kZE=;
        b=TjNCpjSslHmDdHJBrM580FAYmnUaQlNbjNUPY7w2ryCKizLbU5fmAjzs0mRXEey9fm
         w3E1a4W/5hOs6ZG7Np1vQbqsQcO89gfZL3XphNFSZ8iHzklCTTyb4X8NgAUr8l9JbdbM
         BzczdwqXtq56ORH/zSZNryE+j3ReROqwubGLS0Y5F6EuB9lYIF7U3MAWCSrnZxHc+JH0
         E5+xAMpBh2qBoOUFjg29ciK0P9E7yEJOHyAw7VZRKphxvztuVUtDsIrl4XoIyvgKGXkc
         4EuvUy2LXJQaMzXusxhSqCaab6AvQfeNjlETEXoQDfqGDPLL4jbfGviuuovgHYIvHjLn
         sSrQ==
X-Gm-Message-State: AC+VfDwt+9vOrn15hIvT0ElPPgfWI/ZfAWITku+AeiAQXEYs031blhh9
        iv5O3V7QIPtBKp1N1t6CAUyj9k9jLUPchyIkr/mm2Q==
X-Google-Smtp-Source: ACHHUZ6C8AEUslb4mPKx8afkqcysnCcGHMkshVCgbsA+fwrrDmJhHgk3rB1m+tnaSjM1x0IagZpwQQ==
X-Received: by 2002:a17:902:930c:b0:1ab:19db:f2b with SMTP id bc12-20020a170902930c00b001ab19db0f2bmr6243098plb.36.1686574335015;
        Mon, 12 Jun 2023 05:52:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f3-20020a17090274c300b001b3d6089e4dsm1484546plt.94.2023.06.12.05.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 05:52:14 -0700 (PDT)
Message-ID: <648714fe.170a0220.8e3fe.2889@mx.google.com>
Date:   Mon, 12 Jun 2023 05:52:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.183-60-g4ac7b5daa8b1
Subject: stable-rc/linux-5.10.y baseline: 180 runs,
 8 regressions (v5.10.183-60-g4ac7b5daa8b1)
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

stable-rc/linux-5.10.y baseline: 180 runs, 8 regressions (v5.10.183-60-g4ac=
7b5daa8b1)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =

rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.183-60-g4ac7b5daa8b1/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.183-60-g4ac7b5daa8b1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      4ac7b5daa8b19db4be9c2133ab75dff53570463c =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6486e4367e848b14ad30613a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-60-g4ac7b5daa8b1/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-60-g4ac7b5daa8b1/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6486e4367e848b14ad30613f
        failing since 145 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-06-12T09:23:50.101159  <8>[   11.107738] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3658422_1.5.2.4.1>
    2023-06-12T09:23:50.220469  / # #
    2023-06-12T09:23:50.324470  export SHELL=3D/bin/sh
    2023-06-12T09:23:50.325012  #
    2023-06-12T09:23:50.432462  / # export SHELL=3D/bin/sh. /lava-3658422/e=
nvironment
    2023-06-12T09:23:50.432954  =

    2023-06-12T09:23:50.433288  / # <3>[   11.372024] Bluetooth: hci0: comm=
and 0x0c03 tx timeout
    2023-06-12T09:23:50.539206  . /lava-3658422/environment/lava-3658422/bi=
n/lava-test-runner /lava-3658422/1
    2023-06-12T09:23:50.539953  =

    2023-06-12T09:23:50.544576  / # /lava-3658422/bin/lava-test-runner /lav=
a-3658422/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6486e070c96803e17230616f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-60-g4ac7b5daa8b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-60-g4ac7b5daa8b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6486e070c96803e172306174
        failing since 75 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-06-12T09:07:46.485686  + set +x

    2023-06-12T09:07:46.492531  <8>[   10.592322] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10687264_1.4.2.3.1>

    2023-06-12T09:07:46.597222  / # #

    2023-06-12T09:07:46.697844  export SHELL=3D/bin/sh

    2023-06-12T09:07:46.698081  #

    2023-06-12T09:07:46.798620  / # export SHELL=3D/bin/sh. /lava-10687264/=
environment

    2023-06-12T09:07:46.798834  =


    2023-06-12T09:07:46.899352  / # . /lava-10687264/environment/lava-10687=
264/bin/lava-test-runner /lava-10687264/1

    2023-06-12T09:07:46.899684  =


    2023-06-12T09:07:46.904714  / # /lava-10687264/bin/lava-test-runner /la=
va-10687264/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6486e055b5ecbda5f330615a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-60-g4ac7b5daa8b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-60-g4ac7b5daa8b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6486e055b5ecbda5f330615f
        failing since 75 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-06-12T09:07:19.490675  <8>[   13.632353] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10687240_1.4.2.3.1>

    2023-06-12T09:07:19.494327  + set +x

    2023-06-12T09:07:19.598410  / # #

    2023-06-12T09:07:19.699073  export SHELL=3D/bin/sh

    2023-06-12T09:07:19.699290  #

    2023-06-12T09:07:19.799810  / # export SHELL=3D/bin/sh. /lava-10687240/=
environment

    2023-06-12T09:07:19.800024  =


    2023-06-12T09:07:19.900571  / # . /lava-10687240/environment/lava-10687=
240/bin/lava-test-runner /lava-10687240/1

    2023-06-12T09:07:19.900898  =


    2023-06-12T09:07:19.905864  / # /lava-10687240/bin/lava-test-runner /la=
va-10687240/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6486e1d9e65d83d43a306160

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-60-g4ac7b5daa8b1/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-=
iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-60-g4ac7b5daa8b1/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-=
iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6486e1d9e65d83d43a306=
161
        new failure (last pass: v5.10.183) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6486e38e109fdb4e86306138

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-60-g4ac7b5daa8b1/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-roc=
k64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-60-g4ac7b5daa8b1/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-roc=
k64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6486e38e109fdb4e8630613d
        failing since 44 days (last pass: v5.10.147, first fail: v5.10.176-=
373-g8415c0f9308b)

    2023-06-12T09:20:57.037057  [   15.982412] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3658361_1.5.2.4.1>
    2023-06-12T09:20:57.141386  =

    2023-06-12T09:20:57.141602  / # #[   16.065643] rockchip-drm display-su=
bsystem: [drm] Cannot find any crtc or sizes
    2023-06-12T09:20:57.243059  export SHELL=3D/bin/sh
    2023-06-12T09:20:57.243493  =

    2023-06-12T09:20:57.344804  / # export SHELL=3D/bin/sh. /lava-3658361/e=
nvironment
    2023-06-12T09:20:57.345236  =

    2023-06-12T09:20:57.446554  / # . /lava-3658361/environment/lava-365836=
1/bin/lava-test-runner /lava-3658361/1
    2023-06-12T09:20:57.447291  =

    2023-06-12T09:20:57.450702  / # /lava-3658361/bin/lava-test-runner /lav=
a-3658361/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6486e406da927006d0306201

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-60-g4ac7b5daa8b1/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-stm=
32mp157c-dk2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-60-g4ac7b5daa8b1/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-stm=
32mp157c-dk2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6486e406da927006d0306206
        failing since 128 days (last pass: v5.10.147, first fail: v5.10.166=
-10-g6278b8c9832e)

    2023-06-12T09:23:04.915040  <8>[   12.668944] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3658433_1.5.2.4.1>
    2023-06-12T09:23:05.018886  / # #
    2023-06-12T09:23:05.120365  export SHELL=3D/bin/sh
    2023-06-12T09:23:05.120707  #
    2023-06-12T09:23:05.221818  / # export SHELL=3D/bin/sh. /lava-3658433/e=
nvironment
    2023-06-12T09:23:05.222287  =

    2023-06-12T09:23:05.323569  / # . /lava-3658433/environment/lava-365843=
3/bin/lava-test-runner /lava-3658433/1
    2023-06-12T09:23:05.324036  =

    2023-06-12T09:23:05.328477  / # /lava-3658433/bin/lava-test-runner /lav=
a-3658433/1
    2023-06-12T09:23:05.394406  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6486e4b20fe51a521a306186

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-60-g4ac7b5daa8b1/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64=
-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-60-g4ac7b5daa8b1/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64=
-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6486e4b20fe51a521a3061ae
        failing since 132 days (last pass: v5.10.158-107-g6b6a42c25ed4, fir=
st fail: v5.10.165-144-g930bc29c79c4)

    2023-06-12T09:25:43.833152  + set +x
    2023-06-12T09:25:43.837128  <8>[   17.018285] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3658359_1.5.2.4.1>
    2023-06-12T09:25:43.957946  / # #
    2023-06-12T09:25:44.063906  export SHELL=3D/bin/sh
    2023-06-12T09:25:44.065600  #
    2023-06-12T09:25:44.169210  / # export SHELL=3D/bin/sh. /lava-3658359/e=
nvironment
    2023-06-12T09:25:44.170810  =

    2023-06-12T09:25:44.274447  / # . /lava-3658359/environment/lava-365835=
9/bin/lava-test-runner /lava-3658359/1
    2023-06-12T09:25:44.277384  =

    2023-06-12T09:25:44.280425  / # /lava-3658359/bin/lava-test-runner /lav=
a-3658359/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6486e4d11b23e3ab4f30613a

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-60-g4ac7b5daa8b1/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-=
pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-60-g4ac7b5daa8b1/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-=
pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6486e4d11b23e3ab4f306166
        failing since 132 days (last pass: v5.10.158-107-g6b6a42c25ed4, fir=
st fail: v5.10.165-144-g930bc29c79c4)

    2023-06-12T09:26:09.614854  + set +x
    2023-06-12T09:26:09.618918  <8>[   17.066205] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 596627_1.5.2.4.1>
    2023-06-12T09:26:09.728911  / # #
    2023-06-12T09:26:09.831352  export SHELL=3D/bin/sh
    2023-06-12T09:26:09.832361  #
    2023-06-12T09:26:09.934282  / # export SHELL=3D/bin/sh. /lava-596627/en=
vironment
    2023-06-12T09:26:09.934831  =

    2023-06-12T09:26:10.036717  / # . /lava-596627/environment/lava-596627/=
bin/lava-test-runner /lava-596627/1
    2023-06-12T09:26:10.037618  =

    2023-06-12T09:26:10.041021  / # /lava-596627/bin/lava-test-runner /lava=
-596627/1 =

    ... (12 line(s) more)  =

 =20
