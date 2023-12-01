Return-Path: <stable+bounces-3649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E7C800CA4
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 14:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B63B81C20E19
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 13:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2553B79E;
	Fri,  1 Dec 2023 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="u4ytjNlj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B247A6
	for <stable@vger.kernel.org>; Fri,  1 Dec 2023 05:55:31 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5c629a9fe79so384405a12.3
        for <stable@vger.kernel.org>; Fri, 01 Dec 2023 05:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701438930; x=1702043730; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FP8BZWaqX9L8IpaRmEgjtC85VUeWRsRBqohM7vSoV8s=;
        b=u4ytjNljboAgxvnYBBoRe+CtWGbXY8uQowHkxBDQNSBVVs4gPMAEhx3B1W62mKBeNL
         c1xqZZEbmuwnh4lvXFQrjCLgHmAjoDrMHmvBApf89z9Mnkddk6RLYCAGrssjAc/idclf
         d+TOCvneXXGAUh6JHoFlAL2+RO2BFSo/SGMZR7uk8PT5f+oqWLVVLE61Y836ShT2bNav
         JeM1sof4dhWDOQ7n0xm1BcmrPEDoIG00sKPJMJ0ndx3RsS3zvlWJIHO8xWgI0gtczQ/E
         I/5+09X3YYj44oEcADvDHJaIGMLyq28N7aLRikSLEdisrAIHUIiuF9Gkb0/KLkimPJCR
         f+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701438930; x=1702043730;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FP8BZWaqX9L8IpaRmEgjtC85VUeWRsRBqohM7vSoV8s=;
        b=dsFakQcaA/QTxvevhSq5ThzRxWvBiiLAeq/KJ1r+HjUOJWLaAPsKqJ25dFXC4Iqeci
         iG5wmWClQHHfcg16kuAsmwMWwnttPZ6oOXKQWdkHkD1DvRtTxi1bUpeoTsP6rMxdvI4c
         MQt/fh8Jm1spRsLYDR8x838ywU58zM/OWhuMhr/Ww8Ttw4CL9i2+WwWgzxXM9O7CGB+6
         1jHNqa8HAl4yQj+GE+1j2aMuQPlzOZ1LmORfibp4o2oxxHlnc331/ee8+xh1qeCY3Hss
         plELoCPeGTtN+Yam+czOUiR/jdu2H05jdbj0p04wdJvDYCZVPDT80oEqUYCbBTkxdpmg
         7Z2w==
X-Gm-Message-State: AOJu0YwJdLXaOsl6Wi2uIWcTTQrZ9xAXv2sJLN8tc8I0RFWM9AXuHxHu
	2wI6xYu0G7qyO+IuuPQ39Coh4aawnd8KdkYiD4RyjQ==
X-Google-Smtp-Source: AGHT+IH3OCUUASM/lYFuCPcgsLES27NjgJjAGdpXXxMhfzc+Vu2FKEPDTEkNBCJUilmLAwX431Y1pw==
X-Received: by 2002:a17:90b:1c86:b0:280:cd7b:1fa5 with SMTP id oo6-20020a17090b1c8600b00280cd7b1fa5mr24045151pjb.4.1701438930540;
        Fri, 01 Dec 2023 05:55:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 24-20020a17090a195800b00286573fc6e5sm1574879pjh.4.2023.12.01.05.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 05:55:30 -0800 (PST)
Message-ID: <6569e5d2.170a0220.36a52.4fa0@mx.google.com>
Date: Fri, 01 Dec 2023 05:55:30 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.202-69-g560a93e9d1ce3
Subject: stable-rc/queue/5.10 baseline: 139 runs,
 7 regressions (v5.10.202-69-g560a93e9d1ce3)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 139 runs, 7 regressions (v5.10.202-69-g560a9=
3e9d1ce3)

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

sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
                  | 1          =

sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =

sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.202-69-g560a93e9d1ce3/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.202-69-g560a93e9d1ce3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      560a93e9d1ce3a757a9369dbbdb7285b63d45403 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/6569b3009ba1f6388de13484

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-69-g560a93e9d1ce3/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-69-g560a93e9d1ce3/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6569b3009ba1f6388de134b9
        failing since 290 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-12-01T10:18:23.140060  <8>[   19.739222] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 295247_1.5.2.4.1>
    2023-12-01T10:18:23.248616  / # #
    2023-12-01T10:18:23.350310  export SHELL=3D/bin/sh
    2023-12-01T10:18:23.350688  #
    2023-12-01T10:18:23.451883  / # export SHELL=3D/bin/sh. /lava-295247/en=
vironment
    2023-12-01T10:18:23.452281  =

    2023-12-01T10:18:23.553601  / # . /lava-295247/environment/lava-295247/=
bin/lava-test-runner /lava-295247/1
    2023-12-01T10:18:23.554581  =

    2023-12-01T10:18:23.559389  / # /lava-295247/bin/lava-test-runner /lava=
-295247/1
    2023-12-01T10:18:23.667145  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6569b22e889922e33ce134b0

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-69-g560a93e9d1ce3/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-69-g560a93e9d1ce3/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6569b22e889922e33ce134b5
        failing since 8 days (last pass: v5.10.181-18-g1622068b57a4, first =
fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-01T10:21:32.613673  / # #

    2023-12-01T10:21:32.714299  export SHELL=3D/bin/sh

    2023-12-01T10:21:32.714510  #

    2023-12-01T10:21:32.815036  / # export SHELL=3D/bin/sh. /lava-12149137/=
environment

    2023-12-01T10:21:32.815201  =


    2023-12-01T10:21:32.915913  / # . /lava-12149137/environment/lava-12149=
137/bin/lava-test-runner /lava-12149137/1

    2023-12-01T10:21:32.916167  =


    2023-12-01T10:21:32.927150  / # /lava-12149137/bin/lava-test-runner /la=
va-12149137/1

    2023-12-01T10:21:32.969271  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-01T10:21:32.986346  + cd /lav<8>[   16.385831] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12149137_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6569b4cf4ff5c6c505e1348f

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-69-g560a93e9d1ce3/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-69-g560a93e9d1ce3/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6569b4cf4ff5c6c505e13495
        failing since 262 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-01T10:26:16.257939  /lava-12149296/1/../bin/lava-test-case

    2023-12-01T10:26:16.269268  <8>[   62.132852] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6569b4cf4ff5c6c505e13496
        failing since 262 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-01T10:26:14.201905  <8>[   60.063322] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-12-01T10:26:15.222831  /lava-12149296/1/../bin/lava-test-case

    2023-12-01T10:26:15.234112  <8>[   61.097453] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6569b22ffc44b87552e13479

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-69-g560a93e9d1ce3/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-69-g560a93e9d1ce3/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6569b22ffc44b87552e1347e
        failing since 8 days (last pass: v5.10.176-241-ga0049fd9c865, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-01T10:15:01.396909  <8>[   16.958223] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 446063_1.5.2.4.1>
    2023-12-01T10:15:01.501962  / # #
    2023-12-01T10:15:01.603580  export SHELL=3D/bin/sh
    2023-12-01T10:15:01.604159  #
    2023-12-01T10:15:01.705143  / # export SHELL=3D/bin/sh. /lava-446063/en=
vironment
    2023-12-01T10:15:01.705827  =

    2023-12-01T10:15:01.806829  / # . /lava-446063/environment/lava-446063/=
bin/lava-test-runner /lava-446063/1
    2023-12-01T10:15:01.807696  =

    2023-12-01T10:15:01.812171  / # /lava-446063/bin/lava-test-runner /lava=
-446063/1
    2023-12-01T10:15:01.878222  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6569b240fc44b87552e13491

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-69-g560a93e9d1ce3/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-69-g560a93e9d1ce3/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6569b240fc44b87552e13496
        failing since 8 days (last pass: v5.10.176-241-ga0049fd9c865, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-01T10:21:48.624238  / # #

    2023-12-01T10:21:48.726313  export SHELL=3D/bin/sh

    2023-12-01T10:21:48.727007  #

    2023-12-01T10:21:48.828306  / # export SHELL=3D/bin/sh. /lava-12149132/=
environment

    2023-12-01T10:21:48.829008  =


    2023-12-01T10:21:48.930467  / # . /lava-12149132/environment/lava-12149=
132/bin/lava-test-runner /lava-12149132/1

    2023-12-01T10:21:48.931551  =


    2023-12-01T10:21:48.948890  / # /lava-12149132/bin/lava-test-runner /la=
va-12149132/1

    2023-12-01T10:21:48.989737  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-01T10:21:49.007885  + cd /lava-1214913<8>[   18.295167] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12149132_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6569b4fe8deaaa5427e1348b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-69-g560a93e9d1ce3/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-69-g560a93e9d1ce3/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6569b4fe8deaaa5427e13490
        failing since 8 days (last pass: v5.10.165-77-g4600242c13ed, first =
fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-01T10:26:39.846396  + set +x
    2023-12-01T10:26:39.847939  <8>[    8.531850] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3856122_1.5.2.4.1>
    2023-12-01T10:26:39.954109  / # #
    2023-12-01T10:26:40.055882  export SHELL=3D/bin/sh
    2023-12-01T10:26:40.056380  #
    2023-12-01T10:26:40.157247  / # export SHELL=3D/bin/sh. /lava-3856122/e=
nvironment
    2023-12-01T10:26:40.157934  =

    2023-12-01T10:26:40.259019  / # . /lava-3856122/environment/lava-385612=
2/bin/lava-test-runner /lava-3856122/1
    2023-12-01T10:26:40.260001  =

    2023-12-01T10:26:40.278691  / # /lava-3856122/bin/lava-test-runner /lav=
a-3856122/1 =

    ... (12 line(s) more)  =

 =20

