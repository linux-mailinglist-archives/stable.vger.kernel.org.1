Return-Path: <stable+bounces-2715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3957F956B
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 22:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE991C2081B
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 21:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4BA12E6B;
	Sun, 26 Nov 2023 21:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="cNoKOxzv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB795DE
	for <stable@vger.kernel.org>; Sun, 26 Nov 2023 13:10:02 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-285b926e5deso599007a91.0
        for <stable@vger.kernel.org>; Sun, 26 Nov 2023 13:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701033002; x=1701637802; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rK5sq2eJvS2zMvlK2l8TSX9JQSJkFsb5rXrwMwDHybg=;
        b=cNoKOxzvU8wL6/6ytYw4+UFKG9QP57zNzhUoAKQB1LzJvRQSjKYde28sablDjzv80Q
         2hDCjF8QoWNRjWxFRWiPXxanVG2G7Q4ErcqSiMiGN4e92g0fMghBE3/CiECR2+6ksurk
         MH8Sqy9jWGFg1UeFJkSTJ1Kq+YdZBE7xdP29yW9j/30G1XAxyyq46shr+gfOOaq5MEh9
         gbxKckauUhEOcYhcyneRcW74ldUoF7rbF0UFzLXNkItIvmdOlgzOqnOcKXf4IL050oN6
         O0rvrVI7LY2sd11iP8xkrnKfu87gAyg6TL1oOMiOHSgFVp1Cu2U4dtwMAi32XqD3B5sj
         rq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701033002; x=1701637802;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rK5sq2eJvS2zMvlK2l8TSX9JQSJkFsb5rXrwMwDHybg=;
        b=Mo0phaLk03Nv1d38+2x1/GNUicxfNwKjmCofTAHWGDo88IMqkOQdQ5Qcpg7/oL31l9
         JCLkDLVsroLE4QPJW3Go8P23QXrwr1t9uqnrXfaSGa4kRrjm970/PTJfRNmQ+QE9ipSm
         7x61s46dxDgTjkpnpIRK/Uq/mWJkuJ3OZWmL9dyiL+PHAtUG+SDPSP3rJr42rYFeFl/6
         Gbqlm68HQWnlDHEZpCKOJJb4xVPe7eK/mZAfMf4Sq8GNKrVO9VQ/u2byqhMfINQBKX6A
         9ZBbE6aGZgOTUtalFoo61qoS1Zs+hrxk6M7m05NtzWIIxSUZD36J2GJ1Z0bFwVHdz3qU
         0nZw==
X-Gm-Message-State: AOJu0Yx1Vh1lRiGWE4cPS4yR3WUo5P8dBcA0qb/sc0hnAsRguXBu6A6r
	PgkAF/NUxXt+rXF6GHiomLEv/3aPiBgBFFZFfOg=
X-Google-Smtp-Source: AGHT+IFvXzaVLOHgLpl1d1qgimRPAKEPR0VCEAIcjn9i2WkW6+eVRYAF4WxHnJKI5vdwPj/H627Vaw==
X-Received: by 2002:a17:90b:4a49:b0:285:ada5:956 with SMTP id lb9-20020a17090b4a4900b00285ada50956mr4676046pjb.42.1701033001594;
        Sun, 26 Nov 2023 13:10:01 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bh2-20020a056a02020200b0059d6f5196fasm5585300pgb.78.2023.11.26.13.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 13:10:01 -0800 (PST)
Message-ID: <6563b429.050a0220.b29ff.b3be@mx.google.com>
Date: Sun, 26 Nov 2023 13:10:01 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.201-187-g1c10a6db4286a
Subject: stable-rc/queue/5.10 baseline: 123 runs,
 7 regressions (v5.10.201-187-g1c10a6db4286a)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 123 runs, 7 regressions (v5.10.201-187-g1c10=
a6db4286a)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig | 1          =

juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
           | 1          =

r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
           | 1          =

rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
           | 1          =

sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
           | 1          =

sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
           | 1          =

sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig  | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.201-187-g1c10a6db4286a/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.201-187-g1c10a6db4286a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      1c10a6db4286ae97118521b3a68a08a7dac41cea =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6563827458e68e05577e4a81

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-187-g1c10a6db4286a/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-187-g1c10a6db4286a/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6563827458e68e05577e4aba
        failing since 285 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-11-26T17:37:43.495120  <8>[   20.642176] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 275447_1.5.2.4.1>
    2023-11-26T17:37:43.603093  / # #
    2023-11-26T17:37:43.705355  export SHELL=3D/bin/sh
    2023-11-26T17:37:43.705967  #
    2023-11-26T17:37:43.807771  / # export SHELL=3D/bin/sh. /lava-275447/en=
vironment
    2023-11-26T17:37:43.808434  =

    2023-11-26T17:37:43.910371  / # . /lava-275447/environment/lava-275447/=
bin/lava-test-runner /lava-275447/1
    2023-11-26T17:37:43.911350  =

    2023-11-26T17:37:43.916272  / # /lava-275447/bin/lava-test-runner /lava=
-275447/1
    2023-11-26T17:37:44.025017  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/6563847d85cd663f047e4ac3

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-187-g1c10a6db4286a/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.=
txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-187-g1c10a6db4286a/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6563847d85cd663f047e4b02
        failing since 4 days (last pass: v5.10.181-18-g1622068b57a4, first =
fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-26T17:46:13.040657  / # #
    2023-11-26T17:46:13.143480  export SHELL=3D/bin/sh
    2023-11-26T17:46:13.144210  #
    2023-11-26T17:46:13.246183  / # export SHELL=3D/bin/sh. /lava-275470/en=
vironment
    2023-11-26T17:46:13.246931  =

    2023-11-26T17:46:13.348898  / # . /lava-275470/environment/lava-275470/=
bin/lava-test-runner /lava-275470/1
    2023-11-26T17:46:13.350183  =

    2023-11-26T17:46:13.364789  / # /lava-275470/bin/lava-test-runner /lava=
-275470/1
    2023-11-26T17:46:13.422670  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-26T17:46:13.423176  + cd /lava-275470/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/656383250f3ef8f7a77e4a79

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-187-g1c10a6db4286a/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-187-g1c10a6db4286a/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656383250f3ef8f7a77e4a82
        failing since 4 days (last pass: v5.10.181-18-g1622068b57a4, first =
fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-26T17:47:14.188402  / # #

    2023-11-26T17:47:14.288951  export SHELL=3D/bin/sh

    2023-11-26T17:47:14.289103  #

    2023-11-26T17:47:14.389576  / # export SHELL=3D/bin/sh. /lava-12090414/=
environment

    2023-11-26T17:47:14.389808  =


    2023-11-26T17:47:14.490332  / # . /lava-12090414/environment/lava-12090=
414/bin/lava-test-runner /lava-12090414/1

    2023-11-26T17:47:14.490634  =


    2023-11-26T17:47:14.501771  / # /lava-12090414/bin/lava-test-runner /la=
va-12090414/1

    2023-11-26T17:47:14.545224  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-26T17:47:14.561075  + cd /lav<8>[   16.449959] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12090414_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/656383619f9521889a7e4a86

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-187-g1c10a6db4286a/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-ro=
ck-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-187-g1c10a6db4286a/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-ro=
ck-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656383619f9521889a7e4a8f
        failing since 4 days (last pass: v5.10.181-18-g1622068b57a4, first =
fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-26T17:41:24.057742  / # #

    2023-11-26T17:41:25.318789  export SHELL=3D/bin/sh

    2023-11-26T17:41:25.329755  #

    2023-11-26T17:41:25.330238  / # export SHELL=3D/bin/sh

    2023-11-26T17:41:27.074038  / # . /lava-12090405/environment

    2023-11-26T17:41:30.279394  /lava-12090405/bin/lava-test-runner /lava-1=
2090405/1

    2023-11-26T17:41:30.290833  . /lava-12090405/environment

    2023-11-26T17:41:30.291976  / # /lava-12090405/bin/lava-test-runner /la=
va-12090405/1

    2023-11-26T17:41:30.346128  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-26T17:41:30.346635  + cd /lava-12090405/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/6563832096e25d42497e4a91

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-187-g1c10a6db4286a/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-187-g1c10a6db4286a/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6563832096e25d42497e4a9a
        failing since 4 days (last pass: v5.10.176-241-ga0049fd9c865, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-26T17:40:42.153496  / # #
    2023-11-26T17:40:42.255400  export SHELL=3D/bin/sh
    2023-11-26T17:40:42.256159  #
    2023-11-26T17:40:42.357254  / # export SHELL=3D/bin/sh. /lava-445387/en=
vironment
    2023-11-26T17:40:42.358068  =

    2023-11-26T17:40:42.459172  / # . /lava-445387/environment/lava-445387/=
bin/lava-test-runner /lava-445387/1
    2023-11-26T17:40:42.460179  =

    2023-11-26T17:40:42.462107  / # /lava-445387/bin/lava-test-runner /lava=
-445387/1
    2023-11-26T17:40:42.494147  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-26T17:40:42.535382  + cd /lava-445387/<8>[   17.441504] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 445387_1.5.2.4.5> =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/65638338e3389fc8297e4a82

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-187-g1c10a6db4286a/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-187-g1c10a6db4286a/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65638338e3389fc8297e4a8b
        failing since 4 days (last pass: v5.10.176-241-ga0049fd9c865, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-26T17:47:28.897339  / # #

    2023-11-26T17:47:28.999436  export SHELL=3D/bin/sh

    2023-11-26T17:47:29.000169  #

    2023-11-26T17:47:29.101601  / # export SHELL=3D/bin/sh. /lava-12090410/=
environment

    2023-11-26T17:47:29.102279  =


    2023-11-26T17:47:29.203524  / # . /lava-12090410/environment/lava-12090=
410/bin/lava-test-runner /lava-12090410/1

    2023-11-26T17:47:29.204540  =


    2023-11-26T17:47:29.205636  / # /lava-12090410/bin/lava-test-runner /la=
va-12090410/1

    2023-11-26T17:47:29.249489  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-26T17:47:29.280720  + cd /lava-1209041<8>[   18.245415] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12090410_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/6563834347fbb84efa7e4a8e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-187-g1c10a6db4286a/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-187-g1c10a6db4286a/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6563834347fbb84efa7e4a97
        failing since 4 days (last pass: v5.10.165-77-g4600242c13ed, first =
fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-26T17:41:01.687422  / # #
    2023-11-26T17:41:01.788657  export SHELL=3D/bin/sh
    2023-11-26T17:41:01.789077  #
    2023-11-26T17:41:01.889868  / # export SHELL=3D/bin/sh. /lava-3848366/e=
nvironment
    2023-11-26T17:41:01.890316  =

    2023-11-26T17:41:01.991150  / # . /lava-3848366/environment/lava-384836=
6/bin/lava-test-runner /lava-3848366/1
    2023-11-26T17:41:01.991886  =

    2023-11-26T17:41:01.999245  / # /lava-3848366/bin/lava-test-runner /lav=
a-3848366/1
    2023-11-26T17:41:02.047396  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-26T17:41:02.087167  + cd /lava-3848366/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20

