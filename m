Return-Path: <stable+bounces-3729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 769A580239F
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 13:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758B3280DDA
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 12:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4E3C2E9;
	Sun,  3 Dec 2023 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="oJmmAnLV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2C5DB
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 04:14:14 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d048c171d6so19648615ad.1
        for <stable@vger.kernel.org>; Sun, 03 Dec 2023 04:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701605653; x=1702210453; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CI/2RYbVevh9pkT5vpVQzdOL7/RKcCvgPbTtIQJtI3E=;
        b=oJmmAnLVtI5dCTB39pLs5ZyLJsybGkA7bF8Q1PeJQ/XeDqVQiev0KzZfgMFBmaxU+p
         zavbINLkaa79MT715q2BlmqpvqScJBr/FXnVvZIL1B1/zN2+GWXMetnxTwU/8QcTyVE+
         2E9T/sS5M3QH4lMWBY2pApuULAeIOVraqUSx7b9qEbmcCeHuxJCzNj08UqgkSP5hbAQJ
         BDYQGm/C9aAjFpSbmdWzZ8Bqnx8RIA6a1gdTYpOEHlkSUD+S5YTQDEIOAKwqZ6f8Vajz
         eS90Th5cMUvobcsDW0DY3ojRpBEJ0goeM97AYQ7hUn6mqj7eQTwoeeWfV2lE30J7QvAr
         cmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701605653; x=1702210453;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CI/2RYbVevh9pkT5vpVQzdOL7/RKcCvgPbTtIQJtI3E=;
        b=iMVAF/uDr5SudJzsSVAqD8HyyTxK6Su5St9r+4WViOQtVwOgKPJEsZ0BFTZamVUSzk
         kJStnd6KZqXOjlTQmSbFSPxa4hUDnHyL++Ufem6VTNneEdG5Ky5+S7Ua818z4hfnLFmG
         mDlaYnHT09dwPPQJq4ua0r/IaJgGIKWBdoTst0JRWfnvKR1/wKRFF/789bVyFvBPUlnA
         5x0Jm0dOiD1a+SGh4RoEbGlEdMfiuORm+ClB4ivC1pfNlRBNomdj+Sp6zKgoLbZ9++BJ
         zK80XwHqSw4AZd8Llt+OaD1qOUtoC/3y7urZDUSPP58RzqUpbGcQCYUtbezZEpGJrSr0
         Zzfg==
X-Gm-Message-State: AOJu0YyovIf/9OORfGF4S+q0Jq8WgUP3k0zUUGp5MoBEd+jyoh13F4Ua
	g2mbrG38pqamVSxb+iKVxVdQQoBXEam6eCttQVrevA==
X-Google-Smtp-Source: AGHT+IHJe5YQ6AG5VpqhAziWUtdwvhx3y33zQOQsTSPKig6GcyiAi6uY5fyS3ReXLr9bS3vF5QeYcw==
X-Received: by 2002:a17:902:8495:b0:1d0:6ffd:9e28 with SMTP id c21-20020a170902849500b001d06ffd9e28mr1818423plo.122.1701605653000;
        Sun, 03 Dec 2023 04:14:13 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902e74500b001cfc1a593f7sm6553610plf.217.2023.12.03.04.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 04:14:12 -0800 (PST)
Message-ID: <656c7114.170a0220.97612.1be1@mx.google.com>
Date: Sun, 03 Dec 2023 04:14:12 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.4
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.4.262-49-g2add925443816
Subject: stable-rc/queue/5.4 baseline: 131 runs,
 26 regressions (v5.4.262-49-g2add925443816)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.4 baseline: 131 runs, 26 regressions (v5.4.262-49-g2add92=
5443816)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-cp514-3wh-r0qs-guybrush | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                  | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-collabora | gcc-10   | defconfi=
g                  | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                  | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                  | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                  | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                  | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                  | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                  | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook | 1          =

sun8i-h2-plus...ch-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig         | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.4/kern=
el/v5.4.262-49-g2add925443816/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.4
  Describe: v5.4.262-49-g2add925443816
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      2add92544381601901d262dc93c8842bc95a2c8a =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-cp514-3wh-r0qs-guybrush | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/656c3e8f507a54625ce1352f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/bas=
eline-acer-cp514-3wh-r0qs-guybrush.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/bas=
eline-acer-cp514-3wh-r0qs-guybrush.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656c3e8f507a54625ce13=
530
        new failure (last pass: v5.4.262-49-g648b7b7184c37) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656c400cfdc9b0ffe6e13476

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-vi=
rt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-vi=
rt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656c400cfdc9b0ffe6e13=
477
        failing since 495 days (last pass: v5.4.180-77-g7de29e82b9db, first=
 fail: v5.4.207-73-ga2480f1b1dda1) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/656c409a64d82f7d3de13493

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/basel=
ine-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/basel=
ine-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656c409a64d82f7d3de13=
494
        failing since 572 days (last pass: v5.4.191-84-g56ce42d78d96, first=
 fail: v5.4.191-125-g5917d1547e6e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656c40468766375f6fe13482

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656c40468766375f6fe13=
483
        failing since 495 days (last pass: v5.4.180-77-g7de29e82b9db, first=
 fail: v5.4.207-73-ga2480f1b1dda1) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/656c41c3fe1e71da0ae1347b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseli=
ne-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseli=
ne-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656c41c3fe1e71da0ae13=
47c
        failing since 572 days (last pass: v5.4.191-84-g56ce42d78d96, first=
 fail: v5.4.191-125-g5917d1547e6e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-collabora | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656c3ff393da576f74e134da

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656c3ff393da576f74e13=
4db
        failing since 495 days (last pass: v5.4.180-77-g7de29e82b9db, first=
 fail: v5.4.207-73-ga2480f1b1dda1) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/656c40ef1cbee957e1e13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656c40ef1cbee957e1e13=
476
        failing since 572 days (last pass: v5.4.191-84-g56ce42d78d96, first=
 fail: v5.4.191-125-g5917d1547e6e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656c400d93da576f74e13550

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-vi=
rt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-vi=
rt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656c400d93da576f74e13=
551
        failing since 495 days (last pass: v5.4.180-77-g7de29e82b9db, first=
 fail: v5.4.207-73-ga2480f1b1dda1) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/656c409c760513d287e13476

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/basel=
ine-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/basel=
ine-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656c409c760513d287e13=
477
        failing since 572 days (last pass: v5.4.191-84-g56ce42d78d96, first=
 fail: v5.4.191-125-g5917d1547e6e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656c405b82e004626de134cc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656c405b82e004626de13=
4cd
        failing since 495 days (last pass: v5.4.180-77-g7de29e82b9db, first=
 fail: v5.4.207-73-ga2480f1b1dda1) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/656c41c4fe1e71da0ae1347f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseli=
ne-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseli=
ne-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656c41c4fe1e71da0ae13=
480
        failing since 572 days (last pass: v5.4.191-84-g56ce42d78d96, first=
 fail: v5.4.191-125-g5917d1547e6e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656c3ff45cff186a9ae1348e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656c3ff45cff186a9ae13=
48f
        failing since 495 days (last pass: v5.4.180-77-g7de29e82b9db, first=
 fail: v5.4.207-73-ga2480f1b1dda1) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/656c415ba4b5ba1cebe1347f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656c415ba4b5ba1cebe13=
480
        failing since 572 days (last pass: v5.4.191-84-g56ce42d78d96, first=
 fail: v5.4.191-125-g5917d1547e6e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656c400e93da576f74e13553

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-vi=
rt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-vi=
rt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656c400e93da576f74e13=
554
        failing since 572 days (last pass: v5.4.191-77-g1a3b249e415b, first=
 fail: v5.4.191-125-g5917d1547e6e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/656c4099cef37236a0e134aa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/basel=
ine-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/basel=
ine-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656c4099cef37236a0e13=
4ab
        failing since 495 days (last pass: v5.4.180-77-g7de29e82b9db, first=
 fail: v5.4.207-73-ga2480f1b1dda1) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656c405c82e004626de134cf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656c405c82e004626de13=
4d0
        failing since 572 days (last pass: v5.4.191-77-g1a3b249e415b, first=
 fail: v5.4.191-125-g5917d1547e6e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/656c41af978690c09ce134b9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseli=
ne-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseli=
ne-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656c41af978690c09ce13=
4ba
        failing since 495 days (last pass: v5.4.180-77-g7de29e82b9db, first=
 fail: v5.4.207-73-ga2480f1b1dda1) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656c4030fb57447afae134b2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656c4030fb57447afae13=
4b3
        failing since 572 days (last pass: v5.4.191-77-g1a3b249e415b, first=
 fail: v5.4.191-125-g5917d1547e6e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/656c40638766375f6fe13490

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656c40638766375f6fe13=
491
        failing since 495 days (last pass: v5.4.180-77-g7de29e82b9db, first=
 fail: v5.4.207-73-ga2480f1b1dda1) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656c402182e004626de13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-vi=
rt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-vi=
rt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656c402182e004626de13=
476
        failing since 572 days (last pass: v5.4.191-77-g1a3b249e415b, first=
 fail: v5.4.191-125-g5917d1547e6e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/656c409e709c0c889be13476

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/basel=
ine-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/basel=
ine-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656c409e709c0c889be13=
477
        failing since 572 days (last pass: v5.4.191-84-g56ce42d78d96, first=
 fail: v5.4.191-125-g5917d1547e6e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656c414b17f0227feae134d8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656c414b17f0227feae13=
4d9
        failing since 572 days (last pass: v5.4.191-77-g1a3b249e415b, first=
 fail: v5.4.191-125-g5917d1547e6e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/656c42b3736204b671e13481

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseli=
ne-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseli=
ne-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656c42b3736204b671e13=
482
        failing since 572 days (last pass: v5.4.191-84-g56ce42d78d96, first=
 fail: v5.4.191-125-g5917d1547e6e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656c4032fdc9b0ffe6e134b3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656c4032fdc9b0ffe6e13=
4b4
        failing since 572 days (last pass: v5.4.191-77-g1a3b249e415b, first=
 fail: v5.4.191-125-g5917d1547e6e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/656c415cafb90e1a57e134b1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656c415cafb90e1a57e13=
4b2
        failing since 572 days (last pass: v5.4.191-84-g56ce42d78d96, first=
 fail: v5.4.191-125-g5917d1547e6e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/656c403703addaabf0e1348a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-=
h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.262-4=
9-g2add925443816/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-=
h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656c403703addaabf0e13493
        failing since 10 days (last pass: v5.4.230-72-gfed0bc9a3f6d, first =
fail: v5.4.261-89-g3f03c3b5b1e0)

    2023-12-03T08:45:15.750020  <8>[    7.943639] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-12-03T08:45:15.750332  + set +x
    2023-12-03T08:45:15.751994  <8>[    7.956700] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3857861_1.5.2.4.1>
    2023-12-03T08:45:15.858142  / # #
    2023-12-03T08:45:15.959467  export SHELL=3D/bin/sh
    2023-12-03T08:45:15.960076  #
    2023-12-03T08:45:16.061234  / # export SHELL=3D/bin/sh. /lava-3857861/e=
nvironment
    2023-12-03T08:45:16.061757  =

    2023-12-03T08:45:16.162725  / # . /lava-3857861/environment/lava-385786=
1/bin/lava-test-runner /lava-3857861/1
    2023-12-03T08:45:16.163750   =

    ... (13 line(s) more)  =

 =20

