Return-Path: <stable+bounces-3134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6657FD2F3
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 10:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8C0BB218D0
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 09:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E4917999;
	Wed, 29 Nov 2023 09:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="JWfKbI13"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCD31998
	for <stable@vger.kernel.org>; Wed, 29 Nov 2023 01:38:56 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b843b61d8aso3764172b6e.0
        for <stable@vger.kernel.org>; Wed, 29 Nov 2023 01:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701250735; x=1701855535; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ACNqif93OlR3ETTQWNZ4AN1QvC0rL1QAwI7DY9UC0ik=;
        b=JWfKbI13ZAusd1k+HnWXcAMz3oOHjjQS5JTSsopi2fsBqfZOC18HjwwZeaiN/2Vzjh
         Y3ymoQiJQ6HmQqP/gJnwbcm3lu6YLAjzKxaGON07o5Jq97KWL0YjATjh/t4rL2d2yW2Z
         l7pB4XrTZbT4k3EU5NFNgtSc5ZsKFI0rTowpf75d2xvOdiTcaKDypkFWTsl+hDSa/WKM
         T0R5nVO6E8JUff0N0Pg5Ozx8ePfyOcOU7/Mttu/2rFUIOm6wp9t7/BtzcgT0EszYG4QB
         Ei7xho8kg6LTCDYrbIBI+Xj+Vg4VwnYyly8Yhw8m2l2eOoaPI5xW2ZEkNMPvqG7zCHei
         Ypxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701250735; x=1701855535;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ACNqif93OlR3ETTQWNZ4AN1QvC0rL1QAwI7DY9UC0ik=;
        b=pjs/IgsaFEPqz9asY2mB8wOgCRKHVi2o/kvlu9If1Dz0L0cl7rh+tBnDrVbhDgZ1xX
         kzgY/yRkJRuxPIFIB6/SnpuJIucRx6lm1b+2cAk1Qhn6qH+9iHL3dpB0MRM7F70TZxYS
         5HH8JoB+KXSV5181vf9Jk2frnjvFtyb0EYzvblP3Ux49oW/kpPVnrjNTfy/vCqIynfOM
         m87ZLTp595RSljEandnK5AvXAbYodVrKhXP2Sj+CV/e+KJ2OlRVZPL9TMWJidx+sE+dT
         W1wsxyy9m9LNGm+ELDc2Ojs78e2qCH1ZCYNHD9FRXVIw+DlUs0zpaqVERxeYa+HiCXIy
         ki3Q==
X-Gm-Message-State: AOJu0YwZrF+ox6el0EFpIMuMJypNB/v+JmBC0Y71xs7yqX1AzgyITea6
	NxP/g0kBapklr/7fm+PeHX9IGd8T4+9+E7eo//8=
X-Google-Smtp-Source: AGHT+IH1CNXng8mgc2wd68Ul8sb2iMmeHpeG7JGqCIjURKiuzryMHGk3tI2vURLjsfM36Rmr+dAIWQ==
X-Received: by 2002:a05:6808:201b:b0:3b6:cd77:552e with SMTP id q27-20020a056808201b00b003b6cd77552emr24291025oiw.10.1701250735486;
        Wed, 29 Nov 2023 01:38:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y189-20020a62cec6000000b006cdd82337bcsm508007pfg.207.2023.11.29.01.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 01:38:54 -0800 (PST)
Message-ID: <656706ae.620a0220.218c7.0d4b@mx.google.com>
Date: Wed, 29 Nov 2023 01:38:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.202
Subject: stable-rc/linux-5.10.y baseline: 145 runs, 3 regressions (v5.10.202)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-5.10.y baseline: 145 runs, 3 regressions (v5.10.202)

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
nel/v5.10.202/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.202
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      479e8b8925415420b31e2aa65f9b0db3dea2adf4 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
juno-uboot         | arm64 | lab-broonie   | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6566d5255323c9da4a7e4a80

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6566d5255323c9da4a7e4abe
        new failure (last pass: v5.10.201-185-ga30cecbc89f2f)

    2023-11-29T06:07:09.132798  / # #
    2023-11-29T06:07:09.235608  export SHELL=3D/bin/sh
    2023-11-29T06:07:09.236367  #
    2023-11-29T06:07:09.338180  / # export SHELL=3D/bin/sh. /lava-285298/en=
vironment
    2023-11-29T06:07:09.338932  =

    2023-11-29T06:07:09.440883  / # . /lava-285298/environment/lava-285298/=
bin/lava-test-runner /lava-285298/1
    2023-11-29T06:07:09.442202  =

    2023-11-29T06:07:09.456739  / # /lava-285298/bin/lava-test-runner /lava=
-285298/1
    2023-11-29T06:07:09.515533  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-29T06:07:09.516066  + cd /lava-285298/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6566d3c89370224a937e4a73

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6566d3c89370224a937e4a7c
        failing since 49 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-11-29T06:01:34.572097  <8>[   16.942176] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 445725_1.5.2.4.1>
    2023-11-29T06:01:34.677136  / # #
    2023-11-29T06:01:34.778749  export SHELL=3D/bin/sh
    2023-11-29T06:01:34.779333  #
    2023-11-29T06:01:34.880329  / # export SHELL=3D/bin/sh. /lava-445725/en=
vironment
    2023-11-29T06:01:34.880918  =

    2023-11-29T06:01:34.981940  / # . /lava-445725/environment/lava-445725/=
bin/lava-test-runner /lava-445725/1
    2023-11-29T06:01:34.982828  =

    2023-11-29T06:01:34.987352  / # /lava-445725/bin/lava-test-runner /lava=
-445725/1
    2023-11-29T06:01:35.054480  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6566d3e64e65403d3e7e4ab9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6566d3e64e65403d3e7e4ac2
        failing since 49 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-11-29T06:08:30.729995  / # #

    2023-11-29T06:08:30.832179  export SHELL=3D/bin/sh

    2023-11-29T06:08:30.832876  #

    2023-11-29T06:08:30.934238  / # export SHELL=3D/bin/sh. /lava-12114934/=
environment

    2023-11-29T06:08:30.934940  =


    2023-11-29T06:08:31.036447  / # . /lava-12114934/environment/lava-12114=
934/bin/lava-test-runner /lava-12114934/1

    2023-11-29T06:08:31.037637  =


    2023-11-29T06:08:31.054034  / # /lava-12114934/bin/lava-test-runner /la=
va-12114934/1

    2023-11-29T06:08:31.097723  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-29T06:08:31.113054  + cd /lava-1211493<8>[   18.254033] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12114934_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

