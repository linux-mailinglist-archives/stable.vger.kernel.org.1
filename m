Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5C57B98AA
	for <lists+stable@lfdr.de>; Thu,  5 Oct 2023 01:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240657AbjJDXX7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 19:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240519AbjJDXX6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 19:23:58 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E41C9
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 16:23:51 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-694f3444f94so285313b3a.2
        for <stable@vger.kernel.org>; Wed, 04 Oct 2023 16:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696461830; x=1697066630; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DGQoI/yw7eC6lfR5ackjUj9CyyL+LWrd4R6KWp7s0gU=;
        b=HXKvp2d7YPPt5TOEwD66vzVxrVj3bMG3FjuMPYoSZst7hFlYK1DZnRKyVTmSSpSapD
         Tb59CHcymqLRH+oXHVlMUBWg/pqtYdjFZmzPdIx6ZzKTY0u1rLXwxnmVvtXqwOSqSrYQ
         c8L7JkCepQ615ZVRE/XsUhPL0ZYWvMN9xPrkv7/PTx9Tde7fcLI5RpUTN4RjktAQ7uZg
         PThs6zdWOwhzQJ/BgvcFypP49EwBgXN0Y5sALw37vlT9q8rHNhw20TlhehFOwWzRhOMi
         cS3NmK4fng08H5mcn5SukB311qmHW5rRB4A/XzMX0APHisDivvUS2Ffrx0QVAb8cNNuQ
         m2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696461830; x=1697066630;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DGQoI/yw7eC6lfR5ackjUj9CyyL+LWrd4R6KWp7s0gU=;
        b=ZfVFFafS3gcAAWkcp9EKbxFnXKCfz9hvMJIX9EXqgqq0rb/E0rIgxgJbYLLfM+iL/7
         NBYdIseC9Bi9AmGHCysztDYSIAVWq2xeMcuTiY+1yc27MkMI3XoJSKHqKekFvLLTDGnp
         2QYm8w7V1e2WnSjYCHdJU5fLJgUoeMt4IzcIiF66j86YbNP8uT/cmT6/1k8I2kQJQoFb
         IZargJO7DY7HqqoAYusLsNLOqnDE1fo9iAgjBAX2PvdGAOF5wsydH1PWz0Qf+tEg6xLC
         SY9gRVwA0DaS69x8AVLDsR35UgUHI1yt/8YWHUdE/b0tULKcQcdvfC2khNQ0KhoK4fOa
         /D3w==
X-Gm-Message-State: AOJu0YzM7bBAt7XjHBI30xMNyzEugfQaICAmsxRXLhAMRuli2770BOdn
        9TXQhMlxsiPheNgSpgRE4kWCRIGQOR1Uj+e6UEVTng==
X-Google-Smtp-Source: AGHT+IHST0JiSx3kOlwGQlmuzYCakoY0XDUqcVLguRXKdoigIasdgsvho6Fd9czLFDmh+VNxjP51Mg==
X-Received: by 2002:a05:6a00:23c8:b0:68e:265d:c2b5 with SMTP id g8-20020a056a0023c800b0068e265dc2b5mr4341682pfc.29.1696461830024;
        Wed, 04 Oct 2023 16:23:50 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x27-20020a056a00271b00b006934704bf56sm69110pfv.64.2023.10.04.16.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 16:22:53 -0700 (PDT)
Message-ID: <651df3cd.050a0220.203239.0634@mx.google.com>
Date:   Wed, 04 Oct 2023 16:22:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.55-260-g0353a7bfd2b60
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-6.1.y baseline: 137 runs,
 31 regressions (v6.1.55-260-g0353a7bfd2b60)
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

stable-rc/linux-6.1.y baseline: 137 runs, 31 regressions (v6.1.55-260-g0353=
a7bfd2b60)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

qemu_arm-vexpress-a15        | arm    | lab-baylibre  | gcc-10   | vexpress=
_defconfig           | 1          =

qemu_arm-vexpress-a9         | arm    | lab-baylibre  | gcc-10   | vexpress=
_defconfig           | 1          =

qemu_arm-virt-gicv2          | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm-virt-gicv2-uefi     | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm-virt-gicv3          | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm-virt-gicv3-uefi     | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_i386                    | i386   | lab-baylibre  | gcc-10   | i386_def=
config               | 1          =

qemu_i386-uefi               | i386   | lab-baylibre  | gcc-10   | i386_def=
config               | 1          =

qemu_riscv64                 | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_smp8_riscv64            | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_x86_64                  | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efconfig             | 1          =

qemu_x86_64                  | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

qemu_x86_64-uefi             | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efconfig             | 1          =

qemu_x86_64-uefi             | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efconfig             | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.55-260-g0353a7bfd2b60/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.55-260-g0353a7bfd2b60
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      0353a7bfd2b60c5e42c8651eb3fa4cc48159db5f =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651dc135ef4852c9af8a0a43

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651dc135ef4852c9af8a0a4c
        failing since 188 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-04T19:48:06.856956  + set +x

    2023-10-04T19:48:06.863028  <8>[    7.946324] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11680052_1.4.2.3.1>

    2023-10-04T19:48:06.965435  =


    2023-10-04T19:48:07.065999  / # #export SHELL=3D/bin/sh

    2023-10-04T19:48:07.066202  =


    2023-10-04T19:48:07.166687  / # export SHELL=3D/bin/sh. /lava-11680052/=
environment

    2023-10-04T19:48:07.166927  =


    2023-10-04T19:48:07.267554  / # . /lava-11680052/environment/lava-11680=
052/bin/lava-test-runner /lava-11680052/1

    2023-10-04T19:48:07.267876  =


    2023-10-04T19:48:07.274151  / # /lava-11680052/bin/lava-test-runner /la=
va-11680052/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651dc12b36ea59d08f8a0a6a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651dc12b36ea59d08f8a0a73
        failing since 188 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-04T19:46:49.200206  + <8>[   11.177952] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11680096_1.4.2.3.1>

    2023-10-04T19:46:49.200682  set +x

    2023-10-04T19:46:49.308923  / # #

    2023-10-04T19:46:49.411345  export SHELL=3D/bin/sh

    2023-10-04T19:46:49.412088  #

    2023-10-04T19:46:49.513642  / # export SHELL=3D/bin/sh. /lava-11680096/=
environment

    2023-10-04T19:46:49.514437  =


    2023-10-04T19:46:49.615982  / # . /lava-11680096/environment/lava-11680=
096/bin/lava-test-runner /lava-11680096/1

    2023-10-04T19:46:49.617283  =


    2023-10-04T19:46:49.622226  / # /lava-11680096/bin/lava-test-runner /la=
va-11680096/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651dc131682ea4c55e8a0a42

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651dc131682ea4c55e8a0a4b
        failing since 188 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-04T19:46:31.918264  <8>[   10.640730] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11680041_1.4.2.3.1>

    2023-10-04T19:46:31.921487  + set +x

    2023-10-04T19:46:32.026967  =


    2023-10-04T19:46:32.128573  / # #export SHELL=3D/bin/sh

    2023-10-04T19:46:32.129327  =


    2023-10-04T19:46:32.231000  / # export SHELL=3D/bin/sh. /lava-11680041/=
environment

    2023-10-04T19:46:32.231638  =


    2023-10-04T19:46:32.333018  / # . /lava-11680041/environment/lava-11680=
041/bin/lava-test-runner /lava-11680041/1

    2023-10-04T19:46:32.334128  =


    2023-10-04T19:46:32.339353  / # /lava-11680041/bin/lava-test-runner /la=
va-11680041/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651dc11ffc9719b1648a0afe

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651dc120fc9719b1648a0b07
        failing since 188 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-04T19:46:23.279373  + set +x

    2023-10-04T19:46:23.285618  <8>[   10.301148] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11680040_1.4.2.3.1>

    2023-10-04T19:46:23.390459  / # #

    2023-10-04T19:46:23.490971  export SHELL=3D/bin/sh

    2023-10-04T19:46:23.491133  #

    2023-10-04T19:46:23.591700  / # export SHELL=3D/bin/sh. /lava-11680040/=
environment

    2023-10-04T19:46:23.591863  =


    2023-10-04T19:46:23.692354  / # . /lava-11680040/environment/lava-11680=
040/bin/lava-test-runner /lava-11680040/1

    2023-10-04T19:46:23.692602  =


    2023-10-04T19:46:23.697163  / # /lava-11680040/bin/lava-test-runner /la=
va-11680040/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651dc11dfc9719b1648a0abc

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651dc11dfc9719b1648a0ac5
        failing since 188 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-04T19:46:51.568764  + set<8>[   11.267875] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11680064_1.4.2.3.1>

    2023-10-04T19:46:51.568858   +x

    2023-10-04T19:46:51.673200  / # #

    2023-10-04T19:46:51.773818  export SHELL=3D/bin/sh

    2023-10-04T19:46:51.774038  #

    2023-10-04T19:46:51.874617  / # export SHELL=3D/bin/sh. /lava-11680064/=
environment

    2023-10-04T19:46:51.874840  =


    2023-10-04T19:46:51.975401  / # . /lava-11680064/environment/lava-11680=
064/bin/lava-test-runner /lava-11680064/1

    2023-10-04T19:46:51.975732  =


    2023-10-04T19:46:51.980763  / # /lava-11680064/bin/lava-test-runner /la=
va-11680064/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651dc114fc9719b1648a0a46

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651dc114fc9719b1648a0a4f
        failing since 188 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-04T19:46:09.076314  <8>[   12.609238] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11680035_1.4.2.3.1>

    2023-10-04T19:46:09.180601  / # #

    2023-10-04T19:46:09.281301  export SHELL=3D/bin/sh

    2023-10-04T19:46:09.281492  #

    2023-10-04T19:46:09.381987  / # export SHELL=3D/bin/sh. /lava-11680035/=
environment

    2023-10-04T19:46:09.382174  =


    2023-10-04T19:46:09.482734  / # . /lava-11680035/environment/lava-11680=
035/bin/lava-test-runner /lava-11680035/1

    2023-10-04T19:46:09.483100  =


    2023-10-04T19:46:09.487971  / # /lava-11680035/bin/lava-test-runner /la=
va-11680035/1

    2023-10-04T19:46:09.494662  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-vexpress-a15        | arm    | lab-baylibre  | gcc-10   | vexpress=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/651dbf1e344d0c3fbb8a0a77

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: vexpress_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/arm/vexpress_defconfig/gcc-10/lab-baylibre/baseline-qemu=
_arm-vexpress-a15.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/arm/vexpress_defconfig/gcc-10/lab-baylibre/baseline-qemu=
_arm-vexpress-a15.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651dbf1e344d0c3fbb8a0=
a78
        new failure (last pass: v6.1.39) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-vexpress-a9         | arm    | lab-baylibre  | gcc-10   | vexpress=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/651dbf1d344d0c3fbb8a0a74

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: vexpress_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/arm/vexpress_defconfig/gcc-10/lab-baylibre/baseline-qemu=
_arm-vexpress-a9.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/arm/vexpress_defconfig/gcc-10/lab-baylibre/baseline-qemu=
_arm-vexpress-a9.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651dbf1d344d0c3fbb8a0=
a75
        new failure (last pass: v6.1.39) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv2          | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/651dc2631383273a468a0ab4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu=
_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu=
_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651dc2631383273a468a0=
ab5
        new failure (last pass: v6.1.39) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv2-uefi     | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/651dc2621383273a468a0ab1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu=
_arm-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu=
_arm-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651dc2621383273a468a0=
ab2
        new failure (last pass: v6.1.39) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv3          | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/651dc265f0300d60bc8a0a43

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu=
_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu=
_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651dc265f0300d60bc8a0=
a44
        new failure (last pass: v6.1.39) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv3-uefi     | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/651dc2641383273a468a0aba

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu=
_arm-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu=
_arm-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651dc2641383273a468a0=
abb
        new failure (last pass: v6.1.39) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/651dbf19344d0c3fbb8a0a68

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/bas=
eline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/bas=
eline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651dbf19344d0c3fbb8a0=
a69
        new failure (last pass: v6.1.39) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/651dc278f0300d60bc8a0a6f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651dc278f0300d60bc8a0=
a70
        new failure (last pass: v6.1.38-590-gce7ec1011187) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/651dbf1b344d0c3fbb8a0a6e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/bas=
eline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/bas=
eline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651dbf1b344d0c3fbb8a0=
a6f
        new failure (last pass: v6.1.39) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/651dc279d6ed6187a78a0a45

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651dc279d6ed6187a78a0=
a46
        new failure (last pass: v6.1.38-590-gce7ec1011187) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/651dbf1a344d0c3fbb8a0a6b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/bas=
eline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/bas=
eline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651dbf1a344d0c3fbb8a0=
a6c
        new failure (last pass: v6.1.39) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/651dc27af0300d60bc8a0a75

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651dc27af0300d60bc8a0=
a76
        new failure (last pass: v6.1.38-590-gce7ec1011187) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/651dbf1c344d0c3fbb8a0a71

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/bas=
eline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/bas=
eline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651dbf1c344d0c3fbb8a0=
a72
        new failure (last pass: v6.1.39) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/651dc28b46703ed3cd8a0b4b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651dc28b46703ed3cd8a0=
b4c
        new failure (last pass: v6.1.38-590-gce7ec1011187) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_i386                    | i386   | lab-baylibre  | gcc-10   | i386_def=
config               | 1          =


  Details:     https://kernelci.org/test/plan/id/651dbec8ea6120b6e18a0b5e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_i3=
86.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_i3=
86.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651dbec8ea6120b6e18a0=
b5f
        new failure (last pass: v6.1.39-224-ge54fe15e179b) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_i386-uefi               | i386   | lab-baylibre  | gcc-10   | i386_def=
config               | 1          =


  Details:     https://kernelci.org/test/plan/id/651dbec9ec6a9b6e2b8a0b35

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_i3=
86-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_i3=
86-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651dbec9ec6a9b6e2b8a0=
b36
        new failure (last pass: v6.1.39-224-ge54fe15e179b) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_riscv64                 | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/651dc01d9400c336828a0c02

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/riscv/defconfig/gcc-10/lab-baylibre/baseline-qemu_riscv6=
4.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/riscv/defconfig/gcc-10/lab-baylibre/baseline-qemu_riscv6=
4.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/riscv/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651dc01d9400c336828a0=
c03
        new failure (last pass: v6.1.39) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_smp8_riscv64            | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/651dc01c9400c336828a0bf4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/riscv/defconfig/gcc-10/lab-baylibre/baseline-qemu_smp8_r=
iscv64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/riscv/defconfig/gcc-10/lab-baylibre/baseline-qemu_smp8_r=
iscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/riscv/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651dc01c9400c336828a0=
bf5
        new failure (last pass: v6.1.39) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64                  | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/651dbf06344d0c3fbb8a0a5e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qem=
u_x86_64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qem=
u_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651dbf06344d0c3fbb8a0=
a5f
        new failure (last pass: v6.1.39) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64                  | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651dc0ff97214874108a0a54

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-baylib=
re/baseline-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-baylib=
re/baseline-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651dc0ff97214874108a0=
a55
        new failure (last pass: v6.1.39) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi             | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/651dbf08a4b089a8098a0a70

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qem=
u_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qem=
u_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651dbf08a4b089a8098a0=
a71
        new failure (last pass: v6.1.39) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi             | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651dc0fe97214874108a0a51

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-baylib=
re/baseline-qemu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-baylib=
re/baseline-qemu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651dc0fe97214874108a0=
a52
        new failure (last pass: v6.1.39) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/651dbf07a4b089a8098a0a6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qem=
u_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qem=
u_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651dbf07a4b089a8098a0=
a6e
        new failure (last pass: v6.1.39) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651dc10097214874108a0a57

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-baylib=
re/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-baylib=
re/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651dc10097214874108a0=
a58
        new failure (last pass: v6.1.39) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/651dc2c4c6d0b4e1998a0a42

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55-=
260-g0353a7bfd2b60/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651dc2c4c6d0b4e1998a0a4b
        failing since 78 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-10-04T19:57:52.318391  / # #

    2023-10-04T19:57:52.419095  export SHELL=3D/bin/sh

    2023-10-04T19:57:52.419835  #

    2023-10-04T19:57:52.521150  / # export SHELL=3D/bin/sh. /lava-11680218/=
environment

    2023-10-04T19:57:52.521849  =


    2023-10-04T19:57:52.623196  / # . /lava-11680218/environment/lava-11680=
218/bin/lava-test-runner /lava-11680218/1

    2023-10-04T19:57:52.624338  =


    2023-10-04T19:57:52.627178  / # /lava-11680218/bin/lava-test-runner /la=
va-11680218/1

    2023-10-04T19:57:52.706707  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-04T19:57:52.707157  + cd /lava-1168021<8>[   18.793383] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11680218_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
