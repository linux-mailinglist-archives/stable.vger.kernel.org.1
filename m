Return-Path: <stable+bounces-8295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 513C781C3C7
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 05:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74BC31C21360
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 04:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B531C06;
	Fri, 22 Dec 2023 04:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="nOCFlDEM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6692115
	for <stable@vger.kernel.org>; Fri, 22 Dec 2023 04:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-28bf1410e37so1041938a91.2
        for <stable@vger.kernel.org>; Thu, 21 Dec 2023 20:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703218556; x=1703823356; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+Wei+e6JkGf4gjm8+sVsP9czLPxFCrPgG4y3BpN5/CU=;
        b=nOCFlDEMGf0cypxKTWMt4WmWHgCppQxhAtj4HKAh5NGsAygdxsvwMsqb3jt6cMOXCM
         Qdj1oArXPVL/j4GSd1L1Rb5Mb0FpSspVwBa5hHWZmAbZEG5HIi9LGrVGszB5lBRreHlY
         Dm9AedIPrPfj2vXlw/+A9WtpnaTmTNyG2fcCb4pvIeVHYfFWxuQaCzjspMV1ZD/tACGW
         MkHqsErMsd+t4KiHvhVXCno0xEleWs5JK7jJNK6lTgcrQUJ/rBl15BDjKFmvi0U0GkxZ
         exxHuSxGEi4qrHBd6rs9bVxSJhSMERbO5nl/mMOPnXKJinOurEx7C1T55dVGlN7zpfHz
         vM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703218556; x=1703823356;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Wei+e6JkGf4gjm8+sVsP9czLPxFCrPgG4y3BpN5/CU=;
        b=OGkdKMEAurNF1vVbB0QQXurW3efjOdnr5DD9drlyi/c0MuibYksJuIG7obMDvxu1G+
         csALH4gNy4JpYCZ/9k9UcyZhuZjKTeLIiiAT47zEEZuIJxqnloJHDkTCWVDRFLzf45tU
         2e1Pn42/79FPq6+0KGAWbUEpU7dLNKKQky3LJaPDtkE0YdTeJUT5TAhKc6YVHnaoveD5
         gYtXvvnxKoZBez8mUC3NKUuyDMyTAWbBnrHw0seOqvIetYrv1MLiPxKV54YskFv/kGvd
         jyr9cVZyZuBhY0hr/qPaJ+jEKOWu/DBQXQ9EzDtuSY9u5eQ6kPFjXHPCujsRGEeryGvB
         3Dtg==
X-Gm-Message-State: AOJu0YxEyyjwMzkyC6jycHq3KzIyv1GutSy6ukMiy6JtD0LEwNIAq91P
	v/P97syi5ZhRqZkwomLyqF1TSpoh9BWDCwOyP+rMtLlWlQs=
X-Google-Smtp-Source: AGHT+IF2/ylkMH5QRuaRcg/vG3heGdUVRwlFTB1xBT0jdB4KeUJ2mlH2O0VwkHe+vf7b0wnWMom9Ag==
X-Received: by 2002:a17:902:7c05:b0:1d3:fa1d:28d0 with SMTP id x5-20020a1709027c0500b001d3fa1d28d0mr668538pll.68.1703218555674;
        Thu, 21 Dec 2023 20:15:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d5-20020a170903230500b001d3ebfb2006sm2424827plh.203.2023.12.21.20.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 20:15:55 -0800 (PST)
Message-ID: <65850d7b.170a0220.46166.8a61@mx.google.com>
Date: Thu, 21 Dec 2023 20:15:55 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.143-85-gef5e184bcb5f3
Subject: stable-rc/queue/5.15 baseline: 104 runs,
 3 regressions (v5.15.143-85-gef5e184bcb5f3)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 104 runs, 3 regressions (v5.15.143-85-gef5e1=
84bcb5f3)

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
nel/v5.15.143-85-gef5e184bcb5f3/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.143-85-gef5e184bcb5f3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      ef5e184bcb5f3472f74fbc5ec2a19e99357ccc53 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6584d88258cd5ec24de13488

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-85-gef5e184bcb5f3/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-85-gef5e184bcb5f3/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6584d88258cd5ec24de1348d
        failing since 29 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-22T00:37:03.358129  / # #

    2023-12-22T00:37:03.458655  export SHELL=3D/bin/sh

    2023-12-22T00:37:03.458774  #

    2023-12-22T00:37:03.559254  / # export SHELL=3D/bin/sh. /lava-12344886/=
environment

    2023-12-22T00:37:03.559369  =


    2023-12-22T00:37:03.659888  / # . /lava-12344886/environment/lava-12344=
886/bin/lava-test-runner /lava-12344886/1

    2023-12-22T00:37:03.660097  =


    2023-12-22T00:37:03.671868  / # /lava-12344886/bin/lava-test-runner /la=
va-12344886/1

    2023-12-22T00:37:03.725722  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-22T00:37:03.725803  + cd /lav<8>[   15.979028] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12344886_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6584d86c5f6e05b90be1348c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-85-gef5e184bcb5f3/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-85-gef5e184bcb5f3/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6584d86c5f6e05b90be13491
        failing since 29 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-22T00:29:23.062387  / # #
    2023-12-22T00:29:23.164021  export SHELL=3D/bin/sh
    2023-12-22T00:29:23.164596  #
    2023-12-22T00:29:23.265580  / # export SHELL=3D/bin/sh. /lava-449349/en=
vironment
    2023-12-22T00:29:23.266141  =

    2023-12-22T00:29:23.367250  / # . /lava-449349/environment/lava-449349/=
bin/lava-test-runner /lava-449349/1
    2023-12-22T00:29:23.368148  =

    2023-12-22T00:29:23.372437  / # /lava-449349/bin/lava-test-runner /lava=
-449349/1
    2023-12-22T00:29:23.404517  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-22T00:29:23.440520  + cd /lava-449349/<8>[   16.536789] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 449349_1.5.2.4.5> =

    ... (10 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6584d880ee71b94adee13476

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-85-gef5e184bcb5f3/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-85-gef5e184bcb5f3/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6584d880ee71b94adee1347b
        failing since 29 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-22T00:37:15.492588  / # #

    2023-12-22T00:37:15.594714  export SHELL=3D/bin/sh

    2023-12-22T00:37:15.595427  #

    2023-12-22T00:37:15.696799  / # export SHELL=3D/bin/sh. /lava-12344876/=
environment

    2023-12-22T00:37:15.697523  =


    2023-12-22T00:37:15.798893  / # . /lava-12344876/environment/lava-12344=
876/bin/lava-test-runner /lava-12344876/1

    2023-12-22T00:37:15.799994  =


    2023-12-22T00:37:15.801175  / # /lava-12344876/bin/lava-test-runner /la=
va-12344876/1

    2023-12-22T00:37:15.875204  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-22T00:37:15.875717  + cd /lava-1234487<8>[   16.809107] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12344876_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

