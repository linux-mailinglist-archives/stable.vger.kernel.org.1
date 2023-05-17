Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7870707171
	for <lists+stable@lfdr.de>; Wed, 17 May 2023 21:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjEQTEH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 17 May 2023 15:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjEQTEG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 17 May 2023 15:04:06 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A08493CA
        for <stable@vger.kernel.org>; Wed, 17 May 2023 12:04:03 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-53467c2486cso102114a12.3
        for <stable@vger.kernel.org>; Wed, 17 May 2023 12:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684350242; x=1686942242;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ccyVv1otfMSf5435ZGJXxlefBPXbP3GuLLISdF8vefc=;
        b=XHPBKnVFTq6zUHG8HpfRRQaS8eKZMbMsPlCCyqPZVZYNNWW8QJaey/0rcc0Pba5BL/
         ey/l31T9GF4cjtUktd2IVjh2rydJRdZKyAQCBtF7WfJZm7YYz58cpbKQmpAr+AqTvesp
         5CvMbqrr5tdnjCLIyirSR8wSaD5iumiR9b5ebsv/rmDt5So6ddH+cn9JfXpSplL3dxt2
         nuBuXK9fUKwKxYZkVNJUi7ynRqBrHIBrjo9wvcLpCETS18yKnLpqPk4kIBDq1my9Lp5w
         tpZ4Y+tU3XLcCVPY/iwkI890tBmsEK8g+TNC+M+HPuC/YKgVCD+Gs2Pq6FFqSLNZS7wP
         hATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684350242; x=1686942242;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ccyVv1otfMSf5435ZGJXxlefBPXbP3GuLLISdF8vefc=;
        b=JkG/mik2v05LiACWEAJgqBtAquoHTrQe6/eoakgt4sb1jRMFv2xq21qGUAO7NPOgt5
         Cj3MqFaghRwGYv47eGO2MxW9vUYZtiAW+7tKr5jFqZgGosxG+np+rRXoKm6W5wQdcaxf
         fMxFmUhKg78KS10SzqO/Z/inxKrW0MFHJRmVSsUy/vytS/j+OrAgcNU9psdxHJwNmVol
         OpHAcT1ZS7ixzOn6VzK0d/Fo1+prIGgC0r//UIljyIJkkLj6ElG8wZjm9K2EeXSvHrFI
         x1cQBIifYyt6Ch4EDex1XP9VflPRf8sqx8yCCX/b4aCeli1Tk1gSdT/tHz29N+fiJTzW
         XeAA==
X-Gm-Message-State: AC+VfDzAf5I3D4NnIn19beL9pSRJJo7uC9UO14KDjubIV0UfRLOLf6CL
        NOp4eQIVWPH2z32JCyqnlRR3OonM0Vafdfa5PmoeSA==
X-Google-Smtp-Source: ACHHUZ6ZmDXWtwyqYVdUeeujjAP3pYPIvCP5dvw7rSumkQVJvt+gLYZ9P2aERLgURUS6fjkhaqMvoA==
X-Received: by 2002:a17:90a:7648:b0:247:26da:5de2 with SMTP id s8-20020a17090a764800b0024726da5de2mr686068pjl.20.1684350242044;
        Wed, 17 May 2023 12:04:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p12-20020a17090ad30c00b00252a7b73486sm1954376pju.29.2023.05.17.12.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:04:01 -0700 (PDT)
Message-ID: <64652521.170a0220.26c5c.43b4@mx.google.com>
Date:   Wed, 17 May 2023 12:04:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.180
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 151 runs, 6 regressions (v5.10.180)
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

stable-rc/queue/5.10 baseline: 151 runs, 6 regressions (v5.10.180)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.180/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.180
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      4c893ff55907c61456bcb917781c0dd687a1e123 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6464f33d2ddc3a1c7b2e8620

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464f33d2ddc3a1c7b2e8652
        failing since 92 days (last pass: v5.10.167-127-g921934d621e4, firs=
t fail: v5.10.167-139-gf9519a5a1701)

    2023-05-17T15:30:51.723468  <8>[   19.311863] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 474610_1.5.2.4.1>
    2023-05-17T15:30:51.835361  / # #
    2023-05-17T15:30:51.938719  export SHELL=3D/bin/sh
    2023-05-17T15:30:51.939652  #
    2023-05-17T15:30:52.041769  / # export SHELL=3D/bin/sh. /lava-474610/en=
vironment
    2023-05-17T15:30:52.042713  =

    2023-05-17T15:30:52.144975  / # . /lava-474610/environment/lava-474610/=
bin/lava-test-runner /lava-474610/1
    2023-05-17T15:30:52.146470  =

    2023-05-17T15:30:52.150293  / # /lava-474610/bin/lava-test-runner /lava=
-474610/1
    2023-05-17T15:30:52.261110  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464f38807a3cbb9b22e8612

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x3=
60-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x3=
60-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464f38807a3cbb9b22e8617
        failing since 48 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-17T15:32:10.846082  + set +x

    2023-05-17T15:32:10.852386  <8>[   14.741738] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10357400_1.4.2.3.1>

    2023-05-17T15:32:10.957053  / # #

    2023-05-17T15:32:11.057800  export SHELL=3D/bin/sh

    2023-05-17T15:32:11.058047  #

    2023-05-17T15:32:11.158621  / # export SHELL=3D/bin/sh. /lava-10357400/=
environment

    2023-05-17T15:32:11.158866  =


    2023-05-17T15:32:11.259521  / # . /lava-10357400/environment/lava-10357=
400/bin/lava-test-runner /lava-10357400/1

    2023-05-17T15:32:11.259887  =


    2023-05-17T15:32:11.264127  / # /lava-10357400/bin/lava-test-runner /la=
va-10357400/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464f228c42e35de5b2e85f3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x3=
60-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x3=
60-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464f228c42e35de5b2e85f8
        failing since 48 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-17T15:26:11.116654  <8>[   11.953835] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10357372_1.4.2.3.1>

    2023-05-17T15:26:11.119849  + set +x

    2023-05-17T15:26:11.221129  #

    2023-05-17T15:26:11.221427  =


    2023-05-17T15:26:11.322032  / # #export SHELL=3D/bin/sh

    2023-05-17T15:26:11.322248  =


    2023-05-17T15:26:11.422799  / # export SHELL=3D/bin/sh. /lava-10357372/=
environment

    2023-05-17T15:26:11.422994  =


    2023-05-17T15:26:11.523551  / # . /lava-10357372/environment/lava-10357=
372/bin/lava-test-runner /lava-10357372/1

    2023-05-17T15:26:11.523827  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6464f1232c8c4c25092e865b

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-=
kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-=
kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6464f1232c8c4c25092e8661
        failing since 64 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-17T15:22:05.996402  <8>[   34.036029] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-05-17T15:22:07.021070  /lava-10357482/1/../bin/lava-test-case

    2023-05-17T15:22:07.031872  <8>[   35.072818] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6464f1232c8c4c25092e8662
        failing since 64 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-17T15:22:05.984065  /lava-10357482/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6464f10b903ce7bf852e860f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-libretech-all=
-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-libretech-all=
-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464f10b903ce7bf852e8613
        failing since 104 days (last pass: v5.10.165-139-gefb57ce0f880, fir=
st fail: v5.10.165-149-ge30e8271d674)

    2023-05-17T15:21:18.221232  / # #
    2023-05-17T15:21:18.322915  export SHELL=3D/bin/sh
    2023-05-17T15:21:18.323458  #
    2023-05-17T15:21:18.424842  / # export SHELL=3D/bin/sh. /lava-3596838/e=
nvironment
    2023-05-17T15:21:18.425333  =

    2023-05-17T15:21:18.526766  / # . /lava-3596838/environment/lava-359683=
8/bin/lava-test-runner /lava-3596838/1
    2023-05-17T15:21:18.527572  =

    2023-05-17T15:21:18.532400  / # /lava-3596838/bin/lava-test-runner /lav=
a-3596838/1
    2023-05-17T15:21:18.631420  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-17T15:21:18.632089  + cd /lava-3596838/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
