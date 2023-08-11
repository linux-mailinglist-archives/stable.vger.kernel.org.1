Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F3F7792F2
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 17:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbjHKPXp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 11:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbjHKPXp (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 11:23:45 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCADFB
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 08:23:44 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686b9920362so1586831b3a.1
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 08:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691767423; x=1692372223;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3sl0biOvNElThShue5hVVH+LBfqNJzQaq2FQhVh9xVE=;
        b=RNSTsnhooeBcCnveei69HxV4r54Tz9Fn921V+UMZEwnGHRIafi/DaCNVPE0yo/JGbW
         CjuOdYWjRCnUyhtTSeDnxbOZ/8DNRupYSdKp024Xmma2FCH8CcEp6HSI+1RZrp/u9FSb
         /Um7WVlwyWyRMqfkODk9OR0CrtFjsWgXCNjbwe3I5v1pGFKc9qxjmiAOppQKiaei54b4
         CP2V+XdhNjmRDdPgS3sBMllkSzOC2da41VmkT9n8iIEW4mmmbybp5DXU0Ag7N1xfnvbI
         glveZNFWfNhuH+TT7kb0/VHE2V527uQvTXkCoVDPm6cF7yDnppEoPS9tCf7DXqBujtFb
         t7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691767423; x=1692372223;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3sl0biOvNElThShue5hVVH+LBfqNJzQaq2FQhVh9xVE=;
        b=GvsY9y0CMzlkPPsg3Y3Ih0VhJkobn5RkinB4qN5Jt0aW97TYWmKC+QWMt93HAgQ2cC
         +fInjOKIRfQPFEqnLRRoyuAlU75V+2aS0zEcL2yojP7GR2Tp4nH5HsMl+BcoVSRA4smq
         1zgkSXcJzZPJs2h2446ua0HBCwnfPOOirZ/f6sY7DYNILP/LXJlDPayUXSsozgdbkU95
         UbYdXFi1Eo7+AdCnVo2gGWGEft2uZVz3q0TXE6FF4BLbIlnrE35jOmqRGVl2kiU4LxcB
         TCfzW5HFKyAo7IsfIaqvo8RT+eQk5HQjS/b+8j/7UsChp+PgOldBagoZIc4WEf0L9ChQ
         2Khg==
X-Gm-Message-State: AOJu0YxLcb6GtROwxZTkXCzLZpTEvpKBYuqwgANYc+laTmAqBCBvRVkl
        lGAdLbJXZuhYfCO9B+PVrc1TWWS/G80RragBXNPRBg==
X-Google-Smtp-Source: AGHT+IGG7aOD9ymwu15HdXbVhUbu28f6FJFG5FahSIkbA3/Epwi7N/q7D2S4+T01B+lFrybyZnDxig==
X-Received: by 2002:a05:6a20:8f22:b0:140:5248:e028 with SMTP id b34-20020a056a208f2200b001405248e028mr2286225pzk.45.1691767423134;
        Fri, 11 Aug 2023 08:23:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x16-20020a62fb10000000b00686bef8e55csm3451051pfm.39.2023.08.11.08.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:23:42 -0700 (PDT)
Message-ID: <64d6527e.620a0220.a10b1.6733@mx.google.com>
Date:   Fri, 11 Aug 2023 08:23:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.14.322
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.14.y
Subject: stable-rc/linux-4.14.y baseline: 83 runs, 9 regressions (v4.14.322)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-4.14.y baseline: 83 runs, 9 regressions (v4.14.322)

Regressions Summary
-------------------

platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
jetson-tk1                 | arm   | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.14.y/ker=
nel/v4.14.322/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.14.y
  Describe: v4.14.322
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      4dbbc9b492fb6a28528de6a1958263780693e96c =



Test Regressions
---------------- =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
jetson-tk1                 | arm   | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64d621d79642cefa2435b1fc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
22/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
22/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d621d79642cefa2435b=
1fd
        new failure (last pass: v4.14.321-205-gf41a58010b71e) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/64d6236563a05a509935b1f4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
22/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
22/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d6236563a05a509935b=
1f5
        failing since 353 days (last pass: v4.14.266-45-gce409501ca5f, firs=
t fail: v4.14.290-230-g4d54ef55c38e) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/64d622767ae28b565e35b1da

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
22/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
22/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d622767ae28b565e35b=
1db
        failing since 353 days (last pass: v4.14.266-45-gce409501ca5f, firs=
t fail: v4.14.290-230-g4d54ef55c38e) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62332d71a35769835b220

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
22/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.t=
xt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
22/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d62332d71a35769835b=
221
        failing since 374 days (last pass: v4.14.267-33-g871c9e115feb, firs=
t fail: v4.14.289-48-gdea72dca89ea9) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/64d622750e43e9f08c35b1eb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
22/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
22/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d622750e43e9f08c35b=
1ec
        failing since 374 days (last pass: v4.14.267-33-g871c9e115feb, firs=
t fail: v4.14.289-48-gdea72dca89ea9) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/64d6244a5a05efe09635b1d9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
22/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
22/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d6244a5a05efe09635b=
1da
        failing since 353 days (last pass: v4.14.266-45-gce409501ca5f, firs=
t fail: v4.14.290-230-g4d54ef55c38e) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/64d622cf272db9c41135b1fa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
22/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
22/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d622cf272db9c41135b=
1fb
        failing since 353 days (last pass: v4.14.266-45-gce409501ca5f, firs=
t fail: v4.14.290-230-g4d54ef55c38e) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62437845e8ec5d235b1f7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
22/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.t=
xt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
22/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d62437845e8ec5d235b=
1f8
        failing since 358 days (last pass: v4.14.267-33-g871c9e115feb, firs=
t fail: v4.14.290) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/64d6227f7ae28b565e35b1fe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
22/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
22/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d6227f7ae28b565e35b=
1ff
        failing since 358 days (last pass: v4.14.267-33-g871c9e115feb, firs=
t fail: v4.14.290) =

 =20
