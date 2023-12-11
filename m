Return-Path: <stable+bounces-5223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA1480BE7D
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 01:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 250791F20E38
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 00:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C51623;
	Mon, 11 Dec 2023 00:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ZzgYHSmV"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F762B5
	for <stable@vger.kernel.org>; Sun, 10 Dec 2023 16:29:16 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-5907ded6287so2136806eaf.0
        for <stable@vger.kernel.org>; Sun, 10 Dec 2023 16:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702254555; x=1702859355; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zyuy+oyGYSPem4XDvYF+ghm9jzQNMVCqu0QTaqB2WGE=;
        b=ZzgYHSmVTYb9RFVPS2j90XuBxhk8RZuRmz62bwKR5sWkAhXnnIZr9X2WEBkShNMiKR
         LykKVsOXPyyyBkF27WkyaoudcPxeK3rq2xeWGf7cmGLHWwqvlEAOhz40kw7GuZCP8Sdz
         TCuuBism5XYrTUH1U8MWirsU/aIOFdwbE3Me3LJheNvMdxdE8Cjz40YL7wLwE7FxIMSS
         N7Sa4TRUP93dS1Sv49pi13jTB61t8jEB1PKuOIs2o5wepVpp1FGL6M9Q3EagczMIGXsR
         5GDXxH/pKgDbAQWI2MTfAoLtyXB2UlBK3HSnY6SWjw5nMXpIg9PYMUEP7GdaqjV5KH0J
         01MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702254555; x=1702859355;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zyuy+oyGYSPem4XDvYF+ghm9jzQNMVCqu0QTaqB2WGE=;
        b=LELIbqB8BTuRC/qk4Bh4igEnD+dXIm6c6imLdprKSwBWtXK/MMDgMUXhk4Q6qqER4z
         H4DxkbOmJZBKHh2LvbIon05fj20VFU3SppP0aIubtSEO/GGxVLWWp1k6+5e3+HAl/0VE
         wF+F4+YpEE8JQ5fEYXT4ohNcC95hvFDShET8hlGI7dVhDzwPW/Kr6zZKDQayn1G7jY3B
         MQkCXvk7MnCSnvg8eeqi36i6hIruGMEpJLEL47xn/ws1mjW+PY3fx00q86MfvH+CrDNX
         DLXan39xsG3zFghdYa9nWM6rBubTAyMl+Ap6OdUkd7CyhBpapF6TWFQAs93xzicaVgxW
         Qglg==
X-Gm-Message-State: AOJu0Yz4G0dFfTWLb+xvwS1HHfgc22EpGQjN8jomWKYpnlPDrJ1x0lLA
	IoGRQ+/IsDolPb/6LqtW7ttQOmGJ4YCHdYQbRs+7Mw==
X-Google-Smtp-Source: AGHT+IEweFNMlja9hUmOkfrdI8QsWokK/eozhRl7jGSSh15I3ns+f1C0qEMc1Ui7zc9c8MW1R+rIuQ==
X-Received: by 2002:a05:6358:c8b:b0:170:17eb:b3b with SMTP id o11-20020a0563580c8b00b0017017eb0b3bmr3886112rwj.37.1702254554773;
        Sun, 10 Dec 2023 16:29:14 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 3-20020a630c43000000b005bdbe9a597fsm5017038pgm.57.2023.12.10.16.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 16:29:14 -0800 (PST)
Message-ID: <657657da.630a0220.ed389.d46d@mx.google.com>
Date: Sun, 10 Dec 2023 16:29:14 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.66-149-g27470c1411748
Subject: stable-rc/queue/6.1 baseline: 141 runs,
 4 regressions (v6.1.66-149-g27470c1411748)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 141 runs, 4 regressions (v6.1.66-149-g27470c1=
411748)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
beagle-xm          | arm   | lab-baylibre  | gcc-10   | omap2plus_defconfig=
 | 1          =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
 | 1          =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.66-149-g27470c1411748/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.66-149-g27470c1411748
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      27470c1411748dd9e38423527c8d65c15e597491 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
beagle-xm          | arm   | lab-baylibre  | gcc-10   | omap2plus_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657627a8276ef0f707e134ea

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-14=
9-g27470c1411748/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-14=
9-g27470c1411748/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/657627a8276ef0f707e13=
4eb
        failing since 234 days (last pass: v6.1.22-477-g2128d4458cbc, first=
 fail: v6.1.22-474-gecc61872327e) =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657626ebc86f713438e13484

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-14=
9-g27470c1411748/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-14=
9-g27470c1411748/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657626ebc86f713438e13489
        failing since 18 days (last pass: v6.1.31-26-gef50524405c2, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-10T21:07:39.918359  / # #

    2023-12-10T21:07:40.020168  export SHELL=3D/bin/sh

    2023-12-10T21:07:40.020793  #

    2023-12-10T21:07:40.122025  / # export SHELL=3D/bin/sh. /lava-12237956/=
environment

    2023-12-10T21:07:40.122670  =


    2023-12-10T21:07:40.224008  / # . /lava-12237956/environment/lava-12237=
956/bin/lava-test-runner /lava-12237956/1

    2023-12-10T21:07:40.225021  =


    2023-12-10T21:07:40.226868  / # /lava-12237956/bin/lava-test-runner /la=
va-12237956/1

    2023-12-10T21:07:40.290322  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-10T21:07:40.290822  + cd /lav<8>[   19.083358] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12237956_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/65762826654cfd731be13482

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-14=
9-g27470c1411748/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-14=
9-g27470c1411748/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65762826654cfd731be13487
        failing since 18 days (last pass: v6.1.31-26-gef50524405c2, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-10T21:05:35.935490  <8>[   18.057012] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447469_1.5.2.4.1>
    2023-12-10T21:05:36.040507  / # #
    2023-12-10T21:05:36.142107  export SHELL=3D/bin/sh
    2023-12-10T21:05:36.142687  #
    2023-12-10T21:05:36.243656  / # export SHELL=3D/bin/sh. /lava-447469/en=
vironment
    2023-12-10T21:05:36.244235  =

    2023-12-10T21:05:36.345246  / # . /lava-447469/environment/lava-447469/=
bin/lava-test-runner /lava-447469/1
    2023-12-10T21:05:36.346094  =

    2023-12-10T21:05:36.350722  / # /lava-447469/bin/lava-test-runner /lava=
-447469/1
    2023-12-10T21:05:36.423709  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657626ea500889caa0e13621

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-14=
9-g27470c1411748/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-14=
9-g27470c1411748/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657626ea500889caa0e13626
        failing since 18 days (last pass: v6.1.31-26-gef50524405c2, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-10T21:07:55.003837  / # #

    2023-12-10T21:07:55.106180  export SHELL=3D/bin/sh

    2023-12-10T21:07:55.106923  #

    2023-12-10T21:07:55.208212  / # export SHELL=3D/bin/sh. /lava-12237955/=
environment

    2023-12-10T21:07:55.208992  =


    2023-12-10T21:07:55.310224  / # . /lava-12237955/environment/lava-12237=
955/bin/lava-test-runner /lava-12237955/1

    2023-12-10T21:07:55.311242  =


    2023-12-10T21:07:55.327044  / # /lava-12237955/bin/lava-test-runner /la=
va-12237955/1

    2023-12-10T21:07:55.392733  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-10T21:07:55.393254  + cd /lava-1223795<8>[   19.182875] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12237955_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

