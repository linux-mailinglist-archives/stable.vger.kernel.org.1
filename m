Return-Path: <stable+bounces-6499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AF480F6C2
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 20:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA76AB20ADD
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 19:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E3281E57;
	Tue, 12 Dec 2023 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="NFlvBzbg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C205A1
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 11:35:16 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1d053c45897so53202815ad.2
        for <stable@vger.kernel.org>; Tue, 12 Dec 2023 11:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702409715; x=1703014515; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mv1cdW3Y0FUjhk/kk2zWKqK4amajtBKlpwDfH2eNy4U=;
        b=NFlvBzbgdaq7/AiRPC+QzlSXZf07SO2qnfdlS63Ux7rqDOqM58v1DI/UPmlRHHyjyB
         grYYcB2lJNuiQXvsRnBBnz7gDL2qRQHMgq42/iRUlV+xOjhePnBLFJWlghLzM7lMSvNF
         7ABj4mr4Hp38F3NRntOKsJMI6OLzOpvcVLj6+WolmZBgjQTOKvV+Fr+tszfrOY5ZIUeK
         ZpyIyo8dP6EZyWba68+xEXhPrexf5nizlSOx6AYti+SeVf/psdN/1uVHAlddBF7BKUgh
         htqJlNvhSKPYV8JYEzWiOtesyTQUiTldqXnMbsLnFJKoHGZq3G1YE5S9HFukVAyV8iY4
         wrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702409715; x=1703014515;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mv1cdW3Y0FUjhk/kk2zWKqK4amajtBKlpwDfH2eNy4U=;
        b=QnrQTRTQtmNPn34CgeUpOQdlQRQsTpO6tuAPMkbv6OO37QOyxn0p58R6pWnKvi+mgO
         gFvuAuDfNqaHiZ2eufUyOFAaZhsjiQEWaiRRxqQi2B2xsgTd59wUVMpw3iknm9HV4VvO
         EVrscMCFeKwI7PtboDAJYQOHw9+/6Ijg+14Hbxw4rI8WEteiH5kBjV7xm0F7pWJq6gvc
         iNnYLXh3H2lYjluPl5RqDR+3TsaxHvDnLmaJ8GDdcKnUycvhndJiiYvMBjgsW+2JogRy
         CFcF785kqI3Gp1TRGVB+rtmnK73eo0LpXCBWji+zlG5F90yOZ8DKw8j/nftS4z2XkKeF
         Fqww==
X-Gm-Message-State: AOJu0YzJGZfDbhnWB37GXao2LyHgE8xZv2tC8+LZdhuMpT4UGyHIEPwW
	g/1M0Db+d18Z3+ceSATfua9l5y4+hpXcWDgaD3c+RQ==
X-Google-Smtp-Source: AGHT+IFaJso265sSDp3NN1BDiT5v1+Tfqgc+LWi+XL22++Q2bXkN/bRq3Xj62bZkFvOnH3BcEYTZcQ==
X-Received: by 2002:a17:902:e5c5:b0:1d1:cd8b:8bc2 with SMTP id u5-20020a170902e5c500b001d1cd8b8bc2mr7564778plf.33.1702409715217;
        Tue, 12 Dec 2023 11:35:15 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bj4-20020a170902850400b001cfa718039bsm8966896plb.216.2023.12.12.11.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 11:35:14 -0800 (PST)
Message-ID: <6578b5f2.170a0220.c1c2d.bfd4@mx.google.com>
Date: Tue, 12 Dec 2023 11:35:14 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.142-139-ga4ffe767de538
Subject: stable-rc/queue/5.15 baseline: 106 runs,
 3 regressions (v5.15.142-139-ga4ffe767de538)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 106 runs, 3 regressions (v5.15.142-139-ga4ff=
e767de538)

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


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.142-139-ga4ffe767de538/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.142-139-ga4ffe767de538
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      a4ffe767de5380b7766e1604b9517e635ee15953 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6578808cf07bda596be134cd

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-139-ga4ffe767de538/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-139-ga4ffe767de538/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6578808cf07bda596be134d6
        failing since 20 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-12T15:54:37.822791  / # #

    2023-12-12T15:54:37.923270  export SHELL=3D/bin/sh

    2023-12-12T15:54:37.923379  #

    2023-12-12T15:54:38.023860  / # export SHELL=3D/bin/sh. /lava-12254905/=
environment

    2023-12-12T15:54:38.023979  =


    2023-12-12T15:54:38.124471  / # . /lava-12254905/environment/lava-12254=
905/bin/lava-test-runner /lava-12254905/1

    2023-12-12T15:54:38.124671  =


    2023-12-12T15:54:38.136667  / # /lava-12254905/bin/lava-test-runner /la=
va-12254905/1

    2023-12-12T15:54:38.190343  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-12T15:54:38.190455  + cd /lav<8>[   15.978925] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12254905_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65788070990439c317e1348a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-139-ga4ffe767de538/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-139-ga4ffe767de538/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65788070990439c317e13493
        failing since 20 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-12T15:46:47.068315  <8>[   16.106360] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447763_1.5.2.4.1>
    2023-12-12T15:46:47.173402  / # #
    2023-12-12T15:46:47.275025  export SHELL=3D/bin/sh
    2023-12-12T15:46:47.275609  #
    2023-12-12T15:46:47.376602  / # export SHELL=3D/bin/sh. /lava-447763/en=
vironment
    2023-12-12T15:46:47.377191  =

    2023-12-12T15:46:47.478203  / # . /lava-447763/environment/lava-447763/=
bin/lava-test-runner /lava-447763/1
    2023-12-12T15:46:47.479064  =

    2023-12-12T15:46:47.483533  / # /lava-447763/bin/lava-test-runner /lava=
-447763/1
    2023-12-12T15:46:47.515587  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6578808f5de84905a8e13495

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-139-ga4ffe767de538/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-139-ga4ffe767de538/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6578808f5de84905a8e1349e
        failing since 20 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-12T15:54:52.912042  / # #

    2023-12-12T15:54:53.013956  export SHELL=3D/bin/sh

    2023-12-12T15:54:53.014215  #

    2023-12-12T15:54:53.115088  / # export SHELL=3D/bin/sh. /lava-12254919/=
environment

    2023-12-12T15:54:53.115795  =


    2023-12-12T15:54:53.217189  / # . /lava-12254919/environment/lava-12254=
919/bin/lava-test-runner /lava-12254919/1

    2023-12-12T15:54:53.217681  =


    2023-12-12T15:54:53.225869  / # /lava-12254919/bin/lava-test-runner /la=
va-12254919/1

    2023-12-12T15:54:53.290897  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-12T15:54:53.290976  + cd /lava-1225491<8>[   16.805470] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12254919_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

