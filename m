Return-Path: <stable+bounces-2945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 292CF7FC69A
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 22:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6093281BD9
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 21:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65C94438A;
	Tue, 28 Nov 2023 21:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="VtVr6Mx6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA651998
	for <stable@vger.kernel.org>; Tue, 28 Nov 2023 13:00:33 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-285699ebabcso169423a91.0
        for <stable@vger.kernel.org>; Tue, 28 Nov 2023 13:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701205232; x=1701810032; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zlznnntZ3nR7t+lkLI/IIgC1leGxHfWAupORT1+7Fbc=;
        b=VtVr6Mx6Dx9xMK4it9FCelTsIgbu/JRrKvacXRvdO3VyzxUbVgk7q5/AQ/7W+wnMGe
         qpAKi1vmNpXheiSrTimzOO6WrE5ee5XhzcazkDgtQdAoCa1NfNplnqEOsoPik3LTc55y
         gr+ANLR+yRVWVIGKYWw2XlW1w2wnyyUFvOovp8bUvFH0Gjq1ovDCOsfP1A0xs8e0XiBa
         6Y4D0x0WOKJACyACb8Dm3U4pcriTe016JJr9h+mXijsY6+OkEVk9m+YHjvwnmqMEXcFY
         ATAl6KmynXQM7N36NJE7xtUuNu6fCcvbwmP+7HqA+ldd/Y6bYRC/lPGoOH1AUpF2hxa/
         PSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701205232; x=1701810032;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zlznnntZ3nR7t+lkLI/IIgC1leGxHfWAupORT1+7Fbc=;
        b=If8uC3BFxjrkKO2Ody0g4aAybTcwd/aedvNLQl6YNvEv6EpGC3ibFba/JUGQGNQKde
         aZak/taN8a+SzeSjssYGF+Pqzs46e5PyAgABIZKphtb7CBsCu2TEAHnF44rFe3B3k3UQ
         eHDOlDuYH5mKEEoFvEeokUtmmkPrcnKbbvXPZGZZlNzNqfq+g7nB7Y22IbstIiuMgy9E
         0Zlx7Cq4ltByFYdc267ZG7jeOOeez6PInmATzmLRm+ziujllc7y41w4dEePGdufQ6AT3
         jnZASTMSE0QX4SFJoJh2rAQfAdDLT5DbESF3ZgjK7QXzHQFztRrqAXiucZPKkqa0V0eN
         xDXg==
X-Gm-Message-State: AOJu0Ywmk9AdH8eKyTZtn6UBG823apL1zHxk5Dhy1fwtNnX4IssXAiA3
	Lt1XM/DWnwswcn5rmRMABTSkqpmJCw6dMq401lQ=
X-Google-Smtp-Source: AGHT+IEC45AREsDhxsOAV82v7hv/O4PM50URWEPd0TblZnYA6OiCkMZ1HNKAeA53nUNypI/glVj7/g==
X-Received: by 2002:a17:90b:380c:b0:285:b08a:7817 with SMTP id mq12-20020a17090b380c00b00285b08a7817mr15417599pjb.13.1701205230629;
        Tue, 28 Nov 2023 13:00:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090a4e4600b00285db538b17sm3421706pjl.41.2023.11.28.13.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 13:00:30 -0800 (PST)
Message-ID: <656654ee.170a0220.2a99d.a11b@mx.google.com>
Date: Tue, 28 Nov 2023 13:00:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.201-185-ga30cecbc89f2f
Subject: stable-rc/linux-5.10.y baseline: 148 runs,
 3 regressions (v5.10.201-185-ga30cecbc89f2f)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-5.10.y baseline: 148 runs, 3 regressions (v5.10.201-185-ga3=
0cecbc89f2f)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
rk3288-veyron-jaq  | arm   | lab-collabora | gcc-10   | multi_v7_defconfig =
| 1          =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
| 1          =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
| 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.201-185-ga30cecbc89f2f/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.201-185-ga30cecbc89f2f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      a30cecbc89f2fdb925ceabf97a53ed4f36490b25 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
rk3288-veyron-jaq  | arm   | lab-collabora | gcc-10   | multi_v7_defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/6566223130994ef08a7e4aa5

  Results:     62 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
01-185-ga30cecbc89f2f/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-=
rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
01-185-ga30cecbc89f2f/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-=
rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cros-ec-keyb-probed: https://kernelci.org/test/case/id/=
6566223130994ef08a7e4ad2
        new failure (last pass: v5.10.201-188-g80dc4301c91e1)

    2023-11-28T17:30:03.220690  /lava-12106333/1/../bin/lava-test-case<8>[ =
  20.801515] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dcros-ec-keyb-driver-prese=
nt RESULT=3Dpass>

    2023-11-28T17:30:03.220746  =


    2023-11-28T17:30:04.232589  /lava-12106333/1/../bin/lava-test-case

    2023-11-28T17:30:04.240658  <8>[   21.822541] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-keyb-probed RESULT=3Dfail>
   =

 =



platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
| 1          =


  Details:     https://kernelci.org/test/plan/id/65662288dbbdae7cfe7e4a7b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
01-185-ga30cecbc89f2f/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
01-185-ga30cecbc89f2f/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65662288dbbdae7cfe7e4a84
        failing since 48 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-11-28T17:25:20.105727  <8>[   16.974081] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 445642_1.5.2.4.1>
    2023-11-28T17:25:20.210772  / # #
    2023-11-28T17:25:20.312489  export SHELL=3D/bin/sh
    2023-11-28T17:25:20.313051  #
    2023-11-28T17:25:20.414065  / # export SHELL=3D/bin/sh. /lava-445642/en=
vironment
    2023-11-28T17:25:20.414612  =

    2023-11-28T17:25:20.515650  / # . /lava-445642/environment/lava-445642/=
bin/lava-test-runner /lava-445642/1
    2023-11-28T17:25:20.516536  =

    2023-11-28T17:25:20.521065  / # /lava-445642/bin/lava-test-runner /lava=
-445642/1
    2023-11-28T17:25:20.587188  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
| 1          =


  Details:     https://kernelci.org/test/plan/id/656622a938823134257e4a72

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
01-185-ga30cecbc89f2f/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-=
h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
01-185-ga30cecbc89f2f/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-=
h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656622a938823134257e4a7b
        failing since 48 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-11-28T17:32:16.710486  / # #

    2023-11-28T17:32:16.812605  export SHELL=3D/bin/sh

    2023-11-28T17:32:16.813336  #

    2023-11-28T17:32:16.914755  / # export SHELL=3D/bin/sh. /lava-12106365/=
environment

    2023-11-28T17:32:16.915452  =


    2023-11-28T17:32:17.016883  / # . /lava-12106365/environment/lava-12106=
365/bin/lava-test-runner /lava-12106365/1

    2023-11-28T17:32:17.018003  =


    2023-11-28T17:32:17.034666  / # /lava-12106365/bin/lava-test-runner /la=
va-12106365/1

    2023-11-28T17:32:17.081620  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-28T17:32:17.093837  + cd /lava-1210636<8>[   18.174728] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12106365_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

