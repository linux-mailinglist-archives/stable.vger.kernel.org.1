Return-Path: <stable+bounces-8448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACD581DF50
	for <lists+stable@lfdr.de>; Mon, 25 Dec 2023 09:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B88FB210F4
	for <lists+stable@lfdr.de>; Mon, 25 Dec 2023 08:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF1220F7;
	Mon, 25 Dec 2023 08:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Hzqh9mdH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C791C14
	for <stable@vger.kernel.org>; Mon, 25 Dec 2023 08:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d2e6e14865so18431995ad.0
        for <stable@vger.kernel.org>; Mon, 25 Dec 2023 00:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703494257; x=1704099057; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jyAObfqCJenK56wjJhBAQBr/4xVtCB3a84Q3prBlYws=;
        b=Hzqh9mdHZ8NsdbZ4o1AtRHL4Iw9JZa7g93vDgH97KtXflp4tcfvIgGss3SuPTVSKK0
         ohSU89ipQs/rC5tpkWZktqHj4WEXAzvT/dyS4OxdurN6Safwdq7c1kf6KfW5vAM0yj3f
         DBe+hXD3VSvPppCOysTeR/wHgqGGo4tYQIMub1+3+qhyypUug/UIdBbxWxOEI3MAI9Nw
         hlGwiXM7zL4+Gj+UIhLEECIXP5Akgl5c6+geU3cKE3RQD6rkW13XUjw20abJJ+cK5Jxa
         ezkDjlImFbGClajj5BbRkKv/b0TtnLPx1W0K7l9niT776bpHGjU2u1gTeV/gfrVrRlfJ
         266w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703494257; x=1704099057;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jyAObfqCJenK56wjJhBAQBr/4xVtCB3a84Q3prBlYws=;
        b=GjTVBYHKcm/dzmqbVND1keacHYvtGWYmP7I6HG9jedkGSOiLb0DrPgZhG/tptOn12a
         MlFvxXkJN/cw2n0G5TzElr4D7InQx5KzAkI9X+2UdI9j1M4YR0btBOJWrWvZvjQeZ5ii
         bAQPY3P0QoyeLlNaKhxft5ofLye8dYH2blTHM5V1BEUJI6SS41n+aT+K1IbPZXJHAStt
         c7W8li5ef8ptZgQvP4EkbnjD06ax1QXLXIGygiLnDkbjBMErE2NY8WE7CiDNqkx1QF55
         vx4vNCLSj20Y23jt6bRNlLLJ5Pez3PYabgmtJz3N0DkmuNY3i8nx7yRd2zKvWENRwD9O
         FgTg==
X-Gm-Message-State: AOJu0YxgeXaMyIQy+DJ6vYB1XOsjUDIlOFgZrQ2gPki3wsuuDPEBg/Rp
	ZlWKDNMy1dYtxe5eGc96wbwA+uOBmG7DkpvomxSQcNqzkyI=
X-Google-Smtp-Source: AGHT+IFRnz1XeheNAe84QeXTCCs3xA/CTHq9ciN9GzP+6VKGcZ485i8KaFyYSLUvZgj7HOgDcbF8tQ==
X-Received: by 2002:a17:902:6947:b0:1d0:8db6:17d0 with SMTP id k7-20020a170902694700b001d08db617d0mr2017327plt.25.1703494256828;
        Mon, 25 Dec 2023 00:50:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g1-20020a170902fe0100b001d36df58ba2sm7720671plj.308.2023.12.25.00.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 00:50:56 -0800 (PST)
Message-ID: <65894270.170a0220.3bcd1.428c@mx.google.com>
Date: Mon, 25 Dec 2023 00:50:56 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.204-92-g6d473b4ebbfa1
Subject: stable-rc/queue/5.10 baseline: 100 runs,
 7 regressions (v5.10.204-92-g6d473b4ebbfa1)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 100 runs, 7 regressions (v5.10.204-92-g6d473=
b4ebbfa1)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
beaglebone-black   | arm   | lab-broonie   | gcc-10   | omap2plus_defconfig=
        | 1          =

juno-uboot         | arm64 | lab-broonie   | gcc-10   | defconfig          =
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
nel/v5.10.204-92-g6d473b4ebbfa1/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.204-92-g6d473b4ebbfa1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      6d473b4ebbfa146bcb84fb8695675526dde5af82 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
beaglebone-black   | arm   | lab-broonie   | gcc-10   | omap2plus_defconfig=
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65891099af754cdc1de134a2

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-92-g6d473b4ebbfa1/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-92-g6d473b4ebbfa1/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65891099af754cdc1de134d9
        failing since 314 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-12-25T05:18:01.931094  <8>[   20.407278] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 393941_1.5.2.4.1>
    2023-12-25T05:18:02.039890  / # #
    2023-12-25T05:18:02.141638  export SHELL=3D/bin/sh
    2023-12-25T05:18:02.142121  #
    2023-12-25T05:18:02.243403  / # export SHELL=3D/bin/sh. /lava-393941/en=
vironment
    2023-12-25T05:18:02.243943  =

    2023-12-25T05:18:02.345283  / # . /lava-393941/environment/lava-393941/=
bin/lava-test-runner /lava-393941/1
    2023-12-25T05:18:02.345980  =

    2023-12-25T05:18:02.350529  / # /lava-393941/bin/lava-test-runner /lava=
-393941/1
    2023-12-25T05:18:02.454334  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
juno-uboot         | arm64 | lab-broonie   | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65890ffc1247747045e134f2

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-92-g6d473b4ebbfa1/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.t=
xt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-92-g6d473b4ebbfa1/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65890ffc1247747045e13531
        failing since 0 day (last pass: v5.10.204-83-gffa73e802298, first f=
ail: v5.10.204-87-ge476129b1875a)

    2023-12-25T05:15:13.134982  / # #
    2023-12-25T05:15:13.237844  export SHELL=3D/bin/sh
    2023-12-25T05:15:13.239058  #
    2023-12-25T05:15:13.341470  / # export SHELL=3D/bin/sh. /lava-393931/en=
vironment
    2023-12-25T05:15:13.342380  =

    2023-12-25T05:15:13.444558  / # . /lava-393931/environment/lava-393931/=
bin/lava-test-runner /lava-393931/1
    2023-12-25T05:15:13.445925  =

    2023-12-25T05:15:13.458675  / # /lava-393931/bin/lava-test-runner /lava=
-393931/1
    2023-12-25T05:15:13.519636  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-25T05:15:13.520183  + cd /lava-393931/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/658936f9e13c9322ffe13475

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-92-g6d473b4ebbfa1/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-92-g6d473b4ebbfa1/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/658936f9e13c9322ffe1347e
        failing since 32 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-25T08:09:13.886658  / # #

    2023-12-25T08:09:13.988958  export SHELL=3D/bin/sh

    2023-12-25T08:09:13.989693  #

    2023-12-25T08:09:14.091057  / # export SHELL=3D/bin/sh. /lava-12378918/=
environment

    2023-12-25T08:09:14.091779  =


    2023-12-25T08:09:14.193271  / # . /lava-12378918/environment/lava-12378=
918/bin/lava-test-runner /lava-12378918/1

    2023-12-25T08:09:14.194415  =


    2023-12-25T08:09:14.210788  / # /lava-12378918/bin/lava-test-runner /la=
va-12378918/1

    2023-12-25T08:09:14.260440  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-25T08:09:14.260953  + cd /lav<8>[   16.450865] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12378918_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
rk3399-gru-kevin   | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chr=
omebook | 2          =


  Details:     https://kernelci.org/test/plan/id/65890f8e91eb132375e13475

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-92-g6d473b4ebbfa1/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-92-g6d473b4ebbfa1/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/65890f8e91eb132375e1347f
        failing since 286 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-25T05:14:06.305137  <8>[   33.940887] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-12-25T05:14:07.329745  /lava-12378901/1/../bin/lava-test-case

    2023-12-25T05:14:07.340659  <8>[   34.977829] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/65890f8e91eb132375e13480
        failing since 286 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-25T05:14:06.293039  /lava-12378901/1/../bin/lava-test-case
   =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65890f6676042806dbe134f6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-92-g6d473b4ebbfa1/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-92-g6d473b4ebbfa1/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65890f6676042806dbe134ff
        failing since 32 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-25T05:13:01.374429  <8>[   16.985607] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 449865_1.5.2.4.1>
    2023-12-25T05:13:01.479412  / # #
    2023-12-25T05:13:01.581021  export SHELL=3D/bin/sh
    2023-12-25T05:13:01.581610  #
    2023-12-25T05:13:01.682614  / # export SHELL=3D/bin/sh. /lava-449865/en=
vironment
    2023-12-25T05:13:01.683216  =

    2023-12-25T05:13:01.784229  / # . /lava-449865/environment/lava-449865/=
bin/lava-test-runner /lava-449865/1
    2023-12-25T05:13:01.785096  =

    2023-12-25T05:13:01.789840  / # /lava-449865/bin/lava-test-runner /lava=
-449865/1
    2023-12-25T05:13:01.855852  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65890f6bf22f628f6ce134c8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-92-g6d473b4ebbfa1/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-92-g6d473b4ebbfa1/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65890f6bf22f628f6ce134d1
        failing since 32 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-25T05:20:44.157480  / # #

    2023-12-25T05:20:44.259686  export SHELL=3D/bin/sh

    2023-12-25T05:20:44.260438  #

    2023-12-25T05:20:44.361817  / # export SHELL=3D/bin/sh. /lava-12378924/=
environment

    2023-12-25T05:20:44.362814  =


    2023-12-25T05:20:44.464370  / # . /lava-12378924/environment/lava-12378=
924/bin/lava-test-runner /lava-12378924/1

    2023-12-25T05:20:44.465535  =


    2023-12-25T05:20:44.481446  / # /lava-12378924/bin/lava-test-runner /la=
va-12378924/1

    2023-12-25T05:20:44.524900  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-25T05:20:44.540668  + cd /lava-1237892<8>[   18.262945] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12378924_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

