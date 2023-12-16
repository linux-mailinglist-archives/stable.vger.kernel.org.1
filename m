Return-Path: <stable+bounces-6855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B0F815694
	for <lists+stable@lfdr.de>; Sat, 16 Dec 2023 04:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F4B1C2423B
	for <lists+stable@lfdr.de>; Sat, 16 Dec 2023 03:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90AE1868;
	Sat, 16 Dec 2023 03:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="UNIPDnSK"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7472C1869
	for <stable@vger.kernel.org>; Sat, 16 Dec 2023 03:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7b7039d30acso79572339f.3
        for <stable@vger.kernel.org>; Fri, 15 Dec 2023 19:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702695600; x=1703300400; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qilq5p8qrcZ+ZniQrEl220gkzRL8ky4kQPpAz582yxE=;
        b=UNIPDnSK3xWC6yOf0NzJ3Q6Wf9Ux2wst/rjrFZtE+qQmPspWYuL2kqrBbpJmc88cxP
         u9iouF3bITOsa8yNjSE26JzIFkexoEGCnF2Cl2WQuqFLUzAjQCsasaSezExzJopr4Zhh
         w+AiILJ7JVNyyApo8lk7L3/M6ohpB2tKZOR/Q3Us5eQhD6b4dAbY16O04iAKJpwgpSpW
         CBuaW9GJyy8Mfeq0LKBio7FbCzcEnhzbZvImilhtwHnUUN6sAQ1sllg3SLvd6OdiCuwr
         Gf59Xa5Z0e/wVSuBqNwvt/z3/gIFgbGyOQ3gEMIAJWg368lNe7jEbIlpSVDEcPZMMQ9f
         iJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702695600; x=1703300400;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qilq5p8qrcZ+ZniQrEl220gkzRL8ky4kQPpAz582yxE=;
        b=G4o7B+KlI9axUvOtsAIbVRWzuYw52eYxuxwMRi6KTXqZOoTYXXpYpr9mg3tjgpPyv5
         zRzK4Bv5tbRNIm6s6ipdnjNWobND4+0WsNndFSJLUdYDIqgMm8Fuhv86uZP4VwMdyxcb
         J5Vgoj7OQgzGM9BNOBr3dFWz749wKKuyBKGVTGJb2Srp5VH6x/b50JfPV/rWiOnNxye2
         C0Q+X9Tm5TMRcphXysCaTpzyuSgK7YJvyQjWF/kPAsxMgWZ5v5+kwAsriYOVtGnGYRfK
         XIHlRKKR5PONmGFFfV5CUFnDwHPS1DSe2TpKqAuIYWZ0fMMQ+UA1Kep3JQA75fakcaYm
         aWKg==
X-Gm-Message-State: AOJu0YwI9ChHIpu4/tYY6gr7509vWSu+Q2AOA3ppC2qHQkL1yVPvXR8E
	twMakX4W0sqUrRrVe7cw2LxddjunU5zi0h1Pdtg=
X-Google-Smtp-Source: AGHT+IHsEcDHUx9ymMJ5vVRySuLacGsdL5M5/YN+CWX5aB5+4r1p77i00lsF0tag9G4Ds25aPf2slA==
X-Received: by 2002:a92:280a:0:b0:35d:99ae:19e3 with SMTP id l10-20020a92280a000000b0035d99ae19e3mr15663648ilf.124.1702695600106;
        Fri, 15 Dec 2023 19:00:00 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id r15-20020a170903020f00b001cf5d0e7e05sm14875422plh.109.2023.12.15.18.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 18:59:59 -0800 (PST)
Message-ID: <657d12af.170a0220.48808.fcf4@mx.google.com>
Date: Fri, 15 Dec 2023 18:59:59 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.143-20-gec6c0b9aa1251
Subject: stable-rc/queue/5.15 baseline: 106 runs,
 3 regressions (v5.15.143-20-gec6c0b9aa1251)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 106 runs, 3 regressions (v5.15.143-20-gec6c0=
b9aa1251)

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
nel/v5.15.143-20-gec6c0b9aa1251/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.143-20-gec6c0b9aa1251
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      ec6c0b9aa1251b11c4b193c207b85e53210d5236 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657cdf6eabff1d30dfe1349c

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-20-gec6c0b9aa1251/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-20-gec6c0b9aa1251/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657cdf6eabff1d30dfe134a1
        failing since 23 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-15T23:28:45.552360  / # #

    2023-12-15T23:28:45.654886  export SHELL=3D/bin/sh

    2023-12-15T23:28:45.655610  #

    2023-12-15T23:28:45.757129  / # export SHELL=3D/bin/sh. /lava-12282820/=
environment

    2023-12-15T23:28:45.757851  =


    2023-12-15T23:28:45.859363  / # . /lava-12282820/environment/lava-12282=
820/bin/lava-test-runner /lava-12282820/1

    2023-12-15T23:28:45.860532  =


    2023-12-15T23:28:45.876682  / # /lava-12282820/bin/lava-test-runner /la=
va-12282820/1

    2023-12-15T23:28:45.926704  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-15T23:28:45.927223  + cd /lav<8>[   16.045671] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12282820_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657cdf70abff1d30dfe134aa

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-20-gec6c0b9aa1251/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-20-gec6c0b9aa1251/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657cdf70abff1d30dfe134af
        failing since 23 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-15T23:21:11.481028  / # #
    2023-12-15T23:21:11.583364  export SHELL=3D/bin/sh
    2023-12-15T23:21:11.584366  #
    2023-12-15T23:21:11.685818  / # export SHELL=3D/bin/sh. /lava-448277/en=
vironment
    2023-12-15T23:21:11.686756  =

    2023-12-15T23:21:11.787983  / # . /lava-448277/environment/lava-448277/=
bin/lava-test-runner /lava-448277/1
    2023-12-15T23:21:11.789422  =

    2023-12-15T23:21:11.802571  / # /lava-448277/bin/lava-test-runner /lava=
-448277/1
    2023-12-15T23:21:11.861621  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-15T23:21:11.861921  + cd /lava-448277/<8>[   16.569170] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 448277_1.5.2.4.5> =

    ... (10 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657cdf821ad6d03b6ae134c3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-20-gec6c0b9aa1251/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-20-gec6c0b9aa1251/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657cdf821ad6d03b6ae134c8
        failing since 23 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-15T23:28:59.918693  / # #

    2023-12-15T23:29:00.019176  export SHELL=3D/bin/sh

    2023-12-15T23:29:00.019298  #

    2023-12-15T23:29:00.119788  / # export SHELL=3D/bin/sh. /lava-12282829/=
environment

    2023-12-15T23:29:00.119902  =


    2023-12-15T23:29:00.220371  / # . /lava-12282829/environment/lava-12282=
829/bin/lava-test-runner /lava-12282829/1

    2023-12-15T23:29:00.220560  =


    2023-12-15T23:29:00.232483  / # /lava-12282829/bin/lava-test-runner /la=
va-12282829/1

    2023-12-15T23:29:00.293545  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-15T23:29:00.293622  + cd /lava-1228282<8>[   16.732816] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12282829_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

