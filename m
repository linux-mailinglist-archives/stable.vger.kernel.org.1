Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A46C70181F
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 18:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjEMQIh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 12:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEMQIg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 12:08:36 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B551BFB
        for <stable@vger.kernel.org>; Sat, 13 May 2023 09:08:33 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-24e015fcf3dso8204148a91.3
        for <stable@vger.kernel.org>; Sat, 13 May 2023 09:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683994112; x=1686586112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JL4bpwjF53LRdS3pFH+2G7t9oIVdDKXa1W33CIj6+ak=;
        b=hDjaVXaqpqRB88eTJQuxrIB/2DOUzdSIc962r9qYUQCpMJTmjBDAp2ccHB0lnkAys2
         HgF43Tu5cgVLV24yHboT4xdNnj+zXmoJfqUAUzt2nf2jBFAX4dSXHqipZNa6MAefCUkF
         X1t+jiIWAyAMuQJbBNxzdWInjUfnr723e4vKrSNe6R8cdygav5vKtiufii41BYgr/Zq6
         HBvGXavW7dKvAbrICiIjr3NLg9gLs9ry8LK1mlPAm+hb3hImPfAO8ue6SvIAz0pR/sMx
         spXVxTBLpS4cOEhNEP1CvrURsmlj7YKiv9b9j83yLlzvPJADPubY8GfGDiNaMLYW01zk
         K8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683994112; x=1686586112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JL4bpwjF53LRdS3pFH+2G7t9oIVdDKXa1W33CIj6+ak=;
        b=i1rFlesgjUd5BusoQu74qDvo4yYFhqSpfesqcNM0ZtFBK/MgSQXOwbLoZ0U9LwB2ol
         IfjckXxuJtrkQ0z4M0ogiAv+JQJ1Mw1l7NjO5tpreMJosOEsItdatH6ezgE9v7xFWAFd
         TboZSo30DJLxHXV/uqYWGliR8MaW/r+/nb+hdSwMmyDbi0ZkSRaWAfvBrtlBfB0i+EQl
         R1GmMFfczgo8l2TMpk2/Hh+QRFIc9rM1xhA3vo1uk6HAzmqsJbvIpbwUOWJ9RZH5h8UY
         TbdKGMwMbfyunKnvrdLqcrkacEpO30sQenkAuTRqXhhMAI44wOF1MT0r2pZYbOQOHJeo
         y7lQ==
X-Gm-Message-State: AC+VfDzlf0oWYYVszkLZz4Lu1Mn3GYIrK2sxZM98UbwBlNzaA8zEQAPI
        xLsfUrx6prKIZ9DOdAAVPqutbiX27qp4jMJAJ2E=
X-Google-Smtp-Source: ACHHUZ7d+yrnnWXpjBD4NUGT6wbYgqHlQ15c+1RBHAExieC0zPOJQv0IDKnfYz3MacsQt04DFiolxw==
X-Received: by 2002:a17:90a:f3d5:b0:24d:fb8f:6c16 with SMTP id ha21-20020a17090af3d500b0024dfb8f6c16mr29455144pjb.16.1683994112268;
        Sat, 13 May 2023 09:08:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q2-20020a17090a2dc200b0024e11f7a002sm22205449pjm.15.2023.05.13.09.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 09:08:31 -0700 (PDT)
Message-ID: <645fb5ff.170a0220.399c8.b111@mx.google.com>
Date:   Sat, 13 May 2023 09:08:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.111-100-g30112e7e73f2f
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 178 runs,
 13 regressions (v5.15.111-100-g30112e7e73f2f)
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

stable-rc/queue/5.15 baseline: 178 runs, 13 regressions (v5.15.111-100-g301=
12e7e73f2f)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 3          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.111-100-g30112e7e73f2f/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.111-100-g30112e7e73f2f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      30112e7e73f2faea624d91c10f128ec908ac021c =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f80415e637673782e86d3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g30112e7e73f2f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g30112e7e73f2f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f80415e637673782e86d8
        failing since 46 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-13T12:18:54.413074  + <8>[   11.627184] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10304721_1.4.2.3.1>

    2023-05-13T12:18:54.413725  set +x

    2023-05-13T12:18:54.521752  / # #

    2023-05-13T12:18:54.624405  export SHELL=3D/bin/sh

    2023-05-13T12:18:54.625194  #

    2023-05-13T12:18:54.726713  / # export SHELL=3D/bin/sh. /lava-10304721/=
environment

    2023-05-13T12:18:54.727538  =


    2023-05-13T12:18:54.829324  / # . /lava-10304721/environment/lava-10304=
721/bin/lava-test-runner /lava-10304721/1

    2023-05-13T12:18:54.830579  =


    2023-05-13T12:18:54.835677  / # /lava-10304721/bin/lava-test-runner /la=
va-10304721/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f80445e637673782e86ef

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g30112e7e73f2f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g30112e7e73f2f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f80445e637673782e86f4
        failing since 46 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-13T12:18:52.618132  <8>[   10.486525] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10304747_1.4.2.3.1>

    2023-05-13T12:18:52.621776  + set +x

    2023-05-13T12:18:52.727365  #

    2023-05-13T12:18:52.728711  =


    2023-05-13T12:18:52.830555  / # #export SHELL=3D/bin/sh

    2023-05-13T12:18:52.831509  =


    2023-05-13T12:18:52.933220  / # export SHELL=3D/bin/sh. /lava-10304747/=
environment

    2023-05-13T12:18:52.933965  =


    2023-05-13T12:18:53.035670  / # . /lava-10304747/environment/lava-10304=
747/bin/lava-test-runner /lava-10304747/1

    2023-05-13T12:18:53.036990  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/645f83952317b80c612e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g30112e7e73f2f/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g30112e7e73f2f/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645f83952317b80c612e8=
5e7
        failing since 99 days (last pass: v5.15.91-12-g3290f78df1ab, first =
fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645f8166a91306e6212e862a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g30112e7e73f2f/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g30112e7e73f2f/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f8166a91306e6212e862f
        failing since 116 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-13T12:23:52.020801  <8>[    9.891334] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3584121_1.5.2.4.1>
    2023-05-13T12:23:52.132505  / # #
    2023-05-13T12:23:52.235184  export SHELL=3D/bin/sh
    2023-05-13T12:23:52.235923  #
    2023-05-13T12:23:52.337538  / # export SHELL=3D/bin/sh. /lava-3584121/e=
nvironment
    2023-05-13T12:23:52.338473  =

    2023-05-13T12:23:52.440353  / # . /lava-3584121/environment/lava-358412=
1/bin/lava-test-runner /lava-3584121/1
    2023-05-13T12:23:52.441636  =

    2023-05-13T12:23:52.446688  / # /lava-3584121/bin/lava-test-runner /lav=
a-3584121/1
    2023-05-13T12:23:52.541425  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f80714b8c9923f72e862b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g30112e7e73f2f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g30112e7e73f2f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f80714b8c9923f72e8630
        failing since 46 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-13T12:19:45.609214  + set +x

    2023-05-13T12:19:45.615653  <8>[   10.661049] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10304760_1.4.2.3.1>

    2023-05-13T12:19:45.720091  / # #

    2023-05-13T12:19:45.820663  export SHELL=3D/bin/sh

    2023-05-13T12:19:45.820855  #

    2023-05-13T12:19:45.921331  / # export SHELL=3D/bin/sh. /lava-10304760/=
environment

    2023-05-13T12:19:45.921578  =


    2023-05-13T12:19:46.022090  / # . /lava-10304760/environment/lava-10304=
760/bin/lava-test-runner /lava-10304760/1

    2023-05-13T12:19:46.022483  =


    2023-05-13T12:19:46.026816  / # /lava-10304760/bin/lava-test-runner /la=
va-10304760/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f80228205b471612e865c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g30112e7e73f2f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g30112e7e73f2f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f80228205b471612e8661
        failing since 46 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-13T12:18:20.934384  <8>[   11.002100] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10304737_1.4.2.3.1>

    2023-05-13T12:18:20.937610  + set +x

    2023-05-13T12:18:21.042138  / # #

    2023-05-13T12:18:21.142823  export SHELL=3D/bin/sh

    2023-05-13T12:18:21.143036  #

    2023-05-13T12:18:21.243574  / # export SHELL=3D/bin/sh. /lava-10304737/=
environment

    2023-05-13T12:18:21.243791  =


    2023-05-13T12:18:21.344331  / # . /lava-10304737/environment/lava-10304=
737/bin/lava-test-runner /lava-10304737/1

    2023-05-13T12:18:21.344639  =


    2023-05-13T12:18:21.349790  / # /lava-10304737/bin/lava-test-runner /la=
va-10304737/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f802be608f9bc022e85fe

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g30112e7e73f2f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g30112e7e73f2f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f802be608f9bc022e8603
        failing since 46 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-13T12:18:30.062641  + set<8>[   11.411702] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10304716_1.4.2.3.1>

    2023-05-13T12:18:30.062779   +x

    2023-05-13T12:18:30.167103  / # #

    2023-05-13T12:18:30.267701  export SHELL=3D/bin/sh

    2023-05-13T12:18:30.267898  #

    2023-05-13T12:18:30.368417  / # export SHELL=3D/bin/sh. /lava-10304716/=
environment

    2023-05-13T12:18:30.368622  =


    2023-05-13T12:18:30.469103  / # . /lava-10304716/environment/lava-10304=
716/bin/lava-test-runner /lava-10304716/1

    2023-05-13T12:18:30.469499  =


    2023-05-13T12:18:30.473685  / # /lava-10304716/bin/lava-test-runner /la=
va-10304716/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f80259e13e7f90b2e8625

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g30112e7e73f2f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g30112e7e73f2f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f80259e13e7f90b2e862a
        failing since 46 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-13T12:18:22.619187  + set<8>[   11.375003] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10304755_1.4.2.3.1>

    2023-05-13T12:18:22.619298   +x

    2023-05-13T12:18:22.723592  / # #

    2023-05-13T12:18:22.824185  export SHELL=3D/bin/sh

    2023-05-13T12:18:22.824379  #

    2023-05-13T12:18:22.924843  / # export SHELL=3D/bin/sh. /lava-10304755/=
environment

    2023-05-13T12:18:22.925025  =


    2023-05-13T12:18:23.025497  / # . /lava-10304755/environment/lava-10304=
755/bin/lava-test-runner /lava-10304755/1

    2023-05-13T12:18:23.025850  =


    2023-05-13T12:18:23.030915  / # /lava-10304755/bin/lava-test-runner /la=
va-10304755/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 3          =


  Details:     https://kernelci.org/test/plan/id/645f8123aeb723cd272e86a6

  Results:     60 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g30112e7e73f2f/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk=
3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g30112e7e73f2f/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk=
3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cros-ec-keyb-driver-present: https://kernelci.org/test/=
case/id/645f8123aeb723cd272e86e3
        new failure (last pass: v5.15.111-98-g74a054a6fefd1)

    2023-05-13T12:22:33.110690  /lava-10304794/1/../bin/lava-test-case

    2023-05-13T12:22:33.137576  <8>[   23.153341] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-i2c-tunnel-probed RESULT=3Dblocked>

    2023-05-13T12:22:34.154140  /lava-10304794/1/../bin/lava-test-case
   =


  * baseline.bootrr.cros-ec-i2c-tunnel-driver-present: https://kernelci.org=
/test/case/id/645f8123aeb723cd272e86e4
        new failure (last pass: v5.15.111-98-g74a054a6fefd1)

    2023-05-13T12:22:30.010573  <8>[   20.026645] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-dev-driver-present RESULT=3Dfail>

    2023-05-13T12:22:31.027404  /lava-10304794/1/../bin/lava-test-case

    2023-05-13T12:22:31.052869  <8>[   21.069277] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-dev-probed RESULT=3Dblocked>

    2023-05-13T12:22:32.069048  /lava-10304794/1/../bin/lava-test-case

    2023-05-13T12:22:32.095848  <8>[   22.111461] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-i2c-tunnel-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.cros-ec-dev-driver-present: https://kernelci.org/test/c=
ase/id/645f8123aeb723cd272e86e5
        new failure (last pass: v5.15.111-98-g74a054a6fefd1)

    2023-05-13T12:22:28.962679  <8>[   18.979482] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtpm-chip-is-online RESULT=3Dskip>

    2023-05-13T12:22:29.984479  /lava-10304794/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/645f81796d26378bd92e8621

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g30112e7e73f2f/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64=
-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g30112e7e73f2f/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64=
-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f81796d26378bd92e8647
        failing since 115 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-13T12:23:56.680868  <8>[   16.111011] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3584047_1.5.2.4.1>
    2023-05-13T12:23:56.803126  / # #
    2023-05-13T12:23:56.909132  export SHELL=3D/bin/sh
    2023-05-13T12:23:56.910732  #
    2023-05-13T12:23:57.014252  / # export SHELL=3D/bin/sh. /lava-3584047/e=
nvironment
    2023-05-13T12:23:57.015982  =

    2023-05-13T12:23:57.119993  / # . /lava-3584047/environment/lava-358404=
7/bin/lava-test-runner /lava-3584047/1
    2023-05-13T12:23:57.123830  =

    2023-05-13T12:23:57.126493  / # /lava-3584047/bin/lava-test-runner /lav=
a-3584047/1
    2023-05-13T12:23:57.172994  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/645f82a6d317cac46c2e86b4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g30112e7e73f2f/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-=
h2-plus-orangepi-r1.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-100-g30112e7e73f2f/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-=
h2-plus-orangepi-r1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f82a6d317cac46c2e86b9
        failing since 101 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.90-203-gea2e94bef77e)

    2023-05-13T12:29:18.474309  <8>[    5.806872] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3584142_1.5.2.4.1>
    2023-05-13T12:29:18.593863  / # #
    2023-05-13T12:29:18.699557  export SHELL=3D/bin/sh
    2023-05-13T12:29:18.701127  #
    2023-05-13T12:29:18.804425  / # export SHELL=3D/bin/sh. /lava-3584142/e=
nvironment
    2023-05-13T12:29:18.806002  =

    2023-05-13T12:29:18.909397  / # . /lava-3584142/environment/lava-358414=
2/bin/lava-test-runner /lava-3584142/1
    2023-05-13T12:29:18.912135  =

    2023-05-13T12:29:18.918290  / # /lava-3584142/bin/lava-test-runner /lav=
a-3584142/1
    2023-05-13T12:29:19.024997  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
