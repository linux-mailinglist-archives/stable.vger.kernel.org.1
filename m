Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2458672A278
	for <lists+stable@lfdr.de>; Fri,  9 Jun 2023 20:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjFISjR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 9 Jun 2023 14:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjFISik (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Jun 2023 14:38:40 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831B73A9A
        for <stable@vger.kernel.org>; Fri,  9 Jun 2023 11:38:15 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-651f2f38634so2139053b3a.0
        for <stable@vger.kernel.org>; Fri, 09 Jun 2023 11:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686335894; x=1688927894;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e7Qt7SMtZCHjb5FNL+Ou4tK4DdxUW10JTcJ3+tnCIvE=;
        b=QXj0mKWTvaikxSAsFXfH1StnAVSMSbtJfkhRcic+XgB7iHjVzeC3VSiMx8bGfAstZV
         oM4jdTx2M7JLzRQQRKUOzYY1Ah6kPeo3x7S6tyGK3VETY3guttiC9CC41YGCvesHDS/e
         BFssekOtINr49PDiO1eepSR/fwo9bo2NxoQ19DAM6u3yJThOm809dRZONwz7RXe0+HxY
         0fn0IHK288HCtUw4juI3aZpoZ08FS1+tiA5kyR7kIWDY2u+qzal9cJ5TRkgG9aoQo05v
         IsDq7icAew5lEOtTxmFMn8s4IRU4mlQd94OSDevea/KgiKWSeapACYDHUXJoUkmnPLqJ
         /gzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686335894; x=1688927894;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e7Qt7SMtZCHjb5FNL+Ou4tK4DdxUW10JTcJ3+tnCIvE=;
        b=G4SxE8dk6upOfEaQdOrVdlHfZ4YmUaZuE2S2PBDYcjbquWli8GkPXTGRfoVHycD/XH
         gJqBOIbUZ7lCDmKadIS8Ybp8dy8y77dPzvYElBjZCaFM0od1ykoPpwiyhiyjSSS2W0ZY
         phFzokvZI3H2TZzJjB0wx7/iAazb6ocjtRfqYi826QPDuAcyVI5nFxUJ8KdnHLJrsWEe
         9N2f96BmGKI/IUtkmalErHYwMBiQac86dtUYxpSJyB7CYpttfOxyxsb6pr3ii54T+15l
         7lbG7/nH2j2sbcd6gRo3e89Iv7xMzlT3iCMjJbSNRbYh5X0z/5/rNeC1Pv0HMjEbHOz/
         FubA==
X-Gm-Message-State: AC+VfDy3I6ypNAd2soWlcdQmgO0KPYrnJu6rXpqR7+turItCF8LmUGcE
        Y+xNYQDIHQH2dIqUUR9X7JCFTQDJakquzXXzBI1X9w==
X-Google-Smtp-Source: ACHHUZ45B08MtPYeXQSuTmgApKkeqHk+zsGRqFgW9JT6tzoithdNhOAeVBABD89Y4tRJf/uj783Q5Q==
X-Received: by 2002:a05:6a20:7343:b0:107:35ed:28b5 with SMTP id v3-20020a056a20734300b0010735ed28b5mr2497261pzc.2.1686335893399;
        Fri, 09 Jun 2023 11:38:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a18-20020a62bd12000000b0064ff855751fsm2968080pff.4.2023.06.09.11.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 11:38:12 -0700 (PDT)
Message-ID: <64837194.620a0220.b499d.65d2@mx.google.com>
Date:   Fri, 09 Jun 2023 11:38:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.4.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.4.246
Subject: stable-rc/linux-5.4.y baseline: 144 runs, 21 regressions (v5.4.246)
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

stable-rc/linux-5.4.y baseline: 144 runs, 21 regressions (v5.4.246)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

da850-lcdk                   | arm    | lab-baylibre  | gcc-10   | multi_v5=
_defconfig           | 1          =

hifive-unleashed-a00         | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a7795-salvator-x           | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.4.y/kern=
el/v5.4.246/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.4.y
  Describe: v5.4.246
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      f568a20f058fa1e37069cff4aac4187c1650a0e9 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64833d42478e5d957e306134

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64833d42478e5d957e306139
        failing since 143 days (last pass: v5.4.226, first fail: v5.4.228-6=
59-gb3b34c474ec7)

    2023-06-09T14:54:33.373788  <8>[   23.731231] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3653429_1.5.2.4.1>
    2023-06-09T14:54:33.482709  / # #
    2023-06-09T14:54:33.585611  export SHELL=3D/bin/sh
    2023-06-09T14:54:33.586509  #
    2023-06-09T14:54:33.688272  / # export SHELL=3D/bin/sh. /lava-3653429/e=
nvironment
    2023-06-09T14:54:33.689116  =

    2023-06-09T14:54:33.791235  / # . /lava-3653429/environment/lava-365342=
9/bin/lava-test-runner /lava-3653429/1
    2023-06-09T14:54:33.792760  =

    2023-06-09T14:54:33.797630  / # /lava-3653429/bin/lava-test-runner /lav=
a-3653429/1
    2023-06-09T14:54:33.891592  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64833d61478e5d957e30615f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64833d61478e5d957e306164
        failing since 143 days (last pass: v5.4.226-68-g8c05f5e0777d, first=
 fail: v5.4.228-659-gb3b34c474ec7)

    2023-06-09T14:54:44.585273  #
    2023-06-09T14:54:44.688497  export SHELL=3D/bin/sh
    2023-06-09T14:54:44.689670  #
    2023-06-09T14:54:44.791973  / # export SHELL=3D/bin/sh. /lava-3653432/e=
nvironment
    2023-06-09T14:54:44.793024  =

    2023-06-09T14:54:44.895251  / # . /lava-3653432/environment/lava-365343=
2/bin/lava-test-runner /lava-3653432/1
    2023-06-09T14:54:44.896857  =

    2023-06-09T14:54:44.901957  / # /lava-3653432/bin/lava-test-runner /lav=
a-3653432/1
    2023-06-09T14:54:44.977816  + export 'TESTRUN_ID=3D1_bootrr'
    2023-06-09T14:54:44.984649  + cd /lava-3653432/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
da850-lcdk                   | arm    | lab-baylibre  | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64833806f7bc3eca35306153

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm/multi_v5_defconfig/gcc-10/lab-baylibre/baseline-da850-lcdk.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm/multi_v5_defconfig/gcc-10/lab-baylibre/baseline-da850-lcdk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64833806f7bc3eca35306158
        failing since 143 days (last pass: v5.4.227, first fail: v5.4.228-6=
59-gb3b34c474ec7)

    2023-06-09T14:31:23.916855  / # #
    2023-06-09T14:31:24.019936  export SHELL=3D/bin/sh
    2023-06-09T14:31:24.020727  #
    2023-06-09T14:31:24.122717  / # export SHELL=3D/bin/sh. /lava-3653309/e=
nvironment
    2023-06-09T14:31:24.123589  =

    2023-06-09T14:31:24.225665  / # . /lava-3653309/environment/lava-365330=
9/bin/lava-test-runner /lava-3653309/1
    2023-06-09T14:31:24.226975  =

    2023-06-09T14:31:24.240115  / # /lava-3653309/bin/lava-test-runner /lav=
a-3653309/1
    2023-06-09T14:31:24.481028  + export 'TESTRUN_ID=3D1_bootrr'
    2023-06-09T14:31:24.484284  + cd /lava-3653309/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hifive-unleashed-a00         | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648338970844fce63c30613a

  Results:     3 PASS, 2 FAIL, 2 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/riscv/defconfig/gcc-10/lab-baylibre/baseline-hifive-unleashed-a00.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/riscv/defconfig/gcc-10/lab-baylibre/baseline-hifive-unleashed-a00.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/riscv/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/648338970844fce6=
3c306143
        failing since 233 days (last pass: v5.4.219, first fail: v5.4.219-2=
67-g4a976f825745)
        3 lines

    2023-06-09T14:34:42.102189  / # =

    2023-06-09T14:34:42.103060  =

    2023-06-09T14:34:44.164592  / # #
    2023-06-09T14:34:44.165477  #
    2023-06-09T14:34:46.177945  / # export SHELL=3D/bin/sh
    2023-06-09T14:34:46.178358  export SHELL=3D/bin/sh
    2023-06-09T14:34:48.193407  / # . /lava-3653282/environment
    2023-06-09T14:34:48.193833  . /lava-3653282/environment
    2023-06-09T14:34:50.209215  / # /lava-3653282/bin/lava-test-runner /lav=
a-3653282/0
    2023-06-09T14:34:50.210362  /lava-3653282/bin/lava-test-runner /lava-36=
53282/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64833b965f1773f4e23061b3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x3=
60-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x3=
60-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64833b965f1773f4e23061b8
        failing since 71 days (last pass: v5.4.238, first fail: v5.4.238)

    2023-06-09T14:47:45.797468  + set<8>[    9.974475] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10660334_1.4.2.3.1>

    2023-06-09T14:47:45.797847   +x

    2023-06-09T14:47:45.902630  / ##

    2023-06-09T14:47:46.004957  export SHELL=3D/bin/sh

    2023-06-09T14:47:46.005725   #

    2023-06-09T14:47:46.107167  / # export SHELL=3D/bin/sh. /lava-10660334/=
environment

    2023-06-09T14:47:46.107532  =


    2023-06-09T14:47:46.208425  / # . /lava-10660334/environment/lava-10660=
334/bin/lava-test-runner /lava-10660334/1

    2023-06-09T14:47:46.209740  =


    2023-06-09T14:47:46.214216  / # /lava-10660334/bin/lava-test-runner /la=
va-10660334/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64833b46263af749fc3062d0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x3=
60-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x3=
60-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64833b46263af749fc3062d5
        failing since 71 days (last pass: v5.4.238, first fail: v5.4.238)

    2023-06-09T14:46:15.201682  <8>[   13.524519] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10660326_1.4.2.3.1>

    2023-06-09T14:46:15.204649  + set +x

    2023-06-09T14:46:15.309863  =


    2023-06-09T14:46:15.411497  / # #export SHELL=3D/bin/sh

    2023-06-09T14:46:15.412215  =


    2023-06-09T14:46:15.513567  / # export SHELL=3D/bin/sh. /lava-10660326/=
environment

    2023-06-09T14:46:15.514267  =


    2023-06-09T14:46:15.615634  / # . /lava-10660326/environment/lava-10660=
326/bin/lava-test-runner /lava-10660326/1

    2023-06-09T14:46:15.616766  =


    2023-06-09T14:46:15.621942  / # /lava-10660326/bin/lava-test-runner /la=
va-10660326/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64833a23094eadd5a7306156

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64833a23094eadd5a7306=
157
        failing since 290 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-390-g1cece69eaa88) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64833ab411f8efc1cb306147

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64833ab411f8efc1cb306=
148
        failing since 290 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-390-g1cece69eaa88) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64833a141b326e371b306130

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64833a141b326e371b306=
131
        failing since 290 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-390-g1cece69eaa88) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64833a241b326e371b306147

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-uefi.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64833a241b326e371b306=
148
        failing since 395 days (last pass: v5.4.191-85-ga4a4cbb41380, first=
 fail: v5.4.191-118-g7dae5fe9ddc0) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64833b0445e7933afa30613e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64833b0445e7933afa306=
13f
        failing since 395 days (last pass: v5.4.191-85-ga4a4cbb41380, first=
 fail: v5.4.191-118-g7dae5fe9ddc0) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64833a289433c1940c30612e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.t=
xt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64833a289433c1940c306=
12f
        failing since 395 days (last pass: v5.4.191-85-ga4a4cbb41380, first=
 fail: v5.4.191-118-g7dae5fe9ddc0) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64833a21312ae5e18630615a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64833a21312ae5e186306=
15b
        failing since 310 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.209) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64833a646762fd484e306178

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64833a646762fd484e306=
179
        failing since 310 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.209) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64833a12094eadd5a7306137

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64833a12094eadd5a7306=
138
        failing since 310 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.209) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64833a22a51ab2c578306136

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-uefi.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64833a22a51ab2c578306=
137
        failing since 290 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-390-g1cece69eaa88) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64833aa0aef6d8167630613d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64833aa0aef6d81676306=
13e
        failing since 290 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-390-g1cece69eaa88) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64833a13094eadd5a730613c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.t=
xt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64833a13094eadd5a7306=
13d
        failing since 290 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-390-g1cece69eaa88) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7795-salvator-x           | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6483396055cf9d587f30612e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm64/defconfig/gcc-10/lab-baylibre/baseline-r8a7795-salvator-x.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm64/defconfig/gcc-10/lab-baylibre/baseline-r8a7795-salvator-x.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6483396055cf9d587f306133
        failing since 42 days (last pass: v5.4.217, first fail: v5.4.238-24=
5-g14f076931beb)

    2023-06-09T14:38:05.401771  + set +x
    2023-06-09T14:38:05.404924  <8>[   69.222908] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3653357_1.5.2.4.1>
    2023-06-09T14:38:05.511107  / # #
    2023-06-09T14:38:05.613919  export SHELL=3D/bin/sh
    2023-06-09T14:38:05.614694  #
    2023-06-09T14:38:05.716125  / # export SHELL=3D/bin/sh. /lava-3653357/e=
nvironment
    2023-06-09T14:38:05.716649  =

    2023-06-09T14:38:05.818075  / # . /lava-3653357/environment/lava-365335=
7/bin/lava-test-runner /lava-3653357/1
    2023-06-09T14:38:05.818902  =

    2023-06-09T14:38:05.822729  / # /lava-3653357/bin/lava-test-runner /lav=
a-3653357/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6483394bf832b97d1030618b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6483394bf832b97d10306=
18c
        failing since 42 days (last pass: v5.4.224-157-g3e1fbfce73e5, first=
 fail: v5.4.238-245-g14f076931beb) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64833b50058a8fc2e73061f0

  Results:     32 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64833b50058a8fc2e730621a
        failing since 142 days (last pass: v5.4.226-68-g97ed976894df, first=
 fail: v5.4.228-659-gb3b34c474ec7)

    2023-06-09T14:46:13.840350  <8>[   16.713921] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3653346_1.5.2.4.1>
    2023-06-09T14:46:13.960383  / # #
    2023-06-09T14:46:14.066017  export SHELL=3D/bin/sh
    2023-06-09T14:46:14.067525  #
    2023-06-09T14:46:14.170969  / # export SHELL=3D/bin/sh. /lava-3653346/e=
nvironment
    2023-06-09T14:46:14.172570  =

    2023-06-09T14:46:14.276020  / # . /lava-3653346/environment/lava-365334=
6/bin/lava-test-runner /lava-3653346/1
    2023-06-09T14:46:14.278803  =

    2023-06-09T14:46:14.281989  / # /lava-3653346/bin/lava-test-runner /lav=
a-3653346/1
    2023-06-09T14:46:14.314067  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =20
