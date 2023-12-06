Return-Path: <stable+bounces-4866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB54E8079B5
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 21:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E733A282470
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 20:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C7336AF9;
	Wed,  6 Dec 2023 20:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="xbp+oyuJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB7A181
	for <stable@vger.kernel.org>; Wed,  6 Dec 2023 12:46:02 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1d0521554ddso1548055ad.2
        for <stable@vger.kernel.org>; Wed, 06 Dec 2023 12:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701895562; x=1702500362; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UZC0eSismuNZWvAX3zJNnNlA5AWfGUBaMr79Ow7aU/4=;
        b=xbp+oyuJaQDZevYQpUM5BPHcWq3TBr9GKsmFiYcDP7bjsVyMLEFvzU3TNS1BkCjkNi
         caVzG7esX0rbecvP3ZRph54OZ9y9fDGQUZb2S7LCZ+wr7OyI6uPkVKry+7Ie4tR+kOp8
         zAIUIIX1fsyyZrjLWc+cpbm4QoMb145fDDuS2OflBDiaC18PwpgIHFbvVpWWh/75GFUl
         JJfT4tcrBnz49/LE2jQAQ0Bpot6m1ab/BQ4Ow4CTqPQPBJZ9yNI+0yIiTJ2CsBdRR8K+
         25DcRbiQdrUL9v4LGqTKXjWZpBoSFfcdJ6jVo5LPDGfY6zBzv9rhaHA3Kqb7iP+vFC2R
         Sy+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701895562; x=1702500362;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UZC0eSismuNZWvAX3zJNnNlA5AWfGUBaMr79Ow7aU/4=;
        b=aFnHf3Ixeko1nhKXcgvmk7SubwWZ7b1MTo0YQTcer0UtogcszgvOAIom+z0ur1Gz4m
         5G1OsUOkY53f27JKRQYXRPcyFIqTj1nZRHWutatILnkViFMfc2wt0NzO7kgOUBZts8HF
         21r9vInO5FoWGpHvFNJEClLr0Bej8noSot77BLiKN7lZwk6qufcC6te3WXZFP2kKKDb1
         Qq6VKqrK1JQ1eiZnEvu4ADwBgmKlcEddLlqlSu3aZv7y79tLu9iE+Pj4QJAOWnksEqET
         76o/8ZjFvYa3SiLJn8H8zKmySiwBaYE5dxhpafZR9ZRUhjOh9p5ui6tfTnud7PVyxiVd
         ijCQ==
X-Gm-Message-State: AOJu0YwLRnChi160bM1P65u0QmVwVDU18WOajS6YC9hUt3yonL18Dtgf
	itWq8sXgjCda247Ed43s6t2PvTUQ8ZpCyRPwqJ7KtQ==
X-Google-Smtp-Source: AGHT+IHMo0/ue12VtO7OfbiL+bhq6dsTDvHKXXPunehO0EeSWLN9pYKt40xi/QxnihxtEC37kmQZYA==
X-Received: by 2002:a17:902:b28c:b0:1d0:6ffe:1e89 with SMTP id u12-20020a170902b28c00b001d06ffe1e89mr1295192plr.108.1701895561485;
        Wed, 06 Dec 2023 12:46:01 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902d50f00b001d01c970119sm223563plg.275.2023.12.06.12.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 12:46:00 -0800 (PST)
Message-ID: <6570dd88.170a0220.8a609.152e@mx.google.com>
Date: Wed, 06 Dec 2023 12:46:00 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.202-131-g761b9c32d3c8b
Subject: stable-rc/queue/5.10 baseline: 149 runs,
 9 regressions (v5.10.202-131-g761b9c32d3c8b)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 149 runs, 9 regressions (v5.10.202-131-g761b=
9c32d3c8b)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =

juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =

panda                        | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =

r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =

sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
                  | 1          =

sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =

sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.202-131-g761b9c32d3c8b/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.202-131-g761b9c32d3c8b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      761b9c32d3c8b7a69a041460401ca00cf9ef0a00 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/6570ad6ecca0142614e13484

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-131-g761b9c32d3c8b/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-131-g761b9c32d3c8b/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6570ad6ecca0142614e134ba
        failing since 295 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-12-06T17:20:20.700842  <8>[   20.869988] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 315683_1.5.2.4.1>
    2023-12-06T17:20:20.808555  / # #
    2023-12-06T17:20:20.910639  export SHELL=3D/bin/sh
    2023-12-06T17:20:20.911135  #
    2023-12-06T17:20:21.012449  / # export SHELL=3D/bin/sh. /lava-315683/en=
vironment
    2023-12-06T17:20:21.012935  =

    2023-12-06T17:20:21.114402  / # . /lava-315683/environment/lava-315683/=
bin/lava-test-runner /lava-315683/1
    2023-12-06T17:20:21.115012  =

    2023-12-06T17:20:21.118251  / # /lava-315683/bin/lava-test-runner /lava=
-315683/1
    2023-12-06T17:20:21.223143  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6570b39b3dd79f8607e1348d

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-131-g761b9c32d3c8b/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.=
txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-131-g761b9c32d3c8b/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6570b39c3dd79f8607e134c8
        new failure (last pass: v5.10.202-131-ged17b556b8e2)

    2023-12-06T17:46:42.349099  / # #
    2023-12-06T17:46:42.452616  export SHELL=3D/bin/sh
    2023-12-06T17:46:42.453375  #
    2023-12-06T17:46:42.555281  / # export SHELL=3D/bin/sh. /lava-315658/en=
vironment
    2023-12-06T17:46:42.556065  =

    2023-12-06T17:46:42.658130  / # . /lava-315658/environment/lava-315658/=
bin/lava-test-runner /lava-315658/1
    2023-12-06T17:46:42.659390  =

    2023-12-06T17:46:42.673266  / # /lava-315658/bin/lava-test-runner /lava=
-315658/1
    2023-12-06T17:46:42.732134  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-06T17:46:42.732639  + cd /lava-315658/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
panda                        | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6570abd32dcead2c16e13478

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-131-g761b9c32d3c8b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pan=
da.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-131-g761b9c32d3c8b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pan=
da.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6570abd32dcead2c16e1347d
        new failure (last pass: v5.10.148-91-g23f89880f93d)

    2023-12-06T17:13:46.779143  <8>[   24.291168] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3863532_1.5.2.4.1>
    2023-12-06T17:13:46.885906  / # #
    2023-12-06T17:13:46.987161  export SHELL=3D/bin/sh
    2023-12-06T17:13:46.987579  #
    2023-12-06T17:13:47.088373  / # export SHELL=3D/bin/sh. /lava-3863532/e=
nvironment
    2023-12-06T17:13:47.088753  =

    2023-12-06T17:13:47.189553  / # . /lava-3863532/environment/lava-386353=
2/bin/lava-test-runner /lava-3863532/1
    2023-12-06T17:13:47.190190  =

    2023-12-06T17:13:47.195137  / # /lava-3863532/bin/lava-test-runner /lav=
a-3863532/1
    2023-12-06T17:13:47.248971  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6570ac68b7990c9b34e1348e

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-131-g761b9c32d3c8b/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-131-g761b9c32d3c8b/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6570ac68b7990c9b34e13493
        failing since 14 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-06T17:23:47.273606  / # #

    2023-12-06T17:23:47.375972  export SHELL=3D/bin/sh

    2023-12-06T17:23:47.376788  #

    2023-12-06T17:23:47.478228  / # export SHELL=3D/bin/sh. /lava-12199765/=
environment

    2023-12-06T17:23:47.479037  =


    2023-12-06T17:23:47.580500  / # . /lava-12199765/environment/lava-12199=
765/bin/lava-test-runner /lava-12199765/1

    2023-12-06T17:23:47.581529  =


    2023-12-06T17:23:47.597406  / # /lava-12199765/bin/lava-test-runner /la=
va-12199765/1

    2023-12-06T17:23:47.647677  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-06T17:23:47.648187  + cd /lav<8>[   16.439662] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12199765_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6570ace03a200aff69e13485

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-131-g761b9c32d3c8b/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-131-g761b9c32d3c8b/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6570ace03a200aff69e1348b
        failing since 267 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-06T17:18:38.097713  <8>[   34.010814] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-12-06T17:18:39.121901  /lava-12199790/1/../bin/lava-test-case

    2023-12-06T17:18:39.132331  <8>[   35.046873] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6570ace03a200aff69e1348c
        failing since 267 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-06T17:18:38.085852  /lava-12199790/1/../bin/lava-test-case
   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6570ac5cdbd1e5e037e134a6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-131-g761b9c32d3c8b/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-131-g761b9c32d3c8b/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6570ac5cdbd1e5e037e134ab
        failing since 14 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-06T17:16:03.280386  <8>[   16.986327] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 446824_1.5.2.4.1>
    2023-12-06T17:16:03.384322  / # #
    2023-12-06T17:16:03.485575  export SHELL=3D/bin/sh
    2023-12-06T17:16:03.486029  #
    2023-12-06T17:16:03.586862  / # export SHELL=3D/bin/sh. /lava-446824/en=
vironment
    2023-12-06T17:16:03.587325  =

    2023-12-06T17:16:03.688226  / # . /lava-446824/environment/lava-446824/=
bin/lava-test-runner /lava-446824/1
    2023-12-06T17:16:03.689278  =

    2023-12-06T17:16:03.695858  / # /lava-446824/bin/lava-test-runner /lava=
-446824/1
    2023-12-06T17:16:03.760876  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6570ac7b351190b376e1350b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-131-g761b9c32d3c8b/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-131-g761b9c32d3c8b/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6570ac7b351190b376e13510
        failing since 14 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-06T17:24:03.497455  / # #

    2023-12-06T17:24:03.597863  export SHELL=3D/bin/sh

    2023-12-06T17:24:03.597972  #

    2023-12-06T17:24:03.698405  / # export SHELL=3D/bin/sh. /lava-12199793/=
environment

    2023-12-06T17:24:03.698503  =


    2023-12-06T17:24:03.798965  / # . /lava-12199793/environment/lava-12199=
793/bin/lava-test-runner /lava-12199793/1

    2023-12-06T17:24:03.799197  =


    2023-12-06T17:24:03.811354  / # /lava-12199793/bin/lava-test-runner /la=
va-12199793/1

    2023-12-06T17:24:03.871131  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-06T17:24:03.871613  + cd /lava-1219979<8>[   18.083591] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12199793_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6570abbd7e87e9ff7ae134d8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-131-g761b9c32d3c8b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-131-g761b9c32d3c8b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6570abbd7e87e9ff7ae134dd
        failing since 14 days (last pass: v5.10.165-77-g4600242c13ed, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-06T17:13:15.551499  / # #
    2023-12-06T17:13:15.652630  export SHELL=3D/bin/sh
    2023-12-06T17:13:15.653078  #
    2023-12-06T17:13:15.753864  / # export SHELL=3D/bin/sh. /lava-3863530/e=
nvironment
    2023-12-06T17:13:15.754274  =

    2023-12-06T17:13:15.855093  / # . /lava-3863530/environment/lava-386353=
0/bin/lava-test-runner /lava-3863530/1
    2023-12-06T17:13:15.855750  =

    2023-12-06T17:13:15.863755  / # /lava-3863530/bin/lava-test-runner /lav=
a-3863530/1
    2023-12-06T17:13:15.962491  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-06T17:13:15.962961  + cd /lava-3863530/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20

