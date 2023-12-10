Return-Path: <stable+bounces-5211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A253880BCD4
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 21:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02F11C20777
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 20:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8499C1CA92;
	Sun, 10 Dec 2023 20:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Z0XJcbMW"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C931DA
	for <stable@vger.kernel.org>; Sun, 10 Dec 2023 12:01:55 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1faf56466baso2718403fac.3
        for <stable@vger.kernel.org>; Sun, 10 Dec 2023 12:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702238513; x=1702843313; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7iCRDgnCS0Q0jS7XCQzR2TFQMfF0NeOY1+KJZAuNOw8=;
        b=Z0XJcbMW96kDRMMJguTGNPEjtK56iCVgq4Ac0/QxO/xbvflv77/R2FDbQdzATrK1x9
         zM4XqH96D013lnqYorFEiidG+mhVYxVg7NARuyODaTbPbpW0pSZ79AIbgLRaOlZy4syK
         WratPrkIXsroepwduw1u4MeclOIVr/td91AwmQU2Y3GSDFZExMyFODgSq/tmqTj0dbdp
         bGFSTllZCGUUr2uK5AV9+t0es17rGxBoRdqJiG2jPfRmKQmekgsnR5bgtSKX8iAV+A4t
         9KuHXf6ifOAvvxN02oWNjfdG/xSwYLE38HDMg2DY6e0gmVN7FnIpnO/4HbAoMLFPC9XH
         XQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702238513; x=1702843313;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7iCRDgnCS0Q0jS7XCQzR2TFQMfF0NeOY1+KJZAuNOw8=;
        b=p7EscxEPZCaG4WNT6G+0LkGD3LqAcopN3GosiFy1CaU6epcDSHO8BxKWtjQzrT3bjs
         N7IM4VTBUfdzvGA7EL+yurJc3j2UuSDunN2cP7oJwExnjuHRXeZ8saAM3XokZQg8SqUu
         TPG/7tBOxKx5sRfMy+FokyynfKhmJPgtZXbojSDoLATd+2L9A1yNSEvTxTFIomJTC6g+
         EBxkvia5x1uc2R7Ikbf2fZpJLkbujMRhIigTQSbTJkSJXM9CUOmiqzBJmLU9qV+h6+uV
         V5jKRkt9HrN06AuQSEvxYUoZX4OqCOjgQ1dIXSzHxbAzbTrWvmB2ZaJz9Fnz8a/xNq7X
         PlfA==
X-Gm-Message-State: AOJu0YyJvKPrf39v/1KSmmLHwxi4x2dByvJRor6DGeH3EkwC5tWz/+de
	vYCiHyUDxccUJPiXan+hTDfoG0iE6KwGoqmuF7XE3g==
X-Google-Smtp-Source: AGHT+IG/bM0YMQINqpajjrfpQ5ZesgBkIcnituGsIokHkZTbpr4yfxXl3rwnO3nA3fNMWdx+fUK2PQ==
X-Received: by 2002:a05:6870:910c:b0:1fb:412:c32c with SMTP id o12-20020a056870910c00b001fb0412c32cmr4075679oae.32.1702238512927;
        Sun, 10 Dec 2023 12:01:52 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 11-20020a63154b000000b005b458aa0541sm4848447pgv.15.2023.12.10.12.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 12:01:52 -0800 (PST)
Message-ID: <65761930.630a0220.8ac9a.d42c@mx.google.com>
Date: Sun, 10 Dec 2023 12:01:52 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.66-136-g3bb44622830bc
Subject: stable-rc/queue/6.1 baseline: 144 runs,
 5 regressions (v6.1.66-136-g3bb44622830bc)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 144 runs, 5 regressions (v6.1.66-136-g3bb4462=
2830bc)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
beagle-xm          | arm   | lab-baylibre  | gcc-10   | omap2plus_defconfig=
 | 1          =

meson-gxbb-p200    | arm64 | lab-baylibre  | gcc-10   | defconfig          =
 | 1          =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
 | 1          =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.66-136-g3bb44622830bc/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.66-136-g3bb44622830bc
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      3bb44622830bc461027a2b37a6186dd74203be96 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
beagle-xm          | arm   | lab-baylibre  | gcc-10   | omap2plus_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6575e79826e97c1b0ae1349f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-13=
6-g3bb44622830bc/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-13=
6-g3bb44622830bc/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6575e79826e97c1b0ae13=
4a0
        failing since 234 days (last pass: v6.1.22-477-g2128d4458cbc, first=
 fail: v6.1.22-474-gecc61872327e) =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
meson-gxbb-p200    | arm64 | lab-baylibre  | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6575e775f6e2ff04c3e134f7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-13=
6-g3bb44622830bc/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p2=
00.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-13=
6-g3bb44622830bc/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p2=
00.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6575e775f6e2ff04c3e13=
4f8
        new failure (last pass: v6.1.66-135-gd37672462f1e8) =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6575e66c870aa664b4e13476

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-13=
6-g3bb44622830bc/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-13=
6-g3bb44622830bc/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6575e66c870aa664b4e1347b
        failing since 17 days (last pass: v6.1.31-26-gef50524405c2, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-10T16:32:34.999309  / # #

    2023-12-10T16:32:35.099748  export SHELL=3D/bin/sh

    2023-12-10T16:32:35.099885  #

    2023-12-10T16:32:35.200318  / # export SHELL=3D/bin/sh. /lava-12236601/=
environment

    2023-12-10T16:32:35.200454  =


    2023-12-10T16:32:35.300889  / # . /lava-12236601/environment/lava-12236=
601/bin/lava-test-runner /lava-12236601/1

    2023-12-10T16:32:35.301075  =


    2023-12-10T16:32:35.313035  / # /lava-12236601/bin/lava-test-runner /la=
va-12236601/1

    2023-12-10T16:32:35.365981  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-10T16:32:35.366053  + cd /lav<8>[   19.078675] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12236601_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6575e6575e7cbfdc2fe134d3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-13=
6-g3bb44622830bc/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-13=
6-g3bb44622830bc/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6575e6575e7cbfdc2fe134d8
        failing since 17 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-10T16:24:49.264803  <8>[   18.042260] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447413_1.5.2.4.1>
    2023-12-10T16:24:49.369810  / # #
    2023-12-10T16:24:49.471405  export SHELL=3D/bin/sh
    2023-12-10T16:24:49.472005  #
    2023-12-10T16:24:49.572994  / # export SHELL=3D/bin/sh. /lava-447413/en=
vironment
    2023-12-10T16:24:49.573651  =

    2023-12-10T16:24:49.674631  / # . /lava-447413/environment/lava-447413/=
bin/lava-test-runner /lava-447413/1
    2023-12-10T16:24:49.675481  =

    2023-12-10T16:24:49.680006  / # /lava-447413/bin/lava-test-runner /lava=
-447413/1
    2023-12-10T16:24:49.753142  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6575e680870aa664b4e134c3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-13=
6-g3bb44622830bc/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-13=
6-g3bb44622830bc/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6575e680870aa664b4e134c8
        failing since 17 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-10T16:32:48.942961  / # #

    2023-12-10T16:32:49.045341  export SHELL=3D/bin/sh

    2023-12-10T16:32:49.046081  #

    2023-12-10T16:32:49.147428  / # export SHELL=3D/bin/sh. /lava-12236598/=
environment

    2023-12-10T16:32:49.148109  =


    2023-12-10T16:32:49.249461  / # . /lava-12236598/environment/lava-12236=
598/bin/lava-test-runner /lava-12236598/1

    2023-12-10T16:32:49.250450  =


    2023-12-10T16:32:49.253012  / # /lava-12236598/bin/lava-test-runner /la=
va-12236598/1

    2023-12-10T16:32:49.332820  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-10T16:32:49.333405  + cd /lava-1223659<8>[   19.148317] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12236598_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

