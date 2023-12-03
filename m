Return-Path: <stable+bounces-3809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 975E1802690
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 20:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 222A2280DD1
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 19:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA78617989;
	Sun,  3 Dec 2023 19:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="qOHQ4emR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7D6DA
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 11:10:10 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d06d42a58aso14009605ad.0
        for <stable@vger.kernel.org>; Sun, 03 Dec 2023 11:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701630609; x=1702235409; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LaHOlQrRh2G+mdGVLBtCQIeg3wdzOBvuiolfVPo6H+s=;
        b=qOHQ4emR2FgMzYb+OJ2IEwR7xQQe6oR9aqHQZTvzantLKMaHNjMh6F4MIdl2QZCiMv
         zJBL9flgM2lkKcz1Sjb2pRo9k0Wk3/t7U78gHSqRvQmMIs4nai0vV7+Z+muYxz1h82mO
         7SeTM8tdInabHmWaX3pu5UR5vHtZRsMa52f3VV555H92CS30cHhjBXuw6mz0SUUgXMYW
         FL+vNUISCS5lsxgKelpBLwwfMfMT6ZkZw5w+G4JE/qT3grjt4ku9qaq2MmaIyX/Ya1do
         jeG6w1WQIsR/RBTYQ6ejkYVD6BEO5HBupZLVPuL7K0J8GhLfAUn+e8W+sgYWujVKjyKY
         QxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701630609; x=1702235409;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LaHOlQrRh2G+mdGVLBtCQIeg3wdzOBvuiolfVPo6H+s=;
        b=igZrHAPMwoff+7hdRDcXzn+vcJT2vQxfHvIioSGuL46CgGU9m02shdtHuqpZahEXhI
         Vi5WAOkB7bK1ojILnmOw6E/bkImST0f4ACsHpB+zmPNj90V/M8MQ1Rj3DTp44IDiGwgX
         +zBeDcUh3wKZos+/qCMGUoH1foiDhfIjYzR9jiIhDgzhjAvFqevA/rxuRSlW2d9Ou76F
         YxG7Hg6kUXbrcL9xH2wSVYo2yKlq+VLP8D9HkpT7omWzomNrBrct38k+4FV4ei3IrGrG
         lbNes/VKGSRhvwkwoPgnnatoSk463P0Y/jarFqdCspGM+bFnUR0zFFcK1o0/al0ORcqd
         BZcw==
X-Gm-Message-State: AOJu0YxwyPTliQKATz/lKVyjnsKx+FdGbriJDcbyRIZgAhwcW8fTgsmX
	KDuuRQnIGi5toyWkS6zwLU9tKo3DwZ056tyA/7hBJA==
X-Google-Smtp-Source: AGHT+IH4JpA5tLImyuI59CorS2VtM6nId4JZ722dptUUq5hbUR6leHW0cL0VDwD7182/XkbkKVIZgQ==
X-Received: by 2002:a17:902:7485:b0:1cf:a2aa:23ae with SMTP id h5-20020a170902748500b001cfa2aa23aemr3030074pll.35.1701630609277;
        Sun, 03 Dec 2023 11:10:09 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y21-20020a170902ed5500b001d04c097d32sm5381301plb.270.2023.12.03.11.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:10:08 -0800 (PST)
Message-ID: <656cd290.170a0220.17a68.ec14@mx.google.com>
Date: Sun, 03 Dec 2023 11:10:08 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.65-53-gab9d7fb08abaf
Subject: stable-rc/queue/6.1 baseline: 145 runs,
 4 regressions (v6.1.65-53-gab9d7fb08abaf)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 145 runs, 4 regressions (v6.1.65-53-gab9d7fb0=
8abaf)

Regressions Summary
-------------------

platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre  | gcc-10   | defconfig | 1   =
       =

r8a77960-ulcb         | arm64 | lab-collabora | gcc-10   | defconfig | 1   =
       =

sun50i-h6-pine-h64    | arm64 | lab-clabbe    | gcc-10   | defconfig | 1   =
       =

sun50i-h6-pine-h64    | arm64 | lab-collabora | gcc-10   | defconfig | 1   =
       =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.65-53-gab9d7fb08abaf/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.65-53-gab9d7fb08abaf
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      ab9d7fb08abaf2f6455d82c8d98d1e2e16804529 =



Test Regressions
---------------- =



platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre  | gcc-10   | defconfig | 1   =
       =


  Details:     https://kernelci.org/test/plan/id/656ca14f70b643d7d9e1351e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-53=
-gab9d7fb08abaf/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-khad=
as-vim2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-53=
-gab9d7fb08abaf/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-khad=
as-vim2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656ca14f70b643d7d9e13=
51f
        new failure (last pass: v6.1.65-16-g699587b9c4264) =

 =



platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
r8a77960-ulcb         | arm64 | lab-collabora | gcc-10   | defconfig | 1   =
       =


  Details:     https://kernelci.org/test/plan/id/656ca042cacb30c145e134ae

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-53=
-gab9d7fb08abaf/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-53=
-gab9d7fb08abaf/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656ca042cacb30c145e134b3
        failing since 10 days (last pass: v6.1.31-26-gef50524405c2, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-03T15:41:48.682153  / # #

    2023-12-03T15:41:48.784081  export SHELL=3D/bin/sh

    2023-12-03T15:41:48.784672  #

    2023-12-03T15:41:48.885959  / # export SHELL=3D/bin/sh. /lava-12169747/=
environment

    2023-12-03T15:41:48.886669  =


    2023-12-03T15:41:48.988104  / # . /lava-12169747/environment/lava-12169=
747/bin/lava-test-runner /lava-12169747/1

    2023-12-03T15:41:48.989173  =


    2023-12-03T15:41:48.990527  / # /lava-12169747/bin/lava-test-runner /la=
va-12169747/1

    2023-12-03T15:41:49.054642  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-03T15:41:49.055125  + cd /lav<8>[   19.040319] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12169747_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
sun50i-h6-pine-h64    | arm64 | lab-clabbe    | gcc-10   | defconfig | 1   =
       =


  Details:     https://kernelci.org/test/plan/id/656ca0370bbb7a6833e13484

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-53=
-gab9d7fb08abaf/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-53=
-gab9d7fb08abaf/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656ca0370bbb7a6833e13489
        failing since 10 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-03T15:35:14.161632  <8>[   18.089416] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 446390_1.5.2.4.1>
    2023-12-03T15:35:14.266830  / # #
    2023-12-03T15:35:14.368490  export SHELL=3D/bin/sh
    2023-12-03T15:35:14.369114  #
    2023-12-03T15:35:14.470106  / # export SHELL=3D/bin/sh. /lava-446390/en=
vironment
    2023-12-03T15:35:14.470703  =

    2023-12-03T15:35:14.571750  / # . /lava-446390/environment/lava-446390/=
bin/lava-test-runner /lava-446390/1
    2023-12-03T15:35:14.572646  =

    2023-12-03T15:35:14.576814  / # /lava-446390/bin/lava-test-runner /lava=
-446390/1
    2023-12-03T15:35:14.655830  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
sun50i-h6-pine-h64    | arm64 | lab-collabora | gcc-10   | defconfig | 1   =
       =


  Details:     https://kernelci.org/test/plan/id/656ca057e9d24dce0de134b2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-53=
-gab9d7fb08abaf/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-53=
-gab9d7fb08abaf/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656ca057e9d24dce0de134b7
        failing since 10 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-03T15:42:04.450466  / # #

    2023-12-03T15:42:04.552656  export SHELL=3D/bin/sh

    2023-12-03T15:42:04.553407  #

    2023-12-03T15:42:04.654861  / # export SHELL=3D/bin/sh. /lava-12169751/=
environment

    2023-12-03T15:42:04.655579  =


    2023-12-03T15:42:04.757096  / # . /lava-12169751/environment/lava-12169=
751/bin/lava-test-runner /lava-12169751/1

    2023-12-03T15:42:04.758265  =


    2023-12-03T15:42:04.775154  / # /lava-12169751/bin/lava-test-runner /la=
va-12169751/1

    2023-12-03T15:42:04.840952  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-03T15:42:04.841510  + cd /lava-1216975<8>[   19.219611] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12169751_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

