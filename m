Return-Path: <stable+bounces-5107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E63A80B3B6
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 11:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A54E1C2091C
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 10:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7D3134B5;
	Sat,  9 Dec 2023 10:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="g5joJPYN"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97279BC
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 02:43:34 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-35d4e557c4bso11800875ab.0
        for <stable@vger.kernel.org>; Sat, 09 Dec 2023 02:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702118613; x=1702723413; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EarpWtaIq7Zdor8xA9WxTuUkxoO9QQONDSwNroBuDkM=;
        b=g5joJPYNpwp9VU63aciPU3wfyTJrZADSsfWvshLd4A5cYvat6ElqRAs7rLlTvLC+oZ
         NVWM38jyokh4PIk0ov9Q0EQlMdZ6i4mPgzMP0ySWRjtRClN+zrNZ9WRPAS6de+jFgEof
         6H44zrJE2ksRxhkRa3iTp7bUBuOnC523wNLyt/yZfqxkGrcNJgLkNf0JEp7vWlEqd4Sx
         +Eqac5wxTJYDu5eiPLW8aq7U0b4nGGADBFS6zOPU1rw9bSA9+0TBEiOgBIec4oH+sqLQ
         H/f0rZ/Wlj+R87VCAF5THuVdC2BPW1Ny3GDGxhXo3dvq4xvjYMtbQ5W+qZvj1M9n7J3Y
         rnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702118613; x=1702723413;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EarpWtaIq7Zdor8xA9WxTuUkxoO9QQONDSwNroBuDkM=;
        b=PcYFy1yVvxEhbXXH5g84Y/lLCHIMCd8flfTDhLmNW+VIozUAMr31g8C2T2hEtjcdf4
         OBXQ3UlWJn32Y0mL7aK6AWl89xsSW8ZVPYV7cmDLVngB+cbd3NPoxEJaJTKGV/PAhOvs
         GxkfCzbvsJbl8+K++ddNfhzXox+rKCKuygoZbsvI4/ybUACEzvphZnOktElgMsPCWamG
         BXyGqRcoc0jLXLbOvrebOLc6DInfSNO162TOsUQBFrsi/XlJ+Vu4b/feHAcY7vaQ+WH/
         NBRqoEZkLwBeU+eVSXFDpmr/pZKvXd4G7cOHS8BxjWWLILPNRtGouamlU3wazVwgUL1E
         +5Ag==
X-Gm-Message-State: AOJu0YyQ97wfzOMwl1yIcaWbc/sYvb2JXk5GgDeC/boGGfL+loUdVVRM
	AmfP64XPu4G6rm2VM5zzffTjTuj3vMgbASXD3hzkFg==
X-Google-Smtp-Source: AGHT+IGvgbNuXb0K+JhLI+kBcZYBWupP9uB5vlUZUIpVdaQqBaeA44cNNjyC1dZZw1ol3thjoh+R0Q==
X-Received: by 2002:a05:6e02:1543:b0:35d:59a2:1276 with SMTP id j3-20020a056e02154300b0035d59a21276mr2602107ilu.34.1702118613404;
        Sat, 09 Dec 2023 02:43:33 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jg6-20020a17090326c600b001cc50146b43sm3136478plb.202.2023.12.09.02.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 02:43:32 -0800 (PST)
Message-ID: <657444d4.170a0220.ad8bf.a392@mx.google.com>
Date: Sat, 09 Dec 2023 02:43:32 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.203-46-g46c237c8ed938
Subject: stable-rc/queue/5.10 baseline: 141 runs,
 10 regressions (v5.10.203-46-g46c237c8ed938)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 141 runs, 10 regressions (v5.10.203-46-g46c2=
37c8ed938)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =

panda                        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig         | 1          =

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
nel/v5.10.203-46-g46c237c8ed938/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.203-46-g46c237c8ed938
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      46c237c8ed9381fa8f2170c03d12cf27c0d78be8 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/657414bd5c91b59879e13483

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-46-g46c237c8ed938/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-46-g46c237c8ed938/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657414bd5c91b59879e134bc
        failing since 298 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-12-09T07:18:07.957848  <8>[   20.861522] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 330214_1.5.2.4.1>
    2023-12-09T07:18:08.068258  / # #
    2023-12-09T07:18:08.171592  export SHELL=3D/bin/sh
    2023-12-09T07:18:08.172578  #
    2023-12-09T07:18:08.274653  / # export SHELL=3D/bin/sh. /lava-330214/en=
vironment
    2023-12-09T07:18:08.275518  =

    2023-12-09T07:18:08.377499  / # . /lava-330214/environment/lava-330214/=
bin/lava-test-runner /lava-330214/1
    2023-12-09T07:18:08.378841  =

    2023-12-09T07:18:08.383170  / # /lava-330214/bin/lava-test-runner /lava=
-330214/1
    2023-12-09T07:18:08.487470  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65740ee98ec9d5ca4fe1349f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-46-g46c237c8ed938/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/b=
aseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-46-g46c237c8ed938/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/b=
aseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65740ee98ec9d5ca4fe13=
4a0
        new failure (last pass: v5.10.203-35-g338b25578b878) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/657410757679989c4fe13480

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-46-g46c237c8ed938/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.t=
xt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-46-g46c237c8ed938/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657410757679989c4fe134be
        new failure (last pass: v5.10.203-35-g338b25578b878)

    2023-12-09T06:59:42.109165  / # #
    2023-12-09T06:59:42.210776  export SHELL=3D/bin/sh
    2023-12-09T06:59:42.211192  #
    2023-12-09T06:59:42.312411  / # export SHELL=3D/bin/sh. /lava-330124/en=
vironment
    2023-12-09T06:59:42.312858  =

    2023-12-09T06:59:42.414053  / # . /lava-330124/environment/lava-330124/=
bin/lava-test-runner /lava-330124/1
    2023-12-09T06:59:42.414853  =

    2023-12-09T06:59:42.422258  / # /lava-330124/bin/lava-test-runner /lava=
-330124/1
    2023-12-09T06:59:42.487102  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-09T06:59:42.487470  + cd /lava-330124/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
panda                        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65740fa337b79b6bdee134de

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-46-g46c237c8ed938/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pand=
a.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-46-g46c237c8ed938/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pand=
a.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65740fa337b79b6bdee134e7
        failing since 2 days (last pass: v5.10.148-91-g23f89880f93d, first =
fail: v5.10.202-131-g761b9c32d3c8b)

    2023-12-09T06:56:20.218781  <8>[   24.484863] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3870076_1.5.2.4.1>
    2023-12-09T06:56:20.323599  / # #
    2023-12-09T06:56:20.424995  export SHELL=3D/bin/sh
    2023-12-09T06:56:20.425499  #
    2023-12-09T06:56:20.526351  / # export SHELL=3D/bin/sh. /lava-3870076/e=
nvironment
    2023-12-09T06:56:20.526884  =

    2023-12-09T06:56:20.627729  / # . /lava-3870076/environment/lava-387007=
6/bin/lava-test-runner /lava-3870076/1
    2023-12-09T06:56:20.628487  =

    2023-12-09T06:56:20.633649  / # /lava-3870076/bin/lava-test-runner /lav=
a-3870076/1
    2023-12-09T06:56:20.688102  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/657421144710a3680ae13521

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-46-g46c237c8ed938/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-46-g46c237c8ed938/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657421144710a3680ae1352a
        failing since 16 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-09T08:18:12.491050  / # #

    2023-12-09T08:18:12.593269  export SHELL=3D/bin/sh

    2023-12-09T08:18:12.593996  #

    2023-12-09T08:18:12.695394  / # export SHELL=3D/bin/sh. /lava-12227931/=
environment

    2023-12-09T08:18:12.696117  =


    2023-12-09T08:18:12.797610  / # . /lava-12227931/environment/lava-12227=
931/bin/lava-test-runner /lava-12227931/1

    2023-12-09T08:18:12.798697  =


    2023-12-09T08:18:12.815181  / # /lava-12227931/bin/lava-test-runner /la=
va-12227931/1

    2023-12-09T08:18:12.864552  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-09T08:18:12.865074  + cd /lav<8>[   16.417491] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12227931_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/657410817679989c4fe1351f

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-46-g46c237c8ed938/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-46-g46c237c8ed938/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/657410817679989c4fe13556
        failing since 270 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-09T07:02:42.516191  /lava-12227942/1/../bin/lava-test-case

    2023-12-09T07:02:42.527808  <8>[   35.253645] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/657410817679989c4fe13557
        failing since 270 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-09T07:02:41.479227  /lava-12227942/1/../bin/lava-test-case

    2023-12-09T07:02:41.490425  <8>[   34.215950] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-clabbe    | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65740f9f70b53ffaa3e13480

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-46-g46c237c8ed938/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-46-g46c237c8ed938/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65740f9f70b53ffaa3e13489
        failing since 16 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-09T06:56:21.708404  <8>[   17.005019] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447250_1.5.2.4.1>
    2023-12-09T06:56:21.812757  / # #
    2023-12-09T06:56:21.914302  export SHELL=3D/bin/sh
    2023-12-09T06:56:21.914897  #
    2023-12-09T06:56:22.015823  / # export SHELL=3D/bin/sh. /lava-447250/en=
vironment
    2023-12-09T06:56:22.016365  =

    2023-12-09T06:56:22.117310  / # . /lava-447250/environment/lava-447250/=
bin/lava-test-runner /lava-447250/1
    2023-12-09T06:56:22.118121  =

    2023-12-09T06:56:22.123735  / # /lava-447250/bin/lava-test-runner /lava=
-447250/1
    2023-12-09T06:56:22.188866  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65740fbd70b53ffaa3e134c2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-46-g46c237c8ed938/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-46-g46c237c8ed938/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65740fbd70b53ffaa3e134cb
        failing since 16 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-09T07:04:19.279930  / # #

    2023-12-09T07:04:19.382058  export SHELL=3D/bin/sh

    2023-12-09T07:04:19.382751  #

    2023-12-09T07:04:19.484197  / # export SHELL=3D/bin/sh. /lava-12227928/=
environment

    2023-12-09T07:04:19.484943  =


    2023-12-09T07:04:19.586396  / # . /lava-12227928/environment/lava-12227=
928/bin/lava-test-runner /lava-12227928/1

    2023-12-09T07:04:19.587477  =


    2023-12-09T07:04:19.604452  / # /lava-12227928/bin/lava-test-runner /la=
va-12227928/1

    2023-12-09T07:04:19.644903  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-09T07:04:19.663086  + cd /lava-1222792<8>[   18.150163] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12227928_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65740f7eefca82b7bae1348c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-46-g46c237c8ed938/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-46-g46c237c8ed938/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65740f7eefca82b7bae13495
        failing since 16 days (last pass: v5.10.165-77-g4600242c13ed, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-09T06:55:34.283041  / # #
    2023-12-09T06:55:34.385271  export SHELL=3D/bin/sh
    2023-12-09T06:55:34.385988  #
    2023-12-09T06:55:34.487296  / # export SHELL=3D/bin/sh. /lava-3870077/e=
nvironment
    2023-12-09T06:55:34.488096  =

    2023-12-09T06:55:34.589383  / # . /lava-3870077/environment/lava-387007=
7/bin/lava-test-runner /lava-3870077/1
    2023-12-09T06:55:34.590099  =

    2023-12-09T06:55:34.607503  / # /lava-3870077/bin/lava-test-runner /lav=
a-3870077/1
    2023-12-09T06:55:34.696397  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-09T06:55:34.696703  + cd /lava-3870077/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20

