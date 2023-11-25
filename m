Return-Path: <stable+bounces-2569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 491017F87A1
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 02:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7758281878
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 01:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0547BEDF;
	Sat, 25 Nov 2023 01:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="PyPKYzDM"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097A3172E
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 17:59:37 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-359d27f6d46so7627475ab.3
        for <stable@vger.kernel.org>; Fri, 24 Nov 2023 17:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700877576; x=1701482376; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wQNnVurgnT92UagiXIPW1UTf050bSe/0nuelQWb6ojo=;
        b=PyPKYzDMKW0p6x7LxNOnthSld0MU3m4OwRVXKXsRW4uRP8d5cM2Kn2lpMhK3m/kUEi
         WrK3WF+n7ElVNjfP0N9ivNoIkgKT6sOeIyvjD/yhS+kelFHa04sf8/WwtQ/6y+Re+X0m
         oxEy9eHKH3fLnd61gVkDMO59xd0Pi8LH+gcSwJvgvveeKwq9tDAAgCksLW4Bj2swHwfh
         t+Lo2Fp6nxWCT8lpGDSljfkP1XJxUp5S5pWdk/t7HqsWgc5gHDCh2bjcIgNK4hQv2QOB
         yJ2UjkKCbUeeyWE//nQPEQyNyHSiI/OH2rlRDidH8MMgC6UCvqhHTLH6+P8EFpOynv5N
         WlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700877576; x=1701482376;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wQNnVurgnT92UagiXIPW1UTf050bSe/0nuelQWb6ojo=;
        b=DyJQXkoUD413VIRhLnsKUmmrmzkZzTfcPNUBz4mt3Bu7BseJ5FJPb6NcBYgMGUcVyK
         WnEm9VuvGwZlFsW45W/R3sgfZhN3eAae6hPscEAOXDdDGj6ctGOsUetO+BDoN5BG+7rU
         req8zvvd+f/sLtwsAtDQW4y+q3Yvp/lazU4/+vw5XwnN+BQoHje2UKaOylU9kITxPw4e
         3U/OrHdi7a+0RgxoYChl12SDsixpMCsPBNsuYUHMn3UasxTQ2rIOthexSUIgdDabfYy5
         rJ8YiYdtR6SGIYqOdULqrvNQKV9gIuGFKEb9L1EibwFN7iIx7XuFPEVC0321Cu//VJOQ
         U6jw==
X-Gm-Message-State: AOJu0YzilDv6BZ1u1QvxXp7oQvhRoFVioVzxtAhVZbfC2Sjzfb+O6uWv
	Bjmn/gk9/W0rh285zR1wVZ2CyrpUrIIEdcpqnkI=
X-Google-Smtp-Source: AGHT+IHYvbsPBnC1z7UHc57AGMZyK6fKDjqz2hZhDDx6OnlOuXI/QsrQJwh6/vAJW7JRKKVCq0VgvA==
X-Received: by 2002:a05:6e02:b4a:b0:35b:56:f2af with SMTP id f10-20020a056e020b4a00b0035b0056f2afmr71281ilu.32.1700877575806;
        Fri, 24 Nov 2023 17:59:35 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id fd39-20020a056a002ea700b006cb7b0c2503sm3524392pfb.95.2023.11.24.17.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 17:59:35 -0800 (PST)
Message-ID: <65615507.050a0220.383d2.93c9@mx.google.com>
Date: Fri, 24 Nov 2023 17:59:35 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.139-297-g00c97fe3c5f3d
Subject: stable-rc/queue/5.15 baseline: 142 runs,
 3 regressions (v5.15.139-297-g00c97fe3c5f3d)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 142 runs, 3 regressions (v5.15.139-297-g00c9=
7fe3c5f3d)

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
nel/v5.15.139-297-g00c97fe3c5f3d/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.139-297-g00c97fe3c5f3d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      00c97fe3c5f3d7a0f46620eafd1cb27022c88961 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/656123ba8afbfd46df7e4a6e

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-297-g00c97fe3c5f3d/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-297-g00c97fe3c5f3d/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656123ba8afbfd46df7e4a77
        failing since 2 days (last pass: v5.15.114-13-g095e387c3889, first =
fail: v5.15.139-172-gb60494a37c0c)

    2023-11-24T22:35:17.390446  / # #

    2023-11-24T22:35:17.492549  export SHELL=3D/bin/sh

    2023-11-24T22:35:17.493295  #

    2023-11-24T22:35:17.594702  / # export SHELL=3D/bin/sh. /lava-12079169/=
environment

    2023-11-24T22:35:17.595417  =


    2023-11-24T22:35:17.696790  / # . /lava-12079169/environment/lava-12079=
169/bin/lava-test-runner /lava-12079169/1

    2023-11-24T22:35:17.697596  =


    2023-11-24T22:35:17.714656  / # /lava-12079169/bin/lava-test-runner /la=
va-12079169/1

    2023-11-24T22:35:17.763953  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-24T22:35:17.764467  + cd /lav<8>[   16.041658] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12079169_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/656123a50618fa06027e4a89

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-297-g00c97fe3c5f3d/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-297-g00c97fe3c5f3d/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656123a50618fa06027e4a92
        failing since 2 days (last pass: v5.15.105-206-g4548859116b8, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-11-24T22:28:43.351166  / # #
    2023-11-24T22:28:43.452882  export SHELL=3D/bin/sh
    2023-11-24T22:28:43.453528  #
    2023-11-24T22:28:43.554515  / # export SHELL=3D/bin/sh. /lava-445194/en=
vironment
    2023-11-24T22:28:43.555120  =

    2023-11-24T22:28:43.656124  / # . /lava-445194/environment/lava-445194/=
bin/lava-test-runner /lava-445194/1
    2023-11-24T22:28:43.657135  =

    2023-11-24T22:28:43.661990  / # /lava-445194/bin/lava-test-runner /lava=
-445194/1
    2023-11-24T22:28:43.730058  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-24T22:28:43.730502  + cd /lava-445194/<8>[   16.621842] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 445194_1.5.2.4.5> =

    ... (10 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/656123b876bd367be27e4adb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-297-g00c97fe3c5f3d/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-297-g00c97fe3c5f3d/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656123b876bd367be27e4ae4
        failing since 2 days (last pass: v5.15.105-206-g4548859116b8, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-11-24T22:35:32.034107  / # #

    2023-11-24T22:35:32.136209  export SHELL=3D/bin/sh

    2023-11-24T22:35:32.136912  #

    2023-11-24T22:35:32.238344  / # export SHELL=3D/bin/sh. /lava-12079154/=
environment

    2023-11-24T22:35:32.239047  =


    2023-11-24T22:35:32.340514  / # . /lava-12079154/environment/lava-12079=
154/bin/lava-test-runner /lava-12079154/1

    2023-11-24T22:35:32.341626  =


    2023-11-24T22:35:32.342903  / # /lava-12079154/bin/lava-test-runner /la=
va-12079154/1

    2023-11-24T22:35:32.418721  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-24T22:35:32.419211  + cd /lava-1207915<8>[   16.818105] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12079154_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

