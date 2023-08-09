Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302737750E3
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 04:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjHIC2T (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 8 Aug 2023 22:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjHIC2T (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 Aug 2023 22:28:19 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6D7173A
        for <stable@vger.kernel.org>; Tue,  8 Aug 2023 19:28:17 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1c023900f3fso896979fac.0
        for <stable@vger.kernel.org>; Tue, 08 Aug 2023 19:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691548096; x=1692152896;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3mtxHWqV3eK8w9QWTrPPIxjPOqu3eZvWapPEhHBb5zQ=;
        b=SZ4dYFs+SkSOyaKr/n30FqtUGW54h0Y2FbsF9uxjFWXs88chvAT6Lp7tgEYJSnfOiU
         5YJ5THeSJMKAlxKC+qCnohlSvkTdo1+iews5zj/lQOTDEahDMGW0e34X/1dVFWVljsvO
         KsBDNtdk7m4UrvTH7gWkiSsRb3HoJZpExNmB/OlB0QG+skgOt9dirMuk2WjNeVmb+s/D
         hXE0rvBtzDiN4uqlUEIHjB6oRNNaouDnORuUX9z4YuR5LYw5IsWtBsAgYq09BKmeFG3N
         xC2R54Rn98sLWna636nS4NrAhmLqCpeUlm6IcsnTZClDb6HkYJLqrWGjQtcun0TOrB0s
         WPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691548096; x=1692152896;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3mtxHWqV3eK8w9QWTrPPIxjPOqu3eZvWapPEhHBb5zQ=;
        b=OfQVIc2JS4MBNVh+RNsUhfjFJxHTnJzlX2c/gHBo0oqcTOSwin0lgid5TO+cybxOE1
         boXhWEqG/spmxy+41nBAw+vjDImlcQPHwCLjuKcbd0dAwLWJtW/KXeBzwx9HiKC+85UM
         quhlCseX1MrLVK/ZVcfRsOf1SPPu5ZGeTDXO37R1Bl5c5EfspRSm4OwCdFUJmOfO9fNH
         knQoPaLTkJA22VngntK8eDnp30fveP22nftdhMJy/Al9DR61nOrHzM1tugCyBGuQFBk4
         4qLfl8ATUCzwXc4RtTg0z/08MOmcP3P9vhVQv5TsYqPiPQ9aKjnI1zkOYqB9pEWZmbMZ
         OBbg==
X-Gm-Message-State: AOJu0YzEdWM6r7Y1XqbS9lrIYqlNEWkGS8YLM3oEB/9BP7mqlbKvFEYu
        4wrpv0LyISX/nGmFGJGhMDIfd0usJnF9MKojqsirRQ==
X-Google-Smtp-Source: AGHT+IFc15ZtJdJqnoWIYKqe3K22nZ1A0ECumhlcKa7yiF1b9GW69zQhL20l46278HtyaKhk2Dgqgw==
X-Received: by 2002:a05:6871:151:b0:1c0:219b:17f4 with SMTP id z17-20020a056871015100b001c0219b17f4mr1616704oab.5.1691548095803;
        Tue, 08 Aug 2023 19:28:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bm2-20020a056a00320200b0068707966034sm8804086pfb.21.2023.08.08.19.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 19:28:14 -0700 (PDT)
Message-ID: <64d2f9be.050a0220.42dc4.0bd4@mx.google.com>
Date:   Tue, 08 Aug 2023 19:28:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.189-186-g6bbe4c818f99
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.10.y
Subject: stable-rc/linux-5.10.y baseline: 120 runs,
 11 regressions (v5.10.189-186-g6bbe4c818f99)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y baseline: 120 runs, 11 regressions (v5.10.189-186-g6=
bbe4c818f99)

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
nel/v5.10.189-186-g6bbe4c818f99/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.189-186-g6bbe4c818f99
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      6bbe4c818f996eb36691875374062ff46920c95d =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2c8c49ca05146c835b1e5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-186-g6bbe4c818f99/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-186-g6bbe4c818f99/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2c8c49ca05146c835b1ea
        failing since 203 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-08-08T22:58:59.561372  + set +x<8>[   11.067741] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3733997_1.5.2.4.1>
    2023-08-08T22:58:59.562108  =

    2023-08-08T22:58:59.671211  / # #
    2023-08-08T22:58:59.774765  export SHELL=3D/bin/sh
    2023-08-08T22:58:59.775298  #
    2023-08-08T22:58:59.876545  / # export SHELL=3D/bin/sh. /lava-3733997/e=
nvironment
    2023-08-08T22:58:59.877029  =

    2023-08-08T22:58:59.978470  / # . /lava-3733997/environment/lava-373399=
7/bin/lava-test-runner /lava-3733997/1
    2023-08-08T22:58:59.979259  =

    2023-08-08T22:58:59.987155  / # /lava-3733997/bin/lava-test-runner /lav=
a-3733997/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2c89e4b7a80659635b1ec

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-186-g6bbe4c818f99/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rd=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-186-g6bbe4c818f99/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rd=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2c89e4b7a80659635b1ef
        failing since 21 days (last pass: v5.10.142, first fail: v5.10.186-=
332-gf98a4d3a5cec)

    2023-08-08T22:58:28.094708  + [   13.191109] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1241906_1.5.2.4.1>
    2023-08-08T22:58:28.095058  set +x
    2023-08-08T22:58:28.201218  =

    2023-08-08T22:58:28.302395  / # #export SHELL=3D/bin/sh
    2023-08-08T22:58:28.302978  =

    2023-08-08T22:58:28.404047  / # export SHELL=3D/bin/sh. /lava-1241906/e=
nvironment
    2023-08-08T22:58:28.404492  =

    2023-08-08T22:58:28.505459  / # . /lava-1241906/environment/lava-124190=
6/bin/lava-test-runner /lava-1241906/1
    2023-08-08T22:58:28.506198  =

    2023-08-08T22:58:28.510024  / # /lava-1241906/bin/lava-test-runner /lav=
a-1241906/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2c8a176a64c260b35b1f9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-186-g6bbe4c818f99/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rd=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-186-g6bbe4c818f99/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rd=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2c8a176a64c260b35b1fc
        failing since 158 days (last pass: v5.10.155, first fail: v5.10.172)

    2023-08-08T22:58:16.342384  [   14.936855] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1241907_1.5.2.4.1>
    2023-08-08T22:58:16.446334  =

    2023-08-08T22:58:16.547760  / # #export SHELL=3D/bin/sh
    2023-08-08T22:58:16.548088  =

    2023-08-08T22:58:16.648701  / # export SHELL=3D/bin/sh. /lava-1241907/e=
nvironment
    2023-08-08T22:58:16.648981  =

    2023-08-08T22:58:16.749602  / # . /lava-1241907/environment/lava-124190=
7/bin/lava-test-runner /lava-1241907/1
    2023-08-08T22:58:16.750011  =

    2023-08-08T22:58:16.752875  / # /lava-1241907/bin/lava-test-runner /lav=
a-1241907/1
    2023-08-08T22:58:16.770120  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2c72f02ac7275de35b1da

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-186-g6bbe4c818f99/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-186-g6bbe4c818f99/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2c72f02ac7275de35b1df
        failing since 133 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-08T22:52:56.411309  + <8>[   10.267617] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11237742_1.4.2.3.1>

    2023-08-08T22:52:56.411424  set +x

    2023-08-08T22:52:56.512525  #

    2023-08-08T22:52:56.613422  / # #export SHELL=3D/bin/sh

    2023-08-08T22:52:56.613659  =


    2023-08-08T22:52:56.714232  / # export SHELL=3D/bin/sh. /lava-11237742/=
environment

    2023-08-08T22:52:56.714441  =


    2023-08-08T22:52:56.815015  / # . /lava-11237742/environment/lava-11237=
742/bin/lava-test-runner /lava-11237742/1

    2023-08-08T22:52:56.815362  =


    2023-08-08T22:52:56.820207  / # /lava-11237742/bin/lava-test-runner /la=
va-11237742/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2c74402ac7275de35b20f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-186-g6bbe4c818f99/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-186-g6bbe4c818f99/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2c74402ac7275de35b214
        failing since 133 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-08T22:52:27.574578  <8>[   12.602325] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11237726_1.4.2.3.1>

    2023-08-08T22:52:27.578051  + set +x

    2023-08-08T22:52:27.683055  #

    2023-08-08T22:52:27.684214  =


    2023-08-08T22:52:27.785910  / # #export SHELL=3D/bin/sh

    2023-08-08T22:52:27.786606  =


    2023-08-08T22:52:27.887876  / # export SHELL=3D/bin/sh. /lava-11237726/=
environment

    2023-08-08T22:52:27.888562  =


    2023-08-08T22:52:27.989884  / # . /lava-11237726/environment/lava-11237=
726/bin/lava-test-runner /lava-11237726/1

    2023-08-08T22:52:27.991024  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2c95a9eb16409ec35b208

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-186-g6bbe4c818f99/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-186-g6bbe4c818f99/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2c95a9eb16409ec35b20b
        failing since 21 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-08T23:01:29.108146  + set +x
    2023-08-08T23:01:29.111441  <8>[   83.739104] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 994487_1.5.2.4.1>
    2023-08-08T23:01:29.218473  / # #
    2023-08-08T23:01:30.680146  export SHELL=3D/bin/sh
    2023-08-08T23:01:30.700935  #
    2023-08-08T23:01:30.701126  / # export SHELL=3D/bin/sh
    2023-08-08T23:01:32.584232  / # . /lava-994487/environment
    2023-08-08T23:01:36.038570  /lava-994487/bin/lava-test-runner /lava-994=
487/1
    2023-08-08T23:01:36.059647  . /lava-994487/environment
    2023-08-08T23:01:36.059981  / # /lava-994487/bin/lava-test-runner /lava=
-994487/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2ca236da113bde235b1ef

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-186-g6bbe4c818f99/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-186-g6bbe4c818f99/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2ca236da113bde235b1f2
        failing since 21 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-08T23:04:43.356981  + set +x
    2023-08-08T23:04:43.357193  <8>[   83.948938] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 994483_1.5.2.4.1>
    2023-08-08T23:04:43.464391  / # #
    2023-08-08T23:04:44.927209  export SHELL=3D/bin/sh
    2023-08-08T23:04:44.947861  #
    2023-08-08T23:04:44.948070  / # export SHELL=3D/bin/sh
    2023-08-08T23:04:46.833439  / # . /lava-994483/environment
    2023-08-08T23:04:50.291446  /lava-994483/bin/lava-test-runner /lava-994=
483/1
    2023-08-08T23:04:50.312326  . /lava-994483/environment
    2023-08-08T23:04:50.312438  / # /lava-994483/bin/lava-test-runner /lava=
-994483/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2c8d09ca05146c835b1f8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-186-g6bbe4c818f99/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-186-g6bbe4c818f99/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2c8d09ca05146c835b1fb
        failing since 21 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-08T22:58:57.023514  / # #
    2023-08-08T22:58:58.483281  export SHELL=3D/bin/sh
    2023-08-08T22:58:58.503725  #
    2023-08-08T22:58:58.503844  / # export SHELL=3D/bin/sh
    2023-08-08T22:59:00.386228  / # . /lava-994470/environment
    2023-08-08T22:59:03.838812  /lava-994470/bin/lava-test-runner /lava-994=
470/1
    2023-08-08T22:59:03.859456  . /lava-994470/environment
    2023-08-08T22:59:03.859584  / # /lava-994470/bin/lava-test-runner /lava=
-994470/1
    2023-08-08T22:59:03.937813  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-08T22:59:03.937946  + cd /lava-994470/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2c9d3d25849c43535b1da

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-186-g6bbe4c818f99/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-186-g6bbe4c818f99/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2c9d4d25849c43535b1dd
        failing since 21 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-08T23:03:35.402952  / # #
    2023-08-08T23:03:36.866800  export SHELL=3D/bin/sh
    2023-08-08T23:03:36.887380  #
    2023-08-08T23:03:36.887586  / # export SHELL=3D/bin/sh
    2023-08-08T23:03:38.772543  / # . /lava-994486/environment
    2023-08-08T23:03:42.229946  /lava-994486/bin/lava-test-runner /lava-994=
486/1
    2023-08-08T23:03:42.250804  . /lava-994486/environment
    2023-08-08T23:03:42.250915  / # /lava-994486/bin/lava-test-runner /lava=
-994486/1
    2023-08-08T23:03:42.330552  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-08T23:03:42.330863  + cd /lava-994486/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2c8378c1299827d35b1d9

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-186-g6bbe4c818f99/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-186-g6bbe4c818f99/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2c8378c1299827d35b1de
        failing since 21 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-08T22:58:22.134978  / # #

    2023-08-08T22:58:22.237121  export SHELL=3D/bin/sh

    2023-08-08T22:58:22.237824  #

    2023-08-08T22:58:22.339270  / # export SHELL=3D/bin/sh. /lava-11237810/=
environment

    2023-08-08T22:58:22.339973  =


    2023-08-08T22:58:22.441437  / # . /lava-11237810/environment/lava-11237=
810/bin/lava-test-runner /lava-11237810/1

    2023-08-08T22:58:22.442539  =


    2023-08-08T22:58:22.458914  / # /lava-11237810/bin/lava-test-runner /la=
va-11237810/1

    2023-08-08T22:58:22.508275  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-08T22:58:22.508779  + cd /lav<8>[   16.442229] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11237810_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2c84d819d26950335b221

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-186-g6bbe4c818f99/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-186-g6bbe4c818f99/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2c84d819d26950335b226
        failing since 21 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-08T22:58:37.371390  / # #

    2023-08-08T22:58:37.472191  export SHELL=3D/bin/sh

    2023-08-08T22:58:37.472441  #

    2023-08-08T22:58:37.573042  / # export SHELL=3D/bin/sh. /lava-11237819/=
environment

    2023-08-08T22:58:37.573306  =


    2023-08-08T22:58:37.673891  / # . /lava-11237819/environment/lava-11237=
819/bin/lava-test-runner /lava-11237819/1

    2023-08-08T22:58:37.674273  =


    2023-08-08T22:58:37.684725  / # /lava-11237819/bin/lava-test-runner /la=
va-11237819/1

    2023-08-08T22:58:37.746735  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-08T22:58:37.746898  + cd /lava-1123781<8>[   18.288421] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11237819_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
