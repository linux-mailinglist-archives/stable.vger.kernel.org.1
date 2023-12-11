Return-Path: <stable+bounces-5270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D799480C48C
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 10:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058631C209E9
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 09:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5372921353;
	Mon, 11 Dec 2023 09:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="sN/7psUL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5371F3
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 01:28:35 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6d089bc4e1aso566006b3a.0
        for <stable@vger.kernel.org>; Mon, 11 Dec 2023 01:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702286915; x=1702891715; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KZej57XxJsS5F3X/mRXMcPVa27TTSoiMeDVLDM2jUyQ=;
        b=sN/7psULkq/t4uaHTRsRZBWPTViguOR7DP0cjxSYyUxp0/Hvio5gmLEk8HG30dlniM
         VfojO8VQDzCub5VpkNJrirX61hvlhr2mQIhHCc6fWI23e4Vi2dYl+Ad7EtoRI0sjUvzp
         sn/Esfy5Q6hhADJL5daOoV2uLJwtcp/rY00Ud2FLvVvp6KNrMsaRVCIVDz449oK7SBNL
         kOTPpBuSorz2S6YmCZnw56r5VCOnty36vLwQk26hCTn61L9Ohj7x7rXNcxMl/aCxaHp6
         5hecRbduW4quYYcbEqfUaV6E24V1UlZTMCP5X5w1260pI45yUPqX7FD/bR70b06NxP7y
         av2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702286915; x=1702891715;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KZej57XxJsS5F3X/mRXMcPVa27TTSoiMeDVLDM2jUyQ=;
        b=r9yoahSCZz8pmtR34N0WIXYP/R8Ynk0vOdjAJziHt5hLJo6NdcWCGpY3pzEQ1Pvvy2
         BoIJnJu3VDyHN2j5ooS/OPuW/I3v0DFtfimufXxnIIJZi/gzyYAZUie9KUXv4V8wYUQr
         dtbVgYlgODPok1lQuXMo4v3JSxMq6f9O8QJ/0N7eBHxP5Zit2KEO3w3ZCfeINg+el09e
         sc9Ve3Gm8rdOMMlVghvtTcPhBGKGfZ4CtsgwiyksQb9hCU4K5y5S29vjHDW6kFD/867O
         JjI+st2+LrxrCzormwqr45gNr39Vx4dnPP6fXoWS/mxMqYc6rLgBdaMyGrfj5UeWSZcz
         A4nA==
X-Gm-Message-State: AOJu0YzokbQq6Hk1LEptM/32vLHJeT7tijryJT9GqpsA2jsijcmUfui6
	+hlER4WXxEXQs8WDHvJyIpXB9a2vxuaFLTMUFRiZ4w==
X-Google-Smtp-Source: AGHT+IHSSqYxWI54xk8gyw0ZuRBPR3K5IGwbNmRkD+Foz9TFRLt8Vba80wVDLI3LM071IQyvlyhlSg==
X-Received: by 2002:a05:6a20:a483:b0:18f:9c4:d33e with SMTP id y3-20020a056a20a48300b0018f09c4d33emr4199319pzk.46.1702286914821;
        Mon, 11 Dec 2023 01:28:34 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x20-20020a631714000000b0058988954686sm5661117pgl.90.2023.12.11.01.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 01:28:34 -0800 (PST)
Message-ID: <6576d642.630a0220.f7589.eb55@mx.google.com>
Date: Mon, 11 Dec 2023 01:28:34 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.142-118-g2880d631f2413
Subject: stable-rc/queue/5.15 baseline: 102 runs,
 4 regressions (v5.15.142-118-g2880d631f2413)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 102 runs, 4 regressions (v5.15.142-118-g2880=
d631f2413)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
beagle-xm          | arm   | lab-baylibre  | gcc-10   | omap2plus_defconfig=
 | 1          =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
 | 1          =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.142-118-g2880d631f2413/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.142-118-g2880d631f2413
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      2880d631f241366533324ff746a1c66dcf61fd85 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
beagle-xm          | arm   | lab-baylibre  | gcc-10   | omap2plus_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6576a202889dcbc54be13479

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-118-g2880d631f2413/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-118-g2880d631f2413/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6576a202889dcbc54be13=
47a
        failing since 310 days (last pass: v5.15.91-12-g3290f78df1ab, first=
 fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6576c1da31fbdc10d1e134ca

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-118-g2880d631f2413/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-118-g2880d631f2413/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6576c1db31fbdc10d1e134cf
        failing since 18 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-11T08:08:44.448561  / # #

    2023-12-11T08:08:44.549076  export SHELL=3D/bin/sh

    2023-12-11T08:08:44.549746  #

    2023-12-11T08:08:44.651007  / # export SHELL=3D/bin/sh. /lava-12242300/=
environment

    2023-12-11T08:08:44.651773  =


    2023-12-11T08:08:44.753490  / # . /lava-12242300/environment/lava-12242=
300/bin/lava-test-runner /lava-12242300/1

    2023-12-11T08:08:44.754895  =


    2023-12-11T08:08:44.763086  / # /lava-12242300/bin/lava-test-runner /la=
va-12242300/1

    2023-12-11T08:08:44.821899  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-11T08:08:44.822430  + cd /lav<8>[   15.915620] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12242300_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/65769eb42ff50bcf85e13490

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-118-g2880d631f2413/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-118-g2880d631f2413/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65769eb42ff50bcf85e13495
        failing since 18 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-11T05:31:23.621399  <8>[   16.110720] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447564_1.5.2.4.1>
    2023-12-11T05:31:23.726475  / # #
    2023-12-11T05:31:23.828093  export SHELL=3D/bin/sh
    2023-12-11T05:31:23.828693  #
    2023-12-11T05:31:23.929628  / # export SHELL=3D/bin/sh. /lava-447564/en=
vironment
    2023-12-11T05:31:23.930206  =

    2023-12-11T05:31:24.031224  / # . /lava-447564/environment/lava-447564/=
bin/lava-test-runner /lava-447564/1
    2023-12-11T05:31:24.032092  =

    2023-12-11T05:31:24.036587  / # /lava-447564/bin/lava-test-runner /lava=
-447564/1
    2023-12-11T05:31:24.068674  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/65769ed571da0d168ce13484

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-118-g2880d631f2413/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-118-g2880d631f2413/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65769ed571da0d168ce13489
        failing since 18 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-11T05:39:19.860469  / # #

    2023-12-11T05:39:19.962614  export SHELL=3D/bin/sh

    2023-12-11T05:39:19.963339  #

    2023-12-11T05:39:20.064661  / # export SHELL=3D/bin/sh. /lava-12242297/=
environment

    2023-12-11T05:39:20.065393  =


    2023-12-11T05:39:20.166778  / # . /lava-12242297/environment/lava-12242=
297/bin/lava-test-runner /lava-12242297/1

    2023-12-11T05:39:20.167892  =


    2023-12-11T05:39:20.212659  / # /lava-12242297/bin/lava-test-runner /la=
va-12242297/1

    2023-12-11T05:39:20.244012  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-11T05:39:20.244575  + cd /lava-1224229<8>[   16.832260] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12242297_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

