Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15733779407
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 18:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjHKQMU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 12:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbjHKQMU (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 12:12:20 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606812683
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 09:12:18 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-686ba97e4feso1967411b3a.0
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 09:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691770337; x=1692375137;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=COfQ8JfHHySC4zk1MPMwmCztbwz0Tmhn1ZGenD/1bF8=;
        b=4vXycP9ZIjWhmxLBmNhtF3axC3NMG1afVNMuy8ek26+LdFiZZnpwnm5eHxlCc42j23
         eeIxPT6WIMV5x4iMnoA0Z7Yzaka3xvJI2TG3FxXA3Lv86ik2PGHvL6UqluPf9eXKdLCz
         eUIEGiFC3fAMTzzSUf+H+A54p6rjPxW68OQnyLMNuzNs2C3+ZY8G/HwvZcDJuzjFDKxz
         tLrA1vuGf5MUELhaj2tgZl08Z7VNX66ToyqrxUpJY9kziHAsjluAU7MIqanszCbewO4v
         5xnhzVfHwMyLSGuT/oOwvfYiyOLtwyVjvRFd8pQ8y2HTuO9Slvk/Bc5Lcl2L+1LAMqR8
         tnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691770337; x=1692375137;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COfQ8JfHHySC4zk1MPMwmCztbwz0Tmhn1ZGenD/1bF8=;
        b=YHr4HvVh1QKuX2OWI2bWf9V1U39hRCOqIpGA7e735mtW3Mjw8j5zlSD4NUzhgUKF9G
         Q72wPQd20gxCbJpFblMw3pcPGXV7k4AxsG5oFUjix869GPUxTrJjcb2/EGYpJN3cUNCI
         qx6KrtfXvGNzWGEj0Etlo1YMWV2f+IZaxItcPS4y/H/yYbIC2rHbc7VGHyqX5aR/ZRS8
         Hc9OBZ2AmLm8yIzlIBis1qsGN8irE4qGh2wajj8OTSOmvZxehz+zMxmoMVCTD527cbio
         D4bWsRmdfDASwu+5GfZMYTeSpAnGlJwbci686nP4bE8Q7kyadOGN7VGDDbPdpElY5wrI
         B8kQ==
X-Gm-Message-State: AOJu0YyaUV2ebAVF9aUzos+NcWd2MWEKB4vl7/8fYiLrmzfG0ZWeWv0n
        tPunHnelBt2ORGGDKXLbxLN9T3UYR+tr3cn5IILOLA==
X-Google-Smtp-Source: AGHT+IFKP1PjwzbrJZSlvSMptj0h33A8GwpaEc0NyOIP5Wjnly465YZo7d8UlasvoQnCL2kr+15HiQ==
X-Received: by 2002:a05:6a21:7903:b0:130:d234:c914 with SMTP id bg3-20020a056a21790300b00130d234c914mr2545533pzc.26.1691770337032;
        Fri, 11 Aug 2023 09:12:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k135-20020a636f8d000000b0054f9936accesm3605024pgc.55.2023.08.11.09.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 09:12:16 -0700 (PDT)
Message-ID: <64d65de0.630a0220.b300b.76c7@mx.google.com>
Date:   Fri, 11 Aug 2023 09:12:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.125-92-g943befa9b5e0
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.15.y
Subject: stable-rc/linux-5.15.y baseline: 122 runs,
 13 regressions (v5.15.125-92-g943befa9b5e0)
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

stable-rc/linux-5.15.y baseline: 122 runs, 13 regressions (v5.15.125-92-g94=
3befa9b5e0)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.125-92-g943befa9b5e0/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.125-92-g943befa9b5e0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      943befa9b5e033766840c1d8959844bbba920e7e =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d6282a5e6eb9d19335b1d9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-92-g943befa9b5e0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-92-g943befa9b5e0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d6282a5e6eb9d19335b1de
        failing since 135 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-11T12:22:48.015860  <8>[   11.130564] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11262989_1.4.2.3.1>

    2023-08-11T12:22:48.019078  + set +x

    2023-08-11T12:22:48.128511  / # #

    2023-08-11T12:22:48.230852  export SHELL=3D/bin/sh

    2023-08-11T12:22:48.231499  #

    2023-08-11T12:22:48.332969  / # export SHELL=3D/bin/sh. /lava-11262989/=
environment

    2023-08-11T12:22:48.333751  =


    2023-08-11T12:22:48.435222  / # . /lava-11262989/environment/lava-11262=
989/bin/lava-test-runner /lava-11262989/1

    2023-08-11T12:22:48.436531  =


    2023-08-11T12:22:48.442937  / # /lava-11262989/bin/lava-test-runner /la=
va-11262989/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62804c1c0d9cfbd35b1df

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-92-g943befa9b5e0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-92-g943befa9b5e0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d62804c1c0d9cfbd35b1e4
        failing since 135 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-11T12:22:10.805426  <8>[   11.236125] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11262993_1.4.2.3.1>

    2023-08-11T12:22:10.809155  + set +x

    2023-08-11T12:22:10.915046  =


    2023-08-11T12:22:11.016801  / # #export SHELL=3D/bin/sh

    2023-08-11T12:22:11.017043  =


    2023-08-11T12:22:11.117636  / # export SHELL=3D/bin/sh. /lava-11262993/=
environment

    2023-08-11T12:22:11.118371  =


    2023-08-11T12:22:11.219814  / # . /lava-11262993/environment/lava-11262=
993/bin/lava-test-runner /lava-11262993/1

    2023-08-11T12:22:11.221326  =


    2023-08-11T12:22:11.225891  / # /lava-11262993/bin/lava-test-runner /la=
va-11262993/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62a70dfdb24d3d835b1d9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-92-g943befa9b5e0/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-92-g943befa9b5e0/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d62a70dfdb24d3d835b=
1da
        failing since 16 days (last pass: v5.15.120, first fail: v5.15.122-=
79-g3bef1500d246a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62d5de41d798f2435b256

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-92-g943befa9b5e0/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-92-g943befa9b5e0/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d62d5de41d798f2435b25b
        failing since 206 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-08-11T12:45:09.667970  <8>[   10.033413] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3737076_1.5.2.4.1>
    2023-08-11T12:45:09.778606  / # #
    2023-08-11T12:45:09.881892  export SHELL=3D/bin/sh
    2023-08-11T12:45:09.882885  #
    2023-08-11T12:45:09.985058  / # export SHELL=3D/bin/sh. /lava-3737076/e=
nvironment
    2023-08-11T12:45:09.986012  =

    2023-08-11T12:45:10.088416  / # . /lava-3737076/environment/lava-373707=
6/bin/lava-test-runner /lava-3737076/1
    2023-08-11T12:45:10.090155  =

    2023-08-11T12:45:10.095478  / # /lava-3737076/bin/lava-test-runner /lav=
a-3737076/1
    2023-08-11T12:45:10.183789  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62a5144168fe8df35b1da

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-92-g943befa9b5e0/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-92-g943befa9b5e0/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d62a5144168fe8df35b1dd
        failing since 28 days (last pass: v5.15.67, first fail: v5.15.119-1=
6-g66130849c020f)

    2023-08-11T12:32:06.426173  [   11.196873] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1242843_1.5.2.4.1>
    2023-08-11T12:32:06.531275  =

    2023-08-11T12:32:06.632459  / # #export SHELL=3D/bin/sh
    2023-08-11T12:32:06.632861  =

    2023-08-11T12:32:06.733816  / # export SHELL=3D/bin/sh. /lava-1242843/e=
nvironment
    2023-08-11T12:32:06.734254  =

    2023-08-11T12:32:06.835191  / # . /lava-1242843/environment/lava-124284=
3/bin/lava-test-runner /lava-1242843/1
    2023-08-11T12:32:06.835914  =

    2023-08-11T12:32:06.839069  / # /lava-1242843/bin/lava-test-runner /lav=
a-1242843/1
    2023-08-11T12:32:06.856676  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62a5444168fe8df35b1f0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-92-g943befa9b5e0/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-92-g943befa9b5e0/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d62a5444168fe8df35b1f3
        failing since 160 days (last pass: v5.15.79, first fail: v5.15.98)

    2023-08-11T12:32:06.381984  [   10.240609] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1242844_1.5.2.4.1>
    2023-08-11T12:32:06.487220  =

    2023-08-11T12:32:06.588373  / # #export SHELL=3D/bin/sh
    2023-08-11T12:32:06.588769  =

    2023-08-11T12:32:06.689702  / # export SHELL=3D/bin/sh. /lava-1242844/e=
nvironment
    2023-08-11T12:32:06.690099  =

    2023-08-11T12:32:06.791057  / # . /lava-1242844/environment/lava-124284=
4/bin/lava-test-runner /lava-1242844/1
    2023-08-11T12:32:06.791736  =

    2023-08-11T12:32:06.794634  / # /lava-1242844/bin/lava-test-runner /lav=
a-1242844/1
    2023-08-11T12:32:06.810926  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62974eea6f7435435b1f5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-92-g943befa9b5e0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-92-g943befa9b5e0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d62974eea6f7435435b=
1f6
        new failure (last pass: v5.15.125-93-gae7f23cbf199) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d6281705b2e33f9335b213

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-92-g943befa9b5e0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-92-g943befa9b5e0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d6281705b2e33f9335b218
        failing since 135 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-11T12:22:26.930088  + set +x

    2023-08-11T12:22:26.936883  <8>[   10.506462] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11262991_1.4.2.3.1>

    2023-08-11T12:22:27.038730  =


    2023-08-11T12:22:27.139355  / # #export SHELL=3D/bin/sh

    2023-08-11T12:22:27.139579  =


    2023-08-11T12:22:27.240119  / # export SHELL=3D/bin/sh. /lava-11262991/=
environment

    2023-08-11T12:22:27.240355  =


    2023-08-11T12:22:27.340904  / # . /lava-11262991/environment/lava-11262=
991/bin/lava-test-runner /lava-11262991/1

    2023-08-11T12:22:27.341264  =


    2023-08-11T12:22:27.346102  / # /lava-11262991/bin/lava-test-runner /la=
va-11262991/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62811eaa64c239c35b1f5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-92-g943befa9b5e0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-92-g943befa9b5e0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d62811eaa64c239c35b1fa
        failing since 135 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-11T12:22:21.233224  + <8>[   10.915968] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11262981_1.4.2.3.1>

    2023-08-11T12:22:21.233794  set +x

    2023-08-11T12:22:21.341638  / # #

    2023-08-11T12:22:21.444008  export SHELL=3D/bin/sh

    2023-08-11T12:22:21.444867  #

    2023-08-11T12:22:21.546277  / # export SHELL=3D/bin/sh. /lava-11262981/=
environment

    2023-08-11T12:22:21.546567  =


    2023-08-11T12:22:21.647534  / # . /lava-11262981/environment/lava-11262=
981/bin/lava-test-runner /lava-11262981/1

    2023-08-11T12:22:21.648718  =


    2023-08-11T12:22:21.654028  / # /lava-11262981/bin/lava-test-runner /la=
va-11262981/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d6280f77e661dde235b206

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-92-g943befa9b5e0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-92-g943befa9b5e0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d6280f77e661dde235b20b
        failing since 135 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-11T12:22:25.644392  + set<8>[   12.722165] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11263005_1.4.2.3.1>

    2023-08-11T12:22:25.644501   +x

    2023-08-11T12:22:25.749101  / # #

    2023-08-11T12:22:25.849740  export SHELL=3D/bin/sh

    2023-08-11T12:22:25.849897  #

    2023-08-11T12:22:25.950354  / # export SHELL=3D/bin/sh. /lava-11263005/=
environment

    2023-08-11T12:22:25.950514  =


    2023-08-11T12:22:26.050984  / # . /lava-11263005/environment/lava-11263=
005/bin/lava-test-runner /lava-11263005/1

    2023-08-11T12:22:26.051289  =


    2023-08-11T12:22:26.056095  / # /lava-11263005/bin/lava-test-runner /la=
va-11263005/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62b2ff3ce0bb93e35b1f4

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-92-g943befa9b5e0/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-92-g943befa9b5e0/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d62b2ff3ce0bb93e35b1f9
        failing since 22 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-08-11T12:37:18.637857  / # #

    2023-08-11T12:37:18.740207  export SHELL=3D/bin/sh

    2023-08-11T12:37:18.741029  #

    2023-08-11T12:37:18.842505  / # export SHELL=3D/bin/sh. /lava-11263048/=
environment

    2023-08-11T12:37:18.843295  =


    2023-08-11T12:37:18.944793  / # . /lava-11263048/environment/lava-11263=
048/bin/lava-test-runner /lava-11263048/1

    2023-08-11T12:37:18.946056  =


    2023-08-11T12:37:18.961843  / # /lava-11263048/bin/lava-test-runner /la=
va-11263048/1

    2023-08-11T12:37:19.011620  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-11T12:37:19.012144  + cd /lav<8>[   16.000909] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11263048_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62a13ceaa2b03f235b1da

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-92-g943befa9b5e0/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-92-g943befa9b5e0/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d62a13ceaa2b03f235b1df
        failing since 22 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-08-11T12:31:36.934238  / # #

    2023-08-11T12:31:38.014952  export SHELL=3D/bin/sh

    2023-08-11T12:31:38.016942  #

    2023-08-11T12:31:39.508204  / # export SHELL=3D/bin/sh. /lava-11263057/=
environment

    2023-08-11T12:31:39.510189  =


    2023-08-11T12:31:42.234821  / # . /lava-11263057/environment/lava-11263=
057/bin/lava-test-runner /lava-11263057/1

    2023-08-11T12:31:42.237077  =


    2023-08-11T12:31:42.241330  / # /lava-11263057/bin/lava-test-runner /la=
va-11263057/1

    2023-08-11T12:31:42.307039  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-11T12:31:42.307555  + cd /lav<8>[   25.507540] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11263057_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62a0540e68b965d35b1f8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-92-g943befa9b5e0/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-92-g943befa9b5e0/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d62a0540e68b965d35b1fd
        failing since 22 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-08-11T12:32:26.039395  / # #

    2023-08-11T12:32:26.141539  export SHELL=3D/bin/sh

    2023-08-11T12:32:26.142244  #

    2023-08-11T12:32:26.243640  / # export SHELL=3D/bin/sh. /lava-11263058/=
environment

    2023-08-11T12:32:26.244348  =


    2023-08-11T12:32:26.345807  / # . /lava-11263058/environment/lava-11263=
058/bin/lava-test-runner /lava-11263058/1

    2023-08-11T12:32:26.346875  =


    2023-08-11T12:32:26.363633  / # /lava-11263058/bin/lava-test-runner /la=
va-11263058/1

    2023-08-11T12:32:26.422661  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-11T12:32:26.423162  + cd /lava-1126305<8>[   16.845619] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11263058_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
