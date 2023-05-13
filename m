Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0B5701925
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 20:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjEMS0J (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 14:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjEMS0J (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 14:26:09 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032D91BC7
        for <stable@vger.kernel.org>; Sat, 13 May 2023 11:26:06 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-643a6f993a7so6943653b3a.1
        for <stable@vger.kernel.org>; Sat, 13 May 2023 11:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684002366; x=1686594366;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DDOijm/+VfaF6SxIrpqWKqhcrlkQBXdgu8cyAiOjzLA=;
        b=thxzGkY2FA6aNgwcGgvSUlujFjQvkTe/ronV0LoUgd7ldohWNFS1cMVdInIiOfuwaM
         rBhZGg1hJVFcMKy9e/VzZq5pLM6baQubfi6rmVVdEwjnFVViFB9Fz1WxM4ZaqTg3/+q2
         NqWi4bQ2SyYmvvO6fiympYBNZ91Z3/BeSGwTF6E6nZk+BKXYYwP5c6Ci7rAnHCn5kf0E
         20uKJrLSS6RZcawhNdrdd1+Aa+7U7bui8qfG/sSAMj8HtWN64hPNaQ2KokrSnQ+iMpAo
         UXJM+nJZCeFN6ItRTKCstgUsac2+zTBqZB7y4mKI5CBOo6rgxMscftKoi9zNDcRFifV+
         xqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684002366; x=1686594366;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DDOijm/+VfaF6SxIrpqWKqhcrlkQBXdgu8cyAiOjzLA=;
        b=H5oMmZeKjG5LnZkiJuLMacZJDhMwGelov0l9WWxD4GSN3T8CZehj2aT33zdURgiZdk
         ZQjBUXuC8V2oIEFyj2XJvE/hEx5E8LU8DsOBgghJ6MSzY9FHQz3mgdpBVAIjVzb4eKu3
         LxyyBnuvl0zNWaFQGdbTPo82w2879aSp9KoDU4ChaYpTWCi0NpS7Ter5rKcJLLemL5RG
         o6ptmJbODYh+PdgzFdDMFfxsSttDG5PJfPqxc6MCrUFHev4xifFP/3rryney40SG3hAK
         ZHjT3OkAx+7j/dAbfpLaEvmoRfHkIa9Gc/7dwCT9/c+sCFSRgMymbzMUYXKYJyJE/YJ/
         x2Dw==
X-Gm-Message-State: AC+VfDxpL3jA2SImoyg0YG+DuzFj47t4pFO81ga0b1lQJoUjT1BH8bxl
        GjPOtNtQskVOTtUuR55l8tzT3wNGTGs0frrbLH4=
X-Google-Smtp-Source: ACHHUZ6HYVwjGT6NldT1CFdF2AO3cFTui7B26sPhO/1YL4Vq3V5QjPUYmZXY+dbBrqjVvPSebmyFbQ==
X-Received: by 2002:a05:6a00:16c5:b0:63d:38db:60ef with SMTP id l5-20020a056a0016c500b0063d38db60efmr33112121pfc.26.1684002365888;
        Sat, 13 May 2023 11:26:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p5-20020aa78605000000b006438898ce82sm9241646pfn.140.2023.05.13.11.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 11:26:05 -0700 (PDT)
Message-ID: <645fd63d.a70a0220.12b8a.291e@mx.google.com>
Date:   Sat, 13 May 2023 11:26:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.111-105-g1c740a39cc067
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 178 runs,
 9 regressions (v5.15.111-105-g1c740a39cc067)
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

stable-rc/queue/5.15 baseline: 178 runs, 9 regressions (v5.15.111-105-g1c74=
0a39cc067)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.111-105-g1c740a39cc067/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.111-105-g1c740a39cc067
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      1c740a39cc06703b66091e80cdc063d939d60ec6 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645fa12762fdeb287a2e860c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-105-g1c740a39cc067/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-105-g1c740a39cc067/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645fa12762fdeb287a2e8611
        failing since 46 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-13T14:39:27.986728  + set<8>[   10.937282] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10305963_1.4.2.3.1>

    2023-05-13T14:39:27.986839   +x

    2023-05-13T14:39:28.091003  / # #

    2023-05-13T14:39:28.191646  export SHELL=3D/bin/sh

    2023-05-13T14:39:28.191859  #

    2023-05-13T14:39:28.292337  / # export SHELL=3D/bin/sh. /lava-10305963/=
environment

    2023-05-13T14:39:28.292595  =


    2023-05-13T14:39:28.393208  / # . /lava-10305963/environment/lava-10305=
963/bin/lava-test-runner /lava-10305963/1

    2023-05-13T14:39:28.393580  =


    2023-05-13T14:39:28.397959  / # /lava-10305963/bin/lava-test-runner /la=
va-10305963/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645fa1337a80792ed62e85f3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-105-g1c740a39cc067/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-105-g1c740a39cc067/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645fa1337a80792ed62e85f8
        failing since 46 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-13T14:39:23.337895  <8>[   11.632541] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10306016_1.4.2.3.1>

    2023-05-13T14:39:23.341404  + set +x

    2023-05-13T14:39:23.442689  #

    2023-05-13T14:39:23.443230  =


    2023-05-13T14:39:23.544245  / # #export SHELL=3D/bin/sh

    2023-05-13T14:39:23.544981  =


    2023-05-13T14:39:23.646384  / # export SHELL=3D/bin/sh. /lava-10306016/=
environment

    2023-05-13T14:39:23.647125  =


    2023-05-13T14:39:23.748589  / # . /lava-10306016/environment/lava-10306=
016/bin/lava-test-runner /lava-10306016/1

    2023-05-13T14:39:23.749755  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/645fa6f5d7121724202e8600

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-105-g1c740a39cc067/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-105-g1c740a39cc067/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645fa6f5d7121724202e8=
601
        failing since 99 days (last pass: v5.15.91-12-g3290f78df1ab, first =
fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645fa4e18ed6c7fd9d2e8650

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-105-g1c740a39cc067/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-105-g1c740a39cc067/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645fa4e18ed6c7fd9d2e8655
        failing since 116 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-13T14:55:04.562073  + set +x<8>[   10.077607] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3584879_1.5.2.4.1>
    2023-05-13T14:55:04.562717  =

    2023-05-13T14:55:04.671339  / # #
    2023-05-13T14:55:04.774521  export SHELL=3D/bin/sh
    2023-05-13T14:55:04.775347  #
    2023-05-13T14:55:04.877154  / # export SHELL=3D/bin/sh. /lava-3584879/e=
nvironment
    2023-05-13T14:55:04.878284  =

    2023-05-13T14:55:04.980561  / # . /lava-3584879/environment/lava-358487=
9/bin/lava-test-runner /lava-3584879/1
    2023-05-13T14:55:04.982423  =

    2023-05-13T14:55:04.986708  / # /lava-3584879/bin/lava-test-runner /lav=
a-3584879/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645fa121f7f06dc4ce2e8607

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-105-g1c740a39cc067/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-105-g1c740a39cc067/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645fa121f7f06dc4ce2e860c
        failing since 46 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-13T14:39:17.096971  + <8>[   10.915157] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10306010_1.4.2.3.1>

    2023-05-13T14:39:17.097060  set +x

    2023-05-13T14:39:17.198243  #

    2023-05-13T14:39:17.299084  / # #export SHELL=3D/bin/sh

    2023-05-13T14:39:17.299301  =


    2023-05-13T14:39:17.399801  / # export SHELL=3D/bin/sh. /lava-10306010/=
environment

    2023-05-13T14:39:17.400042  =


    2023-05-13T14:39:17.500661  / # . /lava-10306010/environment/lava-10306=
010/bin/lava-test-runner /lava-10306010/1

    2023-05-13T14:39:17.500944  =


    2023-05-13T14:39:17.505308  / # /lava-10306010/bin/lava-test-runner /la=
va-10306010/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645fa120f7f06dc4ce2e85f1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-105-g1c740a39cc067/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-105-g1c740a39cc067/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645fa120f7f06dc4ce2e85f6
        failing since 46 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-13T14:39:20.168507  + <8>[   11.036309] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10306008_1.4.2.3.1>

    2023-05-13T14:39:20.168630  set +x

    2023-05-13T14:39:20.272724  / # #

    2023-05-13T14:39:20.373281  export SHELL=3D/bin/sh

    2023-05-13T14:39:20.373470  #

    2023-05-13T14:39:20.473976  / # export SHELL=3D/bin/sh. /lava-10306008/=
environment

    2023-05-13T14:39:20.474174  =


    2023-05-13T14:39:20.574657  / # . /lava-10306008/environment/lava-10306=
008/bin/lava-test-runner /lava-10306008/1

    2023-05-13T14:39:20.574944  =


    2023-05-13T14:39:20.579451  / # /lava-10306008/bin/lava-test-runner /la=
va-10306008/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645fa1131ebb7cee862e8600

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-105-g1c740a39cc067/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-105-g1c740a39cc067/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645fa1131ebb7cee862e8605
        failing since 46 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-13T14:39:02.735866  <8>[   12.572951] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10305957_1.4.2.3.1>

    2023-05-13T14:39:02.840086  / # #

    2023-05-13T14:39:02.940791  export SHELL=3D/bin/sh

    2023-05-13T14:39:02.941000  #

    2023-05-13T14:39:03.041529  / # export SHELL=3D/bin/sh. /lava-10305957/=
environment

    2023-05-13T14:39:03.041719  =


    2023-05-13T14:39:03.142235  / # . /lava-10305957/environment/lava-10305=
957/bin/lava-test-runner /lava-10305957/1

    2023-05-13T14:39:03.142538  =


    2023-05-13T14:39:03.146955  / # /lava-10305957/bin/lava-test-runner /la=
va-10305957/1

    2023-05-13T14:39:03.152631  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/645fa45836ad95c9c82e868a

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-105-g1c740a39cc067/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64=
-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-105-g1c740a39cc067/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64=
-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645fa45836ad95c9c82e86b3
        failing since 115 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-13T14:52:46.115374  + set +x
    2023-05-13T14:52:46.122673  <8>[   16.149971] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3584817_1.5.2.4.1>
    2023-05-13T14:52:46.241936  / # #
    2023-05-13T14:52:46.347682  export SHELL=3D/bin/sh
    2023-05-13T14:52:46.349297  #
    2023-05-13T14:52:46.452865  / # export SHELL=3D/bin/sh. /lava-3584817/e=
nvironment
    2023-05-13T14:52:46.454380  =

    2023-05-13T14:52:46.557925  / # . /lava-3584817/environment/lava-358481=
7/bin/lava-test-runner /lava-3584817/1
    2023-05-13T14:52:46.560627  =

    2023-05-13T14:52:46.563925  / # /lava-3584817/bin/lava-test-runner /lav=
a-3584817/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/645fa43309d27d43d52e8651

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-105-g1c740a39cc067/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-=
h2-plus-orangepi-r1.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-105-g1c740a39cc067/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-=
h2-plus-orangepi-r1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645fa43309d27d43d52e8656
        failing since 101 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.90-203-gea2e94bef77e)

    2023-05-13T14:51:47.166150  / # #
    2023-05-13T14:51:47.271621  export SHELL=3D/bin/sh
    2023-05-13T14:51:47.273129  #
    2023-05-13T14:51:47.376460  / # export SHELL=3D/bin/sh. /lava-3584757/e=
nvironment
    2023-05-13T14:51:47.378022  =

    2023-05-13T14:51:47.481359  / # . /lava-3584757/environment/lava-358475=
7/bin/lava-test-runner /lava-3584757/1
    2023-05-13T14:51:47.484062  =

    2023-05-13T14:51:47.491369  / # /lava-3584757/bin/lava-test-runner /lav=
a-3584757/1
    2023-05-13T14:51:47.611079  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-13T14:51:47.614376  + cd /lava-3584757/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
