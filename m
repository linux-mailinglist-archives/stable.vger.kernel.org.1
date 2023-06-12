Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A00C72C861
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 16:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbjFLO0o (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 10:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238921AbjFLO0Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 10:26:25 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888A110D9
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 07:24:30 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-662f0feafb2so3152624b3a.1
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 07:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686579869; x=1689171869;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SqEL/PjddhAfT7o8wyHGFMsqAZGNM0KURV1aQluwohs=;
        b=c1wMJC93XmmbG4v8UQUy7/fkpNa9rVV1Fbg1CHoAvR7iCMhT49GA185vWj13ANNiT1
         /LwjIZoFxCQXrev+S86gOO4Q7ICJO+kzNbJtRyVpLW+3IpYajPeO6QpN/p91oUByQdI9
         +LgH6ms2vvGx7Ym8i2cFceR/LrBiDxjuJJZRR1l3Nge7vdaZVSNNCqFyx+62krgazayF
         1XJt7pLu/fi/pP//jTfSwrH6hxovlA+TeU76Fenz2nttcILe2OxX3ojxgHVWkdK8Vl5V
         xwdXvIDvfwe+MloTzxjOlLaWNCTCtThmCq+gdUnv30cQAASvxK5umYvVcpTIHTm4skxF
         e9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686579869; x=1689171869;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SqEL/PjddhAfT7o8wyHGFMsqAZGNM0KURV1aQluwohs=;
        b=cuY+lXs3nzby9u6YXfOL5Y0DRk0xrDQbSiuWoMN+vdbN5Bnl0MKeDhJQUzs7UAJXx1
         YI4D1HOGLOfYt9RlHIPzu/2xYT8Yn8Xx2D0yZXEzpW6WQ9jrKHWnDzcQ6jnsV9WH7rYU
         k8ptA1211a79fXYF675wcBxGIaB5FkfYbKVpzi8wZxQv2gQEMlaPomA05v/jHZIlcQox
         2us/peaRyCR8vXhEG6HOcpvfcnSob7MhTAJEGF4n5nUJlcjvpKsY/BLDYgeJRurvA2oi
         lMLlaso+393PlpHDG0YDb/+ZNRkEeWr91ie3a/Hy14wBujIWgGut0lNF9NLRgwHJLTzj
         Nw4g==
X-Gm-Message-State: AC+VfDw6W04owbsTdVMSwDbuhnPvnAguzISKujPkEu5ksG2niris8Km/
        kbXsZVsnoUAIzVmkrIZ1/aZ+2aW5HCpxgPN61DRcQg==
X-Google-Smtp-Source: ACHHUZ7PgUnI7ee3XZLNct3JCge7FCvTkuzjzkwpohzb1na+hanD43rMTpxGkPgjvr8ehhvRuHHPkQ==
X-Received: by 2002:a05:6a00:2da3:b0:652:a559:b2c5 with SMTP id fb35-20020a056a002da300b00652a559b2c5mr11448730pfb.13.1686579867838;
        Mon, 12 Jun 2023 07:24:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a14-20020a62e20e000000b00654ecbafeadsm6937973pfi.218.2023.06.12.07.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 07:24:27 -0700 (PDT)
Message-ID: <64872a9b.620a0220.628a3.cec7@mx.google.com>
Date:   Mon, 12 Jun 2023 07:24:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.4.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.4.246-38-g7bfc32eb1006b
Subject: stable-rc/linux-5.4.y baseline: 153 runs,
 23 regressions (v5.4.246-38-g7bfc32eb1006b)
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

stable-rc/linux-5.4.y baseline: 153 runs, 23 regressions (v5.4.246-38-g7bfc=
32eb1006b)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

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

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.4.y/kern=
el/v5.4.246-38-g7bfc32eb1006b/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.4.y
  Describe: v5.4.246-38-g7bfc32eb1006b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      7bfc32eb1006b67177591f1031ee9a75e017c144 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6486f9a7c616b7c8be306138

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6486f9a7c616b7c8be30613d
        failing since 146 days (last pass: v5.4.226, first fail: v5.4.228-6=
59-gb3b34c474ec7)

    2023-06-12T10:55:22.236809  <8>[   23.643341] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3658782_1.5.2.4.1>
    2023-06-12T10:55:22.347003  / # #
    2023-06-12T10:55:22.450171  export SHELL=3D/bin/sh
    2023-06-12T10:55:22.451065  #
    2023-06-12T10:55:22.553000  / # export SHELL=3D/bin/sh. /lava-3658782/e=
nvironment
    2023-06-12T10:55:22.554065  =

    2023-06-12T10:55:22.656586  / # . /lava-3658782/environment/lava-365878=
2/bin/lava-test-runner /lava-3658782/1
    2023-06-12T10:55:22.658371  =

    2023-06-12T10:55:22.663670  / # /lava-3658782/bin/lava-test-runner /lav=
a-3658782/1
    2023-06-12T10:55:22.755407  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6486f91ad44cd62451306140

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6486f91ad44cd62451306=
141
        new failure (last pass: v5.4.246-37-g37d240d8ed43) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6486f85002a7d6b3ea306193

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6486f85002a7d6b3ea306198
        failing since 146 days (last pass: v5.4.226-68-g8c05f5e0777d, first=
 fail: v5.4.228-659-gb3b34c474ec7)

    2023-06-12T10:49:24.730652  + set +x<8>[    9.828465] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3658775_1.5.2.4.1>
    2023-06-12T10:49:24.730960  =

    2023-06-12T10:49:24.838048  / # #
    2023-06-12T10:49:24.939520  export SHELL=3D/bin/sh
    2023-06-12T10:49:24.939905  #
    2023-06-12T10:49:25.041138  / # export SHELL=3D/bin/sh. /lava-3658775/e=
nvironment
    2023-06-12T10:49:25.041505  =

    2023-06-12T10:49:25.142729  / # . /lava-3658775/environment/lava-365877=
5/bin/lava-test-runner /lava-3658775/1
    2023-06-12T10:49:25.143496  =

    2023-06-12T10:49:25.143709  / # <3>[   10.160253] Bluetooth: hci0: comm=
and 0x0c03 tx timeout =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
da850-lcdk                   | arm    | lab-baylibre  | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6486f690046c615ab4306169

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm/multi_v5_defconfig/gcc-10/lab-baylibre/baseline-da85=
0-lcdk.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm/multi_v5_defconfig/gcc-10/lab-baylibre/baseline-da85=
0-lcdk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6486f690046c615ab430616c
        failing since 146 days (last pass: v5.4.227, first fail: v5.4.228-6=
59-gb3b34c474ec7)

    2023-06-12T10:41:58.280369  / # #
    2023-06-12T10:41:58.381877  export SHELL=3D/bin/sh
    2023-06-12T10:41:58.382244  #
    2023-06-12T10:41:58.483373  / # export SHELL=3D/bin/sh. /lava-3658709/e=
nvironment
    2023-06-12T10:41:58.483843  =

    2023-06-12T10:41:58.584978  / # . /lava-3658709/environment/lava-365870=
9/bin/lava-test-runner /lava-3658709/1
    2023-06-12T10:41:58.585597  =

    2023-06-12T10:41:58.628602  / # /lava-3658709/bin/lava-test-runner /lav=
a-3658709/1
    2023-06-12T10:41:58.840054  + export 'TESTRUN_ID=3D1_bootrr'
    2023-06-12T10:41:58.843180  + cd /lava-3658709/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hifive-unleashed-a00         | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6486f6a0fc40854166306144

  Results:     3 PASS, 2 FAIL, 2 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/riscv/defconfig/gcc-10/lab-baylibre/baseline-hifive-unle=
ashed-a00.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/riscv/defconfig/gcc-10/lab-baylibre/baseline-hifive-unle=
ashed-a00.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/riscv/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/6486f6a0fc408541=
6630614d
        failing since 236 days (last pass: v5.4.219, first fail: v5.4.219-2=
67-g4a976f825745)
        3 lines

    2023-06-12T10:42:19.308840  / # =

    2023-06-12T10:42:19.309687  =

    2023-06-12T10:42:21.373361  / # #
    2023-06-12T10:42:21.374546  #
    2023-06-12T10:42:23.385590  / # export SHELL=3D/bin/sh
    2023-06-12T10:42:23.386333  export SHELL=3D/bin/sh
    2023-06-12T10:42:25.401097  / # . /lava-3658671/environment
    2023-06-12T10:42:25.401529  . /lava-3658671/environment
    2023-06-12T10:42:27.416840  / # /lava-3658671/bin/lava-test-runner /lav=
a-3658671/0
    2023-06-12T10:42:27.418699  /lava-3658671/bin/lava-test-runner /lava-36=
58671/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6486f6a3fc40854166306171

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6486f6a3fc40854166306176
        failing since 73 days (last pass: v5.4.238, first fail: v5.4.238)

    2023-06-12T10:42:28.576477  + set<8>[    9.923088] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10688093_1.4.2.3.1>

    2023-06-12T10:42:28.576569   +x

    2023-06-12T10:42:28.678378  =


    2023-06-12T10:42:28.778967  / # #export SHELL=3D/bin/sh

    2023-06-12T10:42:28.779184  =


    2023-06-12T10:42:28.879687  / # export SHELL=3D/bin/sh. /lava-10688093/=
environment

    2023-06-12T10:42:28.879870  =


    2023-06-12T10:42:28.980387  / # . /lava-10688093/environment/lava-10688=
093/bin/lava-test-runner /lava-10688093/1

    2023-06-12T10:42:28.980767  =


    2023-06-12T10:42:28.984923  / # /lava-10688093/bin/lava-test-runner /la=
va-10688093/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6486f6a3fc4085416630617c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6486f6a3fc40854166306181
        failing since 73 days (last pass: v5.4.238, first fail: v5.4.238)

    2023-06-12T10:42:41.515017  <8>[   10.374065] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10688058_1.4.2.3.1>

    2023-06-12T10:42:41.518857  + set +x

    2023-06-12T10:42:41.623224  / # #

    2023-06-12T10:42:41.723905  export SHELL=3D/bin/sh

    2023-06-12T10:42:41.724116  #

    2023-06-12T10:42:41.824666  / # export SHELL=3D/bin/sh. /lava-10688058/=
environment

    2023-06-12T10:42:41.824887  =


    2023-06-12T10:42:41.925449  / # . /lava-10688058/environment/lava-10688=
058/bin/lava-test-runner /lava-10688058/1

    2023-06-12T10:42:41.925840  =


    2023-06-12T10:42:41.931031  / # /lava-10688058/bin/lava-test-runner /la=
va-10688058/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6486f5fc51c52476873063b1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6486f5fc51c5247687306=
3b2
        failing since 293 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-390-g1cece69eaa88) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6486f5ea548c0d5ff03061a2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6486f5ea548c0d5ff0306=
1a3
        failing since 293 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-390-g1cece69eaa88) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6486f5d0317b9bd16930614a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6486f5d0317b9bd169306=
14b
        failing since 293 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-390-g1cece69eaa88) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6486f5e7548c0d5ff0306199

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6486f5e7548c0d5ff0306=
19a
        failing since 314 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.207-123-gb48a8f43dce6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6486f77af5aac8993530612e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6486f77af5aac89935306=
12f
        failing since 314 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.207-123-gb48a8f43dce6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6486f5d2fcc7858e0b306162

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6486f5d2fcc7858e0b306=
163
        failing since 314 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.207-123-gb48a8f43dce6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6486f5e5548c0d5ff0306190

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6486f5e5548c0d5ff0306=
191
        failing since 312 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.209) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6486f7511e9213281630613d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6486f7511e92132816306=
13e
        failing since 312 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.209) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6486f5d1d411030eca306133

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6486f5d1d411030eca306=
134
        failing since 312 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.209) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6486f5fbc42f20caca30616a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6486f5fbc42f20caca306=
16b
        failing since 293 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-390-g1cece69eaa88) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6486f5e9548c0d5ff030619f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6486f5e9548c0d5ff0306=
1a0
        failing since 293 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-390-g1cece69eaa88) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6486f5cf317b9bd169306147

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6486f5cf317b9bd169306=
148
        failing since 293 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-390-g1cece69eaa88) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7795-salvator-x           | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6486f5102340c9c1fa306186

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm64/defconfig/gcc-10/lab-baylibre/baseline-r8a7795-sal=
vator-x.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm64/defconfig/gcc-10/lab-baylibre/baseline-r8a7795-sal=
vator-x.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6486f5102340c9c1fa30618b
        failing since 45 days (last pass: v5.4.217, first fail: v5.4.238-24=
5-g14f076931beb)

    2023-06-12T10:35:36.549392  + set +x
    2023-06-12T10:35:36.552530  <8>[   68.405864] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3658654_1.5.2.4.1>
    2023-06-12T10:35:36.658711  / # #
    2023-06-12T10:35:36.760889  export SHELL=3D/bin/sh
    2023-06-12T10:35:36.761537  #
    2023-06-12T10:35:36.863378  / # export SHELL=3D/bin/sh. /lava-3658654/e=
nvironment
    2023-06-12T10:35:36.863853  =

    2023-06-12T10:35:36.965363  / # . /lava-3658654/environment/lava-365865=
4/bin/lava-test-runner /lava-3658654/1
    2023-06-12T10:35:36.966068  =

    2023-06-12T10:35:36.969835  / # /lava-3658654/bin/lava-test-runner /lav=
a-3658654/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6486f4fc7409250e2430616b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6486f4fc7409250e24306=
16c
        failing since 45 days (last pass: v5.4.224-157-g3e1fbfce73e5, first=
 fail: v5.4.238-245-g14f076931beb) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6486f69942d5495e2a306156

  Results:     32 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-=
pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-=
pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6486f69942d5495e2a306179
        failing since 145 days (last pass: v5.4.226-68-g97ed976894df, first=
 fail: v5.4.228-659-gb3b34c474ec7)

    2023-06-12T10:42:13.296805  <8>[   16.704651] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3658664_1.5.2.4.1>
    2023-06-12T10:42:13.416878  / # #
    2023-06-12T10:42:13.522580  export SHELL=3D/bin/sh
    2023-06-12T10:42:13.524139  #
    2023-06-12T10:42:13.627800  / # export SHELL=3D/bin/sh. /lava-3658664/e=
nvironment
    2023-06-12T10:42:13.629447  =

    2023-06-12T10:42:13.732899  / # . /lava-3658664/environment/lava-365866=
4/bin/lava-test-runner /lava-3658664/1
    2023-06-12T10:42:13.735572  =

    2023-06-12T10:42:13.738805  / # /lava-3658664/bin/lava-test-runner /lav=
a-3658664/1
    2023-06-12T10:42:13.771152  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6486f5032340c9c1fa306147

  Results:     32 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-p=
ine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.246=
-38-g7bfc32eb1006b/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-p=
ine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6486f5032340c9c1fa30616e
        failing since 145 days (last pass: v5.4.226-68-g97ed976894df, first=
 fail: v5.4.228-659-gb3b34c474ec7)

    2023-06-12T10:35:22.058913  <8>[   16.729278] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 596954_1.5.2.4.1>
    2023-06-12T10:35:22.167589  / # #
    2023-06-12T10:35:22.270239  export SHELL=3D/bin/sh
    2023-06-12T10:35:22.270824  #
    2023-06-12T10:35:22.372707  / # export SHELL=3D/bin/sh. /lava-596954/en=
vironment
    2023-06-12T10:35:22.373385  =

    2023-06-12T10:35:22.475204  / # . /lava-596954/environment/lava-596954/=
bin/lava-test-runner /lava-596954/1
    2023-06-12T10:35:22.476721  =

    2023-06-12T10:35:22.479753  / # /lava-596954/bin/lava-test-runner /lava=
-596954/1
    2023-06-12T10:35:22.513393  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =20
