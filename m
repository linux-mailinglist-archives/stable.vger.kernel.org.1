Return-Path: <stable+bounces-3900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34062803A50
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 17:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3FCA1F211D5
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 16:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA66824B49;
	Mon,  4 Dec 2023 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="SKTTG/0d"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB858A4
	for <stable@vger.kernel.org>; Mon,  4 Dec 2023 08:30:49 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5c230c79c0bso1628243a12.1
        for <stable@vger.kernel.org>; Mon, 04 Dec 2023 08:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701707448; x=1702312248; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kfuYjx/K7fUxe+wjJsnyMUv5RvuTFMEPAckUcnjAVCE=;
        b=SKTTG/0deAEigRvnHguFAPVGB6AblDMZPD+R7A3a/Z8j5VaZ7fvzxCAADtyVdWVoLx
         Vb4V+AdziS1CNZEbEUQM+2NGlUVa/IV/nU5/F4qnZn2xhsQA0Tp5VtWbTd7YZVw5O9iY
         3XVQZIntm1q+JICG3KK4vMFBDHnr6iW5nDrvzCU9sAXswpCTXEDgUOXNBQDJe9bTFAXP
         2OlD/y00sS+4IQGt3lMc60BXgbQ8Ny/sD+D90izs5B8rZVmnbuTqg55HdmtlUrSajejQ
         NvXY0XS0ng5hwiqRh+1oMeoxzqwJp77VEqvfvoPpvYkcSE+Qj5Lkpn9JIyZmpmPBMzb7
         0XsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701707448; x=1702312248;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kfuYjx/K7fUxe+wjJsnyMUv5RvuTFMEPAckUcnjAVCE=;
        b=BB/6Vl4H//KMXYtcI3g2xrqraAD9r4dwDbzVevuLE0J+gKeVclz1KYIJzWpMGAeMQ2
         6sb3ezOeQzPN3fH6LKUkjvnedb4I0JbONB3j19ZNFt1cEjHXVgc4iJ+oak328n1rGlm1
         vu/I6b21OHzcoviSkQFdZqaSaAFRIwuij3zVnyHSHuu9Ca9TPM191l2AmarWDHczvs8K
         TJsecFNY4jCpN8nUh5UqZ9cTX0LaQ1bf8dzkC3spSytjzC9IpIrWzQPuHoSZH3Y06P/U
         1lCgZNQJW6ztekIsj7h3U6fPW5lOYxt2HyU+/K9va5CyF0DX7K2m4eTOdN/GK54h27Ur
         7o8w==
X-Gm-Message-State: AOJu0Yz60TbBwtpCf7vvbW/S/B+51VfJz6sropkEtkpEukpNhFFwDNzb
	L5oUJOJ2BiHBtJWq3gpX8UbOFfk0OKTFBsLfVzjFjg==
X-Google-Smtp-Source: AGHT+IHsqlUDiCfHXL55qo6oA0bMeaDDJUPbNsem/FG8eZJYRBNOI33u4wWhRfk9SyxBZp+Q5p0hjQ==
X-Received: by 2002:a05:6a20:e12a:b0:187:e646:4faf with SMTP id kr42-20020a056a20e12a00b00187e6464fafmr29423122pzb.14.1701707448610;
        Mon, 04 Dec 2023 08:30:48 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l11-20020a635b4b000000b005b6c1972c99sm7808382pgm.7.2023.12.04.08.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 08:30:48 -0800 (PST)
Message-ID: <656dfeb8.630a0220.ecb30.5e6c@mx.google.com>
Date: Mon, 04 Dec 2023 08:30:48 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.141-66-gb1cbb2de711a1
Subject: stable-rc/queue/5.15 baseline: 141 runs,
 5 regressions (v5.15.141-66-gb1cbb2de711a1)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 141 runs, 5 regressions (v5.15.141-66-gb1cbb=
2de711a1)

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
nel/v5.15.141-66-gb1cbb2de711a1/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.141-66-gb1cbb2de711a1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b1cbb2de711a1d58b0c9783ad24fec35ba25b583 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
kontron-pitx-imx8m | arm64 | lab-kontron   | gcc-10   | defconfig | 2      =
    =


  Details:     https://kernelci.org/test/plan/id/656dc89f882a12e292e13481

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-66-gb1cbb2de711a1/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx=
-imx8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-66-gb1cbb2de711a1/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx=
-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656dc89f882a12e292e13484
        new failure (last pass: v5.15.141-66-gec1ddec22d5c4)

    2023-12-04T12:39:51.505729  / # #
    2023-12-04T12:39:51.607886  export SHELL=3D/bin/sh
    2023-12-04T12:39:51.608281  #
    2023-12-04T12:39:51.709266  / # export SHELL=3D/bin/sh. /lava-401651/en=
vironment
    2023-12-04T12:39:51.710023  =

    2023-12-04T12:39:51.811531  / # . /lava-401651/environment/lava-401651/=
bin/lava-test-runner /lava-401651/1
    2023-12-04T12:39:51.812757  =

    2023-12-04T12:39:51.816766  / # /lava-401651/bin/lava-test-runner /lava=
-401651/1
    2023-12-04T12:39:51.878974  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-04T12:39:51.879407  + cd /l<8>[   12.205066] <LAVA_SIGNAL_START=
RUN 1_bootrr 401651_1.5.2.4.5> =

    ... (10 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/656=
dc89f882a12e292e13494
        new failure (last pass: v5.15.141-66-gec1ddec22d5c4)

    2023-12-04T12:39:54.206969  /lava-401651/1/../bin/lava-test-case
    2023-12-04T12:39:54.207393  <8>[   14.626509] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>
    2023-12-04T12:39:54.207680  /lava-401651/1/../bin/lava-test-case   =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/656dc8c9024be37dafe13475

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-66-gb1cbb2de711a1/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-66-gb1cbb2de711a1/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656dc8c9024be37dafe1347a
        failing since 11 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-04T12:47:53.173632  / # #

    2023-12-04T12:47:53.275795  export SHELL=3D/bin/sh

    2023-12-04T12:47:53.276497  #

    2023-12-04T12:47:53.377746  / # export SHELL=3D/bin/sh. /lava-12177809/=
environment

    2023-12-04T12:47:53.378437  =


    2023-12-04T12:47:53.479796  / # . /lava-12177809/environment/lava-12177=
809/bin/lava-test-runner /lava-12177809/1

    2023-12-04T12:47:53.480872  =


    2023-12-04T12:47:53.482261  / # /lava-12177809/bin/lava-test-runner /la=
va-12177809/1

    2023-12-04T12:47:53.546952  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-04T12:47:53.547456  + cd /lav<8>[   16.046749] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12177809_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/656dc8ba35d7aaabc1e1348d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-66-gb1cbb2de711a1/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-66-gb1cbb2de711a1/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656dc8ba35d7aaabc1e13492
        failing since 11 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-04T12:40:20.765002  / # #
    2023-12-04T12:40:20.866978  export SHELL=3D/bin/sh
    2023-12-04T12:40:20.867720  #
    2023-12-04T12:40:20.968891  / # export SHELL=3D/bin/sh. /lava-446512/en=
vironment
    2023-12-04T12:40:20.969579  =

    2023-12-04T12:40:21.070617  / # . /lava-446512/environment/lava-446512/=
bin/lava-test-runner /lava-446512/1
    2023-12-04T12:40:21.071563  =

    2023-12-04T12:40:21.073881  / # /lava-446512/bin/lava-test-runner /lava=
-446512/1
    2023-12-04T12:40:21.105906  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-04T12:40:21.147081  + cd /lava-446512/<8>[   16.586880] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 446512_1.5.2.4.5> =

    ... (10 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/656dc8cb7e9b6497cde13491

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-66-gb1cbb2de711a1/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-66-gb1cbb2de711a1/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656dc8cb7e9b6497cde13496
        failing since 11 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-04T12:48:09.152355  / # #

    2023-12-04T12:48:09.253185  export SHELL=3D/bin/sh

    2023-12-04T12:48:09.253410  #

    2023-12-04T12:48:09.353902  / # export SHELL=3D/bin/sh. /lava-12177826/=
environment

    2023-12-04T12:48:09.354048  =


    2023-12-04T12:48:09.454603  / # . /lava-12177826/environment/lava-12177=
826/bin/lava-test-runner /lava-12177826/1

    2023-12-04T12:48:09.454802  =


    2023-12-04T12:48:09.466035  / # /lava-12177826/bin/lava-test-runner /la=
va-12177826/1

    2023-12-04T12:48:09.528025  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-04T12:48:09.528111  + cd /lava-1217782<8>[   16.774501] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12177826_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

