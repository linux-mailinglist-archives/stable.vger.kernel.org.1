Return-Path: <stable+bounces-5080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE82680B1C7
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 03:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 038D41C20CC5
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 02:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B607810;
	Sat,  9 Dec 2023 02:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="PAex1TJn"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E77EA
	for <stable@vger.kernel.org>; Fri,  8 Dec 2023 18:44:32 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6d9d4193d94so1724108a34.3
        for <stable@vger.kernel.org>; Fri, 08 Dec 2023 18:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702089870; x=1702694670; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mCD4EhaDxINCjAgxBRTZkOasDb9Rg7Qgj/5V0VJR1PU=;
        b=PAex1TJnvUN4aDmEzX8Iz7lV0DaAWP8PenelJ+0DmTJqAmScgDzfiX0w4kFhC/3Rhx
         D4MTFcPUr7tRi5oEwKdgrttWaaTmcJ5a21UW+5/7ylfB+ZveYHc3hP853y2P237II9jL
         DLb0WnXyTGND3KNTyjWjbOgny8VZ0yyhMw9qdKMOc25C5TvuSKGL1WJmJXBOgG3JZm+K
         Nlxan7IDNixfpxmUPprsv7hG8BMKlmzSYyyciAMNBPXCipfOYvcUu1M8h52cunygL5bT
         sH5VLltzxCWopjkMBlDzbT1M1LM09TJYnKB1zrUq3UPegxNrhggt3TEkJamABtcMXKwg
         R57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702089870; x=1702694670;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mCD4EhaDxINCjAgxBRTZkOasDb9Rg7Qgj/5V0VJR1PU=;
        b=RgulhXFmIcXljyqtxmYWfLXHHjKC38TKZJjrbdPvCKxV17DiIvcYZDLhF4DktC74If
         uoQ2hsHPYGZXLOJZ//LQYgbR6qxUDd2g5yMQ1SrUWKCAONV0uB0tvw8hUhTuqJq4PPck
         32xcJ5OUGcMnlzBbe5qaaF6eOhnq3A6bt8StE5Rz85F748C98O+xjWGIqzsjh9AicogV
         qDIsjTHQQmtU95qOqNM76tmm/q1y2g1z9UF0l8dpWsEAQl7mHlEKA3/ltAitXlKpIivR
         RtMVOoH4KAvp9IAjST1r2J4R/E+CCRq782Fw+5grSrXq3uJlBvE9w9KdF0bkkyu3FicG
         Haig==
X-Gm-Message-State: AOJu0YwSf1nexc9EpY15I7IMuvBW3YrTzPajjkA4wa2eyqVWi9o8kuvU
	9PARiXexPRHfD/QQADbSmb54Ey0svn4uUDvLHV/n/Q==
X-Google-Smtp-Source: AGHT+IF1OmpHA93jJeWYc7fyxF4JV3CNzxiCUf9gmGE+tXMLjMJ2e3f513f4DLQp0UZHmSKj7i+WkA==
X-Received: by 2002:a05:6830:168c:b0:6d8:74e2:c08c with SMTP id k12-20020a056830168c00b006d874e2c08cmr1198531otr.62.1702089870114;
        Fri, 08 Dec 2023 18:44:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y4-20020a62f244000000b006ce809948adsm2266395pfl.30.2023.12.08.18.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 18:44:29 -0800 (PST)
Message-ID: <6573d48d.620a0220.52ff9.88bf@mx.google.com>
Date: Fri, 08 Dec 2023 18:44:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.142-8-g5d3692481649b
Subject: stable-rc/queue/5.15 baseline: 161 runs,
 8 regressions (v5.15.142-8-g5d3692481649b)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 161 runs, 8 regressions (v5.15.142-8-g5d3692=
481649b)

Regressions Summary
-------------------

platform               | arch  | lab           | compiler | defconfig      =
     | regressions
-----------------------+-------+---------------+----------+----------------=
-----+------------
beagle-xm              | arm   | lab-baylibre  | gcc-10   | omap2plus_defco=
nfig | 1          =

meson-gxbb-p200        | arm64 | lab-baylibre  | gcc-10   | defconfig      =
     | 1          =

panda                  | arm   | lab-baylibre  | gcc-10   | multi_v7_defcon=
fig  | 1          =

r8a77960-ulcb          | arm64 | lab-collabora | gcc-10   | defconfig      =
     | 1          =

sun50i-a64-pine64-plus | arm64 | lab-baylibre  | gcc-10   | defconfig      =
     | 1          =

sun50i-a64-pine64-plus | arm64 | lab-broonie   | gcc-10   | defconfig      =
     | 1          =

sun50i-h6-pine-h64     | arm64 | lab-clabbe    | gcc-10   | defconfig      =
     | 1          =

sun50i-h6-pine-h64     | arm64 | lab-collabora | gcc-10   | defconfig      =
     | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.142-8-g5d3692481649b/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.142-8-g5d3692481649b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      5d3692481649bb0abef3b516132da3ca931a34ea =



Test Regressions
---------------- =



platform               | arch  | lab           | compiler | defconfig      =
     | regressions
-----------------------+-------+---------------+----------+----------------=
-----+------------
beagle-xm              | arm   | lab-baylibre  | gcc-10   | omap2plus_defco=
nfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6573a3c8b355352b1ae1347d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-8-g5d3692481649b/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-8-g5d3692481649b/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6573a3c8b355352b1ae13=
47e
        failing since 308 days (last pass: v5.15.91-12-g3290f78df1ab, first=
 fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform               | arch  | lab           | compiler | defconfig      =
     | regressions
-----------------------+-------+---------------+----------+----------------=
-----+------------
meson-gxbb-p200        | arm64 | lab-baylibre  | gcc-10   | defconfig      =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/6573a270f6ddb38b39e134c4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-8-g5d3692481649b/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p=
200.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-8-g5d3692481649b/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p=
200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6573a270f6ddb38b39e13=
4c5
        failing since 0 day (last pass: v5.15.112-273-gd9a33ebea341, first =
fail: v5.15.142-8-ge5a5d1af708ec) =

 =



platform               | arch  | lab           | compiler | defconfig      =
     | regressions
-----------------------+-------+---------------+----------+----------------=
-----+------------
panda                  | arm   | lab-baylibre  | gcc-10   | multi_v7_defcon=
fig  | 1          =


  Details:     https://kernelci.org/test/plan/id/6573a0e13c7b47da42e134d4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-8-g5d3692481649b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-panda=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-8-g5d3692481649b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-panda=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6573a0e13c7b47da42e134dd
        failing since 2 days (last pass: v5.15.74-135-g19e8e8e20e2b, first =
fail: v5.15.141-64-g41591b7f348c5)

    2023-12-08T23:03:40.515479  <8>[   11.959869] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3867967_1.5.2.4.1>
    2023-12-08T23:03:40.620178  / # #
    2023-12-08T23:03:40.721330  export SHELL=3D/bin/sh
    2023-12-08T23:03:40.721688  #
    2023-12-08T23:03:40.822475  / # export SHELL=3D/bin/sh. /lava-3867967/e=
nvironment
    2023-12-08T23:03:40.822929  =

    2023-12-08T23:03:40.923791  / # . /lava-3867967/environment/lava-386796=
7/bin/lava-test-runner /lava-3867967/1
    2023-12-08T23:03:40.924618  =

    2023-12-08T23:03:40.928568  / # /lava-3867967/bin/lava-test-runner /lav=
a-3867967/1
    2023-12-08T23:03:40.989641  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform               | arch  | lab           | compiler | defconfig      =
     | regressions
-----------------------+-------+---------------+----------+----------------=
-----+------------
r8a77960-ulcb          | arm64 | lab-collabora | gcc-10   | defconfig      =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/6573a15937d830953ee134c1

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-8-g5d3692481649b/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-8-g5d3692481649b/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6573a15937d830953ee134ca
        failing since 16 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-08T23:13:19.165636  / # #

    2023-12-08T23:13:19.267801  export SHELL=3D/bin/sh

    2023-12-08T23:13:19.268574  #

    2023-12-08T23:13:19.370035  / # export SHELL=3D/bin/sh. /lava-12222743/=
environment

    2023-12-08T23:13:19.370766  =


    2023-12-08T23:13:19.472136  / # . /lava-12222743/environment/lava-12222=
743/bin/lava-test-runner /lava-12222743/1

    2023-12-08T23:13:19.473456  =


    2023-12-08T23:13:19.488536  / # /lava-12222743/bin/lava-test-runner /la=
va-12222743/1

    2023-12-08T23:13:19.539459  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-08T23:13:19.539972  + cd /lav<8>[   16.056091] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12222743_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform               | arch  | lab           | compiler | defconfig      =
     | regressions
-----------------------+-------+---------------+----------+----------------=
-----+------------
sun50i-a64-pine64-plus | arm64 | lab-baylibre  | gcc-10   | defconfig      =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/6573b89a7b15aff7e2e137b3

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-8-g5d3692481649b/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-p=
ine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-8-g5d3692481649b/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-p=
ine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6573b89b7b15aff7e2e137e1
        failing since 325 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-12-09T00:44:42.393681  + set +x
    2023-12-09T00:44:42.397849  <8>[   16.073578] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3868051_1.5.2.4.1>
    2023-12-09T00:44:42.506984  / # #
    2023-12-09T00:44:42.608163  export SHELL=3D/bin/sh
    2023-12-09T00:44:42.608581  #
    2023-12-09T00:44:42.709360  / # export SHELL=3D/bin/sh. /lava-3868051/e=
nvironment
    2023-12-09T00:44:42.709785  =

    2023-12-09T00:44:42.810492  / # . /lava-3868051/environment/lava-386805=
1/bin/lava-test-runner /lava-3868051/1
    2023-12-09T00:44:42.811037  =

    2023-12-09T00:44:42.815574  / # /lava-3868051/bin/lava-test-runner /lav=
a-3868051/1 =

    ... (12 line(s) more)  =

 =



platform               | arch  | lab           | compiler | defconfig      =
     | regressions
-----------------------+-------+---------------+----------+----------------=
-----+------------
sun50i-a64-pine64-plus | arm64 | lab-broonie   | gcc-10   | defconfig      =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/6573a1b86eb80756cbe13489

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-8-g5d3692481649b/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pi=
ne64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-8-g5d3692481649b/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pi=
ne64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6573a1b96eb80756cbe134ba
        failing since 325 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-12-08T23:06:53.017112  + set +x
    2023-12-08T23:06:53.021107  <8>[   16.045302] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 327669_1.5.2.4.1>
    2023-12-08T23:06:53.131188  / # #
    2023-12-08T23:06:53.233037  export SHELL=3D/bin/sh
    2023-12-08T23:06:53.233558  #
    2023-12-08T23:06:53.335247  / # export SHELL=3D/bin/sh. /lava-327669/en=
vironment
    2023-12-08T23:06:53.335764  =

    2023-12-08T23:06:53.437195  / # . /lava-327669/environment/lava-327669/=
bin/lava-test-runner /lava-327669/1
    2023-12-08T23:06:53.437938  =

    2023-12-08T23:06:53.442576  / # /lava-327669/bin/lava-test-runner /lava=
-327669/1 =

    ... (12 line(s) more)  =

 =



platform               | arch  | lab           | compiler | defconfig      =
     | regressions
-----------------------+-------+---------------+----------+----------------=
-----+------------
sun50i-h6-pine-h64     | arm64 | lab-clabbe    | gcc-10   | defconfig      =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/6573a146f77f444f2ee13476

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-8-g5d3692481649b/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine=
-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-8-g5d3692481649b/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine=
-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6573a146f77f444f2ee1347f
        failing since 16 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-08T23:05:32.922975  <8>[   16.053377] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447157_1.5.2.4.1>
    2023-12-08T23:05:33.028007  / # #
    2023-12-08T23:05:33.129752  export SHELL=3D/bin/sh
    2023-12-08T23:05:33.130370  #
    2023-12-08T23:05:33.231381  / # export SHELL=3D/bin/sh. /lava-447157/en=
vironment
    2023-12-08T23:05:33.232031  =

    2023-12-08T23:05:33.333025  / # . /lava-447157/environment/lava-447157/=
bin/lava-test-runner /lava-447157/1
    2023-12-08T23:05:33.333919  =

    2023-12-08T23:05:33.338161  / # /lava-447157/bin/lava-test-runner /lava=
-447157/1
    2023-12-08T23:05:33.370289  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform               | arch  | lab           | compiler | defconfig      =
     | regressions
-----------------------+-------+---------------+----------+----------------=
-----+------------
sun50i-h6-pine-h64     | arm64 | lab-collabora | gcc-10   | defconfig      =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/6573a16def9ddf63f6e1347c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-8-g5d3692481649b/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-8-g5d3692481649b/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6573a16eef9ddf63f6e13485
        failing since 16 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-08T23:13:34.909600  / # #

    2023-12-08T23:13:35.011771  export SHELL=3D/bin/sh

    2023-12-08T23:13:35.012564  #

    2023-12-08T23:13:35.113988  / # export SHELL=3D/bin/sh. /lava-12222741/=
environment

    2023-12-08T23:13:35.114737  =


    2023-12-08T23:13:35.216179  / # . /lava-12222741/environment/lava-12222=
741/bin/lava-test-runner /lava-12222741/1

    2023-12-08T23:13:35.217357  =


    2023-12-08T23:13:35.234063  / # /lava-12222741/bin/lava-test-runner /la=
va-12222741/1

    2023-12-08T23:13:35.291915  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-08T23:13:35.292466  + cd /lava-1222274<8>[   16.954716] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12222741_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

