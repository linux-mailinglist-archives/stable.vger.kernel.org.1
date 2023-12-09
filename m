Return-Path: <stable+bounces-5104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764A580B350
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 09:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13934B20B47
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 08:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFC8749C;
	Sat,  9 Dec 2023 08:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="DEYjkzS+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F262E10D0
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 00:44:48 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5bcfc508d14so2425008a12.3
        for <stable@vger.kernel.org>; Sat, 09 Dec 2023 00:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702111488; x=1702716288; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4F2XPgY08914Vj/3FBmhuVTlIm2LIbNcKs3sUWRuRg=;
        b=DEYjkzS+4KxkWvUMISEJncfoMqF7HBqEFwk6wDSmSB19389ViW31na9TtM35dnTmsp
         FeByS/VZ4fiBd746uLQf36v09VsGPA6ER9LwSDmGiDpgxrXhPwqgCSt8DSl09q6FfkLf
         wHQlUuNR501VuGbccGS3kaEaUf8xL7iNq9WxN3m/wPuiIZDDmZooymPP4u6+P+d3s+9z
         3Ri2TsC7KJVq0NzP7DBc08PzrZQ/WqDbmpwlR3WOuj3Vlc5RyTgIidvFs6UTPpT3egpN
         3VaNyn8rHHYAgUOfQVezQenc7IKk5I2IIqtTj4f2cnMtATHwqgPKOu9hZrVUrA0halC6
         wM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702111488; x=1702716288;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y4F2XPgY08914Vj/3FBmhuVTlIm2LIbNcKs3sUWRuRg=;
        b=GT1if228EIejpr4rEvBZD7abu5zHZfoqII4oveIVl6iDpu/OG4KdmV5T6sv8lb8+0x
         p3+YxKpbg5PWh/cRxCWz/Tx0gR8IylXUKiWY9vFM8N473VwfjggPrZg6Li4XSXJM8VPS
         bIMrTDGHzQTQvBAK49DcnMTZ5PLvOoIJMy091dBN9YZXNAUqi4AYntG3lQ8S56FwTHWO
         o1+f+G1oWL4HF/308J86D3n+oTzhOFlm9hcMIqi1uti3ZcMStDVWTVxj1IarzB4Bu3NV
         k138mkCKq6oW73sdIZcsS+dHRgazAFVWhKUvODlrrHVywdV7qMLHLvekxkyWzsXsEW2H
         KYNQ==
X-Gm-Message-State: AOJu0Yy9Zfa757ZgbtaKT9DrYKnj7QaIUN1j/jcxaV3Oxz8zwqgVG4eO
	JX9kHks5t8eFRSv9iVPvpST/eui5g3LJexoDPArHHg==
X-Google-Smtp-Source: AGHT+IH5jyK+3UA/WrKCZXCL6M7Zr0sna5eHXfp3MnqQHL1HmMF6d0+tQWeX3q7IbvGNgW24QlB50g==
X-Received: by 2002:a05:6a20:1445:b0:18c:aa14:ad4 with SMTP id a5-20020a056a20144500b0018caa140ad4mr1779659pzi.30.1702111488037;
        Sat, 09 Dec 2023 00:44:48 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id sc16-20020a17090b511000b002887e7ca212sm3169521pjb.18.2023.12.09.00.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 00:44:47 -0800 (PST)
Message-ID: <657428ff.170a0220.1cfa1.aac0@mx.google.com>
Date: Sat, 09 Dec 2023 00:44:47 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.142-48-gdbed703bb51c2
Subject: stable-rc/queue/5.15 baseline: 158 runs,
 5 regressions (v5.15.142-48-gdbed703bb51c2)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 158 runs, 5 regressions (v5.15.142-48-gdbed7=
03bb51c2)

Regressions Summary
-------------------

platform              | arch  | lab           | compiler | defconfig       =
   | regressions
----------------------+-------+---------------+----------+-----------------=
---+------------
at91-sama5d4_xplained | arm   | lab-baylibre  | gcc-10   | multi_v7_defconf=
ig | 1          =

panda                 | arm   | lab-baylibre  | gcc-10   | multi_v7_defconf=
ig | 1          =

r8a77960-ulcb         | arm64 | lab-collabora | gcc-10   | defconfig       =
   | 1          =

sun50i-h6-pine-h64    | arm64 | lab-clabbe    | gcc-10   | defconfig       =
   | 1          =

sun50i-h6-pine-h64    | arm64 | lab-collabora | gcc-10   | defconfig       =
   | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.142-48-gdbed703bb51c2/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.142-48-gdbed703bb51c2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      dbed703bb51c2f7ff36312dc544210731e815729 =



Test Regressions
---------------- =



platform              | arch  | lab           | compiler | defconfig       =
   | regressions
----------------------+-------+---------------+----------+-----------------=
---+------------
at91-sama5d4_xplained | arm   | lab-baylibre  | gcc-10   | multi_v7_defconf=
ig | 1          =


  Details:     https://kernelci.org/test/plan/id/6573f7e288f56e8a37e1351e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-48-gdbed703bb51c2/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91=
-sama5d4_xplained.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-48-gdbed703bb51c2/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91=
-sama5d4_xplained.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6573f7e288f56e8a37e13=
51f
        new failure (last pass: v5.15.142-8-g5d3692481649b) =

 =



platform              | arch  | lab           | compiler | defconfig       =
   | regressions
----------------------+-------+---------------+----------+-----------------=
---+------------
panda                 | arm   | lab-baylibre  | gcc-10   | multi_v7_defconf=
ig | 1          =


  Details:     https://kernelci.org/test/plan/id/6573f6c404ddfbe839e1348d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-48-gdbed703bb51c2/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pand=
a.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-48-gdbed703bb51c2/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pand=
a.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6573f6c404ddfbe839e13496
        failing since 2 days (last pass: v5.15.74-135-g19e8e8e20e2b, first =
fail: v5.15.141-64-g41591b7f348c5)

    2023-12-09T05:10:13.584653  <8>[   12.105346] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3869966_1.5.2.4.1>
    2023-12-09T05:10:13.689302  / # #
    2023-12-09T05:10:13.790376  export SHELL=3D/bin/sh
    2023-12-09T05:10:13.790701  #
    2023-12-09T05:10:13.891439  / # export SHELL=3D/bin/sh. /lava-3869966/e=
nvironment
    2023-12-09T05:10:13.891761  =

    2023-12-09T05:10:13.992515  / # . /lava-3869966/environment/lava-386996=
6/bin/lava-test-runner /lava-3869966/1
    2023-12-09T05:10:13.993047  =

    2023-12-09T05:10:13.998333  / # /lava-3869966/bin/lava-test-runner /lav=
a-3869966/1
    2023-12-09T05:10:14.057272  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform              | arch  | lab           | compiler | defconfig       =
   | regressions
----------------------+-------+---------------+----------+-----------------=
---+------------
r8a77960-ulcb         | arm64 | lab-collabora | gcc-10   | defconfig       =
   | 1          =


  Details:     https://kernelci.org/test/plan/id/6573f5396f643ab39be134e0

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-48-gdbed703bb51c2/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-48-gdbed703bb51c2/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6573f5396f643ab39be134e9
        failing since 16 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-09T05:11:21.506072  / # #

    2023-12-09T05:11:21.608158  export SHELL=3D/bin/sh

    2023-12-09T05:11:21.608919  #

    2023-12-09T05:11:21.710334  / # export SHELL=3D/bin/sh. /lava-12227014/=
environment

    2023-12-09T05:11:21.711061  =


    2023-12-09T05:11:21.812532  / # . /lava-12227014/environment/lava-12227=
014/bin/lava-test-runner /lava-12227014/1

    2023-12-09T05:11:21.813658  =


    2023-12-09T05:11:21.830161  / # /lava-12227014/bin/lava-test-runner /la=
va-12227014/1

    2023-12-09T05:11:21.879798  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-09T05:11:21.880355  + cd /lav<8>[   16.141486] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12227014_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform              | arch  | lab           | compiler | defconfig       =
   | regressions
----------------------+-------+---------------+----------+-----------------=
---+------------
sun50i-h6-pine-h64    | arm64 | lab-clabbe    | gcc-10   | defconfig       =
   | 1          =


  Details:     https://kernelci.org/test/plan/id/6573f54913fb5a9c83e13487

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-48-gdbed703bb51c2/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-48-gdbed703bb51c2/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6573f54913fb5a9c83e13490
        failing since 16 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-09T05:03:59.702367  <8>[   16.055278] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447235_1.5.2.4.1>
    2023-12-09T05:03:59.807345  / # #
    2023-12-09T05:03:59.909022  export SHELL=3D/bin/sh
    2023-12-09T05:03:59.909704  #
    2023-12-09T05:04:00.010674  / # export SHELL=3D/bin/sh. /lava-447235/en=
vironment
    2023-12-09T05:04:00.011261  =

    2023-12-09T05:04:00.112299  / # . /lava-447235/environment/lava-447235/=
bin/lava-test-runner /lava-447235/1
    2023-12-09T05:04:00.113287  =

    2023-12-09T05:04:00.117574  / # /lava-447235/bin/lava-test-runner /lava=
-447235/1
    2023-12-09T05:04:00.149815  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform              | arch  | lab           | compiler | defconfig       =
   | regressions
----------------------+-------+---------------+----------+-----------------=
---+------------
sun50i-h6-pine-h64    | arm64 | lab-collabora | gcc-10   | defconfig       =
   | 1          =


  Details:     https://kernelci.org/test/plan/id/6573f54f13fb5a9c83e134a1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-48-gdbed703bb51c2/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-48-gdbed703bb51c2/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6573f54f13fb5a9c83e134aa
        failing since 16 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-09T05:11:35.708186  / # #

    2023-12-09T05:11:35.810356  export SHELL=3D/bin/sh

    2023-12-09T05:11:35.811062  #

    2023-12-09T05:11:35.912357  / # export SHELL=3D/bin/sh. /lava-12227022/=
environment

    2023-12-09T05:11:35.913095  =


    2023-12-09T05:11:36.014593  / # . /lava-12227022/environment/lava-12227=
022/bin/lava-test-runner /lava-12227022/1

    2023-12-09T05:11:36.015707  =


    2023-12-09T05:11:36.032716  / # /lava-12227022/bin/lava-test-runner /la=
va-12227022/1

    2023-12-09T05:11:36.090520  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-09T05:11:36.091042  + cd /lava-1222702<8>[   16.762618] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12227022_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

