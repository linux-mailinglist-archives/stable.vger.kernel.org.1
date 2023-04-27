Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE246F0A16
	for <lists+stable@lfdr.de>; Thu, 27 Apr 2023 18:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243932AbjD0QmX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Apr 2023 12:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244042AbjD0QmW (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Apr 2023 12:42:22 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECCA421E
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 09:42:19 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b620188aeso10103438b3a.0
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 09:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682613738; x=1685205738;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jUYTgiohC1NSo3aj/2mccWFzgjg0WZbQfgt3w4HU6w0=;
        b=y45SqVKqsSUAKybN/jk3FJ+Zp/xTvyjM+XIMKOQY3+5iGOp0AAJkhLkJ4OfH097kO+
         WkTog2vGRq+pVy7xcG/bhIMVsYBEv5M/p2sNfjBkbXDmskHla+/5EGdpEHJCsPwdspMU
         bJQS8uiVISuFDR7dhcIcdOqE38ljmSSstbAnUrulcIBGXFC3yF5NTbQNkWHayPc3EoF/
         po1avwa6NzpCakOQ6YaMjX396DhNZVE/9gPG2TDPeR5cKnSZvl8kgkJRwM59omfievsj
         g1pdfOAv/BkJG5Xbkt6vhsmnDMn68UDfxUA8/wcBg8UKPHrHD0bSe3A34QtgI7r9tOSf
         8m3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682613739; x=1685205739;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jUYTgiohC1NSo3aj/2mccWFzgjg0WZbQfgt3w4HU6w0=;
        b=WUGTmD9OzqwvcgJ85jjr4siX2+o8HxCewIxLeYD9hDSznCsEDeD05Ugber4gkx05Np
         14W3kuA98Hbg+z2lia9+q0eadXVke4sBdbqhhaRD3C7GBlgsniJPIdkpZB6MQZF6zzOA
         YJLNSC21aV5/I3Eul18DAcZD48m1jLTPAdRbFGXAYzg2hI880vbSoCNNf5PgDEvB53Q3
         odbwNfhkmofQGV/LbsDdj7OI0KZMPwKnlvWQGxETj5EqpIAPL88d6kOw+lCnQ3YGGbm4
         mGtLG9vpgyFC6q3nJEmrlwpEUuSTHvlltDbhi8Cixpe4SATn48zmmNf+gx555h1vfgEG
         ipxw==
X-Gm-Message-State: AC+VfDzg4iuRDfpB2M7LZf1S6kFC7V8fWME06AZZJQSO2zeBXH/AseaQ
        Lr4kHZZf7OgQQM7CAkoto4888T8R/01J+JC2QyM=
X-Google-Smtp-Source: ACHHUZ6jZTKMsrI6Gt41h3kxtB5B+Hs6Fxg5N3BikxmLvixKw02wKso5vT0hxQKcZNjSGNilJwKuTg==
X-Received: by 2002:a05:6a21:3387:b0:ef:a31b:af8b with SMTP id yy7-20020a056a21338700b000efa31baf8bmr2861975pzb.24.1682613738518;
        Thu, 27 Apr 2023 09:42:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q10-20020a63d60a000000b0051eff0a70d7sm11361757pgg.94.2023.04.27.09.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 09:42:17 -0700 (PDT)
Message-ID: <644aa5e9.630a0220.eeea6.71f4@mx.google.com>
Date:   Thu, 27 Apr 2023 09:42:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.176-369-g3210d913e968
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 123 runs,
 7 regressions (v5.10.176-369-g3210d913e968)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/queue/5.10 baseline: 123 runs, 7 regressions (v5.10.176-369-g3210=
d913e968)

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

imx6q-var-dt6customboard     | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.176-369-g3210d913e968/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.176-369-g3210d913e968
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      3210d913e9686b72ad439260108c5456c244a9fb =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/644a6eea27f8753a7f2e8622

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-369-g3210d913e968/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-369-g3210d913e968/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a6eea27f8753a7f2e8657
        failing since 72 days (last pass: v5.10.167-127-g921934d621e4, firs=
t fail: v5.10.167-139-gf9519a5a1701)

    2023-04-27T12:47:23.495085  <8>[   19.931286] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 394081_1.5.2.4.1>
    2023-04-27T12:47:23.605996  / # #
    2023-04-27T12:47:23.708748  export SHELL=3D/bin/sh
    2023-04-27T12:47:23.709236  #
    2023-04-27T12:47:23.810709  / # export SHELL=3D/bin/sh. /lava-394081/en=
vironment
    2023-04-27T12:47:23.811187  =

    2023-04-27T12:47:23.913013  / # . /lava-394081/environment/lava-394081/=
bin/lava-test-runner /lava-394081/1
    2023-04-27T12:47:23.914553  =

    2023-04-27T12:47:23.917476  / # /lava-394081/bin/lava-test-runner /lava=
-394081/1
    2023-04-27T12:47:24.024407  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644a6df067485338692e85e9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-369-g3210d913e968/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-369-g3210d913e968/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a6df067485338692e85ee
        failing since 91 days (last pass: v5.10.165-76-g5c2e982fcf18, first=
 fail: v5.10.165-77-g4600242c13ed)

    2023-04-27T12:43:13.215189  <8>[   11.014282] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3537303_1.5.2.4.1>
    2023-04-27T12:43:13.327056  / # #
    2023-04-27T12:43:13.430647  export SHELL=3D/bin/sh
    2023-04-27T12:43:13.431741  #
    2023-04-27T12:43:13.534089  / # export SHELL=3D/bin/sh. /lava-3537303/e=
nvironment
    2023-04-27T12:43:13.535474  =

    2023-04-27T12:43:13.638139  / # . /lava-3537303/environment/lava-353730=
3/bin/lava-test-runner /lava-3537303/1
    2023-04-27T12:43:13.639917  =

    2023-04-27T12:43:13.640375  / # <3>[   11.370877] Bluetooth: hci0: comm=
and 0x0c03 tx timeout
    2023-04-27T12:43:13.644613  /lava-3537303/bin/lava-test-runner /lava-35=
37303/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a6d853d5a5aa83a2e8604

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-369-g3210d913e968/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-369-g3210d913e968/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a6d853d5a5aa83a2e8609
        failing since 28 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-04-27T12:41:14.970563  + set +x

    2023-04-27T12:41:14.977082  <8>[   10.674371] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10142458_1.4.2.3.1>

    2023-04-27T12:41:15.081553  / # #

    2023-04-27T12:41:15.182148  export SHELL=3D/bin/sh

    2023-04-27T12:41:15.182323  #

    2023-04-27T12:41:15.282861  / # export SHELL=3D/bin/sh. /lava-10142458/=
environment

    2023-04-27T12:41:15.283077  =


    2023-04-27T12:41:15.383632  / # . /lava-10142458/environment/lava-10142=
458/bin/lava-test-runner /lava-10142458/1

    2023-04-27T12:41:15.383968  =


    2023-04-27T12:41:15.388164  / # /lava-10142458/bin/lava-test-runner /la=
va-10142458/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a6d5f64b2d3bb902e8622

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-369-g3210d913e968/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-369-g3210d913e968/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a6d5f64b2d3bb902e8627
        failing since 28 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-04-27T12:40:53.268178  <8>[   12.347244] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10142457_1.4.2.3.1>

    2023-04-27T12:40:53.271549  + set +x

    2023-04-27T12:40:53.375742  / # #

    2023-04-27T12:40:53.476463  export SHELL=3D/bin/sh

    2023-04-27T12:40:53.476638  #

    2023-04-27T12:40:53.577148  / # export SHELL=3D/bin/sh. /lava-10142457/=
environment

    2023-04-27T12:40:53.577326  =


    2023-04-27T12:40:53.677857  / # . /lava-10142457/environment/lava-10142=
457/bin/lava-test-runner /lava-10142457/1

    2023-04-27T12:40:53.678162  =


    2023-04-27T12:40:53.683592  / # /lava-10142457/bin/lava-test-runner /la=
va-10142457/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-var-dt6customboard     | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644a6d73141d89849d2e85f6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-369-g3210d913e968/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-imx6=
q-var-dt6customboard.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-369-g3210d913e968/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-imx6=
q-var-dt6customboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a6d73141d89849d2e85fb
        new failure (last pass: v5.10.149-456-g9acbbc5f6af9)

    2023-04-27T12:40:56.120394  / # #
    2023-04-27T12:40:56.222295  export SHELL=3D/bin/sh
    2023-04-27T12:40:56.222810  #
    2023-04-27T12:40:56.324196  / # export SHELL=3D/bin/sh. /lava-3537301/e=
nvironment
    2023-04-27T12:40:56.324732  =

    2023-04-27T12:40:56.426085  / # . /lava-3537301/environment/lava-353730=
1/bin/lava-test-runner /lava-3537301/1
    2023-04-27T12:40:56.426774  =

    2023-04-27T12:40:56.432515  / # /lava-3537301/bin/lava-test-runner /lav=
a-3537301/1
    2023-04-27T12:40:56.522417  + export 'TESTRUN_ID=3D1_bootrr'
    2023-04-27T12:40:56.522786  + cd /lava-3537301/1/tests/1_bootrr =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644a6d5d64b2d3bb902e8614

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-369-g3210d913e968/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-stm3=
2mp157c-dk2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-369-g3210d913e968/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-stm3=
2mp157c-dk2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a6d5d64b2d3bb902e8619
        failing since 84 days (last pass: v5.10.147-29-g9a9285d3dc114, firs=
t fail: v5.10.165-149-ge30e8271d674)

    2023-04-27T12:40:42.060328  <8>[   11.668617] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3537293_1.5.2.4.1>
    2023-04-27T12:40:42.167334  / # #
    2023-04-27T12:40:42.269117  export SHELL=3D/bin/sh
    2023-04-27T12:40:42.269555  #
    2023-04-27T12:40:42.370896  / # export SHELL=3D/bin/sh. /lava-3537293/e=
nvironment
    2023-04-27T12:40:42.371373  =

    2023-04-27T12:40:42.472737  / # . /lava-3537293/environment/lava-353729=
3/bin/lava-test-runner /lava-3537293/1
    2023-04-27T12:40:42.473493  =

    2023-04-27T12:40:42.477455  / # /lava-3537293/bin/lava-test-runner /lav=
a-3537293/1
    2023-04-27T12:40:42.543355  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644a730b85cd66c11b2e8621

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-369-g3210d913e968/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-369-g3210d913e968/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a730b85cd66c11b2e8626
        failing since 84 days (last pass: v5.10.165-139-gefb57ce0f880, firs=
t fail: v5.10.165-149-ge30e8271d674)

    2023-04-27T13:04:54.622356  / # #
    2023-04-27T13:04:54.724067  export SHELL=3D/bin/sh
    2023-04-27T13:04:54.724426  #
    2023-04-27T13:04:54.825832  / # export SHELL=3D/bin/sh. /lava-3537292/e=
nvironment
    2023-04-27T13:04:54.826385  =

    2023-04-27T13:04:54.927818  / # . /lava-3537292/environment/lava-353729=
2/bin/lava-test-runner /lava-3537292/1
    2023-04-27T13:04:54.928602  =

    2023-04-27T13:04:54.933741  / # /lava-3537292/bin/lava-test-runner /lav=
a-3537292/1
    2023-04-27T13:04:54.997873  + export 'TESTRUN_ID=3D1_bootrr'
    2023-04-27T13:04:55.032558  + cd /lava-3537292/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
