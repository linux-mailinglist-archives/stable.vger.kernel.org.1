Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5673C6F18F9
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 15:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346198AbjD1NKl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 09:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjD1NKe (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 09:10:34 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A0319AC
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 06:10:02 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63b52ad6311so11260846b3a.2
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 06:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682687400; x=1685279400;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EYSXgKVpEc+RYkBk5WzYY/RLUABiuMopDxNdyhBy2PA=;
        b=YhjLYKknsOV43vJO4Z9xtW64lxBRyZQjpZMNTNus6N5AM5Bhh0vLJep98/g3z/F9dA
         9ZFh0fLusRT1C6BOC6WYUANk0dBzEDTeKCyKM0HGFCMzSCI1UoZkTmDflrKHzN/XDEU1
         lSmiCL0A3WeMqJvwsr74aHnj7sclnaBKqmDIL7hOE0vjILfW2dBhOl5cpaLn+J3gmVL3
         +fs5B4Oqsxjxe07pJzakEPhiRWZk9+8j+zx6LAj0SklqzZ10B8/LDvABlAsTMaHY9hpg
         CLF4AIuvK+HOf1z0dxrvt62SIijbIfoPpWMCaEnHigA4nUQFuEYIbihfbQHKHk22RMZx
         utmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682687400; x=1685279400;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EYSXgKVpEc+RYkBk5WzYY/RLUABiuMopDxNdyhBy2PA=;
        b=hHLDUcEzvRHobPYDx28h1QZKR5Zao7KFY9y4dvl+BTuRJU2rh886wTyZj2GSPF6cEN
         O7hRe1+ZiFUF8U69XaMTUQpA8ti25s0drown11Y2mv3whofy9F8EDDSEYBmKlPsRn5Ob
         NjBW6c5H+WdnXoaYTfcPDKIkEMTTQa1vMg39QDMJscbVOAwpBnNQFdexZJ28E5LLm5Hm
         bVeEDafnxwBrraTQhQPuSgqGEccgPAfGi6BH2PLeKY7jC2Ta1c52cOEZc1l+hK5Vpclx
         /BiM7YdvQdvscQYxnr/7Wt9uJlLdFIIQLSnw+9D0VfgrmQfKzhPzHJIL3DBODWiTaZJu
         UwPw==
X-Gm-Message-State: AC+VfDyw52q2r3njdSyeLcGXwW6K2QwEVMpS9BkDUNc7SFmvk14vSsTw
        zAIU60AERf36r5nBEiJQcDdTVug0myqrJVaFwTg=
X-Google-Smtp-Source: ACHHUZ5PnAieagKQVNvzVkJw+DtEImWUdUoYOEjwdJbCYswVK+zbhoxoclFSzFlqeHcule0+XUGEFw==
X-Received: by 2002:a17:902:e5c5:b0:1a9:8ba4:d0e3 with SMTP id u5-20020a170902e5c500b001a98ba4d0e3mr6436517plf.59.1682687399840;
        Fri, 28 Apr 2023 06:09:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902dac500b00199203a4fa3sm1791685plx.203.2023.04.28.06.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 06:09:59 -0700 (PDT)
Message-ID: <644bc5a7.170a0220.6fe2b.4163@mx.google.com>
Date:   Fri, 28 Apr 2023 06:09:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.4.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.4.238-245-g14f076931beb
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.4.y baseline: 153 runs,
 22 regressions (v5.4.238-245-g14f076931beb)
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

stable-rc/linux-5.4.y baseline: 153 runs, 22 regressions (v5.4.238-245-g14f=
076931beb)

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

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.4.y/kern=
el/v5.4.238-245-g14f076931beb/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.4.y
  Describe: v5.4.238-245-g14f076931beb
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      14f076931beb7a4703ce56833095b4ca946b5e51 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644b904bd94157ac9e2e85f6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644b904bd94157ac9e2e85fb
        failing since 101 days (last pass: v5.4.226, first fail: v5.4.228-6=
59-gb3b34c474ec7)

    2023-04-28T09:22:00.016956  <8>[   23.630645] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3540131_1.5.2.4.1>
    2023-04-28T09:22:00.128283  / # #
    2023-04-28T09:22:00.231834  export SHELL=3D/bin/sh
    2023-04-28T09:22:00.233121  #
    2023-04-28T09:22:00.335862  / # export SHELL=3D/bin/sh. /lava-3540131/e=
nvironment
    2023-04-28T09:22:00.337161  =

    2023-04-28T09:22:00.439648  / # . /lava-3540131/environment/lava-354013=
1/bin/lava-test-runner /lava-3540131/1
    2023-04-28T09:22:00.441629  =

    2023-04-28T09:22:00.446494  / # /lava-3540131/bin/lava-test-runner /lav=
a-3540131/1
    2023-04-28T09:22:00.542699  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644b905e471d83e9f52e8610

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644b905e471d83e9f52e8613
        failing since 101 days (last pass: v5.4.226-68-g8c05f5e0777d, first=
 fail: v5.4.228-659-gb3b34c474ec7)

    2023-04-28T09:22:20.829764  + set +x<8>[    9.942134] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3540136_1.5.2.4.1>
    2023-04-28T09:22:20.829959  =

    2023-04-28T09:22:20.933047  / # #
    2023-04-28T09:22:21.034486  export SHELL=3D/bin/sh
    2023-04-28T09:22:21.034831  #
    2023-04-28T09:22:21.136024  / # export SHELL=3D/bin/sh. /lava-3540136/e=
nvironment
    2023-04-28T09:22:21.136393  =

    2023-04-28T09:22:21.237586  / # . /lava-3540136/environment/lava-354013=
6/bin/lava-test-runner /lava-3540136/1
    2023-04-28T09:22:21.238135  =

    2023-04-28T09:22:21.243215  / # /lava-3540136/bin/lava-test-runner /lav=
a-3540136/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
da850-lcdk                   | arm    | lab-baylibre  | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644b8d2b394e152b5a2e85ec

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm/multi_v5_defconfig/gcc-10/lab-baylibre/baseline-da85=
0-lcdk.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm/multi_v5_defconfig/gcc-10/lab-baylibre/baseline-da85=
0-lcdk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644b8d2b394e152b5a2e85f1
        failing since 101 days (last pass: v5.4.227, first fail: v5.4.228-6=
59-gb3b34c474ec7)

    2023-04-28T09:08:46.886821  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 3540065_1.5.=
2.4.1>
    2023-04-28T09:08:46.993255  / # #
    2023-04-28T09:08:47.096720  export SHELL=3D/bin/sh
    2023-04-28T09:08:47.097874  #
    2023-04-28T09:08:47.200385  / # export SHELL=3D/bin/sh. /lava-3540065/e=
nvironment
    2023-04-28T09:08:47.201573  =

    2023-04-28T09:08:47.304043  / # . /lava-3540065/environment/lava-354006=
5/bin/lava-test-runner /lava-3540065/1
    2023-04-28T09:08:47.305746  =

    2023-04-28T09:08:47.346505  / # /lava-3540065/bin/lava-test-runner /lav=
a-3540065/1
    2023-04-28T09:08:47.564688  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hifive-unleashed-a00         | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644b8e0da340cbf1fc2e85eb

  Results:     3 PASS, 2 FAIL, 2 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/riscv/defconfig/gcc-10/lab-baylibre/baseline-hifive-unle=
ashed-a00.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/riscv/defconfig/gcc-10/lab-baylibre/baseline-hifive-unle=
ashed-a00.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/riscv/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/644b8e0da340cbf1=
fc2e85f4
        failing since 191 days (last pass: v5.4.219, first fail: v5.4.219-2=
67-g4a976f825745)
        3 lines

    2023-04-28T09:12:08.037946  / # =

    2023-04-28T09:12:08.038884  =

    2023-04-28T09:12:10.105989  / # #
    2023-04-28T09:12:10.106562  #
    2023-04-28T09:12:12.118654  / # export SHELL=3D/bin/sh
    2023-04-28T09:12:12.119470  export SHELL=3D/bin/sh
    2023-04-28T09:12:14.134555  / # . /lava-3540083/environment
    2023-04-28T09:12:14.136112  . /lava-3540083/environment
    2023-04-28T09:12:16.150099  / # /lava-3540083/bin/lava-test-runner /lav=
a-3540083/0
    2023-04-28T09:12:16.151250  /lava-3540083/bin/lava-test-runner /lava-35=
40083/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644b8bc994780cfd362e85e9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644b8bc994780cfd362e85ee
        failing since 28 days (last pass: v5.4.238, first fail: v5.4.238)

    2023-04-28T09:02:52.454217  + set<8>[    9.977287] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10149219_1.4.2.3.1>

    2023-04-28T09:02:52.454339   +x

    2023-04-28T09:02:52.556338  #

    2023-04-28T09:02:52.556595  =


    2023-04-28T09:02:52.657129  / # #export SHELL=3D/bin/sh

    2023-04-28T09:02:52.657301  =


    2023-04-28T09:02:52.757791  / # export SHELL=3D/bin/sh. /lava-10149219/=
environment

    2023-04-28T09:02:52.758008  =


    2023-04-28T09:02:52.858609  / # . /lava-10149219/environment/lava-10149=
219/bin/lava-test-runner /lava-10149219/1

    2023-04-28T09:02:52.858873  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644b8bc0fc3e1eb3892e8675

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644b8bc0fc3e1eb3892e867a
        failing since 28 days (last pass: v5.4.238, first fail: v5.4.238)

    2023-04-28T09:02:41.798951  + set<8>[   12.295146] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10149196_1.4.2.3.1>

    2023-04-28T09:02:41.799042   +x

    2023-04-28T09:02:41.901101  /#

    2023-04-28T09:02:42.001850   # #export SHELL=3D/bin/sh

    2023-04-28T09:02:42.002039  =


    2023-04-28T09:02:42.102539  / # export SHELL=3D/bin/sh. /lava-10149196/=
environment

    2023-04-28T09:02:42.102732  =


    2023-04-28T09:02:42.203217  / # . /lava-10149196/environment/lava-10149=
196/bin/lava-test-runner /lava-10149196/1

    2023-04-28T09:02:42.203507  =


    2023-04-28T09:02:42.208598  / # /lava-10149196/bin/lava-test-runner /la=
va-10149196/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644b8d15f22c382dd72e8606

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644b8d15f22c382dd72e8=
607
        failing since 247 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-390-g1cece69eaa88) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644b8cabbbc578a58a2e8609

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644b8cabbbc578a58a2e8=
60a
        failing since 247 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-390-g1cece69eaa88) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644b8ca8ccfa40278b2e85e9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644b8ca8ccfa40278b2e8=
5ea
        failing since 247 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-390-g1cece69eaa88) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644b8d17b26687598b2e863d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644b8d17b26687598b2e8=
63e
        failing since 269 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.207-123-gb48a8f43dce6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644b8cad83463af9192e85e9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644b8cad83463af9192e8=
5ea
        failing since 269 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.207-123-gb48a8f43dce6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644b8caaccfa40278b2e85ef

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644b8caaccfa40278b2e8=
5f0
        failing since 269 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.207-123-gb48a8f43dce6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644b8d16f22c382dd72e8609

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644b8d16f22c382dd72e8=
60a
        failing since 267 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.209) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644b8cac83463af9192e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644b8cac83463af9192e8=
5e7
        failing since 267 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.209) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644b8ca0b074990e022e85eb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644b8ca0b074990e022e8=
5ec
        failing since 267 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.209) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644b8d14f22c382dd72e8600

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644b8d14f22c382dd72e8=
601
        failing since 247 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-390-g1cece69eaa88) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644b8ca9ccfa40278b2e85ec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644b8ca9ccfa40278b2e8=
5ed
        failing since 247 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-390-g1cece69eaa88) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644b8c9e8693ed47f92e8610

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644b8c9e8693ed47f92e8=
611
        failing since 247 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-390-g1cece69eaa88) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7795-salvator-x           | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644b8bf1470dc8c14f2e861c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm64/defconfig/gcc-10/lab-baylibre/baseline-r8a7795-sal=
vator-x.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm64/defconfig/gcc-10/lab-baylibre/baseline-r8a7795-sal=
vator-x.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644b8bf1470dc8c14f2e8621
        new failure (last pass: v5.4.217)

    2023-04-28T09:03:29.092190  + set +x
    2023-04-28T09:03:29.095390  <8>[   72.145423] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3540039_1.5.2.4.1>
    2023-04-28T09:03:29.200745  / # #
    2023-04-28T09:03:29.302157  export SHELL=3D/bin/sh
    2023-04-28T09:03:29.302549  #
    2023-04-28T09:03:29.403675  / # export SHELL=3D/bin/sh. /lava-3540039/e=
nvironment
    2023-04-28T09:03:29.404020  =

    2023-04-28T09:03:29.505177  / # . /lava-3540039/environment/lava-354003=
9/bin/lava-test-runner /lava-3540039/1
    2023-04-28T09:03:29.505692  =

    2023-04-28T09:03:29.509483  / # /lava-3540039/bin/lava-test-runner /lav=
a-3540039/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644b8bc8f808ec4f182e85e7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644b8bc8f808ec4f182e8=
5e8
        new failure (last pass: v5.4.224-157-g3e1fbfce73e5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644b9011fd12a17dd12e85e7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644b9011fd12a17dd12e85ec
        failing since 101 days (last pass: v5.4.227, first fail: v5.4.228-6=
59-gb3b34c474ec7)

    2023-04-28T09:21:07.552827  / # #
    2023-04-28T09:21:07.654773  export SHELL=3D/bin/sh
    2023-04-28T09:21:07.655345  #
    2023-04-28T09:21:07.756751  / # export SHELL=3D/bin/sh. /lava-3540130/e=
nvironment
    2023-04-28T09:21:07.757323  =

    2023-04-28T09:21:07.858769  / # . /lava-3540130/environment/lava-354013=
0/bin/lava-test-runner /lava-3540130/1
    2023-04-28T09:21:07.859625  =

    2023-04-28T09:21:07.879155  / # /lava-3540130/bin/lava-test-runner /lav=
a-3540130/1
    2023-04-28T09:21:07.966943  + export 'TESTRUN_ID=3D1_bootrr'
    2023-04-28T09:21:07.967331  + cd /lava-3540130/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/644b8953a18e9654c32e85f4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h=
3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g14f076931beb/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h=
3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644b8953a18e9654c32e85f9
        failing since 101 days (last pass: v5.4.227, first fail: v5.4.228-6=
59-gb3b34c474ec7)

    2023-04-28T08:52:10.509252  <8>[    5.899484] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3539998_1.5.2.4.1>
    2023-04-28T08:52:10.615309  / # #
    2023-04-28T08:52:10.717252  export SHELL=3D/bin/sh
    2023-04-28T08:52:10.717695  #
    2023-04-28T08:52:10.819175  / # export SHELL=3D/bin/sh. /lava-3539998/e=
nvironment
    2023-04-28T08:52:10.819657  =

    2023-04-28T08:52:10.921161  / # . /lava-3539998/environment/lava-353999=
8/bin/lava-test-runner /lava-3539998/1
    2023-04-28T08:52:10.921912  =

    2023-04-28T08:52:10.926518  / # /lava-3539998/bin/lava-test-runner /lav=
a-3539998/1
    2023-04-28T08:52:10.974661  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
