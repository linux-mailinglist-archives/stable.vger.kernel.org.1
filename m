Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D523078E07B
	for <lists+stable@lfdr.de>; Wed, 30 Aug 2023 22:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbjH3UT3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 30 Aug 2023 16:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241359AbjH3UTZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 30 Aug 2023 16:19:25 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D2C1BD5
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 13:18:49 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bf11b1c7d0so9043675ad.0
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 13:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693426661; x=1694031461; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bLolZ8fNf9GSwZj+44js8GVnUwLLZfPrQ/MhdiTy5x8=;
        b=VsKWlqXUdQlDvVBIhqDKAz5f9nbVFtesCj9s0ulTVGkEu5UgkPvvaRMkflmmpX2IXD
         yT8sOVqSBkEe3ruzk+OHe8z/4jEzw0xFIevLV/Qg1lNwJWSvfLYXdBoE9SgWyYR/+GqL
         AEe6YbjVmCtqrh7x9fQB4GVlTFoEuqeaFqfrS0b/uQGoSMYXxF2I2B5+FMTXqvcsyJno
         tmTotuj1oG8WlhyFb0/1wW+ClazukltOYQY6M1MCYhq8F4xB7UjJXlqpYkXjNo6d3M9v
         csY39vJteNk05qMb0i6kpBk8Qj8SbYZYeZ9O4Q2JOygAq1lJ3to3uGwBEpYRAZAmjsTT
         y3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693426661; x=1694031461;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bLolZ8fNf9GSwZj+44js8GVnUwLLZfPrQ/MhdiTy5x8=;
        b=GkRkBcg27vVXSt6RIwVw7noMALhdpkcnQVjFn5tSn3dsvMlMCdKuNM/rVInH7yg4t3
         Qzdz4utbAORVl00TD5aOv/BuyMkannQKEQ6JeT2v0f7dbo7Orz+RKB9t1IttObF1YhSd
         FaaoXgZupZkSLIoIWC+BbCOYrANncAzyaIQ175YpFlKJS7DIY+R8C7AJ/XsMClphU66i
         jvpbIjpiCGmCSy2D4+/YXUTEn+pTLBa6tOhx7MrPtPSGQe49Ln3MNqk//A4uTaAyOqJa
         C1/AHTa9h0MaVKXj6Evi8ZoNoFQ1ccLsMvEdr3/GeFKcgk8w71+AXKeMl2GKP9ijjFTz
         1P2w==
X-Gm-Message-State: AOJu0Yzeb+/ot2tThtVcLOchjlvwXfq0f+pNzUqW0jWcFL7Thj5CDC1V
        GG/FPE2NJyTwViYc3MeYerlmoSz5X+GBHlw+BeY=
X-Google-Smtp-Source: AGHT+IGOyqJoGZen8EUCv0WecaVnHkR0IcnkZSvSSVoJoa8jVuilIOvMWw76Ed0YtpbY2Fjove3agA==
X-Received: by 2002:a17:90b:3004:b0:26b:2ba4:add8 with SMTP id hg4-20020a17090b300400b0026b2ba4add8mr1004251pjb.21.1693426660142;
        Wed, 30 Aug 2023 13:17:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z11-20020a63b04b000000b00565ec002d14sm10807621pgo.33.2023.08.30.13.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 13:17:39 -0700 (PDT)
Message-ID: <64efa3e3.630a0220.68bf7.11f3@mx.google.com>
Date:   Wed, 30 Aug 2023 13:17:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.129
Subject: stable/linux-5.15.y baseline: 172 runs, 25 regressions (v5.15.129)
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

stable/linux-5.15.y baseline: 172 runs, 25 regressions (v5.15.129)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =

mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.15.y/kernel=
/v5.15.129/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.15.y
  Describe: v5.15.129
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      9e43368a3393dd40002cecb63e13af285be270fc =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef6939ad73a01f3b286dc1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef6939ad73a01f3b286dca
        failing since 153 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-30T16:07:05.092893  <8>[   10.885468] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11384948_1.4.2.3.1>

    2023-08-30T16:07:05.096415  + set +x

    2023-08-30T16:07:05.200790  / # #

    2023-08-30T16:07:05.301520  export SHELL=3D/bin/sh

    2023-08-30T16:07:05.301675  #

    2023-08-30T16:07:05.402176  / # export SHELL=3D/bin/sh. /lava-11384948/=
environment

    2023-08-30T16:07:05.402337  =


    2023-08-30T16:07:05.502835  / # . /lava-11384948/environment/lava-11384=
948/bin/lava-test-runner /lava-11384948/1

    2023-08-30T16:07:05.503119  =


    2023-08-30T16:07:05.509030  / # /lava-11384948/bin/lava-test-runner /la=
va-11384948/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef69ee48003436bf286d9a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef69ee48003436bf286da3
        failing since 153 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-30T16:09:58.960941  + set +x

    2023-08-30T16:09:58.967516  <8>[   11.656136] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11384974_1.4.2.3.1>

    2023-08-30T16:09:59.075571  / # #

    2023-08-30T16:09:59.177930  export SHELL=3D/bin/sh

    2023-08-30T16:09:59.178604  #

    2023-08-30T16:09:59.280003  / # export SHELL=3D/bin/sh. /lava-11384974/=
environment

    2023-08-30T16:09:59.280980  =


    2023-08-30T16:09:59.382907  / # . /lava-11384974/environment/lava-11384=
974/bin/lava-test-runner /lava-11384974/1

    2023-08-30T16:09:59.384557  =


    2023-08-30T16:09:59.390064  / # /lava-11384974/bin/lava-test-runner /la=
va-11384974/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef69471f5329b6d4286d77

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef69471f5329b6d4286d80
        failing since 153 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-30T16:07:14.692445  + set<8>[   12.033647] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11384950_1.4.2.3.1>

    2023-08-30T16:07:14.692921   +x

    2023-08-30T16:07:14.801129  / # #

    2023-08-30T16:07:14.903405  export SHELL=3D/bin/sh

    2023-08-30T16:07:14.904016  #

    2023-08-30T16:07:15.005009  / # export SHELL=3D/bin/sh. /lava-11384950/=
environment

    2023-08-30T16:07:15.005429  =


    2023-08-30T16:07:15.106464  / # . /lava-11384950/environment/lava-11384=
950/bin/lava-test-runner /lava-11384950/1

    2023-08-30T16:07:15.107535  =


    2023-08-30T16:07:15.112668  / # /lava-11384950/bin/lava-test-runner /la=
va-11384950/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef69f77ea1f21f76286d77

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef69f77ea1f21f76286d80
        failing since 153 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-30T16:10:10.415889  + <8>[   12.111409] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11384992_1.4.2.3.1>

    2023-08-30T16:10:10.416360  set +x

    2023-08-30T16:10:10.525372  / # #

    2023-08-30T16:10:10.628250  export SHELL=3D/bin/sh

    2023-08-30T16:10:10.629109  #

    2023-08-30T16:10:10.730881  / # export SHELL=3D/bin/sh. /lava-11384992/=
environment

    2023-08-30T16:10:10.731809  =


    2023-08-30T16:10:10.833638  / # . /lava-11384992/environment/lava-11384=
992/bin/lava-test-runner /lava-11384992/1

    2023-08-30T16:10:10.834109  =


    2023-08-30T16:10:10.839288  / # /lava-11384992/bin/lava-test-runner /la=
va-11384992/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef6946e133e329af286daa

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef6946e133e329af286db3
        failing since 153 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-30T16:07:13.293573  <8>[   10.495858] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11384949_1.4.2.3.1>

    2023-08-30T16:07:13.297134  + set +x

    2023-08-30T16:07:13.402711  =


    2023-08-30T16:07:13.504495  / # #export SHELL=3D/bin/sh

    2023-08-30T16:07:13.505342  =


    2023-08-30T16:07:13.606992  / # export SHELL=3D/bin/sh. /lava-11384949/=
environment

    2023-08-30T16:07:13.607730  =


    2023-08-30T16:07:13.709160  / # . /lava-11384949/environment/lava-11384=
949/bin/lava-test-runner /lava-11384949/1

    2023-08-30T16:07:13.710379  =


    2023-08-30T16:07:13.715381  / # /lava-11384949/bin/lava-test-runner /la=
va-11384949/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef69ec93296a9f25286dbf

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef69ec93296a9f25286dc8
        failing since 153 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-30T16:10:04.086365  <8>[   11.545608] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11384990_1.4.2.3.1>

    2023-08-30T16:10:04.090049  + set +x

    2023-08-30T16:10:04.195753  =


    2023-08-30T16:10:04.297532  / # #export SHELL=3D/bin/sh

    2023-08-30T16:10:04.298262  =


    2023-08-30T16:10:04.399900  / # export SHELL=3D/bin/sh. /lava-11384990/=
environment

    2023-08-30T16:10:04.400748  =


    2023-08-30T16:10:04.502296  / # . /lava-11384990/environment/lava-11384=
990/bin/lava-test-runner /lava-11384990/1

    2023-08-30T16:10:04.503551  =


    2023-08-30T16:10:04.508777  / # /lava-11384990/bin/lava-test-runner /la=
va-11384990/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef6bc6171e5b351f286d70

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-sama5d4_xplained.t=
xt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-sama5d4_xplained.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef6bc6171e5b351f286=
d71
        new failure (last pass: v5.15.128) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef6d727bfc742924286d89

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef6d727bfc742924286d92
        failing since 34 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-08-30T16:26:42.912345  / # #

    2023-08-30T16:26:43.014542  export SHELL=3D/bin/sh

    2023-08-30T16:26:43.015244  #

    2023-08-30T16:26:43.116618  / # export SHELL=3D/bin/sh. /lava-11385050/=
environment

    2023-08-30T16:26:43.117400  =


    2023-08-30T16:26:43.218873  / # . /lava-11385050/environment/lava-11385=
050/bin/lava-test-runner /lava-11385050/1

    2023-08-30T16:26:43.220038  =


    2023-08-30T16:26:43.236567  / # /lava-11385050/bin/lava-test-runner /la=
va-11385050/1

    2023-08-30T16:26:43.300542  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-30T16:26:43.344457  + cd /lava-11385050/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef6d58a32e5a7b62286d7c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef6d58a32e5a7b62286=
d7d
        failing since 147 days (last pass: v5.15.105, first fail: v5.15.106=
) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef6b1214dfce9e62286da2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef6b1214dfce9e62286dab
        failing since 223 days (last pass: v5.15.82, first fail: v5.15.89)

    2023-08-30T16:14:53.823615  <8>[    9.929328] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3756205_1.5.2.4.1>
    2023-08-30T16:14:53.933871  / # #
    2023-08-30T16:14:54.037692  export SHELL=3D/bin/sh
    2023-08-30T16:14:54.038800  #
    2023-08-30T16:14:54.141240  / # export SHELL=3D/bin/sh. /lava-3756205/e=
nvironment
    2023-08-30T16:14:54.142289  =

    2023-08-30T16:14:54.244762  / # . /lava-3756205/environment/lava-375620=
5/bin/lava-test-runner /lava-3756205/1
    2023-08-30T16:14:54.246502  =

    2023-08-30T16:14:54.250195  / # /lava-3756205/bin/lava-test-runner /lav=
a-3756205/1
    2023-08-30T16:14:54.340230  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef7383475df4bbba286dbe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef7383475df4bbba286dc1
        failing since 180 days (last pass: v5.15.79, first fail: v5.15.97)

    2023-08-30T16:50:55.990475  [   16.000762] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1248060_1.5.2.4.1>
    2023-08-30T16:50:56.095924  =

    2023-08-30T16:50:56.197194  / # #export SHELL=3D/bin/sh
    2023-08-30T16:50:56.197598  =

    2023-08-30T16:50:56.298577  / # export SHELL=3D/bin/sh. /lava-1248060/e=
nvironment
    2023-08-30T16:50:56.298977  =

    2023-08-30T16:50:56.400018  / # . /lava-1248060/environment/lava-124806=
0/bin/lava-test-runner /lava-1248060/1
    2023-08-30T16:50:56.400783  =

    2023-08-30T16:50:56.404626  / # /lava-1248060/bin/lava-test-runner /lav=
a-1248060/1
    2023-08-30T16:50:56.419535  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef692ee905f226b5286d6d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef692ee905f226b5286d76
        failing since 153 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-30T16:07:16.189898  + set +x

    2023-08-30T16:07:16.196513  <8>[   10.858285] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11384934_1.4.2.3.1>

    2023-08-30T16:07:16.308142  / # #

    2023-08-30T16:07:16.410633  export SHELL=3D/bin/sh

    2023-08-30T16:07:16.411577  #

    2023-08-30T16:07:16.513153  / # export SHELL=3D/bin/sh. /lava-11384934/=
environment

    2023-08-30T16:07:16.513861  =


    2023-08-30T16:07:16.615499  / # . /lava-11384934/environment/lava-11384=
934/bin/lava-test-runner /lava-11384934/1

    2023-08-30T16:07:16.616613  =


    2023-08-30T16:07:16.621260  / # /lava-11384934/bin/lava-test-runner /la=
va-11384934/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef69e148003436bf286d79

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef69e148003436bf286d82
        failing since 153 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-30T16:09:49.935039  + set +x

    2023-08-30T16:09:49.941734  <8>[   12.469424] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11384985_1.4.2.3.1>

    2023-08-30T16:09:50.049838  / # #

    2023-08-30T16:09:50.152270  export SHELL=3D/bin/sh

    2023-08-30T16:09:50.153043  #

    2023-08-30T16:09:50.254509  / # export SHELL=3D/bin/sh. /lava-11384985/=
environment

    2023-08-30T16:09:50.255310  =


    2023-08-30T16:09:50.356834  / # . /lava-11384985/environment/lava-11384=
985/bin/lava-test-runner /lava-11384985/1

    2023-08-30T16:09:50.357984  =


    2023-08-30T16:09:50.363103  / # /lava-11384985/bin/lava-test-runner /la=
va-11384985/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef6932e905f226b5286d8e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef6932e905f226b5286d97
        failing since 153 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-30T16:06:59.281388  + set +x

    2023-08-30T16:06:59.287734  <8>[   10.251427] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11384935_1.4.2.3.1>

    2023-08-30T16:06:59.392250  / # #

    2023-08-30T16:06:59.492905  export SHELL=3D/bin/sh

    2023-08-30T16:06:59.493105  #

    2023-08-30T16:06:59.593616  / # export SHELL=3D/bin/sh. /lava-11384935/=
environment

    2023-08-30T16:06:59.593809  =


    2023-08-30T16:06:59.694395  / # . /lava-11384935/environment/lava-11384=
935/bin/lava-test-runner /lava-11384935/1

    2023-08-30T16:06:59.694695  =


    2023-08-30T16:06:59.700209  / # /lava-11384935/bin/lava-test-runner /la=
va-11384935/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef69c43cec95c64e286db1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef69c43cec95c64e286dba
        failing since 153 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-30T16:09:40.952638  + set<8>[   11.305715] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11384989_1.4.2.3.1>

    2023-08-30T16:09:40.952729   +x

    2023-08-30T16:09:41.054327  #

    2023-08-30T16:09:41.155303  / # #export SHELL=3D/bin/sh

    2023-08-30T16:09:41.155454  =


    2023-08-30T16:09:41.255924  / # export SHELL=3D/bin/sh. /lava-11384989/=
environment

    2023-08-30T16:09:41.256097  =


    2023-08-30T16:09:41.356607  / # . /lava-11384989/environment/lava-11384=
989/bin/lava-test-runner /lava-11384989/1

    2023-08-30T16:09:41.356885  =


    2023-08-30T16:09:41.362369  / # /lava-11384989/bin/lava-test-runner /la=
va-11384989/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef69461f5329b6d4286d6c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef69461f5329b6d4286d75
        failing since 153 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-30T16:07:14.299256  + <8>[   11.347698] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11384926_1.4.2.3.1>

    2023-08-30T16:07:14.299819  set +x

    2023-08-30T16:07:14.407663  / # #

    2023-08-30T16:07:14.510292  export SHELL=3D/bin/sh

    2023-08-30T16:07:14.511082  #

    2023-08-30T16:07:14.612334  / # export SHELL=3D/bin/sh. /lava-11384926/=
environment

    2023-08-30T16:07:14.612555  =


    2023-08-30T16:07:14.713033  / # . /lava-11384926/environment/lava-11384=
926/bin/lava-test-runner /lava-11384926/1

    2023-08-30T16:07:14.713311  =


    2023-08-30T16:07:14.718108  / # /lava-11384926/bin/lava-test-runner /la=
va-11384926/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef69e093296a9f25286d97

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef69e093296a9f25286da0
        failing since 153 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-30T16:10:00.998783  + <8>[    9.646103] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11384968_1.4.2.3.1>

    2023-08-30T16:10:00.999310  set +x

    2023-08-30T16:10:01.106493  / # #

    2023-08-30T16:10:01.207376  export SHELL=3D/bin/sh

    2023-08-30T16:10:01.208142  #

    2023-08-30T16:10:01.309504  / # export SHELL=3D/bin/sh. /lava-11384968/=
environment

    2023-08-30T16:10:01.310224  =


    2023-08-30T16:10:01.411626  / # . /lava-11384968/environment/lava-11384=
968/bin/lava-test-runner /lava-11384968/1

    2023-08-30T16:10:01.412779  =


    2023-08-30T16:10:01.417721  / # /lava-11384968/bin/lava-test-runner /la=
va-11384968/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef6abd524015ce3d286d9c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef6abd524015ce3d286da5
        failing since 153 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-30T16:13:32.689877  <8>[   11.337424] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11384947_1.4.2.3.1>

    2023-08-30T16:13:32.798246  / # #

    2023-08-30T16:13:32.900697  export SHELL=3D/bin/sh

    2023-08-30T16:13:32.901499  #

    2023-08-30T16:13:33.003198  / # export SHELL=3D/bin/sh. /lava-11384947/=
environment

    2023-08-30T16:13:33.004086  =


    2023-08-30T16:13:33.105850  / # . /lava-11384947/environment/lava-11384=
947/bin/lava-test-runner /lava-11384947/1

    2023-08-30T16:13:33.107448  =


    2023-08-30T16:13:33.112370  / # /lava-11384947/bin/lava-test-runner /la=
va-11384947/1

    2023-08-30T16:13:33.118227  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef6b364b6cf39860286d9c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef6b364b6cf39860286da5
        failing since 153 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-30T16:15:25.648612  + <8>[   12.309182] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11384970_1.4.2.3.1>

    2023-08-30T16:15:25.648756  set +x

    2023-08-30T16:15:25.752980  / # #

    2023-08-30T16:15:25.853655  export SHELL=3D/bin/sh

    2023-08-30T16:15:25.853882  #

    2023-08-30T16:15:25.954484  / # export SHELL=3D/bin/sh. /lava-11384970/=
environment

    2023-08-30T16:15:25.954711  =


    2023-08-30T16:15:26.055314  / # . /lava-11384970/environment/lava-11384=
970/bin/lava-test-runner /lava-11384970/1

    2023-08-30T16:15:26.055685  =


    2023-08-30T16:15:26.060195  / # /lava-11384970/bin/lava-test-runner /la=
va-11384970/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef70d901fd5d4d2e286d7c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-baylibre/baseline-mes=
on-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-baylibre/baseline-mes=
on-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef70d901fd5d4d2e286=
d7d
        new failure (last pass: v5.15.128) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef6ea2e3cc36b7bb286dac

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-broonie/baseline-meso=
n-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-broonie/baseline-meso=
n-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef6ea2e3cc36b7bb286=
dad
        new failure (last pass: v5.15.128) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef6e9df79ec88853286d82

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef6e9df79ec88853286=
d83
        failing since 218 days (last pass: v5.15.89, first fail: v5.15.90) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef72eb0e45a60f83286de6

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef72eb0e45a60f83286def
        failing since 34 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-08-30T16:50:11.569787  / # #

    2023-08-30T16:50:11.670566  export SHELL=3D/bin/sh

    2023-08-30T16:50:11.671276  #

    2023-08-30T16:50:11.772696  / # export SHELL=3D/bin/sh. /lava-11385322/=
environment

    2023-08-30T16:50:11.773449  =


    2023-08-30T16:50:11.874911  / # . /lava-11385322/environment/lava-11385=
322/bin/lava-test-runner /lava-11385322/1

    2023-08-30T16:50:11.876000  =


    2023-08-30T16:50:11.883637  / # /lava-11385322/bin/lava-test-runner /la=
va-11385322/1

    2023-08-30T16:50:11.942679  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-30T16:50:11.943192  + cd /lav<8>[   15.991741] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11385322_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef731f2d0e66c6ff286daa

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef731f2d0e66c6ff286daf
        failing since 34 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-08-30T16:49:28.845205  / # #

    2023-08-30T16:49:29.924813  export SHELL=3D/bin/sh

    2023-08-30T16:49:29.926738  #

    2023-08-30T16:49:31.417325  / # export SHELL=3D/bin/sh. /lava-11385328/=
environment

    2023-08-30T16:49:31.419189  =


    2023-08-30T16:49:34.142877  / # . /lava-11385328/environment/lava-11385=
328/bin/lava-test-runner /lava-11385328/1

    2023-08-30T16:49:34.145010  =


    2023-08-30T16:49:34.153354  / # /lava-11385328/bin/lava-test-runner /la=
va-11385328/1

    2023-08-30T16:49:34.215860  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-30T16:49:34.216394  + cd /lava-113853<8>[   25.507410] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11385328_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef73000e45a60f83286ef6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.129/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef73000e45a60f83286eff
        failing since 34 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-08-30T16:50:28.842355  / # #

    2023-08-30T16:50:28.944258  export SHELL=3D/bin/sh

    2023-08-30T16:50:28.944931  #

    2023-08-30T16:50:29.046207  / # export SHELL=3D/bin/sh. /lava-11385325/=
environment

    2023-08-30T16:50:29.046907  =


    2023-08-30T16:50:29.148366  / # . /lava-11385325/environment/lava-11385=
325/bin/lava-test-runner /lava-11385325/1

    2023-08-30T16:50:29.149303  =


    2023-08-30T16:50:29.150493  / # /lava-11385325/bin/lava-test-runner /la=
va-11385325/1

    2023-08-30T16:50:29.193281  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-30T16:50:29.224487  + cd /lava-1138532<8>[   16.830442] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11385325_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
