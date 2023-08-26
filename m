Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B81B7898EB
	for <lists+stable@lfdr.de>; Sat, 26 Aug 2023 22:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjHZUFX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 26 Aug 2023 16:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjHZUFN (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 26 Aug 2023 16:05:13 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7B1171A
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 13:05:09 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1c4c5375329so1396254fac.2
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 13:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693080307; x=1693685107;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v1MkCjsLCx/2JXjo61mH6Wz+Eh5HwCLyBrYJ5hHN52I=;
        b=QtK99MpFmQb6Llg12GBGupIpWSBZ0IgvFGx6X5m4i5A2vopfRqfAFLIl6w65I1tr1Z
         IQx3CzaKwCljexKDuKMeviz24SBtURs6HeApmuxM5s9PShcnj2MGnb47rAtRlZq0FuQm
         x8wPFg3uY9W9bm5/Wig98AAespCZXEomXBZV33QVhPzGdWSbE8DrSXcVU/NnEQ6ufyeE
         bRBBDWdXwTVS1BvSvozEftad+6Kndk454ZxTUYFf45AcEpIYj4s19Zt5kxgc+f9dtSUK
         1iXTA4K47ZL3BEJsqQUv7I/QGNxd3Qew3xg0NBK0r14CVnjzab+UsOh9Re33gh0qtCE+
         B56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693080307; x=1693685107;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v1MkCjsLCx/2JXjo61mH6Wz+Eh5HwCLyBrYJ5hHN52I=;
        b=X46JZ8ExXXV+eTgXK7xuu89WHtef5GQh/ILd0eNFVq4cU7cC0KDDDhibVoK/O8h27w
         mNFJl+1mbKu1Oh5Nj1yyzhYtLFhSLmvRTzdYNNfg8iXB4TsyK5uPwlQpT2OnSOo0yQuB
         8ZnTnI+9+hswfV270RHkQuGSaUyPNdxi5SqmoFpEtXjJkMXAR7drOdno04orJ3g/Xqhi
         RHmdmWl5zCueLtXHHq5SCkTBu9S1n2aEgNKGRBSzJS7IvP7aF7qb6zUPAlTaK18sFICy
         7YjD86XS+s0H7dnT9M2JDKuin480epVfs1/QZveKdLE6VgWXn+jfPU3b4qcZg7JeJb5Y
         vdZA==
X-Gm-Message-State: AOJu0YwVaxD/dHwGj9yH4HTktPWYTSfiMj3OROZfFNKyvqxOCN7YAjMw
        K84mzBLMfiBia9k6m7QrHTEJMeBvZ30LL9gF34o=
X-Google-Smtp-Source: AGHT+IHfnqY/2pf/maupBgkQWQNk4aNP5yHLjJCbfQTeqOYT1Vti1vlXkrBQivc9kuSMGB7cNrvOcA==
X-Received: by 2002:a05:6870:818f:b0:1bf:acf:c1bf with SMTP id k15-20020a056870818f00b001bf0acfc1bfmr7402787oae.38.1693080306744;
        Sat, 26 Aug 2023 13:05:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ne11-20020a17090b374b00b0026fb228fafasm289801pjb.18.2023.08.26.13.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 13:05:06 -0700 (PDT)
Message-ID: <64ea5af2.170a0220.ae8b9.06c6@mx.google.com>
Date:   Sat, 26 Aug 2023 13:05:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.128
Subject: stable-rc/linux-5.15.y baseline: 122 runs, 12 regressions (v5.15.128)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.15.y baseline: 122 runs, 12 regressions (v5.15.128)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

beagle-xm                 | arm    | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig          | 1          =

cubietruck                | arm    | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig           | 1          =

fsl-ls2088a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =

fsl-lx2160a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =

hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

r8a77960-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.128/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.128
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      5ddfe5cc87167343bd4c17f776de7b7aa1475b0c =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea2574476fda8b3b286d6c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea2574476fda8b3b286d71
        failing since 150 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-26T16:17:40.954056  <8>[   10.963890] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11363543_1.4.2.3.1>

    2023-08-26T16:17:40.957741  + set +x

    2023-08-26T16:17:41.059245  #

    2023-08-26T16:17:41.059544  =


    2023-08-26T16:17:41.160167  / # #export SHELL=3D/bin/sh

    2023-08-26T16:17:41.160379  =


    2023-08-26T16:17:41.260918  / # export SHELL=3D/bin/sh. /lava-11363543/=
environment

    2023-08-26T16:17:41.261113  =


    2023-08-26T16:17:41.361652  / # . /lava-11363543/environment/lava-11363=
543/bin/lava-test-runner /lava-11363543/1

    2023-08-26T16:17:41.361979  =

 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea257e476fda8b3b286d7f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea257e476fda8b3b286d84
        failing since 150 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-26T16:16:47.271251  <8>[   10.884262] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11363553_1.4.2.3.1>

    2023-08-26T16:16:47.274433  + set +x

    2023-08-26T16:16:47.376216  #

    2023-08-26T16:16:47.376502  =


    2023-08-26T16:16:47.477096  / # #export SHELL=3D/bin/sh

    2023-08-26T16:16:47.477309  =


    2023-08-26T16:16:47.577811  / # export SHELL=3D/bin/sh. /lava-11363553/=
environment

    2023-08-26T16:16:47.577988  =


    2023-08-26T16:16:47.678547  / # . /lava-11363553/environment/lava-11363=
553/bin/lava-test-runner /lava-11363553/1

    2023-08-26T16:16:47.678818  =

 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beagle-xm                 | arm    | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea2b0e78dadca871286d73

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ea2b0e78dadca871286=
d74
        failing since 32 days (last pass: v5.15.120, first fail: v5.15.122-=
79-g3bef1500d246a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
cubietruck                | arm    | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea2621653ffff245286d6f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea2621653ffff245286d74
        failing since 221 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-08-26T16:19:32.138553  <8>[    9.968926] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3751347_1.5.2.4.1>
    2023-08-26T16:19:32.245553  / # #
    2023-08-26T16:19:32.347226  export SHELL=3D/bin/sh
    2023-08-26T16:19:32.347650  #
    2023-08-26T16:19:32.448948  / # export SHELL=3D/bin/sh. /lava-3751347/e=
nvironment
    2023-08-26T16:19:32.449386  =

    2023-08-26T16:19:32.550499  / # . /lava-3751347/environment/lava-375134=
7/bin/lava-test-runner /lava-3751347/1
    2023-08-26T16:19:32.551093  =

    2023-08-26T16:19:32.556354  / # /lava-3751347/bin/lava-test-runner /lav=
a-3751347/1
    2023-08-26T16:19:32.602044  <3>[   10.434096] Bluetooth: hci0: command =
0x0c03 tx timeout =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
fsl-ls2088a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea23cf4e0d7b7854286d6d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea23cf4e0d7b7854286d74
        failing since 43 days (last pass: v5.15.67, first fail: v5.15.119-1=
6-g66130849c020f)

    2023-08-26T16:09:29.635214  + [   11.380421] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1246771_1.5.2.4.1>
    2023-08-26T16:09:29.635528  set +x
    2023-08-26T16:09:29.741581  =

    2023-08-26T16:09:29.842873  / # #export SHELL=3D/bin/sh
    2023-08-26T16:09:29.843312  =

    2023-08-26T16:09:29.944345  / # export SHELL=3D/bin/sh. /lava-1246771/e=
nvironment
    2023-08-26T16:09:29.944854  =

    2023-08-26T16:09:30.046047  / # . /lava-1246771/environment/lava-124677=
1/bin/lava-test-runner /lava-1246771/1
    2023-08-26T16:09:30.046802  =

    2023-08-26T16:09:30.050174  / # /lava-1246771/bin/lava-test-runner /lav=
a-1246771/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
fsl-lx2160a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea23f62377a2e1d3286ddf

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea23f62377a2e1d3286de6
        failing since 175 days (last pass: v5.15.79, first fail: v5.15.98)

    2023-08-26T16:10:05.445010  [   10.568191] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1246770_1.5.2.4.1>
    2023-08-26T16:10:05.552351  / # #
    2023-08-26T16:10:05.653958  export SHELL=3D/bin/sh
    2023-08-26T16:10:05.654490  #
    2023-08-26T16:10:05.755698  / # export SHELL=3D/bin/sh. /lava-1246770/e=
nvironment
    2023-08-26T16:10:05.756161  =

    2023-08-26T16:10:05.857305  / # . /lava-1246770/environment/lava-124677=
0/bin/lava-test-runner /lava-1246770/1
    2023-08-26T16:10:05.858042  =

    2023-08-26T16:10:05.862017  / # /lava-1246770/bin/lava-test-runner /lav=
a-1246770/1
    2023-08-26T16:10:05.876861  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea2569934895e9e2286d82

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea2569934895e9e2286d87
        failing since 150 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-26T16:16:23.296652  <8>[   10.580933] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11363573_1.4.2.3.1>

    2023-08-26T16:16:23.300232  + set +x

    2023-08-26T16:16:23.408029  / # #

    2023-08-26T16:16:23.510427  export SHELL=3D/bin/sh

    2023-08-26T16:16:23.511150  #

    2023-08-26T16:16:23.612587  / # export SHELL=3D/bin/sh. /lava-11363573/=
environment

    2023-08-26T16:16:23.613373  =


    2023-08-26T16:16:23.714874  / # . /lava-11363573/environment/lava-11363=
573/bin/lava-test-runner /lava-11363573/1

    2023-08-26T16:16:23.716168  =


    2023-08-26T16:16:23.721101  / # /lava-11363573/bin/lava-test-runner /la=
va-11363573/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea256ed3779bd59b286da3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea256ed3779bd59b286da8
        failing since 150 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-26T16:16:32.699055  + set<8>[   11.310387] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11363558_1.4.2.3.1>

    2023-08-26T16:16:32.699622   +x

    2023-08-26T16:16:32.807633  / # #

    2023-08-26T16:16:32.910341  export SHELL=3D/bin/sh

    2023-08-26T16:16:32.911139  #

    2023-08-26T16:16:33.012943  / # export SHELL=3D/bin/sh. /lava-11363558/=
environment

    2023-08-26T16:16:33.013748  =


    2023-08-26T16:16:33.115423  / # . /lava-11363558/environment/lava-11363=
558/bin/lava-test-runner /lava-11363558/1

    2023-08-26T16:16:33.116752  =


    2023-08-26T16:16:33.121868  / # /lava-11363558/bin/lava-test-runner /la=
va-11363558/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea2566934895e9e2286d6c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-len=
ovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-len=
ovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea2566934895e9e2286d71
        failing since 150 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-26T16:16:24.722420  <8>[   11.653752] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11363539_1.4.2.3.1>

    2023-08-26T16:16:24.827133  / # #

    2023-08-26T16:16:24.927896  export SHELL=3D/bin/sh

    2023-08-26T16:16:24.928123  #

    2023-08-26T16:16:25.028793  / # export SHELL=3D/bin/sh. /lava-11363539/=
environment

    2023-08-26T16:16:25.029035  =


    2023-08-26T16:16:25.129838  / # . /lava-11363539/environment/lava-11363=
539/bin/lava-test-runner /lava-11363539/1

    2023-08-26T16:16:25.130981  =


    2023-08-26T16:16:25.135973  / # /lava-11363539/bin/lava-test-runner /la=
va-11363539/1

    2023-08-26T16:16:25.141713  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a77960-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea23983e6e0f5bbc286e78

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea23983e6e0f5bbc286e7d
        failing since 37 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-08-26T16:10:13.252223  / # #

    2023-08-26T16:10:13.354061  export SHELL=3D/bin/sh

    2023-08-26T16:10:13.354724  #

    2023-08-26T16:10:13.455814  / # export SHELL=3D/bin/sh. /lava-11363474/=
environment

    2023-08-26T16:10:13.456496  =


    2023-08-26T16:10:13.557816  / # . /lava-11363474/environment/lava-11363=
474/bin/lava-test-runner /lava-11363474/1

    2023-08-26T16:10:13.558810  =


    2023-08-26T16:10:13.559978  / # /lava-11363474/bin/lava-test-runner /la=
va-11363474/1

    2023-08-26T16:10:13.624332  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-26T16:10:13.624928  + cd /lav<8>[   15.966532] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11363474_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea23ac157ea5d453286de5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea23ac157ea5d453286dea
        failing since 37 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-08-26T16:09:06.240559  / # #

    2023-08-26T16:09:07.319854  export SHELL=3D/bin/sh

    2023-08-26T16:09:07.321805  #

    2023-08-26T16:09:08.812229  / # export SHELL=3D/bin/sh. /lava-11363484/=
environment

    2023-08-26T16:09:08.813994  =


    2023-08-26T16:09:11.537501  / # . /lava-11363484/environment/lava-11363=
484/bin/lava-test-runner /lava-11363484/1

    2023-08-26T16:09:11.539767  =


    2023-08-26T16:09:11.548609  / # /lava-11363484/bin/lava-test-runner /la=
va-11363484/1

    2023-08-26T16:09:11.610352  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-26T16:09:11.610842  + cd /lava-113634<8>[   25.490146] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11363484_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea23993e6e0f5bbc286e86

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea23993e6e0f5bbc286e8b
        failing since 37 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-08-26T16:10:24.597448  / # #

    2023-08-26T16:10:24.699546  export SHELL=3D/bin/sh

    2023-08-26T16:10:24.700246  #

    2023-08-26T16:10:24.801700  / # export SHELL=3D/bin/sh. /lava-11363476/=
environment

    2023-08-26T16:10:24.802401  =


    2023-08-26T16:10:24.903820  / # . /lava-11363476/environment/lava-11363=
476/bin/lava-test-runner /lava-11363476/1

    2023-08-26T16:10:24.904868  =


    2023-08-26T16:10:24.906545  / # /lava-11363476/bin/lava-test-runner /la=
va-11363476/1

    2023-08-26T16:10:24.981343  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-26T16:10:24.981844  + cd /lava-1136347<8>[   16.838505] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11363476_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
