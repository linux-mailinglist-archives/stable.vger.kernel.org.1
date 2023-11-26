Return-Path: <stable+bounces-2718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8C77F95BB
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 23:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8230B1C20492
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 22:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C361401B;
	Sun, 26 Nov 2023 22:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="i50XGFHb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7F0ED
	for <stable@vger.kernel.org>; Sun, 26 Nov 2023 14:18:04 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cfc2d03b3aso2659335ad.1
        for <stable@vger.kernel.org>; Sun, 26 Nov 2023 14:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701037083; x=1701641883; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vmJbefE6z1zJAr1ZzMjbDxygr6mnV0Jhs/1qj86QlPY=;
        b=i50XGFHb0IhJftpYY5UbRiRcRvDOrOfViSqrjDbGAZdFdyprBVztHu2zz4lRSX8AX6
         RoGK3uL2Zt8JjRYzxozAVjFX7WUwtzbnZSUZW9W5gyMDj1DGmjOI9AfGysUl8eNRJ6a1
         pEjJx6tFsGvo2PVViEl/18sn2hson9vDKlkk0dqMDGuyRoQ96uWUlUNjHNhYT8+wxjRQ
         CWTj8Kk6IgQMxBPu4B/PaP3KkTXW3FmAboPzrezNR+kCM9GmLQ2AL1t83UdwontBwAXW
         z43mncAgPcwz55WMfa69o7q0OmcIXHtJ6BiUfB2DCG3bxCWGAjp/GKX92FqBEQeuOz9W
         FG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701037083; x=1701641883;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vmJbefE6z1zJAr1ZzMjbDxygr6mnV0Jhs/1qj86QlPY=;
        b=ZNb49NR5EgiFB3RXLMInbA2G7G/VxHf6NNsyPrL5tB1R9/4qxydT2rM8adWYo2BVRC
         o6TJpzxhPCK1N/cSM8q5LmWhbnjOB0unzNH8rgpwasyFJhQYsGh4qAap+xKAhemy4omn
         Ewbh617qulz5v9GDCqy6D78G1R/O1uWV1KBN8uZ5IHe7pFmRYML5ruU+gGJKRXvfZHDr
         j5g61Iv7ZIw/qCEY3VasnCdo/sLSigOKJIpHIHB4GL5oVpDylWqiv613aaT2Dx2xW2Vs
         UXEXwe8CDBU9Z2JlK6NpsfbYFmK/21rMiuSM0i14580hYfaGgrZ1SwhrL1V851+Hhzc7
         DvrA==
X-Gm-Message-State: AOJu0Yx9V/s8lJp8LDhV0aPEfhiNcSdJAV9M/pYa2eHlsPowrgsVo1/V
	PImQpwZYrSreeuULwvuvt26lK5XKv4BohpGMm7E=
X-Google-Smtp-Source: AGHT+IFzFC9INFImK5gXXwyWXSOg1FowWJqmqTwak/bjDJFBJdMvo0w4Z7ZQELLKfRFN3FToRZ44Sg==
X-Received: by 2002:a17:902:ce92:b0:1cf:9905:55b3 with SMTP id f18-20020a170902ce9200b001cf990555b3mr10261097plg.29.1701037082670;
        Sun, 26 Nov 2023 14:18:02 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jj14-20020a170903048e00b001c73f3a9b7fsm6886639plb.185.2023.11.26.14.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 14:18:02 -0800 (PST)
Message-ID: <6563c41a.170a0220.aecd.f24d@mx.google.com>
Date: Sun, 26 Nov 2023 14:18:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.201-188-g2f84e268b78b3
Subject: stable-rc/linux-5.10.y baseline: 128 runs,
 3 regressions (v5.10.201-188-g2f84e268b78b3)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-5.10.y baseline: 128 runs, 3 regressions (v5.10.201-188-g2f=
84e268b78b3)

Regressions Summary
-------------------

platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre  | gcc-10   | defconfig | 1   =
       =

sun50i-h6-pine-h64    | arm64 | lab-clabbe    | gcc-10   | defconfig | 1   =
       =

sun50i-h6-pine-h64    | arm64 | lab-collabora | gcc-10   | defconfig | 1   =
       =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.201-188-g2f84e268b78b3/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.201-188-g2f84e268b78b3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      2f84e268b78b36c0d35a71fcac210122891f6385 =



Test Regressions
---------------- =



platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre  | gcc-10   | defconfig | 1   =
       =


  Details:     https://kernelci.org/test/plan/id/6563936a0421c887307e4b5c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
01-188-g2f84e268b78b3/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gx=
m-khadas-vim2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
01-188-g2f84e268b78b3/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gx=
m-khadas-vim2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6563936a0421c887307e4=
b5d
        new failure (last pass: v5.10.201-189-gf8438240ed9e5) =

 =



platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
sun50i-h6-pine-h64    | arm64 | lab-clabbe    | gcc-10   | defconfig | 1   =
       =


  Details:     https://kernelci.org/test/plan/id/6563925dcb3cb3d5fa7e4a7f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
01-188-g2f84e268b78b3/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
01-188-g2f84e268b78b3/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6563925dcb3cb3d5fa7e4a88
        failing since 46 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-11-26T18:45:40.402032  <8>[   16.958961] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 445397_1.5.2.4.1>
    2023-11-26T18:45:40.507053  / # #
    2023-11-26T18:45:40.608633  export SHELL=3D/bin/sh
    2023-11-26T18:45:40.609277  #
    2023-11-26T18:45:40.710291  / # export SHELL=3D/bin/sh. /lava-445397/en=
vironment
    2023-11-26T18:45:40.710899  =

    2023-11-26T18:45:40.811909  / # . /lava-445397/environment/lava-445397/=
bin/lava-test-runner /lava-445397/1
    2023-11-26T18:45:40.812768  =

    2023-11-26T18:45:40.817265  / # /lava-445397/bin/lava-test-runner /lava=
-445397/1
    2023-11-26T18:45:40.884291  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
sun50i-h6-pine-h64    | arm64 | lab-collabora | gcc-10   | defconfig | 1   =
       =


  Details:     https://kernelci.org/test/plan/id/6563927735536ed4687e4a8e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
01-188-g2f84e268b78b3/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-=
h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
01-188-g2f84e268b78b3/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-=
h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6563927735536ed4687e4a97
        failing since 46 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-11-26T18:52:38.395104  / # #

    2023-11-26T18:52:38.497179  export SHELL=3D/bin/sh

    2023-11-26T18:52:38.498016  #

    2023-11-26T18:52:38.599510  / # export SHELL=3D/bin/sh. /lava-12090745/=
environment

    2023-11-26T18:52:38.600201  =


    2023-11-26T18:52:38.701562  / # . /lava-12090745/environment/lava-12090=
745/bin/lava-test-runner /lava-12090745/1

    2023-11-26T18:52:38.702607  =


    2023-11-26T18:52:38.719582  / # /lava-12090745/bin/lava-test-runner /la=
va-12090745/1

    2023-11-26T18:52:38.761716  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-26T18:52:38.778572  + cd /lava-1209074<8>[   18.189977] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12090745_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

