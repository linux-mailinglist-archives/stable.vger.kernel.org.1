Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1406F1A76
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 16:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjD1O2h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 10:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjD1O2g (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 10:28:36 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FA51BEE
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 07:28:34 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1a667067275so252025ad.1
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 07:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682692113; x=1685284113;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Krcnoq+g4RGovHlcUXTw/q/vo9ZqnDK1hf+H8vveqDM=;
        b=uoEqPatIjlyckFp7xqOTm2bqFSHswDgYpYS74ThnyPSMdo5Qi/HwjK+KpTgnqwcD1G
         EQArC+0YQDaDZyv93AIS26SYBX8vfCO9vajazpQ6cO+EwtCeJCZMsVxy213V4O2rfZvi
         hxFQSQ1Ms0YqvXFijSe5vCdd1Pho1m3SbXos/d4V39LldfMWfCC6ri3QZOYDdCC7sIMN
         oKU5Yj/MkUx7Xcaqeut5PQVUwLc9Iri/bsykx+DsVpM5aqTh9JtMcW7gaNEZC7FKfiZa
         GKATEDo2zLTJCOAMFPTNNKfwZXcECY30GXkV37uohcpU20RfMGXbmKdP8s8ybQ1Bu3rD
         w5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682692113; x=1685284113;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Krcnoq+g4RGovHlcUXTw/q/vo9ZqnDK1hf+H8vveqDM=;
        b=jzE6CeRXyttgcelbmF+HbZryh3nfkd9OFbZfsFi9zEZZnDnzPR155UHxDhi4gOBH2T
         X3kmD2QD9DvaR/bhJgJdXpId+Z47wsgOf8XE36kkbECjyYyvd/peQZCZDIr5WL01mEpi
         TE8EYZvzNXvpRNPIvBWnfAnTnkoxNUb8nL57S2XPnwqD0aTY6SrFbt+Lc/t00lw4Omuu
         lLDJKVWp2fkWJOabge78yrQveT6e/mkORU9jeyTBwikQwWlpbItqWJIN+szIY5PzMDtC
         5uk3NZHIEIbell+dJCDLDG2og3AGIcWE/k5fgK4bI7iKhNW4f3fVWHjdNACv3MK0WgK6
         iApg==
X-Gm-Message-State: AC+VfDxbQP1ZAqIFrSBmqPFqAi4a9PBk+yfMXll/a5pmoX3bvoiufDGw
        6ene88gS0efcXavETCk46MY40aYHrwFr8KE8ROc=
X-Google-Smtp-Source: ACHHUZ55mr/UfHOB9zhMqTnCzjfTO9RvB4nnKLlYPX6aevqLqsL1op7DM7Acwxo3+gUKKqtmfx+fQg==
X-Received: by 2002:a17:902:c60c:b0:1a6:639e:887e with SMTP id r12-20020a170902c60c00b001a6639e887emr4225098plr.13.1682692112654;
        Fri, 28 Apr 2023 07:28:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090adc0400b00246aba3ebabsm14890690pjv.45.2023.04.28.07.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 07:28:32 -0700 (PDT)
Message-ID: <644bd810.170a0220.9a5f4.f662@mx.google.com>
Date:   Fri, 28 Apr 2023 07:28:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/4.19
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.19.279-176-g5b85c41f2aa9
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/4.19 baseline: 132 runs,
 17 regressions (v4.19.279-176-g5b85c41f2aa9)
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

stable-rc/queue/4.19 baseline: 132 runs, 17 regressions (v4.19.279-176-g5b8=
5c41f2aa9)

Regressions Summary
-------------------

platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
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
nel/v4.19.279-176-g5b85c41f2aa9/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/4.19
  Describe: v4.19.279-176-g5b85c41f2aa9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      5b85c41f2aa91fd0de06ab1fefba6875f270894f =



Test Regressions
---------------- =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
cubietruck                 | arm   | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/644ba54c74fa9224112e85e7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g5b85c41f2aa9/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g5b85c41f2aa9/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644ba54c74fa9224112e85ec
        failing since 101 days (last pass: v4.19.269-9-gce7b59ec9d48, first=
 fail: v4.19.269-521-g305d312d039a)

    2023-04-28T10:51:38.183481  + set +x<8>[    7.432866] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3540475_1.5.2.4.1>
    2023-04-28T10:51:38.184406  =

    2023-04-28T10:51:38.295184  / # #
    2023-04-28T10:51:38.398971  export SHELL=3D/bin/sh
    2023-04-28T10:51:38.399965  #
    2023-04-28T10:51:38.502039  / # export SHELL=3D/bin/sh. /lava-3540475/e=
nvironment
    2023-04-28T10:51:38.502924  =

    2023-04-28T10:51:38.605011  / # . /lava-3540475/environment/lava-354047=
5/bin/lava-test-runner /lava-3540475/1
    2023-04-28T10:51:38.607127  =

    2023-04-28T10:51:38.612546  / # /lava-3540475/bin/lava-test-runner /lav=
a-3540475/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/644b9d21bf3c15e5b72e85ef

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g5b85c41f2aa9/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g5b85c41f2aa9/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644b9d21bf3c15e5b72e8=
5f0
        failing since 276 days (last pass: v4.19.230-58-gbd840138c177, firs=
t fail: v4.19.253-43-g91137b502cfbd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/644b9cefdbf45404f52e866b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g5b85c41f2aa9/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g5b85c41f2aa9/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644b9cefdbf45404f52e8=
66c
        failing since 276 days (last pass: v4.19.230-58-gbd840138c177, firs=
t fail: v4.19.253-43-g91137b502cfbd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/644b9c876303eb91362e865a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g5b85c41f2aa9/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g5b85c41f2aa9/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644b9c876303eb91362e8=
65b
        failing since 276 days (last pass: v4.19.230-58-gbd840138c177, firs=
t fail: v4.19.253-43-g91137b502cfbd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/644b9d1eede05e3e212e85ec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g5b85c41f2aa9/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g5b85c41f2aa9/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644b9d1eede05e3e212e8=
5ed
        failing since 276 days (last pass: v4.19.230-58-gbd840138c177, firs=
t fail: v4.19.253-43-g91137b502cfbd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/644b9cc6971bdafd6a2e8609

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g5b85c41f2aa9/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g5b85c41f2aa9/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644b9cc6971bdafd6a2e8=
60a
        failing since 276 days (last pass: v4.19.230-58-gbd840138c177, firs=
t fail: v4.19.253-43-g91137b502cfbd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/644b9c7d8013530e342e85ee

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g5b85c41f2aa9/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g5b85c41f2aa9/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644b9c7d8013530e342e8=
5ef
        failing since 276 days (last pass: v4.19.230-58-gbd840138c177, firs=
t fail: v4.19.253-43-g91137b502cfbd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/644b9d23bf3c15e5b72e85f2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g5b85c41f2aa9/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g5b85c41f2aa9/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644b9d23bf3c15e5b72e8=
5f3
        failing since 276 days (last pass: v4.19.230-58-gbd840138c177, firs=
t fail: v4.19.253-43-g91137b502cfbd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/644b9e2ca26bf73d372e8636

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g5b85c41f2aa9/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g5b85c41f2aa9/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644b9e2ca26bf73d372e8=
637
        failing since 276 days (last pass: v4.19.230-58-gbd840138c177, firs=
t fail: v4.19.253-43-g91137b502cfbd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/644b9c7f8013530e342e85f4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g5b85c41f2aa9/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g5b85c41f2aa9/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644b9c7f8013530e342e8=
5f5
        failing since 276 days (last pass: v4.19.230-58-gbd840138c177, firs=
t fail: v4.19.253-43-g91137b502cfbd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/644b9d20bf3c15e5b72e85e9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g5b85c41f2aa9/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g5b85c41f2aa9/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644b9d20bf3c15e5b72e8=
5ea
        failing since 276 days (last pass: v4.19.230-58-gbd840138c177, firs=
t fail: v4.19.253-43-g91137b502cfbd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/644b9ceedbf45404f52e8665

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g5b85c41f2aa9/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g5b85c41f2aa9/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644b9ceedbf45404f52e8=
666
        failing since 276 days (last pass: v4.19.230-58-gbd840138c177, firs=
t fail: v4.19.253-43-g91137b502cfbd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/644b9c7e6303eb91362e864c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g5b85c41f2aa9/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g5b85c41f2aa9/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644b9c7e6303eb91362e8=
64d
        failing since 276 days (last pass: v4.19.230-58-gbd840138c177, firs=
t fail: v4.19.253-43-g91137b502cfbd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
r8a7795-salvator-x         | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/644b9b937f77380fd02e861d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g5b85c41f2aa9/arm64/defconfig/gcc-10/lab-baylibre/baseline-r8a7795-sal=
vator-x.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g5b85c41f2aa9/arm64/defconfig/gcc-10/lab-baylibre/baseline-r8a7795-sal=
vator-x.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644b9b937f77380fd02e8622
        failing since 86 days (last pass: v4.19.266-113-g31aa3f26a1bd, firs=
t fail: v4.19.271-66-g3a26c3e5ffb1)

    2023-04-28T10:10:06.507353  + set +x
    2023-04-28T10:10:06.509497  <8>[    8.052984] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3540337_1.5.2.4.1>
    2023-04-28T10:10:06.616846  / # #
    2023-04-28T10:10:06.718367  export SHELL=3D/bin/sh
    2023-04-28T10:10:06.718821  #
    2023-04-28T10:10:06.820156  / # export SHELL=3D/bin/sh. /lava-3540337/e=
nvironment
    2023-04-28T10:10:06.820624  =

    2023-04-28T10:10:06.922028  / # . /lava-3540337/environment/lava-354033=
7/bin/lava-test-runner /lava-3540337/1
    2023-04-28T10:10:06.922739  =

    2023-04-28T10:10:06.926493  / # /lava-3540337/bin/lava-test-runner /lav=
a-3540337/1 =

    ... (13 line(s) more)  =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
rk3328-rock64              | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/644b9ba757ea17786b2e85e7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g5b85c41f2aa9/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g5b85c41f2aa9/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644b9ba757ea17786b2e8=
5e8
        new failure (last pass: v4.19.271-68-gf209487d4364) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
sun50i-h6-pine-h64         | arm64 | lab-baylibre  | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/644b9ba27f77380fd02e863b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g5b85c41f2aa9/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g5b85c41f2aa9/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644b9ba27f77380fd02e8640
        failing since 101 days (last pass: v4.19.266-171-g3ff1cc101ea8, fir=
st fail: v4.19.269-521-g305d312d039a)

    2023-04-28T10:10:20.891953  / # #
    2023-04-28T10:10:20.993840  export SHELL=3D/bin/sh
    2023-04-28T10:10:20.994196  #
    2023-04-28T10:10:21.095549  / # export SHELL=3D/bin/sh. /lava-3540318/e=
nvironment
    2023-04-28T10:10:21.095907  =

    2023-04-28T10:10:21.197321  / # . /lava-3540318/environment/lava-354031=
8/bin/lava-test-runner /lava-3540318/1
    2023-04-28T10:10:21.198188  =

    2023-04-28T10:10:21.203202  / # /lava-3540318/bin/lava-test-runner /lav=
a-3540318/1
    2023-04-28T10:10:21.273129  + export 'TESTRUN_ID=3D1_bootrr'
    2023-04-28T10:10:21.273695  + cd /lava-3540318<8>[   15.629521] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 3540318_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
sun50i-h6-pine-h64         | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/644b9b7a0f20b4f2852e85e6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g5b85c41f2aa9/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.279=
-176-g5b85c41f2aa9/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644b9b7a0f20b4f2852e85eb
        failing since 101 days (last pass: v4.19.266-171-g3ff1cc101ea8, fir=
st fail: v4.19.269-521-g305d312d039a)

    2023-04-28T10:09:56.983259  / # #

    2023-04-28T10:09:57.085333  export SHELL=3D/bin/sh

    2023-04-28T10:09:57.086057  #

    2023-04-28T10:09:57.187230  / # export SHELL=3D/bin/sh. /lava-10149900/=
environment

    2023-04-28T10:09:57.187999  =


    2023-04-28T10:09:57.289242  / # . /lava-10149900/environment/lava-10149=
900/bin/lava-test-runner /lava-10149900/1

    2023-04-28T10:09:57.290248  =


    2023-04-28T10:09:57.291304  / # /lava-10149900/bin/lava-test-runner /la=
va-10149900/1

    2023-04-28T10:09:57.365246  + export 'TESTRUN_ID=3D1_bootrr'

    2023-04-28T10:09:57.365806  + cd /lava-1014990<8>[   15.624210] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 10149900_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
