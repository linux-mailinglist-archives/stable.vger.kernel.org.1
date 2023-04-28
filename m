Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBA76F1EB5
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 21:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjD1TWn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 15:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjD1TWm (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 15:22:42 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1605A40E4
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 12:22:40 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1a6f0d8cdfeso2707015ad.2
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 12:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682709759; x=1685301759;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7grNDNq1cnDcDptrw1tqEfLSwggf0PFxV/jmV/vvdDw=;
        b=ZvxwCaEufJMqy84jPh8fStKMpYEB1ZTncw2+ItxK2/DuE7vBUk7UbTAfgVE6Yq4bAQ
         3PHv2e8fhl7YVEmRqJvFrt8ImTP+Gb4BolRVrYILBMlvauqQtdgH2RR1oUC3w68vAJkl
         K/2UDPM0SsmS8uIQ7i43/Q4oS5T06dcqTEXPoM1+E3eGdVzadgAswkwf1Fe83QkL79Ci
         sans1DoNcKIqnpJDvd7kmgFxAFBA9gCsavvKDSr3xDQAvpRigSaxcslN0Cnv161xGqBA
         OcHaZVkFm2MPBLZeuzZlkmM0IGZ+NCvQNiiB7UUIjFy9YiKY0ukxr0MKfm4O510wqKKe
         G43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682709759; x=1685301759;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7grNDNq1cnDcDptrw1tqEfLSwggf0PFxV/jmV/vvdDw=;
        b=caAq9ponq9hCV3TlMYb945j626yijSP2t1q0Um7s0pvSl4KeYrfyi0/mjb/R+bphNO
         pMjVHY7VG3vabcaXqpKCjB/mDDIywXQ+Z8ry/dXVN9TVzQ7y4IL0j5SCfHAgy7BqqErm
         Fr2KbH7RhP8PZvM2jL5OIAwSVnLbzwQFLeVLaP95R7ccDK3tNJ6qHFct9YvGo/hLVulL
         Kff/iMvjIVR78HvEW7+20liEhuNDAtID5I9V6MM0RwVldbnbwBEtY9MJpvsL5sA1L1pB
         17OBsA6obNhAt0llb19M1T2Evh+p/5Fd8Ivl0GYw0COKm1q2irNmnhMzdwUBSYPWHNTq
         DoSA==
X-Gm-Message-State: AC+VfDywPZUuSceKPxUI2GQ4jfoHWmG47AYg+xTP4Khgcca1p1K5+QNG
        hfkcbZU8TL9dTB70EB+5Jp0+NlzjlLNpIV8JZfM=
X-Google-Smtp-Source: ACHHUZ6is+CZ3DLVI5gkqr7UtLSMhfIZ7tMUiSLoDjb6AMV/vcflqV5hFM/OkwAOhzoqjgWP0drsdA==
X-Received: by 2002:a17:902:d2c2:b0:19d:297:f30b with SMTP id n2-20020a170902d2c200b0019d0297f30bmr7627069plc.19.1682709759059;
        Fri, 28 Apr 2023 12:22:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g4-20020a1709026b4400b0019a6cce2060sm13543797plt.57.2023.04.28.12.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 12:22:38 -0700 (PDT)
Message-ID: <644c1cfe.170a0220.a9f54.d194@mx.google.com>
Date:   Fri, 28 Apr 2023 12:22:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.19.279-177-g3ea9da44137b
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-4.19.y baseline: 111 runs,
 3 regressions (v4.19.279-177-g3ea9da44137b)
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

stable-rc/linux-4.19.y baseline: 111 runs, 3 regressions (v4.19.279-177-g3e=
a9da44137b)

Regressions Summary
-------------------

platform         | arch | lab          | compiler | defconfig           | r=
egressions
-----------------+------+--------------+----------+---------------------+--=
----------
at91sam9g20ek    | arm  | lab-broonie  | gcc-10   | multi_v5_defconfig  | 1=
          =

beaglebone-black | arm  | lab-cip      | gcc-10   | omap2plus_defconfig | 1=
          =

cubietruck       | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig  | 1=
          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.19.y/ker=
nel/v4.19.279-177-g3ea9da44137b/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.279-177-g3ea9da44137b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      3ea9da44137b3577b0f510bbbf0f3aaf375fdf9a =



Test Regressions
---------------- =



platform         | arch | lab          | compiler | defconfig           | r=
egressions
-----------------+------+--------------+----------+---------------------+--=
----------
at91sam9g20ek    | arm  | lab-broonie  | gcc-10   | multi_v5_defconfig  | 1=
          =


  Details:     https://kernelci.org/test/plan/id/644be2cc7f377e12042e85f6

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
79-177-g3ea9da44137b/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at9=
1sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
79-177-g3ea9da44137b/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at9=
1sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644be2cc7f377e12042e8627
        new failure (last pass: v4.19.279-177-g91ed867e7ad5)

    2023-04-28T15:13:39.775174  + set +x
    2023-04-28T15:13:39.780371  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 398557_1.5.2=
.4.1>
    2023-04-28T15:13:39.893850  / # #
    2023-04-28T15:13:39.996742  export SHELL=3D/bin/sh
    2023-04-28T15:13:39.997530  #
    2023-04-28T15:13:40.099465  / # export SHELL=3D/bin/sh. /lava-398557/en=
vironment
    2023-04-28T15:13:40.100257  =

    2023-04-28T15:13:40.202270  / # . /lava-398557/environment/lava-398557/=
bin/lava-test-runner /lava-398557/1
    2023-04-28T15:13:40.203618  =

    2023-04-28T15:13:40.210095  / # /lava-398557/bin/lava-test-runner /lava=
-398557/1 =

    ... (12 line(s) more)  =

 =



platform         | arch | lab          | compiler | defconfig           | r=
egressions
-----------------+------+--------------+----------+---------------------+--=
----------
beaglebone-black | arm  | lab-cip      | gcc-10   | omap2plus_defconfig | 1=
          =


  Details:     https://kernelci.org/test/plan/id/644be55cea7d8cb18d2e85f8

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
79-177-g3ea9da44137b/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beagle=
bone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
79-177-g3ea9da44137b/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beagle=
bone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644be55cea7d8cb18d2e85fb
        new failure (last pass: v4.19.279-173-g8ca3c8d286160)

    2023-04-28T15:24:44.541354  / # #
    2023-04-28T15:24:44.644709  export SHELL=3D/bin/sh
    2023-04-28T15:24:44.645770  #
    2023-04-28T15:24:44.747792  / # export SHELL=3D/bin/sh. /lava-919661/en=
vironment
    2023-04-28T15:24:44.748190  =

    2023-04-28T15:24:44.849802  / # . /lava-919661/environment/lava-919661/=
bin/lava-test-runner /lava-919661/1
    2023-04-28T15:24:44.851377  =

    2023-04-28T15:24:44.863912  / # /lava-919661/bin/lava-test-runner /lava=
-919661/1
    2023-04-28T15:24:45.074549  + export 'TESTRUN_ID=3D1_bootrr'
    2023-04-28T15:24:45.075274  + cd /lava-919661/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform         | arch | lab          | compiler | defconfig           | r=
egressions
-----------------+------+--------------+----------+---------------------+--=
----------
cubietruck       | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig  | 1=
          =


  Details:     https://kernelci.org/test/plan/id/644be7c9be2c78f1c82e865a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
79-177-g3ea9da44137b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
79-177-g3ea9da44137b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644be7c9be2c78f1c82e865f
        failing since 101 days (last pass: v4.19.268-50-gbf741d1d7e6d, firs=
t fail: v4.19.269-522-gc75d2b5524ab)

    2023-04-28T15:35:25.504912  <8>[    7.210034] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3541370_1.5.2.4.1>
    2023-04-28T15:35:25.615105  / # #
    2023-04-28T15:35:25.718672  export SHELL=3D/bin/sh
    2023-04-28T15:35:25.720022  #
    2023-04-28T15:35:25.822567  / # export SHELL=3D/bin/sh. /lava-3541370/e=
nvironment
    2023-04-28T15:35:25.823857  =

    2023-04-28T15:35:25.926152  / # . /lava-3541370/environment/lava-354137=
0/bin/lava-test-runner /lava-3541370/1
    2023-04-28T15:35:25.928078  =

    2023-04-28T15:35:25.933152  / # /lava-3541370/bin/lava-test-runner /lav=
a-3541370/1
    2023-04-28T15:35:26.015542  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
