Return-Path: <stable+bounces-3656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A02ED800D37
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 15:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40731C20EBF
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 14:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0CC24B33;
	Fri,  1 Dec 2023 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="mjraH5A3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721EC10F4
	for <stable@vger.kernel.org>; Fri,  1 Dec 2023 06:34:47 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so470964a12.1
        for <stable@vger.kernel.org>; Fri, 01 Dec 2023 06:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701441286; x=1702046086; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CENPHh1/SC8IquIWNwckiygylz3Hg/zRqIk4NHmIAm8=;
        b=mjraH5A3Pffn0a3nSNuVK8dlEJwQCB3ldU43glPDTseZtl/rrAAUnW24dAGz2kfRfr
         DtRY9tI0MHSVSq2I1lhUD5s1oX8BCv6GNNfcVT3OCTc2V9UYXET9cjRdkwfaU9vxxoPz
         WYRpfnTBEgVlQKhjFFMoxXYF6IjwaVROp4VpxNHfTfqbQXElkk9qi/TQ/bXamSkQBKpJ
         6BO17ReAxpxrMA+jj+PLpG5wcWrx7x+vhqCwFUZfah9xvhED/0G/VBA1Ksup7EqQFkVt
         hOsLQOuSmIf8hApec/dBg6T3iMMDPCF0ilINS0tmu3CRoNnulMsHHd5s5Kfi8p1jYBe3
         3aSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701441286; x=1702046086;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CENPHh1/SC8IquIWNwckiygylz3Hg/zRqIk4NHmIAm8=;
        b=c7zdp5UhW6QQa+Ci0ReAvoXtcKrfgZflnlrDAZIJXQk8sYY4TvbztYPc8F5MUhxOkb
         bx1mxEyyalRH9iTgA7v8Aa9bwcVMPY/kGA+3C5ncEHh904c91ptgEsxs1tg+IqC9Vtj+
         YhB7/5VDLfavbmmpm4JgRJVkhhrnuvQv6jEokMf3sWzf4aZJF1ZL1skML9mh4UbFn0fT
         oxmwS2NugJUy8z/U2LtNGmR9Icf3njZMNBSR1VcFvYr2BOyFU7SIygQr/SjRRmGm9oAE
         RrNFonwmOpScq0De2jZRozXH1x7H20FPKvzs8x3gRUzleJ/ZU+IQk+exzamukaVEfhXK
         G7zQ==
X-Gm-Message-State: AOJu0Yxp4QQeLqdUgTsLfPj4w+XENcKLtheCHiavjtQqzF7XORJQt3rT
	ujv7I0acoEpsVSn3wdJ2kxLKlRfb84jgVdZhcCar0A==
X-Google-Smtp-Source: AGHT+IFaDcoEsHY3UYalwkSACRpiVvsNlUOWwET+6M27fLO4i/GtMERbX0cLlXbBtoiYpjBiLjytog==
X-Received: by 2002:a05:6a20:9e4c:b0:187:d93f:b0fa with SMTP id mt12-20020a056a209e4c00b00187d93fb0famr30074190pzb.27.1701441285884;
        Fri, 01 Dec 2023 06:34:45 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b24-20020aa78718000000b006cde18e6bf5sm3177673pfo.10.2023.12.01.06.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 06:34:45 -0800 (PST)
Message-ID: <6569ef05.a70a0220.f2c82.a420@mx.google.com>
Date: Fri, 01 Dec 2023 06:34:45 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.64-82-g8d1d7f9dd3868
Subject: stable-rc/queue/6.1 baseline: 148 runs,
 3 regressions (v6.1.64-82-g8d1d7f9dd3868)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 148 runs, 3 regressions (v6.1.64-82-g8d1d7f9d=
d3868)

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
el/v6.1.64-82-g8d1d7f9dd3868/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.64-82-g8d1d7f9dd3868
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      8d1d7f9dd38685e0f1fadcf836e14843c1167b8f =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6569bcbcab969f2930e13498

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.64-82=
-g8d1d7f9dd3868/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.64-82=
-g8d1d7f9dd3868/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6569bcbcab969f2930e1349d
        failing since 8 days (last pass: v6.1.31-26-gef50524405c2, first fa=
il: v6.1.63-176-gecc0fed1ffa4)

    2023-12-01T11:06:28.468354  / # #

    2023-12-01T11:06:28.570408  export SHELL=3D/bin/sh

    2023-12-01T11:06:28.571135  #

    2023-12-01T11:06:28.672524  / # export SHELL=3D/bin/sh. /lava-12149657/=
environment

    2023-12-01T11:06:28.673271  =


    2023-12-01T11:06:28.774726  / # . /lava-12149657/environment/lava-12149=
657/bin/lava-test-runner /lava-12149657/1

    2023-12-01T11:06:28.775811  =


    2023-12-01T11:06:28.782090  / # /lava-12149657/bin/lava-test-runner /la=
va-12149657/1

    2023-12-01T11:06:28.841372  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-01T11:06:28.841871  + cd /lav<8>[   19.097545] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12149657_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6569bca71477772a74e134fb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.64-82=
-g8d1d7f9dd3868/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.64-82=
-g8d1d7f9dd3868/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6569bca81477772a74e13500
        failing since 8 days (last pass: v6.1.22-372-g971903477e72, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-01T10:59:46.337183  <8>[   18.104175] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 446077_1.5.2.4.1>
    2023-12-01T10:59:46.442234  / # #
    2023-12-01T10:59:46.543846  export SHELL=3D/bin/sh
    2023-12-01T10:59:46.544438  #
    2023-12-01T10:59:46.645432  / # export SHELL=3D/bin/sh. /lava-446077/en=
vironment
    2023-12-01T10:59:46.646035  =

    2023-12-01T10:59:46.747036  / # . /lava-446077/environment/lava-446077/=
bin/lava-test-runner /lava-446077/1
    2023-12-01T10:59:46.747940  =

    2023-12-01T10:59:46.752372  / # /lava-446077/bin/lava-test-runner /lava=
-446077/1
    2023-12-01T10:59:46.831378  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6569bcceab969f2930e13500

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.64-82=
-g8d1d7f9dd3868/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.64-82=
-g8d1d7f9dd3868/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6569bcceab969f2930e13505
        failing since 8 days (last pass: v6.1.22-372-g971903477e72, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-01T11:06:41.082384  / # #

    2023-12-01T11:06:41.184481  export SHELL=3D/bin/sh

    2023-12-01T11:06:41.185211  #

    2023-12-01T11:06:41.286541  / # export SHELL=3D/bin/sh. /lava-12149661/=
environment

    2023-12-01T11:06:41.287255  =


    2023-12-01T11:06:41.388579  / # . /lava-12149661/environment/lava-12149=
661/bin/lava-test-runner /lava-12149661/1

    2023-12-01T11:06:41.389685  =


    2023-12-01T11:06:41.406682  / # /lava-12149661/bin/lava-test-runner /la=
va-12149661/1

    2023-12-01T11:06:41.472748  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-01T11:06:41.473290  + cd /lava-1214966<8>[   19.217135] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12149661_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

