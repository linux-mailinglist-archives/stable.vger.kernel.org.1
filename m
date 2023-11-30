Return-Path: <stable+bounces-3203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7493E7FE82A
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 05:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64A50B20B38
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 04:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479A8156E5;
	Thu, 30 Nov 2023 04:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="gbint8N6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9F510FF
	for <stable@vger.kernel.org>; Wed, 29 Nov 2023 20:07:21 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2858ae35246so502451a91.0
        for <stable@vger.kernel.org>; Wed, 29 Nov 2023 20:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701317240; x=1701922040; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H8/mPzgNgyPneA4lo2/5hcxiPdlRDeI9VRvkLr21wlU=;
        b=gbint8N6TO50aaeyOjmu/F6GfVm9/9ocI86xfTn9/my33/xujiNuaucl8J0NfK4PJX
         06QjKE/3CP/o1vre/OTMaPS0UGKJ+osUcy/QgptK9UXu4vKJZ0w49NmVFfwHK+uJQnRv
         FjDvAGzDhuljYpzreLBJi8V8+cYqQ6/aO12DrmobakwbbHDnpWF4rLX8KvdjZEb4VCc2
         R2+K1ezfZdkWiItF+ODrfBaMC86z9TPBcRFrGPV5oZsSNgxAVPwJkeAT/AKJjmf5bRlj
         8mJLojzYSv5FtwS8wXmeBrislfOYkl/3dFHIo53Q55vUCWbVAM+nWzKiPBnjayOCEOmV
         Th0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701317240; x=1701922040;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H8/mPzgNgyPneA4lo2/5hcxiPdlRDeI9VRvkLr21wlU=;
        b=fTSaefo4hpNQoA2C+EhrF4ig7gYooDhQQvyO9J2PuewA5u8Zx5wjwhnibwdDhWBlHq
         g8qYMdKLZJWhrntc4LqWGn41Oy7w8XrFJl1KcMm79G70Gz16VaG98ZZudfYXEgrlxYOU
         7/7+dAefWnFXzS4iwiuzcaeI2kyNnJzrWbTXpJn1esbT6IamwI61SrfWqTm+MSGceBcd
         mnELJdI+oVTFH3gPbvskB5Iwma5hLj4+OfsOJ6DEOVi+K9WBDnoSIgxlm2NzzoWZV5z+
         QtmDJF3CTwcMWwg4EXqHqL+4gHH+reZXq7PoPMCm3mpNI1vP3fiXIAazmpJooRDqYPct
         SJBQ==
X-Gm-Message-State: AOJu0YwpmPmNozBVuobH4bKtJ2LBTL7+Q/W9e4Zsuoda/Ao0y5rOj8us
	D+EXraZpa0ar2yquZY9muOp26do8A9LbG7ohngP8hQ==
X-Google-Smtp-Source: AGHT+IE+kPaPxc7HHcnOJcfHREdx6e6p63P/5DsfVAGLNKddF2TQ61iyXbktnJm/UsUZUwfK4d5U2Q==
X-Received: by 2002:a17:90b:388e:b0:285:c4f1:4646 with SMTP id mu14-20020a17090b388e00b00285c4f14646mr12797572pjb.46.1701317240325;
        Wed, 29 Nov 2023 20:07:20 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id gz9-20020a17090b0ec900b002839679c23dsm258975pjb.13.2023.11.29.20.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 20:07:19 -0800 (PST)
Message-ID: <65680a77.170a0220.a1d4b.0ff7@mx.google.com>
Date: Wed, 29 Nov 2023 20:07:19 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.202-53-ga1e0fa8fccd1b
Subject: stable-rc/queue/5.10 baseline: 140 runs,
 8 regressions (v5.10.202-53-ga1e0fa8fccd1b)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 140 runs, 8 regressions (v5.10.202-53-ga1e0f=
a8fccd1b)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 1          =

qemu_x86_64                  | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                  | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook | 2          =

sun50i-h6-pine-h64           | arm64  | lab-clabbe    | gcc-10   | defconfi=
g                  | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                  | 1          =

sun8i-h2-plus...ch-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig         | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.202-53-ga1e0fa8fccd1b/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.202-53-ga1e0fa8fccd1b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      a1e0fa8fccd1b3bc456aad06901708c2127860d9 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/6567d6f332c84ed2877e4a72

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-53-ga1e0fa8fccd1b/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-53-ga1e0fa8fccd1b/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6567d6f332c84ed2877e4aab
        failing since 289 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-11-30T00:27:07.931034  <8>[   15.930242] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 289170_1.5.2.4.1>
    2023-11-30T00:27:08.038077  / # #
    2023-11-30T00:27:08.139821  export SHELL=3D/bin/sh
    2023-11-30T00:27:08.140255  #
    2023-11-30T00:27:08.242107  / # export SHELL=3D/bin/sh. /lava-289170/en=
vironment
    2023-11-30T00:27:08.242756  =

    2023-11-30T00:27:08.344697  / # . /lava-289170/environment/lava-289170/=
bin/lava-test-runner /lava-289170/1
    2023-11-30T00:27:08.345575  =

    2023-11-30T00:27:08.350522  / # /lava-289170/bin/lava-test-runner /lava=
-289170/1
    2023-11-30T00:27:08.460290  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
qemu_x86_64                  | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/6567d6c5940bd375a07e4adf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-53-ga1e0fa8fccd1b/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-baylibre/ba=
seline-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-53-ga1e0fa8fccd1b/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-baylibre/ba=
seline-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6567d6c5940bd375a07e4=
ae0
        new failure (last pass: v5.10.202-53-gc4c658517011c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6567d7940e4dd383ba7e4a81

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-53-ga1e0fa8fccd1b/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-53-ga1e0fa8fccd1b/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6567d7940e4dd383ba7e4a8a
        failing since 7 days (last pass: v5.10.181-18-g1622068b57a4, first =
fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-30T00:36:22.860194  / # #

    2023-11-30T00:36:22.960696  export SHELL=3D/bin/sh

    2023-11-30T00:36:22.960823  #

    2023-11-30T00:36:23.061275  / # export SHELL=3D/bin/sh. /lava-12127683/=
environment

    2023-11-30T00:36:23.061391  =


    2023-11-30T00:36:23.161909  / # . /lava-12127683/environment/lava-12127=
683/bin/lava-test-runner /lava-12127683/1

    2023-11-30T00:36:23.162107  =


    2023-11-30T00:36:23.174557  / # /lava-12127683/bin/lava-test-runner /la=
va-12127683/1

    2023-11-30T00:36:23.227464  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-30T00:36:23.227544  + cd /lav<8>[   16.411753] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12127683_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6567d85c4e745721217e4ab3

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-53-ga1e0fa8fccd1b/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-53-ga1e0fa8fccd1b/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6567d85c4e745721217e4abd
        failing since 260 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-11-30T00:33:09.325843  <8>[   61.179930] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-11-30T00:33:10.351089  /lava-12127712/1/../bin/lava-test-case

    2023-11-30T00:33:10.362284  <8>[   62.216856] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6567d85c4e745721217e4abe
        failing since 260 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-11-30T00:33:09.314397  /lava-12127712/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-clabbe    | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6567d77c548e182d807e4a76

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-53-ga1e0fa8fccd1b/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-53-ga1e0fa8fccd1b/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6567d77c548e182d807e4a7f
        failing since 7 days (last pass: v5.10.176-241-ga0049fd9c865, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-30T00:29:38.383483  <8>[   16.926629] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 445863_1.5.2.4.1>
    2023-11-30T00:29:38.488555  / # #
    2023-11-30T00:29:38.590202  export SHELL=3D/bin/sh
    2023-11-30T00:29:38.590834  #
    2023-11-30T00:29:38.691838  / # export SHELL=3D/bin/sh. /lava-445863/en=
vironment
    2023-11-30T00:29:38.692433  =

    2023-11-30T00:29:38.793495  / # . /lava-445863/environment/lava-445863/=
bin/lava-test-runner /lava-445863/1
    2023-11-30T00:29:38.794409  =

    2023-11-30T00:29:38.798814  / # /lava-445863/bin/lava-test-runner /lava=
-445863/1
    2023-11-30T00:29:38.865861  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6567d7954a44f812167e4a6d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-53-ga1e0fa8fccd1b/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-53-ga1e0fa8fccd1b/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6567d7954a44f812167e4a76
        failing since 7 days (last pass: v5.10.176-241-ga0049fd9c865, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-30T00:36:37.360881  / # #

    2023-11-30T00:36:37.463224  export SHELL=3D/bin/sh

    2023-11-30T00:36:37.463991  #

    2023-11-30T00:36:37.565399  / # export SHELL=3D/bin/sh. /lava-12127684/=
environment

    2023-11-30T00:36:37.566157  =


    2023-11-30T00:36:37.667602  / # . /lava-12127684/environment/lava-12127=
684/bin/lava-test-runner /lava-12127684/1

    2023-11-30T00:36:37.668833  =


    2023-11-30T00:36:37.684045  / # /lava-12127684/bin/lava-test-runner /la=
va-12127684/1

    2023-11-30T00:36:37.741871  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-30T00:36:37.742384  + cd /lava-1212768<8>[   18.201317] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12127684_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6567d9827e5ed3e3c57e4a8c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-53-ga1e0fa8fccd1b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-53-ga1e0fa8fccd1b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6567d9827e5ed3e3c57e4a95
        failing since 7 days (last pass: v5.10.165-77-g4600242c13ed, first =
fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-30T00:38:00.071862  / # #
    2023-11-30T00:38:00.173135  export SHELL=3D/bin/sh
    2023-11-30T00:38:00.173601  #
    2023-11-30T00:38:00.274417  / # export SHELL=3D/bin/sh. /lava-3854054/e=
nvironment
    2023-11-30T00:38:00.274842  =

    2023-11-30T00:38:00.375666  / # . /lava-3854054/environment/lava-385405=
4/bin/lava-test-runner /lava-3854054/1
    2023-11-30T00:38:00.376367  =

    2023-11-30T00:38:00.383949  / # /lava-3854054/bin/lava-test-runner /lav=
a-3854054/1
    2023-11-30T00:38:00.432016  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-30T00:38:00.471769  + cd /lava-3854054/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20

