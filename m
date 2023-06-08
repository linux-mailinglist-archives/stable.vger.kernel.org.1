Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EEC72743C
	for <lists+stable@lfdr.de>; Thu,  8 Jun 2023 03:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjFHBX1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 21:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbjFHBX0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 21:23:26 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DA72103
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 18:23:22 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-33d269dd56bso7688095ab.1
        for <stable@vger.kernel.org>; Wed, 07 Jun 2023 18:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686187402; x=1688779402;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Kr+2dcV32Cf1TvETN+8e98k7J6TfFVmMnFf4h4FZWlE=;
        b=i7ji3P28c8RfhtTqRqfRgBbk6nqnMJk+JrjeWCfvgC/6VGSxrqr+OI/gxLKBCNRHhf
         f5nBQly2JO8ZdiNZs9mGiTEjnMVkuqKXzgSskcak9FUVtNK505gmBS7Uz2vm0tDiHnug
         83HG4S+v4NpleQbLT3D3fiPZQkr5N88lkMzQcX99JKU9tJgXIgRLeChXUAOAHTHLzjyx
         9fq+xttFEXIQx6u+o7aCfk1GfiGoSDH0HPprpXYhk32QXilgUcrE+E7j5A4KguCW1hWt
         IfTyA7RKSIJRhjgTHYJUxxLPw12eO/5/yc+XkwcvpdiwHGJCH0WYDGF0D/eeGkcnXzKR
         RrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686187402; x=1688779402;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kr+2dcV32Cf1TvETN+8e98k7J6TfFVmMnFf4h4FZWlE=;
        b=PaMMxoyY3uUXN9jn0ask/hjrO2VyyjiQvdwsCcNVrKw4PGoOWnTY96bPPAFmot7eUr
         uSQ24GI1Y8wr92M6EnaSjvzhiDCIjCjl/T4nkF0+YNANT72myxdA3lBLSuHt70G8gZZi
         UvjnttlZaQdF+vED0/hRxEHGgHWcfnWA/tTvSdD+yR7tspN7NB3SYJe459mp5OMcTrUL
         jXeL0NAdod1l82a4lyJSkQmmmJ7OupQ+o/WdCoCxI7h0hMagkcDwYRzZ0BUfrtqLjxul
         vIZK0ILr+ZeNglNR3dHtU5IbHlVYor/bjbRBraU5toKcj94BrXZRCzOv/6aoaeYlEvT1
         TthQ==
X-Gm-Message-State: AC+VfDxBPhzj+OVDPAUt4ndN29GXp2nyptL9dx/iaFam6F6et5KYYDso
        xEaPU0nc2VVLwA4+g1j8Ro+EMW6s6akHhpWAe8lMJQ==
X-Google-Smtp-Source: ACHHUZ5OH8f01KKDasdGZtfje02hxgBAg3KrmHjjgAhJucXFH2wutKASvss0ZIeRV+7mYSm7NSxSNQ==
X-Received: by 2002:a92:c909:0:b0:33d:11cd:c7b2 with SMTP id t9-20020a92c909000000b0033d11cdc7b2mr5304627ilp.24.1686187401342;
        Wed, 07 Jun 2023 18:23:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k29-20020a63ba1d000000b0052c3f0ae381sm60469pgf.78.2023.06.07.18.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 18:23:20 -0700 (PDT)
Message-ID: <64812d88.630a0220.53c5d.02aa@mx.google.com>
Date:   Wed, 07 Jun 2023 18:23:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.114-196-g00621f2608ac
Subject: stable-rc/linux-5.15.y baseline: 171 runs,
 18 regressions (v5.15.114-196-g00621f2608ac)
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

stable-rc/linux-5.15.y baseline: 171 runs, 18 regressions (v5.15.114-196-g0=
0621f2608ac)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

at91-sama5d4_xplained        | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 4          =

rk3328-rock64                | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

stm32mp157c-dk2              | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.114-196-g00621f2608ac/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.114-196-g00621f2608ac
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      00621f2608ac31643168c86e902c21a017ffe3b1 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6480fb0b14bfaad48030614f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-196-g00621f2608ac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-196-g00621f2608ac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6480fb0b14bfaad480306154
        failing since 71 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-07T21:47:34.513518  + set +x

    2023-06-07T21:47:34.520022  <8>[    8.620849] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10630938_1.4.2.3.1>

    2023-06-07T21:47:34.627904  / # #

    2023-06-07T21:47:34.730129  export SHELL=3D/bin/sh

    2023-06-07T21:47:34.730846  #

    2023-06-07T21:47:34.832410  / # export SHELL=3D/bin/sh. /lava-10630938/=
environment

    2023-06-07T21:47:34.833047  =


    2023-06-07T21:47:34.934470  / # . /lava-10630938/environment/lava-10630=
938/bin/lava-test-runner /lava-10630938/1

    2023-06-07T21:47:34.935581  =


    2023-06-07T21:47:34.941408  / # /lava-10630938/bin/lava-test-runner /la=
va-10630938/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6480faff14bfaad48030612f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-196-g00621f2608ac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-196-g00621f2608ac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6480faff14bfaad480306134
        failing since 71 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-07T21:47:19.544192  + <8>[    9.390783] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10630932_1.4.2.3.1>

    2023-06-07T21:47:19.544351  set +x

    2023-06-07T21:47:19.648608  / # #

    2023-06-07T21:47:19.749310  export SHELL=3D/bin/sh

    2023-06-07T21:47:19.749535  #

    2023-06-07T21:47:19.850127  / # export SHELL=3D/bin/sh. /lava-10630932/=
environment

    2023-06-07T21:47:19.850354  =


    2023-06-07T21:47:19.950967  / # . /lava-10630932/environment/lava-10630=
932/bin/lava-test-runner /lava-10630932/1

    2023-06-07T21:47:19.951311  =


    2023-06-07T21:47:19.956685  / # /lava-10630932/bin/lava-test-runner /la=
va-10630932/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6480fafba0a1dc2945306165

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-196-g00621f2608ac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-196-g00621f2608ac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6480fafba0a1dc294530616a
        failing since 71 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-07T21:47:16.434162  <8>[   10.361718] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10630908_1.4.2.3.1>

    2023-06-07T21:47:16.437265  + set +x

    2023-06-07T21:47:16.541387  #

    2023-06-07T21:47:16.541879  =


    2023-06-07T21:47:16.642870  / # #export SHELL=3D/bin/sh

    2023-06-07T21:47:16.643595  =


    2023-06-07T21:47:16.745440  / # export SHELL=3D/bin/sh. /lava-10630908/=
environment

    2023-06-07T21:47:16.746073  =


    2023-06-07T21:47:16.847321  / # . /lava-10630908/environment/lava-10630=
908/bin/lava-test-runner /lava-10630908/1

    2023-06-07T21:47:16.848410  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91-sama5d4_xplained        | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6480f9902dbdb6127530612e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-196-g00621f2608ac/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at=
91-sama5d4_xplained.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-196-g00621f2608ac/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at=
91-sama5d4_xplained.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6480f9902dbdb61275306=
12f
        new failure (last pass: v5.15.114-36-ge43ef124b08b3) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6480faf97e056b4cd5306154

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-196-g00621f2608ac/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-196-g00621f2608ac/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6480faf97e056b4cd5306=
155
        failing since 391 days (last pass: v5.15.37-259-gab77581473a3, firs=
t fail: v5.15.39) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6480f82e50fe377819306155

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-196-g00621f2608ac/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-196-g00621f2608ac/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6480f82e50fe37781930615a
        failing since 141 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-06-07T21:35:06.829346  + set +x<8>[   10.023623] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3646497_1.5.2.4.1>
    2023-06-07T21:35:06.829666  =

    2023-06-07T21:35:06.936490  / # #
    2023-06-07T21:35:07.038219  export SHELL=3D/bin/sh
    2023-06-07T21:35:07.038592  #
    2023-06-07T21:35:07.139721  / # export SHELL=3D/bin/sh. /lava-3646497/e=
nvironment
    2023-06-07T21:35:07.140094  =

    2023-06-07T21:35:07.240986  / # . /lava-3646497/environment/lava-364649=
7/bin/lava-test-runner /lava-3646497/1
    2023-06-07T21:35:07.241660  =

    2023-06-07T21:35:07.241853  / # <3>[   10.353190] Bluetooth: hci0: comm=
and 0xfc18 tx timeout =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6480faf6a0a1dc2945306130

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-196-g00621f2608ac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-196-g00621f2608ac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6480faf6a0a1dc2945306135
        failing since 71 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-07T21:47:22.163057  + set +x

    2023-06-07T21:47:22.169491  <8>[   10.413028] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10630949_1.4.2.3.1>

    2023-06-07T21:47:22.273771  / # #

    2023-06-07T21:47:22.374352  export SHELL=3D/bin/sh

    2023-06-07T21:47:22.374635  #

    2023-06-07T21:47:22.475264  / # export SHELL=3D/bin/sh. /lava-10630949/=
environment

    2023-06-07T21:47:22.475597  =


    2023-06-07T21:47:22.576250  / # . /lava-10630949/environment/lava-10630=
949/bin/lava-test-runner /lava-10630949/1

    2023-06-07T21:47:22.576720  =


    2023-06-07T21:47:22.581369  / # /lava-10630949/bin/lava-test-runner /la=
va-10630949/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6480faed45139d5278306174

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-196-g00621f2608ac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-196-g00621f2608ac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6480faed45139d5278306179
        failing since 71 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-07T21:47:22.052508  <8>[   11.101392] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10630951_1.4.2.3.1>

    2023-06-07T21:47:22.055830  + set +x

    2023-06-07T21:47:22.157486  =


    2023-06-07T21:47:22.258139  / # #export SHELL=3D/bin/sh

    2023-06-07T21:47:22.258375  =


    2023-06-07T21:47:22.358961  / # export SHELL=3D/bin/sh. /lava-10630951/=
environment

    2023-06-07T21:47:22.359176  =


    2023-06-07T21:47:22.459762  / # . /lava-10630951/environment/lava-10630=
951/bin/lava-test-runner /lava-10630951/1

    2023-06-07T21:47:22.460070  =


    2023-06-07T21:47:22.465038  / # /lava-10630951/bin/lava-test-runner /la=
va-10630951/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6480fb1dd492bfdadc3061a5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-196-g00621f2608ac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-196-g00621f2608ac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6480fb1dd492bfdadc3061aa
        failing since 71 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-07T21:47:57.005646  + set<8>[   11.451782] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10630969_1.4.2.3.1>

    2023-06-07T21:47:57.006226   +x

    2023-06-07T21:47:57.114811  / # #

    2023-06-07T21:47:57.217255  export SHELL=3D/bin/sh

    2023-06-07T21:47:57.218062  #

    2023-06-07T21:47:57.319525  / # export SHELL=3D/bin/sh. /lava-10630969/=
environment

    2023-06-07T21:47:57.320314  =


    2023-06-07T21:47:57.421861  / # . /lava-10630969/environment/lava-10630=
969/bin/lava-test-runner /lava-10630969/1

    2023-06-07T21:47:57.423084  =


    2023-06-07T21:47:57.427334  / # /lava-10630969/bin/lava-test-runner /la=
va-10630969/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6480f7635ef6a1a02b306131

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-196-g00621f2608ac/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline=
-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-196-g00621f2608ac/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline=
-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6480f7635ef6a1a02b306136
        failing since 128 days (last pass: v5.15.81-122-gc5f8d4a5d3c8, firs=
t fail: v5.15.90-205-g5605d15db022)

    2023-06-07T21:31:53.796690  + set +x
    2023-06-07T21:31:53.797013  [    9.443761] <LAVA_SIGNAL_ENDRUN 0_dmesg =
970656_1.5.2.3.1>
    2023-06-07T21:31:53.905120  / # #
    2023-06-07T21:31:54.006933  export SHELL=3D/bin/sh
    2023-06-07T21:31:54.007500  #
    2023-06-07T21:31:54.108886  / # export SHELL=3D/bin/sh. /lava-970656/en=
vironment
    2023-06-07T21:31:54.109568  =

    2023-06-07T21:31:54.211117  / # . /lava-970656/environment/lava-970656/=
bin/lava-test-runner /lava-970656/1
    2023-06-07T21:31:54.211963  =

    2023-06-07T21:31:54.214424  / # /lava-970656/bin/lava-test-runner /lava=
-970656/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6480faf9a0a1dc2945306157

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-196-g00621f2608ac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-196-g00621f2608ac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6480faf9a0a1dc294530615c
        failing since 71 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-07T21:47:29.764168  <8>[    9.646608] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10630981_1.4.2.3.1>

    2023-06-07T21:47:29.871687  / # #

    2023-06-07T21:47:29.972292  export SHELL=3D/bin/sh

    2023-06-07T21:47:29.972441  #

    2023-06-07T21:47:30.072928  / # export SHELL=3D/bin/sh. /lava-10630981/=
environment

    2023-06-07T21:47:30.073076  =


    2023-06-07T21:47:30.173590  / # . /lava-10630981/environment/lava-10630=
981/bin/lava-test-runner /lava-10630981/1

    2023-06-07T21:47:30.173826  =


    2023-06-07T21:47:30.178730  / # /lava-10630981/bin/lava-test-runner /la=
va-10630981/1

    2023-06-07T21:47:30.183912  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 4          =


  Details:     https://kernelci.org/test/plan/id/6480f9d3ec4c26a60f30625f

  Results:     153 PASS, 14 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-196-g00621f2608ac/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/=
baseline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-196-g00621f2608ac/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/=
baseline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/6480f9d3ec4c26a60f30627a
        failing since 23 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-07T21:42:19.838200  /lava-10630864/1/../bin/lava-test-case

    2023-06-07T21:42:19.844794  <8>[   60.572130] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/6480f9d3ec4c26a60f30628a
        failing since 23 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-07T21:42:20.878484  /lava-10630864/1/../bin/lava-test-case

    2023-06-07T21:42:20.884616  <8>[   61.612697] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/6480f9d3ec4c26a60f30628a
        failing since 23 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-07T21:42:20.878484  /lava-10630864/1/../bin/lava-test-case

    2023-06-07T21:42:20.884616  <8>[   61.612697] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6480f9d3ec4c26a60f306303
        failing since 23 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-07T21:42:05.669527  + set +x

    2023-06-07T21:42:05.676074  <8>[   46.404268] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10630864_1.5.2.3.1>

    2023-06-07T21:42:05.783803  / # #

    2023-06-07T21:42:05.886279  export SHELL=3D/bin/sh

    2023-06-07T21:42:05.887011  #

    2023-06-07T21:42:05.988582  / # export SHELL=3D/bin/sh. /lava-10630864/=
environment

    2023-06-07T21:42:05.989348  =


    2023-06-07T21:42:06.090854  / # . /lava-10630864/environment/lava-10630=
864/bin/lava-test-runner /lava-10630864/1

    2023-06-07T21:42:06.092007  =


    2023-06-07T21:42:06.097217  / # /lava-10630864/bin/lava-test-runner /la=
va-10630864/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3328-rock64                | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6480fca65d3fe2c76f306146

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-196-g00621f2608ac/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-ro=
ck64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-196-g00621f2608ac/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-ro=
ck64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6480fca65d3fe2c76f30614b
        new failure (last pass: v5.15.72-38-gebe70cd7f5413)

    2023-06-07T21:54:30.520853  [   16.136826] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3646640_1.5.2.4.1>
    2023-06-07T21:54:30.624439  =

    2023-06-07T21:54:30.624570  / # #[   16.195238] rockchip-drm display-su=
bsystem: [drm] Cannot find any crtc or sizes
    2023-06-07T21:54:30.725788  export SHELL=3D/bin/sh
    2023-06-07T21:54:30.726103  =

    2023-06-07T21:54:30.827047  / # export SHELL=3D/bin/sh. /lava-3646640/e=
nvironment
    2023-06-07T21:54:30.827381  =

    2023-06-07T21:54:30.928588  / # . /lava-3646640/environment/lava-364664=
0/bin/lava-test-runner /lava-3646640/1
    2023-06-07T21:54:30.929334  =

    2023-06-07T21:54:30.932825  / # /lava-3646640/bin/lava-test-runner /lav=
a-3646640/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
stm32mp157c-dk2              | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6480f77a72d3df5c09306155

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-196-g00621f2608ac/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-st=
m32mp157c-dk2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-196-g00621f2608ac/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-st=
m32mp157c-dk2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6480f77a72d3df5c0930615a
        failing since 123 days (last pass: v5.15.59, first fail: v5.15.91-2=
1-gd8296a906e7a)

    2023-06-07T21:32:20.234515  <8>[   10.474108] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3646499_1.5.2.4.1>
    2023-06-07T21:32:20.341364  / # #
    2023-06-07T21:32:20.443070  export SHELL=3D/bin/sh
    2023-06-07T21:32:20.443666  #
    2023-06-07T21:32:20.545383  / # export SHELL=3D/bin/sh. /lava-3646499/e=
nvironment
    2023-06-07T21:32:20.546114  =

    2023-06-07T21:32:20.648068  / # . /lava-3646499/environment/lava-364649=
9/bin/lava-test-runner /lava-3646499/1
    2023-06-07T21:32:20.648995  =

    2023-06-07T21:32:20.652640  / # /lava-3646499/bin/lava-test-runner /lav=
a-3646499/1
    2023-06-07T21:32:20.719674  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/6480f8d23f21ec5b13306143

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-196-g00621f2608ac/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i=
-h2-plus-orangepi-r1.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-196-g00621f2608ac/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i=
-h2-plus-orangepi-r1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6480f8d23f21ec5b13306148
        failing since 56 days (last pass: v5.15.82-124-g2b8b2c150867, first=
 fail: v5.15.105-194-g415a9d81c640)

    2023-06-07T21:38:03.435905  + set +x
    2023-06-07T21:38:03.439216  <8>[    5.638706] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3646490_1.5.2.4.1>
    2023-06-07T21:38:03.558569  / # #
    2023-06-07T21:38:03.664081  export SHELL=3D/bin/sh
    2023-06-07T21:38:03.665584  #
    2023-06-07T21:38:03.768997  / # export SHELL=3D/bin/sh. /lava-3646490/e=
nvironment
    2023-06-07T21:38:03.770519  =

    2023-06-07T21:38:03.874027  / # . /lava-3646490/environment/lava-364649=
0/bin/lava-test-runner /lava-3646490/1
    2023-06-07T21:38:03.876746  =

    2023-06-07T21:38:03.886053  / # /lava-3646490/bin/lava-test-runner /lav=
a-3646490/1 =

    ... (12 line(s) more)  =

 =20
