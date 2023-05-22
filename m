Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A860070B4E9
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 08:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjEVGQY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 02:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjEVGQX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 02:16:23 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028E8CF
        for <stable@vger.kernel.org>; Sun, 21 May 2023 23:16:22 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64d1a0d640cso3039830b3a.1
        for <stable@vger.kernel.org>; Sun, 21 May 2023 23:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684736181; x=1687328181;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hvp+vm+ghPtp23T2q9SBan8htQNyrius7I+DE73tBNs=;
        b=BY6xWfWXf82KNFotLBlueLixB5OW3Omlu0TAVcwGKcmEUz33Kpyu4b73BiahKL7glE
         JzNxIgY8us0aTbSRz3yqYHUSRXmi/yeEnMEtdPj6/x/EO1gU7TV4Ml57yaG3u6hExQdZ
         q3r2DR+xZXJKQxoMQ5bfYCuVXQuSDD4pfej97sMnRNMZcWv+giy9VVLSGZ5haNp4uR4C
         KdKlr4KnI7Qy3ML8S2m0dwUCJ1eQ9TqD4ZAz++vipEnGcdQ+8zoMr1HN5Vjs+NrFreZr
         YBmtxmh2mSjQa5pUj0F0l0AKscD40UVwBn+eRu6zqfMRrE21+dT/C0pNDcoXnw7nd6Iz
         2jZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684736181; x=1687328181;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hvp+vm+ghPtp23T2q9SBan8htQNyrius7I+DE73tBNs=;
        b=N1SmdYMagHLSRAU7nKt4Z5Dsiv7QVMy2WZnCExalrJaltnOfU5MMaejaGTQy71GUzT
         UYjYMXYr29pUi6LpIIJ95hQWxSntSetsvjLrAGbLLhXXLW7CVVqsfLMfyBTmOGewHOQN
         CTKm47eZl1BakGtDQfNrYh50Kq3aIzUrTnd5LIgQj5f52X2vKsVIJo/7WQp0P2eMf/ja
         EWDZrkemZN4sXZfig3uBDIGxVvXYWSD/mUN5xX2mfEIWRtJHRunANaW+wZREGxd3HJm7
         +MrBObQPkEGrbVBFmvz1eev3P0CHJaHNPdcNVtRqqCiW59wcVCy2HMiJ3YzUcQDOhnpD
         yWHQ==
X-Gm-Message-State: AC+VfDycGL20JCDu3k1xA3+u+5jngeQBg7A+8sdW1R0EJtUDdRbYH33T
        k9+JIecXT1EdzgQQo9kIWiW6NtsjR7hLwmJHtdY=
X-Google-Smtp-Source: ACHHUZ6EZWzpwGGwi+bXOEtQf47v096uHvvRf4O9Gy9yF0WUF5KuIitZLkT81l9XK+itqVVUcgrVHA==
X-Received: by 2002:a05:6a00:22c8:b0:646:ec88:998c with SMTP id f8-20020a056a0022c800b00646ec88998cmr14027165pfj.15.1684736180844;
        Sun, 21 May 2023 23:16:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a20-20020aa780d4000000b0064ceb16a1a8sm3418263pfn.33.2023.05.21.23.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 23:16:20 -0700 (PDT)
Message-ID: <646b08b4.a70a0220.77616.5517@mx.google.com>
Date:   Sun, 21 May 2023 23:16:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.180-86-g6c6da2307cf8
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 154 runs,
 6 regressions (v5.10.180-86-g6c6da2307cf8)
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

stable-rc/queue/5.10 baseline: 154 runs, 6 regressions (v5.10.180-86-g6c6da=
2307cf8)

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
nel/v5.10.180-86-g6c6da2307cf8/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.180-86-g6c6da2307cf8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      6c6da2307cf897cd198f2b6b41e1b223c950ace3 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/646ad60c55644ea45e2e85e7

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-86-g6c6da2307cf8/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beagl=
ebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-86-g6c6da2307cf8/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beagl=
ebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646ad60c55644ea45e2e861d
        failing since 97 days (last pass: v5.10.167-127-g921934d621e4, firs=
t fail: v5.10.167-139-gf9519a5a1701)

    2023-05-22T02:39:47.397622  <8>[   16.086104] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 492655_1.5.2.4.1>
    2023-05-22T02:39:47.507858  / # #
    2023-05-22T02:39:47.611139  export SHELL=3D/bin/sh
    2023-05-22T02:39:47.611877  #
    2023-05-22T02:39:47.714430  / # export SHELL=3D/bin/sh. /lava-492655/en=
vironment
    2023-05-22T02:39:47.715173  =

    2023-05-22T02:39:47.817538  / # . /lava-492655/environment/lava-492655/=
bin/lava-test-runner /lava-492655/1
    2023-05-22T02:39:47.819108  =

    2023-05-22T02:39:47.822908  / # /lava-492655/bin/lava-test-runner /lava=
-492655/1
    2023-05-22T02:39:47.927237  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646ad4287e2acb42442e863c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-86-g6c6da2307cf8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-86-g6c6da2307cf8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646ad4287e2acb42442e8641
        failing since 52 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-22T02:32:00.261548  + <8>[   10.702307] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10406755_1.4.2.3.1>

    2023-05-22T02:32:00.261655  set +x

    2023-05-22T02:32:00.362904  #

    2023-05-22T02:32:00.463771  / # #export SHELL=3D/bin/sh

    2023-05-22T02:32:00.464006  =


    2023-05-22T02:32:00.564579  / # export SHELL=3D/bin/sh. /lava-10406755/=
environment

    2023-05-22T02:32:00.564792  =


    2023-05-22T02:32:00.665344  / # . /lava-10406755/environment/lava-10406=
755/bin/lava-test-runner /lava-10406755/1

    2023-05-22T02:32:00.665686  =


    2023-05-22T02:32:00.669933  / # /lava-10406755/bin/lava-test-runner /la=
va-10406755/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646ad43b5e708b992f2e8658

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-86-g6c6da2307cf8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-86-g6c6da2307cf8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646ad43b5e708b992f2e865d
        failing since 52 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-22T02:32:05.414001  + set +x<8>[   15.225638] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10406800_1.4.2.3.1>

    2023-05-22T02:32:05.414088  =


    2023-05-22T02:32:05.515634  /#

    2023-05-22T02:32:05.616472   # #export SHELL=3D/bin/sh

    2023-05-22T02:32:05.616654  =


    2023-05-22T02:32:05.717139  / # export SHELL=3D/bin/sh. /lava-10406800/=
environment

    2023-05-22T02:32:05.717338  =


    2023-05-22T02:32:05.817852  / # . /lava-10406800/environment/lava-10406=
800/bin/lava-test-runner /lava-10406800/1

    2023-05-22T02:32:05.818140  =


    2023-05-22T02:32:05.822925  / # /lava-10406800/bin/lava-test-runner /la=
va-10406800/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/646ad4a02ad975c0ec2e8626

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-86-g6c6da2307cf8/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-86-g6c6da2307cf8/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/646ad4a02ad975c0ec2e862c
        failing since 69 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-22T02:33:48.615728  /lava-10406715/1/../bin/lava-test-case

    2023-05-22T02:33:48.626744  <8>[   34.869771] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/646ad4a02ad975c0ec2e862d
        failing since 69 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-22T02:33:46.558208  <8>[   32.798719] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-05-22T02:33:47.581014  /lava-10406715/1/../bin/lava-test-case

    2023-05-22T02:33:47.591851  <8>[   33.834494] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646ad7ba6f2a798f9f2e85ea

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-86-g6c6da2307cf8/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i=
-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-86-g6c6da2307cf8/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i=
-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646ad7ba6f2a798f9f2e85ef
        failing since 109 days (last pass: v5.10.165-139-gefb57ce0f880, fir=
st fail: v5.10.165-149-ge30e8271d674)

    2023-05-22T02:47:10.671700  / # #
    2023-05-22T02:47:10.773377  export SHELL=3D/bin/sh
    2023-05-22T02:47:10.773724  #
    2023-05-22T02:47:10.875022  / # export SHELL=3D/bin/sh. /lava-3607686/e=
nvironment
    2023-05-22T02:47:10.875368  =

    2023-05-22T02:47:10.976680  / # . /lava-3607686/environment/lava-360768=
6/bin/lava-test-runner /lava-3607686/1
    2023-05-22T02:47:10.977272  =

    2023-05-22T02:47:10.984229  / # /lava-3607686/bin/lava-test-runner /lav=
a-3607686/1
    2023-05-22T02:47:11.048304  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-22T02:47:11.095138  + cd /lava-3607686/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
