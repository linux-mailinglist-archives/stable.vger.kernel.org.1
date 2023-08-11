Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A51779404
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 18:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjHKQMP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 12:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjHKQMO (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 12:12:14 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CF62702
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 09:12:12 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686b9920362so1628187b3a.1
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 09:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691770332; x=1692375132;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Moc4BtxLED8+hTatnBU/PP8PK6l99fyQT/UmQnEWuQg=;
        b=ri7Do7dp+8z7MwfwcU2XE/Y3JmJZeRvAoJmpgKqREgRUXdEOdmeX/S9LYGiML52Oow
         dpLtoY0dXbIUUq0EFd6Bm4RN5eIq9hQEZD681YqdTBsfxnxAIpRIQ+wYU6+MoXI08R7c
         ME5XgdiBV9Awb8c2rSHjVUNy8TMjZ7/M/jA6C44HGUXi+eK7/2e2xSiFt6PQhRrqu+uy
         uxdeGw1z0Wbm+bA8JlSaWO0VQ4BMxbzdW8ZMWVKJCv8qcZjoPqqe8r4JxYT7UdD9O2UB
         Z2EQ+Te0o/kUvfEhG++n+HZ5xLKFA9+0QCxVaBTLKCpp2PTu43M5llHdkSuPC2TfYN7Z
         BEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691770332; x=1692375132;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Moc4BtxLED8+hTatnBU/PP8PK6l99fyQT/UmQnEWuQg=;
        b=M8dQC7RGzvYqLQEUq153mxWseG89aiD/xZ2eW7NRwsaL7xA84ol68nCpzeTCVXFGHP
         r6gyXxzsWDnjCQGY21pzq4I0Upkiyn8qMo1UZMrX2mMPlQEfqJjJxD0s4kql0qT7rBPr
         OWB6VfQxFZkbsOq2C8+Up9lJ543xdkREwW3G8K2x8Fw8rI2SX4JScXTZ+u68QWcS9ncU
         /e27/lY5HG4lCvNmhtlesDW1fNcRS7G7LzSQ2d1tO1MS2JOioR8++XLt6Ps40fyZD6ct
         gX54prDlzBQnVJez7tpPQ9XB7aRehHInPXaUSE8EoK552wnhwPHBWVnWQlMYsyb18Ltw
         D43A==
X-Gm-Message-State: AOJu0YzFY+CeUdrUIJXz1fKO97L+k3GNwS45JzgqbKV9nNFH1kCzoEJm
        6EMVWVLbTW/srVZ/Rt8+XuXS13QYoedUcrtrMG6daw==
X-Google-Smtp-Source: AGHT+IHgf1Sjh+Uor5DUjCH31r1nnRxNbtY3vT0gRwdXwHiMV/n2WZehKVqRmVc7nvu3yu10pssstQ==
X-Received: by 2002:a05:6a21:35c9:b0:10c:7c72:bdf9 with SMTP id ba9-20020a056a2135c900b0010c7c72bdf9mr2221446pzc.29.1691770331871;
        Fri, 11 Aug 2023 09:12:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u9-20020a62ed09000000b00686ed095681sm3487755pfh.191.2023.08.11.09.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 09:12:11 -0700 (PDT)
Message-ID: <64d65ddb.620a0220.aba61.6d44@mx.google.com>
Date:   Fri, 11 Aug 2023 09:12:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.291
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.19.y
Subject: stable-rc/linux-4.19.y baseline: 98 runs, 20 regressions (v4.19.291)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-4.19.y baseline: 98 runs, 20 regressions (v4.19.291)

Regressions Summary
-------------------

platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
beagle-xm                  | arm   | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig        | 1          =

cubietruck                 | arm   | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig         | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

rk3399-gru-kevin           | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 2          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.19.y/ker=
nel/v4.19.291/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.291
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      fbbeed723bc5560108f32c8cf5df5a9a0b19519e =



Test Regressions
---------------- =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
beagle-xm                  | arm   | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62deb037563b10935b1de

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d62deb037563b10935b=
1df
        new failure (last pass: v4.19.290-324-gde1cde99fbfbb) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
cubietruck                 | arm   | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62cb212618176a235b1f0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d62cb212618176a235b1f5
        failing since 206 days (last pass: v4.19.268-50-gbf741d1d7e6d, firs=
t fail: v4.19.269-522-gc75d2b5524ab)

    2023-08-11T12:41:46.301379  <8>[    7.404404] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3737052_1.5.2.4.1>
    2023-08-11T12:41:46.411565  / # #
    2023-08-11T12:41:46.513418  export SHELL=3D/bin/sh
    2023-08-11T12:41:46.514492  #
    2023-08-11T12:41:46.616625  / # export SHELL=3D/bin/sh. /lava-3737052/e=
nvironment
    2023-08-11T12:41:46.617663  =

    2023-08-11T12:41:46.719826  / # . /lava-3737052/environment/lava-373705=
2/bin/lava-test-runner /lava-3737052/1
    2023-08-11T12:41:46.721376  =

    2023-08-11T12:41:46.726540  / # /lava-3737052/bin/lava-test-runner /lav=
a-3737052/1
    2023-08-11T12:41:46.811412  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62e3a049263c79f35b1dc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d62e3a049263c79f35b=
1dd
        failing since 361 days (last pass: v4.19.230-41-g73351b9c55d9, firs=
t fail: v4.19.255-191-gab9c8d4442969) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62fa0d02293e0a135b1da

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-=
virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-=
virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d62fa0d02293e0a135b=
1db
        failing since 360 days (last pass: v4.19.230-41-g73351b9c55d9, firs=
t fail: v4.19.255-215-g4373264025937) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62d40bad564f81135b1f5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d62d40bad564f81135b=
1f6
        failing since 361 days (last pass: v4.19.230-41-g73351b9c55d9, firs=
t fail: v4.19.255-191-gab9c8d4442969) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62df2037563b10935b207

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm6=
4-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm6=
4-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d62df2037563b10935b=
208
        failing since 360 days (last pass: v4.19.230-41-g73351b9c55d9, firs=
t fail: v4.19.255-215-g4373264025937) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62e38345a3a5db035b1d9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.t=
xt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d62e38345a3a5db035b=
1da
        failing since 347 days (last pass: v4.19.230-41-g73351b9c55d9, firs=
t fail: v4.19.256-37-g34c3cf0160a8) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62fa2c057072ffa35b1dc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-=
virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-=
virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d62fa2c057072ffa35b=
1dd
        failing since 353 days (last pass: v4.19.230-41-g73351b9c55d9, firs=
t fail: v4.19.255-288-g9901269a16d1) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62d3fbad564f81135b1f2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d62d3fbad564f81135b=
1f3
        failing since 347 days (last pass: v4.19.230-41-g73351b9c55d9, firs=
t fail: v4.19.256-37-g34c3cf0160a8) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62df367c7a6ff4035b1d9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm6=
4-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm6=
4-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d62df367c7a6ff4035b=
1da
        failing since 353 days (last pass: v4.19.230-41-g73351b9c55d9, firs=
t fail: v4.19.255-288-g9901269a16d1) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62e88049263c79f35b1f6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d62e88049263c79f35b=
1f7
        failing since 372 days (last pass: v4.19.230-41-g73351b9c55d9, firs=
t fail: v4.19.254) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62fab8d8d9108f135b1d9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-=
virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-=
virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d62fab8d8d9108f135b=
1da
        failing since 361 days (last pass: v4.19.230-41-g73351b9c55d9, firs=
t fail: v4.19.255-191-gab9c8d4442969) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62d41bad564f81135b1f8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d62d41bad564f81135b=
1f9
        failing since 372 days (last pass: v4.19.230-41-g73351b9c55d9, firs=
t fail: v4.19.254) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62de946cb8d577835b23b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm6=
4-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm6=
4-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d62de946cb8d577835b=
23c
        failing since 361 days (last pass: v4.19.230-41-g73351b9c55d9, firs=
t fail: v4.19.255-191-gab9c8d4442969) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62e42e0bffae1ba35b205

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.t=
xt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d62e42e0bffae1ba35b=
206
        failing since 358 days (last pass: v4.19.230-41-g73351b9c55d9, firs=
t fail: v4.19.255) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62fdc8d8d9108f135b218

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-=
virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-=
virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d62fdc8d8d9108f135b=
219
        failing since 353 days (last pass: v4.19.230-41-g73351b9c55d9, firs=
t fail: v4.19.255-288-g9901269a16d1) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62d35e41d798f2435b224

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d62d35e41d798f2435b=
225
        failing since 358 days (last pass: v4.19.230-41-g73351b9c55d9, firs=
t fail: v4.19.255) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62e23e0bffae1ba35b1df

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm6=
4-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm6=
4-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d62e23e0bffae1ba35b=
1e0
        failing since 353 days (last pass: v4.19.230-41-g73351b9c55d9, firs=
t fail: v4.19.255-288-g9901269a16d1) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
rk3399-gru-kevin           | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64d62da346cb8d577835b1da

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gr=
u-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
91/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gr=
u-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64d62da346cb8d577835b1e0
        failing since 150 days (last pass: v4.19.276, first fail: v4.19.276=
-4-g4f95ee925a2b)

    2023-08-11T12:46:37.695324  /lava-11263223/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64d62da346cb8d577835b1e1
        failing since 150 days (last pass: v4.19.276, first fail: v4.19.276=
-4-g4f95ee925a2b)

    2023-08-11T12:46:36.669299  /lava-11263223/1/../bin/lava-test-case

    2023-08-11T12:46:36.678204  <8>[   36.265185] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20
