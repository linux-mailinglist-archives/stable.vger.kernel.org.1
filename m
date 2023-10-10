Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654817BF067
	for <lists+stable@lfdr.de>; Tue, 10 Oct 2023 03:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379327AbjJJBkt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 21:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379337AbjJJBks (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 21:40:48 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD54F9D
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 18:40:43 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c434c33ec0so31032635ad.3
        for <stable@vger.kernel.org>; Mon, 09 Oct 2023 18:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696902042; x=1697506842; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C7/vC6Le9bczRWTgbjwcsSq5cytixf1fWvrpkYaKquE=;
        b=hpk48l2HVQOP9vnAeviFl2W1j4REbSPxMfM7BIKmdEHwK35ZQD40a/txbxMFs7QAuH
         /9ZtML01bQLSpfYnF+NiDg/LfdP6xRCeV848HU6R5ZCFzizhKhNRg4XRavuBZ5OSFRtJ
         kusyqkPOe79/6JQD4jSN8aWHnWNz+6mGrdsTKyBvmxRkNKL0Owk8HRFUYXkoeFdRGF6d
         /conUe0vd3w6ASGnb6a/uiMVJtziT7yDCr5u9GnbZr0CUfFb0t0PCJHXXYdQmwui4+Ur
         h3XNgES8TmTeS4h4uNe38PzV+L8wfjUKwo/xv87PirYHkITydoY6RKNyVlbuaMKDE0sE
         RuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696902042; x=1697506842;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C7/vC6Le9bczRWTgbjwcsSq5cytixf1fWvrpkYaKquE=;
        b=Ex/KHrlFONMiGAQPTrtpivgzXCY+fV5VG+UsSrXPaMnC0cwsSKcrGLuY43O64rEDua
         FcfHjU/ntBjmlL/AbqeP5bw/WFbLZzVNwFLbOop0XvZtgalJ7AnZKiPNebVPZ3nRLuLI
         MjxWb/4UfbShAUK9f40fZDBeEJimcTNVvQUHBuwBEt5L0y2mII06W+s9ZdP5R0IYVN5v
         5ewCi4C43YzylUhYSRUSyJLF/8OVZXUBgWrIo7WkkFq3XyKkAM0wmII1CE10np3gu/Ru
         WAADMfUfNXhQGXu12Rrqp7Ch4V8i+jqMkQ7EpALN3wYdHPmr2caFnhIuMrPx7klsfC0p
         lJug==
X-Gm-Message-State: AOJu0Yw/ut+cuOfhDFW9ME+xiFlQDFlrS9MX+E960yXnmFK84HPT7c3j
        DVSyTRVEPFB7EUANeYFp19G0zCvPYj79tZLDhQDWgw==
X-Google-Smtp-Source: AGHT+IH/bG+NigKyVybwKq/4VKFQZFcWN9v7Zt5gzVCqgWIgZHfFpjsnlKGID81psxnNJRGVrjflbw==
X-Received: by 2002:a17:902:d2c2:b0:1c7:3526:dfcd with SMTP id n2-20020a170902d2c200b001c73526dfcdmr16497521plc.52.1696902041832;
        Mon, 09 Oct 2023 18:40:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x20-20020a170902ea9400b001c5076ae6absm10210807plb.126.2023.10.09.18.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 18:40:41 -0700 (PDT)
Message-ID: <6524ab99.170a0220.878af.b633@mx.google.com>
Date:   Mon, 09 Oct 2023 18:40:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15.134-76-g6b29ebf84608
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.15.y baseline: 136 runs,
 34 regressions (v5.15.134-76-g6b29ebf84608)
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

stable-rc/linux-5.15.y baseline: 136 runs, 34 regressions (v5.15.134-76-g6b=
29ebf84608)

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

qemu_arm64-virt-gicv2      | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =

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
nel/v5.15.134-76-g6b29ebf84608/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.134-76-g6b29ebf84608
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      6b29ebf8460817018f98911286d0f8b8191d9c9c =



Test Regressions
---------------- =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
asus-C436FA-Flip-hatch     | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6524770307c90a2ba0efcf59

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6524770307c90a2ba0efcf62
        failing since 195 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-10-09T21:55:56.234666  <8>[   10.798366] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11716443_1.4.2.3.1>

    2023-10-09T21:55:56.237954  + set +x

    2023-10-09T21:55:56.339442  =


    2023-10-09T21:55:56.440049  / # #export SHELL=3D/bin/sh

    2023-10-09T21:55:56.440739  =


    2023-10-09T21:55:56.542061  / # export SHELL=3D/bin/sh. /lava-11716443/=
environment

    2023-10-09T21:55:56.542849  =


    2023-10-09T21:55:56.644268  / # . /lava-11716443/environment/lava-11716=
443/bin/lava-test-runner /lava-11716443/1

    2023-10-09T21:55:56.645278  =


    2023-10-09T21:55:56.650822  / # /lava-11716443/bin/lava-test-runner /la=
va-11716443/1
 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
asus-cx9400-volteer        | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652478d2007362c705efcf07

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652478d2007362c705efcf10
        failing since 195 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-10-09T22:04:00.305153  <8>[   10.452539] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11716494_1.4.2.3.1>

    2023-10-09T22:04:00.308711  + set +x

    2023-10-09T22:04:00.409802  #

    2023-10-09T22:04:00.510505  / # #export SHELL=3D/bin/sh

    2023-10-09T22:04:00.510709  =


    2023-10-09T22:04:00.611246  / # export SHELL=3D/bin/sh. /lava-11716494/=
environment

    2023-10-09T22:04:00.611459  =


    2023-10-09T22:04:00.712045  / # . /lava-11716494/environment/lava-11716=
494/bin/lava-test-runner /lava-11716494/1

    2023-10-09T22:04:00.712373  =


    2023-10-09T22:04:00.717486  / # /lava-11716494/bin/lava-test-runner /la=
va-11716494/1
 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
hp-x360-14-G1-sona         | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652478afc37060ae1eefd21e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652478b0c37060ae1eefd227
        failing since 195 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-10-09T22:02:52.164538  <8>[    8.050784] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11716502_1.4.2.3.1>

    2023-10-09T22:02:52.167938  + set +x

    2023-10-09T22:02:52.272346  / # #

    2023-10-09T22:02:52.373104  export SHELL=3D/bin/sh

    2023-10-09T22:02:52.373322  #

    2023-10-09T22:02:52.473850  / # export SHELL=3D/bin/sh. /lava-11716502/=
environment

    2023-10-09T22:02:52.474084  =


    2023-10-09T22:02:52.574642  / # . /lava-11716502/environment/lava-11716=
502/bin/lava-test-runner /lava-11716502/1

    2023-10-09T22:02:52.575085  =


    2023-10-09T22:02:52.579717  / # /lava-11716502/bin/lava-test-runner /la=
va-11716502/1
 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
hp-x360-14a-cb0001xx-zork  | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652476ef20583dc933efcf25

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652476ef20583dc933efcf2e
        failing since 195 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-10-09T21:55:43.711226  + set +x<8>[   11.569492] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11716427_1.4.2.3.1>

    2023-10-09T21:55:43.711344  =


    2023-10-09T21:55:43.815505  / # #

    2023-10-09T21:55:43.916055  export SHELL=3D/bin/sh

    2023-10-09T21:55:43.916263  #

    2023-10-09T21:55:44.016748  / # export SHELL=3D/bin/sh. /lava-11716427/=
environment

    2023-10-09T21:55:44.016943  =


    2023-10-09T21:55:44.117453  / # . /lava-11716427/environment/lava-11716=
427/bin/lava-test-runner /lava-11716427/1

    2023-10-09T21:55:44.117730  =


    2023-10-09T21:55:44.122190  / # /lava-11716427/bin/lava-test-runner /la=
va-11716427/1
 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
kontron-pitx-imx8m         | arm64  | lab-kontron   | gcc-10   | defconfig =
                   | 2          =


  Details:     https://kernelci.org/test/plan/id/65247a8175a8db9842efcf08

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pit=
x-imx8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pit=
x-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65247a8175a8db9842efcf0f
        failing since 5 days (last pass: v5.15.132-111-g634d2466eedd, first=
 fail: v5.15.133-184-g6f28ecf24aef)

    2023-10-09T22:11:05.777627  / # #
    2023-10-09T22:11:05.879522  export SHELL=3D/bin/sh
    2023-10-09T22:11:05.880089  #
    2023-10-09T22:11:05.981128  / # export SHELL=3D/bin/sh. /lava-384645/en=
vironment
    2023-10-09T22:11:05.981694  =

    2023-10-09T22:11:06.082723  / # . /lava-384645/environment/lava-384645/=
bin/lava-test-runner /lava-384645/1
    2023-10-09T22:11:06.083642  =

    2023-10-09T22:11:06.091943  / # /lava-384645/bin/lava-test-runner /lava=
-384645/1
    2023-10-09T22:11:06.150066  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-09T22:11:06.150463  + cd /l<8>[   12.115092] <LAVA_SIGNAL_START=
RUN 1_bootrr 384645_1.5.2.4.5> =

    ... (10 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/652=
47a8175a8db9842efcf1f
        failing since 5 days (last pass: v5.15.132-111-g634d2466eedd, first=
 fail: v5.15.133-184-g6f28ecf24aef)

    2023-10-09T22:11:08.475038  /lava-384645/1/../bin/lava-test-case
    2023-10-09T22:11:08.475254  <8>[   14.539385] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>
    2023-10-09T22:11:08.475412  /lava-384645/1/../bin/lava-test-case   =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
lenovo-TPad-C13-Yoga-zork  | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65247715047794661cefcf15

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65247715047794661cefcf1e
        failing since 195 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-10-09T21:56:19.299066  + set<8>[   12.468634] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11716434_1.4.2.3.1>

    2023-10-09T21:56:19.299177   +x

    2023-10-09T21:56:19.403714  / # #

    2023-10-09T21:56:19.504278  export SHELL=3D/bin/sh

    2023-10-09T21:56:19.504437  #

    2023-10-09T21:56:19.604942  / # export SHELL=3D/bin/sh. /lava-11716434/=
environment

    2023-10-09T21:56:19.605112  =


    2023-10-09T21:56:19.705686  / # . /lava-11716434/environment/lava-11716=
434/bin/lava-test-runner /lava-11716434/1

    2023-10-09T21:56:19.706044  =


    2023-10-09T21:56:19.710457  / # /lava-11716434/bin/lava-test-runner /la=
va-11716434/1
 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm-vexpress-a15      | arm    | lab-baylibre  | gcc-10   | vexpress_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/652475061f16277046efcef7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: vexpress_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm/vexpress_defconfig/gcc-10/lab-baylibre/baseline-qem=
u_arm-vexpress-a15.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm/vexpress_defconfig/gcc-10/lab-baylibre/baseline-qem=
u_arm-vexpress-a15.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652475061f16277046efc=
ef8
        failing since 5 days (last pass: v5.15.120-461-gf00f5bd44794, first=
 fail: v5.15.133-184-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm-vexpress-a9       | arm    | lab-baylibre  | gcc-10   | vexpress_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/652475051f16277046efcef4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: vexpress_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm/vexpress_defconfig/gcc-10/lab-baylibre/baseline-qem=
u_arm-vexpress-a9.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm/vexpress_defconfig/gcc-10/lab-baylibre/baseline-qem=
u_arm-vexpress-a9.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652475051f16277046efc=
ef5
        failing since 5 days (last pass: v5.15.120-461-gf00f5bd44794, first=
 fail: v5.15.133-184-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm-virt-gicv2        | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/652478722b753661deefcf08

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qem=
u_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qem=
u_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652478722b753661deefc=
f09
        failing since 5 days (last pass: v5.15.120, first fail: v5.15.133-1=
84-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm-virt-gicv2-uefi   | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/652478759c3d75dadaefcf51

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qem=
u_arm-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qem=
u_arm-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652478759c3d75dadaefc=
f52
        failing since 5 days (last pass: v5.15.120, first fail: v5.15.133-1=
84-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm-virt-gicv3        | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/652478762b753661deefcf12

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qem=
u_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qem=
u_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652478762b753661deefc=
f13
        failing since 5 days (last pass: v5.15.120, first fail: v5.15.133-1=
84-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm-virt-gicv3-uefi   | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/652478742b753661deefcf0b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qem=
u_arm-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qem=
u_arm-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652478742b753661deefc=
f0c
        failing since 5 days (last pass: v5.15.120, first fail: v5.15.133-1=
84-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/652477fa52acb9a854efcef9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/ba=
seline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/ba=
seline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652477fa52acb9a854efc=
efa
        failing since 5 days (last pass: v5.15.120, first fail: v5.15.133-1=
84-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/65247a673869fed4cfefcf0b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64=
-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64=
-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65247a673869fed4cfefc=
f0c
        failing since 5 days (last pass: v5.15.120, first fail: v5.15.133-1=
84-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/652477fb6972b2cce6efcef5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/ba=
seline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/ba=
seline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652477fb6972b2cce6efc=
ef6
        failing since 5 days (last pass: v5.15.120, first fail: v5.15.133-1=
84-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/65247a7c75a8db9842efcefe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64=
-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64=
-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65247a7c75a8db9842efc=
eff
        failing since 5 days (last pass: v5.15.120, first fail: v5.15.133-1=
84-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/652477fc6972b2cce6efcefa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/ba=
seline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/ba=
seline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652477fc6972b2cce6efc=
efb
        failing since 5 days (last pass: v5.15.120, first fail: v5.15.133-1=
84-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/65247a683869fed4cfefcf0e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64=
-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64=
-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65247a683869fed4cfefc=
f0f
        failing since 5 days (last pass: v5.15.120, first fail: v5.15.133-1=
84-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/652477fe52acb9a854efcf00

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/ba=
seline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/ba=
seline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652477fe52acb9a854efc=
f01
        failing since 5 days (last pass: v5.15.120, first fail: v5.15.133-1=
84-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/65247a693869fed4cfefcf11

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64=
-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64=
-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65247a693869fed4cfefc=
f12
        failing since 5 days (last pass: v5.15.120, first fail: v5.15.133-1=
84-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_i386                  | i386   | lab-baylibre  | gcc-10   | i386_defco=
nfig               | 1          =


  Details:     https://kernelci.org/test/plan/id/652476cf0738654a51efcf02

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_i=
386.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_i=
386.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652476cf0738654a51efc=
f03
        failing since 5 days (last pass: v5.15.120, first fail: v5.15.133-1=
84-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_i386-uefi             | i386   | lab-baylibre  | gcc-10   | i386_defco=
nfig               | 1          =


  Details:     https://kernelci.org/test/plan/id/652476d02c311a9e3cefcef5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_i=
386-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_i=
386-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652476d02c311a9e3cefc=
ef6
        failing since 5 days (last pass: v5.15.120, first fail: v5.15.133-1=
84-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_riscv64               | riscv  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/65247591ba8a21a29defcf04

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/riscv/defconfig/gcc-10/lab-baylibre/baseline-qemu_riscv=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/riscv/defconfig/gcc-10/lab-baylibre/baseline-qemu_riscv=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/riscv/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65247591ba8a21a29defc=
f05
        failing since 5 days (last pass: v5.15.121-29-g391f6b7e3028e, first=
 fail: v5.15.133-184-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_smp8_riscv64          | riscv  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/65247590d34c775815efcf07

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/riscv/defconfig/gcc-10/lab-baylibre/baseline-qemu_smp8_=
riscv64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/riscv/defconfig/gcc-10/lab-baylibre/baseline-qemu_smp8_=
riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/riscv/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65247590d34c775815efc=
f08
        failing since 5 days (last pass: v5.15.121-29-g391f6b7e3028e, first=
 fail: v5.15.133-184-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_x86_64                | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
config             | 1          =


  Details:     https://kernelci.org/test/plan/id/652475f3a3d82e9a59efcef9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_x86_64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652475f3a3d82e9a59efc=
efa
        failing since 5 days (last pass: v5.15.120, first fail: v5.15.133-1=
84-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_x86_64                | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652476a81f7d214952efcf0b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-bayli=
bre/baseline-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-bayli=
bre/baseline-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652476a81f7d214952efc=
f0c
        failing since 5 days (last pass: v5.15.120-461-gf00f5bd44794, first=
 fail: v5.15.133-184-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_x86_64-uefi           | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
config             | 1          =


  Details:     https://kernelci.org/test/plan/id/652475f4a3d82e9a59efcefc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652475f4a3d82e9a59efc=
efd
        failing since 5 days (last pass: v5.15.120, first fail: v5.15.133-1=
84-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_x86_64-uefi           | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652476a776ab306b2fefcfc4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-bayli=
bre/baseline-qemu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-bayli=
bre/baseline-qemu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652476a776ab306b2fefc=
fc5
        failing since 5 days (last pass: v5.15.120-461-gf00f5bd44794, first=
 fail: v5.15.133-184-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_x86_64-uefi-mixed     | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
config             | 1          =


  Details:     https://kernelci.org/test/plan/id/652475f5b2e1df6438efcefc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652475f5b2e1df6438efc=
efd
        failing since 5 days (last pass: v5.15.120, first fail: v5.15.133-1=
84-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_x86_64-uefi-mixed     | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652476a91f7d214952efcf10

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-bayli=
bre/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-bayli=
bre/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652476a91f7d214952efc=
f11
        failing since 5 days (last pass: v5.15.120-461-gf00f5bd44794, first=
 fail: v5.15.133-184-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
r8a77960-ulcb              | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/65247ab06a4825c298efcfb7

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65247ab06a4825c298efcfc0
        failing since 82 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-10-09T22:16:06.354201  / # #

    2023-10-09T22:16:06.456606  export SHELL=3D/bin/sh

    2023-10-09T22:16:06.457410  #

    2023-10-09T22:16:06.558868  / # export SHELL=3D/bin/sh. /lava-11716713/=
environment

    2023-10-09T22:16:06.559649  =


    2023-10-09T22:16:06.661166  / # . /lava-11716713/environment/lava-11716=
713/bin/lava-test-runner /lava-11716713/1

    2023-10-09T22:16:06.662401  =


    2023-10-09T22:16:06.676555  / # /lava-11716713/bin/lava-test-runner /la=
va-11716713/1

    2023-10-09T22:16:06.728236  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-09T22:16:06.728789  + cd /lav<8>[   16.005090] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11716713_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
r8a779m1-ulcb              | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/65247ac70aa1dfd69cefcf33

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65247ac70aa1dfd69cefcf3c
        failing since 82 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-10-09T22:12:27.262817  / # #

    2023-10-09T22:12:28.342048  export SHELL=3D/bin/sh

    2023-10-09T22:12:28.343815  #

    2023-10-09T22:12:29.834194  / # export SHELL=3D/bin/sh. /lava-11716717/=
environment

    2023-10-09T22:12:29.835970  =


    2023-10-09T22:12:32.559601  / # . /lava-11716717/environment/lava-11716=
717/bin/lava-test-runner /lava-11716717/1

    2023-10-09T22:12:32.561802  =


    2023-10-09T22:12:32.569858  / # /lava-11716717/bin/lava-test-runner /la=
va-11716717/1

    2023-10-09T22:12:32.632988  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-09T22:12:32.633447  + cd /lava-117167<8>[   25.545270] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11716717_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
sun50i-h6-pine-h64         | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/65247ac88e660c07e4efd044

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
34-76-g6b29ebf84608/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65247ac88e660c07e4efd04d
        failing since 82 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-10-09T22:16:18.506777  / # #

    2023-10-09T22:16:18.607492  export SHELL=3D/bin/sh

    2023-10-09T22:16:18.607716  #

    2023-10-09T22:16:18.708380  / # export SHELL=3D/bin/sh. /lava-11716725/=
environment

    2023-10-09T22:16:18.709094  =


    2023-10-09T22:16:18.810548  / # . /lava-11716725/environment/lava-11716=
725/bin/lava-test-runner /lava-11716725/1

    2023-10-09T22:16:18.811625  =


    2023-10-09T22:16:18.821004  / # /lava-11716725/bin/lava-test-runner /la=
va-11716725/1

    2023-10-09T22:16:18.884917  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-09T22:16:18.885510  + cd /lava-1171672<8>[   16.852771] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11716725_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
