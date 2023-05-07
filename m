Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEC86F9871
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 14:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjEGMAl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 08:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjEGMAd (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 08:00:33 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F061328C
        for <stable@vger.kernel.org>; Sun,  7 May 2023 05:00:26 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-643846c006fso3824834b3a.0
        for <stable@vger.kernel.org>; Sun, 07 May 2023 05:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683460826; x=1686052826;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0nJiRCqFioKC5MRnuGmcGFB6ukV5bHlnepMm6dcFvOw=;
        b=V3/hX1grOlCQSg8tNBoYNAi9vudBJ5+u9AgQ6fgEa4V+pqFzpV3aiB7GvqPazGVCLn
         9usugWSSLvnojBJ+lr7GiD3i5kUz2JBZAID8U4xu2qA+cbBGkTtrGiBblFsmXs5S2EOI
         dbafXjFQrUm2ytuBU9MwKY2WKLuhnsL1iu8sZqluGmBhHj30+mKkiN7MQ3Wjrwa2JODj
         YimcwOyOqMerR6CeksSmv2Ad9EC+Q31uaxYhpdLQf4QZPlZ2iuFppT0T88hXWY6xrivI
         uSqzR4x5o+fKydQ4EMnBZWU0/QULY6uqlPP0VTMfEAbVJVMXVx14VENxsfnFLvTByWvZ
         hNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683460826; x=1686052826;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0nJiRCqFioKC5MRnuGmcGFB6ukV5bHlnepMm6dcFvOw=;
        b=WapqRY8W7fiHsnsLPLSIg5XbfYAAr/PMJsCDewzpcNSW+31jgxVKgthhaXdHmrMARm
         zPV+lja1xotnYsRk/7NitcSiANMSGv+FWPVbnB1JdmbseoaocIcL34h6c7anWUcYlIbZ
         1cJuOTUu3MD2hcD5Flw/Wa3swwWvzf83U0irM5cGOctl7tWHs697BkzqT8PVn8NduvR+
         v6v6w1mVVgd70rFIGLWKjK3eRJ1EUCM84080AcWK5WNO77wD+WY7wRM/+jVehlsCSRfY
         A/rIflzzAWIo7KG8Pd5Slxkuo6GAPL0lZk+huF9DqnLaCGgmLLFkVNKtM6VrKZw6Da8Y
         rUpQ==
X-Gm-Message-State: AC+VfDx5PUUR3ZVHpiWpWvZHWmzyNXXmQ0Rl9loG3QPjIc2lBcC0RuWu
        J+RvG2bbvlkdl44WLiM1zciGbfR5LAvHhM1jpmA1zA==
X-Google-Smtp-Source: ACHHUZ59Gu5wU69hJl2QXrr2NSjwYRocohmkpqtV0Tw28q4ApYD0N5XmrRit2WmNW8g7DoxkS9QOxQ==
X-Received: by 2002:a05:6a00:801:b0:63b:64f7:45a0 with SMTP id m1-20020a056a00080100b0063b64f745a0mr10040971pfk.12.1683460825998;
        Sun, 07 May 2023 05:00:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h16-20020aa786d0000000b0063b8f33cb81sm4433312pfo.93.2023.05.07.05.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 05:00:25 -0700 (PDT)
Message-ID: <645792d9.a70a0220.ac7d7.81ae@mx.google.com>
Date:   Sun, 07 May 2023 05:00:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.176-634-gf42a280eea34
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 158 runs,
 6 regressions (v5.10.176-634-gf42a280eea34)
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

stable-rc/queue/5.10 baseline: 158 runs, 6 regressions (v5.10.176-634-gf42a=
280eea34)

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
nel/v5.10.176-634-gf42a280eea34/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.176-634-gf42a280eea34
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      f42a280eea34937b0c6853d75339e89249d6048a =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64575e51044c8924a82e85ec

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-634-gf42a280eea34/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-634-gf42a280eea34/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64575e51044c8924a82e8621
        failing since 82 days (last pass: v5.10.167-127-g921934d621e4, firs=
t fail: v5.10.167-139-gf9519a5a1701)

    2023-05-07T08:16:01.403152  <8>[   19.446622] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 421351_1.5.2.4.1>
    2023-05-07T08:16:01.513382  / # #
    2023-05-07T08:16:01.616711  export SHELL=3D/bin/sh
    2023-05-07T08:16:01.617702  #
    2023-05-07T08:16:01.719815  / # export SHELL=3D/bin/sh. /lava-421351/en=
vironment
    2023-05-07T08:16:01.720742  =

    2023-05-07T08:16:01.822960  / # . /lava-421351/environment/lava-421351/=
bin/lava-test-runner /lava-421351/1
    2023-05-07T08:16:01.824490  =

    2023-05-07T08:16:01.829005  / # /lava-421351/bin/lava-test-runner /lava=
-421351/1
    2023-05-07T08:16:01.933802  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645759f22d01ee92932e85f5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-634-gf42a280eea34/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-634-gf42a280eea34/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645759f22d01ee92932e85fa
        failing since 37 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-07T07:57:31.215237  + set +x

    2023-05-07T07:57:31.222043  <8>[   14.175909] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10224156_1.4.2.3.1>

    2023-05-07T07:57:31.326189  / # #

    2023-05-07T07:57:31.426830  export SHELL=3D/bin/sh

    2023-05-07T07:57:31.427054  #

    2023-05-07T07:57:31.527581  / # export SHELL=3D/bin/sh. /lava-10224156/=
environment

    2023-05-07T07:57:31.527768  =


    2023-05-07T07:57:31.628255  / # . /lava-10224156/environment/lava-10224=
156/bin/lava-test-runner /lava-10224156/1

    2023-05-07T07:57:31.628586  =


    2023-05-07T07:57:31.633212  / # /lava-10224156/bin/lava-test-runner /la=
va-10224156/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645759edb0f407b65a2e8626

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-634-gf42a280eea34/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-634-gf42a280eea34/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645759edb0f407b65a2e862b
        failing since 37 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-07T07:57:18.594533  <8>[   17.047155] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10224188_1.4.2.3.1>

    2023-05-07T07:57:18.598202  + set +x

    2023-05-07T07:57:18.704035  =


    2023-05-07T07:57:18.805834  / # #export SHELL=3D/bin/sh

    2023-05-07T07:57:18.806607  =


    2023-05-07T07:57:18.908246  / # export SHELL=3D/bin/sh. /lava-10224188/=
environment

    2023-05-07T07:57:18.909022  =


    2023-05-07T07:57:19.010800  / # . /lava-10224188/environment/lava-10224=
188/bin/lava-test-runner /lava-10224188/1

    2023-05-07T07:57:19.012148  =


    2023-05-07T07:57:19.017745  / # /lava-10224188/bin/lava-test-runner /la=
va-10224188/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64576171dc308be17f2e862c

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-634-gf42a280eea34/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-634-gf42a280eea34/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64576172dc308be17f2e8632
        failing since 54 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-07T08:29:30.611587  <8>[   33.917823] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-05-07T08:29:31.637574  /lava-10224445/1/../bin/lava-test-case

    2023-05-07T08:29:31.648506  <8>[   34.954992] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64576172dc308be17f2e8633
        failing since 54 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-07T08:29:30.600361  /lava-10224445/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64575dcf4938029edb2e865a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-634-gf42a280eea34/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-634-gf42a280eea34/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64575dcf4938029edb2e865f
        failing since 94 days (last pass: v5.10.165-139-gefb57ce0f880, firs=
t fail: v5.10.165-149-ge30e8271d674)

    2023-05-07T08:13:46.860507  / # #
    2023-05-07T08:13:46.962298  export SHELL=3D/bin/sh
    2023-05-07T08:13:46.962855  #
    2023-05-07T08:13:47.064357  / # export SHELL=3D/bin/sh. /lava-3559345/e=
nvironment
    2023-05-07T08:13:47.064855  =

    2023-05-07T08:13:47.166386  / # . /lava-3559345/environment/lava-355934=
5/bin/lava-test-runner /lava-3559345/1
    2023-05-07T08:13:47.167224  =

    2023-05-07T08:13:47.171636  / # /lava-3559345/bin/lava-test-runner /lav=
a-3559345/1
    2023-05-07T08:13:47.235758  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-07T08:13:47.270477  + cd /lava-3559345/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
