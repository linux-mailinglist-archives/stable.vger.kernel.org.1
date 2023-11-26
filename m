Return-Path: <stable+bounces-2664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE457F908B
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 01:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92FD4B20F1A
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 00:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F87281B;
	Sun, 26 Nov 2023 00:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="cpOf6A/4"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B009D182
	for <stable@vger.kernel.org>; Sat, 25 Nov 2023 16:52:54 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-58a42c3cbb8so1769649eaf.3
        for <stable@vger.kernel.org>; Sat, 25 Nov 2023 16:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700959973; x=1701564773; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0Qt5mq7LlIBj7ff3j+t9lX7KBXFdggxVgNKly60GGaU=;
        b=cpOf6A/4o+YKFHlA2ZsQ5hvxG5ozwbmlYUCjXIQ4d88MJuzNJj0n/9CY2Ff51Zp11o
         C7DZVjDDccUiG/PmX93+FNY6UkiVMuuO+sbIy3lShZZTOntpCRk5XgeYN/uWh3Sbr/IZ
         W41oiTIpEohkDp7HrJwlGm8JBYyZ3q6XHNMdnhlSA230pvjrJn2icP6eda/ySihQitsI
         UG8WccPQfZtncyQtdFdr8aVUAnG4yr23FW9LTyktjQLblpAi0/eM7Tx5jr/yM77/imHa
         ezTUFclxZQrfHhCEXId3OEOKxm2OSWwuXKAvu8ZV1YppABr3uLby2NXv6Gd4yT3YzAaL
         CUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700959973; x=1701564773;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Qt5mq7LlIBj7ff3j+t9lX7KBXFdggxVgNKly60GGaU=;
        b=bSDJJUbEGWQufBm/XnX3BPrlqPN+iv+lf2wwgd53DASVtbifk4f8qGQOnCT3oTYlwm
         TA4RGgvkKJBv3ENTaforOft0eFsu2MxKYPJPinhWsE1t5Jq0ZmmKxvvkdHVBavjF5rcT
         2UdqyUO/XFsqxF9Sw09zGV6zCmwlSdTkhHYDaFftSq4kAbXr84ATB29pj3xEeoeLkNLw
         pBrzQF01J89TAwTsc4soCR1B2g5LS4+nxh1EUwCz5+kgcge82PP8W5SrmBjHl7fBkesd
         1r/VFsPwjNrgafqZP7Qpzeq1fKDSRSwK1RZINWVGE4SDjXA2qxudCl2P6T9EEsC8eiWz
         0PLg==
X-Gm-Message-State: AOJu0YxrKycNt4QOLB4/Mg3SaZPvpyY3KWboes0H4cSm2OsP3cZKdyw5
	7sHyumcR5mB4XkfHGOOxR7PnUZcr4mjSzLkvaak=
X-Google-Smtp-Source: AGHT+IH8VPOdqVdFWpTmTAy6ZKnNqbsyPTA7YquX2TBGRZ+zDGmVgsDdyQPAmZJ+0Hnew4pKiijmPw==
X-Received: by 2002:a05:6358:7e84:b0:16b:fa51:4862 with SMTP id o4-20020a0563587e8400b0016bfa514862mr6950651rwn.29.1700959973498;
        Sat, 25 Nov 2023 16:52:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z4-20020a63e104000000b005b944b20f34sm5330783pgh.85.2023.11.25.16.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 16:52:52 -0800 (PST)
Message-ID: <656296e4.630a0220.ad2d1.cc77@mx.google.com>
Date: Sat, 25 Nov 2023 16:52:52 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.201-189-gf8438240ed9e5
Subject: stable-rc/linux-5.10.y baseline: 123 runs,
 3 regressions (v5.10.201-189-gf8438240ed9e5)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-5.10.y baseline: 123 runs, 3 regressions (v5.10.201-189-gf8=
438240ed9e5)

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
nel/v5.10.201-189-gf8438240ed9e5/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.201-189-gf8438240ed9e5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      f8438240ed9e569bc85dde03dc0683f8cbe60be3 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
juno-uboot         | arm64 | lab-broonie   | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/656266869194f475d07e4acd

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
01-189-gf8438240ed9e5/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboo=
t.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
01-189-gf8438240ed9e5/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboo=
t.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656266869194f475d07e4b0c
        new failure (last pass: v5.10.201-189-gd26c78c8f941c)

    2023-11-25T21:26:04.832820  / # #
    2023-11-25T21:26:04.935874  export SHELL=3D/bin/sh
    2023-11-25T21:26:04.936636  #
    2023-11-25T21:26:05.038555  / # export SHELL=3D/bin/sh. /lava-273308/en=
vironment
    2023-11-25T21:26:05.039331  =

    2023-11-25T21:26:05.141324  / # . /lava-273308/environment/lava-273308/=
bin/lava-test-runner /lava-273308/1
    2023-11-25T21:26:05.142734  =

    2023-11-25T21:26:05.156288  / # /lava-273308/bin/lava-test-runner /lava=
-273308/1
    2023-11-25T21:26:05.216035  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-25T21:26:05.216544  + cd /lava-273308/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/656265f311932211977e4ac5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
01-189-gf8438240ed9e5/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
01-189-gf8438240ed9e5/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656265f311932211977e4ace
        failing since 45 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-11-25T21:23:53.510522  <8>[   16.974793] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 445293_1.5.2.4.1>
    2023-11-25T21:23:53.615580  / # #
    2023-11-25T21:23:53.717217  export SHELL=3D/bin/sh
    2023-11-25T21:23:53.717843  #
    2023-11-25T21:23:53.818834  / # export SHELL=3D/bin/sh. /lava-445293/en=
vironment
    2023-11-25T21:23:53.819436  =

    2023-11-25T21:23:53.920452  / # . /lava-445293/environment/lava-445293/=
bin/lava-test-runner /lava-445293/1
    2023-11-25T21:23:53.921329  =

    2023-11-25T21:23:53.925834  / # /lava-445293/bin/lava-test-runner /lava=
-445293/1
    2023-11-25T21:23:53.992860  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/656266089e6064d7527e4ae6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
01-189-gf8438240ed9e5/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-=
h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
01-189-gf8438240ed9e5/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-=
h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656266089e6064d7527e4aef
        failing since 45 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-11-25T21:30:40.060325  / # #

    2023-11-25T21:30:40.162299  export SHELL=3D/bin/sh

    2023-11-25T21:30:40.162555  #

    2023-11-25T21:30:40.263358  / # export SHELL=3D/bin/sh. /lava-12084450/=
environment

    2023-11-25T21:30:40.264041  =


    2023-11-25T21:30:40.365442  / # . /lava-12084450/environment/lava-12084=
450/bin/lava-test-runner /lava-12084450/1

    2023-11-25T21:30:40.366505  =


    2023-11-25T21:30:40.368402  / # /lava-12084450/bin/lava-test-runner /la=
va-12084450/1

    2023-11-25T21:30:40.409686  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-25T21:30:40.443523  + cd /lava-1208445<8>[   18.220900] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12084450_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

