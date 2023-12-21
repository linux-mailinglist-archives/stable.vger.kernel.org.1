Return-Path: <stable+bounces-8220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FA881ACCF
	for <lists+stable@lfdr.de>; Thu, 21 Dec 2023 03:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19DFCB21F9E
	for <lists+stable@lfdr.de>; Thu, 21 Dec 2023 02:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C596A2104;
	Thu, 21 Dec 2023 02:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="JEMqOMgG"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42E74416
	for <stable@vger.kernel.org>; Thu, 21 Dec 2023 02:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7ba7c845e1aso15336739f.2
        for <stable@vger.kernel.org>; Wed, 20 Dec 2023 18:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703127462; x=1703732262; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lmSMRGvkG5AxPec6xpAlX3LubdXpWIe6jVQu/QSalYo=;
        b=JEMqOMgGNetXcdq5j8pFIhq+qkOJGOJ3sESqZBvsxAYPBEClJNhy/uV0aC76DUAGGp
         i/P24nayHPIE/i5Agntt5UnGVKwjB35PkxDB7ZWR9YSsgqpJ9C0MdeyXTBtgkZRAGJc9
         EdM2uIiD3AL91TjX+zf6GSnBzh4Sldmbz6sEVCrEGvkKsDVtIDuiYMi3KNGZ0HA/l8m8
         tMxLCygIf1P3QtlUVL4fVmiaKwvbWxNX3rt/yKBJXdrad7aDy1IM6uS9TLlcvlIpW7uB
         J/HlIrxRpRx1ziFKjoCkkFqsvQ7jdgs1eo35UqY3Cm80O4gNJB8HqL/6X1EqpxdVUzjZ
         9q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703127462; x=1703732262;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lmSMRGvkG5AxPec6xpAlX3LubdXpWIe6jVQu/QSalYo=;
        b=BStz3xRb3AMkkwIJ5QjBqRNFqqYvdxGx3PTXJzHZOpGgsR+ynd7gq0mLulk7ju9b1X
         ETM7qnYMDgypmNLvJW3U9YeL01XnvO6ohkdCXgLgTqyDMGR9VvHzDyMA7lvSrQJLkjI+
         tpKHdPoBbXm2RwJCe0eg9BdEB0Ph/H8k8QrF2IRB4ha3hdgQFkYIJBMUvqrfSpbR/8PR
         pFlPrRxlxRzZk2Rn7kZ81zLDbg1m1ZIJpZOKjA1EazNOkodmEEkZTBc8W2Rn5wQyLPnd
         yBzjs/0dPwZSzWdcA2WO2SjTNbuAsoDh+1ml8HQrZoRAGTp2JyYY2u5NiPY7XvlqdQVf
         Frgg==
X-Gm-Message-State: AOJu0YyO4L2PUOP1/4PnBUm6C3cZ+MirTRtN/lMegYBeWAsvwm3IPUGl
	x9R/COwqYSPI9DkyT9WBIrHJD4H0roF/J664mio=
X-Google-Smtp-Source: AGHT+IHKlHn1+qHJvG9LQLrAx29LCB0g6CSaejvAvSyhNyZSAfl8UEPLfGvROMpCQxch9eseYRnMhw==
X-Received: by 2002:a05:6e02:20c1:b0:35d:6227:4f03 with SMTP id 1-20020a056e0220c100b0035d62274f03mr30268821ilq.7.1703127462379;
        Wed, 20 Dec 2023 18:57:42 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d10-20020a170903230a00b001c5b8087fe5sm438606plh.94.2023.12.20.18.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 18:57:41 -0800 (PST)
Message-ID: <6583a9a5.170a0220.d0975.2021@mx.google.com>
Date: Wed, 20 Dec 2023 18:57:41 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.68-108-g5ec595eb8752d
Subject: stable-rc/queue/6.1 baseline: 110 runs,
 3 regressions (v6.1.68-108-g5ec595eb8752d)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 110 runs, 3 regressions (v6.1.68-108-g5ec595e=
b8752d)

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
el/v6.1.68-108-g5ec595eb8752d/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.68-108-g5ec595eb8752d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      5ec595eb8752d3c550fc6be6a79772fc65ec8c54 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/658376d635b4ec6b58e13475

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
8-g5ec595eb8752d/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
8-g5ec595eb8752d/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/658376d635b4ec6b58e1347a
        failing since 28 days (last pass: v6.1.31-26-gef50524405c2, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-20T23:28:18.651848  / # #

    2023-12-20T23:28:18.753823  export SHELL=3D/bin/sh

    2023-12-20T23:28:18.754500  #

    2023-12-20T23:28:18.855806  / # export SHELL=3D/bin/sh. /lava-12331640/=
environment

    2023-12-20T23:28:18.856537  =


    2023-12-20T23:28:18.957905  / # . /lava-12331640/environment/lava-12331=
640/bin/lava-test-runner /lava-12331640/1

    2023-12-20T23:28:18.959005  =


    2023-12-20T23:28:18.976035  / # /lava-12331640/bin/lava-test-runner /la=
va-12331640/1

    2023-12-20T23:28:19.024502  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-20T23:28:19.025019  + cd /lav<8>[   19.097762] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12331640_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/658376c6aaf88e268fe134c4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
8-g5ec595eb8752d/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
8-g5ec595eb8752d/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/658376c6aaf88e268fe134c9
        failing since 28 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-20T23:20:33.175329  / # #
    2023-12-20T23:20:33.277151  export SHELL=3D/bin/sh
    2023-12-20T23:20:33.277815  #
    2023-12-20T23:20:33.378932  / # export SHELL=3D/bin/sh. /lava-449236/en=
vironment
    2023-12-20T23:20:33.379641  =

    2023-12-20T23:20:33.480745  / # . /lava-449236/environment/lava-449236/=
bin/lava-test-runner /lava-449236/1
    2023-12-20T23:20:33.481755  =

    2023-12-20T23:20:33.484723  / # /lava-449236/bin/lava-test-runner /lava=
-449236/1
    2023-12-20T23:20:33.563811  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-20T23:20:33.564466  + cd /lava-449236/<8>[   18.550328] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 449236_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/658376ecde277b59ede13494

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
8-g5ec595eb8752d/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
8-g5ec595eb8752d/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/658376ecde277b59ede13499
        failing since 28 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-20T23:28:32.773115  / # #

    2023-12-20T23:28:32.875129  export SHELL=3D/bin/sh

    2023-12-20T23:28:32.875812  #

    2023-12-20T23:28:32.977102  / # export SHELL=3D/bin/sh. /lava-12331639/=
environment

    2023-12-20T23:28:32.977783  =


    2023-12-20T23:28:33.079141  / # . /lava-12331639/environment/lava-12331=
639/bin/lava-test-runner /lava-12331639/1

    2023-12-20T23:28:33.080229  =


    2023-12-20T23:28:33.097409  / # /lava-12331639/bin/lava-test-runner /la=
va-12331639/1

    2023-12-20T23:28:33.162306  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-20T23:28:33.162812  + cd /lava-1233163<8>[   19.119385] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12331639_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

