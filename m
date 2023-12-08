Return-Path: <stable+bounces-5012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3442B80A3AC
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 13:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF349281879
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 12:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FE413ADC;
	Fri,  8 Dec 2023 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="K11S0l3N"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742441710
	for <stable@vger.kernel.org>; Fri,  8 Dec 2023 04:44:13 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1d0c4d84bf6so15051605ad.1
        for <stable@vger.kernel.org>; Fri, 08 Dec 2023 04:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702039452; x=1702644252; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w/1Pw167kffkwQnVVTwadAnK0RyJAJH85bxBGTljJEc=;
        b=K11S0l3NKJ78LMJXTycH0O7p74sBwS01Ivkf/WEJ8xPDagFxwNS28qVLE1b70kSY0w
         VOOeB8VPArf0GnU5LUtrtTBNd4RzN/m5ZjIMJ0n4NVD5Hvc30xAEfrEOA8QdsOLPaCVd
         bacvHvjXSQRFbJrf6ILanB8WeQQwL+KVx31jrdLQbzzhoefTYsv+jqjiAcjq+WFDUqna
         gsoTadbkAnyE5dmhrzRpz1KgWVwhxa/S2OaPE6+BgZ+ytlUd1Ws860gG7Xm4fzNhGa45
         1JQOv3s5IhL0pbjNoPsHTv4X7wmD/lldMz95T03o7kgBWNliy872jL2xCTSfcW+4eVy+
         8/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702039452; x=1702644252;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w/1Pw167kffkwQnVVTwadAnK0RyJAJH85bxBGTljJEc=;
        b=kXNLrduo3toiZZEe1G4S/pInhGVHtR2O8gWQ6MUJ7lVJeU0Yyf6sMYPJBWOHosw3zu
         q2R73TQkPzX/VU38mMdhtgbcPWevu4pTJvTz3Rpns6OarutHtwkpHmnhUPa/cyIdajnP
         q8siPafCCjfcRzjYZ3tUmqJYk5Gef/XeJsqt9+GGDmT4veFjBD+Jte/3LuT0vmAGPHUk
         pXdgqVBNQfmhyKGb9X7KGZQj9rCM8V3twziCZF7nqPyV3XA5NsdMR7dkX+ChHdOC59IS
         vl0w6LbE3oyL4eeJrSkyW+rJCAb00abvuTFg5JWZZSkmcClDTSZ68n+Vfn66Fc6Q7V2H
         XkUA==
X-Gm-Message-State: AOJu0YxVURvB43ixY/l5oW1XAZIEESpk4y8GH5hb3Z48NKrcpUoJ5DWc
	ok4VgSVezMDjvm7fpnrxFFrK8whstHEo+9yvuyqCxg==
X-Google-Smtp-Source: AGHT+IFuhbY1XIAHbiaNq2k8pVLkFYkLuIrLag+nstfL41lA0oJdHa4Kqr7SVWqf+rP8jPBVBxXfwA==
X-Received: by 2002:a17:902:b116:b0:1d0:6ffd:f21d with SMTP id q22-20020a170902b11600b001d06ffdf21dmr2904606plr.115.1702039452305;
        Fri, 08 Dec 2023 04:44:12 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j15-20020a170903024f00b001d0b080c7e6sm1576444plh.208.2023.12.08.04.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 04:44:11 -0800 (PST)
Message-ID: <65730f9b.170a0220.9ed59.46a5@mx.google.com>
Date: Fri, 08 Dec 2023 04:44:11 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.202-125-g174d7af0cf0e4
Subject: stable-rc/queue/5.10 baseline: 147 runs,
 9 regressions (v5.10.202-125-g174d7af0cf0e4)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 147 runs, 9 regressions (v5.10.202-125-g174d=
7af0cf0e4)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =

juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =

panda                        | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =

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


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.202-125-g174d7af0cf0e4/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.202-125-g174d7af0cf0e4
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      174d7af0cf0e46275e40e346f95b5ad806551e02 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/6572dad12b97b99c26e134ce

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-125-g174d7af0cf0e4/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-125-g174d7af0cf0e4/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6572dad12b97b99c26e13508
        failing since 297 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-12-08T08:58:31.374525  <8>[   19.185552] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 322993_1.5.2.4.1>
    2023-12-08T08:58:31.483933  / # #
    2023-12-08T08:58:31.586099  export SHELL=3D/bin/sh
    2023-12-08T08:58:31.586732  #
    2023-12-08T08:58:31.688314  / # export SHELL=3D/bin/sh. /lava-322993/en=
vironment
    2023-12-08T08:58:31.688865  =

    2023-12-08T08:58:31.790707  / # . /lava-322993/environment/lava-322993/=
bin/lava-test-runner /lava-322993/1
    2023-12-08T08:58:31.791567  =

    2023-12-08T08:58:31.796587  / # /lava-322993/bin/lava-test-runner /lava=
-322993/1
    2023-12-08T08:58:31.900304  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6572de8da3d57f0e28e1348d

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-125-g174d7af0cf0e4/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.=
txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-125-g174d7af0cf0e4/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6572de8da3d57f0e28e134c7
        failing since 1 day (last pass: v5.10.202-131-ged17b556b8e2, first =
fail: v5.10.202-131-g761b9c32d3c8b)

    2023-12-08T09:14:27.181941  / # #
    2023-12-08T09:14:27.284841  export SHELL=3D/bin/sh
    2023-12-08T09:14:27.285647  #
    2023-12-08T09:14:27.387688  / # export SHELL=3D/bin/sh. /lava-323064/en=
vironment
    2023-12-08T09:14:27.388520  =

    2023-12-08T09:14:27.490583  / # . /lava-323064/environment/lava-323064/=
bin/lava-test-runner /lava-323064/1
    2023-12-08T09:14:27.491904  =

    2023-12-08T09:14:27.505686  / # /lava-323064/bin/lava-test-runner /lava=
-323064/1
    2023-12-08T09:14:27.564554  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-08T09:14:27.565094  + cd /lava-323064/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
panda                        | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6572dee44765511497e134ab

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-125-g174d7af0cf0e4/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pan=
da.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-125-g174d7af0cf0e4/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pan=
da.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6572dee44765511497e134b4
        failing since 1 day (last pass: v5.10.148-91-g23f89880f93d, first f=
ail: v5.10.202-131-g761b9c32d3c8b)

    2023-12-08T09:16:06.906443  + <8>[   24.595336] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 3865998_1.5.2.4.1>
    2023-12-08T09:16:06.906775  set +x
    2023-12-08T09:16:07.013584  / # #
    2023-12-08T09:16:07.115537  export SHELL=3D/bin/sh
    2023-12-08T09:16:07.116223  #
    2023-12-08T09:16:07.217361  / # export SHELL=3D/bin/sh. /lava-3865998/e=
nvironment
    2023-12-08T09:16:07.218079  =

    2023-12-08T09:16:07.319276  / # . /lava-3865998/environment/lava-386599=
8/bin/lava-test-runner /lava-3865998/1
    2023-12-08T09:16:07.320180  =

    2023-12-08T09:16:07.325153  / # /lava-3865998/bin/lava-test-runner /lav=
a-3865998/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6572dd70e633867000e134d4

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-125-g174d7af0cf0e4/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-125-g174d7af0cf0e4/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6572dd70e633867000e134dd
        failing since 15 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-08T09:17:38.297883  / # #

    2023-12-08T09:17:38.398446  export SHELL=3D/bin/sh

    2023-12-08T09:17:38.398589  #

    2023-12-08T09:17:38.499096  / # export SHELL=3D/bin/sh. /lava-12215543/=
environment

    2023-12-08T09:17:38.499243  =


    2023-12-08T09:17:38.599730  / # . /lava-12215543/environment/lava-12215=
543/bin/lava-test-runner /lava-12215543/1

    2023-12-08T09:17:38.599949  =


    2023-12-08T09:17:38.611593  / # /lava-12215543/bin/lava-test-runner /la=
va-12215543/1

    2023-12-08T09:17:38.665280  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-08T09:17:38.665363  + cd /lav<8>[   16.430629] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12215543_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6572dbd076922c41abe135db

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-125-g174d7af0cf0e4/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-125-g174d7af0cf0e4/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6572dbd076922c41abe135e5
        failing since 269 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-08T09:03:23.425990  /lava-12215491/1/../bin/lava-test-case

    2023-12-08T09:03:23.436894  <8>[   35.319255] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6572dbd076922c41abe135e6
        failing since 269 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-08T09:03:21.364974  <8>[   33.246407] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-12-08T09:03:22.390002  /lava-12215491/1/../bin/lava-test-case

    2023-12-08T09:03:22.400743  <8>[   34.282660] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6572dd80e6443b1b74e13489

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-125-g174d7af0cf0e4/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-125-g174d7af0cf0e4/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6572dd80e6443b1b74e13492
        failing since 15 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-08T09:10:15.375883  <8>[   17.038115] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447035_1.5.2.4.1>
    2023-12-08T09:10:15.480915  / # #
    2023-12-08T09:10:15.582582  export SHELL=3D/bin/sh
    2023-12-08T09:10:15.583171  #
    2023-12-08T09:10:15.684170  / # export SHELL=3D/bin/sh. /lava-447035/en=
vironment
    2023-12-08T09:10:15.684768  =

    2023-12-08T09:10:15.785787  / # . /lava-447035/environment/lava-447035/=
bin/lava-test-runner /lava-447035/1
    2023-12-08T09:10:15.786695  =

    2023-12-08T09:10:15.791192  / # /lava-447035/bin/lava-test-runner /lava=
-447035/1
    2023-12-08T09:10:15.858204  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6572dd84e6443b1b74e13498

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-125-g174d7af0cf0e4/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-125-g174d7af0cf0e4/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6572dd84e6443b1b74e134a1
        failing since 15 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-08T09:17:54.515795  / # #

    2023-12-08T09:17:54.617903  export SHELL=3D/bin/sh

    2023-12-08T09:17:54.618602  #

    2023-12-08T09:17:54.719830  / # export SHELL=3D/bin/sh. /lava-12215538/=
environment

    2023-12-08T09:17:54.720575  =


    2023-12-08T09:17:54.821930  / # . /lava-12215538/environment/lava-12215=
538/bin/lava-test-runner /lava-12215538/1

    2023-12-08T09:17:54.823015  =


    2023-12-08T09:17:54.839749  / # /lava-12215538/bin/lava-test-runner /la=
va-12215538/1

    2023-12-08T09:17:54.880843  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-08T09:17:54.897907  + cd /lava-1221553<8>[   18.237020] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12215538_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6572debe890203e073e1349e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-125-g174d7af0cf0e4/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-125-g174d7af0cf0e4/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6572debe890203e073e134a7
        failing since 15 days (last pass: v5.10.165-77-g4600242c13ed, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-08T09:15:22.203608  / # #
    2023-12-08T09:15:22.306159  export SHELL=3D/bin/sh
    2023-12-08T09:15:22.307013  #
    2023-12-08T09:15:22.408489  / # export SHELL=3D/bin/sh. /lava-3865992/e=
nvironment
    2023-12-08T09:15:22.409089  =

    2023-12-08T09:15:22.510185  / # . /lava-3865992/environment/lava-386599=
2/bin/lava-test-runner /lava-3865992/1
    2023-12-08T09:15:22.511188  =

    2023-12-08T09:15:22.529753  / # /lava-3865992/bin/lava-test-runner /lav=
a-3865992/1
    2023-12-08T09:15:22.616688  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-08T09:15:22.617211  + cd /lava-3865992/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20

