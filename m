Return-Path: <stable+bounces-7920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B948188AE
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 14:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CB60B21BDD
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 13:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9E518ED8;
	Tue, 19 Dec 2023 13:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="GkUQx4bu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A581B275
	for <stable@vger.kernel.org>; Tue, 19 Dec 2023 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6d2350636d6so3962471b3a.2
        for <stable@vger.kernel.org>; Tue, 19 Dec 2023 05:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702992709; x=1703597509; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6bOY+KUCKUqLZd27eDX85h5fm6QQ1A1Nr02gYXP3660=;
        b=GkUQx4buUQZN/SZEJx9RcksTLqSKZrPGVzHll+W+69gVZKqRqf8qm9qsEbzGrlBIGu
         GxND4V62b7NcsMDZxvW7YbZ5iT+NIkLpND/5KZBWEIThM4+MiB0uZhZej6x71OVlpLea
         3SP481zJkRr0fG45uBLM62AizZSjVwmw7phnmFpqT6zsbKi9iK6lAZy20JHasNvgJHnY
         xotFYlf9nITEm4JU9hw1u+NNNprI0PjuIbXBrwQew9cWuwznuTrpxUSmJSYLfUlU/OSy
         FiiBd1DCEAjiSpgo3hHhpGL6a3Nz/S7zej+87GYSoiTIzcxd3aoW+Rpc+sPQ7n9sFIF1
         4srg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702992709; x=1703597509;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6bOY+KUCKUqLZd27eDX85h5fm6QQ1A1Nr02gYXP3660=;
        b=dAKt3C1vnqKiBqEUdG6+48uLEfycUYK78QzcN+iWdcvvVbgOVEDaMer4/euKtLktT7
         8zMyKwvUYfUQ7S142H9RGys66h9Uu8aXZ1uRiNABiqO0q6F3sYe8e2iHvmO9Y8XXixQk
         tv+gmWFnghZArd4gydvJrOEZmc0nrSXKbczTKh6TClSuirbfMSfIe4GxGvcuf6J8nkIx
         WmAnKXUW7ix1K5Jdwpe2UdX+BeDhSpF7kk0lHLdoGhW2lwWZM3WqK0narmsT584ju4K3
         MTpMBfDfi0LKcMM84rYIHgH25pGwHcwXMqbtTgrXHi0y1zQ1nS11u4jr2K6ZQntY+QUl
         JEVQ==
X-Gm-Message-State: AOJu0Ywx1ruOwt2OCdQZrhKPdYbL2eScu9H8e+DTbmV85ZByviTaSQSP
	uM73Z1X1Hh05Mbz4IGxjx0EKcqb2A40KJYWBZ3U=
X-Google-Smtp-Source: AGHT+IFLV5QOgsB2ydJKpsOZVKDRV14Gbsf1JDMS5Z+8xebXrLD0/+43vadEm0Cshf29fbI6i7gwmw==
X-Received: by 2002:a05:6a20:1381:b0:18f:97c:8a52 with SMTP id hn1-20020a056a20138100b0018f097c8a52mr16543478pzc.125.1702992709060;
        Tue, 19 Dec 2023 05:31:49 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ka24-20020a056a00939800b006ce39a397b9sm4871000pfb.48.2023.12.19.05.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 05:31:48 -0800 (PST)
Message-ID: <65819b44.050a0220.68b4.bc39@mx.google.com>
Date: Tue, 19 Dec 2023 05:31:48 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.143-82-g6d719f63e58e
Subject: stable-rc/queue/5.15 baseline: 107 runs,
 5 regressions (v5.15.143-82-g6d719f63e58e)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 107 runs, 5 regressions (v5.15.143-82-g6d719=
f63e58e)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
kontron-pitx-imx8m | arm64 | lab-kontron   | gcc-10   | defconfig | 2      =
    =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.143-82-g6d719f63e58e/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.143-82-g6d719f63e58e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      6d719f63e58e10cb9f5926405764d5087906abbc =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
kontron-pitx-imx8m | arm64 | lab-kontron   | gcc-10   | defconfig | 2      =
    =


  Details:     https://kernelci.org/test/plan/id/6581669c5c3566c2d1e1348c

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-82-g6d719f63e58e/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-=
imx8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-82-g6d719f63e58e/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-=
imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6581669d5c3566c2d1e1348f
        new failure (last pass: v5.15.143-83-g980d9a43cf444)

    2023-12-19T09:46:51.031517  / # #
    2023-12-19T09:46:51.133744  export SHELL=3D/bin/sh
    2023-12-19T09:46:51.134452  #
    2023-12-19T09:46:51.235804  / # export SHELL=3D/bin/sh. /lava-407870/en=
vironment
    2023-12-19T09:46:51.236501  =

    2023-12-19T09:46:51.338005  / # . /lava-407870/environment/lava-407870/=
bin/lava-test-runner /lava-407870/1
    2023-12-19T09:46:51.339142  =

    2023-12-19T09:46:51.343505  / # /lava-407870/bin/lava-test-runner /lava=
-407870/1
    2023-12-19T09:46:51.405666  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-19T09:46:51.406093  + cd /l<8>[   12.199259] <LAVA_SIGNAL_START=
RUN 1_bootrr 407870_1.5.2.4.5> =

    ... (10 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/658=
1669d5c3566c2d1e1349f
        new failure (last pass: v5.15.143-83-g980d9a43cf444)

    2023-12-19T09:46:53.757427  /lava-407870/1/../bin/lava-test-case
    2023-12-19T09:46:53.758055  <8>[   14.621743] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>
    2023-12-19T09:46:53.758393  /lava-407870/1/../bin/lava-test-case
    2023-12-19T09:46:53.758709  <8>[   14.641684] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dimx8mq-usb-phy-driver-present RESULT=3Dpass>   =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65816688767ad71339e13492

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-82-g6d719f63e58e/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-82-g6d719f63e58e/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65816688767ad71339e13497
        failing since 26 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-19T09:54:15.111663  / # #

    2023-12-19T09:54:15.212136  export SHELL=3D/bin/sh

    2023-12-19T09:54:15.212372  #

    2023-12-19T09:54:15.312826  / # export SHELL=3D/bin/sh. /lava-12312345/=
environment

    2023-12-19T09:54:15.312988  =


    2023-12-19T09:54:15.413485  / # . /lava-12312345/environment/lava-12312=
345/bin/lava-test-runner /lava-12312345/1

    2023-12-19T09:54:15.413828  =


    2023-12-19T09:54:15.425405  / # /lava-12312345/bin/lava-test-runner /la=
va-12312345/1

    2023-12-19T09:54:15.468357  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-19T09:54:15.484612  + cd /lav<8>[   15.966867] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12312345_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6581669c8fa6c45a17e13482

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-82-g6d719f63e58e/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine=
-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-82-g6d719f63e58e/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine=
-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6581669c8fa6c45a17e13487
        failing since 26 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-19T09:46:45.025405  <8>[   16.177814] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 448926_1.5.2.4.1>
    2023-12-19T09:46:45.130591  / # #
    2023-12-19T09:46:45.232300  export SHELL=3D/bin/sh
    2023-12-19T09:46:45.232908  #
    2023-12-19T09:46:45.333980  / # export SHELL=3D/bin/sh. /lava-448926/en=
vironment
    2023-12-19T09:46:45.334603  =

    2023-12-19T09:46:45.435642  / # . /lava-448926/environment/lava-448926/=
bin/lava-test-runner /lava-448926/1
    2023-12-19T09:46:45.436611  =

    2023-12-19T09:46:45.440406  / # /lava-448926/bin/lava-test-runner /lava=
-448926/1
    2023-12-19T09:46:45.472489  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6581669d5c3566c2d1e134c4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-82-g6d719f63e58e/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-82-g6d719f63e58e/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6581669d5c3566c2d1e134c9
        failing since 26 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-19T09:54:34.702214  / # #

    2023-12-19T09:54:34.804252  export SHELL=3D/bin/sh

    2023-12-19T09:54:34.805005  #

    2023-12-19T09:54:34.906369  / # export SHELL=3D/bin/sh. /lava-12312344/=
environment

    2023-12-19T09:54:34.907115  =


    2023-12-19T09:54:35.008622  / # . /lava-12312344/environment/lava-12312=
344/bin/lava-test-runner /lava-12312344/1

    2023-12-19T09:54:35.009773  =


    2023-12-19T09:54:35.016392  / # /lava-12312344/bin/lava-test-runner /la=
va-12312344/1

    2023-12-19T09:54:35.083481  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-19T09:54:35.083986  + cd /lava-1231234<8>[   16.776955] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12312344_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

