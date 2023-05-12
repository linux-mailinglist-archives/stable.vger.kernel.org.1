Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D3E70089B
	for <lists+stable@lfdr.de>; Fri, 12 May 2023 15:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240407AbjELNIK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 12 May 2023 09:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240712AbjELNIJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 12 May 2023 09:08:09 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC3ED05E
        for <stable@vger.kernel.org>; Fri, 12 May 2023 06:08:06 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-643a6f993a7so6082427b3a.1
        for <stable@vger.kernel.org>; Fri, 12 May 2023 06:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683896886; x=1686488886;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+RgIm3lOyuZv/4v1Rmp7jbChAqM1k+FhXGF3oZUmyjM=;
        b=z6G9V5fMv3+SFcJKCrjhLTXqR/swcv+j9wYJ7Jv8StuvKVCOX6vicfm7pMUGzn9pjO
         V280oD5BiIHmGDZfVX2wZg4xh0a3u5fIsizb0abSkXu0H2EiUyFOJZQw6a82mG9NNLTy
         FVbkKBi4DgA3/nNpUYnAHlb1k4haT1Lyfm0chS0uVi9DEaoNFG0J2mX6UF5l81u1ZFSV
         Ig8xJ1IDyIkXVkYEnw+Qxzq9gDj18gQk9Cy8dLHoB9bIBg8glDIeU2K7LhwUozGgBOVu
         W9ro1Lagyw/wR+VmbMea5JzniaKKo2nYFNwRBaZD3svuwlLhsutarMDhaz/UBeV5FO7V
         i0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683896886; x=1686488886;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+RgIm3lOyuZv/4v1Rmp7jbChAqM1k+FhXGF3oZUmyjM=;
        b=SgFjVfdsv4Us85XlceI7AM1ANUMolygyuMJwaD82PDc0SAPyjLZic6ShN2jRx0tmjF
         +gnrcdxJXFu91nFpNE1/wvV9zuOe6E9OVGv0+L7eD4e0RBRx20vhXTkxgbIDy1I4XIb2
         lhtgKe/TefcpId8nEfaeBN964SbTJnrjQaLQfIaGxfQvAwM4d5eIhkBSgiAiuelrXHtW
         Wj+c7kzgcQyVnvGvESTyGzEYiySaH9UJA5+c5HPWxHCg09noxkVfAzCmzSjf3cMPUmOZ
         klrzVkhq0PyGWG23YwwdalKGP2HjLzLCLVXGP2lU0ZQ8zSuJeA7mW6goN1Z8/7CIPNQM
         M76A==
X-Gm-Message-State: AC+VfDzq+aVIuLmc4PzXdSLaoHAQy6y7wf5UrnxbEu+vkrftCtXfvt3S
        UDK+iJmZdKAJ+82IIaC1UYzAxt4nYq2IJI7Ho1M=
X-Google-Smtp-Source: ACHHUZ6M8QiLfZ6MqI2O8GngMh7ZM4ANWn316LGZG3sww3fugvTFMZwvIxkyCQySgvLgbUHedfzvvA==
X-Received: by 2002:a05:6a20:9389:b0:ff:e397:cb7e with SMTP id x9-20020a056a20938900b000ffe397cb7emr27987748pzh.33.1683896885690;
        Fri, 12 May 2023 06:08:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k13-20020aa7820d000000b0064182e41e21sm7006530pfi.81.2023.05.12.06.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 06:08:04 -0700 (PDT)
Message-ID: <645e3a34.a70a0220.83dcb.e645@mx.google.com>
Date:   Fri, 12 May 2023 06:08:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.111-63-g64f6528a07317
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 181 runs,
 9 regressions (v5.15.111-63-g64f6528a07317)
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

stable-rc/queue/5.15 baseline: 181 runs, 9 regressions (v5.15.111-63-g64f65=
28a07317)

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

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.111-63-g64f6528a07317/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.111-63-g64f6528a07317
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      64f6528a073178e436e4186b80a7c6401a75d9c6 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645e037722ba9466f32e8628

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g64f6528a07317/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g64f6528a07317/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645e037722ba9466f32e862d
        failing since 44 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-12T09:14:11.821112  + set<8>[   11.077329] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10295833_1.4.2.3.1>

    2023-05-12T09:14:11.821685   +x

    2023-05-12T09:14:11.929443  / # #

    2023-05-12T09:14:12.031897  export SHELL=3D/bin/sh

    2023-05-12T09:14:12.032560  #

    2023-05-12T09:14:12.134079  / # export SHELL=3D/bin/sh. /lava-10295833/=
environment

    2023-05-12T09:14:12.134766  =


    2023-05-12T09:14:12.236240  / # . /lava-10295833/environment/lava-10295=
833/bin/lava-test-runner /lava-10295833/1

    2023-05-12T09:14:12.237654  =


    2023-05-12T09:14:12.242667  / # /lava-10295833/bin/lava-test-runner /la=
va-10295833/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645e037ecc9b2328242e8612

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g64f6528a07317/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g64f6528a07317/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645e037ecc9b2328242e8617
        failing since 44 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-12T09:14:16.293814  <8>[    9.996772] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10295836_1.4.2.3.1>

    2023-05-12T09:14:16.297243  + set +x

    2023-05-12T09:14:16.398857  #

    2023-05-12T09:14:16.399126  =


    2023-05-12T09:14:16.499733  / # #export SHELL=3D/bin/sh

    2023-05-12T09:14:16.499912  =


    2023-05-12T09:14:16.600402  / # export SHELL=3D/bin/sh. /lava-10295836/=
environment

    2023-05-12T09:14:16.600595  =


    2023-05-12T09:14:16.701114  / # . /lava-10295836/environment/lava-10295=
836/bin/lava-test-runner /lava-10295836/1

    2023-05-12T09:14:16.701349  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/645e0a613aa9deefe82e85f5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g64f6528a07317/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g64f6528a07317/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645e0a613aa9deefe82e8=
5f6
        failing since 97 days (last pass: v5.15.91-12-g3290f78df1ab, first =
fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645e03fab111fed5342e8661

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g64f6528a07317/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g64f6528a07317/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645e03fab111fed5342e8666
        failing since 115 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-12T09:16:22.838353  <8>[    9.922555] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3579832_1.5.2.4.1>
    2023-05-12T09:16:22.945297  / # #
    2023-05-12T09:16:23.047389  export SHELL=3D/bin/sh
    2023-05-12T09:16:23.048058  #
    2023-05-12T09:16:23.149360  / # export SHELL=3D/bin/sh. /lava-3579832/e=
nvironment
    2023-05-12T09:16:23.149889  =

    2023-05-12T09:16:23.251152  / # . /lava-3579832/environment/lava-357983=
2/bin/lava-test-runner /lava-3579832/1
    2023-05-12T09:16:23.252867  =

    2023-05-12T09:16:23.253319  / # <3>[   10.272549] Bluetooth: hci0: comm=
and 0xfc18 tx timeout
    2023-05-12T09:16:23.257270  /lava-3579832/bin/lava-test-runner /lava-35=
79832/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645e0381cc9b2328242e8677

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g64f6528a07317/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g64f6528a07317/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645e0381cc9b2328242e867c
        failing since 44 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-12T09:14:25.993164  + <8>[   10.902314] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10295877_1.4.2.3.1>

    2023-05-12T09:14:25.993258  set +x

    2023-05-12T09:14:26.094741  #

    2023-05-12T09:14:26.195555  / # #export SHELL=3D/bin/sh

    2023-05-12T09:14:26.195774  =


    2023-05-12T09:14:26.296331  / # export SHELL=3D/bin/sh. /lava-10295877/=
environment

    2023-05-12T09:14:26.296533  =


    2023-05-12T09:14:26.397031  / # . /lava-10295877/environment/lava-10295=
877/bin/lava-test-runner /lava-10295877/1

    2023-05-12T09:14:26.397423  =


    2023-05-12T09:14:26.401724  / # /lava-10295877/bin/lava-test-runner /la=
va-10295877/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645e037922ba9466f32e8637

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g64f6528a07317/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g64f6528a07317/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645e037922ba9466f32e863c
        failing since 44 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-12T09:14:18.409227  + set +x<8>[   11.087756] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10295870_1.4.2.3.1>

    2023-05-12T09:14:18.409387  =


    2023-05-12T09:14:18.512232  #

    2023-05-12T09:14:18.613294  / # #export SHELL=3D/bin/sh

    2023-05-12T09:14:18.613566  =


    2023-05-12T09:14:18.714193  / # export SHELL=3D/bin/sh. /lava-10295870/=
environment

    2023-05-12T09:14:18.714469  =


    2023-05-12T09:14:18.815139  / # . /lava-10295870/environment/lava-10295=
870/bin/lava-test-runner /lava-10295870/1

    2023-05-12T09:14:18.815434  =


    2023-05-12T09:14:18.820143  / # /lava-10295870/bin/lava-test-runner /la=
va-10295870/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645e0388e83ee253d12e85ed

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g64f6528a07317/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g64f6528a07317/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645e0388e83ee253d12e85f2
        failing since 44 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-12T09:14:26.425500  + set<8>[   10.791814] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10295856_1.4.2.3.1>

    2023-05-12T09:14:26.425583   +x

    2023-05-12T09:14:26.529930  / # #

    2023-05-12T09:14:26.630507  export SHELL=3D/bin/sh

    2023-05-12T09:14:26.630637  #

    2023-05-12T09:14:26.731139  / # export SHELL=3D/bin/sh. /lava-10295856/=
environment

    2023-05-12T09:14:26.731273  =


    2023-05-12T09:14:26.831790  / # . /lava-10295856/environment/lava-10295=
856/bin/lava-test-runner /lava-10295856/1

    2023-05-12T09:14:26.832004  =


    2023-05-12T09:14:26.836571  / # /lava-10295856/bin/lava-test-runner /la=
va-10295856/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645e037422ba9466f32e8612

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g64f6528a07317/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g64f6528a07317/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645e037422ba9466f32e8617
        failing since 44 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-12T09:14:16.523954  + set<8>[   11.920963] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10295861_1.4.2.3.1>

    2023-05-12T09:14:16.524078   +x

    2023-05-12T09:14:16.628229  / # #

    2023-05-12T09:14:16.729062  export SHELL=3D/bin/sh

    2023-05-12T09:14:16.729296  #

    2023-05-12T09:14:16.829846  / # export SHELL=3D/bin/sh. /lava-10295861/=
environment

    2023-05-12T09:14:16.830043  =


    2023-05-12T09:14:16.930550  / # . /lava-10295861/environment/lava-10295=
861/bin/lava-test-runner /lava-10295861/1

    2023-05-12T09:14:16.930963  =


    2023-05-12T09:14:16.935570  / # /lava-10295861/bin/lava-test-runner /la=
va-10295861/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/645e09afed11915c942e85f2

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g64f6528a07317/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-=
pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g64f6528a07317/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-=
pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645e09afed11915c942e861e
        failing since 114 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-12T09:40:40.379062  + set +x
    2023-05-12T09:40:40.383138  <8>[   16.212249] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3579912_1.5.2.4.1>
    2023-05-12T09:40:40.503161  / # #
    2023-05-12T09:40:40.608730  export SHELL=3D/bin/sh
    2023-05-12T09:40:40.610236  #
    2023-05-12T09:40:40.713886  / # export SHELL=3D/bin/sh. /lava-3579912/e=
nvironment
    2023-05-12T09:40:40.717016  =

    2023-05-12T09:40:40.823335  / # . /lava-3579912/environment/lava-357991=
2/bin/lava-test-runner /lava-3579912/1
    2023-05-12T09:40:40.828747  =

    2023-05-12T09:40:40.831269  / # /lava-3579912/bin/lava-test-runner /lav=
a-3579912/1 =

    ... (12 line(s) more)  =

 =20
