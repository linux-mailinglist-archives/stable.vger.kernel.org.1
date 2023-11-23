Return-Path: <stable+bounces-88-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE567F682D
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 21:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95F32281666
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 20:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120604D134;
	Thu, 23 Nov 2023 20:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="iVO4i/lF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B91D44
	for <stable@vger.kernel.org>; Thu, 23 Nov 2023 12:11:30 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b7f0170d7bso1189602b3a.2
        for <stable@vger.kernel.org>; Thu, 23 Nov 2023 12:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700770289; x=1701375089; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R7qQEny/I5IjZo0+r2lmRoyvCs/rVo4V0DHq6gA4GIM=;
        b=iVO4i/lF3ScNImYO8DsTzioRrvPjY/z9SW97Za3KuzH/i7KgO7Jk76Q5xBkApp4wFP
         rr2X/u81jmw9PqghGVriCVFBmC4/65WGbJtxvR5BOH59yw0OapNacvNPWJWhkaH1iyoy
         eMHW8ynMntoYdZ8B09lBHInBiRHTwZ3hD8A+qph2X7eq2LlkIfmvsbyVbxky5jiCdEpL
         y/cxepPZzWRGgL2jOJQoscEjoQIXQdEqE0zpIySX9urBETjSlWGdEkIbmQM1rfIhPkQX
         PNQpwZgH2KrYudFuJBz+yXpOR9yBe/VLubj0arounvFMoigwVs1/ZGzH93FTHPA+Kksv
         WAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700770289; x=1701375089;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R7qQEny/I5IjZo0+r2lmRoyvCs/rVo4V0DHq6gA4GIM=;
        b=UQLhd1r7TpzmwFBrgQGIUr9bL+6QgnzFAoPL0lOXj7irdVRMbhWWx+JPPphHgLaGb1
         C/OGfrpB+O9oeIu15OaZI6BLFCWm97Mcqv49e1QAQ2DNi9neVB36nwgsO7IelDhr0l+k
         +V1uW1jAAl/kESYt9MqycLb8M43wseNdjuFLnMJ4/+cOVs7/CL0hv2mCFQPO3OO0KdLi
         E+FKLPLhi5MrJr8KKDc1sAp/nc7Th9fj3NvWbSMRoTbvbCMTY4rUPt+qv2ZXmht/K/M5
         yt7ysiBOqPC3M6KywR8mcwUPI9t7OnD5/hMk/Qw3Er06Rm2b6h/1d9z1Qsa720T2Orl+
         2OZg==
X-Gm-Message-State: AOJu0YwI6wmO5xafcrdX/7evn3A6f32dPVMdYj0TFg7vjHQ7DYFBBv9u
	NTXGqvJkvINBjlXU+selnyXIfcyzBNcJIZXGI3M=
X-Google-Smtp-Source: AGHT+IGlChs1DErVvk0i0XlakSuwoOkdeSV6/tXi4Ps1zSBBQNyN0QxlZlPHLQx4G9Atsu+wOG5jAQ==
X-Received: by 2002:a05:6a20:4413:b0:187:ef24:358 with SMTP id ce19-20020a056a20441300b00187ef240358mr767625pzb.60.1700770289311;
        Thu, 23 Nov 2023 12:11:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b12-20020aa7810c000000b006b8bb35e313sm1583605pfi.103.2023.11.23.12.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 12:11:28 -0800 (PST)
Message-ID: <655fb1f0.a70a0220.e57d8.3f80@mx.google.com>
Date: Thu, 23 Nov 2023 12:11:28 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.139-235-ga5c4e9d1cfc8
Subject: stable-rc/queue/5.15 baseline: 143 runs,
 3 regressions (v5.15.139-235-ga5c4e9d1cfc8)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 143 runs, 3 regressions (v5.15.139-235-ga5c4=
e9d1cfc8)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.139-235-ga5c4e9d1cfc8/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.139-235-ga5c4e9d1cfc8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      a5c4e9d1cfc86ab7f9cb2741a33b76f8f4de03a2 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/655f7efa5c136947d77e4a9e

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-235-ga5c4e9d1cfc8/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-235-ga5c4e9d1cfc8/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655f7efa5c136947d77e4aa7
        failing since 1 day (last pass: v5.15.114-13-g095e387c3889, first f=
ail: v5.15.139-172-gb60494a37c0c)

    2023-11-23T16:40:09.347241  / # #

    2023-11-23T16:40:09.447773  export SHELL=3D/bin/sh

    2023-11-23T16:40:09.447895  #

    2023-11-23T16:40:09.548385  / # export SHELL=3D/bin/sh. /lava-12068400/=
environment

    2023-11-23T16:40:09.548502  =


    2023-11-23T16:40:09.648998  / # . /lava-12068400/environment/lava-12068=
400/bin/lava-test-runner /lava-12068400/1

    2023-11-23T16:40:09.649198  =


    2023-11-23T16:40:09.661162  / # /lava-12068400/bin/lava-test-runner /la=
va-12068400/1

    2023-11-23T16:40:09.701287  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-23T16:40:09.720390  + cd /lav<8>[   16.025671] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12068400_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/655f7ef25c136947d77e4a8f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-235-ga5c4e9d1cfc8/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-235-ga5c4e9d1cfc8/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655f7ef25c136947d77e4a98
        failing since 1 day (last pass: v5.15.105-206-g4548859116b8, first =
fail: v5.15.139-172-gb60494a37c0c)

    2023-11-23T16:33:45.367144  / # #
    2023-11-23T16:33:45.468924  export SHELL=3D/bin/sh
    2023-11-23T16:33:45.469623  #
    2023-11-23T16:33:45.570665  / # export SHELL=3D/bin/sh. /lava-445051/en=
vironment
    2023-11-23T16:33:45.571331  =

    2023-11-23T16:33:45.672358  / # . /lava-445051/environment/lava-445051/=
bin/lava-test-runner /lava-445051/1
    2023-11-23T16:33:45.673260  =

    2023-11-23T16:33:45.677298  / # /lava-445051/bin/lava-test-runner /lava=
-445051/1
    2023-11-23T16:33:45.709322  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-23T16:33:45.750352  + cd /lava-445051/<8>[   16.530599] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 445051_1.5.2.4.5> =

    ... (10 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/655f7f0e05abea30d57e4a82

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-235-ga5c4e9d1cfc8/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-235-ga5c4e9d1cfc8/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655f7f0e05abea30d57e4a8b
        failing since 1 day (last pass: v5.15.105-206-g4548859116b8, first =
fail: v5.15.139-172-gb60494a37c0c)

    2023-11-23T16:40:28.861404  / # #

    2023-11-23T16:40:28.963518  export SHELL=3D/bin/sh

    2023-11-23T16:40:28.964218  #

    2023-11-23T16:40:29.065541  / # export SHELL=3D/bin/sh. /lava-12068413/=
environment

    2023-11-23T16:40:29.066253  =


    2023-11-23T16:40:29.167651  / # . /lava-12068413/environment/lava-12068=
413/bin/lava-test-runner /lava-12068413/1

    2023-11-23T16:40:29.168723  =


    2023-11-23T16:40:29.171297  / # /lava-12068413/bin/lava-test-runner /la=
va-12068413/1

    2023-11-23T16:40:29.213742  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-23T16:40:29.246324  + cd /lava-1206841<8>[   16.750885] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12068413_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

