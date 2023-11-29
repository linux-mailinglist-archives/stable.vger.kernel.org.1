Return-Path: <stable+bounces-3162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDC77FDD90
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 17:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304101F20FC0
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 16:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABCA39854;
	Wed, 29 Nov 2023 16:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="L3C8tDpj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1038EA8
	for <stable@vger.kernel.org>; Wed, 29 Nov 2023 08:48:39 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-280351c32afso6374123a91.1
        for <stable@vger.kernel.org>; Wed, 29 Nov 2023 08:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701276518; x=1701881318; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AfDV51zohmYVgRWrFVN5Eb2i8rEXMD5nwXbGQTJqKxQ=;
        b=L3C8tDpjxdnJQKZYJtcYKgzscJH4liZmxRy/4QtMLjid7N4u2SRxyvDa5n9+mD+O8l
         qtNzQWr2fwxDWr81yHSedxNP4imOhovKCgmtjWWJTF8Y2UO2tJFurea72EZ2vAU+Z8Jx
         uCLaMRZpsPz50nE1BqDKqavtfLy9oJJx9XkqspX15NeYmLJbBr2XsmuVisSHxfwgAcuo
         eaCF7GFgwiLaGaxPFcrnBifzrnrfv7MxcGKvYf7dY6JJ1+IffuC8I6T7EDpvWQ9WWIU+
         N5hPsi06NtCqAYwDGaRD4Zpbcxoz7g0ZPQclJsnIxCbmA2935iOPIijTMtMhP/VLEeVQ
         +l2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701276518; x=1701881318;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AfDV51zohmYVgRWrFVN5Eb2i8rEXMD5nwXbGQTJqKxQ=;
        b=tCWdk+5va3wp3psIRIwp0zPR9TJq9lWmcY3EZam+eeW6GQvjUJyi585OEX8Z3pHzRa
         FZTAhvWTeA3YXU5xhbvlCWILw1GBvw5tR0q2dhsZDWv5ag9T6kovhlXZCImTq0XsTZHe
         QvcgD9K7dBjZH2H6POV6Qm8XB4c15PCZ0Bi/9bXNN5pyQSVV/8LP+SqkU3Rk4NcRWRoF
         ykEf108emHRZgKNLxCP1sANyUnhi6Fd8iXH5q0+ZhinfZhjgNx+JpvymrT76EHFNmtBF
         5BDcTB+fMxNYwK2tEsRZVxV1Eka6+lmDOwgIGS4M4Qu8wXv+fIxObPd4Uvd/3g08zTAA
         7UmA==
X-Gm-Message-State: AOJu0Yzy3mzCfZ61n15WPWVlbWJLx/SP084uafA8vKp2DOKevNW874nx
	sXX159m8uqgpXwq8mhTB0aLqJXjnJ5wYq2m8xs2bng==
X-Google-Smtp-Source: AGHT+IEzVBwGupU2RPiYrPBdF55/TPuF/OXvuLdS/UZYA3OJMQyWsq8wnASOKY6fE8+4SRtH4/afhA==
X-Received: by 2002:a17:90b:4c50:b0:285:8407:6152 with SMTP id np16-20020a17090b4c5000b0028584076152mr20130745pjb.8.1701276517944;
        Wed, 29 Nov 2023 08:48:37 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id om18-20020a17090b3a9200b0028589e08f62sm1598653pjb.25.2023.11.29.08.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 08:48:37 -0800 (PST)
Message-ID: <65676b65.170a0220.197cb.4735@mx.google.com>
Date: Wed, 29 Nov 2023 08:48:37 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.202-53-gc4c658517011c
Subject: stable-rc/queue/5.10 baseline: 136 runs,
 8 regressions (v5.10.202-53-gc4c658517011c)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 136 runs, 8 regressions (v5.10.202-53-gc4c65=
8517011c)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =

r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =

rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =

sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
                  | 1          =

sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =

sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.202-53-gc4c658517011c/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.202-53-gc4c658517011c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      c4c658517011c81c8211b3afe4502dffc3e090d7 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/656739964c7ce0c2717e4a80

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-53-gc4c658517011c/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-53-gc4c658517011c/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656739964c7ce0c2717e4ab9
        failing since 288 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-11-29T13:15:48.969740  <8>[   21.352476] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 286646_1.5.2.4.1>
    2023-11-29T13:15:49.076702  / # #
    2023-11-29T13:15:49.178250  export SHELL=3D/bin/sh
    2023-11-29T13:15:49.178653  #
    2023-11-29T13:15:49.280027  / # export SHELL=3D/bin/sh. /lava-286646/en=
vironment
    2023-11-29T13:15:49.280432  =

    2023-11-29T13:15:49.381660  / # . /lava-286646/environment/lava-286646/=
bin/lava-test-runner /lava-286646/1
    2023-11-29T13:15:49.382236  =

    2023-11-29T13:15:49.386983  / # /lava-286646/bin/lava-test-runner /lava=
-286646/1
    2023-11-29T13:15:49.489530  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65673a0f5b1e73ecff7e4adc

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-53-gc4c658517011c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-53-gc4c658517011c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65673a0f5b1e73ecff7e4ae5
        failing since 6 days (last pass: v5.10.181-18-g1622068b57a4, first =
fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-29T13:24:28.325171  / # #

    2023-11-29T13:24:28.425663  export SHELL=3D/bin/sh

    2023-11-29T13:24:28.425784  #

    2023-11-29T13:24:28.526248  / # export SHELL=3D/bin/sh. /lava-12120193/=
environment

    2023-11-29T13:24:28.526416  =


    2023-11-29T13:24:28.626910  / # . /lava-12120193/environment/lava-12120=
193/bin/lava-test-runner /lava-12120193/1

    2023-11-29T13:24:28.627089  =


    2023-11-29T13:24:28.638976  / # /lava-12120193/bin/lava-test-runner /la=
va-12120193/1

    2023-11-29T13:24:28.692231  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-29T13:24:28.692310  + cd /lav<8>[   16.430841] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12120193_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/65673affdc33641b067e4a8d

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-53-gc4c658517011c/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-53-gc4c658517011c/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/65673affdc33641b067e4a97
        failing since 260 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-11-29T13:24:12.668683  /lava-12120268/1/../bin/lava-test-case

    2023-11-29T13:24:12.679432  <8>[   35.133662] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/65673affdc33641b067e4a98
        failing since 260 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-11-29T13:24:11.631999  /lava-12120268/1/../bin/lava-test-case

    2023-11-29T13:24:11.642781  <8>[   34.096711] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65673b1adc6dbc271b7e4af1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-53-gc4c658517011c/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-roc=
k-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-53-gc4c658517011c/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-roc=
k-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65673b1adc6dbc271b7e4=
af2
        new failure (last pass: v5.10.201-187-g58b8fec6bec58) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65673a025b1e73ecff7e4a6d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-53-gc4c658517011c/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-53-gc4c658517011c/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65673a025b1e73ecff7e4a76
        failing since 6 days (last pass: v5.10.176-241-ga0049fd9c865, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-29T13:17:44.602800  <8>[   17.059909] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 445796_1.5.2.4.1>
    2023-11-29T13:17:44.707813  / # #
    2023-11-29T13:17:44.809492  export SHELL=3D/bin/sh
    2023-11-29T13:17:44.810079  #
    2023-11-29T13:17:44.911111  / # export SHELL=3D/bin/sh. /lava-445796/en=
vironment
    2023-11-29T13:17:44.911834  =

    2023-11-29T13:17:45.012858  / # . /lava-445796/environment/lava-445796/=
bin/lava-test-runner /lava-445796/1
    2023-11-29T13:17:45.013797  =

    2023-11-29T13:17:45.018053  / # /lava-445796/bin/lava-test-runner /lava=
-445796/1
    2023-11-29T13:17:45.085230  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65673a238f4362d5437e4a90

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-53-gc4c658517011c/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-53-gc4c658517011c/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65673a238f4362d5437e4a99
        failing since 6 days (last pass: v5.10.176-241-ga0049fd9c865, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-29T13:24:51.418851  / # #

    2023-11-29T13:24:51.521047  export SHELL=3D/bin/sh

    2023-11-29T13:24:51.521782  #

    2023-11-29T13:24:51.623183  / # export SHELL=3D/bin/sh. /lava-12120192/=
environment

    2023-11-29T13:24:51.623897  =


    2023-11-29T13:24:51.725308  / # . /lava-12120192/environment/lava-12120=
192/bin/lava-test-runner /lava-12120192/1

    2023-11-29T13:24:51.726395  =


    2023-11-29T13:24:51.742934  / # /lava-12120192/bin/lava-test-runner /la=
va-12120192/1

    2023-11-29T13:24:51.785739  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-29T13:24:51.800949  + cd /lava-1212019<8>[   18.199221] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12120192_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65673aa1930222d06e7e4a79

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-53-gc4c658517011c/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-53-gc4c658517011c/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65673aa1930222d06e7e4a82
        failing since 6 days (last pass: v5.10.165-77-g4600242c13ed, first =
fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-29T13:19:39.861953  / # #
    2023-11-29T13:19:39.963347  export SHELL=3D/bin/sh
    2023-11-29T13:19:39.963836  #
    2023-11-29T13:19:40.064693  / # export SHELL=3D/bin/sh. /lava-3853095/e=
nvironment
    2023-11-29T13:19:40.065133  =

    2023-11-29T13:19:40.165959  / # . /lava-3853095/environment/lava-385309=
5/bin/lava-test-runner /lava-3853095/1
    2023-11-29T13:19:40.166566  =

    2023-11-29T13:19:40.174065  / # /lava-3853095/bin/lava-test-runner /lav=
a-3853095/1
    2023-11-29T13:19:40.271987  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-29T13:19:40.272467  + cd /lava-3853095/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20

