Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC91C70C3A3
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 18:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbjEVQlg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 12:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjEVQlf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 12:41:35 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38705F4
        for <stable@vger.kernel.org>; Mon, 22 May 2023 09:41:31 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d5b4c3ffeso1288025b3a.2
        for <stable@vger.kernel.org>; Mon, 22 May 2023 09:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684773690; x=1687365690;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nvhmGfCuvH0iQ4D87cSb+MeuXOC3lHNRTeKUt83v2FE=;
        b=g1YPch+u+08uPMyPoEVWaW4rPUP0gCReEewq60n0tN3jOegToCCfkTRVIGvptJyiPW
         EIYt02DREnOEI06Y10yczKgadFahYtOUGNrCfJz58nbk5kZJrG4KlE484zmoMClulXJI
         BCYvR2VAd6NBXAN6q9FLzEx5dPpLpFWL9IGlYghLvgtg8VCFGcA+ORh+nPJ4xX59THLM
         vqBUoD3u1k482cXFe6AV896Jm3i6N08cJMAgc2Y8so9ge7n8W/YHkk/yE8sVMzJK9yjB
         c9WbOIgSOyTEk0mnsjBzMRCVSSAwilGFCbvNJy3cjze+etA4gh7mQvT19GIfKZWRHovo
         K+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773690; x=1687365690;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nvhmGfCuvH0iQ4D87cSb+MeuXOC3lHNRTeKUt83v2FE=;
        b=htNaTOIKkP6Fe2ALMUqjUuO5aAmLMXpiH9NyNPo0JDgDESBxR9306bYZgqsmHXIDcX
         owKm7c3UV8gZAKw8YkEEg3+riTA7bZbZEPMuDLRvcZvrVDI8+RH4+hSd6OBfMwm/WXHA
         c4GR5Sb3yZTNSBKtjA3ffQDws7st2bX2oesU7an9cz2U/T2EFPhLT8X51kbNeKlyWwFd
         gENzce8/PMJI54az+oJJOn02yOsI78w3ns3iTmUkFFwL+J03KSY/rKb6vHxcxX71Ma3u
         2ZqLaB+H1VkTQuA6VO9jPll2izucSMfyfTIq/GcjT/N3an0AJJJawq2LpZROFPaUbUnl
         J5Gw==
X-Gm-Message-State: AC+VfDyy37Vqrjxu7VEhQOWuwBu4jWbauP5lQHRUtMXgYMt483ZY/EYz
        xLIOd+9h7So0YOsMTkw3LcVm8xylvA6yw3AXB/58YA==
X-Google-Smtp-Source: ACHHUZ5MgluErqsP6/XCcIJT2GcmPr3Kay6oUzPf+p1xHnW61YdqN3ML9zmYRncIBotUG9b/vp761g==
X-Received: by 2002:a05:6a00:15c7:b0:63b:8f08:9af3 with SMTP id o7-20020a056a0015c700b0063b8f089af3mr17547978pfu.7.1684773690085;
        Mon, 22 May 2023 09:41:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e23-20020aa78257000000b0063d63d48215sm4382315pfn.3.2023.05.22.09.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:41:29 -0700 (PDT)
Message-ID: <646b9b39.a70a0220.9d67e.7515@mx.google.com>
Date:   Mon, 22 May 2023 09:41:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.180-122-g041f2b5d96fd7
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 165 runs,
 6 regressions (v5.10.180-122-g041f2b5d96fd7)
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

stable-rc/queue/5.10 baseline: 165 runs, 6 regressions (v5.10.180-122-g041f=
2b5d96fd7)

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
nel/v5.10.180-122-g041f2b5d96fd7/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.180-122-g041f2b5d96fd7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      041f2b5d96fd73b79113eab5cf54d6b15e77f807 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/646b6a53c85c1f37d22e8609

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-122-g041f2b5d96fd7/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-122-g041f2b5d96fd7/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646b6a53c85c1f37d22e863f
        failing since 97 days (last pass: v5.10.167-127-g921934d621e4, firs=
t fail: v5.10.167-139-gf9519a5a1701)

    2023-05-22T13:12:30.839684  <8>[   19.713933] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 494657_1.5.2.4.1>
    2023-05-22T13:12:30.948823  / # #
    2023-05-22T13:12:31.050753  export SHELL=3D/bin/sh
    2023-05-22T13:12:31.051329  #
    2023-05-22T13:12:31.152810  / # export SHELL=3D/bin/sh. /lava-494657/en=
vironment
    2023-05-22T13:12:31.153356  =

    2023-05-22T13:12:31.254831  / # . /lava-494657/environment/lava-494657/=
bin/lava-test-runner /lava-494657/1
    2023-05-22T13:12:31.255823  =

    2023-05-22T13:12:31.260403  / # /lava-494657/bin/lava-test-runner /lava=
-494657/1
    2023-05-22T13:12:31.355916  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646b6a16bba4c6db0b2e85f6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-122-g041f2b5d96fd7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-122-g041f2b5d96fd7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646b6a16bba4c6db0b2e85fb
        failing since 53 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-22T13:11:34.106466  + <8>[   11.107431] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10410560_1.4.2.3.1>

    2023-05-22T13:11:34.106558  set +x

    2023-05-22T13:11:34.208313  =


    2023-05-22T13:11:34.308915  / # #export SHELL=3D/bin/sh

    2023-05-22T13:11:34.309190  =


    2023-05-22T13:11:34.409821  / # export SHELL=3D/bin/sh. /lava-10410560/=
environment

    2023-05-22T13:11:34.410098  =


    2023-05-22T13:11:34.510759  / # . /lava-10410560/environment/lava-10410=
560/bin/lava-test-runner /lava-10410560/1

    2023-05-22T13:11:34.511156  =


    2023-05-22T13:11:34.515741  / # /lava-10410560/bin/lava-test-runner /la=
va-10410560/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646b6a1b2b5b4f1e3c2e861a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-122-g041f2b5d96fd7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-122-g041f2b5d96fd7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646b6a1b2b5b4f1e3c2e861f
        failing since 53 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-22T13:11:35.079669  + set +x<8>[   12.476852] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10410547_1.4.2.3.1>

    2023-05-22T13:11:35.080211  =


    2023-05-22T13:11:35.187324  #

    2023-05-22T13:11:35.288744  / # #export SHELL=3D/bin/sh

    2023-05-22T13:11:35.289476  =


    2023-05-22T13:11:35.390748  / # export SHELL=3D/bin/sh. /lava-10410547/=
environment

    2023-05-22T13:11:35.391512  =


    2023-05-22T13:11:35.492879  / # . /lava-10410547/environment/lava-10410=
547/bin/lava-test-runner /lava-10410547/1

    2023-05-22T13:11:35.493906  =


    2023-05-22T13:11:35.498834  / # /lava-10410547/bin/lava-test-runner /la=
va-10410547/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/646b6a54c85c1f37d22e8645

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-122-g041f2b5d96fd7/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-122-g041f2b5d96fd7/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/646b6a54c85c1f37d22e864b
        failing since 69 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-22T13:12:47.371780  /lava-10410228/1/../bin/lava-test-case

    2023-05-22T13:12:47.382167  <8>[   33.531290] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/646b6a54c85c1f37d22e864c
        failing since 69 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-22T13:12:45.308904  <8>[   31.457301] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-05-22T13:12:46.333338  /lava-10410228/1/../bin/lava-test-case

    2023-05-22T13:12:46.344442  <8>[   32.493470] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646b6861d1ba2458572e85fe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-122-g041f2b5d96fd7/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-122-g041f2b5d96fd7/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646b6861d1ba2458572e8603
        failing since 109 days (last pass: v5.10.165-139-gefb57ce0f880, fir=
st fail: v5.10.165-149-ge30e8271d674)

    2023-05-22T13:04:05.254036  / # #
    2023-05-22T13:04:05.355710  export SHELL=3D/bin/sh
    2023-05-22T13:04:05.356069  #
    2023-05-22T13:04:05.457384  / # export SHELL=3D/bin/sh. /lava-3608403/e=
nvironment
    2023-05-22T13:04:05.457740  =

    2023-05-22T13:04:05.559074  / # . /lava-3608403/environment/lava-360840=
3/bin/lava-test-runner /lava-3608403/1
    2023-05-22T13:04:05.559688  =

    2023-05-22T13:04:05.565311  / # /lava-3608403/bin/lava-test-runner /lav=
a-3608403/1
    2023-05-22T13:04:05.629416  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-22T13:04:05.678160  + cd /lava-3608403/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
