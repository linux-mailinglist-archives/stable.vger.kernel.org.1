Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A7076535A
	for <lists+stable@lfdr.de>; Thu, 27 Jul 2023 14:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjG0MM2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Jul 2023 08:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjG0MM1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Jul 2023 08:12:27 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB842D5F
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 05:12:20 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b8b4748fe4so5829615ad.1
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 05:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690459939; x=1691064739;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zC9YRqeBZZO7PtMiPXzg1D5y97EUqfHzQHojAzkNeLA=;
        b=Pe7i7BdTq/uGW5Q+hi93YAT22xuloEds1E+1TYo2JF4klc+8vqmzxws/bUHzp+3mmH
         DlxKfXAlgOqylTq9yp96tV47OoODm+qrB+r2DoXT+X/Ddey/qTmzoCV0vXrb67EYOEIg
         Io3bhsUi1Xy8lFx7dg3lTOiEqGF72FbRBIwLNJU3hqlX2myDYJA5E2V5TUXKBFI8jxPF
         B0nFk3udr/Rk0yiwh5M2i0zZhq4mc93mfi47eoIprt283+yKe6ybGPq/sy1dD9kC1cAG
         h110XdBJyf3GDBSoNcRGeN7dl2G8qYqoKi0xRWcDJDqgjbVwzDFRoLH5dcxtUB3Ees72
         Rpvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690459939; x=1691064739;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zC9YRqeBZZO7PtMiPXzg1D5y97EUqfHzQHojAzkNeLA=;
        b=A+ab92sLRA6Uy6RjX6lgVZhHlMwnXHYLfweMV7L66enDxztN3uWFzyRhzxEMpoWMWB
         pKF7nq87l/WyJon3ECzkLlbiaEPKeaV+yXZdJMlY5wa1NU1IEqpBk6vBRhN/KtCA2Nq6
         071VKgrBrIE7EHbsCNThx4djXvWlcu9Opeiofx72KnS52ga8JeR8Vwx+mJyE+DfNiQZS
         68XCPLCED3dKNsfu4lPDTnm39wgm1gUpfHuRRB4WRhSsZelRMCGcCBnnrnYd9NNiwjhy
         lrbZOm5I4dFEJ7TAmFXobXzUJkO1/wrpC/jKsmDNQOzE4ih0gaq99hjFmFyYEDF2qVVL
         611Q==
X-Gm-Message-State: ABy/qLaGDQmOb6MWMNXu2VQc329OzDCi+/b2UBOeWtdhxRCQoVB9LcFD
        u9FjtrjxYoWOnKSG75wT5QuCxYv2s3PMD59lKXKsdQ==
X-Google-Smtp-Source: APBJJlG9WQK8q0uhcSD23glBUh38o6T9oYOT0ZmYnosq324Hbil1AKSvzqAEF8PIEjTeU56tODdkog==
X-Received: by 2002:a17:903:2291:b0:1bb:cd10:8215 with SMTP id b17-20020a170903229100b001bbcd108215mr4437321plh.4.1690459938488;
        Thu, 27 Jul 2023 05:12:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902e88800b001b53be3d956sm1483818plg.167.2023.07.27.05.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 05:12:17 -0700 (PDT)
Message-ID: <64c25f21.170a0220.214fb.2a09@mx.google.com>
Date:   Thu, 27 Jul 2023 05:12:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Kernel: v5.15.123
X-Kernelci-Report-Type: test
Subject: stable/linux-5.15.y baseline: 198 runs, 21 regressions (v5.15.123)
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

stable/linux-5.15.y baseline: 198 runs, 21 regressions (v5.15.123)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =

cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

fsl-lx2160a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm...ok+kselftest | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.15.y/kernel=
/v5.15.123/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.15.y
  Describe: v5.15.123
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      09996673e3139a6d86fc3d95c852b3a020e2fe5f =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64c228e8cd86f5c72e8ace42

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c228e8cd86f5c72e8ace47
        failing since 118 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-07-27T08:20:33.027856  + set +x

    2023-07-27T08:20:33.034808  <8>[   11.943415] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11149509_1.4.2.3.1>

    2023-07-27T08:20:33.142159  / # #

    2023-07-27T08:20:33.244409  export SHELL=3D/bin/sh

    2023-07-27T08:20:33.245201  #

    2023-07-27T08:20:33.346729  / # export SHELL=3D/bin/sh. /lava-11149509/=
environment

    2023-07-27T08:20:33.347528  =


    2023-07-27T08:20:33.449275  / # . /lava-11149509/environment/lava-11149=
509/bin/lava-test-runner /lava-11149509/1

    2023-07-27T08:20:33.450431  =


    2023-07-27T08:20:33.456284  / # /lava-11149509/bin/lava-test-runner /la=
va-11149509/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c228fb9284a92e418ace38

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c228fb9284a92e418ace3d
        failing since 118 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-07-27T08:21:00.522815  + set +x

    2023-07-27T08:21:00.529601  <8>[   10.648112] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11149525_1.4.2.3.1>

    2023-07-27T08:21:00.633609  / # #

    2023-07-27T08:21:00.734209  export SHELL=3D/bin/sh

    2023-07-27T08:21:00.734417  #

    2023-07-27T08:21:00.834953  / # export SHELL=3D/bin/sh. /lava-11149525/=
environment

    2023-07-27T08:21:00.835143  =


    2023-07-27T08:21:00.935714  / # . /lava-11149525/environment/lava-11149=
525/bin/lava-test-runner /lava-11149525/1

    2023-07-27T08:21:00.936013  =


    2023-07-27T08:21:00.941151  / # /lava-11149525/bin/lava-test-runner /la=
va-11149525/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64c228eb45efef8f1e8ace68

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c228eb45efef8f1e8ace6d
        failing since 118 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-07-27T08:20:37.055878  + <8>[   12.453639] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11149515_1.4.2.3.1>

    2023-07-27T08:20:37.056464  set +x

    2023-07-27T08:20:37.163734  / # #

    2023-07-27T08:20:37.265970  export SHELL=3D/bin/sh

    2023-07-27T08:20:37.266590  #

    2023-07-27T08:20:37.367980  / # export SHELL=3D/bin/sh. /lava-11149515/=
environment

    2023-07-27T08:20:37.368649  =


    2023-07-27T08:20:37.470203  / # . /lava-11149515/environment/lava-11149=
515/bin/lava-test-runner /lava-11149515/1

    2023-07-27T08:20:37.471367  =


    2023-07-27T08:20:37.476069  / # /lava-11149515/bin/lava-test-runner /la=
va-11149515/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c2290d9284a92e418ace61

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c2290d9284a92e418ace66
        failing since 118 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-07-27T08:21:13.648373  + set<8>[   11.161855] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11149555_1.4.2.3.1>

    2023-07-27T08:21:13.648463   +x

    2023-07-27T08:21:13.752731  / # #

    2023-07-27T08:21:13.853275  export SHELL=3D/bin/sh

    2023-07-27T08:21:13.853430  #

    2023-07-27T08:21:13.953890  / # export SHELL=3D/bin/sh. /lava-11149555/=
environment

    2023-07-27T08:21:13.954036  =


    2023-07-27T08:21:14.054502  / # . /lava-11149555/environment/lava-11149=
555/bin/lava-test-runner /lava-11149555/1

    2023-07-27T08:21:14.054729  =


    2023-07-27T08:21:14.059646  / # /lava-11149555/bin/lava-test-runner /la=
va-11149555/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64c228d8b4a404208b8ace2b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c228d8b4a404208b8ace30
        failing since 118 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-07-27T08:20:32.687259  <8>[   11.513251] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11149499_1.4.2.3.1>

    2023-07-27T08:20:32.690788  + set +x

    2023-07-27T08:20:32.796098  #

    2023-07-27T08:20:32.898613  / # #export SHELL=3D/bin/sh

    2023-07-27T08:20:32.899358  =


    2023-07-27T08:20:33.000721  / # export SHELL=3D/bin/sh. /lava-11149499/=
environment

    2023-07-27T08:20:33.001454  =


    2023-07-27T08:20:33.102989  / # . /lava-11149499/environment/lava-11149=
499/bin/lava-test-runner /lava-11149499/1

    2023-07-27T08:20:33.104138  =


    2023-07-27T08:20:33.109683  / # /lava-11149499/bin/lava-test-runner /la=
va-11149499/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c228fb0a919e4b658ace34

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c228fb0a919e4b658ace39
        failing since 118 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-07-27T08:21:10.438166  <8>[   10.690971] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11149547_1.4.2.3.1>

    2023-07-27T08:21:10.441938  + set +x

    2023-07-27T08:21:10.543292  /#

    2023-07-27T08:21:10.644133   # #export SHELL=3D/bin/sh

    2023-07-27T08:21:10.644358  =


    2023-07-27T08:21:10.744919  / # export SHELL=3D/bin/sh. /lava-11149547/=
environment

    2023-07-27T08:21:10.745142  =


    2023-07-27T08:21:10.845681  / # . /lava-11149547/environment/lava-11149=
547/bin/lava-test-runner /lava-11149547/1

    2023-07-27T08:21:10.845941  =


    2023-07-27T08:21:10.851241  / # /lava-11149547/bin/lava-test-runner /la=
va-11149547/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/64c22891acec1bb6868ace23

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c22891acec1bb6868ace28
        new failure (last pass: v5.15.119)

    2023-07-27T08:20:49.239548  / # #

    2023-07-27T08:20:49.341711  export SHELL=3D/bin/sh

    2023-07-27T08:20:49.342435  #

    2023-07-27T08:20:49.443842  / # export SHELL=3D/bin/sh. /lava-11149476/=
environment

    2023-07-27T08:20:49.444566  =


    2023-07-27T08:20:49.546048  / # . /lava-11149476/environment/lava-11149=
476/bin/lava-test-runner /lava-11149476/1

    2023-07-27T08:20:49.547151  =


    2023-07-27T08:20:49.563769  / # /lava-11149476/bin/lava-test-runner /la=
va-11149476/1

    2023-07-27T08:20:49.671696  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-27T08:20:49.672205  + cd /lava-11149476/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64c229a2a5d68073188ace64

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c229a2a5d68073188ace69
        failing since 189 days (last pass: v5.15.82, first fail: v5.15.89)

    2023-07-27T08:23:43.574791  <8>[   10.118950] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3725621_1.5.2.4.1>
    2023-07-27T08:23:43.681725  / # #
    2023-07-27T08:23:43.783468  export SHELL=3D/bin/sh
    2023-07-27T08:23:43.783924  #
    2023-07-27T08:23:43.784152  / # <3>[   10.273941] Bluetooth: hci0: comm=
and 0xfc18 tx timeout
    2023-07-27T08:23:43.885836  export SHELL=3D/bin/sh. /lava-3725621/envir=
onment
    2023-07-27T08:23:43.886797  =

    2023-07-27T08:23:43.989142  / # . /lava-3725621/environment/lava-372562=
1/bin/lava-test-runner /lava-3725621/1
    2023-07-27T08:23:43.990700  =

    2023-07-27T08:23:43.996173  / # /lava-3725621/bin/lava-test-runner /lav=
a-3725621/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c22ea28c4bbd313b8acf41

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c22ea28c4bbd313b8acf44
        failing since 145 days (last pass: v5.15.79, first fail: v5.15.97)

    2023-07-27T08:45:03.240394  [   11.574693] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1238895_1.5.2.4.1>
    2023-07-27T08:45:03.347692  / # #
    2023-07-27T08:45:03.449183  export SHELL=3D/bin/sh
    2023-07-27T08:45:03.449626  #
    2023-07-27T08:45:03.550580  / # export SHELL=3D/bin/sh. /lava-1238895/e=
nvironment
    2023-07-27T08:45:03.551002  =

    2023-07-27T08:45:03.652019  / # . /lava-1238895/environment/lava-123889=
5/bin/lava-test-runner /lava-1238895/1
    2023-07-27T08:45:03.652723  =

    2023-07-27T08:45:03.656647  / # /lava-1238895/bin/lava-test-runner /lav=
a-1238895/1
    2023-07-27T08:45:03.671538  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64c228c66926d199818ace89

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c228c66926d199818ace8e
        failing since 118 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-07-27T08:20:25.083059  + set +x<8>[   12.064073] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11149506_1.4.2.3.1>

    2023-07-27T08:20:25.083569  =


    2023-07-27T08:20:25.190792  / # #

    2023-07-27T08:20:25.292929  export SHELL=3D/bin/sh

    2023-07-27T08:20:25.293589  #

    2023-07-27T08:20:25.394819  / # export SHELL=3D/bin/sh. /lava-11149506/=
environment

    2023-07-27T08:20:25.394994  =


    2023-07-27T08:20:25.495499  / # . /lava-11149506/environment/lava-11149=
506/bin/lava-test-runner /lava-11149506/1

    2023-07-27T08:20:25.495754  =


    2023-07-27T08:20:25.500219  / # /lava-11149506/bin/lava-test-runner /la=
va-11149506/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c2290cc27e7bbf718ace38

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c2290cc27e7bbf718ace3d
        failing since 118 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-07-27T08:21:34.269860  + set +x

    2023-07-27T08:21:34.276508  <8>[   10.057676] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11149541_1.4.2.3.1>

    2023-07-27T08:21:34.383481  / # #

    2023-07-27T08:21:34.485504  export SHELL=3D/bin/sh

    2023-07-27T08:21:34.486122  #

    2023-07-27T08:21:34.587363  / # export SHELL=3D/bin/sh. /lava-11149541/=
environment

    2023-07-27T08:21:34.588154  =


    2023-07-27T08:21:34.689634  / # . /lava-11149541/environment/lava-11149=
541/bin/lava-test-runner /lava-11149541/1

    2023-07-27T08:21:34.690642  =


    2023-07-27T08:21:34.695299  / # /lava-11149541/bin/lava-test-runner /la=
va-11149541/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64c228a8392332055b8ace25

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c228a8392332055b8ace2a
        failing since 118 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-07-27T08:19:46.205548  + <8>[   11.738778] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11149493_1.4.2.3.1>

    2023-07-27T08:19:46.206018  set +x

    2023-07-27T08:19:46.310492  #

    2023-07-27T08:19:46.413185  / # #export SHELL=3D/bin/sh

    2023-07-27T08:19:46.414035  =


    2023-07-27T08:19:46.515805  / # export SHELL=3D/bin/sh. /lava-11149493/=
environment

    2023-07-27T08:19:46.516591  =


    2023-07-27T08:19:46.618537  / # . /lava-11149493/environment/lava-11149=
493/bin/lava-test-runner /lava-11149493/1

    2023-07-27T08:19:46.619744  =


    2023-07-27T08:19:46.625302  / # /lava-11149493/bin/lava-test-runner /la=
va-11149493/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c2290b808f54a3c28ace41

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c2290b808f54a3c28ace46
        failing since 118 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-07-27T08:21:06.718545  + set +x

    2023-07-27T08:21:06.725477  <8>[   10.480958] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11149539_1.4.2.3.1>

    2023-07-27T08:21:06.833506  =


    2023-07-27T08:21:06.935245  / # #export SHELL=3D/bin/sh

    2023-07-27T08:21:06.935943  =


    2023-07-27T08:21:07.037398  / # export SHELL=3D/bin/sh. /lava-11149539/=
environment

    2023-07-27T08:21:07.038143  =


    2023-07-27T08:21:07.139770  / # . /lava-11149539/environment/lava-11149=
539/bin/lava-test-runner /lava-11149539/1

    2023-07-27T08:21:07.141010  =


    2023-07-27T08:21:07.145852  / # /lava-11149539/bin/lava-test-runner /la=
va-11149539/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64c228d3b4a404208b8ace1d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c228d3b4a404208b8ace22
        failing since 118 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-07-27T08:20:30.363313  + <8>[   11.881675] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11149511_1.4.2.3.1>

    2023-07-27T08:20:30.363899  set +x

    2023-07-27T08:20:30.472143  / # #

    2023-07-27T08:20:30.574342  export SHELL=3D/bin/sh

    2023-07-27T08:20:30.575118  #

    2023-07-27T08:20:30.676582  / # export SHELL=3D/bin/sh. /lava-11149511/=
environment

    2023-07-27T08:20:30.677369  =


    2023-07-27T08:20:30.778811  / # . /lava-11149511/environment/lava-11149=
511/bin/lava-test-runner /lava-11149511/1

    2023-07-27T08:20:30.780045  =


    2023-07-27T08:20:30.784713  / # /lava-11149511/bin/lava-test-runner /la=
va-11149511/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c2290b0a919e4b658ace5c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c2290b0a919e4b658ace61
        failing since 118 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-07-27T08:20:59.452850  + <8>[   11.404412] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11149545_1.4.2.3.1>

    2023-07-27T08:20:59.452947  set +x

    2023-07-27T08:20:59.557443  / # #

    2023-07-27T08:20:59.657998  export SHELL=3D/bin/sh

    2023-07-27T08:20:59.658192  #

    2023-07-27T08:20:59.758726  / # export SHELL=3D/bin/sh. /lava-11149545/=
environment

    2023-07-27T08:20:59.758919  =


    2023-07-27T08:20:59.859487  / # . /lava-11149545/environment/lava-11149=
545/bin/lava-test-runner /lava-11149545/1

    2023-07-27T08:20:59.859816  =


    2023-07-27T08:20:59.864529  / # /lava-11149545/bin/lava-test-runner /la=
va-11149545/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64c228dcb4a404208b8ace43

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c228dcb4a404208b8ace48
        failing since 175 days (last pass: v5.15.81, first fail: v5.15.91)

    2023-07-27T08:20:37.990043  + set +x
    2023-07-27T08:20:37.990218  [    9.432499] <LAVA_SIGNAL_ENDRUN 0_dmesg =
996317_1.5.2.3.1>
    2023-07-27T08:20:38.097691  / # #
    2023-07-27T08:20:38.199708  export SHELL=3D/bin/sh
    2023-07-27T08:20:38.200179  #
    2023-07-27T08:20:38.301411  / # export SHELL=3D/bin/sh. /lava-996317/en=
vironment
    2023-07-27T08:20:38.301856  =

    2023-07-27T08:20:38.403115  / # . /lava-996317/environment/lava-996317/=
bin/lava-test-runner /lava-996317/1
    2023-07-27T08:20:38.403714  =

    2023-07-27T08:20:38.406414  / # /lava-996317/bin/lava-test-runner /lava=
-996317/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64c228c00f5f16e09f8ace34

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c228c00f5f16e09f8ace39
        failing since 118 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-07-27T08:20:09.013037  + <8>[   12.793914] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11149518_1.4.2.3.1>

    2023-07-27T08:20:09.013584  set +x

    2023-07-27T08:20:09.121676  / # #

    2023-07-27T08:20:09.224090  export SHELL=3D/bin/sh

    2023-07-27T08:20:09.224875  #

    2023-07-27T08:20:09.326594  / # export SHELL=3D/bin/sh. /lava-11149518/=
environment

    2023-07-27T08:20:09.327461  =


    2023-07-27T08:20:09.429019  / # . /lava-11149518/environment/lava-11149=
518/bin/lava-test-runner /lava-11149518/1

    2023-07-27T08:20:09.430319  =


    2023-07-27T08:20:09.434792  / # /lava-11149518/bin/lava-test-runner /la=
va-11149518/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c228fa9284a92e418ace2d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c228fa9284a92e418ace32
        failing since 118 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-07-27T08:20:58.129571  + set<8>[   11.696521] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11149524_1.4.2.3.1>

    2023-07-27T08:20:58.129675   +x

    2023-07-27T08:20:58.234277  / # #

    2023-07-27T08:20:58.334859  export SHELL=3D/bin/sh

    2023-07-27T08:20:58.335112  #

    2023-07-27T08:20:58.435667  / # export SHELL=3D/bin/sh. /lava-11149524/=
environment

    2023-07-27T08:20:58.435864  =


    2023-07-27T08:20:58.536399  / # . /lava-11149524/environment/lava-11149=
524/bin/lava-test-runner /lava-11149524/1

    2023-07-27T08:20:58.536683  =


    2023-07-27T08:20:58.541431  / # /lava-11149524/bin/lava-test-runner /la=
va-11149524/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64c22ca80e7185dfdc8acec4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64c22ca80e7185dfdc8ac=
ec5
        failing since 183 days (last pass: v5.15.89, first fail: v5.15.90) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c22e5a72661701238aceab

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c22e5a72661701238aceb0
        new failure (last pass: v5.15.119)

    2023-07-27T08:43:49.676841  / # #

    2023-07-27T08:43:50.755503  export SHELL=3D/bin/sh

    2023-07-27T08:43:50.757233  #

    2023-07-27T08:43:52.246190  / # export SHELL=3D/bin/sh. /lava-11149712/=
environment

    2023-07-27T08:43:52.248111  =


    2023-07-27T08:43:54.969310  / # . /lava-11149712/environment/lava-11149=
712/bin/lava-test-runner /lava-11149712/1

    2023-07-27T08:43:54.971370  =


    2023-07-27T08:43:54.984343  / # /lava-11149712/bin/lava-test-runner /la=
va-11149712/1

    2023-07-27T08:43:55.043310  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-27T08:43:55.043765  + cd /lava-111497<8>[   25.507903] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11149712_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c22e4569088851e28acecc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.123/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c22e4569088851e28aced1
        new failure (last pass: v5.15.119)

    2023-07-27T08:45:05.960661  / # #

    2023-07-27T08:45:06.062758  export SHELL=3D/bin/sh

    2023-07-27T08:45:06.062955  #

    2023-07-27T08:45:06.163454  / # export SHELL=3D/bin/sh. /lava-11149714/=
environment

    2023-07-27T08:45:06.163580  =


    2023-07-27T08:45:06.264188  / # . /lava-11149714/environment/lava-11149=
714/bin/lava-test-runner /lava-11149714/1

    2023-07-27T08:45:06.264388  =


    2023-07-27T08:45:06.268458  / # /lava-11149714/bin/lava-test-runner /la=
va-11149714/1

    2023-07-27T08:45:06.336550  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-27T08:45:06.336636  + cd /lava-1114971<8>[   16.860632] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11149714_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
