Return-Path: <stable+bounces-2671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AD97F9137
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 05:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F52EB20EBD
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 04:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0B61FD2;
	Sun, 26 Nov 2023 04:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="qfzokwWS"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DE9AF
	for <stable@vger.kernel.org>; Sat, 25 Nov 2023 20:15:53 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1fa2b8f7f27so375275fac.0
        for <stable@vger.kernel.org>; Sat, 25 Nov 2023 20:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700972150; x=1701576950; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xd9AK5iWLQ0b3ADZOlkvv24itJBnWUEtDo8X8bHD408=;
        b=qfzokwWSa2oeVg28GxfIkFZl83yGBFl0+V421tlT35erhKSqnOJWWsIwmZrMOFoeK0
         c2kh+cHAIhHLJI+BD+yvvQDpU96K597y+o9q6JMYQNCoOTP8VcnJF7ID6/eUu6DHJVvY
         9Ct83BEr68xvT/yAYmiijvQ0ZmxK3AZl3qR1PSPKhptv0nSmsRRDHU1TtZxk8dxt+TWh
         Ng0i26r5LbHdwvB+firta876FMK34Klw3t2K4fbwtBLtu7BQcqap/ME4HNw3W1/qjCxU
         q+1gDYFj+H9nQ4xKZ9qfrwqy0qecpk2KWuUgY00CACcYIXpvOVqxAuRd05Sp7eUZk5i1
         nacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700972150; x=1701576950;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xd9AK5iWLQ0b3ADZOlkvv24itJBnWUEtDo8X8bHD408=;
        b=xJ5SjFZtB+wLW9e5Equ91ziaMIsj3WpzYyxoYqsbVg27cm8GDw8eGNJiuRes5Np5Pa
         NOYwEjGfx38Xo57AIaLiFZwtbS62z3sjC7mG3cZNvbzgBaXVysLSI5uS41C0If+wtYC/
         jB66XeOEENpfUR8pNM7rv3q6g5o+owHWt8Ur2k3f3na8njPneV/VCjP2P4KeVHCMcB3L
         9fI49bV5aZrew25zn1xYuyBe2bphBsS4CqsrrHNG1JQN8R8myufubEBSFOOccQ8hT5jp
         ma/TgdsH9NdXlV/dGUPoCgKiFUe+/38Ui40eF9jdeyCZoejlOZ/GofptcTxMgoTawF6O
         78uQ==
X-Gm-Message-State: AOJu0YyvDG6vKyqOvxrDtFgqTWGrdS7cZ0HMKc/IzT7AjpUfhSsjGG32
	OxzouYcsxuyA3zzKziZdEPKO6gC6RkQVo7j6KpE=
X-Google-Smtp-Source: AGHT+IHt7meSbn0Yz9KX4qw9VZOJjLOg4wIfXZhnL+Huua74jmZYFicmoiHiQNL3NBUTtU4vrs+4Ag==
X-Received: by 2002:a05:6870:8092:b0:1f9:6247:4d05 with SMTP id q18-20020a056870809200b001f962474d05mr9457374oab.22.1700972150144;
        Sat, 25 Nov 2023 20:15:50 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k4-20020a170902c40400b001cc50146b43sm5679274plk.202.2023.11.25.20.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 20:15:49 -0800 (PST)
Message-ID: <6562c675.170a0220.2a0e6.d18d@mx.google.com>
Date: Sat, 25 Nov 2023 20:15:49 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.139-293-g3fa31be92843c
Subject: stable-rc/queue/5.15 baseline: 118 runs,
 3 regressions (v5.15.139-293-g3fa31be92843c)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 118 runs, 3 regressions (v5.15.139-293-g3fa3=
1be92843c)

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
nel/v5.15.139-293-g3fa31be92843c/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.139-293-g3fa31be92843c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      3fa31be92843c767f6f890e52b4caa0a475e21e9 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65629270a93c23c0ee7e4b00

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-293-g3fa31be92843c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-293-g3fa31be92843c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65629270a93c23c0ee7e4b09
        failing since 3 days (last pass: v5.15.114-13-g095e387c3889, first =
fail: v5.15.139-172-gb60494a37c0c)

    2023-11-26T00:40:12.122946  / # #

    2023-11-26T00:40:12.223385  export SHELL=3D/bin/sh

    2023-11-26T00:40:12.223484  #

    2023-11-26T00:40:12.323890  / # export SHELL=3D/bin/sh. /lava-12085641/=
environment

    2023-11-26T00:40:12.324022  =


    2023-11-26T00:40:12.424454  / # . /lava-12085641/environment/lava-12085=
641/bin/lava-test-runner /lava-12085641/1

    2023-11-26T00:40:12.424625  =


    2023-11-26T00:40:12.436830  / # /lava-12085641/bin/lava-test-runner /la=
va-12085641/1

    2023-11-26T00:40:12.490580  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-26T00:40:12.490652  + cd /lav<8>[   16.078657] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12085641_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6562926b1801b41b407e4ae1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-293-g3fa31be92843c/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-293-g3fa31be92843c/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6562926b1801b41b407e4aea
        failing since 3 days (last pass: v5.15.105-206-g4548859116b8, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-11-26T00:33:37.826102  <8>[   16.102130] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 445320_1.5.2.4.1>
    2023-11-26T00:33:37.931137  / # #
    2023-11-26T00:33:38.032745  export SHELL=3D/bin/sh
    2023-11-26T00:33:38.033317  #
    2023-11-26T00:33:38.134322  / # export SHELL=3D/bin/sh. /lava-445320/en=
vironment
    2023-11-26T00:33:38.134907  =

    2023-11-26T00:33:38.235921  / # . /lava-445320/environment/lava-445320/=
bin/lava-test-runner /lava-445320/1
    2023-11-26T00:33:38.236847  =

    2023-11-26T00:33:38.241335  / # /lava-445320/bin/lava-test-runner /lava=
-445320/1
    2023-11-26T00:33:38.273456  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65629283a93c23c0ee7e4b8a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-293-g3fa31be92843c/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-293-g3fa31be92843c/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65629283a93c23c0ee7e4b93
        failing since 3 days (last pass: v5.15.105-206-g4548859116b8, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-11-26T00:40:26.825984  / # #

    2023-11-26T00:40:26.927789  export SHELL=3D/bin/sh

    2023-11-26T00:40:26.928449  #

    2023-11-26T00:40:27.029774  / # export SHELL=3D/bin/sh. /lava-12085648/=
environment

    2023-11-26T00:40:27.030481  =


    2023-11-26T00:40:27.131559  / # . /lava-12085648/environment/lava-12085=
648/bin/lava-test-runner /lava-12085648/1

    2023-11-26T00:40:27.131805  =


    2023-11-26T00:40:27.134363  / # /lava-12085648/bin/lava-test-runner /la=
va-12085648/1

    2023-11-26T00:40:27.177290  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-26T00:40:27.207722  + cd /lava-1208564<8>[   16.775929] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12085648_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

