Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3FC74FCB6
	for <lists+stable@lfdr.de>; Wed, 12 Jul 2023 03:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjGLBc3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 21:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGLBc2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 21:32:28 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DBACF
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 18:32:26 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3942c6584f0so4570436b6e.3
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 18:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689125545; x=1691717545;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5qKFzbruWwCz6p0EhiB6d56ogckS4vUjsQQPpswxhAE=;
        b=k9f1dWKS6O67ngWvJAjdDjnqAnQ77brf/6/EpP2DGbxDNmrsZPHDbGUQU6/vKoe3Et
         yV+IrORd9lHX3SR7eLZfVv6TKgCBUHtjJbPIlEdtkW/sHW0XtJtfN529oM63wvN/OVF/
         sRb9KC3bpCqorPGIANYRJp3Oasdjg6F2rUG2Iz57XXUz63ts7wbdgodZBSzjadFyLlnP
         6hW3fSD5rs0R61/dovR8wfrrot6KRwWJAnJ6iUS+YeJC0qm0k8DnM/I+XR7q954H/CQj
         eZFjrnDFy4pdTzOuChlWCj7j8fI+zVw1fcPnnQ6DbOiMYKx2VS23zco454s+NAEjhs//
         0PUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689125545; x=1691717545;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qKFzbruWwCz6p0EhiB6d56ogckS4vUjsQQPpswxhAE=;
        b=aSQTkdL3dgFzM8BuEazs5RfSZ7UxF/An+Ez2AzvJTHS77Rv3sWQPsJ2XU4lCgjUzOo
         bxW/LMceUX9zBUxh1Db+xdJmPQmTBUaN3q+lzyOB3pww5SoujFzRRYSRmtRQ1Op3RgXF
         6bSaOTukqTwxX51vwgFO7mS/i2CPzZm+lu8e+WesjGY3Odhg95ddtD19hZdo7PYxFwYe
         TXxux7oZWjwXNMCfheygkX8I3wEJTHmx0Dc8ijtnujsbzY4qM8jYz3rzJelkqX0y1vIi
         p+ZO9FQNxyUMGTA6WxPiIlFWeUZ9H7B0wxMQFQuCHzAmZ46n2M2Y6FoUTrM93drD7V2j
         0kCQ==
X-Gm-Message-State: ABy/qLZTbbV/JfAQpDDv1TkPv3avlZC4nPty4CYR+qDiiazdVPRs0EqK
        W1PZu6rb4cKguyxZuJFVuuTZuMl7PqGTcfNOirry4g==
X-Google-Smtp-Source: APBJJlFGO/cqX8zCHbEiXSRXRmdeA6LsXOYojIA2CbOPBZHc2K/JC18KTC+2zI7SF4ympPx3EU9WoA==
X-Received: by 2002:a05:6808:1986:b0:3a1:d656:21c with SMTP id bj6-20020a056808198600b003a1d656021cmr19869835oib.21.1689125545358;
        Tue, 11 Jul 2023 18:32:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j15-20020aa7800f000000b00666e883757fsm2344482pfi.123.2023.07.11.18.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 18:32:24 -0700 (PDT)
Message-ID: <64ae02a8.a70a0220.3ca11.5a4c@mx.google.com>
Date:   Tue, 11 Jul 2023 18:32:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.186-221-gf178eace6e074
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y
Subject: stable-rc/linux-5.10.y baseline: 165 runs,
 11 regressions (v5.10.186-221-gf178eace6e074)
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

stable-rc/linux-5.10.y baseline: 165 runs, 11 regressions (v5.10.186-221-gf=
178eace6e074)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

imx6q-var-dt6customboard     | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 3          =

r8a77950-salvator-x          | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.186-221-gf178eace6e074/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.186-221-gf178eace6e074
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      f178eace6e0740ae5eab86eb3d05df94e91e8192 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64add05456a4baed0ebb2a89

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-221-gf178eace6e074/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-221-gf178eace6e074/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64add05456a4baed0ebb2a8e
        failing since 174 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-07-11T21:57:25.550499  + set +x<8>[   11.044795] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3719201_1.5.2.4.1>
    2023-07-11T21:57:25.551210  =

    2023-07-11T21:57:25.662281  / # #
    2023-07-11T21:57:25.766121  export SHELL=3D/bin/sh
    2023-07-11T21:57:25.767297  #
    2023-07-11T21:57:25.870054  / # export SHELL=3D/bin/sh. /lava-3719201/e=
nvironment
    2023-07-11T21:57:25.871149  =

    2023-07-11T21:57:25.973780  / # . /lava-3719201/environment/lava-371920=
1/bin/lava-test-runner /lava-3719201/1
    2023-07-11T21:57:25.975297  =

    2023-07-11T21:57:25.975718  / # /lava-3719201/bin/lava-test-runner /lav=
a-3719201/1<3>[   11.453586] Bluetooth: hci0: command 0x0c03 tx timeout =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64adcfa2715548a92dbb2a75

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-221-gf178eace6e074/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-221-gf178eace6e074/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64adcfa2715548a92dbb2a7a
        failing since 105 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-07-11T21:54:39.024382  + set +x

    2023-07-11T21:54:39.030618  <8>[   10.834505] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11063819_1.4.2.3.1>

    2023-07-11T21:54:39.135347  / # #

    2023-07-11T21:54:39.236068  export SHELL=3D/bin/sh

    2023-07-11T21:54:39.236247  #

    2023-07-11T21:54:39.336799  / # export SHELL=3D/bin/sh. /lava-11063819/=
environment

    2023-07-11T21:54:39.336973  =


    2023-07-11T21:54:39.437537  / # . /lava-11063819/environment/lava-11063=
819/bin/lava-test-runner /lava-11063819/1

    2023-07-11T21:54:39.437820  =


    2023-07-11T21:54:39.442365  / # /lava-11063819/bin/lava-test-runner /la=
va-11063819/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64adcfa1ea31e32225bb2ae1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-221-gf178eace6e074/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-221-gf178eace6e074/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64adcfa1ea31e32225bb2ae6
        failing since 105 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-07-11T21:54:28.031879  <8>[   11.823319] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11063848_1.4.2.3.1>

    2023-07-11T21:54:28.032245  + set +x

    2023-07-11T21:54:28.140863  / # #

    2023-07-11T21:54:28.243195  export SHELL=3D/bin/sh

    2023-07-11T21:54:28.243938  #

    2023-07-11T21:54:28.345447  / # export SHELL=3D/bin/sh. /lava-11063848/=
environment

    2023-07-11T21:54:28.346167  =


    2023-07-11T21:54:28.447846  / # . /lava-11063848/environment/lava-11063=
848/bin/lava-test-runner /lava-11063848/1

    2023-07-11T21:54:28.449082  =


    2023-07-11T21:54:28.454540  / # /lava-11063848/bin/lava-test-runner /la=
va-11063848/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-var-dt6customboard     | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 3          =


  Details:     https://kernelci.org/test/plan/id/64adcf7cd394f157bfbb2afd

  Results:     3 PASS, 3 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-221-gf178eace6e074/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-i=
mx6q-var-dt6customboard.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-221-gf178eace6e074/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-i=
mx6q-var-dt6customboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64adcf7cd394f157bfbb2b02
        new failure (last pass: v5.10.131-113-g024476cf51e8)

    2023-07-11T21:53:46.175657  kern  :emerg : 7ec0: 00000000 00000000 0000=
0003 00000000 00000000 9fdefb86 c3a8e400 c399e840
    2023-07-11T21:53:46.176011  kern  :emerg : 7ee0: cec6008f cec6020f c399=
e894 c09e4c0c fffffc84 c399e840 c3a8e400 c3a8e580
    2023-07-11T21:53:46.176237  kern  :emerg : 7f00: 00000000 c1b209c0 0000=
0000 c09e4f00 c3a8e5a0 c226b280 ef796380 ef799600
    2023-07-11T21:53:46.176452  kern  :emerg : 7f20: 00000000 c03625b8 c23f=
6000 ef796380 ef796398 c226b280 ef796380 c226b294
    2023-07-11T21:53:46.176895  kern  :emerg : 7f40: ef796398 c1903d00 0000=
0008 c23f6000 ef796380 c0362b4c ffffe000 c1b20087
    2023-07-11T21:53:46.218687  kern  :emerg : 7f60: c226b280 c22f23c0 c225=
c8c0 00000000 c23f6000 c0362914 c226b280 c210feb4
    2023-07-11T21:53:46.218989  kern  :emerg : 7f80: c22f23e4 c0368400 0000=
0003 c225c8c0 c03682b4 00000000 00000000 00000000
    2023-07-11T21:53:46.219215  kern  :emerg : 7fa0: 00000000 00000000 0000=
0000 c03001a8 00000000 00000000 00000000 00000000
    2023-07-11T21:53:46.219447  kern  :emerg : 7fc0: 00000000 00000000 0000=
0000 00000000 00000000 00000000 00000000 00000000
    2023-07-11T21:53:46.219657  kern  :emerg : 7fe0: 00000000 00000000 0000=
0000 00000000 00000013 00000000 00000000 00000000 =

    ... (39 line(s) more)  =


  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/64adcf7cd394f15=
7bfbb2b04
        new failure (last pass: v5.10.131-113-g024476cf51e8)
        26 lines

    2023-07-11T21:53:46.132472  kern  :emerg : Internal error: : 1 [#1] SMP=
 ARM
    2023-07-11T21:53:46.132968  kern  :emerg : Process kworker/0:2 (pid: 51=
, stack limit =3D 0x(ptrval))
    2023-07-11T21:53:46.133203  kern  :emerg : Stack: (0xc23f7eb0 to<8>[   =
42.949642] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dfail UNITS=
=3Dlines MEASUREMENT=3D26>
    2023-07-11T21:53:46.133422   0xc23f8000)
    2023-07-11T21:53:46.133633  kern  :emerg : 7ea0<8>[   42.960943] <LAVA_=
SIGNAL_ENDRUN 0_dmesg 3719205_1.5.2.4.1>
    2023-07-11T21:53:46.133842  :                                     00000=
000 c23f6000 00000000 cec60217   =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/64adcf7cd394f15=
7bfbb2b05
        new failure (last pass: v5.10.131-113-g024476cf51e8)
        4 lines

    2023-07-11T21:53:46.051409  kern  :alert : 8<--- cut here ---
    2023-07-11T21:53:46.080332  kern  :alert : Unhandled fault: alignment e=
xception (0x001) at 0xcec60217
    2023-07-11T21:53:46.080860  kern  :alert : pgd =3D (ptrval)
    2023-07-11T21:53:46.083447  kern  :alert : [<8>[   42.903371] <LAVA_SIG=
NAL_TESTCASE TEST_CASE_ID=3Dalert RESULT=3Dfail UNITS=3Dlines MEASUREMENT=
=3D4>
    2023-07-11T21:53:46.083718  cec60217] *pgd=3D1ec1141e(bad)   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77950-salvator-x          | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64adcf2d4eef6cbd55bb2a80

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-221-gf178eace6e074/arm64/defconfig/gcc-10/lab-baylibre/baseline-r8a77950=
-salvator-x.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-221-gf178eace6e074/arm64/defconfig/gcc-10/lab-baylibre/baseline-r8a77950=
-salvator-x.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64adcf2d4eef6cbd55bb2=
a81
        new failure (last pass: v5.10.186-12-g95b8dd2315eef) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64adce293c9c87acaabb2a99

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-221-gf178eace6e074/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-r=
ock64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-221-gf178eace6e074/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-r=
ock64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64adce293c9c87acaabb2a9e
        failing since 74 days (last pass: v5.10.147, first fail: v5.10.176-=
373-g8415c0f9308b)

    2023-07-11T21:48:20.275445  [   15.975428] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3719169_1.5.2.4.1>
    2023-07-11T21:48:20.379609  =

    2023-07-11T21:48:20.379803  / # #[   16.061961] rockchip-drm display-su=
bsystem: [drm] Cannot find any crtc or sizes
    2023-07-11T21:48:20.481258  export SHELL=3D/bin/sh
    2023-07-11T21:48:20.481746  =

    2023-07-11T21:48:20.583294  / # export SHELL=3D/bin/sh. /lava-3719169/e=
nvironment
    2023-07-11T21:48:20.583734  =

    2023-07-11T21:48:20.685098  / # . /lava-3719169/environment/lava-371916=
9/bin/lava-test-runner /lava-3719169/1
    2023-07-11T21:48:20.685820  =

    2023-07-11T21:48:20.689312  / # /lava-3719169/bin/lava-test-runner /lav=
a-3719169/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64adcf55b2e979b9d4bb2aca

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-221-gf178eace6e074/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-s=
tm32mp157c-dk2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-221-gf178eace6e074/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-s=
tm32mp157c-dk2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64adcf55b2e979b9d4bb2acf
        failing since 158 days (last pass: v5.10.147, first fail: v5.10.166=
-10-g6278b8c9832e)

    2023-07-11T21:53:06.979573  <8>[   12.700887] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3719214_1.5.2.4.1>
    2023-07-11T21:53:07.086418  / # #
    2023-07-11T21:53:07.189268  export SHELL=3D/bin/sh
    2023-07-11T21:53:07.189861  #
    2023-07-11T21:53:07.291556  / # export SHELL=3D/bin/sh. /lava-3719214/e=
nvironment
    2023-07-11T21:53:07.292167  =

    2023-07-11T21:53:07.393966  / # . /lava-3719214/environment/lava-371921=
4/bin/lava-test-runner /lava-3719214/1
    2023-07-11T21:53:07.395069  =

    2023-07-11T21:53:07.399646  / # /lava-3719214/bin/lava-test-runner /lav=
a-3719214/1
    2023-07-11T21:53:07.465677  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64adceb0db58f55d2abb2abd

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-221-gf178eace6e074/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a=
64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-221-gf178eace6e074/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a=
64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64adceb0db58f55d2abb2ae9
        failing since 162 days (last pass: v5.10.158-107-g6b6a42c25ed4, fir=
st fail: v5.10.165-144-g930bc29c79c4)

    2023-07-11T21:50:11.184856  + set +x
    2023-07-11T21:50:11.188972  <8>[   17.067154] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3719171_1.5.2.4.1>
    2023-07-11T21:50:11.309237  / # #
    2023-07-11T21:50:11.414869  export SHELL=3D/bin/sh
    2023-07-11T21:50:11.416434  #
    2023-07-11T21:50:11.519753  / # export SHELL=3D/bin/sh. /lava-3719171/e=
nvironment
    2023-07-11T21:50:11.521344  =

    2023-07-11T21:50:11.624720  / # . /lava-3719171/environment/lava-371917=
1/bin/lava-test-runner /lava-3719171/1
    2023-07-11T21:50:11.627365  =

    2023-07-11T21:50:11.630666  / # /lava-3719171/bin/lava-test-runner /lav=
a-3719171/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64add41c1f2276807dbb2ac1

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-221-gf178eace6e074/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a6=
4-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-221-gf178eace6e074/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a6=
4-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64add41c1f2276807dbb2aed
        failing since 162 days (last pass: v5.10.158-107-g6b6a42c25ed4, fir=
st fail: v5.10.165-144-g930bc29c79c4)

    2023-07-11T22:13:16.137948  <8>[   17.147933] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 714716_1.5.2.4.1>
    2023-07-11T22:13:16.247136  / # #
    2023-07-11T22:13:16.348803  export SHELL=3D/bin/sh
    2023-07-11T22:13:16.349190  #
    2023-07-11T22:13:16.450458  / # export SHELL=3D/bin/sh. /lava-714716/en=
vironment
    2023-07-11T22:13:16.450850  =

    2023-07-11T22:13:16.552168  / # . /lava-714716/environment/lava-714716/=
bin/lava-test-runner /lava-714716/1
    2023-07-11T22:13:16.552929  =

    2023-07-11T22:13:16.555822  / # /lava-714716/bin/lava-test-runner /lava=
-714716/1
    2023-07-11T22:13:16.599612  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
