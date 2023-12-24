Return-Path: <stable+bounces-8421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3247C81DC08
	for <lists+stable@lfdr.de>; Sun, 24 Dec 2023 20:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7453A1F214EE
	for <lists+stable@lfdr.de>; Sun, 24 Dec 2023 19:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F48DD28D;
	Sun, 24 Dec 2023 19:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="2/wmkrt3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FD0D292
	for <stable@vger.kernel.org>; Sun, 24 Dec 2023 19:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6d9b267007fso49924b3a.3
        for <stable@vger.kernel.org>; Sun, 24 Dec 2023 11:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703444633; x=1704049433; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=27pSKnvEOqUuV5M8iOqH0LNPn2t8+roWATzj0jusPEA=;
        b=2/wmkrt3e3SmQDqSYY88NlxPKujMhugivcnMw7FyFhpYv+VDEIhWUBNIMXtlO8mCYk
         rwe4WT8XzUEYFwQjcdiiU+YvC1Fg1NKIreTDgt5G6Jw7XRhnhRY3WeHGGTa9TmcW2Eal
         QU4CzGIYsNogwWd13cGuMc5T8XumjiD+yl2LSiMiZyUnC6jExAOyrWHU8FOJg2A1pgt6
         xfNs2qS0k8QOkBdg7DUQQ3+ZQVtceydaqiKd/NEy0mO1GLxxCuDMM6iMxJMM5Cx33/Ud
         O+2wYrC4g+PGjP55IGPW3z49+Kntho62a2kSBI5jolfCH36JCVg0pvb1abvL8QUCjlu8
         14rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703444633; x=1704049433;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27pSKnvEOqUuV5M8iOqH0LNPn2t8+roWATzj0jusPEA=;
        b=rWDs5SPXqebIvgi5VRYl4+7yIWB4hwjsfTneulbFzsOQnBlwiXAMoB9mfkl3g4cK7S
         aNc9VogLA4ye9kSvSdPC8bOGrlin0D6QKeXJBGoe/tyLOKX46XjOyptq2EfaaK5rnQE3
         dfbCZewebF5WTrKIjGiQdIIfOlrlyhkHBV1PutL+/sGH8NSqTwTtj3XI9g+XjFT7kT8a
         tF21CYcspcJCgH8w0vVU4gnV7E6ZL8tbnqeSfb4UH4HxO/ja//KkHRVzEoELe2ekgqX9
         nzm5WboyDwhOzCOWZt0RRGWddRFGP+3NY7tuHmzx+VoPWfne5dzqtatkaEoDC/5XN/Ke
         zu/Q==
X-Gm-Message-State: AOJu0YyM9CXx83X4n52eR6Co4XBj1xqRZ8Wafs2b9SI+ndHWy4fAVbOr
	AmL8i843pwEYYpC7E9VsBAQ/ypcfaG8cGeTmQK/tp0qZeO4=
X-Google-Smtp-Source: AGHT+IGxti65vfMwDfjl91JNK2nd6I24Qta26UCds+mbS3nMjmWCJ/mBSxUVy478pMs03i3nzSLOyw==
X-Received: by 2002:a17:902:ee93:b0:1d3:e41b:7601 with SMTP id a19-20020a170902ee9300b001d3e41b7601mr2691562pld.18.1703444633258;
        Sun, 24 Dec 2023 11:03:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902779100b001d09c539c96sm6751519pll.229.2023.12.24.11.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 11:03:52 -0800 (PST)
Message-ID: <65888098.170a0220.60849.25d7@mx.google.com>
Date: Sun, 24 Dec 2023 11:03:52 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.68-160-gf04523f89ac68
Subject: stable-rc/queue/6.1 baseline: 108 runs,
 3 regressions (v6.1.68-160-gf04523f89ac68)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 108 runs, 3 regressions (v6.1.68-160-gf04523f=
89ac68)

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
el/v6.1.68-160-gf04523f89ac68/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.68-160-gf04523f89ac68
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      f04523f89ac681f2f93fa00908376cfaf4cd5dee =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65884d630755bd0ef9e13501

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-16=
0-gf04523f89ac68/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-16=
0-gf04523f89ac68/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65884d630755bd0ef9e13506
        failing since 31 days (last pass: v6.1.31-26-gef50524405c2, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-24T15:32:34.252265  / # #

    2023-12-24T15:32:34.354375  export SHELL=3D/bin/sh

    2023-12-24T15:32:34.355033  #

    2023-12-24T15:32:34.456367  / # export SHELL=3D/bin/sh. /lava-12373423/=
environment

    2023-12-24T15:32:34.457110  =


    2023-12-24T15:32:34.558618  / # . /lava-12373423/environment/lava-12373=
423/bin/lava-test-runner /lava-12373423/1

    2023-12-24T15:32:34.559805  =


    2023-12-24T15:32:34.576229  / # /lava-12373423/bin/lava-test-runner /la=
va-12373423/1

    2023-12-24T15:32:34.624852  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-24T15:32:34.625375  + cd /lav<8>[   19.182332] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12373423_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65884d59aa355e233de1349d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-16=
0-gf04523f89ac68/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-16=
0-gf04523f89ac68/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65884d59aa355e233de134a2
        failing since 31 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-24T15:25:07.028815  / # #
    2023-12-24T15:25:07.130188  export SHELL=3D/bin/sh
    2023-12-24T15:25:07.130875  #
    2023-12-24T15:25:07.231865  / # export SHELL=3D/bin/sh. /lava-449805/en=
vironment
    2023-12-24T15:25:07.232555  =

    2023-12-24T15:25:07.333627  / # . /lava-449805/environment/lava-449805/=
bin/lava-test-runner /lava-449805/1
    2023-12-24T15:25:07.334653  =

    2023-12-24T15:25:07.339205  / # /lava-449805/bin/lava-test-runner /lava=
-449805/1
    2023-12-24T15:25:07.412513  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-24T15:25:07.412824  + cd /lava-449805/<8>[   18.548641] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 449805_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65884d640755bd0ef9e1350c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-16=
0-gf04523f89ac68/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-16=
0-gf04523f89ac68/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65884d640755bd0ef9e13511
        failing since 31 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-24T15:32:52.944921  / # #

    2023-12-24T15:32:53.047030  export SHELL=3D/bin/sh

    2023-12-24T15:32:53.047725  #

    2023-12-24T15:32:53.149120  / # export SHELL=3D/bin/sh. /lava-12373435/=
environment

    2023-12-24T15:32:53.149870  =


    2023-12-24T15:32:53.251345  / # . /lava-12373435/environment/lava-12373=
435/bin/lava-test-runner /lava-12373435/1

    2023-12-24T15:32:53.252582  =


    2023-12-24T15:32:53.254222  / # /lava-12373435/bin/lava-test-runner /la=
va-12373435/1

    2023-12-24T15:32:53.334291  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-24T15:32:53.334798  + cd /lava-1237343<8>[   19.119693] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12373435_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

