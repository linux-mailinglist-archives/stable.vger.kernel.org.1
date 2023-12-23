Return-Path: <stable+bounces-8372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B44A481D295
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 06:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242442855F3
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 05:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395164C69;
	Sat, 23 Dec 2023 05:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="1XHPOk6U"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488F84C6C
	for <stable@vger.kernel.org>; Sat, 23 Dec 2023 05:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d3e6c86868so20069265ad.1
        for <stable@vger.kernel.org>; Fri, 22 Dec 2023 21:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703310803; x=1703915603; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/uYnY4jrd3ANR9/FMObaUPcp+qpD8YQgSBAQruR3HiQ=;
        b=1XHPOk6UYOeGOo4nd9nJfJTFm2jCeqmRqjcmY5Ua5cE8IZMfNln28ysEpwh1EIVOIg
         p8+u/dgNfRPHwcFPVm+Nfgu+yFDktiGfLnoTtS/oEySOatIbFZFeymsRIc+bggpwpbh4
         zdFQ6Uldo7gs8iZsSV8R7dPOQyqkEde+PzdO7FHKUYfJdShsIBuTA64kLNDUHWS+C9bX
         W1pHu0iQDfs6Pt7txppnFxGNwCVKZnzzQPSaBM8aSk3ox1TD5FcEllZH7nx/igCpfkSR
         dR2duTud1T5z8qpaY6tcm8flNwSDwWwNyTSIpluGALnzaJSSgwvcSKFhmxiBzxyZx9TW
         lfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703310803; x=1703915603;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/uYnY4jrd3ANR9/FMObaUPcp+qpD8YQgSBAQruR3HiQ=;
        b=E271VK9gF0vv0Glmj9egoG90B6pq589bVVZ5YZhA56LLB+GfHDZ/ZVLQysYZBYqNOi
         AAkWy95aVPWf3/MZfsLixtI7NLQ6tRml3IiSpER/S97h3U4v//GX1lAkVFsDb+IFEWbR
         ktperuSDWG+TKIsizMWS30sPWtNT8PhjHye5pO8fqvHDW2p9jDn8VDVyZ+IVjbif1MVM
         6t2QuJRrpD3iytNVtH8jlk43NO9emi3UORHALg6LlQlE6ZKfcKMi3wnvgiDpVE4GkkoB
         WGUmffs5T/mQMQrzKMCtkReAb3FzPyy+JtLr0Mx1pwNIAyxGQMTBtYo25GE5h7a8nopP
         x5YA==
X-Gm-Message-State: AOJu0YwLdYim3l9eHKHpLGWI7do/ySi9lewOz7AbzKGv9SiV02lwE/2Q
	DFyqTspuIN0q8EfWK8v33LxYQJ+16yHYYzd1Ufp0raNV38Q=
X-Google-Smtp-Source: AGHT+IEhaVGYuc1Fz4UwlunWPjJXLRz26LbBSQlG1HZDh71jp6/sQ6fufwJVnnY2SkKbnMagKm2Spg==
X-Received: by 2002:a17:902:fc47:b0:1d4:1327:bd15 with SMTP id me7-20020a170902fc4700b001d41327bd15mr3246650plb.32.1703310803140;
        Fri, 22 Dec 2023 21:53:23 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902684f00b001d3eaab64a3sm4446357pln.219.2023.12.22.21.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 21:53:22 -0800 (PST)
Message-ID: <658675d2.170a0220.1c59d.e8a9@mx.google.com>
Date: Fri, 22 Dec 2023 21:53:22 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.143-109-gfda221fa55986
Subject: stable-rc/queue/5.15 baseline: 103 runs,
 3 regressions (v5.15.143-109-gfda221fa55986)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 103 runs, 3 regressions (v5.15.143-109-gfda2=
21fa55986)

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
nel/v5.15.143-109-gfda221fa55986/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.143-109-gfda221fa55986
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      fda221fa55986da4b6aea6d8592bd0c67a54094e =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/658640aca6f1d61b2fe137dd

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-109-gfda221fa55986/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-109-gfda221fa55986/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/658640aca6f1d61b2fe137e2
        failing since 30 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-23T02:13:47.622528  / # #

    2023-12-23T02:13:47.723114  export SHELL=3D/bin/sh

    2023-12-23T02:13:47.723363  #

    2023-12-23T02:13:47.823900  / # export SHELL=3D/bin/sh. /lava-12358416/=
environment

    2023-12-23T02:13:47.824108  =


    2023-12-23T02:13:47.924927  / # . /lava-12358416/environment/lava-12358=
416/bin/lava-test-runner /lava-12358416/1

    2023-12-23T02:13:47.926140  =


    2023-12-23T02:13:47.936618  / # /lava-12358416/bin/lava-test-runner /la=
va-12358416/1

    2023-12-23T02:13:47.976754  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-23T02:13:47.995675  + cd /lav<8>[   15.905240] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12358416_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/658640a1f778117babe134b6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-109-gfda221fa55986/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-109-gfda221fa55986/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/658640a1f778117babe134bb
        failing since 30 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-23T02:06:14.929266  <8>[   16.114839] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 449607_1.5.2.4.1>
    2023-12-23T02:06:15.034243  / # #
    2023-12-23T02:06:15.135846  export SHELL=3D/bin/sh
    2023-12-23T02:06:15.136412  #
    2023-12-23T02:06:15.237396  / # export SHELL=3D/bin/sh. /lava-449607/en=
vironment
    2023-12-23T02:06:15.238011  =

    2023-12-23T02:06:15.339012  / # . /lava-449607/environment/lava-449607/=
bin/lava-test-runner /lava-449607/1
    2023-12-23T02:06:15.339868  =

    2023-12-23T02:06:15.344573  / # /lava-449607/bin/lava-test-runner /lava=
-449607/1
    2023-12-23T02:06:15.376680  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/658640aba6f1d61b2fe137d2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-109-gfda221fa55986/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-109-gfda221fa55986/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/658640aba6f1d61b2fe137d7
        failing since 30 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-23T02:14:05.501313  / # #

    2023-12-23T02:14:05.603347  export SHELL=3D/bin/sh

    2023-12-23T02:14:05.604057  #

    2023-12-23T02:14:05.705416  / # export SHELL=3D/bin/sh. /lava-12358413/=
environment

    2023-12-23T02:14:05.706164  =


    2023-12-23T02:14:05.807550  / # . /lava-12358413/environment/lava-12358=
413/bin/lava-test-runner /lava-12358413/1

    2023-12-23T02:14:05.808709  =


    2023-12-23T02:14:05.825633  / # /lava-12358413/bin/lava-test-runner /la=
va-12358413/1

    2023-12-23T02:14:05.883794  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-23T02:14:05.884401  + cd /lava-1235841<8>[   16.802041] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12358413_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

