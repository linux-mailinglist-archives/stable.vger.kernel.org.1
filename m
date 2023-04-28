Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD036F1E16
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 20:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346382AbjD1ScF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 14:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346446AbjD1ScD (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 14:32:03 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DD5FB
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 11:32:01 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b5c4c76aaso256560b3a.2
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 11:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682706720; x=1685298720;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ze6A5nSArXiETPdnpiaGVP9k8SJTLA5xWlwjkURlrGM=;
        b=Xz4YxoDKjrrwQO+QdTszm5DndwDMOR4JcONWJZBvVICiKU6/hFvqX+0KjFuVqmTo0d
         e+mPDNPet4mlXN3Wwhsy0TxFdpKK3xn45B2pwLqZSba5ftQ4vByK9xHqDmV+kX1ktjz/
         OdP3lG7Cx0BM8kp4YMo0XA7KwbrTnftMpCWgCBXczINi3AiGiY8nsj7BrXJp6gbQFgpN
         XF+jlnb+S4dnshc5QE7jiJV+Xbtgg2rGslZ5tv/TzsZBTCExdu13+R5JSK2cjtcaK48g
         k0Fkc61+VPhdqAs08Tt2F6WK7ro1NUluRzSOnWbDp2DvSDDJXOLwCt3wM4b3KC247KL/
         Fuuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682706720; x=1685298720;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ze6A5nSArXiETPdnpiaGVP9k8SJTLA5xWlwjkURlrGM=;
        b=KK4t45+ivn7hhQkb4/RGRO9McE+BulO2SCjB93Y98DEKoHT9DStoVAN4hf+zCseUeg
         1S4SpGNlYYvb3to6nZsN8DhBn0fcnZgRwh2TV97Tq4MG9+z3IP0DadX2jsZ2SZtm7fgO
         8haP/fq/H3pZCiDeVSMuS1mtPO35NuqF/rRrrksCY8JayDSiRNJ7zb87oIvgdzhqBe7E
         KbG3Mna03M98PqGtNm+MoKBrmOyhZAmoZIe0C5zS8R7H7qBW4ms+fivAJqt9bxR9Qa1/
         r+MpN9pgRdJPzVn1/L+jGLXau8cwHcxPTHfdKK9fDbBUTos3Z/BUKpN7TojpEGOBQAbm
         jbOg==
X-Gm-Message-State: AC+VfDystvrmCH9PhuboI7BwALwqIm4Ej3rSfS6fyqHQfXNlFwZJrxH5
        zRzEKbGJbNooCCrKUABGqYbMtKumZmNhikn/+/U=
X-Google-Smtp-Source: ACHHUZ44ggM8f9PMm/IHYWXDLt1hTq2XxTKPhoSU1ZiLarnQbJN85hNQDB0zXmTGUT5xluA1zE34HQ==
X-Received: by 2002:a05:6a00:2d21:b0:63c:e253:a692 with SMTP id fa33-20020a056a002d2100b0063ce253a692mr8721869pfb.15.1682706720206;
        Fri, 28 Apr 2023 11:32:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w18-20020a63d752000000b0051b8172fa68sm13652192pgi.38.2023.04.28.11.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 11:31:59 -0700 (PDT)
Message-ID: <644c111f.630a0220.ebaf1.cf07@mx.google.com>
Date:   Fri, 28 Apr 2023 11:31:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.105-361-g64fb7ad7e758
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.15.y baseline: 135 runs,
 10 regressions (v5.15.105-361-g64fb7ad7e758)
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

stable-rc/linux-5.15.y baseline: 135 runs, 10 regressions (v5.15.105-361-g6=
4fb7ad7e758)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.105-361-g64fb7ad7e758/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.105-361-g64fb7ad7e758
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      64fb7ad7e758c85ebeb0c8c500e4175c65bf5778 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bd62f481ee4e0ff2e8602

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-361-g64fb7ad7e758/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-361-g64fb7ad7e758/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bd62f481ee4e0ff2e8607
        failing since 30 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-04-28T14:20:12.583671  <8>[   10.700137] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10151920_1.4.2.3.1>

    2023-04-28T14:20:12.586879  + set +x

    2023-04-28T14:20:12.693947  / # #

    2023-04-28T14:20:12.794558  export SHELL=3D/bin/sh

    2023-04-28T14:20:12.794748  #

    2023-04-28T14:20:12.895233  / # export SHELL=3D/bin/sh. /lava-10151920/=
environment

    2023-04-28T14:20:12.895426  =


    2023-04-28T14:20:12.995918  / # . /lava-10151920/environment/lava-10151=
920/bin/lava-test-runner /lava-10151920/1

    2023-04-28T14:20:12.996201  =


    2023-04-28T14:20:13.001612  / # /lava-10151920/bin/lava-test-runner /la=
va-10151920/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bd618b0db3ff27f2e860b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-361-g64fb7ad7e758/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-361-g64fb7ad7e758/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bd618b0db3ff27f2e8610
        failing since 30 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-04-28T14:19:58.783400  + set<8>[   11.069805] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10151918_1.4.2.3.1>

    2023-04-28T14:19:58.783486   +x

    2023-04-28T14:19:58.887835  / # #

    2023-04-28T14:19:58.988425  export SHELL=3D/bin/sh

    2023-04-28T14:19:58.988638  #

    2023-04-28T14:19:59.089438  / # export SHELL=3D/bin/sh. /lava-10151918/=
environment

    2023-04-28T14:19:59.090263  =


    2023-04-28T14:19:59.191916  / # . /lava-10151918/environment/lava-10151=
918/bin/lava-test-runner /lava-10151918/1

    2023-04-28T14:19:59.193174  =


    2023-04-28T14:19:59.197753  / # /lava-10151918/bin/lava-test-runner /la=
va-10151918/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bd626b0db3ff27f2e864c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-361-g64fb7ad7e758/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-361-g64fb7ad7e758/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bd626b0db3ff27f2e8651
        failing since 30 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-04-28T14:20:01.830624  <8>[   11.266265] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10151960_1.4.2.3.1>

    2023-04-28T14:20:01.833896  + set +x

    2023-04-28T14:20:01.938729  / # #

    2023-04-28T14:20:02.039451  export SHELL=3D/bin/sh

    2023-04-28T14:20:02.039629  #

    2023-04-28T14:20:02.140150  / # export SHELL=3D/bin/sh. /lava-10151960/=
environment

    2023-04-28T14:20:02.140366  =


    2023-04-28T14:20:02.240887  / # . /lava-10151960/environment/lava-10151=
960/bin/lava-test-runner /lava-10151960/1

    2023-04-28T14:20:02.241156  =


    2023-04-28T14:20:02.245874  / # /lava-10151960/bin/lava-test-runner /la=
va-10151960/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/644bd9cc0797a68daf2e8610

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-361-g64fb7ad7e758/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-361-g64fb7ad7e758/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644bd9cc0797a68daf2e8=
611
        failing since 350 days (last pass: v5.15.37-259-gab77581473a3, firs=
t fail: v5.15.39) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644bd6ac1cb016c2a92e85fd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-361-g64fb7ad7e758/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-361-g64fb7ad7e758/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bd6ac1cb016c2a92e8602
        failing since 101 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-04-28T14:22:10.568900  <8>[    9.868321] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3541202_1.5.2.4.1>
    2023-04-28T14:22:10.577017  <3>[    9.874736] Bluetooth: hci0: command =
0x0c03 tx timeout
    2023-04-28T14:22:10.687257  / # #
    2023-04-28T14:22:10.791116  export SHELL=3D/bin/sh
    2023-04-28T14:22:10.792203  #
    2023-04-28T14:22:10.894558  / # export SHELL=3D/bin/sh. /lava-3541202/e=
nvironment
    2023-04-28T14:22:10.896353  =

    2023-04-28T14:22:11.000112  / # . /lava-3541202/environment/lava-354120=
2/bin/lava-test-runner /lava-3541202/1
    2023-04-28T14:22:11.001995  =

    2023-04-28T14:22:11.006855  / # /lava-3541202/bin/lava-test-runner /lav=
a-3541202/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bd621b0db3ff27f2e8628

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-361-g64fb7ad7e758/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-361-g64fb7ad7e758/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bd621b0db3ff27f2e862d
        failing since 30 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-04-28T14:20:09.610976  + set +x

    2023-04-28T14:20:09.617349  <8>[   11.065360] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10151925_1.4.2.3.1>

    2023-04-28T14:20:09.721943  / # #

    2023-04-28T14:20:09.822621  export SHELL=3D/bin/sh

    2023-04-28T14:20:09.822808  #

    2023-04-28T14:20:09.923463  / # export SHELL=3D/bin/sh. /lava-10151925/=
environment

    2023-04-28T14:20:09.924362  =


    2023-04-28T14:20:10.025827  / # . /lava-10151925/environment/lava-10151=
925/bin/lava-test-runner /lava-10151925/1

    2023-04-28T14:20:10.026236  =


    2023-04-28T14:20:10.031165  / # /lava-10151925/bin/lava-test-runner /la=
va-10151925/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bd61abea5f5077b2e8611

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-361-g64fb7ad7e758/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-361-g64fb7ad7e758/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bd61abea5f5077b2e8616
        failing since 30 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-04-28T14:19:49.760733  + set +x

    2023-04-28T14:19:49.767773  <8>[   10.112561] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10151901_1.4.2.3.1>

    2023-04-28T14:19:49.869685  =


    2023-04-28T14:19:49.970252  / # #export SHELL=3D/bin/sh

    2023-04-28T14:19:49.970414  =


    2023-04-28T14:19:50.070922  / # export SHELL=3D/bin/sh. /lava-10151901/=
environment

    2023-04-28T14:19:50.071109  =


    2023-04-28T14:19:50.171638  / # . /lava-10151901/environment/lava-10151=
901/bin/lava-test-runner /lava-10151901/1

    2023-04-28T14:19:50.171973  =


    2023-04-28T14:19:50.177084  / # /lava-10151901/bin/lava-test-runner /la=
va-10151901/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bd627747ed3af402e8621

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-361-g64fb7ad7e758/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-361-g64fb7ad7e758/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bd627747ed3af402e8626
        failing since 30 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-04-28T14:20:02.523964  + set +x<8>[   10.713349] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10151899_1.4.2.3.1>

    2023-04-28T14:20:02.524046  =


    2023-04-28T14:20:02.628466  / # #

    2023-04-28T14:20:02.729068  export SHELL=3D/bin/sh

    2023-04-28T14:20:02.729330  #

    2023-04-28T14:20:02.829900  / # export SHELL=3D/bin/sh. /lava-10151899/=
environment

    2023-04-28T14:20:02.830088  =


    2023-04-28T14:20:02.930644  / # . /lava-10151899/environment/lava-10151=
899/bin/lava-test-runner /lava-10151899/1

    2023-04-28T14:20:02.930919  =


    2023-04-28T14:20:02.935674  / # /lava-10151899/bin/lava-test-runner /la=
va-10151899/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bd63aa2d8e3aee62e8662

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-361-g64fb7ad7e758/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-361-g64fb7ad7e758/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bd63aa2d8e3aee62e8667
        failing since 30 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-04-28T14:20:18.614901  <8>[   11.054677] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10151931_1.4.2.3.1>

    2023-04-28T14:20:18.719442  / # #

    2023-04-28T14:20:18.820122  export SHELL=3D/bin/sh

    2023-04-28T14:20:18.820305  #

    2023-04-28T14:20:18.920804  / # export SHELL=3D/bin/sh. /lava-10151931/=
environment

    2023-04-28T14:20:18.920992  =


    2023-04-28T14:20:19.021530  / # . /lava-10151931/environment/lava-10151=
931/bin/lava-test-runner /lava-10151931/1

    2023-04-28T14:20:19.021792  =


    2023-04-28T14:20:19.026731  / # /lava-10151931/bin/lava-test-runner /la=
va-10151931/1

    2023-04-28T14:20:19.031920  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644bd65bc1de2751cb2e85fd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-361-g64fb7ad7e758/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-st=
m32mp157c-dk2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-361-g64fb7ad7e758/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-st=
m32mp157c-dk2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bd65bc1de2751cb2e8602
        failing since 82 days (last pass: v5.15.59, first fail: v5.15.91-21=
-gd8296a906e7a)

    2023-04-28T14:21:05.485246  <8>[   10.492274] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3541194_1.5.2.4.1>
    2023-04-28T14:21:05.591148  / # #
    2023-04-28T14:21:05.692879  export SHELL=3D/bin/sh
    2023-04-28T14:21:05.693323  #
    2023-04-28T14:21:05.794698  / # export SHELL=3D/bin/sh. /lava-3541194/e=
nvironment
    2023-04-28T14:21:05.795354  =

    2023-04-28T14:21:05.896932  / # . /lava-3541194/environment/lava-354119=
4/bin/lava-test-runner /lava-3541194/1
    2023-04-28T14:21:05.897708  =

    2023-04-28T14:21:05.902174  / # /lava-3541194/bin/lava-test-runner /lav=
a-3541194/1
    2023-04-28T14:21:05.969145  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
