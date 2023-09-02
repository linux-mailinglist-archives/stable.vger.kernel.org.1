Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D60779079C
	for <lists+stable@lfdr.de>; Sat,  2 Sep 2023 13:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjIBLpK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 2 Sep 2023 07:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjIBLpJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 2 Sep 2023 07:45:09 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D848E
        for <stable@vger.kernel.org>; Sat,  2 Sep 2023 04:45:03 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bf48546ccfso18790955ad.2
        for <stable@vger.kernel.org>; Sat, 02 Sep 2023 04:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693655102; x=1694259902; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2m1lz2vYY0SzIXzAMmcHu3KcPQBuPC5vzwdIM4d5qJQ=;
        b=Z/8AkjniTi0QJjN1uBpuibodaK66yCVuKNVHAKWOaU/gdaRtqj//Nz8b4Dcecp64vm
         hBXzcjEDvz1JnrRD01rymT8JufTeEw0jtBzm0buxpsRpCVFtBYuvlTjv4RMN/RPgm//o
         SVgBhc0FELNNK/izAM2oxApe58CuoL21jGcEpNqf39m8IBOHpilAlWKpuEnZFaHcfRAx
         ERO6oSRR8aqGUf0xXurxoiE7cyXMvmdNw4By5DPaH/tS9N3AEHKAsovO+JbRNKCp2kkQ
         /gfRDlDAdzDA7+DlMhd6LjxXyBmWYNcGQUwrZ2vjbWEosLxPMSMmDzi5T78fhxKa693s
         eHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693655102; x=1694259902;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2m1lz2vYY0SzIXzAMmcHu3KcPQBuPC5vzwdIM4d5qJQ=;
        b=cDYwdD1DQag1Ep3yyebTOU2c1+s5nY2uHqjk0E1AKpU235fwGX9eQm1hLJxyE6671D
         Jm35vY/nGpGL5AG8ASyYjH2WdUdxaKJmSc3lCCfGZPZX3JRLKpQMlg3net3iuiFQN7Cc
         3Xl0xsVS1WX/UhtHOh/HHOcKxqibmPMF8XsOyBko16VIxLukLRyX9a3poVvgSjNO3q8L
         fuzjJMtptgD7hDKy7s8LHdXlc0kZkXCEIu7SBmj0m+QFc+mi/Oupcj6fJ2wBspEWJr0j
         SQ6UGy4BeJ0aUE94La0Gaa/z5Gd6V5elMWVY4QX7N+jXDoVyC09qkXoKrIfjShoH6FI+
         RHMg==
X-Gm-Message-State: AOJu0YyZOQgFDsGwuKm7NjEpn+eZ0GXhAchfP2FY6DDnoDxKjnMTqW15
        KBXZdZI6UeTX22zErgs2yTG2gE1112exQ8PXf1A=
X-Google-Smtp-Source: AGHT+IE5WR0VbXpZzvTcmVP/f6AWnhmTdoi3y5643JrOZdpccgr2cBVfH917bhIcaISggMIOis076w==
X-Received: by 2002:a17:902:b490:b0:1c1:e52e:49e3 with SMTP id y16-20020a170902b49000b001c1e52e49e3mr4551700plr.36.1693655101791;
        Sat, 02 Sep 2023 04:45:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ja19-20020a170902efd300b001b9c960ffeasm4500877plb.47.2023.09.02.04.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 04:45:01 -0700 (PDT)
Message-ID: <64f3203d.170a0220.7a215.9712@mx.google.com>
Date:   Sat, 02 Sep 2023 04:45:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.130
Subject: stable/linux-5.15.y baseline: 185 runs, 33 regressions (v5.15.130)
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

stable/linux-5.15.y baseline: 185 runs, 33 regressions (v5.15.130)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

fsl-ls1028a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g+kselftest          | 1          =

fsl-ls1088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g+kselftest          | 1          =

fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g+kselftest          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g+kselftest          | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

meson-g12a-u200              | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+kselftest          | 1          =

meson-g12b-odroid-n2         | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+kselftest          | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+kselftest          | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =

mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.15.y/kernel=
/v5.15.130/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.15.y
  Describe: v5.15.130
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      8f790700c974345ab78054e109beddd84539f319 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2eab0c75cc2f5a1286d7a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2eab0c75cc2f5a1286d83
        failing since 155 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-02T07:56:14.317243  + set +x

    2023-09-02T07:56:14.323863  <8>[   11.801068] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11409051_1.4.2.3.1>

    2023-09-02T07:56:14.431961  / # #

    2023-09-02T07:56:14.534275  export SHELL=3D/bin/sh

    2023-09-02T07:56:14.535040  #

    2023-09-02T07:56:14.636761  / # export SHELL=3D/bin/sh. /lava-11409051/=
environment

    2023-09-02T07:56:14.637546  =


    2023-09-02T07:56:14.739207  / # . /lava-11409051/environment/lava-11409=
051/bin/lava-test-runner /lava-11409051/1

    2023-09-02T07:56:14.740487  =


    2023-09-02T07:56:14.745504  / # /lava-11409051/bin/lava-test-runner /la=
va-11409051/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2eb9d1da735653d286ddc

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2eb9d1da735653d286de5
        failing since 155 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-02T08:01:18.998527  + set +x

    2023-09-02T08:01:19.004671  <8>[   11.080938] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11409083_1.4.2.3.1>

    2023-09-02T08:01:19.107028  =


    2023-09-02T08:01:19.207660  / # #export SHELL=3D/bin/sh

    2023-09-02T08:01:19.207830  =


    2023-09-02T08:01:19.308344  / # export SHELL=3D/bin/sh. /lava-11409083/=
environment

    2023-09-02T08:01:19.308583  =


    2023-09-02T08:01:19.409138  / # . /lava-11409083/environment/lava-11409=
083/bin/lava-test-runner /lava-11409083/1

    2023-09-02T08:01:19.409522  =


    2023-09-02T08:01:19.415221  / # /lava-11409083/bin/lava-test-runner /la=
va-11409083/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2eaaca53294bb18286ddf

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2eaaca53294bb18286de8
        failing since 155 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-02T07:56:03.992180  + <8>[   12.086327] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11409055_1.4.2.3.1>

    2023-09-02T07:56:03.992744  set +x

    2023-09-02T07:56:04.100672  / # #

    2023-09-02T07:56:04.203135  export SHELL=3D/bin/sh

    2023-09-02T07:56:04.203971  #

    2023-09-02T07:56:04.305634  / # export SHELL=3D/bin/sh. /lava-11409055/=
environment

    2023-09-02T07:56:04.306419  =


    2023-09-02T07:56:04.408136  / # . /lava-11409055/environment/lava-11409=
055/bin/lava-test-runner /lava-11409055/1

    2023-09-02T07:56:04.409353  =


    2023-09-02T07:56:04.414621  / # /lava-11409055/bin/lava-test-runner /la=
va-11409055/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2eba9db3aaf3e7b286d7d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2eba9db3aaf3e7b286d82
        failing since 155 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-02T08:00:20.927395  + set<8>[    9.491285] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11409115_1.4.2.3.1>

    2023-09-02T08:00:20.927918   +x

    2023-09-02T08:00:21.035474  / # #

    2023-09-02T08:00:21.137940  export SHELL=3D/bin/sh

    2023-09-02T08:00:21.138758  #

    2023-09-02T08:00:21.240321  / # export SHELL=3D/bin/sh. /lava-11409115/=
environment

    2023-09-02T08:00:21.241046  =


    2023-09-02T08:00:21.342637  / # . /lava-11409115/environment/lava-11409=
115/bin/lava-test-runner /lava-11409115/1

    2023-09-02T08:00:21.343951  =


    2023-09-02T08:00:21.348511  / # /lava-11409115/bin/lava-test-runner /la=
va-11409115/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2ea9e24400d1f96286ddc

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2ea9e24400d1f96286de5
        failing since 155 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-02T07:56:06.257208  <8>[   10.986657] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11409036_1.4.2.3.1>

    2023-09-02T07:56:06.260746  + set +x

    2023-09-02T07:56:06.363147  =


    2023-09-02T07:56:06.464920  / # #export SHELL=3D/bin/sh

    2023-09-02T07:56:06.465256  =


    2023-09-02T07:56:06.566490  / # export SHELL=3D/bin/sh. /lava-11409036/=
environment

    2023-09-02T07:56:06.567295  =


    2023-09-02T07:56:06.669032  / # . /lava-11409036/environment/lava-11409=
036/bin/lava-test-runner /lava-11409036/1

    2023-09-02T07:56:06.670266  =


    2023-09-02T07:56:06.676036  / # /lava-11409036/bin/lava-test-runner /la=
va-11409036/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2eba08c9ddc6811286d70

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2eba08c9ddc6811286d79
        failing since 155 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-02T08:00:15.298349  <8>[   11.307903] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11409099_1.4.2.3.1>

    2023-09-02T08:00:15.301282  + set +x

    2023-09-02T08:00:15.406552  =


    2023-09-02T08:00:15.508122  / # #export SHELL=3D/bin/sh

    2023-09-02T08:00:15.508325  =


    2023-09-02T08:00:15.608901  / # export SHELL=3D/bin/sh. /lava-11409099/=
environment

    2023-09-02T08:00:15.609542  =


    2023-09-02T08:00:15.710837  / # . /lava-11409099/environment/lava-11409=
099/bin/lava-test-runner /lava-11409099/1

    2023-09-02T08:00:15.712007  =


    2023-09-02T08:00:15.717127  / # /lava-11409099/bin/lava-test-runner /la=
va-11409099/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2ec34f5a7ab546b286dbc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2ec34f5a7ab546b286dc5
        failing since 36 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-09-02T08:04:14.292999  / # #

    2023-09-02T08:04:14.395162  export SHELL=3D/bin/sh

    2023-09-02T08:04:14.395863  #

    2023-09-02T08:04:14.497185  / # export SHELL=3D/bin/sh. /lava-11409079/=
environment

    2023-09-02T08:04:14.497899  =


    2023-09-02T08:04:14.599336  / # . /lava-11409079/environment/lava-11409=
079/bin/lava-test-runner /lava-11409079/1

    2023-09-02T08:04:14.600430  =


    2023-09-02T08:04:14.617356  / # /lava-11409079/bin/lava-test-runner /la=
va-11409079/1

    2023-09-02T08:04:14.725099  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-02T08:04:14.725585  + cd /lava-11409079/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2ecff5def908a7c286da0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f2ecff5def908a7c286=
da1
        failing since 149 days (last pass: v5.15.105, first fail: v5.15.106=
) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2eca150c1211bb2286d6c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2eca150c1211bb2286d75
        failing since 226 days (last pass: v5.15.82, first fail: v5.15.89)

    2023-09-02T08:04:26.920421  + set +x<8>[   10.003814] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3760088_1.5.2.4.1>
    2023-09-02T08:04:26.920732  =

    2023-09-02T08:04:27.027420  / # #
    2023-09-02T08:04:27.129203  export SHELL=3D/bin/sh
    2023-09-02T08:04:27.129579  #
    2023-09-02T08:04:27.230873  / # export SHELL=3D/bin/sh. /lava-3760088/e=
nvironment
    2023-09-02T08:04:27.231843  =

    2023-09-02T08:04:27.232453  / # <3>[   10.274249] Bluetooth: hci0: comm=
and 0x0c03 tx timeout
    2023-09-02T08:04:27.334593  . /lava-3760088/environment/lava-3760088/bi=
n/lava-test-runner /lava-3760088/1
    2023-09-02T08:04:27.335311   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2ef247bde45e64e286d80

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm64/defconfig+kselftest/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm64/defconfig+kselftest/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f2ef247bde45e64e286=
d81
        new failure (last pass: v5.15.128) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls1088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2ef267bde45e64e286d97

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm64/defconfig+kselftest/gcc-10/lab-nxp/baseline-fsl-ls1088a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm64/defconfig+kselftest/gcc-10/lab-nxp/baseline-fsl-ls1088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f2ef267bde45e64e286=
d98
        new failure (last pass: v5.15.128) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2eefc224739ebf5286f74

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm64/defconfig+kselftest/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm64/defconfig+kselftest/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f2eefc224739ebf5286=
f75
        new failure (last pass: v5.15.128) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2eaa024400d1f96286dea

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2eaa024400d1f96286df3
        failing since 155 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-02T07:55:55.031978  + set +x

    2023-09-02T07:55:55.038878  <8>[   12.378366] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11409056_1.4.2.3.1>

    2023-09-02T07:55:55.142858  / # #

    2023-09-02T07:55:55.243478  export SHELL=3D/bin/sh

    2023-09-02T07:55:55.243650  #

    2023-09-02T07:55:55.344117  / # export SHELL=3D/bin/sh. /lava-11409056/=
environment

    2023-09-02T07:55:55.344310  =


    2023-09-02T07:55:55.444810  / # . /lava-11409056/environment/lava-11409=
056/bin/lava-test-runner /lava-11409056/1

    2023-09-02T07:55:55.445056  =


    2023-09-02T07:55:55.449677  / # /lava-11409056/bin/lava-test-runner /la=
va-11409056/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2eb958b38a7e9a8286d85

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2eb958b38a7e9a8286d8e
        failing since 155 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-02T08:00:11.244543  + <8>[   10.109445] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11409086_1.4.2.3.1>

    2023-09-02T08:00:11.244630  set +x

    2023-09-02T08:00:11.348999  / # #

    2023-09-02T08:00:11.449714  export SHELL=3D/bin/sh

    2023-09-02T08:00:11.450006  #

    2023-09-02T08:00:11.550543  / # export SHELL=3D/bin/sh. /lava-11409086/=
environment

    2023-09-02T08:00:11.550758  =


    2023-09-02T08:00:11.651335  / # . /lava-11409086/environment/lava-11409=
086/bin/lava-test-runner /lava-11409086/1

    2023-09-02T08:00:11.651641  =


    2023-09-02T08:00:11.656180  / # /lava-11409086/bin/lava-test-runner /la=
va-11409086/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2eaa44407f0c03b286d6c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2eaa44407f0c03b286d71
        failing since 155 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-02T07:55:59.956159  + set +x

    2023-09-02T07:55:59.963309  <8>[   11.699834] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11409050_1.4.2.3.1>

    2023-09-02T07:56:00.072192  / # #

    2023-09-02T07:56:00.174621  export SHELL=3D/bin/sh

    2023-09-02T07:56:00.175389  #

    2023-09-02T07:56:00.276999  / # export SHELL=3D/bin/sh. /lava-11409050/=
environment

    2023-09-02T07:56:00.277747  =


    2023-09-02T07:56:00.379526  / # . /lava-11409050/environment/lava-11409=
050/bin/lava-test-runner /lava-11409050/1

    2023-09-02T07:56:00.380892  =


    2023-09-02T07:56:00.386478  / # /lava-11409050/bin/lava-test-runner /la=
va-11409050/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2eb958b38a7e9a8286d7a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2eb958b38a7e9a8286d83
        failing since 155 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-02T08:00:08.060094  <8>[   10.111991] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11409098_1.4.2.3.1>

    2023-09-02T08:00:08.063344  + set +x

    2023-09-02T08:00:08.164849  =


    2023-09-02T08:00:08.265426  / # #export SHELL=3D/bin/sh

    2023-09-02T08:00:08.265585  =


    2023-09-02T08:00:08.366206  / # export SHELL=3D/bin/sh. /lava-11409098/=
environment

    2023-09-02T08:00:08.366407  =


    2023-09-02T08:00:08.466957  / # . /lava-11409098/environment/lava-11409=
098/bin/lava-test-runner /lava-11409098/1

    2023-09-02T08:00:08.467218  =


    2023-09-02T08:00:08.472851  / # /lava-11409098/bin/lava-test-runner /la=
va-11409098/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2eaa124400d1f96286df7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2eaa124400d1f96286e00
        failing since 155 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-02T07:56:05.967859  + <8>[   11.644725] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11409064_1.4.2.3.1>

    2023-09-02T07:56:05.968037  set +x

    2023-09-02T07:56:06.072749  / # #

    2023-09-02T07:56:06.173589  export SHELL=3D/bin/sh

    2023-09-02T07:56:06.173860  #

    2023-09-02T07:56:06.274682  / # export SHELL=3D/bin/sh. /lava-11409064/=
environment

    2023-09-02T07:56:06.274913  =


    2023-09-02T07:56:06.375758  / # . /lava-11409064/environment/lava-11409=
064/bin/lava-test-runner /lava-11409064/1

    2023-09-02T07:56:06.376990  =


    2023-09-02T07:56:06.382269  / # /lava-11409064/bin/lava-test-runner /la=
va-11409064/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2ebabfa535c9f45286d9f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2ebabfa535c9f45286da8
        failing since 155 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-02T08:00:25.025113  + set<8>[   11.017596] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11409101_1.4.2.3.1>

    2023-09-02T08:00:25.025679   +x

    2023-09-02T08:00:25.133495  / # #

    2023-09-02T08:00:25.236282  export SHELL=3D/bin/sh

    2023-09-02T08:00:25.237172  #

    2023-09-02T08:00:25.338880  / # export SHELL=3D/bin/sh. /lava-11409101/=
environment

    2023-09-02T08:00:25.339695  =


    2023-09-02T08:00:25.441389  / # . /lava-11409101/environment/lava-11409=
101/bin/lava-test-runner /lava-11409101/1

    2023-09-02T08:00:25.442823  =


    2023-09-02T08:00:25.448019  / # /lava-11409101/bin/lava-test-runner /la=
va-11409101/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2eec67dac18bd0f286d6c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm64/defconfig+kselftest/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls=
.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm64/defconfig+kselftest/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f2eec67dac18bd0f286=
d6d
        new failure (last pass: v5.15.128) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2eaa1a53294bb18286d7d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2eaa1a53294bb18286d86
        failing since 155 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-02T07:56:07.881487  + <8>[   11.798393] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11409040_1.4.2.3.1>

    2023-09-02T07:56:07.881580  set +x

    2023-09-02T07:56:07.986114  / # #

    2023-09-02T07:56:08.086730  export SHELL=3D/bin/sh

    2023-09-02T07:56:08.086908  #

    2023-09-02T07:56:08.187422  / # export SHELL=3D/bin/sh. /lava-11409040/=
environment

    2023-09-02T07:56:08.187599  =


    2023-09-02T07:56:08.288155  / # . /lava-11409040/environment/lava-11409=
040/bin/lava-test-runner /lava-11409040/1

    2023-09-02T07:56:08.288417  =


    2023-09-02T07:56:08.293679  / # /lava-11409040/bin/lava-test-runner /la=
va-11409040/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2eb9a1da735653d286db0

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2eb9a1da735653d286db9
        failing since 155 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-02T08:00:08.504240  <8>[    9.242793] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11409087_1.4.2.3.1>

    2023-09-02T08:00:08.611532  / # #

    2023-09-02T08:00:08.713636  export SHELL=3D/bin/sh

    2023-09-02T08:00:08.714271  #

    2023-09-02T08:00:08.815593  / # export SHELL=3D/bin/sh. /lava-11409087/=
environment

    2023-09-02T08:00:08.815990  =


    2023-09-02T08:00:08.916748  / # . /lava-11409087/environment/lava-11409=
087/bin/lava-test-runner /lava-11409087/1

    2023-09-02T08:00:08.917026  =


    2023-09-02T08:00:08.921858  / # /lava-11409087/bin/lava-test-runner /la=
va-11409087/1

    2023-09-02T08:00:08.927496  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-g12a-u200              | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2ef0c197bab8a5d286deb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm64/defconfig+kselftest/gcc-10/lab-baylibre/baseline-meson-g12a-u200.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm64/defconfig+kselftest/gcc-10/lab-baylibre/baseline-meson-g12a-u200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f2ef0c197bab8a5d286=
dec
        new failure (last pass: v5.15.128) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-g12b-odroid-n2         | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2efbf2e92fd29a5286e12

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm64/defconfig+kselftest/gcc-10/lab-baylibre/baseline-meson-g12b-odroid-n2=
.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm64/defconfig+kselftest/gcc-10/lab-baylibre/baseline-meson-g12b-odroid-n2=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f2efbf2e92fd29a5286=
e13
        new failure (last pass: v5.15.128) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f03800bf7c0b98286d72

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm64/defconfig+kselftest/gcc-10/lab-baylibre/baseline-meson-gxl-s905x-libr=
etech-cc.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm64/defconfig+kselftest/gcc-10/lab-baylibre/baseline-meson-gxl-s905x-libr=
etech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f2f03800bf7c0b98286=
d73
        new failure (last pass: v5.15.128) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f2d363adb77fd6286d89

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-baylibre/baseline-mes=
on-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-baylibre/baseline-mes=
on-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f2f2d363adb77fd6286=
d8a
        failing since 2 days (last pass: v5.15.128, first fail: v5.15.129) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2ee9f1e0c75655a286d6c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm64/defconfig+kselftest/gcc-10/lab-broonie/baseline-meson-gxl-s905x-libre=
tech-cc.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm64/defconfig+kselftest/gcc-10/lab-broonie/baseline-meson-gxl-s905x-libre=
tech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f2ee9f1e0c75655a286=
d6d
        new failure (last pass: v5.15.128) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f067605d12b15c286deb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-broonie/baseline-meso=
n-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-broonie/baseline-meso=
n-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f2f067605d12b15c286=
dec
        failing since 2 days (last pass: v5.15.128, first fail: v5.15.129) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f07018651b66d9286d91

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f2f07018651b66d9286=
d92
        failing since 220 days (last pass: v5.15.89, first fail: v5.15.90) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2ec2af5a7ab546b286d6c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2ec2af5a7ab546b286d75
        failing since 36 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-09-02T08:02:47.303472  / # #

    2023-09-02T08:02:48.383344  export SHELL=3D/bin/sh

    2023-09-02T08:02:48.385074  #

    2023-09-02T08:02:49.874671  / # export SHELL=3D/bin/sh. /lava-11409150/=
environment

    2023-09-02T08:02:49.876460  =


    2023-09-02T08:02:52.599428  / # . /lava-11409150/environment/lava-11409=
150/bin/lava-test-runner /lava-11409150/1

    2023-09-02T08:02:52.601659  =


    2023-09-02T08:02:52.611814  / # /lava-11409150/bin/lava-test-runner /la=
va-11409150/1

    2023-09-02T08:02:52.672567  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-02T08:02:52.673234  + cd /lava-114091<8>[   25.517296] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11409150_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2eed27dac18bd0f286dad

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f2eed27dac18bd0f286=
dae
        new failure (last pass: v5.15.128) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2eebe4e5f27a785286da7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.t=
xt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f2eebe4e5f27a785286=
da8
        new failure (last pass: v5.15.128) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2eed87dac18bd0f286dd5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm64/defconfig+kselftest/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plu=
s.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm64/defconfig+kselftest/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plu=
s.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f2eed87dac18bd0f286=
dd6
        new failure (last pass: v5.15.128) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2ec0ce31cf1d72c286d90

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.130/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2ec0ce31cf1d72c286d99
        failing since 36 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-09-02T08:03:46.415152  / # #

    2023-09-02T08:03:46.517430  export SHELL=3D/bin/sh

    2023-09-02T08:03:46.518132  #

    2023-09-02T08:03:46.619458  / # export SHELL=3D/bin/sh. /lava-11409151/=
environment

    2023-09-02T08:03:46.620170  =


    2023-09-02T08:03:46.721623  / # . /lava-11409151/environment/lava-11409=
151/bin/lava-test-runner /lava-11409151/1

    2023-09-02T08:03:46.722712  =


    2023-09-02T08:03:46.740709  / # /lava-11409151/bin/lava-test-runner /la=
va-11409151/1

    2023-09-02T08:03:46.797346  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-02T08:03:46.797837  + cd /lava-1140915<8>[   16.792989] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11409151_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
