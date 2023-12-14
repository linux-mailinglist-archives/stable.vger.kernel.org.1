Return-Path: <stable+bounces-6710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 826D1812725
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 06:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50E21C21498
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 05:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D702E6AC2;
	Thu, 14 Dec 2023 05:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="iG8FxCRC"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4BFA3
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 21:52:24 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-35f697bf477so8749085ab.3
        for <stable@vger.kernel.org>; Wed, 13 Dec 2023 21:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702533143; x=1703137943; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GkesAJF3oQqA1pIac+GuksO+kykrB4ibSiShvsaFJZU=;
        b=iG8FxCRClBC7fc9ixdCUAkBZppHu6zO3UWjvn1kLt2OQbUgbCOuzrQtlDMGlIEOIyh
         u/K7du5KQwhZGJ5OhQ1RVx6SUGZ0umdbdpY3VaTT1yWSkrVnU+8o5KTVq3YzyyDwH/JD
         dBqtHJZwoErGRpiHnvAVpKEkCb8SfrFm9zoYfVforBP8s/bY8scjA5JKSkq5epGzZoSj
         7maTPpQltGXThzWmIkfdZhbM0NeT9Hc071rk32cJ4ui2etL3EtxTAFBBwu2XzYSsVW2o
         PYwTJHJJ4oodazErSbfLFtHa55rE7erv8UJmDhAQqCaylhuhbtCm6VG3009Ba4aITA3Y
         wUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702533143; x=1703137943;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GkesAJF3oQqA1pIac+GuksO+kykrB4ibSiShvsaFJZU=;
        b=VQK/oIEo0UfYR6o3W7D8HO6lpsT+U1ml6th+pKMCafzIT4GD5nbKfcB3e255gaMsOC
         g28EZvVwx/sXH0Ogyd4OndtJKgplmnbwe2pB7aXTciAUoEaqAgxC+jADW+Gd9gPzJvqN
         quKS1KWxZOaXbI8UcWqdhE/7k4Ya+MG3QBXSwh+cim24ixNp1OMIVb5zf3WTfuEyriKj
         qLhismFhlAqK+cZP5PNMwwdJ973mJPPxWhM5ZpjpBLLt8eOMlxmpPVP6ZztXnWYpzoCf
         UYa2j20IPblba7qFJb1C5vaJra2jwpRLC0JoVT68H+XOMyPxC0F1jLu08r4qGlqRZyMF
         5DEg==
X-Gm-Message-State: AOJu0YwrO+bySEPzrqG5UhFeDTdyLyyTikPMG1655yAN+l+I1ynjJKOd
	LEhU1y/nVaHEsH0b49EavbyFp17+6Yyn0DD/cquCEg==
X-Google-Smtp-Source: AGHT+IFvOo1AnwLA7EdtL3nSM834wfrawO3tOrubzGU1ITeFHD5FkFXwbAl7baZUbHAI8yKXIYXd1Q==
X-Received: by 2002:a05:6e02:1521:b0:35d:7711:da09 with SMTP id i1-20020a056e02152100b0035d7711da09mr12986599ilu.63.1702533142963;
        Wed, 13 Dec 2023 21:52:22 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902848300b001d33e6521b9sm4041540plo.14.2023.12.13.21.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 21:52:22 -0800 (PST)
Message-ID: <657a9816.170a0220.287e1.db52@mx.google.com>
Date: Wed, 13 Dec 2023 21:52:22 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.67-194-gb1f34ec337363
Subject: stable-rc/queue/6.1 baseline: 108 runs,
 3 regressions (v6.1.67-194-gb1f34ec337363)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 108 runs, 3 regressions (v6.1.67-194-gb1f34ec=
337363)

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
el/v6.1.67-194-gb1f34ec337363/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.67-194-gb1f34ec337363
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b1f34ec337363d820a35e7e5ae939996ed093f3b =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657a635c8daf8abc86e134d0

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.67-19=
4-gb1f34ec337363/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.67-19=
4-gb1f34ec337363/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657a635c8daf8abc86e134d9
        failing since 21 days (last pass: v6.1.31-26-gef50524405c2, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-14T02:14:36.300192  / # #

    2023-12-14T02:14:36.402482  export SHELL=3D/bin/sh

    2023-12-14T02:14:36.403236  #

    2023-12-14T02:14:36.504662  / # export SHELL=3D/bin/sh. /lava-12265783/=
environment

    2023-12-14T02:14:36.505423  =


    2023-12-14T02:14:36.606884  / # . /lava-12265783/environment/lava-12265=
783/bin/lava-test-runner /lava-12265783/1

    2023-12-14T02:14:36.608084  =


    2023-12-14T02:14:36.614106  / # /lava-12265783/bin/lava-test-runner /la=
va-12265783/1

    2023-12-14T02:14:36.673639  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-14T02:14:36.674276  + cd /lav<8>[   19.179731] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12265783_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657a63448bd0cbe0c6e134ca

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.67-19=
4-gb1f34ec337363/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.67-19=
4-gb1f34ec337363/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657a63448bd0cbe0c6e134d3
        failing since 21 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-14T02:06:55.704407  <8>[   18.086255] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447981_1.5.2.4.1>
    2023-12-14T02:06:55.809426  / # #
    2023-12-14T02:06:55.911163  export SHELL=3D/bin/sh
    2023-12-14T02:06:55.911783  #
    2023-12-14T02:06:56.012794  / # export SHELL=3D/bin/sh. /lava-447981/en=
vironment
    2023-12-14T02:06:56.013398  =

    2023-12-14T02:06:56.114451  / # . /lava-447981/environment/lava-447981/=
bin/lava-test-runner /lava-447981/1
    2023-12-14T02:06:56.115326  =

    2023-12-14T02:06:56.119700  / # /lava-447981/bin/lava-test-runner /lava=
-447981/1
    2023-12-14T02:06:56.198354  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657a635b8daf8abc86e134c2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.67-19=
4-gb1f34ec337363/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.67-19=
4-gb1f34ec337363/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657a635b8daf8abc86e134cb
        failing since 21 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-14T02:14:48.968539  / # #

    2023-12-14T02:14:49.070800  export SHELL=3D/bin/sh

    2023-12-14T02:14:49.071549  #

    2023-12-14T02:14:49.173074  / # export SHELL=3D/bin/sh. /lava-12265779/=
environment

    2023-12-14T02:14:49.173829  =


    2023-12-14T02:14:49.275236  / # . /lava-12265779/environment/lava-12265=
779/bin/lava-test-runner /lava-12265779/1

    2023-12-14T02:14:49.276465  =


    2023-12-14T02:14:49.277575  / # /lava-12265779/bin/lava-test-runner /la=
va-12265779/1

    2023-12-14T02:14:49.358745  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-14T02:14:49.358911  + cd /lava-1226577<8>[   19.214144] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12265779_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

