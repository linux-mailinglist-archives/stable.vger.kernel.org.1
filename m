Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF9573E033
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 15:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjFZNHx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 09:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjFZNHs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 09:07:48 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4B9C2
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 06:07:43 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-39ec45b22f6so2301298b6e.0
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 06:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687784862; x=1690376862;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tu9we4wA3iF8bdtaYCsv2WYKAROPEXH4p2EJyIgsOtc=;
        b=O7FKi7dApAgvNU3Vd75BH1nVduZBx2YRMG+D/ljywZfhbGRordebIrNvgc7a6dgz+a
         YGhLD9hjlidOnhcNavhkonj8ENaN+elg27D5klRB4OePemAXEoU5TiDiAFYM9L6ds0i7
         rnEF344HOQjrpZHiN4+Is38t6ryg1xqzQhhnO1rU6A7yUe/riLBAhwAEN7+fzFKJu7rw
         uE2yDrUpjpd5XkL1oWcQOtbZpJMCU0KdIzI+h01hq0dO53J4SJs4caqm3Z87k5tOkTQe
         XfrWdCWmfIkJDcwUQpM8rH7tZAKO/g/JtnCMGiNylRXMkiMMuscR8z1PPH+7JfpEJD5r
         Eyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687784862; x=1690376862;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tu9we4wA3iF8bdtaYCsv2WYKAROPEXH4p2EJyIgsOtc=;
        b=XAlFBdS56bv4enNlfgLFM2CLgYKsocDmireWswOqMofQ6i6i/rKt4wYUvpWpG+j881
         ljfnoJIXAr2zK7OBbnC46I0XDN3K8SIwWPkmkXJYqyf1X5mhQs163mGVV2fcbGbrThAQ
         EftSm+xzj3GSU7qaDoyasZEi5GgbskhyP09i1zuT0UzRxwJqHHsKB1etUXr+QhFwhmAH
         DajJBFi+QDlII6lacUrllobpxUrzvhZhqC69r9TwR6A6SKax0pz5uN5/lUdUk0EqT+N/
         tU6KJtd2dKIShTuLPcnmrVu9USjMrJj7ZuAD01kTy9vgP6uDXGJ1jPWA2GnnuZEF5XQm
         2kvQ==
X-Gm-Message-State: AC+VfDwpK5S5cJ+yk4e3k+GpvFywONnUpQpE+KOPyNBkkBSCJPS+jqFT
        Y94Q7B8QWjhkNdzXNHoW3g2QTt1s0UUAo91mVZWCcg==
X-Google-Smtp-Source: ACHHUZ5+3wCrCFPAHFMbb4/COX1kZIfeper4R5aKpIbVSLADC/uOKnBbM8Cl9e1ofj+KiuvHmG+QZQ==
X-Received: by 2002:a05:6808:1b06:b0:39e:dbb3:5528 with SMTP id bx6-20020a0568081b0600b0039edbb35528mr26573368oib.47.1687784861815;
        Mon, 26 Jun 2023 06:07:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s2-20020a17090aba0200b002535a0f2028sm6074518pjr.51.2023.06.26.06.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 06:07:41 -0700 (PDT)
Message-ID: <64998d9d.170a0220.9288c.aaa4@mx.google.com>
Date:   Mon, 26 Jun 2023 06:07:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.185
Subject: stable-rc/linux-5.10.y baseline: 175 runs, 6 regressions (v5.10.185)
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

stable-rc/linux-5.10.y baseline: 175 runs, 6 regressions (v5.10.185)

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

rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.185/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.185
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      ef0d5feb32ab7007d1316e9c5037cd7d9f7febbf =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64933d05c75649a4e630612e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
85/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
85/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64933d05c75649a4e6306137
        failing since 154 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-06-21T18:09:54.870619  <8>[   11.116821] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3684461_1.5.2.4.1>
    2023-06-21T18:09:54.981890  / # #
    2023-06-21T18:09:55.085210  export SHELL=3D/bin/sh
    2023-06-21T18:09:55.086276  #
    2023-06-21T18:09:55.188520  / # export SHELL=3D/bin/sh. /lava-3684461/e=
nvironment
    2023-06-21T18:09:55.189471  =

    2023-06-21T18:09:55.291966  / # . /lava-3684461/environment/lava-368446=
1/bin/lava-test-runner /lava-3684461/1
    2023-06-21T18:09:55.294376  =

    2023-06-21T18:09:55.295674  / # <3>[   11.452263] Bluetooth: hci0: comm=
and 0x0c03 tx timeout
    2023-06-21T18:09:55.298708  /lava-3684461/bin/lava-test-runner /lava-36=
84461/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64933a757a626c8e5a30614f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
85/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
85/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64933a757a626c8e5a306158
        failing since 84 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-06-26T09:05:05.804660  + set +x

    2023-06-26T09:05:05.810906  <8>[   10.531950] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10909974_1.4.2.3.1>

    2023-06-26T09:05:05.915021  / # #

    2023-06-26T09:05:06.015591  export SHELL=3D/bin/sh

    2023-06-26T09:05:06.015790  #

    2023-06-26T09:05:06.116307  / # export SHELL=3D/bin/sh. /lava-10909974/=
environment

    2023-06-26T09:05:06.116466  =


    2023-06-26T09:05:06.216931  / # . /lava-10909974/environment/lava-10909=
974/bin/lava-test-runner /lava-10909974/1

    2023-06-26T09:05:06.217164  =


    2023-06-26T09:05:06.221553  / # /lava-10909974/bin/lava-test-runner /la=
va-10909974/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64933a7eee735df47030615c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
85/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
85/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64933a7eee735df470306165
        failing since 84 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-06-26T09:04:32.566362  + set +x

    2023-06-26T09:04:32.573324  <8>[   13.030142] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10909991_1.4.2.3.1>

    2023-06-26T09:04:32.675471  #

    2023-06-26T09:04:32.675803  =


    2023-06-26T09:04:32.776444  / # #export SHELL=3D/bin/sh

    2023-06-26T09:04:32.776659  =


    2023-06-26T09:04:32.877178  / # export SHELL=3D/bin/sh. /lava-10909991/=
environment

    2023-06-26T09:04:32.877419  =


    2023-06-26T09:04:32.978020  / # . /lava-10909991/environment/lava-10909=
991/bin/lava-test-runner /lava-10909991/1

    2023-06-26T09:04:32.978385  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64933cfc3600176d1930615a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
85/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
85/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64933cfc3600176d19306163
        failing since 54 days (last pass: v5.10.147, first fail: v5.10.176-=
373-g8415c0f9308b)

    2023-06-26T09:33:14.436584  [   16.037218] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3693468_1.5.2.4.1>
    2023-06-26T09:33:14.540510  =

    2023-06-26T09:33:14.540668  / # #[   16.098254] rockchip-drm display-su=
bsystem: [drm] Cannot find any crtc or sizes
    2023-06-26T09:33:14.642020  export SHELL=3D/bin/sh
    2023-06-26T09:33:14.642489  =

    2023-06-26T09:33:14.743932  / # export SHELL=3D/bin/sh. /lava-3693468/e=
nvironment
    2023-06-26T09:33:14.744411  =

    2023-06-26T09:33:14.845915  / # . /lava-3693468/environment/lava-369346=
8/bin/lava-test-runner /lava-3693468/1
    2023-06-26T09:33:14.846703  =

    2023-06-26T09:33:14.850213  / # /lava-3693468/bin/lava-test-runner /lav=
a-3693468/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6493405493a719468d30613a

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
85/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
85/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6493405493a719468d306168
        failing since 142 days (last pass: v5.10.158-107-g6b6a42c25ed4, fir=
st fail: v5.10.165-144-g930bc29c79c4)

    2023-06-26T09:45:33.059810  + set +x
    2023-06-26T09:45:33.063977  <8>[   17.054733] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3693467_1.5.2.4.1>
    2023-06-26T09:45:33.184043  / # #
    2023-06-26T09:45:33.289694  export SHELL=3D/bin/sh
    2023-06-26T09:45:33.292463  #
    2023-06-26T09:45:33.396681  / # export SHELL=3D/bin/sh. /lava-3693467/e=
nvironment
    2023-06-26T09:45:33.398207  =

    2023-06-26T09:45:33.501732  / # . /lava-3693467/environment/lava-369346=
7/bin/lava-test-runner /lava-3693467/1
    2023-06-26T09:45:33.504499  =

    2023-06-26T09:45:33.507723  / # /lava-3693467/bin/lava-test-runner /lav=
a-3693467/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64933ddc01b5874488306162

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
85/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
85/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64933ddc01b5874488306190
        failing since 142 days (last pass: v5.10.158-107-g6b6a42c25ed4, fir=
st fail: v5.10.165-144-g930bc29c79c4)

    2023-06-26T09:35:30.613402  + set +x
    2023-06-26T09:35:30.617158  <8>[   17.095415] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 666659_1.5.2.4.1>
    2023-06-26T09:35:30.734091  / # #
    2023-06-26T09:35:30.836293  export SHELL=3D/bin/sh
    2023-06-26T09:35:30.836878  #
    2023-06-26T09:35:30.938584  / # export SHELL=3D/bin/sh. /lava-666659/en=
vironment
    2023-06-26T09:35:30.939373  =

    2023-06-26T09:35:31.041184  / # . /lava-666659/environment/lava-666659/=
bin/lava-test-runner /lava-666659/1
    2023-06-26T09:35:31.042042  =

    2023-06-26T09:35:31.046007  / # /lava-666659/bin/lava-test-runner /lava=
-666659/1 =

    ... (12 line(s) more)  =

 =20
