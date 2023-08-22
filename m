Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8247837FE
	for <lists+stable@lfdr.de>; Tue, 22 Aug 2023 04:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjHVCe5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 22:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjHVCe5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 22:34:57 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1744EDB
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:34:55 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bf48546ccfso18977315ad.2
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692671694; x=1693276494;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jgy04GaT3c1f6YDhsYWZENyRkG4OkQZsIHcTmOgUU1k=;
        b=AiPhnLEB3IMXixMIsZQj9EREqlmM+DZYqOADA1db2pz7OLXgkPYcdik8iWKl1OUjUH
         O+pgEc3ccxio9gpaIbJBtGs+skqgkhW4bsSca9GaMTNs8sHfT8CVtMbF+BcUamEYHDgK
         K5jOVg6pX3/BSn38Ya7PHmx1TzIaL9e0tDxPdd6DoTV8GJBgDdUZR+VNU9nbgn+sUzsU
         v2XwlPUXMnsA9Ap3w8r4RbJSUPsc8vYhgbYOBMoNg7/JwwG6pCnusmfaHr+M5+crKTo8
         I7i9AsClGKWj6apGgnB770i3t1De0QQMUUMhSH1D1VeF5803HzCUdqhw3xAdpD3W3lam
         /fnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692671694; x=1693276494;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jgy04GaT3c1f6YDhsYWZENyRkG4OkQZsIHcTmOgUU1k=;
        b=F37Ujz+Q+5LgiBU/rJN/D8bD6pXzdYSBlo/DBLwZJetdDh03liZAyX+vGywOmmZLAc
         ecY92v9uYBLFt5gxNW7a3Ob7pCtXeQo0VG+hRat2ikgVh4nXYYALELTqMjgMY+hROuab
         /1cnE3kpR3J4m0xyqWtBm2/ZvVvNl316x4lLu8Rh8zGLte4wyi90dOgA+bS5z9SMXv57
         P/ASnx1JL5hlIalkF2I0qPK4N0VVGyHE1aGgaf5WrOl98aQHTGEZj1/SRTYqutE17dvl
         eAuitaP1Q3EdqfyrAucXJfJC0ixEnxX2ttfGQx9mAXpIv2f4yKVuwXnWOlv9cKOzIO4C
         9aRg==
X-Gm-Message-State: AOJu0Yx+OWOmLV5sTHoeHXqkDMm92AhnBuQ8fv1XScq9FjrPSkFtRkBB
        9IaYkRY9f/xMISq+D2zETLpQe0Avyp7KWsDt95wt9w==
X-Google-Smtp-Source: AGHT+IEMhSjEsMmOAjaOtgDS9KVPYo750Xwui5/D7yhobgj2gHBErgrXv/W+zT+4k143tjRXPEHQ6w==
X-Received: by 2002:a17:902:b709:b0:1bd:a0cd:1860 with SMTP id d9-20020a170902b70900b001bda0cd1860mr4981356pls.64.1692671693943;
        Mon, 21 Aug 2023 19:34:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j24-20020a170902759800b001b8b6a19bd6sm7730881pll.63.2023.08.21.19.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 19:34:53 -0700 (PDT)
Message-ID: <64e41ecd.170a0220.97b6e.eb6f@mx.google.com>
Date:   Mon, 21 Aug 2023 19:34:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.292-86-g29f196d64ede
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-4.19.y baseline: 55 runs,
 6 regressions (v4.19.292-86-g29f196d64ede)
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

stable-rc/linux-4.19.y baseline: 55 runs, 6 regressions (v4.19.292-86-g29f1=
96d64ede)

Regressions Summary
-------------------

platform                   | arch  | lab         | compiler | defconfig    =
              | regressions
---------------------------+-------+-------------+----------+--------------=
--------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie | gcc-10   | defconfig+arm=
64-chromebook | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie | gcc-10   | defconfig    =
              | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie | gcc-10   | defconfig+arm=
64-chromebook | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie | gcc-10   | defconfig    =
              | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie | gcc-10   | defconfig+arm=
64-chromebook | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.19.y/ker=
nel/v4.19.292-86-g29f196d64ede/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.292-86-g29f196d64ede
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      29f196d64edee575367dbe1930b34e98f1a985d3 =



Test Regressions
---------------- =



platform                   | arch  | lab         | compiler | defconfig    =
              | regressions
---------------------------+-------+-------------+----------+--------------=
--------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e406a22b21349c7fdc95ce

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
92-86-g29f196d64ede/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/bas=
eline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
92-86-g29f196d64ede/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/bas=
eline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64e406a22b21349c7fdc9=
5cf
        failing since 469 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-79-ge28b1117a7ab) =

 =



platform                   | arch  | lab         | compiler | defconfig    =
              | regressions
---------------------------+-------+-------------+----------+--------------=
--------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/64e404fe45f0ae1043dc962d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
92-86-g29f196d64ede/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-=
virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
92-86-g29f196d64ede/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-=
virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64e404fe45f0ae1043dc9=
62e
        failing since 468 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-89-g71a9ee8b0cfd) =

 =



platform                   | arch  | lab         | compiler | defconfig    =
              | regressions
---------------------------+-------+-------------+----------+--------------=
--------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e405ee32c4ca9600dc95f1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
92-86-g29f196d64ede/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/bas=
eline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
92-86-g29f196d64ede/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/bas=
eline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64e405ee32c4ca9600dc9=
5f2
        failing since 469 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-79-ge28b1117a7ab) =

 =



platform                   | arch  | lab         | compiler | defconfig    =
              | regressions
---------------------------+-------+-------------+----------+--------------=
--------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4048615d6dcd087dc95d1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
92-86-g29f196d64ede/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-=
virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
92-86-g29f196d64ede/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-=
virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64e4048615d6dcd087dc9=
5d2
        failing since 468 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-89-g71a9ee8b0cfd) =

 =



platform                   | arch  | lab         | compiler | defconfig    =
              | regressions
---------------------------+-------+-------------+----------+--------------=
--------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4075665741f35e6dc95cd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
92-86-g29f196d64ede/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/bas=
eline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
92-86-g29f196d64ede/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/bas=
eline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64e4075665741f35e6dc9=
5ce
        failing since 469 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-79-ge28b1117a7ab) =

 =



platform                   | arch  | lab         | compiler | defconfig    =
              | regressions
---------------------------+-------+-------------+----------+--------------=
--------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e406b67d56c06430dc95cf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
92-86-g29f196d64ede/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/bas=
eline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
92-86-g29f196d64ede/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/bas=
eline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64e406b67d56c06430dc9=
5d0
        failing since 469 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-79-ge28b1117a7ab) =

 =20
