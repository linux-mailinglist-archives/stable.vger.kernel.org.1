Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3537BEEA9
	for <lists+stable@lfdr.de>; Tue, 10 Oct 2023 01:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377989AbjJIXCc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 19:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377234AbjJIXCc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 19:02:32 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB187A4
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 16:02:27 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-690fa0eea3cso4538005b3a.0
        for <stable@vger.kernel.org>; Mon, 09 Oct 2023 16:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696892547; x=1697497347; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ffx7UcGqi2j1UrpL5kPaHsXPP64v91vhFLDapLkA4A8=;
        b=kFY1MUteAH1UDaTUh7l6XIerPQ1BucBBlQZra7uyQXMysOCvTFESOGnhRXKgZv/Yk4
         0v/tldj3uTTrrYzko/l+zd1nXk/Tp1/3GKQPx6EJ9ASqP3wTlg0AoQau8yrtg+nvLSKV
         +b7DAl6yNi3Lcyc6CgMMZiq3RDxayy9/KG0eYcLgi7t2GV7qzUw0vE4QPG/VC2PpQ8qM
         Fc9/Q3HY2e+sm32A4Z+cgA/q8vJxRjnVNG+LMQKvJPA94DDBhPBx91ccWOM08YaDfeYW
         q91krdNyKjYi8HWiRhDlfSgfsmCq7gvG5UNGHRpR9KkCJ7yzJ63oGWrXxsOrxuN498AP
         lRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696892547; x=1697497347;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ffx7UcGqi2j1UrpL5kPaHsXPP64v91vhFLDapLkA4A8=;
        b=q15FDvW30eBz4QBM8JcDfmd1ouhO9TUlRveBkc/JVaYv9Xrl4NaPTmKIvBvGRsJSSs
         GHbTTEGnvEKdBihHi4ITlQG1yMA0RJlb0LWK3XcGdyvAjJfgNnDttbVzQedxEm/wEgK9
         wzkZyormmm8+oHrIMu2Zs63DlYRvyu4Lg1CmOZsY38XnSxVIVgyXQdWW2v4akP4mbcv1
         oI803vRy3kctEVyGpsD9tcpw7AT/T+5WMvbfveJ+fY1uyORbGzePtOp4jpA4k0NYf84P
         z9Em5esGriBrzEdp3A+jCN54FA+6exXwA1rR5ETepZy5rSHnuHFpIyFe86Zy4+A7bgcf
         6qVA==
X-Gm-Message-State: AOJu0Yxh7UXdFhSA3iLrVR9Ow2PIwIaxheNjCnnu2azaqlsdarn/GyEU
        0ORTgRYQmHBGjuBkMfCObLzIpimaZhDg4jRzJBBZng==
X-Google-Smtp-Source: AGHT+IHswM9nSkWf8kuGGA257Yeb4O2+ycOBwCsW5q0pKHbeCAsmD6rXmeuPYBHs+/vm+skHjYgv7g==
X-Received: by 2002:a05:6a21:7881:b0:15e:a653:fed5 with SMTP id bf1-20020a056a21788100b0015ea653fed5mr21485336pzc.16.1696892546131;
        Mon, 09 Oct 2023 16:02:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t5-20020a62ea05000000b0068be4ce33easm7057903pfh.96.2023.10.09.16.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 16:02:25 -0700 (PDT)
Message-ID: <65248681.620a0220.37856.186a@mx.google.com>
Date:   Mon, 09 Oct 2023 16:02:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.197-227-g18c65c1b4996
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.10.y baseline: 141 runs,
 35 regressions (v5.10.197-227-g18c65c1b4996)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y baseline: 141 runs, 35 regressions (v5.10.197-227-g1=
8c65c1b4996)

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

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

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
g                    | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

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

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.197-227-g18c65c1b4996/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.197-227-g18c65c1b4996
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      18c65c1b4996e3f6f8986a05eceaf427355a7a4f =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65245174257f181258efcf3b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65245174257f181258efcf44
        failing since 194 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-10-09T19:16:09.274019  + set +x

    2023-10-09T19:16:09.281049  <8>[   10.345762] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11713947_1.4.2.3.1>

    2023-10-09T19:16:09.385240  / # #

    2023-10-09T19:16:09.485935  export SHELL=3D/bin/sh

    2023-10-09T19:16:09.486161  #

    2023-10-09T19:16:09.586758  / # export SHELL=3D/bin/sh. /lava-11713947/=
environment

    2023-10-09T19:16:09.586989  =


    2023-10-09T19:16:09.687609  / # . /lava-11713947/environment/lava-11713=
947/bin/lava-test-runner /lava-11713947/1

    2023-10-09T19:16:09.687949  =


    2023-10-09T19:16:09.692770  / # /lava-11713947/bin/lava-test-runner /la=
va-11713947/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6524510a10a9bf375defcf1e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6524510a10a9bf375defcf27
        failing since 194 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-10-09T19:14:18.811195  <8>[   12.062616] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11713917_1.4.2.3.1>

    2023-10-09T19:14:18.814458  + set +x

    2023-10-09T19:14:18.919156  #

    2023-10-09T19:14:18.920193  =


    2023-10-09T19:14:19.021848  / # #export SHELL=3D/bin/sh

    2023-10-09T19:14:19.022608  =


    2023-10-09T19:14:19.123976  / # export SHELL=3D/bin/sh. /lava-11713917/=
environment

    2023-10-09T19:14:19.124667  =


    2023-10-09T19:14:19.226161  / # . /lava-11713917/environment/lava-11713=
917/bin/lava-test-runner /lava-11713917/1

    2023-10-09T19:14:19.227212  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65245432846ae64ef6efcf0c

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65245432846ae64ef6efcf4c
        failing since 19 days (last pass: v5.10.195, first fail: v5.10.195-=
84-gf147286de8e5)

    2023-10-09T19:27:25.139229  / # #
    2023-10-09T19:27:25.242141  export SHELL=3D/bin/sh
    2023-10-09T19:27:25.242900  #
    2023-10-09T19:27:25.344888  / # export SHELL=3D/bin/sh. /lava-157740/en=
vironment
    2023-10-09T19:27:25.345633  =

    2023-10-09T19:27:25.447692  / # . /lava-157740/environment/lava-157740/=
bin/lava-test-runner /lava-157740/1
    2023-10-09T19:27:25.448984  =

    2023-10-09T19:27:25.463472  / # /lava-157740/bin/lava-test-runner /lava=
-157740/1
    2023-10-09T19:27:25.521359  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-09T19:27:25.521856  + cd /lava-157740/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-vexpress-a15        | arm    | lab-baylibre  | gcc-10   | vexpress=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65244e00ae325ca4c4efcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: vexpress_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm/vexpress_defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm-vexpress-a15.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm/vexpress_defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm-vexpress-a15.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65244e00ae325ca4c4efc=
ef4
        failing since 4 days (last pass: v5.10.186-441-g2f0e20469d5f, first=
 fail: v5.10.197-168-g3eccb060a778) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-vexpress-a9         | arm    | lab-baylibre  | gcc-10   | vexpress=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65244dffbc8e94beabefcefa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: vexpress_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm/vexpress_defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm-vexpress-a9.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm/vexpress_defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm-vexpress-a9.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65244dffbc8e94beabefc=
efb
        failing since 4 days (last pass: v5.10.186-441-g2f0e20469d5f, first=
 fail: v5.10.197-168-g3eccb060a778) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv2          | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/652450d32791865420efcf42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652450d32791865420efc=
f43
        failing since 4 days (last pass: v5.10.186, first fail: v5.10.197-1=
68-g3eccb060a778) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv2-uefi     | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/652450d42791865420efcf45

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652450d42791865420efc=
f46
        failing since 4 days (last pass: v5.10.186, first fail: v5.10.197-1=
68-g3eccb060a778) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv3          | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/652450e52791865420efcf72

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652450e52791865420efc=
f73
        failing since 4 days (last pass: v5.10.186, first fail: v5.10.197-1=
68-g3eccb060a778) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv3-uefi     | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/652450d52791865420efcf48

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652450d52791865420efc=
f49
        failing since 4 days (last pass: v5.10.186, first fail: v5.10.197-1=
68-g3eccb060a778) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/652453650af2790f76efcefd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm6=
4-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm6=
4-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652453650af2790f76efc=
efe
        failing since 4 days (last pass: v5.10.186, first fail: v5.10.197-1=
68-g3eccb060a778) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6524555b31e88c3d68efcf2d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/b=
aseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/b=
aseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6524555b31e88c3d68efc=
f2e
        failing since 5 days (last pass: v5.10.186, first fail: v5.10.197-1=
68-g3eccb060a778) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/652453780af2790f76efcf03

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm6=
4-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm6=
4-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652453780af2790f76efc=
f04
        failing since 4 days (last pass: v5.10.186, first fail: v5.10.197-1=
68-g3eccb060a778) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65245559d80ead50a4efcefb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/b=
aseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/b=
aseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65245559d80ead50a4efc=
efc
        failing since 5 days (last pass: v5.10.186, first fail: v5.10.197-1=
68-g3eccb060a778) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6524537969c1377d1defcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm6=
4-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm6=
4-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6524537969c1377d1defc=
ef4
        failing since 4 days (last pass: v5.10.186, first fail: v5.10.197-1=
68-g3eccb060a778) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6524555ad80ead50a4efcf01

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/b=
aseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/b=
aseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6524555ad80ead50a4efc=
f02
        failing since 5 days (last pass: v5.10.186, first fail: v5.10.197-1=
68-g3eccb060a778) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6524537a0af2790f76efcf0a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm6=
4-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm6=
4-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6524537a0af2790f76efc=
f0b
        failing since 4 days (last pass: v5.10.186, first fail: v5.10.197-1=
68-g3eccb060a778) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65245558d80ead50a4efcef6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/b=
aseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/b=
aseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65245558d80ead50a4efc=
ef7
        failing since 5 days (last pass: v5.10.186, first fail: v5.10.197-1=
68-g3eccb060a778) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_i386                    | i386   | lab-baylibre  | gcc-10   | i386_def=
config               | 1          =


  Details:     https://kernelci.org/test/plan/id/65244f69ea5981232fefcf34

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_=
i386.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_=
i386.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65244f69ea5981232fefc=
f35
        failing since 4 days (last pass: v5.10.186, first fail: v5.10.197-1=
68-g3eccb060a778) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_i386-uefi               | i386   | lab-baylibre  | gcc-10   | i386_def=
config               | 1          =


  Details:     https://kernelci.org/test/plan/id/65244f680481f35abcefcf1f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_=
i386-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_=
i386-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65244f680481f35abcefc=
f20
        failing since 4 days (last pass: v5.10.186, first fail: v5.10.197-1=
68-g3eccb060a778) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_riscv64                 | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65244e01ae325ca4c4efcef7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/riscv/defconfig/gcc-10/lab-baylibre/baseline-qemu_risc=
v64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/riscv/defconfig/gcc-10/lab-baylibre/baseline-qemu_risc=
v64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/riscv/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65244e01ae325ca4c4efc=
ef8
        failing since 4 days (last pass: v5.10.186, first fail: v5.10.197-1=
68-g3eccb060a778) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_smp8_riscv64            | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65244e029adc9e3fc2efcef7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/riscv/defconfig/gcc-10/lab-baylibre/baseline-qemu_smp8=
_riscv64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/riscv/defconfig/gcc-10/lab-baylibre/baseline-qemu_smp8=
_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/riscv/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65244e029adc9e3fc2efc=
ef8
        failing since 4 days (last pass: v5.10.186, first fail: v5.10.197-1=
68-g3eccb060a778) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64                  | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/65244f54ecae048b50efcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-q=
emu_x86_64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-q=
emu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65244f54ecae048b50efc=
ef4
        failing since 4 days (last pass: v5.10.186, first fail: v5.10.197-1=
68-g3eccb060a778) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64                  | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652450d0838ac2ea67efcf19

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-bayl=
ibre/baseline-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-bayl=
ibre/baseline-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652450d0838ac2ea67efc=
f1a
        failing since 4 days (last pass: v5.10.186, first fail: v5.10.197-1=
68-g3eccb060a778) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi             | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/65244f550481f35abcefcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-q=
emu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-q=
emu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65244f550481f35abcefc=
ef4
        failing since 4 days (last pass: v5.10.186, first fail: v5.10.197-1=
68-g3eccb060a778) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi             | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652450d1838ac2ea67efcf27

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-bayl=
ibre/baseline-qemu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-bayl=
ibre/baseline-qemu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652450d1838ac2ea67efc=
f28
        failing since 4 days (last pass: v5.10.186, first fail: v5.10.197-1=
68-g3eccb060a778) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/65244f560481f35abcefcef6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-q=
emu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-q=
emu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65244f560481f35abcefc=
ef7
        failing since 4 days (last pass: v5.10.186, first fail: v5.10.197-1=
68-g3eccb060a778) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652450d22791865420efcf3f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-bayl=
ibre/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-bayl=
ibre/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652450d22791865420efc=
f40
        failing since 4 days (last pass: v5.10.186, first fail: v5.10.197-1=
68-g3eccb060a778) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/652454b411b14c6138efcefe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hihop=
e-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hihop=
e-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652454b411b14c6138efc=
eff
        new failure (last pass: v5.10.194-407-g794568ce435b) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/652457a42c46323654efcf12

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652457a42c46323654efc=
f13
        failing since 4 days (last pass: v5.10.197, first fail: v5.10.197-1=
68-g3eccb060a778) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/652456b53a2dd43b47efcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652456b53a2dd43b47efc=
ef4
        failing since 4 days (last pass: v5.10.197, first fail: v5.10.197-1=
68-g3eccb060a778) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/652454fc11b14c6138efcf21

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652454fc11b14c6138efc=
f22
        failing since 4 days (last pass: v5.10.195-84-gf147286de8e5, first =
fail: v5.10.197-168-g3eccb060a778) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/652456ca3a2dd43b47efceff

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652456ca3a2dd43b47efc=
f00
        failing since 4 days (last pass: v5.10.197, first fail: v5.10.197-1=
68-g3eccb060a778) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6524539a69c1377d1defcf30

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6524539a69c1377d1defcf39
        failing since 83 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-10-09T19:29:27.102826  / # #

    2023-10-09T19:29:27.205096  export SHELL=3D/bin/sh

    2023-10-09T19:29:27.205818  #

    2023-10-09T19:29:27.307275  / # export SHELL=3D/bin/sh. /lava-11714029/=
environment

    2023-10-09T19:29:27.308075  =


    2023-10-09T19:29:27.409480  / # . /lava-11714029/environment/lava-11714=
029/bin/lava-test-runner /lava-11714029/1

    2023-10-09T19:29:27.410654  =


    2023-10-09T19:29:27.426874  / # /lava-11714029/bin/lava-test-runner /la=
va-11714029/1

    2023-10-09T19:29:27.476066  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-09T19:29:27.476560  + cd /lav<8>[   16.465896] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11714029_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/652453dfdd50f85a96efcf45

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-r=
ock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-r=
ock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652453dfdd50f85a96efcf4e
        failing since 46 days (last pass: v5.10.191, first fail: v5.10.190-=
136-gda59b7b5c515e)

    2023-10-09T19:25:50.953609  / # #

    2023-10-09T19:25:52.214867  export SHELL=3D/bin/sh

    2023-10-09T19:25:52.225775  #

    2023-10-09T19:25:52.226216  / # export SHELL=3D/bin/sh

    2023-10-09T19:25:53.969619  / # . /lava-11714036/environment

    2023-10-09T19:25:57.171746  /lava-11714036/bin/lava-test-runner /lava-1=
1714036/1

    2023-10-09T19:25:57.182601  . /lava-11714036/environment

    2023-10-09T19:25:57.187814  / # /lava-11714036/bin/lava-test-runner /la=
va-11714036/1

    2023-10-09T19:25:57.236436  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-09T19:25:57.236791  + cd /lava-11714036/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/652453afcb6929122fefcf1b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97-227-g18c65c1b4996/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652453afcb6929122fefcf24
        failing since 83 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-10-09T19:29:43.861573  / # #

    2023-10-09T19:29:43.962714  export SHELL=3D/bin/sh

    2023-10-09T19:29:43.963413  #

    2023-10-09T19:29:44.064833  / # export SHELL=3D/bin/sh. /lava-11714039/=
environment

    2023-10-09T19:29:44.065534  =


    2023-10-09T19:29:44.166963  / # . /lava-11714039/environment/lava-11714=
039/bin/lava-test-runner /lava-11714039/1

    2023-10-09T19:29:44.168071  =


    2023-10-09T19:29:44.170759  / # /lava-11714039/bin/lava-test-runner /la=
va-11714039/1

    2023-10-09T19:29:44.212316  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-09T19:29:44.245898  + cd /lava-1171403<8>[   18.206579] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11714039_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
