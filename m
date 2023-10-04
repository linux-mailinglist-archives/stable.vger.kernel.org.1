Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F3A7B97FD
	for <lists+stable@lfdr.de>; Thu,  5 Oct 2023 00:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjJDW37 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 18:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjJDW36 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 18:29:58 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400D2C6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 15:29:52 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c63164a2b6so11714525ad.0
        for <stable@vger.kernel.org>; Wed, 04 Oct 2023 15:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696458591; x=1697063391; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KabpYSurwr3uTbwXhUb1pBCU8qTBaUqn9G11+alpyCQ=;
        b=e1GMFcl/gbjTG3ZAqI4NfBAqliccBT0e/SWJpDBl0h2EWBvauaOn5a8rW4dE2VYQO7
         +sPMIM78BVzjJrwebg5369ac2YjYfSGIzyKuGj3NqNL4yH93/T8huLId8j74nz9eG0XA
         lz/bCOuYUnnTnb+9aYb/yKFMzn6ssW6FN1mWYmQeiDW8BiuAuLPNQIfSV7g9YpD7vZmO
         XwpmXCZnEVzYtNansvRvXMXW9DMDBH8+W2fO1K6kAcOIkiVH4DXIlSPqyTsTgG8k8GOM
         ARieoeR+xr7aOrMziHOsgRS78h4Lf2YI2C8/ofwRYLCGi9/mSpDwgSoVzQ2F+ZTNILJF
         MGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696458591; x=1697063391;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KabpYSurwr3uTbwXhUb1pBCU8qTBaUqn9G11+alpyCQ=;
        b=qIqE38H9vBbzZprbY4235cn5eG4enn/ho4FcW3/PskkkVFW7rNqeE6RW2aEAUQOP7m
         msWDoWlEsjmx3LIg7yAo/w6j/bP/YPatGVEXKknuriCMxqHklZtkC2FJzWwgaW+8ti9X
         ef+4NNZaBEzl9cH0xGHKC5UoAcAt6/XTBdnlA7aIl6INGtyicjcmvbrBo0kgV7qz6nYt
         85eXHIG+V8KNDnrRswwfd6g0LI17+F78hEJ6eopDCyB2hASMaGeo143i/bbmpuYZy9/n
         7Pt/X1CNsPkSNjb7OP3v0IQerIC9obgFnI0ujt+nmZ0HCFP8bR/RIuYErTagivPsZeU9
         9UAQ==
X-Gm-Message-State: AOJu0Yzj9taUuCtfGytrRpT3B8QN1NwgxUXGquxuzSvsJM5f7O1Wf+YJ
        fPeEyHpj+cu69LzIwoITFIrqiYOqaU5MbibzjEUCiQ==
X-Google-Smtp-Source: AGHT+IG/IJfd80hgTLdo/iQXHJhhN4GF1bIqoIQEi70loBQwt0lhQnr7NooWgp5ApbYAX0odcJ80yw==
X-Received: by 2002:a17:902:d507:b0:1b0:3ab6:5140 with SMTP id b7-20020a170902d50700b001b03ab65140mr1205782plg.4.1696458590907;
        Wed, 04 Oct 2023 15:29:50 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jk13-20020a170903330d00b001b392bf9192sm65764plb.145.2023.10.04.15.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 15:29:50 -0700 (PDT)
Message-ID: <651de75e.170a0220.23791.04fa@mx.google.com>
Date:   Wed, 04 Oct 2023 15:29:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.133-184-g6f28ecf24aef
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.15.y baseline: 136 runs,
 34 regressions (v5.15.133-184-g6f28ecf24aef)
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

stable-rc/linux-5.15.y baseline: 136 runs, 34 regressions (v5.15.133-184-g6=
f28ecf24aef)

Regressions Summary
-------------------

platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
asus-C436FA-Flip-hatch     | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

asus-cx9400-volteer        | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

hp-x360-14-G1-sona         | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork  | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

kontron-pitx-imx8m         | arm64  | lab-kontron   | gcc-10   | defconfig =
                   | 2          =

lenovo-TPad-C13-Yoga-zork  | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

qemu_arm-vexpress-a15      | arm    | lab-baylibre  | gcc-10   | vexpress_d=
efconfig           | 1          =

qemu_arm-vexpress-a9       | arm    | lab-baylibre  | gcc-10   | vexpress_d=
efconfig           | 1          =

qemu_arm-virt-gicv2        | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =

qemu_arm-virt-gicv2-uefi   | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =

qemu_arm-virt-gicv3        | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =

qemu_arm-virt-gicv3-uefi   | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_i386                  | i386   | lab-baylibre  | gcc-10   | i386_defco=
nfig               | 1          =

qemu_i386-uefi             | i386   | lab-baylibre  | gcc-10   | i386_defco=
nfig               | 1          =

qemu_riscv64               | riscv  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =

qemu_smp8_riscv64          | riscv  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =

qemu_x86_64                | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
config             | 1          =

qemu_x86_64                | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

qemu_x86_64-uefi           | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
config             | 1          =

qemu_x86_64-uefi           | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

qemu_x86_64-uefi-mixed     | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
config             | 1          =

qemu_x86_64-uefi-mixed     | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

r8a77960-ulcb              | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =

r8a779m1-ulcb              | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =

sun50i-h6-pine-h64         | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.133-184-g6f28ecf24aef/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.133-184-g6f28ecf24aef
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      6f28ecf24aef2896f4071dc6268d3fb5f8259c77 =



Test Regressions
---------------- =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
asus-C436FA-Flip-hatch     | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651db56f56b11608068a0a9f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651db56f56b11608068a0aa8
        failing since 189 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-10-04T18:56:23.946471  <8>[   10.533752] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11679362_1.4.2.3.1>

    2023-10-04T18:56:23.950102  + set +x

    2023-10-04T18:56:24.055483  #

    2023-10-04T18:56:24.056737  =


    2023-10-04T18:56:24.158703  / # #export SHELL=3D/bin/sh

    2023-10-04T18:56:24.159548  =


    2023-10-04T18:56:24.261255  / # export SHELL=3D/bin/sh. /lava-11679362/=
environment

    2023-10-04T18:56:24.262035  =


    2023-10-04T18:56:24.363716  / # . /lava-11679362/environment/lava-11679=
362/bin/lava-test-runner /lava-11679362/1

    2023-10-04T18:56:24.365038  =

 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
asus-cx9400-volteer        | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651db49bbc144d6e488a0a5a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651db49bbc144d6e488a0a63
        failing since 189 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-10-04T18:52:50.766144  <8>[   10.282462] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11679298_1.4.2.3.1>

    2023-10-04T18:52:50.769840  + set +x

    2023-10-04T18:52:50.871145  /#

    2023-10-04T18:52:50.971999   # #export SHELL=3D/bin/sh

    2023-10-04T18:52:50.972211  =


    2023-10-04T18:52:51.072762  / # export SHELL=3D/bin/sh. /lava-11679298/=
environment

    2023-10-04T18:52:51.072990  =


    2023-10-04T18:52:51.173547  / # . /lava-11679298/environment/lava-11679=
298/bin/lava-test-runner /lava-11679298/1

    2023-10-04T18:52:51.173886  =


    2023-10-04T18:52:51.178987  / # /lava-11679298/bin/lava-test-runner /la=
va-11679298/1
 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
hp-x360-14-G1-sona         | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651db47db35f4fb69e8a0a8a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651db47db35f4fb69e8a0a93
        failing since 189 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-10-04T18:52:28.572085  + set +x

    2023-10-04T18:52:28.578860  <8>[   11.014216] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11679281_1.4.2.3.1>

    2023-10-04T18:52:28.687448  =


    2023-10-04T18:52:28.789339  / # #export SHELL=3D/bin/sh

    2023-10-04T18:52:28.790128  =


    2023-10-04T18:52:28.891709  / # export SHELL=3D/bin/sh. /lava-11679281/=
environment

    2023-10-04T18:52:28.892491  =


    2023-10-04T18:52:28.993987  / # . /lava-11679281/environment/lava-11679=
281/bin/lava-test-runner /lava-11679281/1

    2023-10-04T18:52:28.995314  =


    2023-10-04T18:52:29.000528  / # /lava-11679281/bin/lava-test-runner /la=
va-11679281/1
 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
hp-x360-14a-cb0001xx-zork  | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651db4b0ccb454c07b8a0a71

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651db4b0ccb454c07b8a0a7a
        failing since 189 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-10-04T18:53:09.775925  + set<8>[   10.791867] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11679357_1.4.2.3.1>

    2023-10-04T18:53:09.776011   +x

    2023-10-04T18:53:09.880482  / # #

    2023-10-04T18:53:09.981092  export SHELL=3D/bin/sh

    2023-10-04T18:53:09.981287  #

    2023-10-04T18:53:10.081823  / # export SHELL=3D/bin/sh. /lava-11679357/=
environment

    2023-10-04T18:53:10.082007  =


    2023-10-04T18:53:10.182546  / # . /lava-11679357/environment/lava-11679=
357/bin/lava-test-runner /lava-11679357/1

    2023-10-04T18:53:10.182789  =


    2023-10-04T18:53:10.187244  / # /lava-11679357/bin/lava-test-runner /la=
va-11679357/1
 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
kontron-pitx-imx8m         | arm64  | lab-kontron   | gcc-10   | defconfig =
                   | 2          =


  Details:     https://kernelci.org/test/plan/id/651db57256b11608068a0aab

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pi=
tx-imx8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pi=
tx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651db57256b11608068a0ab2
        new failure (last pass: v5.15.132-111-g634d2466eedd)

    2023-10-04T18:56:34.443608  / # #
    2023-10-04T18:56:34.545755  export SHELL=3D/bin/sh
    2023-10-04T18:56:34.546544  #
    2023-10-04T18:56:34.647793  / # export SHELL=3D/bin/sh. /lava-384262/en=
vironment
    2023-10-04T18:56:34.648422  =

    2023-10-04T18:56:34.749648  / # . /lava-384262/environment/lava-384262/=
bin/lava-test-runner /lava-384262/1
    2023-10-04T18:56:34.750821  =

    2023-10-04T18:56:34.768844  / # /lava-384262/bin/lava-test-runner /lava=
-384262/1
    2023-10-04T18:56:34.816125  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-04T18:56:34.816544  + cd /l<8>[   12.138197] <LAVA_SIGNAL_START=
RUN 1_bootrr 384262_1.5.2.4.5> =

    ... (10 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/651=
db57256b11608068a0ac2
        new failure (last pass: v5.15.132-111-g634d2466eedd)

    2023-10-04T18:56:37.137105  /lava-384262/1/../bin/lava-test-case
    2023-10-04T18:56:37.137542  <8>[   14.552706] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>
    2023-10-04T18:56:37.137844  /lava-384262/1/../bin/lava-test-case   =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
lenovo-TPad-C13-Yoga-zork  | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651db486b35f4fb69e8a0ace

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651db486b35f4fb69e8a0ad7
        failing since 189 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-10-04T18:52:39.683847  + <8>[   12.289072] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11679311_1.4.2.3.1>

    2023-10-04T18:52:39.683946  set +x

    2023-10-04T18:52:39.788347  / # #

    2023-10-04T18:52:39.888884  export SHELL=3D/bin/sh

    2023-10-04T18:52:39.889067  #

    2023-10-04T18:52:39.989603  / # export SHELL=3D/bin/sh. /lava-11679311/=
environment

    2023-10-04T18:52:39.989813  =


    2023-10-04T18:52:40.090295  / # . /lava-11679311/environment/lava-11679=
311/bin/lava-test-runner /lava-11679311/1

    2023-10-04T18:52:40.090592  =


    2023-10-04T18:52:40.095332  / # /lava-11679311/bin/lava-test-runner /la=
va-11679311/1
 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm-vexpress-a15      | arm    | lab-baylibre  | gcc-10   | vexpress_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/651db283e85dfb6c348a0c1a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: vexpress_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm/vexpress_defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm-vexpress-a15.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm/vexpress_defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm-vexpress-a15.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651db283e85dfb6c348a0=
c1b
        new failure (last pass: v5.15.120-461-gf00f5bd44794) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm-vexpress-a9       | arm    | lab-baylibre  | gcc-10   | vexpress_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/651db282e85dfb6c348a0c17

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: vexpress_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm/vexpress_defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm-vexpress-a9.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm/vexpress_defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm-vexpress-a9.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651db282e85dfb6c348a0=
c18
        new failure (last pass: v5.15.120-461-gf00f5bd44794) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm-virt-gicv2        | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/651db4dd54a68d4d418a0a8c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651db4dd54a68d4d418a0=
a8d
        new failure (last pass: v5.15.120) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm-virt-gicv2-uefi   | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/651db4db54a68d4d418a0a86

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651db4db54a68d4d418a0=
a87
        new failure (last pass: v5.15.120) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm-virt-gicv3        | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/651db4de54a68d4d418a0a8f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651db4de54a68d4d418a0=
a90
        new failure (last pass: v5.15.120) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm-virt-gicv3-uefi   | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/651db4dc54a68d4d418a0a89

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651db4dc54a68d4d418a0=
a8a
        new failure (last pass: v5.15.120) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/651db52c2802d3149f8a0a65

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm6=
4-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm6=
4-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651db52c2802d3149f8a0=
a66
        new failure (last pass: v5.15.120) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/651db658f42e74a3408a0a86

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/b=
aseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/b=
aseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651db658f42e74a3408a0=
a87
        new failure (last pass: v5.15.120) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/651db52b2802d3149f8a0a62

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm6=
4-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm6=
4-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651db52b2802d3149f8a0=
a63
        new failure (last pass: v5.15.120) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/651db657f42e74a3408a0a83

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/b=
aseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/b=
aseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651db657f42e74a3408a0=
a84
        new failure (last pass: v5.15.120) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/651db52fed9d6c33fa8a0a4d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm6=
4-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm6=
4-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651db52fed9d6c33fa8a0=
a4e
        new failure (last pass: v5.15.120) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/651db6438c949b58868a0b07

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/b=
aseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/b=
aseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651db6438c949b58868a0=
b08
        new failure (last pass: v5.15.120) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/651db52d2802d3149f8a0a68

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm6=
4-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm6=
4-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651db52d2802d3149f8a0=
a69
        new failure (last pass: v5.15.120) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/651db644ed5bca6d5d8a0aac

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/b=
aseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/b=
aseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651db644ed5bca6d5d8a0=
aad
        new failure (last pass: v5.15.120) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_i386                  | i386   | lab-baylibre  | gcc-10   | i386_defco=
nfig               | 1          =


  Details:     https://kernelci.org/test/plan/id/651db2d4b4b21f30248a0a43

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_=
i386.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_=
i386.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651db2d4b4b21f30248a0=
a44
        new failure (last pass: v5.15.120) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_i386-uefi             | i386   | lab-baylibre  | gcc-10   | i386_defco=
nfig               | 1          =


  Details:     https://kernelci.org/test/plan/id/651db2d5b4b21f30248a0a46

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_=
i386-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_=
i386-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651db2d5b4b21f30248a0=
a47
        new failure (last pass: v5.15.120) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_riscv64               | riscv  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/651db3615bd87b46c88a0a78

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/riscv/defconfig/gcc-10/lab-baylibre/baseline-qemu_risc=
v64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/riscv/defconfig/gcc-10/lab-baylibre/baseline-qemu_risc=
v64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/riscv/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651db3615bd87b46c88a0=
a79
        new failure (last pass: v5.15.121-29-g391f6b7e3028e) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_smp8_riscv64          | riscv  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/651db3745bd87b46c88a0a8c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/riscv/defconfig/gcc-10/lab-baylibre/baseline-qemu_smp8=
_riscv64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/riscv/defconfig/gcc-10/lab-baylibre/baseline-qemu_smp8=
_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/riscv/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651db3745bd87b46c88a0=
a8d
        new failure (last pass: v5.15.121-29-g391f6b7e3028e) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_x86_64                | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
config             | 1          =


  Details:     https://kernelci.org/test/plan/id/651db3a1373d8f29bf8a0a52

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-q=
emu_x86_64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-q=
emu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651db3a1373d8f29bf8a0=
a53
        new failure (last pass: v5.15.120) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_x86_64                | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651db45150353477438a0aab

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-bayl=
ibre/baseline-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-bayl=
ibre/baseline-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651db45150353477438a0=
aac
        new failure (last pass: v5.15.120-461-gf00f5bd44794) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_x86_64-uefi           | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
config             | 1          =


  Details:     https://kernelci.org/test/plan/id/651db39fe5a10713758a0a48

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-q=
emu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-q=
emu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651db39fe5a10713758a0=
a49
        new failure (last pass: v5.15.120) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_x86_64-uefi           | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651db45050353477438a0aa8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-bayl=
ibre/baseline-qemu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-bayl=
ibre/baseline-qemu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651db45050353477438a0=
aa9
        new failure (last pass: v5.15.120-461-gf00f5bd44794) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_x86_64-uefi-mixed     | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
config             | 1          =


  Details:     https://kernelci.org/test/plan/id/651db3a0e5a10713758a0a4d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-q=
emu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-q=
emu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651db3a0e5a10713758a0=
a4e
        new failure (last pass: v5.15.120) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_x86_64-uefi-mixed     | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651db44f50353477438a0aa5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-bayl=
ibre/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-bayl=
ibre/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651db44f50353477438a0=
aa6
        new failure (last pass: v5.15.120-461-gf00f5bd44794) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
r8a77960-ulcb              | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/651db57656b11608068a0ae6

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651db57656b11608068a0aef
        failing since 76 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-10-04T19:00:51.755445  / # #

    2023-10-04T19:00:51.856003  export SHELL=3D/bin/sh

    2023-10-04T19:00:51.856149  #

    2023-10-04T19:00:51.956629  / # export SHELL=3D/bin/sh. /lava-11679426/=
environment

    2023-10-04T19:00:51.956746  =


    2023-10-04T19:00:52.057224  / # . /lava-11679426/environment/lava-11679=
426/bin/lava-test-runner /lava-11679426/1

    2023-10-04T19:00:52.057408  =


    2023-10-04T19:00:52.063900  / # /lava-11679426/bin/lava-test-runner /la=
va-11679426/1

    2023-10-04T19:00:52.123229  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-04T19:00:52.123751  + cd /lav<8>[   15.935353] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11679426_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
r8a779m1-ulcb              | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/651db57f44433d2ab48a0a50

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651db57f44433d2ab48a0a59
        failing since 76 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-10-04T18:56:57.305824  / # #

    2023-10-04T18:56:58.384837  export SHELL=3D/bin/sh

    2023-10-04T18:56:58.386568  #

    2023-10-04T18:56:59.876246  / # export SHELL=3D/bin/sh. /lava-11679429/=
environment

    2023-10-04T18:56:59.878095  =


    2023-10-04T18:57:02.601595  / # . /lava-11679429/environment/lava-11679=
429/bin/lava-test-runner /lava-11679429/1

    2023-10-04T18:57:02.603743  =


    2023-10-04T18:57:02.613615  / # /lava-11679429/bin/lava-test-runner /la=
va-11679429/1

    2023-10-04T18:57:02.675564  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-04T18:57:02.676059  + cd /lava-116794<8>[   25.558657] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11679429_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
sun50i-h6-pine-h64         | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/651db577645b3ce5358a0aa7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33-184-g6f28ecf24aef/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651db577645b3ce5358a0ab0
        failing since 76 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-10-04T19:01:05.654131  / # #

    2023-10-04T19:01:05.756232  export SHELL=3D/bin/sh

    2023-10-04T19:01:05.756955  #

    2023-10-04T19:01:05.858346  / # export SHELL=3D/bin/sh. /lava-11679427/=
environment

    2023-10-04T19:01:05.859085  =


    2023-10-04T19:01:05.960528  / # . /lava-11679427/environment/lava-11679=
427/bin/lava-test-runner /lava-11679427/1

    2023-10-04T19:01:05.961653  =


    2023-10-04T19:01:05.963288  / # /lava-11679427/bin/lava-test-runner /la=
va-11679427/1

    2023-10-04T19:01:06.004287  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-04T19:01:06.038294  + cd /lava-1167942<8>[   16.796025] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11679427_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
