Return-Path: <stable+bounces-3815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE4480272F
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 21:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70F411C208F8
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 20:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B920818B0C;
	Sun,  3 Dec 2023 20:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="exOHda1K"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DEAC0
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 12:10:41 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-58ce8513da1so2666485eaf.2
        for <stable@vger.kernel.org>; Sun, 03 Dec 2023 12:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701634241; x=1702239041; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XD2E6bXYb7J1mG0LHbsQ5S7Uo691ejmPU1PYdkrSHR4=;
        b=exOHda1Kd878jToyhO1M1NhXkHiYKLXSBC0aZuodyt0Yind8UfHr2HJGB/yRcsyHoc
         RMf+3ralkA8/OwEt/DHeRZzqBC+VCdGlV/zJK/8aWaFf7ZsZroRXsEgGsof2wffhGR6U
         yQ6pc2lpbVp7YR11kx1KcopUvO1tXgPappkysf4rI7FYeN9yhiQr48VD19qGqZaNgl2W
         oiZecLKcpfCnAktQt85AbwespmdOCkzrpERehGTPMo4qD8HAfxQa/vSkTmgiAyFeG9vQ
         FeKhx8P+7phr0TFKWHj333Z3qsNyRdxyTTIegQqHahEXGGOcLy0AijqCDVl6gKmaJrXn
         ZWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701634241; x=1702239041;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XD2E6bXYb7J1mG0LHbsQ5S7Uo691ejmPU1PYdkrSHR4=;
        b=L71sdOPSo8wkAbKAi8DMr0oWVYjnacPivwFuNg/aHkBJqKT3XdWITx8Ixh1bho1vTP
         +JU0j6ln4uOhYoh22N2WJPkeCPe/8hXqdzNxmg7Sb8GKIIuzREMzKVnQzriTM1eYysnz
         IfeZKWLvUVPTnTXkbkvsgShb2HlDS2J9+4HGVqUwOGl4zpa6rPbVyu2C6CtvI/TDAPKu
         0H7AIeoy06P+swh9pGC20EAByK7tLJo53p7HFlxeH9qcfS9FGjsZH43KyLyZdfiRQeir
         u7QxJkvLnxbbTb2JThD5y0MUDEHfy7nzHPW8G/UmWAUkdUNY/86M2qi1xCwE/XPagEvS
         teFw==
X-Gm-Message-State: AOJu0YwXQrAnnUuuJQzebt+pJT2aQrwlSznYFi2IYh486LKGXibl/Kw5
	wE7Id/g8RXnLpQtqhzaJit8lnjd95Z9Nv6WBst+0LQ==
X-Google-Smtp-Source: AGHT+IGuPGN9cbGsYW0yT94UczrU7kmMQ2JZdssSdqfvnz9iqVlSmkCi29emqF32kqR7JbTRlKF3Bg==
X-Received: by 2002:a05:6358:7f0b:b0:16d:fc4d:9fe5 with SMTP id p11-20020a0563587f0b00b0016dfc4d9fe5mr3266595rwn.3.1701634240628;
        Sun, 03 Dec 2023 12:10:40 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s21-20020a62e715000000b006bb5ff51177sm2757946pfh.194.2023.12.03.12.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 12:10:40 -0800 (PST)
Message-ID: <656ce0c0.620a0220.4276d.554c@mx.google.com>
Date: Sun, 03 Dec 2023 12:10:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.202-89-g101afac3a6283
Subject: stable-rc/linux-5.10.y baseline: 144 runs,
 4 regressions (v5.10.202-89-g101afac3a6283)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-5.10.y baseline: 144 runs, 4 regressions (v5.10.202-89-g101=
afac3a6283)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
         | regressions
-------------------+--------+---------------+----------+-------------------=
---------+------------
juno-uboot         | arm64  | lab-broonie   | gcc-10   | defconfig         =
         | 1          =

qemu_x86_64        | x86_64 | lab-baylibre  | gcc-10   | x86_64_defconfig+x=
86-board | 1          =

sun50i-h6-pine-h64 | arm64  | lab-clabbe    | gcc-10   | defconfig         =
         | 1          =

sun50i-h6-pine-h64 | arm64  | lab-collabora | gcc-10   | defconfig         =
         | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.202-89-g101afac3a6283/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.202-89-g101afac3a6283
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      101afac3a62836f4295abf27f5add57c4acd1190 =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
         | regressions
-------------------+--------+---------------+----------+-------------------=
---------+------------
juno-uboot         | arm64  | lab-broonie   | gcc-10   | defconfig         =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/656cafd76720b8019ae13558

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02-89-g101afac3a6283/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02-89-g101afac3a6283/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656cafd76720b8019ae13591
        failing since 4 days (last pass: v5.10.201-185-ga30cecbc89f2f, firs=
t fail: v5.10.202)

    2023-12-03T16:41:33.877348  / # #
    2023-12-03T16:41:33.980239  export SHELL=3D/bin/sh
    2023-12-03T16:41:33.981028  #
    2023-12-03T16:41:34.083049  / # export SHELL=3D/bin/sh. /lava-302482/en=
vironment
    2023-12-03T16:41:34.083872  =

    2023-12-03T16:41:34.185945  / # . /lava-302482/environment/lava-302482/=
bin/lava-test-runner /lava-302482/1
    2023-12-03T16:41:34.187350  =

    2023-12-03T16:41:34.201410  / # /lava-302482/bin/lava-test-runner /lava=
-302482/1
    2023-12-03T16:41:34.260256  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-03T16:41:34.260803  + cd /lava-302482/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform           | arch   | lab           | compiler | defconfig         =
         | regressions
-------------------+--------+---------------+----------+-------------------=
---------+------------
qemu_x86_64        | x86_64 | lab-baylibre  | gcc-10   | x86_64_defconfig+x=
86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/656cadba893653b26fe134a0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02-89-g101afac3a6283/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-baylibre/=
baseline-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02-89-g101afac3a6283/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-baylibre/=
baseline-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656cadba893653b26fe13=
4a1
        new failure (last pass: v5.10.202) =

 =



platform           | arch   | lab           | compiler | defconfig         =
         | regressions
-------------------+--------+---------------+----------+-------------------=
---------+------------
sun50i-h6-pine-h64 | arm64  | lab-clabbe    | gcc-10   | defconfig         =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/656cade4835e0ffb97e134b1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02-89-g101afac3a6283/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02-89-g101afac3a6283/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656cade4835e0ffb97e134b6
        failing since 53 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-12-03T16:33:32.695405  <8>[   16.986126] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 446408_1.5.2.4.1>
    2023-12-03T16:33:32.800494  / # #
    2023-12-03T16:33:32.902153  export SHELL=3D/bin/sh
    2023-12-03T16:33:32.902813  #
    2023-12-03T16:33:33.003829  / # export SHELL=3D/bin/sh. /lava-446408/en=
vironment
    2023-12-03T16:33:33.004436  =

    2023-12-03T16:33:33.105491  / # . /lava-446408/environment/lava-446408/=
bin/lava-test-runner /lava-446408/1
    2023-12-03T16:33:33.106427  =

    2023-12-03T16:33:33.110646  / # /lava-446408/bin/lava-test-runner /lava=
-446408/1
    2023-12-03T16:33:33.177804  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch   | lab           | compiler | defconfig         =
         | regressions
-------------------+--------+---------------+----------+-------------------=
---------+------------
sun50i-h6-pine-h64 | arm64  | lab-collabora | gcc-10   | defconfig         =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/656cadf3835e0ffb97e134f8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02-89-g101afac3a6283/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02-89-g101afac3a6283/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656cadf3835e0ffb97e134fd
        failing since 53 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-12-03T16:40:08.647961  / # #

    2023-12-03T16:40:08.748576  export SHELL=3D/bin/sh

    2023-12-03T16:40:08.748705  #

    2023-12-03T16:40:08.849209  / # export SHELL=3D/bin/sh. /lava-12170939/=
environment

    2023-12-03T16:40:08.849415  =


    2023-12-03T16:40:08.950266  / # . /lava-12170939/environment/lava-12170=
939/bin/lava-test-runner /lava-12170939/1

    2023-12-03T16:40:08.951331  =


    2023-12-03T16:40:08.961519  / # /lava-12170939/bin/lava-test-runner /la=
va-12170939/1

    2023-12-03T16:40:09.023554  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-03T16:40:09.024043  + cd /lava-1217093<8>[   18.074157] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12170939_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

