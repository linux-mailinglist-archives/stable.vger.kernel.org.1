Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA546F99BB
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 18:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjEGQ0p (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 12:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEGQ0o (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 12:26:44 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3966712096
        for <stable@vger.kernel.org>; Sun,  7 May 2023 09:26:42 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64115e652eeso29526869b3a.0
        for <stable@vger.kernel.org>; Sun, 07 May 2023 09:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683476801; x=1686068801;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CGB6SHHXl10w2vgjGHs8wraGMlL1L60Sc0YFjWwGZU4=;
        b=tqachoFT7FuIy8kJ3bHVvIh7BEl2Nk2Uc9X7HqPmKNp96hGGdye3JXq5zVXzKMWIif
         9Nm8b3EaM5ubCCfxkUiGsRhPtjMDuw1rQQoLQyWvM/HLhqEXWNBW8hx3R22QPzereiV+
         sOn7+r6FS9sNduWAyJkcqCmFHhmuzY9MdjFe1fRiiaOBWrpFwpPfpbpOBkIecw6O+/tZ
         Z5gPd3dV99f7gNRAkR8cQ4RH/T0EtWhf64m8Zz3UIOjkTNeAKcvj/vtXJeqhYpeZlyEo
         0PL3RGh2sDy0gYFCdgoZZTz3Hdglr+rJXkmmwhU/P5+3CsDntxrpkys8QcPcZ97m5wkg
         y43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683476801; x=1686068801;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CGB6SHHXl10w2vgjGHs8wraGMlL1L60Sc0YFjWwGZU4=;
        b=CAPJPjHELJEEmIgB+iRamMlFf07HUSY0iEKzVfqURZy3Gd9gfFj88slglNQuNt71WM
         bPxUCM+Yemn2S2Osq05dNwRifx6smToWpX5RA/Be/EH6kmQp0sqYp96gr/pQ310rcRw7
         8RDicwr90xRvQNMbAVnimJP1dYMSb++xmAnaZhC6IoqfJSTOej3A4jh+JlrcaM/ByxRy
         pQwwClqvU8aTc3Eu48hVF3RNamxJMhWs8uvjhEtJQ/+MXTj5LI9P6eHLucxM+ryI+Gqj
         16NUqON5dfTjF8575lUK3AjbGZsX8mBalUxWpkVtMcr1VW5OM1O+FfPK10mPWIReICSO
         tMVA==
X-Gm-Message-State: AC+VfDxSS1e/vK02fMnGDYnsBXmVxFClrFRpccXyQE/1i8og/ss/ibsA
        UQxwrjvyOaw67b1ugNiaY4XHH5E5vhRebro5t3x2/Q==
X-Google-Smtp-Source: ACHHUZ6KdNiFYe3+I1FgWk110ELW4eEpDZeZYjKps9pTI3UFwYlIZ8f6Bp6FR/YIm8kUjGpLZEjBuA==
X-Received: by 2002:a17:903:187:b0:1ab:11d5:4f07 with SMTP id z7-20020a170903018700b001ab11d54f07mr16143731plg.18.1683476801021;
        Sun, 07 May 2023 09:26:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902820200b001a95c743ca2sm5349330pln.94.2023.05.07.09.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 09:26:40 -0700 (PDT)
Message-ID: <6457d140.170a0220.67b91.9ab6@mx.google.com>
Date:   Sun, 07 May 2023 09:26:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.105-727-g99d928e8b191
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 159 runs,
 8 regressions (v5.15.105-727-g99d928e8b191)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/queue/5.15 baseline: 159 runs, 8 regressions (v5.15.105-727-g99d9=
28e8b191)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
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

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.105-727-g99d928e8b191/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.105-727-g99d928e8b191
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      99d928e8b191bf4d4a6b7b9b4be13d1c0dbb17db =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64579ae28cbb70a2fb2e85fc

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-727-g99d928e8b191/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-727-g99d928e8b191/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64579ae28cbb70a2fb2e8601
        failing since 40 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-07T12:34:22.148540  + <8>[   11.677469] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10226994_1.4.2.3.1>

    2023-05-07T12:34:22.149020  set +x

    2023-05-07T12:34:22.256683  / # #

    2023-05-07T12:34:22.359124  export SHELL=3D/bin/sh

    2023-05-07T12:34:22.359883  #

    2023-05-07T12:34:22.461330  / # export SHELL=3D/bin/sh. /lava-10226994/=
environment

    2023-05-07T12:34:22.461575  =


    2023-05-07T12:34:22.562383  / # . /lava-10226994/environment/lava-10226=
994/bin/lava-test-runner /lava-10226994/1

    2023-05-07T12:34:22.563660  =


    2023-05-07T12:34:22.568663  / # /lava-10226994/bin/lava-test-runner /la=
va-10226994/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64579aed8cbb70a2fb2e8683

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-727-g99d928e8b191/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-727-g99d928e8b191/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64579aed8cbb70a2fb2e8688
        failing since 40 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-07T12:34:32.789983  + set +x

    2023-05-07T12:34:32.796771  <8>[    8.078415] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10226980_1.4.2.3.1>

    2023-05-07T12:34:32.901395  / # #

    2023-05-07T12:34:33.002023  export SHELL=3D/bin/sh

    2023-05-07T12:34:33.002184  #

    2023-05-07T12:34:33.102692  / # export SHELL=3D/bin/sh. /lava-10226980/=
environment

    2023-05-07T12:34:33.102857  =


    2023-05-07T12:34:33.203437  / # . /lava-10226980/environment/lava-10226=
980/bin/lava-test-runner /lava-10226980/1

    2023-05-07T12:34:33.203726  =


    2023-05-07T12:34:33.209072  / # /lava-10226980/bin/lava-test-runner /la=
va-10226980/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64579ad4acb66f29702e8637

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-727-g99d928e8b191/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-727-g99d928e8b191/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64579ad4acb66f29702e863c
        failing since 40 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-07T12:34:13.329498  + set +x

    2023-05-07T12:34:13.335555  <8>[   11.123948] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10226965_1.4.2.3.1>

    2023-05-07T12:34:13.440386  / # #

    2023-05-07T12:34:13.541251  export SHELL=3D/bin/sh

    2023-05-07T12:34:13.541514  #

    2023-05-07T12:34:13.642147  / # export SHELL=3D/bin/sh. /lava-10226965/=
environment

    2023-05-07T12:34:13.642418  =


    2023-05-07T12:34:13.743078  / # . /lava-10226965/environment/lava-10226=
965/bin/lava-test-runner /lava-10226965/1

    2023-05-07T12:34:13.743537  =


    2023-05-07T12:34:13.748553  / # /lava-10226965/bin/lava-test-runner /la=
va-10226965/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64579ae48cbb70a2fb2e8612

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-727-g99d928e8b191/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-727-g99d928e8b191/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64579ae48cbb70a2fb2e8617
        failing since 40 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-07T12:34:20.834941  + set<8>[   11.309616] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10226997_1.4.2.3.1>

    2023-05-07T12:34:20.835550   +x

    2023-05-07T12:34:20.943475  / # #

    2023-05-07T12:34:21.045812  export SHELL=3D/bin/sh

    2023-05-07T12:34:21.046609  #

    2023-05-07T12:34:21.148227  / # export SHELL=3D/bin/sh. /lava-10226997/=
environment

    2023-05-07T12:34:21.149102  =


    2023-05-07T12:34:21.250609  / # . /lava-10226997/environment/lava-10226=
997/bin/lava-test-runner /lava-10226997/1

    2023-05-07T12:34:21.251884  =


    2023-05-07T12:34:21.257241  / # /lava-10226997/bin/lava-test-runner /la=
va-10226997/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64579bb5bc784c94c52e85e9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-727-g99d928e8b191/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-i=
mx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-727-g99d928e8b191/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-i=
mx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64579bb5bc784c94c52e85ee
        failing since 100 days (last pass: v5.15.81-121-gcb14018a85f6, firs=
t fail: v5.15.90-146-gbf7101723cc0)

    2023-05-07T12:37:24.534813  + set +x
    2023-05-07T12:37:24.534990  [    9.491265] <LAVA_SIGNAL_ENDRUN 0_dmesg =
942771_1.5.2.3.1>
    2023-05-07T12:37:24.642044  / # #
    2023-05-07T12:37:24.743598  export SHELL=3D/bin/sh
    2023-05-07T12:37:24.744092  #
    2023-05-07T12:37:24.845284  / # export SHELL=3D/bin/sh. /lava-942771/en=
vironment
    2023-05-07T12:37:24.845749  =

    2023-05-07T12:37:24.947054  / # . /lava-942771/environment/lava-942771/=
bin/lava-test-runner /lava-942771/1
    2023-05-07T12:37:24.947708  =

    2023-05-07T12:37:24.950081  / # /lava-942771/bin/lava-test-runner /lava=
-942771/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64579ad1acb66f29702e862a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-727-g99d928e8b191/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-727-g99d928e8b191/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64579ad1acb66f29702e862f
        failing since 40 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-07T12:34:12.789330  <8>[   11.805907] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10226957_1.4.2.3.1>

    2023-05-07T12:34:12.893443  / # #

    2023-05-07T12:34:12.993951  export SHELL=3D/bin/sh

    2023-05-07T12:34:12.994110  #

    2023-05-07T12:34:13.094585  / # export SHELL=3D/bin/sh. /lava-10226957/=
environment

    2023-05-07T12:34:13.094739  =


    2023-05-07T12:34:13.195198  / # . /lava-10226957/environment/lava-10226=
957/bin/lava-test-runner /lava-10226957/1

    2023-05-07T12:34:13.195434  =


    2023-05-07T12:34:13.199893  / # /lava-10226957/bin/lava-test-runner /la=
va-10226957/1

    2023-05-07T12:34:13.205337  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64579ef70d6d280f7d2e8617

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-727-g99d928e8b191/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-727-g99d928e8b191/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64579ef70d6d280f7d2e8=
618
        new failure (last pass: v5.15.105-715-gb6b6662beaab) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64579e4fa8eca89fd82e85ea

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-727-g99d928e8b191/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-=
pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-727-g99d928e8b191/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-=
pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64579e4fa8eca89fd82e8615
        failing since 109 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-07T12:48:49.892920  <8>[   16.086464] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3560408_1.5.2.4.1>
    2023-05-07T12:48:50.013027  / # #
    2023-05-07T12:48:50.118620  export SHELL=3D/bin/sh
    2023-05-07T12:48:50.120207  #
    2023-05-07T12:48:50.223544  / # export SHELL=3D/bin/sh. /lava-3560408/e=
nvironment
    2023-05-07T12:48:50.225045  =

    2023-05-07T12:48:50.328574  / # . /lava-3560408/environment/lava-356040=
8/bin/lava-test-runner /lava-3560408/1
    2023-05-07T12:48:50.331302  =

    2023-05-07T12:48:50.334566  / # /lava-3560408/bin/lava-test-runner /lav=
a-3560408/1
    2023-05-07T12:48:50.381007  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
