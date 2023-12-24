Return-Path: <stable+bounces-8422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCE481DC27
	for <lists+stable@lfdr.de>; Sun, 24 Dec 2023 20:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A694E1C20CB4
	for <lists+stable@lfdr.de>; Sun, 24 Dec 2023 19:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DE0D30E;
	Sun, 24 Dec 2023 19:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="GagbFYRe"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31409D517
	for <stable@vger.kernel.org>; Sun, 24 Dec 2023 19:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d2350636d6so3001369b3a.2
        for <stable@vger.kernel.org>; Sun, 24 Dec 2023 11:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703446466; x=1704051266; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zd0MXjzE2O8k7aEBvZAmBhx1uD5TkbqROankZHBEoyE=;
        b=GagbFYRe80XWByuX97bNZJ6s/zQ3+XLhvuNFypc1oOxSVcTxXlmpM7D0aN92Pttebd
         mvH0ar6KvI1vlMqRlXLEJJW1vorq3R19P+hr8HCKVO2viUcaGjYUG1AzDY/G+LjrZEw0
         8YYwH5neD0llnwT1ZwJfThgFdAyZ0DyrXmzDSH2QnAC5X+F9YY98OPQHIY6Qh6ljUtWS
         HX2Dpfrsk7dGlsR5rrAdPG5/F3p8oisT/b8z5KZKus/Qfp9rmG/ORaHqa7SzxQqr6qlf
         hzANkW21IXWDQjaWvADHDfi88/jyP9VM4XrtheMpUA/7Lc20lgAOmiIQjKlcK/Yi5VSz
         vT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703446466; x=1704051266;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zd0MXjzE2O8k7aEBvZAmBhx1uD5TkbqROankZHBEoyE=;
        b=Z0DxhFsR4tNG0csnjj7rbFvhTFQbbS62gkbNqFAR12Ju2/d+3bsqZPr9EmXeaUk4xk
         U+uEimTccCmi4N2z0n5VAugAAsf0eY52E84uxQafQkE+926EdcR+BB4QJPubF5Bdip0X
         lGRH4XXhFvIHAwvk63yF6dNAUXtTQsemfQc2J93slikzM+iC5awKXGBu7X/35Z8NJFAc
         w3aVnT8EBicfsPdjCK7E77iEpJNSUIpfEpIk4LLdXQ19gzwXT2Xbby2MZ4VrY5tzz4B/
         Z6Qfu5yCYMU6PEYqliRwHHnn2yFVtwlPkEjVVokjA4cCpGfA9Lv+9VvNLHP3pN9/8Wik
         FfgA==
X-Gm-Message-State: AOJu0Yw6WHJr9HNvdPaLpfIlxbGN4k7Y/xYF/h5KGP2LvpDRQN5zdwwu
	vrEAXsAXc8viuIEbNmpT7uSSJ+1WaZEk95qwQJdAJ3ETin0=
X-Google-Smtp-Source: AGHT+IHqsoMXd2+7AyNQw+0EKCWbvXGKfho6EhfyNvqj47AkpBZR62PSkx1PBteacv3oNI45Qoc6iA==
X-Received: by 2002:a05:6a00:cc5:b0:6d9:9898:81ef with SMTP id b5-20020a056a000cc500b006d9989881efmr3557271pfv.37.1703446466029;
        Sun, 24 Dec 2023 11:34:26 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h11-20020aa786cb000000b006d9abda076asm2207075pfo.179.2023.12.24.11.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 11:34:25 -0800 (PST)
Message-ID: <658887c1.a70a0220.89d46.41fd@mx.google.com>
Date: Sun, 24 Dec 2023 11:34:25 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.143-253-g137e0215c3892
Subject: stable-rc/queue/5.15 baseline: 103 runs,
 4 regressions (v5.15.143-253-g137e0215c3892)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 103 runs, 4 regressions (v5.15.143-253-g137e=
0215c3892)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
kontron-pitx-imx8m | arm64 | lab-kontron   | gcc-10   | defconfig | 1      =
    =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.143-253-g137e0215c3892/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.143-253-g137e0215c3892
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      137e0215c3892ea239cf42b454658099f139725d =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
kontron-pitx-imx8m | arm64 | lab-kontron   | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65885745c6e0440c99e13511

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-253-g137e0215c3892/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pit=
x-imx8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-253-g137e0215c3892/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pit=
x-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65885745c6e0440c99e13=
512
        new failure (last pass: v5.15.143-247-g2c5a01b7b03a0) =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65885638cc72a8d75ee134f1

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-253-g137e0215c3892/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-253-g137e0215c3892/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65885638cc72a8d75ee134f6
        failing since 32 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-24T16:10:28.750585  / # #

    2023-12-24T16:10:28.851066  export SHELL=3D/bin/sh

    2023-12-24T16:10:28.851191  #

    2023-12-24T16:10:28.951680  / # export SHELL=3D/bin/sh. /lava-12374229/=
environment

    2023-12-24T16:10:28.951818  =


    2023-12-24T16:10:29.052336  / # . /lava-12374229/environment/lava-12374=
229/bin/lava-test-runner /lava-12374229/1

    2023-12-24T16:10:29.052559  =


    2023-12-24T16:10:29.064260  / # /lava-12374229/bin/lava-test-runner /la=
va-12374229/1

    2023-12-24T16:10:29.104440  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-24T16:10:29.123257  + cd /lav<8>[   15.923656] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12374229_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65885642447d67cb7de13483

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-253-g137e0215c3892/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-253-g137e0215c3892/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65885642447d67cb7de13488
        failing since 32 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-24T16:03:04.904235  <8>[   16.138353] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 449806_1.5.2.4.1>
    2023-12-24T16:03:05.009281  / # #
    2023-12-24T16:03:05.110934  export SHELL=3D/bin/sh
    2023-12-24T16:03:05.111533  #
    2023-12-24T16:03:05.212521  / # export SHELL=3D/bin/sh. /lava-449806/en=
vironment
    2023-12-24T16:03:05.213136  =

    2023-12-24T16:03:05.314159  / # . /lava-449806/environment/lava-449806/=
bin/lava-test-runner /lava-449806/1
    2023-12-24T16:03:05.315073  =

    2023-12-24T16:03:05.319482  / # /lava-449806/bin/lava-test-runner /lava=
-449806/1
    2023-12-24T16:03:05.351521  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6588564c447d67cb7de13497

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-253-g137e0215c3892/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-253-g137e0215c3892/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6588564c447d67cb7de1349c
        failing since 32 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-24T16:10:44.447838  / # #

    2023-12-24T16:10:44.550239  export SHELL=3D/bin/sh

    2023-12-24T16:10:44.550936  #

    2023-12-24T16:10:44.652358  / # export SHELL=3D/bin/sh. /lava-12374223/=
environment

    2023-12-24T16:10:44.653064  =


    2023-12-24T16:10:44.754504  / # . /lava-12374223/environment/lava-12374=
223/bin/lava-test-runner /lava-12374223/1

    2023-12-24T16:10:44.755575  =


    2023-12-24T16:10:44.772131  / # /lava-12374223/bin/lava-test-runner /la=
va-12374223/1

    2023-12-24T16:10:44.830081  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-24T16:10:44.830585  + cd /lava-1237422<8>[   16.906939] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12374223_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

