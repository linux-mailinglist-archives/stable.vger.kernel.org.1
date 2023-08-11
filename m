Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2534A77936F
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 17:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbjHKPpD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 11:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbjHKPpD (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 11:45:03 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB92630CB
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 08:45:01 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5654051b27fso1632370a12.0
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 08:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691768701; x=1692373501;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vPzRJ2oKaiAcPC2uCDothyvLu/rvZdmEfNYXrWPlrCg=;
        b=x8LUOdMSzyTO06i3Jbe7Y8XUCVW/rfcQpeP4B7MWjOFuEoAi2QfhfVQGCQGInbW9v2
         Ag/tY6Ti0FvFmxdf94RuROFMdwvBHXx4F21AInsEnmyXP1oMbatP42LBcNQai4TUHMV1
         SfplKtYOiCtyZsU0RYC9f4NyF5QHNr8//C4vJk1UJ+9mla28cxETSnWx1PHjCXB1w8LU
         2gxjWz/5BHKRjgg0WNR6IT8PeslDc8eynSKbtRViCFYJMQrmAa2HMNr96wDr17JIsnp8
         Fy0fm2JM7jhMkMZsDhFPyR70WOCx6fs1A+nJ7bSpEk0c66hFylgqjloyvbCwrM7KJy4M
         17UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691768701; x=1692373501;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vPzRJ2oKaiAcPC2uCDothyvLu/rvZdmEfNYXrWPlrCg=;
        b=S09H0CdOi3bnFac4Z71q9qW7Zfda5DLVGzCiTMG0rf42oIeM51wUENjdnOaosNCHqj
         5nkS5fg0UQ5SdmOWu740Ed8WqK9Jux2whWa3xDXt3C3rJiY/3eB+yj7eiJbS7x9/Yc6R
         2JICWdF/2RfePPuWbpjDBL/frrjJEictQg1btx3wJypl6n7kvvqty1lKZxszNT5qFcY9
         RXFnr+EnNm/GCcMhvaruDDRwotEY3JfSXFhM73nouZ189fgrCiwr9up3vZ2oh3NB4rGy
         J2uqv0UAhd+nPb0ih7UUVTAs2HuRF1LCaCqcXfpS76gBlV+KwnDBaHza4445G7K1qroy
         QP4g==
X-Gm-Message-State: AOJu0YwuaWecuDl2ZemJi82hzhFvl+m8SKKqtVVSpGiVVTWxvio/Hlws
        1nMLN7k+TuurngqsHeKuUoRWrE520XZw08iqY7IAAA==
X-Google-Smtp-Source: AGHT+IH8kQklmvg0gk868BTM9WI8Ry9+hZMK1PBSf9Eojce8tyNRMiHW5nWp6cPlR/BS19RiAJjAEQ==
X-Received: by 2002:a17:90a:3002:b0:261:2a59:dc38 with SMTP id g2-20020a17090a300200b002612a59dc38mr1890263pjb.25.1691768700560;
        Fri, 11 Aug 2023 08:45:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s88-20020a17090a69e100b00265c742a262sm3729297pjj.4.2023.08.11.08.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:44:59 -0700 (PDT)
Message-ID: <64d6577b.170a0220.998e6.6d57@mx.google.com>
Date:   Fri, 11 Aug 2023 08:44:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.190
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.10.y
Subject: stable-rc/linux-5.10.y baseline: 110 runs, 10 regressions (v5.10.190)
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

stable-rc/linux-5.10.y baseline: 110 runs, 10 regressions (v5.10.190)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

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

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.190/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.190
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      ec585727b63d12f9683140fe4b8eb8e564dd3aa0 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62563dddf4b35e835b1dc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d62563dddf4b35e835b=
1dd
        new failure (last pass: v5.10.189-202-g0195dc1d1da1c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d626f5f770b5c5b035b1e2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d626f5f770b5c5b035b1e7
        failing since 205 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-08-11T12:17:32.374452  <8>[   11.101545] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3736933_1.5.2.4.1>
    2023-08-11T12:17:32.483803  / # #
    2023-08-11T12:17:32.585231  export SHELL=3D/bin/sh
    2023-08-11T12:17:32.585617  #
    2023-08-11T12:17:32.686888  / # export SHELL=3D/bin/sh. /lava-3736933/e=
nvironment
    2023-08-11T12:17:32.687370  =

    2023-08-11T12:17:32.788513  / # . /lava-3736933/environment/lava-373693=
3/bin/lava-test-runner /lava-3736933/1
    2023-08-11T12:17:32.789140  =

    2023-08-11T12:17:32.793816  / # /lava-3736933/bin/lava-test-runner /lav=
a-3736933/1
    2023-08-11T12:17:32.878762  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d624ed67b9c9db8135b1d9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d624ed67b9c9db8135b1dc
        failing since 24 days (last pass: v5.10.142, first fail: v5.10.186-=
332-gf98a4d3a5cec)

    2023-08-11T12:09:02.892207  [   13.295882] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1242830_1.5.2.4.1>
    2023-08-11T12:09:02.999979  =

    2023-08-11T12:09:03.101638  / # #export SHELL=3D/bin/sh
    2023-08-11T12:09:03.102217  =

    2023-08-11T12:09:03.203422  / # export SHELL=3D/bin/sh. /lava-1242830/e=
nvironment
    2023-08-11T12:09:03.203926  =

    2023-08-11T12:09:03.305168  / # . /lava-1242830/environment/lava-124283=
0/bin/lava-test-runner /lava-1242830/1
    2023-08-11T12:09:03.305935  =

    2023-08-11T12:09:03.309087  / # /lava-1242830/bin/lava-test-runner /lav=
a-1242830/1
    2023-08-11T12:09:03.330904  + export 'TESTRUN_[   13.733963] <LAVA_SIGN=
AL_STARTRUN 1_bootrr 1242830_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d624f0da5ba29cbd35b1e7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d624f0da5ba29cbd35b1ea
        failing since 160 days (last pass: v5.10.155, first fail: v5.10.172)

    2023-08-11T12:09:04.221723  [   10.754936] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1242831_1.5.2.4.1>
    2023-08-11T12:09:04.327581  =

    2023-08-11T12:09:04.428825  / # #export SHELL=3D/bin/sh
    2023-08-11T12:09:04.429218  =

    2023-08-11T12:09:04.530011  / # export SHELL=3D/bin/sh. /lava-1242831/e=
nvironment
    2023-08-11T12:09:04.530489  =

    2023-08-11T12:09:04.631533  / # . /lava-1242831/environment/lava-124283=
1/bin/lava-test-runner /lava-1242831/1
    2023-08-11T12:09:04.632308  =

    2023-08-11T12:09:04.636246  / # /lava-1242831/bin/lava-test-runner /lav=
a-1242831/1
    2023-08-11T12:09:04.651262  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62386910db28d0735b21d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d62386910db28d0735b222
        failing since 135 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-11T12:02:39.640228  + <8>[   17.137436] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11262741_1.4.2.3.1>

    2023-08-11T12:02:39.640627  set +x

    2023-08-11T12:02:39.746371  =


    2023-08-11T12:02:39.848232  / # #export SHELL=3D/bin/sh

    2023-08-11T12:02:39.849016  =


    2023-08-11T12:02:39.950532  / # export SHELL=3D/bin/sh. /lava-11262741/=
environment

    2023-08-11T12:02:39.951316  =


    2023-08-11T12:02:40.052828  / # . /lava-11262741/environment/lava-11262=
741/bin/lava-test-runner /lava-11262741/1

    2023-08-11T12:02:40.054235  =


    2023-08-11T12:02:40.059437  / # /lava-11262741/bin/lava-test-runner /la=
va-11262741/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d623dc77ecfb6cc435b21e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d623dc77ecfb6cc435b223
        failing since 135 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-11T12:04:36.046339  + set +x<8>[   13.073696] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11262739_1.4.2.3.1>

    2023-08-11T12:04:36.046430  =


    2023-08-11T12:04:36.148296  #

    2023-08-11T12:04:36.249153  / # #export SHELL=3D/bin/sh

    2023-08-11T12:04:36.249364  =


    2023-08-11T12:04:36.349879  / # export SHELL=3D/bin/sh. /lava-11262739/=
environment

    2023-08-11T12:04:36.350132  =


    2023-08-11T12:04:36.450691  / # . /lava-11262739/environment/lava-11262=
739/bin/lava-test-runner /lava-11262739/1

    2023-08-11T12:04:36.451004  =


    2023-08-11T12:04:36.455599  / # /lava-11262739/bin/lava-test-runner /la=
va-11262739/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62517f20ebaae1235b1df

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d62517f20ebaae1235b219
        failing since 2 days (last pass: v5.10.189-186-g6bbe4c818f99, first=
 fail: v5.10.189-202-gb9dd551c546f)

    2023-08-11T12:09:40.146257  / # #
    2023-08-11T12:09:40.249054  export SHELL=3D/bin/sh
    2023-08-11T12:09:40.249823  #
    2023-08-11T12:09:40.351763  / # export SHELL=3D/bin/sh. /lava-45483/env=
ironment
    2023-08-11T12:09:40.352531  =

    2023-08-11T12:09:40.454509  / # . /lava-45483/environment/lava-45483/bi=
n/lava-test-runner /lava-45483/1
    2023-08-11T12:09:40.455844  =

    2023-08-11T12:09:40.470546  / # /lava-45483/bin/lava-test-runner /lava-=
45483/1
    2023-08-11T12:09:40.528462  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-11T12:09:40.528979  + cd /lava-45483/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62530f63e76653e35b1e3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d62530f63e76653e35b1e6
        failing since 24 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-11T12:09:35.745638  / # #
    2023-08-11T12:09:37.205661  export SHELL=3D/bin/sh
    2023-08-11T12:09:37.226172  #
    2023-08-11T12:09:37.226393  / # export SHELL=3D/bin/sh
    2023-08-11T12:09:39.108568  / # . /lava-995638/environment
    2023-08-11T12:09:42.559967  /lava-995638/bin/lava-test-runner /lava-995=
638/1
    2023-08-11T12:09:42.580505  . /lava-995638/environment
    2023-08-11T12:09:42.580613  / # /lava-995638/bin/lava-test-runner /lava=
-995638/1
    2023-08-11T12:09:42.658159  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-11T12:09:42.658367  + cd /lava-995638/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62acb44d40f405535b240

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d62acb44d40f405535b245
        failing since 24 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-11T12:35:38.068814  / # #

    2023-08-11T12:35:38.170970  export SHELL=3D/bin/sh

    2023-08-11T12:35:38.171680  #

    2023-08-11T12:35:38.273090  / # export SHELL=3D/bin/sh. /lava-11262830/=
environment

    2023-08-11T12:35:38.273801  =


    2023-08-11T12:35:38.375264  / # . /lava-11262830/environment/lava-11262=
830/bin/lava-test-runner /lava-11262830/1

    2023-08-11T12:35:38.376369  =


    2023-08-11T12:35:38.392983  / # /lava-11262830/bin/lava-test-runner /la=
va-11262830/1

    2023-08-11T12:35:38.442151  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-11T12:35:38.442665  + cd /lav<8>[   16.411662] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11262830_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d6248c2217aa02a035b2a4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d6248c2217aa02a035b2a9
        failing since 24 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-11T12:08:59.732505  / # #

    2023-08-11T12:08:59.834672  export SHELL=3D/bin/sh

    2023-08-11T12:08:59.835379  #

    2023-08-11T12:08:59.936798  / # export SHELL=3D/bin/sh. /lava-11262822/=
environment

    2023-08-11T12:08:59.937548  =


    2023-08-11T12:09:00.039003  / # . /lava-11262822/environment/lava-11262=
822/bin/lava-test-runner /lava-11262822/1

    2023-08-11T12:09:00.040090  =


    2023-08-11T12:09:00.056791  / # /lava-11262822/bin/lava-test-runner /la=
va-11262822/1

    2023-08-11T12:09:00.114837  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-11T12:09:00.115341  + cd /lava-1126282<8>[   18.282227] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11262822_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
