Return-Path: <stable+bounces-3197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632097FE762
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 03:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 181EE2823D6
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 02:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878F679F6;
	Thu, 30 Nov 2023 02:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="jiBQlzS+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606AD10E2
	for <stable@vger.kernel.org>; Wed, 29 Nov 2023 18:46:07 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-28594582e44so517482a91.0
        for <stable@vger.kernel.org>; Wed, 29 Nov 2023 18:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701312366; x=1701917166; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uygguNpBxXhLgvaY3o2xHRnIgrSXntfcY/vMWrngxJI=;
        b=jiBQlzS+QcVV7Y+LeHSEgtDY+sVmMho+GABd+ISAj2xHoUYKcm/KPsFAOpd8aT06CL
         uFfRIKhv5fxYfCyk8nfjoZHayVEXDxZPGwVP7yOeX+t+Sg+1KSd5ipHZjcOYdLr7Qmau
         6a9RCv12+VrpiV367ySKC6ZJ0RRsIi2cEzvIVjTgvoEUv+Iwtc+a14bxXIRnjA4jXkJ3
         fCsCsAHCsoMy6mphx8KutuUuMGduF2Z9PHLijNZ0GLW1ZFgYCLF2eoY8J1fkNqviAOSG
         bhJECQMclBD9B3gOL1pLdUB06p07jYUB25sOf3Fg5kHV/3n/jMUPl3KICPsVdvCu5VvY
         l54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701312366; x=1701917166;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uygguNpBxXhLgvaY3o2xHRnIgrSXntfcY/vMWrngxJI=;
        b=NgX9pq8B5yctEPlj4TBZGcCKHgAY+/84CdM4b+jrewAXfQJ4TRIqemaRhv6f0RCABg
         LsSmDJ43OuOVTn15gIL9WK6j4TDx9JglvZS52+3QgOkLvgMLDDphzpQjKdvVqRphxLmY
         VFJ23D8gwok4c52TggK7bsvbqjsGeOf2sf+pckRu/vLtXYmAH4iZEtWAjoVtzYYDAoVT
         jO/FWw4NavlpC4yXpYzWauP1eEzqgah3NW3LnmqG09NAz3MonjNuh/lV3abLQDA6jbaN
         A9r4N9NQQZ5AfNsQY2xckdzizZUTUCcir/V5twRItULzmSAlTOcgSRAIv4ZV5OToal1j
         M37w==
X-Gm-Message-State: AOJu0Yxj93W7PQ6EXTTnnfY2SKy1czvpGnr1raMnH9D3vTqe/VbLb/Az
	qm6qFo0jG6hITOZ2VimJahblnfb/KcdNgl+ABrMcGQ==
X-Google-Smtp-Source: AGHT+IF1FL5XcTNj8nQl48V42YtCO3uW9fTjLiGld9c48BotVMz7HrPEAe85cllnVRnauAzBPwbglw==
X-Received: by 2002:a17:90b:3a90:b0:285:34a2:3dab with SMTP id om16-20020a17090b3a9000b0028534a23dabmr20521315pjb.11.1701312365905;
        Wed, 29 Nov 2023 18:46:05 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y125-20020a636483000000b005bd3d6e270dsm136196pgb.68.2023.11.29.18.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 18:46:05 -0800 (PST)
Message-ID: <6567f76d.630a0220.f6458.0936@mx.google.com>
Date: Wed, 29 Nov 2023 18:46:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.64-52-gf4eda5c29509d
Subject: stable-rc/queue/6.1 baseline: 148 runs,
 4 regressions (v6.1.64-52-gf4eda5c29509d)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 148 runs, 4 regressions (v6.1.64-52-gf4eda5c2=
9509d)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
beaglebone-black   | arm   | lab-broonie   | gcc-10   | omap2plus_defconfig=
 | 1          =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
 | 1          =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.64-52-gf4eda5c29509d/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.64-52-gf4eda5c29509d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      f4eda5c29509d37d2b2176f0e8d34335969bb67c =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
beaglebone-black   | arm   | lab-broonie   | gcc-10   | omap2plus_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6567c3723964fe451d7e4a88

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.64-52=
-gf4eda5c29509d/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beagleb=
one-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.64-52=
-gf4eda5c29509d/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beagleb=
one-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6567c3723964fe451d7e4=
a89
        new failure (last pass: v6.1.64-54-g93cdac04ac8ae) =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6567c5d674d84717777e4a8a

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.64-52=
-gf4eda5c29509d/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.64-52=
-gf4eda5c29509d/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6567c5d674d84717777e4a93
        failing since 7 days (last pass: v6.1.31-26-gef50524405c2, first fa=
il: v6.1.63-176-gecc0fed1ffa4)

    2023-11-29T23:20:40.165318  / # #

    2023-11-29T23:20:40.267577  export SHELL=3D/bin/sh

    2023-11-29T23:20:40.268294  #

    2023-11-29T23:20:40.369524  / # export SHELL=3D/bin/sh. /lava-12126576/=
environment

    2023-11-29T23:20:40.370261  =


    2023-11-29T23:20:40.471545  / # . /lava-12126576/environment/lava-12126=
576/bin/lava-test-runner /lava-12126576/1

    2023-11-29T23:20:40.472649  =


    2023-11-29T23:20:40.489734  / # /lava-12126576/bin/lava-test-runner /la=
va-12126576/1

    2023-11-29T23:20:40.537859  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-29T23:20:40.538395  + cd /lav<8>[   19.097531] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12126576_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6567c5be46b55a73717e4ad0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.64-52=
-gf4eda5c29509d/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.64-52=
-gf4eda5c29509d/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6567c5be46b55a73717e4ad9
        failing since 7 days (last pass: v6.1.22-372-g971903477e72, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-11-29T23:14:00.728181  <8>[   18.139130] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 445845_1.5.2.4.1>
    2023-11-29T23:14:00.833216  / # #
    2023-11-29T23:14:00.934849  export SHELL=3D/bin/sh
    2023-11-29T23:14:00.935440  #
    2023-11-29T23:14:01.036439  / # export SHELL=3D/bin/sh. /lava-445845/en=
vironment
    2023-11-29T23:14:01.037044  =

    2023-11-29T23:14:01.138077  / # . /lava-445845/environment/lava-445845/=
bin/lava-test-runner /lava-445845/1
    2023-11-29T23:14:01.139079  =

    2023-11-29T23:14:01.143412  / # /lava-445845/bin/lava-test-runner /lava=
-445845/1
    2023-11-29T23:14:01.222425  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6567c5d574d84717777e4a7c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.64-52=
-gf4eda5c29509d/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.64-52=
-gf4eda5c29509d/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6567c5d574d84717777e4a85
        failing since 7 days (last pass: v6.1.22-372-g971903477e72, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-11-29T23:20:50.452886  / # #

    2023-11-29T23:20:50.555174  export SHELL=3D/bin/sh

    2023-11-29T23:20:50.555953  #

    2023-11-29T23:20:50.657269  / # export SHELL=3D/bin/sh. /lava-12126570/=
environment

    2023-11-29T23:20:50.657996  =


    2023-11-29T23:20:50.759411  / # . /lava-12126570/environment/lava-12126=
570/bin/lava-test-runner /lava-12126570/1

    2023-11-29T23:20:50.760629  =


    2023-11-29T23:20:50.761836  / # /lava-12126570/bin/lava-test-runner /la=
va-12126570/1

    2023-11-29T23:20:50.842920  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-29T23:20:50.843424  + cd /lava-1212657<8>[   19.057705] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12126570_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

