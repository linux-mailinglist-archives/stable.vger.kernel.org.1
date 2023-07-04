Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE74A74735E
	for <lists+stable@lfdr.de>; Tue,  4 Jul 2023 15:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjGDN4Q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 4 Jul 2023 09:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjGDN4Q (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 4 Jul 2023 09:56:16 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497C1BE
        for <stable@vger.kernel.org>; Tue,  4 Jul 2023 06:56:14 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a04e5baffcso4314569b6e.3
        for <stable@vger.kernel.org>; Tue, 04 Jul 2023 06:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688478973; x=1691070973;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/f35JIqIrRY3j9mrwXvEDM28APhdICVqy6ZwVWRIJ8U=;
        b=wXP1qzjE7p1mGb0G2hLth13XVlik0UtSERAsClIcx/SWQORm0IDBG40r+xLEpLpD98
         WwBXqmHWgEYK1lb28h0tiuFQklsCVC7zAXgci59aInplNGGKjDvHwXetf7DipjOSlQtX
         2z3oLpfDuTFFDksPCDsKh3VmwuoRmCvago80eKOIHBtoxsX4x3heOjFUIOlFdSbh/D2R
         ppQtWjZ258JDk32DNqJ0Iq9fX1yLt+Cwl5x6ViY1Rw8K7RgzXrOD81vRUGH1qMM9kzSV
         gj4EpUvc4IwapMUP05e1b8QHCH4xxbjAdDBJiWVw6f5gEu+1blnhh4pQP0euSDSgeNYO
         0aCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688478973; x=1691070973;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/f35JIqIrRY3j9mrwXvEDM28APhdICVqy6ZwVWRIJ8U=;
        b=iTytifHYvu87rbQLa53jsn3dIxjBvAu1a6cwsHFdw1qI4c0PlVqi3Po/m+kLtFJKgt
         yX20h+GY1tmtWvt+auTK3O3r4RKBCjjj3Rjbxi560xDQvN6iTXzwf3AuIdbcmikhk5iy
         zn3Mojn7dNfR5nqrPU6W29oquCRWtDOrLK5R4frWVreoAhE59+66n0z5pTIM7kHJIUyY
         SAkhMkxlUYMs3TyCdNDFyi4MlcOHB+8Bz8WouilxezEyriK6qkiXlxpYtvU6eJsvw6RE
         /kiDNE/JP7gingY51plFjsm6mPpnSoxqwPpJWrdNz1qQFi5rbQFmY8gDLFfEc8D3c5qE
         xeSQ==
X-Gm-Message-State: AC+VfDyUNnWyE/rywpnU5f73YIzx8D/6xFYfWhGitmGIhy6Cnzk42Ttd
        FRPwjxQ0pi/62v6XtZCoCmZZpt8j+qt4NoDiUyHIkQ==
X-Google-Smtp-Source: ACHHUZ7vXZza62z2TMIUf7y/hgVfmLCsO3tHzEEmbOIew/P3IEa10V1v0fsXVn7ipP5fI2Rgw9RsDA==
X-Received: by 2002:a05:6808:1827:b0:3a3:6c7d:a5cb with SMTP id bh39-20020a056808182700b003a36c7da5cbmr14705849oib.46.1688478973177;
        Tue, 04 Jul 2023 06:56:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s17-20020aa78d51000000b00668926a2f0bsm15689737pfe.31.2023.07.04.06.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 06:56:12 -0700 (PDT)
Message-ID: <64a424fc.a70a0220.f52a7.e775@mx.google.com>
Date:   Tue, 04 Jul 2023 06:56:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.4.249-9-gc736379684d1
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.4.y
Subject: stable-rc/linux-5.4.y baseline: 113 runs,
 5 regressions (v5.4.249-9-gc736379684d1)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.4.y baseline: 113 runs, 5 regressions (v5.4.249-9-gc73637=
9684d1)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

da850-lcdk                   | arm    | lab-baylibre  | gcc-10   | multi_v5=
_defconfig           | 1          =

hifive-unleashed-a00         | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.4.y/kern=
el/v5.4.249-9-gc736379684d1/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.4.y
  Describe: v5.4.249-9-gc736379684d1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      c736379684d1ed2c709a3ab92350c59c9055822e =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3eeb8a392bee77abb2a93

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
-9-gc736379684d1/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubiet=
ruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
-9-gc736379684d1/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubiet=
ruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3eeb8a392bee77abb2a98
        failing since 168 days (last pass: v5.4.226-68-g8c05f5e0777d, first=
 fail: v5.4.228-659-gb3b34c474ec7)

    2023-07-04T10:04:16.806938  <8>[    9.854975] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3710761_1.5.2.4.1>
    2023-07-04T10:04:16.918515  / # #
    2023-07-04T10:04:17.022082  export SHELL=3D/bin/sh
    2023-07-04T10:04:17.023164  #
    2023-07-04T10:04:17.125448  / # export SHELL=3D/bin/sh. /lava-3710761/e=
nvironment
    2023-07-04T10:04:17.126429  =

    2023-07-04T10:04:17.228594  / # . /lava-3710761/environment/lava-371076=
1/bin/lava-test-runner /lava-3710761/1
    2023-07-04T10:04:17.230534  =

    2023-07-04T10:04:17.235504  / # /lava-3710761/bin/lava-test-runner /lav=
a-3710761/1
    2023-07-04T10:04:17.313063  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
da850-lcdk                   | arm    | lab-baylibre  | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3ebbe364a2ae406bb2a8e

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
-9-gc736379684d1/arm/multi_v5_defconfig/gcc-10/lab-baylibre/baseline-da850-=
lcdk.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
-9-gc736379684d1/arm/multi_v5_defconfig/gcc-10/lab-baylibre/baseline-da850-=
lcdk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3ebbe364a2ae406bb2a93
        failing since 168 days (last pass: v5.4.227, first fail: v5.4.228-6=
59-gb3b34c474ec7)

    2023-07-04T09:51:40.360056  + set +x
    2023-07-04T09:51:40.360636  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 3710715_1.5.=
2.4.1>
    2023-07-04T09:51:40.471107  / # #
    2023-07-04T09:51:40.575010  export SHELL=3D/bin/sh
    2023-07-04T09:51:40.576126  #
    2023-07-04T09:51:40.678592  / # export SHELL=3D/bin/sh. /lava-3710715/e=
nvironment
    2023-07-04T09:51:40.679833  =

    2023-07-04T09:51:40.782182  / # . /lava-3710715/environment/lava-371071=
5/bin/lava-test-runner /lava-3710715/1
    2023-07-04T09:51:40.784240  =

    2023-07-04T09:51:40.828971  / # /lava-3710715/bin/lava-test-runner /lav=
a-3710715/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hifive-unleashed-a00         | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3ebfd829a6ba242bb2a78

  Results:     3 PASS, 2 FAIL, 2 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
-9-gc736379684d1/riscv/defconfig/gcc-10/lab-baylibre/baseline-hifive-unleas=
hed-a00.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
-9-gc736379684d1/riscv/defconfig/gcc-10/lab-baylibre/baseline-hifive-unleas=
hed-a00.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/riscv/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/64a3ebfd829a6ba2=
42bb2a81
        failing since 258 days (last pass: v5.4.219, first fail: v5.4.219-2=
67-g4a976f825745)
        3 lines

    2023-07-04T09:52:33.258213  / # =

    2023-07-04T09:52:33.259097  =

    2023-07-04T09:52:35.322928  / # #
    2023-07-04T09:52:35.324181  #
    2023-07-04T09:52:37.335256  / # export SHELL=3D/bin/sh
    2023-07-04T09:52:37.335709  export SHELL=3D/bin/sh
    2023-07-04T09:52:39.350564  / # . /lava-3710719/environment
    2023-07-04T09:52:39.351026  . /lava-3710719/environment
    2023-07-04T09:52:41.367024  / # /lava-3710719/bin/lava-test-runner /lav=
a-3710719/0
    2023-07-04T09:52:41.368995  /lava-3710719/bin/lava-test-runner /lava-37=
10719/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3f2a2a11ade64c9bb2a7d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
-9-gc736379684d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
-9-gc736379684d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3f2a2a11ade64c9bb2a82
        failing since 95 days (last pass: v5.4.238, first fail: v5.4.238)

    2023-07-04T10:21:38.575890  + <8>[   10.776554] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11006575_1.4.2.3.1>

    2023-07-04T10:21:38.579317  set +x

    2023-07-04T10:21:38.680552  /#

    2023-07-04T10:21:38.781341   # #export SHELL=3D/bin/sh

    2023-07-04T10:21:38.781561  =


    2023-07-04T10:21:38.882118  / # export SHELL=3D/bin/sh. /lava-11006575/=
environment

    2023-07-04T10:21:38.882323  =


    2023-07-04T10:21:38.982907  / # . /lava-11006575/environment/lava-11006=
575/bin/lava-test-runner /lava-11006575/1

    2023-07-04T10:21:38.983296  =


    2023-07-04T10:21:38.987467  / # /lava-11006575/bin/lava-test-runner /la=
va-11006575/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3f325fbe5eb65f1bb2ab1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
-9-gc736379684d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
-9-gc736379684d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3f325fbe5eb65f1bb2ab6
        failing since 95 days (last pass: v5.4.238, first fail: v5.4.238)

    2023-07-04T10:23:14.458086  <8>[   12.483041] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11006567_1.4.2.3.1>

    2023-07-04T10:23:14.461119  + set +x

    2023-07-04T10:23:14.565272  / # #

    2023-07-04T10:23:14.665911  export SHELL=3D/bin/sh

    2023-07-04T10:23:14.666128  #

    2023-07-04T10:23:14.766616  / # export SHELL=3D/bin/sh. /lava-11006567/=
environment

    2023-07-04T10:23:14.766805  =


    2023-07-04T10:23:14.867339  / # . /lava-11006567/environment/lava-11006=
567/bin/lava-test-runner /lava-11006567/1

    2023-07-04T10:23:14.867626  =


    2023-07-04T10:23:14.873136  / # /lava-11006567/bin/lava-test-runner /la=
va-11006567/1
 =

    ... (12 line(s) more)  =

 =20
