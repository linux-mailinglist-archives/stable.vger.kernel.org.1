Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AD36F0713
	for <lists+stable@lfdr.de>; Thu, 27 Apr 2023 16:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjD0OPy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Apr 2023 10:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243563AbjD0OPy (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Apr 2023 10:15:54 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC09844BA
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 07:15:48 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63b5c4c769aso10660878b3a.3
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 07:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682604948; x=1685196948;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RpfjTWiKGRk5nAF+Q0TPE/L3DWLP7WAAJYzVLx55Ahw=;
        b=PerFerXunYKXpLcq7j+MV1FBChGh46PE7iS2E3zlXZnkZ/DFAxWMngUxQc6LCWXfLA
         8I4uBXhGtPhebThu95XU3eway38LUJ41Wu5bdTgbVuid1C0f0L7ySmc1Qie5QGsV78rI
         b6/K1MRuWrB1Tb/btY3GzwdFxGAmhmFh3P6k0rCd3MCzzlJVBeB6FH34ZzPDm2glrW6A
         FcuVQGcjLICXLOSzn7JAN9DWcinees1hvWca23XBC+U18OG5xap3+vsb1zqCV5l8d825
         kwkl5bJ8k3NAJ6Wwbh7nFohzppZTSZ1fkvukvbh7yhXVJRaQhvGAxyGXEDwDPf6cVeFv
         45vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682604948; x=1685196948;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RpfjTWiKGRk5nAF+Q0TPE/L3DWLP7WAAJYzVLx55Ahw=;
        b=BBLhhQW+iSr9BE1SgtlzHHIjs2beN+qTN2RkLINwc0aYl9C3CC/cIV8bg6F281dJhE
         W+iaVAbF8Zhg2M9UE68UwtaQG7CEOMLKE6YnrWWDiJ34JnCpHY53G9UNVduWC3W+5IeW
         cVCjptQKJocwrI4OgwiKcvW6AXWCGV7fbJWz0AXJKsSwhGVCrkRAQ7ZaIkvXUP6Dmc8V
         iNDVyuq40SZ8/MmgeB/STMmUrqZnCO90MVnLoKoE5EIe8Xlk4qAAmtSL6YQnIdzWpNV+
         gn+JEPIksMuydch++ACgOUuHrT0ka2RAvhw3tYM+PopUrhbicrOatthEywPrgNhaxenv
         OIoA==
X-Gm-Message-State: AC+VfDzAplbMrwxXsGiJ81FaIyi9GUgZCHFDiwMYSqiGtYWGjF2SHCpT
        LFZqMbp+VWmOIv6J1HnlgIWufkx1SxuqMS0/PCVdJA==
X-Google-Smtp-Source: ACHHUZ6CVSTq1MsOIVDdtHyQ/ou4XMTNDn7fE/nZB2Po7FyZ7PnVK2wUOaJGQWU7FBk36Q+sh3s3og==
X-Received: by 2002:a17:90a:ac01:b0:237:40a5:7acf with SMTP id o1-20020a17090aac0100b0023740a57acfmr1951113pjq.33.1682604947418;
        Thu, 27 Apr 2023 07:15:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v16-20020a17090a459000b0024b822e6644sm8737672pjg.54.2023.04.27.07.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 07:15:46 -0700 (PDT)
Message-ID: <644a8392.170a0220.35edd.1a24@mx.google.com>
Date:   Thu, 27 Apr 2023 07:15:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.4
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.4.238-240-g00f088492fe8
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.4 baseline: 135 runs,
 12 regressions (v5.4.238-240-g00f088492fe8)
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

stable-rc/queue/5.4 baseline: 135 runs, 12 regressions (v5.4.238-240-g00f08=
8492fe8)

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

qemu_arm64-virt-gicv2        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.4/kern=
el/v5.4.238-240-g00f088492fe8/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.4
  Describe: v5.4.238-240-g00f088492fe8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      00f088492fe8cfbb67a983bcdd0312522e132795 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644a4b7dae0584cf122e85f1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.238-2=
40-g00f088492fe8/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubiet=
ruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.238-2=
40-g00f088492fe8/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubiet=
ruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a4b7dae0584cf122e85f6
        failing since 86 days (last pass: v5.4.230-81-g2ad0dc06d587, first =
fail: v5.4.230-108-g761a8268d868)

    2023-04-27T10:16:11.785080  <8>[    9.914261] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3536834_1.5.2.4.1>
    2023-04-27T10:16:11.891955  / # #
    2023-04-27T10:16:11.993354  export SHELL=3D/bin/sh
    2023-04-27T10:16:11.993682  #
    2023-04-27T10:16:12.094892  / # export SHELL=3D/bin/sh. /lava-3536834/e=
nvironment
    2023-04-27T10:16:12.095267  =

    2023-04-27T10:16:12.196282  / # . /lava-3536834/environment/lava-353683=
4/bin/lava-test-runner /lava-3536834/1
    2023-04-27T10:16:12.196815  =

    2023-04-27T10:16:12.201819  / # /lava-3536834/bin/lava-test-runner /lav=
a-3536834/1
    2023-04-27T10:16:12.288278  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hifive-unleashed-a00         | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644a630cdfe8d109c42e8624

  Results:     3 PASS, 2 FAIL, 2 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.238-2=
40-g00f088492fe8/riscv/defconfig/gcc-10/lab-baylibre/baseline-hifive-unleas=
hed-a00.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.238-2=
40-g00f088492fe8/riscv/defconfig/gcc-10/lab-baylibre/baseline-hifive-unleas=
hed-a00.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/riscv/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/644a630cdfe8d109=
c42e862d
        failing since 190 days (last pass: v5.4.219-270-gde284a6cd1e4, firs=
t fail: v5.4.219-266-g5eb28a6c7901)
        3 lines

    2023-04-27T11:56:42.444191  / # =

    2023-04-27T11:56:42.445223  =

    2023-04-27T11:56:44.509370  / # #
    2023-04-27T11:56:44.510091  #
    2023-04-27T11:56:46.523815  / # export SHELL=3D/bin/sh
    2023-04-27T11:56:46.524293  export SHELL=3D/bin/sh
    2023-04-27T11:56:48.541022  / # . /lava-3536874/environment
    2023-04-27T11:56:48.541577  . /lava-3536874/environment
    2023-04-27T11:56:50.556335  / # /lava-3536874/bin/lava-test-runner /lav=
a-3536874/0
    2023-04-27T11:56:50.557526  /lava-3536874/bin/lava-test-runner /lava-35=
36874/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a4a6e2ce5b7c1ef2e8618

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.238-2=
40-g00f088492fe8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.238-2=
40-g00f088492fe8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a4a6e2ce5b7c1ef2e861d
        failing since 29 days (last pass: v5.4.238-29-g39c31e43e3b2b, first=
 fail: v5.4.238-60-gcf51829325af)

    2023-04-27T10:11:41.805337  + set<8>[   10.735295] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10141130_1.4.2.3.1>

    2023-04-27T10:11:41.805438   +x

    2023-04-27T10:11:41.907748  =


    2023-04-27T10:11:42.008339  / # #export SHELL=3D/bin/sh

    2023-04-27T10:11:42.008570  =


    2023-04-27T10:11:42.109090  / # export SHELL=3D/bin/sh. /lava-10141130/=
environment

    2023-04-27T10:11:42.109261  =


    2023-04-27T10:11:42.209837  / # . /lava-10141130/environment/lava-10141=
130/bin/lava-test-runner /lava-10141130/1

    2023-04-27T10:11:42.210191  =


    2023-04-27T10:11:42.214699  / # /lava-10141130/bin/lava-test-runner /la=
va-10141130/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a4a1ab4d431261d2e861c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.238-2=
40-g00f088492fe8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.238-2=
40-g00f088492fe8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a4a1ab4d431261d2e8621
        failing since 29 days (last pass: v5.4.238-29-g39c31e43e3b2b, first=
 fail: v5.4.238-60-gcf51829325af)

    2023-04-27T10:10:18.795040  + set +x

    2023-04-27T10:10:18.802059  <8>[   13.071739] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10141085_1.4.2.3.1>

    2023-04-27T10:10:18.909721  / # #

    2023-04-27T10:10:19.012668  export SHELL=3D/bin/sh

    2023-04-27T10:10:19.013314  #

    2023-04-27T10:10:19.114707  / # export SHELL=3D/bin/sh. /lava-10141085/=
environment

    2023-04-27T10:10:19.115402  =


    2023-04-27T10:10:19.216773  / # . /lava-10141085/environment/lava-10141=
085/bin/lava-test-runner /lava-10141085/1

    2023-04-27T10:10:19.217955  =


    2023-04-27T10:10:19.223415  / # /lava-10141085/bin/lava-test-runner /la=
va-10141085/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644a4f46afcae27cd62e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.238-2=
40-g00f088492fe8/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.238-2=
40-g00f088492fe8/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644a4f46afcae27cd62e8=
5e7
        failing since 275 days (last pass: v5.4.180-77-g7de29e82b9db, first=
 fail: v5.4.207-73-ga2480f1b1dda1) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644a4c9a103fb1e5532e868a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.238-2=
40-g00f088492fe8/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.238-2=
40-g00f088492fe8/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644a4c9a103fb1e5532e8=
68b
        failing since 275 days (last pass: v5.4.180-77-g7de29e82b9db, first=
 fail: v5.4.207-73-ga2480f1b1dda1) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644a4c9864d43e75142e8623

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.238-2=
40-g00f088492fe8/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.238-2=
40-g00f088492fe8/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644a4c9864d43e75142e8=
624
        failing since 275 days (last pass: v5.4.180-77-g7de29e82b9db, first=
 fail: v5.4.207-73-ga2480f1b1dda1) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644a4da2bd978381982e860b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.238-2=
40-g00f088492fe8/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.238-2=
40-g00f088492fe8/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644a4da2bd978381982e8=
60c
        failing since 275 days (last pass: v5.4.180-77-g7de29e82b9db, first=
 fail: v5.4.207-73-ga2480f1b1dda1) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644a4c99ff53e5728e2e863e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.238-2=
40-g00f088492fe8/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.238-2=
40-g00f088492fe8/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644a4c99ff53e5728e2e8=
63f
        failing since 275 days (last pass: v5.4.180-77-g7de29e82b9db, first=
 fail: v5.4.207-73-ga2480f1b1dda1) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644a4db69b5b0b02d32e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.238-2=
40-g00f088492fe8/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.238-2=
40-g00f088492fe8/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644a4db69b5b0b02d32e8=
5e7
        failing since 275 days (last pass: v5.4.180-77-g7de29e82b9db, first=
 fail: v5.4.207-73-ga2480f1b1dda1) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644a4c9264d43e75142e85ff

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.238-2=
40-g00f088492fe8/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.238-2=
40-g00f088492fe8/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644a4c9264d43e75142e8=
600
        failing since 275 days (last pass: v5.4.180-77-g7de29e82b9db, first=
 fail: v5.4.207-73-ga2480f1b1dda1) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644a714b6bf7da46322e8619

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.238-2=
40-g00f088492fe8/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-=
h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.238-2=
40-g00f088492fe8/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-=
h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a714b6bf7da46322e861c
        failing since 85 days (last pass: v5.4.230-108-g761a8268d868, first=
 fail: v5.4.230-109-g0a6085bff265)

    2023-04-27T12:57:00.185749  / # #
    2023-04-27T12:57:00.287462  export SHELL=3D/bin/sh
    2023-04-27T12:57:00.287816  #
    2023-04-27T12:57:00.389152  / # export SHELL=3D/bin/sh. /lava-3536831/e=
nvironment
    2023-04-27T12:57:00.389508  =

    2023-04-27T12:57:00.490848  / # . /lava-3536831/environment/lava-353683=
1/bin/lava-test-runner /lava-3536831/1
    2023-04-27T12:57:00.491457  =

    2023-04-27T12:57:00.497037  / # /lava-3536831/bin/lava-test-runner /lav=
a-3536831/1
    2023-04-27T12:57:00.584896  + export 'TESTRUN_ID=3D1_bootrr'
    2023-04-27T12:57:00.585156  + cd /lava-3536831/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
