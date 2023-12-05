Return-Path: <stable+bounces-4708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F32988059A9
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 17:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 222BF1C210B1
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 16:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DFA63DFB;
	Tue,  5 Dec 2023 16:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Wh64Kuxt"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279489E
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 08:15:29 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1fb104887fbso2531532fac.3
        for <stable@vger.kernel.org>; Tue, 05 Dec 2023 08:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701792928; x=1702397728; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i635OWIJE8e59D2d5pqWfEh7echbPMvYxU37iEfkPrI=;
        b=Wh64KuxtHv/L+0nOpOBMIwa4mV1GNn9fTYspuYfSTJx3MA3sGbzpHwuQyP3ykTgM9s
         JM5FLYAssxMnX0m1lNzQ16ONGiZu+J5lzKQDYL9Ubb7k8I4eaiRQIsPCDLGhEsgNIhaE
         Cuve8Q8gCJtG/8ZUE1mBj9WaOGe4O68OVSpJXJEhjIQtUzVFces8tOHe/dySZSKBLLGN
         78d9Csb7v3uSyShTRBrqJGKVnKP6PbRlzudT6eL8nOqV1BMv6ujRv4+lJRDzoSg7ufF/
         nWrveHaGcQrR44dp1DwIj0IH71y2nTzSyf2WfkcTCBoPnkmJ9vniaOehUIbvqxBl2UGi
         op9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701792928; x=1702397728;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i635OWIJE8e59D2d5pqWfEh7echbPMvYxU37iEfkPrI=;
        b=AwOWt28UmdkNqWGwk4vs7N+7km7Oyof7V20kpfw1BtsgAocrvTRMTUfT2VQ5hw/jJC
         ZvAwhUfy1vetQfjIOUlhHICNCp8eoTAyqlWOAjPGviHXwqtkRWre6Ueu5jCpV8LhMLQq
         KrUy2Ar9XpgFlqXVFkJlFQBY4SFrW/iWOC6XprvjcnXr33V33E+S2lPp1/JL50MfD/W9
         VJIcHvQVfYosPe3mb5lvf6HlpxTyS0qUe0UXnvPwLhIL0olntLuShYlUgig1TuCIob8n
         2X09SbtH6f3bqJR+icLx4YlnB3vHtE7x0x389pK+tgrUk8WT6Zj97TiWSXUmQdQclGTd
         6UEA==
X-Gm-Message-State: AOJu0YwEXgmHNGnIAkjrHPMiFcP6JsRq5+F6nxq2M/OvdKLiDAjgRfnJ
	yYKmRe/Lpmbyu9FHtzhYZJokQIr2Wo1gbIK69Su+Hw==
X-Google-Smtp-Source: AGHT+IHo+1S3oAMo20W+SLJQ4mYzhvZ+uN69CUFRRD1sjROoAWu4Cf6QaCbiepTwXVc0FHz68velvw==
X-Received: by 2002:a05:6870:9709:b0:1fb:75c:3fdf with SMTP id n9-20020a056870970900b001fb075c3fdfmr7030788oaq.63.1701792928000;
        Tue, 05 Dec 2023 08:15:28 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h12-20020a63210c000000b005aa800c149bsm9479195pgh.39.2023.12.05.08.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 08:15:27 -0800 (PST)
Message-ID: <656f4c9f.630a0220.97787.b443@mx.google.com>
Date: Tue, 05 Dec 2023 08:15:27 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.202-135-g9245256c4454
Subject: stable-rc/linux-5.10.y baseline: 146 runs,
 3 regressions (v5.10.202-135-g9245256c4454)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-5.10.y baseline: 146 runs, 3 regressions (v5.10.202-135-g92=
45256c4454)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
juno-uboot         | arm64 | lab-broonie   | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.202-135-g9245256c4454/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.202-135-g9245256c4454
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      9245256c4454e1add5a52d689fae93ba1d57c198 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
juno-uboot         | arm64 | lab-broonie   | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/656f19681c57b678e4e13481

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02-135-g9245256c4454/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02-135-g9245256c4454/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656f19691c57b678e4e134bc
        failing since 6 days (last pass: v5.10.201-185-ga30cecbc89f2f, firs=
t fail: v5.10.202)

    2023-12-05T12:36:25.163380  / # #
    2023-12-05T12:36:25.266268  export SHELL=3D/bin/sh
    2023-12-05T12:36:25.267043  #
    2023-12-05T12:36:25.369002  / # export SHELL=3D/bin/sh. /lava-308278/en=
vironment
    2023-12-05T12:36:25.369810  =

    2023-12-05T12:36:25.471875  / # . /lava-308278/environment/lava-308278/=
bin/lava-test-runner /lava-308278/1
    2023-12-05T12:36:25.473167  =

    2023-12-05T12:36:25.487586  / # /lava-308278/bin/lava-test-runner /lava=
-308278/1
    2023-12-05T12:36:25.546487  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-05T12:36:25.547023  + cd /lava-308278/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/656f1774bfc1947f72e13477

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02-135-g9245256c4454/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02-135-g9245256c4454/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656f1774bfc1947f72e1347c
        failing since 55 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-12-05T12:28:26.306192  <8>[   17.004136] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 446568_1.5.2.4.1>
    2023-12-05T12:28:26.411202  / # #
    2023-12-05T12:28:26.512843  export SHELL=3D/bin/sh
    2023-12-05T12:28:26.513416  #
    2023-12-05T12:28:26.614413  / # export SHELL=3D/bin/sh. /lava-446568/en=
vironment
    2023-12-05T12:28:26.614994  =

    2023-12-05T12:28:26.716030  / # . /lava-446568/environment/lava-446568/=
bin/lava-test-runner /lava-446568/1
    2023-12-05T12:28:26.716893  =

    2023-12-05T12:28:26.721328  / # /lava-446568/bin/lava-test-runner /lava=
-446568/1
    2023-12-05T12:28:26.787512  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/656f1789bfc1947f72e13514

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02-135-g9245256c4454/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02-135-g9245256c4454/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656f1789bfc1947f72e13518
        failing since 55 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-12-05T12:36:27.773531  / # #

    2023-12-05T12:36:27.875653  export SHELL=3D/bin/sh

    2023-12-05T12:36:27.876420  #

    2023-12-05T12:36:27.977827  / # export SHELL=3D/bin/sh. /lava-12186075/=
environment

    2023-12-05T12:36:27.978563  =


    2023-12-05T12:36:28.079940  / # . /lava-12186075/environment/lava-12186=
075/bin/lava-test-runner /lava-12186075/1

    2023-12-05T12:36:28.081050  =


    2023-12-05T12:36:28.097441  / # /lava-12186075/bin/lava-test-runner /la=
va-12186075/1

    2023-12-05T12:36:28.140726  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-05T12:36:28.156377  + cd /lava-1218607<8>[   18.077398] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12186075_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

