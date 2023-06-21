Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E75D739237
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 00:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjFUWGJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 21 Jun 2023 18:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjFUWGJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Jun 2023 18:06:09 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110A910CE
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 15:06:07 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b4f9583404so49333995ad.2
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 15:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687385166; x=1689977166;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVZi7kq4Ial275bGPr8p69FtMOdnMYG6SmD5z32CdDA=;
        b=qOZ0tQQolyJ6Bt6ugZEuaNzsuoUYj3h6QodRKshdvUn8ykGaOKcMaZOlTgrW+Lp7G8
         7FVpZIX7wuzrF0raNGzFtLxKX3WwXe3TdUmb21UzuaumtBzkX6xLTk1yZsQj/BHMZLfu
         LJKRNu7YWPbsQ8m+nRaEAFc0JxyLKpM+3+yOWcIBiUlPtFu66dLyYmHpoA5E9yOi+ZUG
         /9yML+how2ysemxN9NbJJXoI3e5CBcExCGukiDKV0fhGw/7l1eFCyp0xqcXI/OdOta+M
         GOSaMmt0XgJjzCf8+vXptZ0khjEoKwnUh+iYlYRhhEYRttFtsZFhhaiPrWOd/eYZSV00
         A72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687385166; x=1689977166;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZVZi7kq4Ial275bGPr8p69FtMOdnMYG6SmD5z32CdDA=;
        b=X4UuJAWHeBWCVlg7L7uC9z41pgBx0UluuRIO6HAKN7+8pvM1eHtazzYKXqiCW7dBXh
         KW17+iIpHRcwK7C7K8g27O6nPxfZcixxK2MKlgVajFVeplEk4S7gosE3WDfUp05bLpnN
         uG9IlmBtpRi4DgJksTMEnuBwbvNMUOVh7M8vQUIggb3qQ8qRwDkelMowLTvKJOeWdraq
         28RBIGv56rfxWzKEL18JO+sEgF1lB3PqjxLYziMdOvhb6Mf6jQUcr6D+6IUhp/KGzGi6
         wtrVxyKR0SB44atNkLS2BbFIjxSSeqNGT9XVDcy8+466sj/EjndxAtFUJanxqb6APIN+
         Q4xg==
X-Gm-Message-State: AC+VfDyhYWDkQHHdUXgt9m0I9nEGnHsDUX/Ye4SaxpqJOS5XboxS/gnY
        FnaCKifVFC1LAdzhbemrMDtBl24kYiJkZYYA+MEgOQ==
X-Google-Smtp-Source: ACHHUZ7Y428D9xMtGXFo4QbdjQ2J5EKVbxpzdrygMxNmLo4vyU2zNqbj2cnw87mQO+4rZiiFUckoRA==
X-Received: by 2002:a17:902:db0a:b0:1b5:5c02:9121 with SMTP id m10-20020a170902db0a00b001b55c029121mr13227650plx.32.1687385165860;
        Wed, 21 Jun 2023 15:06:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bd7-20020a170902830700b001b53472353csm3930406plb.211.2023.06.21.15.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 15:06:05 -0700 (PDT)
Message-ID: <6493744d.170a0220.bfc69.973b@mx.google.com>
Date:   Wed, 21 Jun 2023 15:06:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.185
Subject: stable-rc/linux-5.10.y baseline: 170 runs, 6 regressions (v5.10.185)
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

stable-rc/linux-5.10.y baseline: 170 runs, 6 regressions (v5.10.185)

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

rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.185/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.185
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      ef0d5feb32ab7007d1316e9c5037cd7d9f7febbf =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64933d05c75649a4e630612e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
85/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
85/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64933d05c75649a4e6306137
        failing since 154 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-06-21T18:09:54.870619  <8>[   11.116821] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3684461_1.5.2.4.1>
    2023-06-21T18:09:54.981890  / # #
    2023-06-21T18:09:55.085210  export SHELL=3D/bin/sh
    2023-06-21T18:09:55.086276  #
    2023-06-21T18:09:55.188520  / # export SHELL=3D/bin/sh. /lava-3684461/e=
nvironment
    2023-06-21T18:09:55.189471  =

    2023-06-21T18:09:55.291966  / # . /lava-3684461/environment/lava-368446=
1/bin/lava-test-runner /lava-3684461/1
    2023-06-21T18:09:55.294376  =

    2023-06-21T18:09:55.295674  / # <3>[   11.452263] Bluetooth: hci0: comm=
and 0x0c03 tx timeout
    2023-06-21T18:09:55.298708  /lava-3684461/bin/lava-test-runner /lava-36=
84461/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64933a757a626c8e5a30614f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
85/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
85/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64933a757a626c8e5a306158
        failing since 84 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-06-21T17:59:05.613474  + set +x

    2023-06-21T17:59:05.620180  <8>[   10.523552] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10848402_1.4.2.3.1>

    2023-06-21T17:59:05.724363  / # #

    2023-06-21T17:59:05.824998  export SHELL=3D/bin/sh

    2023-06-21T17:59:05.825198  #

    2023-06-21T17:59:05.925674  / # export SHELL=3D/bin/sh. /lava-10848402/=
environment

    2023-06-21T17:59:05.925961  =


    2023-06-21T17:59:06.026480  / # . /lava-10848402/environment/lava-10848=
402/bin/lava-test-runner /lava-10848402/1

    2023-06-21T17:59:06.026774  =


    2023-06-21T17:59:06.031759  / # /lava-10848402/bin/lava-test-runner /la=
va-10848402/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64933a7eee735df47030615c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
85/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
85/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64933a7eee735df470306165
        failing since 84 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-06-21T17:59:15.016470  + set +x<8>[   13.081492] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10848419_1.4.2.3.1>

    2023-06-21T17:59:15.017060  =


    2023-06-21T17:59:15.123828  / #

    2023-06-21T17:59:15.226235  # #export SHELL=3D/bin/sh

    2023-06-21T17:59:15.226920  =


    2023-06-21T17:59:15.328190  / # export SHELL=3D/bin/sh. /lava-10848419/=
environment

    2023-06-21T17:59:15.328562  =


    2023-06-21T17:59:15.429404  / # . /lava-10848419/environment/lava-10848=
419/bin/lava-test-runner /lava-10848419/1

    2023-06-21T17:59:15.430479  =


    2023-06-21T17:59:15.435562  / # /lava-10848419/bin/lava-test-runner /la=
va-10848419/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64933cfc3600176d1930615a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
85/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
85/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64933cfc3600176d19306163
        failing since 54 days (last pass: v5.10.147, first fail: v5.10.176-=
373-g8415c0f9308b)

    2023-06-21T18:09:43.053671  [   15.991656] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3684527_1.5.2.4.1>
    2023-06-21T18:09:43.157847  =

    2023-06-21T18:09:43.158025  / # #[   16.061331] rockchip-drm display-su=
bsystem: [drm] Cannot find any crtc or sizes
    2023-06-21T18:09:43.259396  export SHELL=3D/bin/sh
    2023-06-21T18:09:43.259844  =

    2023-06-21T18:09:43.361220  / # export SHELL=3D/bin/sh. /lava-3684527/e=
nvironment
    2023-06-21T18:09:43.361656  =

    2023-06-21T18:09:43.463073  / # . /lava-3684527/environment/lava-368452=
7/bin/lava-test-runner /lava-3684527/1
    2023-06-21T18:09:43.464147  =

    2023-06-21T18:09:43.467744  / # /lava-3684527/bin/lava-test-runner /lav=
a-3684527/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6493405493a719468d30613a

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
85/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
85/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6493405493a719468d306168
        failing since 142 days (last pass: v5.10.158-107-g6b6a42c25ed4, fir=
st fail: v5.10.165-144-g930bc29c79c4)

    2023-06-21T18:23:55.744289  + set +x
    2023-06-21T18:23:55.748332  <8>[   17.078544] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3684526_1.5.2.4.1>
    2023-06-21T18:23:55.869451  / # #
    2023-06-21T18:23:55.975353  export SHELL=3D/bin/sh
    2023-06-21T18:23:55.977026  #
    2023-06-21T18:23:56.080588  / # export SHELL=3D/bin/sh. /lava-3684526/e=
nvironment
    2023-06-21T18:23:56.082187  =

    2023-06-21T18:23:56.185942  / # . /lava-3684526/environment/lava-368452=
6/bin/lava-test-runner /lava-3684526/1
    2023-06-21T18:23:56.188870  =

    2023-06-21T18:23:56.191865  / # /lava-3684526/bin/lava-test-runner /lav=
a-3684526/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64933ddc01b5874488306162

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
85/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
85/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64933ddc01b5874488306190
        failing since 142 days (last pass: v5.10.158-107-g6b6a42c25ed4, fir=
st fail: v5.10.165-144-g930bc29c79c4)

    2023-06-21T18:13:18.449050  + set +x
    2023-06-21T18:13:18.453160  <8>[   17.059776] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 647377_1.5.2.4.1>
    2023-06-21T18:13:18.565679  / # #
    2023-06-21T18:13:18.668735  export SHELL=3D/bin/sh
    2023-06-21T18:13:18.669453  #
    2023-06-21T18:13:18.771220  / # export SHELL=3D/bin/sh. /lava-647377/en=
vironment
    2023-06-21T18:13:18.771893  =

    2023-06-21T18:13:18.873825  / # . /lava-647377/environment/lava-647377/=
bin/lava-test-runner /lava-647377/1
    2023-06-21T18:13:18.875003  =

    2023-06-21T18:13:18.877852  / # /lava-647377/bin/lava-test-runner /lava=
-647377/1 =

    ... (12 line(s) more)  =

 =20
