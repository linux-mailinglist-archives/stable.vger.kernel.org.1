Return-Path: <stable+bounces-3577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E387FFD85
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 22:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B34C91C20D1B
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 21:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C000C5A0E1;
	Thu, 30 Nov 2023 21:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="g6NgVhSW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E291B4
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 13:30:08 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d03bcf27e9so7956715ad.0
        for <stable@vger.kernel.org>; Thu, 30 Nov 2023 13:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701379808; x=1701984608; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HZoiDywwzuD6sizBcyEKwj0p+qrR5wZzlu2Qr5n7grA=;
        b=g6NgVhSWUcpchUwiwLoSg8OcJjsI3XFRg+e0R1lM5KeJLY6NZR63tzbn6OivnI5Swm
         6aJMv3bDx1fNI6p2OXgv9PhWwtf0k3ySPpp4uDXGwh6qpeJ4IZEjtRxgHx4VQjSquiiz
         oromsQR2dXW/3HF3OcpptCOlmc9u5zaBuvTyvKFgoW64IJTX7WE+o7uAjPnKisGDC91i
         7DY+L8V9v7AS7Iuzg5R8uvBOZhcfNGYyaoM/ovxf32URZEp7AiGOlcA6x5QJ4uRtLwtB
         yFGxqskxpVU3GrMB47MIzMf/4aneKNprhn893dozl07CAeAsCdIlTRoO7TGwiM/iuLkm
         7+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701379808; x=1701984608;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HZoiDywwzuD6sizBcyEKwj0p+qrR5wZzlu2Qr5n7grA=;
        b=cI4xOdJtj5gVllu4JMWN04IQrLhIQs025Ne37sbLfjW0uILjpvTsIOanQRyJb1BGff
         EfpfKVG9ss449g2zMGxu4hr+uFLPqv1ditTKhy5YBQK41gYtPapR3ceLxQiYMmgd2L+S
         +juglRQsaxFD1YQuGxiWP2/QL0HGbYEkBF4OKBFm6ciaOJKwnUVjTFi5XR1DGbuIEwPB
         okd1hHcWiXNpm4aNuJPtFI02KES3k8b6uSWSMpcV38fyAArl+GZSQIphj7GzWqDkEx7M
         0Yncu9ORcyK4B9+p+q08+olVwYQT9/wZA2m45+wtpE9vY+IaAaRA80OtikTNFLZSVRMJ
         Vc8Q==
X-Gm-Message-State: AOJu0YxmCkKFGCZ11g2gDJJBI++wiOG0nBQL9WRPuRVqJsIL1DFoBgFG
	QxRO9tsi/7uWOZroNFLIbUd8YyRFsI8gKrnsiF5f1w==
X-Google-Smtp-Source: AGHT+IFiDF23gWmnZD8IRGFjojtRWIk9mAei2s3/T2cBlDy9LHd9abMeckCfY8erBuuyywGWK/vuqg==
X-Received: by 2002:a17:902:db02:b0:1cf:ca67:4336 with SMTP id m2-20020a170902db0200b001cfca674336mr17325159plx.11.1701379807672;
        Thu, 30 Nov 2023 13:30:07 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902ee4400b001d04c097d1esm304558plo.271.2023.11.30.13.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 13:30:07 -0800 (PST)
Message-ID: <6568fedf.170a0220.863f7.19d3@mx.google.com>
Date: Thu, 30 Nov 2023 13:30:07 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.202-70-g7a1294e8eed9d
Subject: stable-rc/queue/5.10 baseline: 139 runs,
 8 regressions (v5.10.202-70-g7a1294e8eed9d)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 139 runs, 8 regressions (v5.10.202-70-g7a129=
4e8eed9d)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =

r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =

sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
                  | 1          =

sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =

sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =

sun8i-h3-orangepi-pc         | arm   | lab-clabbe    | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.202-70-g7a1294e8eed9d/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.202-70-g7a1294e8eed9d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      7a1294e8eed9d6014a7eb559185e420d53c3623d =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6568cda3e3386b47587e4ab0

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-70-g7a1294e8eed9d/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.t=
xt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-70-g7a1294e8eed9d/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6568cda3e3386b47587e4aee
        new failure (last pass: v5.10.202-53-ga1e0fa8fccd1b)

    2023-11-30T17:59:33.312925  <8>[   14.051539] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 292350_1.5.2.4.1>
    2023-11-30T17:59:33.421583  / # #
    2023-11-30T17:59:33.524482  export SHELL=3D/bin/sh
    2023-11-30T17:59:33.525279  #
    2023-11-30T17:59:33.627264  / # export SHELL=3D/bin/sh. /lava-292350/en=
vironment
    2023-11-30T17:59:33.628056  =

    2023-11-30T17:59:33.730016  / # . /lava-292350/environment/lava-292350/=
bin/lava-test-runner /lava-292350/1
    2023-11-30T17:59:33.730707  =

    2023-11-30T17:59:33.744464  / # /lava-292350/bin/lava-test-runner /lava=
-292350/1
    2023-11-30T17:59:33.803415  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6568ccfadb23ce5b497e4a6d

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-70-g7a1294e8eed9d/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-70-g7a1294e8eed9d/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6568ccfadb23ce5b497e4a76
        failing since 8 days (last pass: v5.10.181-18-g1622068b57a4, first =
fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-30T18:03:17.930090  / # #

    2023-11-30T18:03:18.032269  export SHELL=3D/bin/sh

    2023-11-30T18:03:18.032991  #

    2023-11-30T18:03:18.134401  / # export SHELL=3D/bin/sh. /lava-12138448/=
environment

    2023-11-30T18:03:18.135117  =


    2023-11-30T18:03:18.236499  / # . /lava-12138448/environment/lava-12138=
448/bin/lava-test-runner /lava-12138448/1

    2023-11-30T18:03:18.237589  =


    2023-11-30T18:03:18.254811  / # /lava-12138448/bin/lava-test-runner /la=
va-12138448/1

    2023-11-30T18:03:18.303647  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-30T18:03:18.304168  + cd /lav<8>[   16.398909] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12138448_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6568ce24278853eb5b7e4ab8

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-70-g7a1294e8eed9d/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-70-g7a1294e8eed9d/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6568ce24278853eb5b7e4ac2
        failing since 261 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-11-30T18:04:18.931805  /lava-12138670/1/../bin/lava-test-case

    2023-11-30T18:04:18.941686  <8>[   35.822678] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6568ce24278853eb5b7e4ac3
        failing since 261 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-11-30T18:04:17.895040  /lava-12138670/1/../bin/lava-test-case

    2023-11-30T18:04:17.905905  <8>[   34.786567] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6568cce236975fc7bf7e4aeb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-70-g7a1294e8eed9d/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-70-g7a1294e8eed9d/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6568cce236975fc7bf7e4af4
        failing since 8 days (last pass: v5.10.176-241-ga0049fd9c865, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-30T17:56:40.052189  <8>[   16.957651] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 445944_1.5.2.4.1>
    2023-11-30T17:56:40.157221  / # #
    2023-11-30T17:56:40.258930  export SHELL=3D/bin/sh
    2023-11-30T17:56:40.259536  #
    2023-11-30T17:56:40.360528  / # export SHELL=3D/bin/sh. /lava-445944/en=
vironment
    2023-11-30T17:56:40.361125  =

    2023-11-30T17:56:40.462146  / # . /lava-445944/environment/lava-445944/=
bin/lava-test-runner /lava-445944/1
    2023-11-30T17:56:40.462982  =

    2023-11-30T17:56:40.467348  / # /lava-445944/bin/lava-test-runner /lava=
-445944/1
    2023-11-30T17:56:40.534521  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6568ccfce6d3893c4f7e4af7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-70-g7a1294e8eed9d/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-70-g7a1294e8eed9d/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6568ccfce6d3893c4f7e4b00
        failing since 8 days (last pass: v5.10.176-241-ga0049fd9c865, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-30T18:03:32.450590  / # #

    2023-11-30T18:03:32.551307  export SHELL=3D/bin/sh

    2023-11-30T18:03:32.552030  #

    2023-11-30T18:03:32.653304  / # export SHELL=3D/bin/sh. /lava-12138460/=
environment

    2023-11-30T18:03:32.654005  =


    2023-11-30T18:03:32.755459  / # . /lava-12138460/environment/lava-12138=
460/bin/lava-test-runner /lava-12138460/1

    2023-11-30T18:03:32.756555  =


    2023-11-30T18:03:32.764366  / # /lava-12138460/bin/lava-test-runner /la=
va-12138460/1

    2023-11-30T18:03:32.828870  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-30T18:03:32.829401  + cd /lava-1213846<8>[   18.243040] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12138460_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6568ccc88a14ead4517e4a7b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-70-g7a1294e8eed9d/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-70-g7a1294e8eed9d/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6568ccc88a14ead4517e4a84
        failing since 8 days (last pass: v5.10.165-77-g4600242c13ed, first =
fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-30T17:55:56.701139  <8>[    8.535757] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3854565_1.5.2.4.1>
    2023-11-30T17:55:56.818541  / # #
    2023-11-30T17:55:56.919710  export SHELL=3D/bin/sh
    2023-11-30T17:55:56.920105  #
    2023-11-30T17:55:57.020921  / # export SHELL=3D/bin/sh. /lava-3854565/e=
nvironment
    2023-11-30T17:55:57.021409  =

    2023-11-30T17:55:57.122225  / # . /lava-3854565/environment/lava-385456=
5/bin/lava-test-runner /lava-3854565/1
    2023-11-30T17:55:57.122921  =

    2023-11-30T17:55:57.131887  / # /lava-3854565/bin/lava-test-runner /lav=
a-3854565/1
    2023-11-30T17:55:57.229769  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun8i-h3-orangepi-pc         | arm   | lab-clabbe    | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6568ce37482db287737e4a9a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-70-g7a1294e8eed9d/arm/multi_v7_defconfig/gcc-10/lab-clabbe/baseline-sun8i-=
h3-orangepi-pc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-70-g7a1294e8eed9d/arm/multi_v7_defconfig/gcc-10/lab-clabbe/baseline-sun8i-=
h3-orangepi-pc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6568ce37482db287737e4=
a9b
        new failure (last pass: v5.10.202-53-ga1e0fa8fccd1b) =

 =20

