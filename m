Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4746FFCAD
	for <lists+stable@lfdr.de>; Fri, 12 May 2023 00:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbjEKWdU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 11 May 2023 18:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239078AbjEKWdU (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 11 May 2023 18:33:20 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07874E42
        for <stable@vger.kernel.org>; Thu, 11 May 2023 15:33:17 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-643846c006fso9797001b3a.0
        for <stable@vger.kernel.org>; Thu, 11 May 2023 15:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683844396; x=1686436396;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TSPHYOkL1wbp4u3zyDZZeQuH1Dq2hGML9UtF4QfvJYc=;
        b=k2YmUT420uAsGhDXK1Qtun2uo2AsphPTO4aPp+tq02sv7PSuJVBdp0Xe2UjCbtLYSM
         VA2RRDu0SVBqRxL1G7pSDCKwV8PLI9Py1SvDSoWsLQr50aXHjZTWlw8nJpmzGX53V0Er
         onlGoDPwZyFJ488xjH8Y8ZAdY8d7MDa+JnxlMJ1kOdM0U6P2nc8H4yntracCGX01e9Nq
         1vk8j85ipPk2fXf5X4j9L05KwT7uECVXYV1CjVJQ8Af+/YK8XWu5uKLEMcZUkJW+u+TC
         1M7aKNy6GROJwEjXpBgjaPWTH9syPAeaM9QZRJE8f5Na+WeILKJF4mxvFdeL9d1+PqoJ
         e4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683844396; x=1686436396;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TSPHYOkL1wbp4u3zyDZZeQuH1Dq2hGML9UtF4QfvJYc=;
        b=ik/gNnvWq405fBTEmEfKKKPhWU2f7GkJXAeo8UwqNZZZgQccm7ntQynoQc4lfo3Kx7
         wBZfr+3q1nhDz14yRBj4iGWSY6KAVyDFuDDno45W6SMzD/ioKn2i6n0JAOeKMb4NqXvT
         r9bwfVZNdW5k+Op6Z30uNz+u+WqJLo9oA/mxzZvMTe96QUrMzVc2TqfoHLx4PxPhNyyG
         xrZHVLIm/GQ4B1dN06Ct/5glD+J2xg+nklTsEwPBW6HLlIMNE3DXGQRLNd3r2oHnTlST
         RVts1ca9AyINSsgMj6B2YnDjHeYxOOZBt1ZNO4xxTPtCJ7EtKZWjR/b1X8xytO0Ma4YK
         PNeA==
X-Gm-Message-State: AC+VfDwxZA2gXQr1o22HZcxuq45WmlVyMzMYqSJQk7rv1eBhDCIMQ7nH
        m/HfsFj3BXDqoGFPdYWID9KaYepS75WiPLAnanfomg==
X-Google-Smtp-Source: ACHHUZ5/lJULqQDEh01K/xw+UHrace2NSwjFIl8T1XgL8F4dPOPALdVCd4DRf4V5nj+zI+FbZ7jB/w==
X-Received: by 2002:a05:6a00:1396:b0:646:6cc3:4a52 with SMTP id t22-20020a056a00139600b006466cc34a52mr18848465pfg.3.1683844395876;
        Thu, 11 May 2023 15:33:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g19-20020aa78753000000b00634b91326a9sm5969755pfo.143.2023.05.11.15.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 15:33:15 -0700 (PDT)
Message-ID: <645d6d2b.a70a0220.db81c.d33a@mx.google.com>
Date:   Thu, 11 May 2023 15:33:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.179-311-g6fa466ca14434
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 158 runs,
 4 regressions (v5.10.179-311-g6fa466ca14434)
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

stable-rc/queue/5.10 baseline: 158 runs, 4 regressions (v5.10.179-311-g6fa4=
66ca14434)

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

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.179-311-g6fa466ca14434/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.179-311-g6fa466ca14434
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      6fa466ca144344f028dad46017a4b9be69c00494 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/645d32f229317e56c22e8669

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-311-g6fa466ca14434/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-311-g6fa466ca14434/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d32f229317e56c22e8695
        failing since 86 days (last pass: v5.10.167-127-g921934d621e4, firs=
t fail: v5.10.167-139-gf9519a5a1701)

    2023-05-11T18:24:29.272540  <8>[   18.925786] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447783_1.5.2.4.1>
    2023-05-11T18:24:29.380762  / # #
    2023-05-11T18:24:29.482992  export SHELL=3D/bin/sh
    2023-05-11T18:24:29.483550  #
    2023-05-11T18:24:29.585153  / # export SHELL=3D/bin/sh. /lava-447783/en=
vironment
    2023-05-11T18:24:29.585736  =

    2023-05-11T18:24:29.687672  / # . /lava-447783/environment/lava-447783/=
bin/lava-test-runner /lava-447783/1
    2023-05-11T18:24:29.688802  =

    2023-05-11T18:24:29.692387  / # /lava-447783/bin/lava-test-runner /lava=
-447783/1
    2023-05-11T18:24:29.800635  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d327959bcc87ece2e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-311-g6fa466ca14434/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-311-g6fa466ca14434/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d327959bcc87ece2e85eb
        failing since 42 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-11T18:22:32.726199  + <8>[   10.292068] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10286890_1.4.2.3.1>

    2023-05-11T18:22:32.726284  set +x

    2023-05-11T18:22:32.827725  =


    2023-05-11T18:22:32.928336  / # #export SHELL=3D/bin/sh

    2023-05-11T18:22:32.928635  =


    2023-05-11T18:22:33.029202  / # export SHELL=3D/bin/sh. /lava-10286890/=
environment

    2023-05-11T18:22:33.029419  =


    2023-05-11T18:22:33.130021  / # . /lava-10286890/environment/lava-10286=
890/bin/lava-test-runner /lava-10286890/1

    2023-05-11T18:22:33.130354  =


    2023-05-11T18:22:33.134580  / # /lava-10286890/bin/lava-test-runner /la=
va-10286890/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d3259ea630429662e85f1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-311-g6fa466ca14434/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-311-g6fa466ca14434/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d3259ea630429662e85f6
        failing since 42 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-11T18:22:03.170595  <8>[   15.872514] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10286951_1.4.2.3.1>

    2023-05-11T18:22:03.173850  + set +x

    2023-05-11T18:22:03.279003  =


    2023-05-11T18:22:03.380108  / # #export SHELL=3D/bin/sh

    2023-05-11T18:22:03.380741  =


    2023-05-11T18:22:03.481854  / # export SHELL=3D/bin/sh. /lava-10286951/=
environment

    2023-05-11T18:22:03.482610  =


    2023-05-11T18:22:03.584022  / # . /lava-10286951/environment/lava-10286=
951/bin/lava-test-runner /lava-10286951/1

    2023-05-11T18:22:03.585204  =


    2023-05-11T18:22:03.590197  / # /lava-10286951/bin/lava-test-runner /la=
va-10286951/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645d36ca2f8e1e8f4b2e85eb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-311-g6fa466ca14434/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-311-g6fa466ca14434/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d36ca2f8e1e8f4b2e85f0
        failing since 98 days (last pass: v5.10.165-139-gefb57ce0f880, firs=
t fail: v5.10.165-149-ge30e8271d674)

    2023-05-11T18:40:54.870171  / # #
    2023-05-11T18:40:54.972140  export SHELL=3D/bin/sh
    2023-05-11T18:40:54.972710  #
    2023-05-11T18:40:55.074117  / # export SHELL=3D/bin/sh. /lava-3576680/e=
nvironment
    2023-05-11T18:40:55.074674  =

    2023-05-11T18:40:55.176111  / # . /lava-3576680/environment/lava-357668=
0/bin/lava-test-runner /lava-3576680/1
    2023-05-11T18:40:55.176959  =

    2023-05-11T18:40:55.181090  / # /lava-3576680/bin/lava-test-runner /lav=
a-3576680/1
    2023-05-11T18:40:55.245193  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-11T18:40:55.293028  + cd /lava-3576680/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
