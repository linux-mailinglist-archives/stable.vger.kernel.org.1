Return-Path: <stable+bounces-5026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF23580A581
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 15:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66887281831
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 14:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804671BDC3;
	Fri,  8 Dec 2023 14:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="RHGQ6TQ3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E32A1723
	for <stable@vger.kernel.org>; Fri,  8 Dec 2023 06:32:31 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5c1a75a4b6cso1455419a12.2
        for <stable@vger.kernel.org>; Fri, 08 Dec 2023 06:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702045950; x=1702650750; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9iOFNPjA7t6cNc/sYhrlDcHPPo+qT1lN5VRxCfjRXuo=;
        b=RHGQ6TQ3WXqEhPt5FMmWgP0ER2c0sefHuD4dJRWSia4VK7c7uzVzJtpO0suorwFhMQ
         X/AM/7nmWjmt+5o3AXW4pSUNAEzWDzimavZWcoXyHp+95LYldNUYPlt+Cl+feLtw4mid
         ObNWW4HQXJJH2xQWXEAk1TYyz6j2mS3nHGKSCb0vB+ay2o8P7mraQOFgb5HFzFqX1uve
         GHIdafzScW+FDc3lrq2BMz/AXuH3rOL4WeT8eS7dKujCKwYOLZQnKGPPOxYfu6MpddG/
         Xj2svXjlXvQvfMDlxo6LKM2Xo23eHU/iV0tuWBzYt3SvZrE8blysZ+EHlGjTfST0GYfc
         xaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702045950; x=1702650750;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9iOFNPjA7t6cNc/sYhrlDcHPPo+qT1lN5VRxCfjRXuo=;
        b=LDJ7Ny2oi1OGwagWZwxi1zSHorwgrhGyc50DiVTt/xoz7Td14Fu0GEE344VlvyvcHq
         6RRZVzzccfSCsAQk4q9JEuJZ/QjS0o0UJgWtqlS5JUlXK/yfRKPgmdk038jvpsu7ZGeX
         Fbg2x13Y+3iNukss0rD5TzwIEe9S7gbYcSM0HTmSVTRQwjfo2ikXMpMi2CQDl92XsyLl
         JZM4mdjM+7FuUU0z1RnJb5jQ0KLvT6aUzBTsYfht/li4e336poscHPx4qeYxuvn8RiVz
         kxIU0zEsCzhrWYEMq/K8z8RniR5u3QVCNzOau0G9dmAtOLHco869Y7dsiApemP8OKpue
         JHnA==
X-Gm-Message-State: AOJu0YxhqIJmwWqE5RugYXq738q9L4+Ayy7TCbqBZw7N7pUwks6YeqPW
	E7VFp6e3BgMic9u64Bv4MbXGtxcTFUwiuUhputyM7g==
X-Google-Smtp-Source: AGHT+IGaRDDsoDd/5nswXAZJNpm0YueI48Utm/JC69r/jl1nBGtcIN2F7a0HhuxB6O8YU2dTNVKiAg==
X-Received: by 2002:a17:90a:d143:b0:285:25b3:4d5d with SMTP id t3-20020a17090ad14300b0028525b34d5dmr175172pjw.8.1702045950003;
        Fri, 08 Dec 2023 06:32:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id sf3-20020a17090b51c300b0028a42f9d3ebsm671005pjb.53.2023.12.08.06.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 06:32:29 -0800 (PST)
Message-ID: <657328fd.170a0220.60bbc.2086@mx.google.com>
Date: Fri, 08 Dec 2023 06:32:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.142
Subject: stable/linux-5.15.y baseline: 236 runs, 8 regressions (v5.15.142)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable/linux-5.15.y baseline: 236 runs, 8 regressions (v5.15.142)

Regressions Summary
-------------------

platform                    | arch  | lab          | compiler | defconfig  =
                  | regressions
----------------------------+-------+--------------+----------+------------=
------------------+------------
kontron-pitx-imx8m          | arm64 | lab-kontron  | gcc-10   | defconfig  =
                  | 2          =

meson-gxbb-p200             | arm64 | lab-baylibre | gcc-10   | defconfig  =
                  | 1          =

meson-gxbb-p200             | arm64 | lab-baylibre | gcc-10   | defconfig+k=
selftest          | 1          =

sun7i-a20-cubieboard2       | arm   | lab-clabbe   | gcc-10   | multi_v7_de=
fconfig+kselftest | 1          =

sun8i-a33-olinuxino         | arm   | lab-clabbe   | gcc-10   | multi_v7_de=
fconfig+kselftest | 1          =

sun8i-h3-orangepi-pc        | arm   | lab-clabbe   | gcc-10   | multi_v7_de=
fconfig+kselftest | 1          =

sun8i-r40-bananapi-m2-ultra | arm   | lab-clabbe   | gcc-10   | multi_v7_de=
fconfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.15.y/kernel=
/v5.15.142/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.15.y
  Describe: v5.15.142
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      8a1d809b05454b2e08fb3d801787917975fdb037 =



Test Regressions
---------------- =



platform                    | arch  | lab          | compiler | defconfig  =
                  | regressions
----------------------------+-------+--------------+----------+------------=
------------------+------------
kontron-pitx-imx8m          | arm64 | lab-kontron  | gcc-10   | defconfig  =
                  | 2          =


  Details:     https://kernelci.org/test/plan/id/6572f1a2f71fb9f042e134d8

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.142/=
arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.142/=
arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6572f1a2f71fb9f042e134db
        new failure (last pass: v5.15.141)

    2023-12-08T10:35:53.481633  / # #
    2023-12-08T10:35:53.582574  export SHELL=3D/bin/sh
    2023-12-08T10:35:53.583209  #
    2023-12-08T10:35:53.684374  / # export SHELL=3D/bin/sh. /lava-403347/en=
vironment
    2023-12-08T10:35:53.685130  =

    2023-12-08T10:35:53.786412  / # . /lava-403347/environment/lava-403347/=
bin/lava-test-runner /lava-403347/1
    2023-12-08T10:35:53.787649  =

    2023-12-08T10:35:53.795962  / # /lava-403347/bin/lava-test-runner /lava=
-403347/1
    2023-12-08T10:35:53.853613  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-08T10:35:53.853976  + cd /l<8>[   12.149883] <LAVA_SIGNAL_START=
RUN 1_bootrr 403347_1.5.2.4.5> =

    ... (10 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/657=
2f1a2f71fb9f042e134eb
        new failure (last pass: v5.15.141)

    2023-12-08T10:35:56.176932  /lava-403347/1/../bin/lava-test-case
    2023-12-08T10:35:56.177350  <8>[   14.571323] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>   =

 =



platform                    | arch  | lab          | compiler | defconfig  =
                  | regressions
----------------------------+-------+--------------+----------+------------=
------------------+------------
meson-gxbb-p200             | arm64 | lab-baylibre | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6572f295c86c8acafae135d6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.142/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p200.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.142/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6572f295c86c8acafae13=
5d7
        new failure (last pass: v5.15.137) =

 =



platform                    | arch  | lab          | compiler | defconfig  =
                  | regressions
----------------------------+-------+--------------+----------+------------=
------------------+------------
meson-gxbb-p200             | arm64 | lab-baylibre | gcc-10   | defconfig+k=
selftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6572f795545fd7f830e13492

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.142/=
arm64/defconfig+kselftest/gcc-10/lab-baylibre/baseline-meson-gxbb-p200.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.142/=
arm64/defconfig+kselftest/gcc-10/lab-baylibre/baseline-meson-gxbb-p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6572f795545fd7f830e13=
493
        new failure (last pass: v5.15.137) =

 =



platform                    | arch  | lab          | compiler | defconfig  =
                  | regressions
----------------------------+-------+--------------+----------+------------=
------------------+------------
sun7i-a20-cubieboard2       | arm   | lab-clabbe   | gcc-10   | multi_v7_de=
fconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6572f5bc4b4d0219d8e13485

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.142/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun7i-a20-cubie=
board2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.142/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun7i-a20-cubie=
board2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6572f5bc4b4d0219d8e13=
486
        failing since 29 days (last pass: v5.15.137, first fail: v5.15.138) =

 =



platform                    | arch  | lab          | compiler | defconfig  =
                  | regressions
----------------------------+-------+--------------+----------+------------=
------------------+------------
sun8i-a33-olinuxino         | arm   | lab-clabbe   | gcc-10   | multi_v7_de=
fconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6572f5bb4b4d0219d8e1347f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.142/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-a33-olinu=
xino.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.142/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-a33-olinu=
xino.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6572f5bb4b4d0219d8e13=
480
        failing since 29 days (last pass: v5.15.137, first fail: v5.15.138) =

 =



platform                    | arch  | lab          | compiler | defconfig  =
                  | regressions
----------------------------+-------+--------------+----------+------------=
------------------+------------
sun8i-h3-orangepi-pc        | arm   | lab-clabbe   | gcc-10   | multi_v7_de=
fconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6572f737dd028b108ce13492

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.142/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-h3-orange=
pi-pc.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.142/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-h3-orange=
pi-pc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6572f737dd028b108ce13=
493
        failing since 29 days (last pass: v5.15.137, first fail: v5.15.138) =

 =



platform                    | arch  | lab          | compiler | defconfig  =
                  | regressions
----------------------------+-------+--------------+----------+------------=
------------------+------------
sun8i-r40-bananapi-m2-ultra | arm   | lab-clabbe   | gcc-10   | multi_v7_de=
fconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6572f723f52d2dc8e8e13525

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.142/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-r40-banan=
api-m2-ultra.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.142/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-r40-banan=
api-m2-ultra.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6572f723f52d2dc8e8e13=
526
        failing since 29 days (last pass: v5.15.137, first fail: v5.15.138) =

 =20

