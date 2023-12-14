Return-Path: <stable+bounces-6770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A3A813BA6
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 21:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9AA81C20EDC
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 20:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7B61110;
	Thu, 14 Dec 2023 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="kRm7qTNq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E04C2112
	for <stable@vger.kernel.org>; Thu, 14 Dec 2023 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d351cb8b82so12604115ad.3
        for <stable@vger.kernel.org>; Thu, 14 Dec 2023 12:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702586428; x=1703191228; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C8nbQBNrKj5RaU4fOdIveZKd+hkY5ahnLBvQRHFBU/4=;
        b=kRm7qTNqbKK62jrbtiYJgLnOmxCbcuvMPs8iKZStl2YFU1Io3h8o59q3FuZCdAQWX2
         sTUSaXhytiJSGgRzO+a04NJzjnbRGuSN2n93Nzcds4a6AtgCbkqX8lwjuDrAS1mb0eSu
         DvMFEVLapO2vfwU+IiLsBRRX6BEFD5QxLahMTCwOkUkdC61gzGGwexzOjc/URMAbbRZq
         4yQBGz5g6h6mmwjG6oT8xaXtORs2EyjyMendQqBC8GAH5q+cEU73g7zTl9XOZn1+OFK1
         o72GQxat7FMgiqa5aNyBsK4VodRWq+36I8BOiH3hZ0QDXrhpGOMLLiMK2dcx52KQxa4d
         leTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702586428; x=1703191228;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C8nbQBNrKj5RaU4fOdIveZKd+hkY5ahnLBvQRHFBU/4=;
        b=X++7HgOIK3NBz1XV3JNsv5xTLzhwEthgxFEmGufZ0Ijt313xx1jB5aJTlXzGsW1sYi
         1tAztEHCi44Q5q5hM3rMCCLXXXFNEEG1EbkXUUx2hMiKU8n4zsPQ9EDfg6LcqHvR/vgo
         v+XujGet2hGNMiLcvmo2Qy1cZgXpL70emwX/qNd4hy24SmVnVggwfItW/mnsAEx0Og3v
         5bdr7YjV8TtKbVVXFvhzOAH85QnZ8lo0U2D3vQ0SJ+lm+unwmn81y1uVEmOT/QZsB5WL
         1jlFVrlDyz2z/8F8lzinwPWCsYA1rfZ0KAW9k92XQbbyJSIP3RpIVG/Fmr8FRj2FnuO9
         MqDQ==
X-Gm-Message-State: AOJu0YxWENXmyUSWvG8AgR/YD66+Wo2LGv+ZWMHW+JW7IOLfsP9fXfii
	uoJmj+LdaRIuu4meRG4a3RCdSSaFYzlJdeaFj+k=
X-Google-Smtp-Source: AGHT+IGF24hITZX1MJazB1th1pcdeQgDs/w8M/xW1bpPmHyyAgOPtKw6qTeDiIjLkzuRWdauujy3VQ==
X-Received: by 2002:a17:902:b70d:b0:1d0:8e06:fbf6 with SMTP id d13-20020a170902b70d00b001d08e06fbf6mr4612242pls.133.1702586428319;
        Thu, 14 Dec 2023 12:40:28 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ix6-20020a170902f80600b001d3623bae2asm2261772plb.254.2023.12.14.12.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 12:40:27 -0800 (PST)
Message-ID: <657b683b.170a0220.29d05.9566@mx.google.com>
Date: Thu, 14 Dec 2023 12:40:27 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.143-19-ga90a765613123
Subject: stable-rc/queue/5.15 baseline: 106 runs,
 3 regressions (v5.15.143-19-ga90a765613123)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 106 runs, 3 regressions (v5.15.143-19-ga90a7=
65613123)

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


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.143-19-ga90a765613123/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.143-19-ga90a765613123
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      a90a765613123cce217f9cb6299d64446f968ee5 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657b32e06323e3416ee134f6

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-19-ga90a765613123/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-19-ga90a765613123/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657b32e06323e3416ee134fb
        failing since 22 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-14T17:00:01.642887  / # #

    2023-12-14T17:00:01.744979  export SHELL=3D/bin/sh

    2023-12-14T17:00:01.745717  #

    2023-12-14T17:00:01.847070  / # export SHELL=3D/bin/sh. /lava-12273090/=
environment

    2023-12-14T17:00:01.847731  =


    2023-12-14T17:00:01.948755  / # . /lava-12273090/environment/lava-12273=
090/bin/lava-test-runner /lava-12273090/1

    2023-12-14T17:00:01.949003  =


    2023-12-14T17:00:01.950592  / # /lava-12273090/bin/lava-test-runner /la=
va-12273090/1

    2023-12-14T17:00:02.014768  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-14T17:00:02.014831  + cd /lav<8>[   15.968036] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12273090_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657b32c36323e3416ee13475

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-19-ga90a765613123/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-19-ga90a765613123/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657b32c36323e3416ee1347a
        failing since 22 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-14T16:52:10.653686  <8>[   16.115981] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 448102_1.5.2.4.1>
    2023-12-14T16:52:10.758652  / # #
    2023-12-14T16:52:10.860338  export SHELL=3D/bin/sh
    2023-12-14T16:52:10.860911  #
    2023-12-14T16:52:10.961930  / # export SHELL=3D/bin/sh. /lava-448102/en=
vironment
    2023-12-14T16:52:10.962538  =

    2023-12-14T16:52:11.063531  / # . /lava-448102/environment/lava-448102/=
bin/lava-test-runner /lava-448102/1
    2023-12-14T16:52:11.064439  =

    2023-12-14T16:52:11.069018  / # /lava-448102/bin/lava-test-runner /lava=
-448102/1
    2023-12-14T16:52:11.101081  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657b32e16323e3416ee13501

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-19-ga90a765613123/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-19-ga90a765613123/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657b32e16323e3416ee13506
        failing since 22 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-14T17:00:16.227436  / # #

    2023-12-14T17:00:16.329697  export SHELL=3D/bin/sh

    2023-12-14T17:00:16.330428  #

    2023-12-14T17:00:16.431800  / # export SHELL=3D/bin/sh. /lava-12273101/=
environment

    2023-12-14T17:00:16.432575  =


    2023-12-14T17:00:16.534064  / # . /lava-12273101/environment/lava-12273=
101/bin/lava-test-runner /lava-12273101/1

    2023-12-14T17:00:16.535237  =


    2023-12-14T17:00:16.552025  / # /lava-12273101/bin/lava-test-runner /la=
va-12273101/1

    2023-12-14T17:00:16.611183  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-14T17:00:16.611689  + cd /lava-1227310<8>[   16.826967] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12273101_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

