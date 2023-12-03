Return-Path: <stable+bounces-3800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A187802605
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 18:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6DE1F20FAB
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 17:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17879171D3;
	Sun,  3 Dec 2023 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="w1brsoSo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DD9D3
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 09:42:05 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5c629a9fe79so900185a12.3
        for <stable@vger.kernel.org>; Sun, 03 Dec 2023 09:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701625324; x=1702230124; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gUUcTdaOz7iy1bKgXCm4/9TZ+PjR0RZag/XNZRuXSA8=;
        b=w1brsoSoqAd+08P3RVX6dSA2Omk5FldbqKcscsERBkv0zCipu2qbq6eQmEJPXyVCCA
         Oz4ieqOHBWoXI4iAYt9TI5x5zvD0m6HEHyfXyzYRhSyAPoAigswtrrsSY9cpq9ErCXKh
         PaHzWu1oFbvPXTbsZSncHZWmzI5vYGcckh8Wb42qB4hzLmQ00l0Hv4BIJUrERYHdyAZj
         18+Pw1MBqhDykye95TIzRPSnnYATaZc4BGfOx4/IpGQaaUdSbESg9R+qHpjLaHG/Imub
         4px0kgT24yVb+MCPZ08ZSu9cpyVXRjVclUzw4CGo+XS7pSTfIK7pCeY+B5QbGSXue0Y6
         TfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701625324; x=1702230124;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gUUcTdaOz7iy1bKgXCm4/9TZ+PjR0RZag/XNZRuXSA8=;
        b=uGYT36xxyiAgiqTkRZhT1Tocn51NFN3kTtt329FP1v5KswZNYk+l+it6aC4NDoLliV
         Mo2z0Ws8XzUya8B2UZR1dnYfRsEw2fDXmdj+Gi1w2ZbwwFEeFdtYW4GTWVDg82ntEiTM
         OBCzsTH1s+Gux13DRSpP4NI/LpNTJooewVkFijEv2xnMhl2h7ScNRv3NJoTP7gei1Ti4
         P3ffxQUhId4kDdELg0gCJo32VI/mEfJETWHvSstC4pRNCRGyypwYM8p+tU8VASFf3eGe
         9xiVvgVYr1NbE97xyZLMHeok18yEP46zG/m6mwyP3YTjeQhYAtaO3P6e0/1eAb6guKSD
         g7SA==
X-Gm-Message-State: AOJu0YydAKwF7Eb9Nq188775JvDIFZ+sj0mdWhWn6bN7EQ9HnRSTX2X6
	/qZyf6CiUaazD73F5sXCgy5qoDQdeC0pHCv4UwYZIw==
X-Google-Smtp-Source: AGHT+IEa+UupuioYyNmG6HBWcMVOsOh7fI5cHU92nlv/gghIdZR7EceOLZYNxZtn/s20TAMXBqLRHw==
X-Received: by 2002:a05:6a21:3409:b0:18f:97c:9293 with SMTP id yn9-20020a056a21340900b0018f097c9293mr729431pzb.120.1701625323994;
        Sun, 03 Dec 2023 09:42:03 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b001bc676df6a9sm6890957plg.132.2023.12.03.09.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 09:42:03 -0800 (PST)
Message-ID: <656cbdeb.170a0220.3fde0.27d3@mx.google.com>
Date: Sun, 03 Dec 2023 09:42:03 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.65-16-g699587b9c4264
Subject: stable-rc/queue/6.1 baseline: 142 runs,
 4 regressions (v6.1.65-16-g699587b9c4264)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 142 runs, 4 regressions (v6.1.65-16-g699587b9=
c4264)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =

r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =

sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
                  | 1          =

sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.65-16-g699587b9c4264/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.65-16-g699587b9c4264
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      699587b9c4264f3a3428b0fea666b65ba7d2efa9 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/656c8b1acaf4eb81dce13477

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-16=
-g699587b9c4264/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-16=
-g699587b9c4264/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656c8b1acaf4eb81dce13=
478
        new failure (last pass: v6.1.64-82-g8d1d7f9dd3868) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656c87f3346238f237e134ac

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-16=
-g699587b9c4264/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-16=
-g699587b9c4264/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656c87f3346238f237e134b1
        failing since 10 days (last pass: v6.1.31-26-gef50524405c2, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-03T13:58:00.114072  / # #

    2023-12-03T13:58:00.216441  export SHELL=3D/bin/sh

    2023-12-03T13:58:00.217160  #

    2023-12-03T13:58:00.318564  / # export SHELL=3D/bin/sh. /lava-12168258/=
environment

    2023-12-03T13:58:00.319274  =


    2023-12-03T13:58:00.420714  / # . /lava-12168258/environment/lava-12168=
258/bin/lava-test-runner /lava-12168258/1

    2023-12-03T13:58:00.421760  =


    2023-12-03T13:58:00.465734  / # /lava-12168258/bin/lava-test-runner /la=
va-12168258/1

    2023-12-03T13:58:00.487129  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-03T13:58:00.487627  + cd /lav<8>[   19.110093] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12168258_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656c87d5427108dc20e13481

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-16=
-g699587b9c4264/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-16=
-g699587b9c4264/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656c87d5427108dc20e13486
        failing since 10 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-03T13:51:11.712980  <8>[   18.026548] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 446363_1.5.2.4.1>
    2023-12-03T13:51:11.818019  / # #
    2023-12-03T13:51:11.919631  export SHELL=3D/bin/sh
    2023-12-03T13:51:11.920229  #
    2023-12-03T13:51:12.021218  / # export SHELL=3D/bin/sh. /lava-446363/en=
vironment
    2023-12-03T13:51:12.021898  =

    2023-12-03T13:51:12.122915  / # . /lava-446363/environment/lava-446363/=
bin/lava-test-runner /lava-446363/1
    2023-12-03T13:51:12.123781  =

    2023-12-03T13:51:12.128157  / # /lava-446363/bin/lava-test-runner /lava=
-446363/1
    2023-12-03T13:51:12.207303  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656c87f4ac3e09b3ace134a5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-16=
-g699587b9c4264/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-16=
-g699587b9c4264/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656c87f4ac3e09b3ace134aa
        failing since 10 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-03T13:58:11.028443  / # #

    2023-12-03T13:58:11.130540  export SHELL=3D/bin/sh

    2023-12-03T13:58:11.131258  #

    2023-12-03T13:58:11.232624  / # export SHELL=3D/bin/sh. /lava-12168259/=
environment

    2023-12-03T13:58:11.233350  =


    2023-12-03T13:58:11.334729  / # . /lava-12168259/environment/lava-12168=
259/bin/lava-test-runner /lava-12168259/1

    2023-12-03T13:58:11.335838  =


    2023-12-03T13:58:11.352431  / # /lava-12168259/bin/lava-test-runner /la=
va-12168259/1

    2023-12-03T13:58:11.418485  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-03T13:58:11.418998  + cd /lava-1216825<8>[   19.258088] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12168259_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

