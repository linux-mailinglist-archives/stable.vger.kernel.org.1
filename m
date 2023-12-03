Return-Path: <stable+bounces-3817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C49802743
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 21:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC68A1F21190
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 20:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B06F18C27;
	Sun,  3 Dec 2023 20:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="SQ46ol8M"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5466ACD
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 12:26:41 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6ce49d9d874so473147b3a.2
        for <stable@vger.kernel.org>; Sun, 03 Dec 2023 12:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701635200; x=1702240000; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jONmtagacpsm+WJR9N51RvA9EXut4aFxB3H0TxNX1tc=;
        b=SQ46ol8MIBxhEkKKrk5dpskUJqBCC5gRMialjaRc3+s1UovCvkRjmtUGZHIXZoPtNt
         PQf3ZbCMg0YD9gc1DCy6/hdbVrM0Unud6u/ltqdldMk/2+MOLzwq8pm096mlgnx9sBHo
         bYD+YuJRizXHpwKvNaj7/1m1gmj7Jnf/VQTvPLPyV69A+teBbJIkpUfCD5niNrpgfHLz
         sEicSu6M/KTjl7LHa2/M+k9g/f1eZam/LgQhWm/P1GRkX9Ey69ml+mqkcLwmQuLtSBBM
         lXWjImRAL0etxtHks5t+C7w+OyY0+Lor4xn5FWP1tVioKvXZshAM+NsNjrBsKIzSyc+L
         U9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701635200; x=1702240000;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jONmtagacpsm+WJR9N51RvA9EXut4aFxB3H0TxNX1tc=;
        b=wsjblfzNTzw4fP4vzK2/JXKxlut88Q+c80C8OzWJVEBaZCgOdq2eCIiqClBvuiMODZ
         VfSPKs8ZTQdRRCTrvrelEdnscKMdAc4YBuSn7oZ82WaVEyUN94G7EUYs6jVX4gihfqZi
         CqFHjktFUGtq0nS3jbzJ1xuySta6Vd16GcRxlrJNPv95KDqaKx3etrCw9gSD1481ksu2
         umQo5MP9jg20jAgsq+oqNOC3s7DhQuEXKFEyJwx0qmZMJ7nxv8G6Vq2vLTxM1xJZ+nvh
         VRk9d07EO2M1a7T09CUFhc+Ew0TeycXfKHOHEf+VMH1vRuF54Q8S9QI5K1tq5ydlXrjU
         b6vQ==
X-Gm-Message-State: AOJu0YyiumsPNfwyaEgFN0RJ5AkQu/z0q9RUO3wNSHKaVuvnqvxgbdgb
	VasHJN5FAKMleNHlzqwn1OjSMx0wHK+AOmPK8aMopw==
X-Google-Smtp-Source: AGHT+IFI3Rwc+EvqZ/qbHRNdD1BAVMdMfgv12rFWX0LghkdF7jSrZm+TqP1MBdefWZqZtlXH2srakQ==
X-Received: by 2002:a05:6a00:1f0d:b0:6ce:2732:57c with SMTP id be13-20020a056a001f0d00b006ce2732057cmr3181132pfb.45.1701635200233;
        Sun, 03 Dec 2023 12:26:40 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x67-20020a626346000000b006be0fb89ac2sm6543724pfb.197.2023.12.03.12.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 12:26:39 -0800 (PST)
Message-ID: <656ce47f.620a0220.40409.205b@mx.google.com>
Date: Sun, 03 Dec 2023 12:26:39 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.141-27-g91ec262d44f0f
Subject: stable-rc/queue/5.15 baseline: 133 runs,
 3 regressions (v5.15.141-27-g91ec262d44f0f)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 133 runs, 3 regressions (v5.15.141-27-g91ec2=
62d44f0f)

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
nel/v5.15.141-27-g91ec262d44f0f/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.141-27-g91ec262d44f0f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      91ec262d44f0f06a48ade1d4626a905dd283696e =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/656cae41e91055d902e1348b

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-27-g91ec262d44f0f/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-27-g91ec262d44f0f/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656cae41e91055d902e13490
        failing since 11 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-03T16:41:21.455033  / # #

    2023-12-03T16:41:21.557060  export SHELL=3D/bin/sh

    2023-12-03T16:41:21.557771  #

    2023-12-03T16:41:21.658970  / # export SHELL=3D/bin/sh. /lava-12170987/=
environment

    2023-12-03T16:41:21.659640  =


    2023-12-03T16:41:21.760969  / # . /lava-12170987/environment/lava-12170=
987/bin/lava-test-runner /lava-12170987/1

    2023-12-03T16:41:21.761933  =


    2023-12-03T16:41:21.763357  / # /lava-12170987/bin/lava-test-runner /la=
va-12170987/1

    2023-12-03T16:41:21.827993  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-03T16:41:21.828513  + cd /lav<8>[   15.978456] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12170987_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/656cae348443149aede134f8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-27-g91ec262d44f0f/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-27-g91ec262d44f0f/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656cae348443149aede134fd
        failing since 11 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-03T16:34:51.887105  <8>[   16.075395] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 446409_1.5.2.4.1>
    2023-12-03T16:34:51.992143  / # #
    2023-12-03T16:34:52.093843  export SHELL=3D/bin/sh
    2023-12-03T16:34:52.094479  #
    2023-12-03T16:34:52.195475  / # export SHELL=3D/bin/sh. /lava-446409/en=
vironment
    2023-12-03T16:34:52.196144  =

    2023-12-03T16:34:52.297148  / # . /lava-446409/environment/lava-446409/=
bin/lava-test-runner /lava-446409/1
    2023-12-03T16:34:52.298023  =

    2023-12-03T16:34:52.302411  / # /lava-446409/bin/lava-test-runner /lava=
-446409/1
    2023-12-03T16:34:52.334441  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/656cae42e91055d902e13496

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-27-g91ec262d44f0f/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-27-g91ec262d44f0f/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656cae42e91055d902e1349b
        failing since 11 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-03T16:41:35.169452  / # #

    2023-12-03T16:41:35.271227  export SHELL=3D/bin/sh

    2023-12-03T16:41:35.271868  #

    2023-12-03T16:41:35.373035  / # export SHELL=3D/bin/sh. /lava-12171001/=
environment

    2023-12-03T16:41:35.373705  =


    2023-12-03T16:41:35.474966  / # . /lava-12171001/environment/lava-12171=
001/bin/lava-test-runner /lava-12171001/1

    2023-12-03T16:41:35.476105  =


    2023-12-03T16:41:35.478196  / # /lava-12171001/bin/lava-test-runner /la=
va-12171001/1

    2023-12-03T16:41:35.521613  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-03T16:41:35.552237  + cd /lava-1217100<8>[   16.833956] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12171001_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

