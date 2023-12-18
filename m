Return-Path: <stable+bounces-7453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 754FA81729E
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E55286966
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840E43A1D8;
	Mon, 18 Dec 2023 14:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="UxgpPSOo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB93814F63
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6d411636a95so1146674b3a.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 06:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702908504; x=1703513304; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wcMD2d+dqpE7HvHjXD40MERSZYDFTTl5IjlEXmZFjgI=;
        b=UxgpPSOo5Py/LlDXfXpxf+VKRGLMzcIPJpnB+K8KetN/MO+vroy/rDtDpp9BUohLog
         K1eRmYtHylW1cKzQ4D5xXbGYJ8lxbKgXZ3WWymWtVjQ3bMMZKjQOZICNSo6s/XkXIveS
         PtUuIB7qV1e+HwQK1mnsYx1s/Yo8YfJjNTu1dVDfUi0a7HYbabiv6angKqnxFiHjUDPR
         SQaQ9JTtIvEiV1n5e4bojWRmpXxPqo0UVNyqptdA0YGQhQ3ymATZRJyE9BKv+RJNYJYY
         V5kaJMPSgrF8k9A0H9eSkc+jqj1fJZLQMV7QvLpicJuhTwdLoxQtalJrGHHITDukxCnj
         s5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702908504; x=1703513304;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wcMD2d+dqpE7HvHjXD40MERSZYDFTTl5IjlEXmZFjgI=;
        b=tn7kkbu9mibKUF8PNWu4Hq3NTeAUMRNaTnd3KzCbZIYzD5keL1RwgxHKOY1uS+XlCm
         LkAqMcMaGJGzGL2TGCm5WkYX3fbJ3cvkttO+CuhlECigPtYMes6tiN8V2eWfs1H2LEmE
         6k1kX+BTi8tMOd6YMk73OW0ETmdG1NeN34unH46SZk7iLBvAtleMssvTjHxLkYoH3J93
         qbqnnrML6pvWcH9jEwgNPKm103eU1vJCM4kf3YcDsFzuKYdY3zTFQeG5Swfg6WCrDimu
         AlIhfaEokhpsfoGVdDLlZm7CKO39FG5XuUxmv+SuC3FuumUh7JJk0fcbfW7Siht0jx08
         YBWw==
X-Gm-Message-State: AOJu0Yyq6ma7/R3d+LCDvjl6NpqAwm30EjQUQJnyhVpDxY4V2onKn9pR
	Gtb7MFhWOApKze5+XArJ1pUouIhakCF6aVxD/T8=
X-Google-Smtp-Source: AGHT+IFNYOXvoCIB9GS6C46rwYocedWT4oy58UG4TKl/PPdwr9hMJCV7iqhz+XLasQIKr0grBpDk0g==
X-Received: by 2002:a05:6a20:ba7:b0:18f:d9ed:fcda with SMTP id i39-20020a056a200ba700b0018fd9edfcdamr17633189pzh.13.1702908503654;
        Mon, 18 Dec 2023 06:08:23 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id r3-20020aa79883000000b006cbb65edcbfsm18792753pfl.12.2023.12.18.06.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 06:08:23 -0800 (PST)
Message-ID: <65805257.a70a0220.2219b.84de@mx.google.com>
Date: Mon, 18 Dec 2023 06:08:23 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.143-84-g335ba9d04eedc
Subject: stable-rc/queue/5.15 baseline: 86 runs,
 3 regressions (v5.15.143-84-g335ba9d04eedc)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 86 runs, 3 regressions (v5.15.143-84-g335ba9=
d04eedc)

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
nel/v5.15.143-84-g335ba9d04eedc/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.143-84-g335ba9d04eedc
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      335ba9d04eedc230553316f7068c0ab9f6123253 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65801d06412362bbd9e134bd

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-84-g335ba9d04eedc/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-84-g335ba9d04eedc/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65801d06412362bbd9e134c2
        failing since 25 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-18T10:28:08.058988  / # #

    2023-12-18T10:28:08.161229  export SHELL=3D/bin/sh

    2023-12-18T10:28:08.162011  #

    2023-12-18T10:28:08.263446  / # export SHELL=3D/bin/sh. /lava-12301567/=
environment

    2023-12-18T10:28:08.264149  =


    2023-12-18T10:28:08.365653  / # . /lava-12301567/environment/lava-12301=
567/bin/lava-test-runner /lava-12301567/1

    2023-12-18T10:28:08.366795  =


    2023-12-18T10:28:08.383113  / # /lava-12301567/bin/lava-test-runner /la=
va-12301567/1

    2023-12-18T10:28:08.432691  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-18T10:28:08.433198  + cd /lav<8>[   15.970683] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12301567_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65801cf5c40fe424a7e13478

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-84-g335ba9d04eedc/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-84-g335ba9d04eedc/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65801cf5c40fe424a7e1347d
        failing since 25 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-18T10:20:15.559466  / # #
    2023-12-18T10:20:15.661070  export SHELL=3D/bin/sh
    2023-12-18T10:20:15.661568  #
    2023-12-18T10:20:15.762586  / # export SHELL=3D/bin/sh. /lava-448693/en=
vironment
    2023-12-18T10:20:15.763178  =

    2023-12-18T10:20:15.864279  / # . /lava-448693/environment/lava-448693/=
bin/lava-test-runner /lava-448693/1
    2023-12-18T10:20:15.865294  =

    2023-12-18T10:20:15.869573  / # /lava-448693/bin/lava-test-runner /lava=
-448693/1
    2023-12-18T10:20:15.901596  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-18T10:20:15.937540  + cd /lava-448693/<8>[   16.581853] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 448693_1.5.2.4.5> =

    ... (10 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65801d08b5e6224da4e134a7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-84-g335ba9d04eedc/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-84-g335ba9d04eedc/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65801d08b5e6224da4e134ac
        failing since 25 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-18T10:28:22.409107  / # #

    2023-12-18T10:28:22.511290  export SHELL=3D/bin/sh

    2023-12-18T10:28:22.512035  #

    2023-12-18T10:28:22.613522  / # export SHELL=3D/bin/sh. /lava-12301575/=
environment

    2023-12-18T10:28:22.614277  =


    2023-12-18T10:28:22.715762  / # . /lava-12301575/environment/lava-12301=
575/bin/lava-test-runner /lava-12301575/1

    2023-12-18T10:28:22.716986  =


    2023-12-18T10:28:22.733333  / # /lava-12301575/bin/lava-test-runner /la=
va-12301575/1

    2023-12-18T10:28:22.792441  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-18T10:28:22.792955  + cd /lava-1230157<8>[   16.843227] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12301575_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

