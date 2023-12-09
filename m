Return-Path: <stable+bounces-5097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A82C80B2D8
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 08:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D969FB20B57
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 07:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41731FCE;
	Sat,  9 Dec 2023 07:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="KafLjfs8"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF5484
	for <stable@vger.kernel.org>; Fri,  8 Dec 2023 23:37:04 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6d9f4eed60eso764050a34.1
        for <stable@vger.kernel.org>; Fri, 08 Dec 2023 23:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702107423; x=1702712223; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qL5Qz2Vvug8jyb77nX10xV+9gwXF9FWXH5MnIAjWfDM=;
        b=KafLjfs8cfn7NHj87NYPjIffdxoqad+tYTo7voYaGqwlQMEL44l3pB95Di4tsphd+O
         YsH+wnULVy55m/wGn1prKCg15I9/Oz8CTMQ7L6TU0AUNAYXFFSKgYKp8UhLX9dGjZYze
         oeLiTcT/lYqwH9HMbpkEOh4MLiQY81rinyWl5VSkCkIoBew+qpWCa2Lp6YDOGiV3w/Mv
         DRDHUEDbyIRIZu8IQxJb6GI20YsRne4XeWN67PbOQcQoYqzkTe0+vIfiHdQBeBXPg6gu
         8mkfZhZ5rz8FDq2IfF8VdFraKwUEDdqvoYWMrKUitF4iNHKC1IFaLuxMxXBB+HeP0obW
         Gx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702107423; x=1702712223;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qL5Qz2Vvug8jyb77nX10xV+9gwXF9FWXH5MnIAjWfDM=;
        b=lb53x4zcLjPo1RSNP6mqWedq1d+SgDtXzzc3e24t4fUqN07QV5ed3AYyU+Lk5fGbba
         4Tac+t67wBzeQKhiTXdxN4qziuO6KCliSlwNWjKRaHAsRDPrCIA1E8tBFsOg/679M2gc
         hQ7c2kPWrY0p8dsLeYXkEr88iKLW65DHE9KtsArhYTAVl3/u2ORHAsv2TXSUFr5O0QhZ
         HhSGZgDA0p9bdADK39lUgNMC8WOCKZwT8BABtDGfKpz0OBUzmw280n88IUMN5+GfP+bx
         Ouh+4XIUdi74bia4QdOomEnGVHM/nM7ud5vgPtK87i5jW9efFJTXClpAoaNDPiHQry0J
         yz1Q==
X-Gm-Message-State: AOJu0Yxncrr6JRc4m5PacP3Ox7O/vjpTPwWnqRdQzIqn0r18IeGwLjE/
	qvjcbSNcJ8MMAGhcd5zf23msmoUoGKzsZrA/H66w3A==
X-Google-Smtp-Source: AGHT+IHiz2fqSyPUZfOCFA/S/bNJHp7JZUHCoztO1vFxLLD5WvxWaM+QIsMXPkzrKl6+mxTo8eJAxQ==
X-Received: by 2002:a9d:6e10:0:b0:6d9:c946:49c with SMTP id e16-20020a9d6e10000000b006d9c946049cmr1466354otr.5.1702107422923;
        Fri, 08 Dec 2023 23:37:02 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k13-20020aa792cd000000b006ce273562fasm2697565pfa.40.2023.12.08.23.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 23:37:02 -0800 (PST)
Message-ID: <6574191e.a70a0220.e9158.9251@mx.google.com>
Date: Fri, 08 Dec 2023 23:37:02 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.66-63-gdd66d04a6991a
Subject: stable-rc/queue/6.1 baseline: 159 runs,
 6 regressions (v6.1.66-63-gdd66d04a6991a)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 159 runs, 6 regressions (v6.1.66-63-gdd66d04a=
6991a)

Regressions Summary
-------------------

platform           | arch  | lab             | compiler | defconfig        =
   | regressions
-------------------+-------+-----------------+----------+------------------=
---+------------
beagle-xm          | arm   | lab-baylibre    | gcc-10   | omap2plus_defconf=
ig | 1          =

beaglebone-black   | arm   | lab-broonie     | gcc-10   | omap2plus_defconf=
ig | 1          =

imx6dl-riotboard   | arm   | lab-pengutronix | gcc-10   | multi_v7_defconfi=
g  | 1          =

r8a77960-ulcb      | arm64 | lab-collabora   | gcc-10   | defconfig        =
   | 1          =

sun50i-h6-pine-h64 | arm64 | lab-clabbe      | gcc-10   | defconfig        =
   | 1          =

sun50i-h6-pine-h64 | arm64 | lab-collabora   | gcc-10   | defconfig        =
   | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.66-63-gdd66d04a6991a/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.66-63-gdd66d04a6991a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      dd66d04a6991aa43b29217ea4ef2170b3d5d99b5 =



Test Regressions
---------------- =



platform           | arch  | lab             | compiler | defconfig        =
   | regressions
-------------------+-------+-----------------+----------+------------------=
---+------------
beagle-xm          | arm   | lab-baylibre    | gcc-10   | omap2plus_defconf=
ig | 1          =


  Details:     https://kernelci.org/test/plan/id/6573e8ff692af3661be134b6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-63=
-gdd66d04a6991a/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-63=
-gdd66d04a6991a/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6573e8ff692af3661be13=
4b7
        failing since 232 days (last pass: v6.1.22-477-g2128d4458cbc, first=
 fail: v6.1.22-474-gecc61872327e) =

 =



platform           | arch  | lab             | compiler | defconfig        =
   | regressions
-------------------+-------+-----------------+----------+------------------=
---+------------
beaglebone-black   | arm   | lab-broonie     | gcc-10   | omap2plus_defconf=
ig | 1          =


  Details:     https://kernelci.org/test/plan/id/6573e91c214db75f6ae134c0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-63=
-gdd66d04a6991a/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beagleb=
one-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-63=
-gdd66d04a6991a/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beagleb=
one-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6573e91c214db75f6ae13=
4c1
        failing since 0 day (last pass: v6.1.66-10-g45deeed0dade2, first fa=
il: v6.1.66-15-ga472e3690d9cb) =

 =



platform           | arch  | lab             | compiler | defconfig        =
   | regressions
-------------------+-------+-----------------+----------+------------------=
---+------------
imx6dl-riotboard   | arm   | lab-pengutronix | gcc-10   | multi_v7_defconfi=
g  | 1          =


  Details:     https://kernelci.org/test/plan/id/6573e8211afcf940c8e134b0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-63=
-gdd66d04a6991a/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
dl-riotboard.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-63=
-gdd66d04a6991a/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
dl-riotboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6573e8211afcf940c8e134b9
        new failure (last pass: v6.1.66-15-ga472e3690d9cb)

    2023-12-09T04:07:38.839768  + set[   14.967390] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1016105_1.5.2.3.1>
    2023-12-09T04:07:38.839924   +x
    2023-12-09T04:07:38.945343  / # #
    2023-12-09T04:07:39.046875  export SHELL=3D/bin/sh
    2023-12-09T04:07:39.047388  #
    2023-12-09T04:07:39.148152  / # export SHELL=3D/bin/sh. /lava-1016105/e=
nvironment
    2023-12-09T04:07:39.148590  =

    2023-12-09T04:07:39.249243  / # . /lava-1016105/environment/lava-101610=
5/bin/lava-test-runner /lava-1016105/1
    2023-12-09T04:07:39.249702  =

    2023-12-09T04:07:39.252901  / # /lava-1016105/bin/lava-test-runner /lav=
a-1016105/1 =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab             | compiler | defconfig        =
   | regressions
-------------------+-------+-----------------+----------+------------------=
---+------------
r8a77960-ulcb      | arm64 | lab-collabora   | gcc-10   | defconfig        =
   | 1          =


  Details:     https://kernelci.org/test/plan/id/6573e6af8baf738cf4e134f7

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-63=
-gdd66d04a6991a/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-63=
-gdd66d04a6991a/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6573e6af8baf738cf4e13500
        failing since 16 days (last pass: v6.1.31-26-gef50524405c2, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-09T04:09:12.037349  / # #

    2023-12-09T04:09:12.139378  export SHELL=3D/bin/sh

    2023-12-09T04:09:12.140026  #

    2023-12-09T04:09:12.241430  / # export SHELL=3D/bin/sh. /lava-12225812/=
environment

    2023-12-09T04:09:12.242198  =


    2023-12-09T04:09:12.343727  / # . /lava-12225812/environment/lava-12225=
812/bin/lava-test-runner /lava-12225812/1

    2023-12-09T04:09:12.344841  =


    2023-12-09T04:09:12.361831  / # /lava-12225812/bin/lava-test-runner /la=
va-12225812/1

    2023-12-09T04:09:12.410310  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-09T04:09:12.410831  + cd /lav<8>[   19.141735] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12225812_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab             | compiler | defconfig        =
   | regressions
-------------------+-------+-----------------+----------+------------------=
---+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe      | gcc-10   | defconfig        =
   | 1          =


  Details:     https://kernelci.org/test/plan/id/6573e6abe07618fa90e134e6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-63=
-gdd66d04a6991a/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-63=
-gdd66d04a6991a/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6573e6ace07618fa90e134ef
        failing since 16 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-09T04:01:42.015299  <8>[   18.042658] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447217_1.5.2.4.1>
    2023-12-09T04:01:42.120325  / # #
    2023-12-09T04:01:42.221959  export SHELL=3D/bin/sh
    2023-12-09T04:01:42.222547  #
    2023-12-09T04:01:42.323516  / # export SHELL=3D/bin/sh. /lava-447217/en=
vironment
    2023-12-09T04:01:42.324098  =

    2023-12-09T04:01:42.425117  / # . /lava-447217/environment/lava-447217/=
bin/lava-test-runner /lava-447217/1
    2023-12-09T04:01:42.426006  =

    2023-12-09T04:01:42.430458  / # /lava-447217/bin/lava-test-runner /lava=
-447217/1
    2023-12-09T04:01:42.509474  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab             | compiler | defconfig        =
   | regressions
-------------------+-------+-----------------+----------+------------------=
---+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora   | gcc-10   | defconfig        =
   | 1          =


  Details:     https://kernelci.org/test/plan/id/6573e6c34323178217e13491

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-63=
-gdd66d04a6991a/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-63=
-gdd66d04a6991a/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6573e6c34323178217e1349a
        failing since 16 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-09T04:09:25.792355  / # #

    2023-12-09T04:09:25.894550  export SHELL=3D/bin/sh

    2023-12-09T04:09:25.895275  #

    2023-12-09T04:09:25.996669  / # export SHELL=3D/bin/sh. /lava-12225798/=
environment

    2023-12-09T04:09:25.997401  =


    2023-12-09T04:09:26.098803  / # . /lava-12225798/environment/lava-12225=
798/bin/lava-test-runner /lava-12225798/1

    2023-12-09T04:09:26.099827  =


    2023-12-09T04:09:26.101835  / # /lava-12225798/bin/lava-test-runner /la=
va-12225798/1

    2023-12-09T04:09:26.182606  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-09T04:09:26.183138  + cd /lava-1222579<8>[   18.992854] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12225798_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

