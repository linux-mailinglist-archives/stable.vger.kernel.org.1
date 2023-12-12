Return-Path: <stable+bounces-6422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4925B80E736
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 10:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C95F21F22305
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 09:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0198D584C5;
	Tue, 12 Dec 2023 09:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="EZn1xc+g"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F83CD2
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 01:18:25 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-28abda9ca94so394227a91.2
        for <stable@vger.kernel.org>; Tue, 12 Dec 2023 01:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702372704; x=1702977504; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BiMAfUTZRSUv4pyuK7zJKdryS/Btiw+tQmCYou+MgX0=;
        b=EZn1xc+giciRnYpCstGDybzSa6PuBiUoqx0hwwXZTFVwBtDyImBfhwX9HlNSCAv6Or
         +0fjvqLYp8R1t5v2hcMSGOXD7u7R7qsN878tmbj/2I5zq089L0S+DE2SKLRjTzu6rvUq
         gXu+3JxDicoTO1n3ULn+z8sOYMzdIBJ1WWRGMv2MvHLDYexgAtClHVWqbrAQaiJWgj2Y
         ZFyOkLK3f/iFS1RakFUFpKyUNYsLwMDLytwcLUAWuQYu5bXHwhOEXdEeMlRwo+HRw6kP
         Fjr4GIJGL/1WOUotDU22n200B9HnaTGPuh8mJhB4RfPGDT1BM68apNuBBOra+1DggXDw
         sxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702372704; x=1702977504;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BiMAfUTZRSUv4pyuK7zJKdryS/Btiw+tQmCYou+MgX0=;
        b=B01Buxuf976UpaGxLjad89jLqFixBhTtXozMtFSovHQK7LgGhr5wbKXe4OA5e7HK/I
         VeTRf7mtcn4QnUc91NJ/JjEIqiVlFQbV9x4F1SbNG8FWBlREQE9nboHpMP3kx2ivA3Hc
         rX6xBL6HWnpgBWHXefHAkT4FU3pBdCq0advhHH6j80OkzrNjF9Zlmu/AOU3YqoE/nHh9
         qRj8RFqlNkqAVY5DpWsRvhppbSfS8L/yCvz+TAkd6p+ghQzRZEcUU9oEmabaBsbwmAq+
         XF32MSmAKYs911cpNjPS89RxzZjNmFsr7AMA4LWb0Cg3XeZK50nIGntG8qUGA/HxycG0
         0Bxg==
X-Gm-Message-State: AOJu0YwOQj21O/Gr0g/whzjcedn0NF78e6FaIObrXcG9szpfTGykc+2I
	gXaRVSk1RKPZBCh60PFQy7c03i97BAS//T3vAkKDyA==
X-Google-Smtp-Source: AGHT+IF4FvDff/sy7u3PQ+m8Nypo+F7Y385OZ41CExB6Y9krB3pWWrkspRZYG2mFaBVfZH7cGg/2Tw==
X-Received: by 2002:a17:90b:1190:b0:288:7921:a745 with SMTP id gk16-20020a17090b119000b002887921a745mr4780194pjb.15.1702372704250;
        Tue, 12 Dec 2023 01:18:24 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q2-20020a17090a430200b0028a4c85a55csm6612717pjg.27.2023.12.12.01.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 01:18:23 -0800 (PST)
Message-ID: <6578255f.170a0220.a6b87.28d2@mx.google.com>
Date: Tue, 12 Dec 2023 01:18:23 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.203-98-g670205df0377e
Subject: stable-rc/linux-5.10.y baseline: 110 runs,
 2 regressions (v5.10.203-98-g670205df0377e)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-5.10.y baseline: 110 runs, 2 regressions (v5.10.203-98-g670=
205df0377e)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.203-98-g670205df0377e/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.203-98-g670205df0377e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      670205df0377e191c0a123ecce9257eba333bbc5 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6577f3d8738a97988ae134ff

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
03-98-g670205df0377e/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
03-98-g670205df0377e/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6577f3d8738a97988ae13508
        failing since 62 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-12-12T05:46:54.973713  <8>[   17.001388] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447690_1.5.2.4.1>
    2023-12-12T05:46:55.078754  / # #
    2023-12-12T05:46:55.180472  export SHELL=3D/bin/sh
    2023-12-12T05:46:55.181096  #
    2023-12-12T05:46:55.282105  / # export SHELL=3D/bin/sh. /lava-447690/en=
vironment
    2023-12-12T05:46:55.282762  =

    2023-12-12T05:46:55.383815  / # . /lava-447690/environment/lava-447690/=
bin/lava-test-runner /lava-447690/1
    2023-12-12T05:46:55.384743  =

    2023-12-12T05:46:55.388889  / # /lava-447690/bin/lava-test-runner /lava=
-447690/1
    2023-12-12T05:46:55.456025  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6577f3ea8988270fafe13490

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
03-98-g670205df0377e/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
03-98-g670205df0377e/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6577f3ea8988270fafe13499
        failing since 62 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-12-12T05:54:42.304753  / # #

    2023-12-12T05:54:42.405456  export SHELL=3D/bin/sh

    2023-12-12T05:54:42.406072  #

    2023-12-12T05:54:42.507317  / # export SHELL=3D/bin/sh. /lava-12251136/=
environment

    2023-12-12T05:54:42.507621  =


    2023-12-12T05:54:42.608512  / # . /lava-12251136/environment/lava-12251=
136/bin/lava-test-runner /lava-12251136/1

    2023-12-12T05:54:42.609543  =


    2023-12-12T05:54:42.618669  / # /lava-12251136/bin/lava-test-runner /la=
va-12251136/1

    2023-12-12T05:54:42.681712  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-12T05:54:42.682202  + cd /lava-1225113<8>[   18.169949] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12251136_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

