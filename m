Return-Path: <stable+bounces-6708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD326812698
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 05:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5043F2827E6
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 04:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A591FA6;
	Thu, 14 Dec 2023 04:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Nheg5V7Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B28E106
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 20:33:08 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1d08a924fcfso73315885ad.2
        for <stable@vger.kernel.org>; Wed, 13 Dec 2023 20:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702528387; x=1703133187; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LxM0d8pCvS1W2fSwGg6Gfw/c0HGk0glhxm68LhflwT0=;
        b=Nheg5V7YbVC3XKjOkaIDSDZZ/MHtYunaEQf6tH9HjSjkWMhJiYh8oszlh7Q24QT0Ac
         itwk8F3GFwk2Dhr5S5RIAVzEu/kUo3df6S0Kh1iAE8pgQo5UdSFiZbIGT6t0gJmNFhdr
         EXXIHwYqOcS2YUV13QatqKvDXW6pRyTTxPqZdnoHjod+JPkclsvyi+5p7FT9LtG5Yt/d
         x0mILxOor/UgS13Zlq7f6W5Rw5p+pOKayYCiBx+Oow533Wc7M/f0lwfMm3HjqZFQSmP3
         7viL+w2qDfKnMkpK5BkrBKDt8YyF3kktF7StwN+qzztJoglI7/5s+l59rX/zhA4LFzda
         0WOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702528387; x=1703133187;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LxM0d8pCvS1W2fSwGg6Gfw/c0HGk0glhxm68LhflwT0=;
        b=WpP0JRpaml4pXmLjhg4uDSkHNm1vqKqUBqskLl9GLyVO7oQACqpxq+JkXkN41rtxRi
         Sxd+gPcggKLO+bX0JA7h+aL+RdQHLH0NeSviAyEUxSTVATfPdeOD3MgXtjlY4YP5ki1E
         KloiritsqbfHfKwP4TIEoF7F9PAPoIld7lSx93BV4UKmVddnh6lFlt5pJnc2jnQHhKjy
         mY5haYLuXBNgDFImywxAfeIy+3mw3i5XRFsXfduY46EWCQOTwQupTIYbkaPTays9L+Tj
         kZhQjMrHzmKdcDo/r5kwP2rgQIUVse8XTb0sC1oP9iEf8HkvlQHGlhBNLTOuXQDBOdno
         xmJA==
X-Gm-Message-State: AOJu0YyD3uOQbSixjFb4TRLBP+rYcmMmvv5JeMSfBqDQU2gI5/ccbJVi
	hWLLG5Cn7jFGmQsg3C65zlqEemTEbwJiN4KZQnU+eg==
X-Google-Smtp-Source: AGHT+IHK6vncMw03mvOa4tZ0+w6vYEgXC+Z87D79QJqsiN75TKf9Uic7K6D5Rwp0ADTVrwDL7Pl+Hw==
X-Received: by 2002:a17:903:647:b0:1d0:8e61:102a with SMTP id kh7-20020a170903064700b001d08e61102amr8107167plb.90.1702528386990;
        Wed, 13 Dec 2023 20:33:06 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g1-20020a170902fe0100b001d0ab572458sm92497plj.121.2023.12.13.20.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 20:33:06 -0800 (PST)
Message-ID: <657a8582.170a0220.53773.033f@mx.google.com>
Date: Wed, 13 Dec 2023 20:33:06 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.204
Subject: stable-rc/linux-5.10.y baseline: 111 runs, 3 regressions (v5.10.204)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-5.10.y baseline: 111 runs, 3 regressions (v5.10.204)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
juno-uboot         | arm64 | lab-broonie   | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.204/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.204
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b50306f77190155d2c14a72be5d2e02254d17dbd =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
juno-uboot         | arm64 | lab-broonie   | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657a5422b3e207012ae13572

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
04/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
04/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657a5422b3e207012ae135b2
        new failure (last pass: v5.10.203-98-g670205df0377e)

    2023-12-14T01:02:03.342505  <8>[   15.330261] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 351033_1.5.2.4.1>
    2023-12-14T01:02:03.450689  / # #
    2023-12-14T01:02:03.553575  export SHELL=3D/bin/sh
    2023-12-14T01:02:03.554421  #
    2023-12-14T01:02:03.656336  / # export SHELL=3D/bin/sh. /lava-351033/en=
vironment
    2023-12-14T01:02:03.657077  =

    2023-12-14T01:02:03.759082  / # . /lava-351033/environment/lava-351033/=
bin/lava-test-runner /lava-351033/1
    2023-12-14T01:02:03.760358  =

    2023-12-14T01:02:03.774725  / # /lava-351033/bin/lava-test-runner /lava=
-351033/1
    2023-12-14T01:02:03.832624  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657a532b32b1fb9aa9e13475

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
04/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
04/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657a532b32b1fb9aa9e1347e
        failing since 64 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-12-14T00:58:10.424665  <8>[   16.986199] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447962_1.5.2.4.1>
    2023-12-14T00:58:10.529614  / # #
    2023-12-14T00:58:10.631223  export SHELL=3D/bin/sh
    2023-12-14T00:58:10.631832  #
    2023-12-14T00:58:10.732837  / # export SHELL=3D/bin/sh. /lava-447962/en=
vironment
    2023-12-14T00:58:10.733466  =

    2023-12-14T00:58:10.834487  / # . /lava-447962/environment/lava-447962/=
bin/lava-test-runner /lava-447962/1
    2023-12-14T00:58:10.835339  =

    2023-12-14T00:58:10.839948  / # /lava-447962/bin/lava-test-runner /lava=
-447962/1
    2023-12-14T00:58:10.905959  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657a533fc67fdbacfbe1351d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
04/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
04/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657a533fc67fdbacfbe13526
        failing since 64 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-12-14T01:06:01.297686  / # #

    2023-12-14T01:06:01.399847  export SHELL=3D/bin/sh

    2023-12-14T01:06:01.400603  #

    2023-12-14T01:06:01.502006  / # export SHELL=3D/bin/sh. /lava-12265029/=
environment

    2023-12-14T01:06:01.502805  =


    2023-12-14T01:06:01.604234  / # . /lava-12265029/environment/lava-12265=
029/bin/lava-test-runner /lava-12265029/1

    2023-12-14T01:06:01.605429  =


    2023-12-14T01:06:01.621459  / # /lava-12265029/bin/lava-test-runner /la=
va-12265029/1

    2023-12-14T01:06:01.679611  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-14T01:06:01.680110  + cd /lava-1226502<8>[   18.191484] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12265029_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

