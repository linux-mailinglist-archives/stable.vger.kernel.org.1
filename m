Return-Path: <stable+bounces-5225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3CC80BEA2
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 02:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91FA7280BE6
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 01:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AAD6135;
	Mon, 11 Dec 2023 01:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="s0USf9dn"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F214EB
	for <stable@vger.kernel.org>; Sun, 10 Dec 2023 17:00:16 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3ba04b9b103so675775b6e.0
        for <stable@vger.kernel.org>; Sun, 10 Dec 2023 17:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702256415; x=1702861215; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TCJLabI8TH+xBWNV87kOC6nArcdUn8hJ5f1kgy/kFkk=;
        b=s0USf9dnxFfdOxLni7loAkbkqgthFsm5fH7cY+jpUBSe7HdpSmswmII0WkUIRWbNxX
         rfVfodeDHd8e98/X+p8lTy6Fvmwc1W6YjN9lBfrYHxwivu9L84a3XfRNM0M9wgON3MVP
         vyf0Kq0+TYZ/WKaO/XltVQ83gblwPDJWdck7BZ1c88+hE4vPkuHKnpak7hxr1yGsgQGh
         ltot4ik4y/6PnGIXGzp+vlS609/bz/jS3EZT8a4YLyzlD4pHi9sak5Nx0I1sxd1mfcBF
         AD1kkq/vEuSCTWMUDmpyuWYOGIikUWYU7JnZO5x5g/KPfYf9FgUFVe7dWo/4hO6u/HwR
         ACFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702256415; x=1702861215;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCJLabI8TH+xBWNV87kOC6nArcdUn8hJ5f1kgy/kFkk=;
        b=JkkiVLQWpTwjLIp/x7mSFx8p/bawVPekXT2ley3hxBgjFgabs5hLeHemPKF8uHFgg3
         9tiAaaZp/PtJ5O9RKOtjYRKomPZtrqvMw5JjXGxeTEAQ5J3d3KOvm9zMDPGhE/fStjLL
         DnJ6INcbuSrvsSBkRbQ891qMETRgcaiYX6R2RMjS30kR89NxHnvZftQRPvgK2NHz6y8i
         UTpVKz75dGfiMIoiLVx+undIPVwrjShEWuJ5FWcY5/2IHj8v0v6fpBLbaeT9zLKQhrv2
         4+Hm3gLKCvmVxLzLtuCKXvyE5M3kDak5Je1mg8+bvQptvDYYb35RblPe4jdf5ranIPWX
         dxeg==
X-Gm-Message-State: AOJu0YwkEake50RoC8Lv3XYlR7EArw1frIwmRorZ5UcRN7ihEcUeeKeL
	lfbclsDrisH1pe4QTAxcWzBtjAJOlrRRU8ArzBmomg==
X-Google-Smtp-Source: AGHT+IEg3y+zOR1j0tIu4bmXjkDfp6Eb2haRQd5sV9TK6kWQnhO+4bOQKm+vpYHnTIUhZ+/muIbTpA==
X-Received: by 2002:a05:6808:1d5:b0:3b9:e43f:51de with SMTP id x21-20020a05680801d500b003b9e43f51demr4262729oic.117.1702256415336;
        Sun, 10 Dec 2023 17:00:15 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u42-20020a056a0009aa00b006ce7ad8c14esm5087924pfg.164.2023.12.10.17.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 17:00:14 -0800 (PST)
Message-ID: <65765f1e.050a0220.d5d33.e1fb@mx.google.com>
Date: Sun, 10 Dec 2023 17:00:14 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.142-112-g6fca85622af22
Subject: stable-rc/queue/5.15 baseline: 92 runs,
 4 regressions (v5.15.142-112-g6fca85622af22)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 92 runs, 4 regressions (v5.15.142-112-g6fca8=
5622af22)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
panda              | arm   | lab-baylibre  | gcc-10   | multi_v7_defconfig =
| 1          =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
| 1          =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
| 1          =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
| 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.142-112-g6fca85622af22/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.142-112-g6fca85622af22
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      6fca85622af224ed8a3158fffeed4bdcabd75f52 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
panda              | arm   | lab-baylibre  | gcc-10   | multi_v7_defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/65762d0b6d2024e212e134a8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-112-g6fca85622af22/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pan=
da.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-112-g6fca85622af22/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pan=
da.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65762d0b6d2024e212e134ad
        failing since 4 days (last pass: v5.15.74-135-g19e8e8e20e2b, first =
fail: v5.15.141-64-g41591b7f348c5)

    2023-12-10T21:26:13.145050  <8>[   11.625427] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3873802_1.5.2.4.1>
    2023-12-10T21:26:13.252630  / # #
    2023-12-10T21:26:13.354138  export SHELL=3D/bin/sh
    2023-12-10T21:26:13.354600  #
    2023-12-10T21:26:13.455586  / # export SHELL=3D/bin/sh. /lava-3873802/e=
nvironment
    2023-12-10T21:26:13.456097  =

    2023-12-10T21:26:13.557116  / # . /lava-3873802/environment/lava-387380=
2/bin/lava-test-runner /lava-3873802/1
    2023-12-10T21:26:13.557935  =

    2023-12-10T21:26:13.562950  / # /lava-3873802/bin/lava-test-runner /lav=
a-3873802/1
    2023-12-10T21:26:13.617270  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
| 1          =


  Details:     https://kernelci.org/test/plan/id/65762dcaa0a1d4e0b3e13476

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-112-g6fca85622af22/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-112-g6fca85622af22/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65762dcba0a1d4e0b3e1347b
        failing since 18 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-10T21:37:14.777953  / # #

    2023-12-10T21:37:14.880118  export SHELL=3D/bin/sh

    2023-12-10T21:37:14.880888  #

    2023-12-10T21:37:14.982297  / # export SHELL=3D/bin/sh. /lava-12238153/=
environment

    2023-12-10T21:37:14.983014  =


    2023-12-10T21:37:15.084435  / # . /lava-12238153/environment/lava-12238=
153/bin/lava-test-runner /lava-12238153/1

    2023-12-10T21:37:15.085502  =


    2023-12-10T21:37:15.101947  / # /lava-12238153/bin/lava-test-runner /la=
va-12238153/1

    2023-12-10T21:37:15.151881  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-10T21:37:15.152434  + cd /lav<8>[   16.039708] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12238153_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
| 1          =


  Details:     https://kernelci.org/test/plan/id/65762ddaa0a1d4e0b3e1350b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-112-g6fca85622af22/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-112-g6fca85622af22/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65762ddaa0a1d4e0b3e13510
        failing since 18 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-10T21:29:53.024287  <8>[   16.050452] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447479_1.5.2.4.1>
    2023-12-10T21:29:53.129305  / # #
    2023-12-10T21:29:53.230971  export SHELL=3D/bin/sh
    2023-12-10T21:29:53.231559  #
    2023-12-10T21:29:53.332581  / # export SHELL=3D/bin/sh. /lava-447479/en=
vironment
    2023-12-10T21:29:53.333183  =

    2023-12-10T21:29:53.434195  / # . /lava-447479/environment/lava-447479/=
bin/lava-test-runner /lava-447479/1
    2023-12-10T21:29:53.435107  =

    2023-12-10T21:29:53.439519  / # /lava-447479/bin/lava-test-runner /lava=
-447479/1
    2023-12-10T21:29:53.471492  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
| 1          =


  Details:     https://kernelci.org/test/plan/id/65762de09e294f32aee13490

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-112-g6fca85622af22/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-112-g6fca85622af22/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65762de09e294f32aee13495
        failing since 18 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-10T21:37:26.331759  / # #

    2023-12-10T21:37:26.434225  export SHELL=3D/bin/sh

    2023-12-10T21:37:26.434927  #

    2023-12-10T21:37:26.536407  / # export SHELL=3D/bin/sh. /lava-12238158/=
environment

    2023-12-10T21:37:26.537150  =


    2023-12-10T21:37:26.638674  / # . /lava-12238158/environment/lava-12238=
158/bin/lava-test-runner /lava-12238158/1

    2023-12-10T21:37:26.639794  =


    2023-12-10T21:37:26.656827  / # /lava-12238158/bin/lava-test-runner /la=
va-12238158/1

    2023-12-10T21:37:26.715673  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-10T21:37:26.716173  + cd /lava-1223815<8>[   16.842469] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12238158_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

