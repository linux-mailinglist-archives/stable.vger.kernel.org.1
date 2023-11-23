Return-Path: <stable+bounces-83-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731757F6608
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 19:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8589E1C2096E
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 18:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4294AF95;
	Thu, 23 Nov 2023 18:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="lZhST8/S"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A702D189
	for <stable@vger.kernel.org>; Thu, 23 Nov 2023 10:14:47 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6cb74a527ceso964518b3a.2
        for <stable@vger.kernel.org>; Thu, 23 Nov 2023 10:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700763286; x=1701368086; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mKXeu+BqZ/zQAo+KMTaQWsUEvAybuOGotxqFZuM8p+o=;
        b=lZhST8/S1BeoO3C5g8S7iNS9AB4A4j/BovRI9EIangx/Uvv/n4HIfP1ShTn6jF6Xuw
         8LpIb/gHp+tgdfccvzXJeKiJhRFJp2S/OD1askUMdE9YSzErzz6pRylENrgMtOPGnpc9
         o3903BADvjxEsZr6iYQQ6ejToweXzR7mnXS7iYqnm5k6buOR5p7RM+Q+FLHByqwLNLC/
         xQcl0s5c+ceh+MBuaLCyHtqdqygPN8IMliG8A7xwm5FCvUHUnvPiIbcl7BQCGD7BJpiP
         c2xNLVVV5WF6D/Wc2r6GcDz5LdQhgNjscxvmilTrIDALVAqEt+Iz9SmV8CQ3qaM+dMFb
         X/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700763286; x=1701368086;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mKXeu+BqZ/zQAo+KMTaQWsUEvAybuOGotxqFZuM8p+o=;
        b=kKEN5JFKCwEXudiQ29ryILSyWKsE4oiI6/pPf7t/5SrkqCOWdcJ1fF4IdGuUdKcLP0
         7v6Wa8qHQYHr55pgWARMtl3DFiaLrloL7o7XrggNPYI03u5O8A/5XHtKWqVOm9YE8Lhk
         a66/fKmEZIsTJv9sls5W709kMB7yT6CkqLr/NfeyGaCv3Pm84TZjd1VeGkMMHBj0EyPi
         F9LDgHc8Bi3XzgOoMVBIVqIYAYH16EZIy6KDxjXyK+A7K9y831XtPi7/TA5o+aXKc8Gh
         JPJGM0hHKDBz+i4mfHZyfWsOUVz9P0ks3BmoOaYsOjUWTI5S0hya30FCB8x9enPdUhCm
         cSRA==
X-Gm-Message-State: AOJu0YzabJ06JDEAOfq33pv1cfyM8KJmOdROK5B2XvXbpiBjojLHieVN
	1m6FnQCBG99BM/C9XfJ4x8HwWptUMWMHPTIfbEc=
X-Google-Smtp-Source: AGHT+IGTXTyPecR5gUuAYiQjc+Z9rcBZfcLU5qXo+rf0hyoxcTOwNiGxw+GwSRaLCFQVcbF3Q2lMXw==
X-Received: by 2002:a05:6a00:a0b:b0:6be:559:d030 with SMTP id p11-20020a056a000a0b00b006be0559d030mr306984pfh.19.1700763286602;
        Thu, 23 Nov 2023 10:14:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l9-20020a62be09000000b0068ff267f094sm1500759pff.158.2023.11.23.10.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 10:14:46 -0800 (PST)
Message-ID: <655f9696.620a0220.b68ef.3790@mx.google.com>
Date: Thu, 23 Nov 2023 10:14:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.63-262-gc57a2560e7ce
Subject: stable-rc/queue/6.1 baseline: 142 runs,
 5 regressions (v6.1.63-262-gc57a2560e7ce)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 142 runs, 5 regressions (v6.1.63-262-gc57a256=
0e7ce)

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


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.63-262-gc57a2560e7ce/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.63-262-gc57a2560e7ce
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      c57a2560e7ce0f2a2c5ef9429fe1146b6fd191c8 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
kontron-pitx-imx8m | arm64 | lab-kontron   | gcc-10   | defconfig | 2      =
    =


  Details:     https://kernelci.org/test/plan/id/655f63b7fb7bab02657e4ab5

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-26=
2-gc57a2560e7ce/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-im=
x8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-26=
2-gc57a2560e7ce/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-im=
x8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655f63b7fb7bab02657e4abc
        new failure (last pass: v6.1.63-236-gfd300c969e06)

    2023-11-23T14:37:35.190258  / # #
    2023-11-23T14:37:35.292371  export SHELL=3D/bin/sh
    2023-11-23T14:37:35.293087  #
    2023-11-23T14:37:35.394517  / # export SHELL=3D/bin/sh. /lava-397783/en=
vironment
    2023-11-23T14:37:35.395228  =

    2023-11-23T14:37:35.496449  / # . /lava-397783/environment/lava-397783/=
bin/lava-test-runner /lava-397783/1
    2023-11-23T14:37:35.496897  =

    2023-11-23T14:37:35.538383  / # /lava-397783/bin/lava-test-runner /lava=
-397783/1
    2023-11-23T14:37:35.567381  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-23T14:37:35.567603  + cd /lava-397783/1/tests/1_bootrr =

    ... (9 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/655=
f63b7fb7bab02657e4acc
        new failure (last pass: v6.1.63-236-gfd300c969e06)

    2023-11-23T14:37:37.933707  /lava-397783/1/../bin/lava-test-case
    2023-11-23T14:37:37.934177  <8>[   18.037987] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>   =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/655f63c5e245aff7a57e4a6d

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-26=
2-gc57a2560e7ce/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-26=
2-gc57a2560e7ce/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655f63c6e245aff7a57e4a76
        failing since 0 day (last pass: v6.1.31-26-gef50524405c2, first fai=
l: v6.1.63-176-gecc0fed1ffa4)

    2023-11-23T14:44:05.764139  / # #

    2023-11-23T14:44:05.866497  export SHELL=3D/bin/sh

    2023-11-23T14:44:05.867196  #

    2023-11-23T14:44:05.968589  / # export SHELL=3D/bin/sh. /lava-12067428/=
environment

    2023-11-23T14:44:05.969364  =


    2023-11-23T14:44:06.070833  / # . /lava-12067428/environment/lava-12067=
428/bin/lava-test-runner /lava-12067428/1

    2023-11-23T14:44:06.071939  =


    2023-11-23T14:44:06.088243  / # /lava-12067428/bin/lava-test-runner /la=
va-12067428/1

    2023-11-23T14:44:06.137499  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-23T14:44:06.138006  + cd /lav<8>[   19.064313] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12067428_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/655f63ac1eebc611a07e4a70

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-26=
2-gc57a2560e7ce/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-26=
2-gc57a2560e7ce/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655f63ac1eebc611a07e4a79
        failing since 0 day (last pass: v6.1.22-372-g971903477e72, first fa=
il: v6.1.63-176-gecc0fed1ffa4)

    2023-11-23T14:37:26.151964  <8>[   18.101740] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 445036_1.5.2.4.1>
    2023-11-23T14:37:26.257047  / # #
    2023-11-23T14:37:26.358625  export SHELL=3D/bin/sh
    2023-11-23T14:37:26.359199  #
    2023-11-23T14:37:26.460183  / # export SHELL=3D/bin/sh. /lava-445036/en=
vironment
    2023-11-23T14:37:26.460768  =

    2023-11-23T14:37:26.561775  / # . /lava-445036/environment/lava-445036/=
bin/lava-test-runner /lava-445036/1
    2023-11-23T14:37:26.562703  =

    2023-11-23T14:37:26.567123  / # /lava-445036/bin/lava-test-runner /lava=
-445036/1
    2023-11-23T14:37:26.640269  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/655f63c767d5db10ea7e4a71

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-26=
2-gc57a2560e7ce/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-26=
2-gc57a2560e7ce/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655f63c767d5db10ea7e4a7a
        failing since 0 day (last pass: v6.1.22-372-g971903477e72, first fa=
il: v6.1.63-176-gecc0fed1ffa4)

    2023-11-23T14:44:21.567167  / # #

    2023-11-23T14:44:21.669284  export SHELL=3D/bin/sh

    2023-11-23T14:44:21.670042  #

    2023-11-23T14:44:21.771513  / # export SHELL=3D/bin/sh. /lava-12067438/=
environment

    2023-11-23T14:44:21.772247  =


    2023-11-23T14:44:21.873772  / # . /lava-12067438/environment/lava-12067=
438/bin/lava-test-runner /lava-12067438/1

    2023-11-23T14:44:21.874913  =


    2023-11-23T14:44:21.891045  / # /lava-12067438/bin/lava-test-runner /la=
va-12067438/1

    2023-11-23T14:44:21.957060  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-23T14:44:21.957593  + cd /lava-1206743<8>[   18.826235] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12067438_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

