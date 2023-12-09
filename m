Return-Path: <stable+bounces-5079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A6E80B1C2
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 03:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0F01F2134A
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 02:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3437F622;
	Sat,  9 Dec 2023 02:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="f8oKpEYq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBB710C4
	for <stable@vger.kernel.org>; Fri,  8 Dec 2023 18:33:31 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5c66e7eafabso2241526a12.0
        for <stable@vger.kernel.org>; Fri, 08 Dec 2023 18:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702089210; x=1702694010; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBo5oLmE5iMbgCJZda32Pfh7wxeHPxMdcLa0R6V42t4=;
        b=f8oKpEYq8nImwBtp6JIRIU/DfuB1IfuW2QSG90qiwJJo5ZWA5zoWB137ShNZkbc6UT
         4tO5h+1WvxseWIJDhezr7vVT+lOGUL01nB3hi4rnKoqSAPORUtD0NIWMHKmF6rmKfeuP
         8f5HYBrOOCOGxsxlwd0fzX1nhknoLk0lxe9viQ8cGLhcK1LN+/jRHqipV9eVZazJgEYC
         XXhBv7/kfc1OgTpvpxRgP1F2JznS/7XPxHIlm/HUHlQR7YsDLC1H1ajD1u4KaDpa5ymE
         4SpkJYI/n9zOEfobaiP7grA36MY+9CP3QTbr3TDsswdiidy0SsavRs4ilfMHz/Cu0lhm
         oI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702089210; x=1702694010;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZBo5oLmE5iMbgCJZda32Pfh7wxeHPxMdcLa0R6V42t4=;
        b=WdZcIze3zVLWQq08lEWj1RwPTM62ahJMoQnmmugB/nf2mMbq3OoOOdOJVde138XkIX
         dTOL4iLXVwR9zzoQuvqKkE2YcEyGlzv6gVCVDiZ7sy6656MFBzGaBj3i8u1GX51KwgFt
         vgpYFc3ndwxQp0LsCWLnYOj08yx6LEz7H/A0te81avDlx5W1Oz0Iq2N918MKizj5TE8o
         ekGEi2xjMTdGqC4hQK77rw6TL6ExjG21Uk6Yf7PDaCcjBjFzdHVORcP5xfwxwGkalv8b
         t0IXMlR9IelayEeT1AJGkwuHWaDAc3Qsag+J/eVgtoe7+TzIpXunhajTsxQjrfdbXyub
         eWbg==
X-Gm-Message-State: AOJu0YzLz938EZIwkthG4GW3oUBd5k6JB7/cehIUvOkwL7u141e88vJ4
	abAdm3ZjvjpZuua5NJ1GGiSP/US2LbsECG6Gih2TWA==
X-Google-Smtp-Source: AGHT+IHvBbU+9XiVNXAotqoWq6Gyi8ZKa/Bfyo/C1mJFUwBGoWd9Y9QN8K1k8WA3DGgFPI8tWkRoug==
X-Received: by 2002:a05:6a20:1615:b0:190:85d9:9d42 with SMTP id l21-20020a056a20161500b0019085d99d42mr542079pzj.111.1702089210101;
        Fri, 08 Dec 2023 18:33:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e20-20020aa78c54000000b006cb9a9ea64dsm2240308pfd.220.2023.12.08.18.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 18:33:29 -0800 (PST)
Message-ID: <6573d1f9.a70a0220.32a7a.8994@mx.google.com>
Date: Fri, 08 Dec 2023 18:33:29 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.66-15-ga472e3690d9cb
Subject: stable-rc/queue/6.1 baseline: 167 runs,
 8 regressions (v6.1.66-15-ga472e3690d9cb)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 167 runs, 8 regressions (v6.1.66-15-ga472e369=
0d9cb)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
beagle-xm          | arm   | lab-baylibre  | gcc-10   | omap2plus_defconfig=
 | 1          =

beaglebone-black   | arm   | lab-broonie   | gcc-10   | omap2plus_defconfig=
 | 1          =

imx6dl-udoo        | arm   | lab-broonie   | gcc-10   | multi_v7_defconfig =
 | 2          =

meson-gxbb-p200    | arm64 | lab-baylibre  | gcc-10   | defconfig          =
 | 1          =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
 | 1          =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.66-15-ga472e3690d9cb/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.66-15-ga472e3690d9cb
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      a472e3690d9cb501cd5df9181c8135287f11badb =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
beagle-xm          | arm   | lab-baylibre  | gcc-10   | omap2plus_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6573a1504190a6ccdde1348b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-15=
-ga472e3690d9cb/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-15=
-ga472e3690d9cb/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6573a1504190a6ccdde13=
48c
        failing since 232 days (last pass: v6.1.22-477-g2128d4458cbc, first=
 fail: v6.1.22-474-gecc61872327e) =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
beaglebone-black   | arm   | lab-broonie   | gcc-10   | omap2plus_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6573a22620e3e6eb48e134bc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-15=
-ga472e3690d9cb/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beagleb=
one-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-15=
-ga472e3690d9cb/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beagleb=
one-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6573a22620e3e6eb48e13=
4bd
        new failure (last pass: v6.1.66-10-g45deeed0dade2) =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
imx6dl-udoo        | arm   | lab-broonie   | gcc-10   | multi_v7_defconfig =
 | 2          =


  Details:     https://kernelci.org/test/plan/id/6573a505acc7c25814e134ce

  Results:     29 PASS, 4 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-15=
-ga472e3690d9cb/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-imx6dl-u=
doo.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-15=
-ga472e3690d9cb/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-imx6dl-u=
doo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/6573a505a=
cc7c25814e134db
        new failure (last pass: v6.1.66-10-g45deeed0dade2)

    2023-12-08T23:21:09.055425  /lava-327623/1/../bin/lava-test-case
    2023-12-08T23:21:09.082768  <8>[   26.477078] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =


  * baseline.bootrr.sound-card-probed: https://kernelci.org/test/case/id/65=
73a505acc7c25814e134dc
        new failure (last pass: v6.1.66-10-g45deeed0dade2)

    2023-12-08T23:21:08.006660  /lava-327623/1/../bin/lava-test-case
    2023-12-08T23:21:08.033506  <8>[   25.427253] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card-probed RESULT=3Dfail>   =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
meson-gxbb-p200    | arm64 | lab-baylibre  | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6573a0e0aba279b564e13504

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-15=
-ga472e3690d9cb/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p20=
0.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-15=
-ga472e3690d9cb/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p20=
0.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6573a0e0aba279b564e13=
505
        new failure (last pass: v6.1.66-10-g45deeed0dade2) =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/65739fdd7a0472dd0ce134a1

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-15=
-ga472e3690d9cb/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-15=
-ga472e3690d9cb/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65739fdd7a0472dd0ce134aa
        failing since 16 days (last pass: v6.1.31-26-gef50524405c2, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-08T23:06:57.879966  / # #

    2023-12-08T23:06:57.982167  export SHELL=3D/bin/sh

    2023-12-08T23:06:57.982900  #

    2023-12-08T23:06:58.084204  / # export SHELL=3D/bin/sh. /lava-12222583/=
environment

    2023-12-08T23:06:58.084540  =


    2023-12-08T23:06:58.185419  / # . /lava-12222583/environment/lava-12222=
583/bin/lava-test-runner /lava-12222583/1

    2023-12-08T23:06:58.186533  =


    2023-12-08T23:06:58.188418  / # /lava-12222583/bin/lava-test-runner /la=
va-12222583/1

    2023-12-08T23:06:58.251936  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-08T23:06:58.252600  + cd /lav<8>[   19.099944] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12222583_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/65739fc912fe3ed915e13487

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-15=
-ga472e3690d9cb/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-15=
-ga472e3690d9cb/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65739fc912fe3ed915e13490
        failing since 16 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-08T22:59:15.623787  <8>[   18.120395] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447148_1.5.2.4.1>
    2023-12-08T22:59:15.728869  / # #
    2023-12-08T22:59:15.830643  export SHELL=3D/bin/sh
    2023-12-08T22:59:15.831274  #
    2023-12-08T22:59:15.932279  / # export SHELL=3D/bin/sh. /lava-447148/en=
vironment
    2023-12-08T22:59:15.932872  =

    2023-12-08T22:59:16.033886  / # . /lava-447148/environment/lava-447148/=
bin/lava-test-runner /lava-447148/1
    2023-12-08T22:59:16.034843  =

    2023-12-08T22:59:16.038922  / # /lava-447148/bin/lava-test-runner /lava=
-447148/1
    2023-12-08T22:59:16.117911  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/65739fded9e296854de1347d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-15=
-ga472e3690d9cb/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-15=
-ga472e3690d9cb/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65739fded9e296854de13486
        failing since 16 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-08T23:07:10.322851  / # #

    2023-12-08T23:07:10.425017  export SHELL=3D/bin/sh

    2023-12-08T23:07:10.425728  #

    2023-12-08T23:07:10.527065  / # export SHELL=3D/bin/sh. /lava-12222587/=
environment

    2023-12-08T23:07:10.527782  =


    2023-12-08T23:07:10.629178  / # . /lava-12222587/environment/lava-12222=
587/bin/lava-test-runner /lava-12222587/1

    2023-12-08T23:07:10.630246  =


    2023-12-08T23:07:10.647243  / # /lava-12222587/bin/lava-test-runner /la=
va-12222587/1

    2023-12-08T23:07:10.713413  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-08T23:07:10.713915  + cd /lava-1222258<8>[   19.156405] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12222587_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

