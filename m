Return-Path: <stable+bounces-6881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F008158C8
	for <lists+stable@lfdr.de>; Sat, 16 Dec 2023 12:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DAF1B23F96
	for <lists+stable@lfdr.de>; Sat, 16 Dec 2023 11:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55F914292;
	Sat, 16 Dec 2023 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="gHhoGKCC"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FF915E94
	for <stable@vger.kernel.org>; Sat, 16 Dec 2023 11:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-20335dcec64so1101510fac.3
        for <stable@vger.kernel.org>; Sat, 16 Dec 2023 03:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702725799; x=1703330599; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=73Vbvj677nKnkyd1XuKX8P5nVdkUX2oIOKtqzC4rkkY=;
        b=gHhoGKCCXlXGFl9uwK1fZImLF5DoHsEfW/M5OLlpzkQNOP1YwHYRwwmwbdTlEyjkx7
         mJ1+QiqeJXl/NoLgPyjFs15n+tTtSi69EYUdYEremY0UBifhbZMyi7e65aBLqdxVyN8L
         LQc5rYKQW8D43GoKJQtyyMP2+23oS6ctDcWmmR5+GpdJIWnt3VK3nlJ1PiFWXgpp5Omc
         ghwZO6XkzKgZwBIUfKpmoo7cIW2d/HfHUaJ0UosR9uwVtvV7Zozu2cXuGtX+qlASuFMB
         FwKdMBpWoOkngWEP8ofV5BQkcCgdoJ8BO4jRPpFK+U3oZ8GUXKKmtW+fcAR5AOUdr0l2
         CYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702725799; x=1703330599;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=73Vbvj677nKnkyd1XuKX8P5nVdkUX2oIOKtqzC4rkkY=;
        b=u8+nXfd951rEHtXF6dTDKustxYl3TzoIS/HAJbwcBhIRiH7PCV3afdHxnyy8D2LQZk
         tTneoYeMR4bp/6z0/enJr5KGF1Z9l4HtoAB+6iD/l0IhPxgzAl2Vi31v5wVtmgOfqN9S
         a4XP0YwnuoMX+rJO0E0HuLGbHHduM5X90WMqknOt8dvI+LTs4bRaIvhFRvIJKN03L/4g
         oUjApLmkcPptubcAr6UPLDF0+78veMiHAqlLKpuP334P8ktgm4pz620LCCZOJ9dEeQdt
         W7LNF50KWpuSRwLIEGEejM1hxGBJtoLSI+Rs9Sse4FCs2ICr5wqXLEGhAX/5ETOdIdiv
         dITQ==
X-Gm-Message-State: AOJu0Yxfo1JPvaMZG6/OQs0wt/aOFjEi8Q2+LLCFPX2ZEFMIpwO36ntA
	M0ukGjnF3l9ZgZgJ/1DjRjtt3QSR5OG/0XwStfk=
X-Google-Smtp-Source: AGHT+IFc88dW6uu9115Tkolm8nLj4HMlnQ0ZUo0IT2IqnEbK+ueqVbyvzwInNOts/sczzSvJTb+6gw==
X-Received: by 2002:a05:6870:503:b0:203:4ae6:f7e7 with SMTP id j3-20020a056870050300b002034ae6f7e7mr5229648oao.89.1702725799447;
        Sat, 16 Dec 2023 03:23:19 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id r13-20020a17090ad40d00b0028b03f9107asm5195735pju.55.2023.12.16.03.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 03:23:18 -0800 (PST)
Message-ID: <657d88a6.170a0220.809b5.fe57@mx.google.com>
Date: Sat, 16 Dec 2023 03:23:18 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.68-44-g3047154b12a05
Subject: stable-rc/queue/6.1 baseline: 109 runs,
 3 regressions (v6.1.68-44-g3047154b12a05)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 109 runs, 3 regressions (v6.1.68-44-g3047154b=
12a05)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.68-44-g3047154b12a05/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.68-44-g3047154b12a05
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      3047154b12a054ad9e1ddf1304432b93dcc310bd =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657d57f9c19da4ac2ee134a2

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-44=
-g3047154b12a05/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-44=
-g3047154b12a05/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657d57f9c19da4ac2ee134ab
        failing since 23 days (last pass: v6.1.31-26-gef50524405c2, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-16T08:02:54.483324  / # #

    2023-12-16T08:02:54.585476  export SHELL=3D/bin/sh

    2023-12-16T08:02:54.586181  #

    2023-12-16T08:02:54.687573  / # export SHELL=3D/bin/sh. /lava-12286053/=
environment

    2023-12-16T08:02:54.688307  =


    2023-12-16T08:02:54.789825  / # . /lava-12286053/environment/lava-12286=
053/bin/lava-test-runner /lava-12286053/1

    2023-12-16T08:02:54.790887  =


    2023-12-16T08:02:54.807865  / # /lava-12286053/bin/lava-test-runner /la=
va-12286053/1

    2023-12-16T08:02:54.856273  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-16T08:02:54.856804  + cd /lav<8>[   19.111481] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12286053_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657d546f61a045082ee13476

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-44=
-g3047154b12a05/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-44=
-g3047154b12a05/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657d546f61a045082ee1347f
        failing since 23 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-16T07:40:25.118247  / # #
    2023-12-16T07:40:25.219598  export SHELL=3D/bin/sh
    2023-12-16T07:40:25.220107  #
    2023-12-16T07:40:25.323129  / # export SHELL=3D/bin/sh. /lava-448361/en=
vironment
    2023-12-16T07:40:25.323640  =

    2023-12-16T07:40:25.424545  / # . /lava-448361/environment/lava-448361/=
bin/lava-test-runner /lava-448361/1
    2023-12-16T07:40:25.425244  =

    2023-12-16T07:40:25.429651  / # /lava-448361/bin/lava-test-runner /lava=
-448361/1
    2023-12-16T07:40:25.502709  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-16T07:40:25.503240  + cd /lava-448361/<8>[   18.594871] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 448361_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657d5477c46ed9a5cde134e0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-44=
-g3047154b12a05/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-44=
-g3047154b12a05/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657d5477c46ed9a5cde134e9
        failing since 23 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-16T07:48:03.831650  / # #

    2023-12-16T07:48:03.933492  export SHELL=3D/bin/sh

    2023-12-16T07:48:03.933708  #

    2023-12-16T07:48:04.034237  / # export SHELL=3D/bin/sh. /lava-12286066/=
environment

    2023-12-16T07:48:04.034706  =


    2023-12-16T07:48:04.135741  / # . /lava-12286066/environment/lava-12286=
066/bin/lava-test-runner /lava-12286066/1

    2023-12-16T07:48:04.136775  =


    2023-12-16T07:48:04.140379  / # /lava-12286066/bin/lava-test-runner /la=
va-12286066/1

    2023-12-16T07:48:04.220253  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-16T07:48:04.220787  + cd /lava-1228606<8>[   19.344570] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12286066_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

