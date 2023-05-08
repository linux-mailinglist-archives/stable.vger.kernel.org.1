Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C5C6F9DB3
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 04:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjEHCYf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 22:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjEHCYe (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 22:24:34 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4586E2697
        for <stable@vger.kernel.org>; Sun,  7 May 2023 19:24:32 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-51b661097bfso2722300a12.0
        for <stable@vger.kernel.org>; Sun, 07 May 2023 19:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683512671; x=1686104671;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mw8ZeX1/RrVH4RX8gK8dBgCOeXFUjgajq7WXkVBwbEA=;
        b=2SrRNhtMbff07f2qkfEiGraYmRiElX8PuSA//eaU5k8RyQ53yscJytBYw2RORb3fA7
         bi4AJvbJZYFwddA5mUEPg4fKycbQ7pYfO2ppTWw0er0jI1aVLl1AYtxNnzk19mSPvV2n
         PETJqRWJSBzYRWAggcrWylChk2iUqYMtkFf5qhlrQiN9S5U990AVQM8VMpVyDqNwsDqr
         YGbkHYTMJ6hWt3vz4iDVPz9zMc1WBqmIXZa+z+Ix1uazoNkg9QsnX5tfedlwS9ALv5jQ
         jLIde7r2eXkfv/q2bhtpNIfvjhvV03Na/qjsPv0vpQO8fT4rYEHtXlzW6Xry+uHq+Chu
         OR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683512671; x=1686104671;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mw8ZeX1/RrVH4RX8gK8dBgCOeXFUjgajq7WXkVBwbEA=;
        b=Bg1XnEmgUkXugKeH2/nrLz600kJW+TlXzwOWYnEFCLIvJjfywWI+1YLGMnxtRVbPtq
         dxnEhk3UidMNiqjgiiZCCxBV/rCEgeZ05rjnB6RPUbOnpwoMKpX2wB2whsVKjtpp/v4z
         5hBEGvgvB4OaCKzJ28LCisv3FgTvfrPkcZ00FTqr+DFn4/3ClndMYt8T9wLNZaaX2fB7
         /KH/424LhyC7BLl9paTAKezXlQLbOpcJHstevShstL8ix/Q/RjmhCsZ32ACjcYbJF4kL
         rK3/j4dNBmFEt9XzzDAqaeAU3ekKMbDWUt3cnFPW8dGS9CR2vygnWSDAjXZICOU9WUkL
         a7ZQ==
X-Gm-Message-State: AC+VfDzGpTOYMB7bUZu9KRJf9wgoplSaKIGQXOofaRHNwTIji9TeGmdy
        dEstq/VL9K1/qZ3S6ASW00O+qIh4bu6jRK97+/JP6w==
X-Google-Smtp-Source: ACHHUZ67rElDCrEAevgU9nZPqxRceE9//pFiHEgLHQIBB/5nE1Ko+wyf0z54YcgbntiW00O8/SZYEA==
X-Received: by 2002:a17:90b:23c9:b0:247:603a:bd60 with SMTP id md9-20020a17090b23c900b00247603abd60mr9158594pjb.45.1683512670656;
        Sun, 07 May 2023 19:24:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ku12-20020a17090b218c00b0023a9564763bsm8615035pjb.29.2023.05.07.19.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 19:24:30 -0700 (PDT)
Message-ID: <64585d5e.170a0220.a3c9c.11cc@mx.google.com>
Date:   Sun, 07 May 2023 19:24:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.105-737-g6d55a9d91feaf
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 162 runs,
 8 regressions (v5.15.105-737-g6d55a9d91feaf)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/queue/5.15 baseline: 162 runs, 8 regressions (v5.15.105-737-g6d55=
a9d91feaf)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.105-737-g6d55a9d91feaf/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.105-737-g6d55a9d91feaf
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      6d55a9d91feaf9d7953470b4a14cdf5f022055b5 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6458296d1a7b1dffa22e85f3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-737-g6d55a9d91feaf/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-737-g6d55a9d91feaf/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6458296d1a7b1dffa22e85f8
        failing since 40 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-07T22:42:26.798319  + <8>[    9.301348] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10233347_1.4.2.3.1>

    2023-05-07T22:42:26.798403  set +x

    2023-05-07T22:42:26.902837  / # #

    2023-05-07T22:42:27.003527  export SHELL=3D/bin/sh

    2023-05-07T22:42:27.003706  #

    2023-05-07T22:42:27.104193  / # export SHELL=3D/bin/sh. /lava-10233347/=
environment

    2023-05-07T22:42:27.104368  =


    2023-05-07T22:42:27.204896  / # . /lava-10233347/environment/lava-10233=
347/bin/lava-test-runner /lava-10233347/1

    2023-05-07T22:42:27.205216  =


    2023-05-07T22:42:27.210374  / # /lava-10233347/bin/lava-test-runner /la=
va-10233347/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6458296e5968f368dd2e85e7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-737-g6d55a9d91feaf/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-737-g6d55a9d91feaf/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6458296f5968f368dd2e85ec
        failing since 40 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-07T22:42:29.842117  <8>[   11.811582] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10233345_1.4.2.3.1>

    2023-05-07T22:42:29.845460  + set +x

    2023-05-07T22:42:29.953184  / # #

    2023-05-07T22:42:30.053843  export SHELL=3D/bin/sh

    2023-05-07T22:42:30.054123  #

    2023-05-07T22:42:30.154876  / # export SHELL=3D/bin/sh. /lava-10233345/=
environment

    2023-05-07T22:42:30.155054  =


    2023-05-07T22:42:30.255716  / # . /lava-10233345/environment/lava-10233=
345/bin/lava-test-runner /lava-10233345/1

    2023-05-07T22:42:30.256863  =


    2023-05-07T22:42:30.262346  / # /lava-10233345/bin/lava-test-runner /la=
va-10233345/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6458296764cf8d3b222e8670

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-737-g6d55a9d91feaf/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-737-g6d55a9d91feaf/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6458296764cf8d3b222e8675
        failing since 40 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-07T22:42:38.343725  + set +x

    2023-05-07T22:42:38.350512  <8>[   10.283389] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10233370_1.4.2.3.1>

    2023-05-07T22:42:38.455095  / # #

    2023-05-07T22:42:38.555803  export SHELL=3D/bin/sh

    2023-05-07T22:42:38.555996  #

    2023-05-07T22:42:38.656483  / # export SHELL=3D/bin/sh. /lava-10233370/=
environment

    2023-05-07T22:42:38.656671  =


    2023-05-07T22:42:38.757150  / # . /lava-10233370/environment/lava-10233=
370/bin/lava-test-runner /lava-10233370/1

    2023-05-07T22:42:38.757439  =


    2023-05-07T22:42:38.761966  / # /lava-10233370/bin/lava-test-runner /la=
va-10233370/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6458295764cf8d3b222e8626

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-737-g6d55a9d91feaf/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-737-g6d55a9d91feaf/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6458295764cf8d3b222e862b
        failing since 40 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-07T22:42:11.940689  <8>[    8.187400] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10233334_1.4.2.3.1>

    2023-05-07T22:42:11.943974  + set +x

    2023-05-07T22:42:12.045813  =


    2023-05-07T22:42:12.146442  / # #export SHELL=3D/bin/sh

    2023-05-07T22:42:12.146679  =


    2023-05-07T22:42:12.247224  / # export SHELL=3D/bin/sh. /lava-10233334/=
environment

    2023-05-07T22:42:12.247444  =


    2023-05-07T22:42:12.348000  / # . /lava-10233334/environment/lava-10233=
334/bin/lava-test-runner /lava-10233334/1

    2023-05-07T22:42:12.348340  =


    2023-05-07T22:42:12.353573  / # /lava-10233334/bin/lava-test-runner /la=
va-10233334/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6458296ae0ba13ad132e85f2

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-737-g6d55a9d91feaf/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-737-g6d55a9d91feaf/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6458296ae0ba13ad132e85f7
        failing since 40 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-07T22:42:32.527092  + set +x<8>[   10.840920] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10233324_1.4.2.3.1>

    2023-05-07T22:42:32.527185  =


    2023-05-07T22:42:32.631498  / # #

    2023-05-07T22:42:32.732089  export SHELL=3D/bin/sh

    2023-05-07T22:42:32.732274  #

    2023-05-07T22:42:32.832825  / # export SHELL=3D/bin/sh. /lava-10233324/=
environment

    2023-05-07T22:42:32.833010  =


    2023-05-07T22:42:32.933524  / # . /lava-10233324/environment/lava-10233=
324/bin/lava-test-runner /lava-10233324/1

    2023-05-07T22:42:32.933801  =


    2023-05-07T22:42:32.938410  / # /lava-10233324/bin/lava-test-runner /la=
va-10233324/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64582c40a3a477181e2e85f4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-737-g6d55a9d91feaf/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-=
imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-737-g6d55a9d91feaf/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-=
imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64582c40a3a477181e2e85f9
        failing since 100 days (last pass: v5.15.81-121-gcb14018a85f6, firs=
t fail: v5.15.90-146-gbf7101723cc0)

    2023-05-07T22:54:49.605200  + set +x
    2023-05-07T22:54:49.605354  [    9.430975] <LAVA_SIGNAL_ENDRUN 0_dmesg =
943290_1.5.2.3.1>
    2023-05-07T22:54:49.712257  / # #
    2023-05-07T22:54:49.813618  export SHELL=3D/bin/sh
    2023-05-07T22:54:49.813928  #
    2023-05-07T22:54:49.915161  / # export SHELL=3D/bin/sh. /lava-943290/en=
vironment
    2023-05-07T22:54:49.915590  =

    2023-05-07T22:54:50.016991  / # . /lava-943290/environment/lava-943290/=
bin/lava-test-runner /lava-943290/1
    2023-05-07T22:54:50.017612  =

    2023-05-07T22:54:50.020153  / # /lava-943290/bin/lava-test-runner /lava=
-943290/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64582954d15be8b0432e8633

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-737-g6d55a9d91feaf/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-737-g6d55a9d91feaf/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64582954d15be8b0432e8638
        failing since 40 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-07T22:42:16.207574  + set<8>[   12.055778] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10233306_1.4.2.3.1>

    2023-05-07T22:42:16.207657   +x

    2023-05-07T22:42:16.311966  / # #

    2023-05-07T22:42:16.412634  export SHELL=3D/bin/sh

    2023-05-07T22:42:16.412823  #

    2023-05-07T22:42:16.513398  / # export SHELL=3D/bin/sh. /lava-10233306/=
environment

    2023-05-07T22:42:16.513572  =


    2023-05-07T22:42:16.614132  / # . /lava-10233306/environment/lava-10233=
306/bin/lava-test-runner /lava-10233306/1

    2023-05-07T22:42:16.614447  =


    2023-05-07T22:42:16.618697  / # /lava-10233306/bin/lava-test-runner /la=
va-10233306/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64582f7a0847bb96eb2e85e6

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-737-g6d55a9d91feaf/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64=
-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-737-g6d55a9d91feaf/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64=
-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64582f7a0847bb96eb2e8613
        failing since 110 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-07T23:07:51.638809  + set +x
    2023-05-07T23:07:51.642999  <8>[   16.045019] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3563011_1.5.2.4.1>
    2023-05-07T23:07:51.763419  / # #
    2023-05-07T23:07:51.869069  export SHELL=3D/bin/sh
    2023-05-07T23:07:51.870586  #
    2023-05-07T23:07:51.974022  / # export SHELL=3D/bin/sh. /lava-3563011/e=
nvironment
    2023-05-07T23:07:51.975608  =

    2023-05-07T23:07:52.079174  / # . /lava-3563011/environment/lava-356301=
1/bin/lava-test-runner /lava-3563011/1
    2023-05-07T23:07:52.081849  =

    2023-05-07T23:07:52.085156  / # /lava-3563011/bin/lava-test-runner /lav=
a-3563011/1 =

    ... (12 line(s) more)  =

 =20
