Return-Path: <stable+bounces-3805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4133802642
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 19:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDABC1C20973
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 18:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA5117753;
	Sun,  3 Dec 2023 18:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="t4Gx8fzC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D541DA
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 10:33:13 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5c61d135d74so1172690a12.1
        for <stable@vger.kernel.org>; Sun, 03 Dec 2023 10:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701628392; x=1702233192; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iHlj1W/Bo/kIY5eqbfG83UMh5L7C88/2ClcKi/mNwaQ=;
        b=t4Gx8fzCurqYWARkeudTXlmfQFv4xq+S3tYyCZWRKXdYrP7Mg8NxTYwUFn8isIIfqY
         I7R6047qrKNjinSnkz+YxwBGE2uiwdMtax03YzEi9+8kiKp/dAR8JYGf6PvOReRM0oUY
         Nz1fKGPAsBHVPdWQzIORWIGvDWQxD39vYnE8R0QS1MOs23+hvyMeRcbR/tOWoJ4QP1oR
         E+avUzj3vqlorw+yF2oZ3XgO4TyQ9aTArpqvZEaaukB+QgmEuKngZck2NYM+49lScfj0
         qapKcpRAG/aAebrEsFmL+G1wwEqACjCYWcivMk3O/drNn5ES4G6P8yjmtmXvtFCmoYib
         BPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701628392; x=1702233192;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iHlj1W/Bo/kIY5eqbfG83UMh5L7C88/2ClcKi/mNwaQ=;
        b=UBcV2P+xD4pGhc3gB3Qvq+dzsIr7xHeMNbnZQOm3qbAmtI/eOCJoH1cxJIB32kuvXS
         KMZCzL2u8yW/kEE3qnjn5kPubS2BUEDmO683a6VOYTOtVLizuFXhw2e09CpgquQISDru
         BGpIKrXs1nsZR9fMCCzlC3AhvX9YHePnwzbs8vIqBCsc/eTSNLcauxK7vNeKzRFA0v7z
         0odP2IuxiarrX7WfdCa3hFXjbkhdyOBiIggdFsUx7UbXpfzrMKGXbzB3npTFcRXgjfBE
         saE8aDjrXQdMbWqNwqBb4JG9IuCcf1wv/CtjswzIxuiqFeDVhAHX2cNaOC+O0Ju7YrYG
         NjFg==
X-Gm-Message-State: AOJu0Yx+WQCJuliOeM5DQwxmLqoEj+lmT5J4TMNYzf51ohwmU/u+F8Ng
	y8MhuizAi75l/52EIG9jf2DF88KndwtqmSCEdtEzHw==
X-Google-Smtp-Source: AGHT+IHjylbdcHToehRkxJdBeF0p66mOJzVuiLgAYExg5CksZ/KnXxP3igR7FZVMv5lyVUlQP8eTbw==
X-Received: by 2002:a05:6a20:914e:b0:18b:9287:eab9 with SMTP id x14-20020a056a20914e00b0018b9287eab9mr1448414pzc.52.1701628392220;
        Sun, 03 Dec 2023 10:33:12 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902ab8d00b001cc20dd8825sm3387195plr.213.2023.12.03.10.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 10:33:11 -0800 (PST)
Message-ID: <656cc9e7.170a0220.8ec6b.7358@mx.google.com>
Date: Sun, 03 Dec 2023 10:33:11 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.202-88-ge2eb03dd135e3
Subject: stable-rc/queue/5.10 baseline: 135 runs,
 8 regressions (v5.10.202-88-ge2eb03dd135e3)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 135 runs, 8 regressions (v5.10.202-88-ge2eb0=
3dd135e3)

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
nel/v5.10.202-88-ge2eb03dd135e3/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.202-88-ge2eb03dd135e3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      e2eb03dd135e35941040aafcf438661c34613499 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/656c971c2abb27a09de134a2

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-88-ge2eb03dd135e3/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-88-ge2eb03dd135e3/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656c971c2abb27a09de134d8
        failing since 292 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-12-03T14:55:15.232249  <8>[   19.080152] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 301661_1.5.2.4.1>
    2023-12-03T14:55:15.341657  / # #
    2023-12-03T14:55:15.443323  export SHELL=3D/bin/sh
    2023-12-03T14:55:15.443920  #
    2023-12-03T14:55:15.545153  / # export SHELL=3D/bin/sh. /lava-301661/en=
vironment
    2023-12-03T14:55:15.545671  =

    2023-12-03T14:55:15.647058  / # . /lava-301661/environment/lava-301661/=
bin/lava-test-runner /lava-301661/1
    2023-12-03T14:55:15.647753  =

    2023-12-03T14:55:15.652516  / # /lava-301661/bin/lava-test-runner /lava=
-301661/1
    2023-12-03T14:55:15.759476  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656c9a0790e9f2db65e13491

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-88-ge2eb03dd135e3/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.t=
xt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-88-ge2eb03dd135e3/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656c9a0790e9f2db65e134cc
        failing since 0 day (last pass: v5.10.202-69-g560a93e9d1ce3, first =
fail: v5.10.202-78-ga6f1d8d78e2ed)

    2023-12-03T15:08:22.157332  / # #
    2023-12-03T15:08:22.260432  export SHELL=3D/bin/sh
    2023-12-03T15:08:22.261214  #
    2023-12-03T15:08:22.363239  / # export SHELL=3D/bin/sh. /lava-301765/en=
vironment
    2023-12-03T15:08:22.364051  =

    2023-12-03T15:08:22.466100  / # . /lava-301765/environment/lava-301765/=
bin/lava-test-runner /lava-301765/1
    2023-12-03T15:08:22.467612  =

    2023-12-03T15:08:22.480246  / # /lava-301765/bin/lava-test-runner /lava=
-301765/1
    2023-12-03T15:08:22.539967  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-03T15:08:22.540484  + cd /lava-301765/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656c9810ef349aad6fe13475

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-88-ge2eb03dd135e3/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-88-ge2eb03dd135e3/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656c9810ef349aad6fe1347a
        failing since 11 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-03T15:06:36.298014  / # #

    2023-12-03T15:06:36.398592  export SHELL=3D/bin/sh

    2023-12-03T15:06:36.398732  #

    2023-12-03T15:06:36.499498  / # export SHELL=3D/bin/sh. /lava-12169107/=
environment

    2023-12-03T15:06:36.500093  =


    2023-12-03T15:06:36.601302  / # . /lava-12169107/environment/lava-12169=
107/bin/lava-test-runner /lava-12169107/1

    2023-12-03T15:06:36.602354  =


    2023-12-03T15:06:36.612689  / # /lava-12169107/bin/lava-test-runner /la=
va-12169107/1

    2023-12-03T15:06:36.653686  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-03T15:06:36.671760  + cd /lav<8>[   16.420988] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12169107_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/656c997e12702334c4e13478

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-88-ge2eb03dd135e3/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-88-ge2eb03dd135e3/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/656c997e12702334c4e1347e
        failing since 264 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-03T15:06:42.224023  <8>[   34.136601] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-12-03T15:06:43.246812  /lava-12169143/1/../bin/lava-test-case

    2023-12-03T15:06:43.258380  <8>[   35.171512] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/656c997e12702334c4e1347f
        failing since 264 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-03T15:06:42.212686  /lava-12169143/1/../bin/lava-test-case
   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656c98033681c28f98e13481

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-88-ge2eb03dd135e3/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-88-ge2eb03dd135e3/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656c98033681c28f98e13486
        failing since 11 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-03T15:00:08.531375  <8>[   17.012730] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 446382_1.5.2.4.1>
    2023-12-03T15:00:08.636416  / # #
    2023-12-03T15:00:08.737892  export SHELL=3D/bin/sh
    2023-12-03T15:00:08.738552  #
    2023-12-03T15:00:08.839455  / # export SHELL=3D/bin/sh. /lava-446382/en=
vironment
    2023-12-03T15:00:08.840084  =

    2023-12-03T15:00:08.940969  / # . /lava-446382/environment/lava-446382/=
bin/lava-test-runner /lava-446382/1
    2023-12-03T15:00:08.941990  =

    2023-12-03T15:00:08.947438  / # /lava-446382/bin/lava-test-runner /lava=
-446382/1
    2023-12-03T15:00:09.013296  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656c980f463fd4d40ce13475

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-88-ge2eb03dd135e3/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-88-ge2eb03dd135e3/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656c980f463fd4d40ce1347a
        failing since 11 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-03T15:06:51.639758  / # #

    2023-12-03T15:06:51.741860  export SHELL=3D/bin/sh

    2023-12-03T15:06:51.742516  #

    2023-12-03T15:06:51.843815  / # export SHELL=3D/bin/sh. /lava-12169102/=
environment

    2023-12-03T15:06:51.844531  =


    2023-12-03T15:06:51.945939  / # . /lava-12169102/environment/lava-12169=
102/bin/lava-test-runner /lava-12169102/1

    2023-12-03T15:06:51.946256  =


    2023-12-03T15:06:51.947502  / # /lava-12169102/bin/lava-test-runner /la=
va-12169102/1

    2023-12-03T15:06:51.989498  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-03T15:06:52.022010  + cd /lava-1216910<8>[   18.208470] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12169102_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/656c98006aed332c41e13483

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-88-ge2eb03dd135e3/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-88-ge2eb03dd135e3/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656c98006aed332c41e13488
        failing since 11 days (last pass: v5.10.165-77-g4600242c13ed, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-03T14:59:48.552428  <8>[    8.585879] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3858796_1.5.2.4.1>
    2023-12-03T14:59:48.656572  / # #
    2023-12-03T14:59:48.757642  export SHELL=3D/bin/sh
    2023-12-03T14:59:48.757970  #
    2023-12-03T14:59:48.858703  / # export SHELL=3D/bin/sh. /lava-3858796/e=
nvironment
    2023-12-03T14:59:48.859030  =

    2023-12-03T14:59:48.959783  / # . /lava-3858796/environment/lava-385879=
6/bin/lava-test-runner /lava-3858796/1
    2023-12-03T14:59:48.960351  =

    2023-12-03T14:59:48.968199  / # /lava-3858796/bin/lava-test-runner /lav=
a-3858796/1
    2023-12-03T14:59:49.063182  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20

