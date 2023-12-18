Return-Path: <stable+bounces-7805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4582C8178D3
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 18:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6207286EFF
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 17:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1904BAAB;
	Mon, 18 Dec 2023 17:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="FFgNOX1o"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDF7125C8
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 17:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d3c1a0d91eso5823545ad.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 09:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702920908; x=1703525708; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0IIF23Gdmo3l0XQ0Q3m3hDAXJRTLlKPCUuYxZEfcAUA=;
        b=FFgNOX1oYMPtMhICeorlqp6KJhfwR0gQKHHEsZVCpIbJ/XWIF2FzJ0IYAki6vie5Sx
         Qot60gH+TtBcYV84AxFfvzcxnpSDkaj07S+bwczLoiLK2KiJGanFzBg2HvUyGKgyHzem
         KCmEZTnD1GTVQet7U1QXwom928Z1cJXB8DFmoEAU9iAZNXNURoBbiwyvBzDhDuvHRC5S
         vEQ85vXSBFCU8qVjUELl+xNUdRoJDje7hJ/XQrdIZ7gjS+7k+YdlSgj0wvMkQiN19HeZ
         HrJR/jOg5r/P/Y/zqnNCzk/3jQ8Q4zp7sJIEAeJ3ga73Bs0S9Pbsuv1ZIcjpgSN8SdGj
         tOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702920908; x=1703525708;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0IIF23Gdmo3l0XQ0Q3m3hDAXJRTLlKPCUuYxZEfcAUA=;
        b=C6tW0yPTRJ6ra/1i1ANeRvoVbuTWdfZj15s+ZZNCJceIKwufQSFpBwH1A70m9NDQTE
         DvIcHQIJycQrXnehPTviZxnstWiEYUzTg6TQohnPVtC7Iw4k7X7j1QjyEXFeHsrF2p9E
         PhlaJ52PFL5LDZY8wxP8RYK29jnlZpMcSjAuE1sYJ5vEeMwpo+0jI7qvIe3CvDIG/zDV
         kGzR6iT89PSS6Pab5+9rR4MGblRxRAstw8xcjXZ3nlDlUfBD8U53CSNtwySq55ye0viN
         DseqGphwibkm6FyGtfOBEewnoDT3pmv01Ufy/x26Jik7xXmy0XU7LWZYl3+ih3mlPRsf
         WOvw==
X-Gm-Message-State: AOJu0Yw+afw3dhVIfbiw4UC6ckQtmx3Q09JBecBForvxEA4SlC4rp08H
	F/DZOGugfbPYt6HtK8aMZ4z7lJpXcjSe61PLx1k=
X-Google-Smtp-Source: AGHT+IEBnmDuS1eRAtHlDGa6SPA+Yj+FVTvikTfBG34QIOZ7jLU0JESowU6AUlWY4vz6IDG8zdUv3w==
X-Received: by 2002:a17:903:41c5:b0:1d3:cad3:169a with SMTP id u5-20020a17090341c500b001d3cad3169amr962611ple.7.1702920908066;
        Mon, 18 Dec 2023 09:35:08 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t18-20020a170902e85200b001d0675e59f9sm19292308plg.200.2023.12.18.09.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 09:35:07 -0800 (PST)
Message-ID: <658082cb.170a0220.13e74.9986@mx.google.com>
Date: Mon, 18 Dec 2023 09:35:07 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.143-83-g980d9a43cf444
Subject: stable-rc/queue/5.15 baseline: 107 runs,
 3 regressions (v5.15.143-83-g980d9a43cf444)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 107 runs, 3 regressions (v5.15.143-83-g980d9=
a43cf444)

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
nel/v5.15.143-83-g980d9a43cf444/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.143-83-g980d9a43cf444
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      980d9a43cf44411126d79db48cbb6a8f17f09250 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/658050ef2fb2cf7181e13499

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-83-g980d9a43cf444/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-83-g980d9a43cf444/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/658050ef2fb2cf7181e1349e
        failing since 26 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-18T14:09:35.005040  / # #

    2023-12-18T14:09:35.105442  export SHELL=3D/bin/sh

    2023-12-18T14:09:35.105545  #

    2023-12-18T14:09:35.205967  / # export SHELL=3D/bin/sh. /lava-12302846/=
environment

    2023-12-18T14:09:35.206061  =


    2023-12-18T14:09:35.306540  / # . /lava-12302846/environment/lava-12302=
846/bin/lava-test-runner /lava-12302846/1

    2023-12-18T14:09:35.306927  =


    2023-12-18T14:09:35.319160  / # /lava-12302846/bin/lava-test-runner /la=
va-12302846/1

    2023-12-18T14:09:35.373441  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-18T14:09:35.373947  + cd /lav<8>[   15.987677] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12302846_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/658050da2fb2cf7181e1348a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-83-g980d9a43cf444/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-83-g980d9a43cf444/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/658050da2fb2cf7181e1348f
        failing since 26 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-18T14:01:40.720076  <8>[   16.167837] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 448714_1.5.2.4.1>
    2023-12-18T14:01:40.827162  / # #
    2023-12-18T14:01:40.928804  export SHELL=3D/bin/sh
    2023-12-18T14:01:40.929397  #
    2023-12-18T14:01:41.030770  / # export SHELL=3D/bin/sh. /lava-448714/en=
vironment
    2023-12-18T14:01:41.031368  =

    2023-12-18T14:01:41.132440  / # . /lava-448714/environment/lava-448714/=
bin/lava-test-runner /lava-448714/1
    2023-12-18T14:01:41.133360  =

    2023-12-18T14:01:41.135330  / # /lava-448714/bin/lava-test-runner /lava=
-448714/1
    2023-12-18T14:01:41.208758  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/658050f1dea43b1e28e1355e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-83-g980d9a43cf444/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-83-g980d9a43cf444/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/658050f1dea43b1e28e13563
        failing since 26 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-18T14:09:49.293957  / # #

    2023-12-18T14:09:49.396083  export SHELL=3D/bin/sh

    2023-12-18T14:09:49.396828  #

    2023-12-18T14:09:49.498302  / # export SHELL=3D/bin/sh. /lava-12302851/=
environment

    2023-12-18T14:09:49.499014  =


    2023-12-18T14:09:49.600495  / # . /lava-12302851/environment/lava-12302=
851/bin/lava-test-runner /lava-12302851/1

    2023-12-18T14:09:49.601577  =


    2023-12-18T14:09:49.618132  / # /lava-12302851/bin/lava-test-runner /la=
va-12302851/1

    2023-12-18T14:09:49.676350  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-18T14:09:49.676882  + cd /lava-1230285<8>[   16.878383] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12302851_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

