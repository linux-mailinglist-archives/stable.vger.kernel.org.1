Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD807E6D25
	for <lists+stable@lfdr.de>; Thu,  9 Nov 2023 16:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjKIPRo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 9 Nov 2023 10:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbjKIPRn (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 9 Nov 2023 10:17:43 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F6535AC
        for <stable@vger.kernel.org>; Thu,  9 Nov 2023 07:17:41 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc68c1fac2so8666845ad.0
        for <stable@vger.kernel.org>; Thu, 09 Nov 2023 07:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699543061; x=1700147861; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Bco//fvuJppeHv4D7tRdo+EPhDBDbX5zfRK2hI5aRSs=;
        b=uskdfPmmltLfgrLOzEKGxA5LzA7QmVzx2BfPK9ubu0pMGfJNgUdf9squZDcYYVo0J0
         qydxum7zlBIsTySAVXAuCRMssbtpK4a7d31+/88nu1YNcHOv59/P4C1H6odSEyDaP48/
         lbuaLhrI0pTtG3uQKh69wojSkWLSa0Do9UBNwTOFTLKu7yK3jyY1+IwWeL7OmetR70dJ
         zgGV8yLtZyATveMtwTJ0tUcGsENhu0y74pzD0+tS61kPHaHwR+KFWBq+aGu/NwATGdQe
         t/aha6k92RTTa4GJGc5EDQAnWbdZ1RFMpFd8nByMvdyRAzqmfKJTBzCAxANkrnd4CM6U
         8Upw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699543061; x=1700147861;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bco//fvuJppeHv4D7tRdo+EPhDBDbX5zfRK2hI5aRSs=;
        b=WJlYGUnEqmUNupwz0u4TeVxGapvERMcD2TIYSU8QhC2S7djviyIhaoQWAHo0pZaApE
         ZH4TGBYj7gLzqz6WR2jAFiZ2PdecqTLikVLo5nLhvgY2GoyfdXTE4V9/1bPDhfvCv93g
         0kcITSqa4DHTIxfXzxKWXfD37yCf1v1T1elsAnmHdARsCGJIuTPhrGC7NXXBKHZjo4HK
         wW5YjN5FojL+mHcNy15aKlm+e04+yIBqdvlfbxaiQqHBSYKCbOSYRcLGhLbE8v8W051I
         FqiYYq/w8D3N0B2MMpcxKTvL2R3v28KmICFSNpXOUKe44UsUZ74H/UWnQ7sc4unTWXWe
         izEQ==
X-Gm-Message-State: AOJu0YxKyZbtKo7JdvZ3HQXlWvqYpk2aMlw1/gBC9SqSUSzN+POL1nhF
        DpC9N5aGMXmnLvtflDBuzxKS0eymQ28eoTOgtBQTFg==
X-Google-Smtp-Source: AGHT+IHXRJ/e51+lZY7Bb6KjERquvvCMSpueQ5RAO7UoFSHqZtjuaQXPazR1nERbAKZub3GG6msgEA==
X-Received: by 2002:a17:902:a388:b0:1cc:45f1:adf5 with SMTP id x8-20020a170902a38800b001cc45f1adf5mr5378021pla.40.1699543060680;
        Thu, 09 Nov 2023 07:17:40 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jm20-20020a17090304d400b001cc4e477861sm3656897plb.212.2023.11.09.07.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 07:17:40 -0800 (PST)
Message-ID: <654cf814.170a0220.80513.b55e@mx.google.com>
Date:   Thu, 09 Nov 2023 07:17:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.200
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.10.y baseline: 117 runs, 2 regressions (v5.10.200)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y baseline: 117 runs, 2 regressions (v5.10.200)

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
nel/v5.10.200/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.200
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      3e55583405ac3f8651966dcd23590adb3db1d8c2 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/654cc449bfa4627347efcefe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
00/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
00/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/654cc449bfa4627347efcf07
        failing since 29 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-11-09T11:36:35.139369  <8>[   16.956522] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 443359_1.5.2.4.1>
    2023-11-09T11:36:35.244455  / # #
    2023-11-09T11:36:35.346076  export SHELL=3D/bin/sh
    2023-11-09T11:36:35.346676  #
    2023-11-09T11:36:35.447629  / # export SHELL=3D/bin/sh. /lava-443359/en=
vironment
    2023-11-09T11:36:35.448220  =

    2023-11-09T11:36:35.549232  / # . /lava-443359/environment/lava-443359/=
bin/lava-test-runner /lava-443359/1
    2023-11-09T11:36:35.550078  =

    2023-11-09T11:36:35.554813  / # /lava-443359/bin/lava-test-runner /lava=
-443359/1
    2023-11-09T11:36:35.620868  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/654cc478cd70464151efcf0d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
00/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
00/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/654cc478cd70464151efcf16
        failing since 29 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-11-09T11:43:44.954327  / # #

    2023-11-09T11:43:45.056384  export SHELL=3D/bin/sh

    2023-11-09T11:43:45.057095  #

    2023-11-09T11:43:45.158550  / # export SHELL=3D/bin/sh. /lava-11974949/=
environment

    2023-11-09T11:43:45.159243  =


    2023-11-09T11:43:45.260697  / # . /lava-11974949/environment/lava-11974=
949/bin/lava-test-runner /lava-11974949/1

    2023-11-09T11:43:45.261827  =


    2023-11-09T11:43:45.278910  / # /lava-11974949/bin/lava-test-runner /la=
va-11974949/1

    2023-11-09T11:43:45.321592  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-09T11:43:45.336918  + cd /lava-1197494<8>[   18.197280] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11974949_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
