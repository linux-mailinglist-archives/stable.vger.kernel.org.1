Return-Path: <stable+bounces-3163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0127FDDAB
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 17:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8612823A1
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 16:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EE13985A;
	Wed, 29 Nov 2023 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="isn0XKVT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27E0DC
	for <stable@vger.kernel.org>; Wed, 29 Nov 2023 08:54:18 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6cbe6d514cdso5804656b3a.1
        for <stable@vger.kernel.org>; Wed, 29 Nov 2023 08:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701276858; x=1701881658; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vhnmod9UNktp0c1BgfVekz1IJr7X+D+jBrLBIDKIUwQ=;
        b=isn0XKVTuyaPK+GR3Nyj+lFkpBBwayeEZXEHPU1FRDATr2eR9tRxcQJ0ICthvIzyuW
         PpUbBJqmqXjbK5YyQvJFhd/j9IYA0+ZMHOHFw3AzJ1fnL8Yf3Znu9q79n+IKjov6bB7w
         4IyoFO6tSrACBRlyPV336oMTHQ+XmYOOV2NcNrG8QH4SfYCQOSJmNuGR0JvVLkBCL6mg
         FC+KERXgscVQKuK7CoIVASVBpYOFhyrWufwJmVlQyW/oIu8lrmcH+IR4nZ45hNVmXpKW
         gpHjY074bt/6bRNhQJl1tTTGDFXWrAp8t8rM1Es0ra/JQHGZQB1/rPUHbdFazH8mjKtU
         dihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701276858; x=1701881658;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vhnmod9UNktp0c1BgfVekz1IJr7X+D+jBrLBIDKIUwQ=;
        b=Nun7uXCnAha8NBFLHR0a9cyU4Szg+NEg4VThSNWCHOGmwJob9sxpBaKiGimk8Hu5zA
         mP3kWO37EKl/egLR9T901QHEQig1Imyb5R+OcW6siJGnwQAlhGo6SnXZfErLR4HXQZHc
         ctgsvGWl6tzJumB3K1pmOUiJBGjlxwJMPo+KEt/kaY/MYO4OP1crnZLSOQCVhfqKGdhm
         KeREviOwipkEb9muPmxU13kopoklzoOhYvCMgriI9KNK8LuN8LCVSzXbm6fPUsEvlTjh
         GeV6ME1Vg1D/t6Yc521zYwwX8OBp27eBlsgUPgpriKE54ra04pJCPhrUIDnyQ7Hp+f7I
         iMkQ==
X-Gm-Message-State: AOJu0YyX2E2R7P5HQDebw72f4DaTkPOkIkLPgsbmM9j+B2nH97NiCsN3
	73kwO5ctHXhyWuQRQS0chc5IVQd1sbYmcB/ViRCHmA==
X-Google-Smtp-Source: AGHT+IGwxoQiwwNc5hLrzwiehOjnaHk6KtwXgpG6364kapizKlVbZyQ4VIuMxYQcXC8Zzt1ZzGQVGA==
X-Received: by 2002:a05:6a20:258c:b0:187:9521:92b9 with SMTP id k12-20020a056a20258c00b00187952192b9mr17416515pzd.53.1701276858016;
        Wed, 29 Nov 2023 08:54:18 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k26-20020a63ff1a000000b005b8f3293bf2sm11695734pgi.88.2023.11.29.08.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 08:54:17 -0800 (PST)
Message-ID: <65676cb9.630a0220.e8a38.e21c@mx.google.com>
Date: Wed, 29 Nov 2023 08:54:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.140-41-g94f03c6721bf7
Subject: stable-rc/queue/5.15 baseline: 140 runs,
 5 regressions (v5.15.140-41-g94f03c6721bf7)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 140 runs, 5 regressions (v5.15.140-41-g94f03=
c6721bf7)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
kontron-pitx-imx8m | arm64 | lab-kontron   | gcc-10   | defconfig | 1      =
    =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =

rk3399-rock-pi-4b  | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.140-41-g94f03c6721bf7/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.140-41-g94f03c6721bf7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      94f03c6721bf7294bf22eba13b52a5987cc49c15 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
kontron-pitx-imx8m | arm64 | lab-kontron   | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65673cbbc18063713e7e4a72

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.140=
-41-g94f03c6721bf7/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx=
-imx8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.140=
-41-g94f03c6721bf7/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx=
-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65673cbbc18063713e7e4=
a73
        new failure (last pass: v5.15.139-291-g3a968ce68298) =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65675fa87cbfd9c4bc7e4a6d

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.140=
-41-g94f03c6721bf7/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.140=
-41-g94f03c6721bf7/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65675fa87cbfd9c4bc7e4a76
        failing since 7 days (last pass: v5.15.114-13-g095e387c3889, first =
fail: v5.15.139-172-gb60494a37c0c)

    2023-11-29T16:04:39.530649  / # #

    2023-11-29T16:04:39.632692  export SHELL=3D/bin/sh

    2023-11-29T16:04:39.633396  #

    2023-11-29T16:04:39.734496  / # export SHELL=3D/bin/sh. /lava-12120344/=
environment

    2023-11-29T16:04:39.734723  =


    2023-11-29T16:04:39.835482  / # . /lava-12120344/environment/lava-12120=
344/bin/lava-test-runner /lava-12120344/1

    2023-11-29T16:04:39.836460  =


    2023-11-29T16:04:39.838497  / # /lava-12120344/bin/lava-test-runner /la=
va-12120344/1

    2023-11-29T16:04:39.902445  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-29T16:04:39.902966  + cd /lav<8>[   16.008332] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12120344_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
rk3399-rock-pi-4b  | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65673cbdc18063713e7e4a75

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.140=
-41-g94f03c6721bf7/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-roc=
k-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.140=
-41-g94f03c6721bf7/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-roc=
k-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65673cbdc18063713e7e4=
a76
        new failure (last pass: v5.15.139-291-g3a968ce68298) =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65673bc0c5be2a32e47e4a74

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.140=
-41-g94f03c6721bf7/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.140=
-41-g94f03c6721bf7/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65673bc1c5be2a32e47e4a7d
        failing since 6 days (last pass: v5.15.105-206-g4548859116b8, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-11-29T13:24:44.779840  <8>[   16.105569] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 445801_1.5.2.4.1>
    2023-11-29T13:24:44.884842  / # #
    2023-11-29T13:24:44.986499  export SHELL=3D/bin/sh
    2023-11-29T13:24:44.987089  #
    2023-11-29T13:24:45.088063  / # export SHELL=3D/bin/sh. /lava-445801/en=
vironment
    2023-11-29T13:24:45.088734  =

    2023-11-29T13:24:45.189748  / # . /lava-445801/environment/lava-445801/=
bin/lava-test-runner /lava-445801/1
    2023-11-29T13:24:45.190635  =

    2023-11-29T13:24:45.195108  / # /lava-445801/bin/lava-test-runner /lava=
-445801/1
    2023-11-29T13:24:45.227223  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65673bca215eb7204e7e4a87

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.140=
-41-g94f03c6721bf7/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.140=
-41-g94f03c6721bf7/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65673bca215eb7204e7e4a90
        failing since 6 days (last pass: v5.15.105-206-g4548859116b8, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-11-29T13:31:34.929844  / # #

    2023-11-29T13:31:35.030403  export SHELL=3D/bin/sh

    2023-11-29T13:31:35.030540  #

    2023-11-29T13:31:35.131129  / # export SHELL=3D/bin/sh. /lava-12120356/=
environment

    2023-11-29T13:31:35.131321  =


    2023-11-29T13:31:35.231859  / # . /lava-12120356/environment/lava-12120=
356/bin/lava-test-runner /lava-12120356/1

    2023-11-29T13:31:35.232107  =


    2023-11-29T13:31:35.243635  / # /lava-12120356/bin/lava-test-runner /la=
va-12120356/1

    2023-11-29T13:31:35.305317  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-29T13:31:35.305438  + cd /lava-1212035<8>[   16.769474] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12120356_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

