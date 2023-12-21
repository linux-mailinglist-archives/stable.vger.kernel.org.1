Return-Path: <stable+bounces-8214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3266381AC3F
	for <lists+stable@lfdr.de>; Thu, 21 Dec 2023 02:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56FF41C23AEC
	for <lists+stable@lfdr.de>; Thu, 21 Dec 2023 01:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD341115;
	Thu, 21 Dec 2023 01:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="lZnrl7Bu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1538CAD24
	for <stable@vger.kernel.org>; Thu, 21 Dec 2023 01:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d3ef33e68dso2084905ad.1
        for <stable@vger.kernel.org>; Wed, 20 Dec 2023 17:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703122411; x=1703727211; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fgOn3hLGbsag7o+z0t/gNP687CffGfi0WVIYYMnia3o=;
        b=lZnrl7Buy1fWYWwzCRlLubJNcwnyJID+In6b7Xm3HWRNnVtweck5/ii9bRuUNQtMf1
         Z8+BxMFjQuk4oGGmnyE7n0gluw4BUFafVbY1sxSXWNgmKXRCKXda/eBaW+pcEF/dX0HI
         T2vT51h1qit2thsHjhHzzuXkcvjwyTpYV9LRm8Nn8MBKPhZikoDD0l7jzZO+scqJwf0R
         F0KsjOHkild0OjDN16Rd92ZF5O3djJ4AUTWOmPVgbA3hAPFgT2+4ThH1l6Qw4pr+Mnmw
         +PStBYiz8732PpvfIgWx6a456NAGuOXXz8bnxONiHtiuKGNqZqUXMtGYqSxD0GZNHORN
         0RJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703122411; x=1703727211;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fgOn3hLGbsag7o+z0t/gNP687CffGfi0WVIYYMnia3o=;
        b=WLNd6gk5GHZaATJ+phZRFrC8ZFhReXaDUSErpRpv/CgXAya7R733oOAuJaK+iVUfKj
         Wbs4Wibp6ntVe5MZ9z7Fwixe0ikpZMfbvqSHlh9VWSamy5JyEdajEBBKSqsCm35tgwv2
         6PDylcgGnQzTAxxogtQx6AkuBoMi4ckgR4EJPI/JLINv8WrDdUUhy+WP6LqIhQSrcdAS
         aWgLfl7ja/ykezSuVcZ7fzR3MmGrCkv+P1OCEXcjmHh5s36W2giqlulFwn/mph7g6i+b
         VAIJXovLbZuMgVV2bMzAc3w+j4j/mBtcvhULsZ+twoSWS4Mhy6H2Ry9OXmCdCI+IR7Rv
         pr+g==
X-Gm-Message-State: AOJu0Yz087r0UwXidkmYFnZ8p/VvpjDKpaFw2D6N8VXoikEJ9pg1xLDE
	vykXBDogrYah4EaabtInnz77Hzu+tHsqBc0Ra/Q=
X-Google-Smtp-Source: AGHT+IGXehTWIw85EKME+2HPBzfuxFd0HHwBSR43lvkKkT/J+3UIURSHX8Vqjf5qLXhamAJzVKdwQg==
X-Received: by 2002:a17:902:ea0e:b0:1d3:b609:eb0b with SMTP id s14-20020a170902ea0e00b001d3b609eb0bmr4598687plg.27.1703122410928;
        Wed, 20 Dec 2023 17:33:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902aa8900b001c407fac227sm365272plr.41.2023.12.20.17.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 17:33:30 -0800 (PST)
Message-ID: <658395ea.170a0220.e060b.19f3@mx.google.com>
Date: Wed, 20 Dec 2023 17:33:30 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.143-83-g1d146b1875fc9
Subject: stable-rc/queue/5.15 baseline: 103 runs,
 3 regressions (v5.15.143-83-g1d146b1875fc9)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 103 runs, 3 regressions (v5.15.143-83-g1d146=
b1875fc9)

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
nel/v5.15.143-83-g1d146b1875fc9/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.143-83-g1d146b1875fc9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      1d146b1875fc901ae6bfe26ec8fed15b8dcd97ae =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6583626fa0efd728d4e134c1

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-83-g1d146b1875fc9/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-83-g1d146b1875fc9/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6583626fa0efd728d4e134c6
        failing since 28 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-20T22:01:01.490359  / # #

    2023-12-20T22:01:01.590953  export SHELL=3D/bin/sh

    2023-12-20T22:01:01.591076  #

    2023-12-20T22:01:01.691563  / # export SHELL=3D/bin/sh. /lava-12330986/=
environment

    2023-12-20T22:01:01.691684  =


    2023-12-20T22:01:01.792181  / # . /lava-12330986/environment/lava-12330=
986/bin/lava-test-runner /lava-12330986/1

    2023-12-20T22:01:01.792371  =


    2023-12-20T22:01:01.798893  / # /lava-12330986/bin/lava-test-runner /la=
va-12330986/1

    2023-12-20T22:01:01.857995  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-20T22:01:01.858075  + cd /lav<8>[   16.027448] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12330986_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6583624c394a9c5964e13477

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-83-g1d146b1875fc9/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-83-g1d146b1875fc9/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6583624c394a9c5964e1347c
        failing since 28 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-20T21:53:08.222899  <8>[   16.094349] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 449223_1.5.2.4.1>
    2023-12-20T21:53:08.327800  / # #
    2023-12-20T21:53:08.429464  export SHELL=3D/bin/sh
    2023-12-20T21:53:08.430056  #
    2023-12-20T21:53:08.531051  / # export SHELL=3D/bin/sh. /lava-449223/en=
vironment
    2023-12-20T21:53:08.531660  =

    2023-12-20T21:53:08.632641  / # . /lava-449223/environment/lava-449223/=
bin/lava-test-runner /lava-449223/1
    2023-12-20T21:53:08.633466  =

    2023-12-20T21:53:08.638119  / # /lava-449223/bin/lava-test-runner /lava=
-449223/1
    2023-12-20T21:53:08.706293  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/658362703c48dc3ddae13478

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-83-g1d146b1875fc9/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-83-g1d146b1875fc9/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/658362703c48dc3ddae1347d
        failing since 28 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-20T22:01:15.993859  / # #

    2023-12-20T22:01:16.094474  export SHELL=3D/bin/sh

    2023-12-20T22:01:16.095205  #

    2023-12-20T22:01:16.196617  / # export SHELL=3D/bin/sh. /lava-12330989/=
environment

    2023-12-20T22:01:16.197346  =


    2023-12-20T22:01:16.298823  / # . /lava-12330989/environment/lava-12330=
989/bin/lava-test-runner /lava-12330989/1

    2023-12-20T22:01:16.299993  =


    2023-12-20T22:01:16.308236  / # /lava-12330989/bin/lava-test-runner /la=
va-12330989/1

    2023-12-20T22:01:16.374184  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-20T22:01:16.374699  + cd /lava-1233098<8>[   16.838621] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12330989_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

