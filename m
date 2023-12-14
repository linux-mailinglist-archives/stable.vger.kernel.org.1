Return-Path: <stable+bounces-6694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 291D78124A2
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 02:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82E36B210AC
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 01:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4406656;
	Thu, 14 Dec 2023 01:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="M56L4pmE"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E9DD5
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 17:34:42 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7b771176f80so121135339f.2
        for <stable@vger.kernel.org>; Wed, 13 Dec 2023 17:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702517681; x=1703122481; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LUJgoJiWPGjflXOiRQSKQPNXd6TK4LeLxIYFddIMzUQ=;
        b=M56L4pmEZn2JkHrjBf7mzR947v1C68GiA7tCo/4iNb0Q7tskjNCu4uuB7SFuP0u7pv
         +YU4vJwY7at8ochsFfKzjY0Atc4eQx7xmQESFuZvPqfAmLPopiiFRGrDGlGgokLMymxY
         26IlldlJ/cCeAHU676DYlmvxgswPXtHfBCvQ09NOoUD1SmCy12IN1vsKzzDPneIo7Izw
         fUENjbq9DQlTV6KobnjhsewMAGzohOWGcHxxRNvwgN/kknk3pb0nBAVF13IGUsKGMh44
         zRZXfp69rXfGMTGqRyqtrokD8YbQPZlDk+IdyUuMGc5deD2fAvH7wkROLvmc8iNBABTN
         1uDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702517681; x=1703122481;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUJgoJiWPGjflXOiRQSKQPNXd6TK4LeLxIYFddIMzUQ=;
        b=RKzCVzABoT8t9wHUW7fRPSrwz5JZ5mHyXwrjB4cZDcuqJSOIcF7HgjZHpoTOkJoSck
         TxI2I3KOYDLZw0ONcJxdfrS5dv+XDpUcxmu+gW7jWEiLhpioqGf4svnPRXXIZ2Job4Cv
         dlosJmU2mpvQm397SL5N+HGlDdm3d+wes14cMuwF029gnwBq9cwnjkgum04LXKmpeyt+
         5rKlZTAEpqHa/AGEbjU7GSZBlz6J4Nilw+NkQWTA9qOOJwE/yYO2IbP4qH3ZiLw0NEUe
         JPasYJVdT/SVWSR4Q6z/11qqRoNzcnn7GeuTdkR5WJXfunFyBsyPeRN4A5nM8ZVFyvM0
         lfiw==
X-Gm-Message-State: AOJu0Ywqc5KUT/x/P/pf7iF5kt7timegRBb8LXR8jPmAt1kBC9LnUzGE
	WiS/wZe2iEArSrab6kzQPao5Silq/e32BsQjyQ8ChA==
X-Google-Smtp-Source: AGHT+IHy6OHj5wccY5yZPr6qsCnHsfJRcSqqREBHdyEQaljsuS1E9UrNcYyIbNouv3km+1DnvlbPzg==
X-Received: by 2002:a05:6e02:1be5:b0:35f:6a24:66a4 with SMTP id y5-20020a056e021be500b0035f6a2466a4mr3787571ilv.4.1702517681491;
        Wed, 13 Dec 2023 17:34:41 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k189-20020a6324c6000000b005bcea1bf43bsm10281104pgk.12.2023.12.13.17.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 17:34:41 -0800 (PST)
Message-ID: <657a5bb1.630a0220.4da19.07e0@mx.google.com>
Date: Wed, 13 Dec 2023 17:34:41 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.203-97-g284f46c131b10
Subject: stable-rc/queue/5.10 baseline: 98 runs,
 6 regressions (v5.10.203-97-g284f46c131b10)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 98 runs, 6 regressions (v5.10.203-97-g284f46=
c131b10)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
beaglebone-black   | arm   | lab-broonie   | gcc-10   | omap2plus_defconfig=
        | 1          =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
        | 1          =

rk3399-gru-kevin   | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chr=
omebook | 2          =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
        | 1          =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
        | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.203-97-g284f46c131b10/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.203-97-g284f46c131b10
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      284f46c131b1068cb8de6e74991ba286dc62a74b =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
beaglebone-black   | arm   | lab-broonie   | gcc-10   | omap2plus_defconfig=
        | 1          =


  Details:     https://kernelci.org/test/plan/id/657a253974377e3c73e13479

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-97-g284f46c131b10/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-97-g284f46c131b10/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657a253a74377e3c73e134b2
        failing since 303 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-12-13T21:41:57.608158  <8>[   16.631010] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 350233_1.5.2.4.1>
    2023-12-13T21:41:57.716641  / # #
    2023-12-13T21:41:57.818378  export SHELL=3D/bin/sh
    2023-12-13T21:41:57.818817  #
    2023-12-13T21:41:57.920070  / # export SHELL=3D/bin/sh. /lava-350233/en=
vironment
    2023-12-13T21:41:57.920500  =

    2023-12-13T21:41:58.021804  / # . /lava-350233/environment/lava-350233/=
bin/lava-test-runner /lava-350233/1
    2023-12-13T21:41:58.022483  =

    2023-12-13T21:41:58.026936  / # /lava-350233/bin/lava-test-runner /lava=
-350233/1
    2023-12-13T21:41:58.134886  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/657a258367aa36f790e13491

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-97-g284f46c131b10/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-97-g284f46c131b10/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657a258367aa36f790e1349a
        failing since 21 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-13T21:50:58.074615  / # #

    2023-12-13T21:50:58.176709  export SHELL=3D/bin/sh

    2023-12-13T21:50:58.177338  #

    2023-12-13T21:50:58.278683  / # export SHELL=3D/bin/sh. /lava-12263499/=
environment

    2023-12-13T21:50:58.279465  =


    2023-12-13T21:50:58.380899  / # . /lava-12263499/environment/lava-12263=
499/bin/lava-test-runner /lava-12263499/1

    2023-12-13T21:50:58.381967  =


    2023-12-13T21:50:58.389226  / # /lava-12263499/bin/lava-test-runner /la=
va-12263499/1

    2023-12-13T21:50:58.448027  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-13T21:50:58.448527  + cd /lav<8>[   16.349109] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12263499_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
rk3399-gru-kevin   | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chr=
omebook | 2          =


  Details:     https://kernelci.org/test/plan/id/657a26424da40235a7e1350b

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-97-g284f46c131b10/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-97-g284f46c131b10/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/657a26424da40235a7e13532
        failing since 274 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-13T21:48:56.892176  /lava-12263511/1/../bin/lava-test-case

    2023-12-13T21:48:56.903197  <8>[   35.616496] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/657a26424da40235a7e13533
        failing since 274 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-13T21:48:55.855301  /lava-12263511/1/../bin/lava-test-case

    2023-12-13T21:48:55.866493  <8>[   34.579213] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/657a258767aa36f790e134a8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-97-g284f46c131b10/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-97-g284f46c131b10/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657a258767aa36f790e134b1
        failing since 21 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-13T21:43:25.642514  <8>[   16.985715] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447933_1.5.2.4.1>
    2023-12-13T21:43:25.747524  / # #
    2023-12-13T21:43:25.849160  export SHELL=3D/bin/sh
    2023-12-13T21:43:25.849849  #
    2023-12-13T21:43:25.950849  / # export SHELL=3D/bin/sh. /lava-447933/en=
vironment
    2023-12-13T21:43:25.951583  =

    2023-12-13T21:43:26.052605  / # . /lava-447933/environment/lava-447933/=
bin/lava-test-runner /lava-447933/1
    2023-12-13T21:43:26.053599  =

    2023-12-13T21:43:26.057726  / # /lava-447933/bin/lava-test-runner /lava=
-447933/1
    2023-12-13T21:43:26.124858  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/657a2598d3f2586418e13480

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-97-g284f46c131b10/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-97-g284f46c131b10/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657a2598d3f2586418e13489
        failing since 21 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-13T21:51:13.733106  / # #

    2023-12-13T21:51:13.835193  export SHELL=3D/bin/sh

    2023-12-13T21:51:13.835887  #

    2023-12-13T21:51:13.937149  / # export SHELL=3D/bin/sh. /lava-12263493/=
environment

    2023-12-13T21:51:13.937801  =


    2023-12-13T21:51:14.039173  / # . /lava-12263493/environment/lava-12263=
493/bin/lava-test-runner /lava-12263493/1

    2023-12-13T21:51:14.040262  =


    2023-12-13T21:51:14.041457  / # /lava-12263493/bin/lava-test-runner /la=
va-12263493/1

    2023-12-13T21:51:14.084816  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-13T21:51:14.115513  + cd /lava-1226349<8>[   18.258482] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12263493_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

