Return-Path: <stable+bounces-4727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C04805B36
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 18:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4AE281BD4
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 17:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1835268B70;
	Tue,  5 Dec 2023 17:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="cspKR9U1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E420A1AA
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 09:35:29 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6ce52ff23dfso13826b3a.0
        for <stable@vger.kernel.org>; Tue, 05 Dec 2023 09:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701797729; x=1702402529; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bDCJmRhNb3x1qnbuAcChCV4UZi+xi6o9Fflp2nTHhis=;
        b=cspKR9U1QvokZSu3ATP7mWPhnXzLEzXqoH41O0V9kIAAkFul47yZtbSZ18UlKHZNEN
         fdjTuER2l/jDU8IgeYRfKF/EynJlHqnjdkdmjyf3JiM+cAck5d2bz0yLydqgmeQOlnki
         LfNYipTJN9eE/ToezX/NM+28hMk4Qiyp/x1VlzxJzUAH+/WWOi1nfrxbpVCcPW3vWYfe
         AhlTULFDk/zmo5WTIKABiueVJ0I13WY1aOH0L+wccv4vJOlM4wJSrJh8fZwfyLbyOJjQ
         r3e+4I5fYzL2zEPRyFP6Egr4q9Vi3ueMp69qMj9DGzztMJRqABE5u98akUwUgNx3euYt
         oAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701797729; x=1702402529;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bDCJmRhNb3x1qnbuAcChCV4UZi+xi6o9Fflp2nTHhis=;
        b=Q4tBlrgIvkSaMPdtveTKQx+UsOTiAecBS+NpSfaO/5GHO4jkTpYIpVMWgEz9YyzEwc
         h+WHQsEgg+CMDwqUJ4xskgWVcr5Ha2DKQ7tZ2G9WRqhF22YmfUpRCfRwsbvmx4Rt2e2Y
         rmxW2zlQgA6U/dx7WBitSHnf7QtfFiB4d8BA+wjCqtHZE7OzA6hVMz2tql+CgWbO3uqB
         s/chrfZXzrw3R8iACOhO0JC+/WGfmZUhUTXSCiHXLLxQfWC6YBBRX6tT5YOceKIUo81H
         j0yVqtq48gw+qJZeZJrGY730M9AJWvmhH/yxnHPEfUH4GYGVokLZA6YnFQukEbWwlJiQ
         u21w==
X-Gm-Message-State: AOJu0YxJ9Ix8t0GKlf0mmbJWI2ND/zJOYzTfUasQ0TsUdytDE4min0+V
	MjijE2j6CyJ7Qcgzk6dYd7Me2RtierjaSyNoUlP7hw==
X-Google-Smtp-Source: AGHT+IHl/NxpqehWtTtsx167EcMfBYAFm9Q85MVL0LKECqgw9fzoM3C3aR+Mj857qQHGfe+PW5Bkww==
X-Received: by 2002:a05:6a00:3a1a:b0:68f:a92a:8509 with SMTP id fj26-20020a056a003a1a00b0068fa92a8509mr1968736pfb.7.1701797728589;
        Tue, 05 Dec 2023 09:35:28 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i19-20020aa78d93000000b006ce614a87edsm2601792pfr.176.2023.12.05.09.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 09:35:28 -0800 (PST)
Message-ID: <656f5f60.a70a0220.9c60f.8f73@mx.google.com>
Date: Tue, 05 Dec 2023 09:35:28 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.65-107-g884c56508f09
Subject: stable-rc/queue/6.1 baseline: 140 runs,
 3 regressions (v6.1.65-107-g884c56508f09)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 140 runs, 3 regressions (v6.1.65-107-g884c565=
08f09)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.65-107-g884c56508f09/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.65-107-g884c56508f09
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      884c56508f096d8a34ae70f9dda605fa30d8e62c =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/656f2ce324429a3557e13479

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-10=
7-g884c56508f09/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-10=
7-g884c56508f09/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656f2ce324429a3557e1347e
        failing since 12 days (last pass: v6.1.31-26-gef50524405c2, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-05T14:07:12.191613  / # #

    2023-12-05T14:07:12.292688  export SHELL=3D/bin/sh

    2023-12-05T14:07:12.293357  #

    2023-12-05T14:07:12.394748  / # export SHELL=3D/bin/sh. /lava-12186870/=
environment

    2023-12-05T14:07:12.395454  =


    2023-12-05T14:07:12.497002  / # . /lava-12186870/environment/lava-12186=
870/bin/lava-test-runner /lava-12186870/1

    2023-12-05T14:07:12.498143  =


    2023-12-05T14:07:12.499978  / # /lava-12186870/bin/lava-test-runner /la=
va-12186870/1

    2023-12-05T14:07:12.563589  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-05T14:07:12.564048  + cd /lav<8>[   19.047208] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12186870_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/656f2cdd0cc40e0c38e13480

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-10=
7-g884c56508f09/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-10=
7-g884c56508f09/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656f2cde0cc40e0c38e13485
        failing since 12 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-05T13:59:52.578166  <8>[   18.065901] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 446595_1.5.2.4.1>
    2023-12-05T13:59:52.683113  / # #
    2023-12-05T13:59:52.784864  export SHELL=3D/bin/sh
    2023-12-05T13:59:52.785586  #
    2023-12-05T13:59:52.886583  / # export SHELL=3D/bin/sh. /lava-446595/en=
vironment
    2023-12-05T13:59:52.887176  =

    2023-12-05T13:59:52.988191  / # . /lava-446595/environment/lava-446595/=
bin/lava-test-runner /lava-446595/1
    2023-12-05T13:59:52.989157  =

    2023-12-05T13:59:52.993304  / # /lava-446595/bin/lava-test-runner /lava=
-446595/1
    2023-12-05T13:59:53.072747  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/656f2ce10cc40e0c38e134a5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-10=
7-g884c56508f09/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-10=
7-g884c56508f09/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656f2ce10cc40e0c38e134aa
        failing since 12 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-05T14:07:30.978254  / # #

    2023-12-05T14:07:31.078844  export SHELL=3D/bin/sh

    2023-12-05T14:07:31.079025  #

    2023-12-05T14:07:31.179653  / # export SHELL=3D/bin/sh. /lava-12186865/=
environment

    2023-12-05T14:07:31.180349  =


    2023-12-05T14:07:31.281767  / # . /lava-12186865/environment/lava-12186=
865/bin/lava-test-runner /lava-12186865/1

    2023-12-05T14:07:31.282797  =


    2023-12-05T14:07:31.292329  / # /lava-12186865/bin/lava-test-runner /la=
va-12186865/1

    2023-12-05T14:07:31.365257  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-05T14:07:31.365747  + cd /lava-1218686<8>[   19.143540] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12186865_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

