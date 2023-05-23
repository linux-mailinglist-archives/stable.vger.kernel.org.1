Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8315270D101
	for <lists+stable@lfdr.de>; Tue, 23 May 2023 04:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbjEWCRh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 22:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234552AbjEWCRb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 22:17:31 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354DF1A7
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:17:09 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64d44b198baso2092671b3a.0
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684808228; x=1687400228;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FmKe1cNTqOXqDXkVpRllgyOt51z3geFfuyD8QLpedqk=;
        b=JMGovQKobAmgkd+NM9bTTm9EqzAKBhzzghMqfqZ46hquF5xtuvSDGHPoFQlwuIr/rx
         BbPxS3WDHr1s2kvsOr6Ti5h+yDZImLSUGxmvQ1eQJzapTv2DE5dTTONbYv+Qmt+5m4G2
         pY2jvA+Pip3PAzkb93FclAXs0R7Nf26tbR9BfpbZ5JxuRZK5pB06bM79zQ3QTI6qxZ3R
         K81oY1zIZirJfSv95CNTQmO5US+J1vhrUnruDN6T3kiqmD0z5cUImAPcw3ccqEDIc9RR
         /RzlO2yCG5gb6eRYOJn9TRfXp+w2YrGzlk6lexffuVMmP2popwJRtwfWg766WSodlafU
         z0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684808228; x=1687400228;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FmKe1cNTqOXqDXkVpRllgyOt51z3geFfuyD8QLpedqk=;
        b=BfaP7/jmnHS7Ebu9mKVP0tybvkpwB8iirpwwTL2MzmsaLBKw5qbFDe/Xzw1pDLJ1D5
         0jcqZcyAk6U8eKnDgIHb8VyfBr6s/ciJup4a6CVIJUZQnGTeQeKLj4epZkxFrWa+1zPr
         tA99JS89IGeDkeF3KVFuVqqm5B4kmOWAthuIzfUxBZao6BfvTLgStZXomaajQyz04ha2
         1tI0JbNtWkOfVE+H3RssL4usBMz9edXMIXqxxvEXeSykjEUyw4pdC5rCamsXumwjTlvF
         kbi8GJJyurZKmGD9RJi1gYXf31pJ7HJi9qevyIqUqazSIiImQ1sYhtZukDEjUcYGJ/Ae
         ubEA==
X-Gm-Message-State: AC+VfDwHciM+fxOr13gwcvnyHxjsKbVobYObYhP/3ltuUXdbj6YlYPYG
        +aBciuaNGyVM8XuPuaGsWvNA8j+iXK9+u8vwi23V+g==
X-Google-Smtp-Source: ACHHUZ6iWX/HrexCbP14IGQ3bD06B37CJu2oiohH1KMZXJZuF3EIc+5lhq49I6EllDA/LglIQIVPKQ==
X-Received: by 2002:a05:6a00:188c:b0:64d:421c:ae43 with SMTP id x12-20020a056a00188c00b0064d421cae43mr12899713pfh.11.1684808227829;
        Mon, 22 May 2023 19:17:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s9-20020aa78289000000b0063f2e729127sm4805250pfm.144.2023.05.22.19.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 19:17:07 -0700 (PDT)
Message-ID: <646c2223.a70a0220.14f9.8841@mx.google.com>
Date:   Mon, 22 May 2023 19:17:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.180-153-ga0e401ac36bd3
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 159 runs,
 6 regressions (v5.10.180-153-ga0e401ac36bd3)
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

stable-rc/queue/5.10 baseline: 159 runs, 6 regressions (v5.10.180-153-ga0e4=
01ac36bd3)

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
nel/v5.10.180-153-ga0e401ac36bd3/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.180-153-ga0e401ac36bd3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      a0e401ac36bd3e4018462c81a51e7337cf69a80a =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/646bf000962a849d712e86d4

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-153-ga0e401ac36bd3/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-153-ga0e401ac36bd3/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646bf000962a849d712e870a
        failing since 98 days (last pass: v5.10.167-127-g921934d621e4, firs=
t fail: v5.10.167-139-gf9519a5a1701)

    2023-05-22T22:42:45.388981  <8>[   25.908754] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 497798_1.5.2.4.1>
    2023-05-22T22:42:45.499028  / # #
    2023-05-22T22:42:45.601844  export SHELL=3D/bin/sh
    2023-05-22T22:42:45.602642  #
    2023-05-22T22:42:45.704937  / # export SHELL=3D/bin/sh. /lava-497798/en=
vironment
    2023-05-22T22:42:45.705515  =

    2023-05-22T22:42:45.807389  / # . /lava-497798/environment/lava-497798/=
bin/lava-test-runner /lava-497798/1
    2023-05-22T22:42:45.808543  =

    2023-05-22T22:42:45.813471  / # /lava-497798/bin/lava-test-runner /lava=
-497798/1
    2023-05-22T22:42:45.921128  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646bee0145e3628a542e8604

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-153-ga0e401ac36bd3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-153-ga0e401ac36bd3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646bee0145e3628a542e8609
        failing since 53 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-22T22:34:33.821612  + set +x

    2023-05-22T22:34:33.828000  <8>[   14.491926] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10417791_1.4.2.3.1>

    2023-05-22T22:34:33.932220  / # #

    2023-05-22T22:34:34.032891  export SHELL=3D/bin/sh

    2023-05-22T22:34:34.033097  #

    2023-05-22T22:34:34.133666  / # export SHELL=3D/bin/sh. /lava-10417791/=
environment

    2023-05-22T22:34:34.133852  =


    2023-05-22T22:34:34.234362  / # . /lava-10417791/environment/lava-10417=
791/bin/lava-test-runner /lava-10417791/1

    2023-05-22T22:34:34.234635  =


    2023-05-22T22:34:34.239128  / # /lava-10417791/bin/lava-test-runner /la=
va-10417791/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646bee10b40a6cdbfb2e862a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-153-ga0e401ac36bd3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-153-ga0e401ac36bd3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646bee10b40a6cdbfb2e862f
        failing since 53 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-22T22:34:39.180898  <8>[   15.209474] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10417741_1.4.2.3.1>

    2023-05-22T22:34:39.184461  + set +x

    2023-05-22T22:34:39.292468  / # #

    2023-05-22T22:34:39.395015  export SHELL=3D/bin/sh

    2023-05-22T22:34:39.395950  #

    2023-05-22T22:34:39.497764  / # export SHELL=3D/bin/sh. /lava-10417741/=
environment

    2023-05-22T22:34:39.498620  =


    2023-05-22T22:34:39.600207  / # . /lava-10417741/environment/lava-10417=
741/bin/lava-test-runner /lava-10417741/1

    2023-05-22T22:34:39.601593  =


    2023-05-22T22:34:39.607532  / # /lava-10417741/bin/lava-test-runner /la=
va-10417741/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/646bf145d5485f25202e876d

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-153-ga0e401ac36bd3/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-153-ga0e401ac36bd3/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/646bf145d5485f25202e8773
        failing since 69 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-22T22:48:13.680750  <8>[   60.941927] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-05-22T22:48:14.704379  /lava-10418020/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/646bf145d5485f25202e8774
        failing since 69 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-22T22:48:13.668830  /lava-10418020/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646bee06b40a6cdbfb2e8605

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-153-ga0e401ac36bd3/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-153-ga0e401ac36bd3/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646bee06b40a6cdbfb2e860a
        failing since 110 days (last pass: v5.10.165-139-gefb57ce0f880, fir=
st fail: v5.10.165-149-ge30e8271d674)

    2023-05-22T22:34:22.014958  / # #
    2023-05-22T22:34:22.116852  export SHELL=3D/bin/sh
    2023-05-22T22:34:22.117355  #
    2023-05-22T22:34:22.218730  / # export SHELL=3D/bin/sh. /lava-3609746/e=
nvironment
    2023-05-22T22:34:22.219232  =

    2023-05-22T22:34:22.320623  / # . /lava-3609746/environment/lava-360974=
6/bin/lava-test-runner /lava-3609746/1
    2023-05-22T22:34:22.321374  =

    2023-05-22T22:34:22.327047  / # /lava-3609746/bin/lava-test-runner /lav=
a-3609746/1
    2023-05-22T22:34:22.391162  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-22T22:34:22.439008  + cd /lava-3609746/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
