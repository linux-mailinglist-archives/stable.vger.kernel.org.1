Return-Path: <stable+bounces-5041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C99B80A942
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 17:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CE72B20AFD
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 16:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A86614A84;
	Fri,  8 Dec 2023 16:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Gqf77uCJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE031FD9
	for <stable@vger.kernel.org>; Fri,  8 Dec 2023 08:36:28 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5c67c1ad5beso2590460a12.1
        for <stable@vger.kernel.org>; Fri, 08 Dec 2023 08:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702053387; x=1702658187; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ja91uwOpgFrBy3x8OHlBGT9oxlL7bVTI4cek2DXXQ3Q=;
        b=Gqf77uCJqBPiwFR+7lqw/vsoJ3udbndFvv/vdVwdgO6WzjGTM+tu9zNfwmwcuBFbUz
         YFhKDaqQ1/FHfm9x4bqIC8We+K5klxqWcoaKHy+1K+FUaKv6dpoyNErac157uIpiPM/r
         kF1vIVkpkO315MlwqM+L967oL2K4rF3VvHU7XJ0ZaaCWNdf02hkskMGD1ZpydGODEMSL
         xNZluMvvf72SfLJoyQ2OUzzu3jIn1koLZLC6Fu2YfLLAqUFf6bHwoBcBOqWxOZAVkZV3
         UeMk+NfIFGKRU8GlCU3AlQE/ri9+xQmdB2LnzfqNflhm63EpBxGhGSts9yO27XJOmY1t
         9riA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702053387; x=1702658187;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ja91uwOpgFrBy3x8OHlBGT9oxlL7bVTI4cek2DXXQ3Q=;
        b=Cl8iSUA6ys/UxU4WVu7Gfi/mgaoGtmH10uS/cYIV4DA0a7CeGQjuV8UMNibiS/I+ht
         bYF4zHoVPtLKuXC9W1qYNiylzAV62HvIUctAe4ni9Kj+HGBTzykTOVfBDJwH5KkxCAhT
         TCTCArD8ayAPP/DMbuf6xomU7UipOjUWh94G2NUyybAHl0o6jYiA6eX0L+ElCrwd2zKj
         519dxOxKfBjaGOLW0SwKg/Oc7Rf+aVZyIEeUBS02kMCKx5njqIPEZrbF4LdckWd41xXM
         RAnLj0Z+vSh2fo7VzllzyhPpks+/k0ZfJcZLDJbsFQBCo8JZJfXshrtBSq16rwqCJzXt
         1VBQ==
X-Gm-Message-State: AOJu0Yy5cvZjB57d/YZ36bNXysNJsyn43MXMhrshRMTuW56rWlXag7yt
	U84HndYUUIZEx5AgorL8kpBc1TkHA29OlIwgpKw9nQ==
X-Google-Smtp-Source: AGHT+IGry9lW4xSl0UGoDDQnI2mlbEOOAc8IfoUHKY6IEETa5VWyy9t0xmulCsD+ZOkxwlwrPvyc5A==
X-Received: by 2002:a17:90b:209:b0:286:9cdc:c2d8 with SMTP id fy9-20020a17090b020900b002869cdcc2d8mr408844pjb.22.1702053387190;
        Fri, 08 Dec 2023 08:36:27 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id pw10-20020a17090b278a00b002867594de40sm3528848pjb.14.2023.12.08.08.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 08:36:26 -0800 (PST)
Message-ID: <6573460a.170a0220.32e10.a22b@mx.google.com>
Date: Fri, 08 Dec 2023 08:36:26 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.66-10-g45deeed0dade2
Subject: stable-rc/queue/6.1 baseline: 154 runs,
 5 regressions (v6.1.66-10-g45deeed0dade2)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 154 runs, 5 regressions (v6.1.66-10-g45deeed0=
dade2)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
beagle-xm          | arm   | lab-baylibre  | gcc-10   | omap2plus_defconfig=
 | 1          =

kontron-pitx-imx8m | arm64 | lab-kontron   | gcc-10   | defconfig          =
 | 1          =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
 | 1          =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.66-10-g45deeed0dade2/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.66-10-g45deeed0dade2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      45deeed0dade29f16e1949365688ea591c20cf2c =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
beagle-xm          | arm   | lab-baylibre  | gcc-10   | omap2plus_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657315eb57890cfc3ee1369d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-10=
-g45deeed0dade2/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-10=
-g45deeed0dade2/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/657315eb57890cfc3ee13=
69e
        failing since 232 days (last pass: v6.1.22-477-g2128d4458cbc, first=
 fail: v6.1.22-474-gecc61872327e) =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
kontron-pitx-imx8m | arm64 | lab-kontron   | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657314a6f45e5c2f10e13484

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-10=
-g45deeed0dade2/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-im=
x8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-10=
-g45deeed0dade2/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-im=
x8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/657314a6f45e5c2f10e13=
485
        new failure (last pass: v6.1.65-106-gf012621e70aee) =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6573139d573be8c457e13475

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-10=
-g45deeed0dade2/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-10=
-g45deeed0dade2/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6573139d573be8c457e1347e
        failing since 15 days (last pass: v6.1.31-26-gef50524405c2, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-08T13:08:30.781393  / # #

    2023-12-08T13:08:30.883622  export SHELL=3D/bin/sh

    2023-12-08T13:08:30.884385  #

    2023-12-08T13:08:30.985810  / # export SHELL=3D/bin/sh. /lava-12218450/=
environment

    2023-12-08T13:08:30.986540  =


    2023-12-08T13:08:31.087995  / # . /lava-12218450/environment/lava-12218=
450/bin/lava-test-runner /lava-12218450/1

    2023-12-08T13:08:31.089156  =


    2023-12-08T13:08:31.106017  / # /lava-12218450/bin/lava-test-runner /la=
va-12218450/1

    2023-12-08T13:08:31.154690  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-08T13:08:31.155227  + cd /lav<8>[   19.122100] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12218450_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657313954163519c46e1347e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-10=
-g45deeed0dade2/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-10=
-g45deeed0dade2/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657313954163519c46e13487
        failing since 15 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-08T13:01:03.238612  / # #
    2023-12-08T13:01:03.340331  export SHELL=3D/bin/sh
    2023-12-08T13:01:03.340945  #
    2023-12-08T13:01:03.441934  / # export SHELL=3D/bin/sh. /lava-447082/en=
vironment
    2023-12-08T13:01:03.442623  =

    2023-12-08T13:01:03.543656  / # . /lava-447082/environment/lava-447082/=
bin/lava-test-runner /lava-447082/1
    2023-12-08T13:01:03.544545  =

    2023-12-08T13:01:03.548695  / # /lava-447082/bin/lava-test-runner /lava=
-447082/1
    2023-12-08T13:01:03.627768  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-08T13:01:03.628236  + cd /lava-447082/<8>[   18.604737] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 447082_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6573139c09f8905e41e1347c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-10=
-g45deeed0dade2/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-10=
-g45deeed0dade2/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6573139c09f8905e41e13485
        failing since 15 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-08T13:08:44.017248  / # #

    2023-12-08T13:08:44.119376  export SHELL=3D/bin/sh

    2023-12-08T13:08:44.120094  #

    2023-12-08T13:08:44.221562  / # export SHELL=3D/bin/sh. /lava-12218447/=
environment

    2023-12-08T13:08:44.222270  =


    2023-12-08T13:08:44.323704  / # . /lava-12218447/environment/lava-12218=
447/bin/lava-test-runner /lava-12218447/1

    2023-12-08T13:08:44.324839  =


    2023-12-08T13:08:44.341505  / # /lava-12218447/bin/lava-test-runner /la=
va-12218447/1

    2023-12-08T13:08:44.408253  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-08T13:08:44.408784  + cd /lava-1221844<8>[   19.120878] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12218447_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

