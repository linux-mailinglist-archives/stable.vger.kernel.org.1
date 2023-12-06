Return-Path: <stable+bounces-4818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD0F80683C
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 08:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75784B2120B
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 07:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839E3168B9;
	Wed,  6 Dec 2023 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="dG13OV3L"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130D2122
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 23:29:53 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6ce3efb78e2so3609956b3a.1
        for <stable@vger.kernel.org>; Tue, 05 Dec 2023 23:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701847792; x=1702452592; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5l6D461yCEJgZXXRws/WxXr5/BZmmGq3wEfpP/kv+B4=;
        b=dG13OV3L3Q37F639INd8dmgBbET22GOunlDt5fipqY7GqX2zpuHc5qDS029RqHz0vW
         ZBQKXmb6sM032fcutg9+52d0dEjUTIdzd0XJQcGHi2StxfqdAwY0cgoEHh5QJbwNDApS
         VEtOrVia/gwDCnxqYokJqGn13P3O2V8hnHeHekty0LiGvuxXpYaOOTCrvj/bSJJNjDOP
         KxRzQ63t0RtQdphjVBV1pSVA5b/AG+YpuPjS9q0isu+fGwI08be5shmb/gfibrwvGZ+6
         vABc/Lg/k5GQFRX08QXRy3b7wVl0kKOc/Ik+ExgnpP9fRZ43hza6Xg5EeHGvkLpNWQbu
         8sNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701847792; x=1702452592;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5l6D461yCEJgZXXRws/WxXr5/BZmmGq3wEfpP/kv+B4=;
        b=TwpyQWbFOOi4rjY9Z6VMLTjW8AEf6WXDAa+MaC6xJeLYBG43G8BO08+RNOUGK3D50C
         1TvuyMPrBILTs835gkbcVEgspqbmxXmaIqH4XoLacs/MGqhFkwk8dJsvp7D6W9Kn8KRf
         4oIzHQJGjit9p8YEgmX5lvOADUaGt7FhGq/NSvpHD8OIfdVtOVRd7V+/p/VnTwpYLl/n
         jxepucJjhWE3C9p0vhf3VLT/wz+THymFs5LAfmGROLLJWsbaYDp0TR2eZrtw4OFYQd+M
         r62yU2e2oNvlpxJrE6jBg99FZL10fIKd+1zA650mun9dLaRu12FqucoEf3EdFY+dMf/r
         NK7A==
X-Gm-Message-State: AOJu0YzS5EHg6YNGkneCVKMLdrA3G3sVEHoDFThPSvIMnonnr98DYe8q
	FVJKu9/aHAWLiILvB0EHdA4zro4449QzdRM8v2HkoQ==
X-Google-Smtp-Source: AGHT+IHlhI61P/Wymn5KaBPQgBHkT4PSIKko257eiEnjbNboBzKNgxM3OwjgQCrsQ9GthSaYAcS3dg==
X-Received: by 2002:a05:6a00:1d09:b0:6ce:79b3:b28a with SMTP id a9-20020a056a001d0900b006ce79b3b28amr489058pfx.60.1701847792000;
        Tue, 05 Dec 2023 23:29:52 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z26-20020aa785da000000b006ce3173a7a7sm34436pfn.148.2023.12.05.23.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 23:29:51 -0800 (PST)
Message-ID: <657022ef.a70a0220.b4914.00be@mx.google.com>
Date: Tue, 05 Dec 2023 23:29:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.65-105-g564877350d4d
Subject: stable-rc/queue/6.1 baseline: 159 runs,
 5 regressions (v6.1.65-105-g564877350d4d)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 159 runs, 5 regressions (v6.1.65-105-g5648773=
50d4d)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
         | regressions
-------------------+--------+---------------+----------+-------------------=
---------+------------
beagle-xm          | arm    | lab-baylibre  | gcc-10   | omap2plus_defconfi=
g        | 1          =

hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig+x=
86-board | 1          =

r8a77960-ulcb      | arm64  | lab-collabora | gcc-10   | defconfig         =
         | 1          =

sun50i-h6-pine-h64 | arm64  | lab-clabbe    | gcc-10   | defconfig         =
         | 1          =

sun50i-h6-pine-h64 | arm64  | lab-collabora | gcc-10   | defconfig         =
         | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.65-105-g564877350d4d/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.65-105-g564877350d4d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      564877350d4da84b31c1f5c8d32b429b49529fc0 =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
         | regressions
-------------------+--------+---------------+----------+-------------------=
---------+------------
beagle-xm          | arm    | lab-baylibre  | gcc-10   | omap2plus_defconfi=
g        | 1          =


  Details:     https://kernelci.org/test/plan/id/656ff1be46d40bc57ae13487

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-10=
5-g564877350d4d/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-10=
5-g564877350d4d/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656ff1be46d40bc57ae13=
488
        failing since 229 days (last pass: v6.1.22-477-g2128d4458cbc, first=
 fail: v6.1.22-474-gecc61872327e) =

 =



platform           | arch   | lab           | compiler | defconfig         =
         | regressions
-------------------+--------+---------------+----------+-------------------=
---------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig+x=
86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/656fefccf6af949bfce13479

  Results:     18 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-10=
5-g564877350d4d/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/base=
line-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-10=
5-g564877350d4d/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/base=
line-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.tpm-chip-is-online: https://kernelci.org/test/case/id/6=
56fefccf6af949bfce13488
        new failure (last pass: v6.1.65-107-g884c56508f09)

    2023-12-06T03:51:19.010361  <8>[   10.479715] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dall-cpus-are-online RESULT=3Dpass>

    2023-12-06T03:51:19.013988  /usr/bin/tpm2_getcap

    2023-12-06T03:51:29.221025  /lava-12194316/1/../bin/lava-test-case

    2023-12-06T03:51:29.227964  <8>[   20.697922] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtpm-chip-is-online RESULT=3Dfail>
   =

 =



platform           | arch   | lab           | compiler | defconfig         =
         | regressions
-------------------+--------+---------------+----------+-------------------=
---------+------------
r8a77960-ulcb      | arm64  | lab-collabora | gcc-10   | defconfig         =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/656ff153b9e8190d70e13495

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-10=
5-g564877350d4d/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-10=
5-g564877350d4d/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656ff154b9e8190d70e1349a
        failing since 13 days (last pass: v6.1.31-26-gef50524405c2, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-06T04:05:35.365981  / # #

    2023-12-06T04:05:35.466607  export SHELL=3D/bin/sh

    2023-12-06T04:05:35.466780  #

    2023-12-06T04:05:35.567325  / # export SHELL=3D/bin/sh. /lava-12194496/=
environment

    2023-12-06T04:05:35.567589  =


    2023-12-06T04:05:35.668187  / # . /lava-12194496/environment/lava-12194=
496/bin/lava-test-runner /lava-12194496/1

    2023-12-06T04:05:35.668513  =


    2023-12-06T04:05:35.679808  / # /lava-12194496/bin/lava-test-runner /la=
va-12194496/1

    2023-12-06T04:05:35.733769  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-06T04:05:35.733938  + cd /lav<8>[   19.091021] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12194496_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch   | lab           | compiler | defconfig         =
         | regressions
-------------------+--------+---------------+----------+-------------------=
---------+------------
sun50i-h6-pine-h64 | arm64  | lab-clabbe    | gcc-10   | defconfig         =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/656ff158b9e8190d70e134ab

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-10=
5-g564877350d4d/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-10=
5-g564877350d4d/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656ff158b9e8190d70e134b0
        failing since 13 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-06T03:57:54.165922  / # #
    2023-12-06T03:57:54.267918  export SHELL=3D/bin/sh
    2023-12-06T03:57:54.268685  #
    2023-12-06T03:57:54.369849  / # export SHELL=3D/bin/sh. /lava-446746/en=
vironment
    2023-12-06T03:57:54.370593  =

    2023-12-06T03:57:54.471754  / # . /lava-446746/environment/lava-446746/=
bin/lava-test-runner /lava-446746/1
    2023-12-06T03:57:54.472854  =

    2023-12-06T03:57:54.474916  / # /lava-446746/bin/lava-test-runner /lava=
-446746/1
    2023-12-06T03:57:54.554933  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-06T03:57:54.555550  + cd /lava-446746/<8>[   18.571687] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 446746_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform           | arch   | lab           | compiler | defconfig         =
         | regressions
-------------------+--------+---------------+----------+-------------------=
---------+------------
sun50i-h6-pine-h64 | arm64  | lab-collabora | gcc-10   | defconfig         =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/656ff1677b3ba78358e13476

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-10=
5-g564877350d4d/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-10=
5-g564877350d4d/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656ff1677b3ba78358e1347b
        failing since 13 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-06T04:05:50.030983  / # #

    2023-12-06T04:05:50.132672  export SHELL=3D/bin/sh

    2023-12-06T04:05:50.132926  #

    2023-12-06T04:05:50.233528  / # export SHELL=3D/bin/sh. /lava-12194501/=
environment

    2023-12-06T04:05:50.234195  =


    2023-12-06T04:05:50.335294  / # . /lava-12194501/environment/lava-12194=
501/bin/lava-test-runner /lava-12194501/1

    2023-12-06T04:05:50.336244  =


    2023-12-06T04:05:50.339730  / # /lava-12194501/bin/lava-test-runner /la=
va-12194501/1

    2023-12-06T04:05:50.419381  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-06T04:05:50.419465  + cd /lava-1219450<8>[   19.183030] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12194501_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

