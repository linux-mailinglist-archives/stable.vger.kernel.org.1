Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33CB772780
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 16:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjHGOUG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 10:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbjHGOUF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 10:20:05 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CD510CF
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 07:19:39 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-686b879f605so3082662b3a.1
        for <stable@vger.kernel.org>; Mon, 07 Aug 2023 07:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691417978; x=1692022778;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mcZTWMq8Jeox1JIhw8Y6TUiXo/PT4PGNPUghMZYCvuw=;
        b=G3MyaZAzopz72Ap55cO990LEmskl0Pdr6V+q2sByqIMMivxpAX3jmmIUmV96Bmvfmv
         F38yoazjd3/M6oQKIdyQ74wWDskSfDiS4FNir5KqpSXv7A6bGp30x/H++vbvBJ/FloOZ
         N7ghBDpmuqJNQsvGN5HGqbdwvhUJkBiv5cknHqCN0vMZd4S4yXqKHxi3cfHhJ8hSnPQ7
         UOJDaWOXKVMLhcRtnQ1fEaC6EqFANWEHufpMd7Dn0za/ntth19LkG/wL0bRClZVVq2dR
         OmvzbOf3LlEBnqJmYiLVCagTJOW0T80LCYFHp2XKeIfRkc47KwYXzWjNyiE6vyr0az7X
         imVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691417978; x=1692022778;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mcZTWMq8Jeox1JIhw8Y6TUiXo/PT4PGNPUghMZYCvuw=;
        b=dUYMMAclvna5lNRBlxTBeIrMayfTRNYL5lwdr8vaBuo5jRMq2xwe6E2xcbsD8xky+0
         ZMF8ZikoHiGJqZCOzu+2B/KNZtM8nuhNcpHVAqGabEiwbHzBYRLL2diOtyDznGr2hMs/
         7YR7131+7xVGA3fKur9u2YC8C5fOyMDE2yiV7le4gXzSNApoPY89KKdXF2daJZaJCiuq
         vJoyD7vvb5sC+pu3fjcUOiYgfMF22JwMIzxF5afm2O0VgGmZHcEuN3aC82HtHLUc3ie6
         twFGDEz6vRprb4TvchEhRZXSTw8jHU3uFNGgfNl2BXw8ccyGwIkpyjoAPIzS94G/el6S
         YeqQ==
X-Gm-Message-State: AOJu0YzqIlozt3PT8RCxixqlT/vb0yFejJ1i1FpWmyHcaGlWSYhznC67
        v419ZLtnAttZlI4Msb0Vp5zZQtb5LJwSf+cS7xbs3Q==
X-Google-Smtp-Source: AGHT+IE7cKdwUsGiOFH0OS5b8iPAs9LBbf30VU0ElNc0ZFTMd87HWGC93yF2JwYI6wC4bdmp8x3W6Q==
X-Received: by 2002:a05:6a21:2703:b0:13f:9dbc:e530 with SMTP id rm3-20020a056a21270300b0013f9dbce530mr6664586pzb.8.1691417978183;
        Mon, 07 Aug 2023 07:19:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n22-20020aa78a56000000b0068664ace38asm6450625pfa.19.2023.08.07.07.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 07:19:37 -0700 (PDT)
Message-ID: <64d0fd79.a70a0220.1dc49.aefb@mx.google.com>
Date:   Mon, 07 Aug 2023 07:19:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.188-183-g686c84f2f1364
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.10.y
Subject: stable-rc/linux-5.10.y baseline: 128 runs,
 11 regressions (v5.10.188-183-g686c84f2f1364)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y baseline: 128 runs, 11 regressions (v5.10.188-183-g6=
86c84f2f1364)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.188-183-g686c84f2f1364/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.188-183-g686c84f2f1364
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      686c84f2f136412631eb684b064def993a96a8cc =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d0cbfd92faaf5b1235b247

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-183-g686c84f2f1364/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-183-g686c84f2f1364/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d0cbfd92faaf5b1235b24c
        failing since 201 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-08-07T10:48:09.812803  <8>[   11.112386] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3731623_1.5.2.4.1>
    2023-08-07T10:48:09.922157  / # #
    2023-08-07T10:48:10.025613  export SHELL=3D/bin/sh
    2023-08-07T10:48:10.026451  #
    2023-08-07T10:48:10.128726  / # export SHELL=3D/bin/sh. /lava-3731623/e=
nvironment
    2023-08-07T10:48:10.129599  =

    2023-08-07T10:48:10.231603  / # . /lava-3731623/environment/lava-373162=
3/bin/lava-test-runner /lava-3731623/1
    2023-08-07T10:48:10.232976  =

    2023-08-07T10:48:10.233377  / # <3>[   11.453197] Bluetooth: hci0: comm=
and 0x0c03 tx timeout
    2023-08-07T10:48:10.237751  /lava-3731623/bin/lava-test-runner /lava-37=
31623/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d0cc4d20542558e535b205

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-183-g686c84f2f1364/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-r=
db.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-183-g686c84f2f1364/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-r=
db.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d0cc4d20542558e535b208
        failing since 20 days (last pass: v5.10.142, first fail: v5.10.186-=
332-gf98a4d3a5cec)

    2023-08-07T10:49:38.079850  [   10.081082] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1241360_1.5.2.4.1>
    2023-08-07T10:49:38.185131  =

    2023-08-07T10:49:38.286379  / # #export SHELL=3D/bin/sh
    2023-08-07T10:49:38.286835  =

    2023-08-07T10:49:38.387792  / # export SHELL=3D/bin/sh. /lava-1241360/e=
nvironment
    2023-08-07T10:49:38.388248  =

    2023-08-07T10:49:38.489255  / # . /lava-1241360/environment/lava-124136=
0/bin/lava-test-runner /lava-1241360/1
    2023-08-07T10:49:38.490033  =

    2023-08-07T10:49:38.493365  / # /lava-1241360/bin/lava-test-runner /lav=
a-1241360/1
    2023-08-07T10:49:38.514399  + export 'TESTRUN_[   10.515108] <LAVA_SIGN=
AL_STARTRUN 1_bootrr 1241360_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d0cc78d6e2be802935b235

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-183-g686c84f2f1364/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-r=
db.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-183-g686c84f2f1364/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-r=
db.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d0cc78d6e2be802935b238
        failing since 156 days (last pass: v5.10.155, first fail: v5.10.172)

    2023-08-07T10:50:13.086988  [   10.409934] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1241358_1.5.2.4.1>
    2023-08-07T10:50:13.192419  =

    2023-08-07T10:50:13.293536  / # #export SHELL=3D/bin/sh
    2023-08-07T10:50:13.294016  =

    2023-08-07T10:50:13.394928  / # export SHELL=3D/bin/sh. /lava-1241358/e=
nvironment
    2023-08-07T10:50:13.395410  =

    2023-08-07T10:50:13.496375  / # . /lava-1241358/environment/lava-124135=
8/bin/lava-test-runner /lava-1241358/1
    2023-08-07T10:50:13.497061  =

    2023-08-07T10:50:13.501028  / # /lava-1241358/bin/lava-test-runner /lav=
a-1241358/1
    2023-08-07T10:50:13.515538  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d0c9e124895abac635b220

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-183-g686c84f2f1364/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-183-g686c84f2f1364/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d0c9e124895abac635b225
        failing since 131 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-07T10:39:22.312351  + set +x

    2023-08-07T10:39:22.319082  <8>[   14.486352] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11221633_1.4.2.3.1>

    2023-08-07T10:39:22.423460  / # #

    2023-08-07T10:39:22.524034  export SHELL=3D/bin/sh

    2023-08-07T10:39:22.524219  #

    2023-08-07T10:39:22.624678  / # export SHELL=3D/bin/sh. /lava-11221633/=
environment

    2023-08-07T10:39:22.624868  =


    2023-08-07T10:39:22.725354  / # . /lava-11221633/environment/lava-11221=
633/bin/lava-test-runner /lava-11221633/1

    2023-08-07T10:39:22.725627  =


    2023-08-07T10:39:22.730014  / # /lava-11221633/bin/lava-test-runner /la=
va-11221633/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d0ca07f173e0237335b238

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-183-g686c84f2f1364/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-183-g686c84f2f1364/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d0ca07f173e0237335b23d
        failing since 131 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-07T10:39:44.789231  <8>[   12.869240] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11221673_1.4.2.3.1>

    2023-08-07T10:39:44.793311  + set +x

    2023-08-07T10:39:44.898835  #

    2023-08-07T10:39:44.900256  =


    2023-08-07T10:39:45.002320  / # #export SHELL=3D/bin/sh

    2023-08-07T10:39:45.003121  =


    2023-08-07T10:39:45.104876  / # export SHELL=3D/bin/sh. /lava-11221673/=
environment

    2023-08-07T10:39:45.105684  =


    2023-08-07T10:39:45.207558  / # . /lava-11221673/environment/lava-11221=
673/bin/lava-test-runner /lava-11221673/1

    2023-08-07T10:39:45.208867  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d0cc72d6e2be802935b1e3

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-183-g686c84f2f1364/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboo=
t.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-183-g686c84f2f1364/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboo=
t.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d0cc72d6e2be802935b21f
        failing since 20 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-07T10:50:07.952130  / # #
    2023-08-07T10:50:08.055253  export SHELL=3D/bin/sh
    2023-08-07T10:50:08.056051  #
    2023-08-07T10:50:08.158039  / # export SHELL=3D/bin/sh. /lava-33268/env=
ironment
    2023-08-07T10:50:08.158840  =

    2023-08-07T10:50:08.260950  / # . /lava-33268/environment/lava-33268/bi=
n/lava-test-runner /lava-33268/1
    2023-08-07T10:50:08.262376  =

    2023-08-07T10:50:08.274864  / # /lava-33268/bin/lava-test-runner /lava-=
33268/1
    2023-08-07T10:50:08.335733  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-07T10:50:08.336278  + cd /lava-33268/1/tests/1_bootrr =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d0cc3ba0910b0aa235b1d9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-183-g686c84f2f1364/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hiho=
pe-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-183-g686c84f2f1364/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hiho=
pe-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d0cc3ba0910b0aa235b1dc
        failing since 6 days (last pass: v5.10.186-10-g5f99a36aeb1c, first =
fail: v5.10.188-107-gc262f74329e1)

    2023-08-07T10:49:07.528441  + set +x
    2023-08-07T10:49:07.529029  <8>[   83.784783] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 993609_1.5.2.4.1>
    2023-08-07T10:49:07.637557  / # #
    2023-08-07T10:49:09.108693  export SHELL=3D/bin/sh
    2023-08-07T10:49:09.130026  #
    2023-08-07T10:49:09.130608  / # export SHELL=3D/bin/sh
    2023-08-07T10:49:11.025429  / # . /lava-993609/environment
    2023-08-07T10:49:14.500560  /lava-993609/bin/lava-test-runner /lava-993=
609/1
    2023-08-07T10:49:14.522360  . /lava-993609/environment
    2023-08-07T10:49:14.522799  / # /lava-993609/bin/lava-test-runner /lava=
-993609/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d0cd49d0c2e864cc35b1ff

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-183-g686c84f2f1364/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/basel=
ine-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-183-g686c84f2f1364/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/basel=
ine-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d0cd49d0c2e864cc35b202
        failing since 20 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-07T10:53:43.945938  + set +x
    2023-08-07T10:53:43.946094  <8>[   83.997964] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 993618_1.5.2.4.1>
    2023-08-07T10:53:44.066587  / # #
    2023-08-07T10:53:45.598582  export SHELL=3D/bin/sh
    2023-08-07T10:53:45.619337  #
    2023-08-07T10:53:45.619546  / # export SHELL=3D/bin/sh
    2023-08-07T10:53:47.619828  / # . /lava-993618/environment
    2023-08-07T10:53:51.298585  /lava-993618/bin/lava-test-runner /lava-993=
618/1
    2023-08-07T10:53:51.320391  . /lava-993618/environment
    2023-08-07T10:53:51.320538  / # /lava-993618/bin/lava-test-runner /lava=
-993618/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d0ce38704710133335b200

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-183-g686c84f2f1364/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/basel=
ine-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-183-g686c84f2f1364/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/basel=
ine-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d0ce38704710133335b203
        failing since 20 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-07T10:57:32.560601  <8>[   84.092572] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-08-07T10:57:32.566632  + set +x
    2023-08-07T10:57:32.566741  <8>[   84.102248] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 993622_1.5.2.4.1>
    2023-08-07T10:57:32.673894  / # #
    2023-08-07T10:57:34.164265  export SHELL=3D/bin/sh
    2023-08-07T10:57:34.188337  #
    2023-08-07T10:57:34.188484  / # export SHELL=3D/bin/sh
    2023-08-07T10:57:36.109866  / # . /lava-993622/environment
    2023-08-07T10:57:39.646765  /lava-993622/bin/lava-test-runner /lava-993=
622/1
    2023-08-07T10:57:39.667537  . /lava-993622/environment =

    ... (16 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d0cbeba514a9380135b1db

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-183-g686c84f2f1364/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7796=
0-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-183-g686c84f2f1364/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7796=
0-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d0cbeba514a9380135b1e0
        failing since 20 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-07T10:49:28.285578  / # #

    2023-08-07T10:49:28.386240  export SHELL=3D/bin/sh

    2023-08-07T10:49:28.386391  #

    2023-08-07T10:49:28.486993  / # export SHELL=3D/bin/sh. /lava-11221768/=
environment

    2023-08-07T10:49:28.487131  =


    2023-08-07T10:49:28.587749  / # . /lava-11221768/environment/lava-11221=
768/bin/lava-test-runner /lava-11221768/1

    2023-08-07T10:49:28.587960  =


    2023-08-07T10:49:28.599440  / # /lava-11221768/bin/lava-test-runner /la=
va-11221768/1

    2023-08-07T10:49:28.641053  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-07T10:49:28.658298  + cd /lav<8>[   16.471658] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11221768_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d0cbfea514a9380135b20e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-183-g686c84f2f1364/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-=
h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-183-g686c84f2f1364/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-=
h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d0cbfea514a9380135b213
        failing since 20 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-07T10:49:45.281792  / # #

    2023-08-07T10:49:45.382655  export SHELL=3D/bin/sh

    2023-08-07T10:49:45.383365  #

    2023-08-07T10:49:45.484646  / # export SHELL=3D/bin/sh. /lava-11221760/=
environment

    2023-08-07T10:49:45.485291  =


    2023-08-07T10:49:45.586607  / # . /lava-11221760/environment/lava-11221=
760/bin/lava-test-runner /lava-11221760/1

    2023-08-07T10:49:45.587757  =


    2023-08-07T10:49:45.590783  / # /lava-11221760/bin/lava-test-runner /la=
va-11221760/1

    2023-08-07T10:49:45.633121  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-07T10:49:45.665681  + cd /lava-1122176<8>[   18.303651] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11221760_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
