Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DE06F1AC4
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 16:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjD1Osu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 10:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjD1Osr (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 10:48:47 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632F43A84
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 07:48:43 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63b4dfead1bso43755b3a.3
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 07:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682693322; x=1685285322;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m7HGkw3lFSVJC9Iel7zggR02KI1Yk659w0x4dj+L2Ys=;
        b=JQ/9KX1v13gQJvBEu4p32+Ivv4DCnqkPWNInsfAnFXdWH/bO/WN9YouHZvU7Ou/aCf
         ZAjnVXN45x2EGBQSUcBLBHoYGKqKupeaOnu0txVRkUUPjyMW56l/kebOlYWhZz2d0iZp
         NEl4EUMhXbeisMR6VMTNcSzc9j0ghfBAQfwwAo56o4vTsPuiqqsX9SXiqUueRfBsYNIH
         D9kSZOsS/QhJRoNXBhR+N95TLT/zTAlmBTa3SafrcnJ9f6KxjZW4XaFdA1iF4jifQ/Ke
         CBW38rLKykRyCj1MIfXc/st/LJbpBr/YE7L/ltkHOBmDEl6s0L4lshrUz5D1tPL7gSHm
         Dgog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682693322; x=1685285322;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m7HGkw3lFSVJC9Iel7zggR02KI1Yk659w0x4dj+L2Ys=;
        b=Ax7e5x5gDYkC3qf5wQ8v4KFFjXf61oeF0WEzRdYLew88AnTT+ELkO3sa3lGQrEuMXK
         p7au5FvPm3pKEyyNkKx+5Cf7QgTFSD3VaUZ2r9p83YkWtpykNdAwh3zZLhPn1/UVauCr
         qwl55gdUkN5KtrKBbYeejMKFhgc2n15gwhVarE7Q2GGAdkTs39GsOXkrJ+kCpW85iCAO
         tJKsL4F2Sh3I2FWCixIuM2m6z4KR6u8y2Zs/drzcK/VJ8lOMhadjUmyRVrqYr7eoKn6K
         FnTWsAJrMQbpBpAvgJSKSAuZCIgQWhzLZGeDOzAvlWmW8gRlbuHidJw3qdgxOFk1tlFR
         ndkQ==
X-Gm-Message-State: AC+VfDwP6kNhNZzDtHkZieHCn4RxuYoRKUbaX8+j6Bf8izNR2RsFTFbb
        5K8cd2vatUtV/DJ8t9xxrIN+XCnhx6j3QDhhBZ8=
X-Google-Smtp-Source: ACHHUZ7VCNtEkgQkjhdYse0zrukN8M3BGi9kxWl5NhV7UlpGcFGCBQN7rtZHXso1EJG9xoapLb5KiA==
X-Received: by 2002:a05:6a20:b919:b0:f2:aa3c:fc6e with SMTP id fe25-20020a056a20b91900b000f2aa3cfc6emr5223920pzb.43.1682693322238;
        Fri, 28 Apr 2023 07:48:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h4-20020a056a00170400b00640f01e130fsm6914930pfc.124.2023.04.28.07.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 07:48:41 -0700 (PDT)
Message-ID: <644bdcc9.050a0220.ebb8a.ec4c@mx.google.com>
Date:   Fri, 28 Apr 2023 07:48:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.176-372-gd4a1fbdb1f8d
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 173 runs,
 9 regressions (v5.10.176-372-gd4a1fbdb1f8d)
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

stable-rc/queue/5.10 baseline: 173 runs, 9 regressions (v5.10.176-372-gd4a1=
fbdb1f8d)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.176-372-gd4a1fbdb1f8d/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.176-372-gd4a1fbdb1f8d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      d4a1fbdb1f8dd4652f25340ec203c896506d1ecc =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/644ba777c4f64953d72e8617

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-gd4a1fbdb1f8d/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-gd4a1fbdb1f8d/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644ba777c4f64953d72e8649
        failing since 73 days (last pass: v5.10.167-127-g921934d621e4, firs=
t fail: v5.10.167-139-gf9519a5a1701)

    2023-04-28T11:00:53.581940  <8>[   19.496844] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 397525_1.5.2.4.1>
    2023-04-28T11:00:53.693227  / # #
    2023-04-28T11:00:53.796293  export SHELL=3D/bin/sh
    2023-04-28T11:00:53.797257  #
    2023-04-28T11:00:53.899373  / # export SHELL=3D/bin/sh. /lava-397525/en=
vironment
    2023-04-28T11:00:53.900271  =

    2023-04-28T11:00:54.002418  / # . /lava-397525/environment/lava-397525/=
bin/lava-test-runner /lava-397525/1
    2023-04-28T11:00:54.003774  =

    2023-04-28T11:00:54.008422  / # /lava-397525/bin/lava-test-runner /lava=
-397525/1
    2023-04-28T11:00:54.117146  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644ba22645fa87199c2e861d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-gd4a1fbdb1f8d/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-gd4a1fbdb1f8d/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644ba22645fa87199c2e8622
        failing since 91 days (last pass: v5.10.165-76-g5c2e982fcf18, first=
 fail: v5.10.165-77-g4600242c13ed)

    2023-04-28T10:38:17.173094  <8>[   11.061849] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3540397_1.5.2.4.1>
    2023-04-28T10:38:17.282782  / # #
    2023-04-28T10:38:17.386373  export SHELL=3D/bin/sh
    2023-04-28T10:38:17.387536  #
    2023-04-28T10:38:17.489640  / # export SHELL=3D/bin/sh. /lava-3540397/e=
nvironment
    2023-04-28T10:38:17.490800  =

    2023-04-28T10:38:17.593068  / # . /lava-3540397/environment/lava-354039=
7/bin/lava-test-runner /lava-3540397/1
    2023-04-28T10:38:17.595104  =

    2023-04-28T10:38:17.595616  / # /lava-3540397/bin/lava-test-runner /lav=
a-3540397/1<3>[   11.451514] Bluetooth: hci0: command 0xfc18 tx timeout
    2023-04-28T10:38:17.599592   =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644ba2be078638506d2e8617

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-gd4a1fbdb1f8d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-gd4a1fbdb1f8d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644ba2be078638506d2e861c
        failing since 29 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-04-28T10:40:55.469779  + set +x

    2023-04-28T10:40:55.476534  <8>[   14.811255] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10150159_1.4.2.3.1>

    2023-04-28T10:40:55.580823  / # #

    2023-04-28T10:40:55.681362  export SHELL=3D/bin/sh

    2023-04-28T10:40:55.681562  #

    2023-04-28T10:40:55.782031  / # export SHELL=3D/bin/sh. /lava-10150159/=
environment

    2023-04-28T10:40:55.782198  =


    2023-04-28T10:40:55.882667  / # . /lava-10150159/environment/lava-10150=
159/bin/lava-test-runner /lava-10150159/1

    2023-04-28T10:40:55.882953  =


    2023-04-28T10:40:55.886933  / # /lava-10150159/bin/lava-test-runner /la=
va-10150159/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644ba2b7078638506d2e85f5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-gd4a1fbdb1f8d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-gd4a1fbdb1f8d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644ba2b7078638506d2e85fa
        failing since 29 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-04-28T10:40:39.522590  + set +x<8>[   12.654696] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10150205_1.4.2.3.1>

    2023-04-28T10:40:39.522680  =


    2023-04-28T10:40:39.624370  #

    2023-04-28T10:40:39.624633  =


    2023-04-28T10:40:39.725200  / # #export SHELL=3D/bin/sh

    2023-04-28T10:40:39.725411  =


    2023-04-28T10:40:39.825971  / # export SHELL=3D/bin/sh. /lava-10150205/=
environment

    2023-04-28T10:40:39.826175  =


    2023-04-28T10:40:39.926699  / # . /lava-10150205/environment/lava-10150=
205/bin/lava-test-runner /lava-10150205/1

    2023-04-28T10:40:39.926975  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644ba4409e5d0929602e85ff

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-gd4a1fbdb1f8d/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-gd4a1fbdb1f8d/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644ba4409e5d0929602e8604
        failing since 86 days (last pass: v5.10.155-149-g63e308de12c9, firs=
t fail: v5.10.165-142-gc53eb88edf7e)

    2023-04-28T10:47:10.733068  [   16.014838] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3540454_1.5.2.4.1>
    2023-04-28T10:47:10.837684  =

    2023-04-28T10:47:10.837931  / # [   16.066964] rockchip-drm display-sub=
system: [drm] Cannot find any crtc or sizes
    2023-04-28T10:47:10.939496  #export SHELL=3D/bin/sh
    2023-04-28T10:47:10.940113  =

    2023-04-28T10:47:11.041939  / # export SHELL=3D/bin/sh. /lava-3540454/e=
nvironment
    2023-04-28T10:47:11.042798  =

    2023-04-28T10:47:11.144878  / # . /lava-3540454/environment/lava-354045=
4/bin/lava-test-runner /lava-3540454/1
    2023-04-28T10:47:11.146218  =

    2023-04-28T10:47:11.149414  / # /lava-3540454/bin/lava-test-runner /lav=
a-3540454/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/644ba5995e4af30aef2e863c

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-gd4a1fbdb1f8d/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-gd4a1fbdb1f8d/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/644ba5995e4af30aef2e8642
        failing since 45 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-04-28T10:53:03.671600  /lava-10150273/1/../bin/lava-test-case

    2023-04-28T10:53:03.682477  <8>[   35.452594] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/644ba5995e4af30aef2e8643
        failing since 45 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-04-28T10:53:01.611444  <8>[   33.379268] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-04-28T10:53:02.633669  /lava-10150273/1/../bin/lava-test-case

    2023-04-28T10:53:02.644680  <8>[   34.414817] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644ba1e94be4008eb02e85f1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-gd4a1fbdb1f8d/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-stm3=
2mp157c-dk2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-gd4a1fbdb1f8d/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-stm3=
2mp157c-dk2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644ba1e94be4008eb02e85f6
        failing since 85 days (last pass: v5.10.147-29-g9a9285d3dc114, firs=
t fail: v5.10.165-149-ge30e8271d674)

    2023-04-28T10:37:21.018560  <8>[   12.609526] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3540392_1.5.2.4.1>
    2023-04-28T10:37:21.123719  / # #
    2023-04-28T10:37:21.226281  export SHELL=3D/bin/sh
    2023-04-28T10:37:21.227053  #
    2023-04-28T10:37:21.328926  / # export SHELL=3D/bin/sh. /lava-3540392/e=
nvironment
    2023-04-28T10:37:21.329513  =

    2023-04-28T10:37:21.431226  / # . /lava-3540392/environment/lava-354039=
2/bin/lava-test-runner /lava-3540392/1
    2023-04-28T10:37:21.432321  =

    2023-04-28T10:37:21.436735  / # /lava-3540392/bin/lava-test-runner /lav=
a-3540392/1
    2023-04-28T10:37:21.502740  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644ba21d45fa87199c2e8603

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-gd4a1fbdb1f8d/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-gd4a1fbdb1f8d/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644ba21d45fa87199c2e8608
        failing since 85 days (last pass: v5.10.165-139-gefb57ce0f880, firs=
t fail: v5.10.165-149-ge30e8271d674)

    2023-04-28T10:37:58.847495  / # #
    2023-04-28T10:37:58.952502  export SHELL=3D/bin/sh
    2023-04-28T10:37:58.953896  #
    2023-04-28T10:37:59.055597  / # export SHELL=3D/bin/sh. /lava-3540391/e=
nvironment
    2023-04-28T10:37:59.056196  =

    2023-04-28T10:37:59.158241  / # . /lava-3540391/environment/lava-354039=
1/bin/lava-test-runner /lava-3540391/1
    2023-04-28T10:37:59.159366  =

    2023-04-28T10:37:59.174420  / # /lava-3540391/bin/lava-test-runner /lav=
a-3540391/1
    2023-04-28T10:37:59.264224  + export 'TESTRUN_ID=3D1_bootrr'
    2023-04-28T10:37:59.264830  + cd /lava-3540391/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
