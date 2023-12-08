Return-Path: <stable+bounces-5057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DE380AD27
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 20:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C612B20AF3
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 19:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E774CB4D;
	Fri,  8 Dec 2023 19:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="T3JW3p4M"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735791720
	for <stable@vger.kernel.org>; Fri,  8 Dec 2023 11:36:47 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5c2066accc5so1783450a12.3
        for <stable@vger.kernel.org>; Fri, 08 Dec 2023 11:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702064206; x=1702669006; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XEl9Rfvp4IwwknyEkWsjIEummespwdrsG0Fe3V2XUjU=;
        b=T3JW3p4M47lupA1+XUeXQyJxdHsic4r9tD8a3WQXZqwQ2fTGZHo+l6f9gHRmiN+OwJ
         ATEFFAjKc4Dv7Cglxq6m9PcUEo3GdZy9uAlOo6XhTo+Qo19aqCR9GdauJ+YY618SJoaz
         l7FTmP2SHedNlFicrLWKQMr2zZayu1kfVEFTOR9c4Os0xAPMpoVfWZDlz/LhU1XyMkvF
         OEWMSisS0h/scd65Ui3J6g2dG/gb4JK59M/PNSeF5eohw7NRwcbjh7G9or75NjFV6S8y
         KV35u/fAJRlSs46CMh2LKapYqtJoQkhAPso19IgTOppcNcwimsdPzNTxArFJxkV+O1Jj
         ojnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702064206; x=1702669006;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XEl9Rfvp4IwwknyEkWsjIEummespwdrsG0Fe3V2XUjU=;
        b=t1KhwAoQdTw//c8MIGoHBB/m+SGkC2rinkSjUU1fWwLlqiuUEEVSxFt3O0cwlt8Bfc
         +EZDEI6u7h81ibC+xSrog7uxL78YoZv8q7nmKxkASugezq+kdGGKkXn533TCo9KERQW+
         kKbz471C8fX1l7q4Xlf3cSahPoXCNGd9LmAuZ7jYkYLWNiTtKgWgUCDHakw4DRSkS4hA
         X+yNq+s2VpaHdzodQeeb+wiAcl4kVWBv9UNaPeMvrGl+Cfn23NjuDw+6TYvfNvM+NZGN
         MuIb3hbYM9z1mS+uB+DhXVjEDpX93WBxcdAfsMXXYGgXm221NDnJJBry0cuh17tgbOxW
         9uaQ==
X-Gm-Message-State: AOJu0Yy7so4+xsOGTt7vFp3EQjPdr6Rpm8Ktl7uEblWyOOFp3x5ABZEP
	MrVcOmtXJF76+LF5DdKa+FVVdC6/ncBKjIglQHFt+w==
X-Google-Smtp-Source: AGHT+IHkghYnHS3rJiAXK/Ffl51w8PTB+KSqRfFiVwDRvyqORi5wiMrKSBhRHwrySaDBpcs0LBqnUA==
X-Received: by 2002:a05:6a20:1586:b0:190:53c1:fed1 with SMTP id h6-20020a056a20158600b0019053c1fed1mr690813pzj.40.1702064206497;
        Fri, 08 Dec 2023 11:36:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s7-20020a63f047000000b005c67dd98b15sm1938822pgj.74.2023.12.08.11.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 11:36:45 -0800 (PST)
Message-ID: <6573704d.630a0220.b7870.6c55@mx.google.com>
Date: Fri, 08 Dec 2023 11:36:45 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.301
Subject: stable-rc/linux-4.19.y baseline: 135 runs, 5 regressions (v4.19.301)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-4.19.y baseline: 135 runs, 5 regressions (v4.19.301)

Regressions Summary
-------------------

platform             | arch  | lab             | compiler | defconfig      =
    | regressions
---------------------+-------+-----------------+----------+----------------=
----+------------
at91sam9g20ek        | arm   | lab-broonie     | gcc-10   | multi_v5_defcon=
fig | 1          =

imx6dl-riotboard     | arm   | lab-pengutronix | gcc-10   | multi_v7_defcon=
fig | 1          =

meson-gxbb-p200      | arm64 | lab-baylibre    | gcc-10   | defconfig      =
    | 1          =

meson-gxl-s905d-p230 | arm64 | lab-baylibre    | gcc-10   | defconfig      =
    | 1          =

meson-gxm-q200       | arm64 | lab-baylibre    | gcc-10   | defconfig      =
    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.19.y/ker=
nel/v4.19.301/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.301
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      3e205b99cc35777195fea391cdfe25bd537589b3 =



Test Regressions
---------------- =



platform             | arch  | lab             | compiler | defconfig      =
    | regressions
---------------------+-------+-----------------+----------+----------------=
----+------------
at91sam9g20ek        | arm   | lab-broonie     | gcc-10   | multi_v5_defcon=
fig | 1          =


  Details:     https://kernelci.org/test/plan/id/65733e2a5915dfb67ce134a4

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
01/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
01/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65733e2a5915dfb67ce134da
        failing since 10 days (last pass: v4.19.299-93-g263cae4d5493f, firs=
t fail: v4.19.299-93-gc66845304b463)

    2023-12-08T16:02:13.168259  + set +x
    2023-12-08T16:02:13.168789  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 326354_1.5.2=
.4.1>
    2023-12-08T16:02:13.282270  / # #
    2023-12-08T16:02:13.385186  export SHELL=3D/bin/sh
    2023-12-08T16:02:13.385954  #
    2023-12-08T16:02:13.487954  / # export SHELL=3D/bin/sh. /lava-326354/en=
vironment
    2023-12-08T16:02:13.488718  =

    2023-12-08T16:02:13.590725  / # . /lava-326354/environment/lava-326354/=
bin/lava-test-runner /lava-326354/1
    2023-12-08T16:02:13.592031  =

    2023-12-08T16:02:13.595736  / # /lava-326354/bin/lava-test-runner /lava=
-326354/1 =

    ... (12 line(s) more)  =

 =



platform             | arch  | lab             | compiler | defconfig      =
    | regressions
---------------------+-------+-----------------+----------+----------------=
----+------------
imx6dl-riotboard     | arm   | lab-pengutronix | gcc-10   | multi_v7_defcon=
fig | 1          =


  Details:     https://kernelci.org/test/plan/id/65733f4cea5d0fe7b4e13477

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
01/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6dl-riotboard.=
txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
01/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6dl-riotboard.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/65733f4cea5d0fe=
7b4e1347a
        new failure (last pass: v4.19.300-64-g58069964f7ae)
        15 lines

    2023-12-08T16:07:25.061290  kern  :emerg : Internal error: Oops - undef=
ined instruction: 0 [#1] SMP ARM
    2023-12-08T16:07:25.079363  kern  :emerg : Process klogd (pid: 76, stac=
k limit =3D[    6.128668] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=
=3Dfail UNITS=3Dlines MEASUREMENT=3D15>
    2023-12-08T16:07:25.079591   0x(ptrval))   =

 =



platform             | arch  | lab             | compiler | defconfig      =
    | regressions
---------------------+-------+-----------------+----------+----------------=
----+------------
meson-gxbb-p200      | arm64 | lab-baylibre    | gcc-10   | defconfig      =
    | 1          =


  Details:     https://kernelci.org/test/plan/id/65733d9bbd32cb8f7ce13487

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
01/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p200.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
01/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65733d9bbd32cb8f7ce13=
488
        new failure (last pass: v4.19.297) =

 =



platform             | arch  | lab             | compiler | defconfig      =
    | regressions
---------------------+-------+-----------------+----------+----------------=
----+------------
meson-gxl-s905d-p230 | arm64 | lab-baylibre    | gcc-10   | defconfig      =
    | 1          =


  Details:     https://kernelci.org/test/plan/id/65733ca0ea6c6bfd9ee13546

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
01/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl-s905d-p230.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
01/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl-s905d-p230.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65733ca0ea6c6bfd9ee1354f
        failing since 22 days (last pass: v4.19.298-87-g060b297883f5, first=
 fail: v4.19.298-89-g83d114914749)

    2023-12-08T15:55:55.721881  <4>[   52.042474] ------------[ cut here ]-=
-----------
    2023-12-08T15:55:55.732743  <4>[   52.047119] WARNING: CPU: 0 PID: 0 at=
 drivers/mmc/host/meson-gx-mmc.c:1039 meson_mmc_irq+0x1c8/0x1dc
    2023-12-08T15:55:55.760973  <4>[   52.056387] Modules linked in: ipv6 d=
wmac_generic realtek meson_gxl meson_dw_hdmi meson_drm dw_hdmi drm_kms_help=
er drm meson_ir meson_rng rng_core rc_core dwmac_meson8b stmmac_platform st=
mmac meson_gxbb_wdt pwm_meson crc32_ce adc_keys drm_panel_orientation_quirk=
s crct10dif_ce nvmem_meson_efuse input_polldev
    2023-12-08T15:55:55.766004  <8>[   52.056601] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3867462_1.5.2.4.1>
    2023-12-08T15:55:55.771694  <4>[   52.083646] CPU: 0 PID: 0 Comm: swapp=
er/0 Tainted: G        W         4.19.301 #1
    2023-12-08T15:55:55.777115  <4>[   52.083648] Hardware name: Amlogic Me=
son GXL (S905D) P230 Development Board (DT)
    2023-12-08T15:55:55.782504  <4>[   52.083652] pstate: 60000085 (nZCv da=
If -PAN -UAO)
    2023-12-08T15:55:55.788302  <4>[   52.083657] pc : meson_mmc_irq+0x1c8/=
0x1dc
    2023-12-08T15:55:55.793636  <4>[   52.083666] lr : meson_mmc_irq+0x1c8/=
0x1dc
    2023-12-08T15:55:55.799186  <4>[   52.118229] sp : ffff000008003cc0 =

    ... (282 line(s) more)  =

 =



platform             | arch  | lab             | compiler | defconfig      =
    | regressions
---------------------+-------+-----------------+----------+----------------=
----+------------
meson-gxm-q200       | arm64 | lab-baylibre    | gcc-10   | defconfig      =
    | 1          =


  Details:     https://kernelci.org/test/plan/id/65733ce41882f3e20de13480

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
01/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-q200.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
01/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/65733ce41882f3e=
20de13483
        failing since 22 days (last pass: v4.19.298-87-g060b297883f5, first=
 fail: v4.19.298-89-g83d114914749)
        1 lines

    2023-12-08T15:57:05.074451  <4>[   49.865811] ------------[ cut here ]-=
-----------
    2023-12-08T15:57:05.074988  <4>[   49.865892] WARNING: CPU: 0 PID: 0 at=
 drivers/mmc/host/meson-gx-mmc.c:1039 meson_mmc_irq+0x1c8/0x1dc
    2023-12-08T15:57:05.078508  <4>[   49.874365] Modules linked in: ipv6 d=
wmac_generic realtek meson_gxl meson_dw_hdmi dw_hdmi meson_drm drm_kms_help=
er meson_rng rng_core drm pwm_meson meson_gxbb_wdt meson_ir adc_keys dwmac_=
meson8b crc32_ce stmmac_platform rc_core stmmac drm_panel_orientation_quirk=
s input_polldev crct10dif_ce nvmem_meson_efuse
    2023-12-08T15:57:05.117229  <4>[   49.901625] CPU: 0 PID: 0 Comm: swapp=
er/0 Tainted: G        W         4.19.301 #1
    2023-12-08T15:57:05.117741  <4>[   49.909296] Hardware name: Amlogic Me=
son GXM (S912) Q200 Development Board (DT)
    2023-12-08T15:57:05.117960  <4>[   49.916801] pstate: 60000085 (nZCv da=
If -PAN -UAO)
    2023-12-08T15:57:05.118160  <4>[   49.921803] pc : meson_mmc_irq+0x1c8/=
0x1dc
    2023-12-08T15:57:05.118352  <4>[   49.926115] lr : meson_mmc_irq+0x1c8/=
0x1dc
    2023-12-08T15:57:05.118749  <4>[   49.930426] sp : ffff000008003cc0
    2023-12-08T15:57:05.118946  <4>[   49.933962] x29: ffff000008003cc0 x28=
: 00000000000000a0  =

    ... (37 line(s) more)  =

 =20

