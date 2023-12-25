Return-Path: <stable+bounces-8440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FF081DE43
	for <lists+stable@lfdr.de>; Mon, 25 Dec 2023 06:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D6F8B20F13
	for <lists+stable@lfdr.de>; Mon, 25 Dec 2023 05:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C4610F1;
	Mon, 25 Dec 2023 05:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="DwIL7C5j"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF8FED7
	for <stable@vger.kernel.org>; Mon, 25 Dec 2023 05:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso2601837a12.3
        for <stable@vger.kernel.org>; Sun, 24 Dec 2023 21:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703482852; x=1704087652; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+VvvHqqbf1s7rx1IuERU2ZijHPb+zWdu7pZQdSlq0FU=;
        b=DwIL7C5j/9kEUl6mG1J393j1OycwrBOw9e2VMLzHVrmHBIZktKQnbzPNwEM2blsaKT
         ibhqFkpVfdSLFTIbscG0iWI18sjWetDEy7jcrX7s/CE2YZJ5Mj1HwACVWS7oKKbjkGNa
         xmNT/Z/aLUiseCr7AXHKtYSfxgGjFvy1ikDBMbD4QNiSfkkkxd+SXqDI1elNJN4Wucpk
         k5HYUKg4ytc9Z9zGKHM7NiGoXu9tsDGVSzHmnzkPeY2JZ4z9autH5SjbuCYX6TRYebx1
         FEsJzQXQzICp7U/4DS9ASD6nupNlH5QVi1f9aB8mLwjysG9vr8CyDQO8CmoV54rL10Y5
         jq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703482852; x=1704087652;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+VvvHqqbf1s7rx1IuERU2ZijHPb+zWdu7pZQdSlq0FU=;
        b=H2jskWKySYM2cXM7zkxu7Q5v9coTnoHFURQUYWkhJbQRFH6r+N/VMXBvCvL/8/DtUA
         vIlpxdDZjiruB+NWEMyiGJS/mHxWiDJDWOy1luWjGT6eq2LE+wK/WBOrdRlQ4QhIywtZ
         DnZ30JLMakoA6M6xRfFkMM5rK7Sr+T5fh4LeK4KHNlgUByihYjKCoIvxhJHdpZMMKRJL
         zHxyMRAac1/nm7w3F5PSy3uc7+/sa6YbtGps5XvCyaquN0YVChLJMtCwsvc8O9QtdKOh
         cw8KpSR9jkc1QUHAdna+v8RgwrZe7May/Fn1nYkkqIogD7dk20dG6Q9CPwcvqpi0Ji8h
         mrSA==
X-Gm-Message-State: AOJu0YxuzGA2npVgKbaHzLdGvv97foWN0F/fncFIwYcXkujaQ6M9DRy6
	1qMBhv3oXvB/KmPVzCX+QuwBqhZ1W6/im6SJ4q2+hS07dhQ=
X-Google-Smtp-Source: AGHT+IGn9Gi47yPDUxsVSCSAfUMoI2zi8CI4f4IYACsB5tV5Jn+cVy4z1TYwfKZba714LZi8LDZ1Sg==
X-Received: by 2002:a05:6a20:b728:b0:195:bf53:3b4c with SMTP id fg40-20020a056a20b72800b00195bf533b4cmr365457pzb.72.1703482851755;
        Sun, 24 Dec 2023 21:40:51 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g2-20020a056a000b8200b006d9b7b11e01sm1404874pfj.43.2023.12.24.21.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 21:40:51 -0800 (PST)
Message-ID: <658915e3.050a0220.96ad.26ae@mx.google.com>
Date: Sun, 24 Dec 2023 21:40:51 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.143-258-ge84d99cc1b357
Subject: stable-rc/queue/5.15 baseline: 104 runs,
 3 regressions (v5.15.143-258-ge84d99cc1b357)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 104 runs, 3 regressions (v5.15.143-258-ge84d=
99cc1b357)

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
nel/v5.15.143-258-ge84d99cc1b357/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.143-258-ge84d99cc1b357
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      e84d99cc1b35757391560aa9704c21c84c8cde18 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6588e15f87a41b0814e134a9

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-258-ge84d99cc1b357/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-258-ge84d99cc1b357/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6588e15f87a41b0814e134b2
        failing since 32 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-25T02:04:15.195521  / # #

    2023-12-25T02:04:15.296440  export SHELL=3D/bin/sh

    2023-12-25T02:04:15.297047  #

    2023-12-25T02:04:15.398304  / # export SHELL=3D/bin/sh. /lava-12376275/=
environment

    2023-12-25T02:04:15.398512  =


    2023-12-25T02:04:15.499184  / # . /lava-12376275/environment/lava-12376=
275/bin/lava-test-runner /lava-12376275/1

    2023-12-25T02:04:15.500103  =


    2023-12-25T02:04:15.507496  / # /lava-12376275/bin/lava-test-runner /la=
va-12376275/1

    2023-12-25T02:04:15.566434  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-25T02:04:15.566915  + cd /lav<8>[   16.011814] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12376275_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6588e15e87a41b0814e1349e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-258-ge84d99cc1b357/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-258-ge84d99cc1b357/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6588e15e87a41b0814e134a7
        failing since 32 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-25T01:56:35.814735  <8>[   16.056372] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 449833_1.5.2.4.1>
    2023-12-25T01:56:35.919711  / # #
    2023-12-25T01:56:36.021326  export SHELL=3D/bin/sh
    2023-12-25T01:56:36.021969  #
    2023-12-25T01:56:36.122951  / # export SHELL=3D/bin/sh. /lava-449833/en=
vironment
    2023-12-25T01:56:36.123583  =

    2023-12-25T01:56:36.224573  / # . /lava-449833/environment/lava-449833/=
bin/lava-test-runner /lava-449833/1
    2023-12-25T01:56:36.225497  =

    2023-12-25T01:56:36.230056  / # /lava-449833/bin/lava-test-runner /lava=
-449833/1
    2023-12-25T01:56:36.262114  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6588e17387a41b0814e134f5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-258-ge84d99cc1b357/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-258-ge84d99cc1b357/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6588e17387a41b0814e134fe
        failing since 32 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-25T02:04:29.331688  / # #

    2023-12-25T02:04:29.432420  export SHELL=3D/bin/sh

    2023-12-25T02:04:29.432661  #

    2023-12-25T02:04:29.533248  / # export SHELL=3D/bin/sh. /lava-12376277/=
environment

    2023-12-25T02:04:29.533513  =


    2023-12-25T02:04:29.634310  / # . /lava-12376277/environment/lava-12376=
277/bin/lava-test-runner /lava-12376277/1

    2023-12-25T02:04:29.635300  =


    2023-12-25T02:04:29.640312  / # /lava-12376277/bin/lava-test-runner /la=
va-12376277/1

    2023-12-25T02:04:29.709127  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-25T02:04:29.709603  + cd /lava-1237627<8>[   16.769699] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12376277_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

