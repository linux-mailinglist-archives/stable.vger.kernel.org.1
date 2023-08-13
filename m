Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A5377A45D
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 02:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjHMApn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 20:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjHMApn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 20:45:43 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD3D10EB
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 17:45:44 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bc7e65ea44so22040735ad.1
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 17:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691887543; x=1692492343;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zjCnf18tfXlxhVQn+GwPywfJ5nu6SJzNHVKmW1XW6Qw=;
        b=EistWHHug49haJv1h3/pU/PH4V1u4YVfWuFkMhi5ZkxFfLQCOty+3iiUboojq6VRRK
         z3JTCCxnm56p+McXbf9kUrk8Sxr3QsuKTdv6yo3A+0GoKNslxwMe5nwX1gIvpQOuLf/w
         fqV1b08B7kqt3QLt2hK77sP2ahnU9CQenkf2KBKy/Wj8FEpkhu72mpqR/8loTbQ/RBHP
         7hNNEiFQ8NqyYgdcPzJnOA7WgUOjI3P24gi82/1zUQO7Po6M4Y9WNb+ws8n+uPAkfcE3
         Pa7ppM3qBlajrzPW/sSZElwZKlqQRBLavtipM4dslylAyIuow5IAdpOztV54QFg9dSg0
         vETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691887543; x=1692492343;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zjCnf18tfXlxhVQn+GwPywfJ5nu6SJzNHVKmW1XW6Qw=;
        b=R4ZRah9R+gq/0M8e5RnoMHjxsJsI9d+99F6w2ida4Ta+T3HlOH60AId8k7TWXSz9/3
         1lPc6YwWgGVvybH4gfoABe/d4zAVPRwuqSONGJcMwL8eTht5dGzaSMSSXgQcks+0WtVV
         RHyLfLVajaxd8+5hRmTw/MULwwW34vQVHGpG1jOAqDH3+m1HAhFEcgi+/y3TICoI9KPC
         GW6M5SaAVywiB4PuzJVbEk7oVrdPBryuQt5B14d/S1YynZfeVty0qE43+7SMWAFdMAfB
         0Ih1TBwR9Gl2JsNIbnNPg4b8U2dTWE4tw/N2KoqVUT+aHwMjNb6yBYqmTj/WugxPsZaS
         yg9g==
X-Gm-Message-State: AOJu0Yyf5V7Q4F74g7aEtu+RcyedTwkLsZVjp8nQNdpoNC9oOvZuCo30
        C6lSQ+BrfY7iDLeHBxbTdF0bts/ShwBMUNmqeFGiRA==
X-Google-Smtp-Source: AGHT+IFmY/rejPFdBJ3x99KvjiEbj5vUVIZrizaiX8r95l09UXU4qX3hW2ket0ojQ+mBvHT6QDCASw==
X-Received: by 2002:a17:902:cf46:b0:1bb:c7bc:ceb8 with SMTP id e6-20020a170902cf4600b001bbc7bcceb8mr8977347plg.22.1691887543191;
        Sat, 12 Aug 2023 17:45:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b16-20020a170902b61000b001b80d399730sm6437187pls.242.2023.08.12.17.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 17:45:42 -0700 (PDT)
Message-ID: <64d827b6.170a0220.5d138.baaa@mx.google.com>
Date:   Sat, 12 Aug 2023 17:45:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.190-56-g3dbd538340c6
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.10.y
Subject: stable-rc/linux-5.10.y baseline: 127 runs,
 12 regressions (v5.10.190-56-g3dbd538340c6)
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

stable-rc/linux-5.10.y baseline: 127 runs, 12 regressions (v5.10.190-56-g3d=
bd538340c6)

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

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.190-56-g3dbd538340c6/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.190-56-g3dbd538340c6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      3dbd538340c63540e85e51e9946f4f37288e415d =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d7f56b54cfa03b8535b296

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-56-g3dbd538340c6/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-56-g3dbd538340c6/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d7f56b54cfa03b8535b29b
        failing since 206 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-08-12T21:10:28.181826  + set +x<8>[   11.098335] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3739683_1.5.2.4.1>
    2023-08-12T21:10:28.182248  =

    2023-08-12T21:10:28.291191  / # #
    2023-08-12T21:10:28.395107  export SHELL=3D/bin/sh
    2023-08-12T21:10:28.395581  #
    2023-08-12T21:10:28.496862  / # export SHELL=3D/bin/sh. /lava-3739683/e=
nvironment
    2023-08-12T21:10:28.497213  =

    2023-08-12T21:10:28.497391  / # <3>[   11.372839] Bluetooth: hci0: comm=
and 0xfc18 tx timeout
    2023-08-12T21:10:28.598456  . /lava-3739683/environment/lava-3739683/bi=
n/lava-test-runner /lava-3739683/1
    2023-08-12T21:10:28.598990   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d7f692418ec8a9f335b1f7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-56-g3dbd538340c6/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-56-g3dbd538340c6/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d7f692418ec8a9f335b1fa
        failing since 25 days (last pass: v5.10.142, first fail: v5.10.186-=
332-gf98a4d3a5cec)

    2023-08-12T21:15:36.711078  [    9.728529] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1243282_1.5.2.4.1>
    2023-08-12T21:15:36.816934  =

    2023-08-12T21:15:36.918109  / # #export SHELL=3D/bin/sh
    2023-08-12T21:15:36.918649  =

    2023-08-12T21:15:37.019695  / # export SHELL=3D/bin/sh. /lava-1243282/e=
nvironment
    2023-08-12T21:15:37.020099  =

    2023-08-12T21:15:37.121061  / # . /lava-1243282/environment/lava-124328=
2/bin/lava-test-runner /lava-1243282/1
    2023-08-12T21:15:37.121761  =

    2023-08-12T21:15:37.126071  / # /lava-1243282/bin/lava-test-runner /lav=
a-1243282/1
    2023-08-12T21:15:37.143614  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d7f6e511ca9c266535b31b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-56-g3dbd538340c6/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-56-g3dbd538340c6/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d7f6e511ca9c266535b31e
        failing since 162 days (last pass: v5.10.155, first fail: v5.10.172)

    2023-08-12T21:17:10.428575  [   14.578963] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1243280_1.5.2.4.1>
    2023-08-12T21:17:10.534625  =

    2023-08-12T21:17:10.635907  / # #export SHELL=3D/bin/sh
    2023-08-12T21:17:10.636356  =

    2023-08-12T21:17:10.737359  / # export SHELL=3D/bin/sh. /lava-1243280/e=
nvironment
    2023-08-12T21:17:10.737944  =

    2023-08-12T21:17:10.839018  / # . /lava-1243280/environment/lava-124328=
0/bin/lava-test-runner /lava-1243280/1
    2023-08-12T21:17:10.839826  =

    2023-08-12T21:17:10.843666  / # /lava-1243280/bin/lava-test-runner /lav=
a-1243280/1
    2023-08-12T21:17:10.857069  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d7f5f6be0b26533035b1ee

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-56-g3dbd538340c6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-56-g3dbd538340c6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d7f5f6be0b26533035b1f3
        failing since 137 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-12T21:13:48.640420  + set +x

    2023-08-12T21:13:48.647498  <8>[   12.000995] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11274258_1.4.2.3.1>

    2023-08-12T21:13:48.751498  / # #

    2023-08-12T21:13:48.852138  export SHELL=3D/bin/sh

    2023-08-12T21:13:48.852328  #

    2023-08-12T21:13:48.953219  / # export SHELL=3D/bin/sh. /lava-11274258/=
environment

    2023-08-12T21:13:48.953914  =


    2023-08-12T21:13:49.055424  / # . /lava-11274258/environment/lava-11274=
258/bin/lava-test-runner /lava-11274258/1

    2023-08-12T21:13:49.055705  =


    2023-08-12T21:13:49.060069  / # /lava-11274258/bin/lava-test-runner /la=
va-11274258/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d7f5aac3b7ac33ee35b229

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-56-g3dbd538340c6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-56-g3dbd538340c6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d7f5aac3b7ac33ee35b22e
        failing since 137 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-12T21:11:53.756822  + set +x

    2023-08-12T21:11:53.763155  <8>[   12.249138] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11274259_1.4.2.3.1>

    2023-08-12T21:11:53.865090  =


    2023-08-12T21:11:53.965674  / # #export SHELL=3D/bin/sh

    2023-08-12T21:11:53.965938  =


    2023-08-12T21:11:54.066523  / # export SHELL=3D/bin/sh. /lava-11274259/=
environment

    2023-08-12T21:11:54.066744  =


    2023-08-12T21:11:54.167278  / # . /lava-11274259/environment/lava-11274=
259/bin/lava-test-runner /lava-11274259/1

    2023-08-12T21:11:54.167599  =


    2023-08-12T21:11:54.173355  / # /lava-11274259/bin/lava-test-runner /la=
va-11274259/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d7f6b35cefc4f68a35b23e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-56-g3dbd538340c6/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hihope=
-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-56-g3dbd538340c6/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hihope=
-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d7f6b35cefc4f68a35b241
        failing since 11 days (last pass: v5.10.186-10-g5f99a36aeb1c, first=
 fail: v5.10.188-107-gc262f74329e1)

    2023-08-12T21:16:12.171931  + set +x
    2023-08-12T21:16:12.172497  <8>[   83.806275] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 996430_1.5.2.4.1>
    2023-08-12T21:16:12.280774  / # #
    2023-08-12T21:16:13.752326  export SHELL=3D/bin/sh
    2023-08-12T21:16:13.773561  #
    2023-08-12T21:16:13.774110  / # export SHELL=3D/bin/sh
    2023-08-12T21:16:15.668571  / # . /lava-996430/environment
    2023-08-12T21:16:19.143114  /lava-996430/bin/lava-test-runner /lava-996=
430/1
    2023-08-12T21:16:19.163945  . /lava-996430/environment
    2023-08-12T21:16:19.164059  / # /lava-996430/bin/lava-test-runner /lava=
-996430/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d7f74541feca598735b1f5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-56-g3dbd538340c6/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baselin=
e-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-56-g3dbd538340c6/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baselin=
e-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d7f74541feca598735b1f8
        failing since 25 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-12T21:18:41.152787  + set +x
    2023-08-12T21:18:41.155943  <8>[   83.737865] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 996437_1.5.2.4.1>
    2023-08-12T21:18:41.262955  / # #
    2023-08-12T21:18:42.727346  export SHELL=3D/bin/sh
    2023-08-12T21:18:42.748300  #
    2023-08-12T21:18:42.748729  / # export SHELL=3D/bin/sh
    2023-08-12T21:18:44.636276  / # . /lava-996437/environment
    2023-08-12T21:18:48.097362  /lava-996437/bin/lava-test-runner /lava-996=
437/1
    2023-08-12T21:18:48.118852  . /lava-996437/environment
    2023-08-12T21:18:48.119273  / # /lava-996437/bin/lava-test-runner /lava=
-996437/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d7f857e3cb5d386c35b1dc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-56-g3dbd538340c6/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baselin=
e-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-56-g3dbd538340c6/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baselin=
e-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d7f857e3cb5d386c35b1df
        failing since 25 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-12T21:23:23.894856  + set +x
    2023-08-12T21:23:23.895072  <8>[   84.012075] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 996435_1.5.2.4.1>
    2023-08-12T21:23:24.001565  / # #
    2023-08-12T21:23:25.464587  export SHELL=3D/bin/sh
    2023-08-12T21:23:25.485176  #
    2023-08-12T21:23:25.485384  / # export SHELL=3D/bin/sh
    2023-08-12T21:23:27.370899  / # . /lava-996435/environment
    2023-08-12T21:23:30.833827  /lava-996435/bin/lava-test-runner /lava-996=
435/1
    2023-08-12T21:23:30.854668  . /lava-996435/environment
    2023-08-12T21:23:30.854776  / # /lava-996435/bin/lava-test-runner /lava=
-996435/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d7f6db11ca9c266535b2ea

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-56-g3dbd538340c6/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.=
txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-56-g3dbd538340c6/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d7f6db11ca9c266535b2ed
        failing since 25 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-12T21:17:00.141079  / # #
    2023-08-12T21:17:01.600657  export SHELL=3D/bin/sh
    2023-08-12T21:17:01.621171  #
    2023-08-12T21:17:01.621331  / # export SHELL=3D/bin/sh
    2023-08-12T21:17:03.503691  / # . /lava-996427/environment
    2023-08-12T21:17:06.955915  /lava-996427/bin/lava-test-runner /lava-996=
427/1
    2023-08-12T21:17:06.976535  . /lava-996427/environment
    2023-08-12T21:17:06.976645  / # /lava-996427/bin/lava-test-runner /lava=
-996427/1
    2023-08-12T21:17:07.055316  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-12T21:17:07.055467  + cd /lava-996427/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d7f7ca036b118ee435b384

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-56-g3dbd538340c6/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baselin=
e-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-56-g3dbd538340c6/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baselin=
e-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d7f7ca036b118ee435b387
        failing since 25 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-12T21:20:51.894909  / # #
    2023-08-12T21:20:53.354719  export SHELL=3D/bin/sh
    2023-08-12T21:20:53.375171  #
    2023-08-12T21:20:53.375322  / # export SHELL=3D/bin/sh
    2023-08-12T21:20:55.257842  / # . /lava-996433/environment
    2023-08-12T21:20:58.710851  /lava-996433/bin/lava-test-runner /lava-996=
433/1
    2023-08-12T21:20:58.731798  . /lava-996433/environment
    2023-08-12T21:20:58.731926  / # /lava-996433/bin/lava-test-runner /lava=
-996433/1
    2023-08-12T21:20:58.811458  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-12T21:20:58.811671  + cd /lava-996433/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d7f65b84368f0dd135b23e

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-56-g3dbd538340c6/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-56-g3dbd538340c6/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d7f65b84368f0dd135b243
        failing since 25 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-12T21:16:27.894522  / # #

    2023-08-12T21:16:27.996665  export SHELL=3D/bin/sh

    2023-08-12T21:16:27.997423  #

    2023-08-12T21:16:28.098844  / # export SHELL=3D/bin/sh. /lava-11274334/=
environment

    2023-08-12T21:16:28.099563  =


    2023-08-12T21:16:28.201016  / # . /lava-11274334/environment/lava-11274=
334/bin/lava-test-runner /lava-11274334/1

    2023-08-12T21:16:28.202119  =


    2023-08-12T21:16:28.218435  / # /lava-11274334/bin/lava-test-runner /la=
va-11274334/1

    2023-08-12T21:16:28.267902  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-12T21:16:28.268404  + cd /lav<8>[   16.451854] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11274334_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d7f66fb7dc2c058535b2cf

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-56-g3dbd538340c6/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-56-g3dbd538340c6/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d7f66fb7dc2c058535b2d4
        failing since 25 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-12T21:16:42.050716  / # #

    2023-08-12T21:16:42.152849  export SHELL=3D/bin/sh

    2023-08-12T21:16:42.153582  #

    2023-08-12T21:16:42.255002  / # export SHELL=3D/bin/sh. /lava-11274332/=
environment

    2023-08-12T21:16:42.255728  =


    2023-08-12T21:16:42.357101  / # . /lava-11274332/environment/lava-11274=
332/bin/lava-test-runner /lava-11274332/1

    2023-08-12T21:16:42.358176  =


    2023-08-12T21:16:42.375000  / # /lava-11274332/bin/lava-test-runner /la=
va-11274332/1

    2023-08-12T21:16:42.417502  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-12T21:16:42.432783  + cd /lava-1127433<8>[   18.345139] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11274332_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
