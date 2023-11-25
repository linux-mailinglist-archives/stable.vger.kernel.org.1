Return-Path: <stable+bounces-2568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EAA7F878A
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 02:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A74F1281E4B
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 01:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4AC819;
	Sat, 25 Nov 2023 01:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="nDOLP1my"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC7419A7
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 17:28:46 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6ce322b62aeso1291943a34.3
        for <stable@vger.kernel.org>; Fri, 24 Nov 2023 17:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700875725; x=1701480525; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z+7QRRaQ58BQnVJi1FkCx+avF0wYukQxPfrJHdo+iA8=;
        b=nDOLP1myhzI6NWQgctb7YdoQPIBlixgEpVTQACMDQfuXX7fxc/0GyPTOVQK4bF91qs
         d2WIr0Stmf0KX9iTSz2knfuRfK15oHpQvzhyjPXL/3Y6YCzTLmXzpGBduTr834HcFnVs
         lvl7XITySrvBG7oAbabQU01dwWVLfDyuzWPyteiIBKPvpeASLT+QGapzju72YQZqGgbm
         KDptqRJY6sjk006WigC5rxVTbrZE6jGWQ0fiOhKx/k2XTdx3VNGRDcowWPAQ5OI1WAEf
         +pUIZvZSheYQy9UbFpB36HQs/wSEtZZecgVQEktYEX0s3vG74AX5fDOoUMEHPUDOUAcW
         0B6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700875725; x=1701480525;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z+7QRRaQ58BQnVJi1FkCx+avF0wYukQxPfrJHdo+iA8=;
        b=LJPlZyEbCsHXlOPBbiqRyW+Cx588vbF/71bkmfp/WcXYhn9HsGRoUgElIzojIFCGZc
         HaqGwZkJli8HHxRFHgZT6Y3FNtN6x1QBjFBaX5P6lILq4A9wh853Sqt5TIUss4xrDbyP
         znkbti1W2FjrsHyIEV67Kx2WI7pvAurVq/3DGzec6BmD/xA3Hd20NL00K7WFecxXWoQI
         FL7wuR0LQSfGFibbOAMDCN9ffne/k8PAhFaqzlIzJ6mLdhXaVzM61ODqkviAAH+le2Hb
         pOrmbp69tnv5KfWhj10oZ5oYsQhD2mAWvq5g0ReC6VXp+V/2k56mlf0cKlnDoS0CVsa5
         L66A==
X-Gm-Message-State: AOJu0YyA9APhxLyMZ2cK/iIE/4WStpn07+xZX4A19mfRWI/oo2ZzrI57
	GslF9RkUkxiKZO+UEMi9lK77pM9Fj4PwY3e0Oog=
X-Google-Smtp-Source: AGHT+IHFbkAPgjmISWttFd/JERa+9vnD1OXM4kAx3AY2OP/1+kjcMnUh2a8cX/KjZnwkLzietldQsA==
X-Received: by 2002:a05:6830:448c:b0:6d8:134b:23e2 with SMTP id r12-20020a056830448c00b006d8134b23e2mr359051otv.0.1700875725095;
        Fri, 24 Nov 2023 17:28:45 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e17-20020a656891000000b005b7e803e672sm3186602pgt.5.2023.11.24.17.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 17:28:44 -0800 (PST)
Message-ID: <65614dcc.650a0220.a76fa.7a66@mx.google.com>
Date: Fri, 24 Nov 2023 17:28:44 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.63-372-g864c65286fa4c
Subject: stable-rc/queue/6.1 baseline: 140 runs,
 3 regressions (v6.1.63-372-g864c65286fa4c)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 140 runs, 3 regressions (v6.1.63-372-g864c652=
86fa4c)

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
el/v6.1.63-372-g864c65286fa4c/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.63-372-g864c65286fa4c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      864c65286fa4c167631e562c3be95b8b75f8e912 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65611bfb7db3f372927e4a7a

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-37=
2-g864c65286fa4c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-37=
2-g864c65286fa4c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65611bfb7db3f372927e4a83
        failing since 2 days (last pass: v6.1.31-26-gef50524405c2, first fa=
il: v6.1.63-176-gecc0fed1ffa4)

    2023-11-24T22:02:31.220579  / # #

    2023-11-24T22:02:31.322349  export SHELL=3D/bin/sh

    2023-11-24T22:02:31.322933  #

    2023-11-24T22:02:31.424110  / # export SHELL=3D/bin/sh. /lava-12078832/=
environment

    2023-11-24T22:02:31.424690  =


    2023-11-24T22:02:31.525805  / # . /lava-12078832/environment/lava-12078=
832/bin/lava-test-runner /lava-12078832/1

    2023-11-24T22:02:31.526755  =


    2023-11-24T22:02:31.529564  / # /lava-12078832/bin/lava-test-runner /la=
va-12078832/1

    2023-11-24T22:02:31.592183  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-24T22:02:31.592645  + cd /lav<8>[   19.123482] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12078832_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65611be8c6e3ae005b7e4abe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-37=
2-g864c65286fa4c/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-37=
2-g864c65286fa4c/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65611be8c6e3ae005b7e4ac7
        failing since 2 days (last pass: v6.1.22-372-g971903477e72, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-11-24T21:55:46.820744  <8>[   18.125560] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 445189_1.5.2.4.1>
    2023-11-24T21:55:46.925854  / # #
    2023-11-24T21:55:47.027576  export SHELL=3D/bin/sh
    2023-11-24T21:55:47.028185  #
    2023-11-24T21:55:47.129188  / # export SHELL=3D/bin/sh. /lava-445189/en=
vironment
    2023-11-24T21:55:47.129798  =

    2023-11-24T21:55:47.230845  / # . /lava-445189/environment/lava-445189/=
bin/lava-test-runner /lava-445189/1
    2023-11-24T21:55:47.231765  =

    2023-11-24T21:55:47.235895  / # /lava-445189/bin/lava-test-runner /lava=
-445189/1
    2023-11-24T21:55:47.308972  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65611c0f580a6e60fe7e4a84

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-37=
2-g864c65286fa4c/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-37=
2-g864c65286fa4c/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65611c0f580a6e60fe7e4a8d
        failing since 2 days (last pass: v6.1.22-372-g971903477e72, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-11-24T22:02:45.147112  / # #

    2023-11-24T22:02:45.249090  export SHELL=3D/bin/sh

    2023-11-24T22:02:45.249769  #

    2023-11-24T22:02:45.350953  / # export SHELL=3D/bin/sh. /lava-12078839/=
environment

    2023-11-24T22:02:45.351691  =


    2023-11-24T22:02:45.453030  / # . /lava-12078839/environment/lava-12078=
839/bin/lava-test-runner /lava-12078839/1

    2023-11-24T22:02:45.454149  =


    2023-11-24T22:02:45.471108  / # /lava-12078839/bin/lava-test-runner /la=
va-12078839/1

    2023-11-24T22:02:45.535987  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-24T22:02:45.536437  + cd /lava-1207883<8>[   18.776758] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12078839_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

