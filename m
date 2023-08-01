Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F01D76B4AA
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 14:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjHAMXs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 08:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjHAMXr (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 08:23:47 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5B610C7
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 05:23:44 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-686f090310dso5577534b3a.0
        for <stable@vger.kernel.org>; Tue, 01 Aug 2023 05:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690892623; x=1691497423;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l8BgpHZAosxf6YocPNseINgJPrpy+kCjvueSxmCy5tw=;
        b=JCZZBCiyatTkLo5b8hKF7HbfING+lQ33maMN+dnlcdhSC1kSrN5N0SAWsZ4WWT8Zv1
         mmWiC28uRZIo4turSX28M2oVgORJ+hoICfOVUOHimUJf8B+K71dlNjZHSEDgJk55iTmB
         Ibpo6I//MwWcZrK8yz5DofOGOeNYddCugJ75+pJYmcsUf6ErJJFwyvyaA77065gN0Ph9
         hqTptVxNF8DbW2xaEBYBP/Vi9gKVB4ursj6TLn7QxJ9JyE/rB02km7L+GWUIermkcjU5
         k+Mbm7QXvPmn15ugwhRmw26qtzpIZMLtY/yvO/Ky0sSXG+RwrGcjM0/tX8gC0u/tWiuw
         gaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690892623; x=1691497423;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l8BgpHZAosxf6YocPNseINgJPrpy+kCjvueSxmCy5tw=;
        b=b0xz2tsh1cBOMuL6gtLTn/5ohW0Q6rX4/w9t2XC4m3xWRBk6kxjRTufpw2k6fJ3qzC
         Pi4fZWYkIUrJk8AAt4b1xwfhMlHolEOq6XaNU6GK5Y4RH+jyK8N2JQdlWGB9LdHaj3E8
         7xoFlc2YStQWHXYRiL7MAsCWIAFsL+OAn41ObdJCQoI8c1ofZWfUPdi95GPWzJDEpdKX
         WwiMM5s2iM/btIoljkko8fCnv6LqpjAnujsZAl8j47mcY/F+8UYWKgdG3ni5yDSUI6BW
         yQNesI9Q0JzyMaY2qW2Pa+HG+394ljcsIEL+DpQ2TIr0x/O8GC1pR0u08V7LLCB3P4Jm
         cOkw==
X-Gm-Message-State: ABy/qLaONXODWKYWL98z/m7MPu004RlWBE7JIISLOhCVp7ZLRSvf7y6o
        n6fYtYw10Io6GKDNxvjwtWlxd6JNzHu+9EuQShk53Q==
X-Google-Smtp-Source: APBJJlFC1mPgMNlmmXZgMze5VK0FJxZumdZZ4ovC8X4gygeeN4icAHwKAPXYctlDWbZz1qI6JRB73A==
X-Received: by 2002:a05:6a21:7897:b0:13c:dee4:ceaa with SMTP id bf23-20020a056a21789700b0013cdee4ceaamr14621883pzc.16.1690892622999;
        Tue, 01 Aug 2023 05:23:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l21-20020a62be15000000b0068743cab196sm2827149pff.186.2023.08.01.05.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 05:23:42 -0700 (PDT)
Message-ID: <64c8f94e.620a0220.7fa17.5bd6@mx.google.com>
Date:   Tue, 01 Aug 2023 05:23:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Kernel: v5.15.123-149-gcff76fcf64697
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.15.y baseline: 125 runs,
 17 regressions (v5.15.123-149-gcff76fcf64697)
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

stable-rc/linux-5.15.y baseline: 125 runs, 17 regressions (v5.15.123-149-gc=
ff76fcf64697)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

fsl-ls2088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

fsl-lx2160a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

kontron-pitx-imx8m           | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 2          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.123-149-gcff76fcf64697/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.123-149-gcff76fcf64697
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      cff76fcf64697fa08c2f74f401e6c3e32f90f0d9 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8c5728072edcb138ace2b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-149-gcff76fcf64697/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-149-gcff76fcf64697/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8c5728072edcb138ace30
        failing since 125 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-01T08:42:00.485679  <8>[   10.719560] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11181949_1.4.2.3.1>

    2023-08-01T08:42:00.489237  + set +x

    2023-08-01T08:42:00.593183  / # #

    2023-08-01T08:42:00.693895  export SHELL=3D/bin/sh

    2023-08-01T08:42:00.694100  #

    2023-08-01T08:42:00.794613  / # export SHELL=3D/bin/sh. /lava-11181949/=
environment

    2023-08-01T08:42:00.794802  =


    2023-08-01T08:42:00.895313  / # . /lava-11181949/environment/lava-11181=
949/bin/lava-test-runner /lava-11181949/1

    2023-08-01T08:42:00.895582  =


    2023-08-01T08:42:00.901583  / # /lava-11181949/bin/lava-test-runner /la=
va-11181949/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8c6516ec8f815dc8ace4a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-149-gcff76fcf64697/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-149-gcff76fcf64697/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64c8c6516ec8f815dc8ac=
e4b
        new failure (last pass: v5.15.123) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8c56f41a10736638ace27

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-149-gcff76fcf64697/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-149-gcff76fcf64697/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8c56f41a10736638ace2c
        failing since 125 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-01T08:42:05.221947  + set +x<8>[   11.070927] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11181946_1.4.2.3.1>

    2023-08-01T08:42:05.222031  =


    2023-08-01T08:42:05.326186  / # #

    2023-08-01T08:42:05.426762  export SHELL=3D/bin/sh

    2023-08-01T08:42:05.426922  #

    2023-08-01T08:42:05.527432  / # export SHELL=3D/bin/sh. /lava-11181946/=
environment

    2023-08-01T08:42:05.527585  =


    2023-08-01T08:42:05.628088  / # . /lava-11181946/environment/lava-11181=
946/bin/lava-test-runner /lava-11181946/1

    2023-08-01T08:42:05.628321  =


    2023-08-01T08:42:05.633370  / # /lava-11181946/bin/lava-test-runner /la=
va-11181946/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8c5848072edcb138ace7e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-149-gcff76fcf64697/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-149-gcff76fcf64697/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8c5848072edcb138ace83
        failing since 125 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-01T08:42:28.060002  <8>[   10.913582] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11181935_1.4.2.3.1>

    2023-08-01T08:42:28.063342  + set +x

    2023-08-01T08:42:28.167301  / # #

    2023-08-01T08:42:28.267998  export SHELL=3D/bin/sh

    2023-08-01T08:42:28.268612  #

    2023-08-01T08:42:28.369770  / # export SHELL=3D/bin/sh. /lava-11181935/=
environment

    2023-08-01T08:42:28.369927  =


    2023-08-01T08:42:28.470444  / # . /lava-11181935/environment/lava-11181=
935/bin/lava-test-runner /lava-11181935/1

    2023-08-01T08:42:28.470703  =


    2023-08-01T08:42:28.475560  / # /lava-11181935/bin/lava-test-runner /la=
va-11181935/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8c709af1c77c5ef8ace42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-149-gcff76fcf64697/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-=
beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-149-gcff76fcf64697/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-=
beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64c8c709af1c77c5ef8ac=
e43
        failing since 6 days (last pass: v5.15.120, first fail: v5.15.122-7=
9-g3bef1500d246a) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8c897015c5127248ace86

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-149-gcff76fcf64697/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-149-gcff76fcf64697/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8c897015c5127248ace8b
        failing since 196 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-08-01T08:55:24.090310  + set +x<8>[   10.015470] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3727013_1.5.2.4.1>
    2023-08-01T08:55:24.090645  =

    2023-08-01T08:55:24.196923  / # #
    2023-08-01T08:55:24.299142  export SHELL=3D/bin/sh
    2023-08-01T08:55:24.300073  #
    2023-08-01T08:55:24.402118  / # export SHELL=3D/bin/sh. /lava-3727013/e=
nvironment
    2023-08-01T08:55:24.403028  =

    2023-08-01T08:55:24.505480  / # . /lava-3727013/environment/lava-372701=
3/bin/lava-test-runner /lava-3727013/1
    2023-08-01T08:55:24.506004  =

    2023-08-01T08:55:24.506150  / # /lava-3727013/bin/lava-test-runner /lav=
a-3727013/1<3>[   10.433251] Bluetooth: hci0: command 0xfc18 tx timeout =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8c5b40292d665c98ace36

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-149-gcff76fcf64697/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-r=
db.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-149-gcff76fcf64697/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-r=
db.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8c5b40292d665c98ace39
        failing since 18 days (last pass: v5.15.67, first fail: v5.15.119-1=
6-g66130849c020f)

    2023-08-01T08:43:16.288977  + [   12.287606] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1239918_1.5.2.4.1>
    2023-08-01T08:43:16.289224  set +x
    2023-08-01T08:43:16.394541  =

    2023-08-01T08:43:16.495710  / # #export SHELL=3D/bin/sh
    2023-08-01T08:43:16.496098  =

    2023-08-01T08:43:16.597028  / # export SHELL=3D/bin/sh. /lava-1239918/e=
nvironment
    2023-08-01T08:43:16.597406  =

    2023-08-01T08:43:16.698347  / # . /lava-1239918/environment/lava-123991=
8/bin/lava-test-runner /lava-1239918/1
    2023-08-01T08:43:16.699019  =

    2023-08-01T08:43:16.702208  / # /lava-1239918/bin/lava-test-runner /lav=
a-1239918/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8c5a1b959a117128ace45

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-149-gcff76fcf64697/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-r=
db.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-149-gcff76fcf64697/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-r=
db.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8c5a1b959a117128ace48
        failing since 150 days (last pass: v5.15.79, first fail: v5.15.98)

    2023-08-01T08:42:58.307075  [   10.332714] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1239919_1.5.2.4.1>
    2023-08-01T08:42:58.412285  =

    2023-08-01T08:42:58.513445  / # #export SHELL=3D/bin/sh
    2023-08-01T08:42:58.513849  =

    2023-08-01T08:42:58.614794  / # export SHELL=3D/bin/sh. /lava-1239919/e=
nvironment
    2023-08-01T08:42:58.615234  =

    2023-08-01T08:42:58.716203  / # . /lava-1239919/environment/lava-123991=
9/bin/lava-test-runner /lava-1239919/1
    2023-08-01T08:42:58.716871  =

    2023-08-01T08:42:58.720827  / # /lava-1239919/bin/lava-test-runner /lav=
a-1239919/1
    2023-08-01T08:42:58.735932  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8c54d0158d321878ace29

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-149-gcff76fcf64697/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-149-gcff76fcf64697/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8c54d0158d321878ace2e
        failing since 125 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-01T08:41:51.054705  + <8>[   10.406361] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11181945_1.4.2.3.1>

    2023-08-01T08:41:51.055195  set +x

    2023-08-01T08:41:51.159982  #

    2023-08-01T08:41:51.262456  / # #export SHELL=3D/bin/sh

    2023-08-01T08:41:51.263095  =


    2023-08-01T08:41:51.364582  / # export SHELL=3D/bin/sh. /lava-11181945/=
environment

    2023-08-01T08:41:51.365453  =


    2023-08-01T08:41:51.467048  / # . /lava-11181945/environment/lava-11181=
945/bin/lava-test-runner /lava-11181945/1

    2023-08-01T08:41:51.468297  =


    2023-08-01T08:41:51.472738  / # /lava-11181945/bin/lava-test-runner /la=
va-11181945/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8c53e1dda70c14f8ace36

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-149-gcff76fcf64697/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-149-gcff76fcf64697/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8c53e1dda70c14f8ace3b
        failing since 125 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-01T08:41:26.388587  <8>[   10.643005] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11181925_1.4.2.3.1>

    2023-08-01T08:41:26.392032  + set +x

    2023-08-01T08:41:26.498058  =


    2023-08-01T08:41:26.599989  / # #export SHELL=3D/bin/sh

    2023-08-01T08:41:26.600604  =


    2023-08-01T08:41:26.702023  / # export SHELL=3D/bin/sh. /lava-11181925/=
environment

    2023-08-01T08:41:26.702862  =


    2023-08-01T08:41:26.804202  / # . /lava-11181925/environment/lava-11181=
925/bin/lava-test-runner /lava-11181925/1

    2023-08-01T08:41:26.805533  =


    2023-08-01T08:41:26.810882  / # /lava-11181925/bin/lava-test-runner /la=
va-11181925/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8c5718072edcb138ace1f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-149-gcff76fcf64697/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-149-gcff76fcf64697/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8c5718072edcb138ace24
        failing since 125 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-01T08:42:01.847459  + <8>[    8.556416] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11181951_1.4.2.3.1>

    2023-08-01T08:42:01.847565  set +x

    2023-08-01T08:42:01.952025  / # #

    2023-08-01T08:42:02.052657  export SHELL=3D/bin/sh

    2023-08-01T08:42:02.052807  #

    2023-08-01T08:42:02.153285  / # export SHELL=3D/bin/sh. /lava-11181951/=
environment

    2023-08-01T08:42:02.153459  =


    2023-08-01T08:42:02.254008  / # . /lava-11181951/environment/lava-11181=
951/bin/lava-test-runner /lava-11181951/1

    2023-08-01T08:42:02.254246  =


    2023-08-01T08:42:02.259226  / # /lava-11181951/bin/lava-test-runner /la=
va-11181951/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8c85e2fee38112f8ace71

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-149-gcff76fcf64697/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baselin=
e-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-149-gcff76fcf64697/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baselin=
e-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8c85e2fee38112f8ace76
        failing since 182 days (last pass: v5.15.81-122-gc5f8d4a5d3c8, firs=
t fail: v5.15.90-205-g5605d15db022)

    2023-08-01T08:54:41.430847  + set +x
    2023-08-01T08:54:41.431074  [    9.442042] <LAVA_SIGNAL_ENDRUN 0_dmesg =
996720_1.5.2.3.1>
    2023-08-01T08:54:41.538807  / # #
    2023-08-01T08:54:41.640368  export SHELL=3D/bin/sh
    2023-08-01T08:54:41.640884  #
    2023-08-01T08:54:41.742185  / # export SHELL=3D/bin/sh. /lava-996720/en=
vironment
    2023-08-01T08:54:41.742639  =

    2023-08-01T08:54:41.843899  / # . /lava-996720/environment/lava-996720/=
bin/lava-test-runner /lava-996720/1
    2023-08-01T08:54:41.844759  =

    2023-08-01T08:54:41.847079  / # /lava-996720/bin/lava-test-runner /lava=
-996720/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
kontron-pitx-imx8m           | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 2          =


  Details:     https://kernelci.org/test/plan/id/64c8c56accefd296518ace52

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-149-gcff76fcf64697/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-p=
itx-imx8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-149-gcff76fcf64697/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-p=
itx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8c56accefd296518ace55
        new failure (last pass: v5.15.123)

    2023-08-01T08:41:53.406837  / # #
    2023-08-01T08:41:53.508675  export SHELL=3D/bin/sh
    2023-08-01T08:41:53.509366  #
    2023-08-01T08:41:53.610717  / # export SHELL=3D/bin/sh. /lava-372926/en=
vironment
    2023-08-01T08:41:53.611356  =

    2023-08-01T08:41:53.712478  / # . /lava-372926/environment/lava-372926/=
bin/lava-test-runner /lava-372926/1
    2023-08-01T08:41:53.713611  =

    2023-08-01T08:41:53.719208  / # /lava-372926/bin/lava-test-runner /lava=
-372926/1
    2023-08-01T08:41:53.779524  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-01T08:41:53.779941  + cd /l<8>[   12.117969] <LAVA_SIGNAL_START=
RUN 1_bootrr 372926_1.5.2.4.5> =

    ... (10 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/64c=
8c56accefd296518ace65
        new failure (last pass: v5.15.123)

    2023-08-01T08:41:56.098522  /lava-372926/1/../bin/lava-test-case
    2023-08-01T08:41:56.098942  <8>[   14.531694] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>
    2023-08-01T08:41:56.099237  /lava-372926/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8c5531dda70c14f8ace5f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-149-gcff76fcf64697/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-149-gcff76fcf64697/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8c5531dda70c14f8ace64
        failing since 125 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-01T08:41:34.278930  + set +x<8>[   11.684219] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11181938_1.4.2.3.1>

    2023-08-01T08:41:34.279128  =


    2023-08-01T08:41:34.384005  / # #

    2023-08-01T08:41:34.486560  export SHELL=3D/bin/sh

    2023-08-01T08:41:34.487319  #

    2023-08-01T08:41:34.588854  / # export SHELL=3D/bin/sh. /lava-11181938/=
environment

    2023-08-01T08:41:34.589612  =


    2023-08-01T08:41:34.690983  / # . /lava-11181938/environment/lava-11181=
938/bin/lava-test-runner /lava-11181938/1

    2023-08-01T08:41:34.692092  =


    2023-08-01T08:41:34.697407  / # /lava-11181938/bin/lava-test-runner /la=
va-11181938/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8c57a1ec7b31d5f8ace1c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-149-gcff76fcf64697/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m=
1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-149-gcff76fcf64697/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m=
1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8c57a1ec7b31d5f8ace21
        failing since 12 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-08-01T08:42:45.434904  / # #

    2023-08-01T08:42:46.515382  export SHELL=3D/bin/sh

    2023-08-01T08:42:46.517292  #

    2023-08-01T08:42:48.008622  / # export SHELL=3D/bin/sh. /lava-11181958/=
environment

    2023-08-01T08:42:48.010526  =


    2023-08-01T08:42:50.734021  / # . /lava-11181958/environment/lava-11181=
958/bin/lava-test-runner /lava-11181958/1

    2023-08-01T08:42:50.736349  =


    2023-08-01T08:42:50.745459  / # /lava-11181958/bin/lava-test-runner /la=
va-11181958/1

    2023-08-01T08:42:50.807870  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-01T08:42:50.808389  + cd /lava-111819<8>[   25.529751] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11181958_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8c5727a04e2536a8ace6a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-149-gcff76fcf64697/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-=
h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-149-gcff76fcf64697/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-=
h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8c5727a04e2536a8ace6f
        failing since 12 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-08-01T08:44:00.259288  / # #

    2023-08-01T08:44:00.361479  export SHELL=3D/bin/sh

    2023-08-01T08:44:00.362207  #

    2023-08-01T08:44:00.463385  / # export SHELL=3D/bin/sh. /lava-11181948/=
environment

    2023-08-01T08:44:00.463754  =


    2023-08-01T08:44:00.564653  / # . /lava-11181948/environment/lava-11181=
948/bin/lava-test-runner /lava-11181948/1

    2023-08-01T08:44:00.565805  =


    2023-08-01T08:44:00.566978  / # /lava-11181948/bin/lava-test-runner /la=
va-11181948/1

    2023-08-01T08:44:00.641251  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-01T08:44:00.641756  + cd /lava-1118194<8>[   16.910982] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11181948_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
