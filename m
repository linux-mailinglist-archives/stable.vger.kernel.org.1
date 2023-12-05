Return-Path: <stable+bounces-4768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 397E2805F58
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 21:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8041C21006
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 20:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AD46DD0E;
	Tue,  5 Dec 2023 20:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="T7Zo3L1k"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12034C6
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 12:21:45 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d0c94397c0so7458785ad.2
        for <stable@vger.kernel.org>; Tue, 05 Dec 2023 12:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701807705; x=1702412505; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8z8dXTCxKYK3TtByzM6qmLrrolvsjcRQTNDjsydeq14=;
        b=T7Zo3L1kehSHmpgfA9RqtZIWv2bwjpHlTzDibxiZXETKuv00DW+Akgg8RNY1O+wNj9
         diuKb992Jm4nbvq9ZwPlxwC0q740/qnokI8aoxvep9WyOn5vx8Yghigc/8clFYM2Td3U
         QiKKgv55T46nK8jD7jWqlUb4ghbLN2z+g4oUObUOtlRTDrfLcI1cHB9SJT59MLO/l5kj
         KZ31u89THAIV+4FWYQ9SVKPIS8EKIzh6wc9Qd6UIprxjgrL/C9kopGQ9RXHoZxALsTio
         k1CIiTSw+dSKMhRQ8wjMdLLlUj+iNcnX6rod7GOAcCyo18K9ILRQqI/dduTa6KKG81bT
         Pw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701807705; x=1702412505;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8z8dXTCxKYK3TtByzM6qmLrrolvsjcRQTNDjsydeq14=;
        b=GELyAFdsX6zQXAUIvFnc27ece7VMC2Ot7sEvFKYidq/a0um5GgipvHUof9KXV3xGkq
         WtwbJ1k80QzMnGLQBMXeLrPRDqeUSCaGW0tyFTtLYu5lQacCAMh80fKiV7835rtlTag/
         5VpHiqoS0h307PUnxzJVmTKwSQApP5Q4Q6JPBjEme6hgWaLHFXlV/squI1IOfrOW65o6
         D24erfiwriKP8C5QUe1JTQ/bzTYZ4ircPLLPSsZ7BkjmxUSBFMmNC8AOeeswuhFpyBtw
         AbflVmkjbhvwLA6dRYSNRv4iG7v5+amTcTalrRpppxZvDpz3Jjot37oXt4vz1yPqNh8e
         m4OQ==
X-Gm-Message-State: AOJu0Yy7ev6l2gSp22IgDo/uo7XRkdY3toRRlb79iEPCeIBG66uJmq2d
	jL4P9Pi+U2voKFqbkRGotXHkvWrz9Oz2dzjRCdvujA==
X-Google-Smtp-Source: AGHT+IEhWk9j5JWlhH+83kocfjF7OXA4ZggsMscRwvLwtXh1YjTNrlePuLhsBekxvBvovf5qO0EZUA==
X-Received: by 2002:a17:902:8f8c:b0:1d0:6ffd:ae0a with SMTP id z12-20020a1709028f8c00b001d06ffdae0amr3611350plo.113.1701807704925;
        Tue, 05 Dec 2023 12:21:44 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x20-20020a170902821400b001cc79f3c60csm8898210pln.31.2023.12.05.12.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 12:21:44 -0800 (PST)
Message-ID: <656f8658.170a0220.b8dc3.9667@mx.google.com>
Date: Tue, 05 Dec 2023 12:21:44 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.141-67-ga00c66688b94
Subject: stable-rc/queue/5.15 baseline: 147 runs,
 3 regressions (v5.15.141-67-ga00c66688b94)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 147 runs, 3 regressions (v5.15.141-67-ga00c6=
6688b94)

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
nel/v5.15.141-67-ga00c66688b94/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.141-67-ga00c66688b94
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      a00c66688b948a18242a10ae70053097bdec7e8c =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/656f5111b84a109769e13475

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-67-ga00c66688b94/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-67-ga00c66688b94/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656f5111b84a109769e1347a
        failing since 13 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-05T16:41:40.704314  / # #

    2023-12-05T16:41:40.804923  export SHELL=3D/bin/sh

    2023-12-05T16:41:40.805147  #

    2023-12-05T16:41:40.905689  / # export SHELL=3D/bin/sh. /lava-12188578/=
environment

    2023-12-05T16:41:40.905909  =


    2023-12-05T16:41:41.006458  / # . /lava-12188578/environment/lava-12188=
578/bin/lava-test-runner /lava-12188578/1

    2023-12-05T16:41:41.006752  =


    2023-12-05T16:41:41.018099  / # /lava-12188578/bin/lava-test-runner /la=
va-12188578/1

    2023-12-05T16:41:41.060353  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-05T16:41:41.077248  + cd /lav<8>[   15.974262] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12188578_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/656f50f9b81a269e89e13480

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-67-ga00c66688b94/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine=
-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-67-ga00c66688b94/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine=
-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656f50f9b81a269e89e13485
        failing since 13 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-05T16:33:50.914229  <8>[   16.122712] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 446644_1.5.2.4.1>
    2023-12-05T16:33:51.019234  / # #
    2023-12-05T16:33:51.120968  export SHELL=3D/bin/sh
    2023-12-05T16:33:51.121617  #
    2023-12-05T16:33:51.222611  / # export SHELL=3D/bin/sh. /lava-446644/en=
vironment
    2023-12-05T16:33:51.223191  =

    2023-12-05T16:33:51.324204  / # . /lava-446644/environment/lava-446644/=
bin/lava-test-runner /lava-446644/1
    2023-12-05T16:33:51.325089  =

    2023-12-05T16:33:51.329362  / # /lava-446644/bin/lava-test-runner /lava=
-446644/1
    2023-12-05T16:33:51.361380  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/656f51254d45e4d9fbe134ad

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-67-ga00c66688b94/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-67-ga00c66688b94/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656f51254d45e4d9fbe134b2
        failing since 13 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-05T16:42:01.305626  / # #

    2023-12-05T16:42:01.407879  export SHELL=3D/bin/sh

    2023-12-05T16:42:01.408604  #

    2023-12-05T16:42:01.509952  / # export SHELL=3D/bin/sh. /lava-12188580/=
environment

    2023-12-05T16:42:01.510673  =


    2023-12-05T16:42:01.611913  / # . /lava-12188580/environment/lava-12188=
580/bin/lava-test-runner /lava-12188580/1

    2023-12-05T16:42:01.612185  =


    2023-12-05T16:42:01.614477  / # /lava-12188580/bin/lava-test-runner /la=
va-12188580/1

    2023-12-05T16:42:01.656647  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-05T16:42:01.689616  + cd /lava-1218858<8>[   16.785737] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12188580_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

