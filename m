Return-Path: <stable+bounces-4868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F655807A96
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 22:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E401C20F94
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 21:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D79F7097E;
	Wed,  6 Dec 2023 21:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="cQzPQqGg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2566798
	for <stable@vger.kernel.org>; Wed,  6 Dec 2023 13:37:54 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6cea5548eb2so109316b3a.0
        for <stable@vger.kernel.org>; Wed, 06 Dec 2023 13:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701898673; x=1702503473; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hnhyazKGGqCv7StmyyUOFN8WFmFgxQjnF1nPCtcgUAI=;
        b=cQzPQqGgufh3Q+B1+27PxxWXLdxddpUKV07C8DDIAtd2ha5pFrcuMlhQ7FS8rYZor3
         BLq3B0RKurswWMw6dQsoblw+VL5JGjluGuxd4IRlFQBzvINsVionl0Hr3OYA2RBKJStX
         eMFTVAlJKNV7wtFEm8X94GnqG0WhTyTBGbgJcNCG8W6A/0mL3wTs/UAcIldeYtoifKQE
         3JInoGnCJ64pn1c9Z7nwSsgblurJGJ2ikEtmiSyKBuPWkCix1jyKN3zk8VjjzvSLjVdA
         TOE/B1kbZyZztXqv3/v954IsyOdaOo8G9YHNaOXGjmJaBWZ8WnycyUXo7Fte+g6M1h0J
         W97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701898673; x=1702503473;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hnhyazKGGqCv7StmyyUOFN8WFmFgxQjnF1nPCtcgUAI=;
        b=gV+dJ2Pt/3/xSQqFR4tTCDh0bbkSul5ZvV2VYefe4o/UPLULSEsg/PXnAi0tWiOx0Y
         OjttNkY8QrB8fPUzVIY0E5qEdXHl9W7Flr1j76P1m2S4aW/eZ0+GqsSpaERquGwHJmnU
         5rjn+3TJn/WtDn1aAjEHVuGKYZc/LosX5btjC5reuj1YTbn0fyAAtZjKsOfQRbdJMF1j
         IuohtvV8aqYtyKkQn0+IKZID9uFRQmjtDU5S9IHlPACdtGuW2j7+RoEhb3q3gAgcUAqE
         MznZ1+2x8eVIdnKN5IvkcRIDD8HNcIBq7tBMnBV8tpYOrXA1TgUd5coLPquA0ziBrcdk
         gJbw==
X-Gm-Message-State: AOJu0YxffUuYITUqk9rNDGjrT55DVxckcsMM5/qc3M87irVpgm870hmX
	znbxgssONzpXuEhq1OdpICYD7vt4fC9wQlOVDL2BEQ==
X-Google-Smtp-Source: AGHT+IEHbyyPQhh7+Njtm3SOWmGhvIxv7mbYJAsAK2ULwnLCbHtC3j3oenV/7dMUkzlI93p7/QYRGA==
X-Received: by 2002:a05:6a00:9387:b0:6cd:d639:b353 with SMTP id ka7-20020a056a00938700b006cdd639b353mr1680374pfb.18.1701898673083;
        Wed, 06 Dec 2023 13:37:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v3-20020aa78503000000b006ce4c7ba448sm431072pfn.25.2023.12.06.13.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 13:37:52 -0800 (PST)
Message-ID: <6570e9b0.a70a0220.c1649.23da@mx.google.com>
Date: Wed, 06 Dec 2023 13:37:52 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.141-64-g41591b7f348c5
Subject: stable-rc/queue/5.15 baseline: 151 runs,
 4 regressions (v5.15.141-64-g41591b7f348c5)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 151 runs, 4 regressions (v5.15.141-64-g41591=
b7f348c5)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
panda              | arm   | lab-baylibre  | gcc-10   | multi_v7_defconfig =
| 1          =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
| 1          =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
| 1          =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
| 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.141-64-g41591b7f348c5/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.141-64-g41591b7f348c5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      41591b7f348c5e24dfe8663461cd674125e63e34 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
panda              | arm   | lab-baylibre  | gcc-10   | multi_v7_defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/6570b3ce5be52f7248e134df

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-64-g41591b7f348c5/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pand=
a.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-64-g41591b7f348c5/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pand=
a.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6570b3ce5be52f7248e134e4
        new failure (last pass: v5.15.74-135-g19e8e8e20e2b)

    2023-12-06T17:47:29.317978  <8>[   11.925445] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3863766_1.5.2.4.1>
    2023-12-06T17:47:29.422506  / # #
    2023-12-06T17:47:29.524033  export SHELL=3D/bin/sh
    2023-12-06T17:47:29.524408  #
    2023-12-06T17:47:29.625180  / # export SHELL=3D/bin/sh. /lava-3863766/e=
nvironment
    2023-12-06T17:47:29.625525  =

    2023-12-06T17:47:29.726379  / # . /lava-3863766/environment/lava-386376=
6/bin/lava-test-runner /lava-3863766/1
    2023-12-06T17:47:29.727503  =

    2023-12-06T17:47:29.732322  / # /lava-3863766/bin/lava-test-runner /lav=
a-3863766/1
    2023-12-06T17:47:29.786203  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
| 1          =


  Details:     https://kernelci.org/test/plan/id/6570b3bf5be52f7248e13479

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-64-g41591b7f348c5/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-64-g41591b7f348c5/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6570b3bf5be52f7248e1347e
        failing since 14 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-06T17:55:01.212818  / # #

    2023-12-06T17:55:01.313483  export SHELL=3D/bin/sh

    2023-12-06T17:55:01.313690  #

    2023-12-06T17:55:01.414149  / # export SHELL=3D/bin/sh. /lava-12200270/=
environment

    2023-12-06T17:55:01.414308  =


    2023-12-06T17:55:01.514815  / # . /lava-12200270/environment/lava-12200=
270/bin/lava-test-runner /lava-12200270/1

    2023-12-06T17:55:01.515059  =


    2023-12-06T17:55:01.526698  / # /lava-12200270/bin/lava-test-runner /la=
va-12200270/1

    2023-12-06T17:55:01.568416  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-06T17:55:01.585765  + cd /lav<8>[   15.958746] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12200270_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
| 1          =


  Details:     https://kernelci.org/test/plan/id/6570b3a114a1735ae1e13484

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-64-g41591b7f348c5/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-64-g41591b7f348c5/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6570b3a114a1735ae1e13489
        failing since 14 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-06T17:47:07.519726  <8>[   16.075469] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 446834_1.5.2.4.1>
    2023-12-06T17:47:07.625184  / # #
    2023-12-06T17:47:07.726852  export SHELL=3D/bin/sh
    2023-12-06T17:47:07.727391  #
    2023-12-06T17:47:07.828382  / # export SHELL=3D/bin/sh. /lava-446834/en=
vironment
    2023-12-06T17:47:07.828958  =

    2023-12-06T17:47:07.929945  / # . /lava-446834/environment/lava-446834/=
bin/lava-test-runner /lava-446834/1
    2023-12-06T17:47:07.931001  =

    2023-12-06T17:47:07.934687  / # /lava-446834/bin/lava-test-runner /lava=
-446834/1
    2023-12-06T17:47:07.966719  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
| 1          =


  Details:     https://kernelci.org/test/plan/id/6570b3d42fb4569dfce13550

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-64-g41591b7f348c5/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-64-g41591b7f348c5/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6570b3d42fb4569dfce13555
        failing since 14 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-06T17:55:16.007203  / # #

    2023-12-06T17:55:16.107663  export SHELL=3D/bin/sh

    2023-12-06T17:55:16.107834  #

    2023-12-06T17:55:16.208380  / # export SHELL=3D/bin/sh. /lava-12200248/=
environment

    2023-12-06T17:55:16.208615  =


    2023-12-06T17:55:16.309139  / # . /lava-12200248/environment/lava-12200=
248/bin/lava-test-runner /lava-12200248/1

    2023-12-06T17:55:16.309435  =


    2023-12-06T17:55:16.320931  / # /lava-12200248/bin/lava-test-runner /la=
va-12200248/1

    2023-12-06T17:55:16.382966  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-06T17:55:16.383463  + cd /lava-1220024<8>[   16.795405] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12200248_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

