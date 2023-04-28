Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391326F1CED
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 18:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345910AbjD1QxR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 12:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjD1QxQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 12:53:16 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B87255AD
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 09:53:12 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-246f856d751so142443a91.0
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 09:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682700791; x=1685292791;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qw62ckHvkQxLjwvHnAowm7EoMzpV4+8z3wjX8KLc5vg=;
        b=mx6Nz9I79ElWelxDs4gB2B5i/EP0uqVgTc4T0fM8sXnD7KvoeHG5kkf02apzJXppUl
         ZHFwQ+tb5NfnDWIIh4T+viWt/uYPYlFCPoXzGsqP1Ms/vBxguFOAwsvB5nytMpvnPURe
         wmH9SB3PtQNJtN7WqQRE71F9BoNNyI0tqC4joqMmaplqJ+u7Ua3H61N5yafGLbvNjPBE
         U7Zic7IG/l+iDTu8w//0IKdVmUVGy11m14FbKhZlYwMFDBaHNqer0t63CHkus/e97xYV
         TyrUuUPnZBy3sFfUxhL1agLGf5CZ5KQBZJP0EwK2PagKcYXYBM72B8+1tdR+dVVW65HR
         WVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682700791; x=1685292791;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qw62ckHvkQxLjwvHnAowm7EoMzpV4+8z3wjX8KLc5vg=;
        b=G/+RVgIG6EUkgPPURsy86QtLWxqQOLZvIlVkkxvy1L33y0dnjlioDAdhMExv6M6plp
         YCkAUdaZS6E5xWkHoIMm+BePD3y9VUuBgcxegGr/JzYNHE9flJqlniVuMfMdpih3SPQR
         DaWRhJb/5sCtKfWsleU9w7XnIZuhsVOvXRaW9i7DXo+Wd3W3I4o51I1T+5mmR/BP9HDM
         AP+d7RMVXb5sftTtqz6e/JuY9JRVLYFNG950oaDShBwgT3gtM4dIpyNluqUCUpjSDfRH
         qg9El3WtQdFEEtukNaF0q7/iry8e6v8FKQNCR1HYkNR2g0dm4kstE7sh/m4YvRIkY6mV
         XNyQ==
X-Gm-Message-State: AC+VfDxvSOUsLIDB3lolvLp8N5zhaeAN6GMfwuRVkquVYviPRKv+Njx5
        qNkVGNZ8aXvI9nY/9ldDDE88dD6cmZpSdqh/pds=
X-Google-Smtp-Source: ACHHUZ6pUT7SSKOa0DP7ls796e3/v513TACPexJuK8/1OSFnNwbWNCcFy63IboUMxPB56PyKvFUnpA==
X-Received: by 2002:a17:90a:6d02:b0:247:eae:1783 with SMTP id z2-20020a17090a6d0200b002470eae1783mr5829428pjj.45.1682700791350;
        Fri, 28 Apr 2023 09:53:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id lk6-20020a17090b33c600b0024702e5dda0sm15138629pjb.39.2023.04.28.09.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 09:53:10 -0700 (PDT)
Message-ID: <644bf9f6.170a0220.df6bc.06c2@mx.google.com>
Date:   Fri, 28 Apr 2023 09:53:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/4.19
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.19.279-176-g0d01abafeebc
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/4.19 baseline: 134 runs,
 18 regressions (v4.19.279-176-g0d01abafeebc)
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

stable-rc/queue/4.19 baseline: 134 runs, 18 regressions (v4.19.279-176-g0d0=
1abafeebc)

Regressions Summary
-------------------

platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
at91sam9g20ek              | arm   | lab-broonie   | gcc-10   | multi_v5_de=
fconfig | 1          =

cubietruck                 | arm   | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =

r8a7795-salvator-x         | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =

rk3328-rock64              | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =

sun50i-h6-pine-h64         | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =

sun50i-h6-pine-h64         | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F4.19/ker=
nel/v4.19.279-176-g0d01abafeebc/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/4.19
  Describe: v4.19.279-176-g0d01abafeebc
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      0d01abafeebcb1a0be039276d0dc5458ade1e473 =



Test Regressions
---------------- =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
at91sam9g20ek              | arm   | lab-broonie   | gcc-10   | multi_v5_de=
fconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/644bbc92e30f61824e2e85e6

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91s=
am9g20ek.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91s=
am9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bbc92e30f61824e2e8618
        new failure (last pass: v4.19.279-176-g5b85c41f2aa9)

    2023-04-28T12:30:33.970421  + set +x
    2023-04-28T12:30:33.975565  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 397989_1.5.2=
.4.1>
    2023-04-28T12:30:34.089355  / # #
    2023-04-28T12:30:34.192495  export SHELL=3D/bin/sh
    2023-04-28T12:30:34.193397  #
    2023-04-28T12:30:34.295393  / # export SHELL=3D/bin/sh. /lava-397989/en=
vironment
    2023-04-28T12:30:34.296207  =

    2023-04-28T12:30:34.398270  / # . /lava-397989/environment/lava-397989/=
bin/lava-test-runner /lava-397989/1
    2023-04-28T12:30:34.399951  =

    2023-04-28T12:30:34.406071  / # /lava-397989/bin/lava-test-runner /lava=
-397989/1 =

    ... (11 line(s) more)  =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
cubietruck                 | arm   | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/644bc143ce6f3ba6132e85fe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bc143ce6f3ba6132e8603
        failing since 101 days (last pass: v4.19.269-9-gce7b59ec9d48, first=
 fail: v4.19.269-521-g305d312d039a)

    2023-04-28T12:50:59.474039  <8>[    7.275729] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3540910_1.5.2.4.1>
    2023-04-28T12:50:59.585787  / # #
    2023-04-28T12:50:59.689796  export SHELL=3D/bin/sh
    2023-04-28T12:50:59.690916  #
    2023-04-28T12:50:59.793193  / # export SHELL=3D/bin/sh. /lava-3540910/e=
nvironment
    2023-04-28T12:50:59.794465  =

    2023-04-28T12:50:59.896984  / # . /lava-3540910/environment/lava-354091=
0/bin/lava-test-runner /lava-3540910/1
    2023-04-28T12:50:59.899277  =

    2023-04-28T12:50:59.904388  / # /lava-3540910/bin/lava-test-runner /lav=
a-3540910/1
    2023-04-28T12:50:59.989872  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/644bbfa9d4137ed0b92e85f9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644bbfa9d4137ed0b92e8=
5fa
        failing since 276 days (last pass: v4.19.230-58-gbd840138c177, firs=
t fail: v4.19.253-43-g91137b502cfbd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/644bbf7cf6481344442e85fd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644bbf7cf6481344442e8=
5fe
        failing since 276 days (last pass: v4.19.230-58-gbd840138c177, firs=
t fail: v4.19.253-43-g91137b502cfbd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/644bbf7a7f149efad72e85ee

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644bbf7a7f149efad72e8=
5ef
        failing since 276 days (last pass: v4.19.230-58-gbd840138c177, firs=
t fail: v4.19.253-43-g91137b502cfbd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/644bbfa67f149efad72e861f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644bbfa67f149efad72e8=
620
        failing since 276 days (last pass: v4.19.230-58-gbd840138c177, firs=
t fail: v4.19.253-43-g91137b502cfbd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/644bbf7b44ba6b077f2e85fa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644bbf7b44ba6b077f2e8=
5fb
        failing since 276 days (last pass: v4.19.230-58-gbd840138c177, firs=
t fail: v4.19.253-43-g91137b502cfbd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/644bbf79f6481344442e85f7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644bbf79f6481344442e8=
5f8
        failing since 276 days (last pass: v4.19.230-58-gbd840138c177, firs=
t fail: v4.19.253-43-g91137b502cfbd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/644bbfacc537c776ad2e85e9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644bbfacc537c776ad2e8=
5ea
        failing since 276 days (last pass: v4.19.230-58-gbd840138c177, firs=
t fail: v4.19.253-43-g91137b502cfbd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/644bbf7d44ba6b077f2e8602

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644bbf7d44ba6b077f2e8=
603
        failing since 276 days (last pass: v4.19.230-58-gbd840138c177, firs=
t fail: v4.19.253-43-g91137b502cfbd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/644bbf5bc30d16238b2e8619

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644bbf5bc30d16238b2e8=
61a
        failing since 276 days (last pass: v4.19.230-58-gbd840138c177, firs=
t fail: v4.19.253-43-g91137b502cfbd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/644bbf7d44ba6b077f2e85ff

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644bbf7d44ba6b077f2e8=
600
        failing since 276 days (last pass: v4.19.230-58-gbd840138c177, firs=
t fail: v4.19.253-43-g91137b502cfbd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/644bbf7a336653a0c92e85ec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644bbf7a336653a0c92e8=
5ed
        failing since 276 days (last pass: v4.19.230-58-gbd840138c177, firs=
t fail: v4.19.253-43-g91137b502cfbd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/644bbf6544ba6b077f2e85e7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644bbf6544ba6b077f2e8=
5e8
        failing since 276 days (last pass: v4.19.230-58-gbd840138c177, firs=
t fail: v4.19.253-43-g91137b502cfbd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
r8a7795-salvator-x         | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/644bbe5ca76fb3a4672e865d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm64/defconfig/gcc-10/lab-baylibre/baseline-r8a7795-sal=
vator-x.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm64/defconfig/gcc-10/lab-baylibre/baseline-r8a7795-sal=
vator-x.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bbe5ca76fb3a4672e8662
        failing since 86 days (last pass: v4.19.266-113-g31aa3f26a1bd, firs=
t fail: v4.19.271-66-g3a26c3e5ffb1)

    2023-04-28T12:38:41.248121  + set +x
    2023-04-28T12:38:41.251239  <8>[    8.635110] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3540855_1.5.2.4.1>
    2023-04-28T12:38:41.357751  / # #
    2023-04-28T12:38:41.459431  export SHELL=3D/bin/sh
    2023-04-28T12:38:41.459873  #
    2023-04-28T12:38:41.561222  / # export SHELL=3D/bin/sh. /lava-3540855/e=
nvironment
    2023-04-28T12:38:41.561689  =

    2023-04-28T12:38:41.662952  / # . /lava-3540855/environment/lava-354085=
5/bin/lava-test-runner /lava-3540855/1
    2023-04-28T12:38:41.663769  =

    2023-04-28T12:38:41.667375  / # /lava-3540855/bin/lava-test-runner /lav=
a-3540855/1 =

    ... (13 line(s) more)  =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
rk3328-rock64              | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/644bbf10a1d4ee28902e8651

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644bbf10a1d4ee28902e8=
652
        failing since 0 day (last pass: v4.19.271-68-gf209487d4364, first f=
ail: v4.19.279-176-g5b85c41f2aa9) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
sun50i-h6-pine-h64         | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/644bbe7826c13e4a0b2e85fb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bbe7826c13e4a0b2e8600
        failing since 101 days (last pass: v4.19.266-171-g3ff1cc101ea8, fir=
st fail: v4.19.269-521-g305d312d039a)

    2023-04-28T12:39:08.526286  <8>[   15.157765] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3540872_1.5.2.4.1>
    2023-04-28T12:39:08.631644  / # #
    2023-04-28T12:39:08.733477  export SHELL=3D/bin/sh
    2023-04-28T12:39:08.733866  #
    2023-04-28T12:39:08.835271  / # export SHELL=3D/bin/sh. /lava-3540872/e=
nvironment
    2023-04-28T12:39:08.835695  =

    2023-04-28T12:39:08.937043  / # . /lava-3540872/environment/lava-354087=
2/bin/lava-test-runner /lava-3540872/1
    2023-04-28T12:39:08.937671  =

    2023-04-28T12:39:08.943758  / # /lava-3540872/bin/lava-test-runner /lav=
a-3540872/1
    2023-04-28T12:39:09.012699  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (13 line(s) more)  =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
sun50i-h6-pine-h64         | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/644bbe6c2d3ac3a87e2e85f5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g0d01abafeebc/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bbe6c2d3ac3a87e2e85fa
        failing since 101 days (last pass: v4.19.266-171-g3ff1cc101ea8, fir=
st fail: v4.19.269-521-g305d312d039a)

    2023-04-28T12:38:44.438187  / # #

    2023-04-28T12:38:44.540282  export SHELL=3D/bin/sh

    2023-04-28T12:38:44.540990  #

    2023-04-28T12:38:44.642407  / # export SHELL=3D/bin/sh. /lava-10151251/=
environment

    2023-04-28T12:38:44.643122  =


    2023-04-28T12:38:44.744547  / # . /lava-10151251/environment/lava-10151=
251/bin/lava-test-runner /lava-10151251/1

    2023-04-28T12:38:44.745663  =


    2023-04-28T12:38:44.762212  / # /lava-10151251/bin/lava-test-runner /la=
va-10151251/1

    2023-04-28T12:38:44.806131  + export 'TESTRUN_ID=3D1_bootrr'

    2023-04-28T12:38:44.820159  + cd /lava-1015125<8>[   15.609241] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 10151251_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
