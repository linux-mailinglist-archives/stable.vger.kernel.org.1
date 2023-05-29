Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91833714167
	for <lists+stable@lfdr.de>; Mon, 29 May 2023 02:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjE2AqT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 20:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjE2AqT (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 20:46:19 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF87CB9
        for <stable@vger.kernel.org>; Sun, 28 May 2023 17:46:16 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64d4e4598f0so3197422b3a.2
        for <stable@vger.kernel.org>; Sun, 28 May 2023 17:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685321176; x=1687913176;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tnDcdzjiG0Q44KUjTeUidErK7dAG20VYsm2uY2gt9iI=;
        b=4WnhVou21SLkyjeLgs4XWChPGrBEW0xgxZmQLhHr7GGQM+vpHQtja73mq7SoHD+5gq
         fyT3iRvLsF45xB7+8+dpxEWCuo5pFEn4LQ/RfC/nuB8erJzHT+oqRYl+sa2t72anfclq
         +41L6ivDCB16fqdP6itTjqP3jiYox1mWfw9SdpR//X8siamj9/3bAkoOSOmsgHtk2I0+
         AXh0RAb9zqUuf2V/j06pfUaGnpB9wfPzD0wJ0eE6RS8zPqIxeU/OoVmUiuyN8mUOU3kC
         HvKcWfBh3y4NKqkQ+i8PqcvjLvBNGFp/CFQKvC8B3rpB5Atu0c/UqvCaFcraZZ+W+2FY
         xZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685321176; x=1687913176;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tnDcdzjiG0Q44KUjTeUidErK7dAG20VYsm2uY2gt9iI=;
        b=M+jTL9wAlN2ji90xhsKplgw+3LIHLccs6nRMXZdm2m7bKGKeda4uxECmnqb2ts9bhN
         HbSnFYD2CTEdaqymjbI24FdfnA3tPTRHLTwVs/PRXMlZlrAiSFRQnV+h/QL9PEelw2Zm
         JslhzetsWjmOuO5HWa+vKX/H7clc/+JqwOH9egcnSM4wkIp8QI4CmZ9eMaNrZLonrz0L
         smwJkDD5NA+YxiFxR5htlNa+TfVulIhDrhSVb5iWNLUpbuoElkUkNDlvJQwVABAIUAFY
         1YBShHnHF4g8PowjJ98cR1PgBy5AvTHbZKoNmqyk+cz71fKC8h1nEnlsDoUNEu0mN2V1
         DPvQ==
X-Gm-Message-State: AC+VfDw+yvT7zKpIq1ZwOEfd/nAy9YFdEBc2jByxeuux8D3ct6rDJy98
        9JbYGIS4EfuZp4iPFLqhvwTd/YGakl0ZXSGWTt6lRg==
X-Google-Smtp-Source: ACHHUZ7w6sPIYGkdh94GDukkO01DJLsT6f4twxSspBE3EGDlYoW5gVPdYRyWVlHUy0bN1C/cZxzTBg==
X-Received: by 2002:a05:6a00:b96:b0:64d:2e8a:4cc1 with SMTP id g22-20020a056a000b9600b0064d2e8a4cc1mr14271882pfj.27.1685321175854;
        Sun, 28 May 2023 17:46:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c19-20020aa78813000000b0064d6b6aac5dsm5668074pfo.73.2023.05.28.17.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 17:46:15 -0700 (PDT)
Message-ID: <6473f5d7.a70a0220.40f39.b444@mx.google.com>
Date:   Sun, 28 May 2023 17:46:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.180-211-g89a45a9e82b1
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 159 runs,
 7 regressions (v5.10.180-211-g89a45a9e82b1)
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

stable-rc/queue/5.10 baseline: 159 runs, 7 regressions (v5.10.180-211-g89a4=
5a9e82b1)

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

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.180-211-g89a45a9e82b1/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.180-211-g89a45a9e82b1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      89a45a9e82b17869d41b4206873bb5efc419fc96 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6473c26e14c354a3262e866f

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-g89a45a9e82b1/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-g89a45a9e82b1/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473c26e14c354a3262e86a5
        failing since 103 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-05-28T21:06:40.030680  <8>[   19.827199] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 527526_1.5.2.4.1>
    2023-05-28T21:06:40.140194  / # #
    2023-05-28T21:06:40.243045  export SHELL=3D/bin/sh
    2023-05-28T21:06:40.243605  #
    2023-05-28T21:06:40.345265  / # export SHELL=3D/bin/sh. /lava-527526/en=
vironment
    2023-05-28T21:06:40.345754  =

    2023-05-28T21:06:40.447192  / # . /lava-527526/environment/lava-527526/=
bin/lava-test-runner /lava-527526/1
    2023-05-28T21:06:40.448195  =

    2023-05-28T21:06:40.452618  / # /lava-527526/bin/lava-test-runner /lava=
-527526/1
    2023-05-28T21:06:40.557504  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6473c3aa2dfbb8d8522e85f1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-g89a45a9e82b1/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-g89a45a9e82b1/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473c3aa2dfbb8d8522e85f4
        failing since 122 days (last pass: v5.10.165-76-g5c2e982fcf18, firs=
t fail: v5.10.165-77-g4600242c13ed)

    2023-05-28T21:12:00.036341  <8>[   11.137588] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3628057_1.5.2.4.1>
    2023-05-28T21:12:00.147621  / # #
    2023-05-28T21:12:00.252264  export SHELL=3D/bin/sh
    2023-05-28T21:12:00.253457  #
    2023-05-28T21:12:00.356237  / # export SHELL=3D/bin/sh. /lava-3628057/e=
nvironment
    2023-05-28T21:12:00.357305  =

    2023-05-28T21:12:00.357917  / # . /lava-3628057/environment<3>[   11.45=
2066] Bluetooth: hci0: command 0x0c03 tx timeout
    2023-05-28T21:12:00.460286  /lava-3628057/bin/lava-test-runner /lava-36=
28057/1
    2023-05-28T21:12:00.462014  =

    2023-05-28T21:12:00.467035  / # /lava-3628057/bin/lava-test-runner /lav=
a-3628057/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473c44935bafc0d832e8600

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-g89a45a9e82b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-g89a45a9e82b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473c44935bafc0d832e8605
        failing since 59 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-28T21:14:44.289293  + set +x

    2023-05-28T21:14:44.295494  <8>[   14.824765] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10498921_1.4.2.3.1>

    2023-05-28T21:14:44.403251  / # #

    2023-05-28T21:14:44.505326  export SHELL=3D/bin/sh

    2023-05-28T21:14:44.506085  #

    2023-05-28T21:14:44.607459  / # export SHELL=3D/bin/sh. /lava-10498921/=
environment

    2023-05-28T21:14:44.608211  =


    2023-05-28T21:14:44.709725  / # . /lava-10498921/environment/lava-10498=
921/bin/lava-test-runner /lava-10498921/1

    2023-05-28T21:14:44.710830  =


    2023-05-28T21:14:44.715686  / # /lava-10498921/bin/lava-test-runner /la=
va-10498921/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473c44e53bb5464e62e85e9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-g89a45a9e82b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-g89a45a9e82b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473c44e53bb5464e62e85ee
        failing since 59 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-28T21:14:36.084554  + set +x

    2023-05-28T21:14:36.091220  <8>[   11.834051] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10498961_1.4.2.3.1>

    2023-05-28T21:14:36.193413  =


    2023-05-28T21:14:36.293953  / # #export SHELL=3D/bin/sh

    2023-05-28T21:14:36.294196  =


    2023-05-28T21:14:36.394788  / # export SHELL=3D/bin/sh. /lava-10498961/=
environment

    2023-05-28T21:14:36.395053  =


    2023-05-28T21:14:36.495625  / # . /lava-10498961/environment/lava-10498=
961/bin/lava-test-runner /lava-10498961/1

    2023-05-28T21:14:36.495994  =


    2023-05-28T21:14:36.500695  / # /lava-10498961/bin/lava-test-runner /la=
va-10498961/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6473c423b29117c2c52e8680

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-g89a45a9e82b1/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-g89a45a9e82b1/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6473c423b29117c2c52e8686
        failing since 75 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-28T21:13:53.728019  /lava-10498883/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6473c423b29117c2c52e8687
        failing since 75 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-28T21:13:52.690688  /lava-10498883/1/../bin/lava-test-case

    2023-05-28T21:13:52.701873  <8>[   32.182806] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6473c2fa084affa7522e8602

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-g89a45a9e82b1/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-g89a45a9e82b1/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473c2fa084affa7522e8607
        failing since 116 days (last pass: v5.10.165-139-gefb57ce0f880, fir=
st fail: v5.10.165-149-ge30e8271d674)

    2023-05-28T21:08:54.848136  / # #
    2023-05-28T21:08:54.949926  export SHELL=3D/bin/sh
    2023-05-28T21:08:54.950365  #
    2023-05-28T21:08:55.051699  / # export SHELL=3D/bin/sh. /lava-3628053/e=
nvironment
    2023-05-28T21:08:55.052139  =

    2023-05-28T21:08:55.153497  / # . /lava-3628053/environment/lava-362805=
3/bin/lava-test-runner /lava-3628053/1
    2023-05-28T21:08:55.154219  =

    2023-05-28T21:08:55.159463  / # /lava-3628053/bin/lava-test-runner /lav=
a-3628053/1
    2023-05-28T21:08:55.223530  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-28T21:08:55.258376  + cd /lava-3628053/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
