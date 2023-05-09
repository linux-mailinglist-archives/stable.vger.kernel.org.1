Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB1F6FC1BB
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 10:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjEII1L (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 04:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbjEII0z (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 04:26:55 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F8DE75
        for <stable@vger.kernel.org>; Tue,  9 May 2023 01:26:51 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6436e004954so5745884b3a.0
        for <stable@vger.kernel.org>; Tue, 09 May 2023 01:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683620811; x=1686212811;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DcXkeptaaSmlfqZoh9J0LpqZ/t4BlkHRNCRMvTSqELQ=;
        b=wFoy3DnWp1b2uEwUTUJn0vuH+IMFPDaJXI6IOAjSa/hn3AbK7iPIgyX10j4T8y1buS
         +KlbxmL0BE/RhZETrdlkkKGlHqOKwxhfIGF/q4wnz8Nzuspl5gVgH8Or5doou20Z9aEG
         MM+qMxY/hs9MAMc7DuszyIElc12gJYVH+o7uB8l6Ur+wm/BtiJs/vpKZBEDQP0ANsXKR
         1UgiD6mfnER4lCPR2hf/rG7fTNi3TmvPtQ7MUiUCmaL7PGWfZwN4wOE33nL2X9wPhO0O
         aDfkm1lN2AuFHechr/zpowIBtizw56UaD1lrEPRTij8lmBUU7I8HZMohnEYPu1u5u2BR
         ajJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683620811; x=1686212811;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DcXkeptaaSmlfqZoh9J0LpqZ/t4BlkHRNCRMvTSqELQ=;
        b=SNOrKUlm4u5mPUtmBYNGivZ9jO5khoqnzzUPbhmBToKn7PAe5t7xVK34BQpr8JarVJ
         dLj80lt8115knfYD9/P+v0glSYUrSb51MpSK5XDO6lnEFOzTE1XHIaG/zNzrqpaPZbK9
         sYWsfrDR+mX5SI7HLUIYymiOcNivF23h1NEmyjsc5OnF7xJ02wcIZ9EQ4Enw5d4iGo2b
         bDycZDaGnnfPJxUfLWrN7NRyQRREFShfY8NvPFohentNWFmfb1BFAB2SUWQCU4BO4i28
         1N6VNOOkpG2cUCYUQKCOP+1BMg5QWRVLeAo+2eBENG8a9wBvc4CKf54MWvDi8HgNaHJ/
         EYkw==
X-Gm-Message-State: AC+VfDzyfznlRw0I/BxaYTcYfI5qRX4N1kl43M7F2lgRjbgCuyJa11GE
        TlfVa3CEM8u7I2oGPtuQpVnN8RuwIDt5/Q33QsoDOQ==
X-Google-Smtp-Source: ACHHUZ5QSYVtAq2cpHKN3fZoexR24IgOUgymj6h0UOqyT3+pyUHkpEshfFHdNKh7erKS9/TV/fX1iQ==
X-Received: by 2002:a05:6a20:3d85:b0:ef:ef0a:f92a with SMTP id s5-20020a056a203d8500b000efef0af92amr17099404pzi.25.1683620810816;
        Tue, 09 May 2023 01:26:50 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p8-20020a62ab08000000b0064394c2a1d0sm1175950pff.209.2023.05.09.01.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 01:26:50 -0700 (PDT)
Message-ID: <645a03ca.620a0220.69600.30c8@mx.google.com>
Date:   Tue, 09 May 2023 01:26:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.14.311-217-g678d31ea568f
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-4.14.y baseline: 109 runs,
 16 regressions (v4.14.311-217-g678d31ea568f)
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

stable-rc/linux-4.14.y baseline: 109 runs, 16 regressions (v4.14.311-217-g6=
78d31ea568f)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

meson-gxl-s905x-khadas-vim   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

meson8b-odroidc1             | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

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


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.14.y/ker=
nel/v4.14.311-217-g678d31ea568f/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.14.y
  Describe: v4.14.311-217-g678d31ea568f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      678d31ea568f17ba12aadb824ae9e876d4ca0c4f =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459c8ee13ac2068f42e861a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
11-217-g678d31ea568f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
11-217-g678d31ea568f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6459c8ee13ac2068f42e8=
61b
        new failure (last pass: v4.14.311-217-ga00bdd4e18600) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459c8ef3d40c8885e2e8618

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
11-217-g678d31ea568f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
11-217-g678d31ea568f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6459c8ef3d40c8885e2e8=
619
        new failure (last pass: v4.14.311-217-ga00bdd4e18600) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-khadas-vim   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6459c8f771b1f2cfbe2e8620

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
11-217-g678d31ea568f/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl=
-s905x-khadas-vim.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
11-217-g678d31ea568f/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl=
-s905x-khadas-vim.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6459c8f771b1f2cfbe2e8=
621
        failing since 308 days (last pass: v4.14.285, first fail: v4.14.286=
) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson8b-odroidc1             | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6459cc1a863f2fbace2e862e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
11-217-g678d31ea568f/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-me=
son8b-odroidc1.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
11-217-g678d31ea568f/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-me=
son8b-odroidc1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6459cc1a863f2fbace2e8=
62f
        failing since 448 days (last pass: v4.14.266, first fail: v4.14.266=
-45-gce409501ca5f) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6459c9227b679dc5692e85ef

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
11-217-g678d31ea568f/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm6=
4-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
11-217-g678d31ea568f/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm6=
4-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6459c9227b679dc5692e8=
5f0
        failing since 258 days (last pass: v4.14.266-45-gce409501ca5f, firs=
t fail: v4.14.290-230-g4d54ef55c38e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6459ca1334b196e4d82e85eb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
11-217-g678d31ea568f/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64=
-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
11-217-g678d31ea568f/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64=
-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6459ca1334b196e4d82e8=
5ec
        failing since 258 days (last pass: v4.14.266-45-gce409501ca5f, firs=
t fail: v4.14.290-230-g4d54ef55c38e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6459c911479562df552e8603

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
11-217-g678d31ea568f/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm=
64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
11-217-g678d31ea568f/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm=
64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6459c911479562df552e8=
604
        failing since 258 days (last pass: v4.14.266-45-gce409501ca5f, firs=
t fail: v4.14.290-230-g4d54ef55c38e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6459c9207b679dc5692e85e9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
11-217-g678d31ea568f/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm6=
4-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
11-217-g678d31ea568f/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm6=
4-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6459c9207b679dc5692e8=
5ea
        failing since 280 days (last pass: v4.14.267-33-g871c9e115feb, firs=
t fail: v4.14.289-48-gdea72dca89ea9) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6459c94b03d34e5d5c2e85ee

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
11-217-g678d31ea568f/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64=
-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
11-217-g678d31ea568f/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64=
-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6459c94b03d34e5d5c2e8=
5ef
        failing since 280 days (last pass: v4.14.267-33-g871c9e115feb, firs=
t fail: v4.14.289-48-gdea72dca89ea9) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6459c8f1df4a9e7e482e85f4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
11-217-g678d31ea568f/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm=
64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
11-217-g678d31ea568f/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm=
64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6459c8f1df4a9e7e482e8=
5f5
        failing since 280 days (last pass: v4.14.267-33-g871c9e115feb, firs=
t fail: v4.14.289-48-gdea72dca89ea9) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6459c9217b679dc5692e85ec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
11-217-g678d31ea568f/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm6=
4-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
11-217-g678d31ea568f/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm6=
4-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6459c9217b679dc5692e8=
5ed
        failing since 258 days (last pass: v4.14.266-45-gce409501ca5f, firs=
t fail: v4.14.290-230-g4d54ef55c38e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6459ca12cf4e1fe5422e8623

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
11-217-g678d31ea568f/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64=
-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
11-217-g678d31ea568f/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64=
-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6459ca12cf4e1fe5422e8=
624
        failing since 258 days (last pass: v4.14.266-45-gce409501ca5f, firs=
t fail: v4.14.290-230-g4d54ef55c38e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6459c8f313ac2068f42e8631

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
11-217-g678d31ea568f/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm=
64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
11-217-g678d31ea568f/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm=
64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6459c8f313ac2068f42e8=
632
        failing since 258 days (last pass: v4.14.266-45-gce409501ca5f, firs=
t fail: v4.14.290-230-g4d54ef55c38e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6459c91e7b679dc5692e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
11-217-g678d31ea568f/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm6=
4-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
11-217-g678d31ea568f/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm6=
4-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6459c91e7b679dc5692e8=
5e7
        failing since 264 days (last pass: v4.14.267-33-g871c9e115feb, firs=
t fail: v4.14.290) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6459c94a9b87a505a22e861b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
11-217-g678d31ea568f/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64=
-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
11-217-g678d31ea568f/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64=
-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6459c94a9b87a505a22e8=
61c
        failing since 264 days (last pass: v4.14.267-33-g871c9e115feb, firs=
t fail: v4.14.290) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6459c8f013ac2068f42e8629

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
11-217-g678d31ea568f/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm=
64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
11-217-g678d31ea568f/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm=
64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6459c8f013ac2068f42e8=
62a
        failing since 264 days (last pass: v4.14.267-33-g871c9e115feb, firs=
t fail: v4.14.290) =

 =20
