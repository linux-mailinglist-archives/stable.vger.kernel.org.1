Return-Path: <stable+bounces-16-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D2A7F57F4
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 07:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2167FB20EB6
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 06:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5210ABE4A;
	Thu, 23 Nov 2023 06:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="LSWCj4aY"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75DB19D
	for <stable@vger.kernel.org>; Wed, 22 Nov 2023 22:00:43 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b83398cfc7so351864b6e.3
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 22:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700719242; x=1701324042; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SpftHuvlJiR4rkLap79XvgsZwaCNdjwYXMTs/zRgyqs=;
        b=LSWCj4aY8HU21IcuMGwjL1dxfGr0w0Uw/81Bah1D5xDwuAvz2XORv7VXnM59wMHPqm
         iFyO2NktDIINi9N4n4oszZnXZ+zVGPISKmltGp77Qv0cfJB/MKb0dFiYQsHZ/eNzuYuH
         JT7cnFuvUH7ow5sqYv6Mm4hCJz5DAqnrq4XaEi4yC0B9emiyn+Wmtlsoqbw6IKy1uupk
         w+/PzXYc19ccSkqmo+Wpj1SLu4RCxzJC8GQCUbaj8M5sWxxprfqy+LHS2EiBC6CZa5I1
         2whx37eWhcuenRPmJhemk/JULnS5ifkTWgRaWR9ZXjpP7a37YTXRa8B7m/LDAFiSuV/5
         75cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700719242; x=1701324042;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SpftHuvlJiR4rkLap79XvgsZwaCNdjwYXMTs/zRgyqs=;
        b=Jlg4TnAwi4uCo/cH2NeedPjWNRcOwtwkGRYZb3pBvLHqhjKfWBudUM+Th6fB+w4Fp5
         wblLlR5zd5jzmxvSuXNDHcN7HGPtZtm6X9/om8B3SfMGEVwz7qelryIvOLlh0yKea9MZ
         +IcQw/p+8V236sXP3206WH0KZCmxqoNn293uvICVjH/+exichFhhhoHESZBxSXPKCRkz
         GS1d3fYwrJIhCYbkOBElhW6NE6f/t0Uq8fOm/Wr+MZ4/k8tjSBqsc/OQPPslStvjIkv6
         anskfKmT7lVgMKN77jGxM6IzCMeWQejcsb0rVd3HgvTmmXy2a2xQkLKUHgVHVWUnMTE4
         WKEA==
X-Gm-Message-State: AOJu0YzfVewkqhGyoaVNK/aB+DcEL/AAPKThXown94EX86Ph/+lwyq0w
	BDp9CxT0Fn61K1f4vpTyAW/1tv65QCT0nvU/czk=
X-Google-Smtp-Source: AGHT+IGTegos68cX6BKVUSPSNuJ0aFATtNz9od19TTj3oAY7qrbpi+ONbKXv/m12yzfGMt3xwwQtlg==
X-Received: by 2002:a05:6808:1288:b0:3b8:4d0b:54f6 with SMTP id a8-20020a056808128800b003b84d0b54f6mr515212oiw.23.1700719242543;
        Wed, 22 Nov 2023 22:00:42 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t3-20020a632d03000000b005897bfc2ed3sm483390pgt.93.2023.11.22.22.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 22:00:41 -0800 (PST)
Message-ID: <655eea89.630a0220.fce21.14ca@mx.google.com>
Date: Wed, 22 Nov 2023 22:00:41 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.139-213-g8d3198b02d3c
Subject: stable-rc/queue/5.15 baseline: 142 runs,
 3 regressions (v5.15.139-213-g8d3198b02d3c)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 142 runs, 3 regressions (v5.15.139-213-g8d31=
98b02d3c)

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
nel/v5.15.139-213-g8d3198b02d3c/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.139-213-g8d3198b02d3c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      8d3198b02d3c3be212203b83e9fc2772e2edfe6a =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/655eb891b7159270687e4b6a

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-213-g8d3198b02d3c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-213-g8d3198b02d3c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655eb891b7159270687e4b73
        failing since 0 day (last pass: v5.15.114-13-g095e387c3889, first f=
ail: v5.15.139-172-gb60494a37c0c)

    2023-11-23T02:33:49.638270  / # #

    2023-11-23T02:33:49.738854  export SHELL=3D/bin/sh

    2023-11-23T02:33:49.738988  #

    2023-11-23T02:33:49.839502  / # export SHELL=3D/bin/sh. /lava-12064382/=
environment

    2023-11-23T02:33:49.839629  =


    2023-11-23T02:33:49.940447  / # . /lava-12064382/environment/lava-12064=
382/bin/lava-test-runner /lava-12064382/1

    2023-11-23T02:33:49.941658  =


    2023-11-23T02:33:49.946772  / # /lava-12064382/bin/lava-test-runner /la=
va-12064382/1

    2023-11-23T02:33:50.007385  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-23T02:33:50.007880  + cd /lav<8>[   16.133435] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12064382_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/655eb884b7159270687e4b0b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-213-g8d3198b02d3c/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-213-g8d3198b02d3c/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655eb884b7159270687e4b14
        failing since 0 day (last pass: v5.15.105-206-g4548859116b8, first =
fail: v5.15.139-172-gb60494a37c0c)

    2023-11-23T02:27:07.290052  <8>[   16.181356] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 444973_1.5.2.4.1>
    2023-11-23T02:27:07.395129  / # #
    2023-11-23T02:27:07.496767  export SHELL=3D/bin/sh
    2023-11-23T02:27:07.497372  #
    2023-11-23T02:27:07.598375  / # export SHELL=3D/bin/sh. /lava-444973/en=
vironment
    2023-11-23T02:27:07.598969  =

    2023-11-23T02:27:07.699987  / # . /lava-444973/environment/lava-444973/=
bin/lava-test-runner /lava-444973/1
    2023-11-23T02:27:07.700886  =

    2023-11-23T02:27:07.705344  / # /lava-444973/bin/lava-test-runner /lava=
-444973/1
    2023-11-23T02:27:07.737425  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/655eb8a5818913315d7e4a84

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-213-g8d3198b02d3c/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-213-g8d3198b02d3c/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655eb8a5818913315d7e4a8d
        failing since 0 day (last pass: v5.15.105-206-g4548859116b8, first =
fail: v5.15.139-172-gb60494a37c0c)

    2023-11-23T02:34:03.799287  / # #

    2023-11-23T02:34:03.901293  export SHELL=3D/bin/sh

    2023-11-23T02:34:03.901997  #

    2023-11-23T02:34:04.003411  / # export SHELL=3D/bin/sh. /lava-12064386/=
environment

    2023-11-23T02:34:04.004122  =


    2023-11-23T02:34:04.105572  / # . /lava-12064386/environment/lava-12064=
386/bin/lava-test-runner /lava-12064386/1

    2023-11-23T02:34:04.106661  =


    2023-11-23T02:34:04.123289  / # /lava-12064386/bin/lava-test-runner /la=
va-12064386/1

    2023-11-23T02:34:04.181110  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-23T02:34:04.181694  + cd /lava-1206438<8>[   16.810433] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12064386_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

