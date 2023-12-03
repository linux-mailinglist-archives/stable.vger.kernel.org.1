Return-Path: <stable+bounces-3808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A74680268D
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 20:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3A31C2074F
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 19:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE17179A4;
	Sun,  3 Dec 2023 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="FQ7NhslA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BC2DA
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 11:09:31 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2868f7b1248so504956a91.1
        for <stable@vger.kernel.org>; Sun, 03 Dec 2023 11:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701630570; x=1702235370; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yzn/FsJwl58Nyx1wgHTRNcjquLAZFzOpsS4MrY2gUGI=;
        b=FQ7NhslAihnxqe0Ppqv5F3mcoW2coTAykUKUuDKpSg6ylbB2PxWVyy9l0jNHrqgy3v
         936kYkWJfdnSAQmo0dYdv4YR9uglra/IWjRQq+RkQ2MgLjAeh1puGR7knKzCnFh+g5xa
         Zr0QW/rVdmatpymX3gUNwTKyfZZ+x0MiRksBY8rKMD7dMu2KEqIR8UXsaeETtzQ/ldSq
         l6PR3MKAl5BLRJJQbSeix2Ch6MVXKL+M2N2QZOtiXtCaUASXgTQwh+v6UvOYQBEA0TX7
         pwlNndZYJmYFLwXfRNH3wQlJ0fxiiKD/m4FTiwxEI4kpcc8cK8mxfLLYNnAg0ykd4FzH
         1J+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701630570; x=1702235370;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yzn/FsJwl58Nyx1wgHTRNcjquLAZFzOpsS4MrY2gUGI=;
        b=LFl1OKRiMCW6KeXICLmOn0XcK5plex8xejRNgAQdqS3uFSSO/N18NR9IXMPJ3OQ+AC
         HD8bJTMsLNoz/1LHRJ0P7SqiZ0cEvSr6OiwEGpiApImnUrWmKULiKt7Y0P1SZurltVzS
         hP6W5kIevI1vr8AqvbR5/foPbcT94sz/SP6/gyP+MHzKHAKc61PjUnpSv6eVhjlnvCPf
         GLTQRTwrU1jGmus75SlvVO5tIB8aBIMJ7SAGNhwA3L/Qu23IXAuidFnMHnV+m/K0sUx5
         oHWZZ4N+lwzSu+hGSyrodLQBjF6aW82q4Jpdw4vZQDhF/ICOTZEJfEmd2fA6C//pSI7s
         4GGA==
X-Gm-Message-State: AOJu0Yy7mUg6y+xMZg/9FyiEI6SRwbYGCHojsXqNfg9qJLaHmkpNqp/D
	c8Iyw1HoFs8lfPFS6OGGb0/ES4TJ8rIcRyKfWxG9pw==
X-Google-Smtp-Source: AGHT+IFPXSEfZH0wV4pW5qM869NOoRREP0BHeTuzYl8US2jaiOyrZGp2dkqKICJGVS+jZdCK1GvLsA==
X-Received: by 2002:a17:90a:bd8c:b0:286:b6c0:e0ea with SMTP id z12-20020a17090abd8c00b00286b6c0e0eamr240249pjr.24.1701630570561;
        Sun, 03 Dec 2023 11:09:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a21-20020a17090abe1500b0028613dcb810sm2304597pjs.23.2023.12.03.11.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:09:29 -0800 (PST)
Message-ID: <656cd269.170a0220.93109.3e00@mx.google.com>
Date: Sun, 03 Dec 2023 11:09:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.300-45-gc7158dd8db14c
Subject: stable-rc/linux-4.19.y baseline: 125 runs,
 1 regressions (v4.19.300-45-gc7158dd8db14c)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-4.19.y baseline: 125 runs, 1 regressions (v4.19.300-45-gc71=
58dd8db14c)

Regressions Summary
-------------------

platform      | arch | lab         | compiler | defconfig          | regres=
sions
--------------+------+-------------+----------+--------------------+-------=
-----
at91sam9g20ek | arm  | lab-broonie | gcc-10   | multi_v5_defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.19.y/ker=
nel/v4.19.300-45-gc7158dd8db14c/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.300-45-gc7158dd8db14c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      c7158dd8db14c28d061092263d2210f44d98ed6a =



Test Regressions
---------------- =



platform      | arch | lab         | compiler | defconfig          | regres=
sions
--------------+------+-------------+----------+--------------------+-------=
-----
at91sam9g20ek | arm  | lab-broonie | gcc-10   | multi_v5_defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/656ca08575efe1a9ece1349e

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
00-45-gc7158dd8db14c/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at9=
1sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
00-45-gc7158dd8db14c/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at9=
1sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656ca08575efe1a9ece134cd
        failing since 5 days (last pass: v4.19.299-93-g263cae4d5493f, first=
 fail: v4.19.299-93-gc66845304b463)

    2023-12-03T15:35:57.591055  + set +x
    2023-12-03T15:35:57.591602  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 302030_1.5.2=
.4.1>
    2023-12-03T15:35:57.704619  / # #
    2023-12-03T15:35:57.807832  export SHELL=3D/bin/sh
    2023-12-03T15:35:57.808650  #
    2023-12-03T15:35:57.910660  / # export SHELL=3D/bin/sh. /lava-302030/en=
vironment
    2023-12-03T15:35:57.911472  =

    2023-12-03T15:35:58.013500  / # . /lava-302030/environment/lava-302030/=
bin/lava-test-runner /lava-302030/1
    2023-12-03T15:35:58.014858  =

    2023-12-03T15:35:58.018488  / # /lava-302030/bin/lava-test-runner /lava=
-302030/1 =

    ... (12 line(s) more)  =

 =20

