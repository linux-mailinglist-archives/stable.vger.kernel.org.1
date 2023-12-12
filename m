Return-Path: <stable+bounces-6432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A23DA80E976
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 11:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58554281675
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 10:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D79F5C908;
	Tue, 12 Dec 2023 10:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="QoY/WF3c"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34582B7
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 02:47:47 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1d0c4d84bf6so31339155ad.1
        for <stable@vger.kernel.org>; Tue, 12 Dec 2023 02:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702378066; x=1702982866; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/4m7ws1HrzZtG4mmytoHhmeZXC5+CufmvULqY/uADf4=;
        b=QoY/WF3cHgIGrY8TImLOZwUotJuvXVmo0vFLR1FWDsQkecpgY/w8qhWfkhWUjhsVTb
         9ESTLJfoR5N0qXXXba5Flo3/67HJb+ZuHfeC6o9/JXpSFoEr9noYld31DAnobvbp/XdK
         oajXL87TlT1Iyiv81xDenR6nIqpCBioGhDk/+Fqj6ZYTbVEcaB+bj6hqr9BrETYXCuwi
         fcmsYIrolJu9L/RmO8mtOTib364LDPAM2fv4dPV1qvWqU6semLiwBFfY7J2y9A9u8tlH
         2yDL9kYZ5wBbDQPX5+EY8+y9E/QHojTjGbw17dZ1UjGaieN6D4hqCPeXKHQ0UTHUATcE
         BMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702378066; x=1702982866;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/4m7ws1HrzZtG4mmytoHhmeZXC5+CufmvULqY/uADf4=;
        b=CHuqAuALdkr+SyHHzZIGgo6CcJfFsVw8GLNzeSFC/OTKCVTIpZIQtJg6uNfxSDObIU
         bC+69uoiYG/Uyl/ZZYFcGi7KuZC3dr2YxQHGGDH5uKGcU9oYe3yIbbGwLJvzolrQnr3N
         M15NuQi8ZxHWUYnur6Qr/m7sf+hwTVH95q4fsggoKScr5H0L27Hpx//H7Aa6YJcyxX1d
         BfNsrflsQdpvznjd0I+Rii/7tJXpxbY6kgJCZLlD5aVglnzWX64R7N3b+ELnari4/Ef4
         teMam/YNCs70xvDJ9Wzb89D5r+8xtL7qPvUuxTKgifRn7fRKKq8W6ujFuYoauU3AJ17s
         tJYw==
X-Gm-Message-State: AOJu0Yz8ppoXeN0M3Inv8FIc6YJg45W7jn9WJbzWk9sO2ANb0zEXfNbm
	UDm+FjkY1w3sNFBGdlMec4kVNOClqr+wI3cL5VPxmg==
X-Google-Smtp-Source: AGHT+IHAUImDz7JtNfUlT88D+psRvjTwowbojr2AX+/FoYzpwCmGa9em2Q3sPZ79d7F5UbsiPF2DTg==
X-Received: by 2002:a17:902:b686:b0:1d2:f458:baf with SMTP id c6-20020a170902b68600b001d2f4580bafmr2693931pls.66.1702378066115;
        Tue, 12 Dec 2023 02:47:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d1-20020a170902728100b001d087820175sm8275548pll.40.2023.12.12.02.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 02:47:45 -0800 (PST)
Message-ID: <65783a51.170a0220.bd01.7ef7@mx.google.com>
Date: Tue, 12 Dec 2023 02:47:45 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.67-194-g4d98cff86b0fc
Subject: stable-rc/queue/6.1 baseline: 110 runs,
 3 regressions (v6.1.67-194-g4d98cff86b0fc)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 110 runs, 3 regressions (v6.1.67-194-g4d98cff=
86b0fc)

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
el/v6.1.67-194-g4d98cff86b0fc/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.67-194-g4d98cff86b0fc
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      4d98cff86b0fc36bff804a47ed7f62b0c09c58e2 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6578177a0c9d3ca870e1349e

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.67-19=
4-g4d98cff86b0fc/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.67-19=
4-g4d98cff86b0fc/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6578177a0c9d3ca870e134a7
        failing since 19 days (last pass: v6.1.31-26-gef50524405c2, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-12T08:26:23.208247  / # #

    2023-12-12T08:26:23.310327  export SHELL=3D/bin/sh

    2023-12-12T08:26:23.311110  #

    2023-12-12T08:26:23.412472  / # export SHELL=3D/bin/sh. /lava-12251672/=
environment

    2023-12-12T08:26:23.413155  =


    2023-12-12T08:26:23.514556  / # . /lava-12251672/environment/lava-12251=
672/bin/lava-test-runner /lava-12251672/1

    2023-12-12T08:26:23.515696  =


    2023-12-12T08:26:23.532502  / # /lava-12251672/bin/lava-test-runner /la=
va-12251672/1

    2023-12-12T08:26:23.581437  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-12T08:26:23.581961  + cd /lav<8>[   19.088177] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12251672_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6578060d0c6f816d04e13480

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.67-19=
4-g4d98cff86b0fc/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.67-19=
4-g4d98cff86b0fc/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6578060d0c6f816d04e13489
        failing since 19 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-12T07:04:39.410090  <8>[   18.060020] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447698_1.5.2.4.1>
    2023-12-12T07:04:39.515041  / # #
    2023-12-12T07:04:39.616715  export SHELL=3D/bin/sh
    2023-12-12T07:04:39.617392  #
    2023-12-12T07:04:39.718388  / # export SHELL=3D/bin/sh. /lava-447698/en=
vironment
    2023-12-12T07:04:39.719082  =

    2023-12-12T07:04:39.820085  / # . /lava-447698/environment/lava-447698/=
bin/lava-test-runner /lava-447698/1
    2023-12-12T07:04:39.820975  =

    2023-12-12T07:04:39.825468  / # /lava-447698/bin/lava-test-runner /lava=
-447698/1
    2023-12-12T07:04:39.904479  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6578063640778a21f9e1354d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.67-19=
4-g4d98cff86b0fc/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.67-19=
4-g4d98cff86b0fc/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6578063640778a21f9e13556
        failing since 19 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-12T07:12:49.909271  / # #

    2023-12-12T07:12:50.009773  export SHELL=3D/bin/sh

    2023-12-12T07:12:50.009889  #

    2023-12-12T07:12:50.110483  / # export SHELL=3D/bin/sh. /lava-12251669/=
environment

    2023-12-12T07:12:50.110615  =


    2023-12-12T07:12:50.211117  / # . /lava-12251669/environment/lava-12251=
669/bin/lava-test-runner /lava-12251669/1

    2023-12-12T07:12:50.211310  =


    2023-12-12T07:12:50.222806  / # /lava-12251669/bin/lava-test-runner /la=
va-12251669/1

    2023-12-12T07:12:50.294073  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-12T07:12:50.294491  + cd /lava-1225166<8>[   19.139358] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12251669_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

