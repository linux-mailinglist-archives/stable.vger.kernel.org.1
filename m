Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8942575E411
	for <lists+stable@lfdr.de>; Sun, 23 Jul 2023 19:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjGWRjU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 13:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjGWRjU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 13:39:20 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889EB180
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 10:39:17 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666eb03457cso1940027b3a.1
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 10:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690133956; x=1690738756;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aprTf09PTjx3DQdXlTEDJ6j3LkxRBoB3K4beEuegh18=;
        b=RfFVdzYHsqRRdb/ktVHhB/z6WLuFewKeW/8ZzSP2n8szU/Hx7QzbvoPsDGNV80ZJD2
         vc5yVOGOuz0EcbCuy3Da3WrIgS8/MvE2r9zU9uTPIm/b190Lw1YxSqJSQSw5LvH2hgAu
         gUHhaB8W9MXP8pcTSsfL181xIdSabayXRSxOu39ioiQ+c+xIlG8BMLAEdMpXSuRHYsKj
         vL9fxiZGx/AqcYd5qtn5KdqNqOJ/nDfOU50orICaSJgqLbABFwNOO2FLm0POsApWqfjt
         EWvSGsH2vs3QSGWk60wZxmN4vIL9ILbT9lfTb+mgMExAysZLN1cHnlPYm4R4BXBvgejE
         AawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690133956; x=1690738756;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aprTf09PTjx3DQdXlTEDJ6j3LkxRBoB3K4beEuegh18=;
        b=QObuey9eVYJjzcAAP6eIBnTHE9WUgzEfQ07s7qidEfqORhMDWIPL6DVK5sP47TGWL4
         0ToM2fLxLSMr8QpSy31z3SCRaENiqsXhC0LnTwETg6nmSqHhP+fzoKu0jx6wrV4XNa6k
         kRlUKdCcK2XF9N7AWeFeZ/Ez5cGWd0CZ9zDNTVSn/JC8+z5hKTRThTLoqmxAUTPlz2In
         KDhzfJDeT/SfXtPjhAP+KozW3FXP+Wsa98ObdnNc3cuqtiHkJNK1re9KkHv9aKf81Cm0
         hKmSrpIRL2qDpEf1EpHhBwNRUvvCxx9hkrNuVM7uDL7BCaYeQ3pIyzTdmND6g/ViZwbR
         JUlA==
X-Gm-Message-State: ABy/qLaEc7+SkfDXqbELEt9rHhaUwS0vEF48QSCkYxQs4IcSlkAx2viO
        JSfcdfUVxsqCH/NtSM+my0WRO11hKydhC2cmeS8=
X-Google-Smtp-Source: APBJJlE8evc4nUB7kRakPaqrelF+Wu3ZQGaJ44+OCQEkyDir2LcNCkvKNYHB18SE0pmJ+gS+mnr2CA==
X-Received: by 2002:a17:90b:4f47:b0:268:96e:31e1 with SMTP id pj7-20020a17090b4f4700b00268096e31e1mr1359912pjb.49.1690133956333;
        Sun, 23 Jul 2023 10:39:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bt21-20020a17090af01500b00263f6687690sm5256216pjb.18.2023.07.23.10.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 10:39:15 -0700 (PDT)
Message-ID: <64bd65c3.170a0220.a8007.8bfa@mx.google.com>
Date:   Sun, 23 Jul 2023 10:39:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.4.y
X-Kernelci-Kernel: v5.4.249
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.4.y baseline: 140 runs, 19 regressions (v5.4.249)
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

stable-rc/linux-5.4.y baseline: 140 runs, 19 regressions (v5.4.249)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hifive-unleashed-a00         | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.4.y/kern=
el/v5.4.249/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.4.y
  Describe: v5.4.249
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b30db4f7e45f3c17cca2ba5be6f22762837a6e34 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64a048deda8e0f5688bb2a9c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a048deda8e0f5688bb2aa1
        failing since 165 days (last pass: v5.4.226-68-g8c05f5e0777d, first=
 fail: v5.4.228-659-gb3b34c474ec7)

    2023-07-19T18:39:11.018034  <8>[    9.816832] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3723407_1.5.2.4.1>
    2023-07-19T18:39:11.125069  / # #
    2023-07-19T18:39:11.226754  export SHELL=3D/bin/sh
    2023-07-19T18:39:11.227189  #
    2023-07-19T18:39:11.328463  / # export SHELL=3D/bin/sh. /lava-3723407/e=
nvironment
    2023-07-19T18:39:11.328909  =

    2023-07-19T18:39:11.430197  / # . /lava-3723407/environment/lava-372340=
7/bin/lava-test-runner /lava-3723407/1
    2023-07-19T18:39:11.430863  =

    2023-07-19T18:39:11.435504  / # /lava-3723407/bin/lava-test-runner /lav=
a-3723407/1
    2023-07-19T18:39:11.513219  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hifive-unleashed-a00         | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649c14834066a81fafd7d606

  Results:     3 PASS, 2 FAIL, 2 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/riscv/defconfig/gcc-10/lab-baylibre/baseline-hifive-unleashed-a00.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/riscv/defconfig/gcc-10/lab-baylibre/baseline-hifive-unleashed-a00.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/riscv/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/649c14834066a81f=
afd7d60b
        failing since 252 days (last pass: v5.4.219, first fail: v5.4.219-2=
67-g4a976f825745)
        3 lines

    2023-07-19T18:34:32.942393  / # =

    2023-07-19T18:34:32.949576  =

    2023-07-19T18:34:33.055760  / # #
    2023-07-19T18:34:33.061501  #
    2023-07-19T18:34:33.164340  / # export SHELL=3D/bin/sh
    2023-07-19T18:34:33.173640  export SHELL=3D/bin/sh
    2023-07-19T18:34:33.275892  / # . /lava-3723389/environment
    2023-07-19T18:34:33.285725  . /lava-3723389/environment
    2023-07-19T18:34:33.388066  / # /lava-3723389/bin/lava-test-runner /lav=
a-3723389/0
    2023-07-19T18:34:33.397828  /lava-3723389/bin/lava-test-runner /lava-37=
23389/0 =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c16770753a47e2ad7d60c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x3=
60-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x3=
60-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c16770753a47e2ad7d615
        failing since 89 days (last pass: v5.4.238, first fail: v5.4.238)

    2023-07-19T18:54:29.559345  + set<8>[   10.044444] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11114370_1.4.2.3.1>

    2023-07-19T18:54:29.559435   +x

    2023-07-19T18:54:29.661090  #

    2023-07-19T18:54:29.661363  =


    2023-07-19T18:54:29.761938  / # #export SHELL=3D/bin/sh

    2023-07-19T18:54:29.762128  =


    2023-07-19T18:54:29.862661  / # export SHELL=3D/bin/sh. /lava-11114370/=
environment

    2023-07-19T18:54:29.862878  =


    2023-07-19T18:54:29.963433  / # . /lava-11114370/environment/lava-11114=
370/bin/lava-test-runner /lava-11114370/1

    2023-07-19T18:54:29.963709  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c164a04309b4c85d7d5fe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x3=
60-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x3=
60-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c164a04309b4c85d7d607
        failing since 89 days (last pass: v5.4.238, first fail: v5.4.238)

    2023-07-19T18:54:41.161449  + set +x

    2023-07-19T18:54:41.167906  <8>[   12.612370] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11114351_1.4.2.3.1>

    2023-07-19T18:54:41.269745  =


    2023-07-19T18:54:41.370285  / # #export SHELL=3D/bin/sh

    2023-07-19T18:54:41.370477  =


    2023-07-19T18:54:41.470952  / # export SHELL=3D/bin/sh. /lava-11114351/=
environment

    2023-07-19T18:54:41.471181  =


    2023-07-19T18:54:41.571724  / # . /lava-11114351/environment/lava-11114=
351/bin/lava-test-runner /lava-11114351/1

    2023-07-19T18:54:41.572037  =


    2023-07-19T18:54:41.577401  / # /lava-11114351/bin/lava-test-runner /la=
va-11114351/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/649c16db48dd7fb803d7d60e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-v=
irt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-v=
irt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649c16db48dd7fb803d7d=
60f
        failing since 328 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.209) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/649c16ece420d37717d7d606

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vi=
rt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vi=
rt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649c16ece420d37717d7d=
607
        failing since 328 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.209) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/649c16b61f16bc1143d7d5ec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-=
virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-=
virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649c16b71f16bc1143d7d=
5ed
        failing since 328 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.209) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/649c16dccab7797328d7d606

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-v=
irt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-v=
irt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649c16dccab7797328d7d=
607
        failing since 330 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.207-123-gb48a8f43dce6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/649c1700d7d786b3e0d7d62c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vi=
rt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vi=
rt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649c1700d7d786b3e0d7d=
62d
        failing since 330 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.207-123-gb48a8f43dce6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/649c16b6858b53e184d7d622

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-=
virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-=
virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649c16b6858b53e184d7d=
623
        failing since 330 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.207-123-gb48a8f43dce6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/649c16dfe420d37717d7d5e7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-v=
irt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-v=
irt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649c16dfe420d37717d7d=
5e8
        failing since 328 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.209) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/649c1764a626067a6dd7d5f0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vi=
rt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vi=
rt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649c1764a626067a6dd7d=
5f1
        failing since 328 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.209) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/649c16b7858b53e184d7d630

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-=
virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-=
virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649c16b7858b53e184d7d=
631
        failing since 328 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.209) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/649c16dde420d37717d7d5e1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-v=
irt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-v=
irt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649c16dde420d37717d7d=
5e2
        failing since 317 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-258-ge86027f8111f5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/649c1702e420d37717d7d62c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vi=
rt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vi=
rt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649c1702e420d37717d7d=
62d
        failing since 317 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-258-ge86027f8111f5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/649c16b73ba8f89559d7d618

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-=
virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-=
virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649c16b73ba8f89559d7d=
619
        failing since 317 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-258-ge86027f8111f5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/649c166a0e0d072b82d7d61a

  Results:     82 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-=
kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-=
kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/649c166a0e0d072b82d7d624
        failing since 106 days (last pass: v5.4.235, first fail: v5.4.235-4=
-gb829e8b6e1a7)

    2023-07-19T18:29:18.520620  /lava-11114137/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/649c166a0e0d072b82d7d625
        failing since 106 days (last pass: v5.4.235, first fail: v5.4.235-4=
-gb829e8b6e1a7)

    2023-07-19T18:29:16.485261  <8>[   31.217419] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-07-19T18:29:17.498352  /lava-11114137/1/../bin/lava-test-case

    2023-07-19T18:29:17.506926  <8>[   32.240278] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b82daa967c31015c8ace21

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-libretech-all=
-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-libretech-all=
-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b82daa967c31015c8ace26
        failing since 183 days (last pass: v5.4.227, first fail: v5.4.228-6=
59-gb3b34c474ec7)

    2023-07-19T18:38:24.940087  <8>[    7.822011] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3723406_1.5.2.4.1>
    2023-07-19T18:38:25.047932  / # #
    2023-07-19T18:38:25.150606  export SHELL=3D/bin/sh
    2023-07-19T18:38:25.151447  #
    2023-07-19T18:38:25.253296  / # export SHELL=3D/bin/sh. /lava-3723406/e=
nvironment
    2023-07-19T18:38:25.254157  =

    2023-07-19T18:38:25.355952  / # . /lava-3723406/environment/lava-372340=
6/bin/lava-test-runner /lava-3723406/1
    2023-07-19T18:38:25.357180  =

    2023-07-19T18:38:25.371524  / # /lava-3723406/bin/lava-test-runner /lav=
a-3723406/1
    2023-07-19T18:38:25.460372  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
