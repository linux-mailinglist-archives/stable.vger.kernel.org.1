Return-Path: <stable+bounces-5054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C31480ABFF
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 19:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 906E6B20AB8
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 18:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462DA41C82;
	Fri,  8 Dec 2023 18:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="aPmOcFKv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544B184
	for <stable@vger.kernel.org>; Fri,  8 Dec 2023 10:24:06 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1d048d38881so18385045ad.2
        for <stable@vger.kernel.org>; Fri, 08 Dec 2023 10:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702059845; x=1702664645; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gjhcGx0UpAs7XoUehADrF2o7M5vXS1DueIdUFGL3/Ns=;
        b=aPmOcFKvyWo3EVTRvHynoWZsPVr/V+I8Tj8k4SPH5cncYQnm1OWPj9UqHKutZa4N48
         BB8Iu7VgV0/n98XXgh0xktcgMcOT5WdwZNrc/fxp+7LTZO/2a8/AZeYfbFqxNIwVsaGk
         xRLVVzP3HEGJH3TB3L0TbhvTySpt8SYs/xPbkG1g+mGCDMl8VIGFAkRiyXvqbA3Xus1s
         cV+ZKowiMgkthDFhX7Dgb5Obg8Otu/jjtTHyo5rrbU6br8ApkTdjZQj7K7v/5XYVbi3K
         l+W7PZFaTy1MduKvQHobR+oiW/SzqzC4gMW3I8RVgFPVTonqtfHIxegSbGpKAHQUfRw3
         4guw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702059845; x=1702664645;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gjhcGx0UpAs7XoUehADrF2o7M5vXS1DueIdUFGL3/Ns=;
        b=jUgu2P0lYxs0oE/nVLncnFzWWZe53EsLkyN25ORtLFM6/3g35CXYJDs8b8hGsyS4go
         J0Hm6s3G5CEp5RoEjJdJyEuJbYzG6QI1MC51pwjpTfMEyHiW1rNw0LUHfc5OHKGYvPVQ
         5SHy6BW97j4yq38oY/ambF/uV4vNXfwSnk7PHmyOx227NqW6V632taauDN6ZIhNBULgy
         Sqb2eCt6+t4sULy1rTCGeHvYlzG6nmZ5E3QOyo4P4X/PEd/u5ZroOktzV9HYsa70Bu2w
         NVLnfVg6ylVSUlqzkmerpMORb01Ib6CGRd5zH0QT3Qd+dpOCD8j0ZA5dtdLS7zGDl/JZ
         4BIg==
X-Gm-Message-State: AOJu0YyNgDFr86ZMnrLALd9sEFO7H7fqqUdPbmuCeRfUZwOt1W3aDXQJ
	Zd6mfetCnMww3Es2MaDbmycme0lvD4Gl8sAAi1jmHA==
X-Google-Smtp-Source: AGHT+IHJHRpEB3L2UIeiDpY7PVmVNrw9HWrvGrrfw8SYWoPPBinp4+/C2IV8PyaNK0+mhgW6qrZGig==
X-Received: by 2002:a17:902:f54c:b0:1cf:cac4:cd1e with SMTP id h12-20020a170902f54c00b001cfcac4cd1emr513733plf.65.1702059845234;
        Fri, 08 Dec 2023 10:24:05 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z3-20020a1709028f8300b001d0242c0471sm1993685plo.224.2023.12.08.10.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 10:24:04 -0800 (PST)
Message-ID: <65735f44.170a0220.44ce9.766c@mx.google.com>
Date: Fri, 08 Dec 2023 10:24:04 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.203
Subject: stable-rc/linux-5.10.y baseline: 149 runs, 4 regressions (v5.10.203)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-5.10.y baseline: 149 runs, 4 regressions (v5.10.203)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
juno-uboot         | arm64 | lab-broonie   | gcc-10   | defconfig | 1      =
    =

meson-gxbb-p200    | arm64 | lab-baylibre  | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.203/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.203
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      d330ef1d295df26d38e7c6d8e74462ab8a396527 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
juno-uboot         | arm64 | lab-broonie   | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657331d02684023afbe13487

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
03/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
03/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657331d12684023afbe134c6
        new failure (last pass: v5.10.202-132-g3e5897d7b363)

    2023-12-08T15:09:49.739637  / # #
    2023-12-08T15:09:49.842704  export SHELL=3D/bin/sh
    2023-12-08T15:09:49.843540  #
    2023-12-08T15:09:49.945515  / # export SHELL=3D/bin/sh. /lava-325808/en=
vironment
    2023-12-08T15:09:49.946412  =

    2023-12-08T15:09:50.048458  / # . /lava-325808/environment/lava-325808/=
bin/lava-test-runner /lava-325808/1
    2023-12-08T15:09:50.049898  =

    2023-12-08T15:09:50.062631  / # /lava-325808/bin/lava-test-runner /lava=
-325808/1
    2023-12-08T15:09:50.122541  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-08T15:09:50.123090  + cd /lava-325808/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
meson-gxbb-p200    | arm64 | lab-baylibre  | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65732f34a6c76c1cffe1347d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
03/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p200.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
03/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65732f34a6c76c1cffe13=
47e
        new failure (last pass: v5.10.199) =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65732e131ea01b9b6ee134a4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
03/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
03/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65732e131ea01b9b6ee134ad
        failing since 58 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-12-08T14:54:06.388258  / # #
    2023-12-08T14:54:06.490209  export SHELL=3D/bin/sh
    2023-12-08T14:54:06.490854  #
    2023-12-08T14:54:06.592004  / # export SHELL=3D/bin/sh. /lava-447118/en=
vironment
    2023-12-08T14:54:06.592516  =

    2023-12-08T14:54:06.693410  / # . /lava-447118/environment/lava-447118/=
bin/lava-test-runner /lava-447118/1
    2023-12-08T14:54:06.694333  =

    2023-12-08T14:54:06.697427  / # /lava-447118/bin/lava-test-runner /lava=
-447118/1
    2023-12-08T14:54:06.765451  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-08T14:54:06.766054  + cd /lava-447118/<8>[   17.480444] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 447118_1.5.2.4.5> =

    ... (10 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65732e201466767280e1347c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
03/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
03/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65732e201466767280e13485
        failing since 58 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-12-08T15:01:51.795153  / # #

    2023-12-08T15:01:51.897015  export SHELL=3D/bin/sh

    2023-12-08T15:01:51.897675  #

    2023-12-08T15:01:51.998984  / # export SHELL=3D/bin/sh. /lava-12220169/=
environment

    2023-12-08T15:01:51.999602  =


    2023-12-08T15:01:52.100921  / # . /lava-12220169/environment/lava-12220=
169/bin/lava-test-runner /lava-12220169/1

    2023-12-08T15:01:52.101963  =


    2023-12-08T15:01:52.103405  / # /lava-12220169/bin/lava-test-runner /la=
va-12220169/1

    2023-12-08T15:01:52.144616  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-08T15:01:52.177544  + cd /lava-1222016<8>[   18.353651] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12220169_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

