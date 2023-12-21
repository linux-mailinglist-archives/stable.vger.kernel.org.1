Return-Path: <stable+bounces-8252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8A281B9D4
	for <lists+stable@lfdr.de>; Thu, 21 Dec 2023 15:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 909061C2175F
	for <lists+stable@lfdr.de>; Thu, 21 Dec 2023 14:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9551DFF1;
	Thu, 21 Dec 2023 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="OuGUaQam"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C801DFD1
	for <stable@vger.kernel.org>; Thu, 21 Dec 2023 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d7609cb6d2so520831b3a.1
        for <stable@vger.kernel.org>; Thu, 21 Dec 2023 06:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703170139; x=1703774939; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tLcya31e5TUZsAT0dtpNK5E3cPF+JUAUTT8OyTl1ajo=;
        b=OuGUaQamyjgwxD7XCwObxU7KCE9IqRhxHWf6wf5CylTxjhcBaBTuCZMuECd8Skdt5t
         sf30jYA41zUJoBj+kQ6xcgwDfPdK0eMyVlIl2vMOIGTfoQkaC/wVIT/8QZ7RrIMuvqdw
         A6ZDK/YIfirgKwSOxck6O/EnobNmSVaLPD6vpfOYDZE9GDcg3mvgs64sFZaFfSVEzNqv
         AW3I0CWY65RHqW+a0C5CpPHsNoZlXWNGPUcDn0qjuTzeRtB0NK/FFktPDALI5kK7ua9Z
         HBns6SK5d1wry9n1DB8f2ixhC7A18OJcswZwvkmIaLDzqzBj8QjQMLHwDrrFgXqDqlpb
         3JsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703170139; x=1703774939;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tLcya31e5TUZsAT0dtpNK5E3cPF+JUAUTT8OyTl1ajo=;
        b=sD58zz6WSxT0A8H3sQCifPiBYnOPaOVQbg6lTyMoLEhI84w5v4FAxGAB3exqWSXelA
         y9peD6eIH1EWqj5nTcqdKDTYFLbvbEEPAlXKRguFoAk/j4TwrA35z87ltHXEOQCq4kqy
         /f7yjOidMqH2xcLrh33sPFENlKx4CfW+Z77yEekqRnEExQ6r908mM31T6+OL4gPTJdEF
         6pvIHbvV6iZB1itZvPe7C8egzxQG43tyuwy5bLdPiMb5inzw+d2SBZqXCGcrvMuGUZ4D
         fWFemRshUoWuM/irs8SIET+rsdnn0pNuHGNPGaBB7a7u28MaUGBKt7rPSFdY6iSduHbc
         yKlg==
X-Gm-Message-State: AOJu0YyZcoMB6BuHWIPdBnPLb0sPntvRGTt8vK2JQwLyLqBRhLcfFeeL
	pNAxYqnJo/Nbu2Wd33W9pzpuR8a9hx0TpTmjSN8=
X-Google-Smtp-Source: AGHT+IEQzPgsAqhZK5AvhrzQEaAWh4PMqUF/8lEm8dxZPvtg9+GhMPw95j24EvM/CdKuOLMW6a9jXg==
X-Received: by 2002:aa7:87cb:0:b0:6d9:682e:8a20 with SMTP id i11-20020aa787cb000000b006d9682e8a20mr1537458pfo.41.1703170138730;
        Thu, 21 Dec 2023 06:48:58 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s186-20020a635ec3000000b005c65ed23b65sm1608801pgb.94.2023.12.21.06.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 06:48:58 -0800 (PST)
Message-ID: <6584505a.630a0220.df484.4cb0@mx.google.com>
Date: Thu, 21 Dec 2023 06:48:58 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.68-109-g72c91a6aec84e
Subject: stable-rc/queue/6.1 baseline: 86 runs,
 4 regressions (v6.1.68-109-g72c91a6aec84e)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 86 runs, 4 regressions (v6.1.68-109-g72c91a6a=
ec84e)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =

r8a779m1-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.68-109-g72c91a6aec84e/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.68-109-g72c91a6aec84e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      72c91a6aec84e00beb4efae0f0c87057a8702425 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65841b53ac4358b64ee134a7

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
9-g72c91a6aec84e/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
9-g72c91a6aec84e/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65841b53ac4358b64ee134ac
        failing since 28 days (last pass: v6.1.31-26-gef50524405c2, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-21T11:09:52.707914  / # #

    2023-12-21T11:09:52.809849  export SHELL=3D/bin/sh

    2023-12-21T11:09:52.810508  #

    2023-12-21T11:09:52.911771  / # export SHELL=3D/bin/sh. /lava-12339173/=
environment

    2023-12-21T11:09:52.912653  =


    2023-12-21T11:09:53.013977  / # . /lava-12339173/environment/lava-12339=
173/bin/lava-test-runner /lava-12339173/1

    2023-12-21T11:09:53.014951  =


    2023-12-21T11:09:53.056792  / # /lava-12339173/bin/lava-test-runner /la=
va-12339173/1

    2023-12-21T11:09:53.080466  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-21T11:09:53.080982  + cd /lav<8>[   19.062659] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12339173_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a779m1-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65841b53f31978d4bfe13491

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
9-g72c91a6aec84e/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulc=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
9-g72c91a6aec84e/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulc=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65841b53f31978d4bfe13=
492
        new failure (last pass: v6.1.68-108-g5ec595eb8752d) =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65841b219cf275b1efe134a2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
9-g72c91a6aec84e/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
9-g72c91a6aec84e/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65841b219cf275b1efe134a7
        failing since 28 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-21T11:01:46.371232  <8>[   18.155576] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 449286_1.5.2.4.1>
    2023-12-21T11:01:46.476281  / # #
    2023-12-21T11:01:46.577834  export SHELL=3D/bin/sh
    2023-12-21T11:01:46.578370  #
    2023-12-21T11:01:46.679355  / # export SHELL=3D/bin/sh. /lava-449286/en=
vironment
    2023-12-21T11:01:46.679923  =

    2023-12-21T11:01:46.780923  / # . /lava-449286/environment/lava-449286/=
bin/lava-test-runner /lava-449286/1
    2023-12-21T11:01:46.781789  =

    2023-12-21T11:01:46.786586  / # /lava-449286/bin/lava-test-runner /lava=
-449286/1
    2023-12-21T11:01:46.859605  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65841b54ac4358b64ee134b2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
9-g72c91a6aec84e/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
9-g72c91a6aec84e/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65841b54ac4358b64ee134b7
        failing since 28 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-21T11:10:04.855506  / # #

    2023-12-21T11:10:04.957554  export SHELL=3D/bin/sh

    2023-12-21T11:10:04.957802  #

    2023-12-21T11:10:05.058505  / # export SHELL=3D/bin/sh. /lava-12339200/=
environment

    2023-12-21T11:10:05.059171  =


    2023-12-21T11:10:05.160491  / # . /lava-12339200/environment/lava-12339=
200/bin/lava-test-runner /lava-12339200/1

    2023-12-21T11:10:05.161550  =


    2023-12-21T11:10:05.163681  / # /lava-12339200/bin/lava-test-runner /la=
va-12339200/1

    2023-12-21T11:10:05.243935  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-21T11:10:05.244475  + cd /lava-1233920<8>[   19.116040] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12339200_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

