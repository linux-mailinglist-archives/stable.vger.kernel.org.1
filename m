Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EFE7341C2
	for <lists+stable@lfdr.de>; Sat, 17 Jun 2023 17:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjFQPCz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 17 Jun 2023 11:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjFQPCy (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Jun 2023 11:02:54 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D4910C0
        for <stable@vger.kernel.org>; Sat, 17 Jun 2023 08:02:51 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6664a9f0b10so1254602b3a.0
        for <stable@vger.kernel.org>; Sat, 17 Jun 2023 08:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687014170; x=1689606170;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M643c81iixb7IM5f9vPq4Gb64tGLlLkw4hTs8VtPMj4=;
        b=n3LRN8vuIltojFcUlI/JNBg/V5xEfijZRzyylVDwd9HwK8/+xMylyB5qqimq7oMjEF
         uZG8LEK+bAmfqtT7opFt8JfKFsQoFyXlV+oEpt85JV7KrbS9bl3txBwQECEWX5T+yAp9
         JPXR5hoi8ovsnrJ5LVN6M+gv3TkicgmlQ8N4kE22XeOcosbnmhgFf6EGvfLw4CHBaPNg
         9Y+2Hyc6B7QDvRb8zA9VVT1x0x0Z1nx7ssnTzFwbGDTMBAtFa23CydovdCENHH6dalYr
         SdFzQ2PY44NZpYhZseZnIS8axWuWsG03sJZmiBM4s+wAY2RxZZSns0sSu2EbdrGNG9ZP
         nmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687014170; x=1689606170;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M643c81iixb7IM5f9vPq4Gb64tGLlLkw4hTs8VtPMj4=;
        b=cNktva6ga5KzcPFyaDDZEsUu22mfM2TIRyp4YTTLh9fAYhJ6/rEDjGsIVxS8cI+Bw7
         TMn2iSdiMjcrWBjQ8vQtV9E0xoVh6tuSceZ33cKaF5BbHLpBBHi7S6MJYc3CRqJeoXhs
         +5tzJyLsVbpMdQfYWUE3iAPeXazQZUkkL7Rf/gyAdjpenL1xRhOewuvx2lzPd+8WuKtj
         0DylpBGfSUN547zUNd0lzFmJxAN799DDI5P8XzN8u1AgvoliQbqOGD9zJPgPFK75MQe6
         gmhXkRCaBLfcjET3n9+veJGfX1FmSD8YAQ/pm0RjRBOTn46k2AgC8n9sKtbfqYgMs9jT
         FHsA==
X-Gm-Message-State: AC+VfDxX8vr6adwKSocS8U+umXCIn9j0er8Oeah9aGjfHxLzuoOLe28n
        f1iJuPc1iEFFkrS/IWqigS+9S60cBQQ46UIzgkiGtQ==
X-Google-Smtp-Source: ACHHUZ4WeCpxEHK3EO/xZh8hpN2tL2Qkc4lssvcBJ38UIMDGMGmb8FMZHFiuVs6GgjMEkBEUzlArVQ==
X-Received: by 2002:a05:6a20:3c92:b0:10f:130c:53e4 with SMTP id b18-20020a056a203c9200b0010f130c53e4mr4904852pzj.41.1687014169575;
        Sat, 17 Jun 2023 08:02:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u11-20020a65670b000000b00476d1385265sm1514921pgf.25.2023.06.17.08.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 08:02:48 -0700 (PDT)
Message-ID: <648dcb18.650a0220.437d3.29b6@mx.google.com>
Date:   Sat, 17 Jun 2023 08:02:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.117-53-gc0964c1ac81bd
Subject: stable-rc/linux-5.15.y baseline: 166 runs,
 18 regressions (v5.15.117-53-gc0964c1ac81bd)
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

stable-rc/linux-5.15.y baseline: 166 runs, 18 regressions (v5.15.117-53-gc0=
964c1ac81bd)

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

sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.117-53-gc0964c1ac81bd/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.117-53-gc0964c1ac81bd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      c0964c1ac81bd40cd21bcf071b5b269723488b48 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648d96d8dfb49d772d306146

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-53-gc0964c1ac81bd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-53-gc0964c1ac81bd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648d96d8dfb49d772d30614b
        failing since 80 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-17T11:19:34.155557  + set +x

    2023-06-17T11:19:34.162555  <8>[   10.727367] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10778457_1.4.2.3.1>

    2023-06-17T11:19:34.270104  #

    2023-06-17T11:19:34.271203  =


    2023-06-17T11:19:34.372939  / # #export SHELL=3D/bin/sh

    2023-06-17T11:19:34.373104  =


    2023-06-17T11:19:34.473617  / # export SHELL=3D/bin/sh. /lava-10778457/=
environment

    2023-06-17T11:19:34.473774  =


    2023-06-17T11:19:34.574245  / # . /lava-10778457/environment/lava-10778=
457/bin/lava-test-runner /lava-10778457/1

    2023-06-17T11:19:34.574515  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648d96dfdfb49d772d30616a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-53-gc0964c1ac81bd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-53-gc0964c1ac81bd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648d96dfdfb49d772d30616f
        failing since 80 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-17T11:19:35.566399  + set<8>[   10.821844] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10778461_1.4.2.3.1>

    2023-06-17T11:19:35.566481   +x

    2023-06-17T11:19:35.670694  / # #

    2023-06-17T11:19:35.771370  export SHELL=3D/bin/sh

    2023-06-17T11:19:35.771562  #

    2023-06-17T11:19:35.872051  / # export SHELL=3D/bin/sh. /lava-10778461/=
environment

    2023-06-17T11:19:35.872224  =


    2023-06-17T11:19:35.972700  / # . /lava-10778461/environment/lava-10778=
461/bin/lava-test-runner /lava-10778461/1

    2023-06-17T11:19:35.972966  =


    2023-06-17T11:19:35.977864  / # /lava-10778461/bin/lava-test-runner /la=
va-10778461/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648d96ea7972d7e07d30618c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-53-gc0964c1ac81bd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-53-gc0964c1ac81bd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648d96ea7972d7e07d306191
        failing since 80 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-17T11:19:49.065775  <8>[   11.031730] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10778496_1.4.2.3.1>

    2023-06-17T11:19:49.069144  + set +x

    2023-06-17T11:19:49.174458  #

    2023-06-17T11:19:49.175851  =


    2023-06-17T11:19:49.278299  / # #export SHELL=3D/bin/sh

    2023-06-17T11:19:49.279134  =


    2023-06-17T11:19:49.380768  / # export SHELL=3D/bin/sh. /lava-10778496/=
environment

    2023-06-17T11:19:49.381597  =


    2023-06-17T11:19:49.483268  / # . /lava-10778496/environment/lava-10778=
496/bin/lava-test-runner /lava-10778496/1

    2023-06-17T11:19:49.484868  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/648d9966803a13631b30612f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-53-gc0964c1ac81bd/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-53-gc0964c1ac81bd/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648d9966803a13631b306=
130
        failing since 400 days (last pass: v5.15.37-259-gab77581473a3, firs=
t fail: v5.15.39) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648d974853cb83b0ec3061c4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-53-gc0964c1ac81bd/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-53-gc0964c1ac81bd/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648d974853cb83b0ec3061c9
        failing since 151 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-06-17T11:21:02.164749  <8>[   10.072663] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3671812_1.5.2.4.1>
    2023-06-17T11:21:02.274968  / # #
    2023-06-17T11:21:02.378330  export SHELL=3D/bin/sh
    2023-06-17T11:21:02.379373  #
    2023-06-17T11:21:02.481746  / # export SHELL=3D/bin/sh. /lava-3671812/e=
nvironment
    2023-06-17T11:21:02.482753  =

    2023-06-17T11:21:02.585031  / # . /lava-3671812/environment/lava-367181=
2/bin/lava-test-runner /lava-3671812/1
    2023-06-17T11:21:02.586843  =

    2023-06-17T11:21:02.591516  / # /lava-3671812/bin/lava-test-runner /lav=
a-3671812/1
    2023-06-17T11:21:02.680001  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648d96fcdad5c0d924306149

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-53-gc0964c1ac81bd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-53-gc0964c1ac81bd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648d96fcdad5c0d92430614e
        failing since 80 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-17T11:20:25.514322  + set +x

    2023-06-17T11:20:25.520957  <8>[   10.386673] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10778506_1.4.2.3.1>

    2023-06-17T11:20:25.625611  / # #

    2023-06-17T11:20:25.726242  export SHELL=3D/bin/sh

    2023-06-17T11:20:25.726441  #

    2023-06-17T11:20:25.826940  / # export SHELL=3D/bin/sh. /lava-10778506/=
environment

    2023-06-17T11:20:25.827159  =


    2023-06-17T11:20:25.927657  / # . /lava-10778506/environment/lava-10778=
506/bin/lava-test-runner /lava-10778506/1

    2023-06-17T11:20:25.927948  =


    2023-06-17T11:20:25.932774  / # /lava-10778506/bin/lava-test-runner /la=
va-10778506/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648d96fa54cb5b182b30614b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-53-gc0964c1ac81bd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-53-gc0964c1ac81bd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648d96fa54cb5b182b306150
        failing since 80 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-17T11:20:20.950307  <8>[   10.688714] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10778464_1.4.2.3.1>

    2023-06-17T11:20:20.953617  + set +x

    2023-06-17T11:20:21.055202  #

    2023-06-17T11:20:21.055543  =


    2023-06-17T11:20:21.156174  / # #export SHELL=3D/bin/sh

    2023-06-17T11:20:21.156419  =


    2023-06-17T11:20:21.257004  / # export SHELL=3D/bin/sh. /lava-10778464/=
environment

    2023-06-17T11:20:21.257252  =


    2023-06-17T11:20:21.357828  / # . /lava-10778464/environment/lava-10778=
464/bin/lava-test-runner /lava-10778464/1

    2023-06-17T11:20:21.358126  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648d96e87972d7e07d30615f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-53-gc0964c1ac81bd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-53-gc0964c1ac81bd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648d96e87972d7e07d306164
        failing since 80 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-17T11:19:43.881558  + <8>[   11.255392] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10778493_1.4.2.3.1>

    2023-06-17T11:19:43.881989  set +x

    2023-06-17T11:19:43.988960  / # #

    2023-06-17T11:19:44.091181  export SHELL=3D/bin/sh

    2023-06-17T11:19:44.091834  #

    2023-06-17T11:19:44.193387  / # export SHELL=3D/bin/sh. /lava-10778493/=
environment

    2023-06-17T11:19:44.194106  =


    2023-06-17T11:19:44.295548  / # . /lava-10778493/environment/lava-10778=
493/bin/lava-test-runner /lava-10778493/1

    2023-06-17T11:19:44.296814  =


    2023-06-17T11:19:44.301457  / # /lava-10778493/bin/lava-test-runner /la=
va-10778493/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648d96dedfb49d772d30615f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-53-gc0964c1ac81bd/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline=
-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-53-gc0964c1ac81bd/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline=
-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648d96dedfb49d772d306164
        failing since 137 days (last pass: v5.15.81-122-gc5f8d4a5d3c8, firs=
t fail: v5.15.90-205-g5605d15db022)

    2023-06-17T11:19:49.726491  + set +x
    2023-06-17T11:19:49.726672  [    9.421784] <LAVA_SIGNAL_ENDRUN 0_dmesg =
980188_1.5.2.3.1>
    2023-06-17T11:19:49.833610  / # #
    2023-06-17T11:19:49.935136  export SHELL=3D/bin/sh
    2023-06-17T11:19:49.935641  #
    2023-06-17T11:19:50.036840  / # export SHELL=3D/bin/sh. /lava-980188/en=
vironment
    2023-06-17T11:19:50.037469  =

    2023-06-17T11:19:50.138791  / # . /lava-980188/environment/lava-980188/=
bin/lava-test-runner /lava-980188/1
    2023-06-17T11:19:50.139421  =

    2023-06-17T11:19:50.141749  / # /lava-980188/bin/lava-test-runner /lava=
-980188/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648d96fd54cb5b182b306159

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-53-gc0964c1ac81bd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-53-gc0964c1ac81bd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648d96fd54cb5b182b30615e
        failing since 80 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-17T11:20:04.011763  + set<8>[   17.072585] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10778525_1.4.2.3.1>

    2023-06-17T11:20:04.012067   +x

    2023-06-17T11:20:04.116542  / # #

    2023-06-17T11:20:04.218893  export SHELL=3D/bin/sh

    2023-06-17T11:20:04.219646  #

    2023-06-17T11:20:04.321129  / # export SHELL=3D/bin/sh. /lava-10778525/=
environment

    2023-06-17T11:20:04.321861  =


    2023-06-17T11:20:04.423291  / # . /lava-10778525/environment/lava-10778=
525/bin/lava-test-runner /lava-10778525/1

    2023-06-17T11:20:04.424551  =


    2023-06-17T11:20:04.429217  / # /lava-10778525/bin/lava-test-runner /la=
va-10778525/1
 =

    ... (19 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 4          =


  Details:     https://kernelci.org/test/plan/id/648d9a64804948e421306176

  Results:     153 PASS, 14 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-53-gc0964c1ac81bd/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/=
baseline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-53-gc0964c1ac81bd/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/=
baseline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/648d9a64804948e421306190
        failing since 33 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-17T11:34:50.400263  /lava-10778673/1/../bin/lava-test-case

    2023-06-17T11:34:50.406240  <8>[   61.589895] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/648d9a64804948e421306190
        failing since 33 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-17T11:34:50.400263  /lava-10778673/1/../bin/lava-test-case

    2023-06-17T11:34:50.406240  <8>[   61.589895] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/648d9a64804948e421306192
        failing since 33 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-17T11:34:49.360366  /lava-10778673/1/../bin/lava-test-case

    2023-06-17T11:34:49.367263  <8>[   60.549820] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648d9a64804948e42130621a
        failing since 33 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-17T11:34:35.214122  <8>[   46.400453] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10778673_1.5.2.3.1>

    2023-06-17T11:34:35.217394  + set +x

    2023-06-17T11:34:35.324784  / # #

    2023-06-17T11:34:35.427334  export SHELL=3D/bin/sh

    2023-06-17T11:34:35.428156  #

    2023-06-17T11:34:35.529839  / # export SHELL=3D/bin/sh. /lava-10778673/=
environment

    2023-06-17T11:34:35.530648  =


    2023-06-17T11:34:35.632317  / # . /lava-10778673/environment/lava-10778=
673/bin/lava-test-runner /lava-10778673/1

    2023-06-17T11:34:35.633545  =


    2023-06-17T11:34:35.638710  / # /lava-10778673/bin/lava-test-runner /la=
va-10778673/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3328-rock64                | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648d983c6dd38a9319306156

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-53-gc0964c1ac81bd/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-ro=
ck64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-53-gc0964c1ac81bd/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-ro=
ck64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648d983c6dd38a931930615b
        failing since 9 days (last pass: v5.15.72-38-gebe70cd7f5413, first =
fail: v5.15.114-196-g00621f2608ac)

    2023-06-17T11:25:26.644413  [   16.054882] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3671871_1.5.2.4.1>
    2023-06-17T11:25:26.748234  =

    2023-06-17T11:25:26.849515  / # #[   16.159438] rockchip-drm display-su=
bsystem: [drm] Cannot findexport SHELL=3D/bin/sh
    2023-06-17T11:25:26.849838   any crtc or sizes
    2023-06-17T11:25:26.849975  =

    2023-06-17T11:25:26.951027  / # export SHELL=3D/bin/sh. /lava-3671871/e=
nvironment
    2023-06-17T11:25:26.951360  =

    2023-06-17T11:25:27.052494  / # . /lava-3671871/environment/lava-367187=
1/bin/lava-test-runner /lava-3671871/1
    2023-06-17T11:25:27.052973  =

    2023-06-17T11:25:27.056482  / # /lava-3671871/bin/lava-test-runner /lav=
a-3671871/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648d9b254995ccbe4330627d

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-53-gc0964c1ac81bd/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a6=
4-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-53-gc0964c1ac81bd/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a6=
4-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648d9b254995ccbe433062aa
        failing since 151 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-06-17T11:37:43.337443  + set +x
    2023-06-17T11:37:43.341531  <8>[   16.007860] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3671859_1.5.2.4.1>
    2023-06-17T11:37:43.461655  / # #
    2023-06-17T11:37:43.567249  export SHELL=3D/bin/sh
    2023-06-17T11:37:43.568813  #
    2023-06-17T11:37:43.672378  / # export SHELL=3D/bin/sh. /lava-3671859/e=
nvironment
    2023-06-17T11:37:43.675558  =

    2023-06-17T11:37:43.782022  / # . /lava-3671859/environment/lava-367185=
9/bin/lava-test-runner /lava-3671859/1
    2023-06-17T11:37:43.787417  =

    2023-06-17T11:37:43.789987  / # /lava-3671859/bin/lava-test-runner /lav=
a-3671859/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648d98bdb835f5a5f43061c6

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-53-gc0964c1ac81bd/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64=
-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-53-gc0964c1ac81bd/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64=
-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648d98beb835f5a5f43061ed
        failing since 151 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-06-17T11:27:27.440807  + set +x
    2023-06-17T11:27:27.444808  <8>[   16.052370] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 625211_1.5.2.4.1>
    2023-06-17T11:27:27.555414  / # #
    2023-06-17T11:27:27.658200  export SHELL=3D/bin/sh
    2023-06-17T11:27:27.658795  #
    2023-06-17T11:27:27.760638  / # export SHELL=3D/bin/sh. /lava-625211/en=
vironment
    2023-06-17T11:27:27.761326  =

    2023-06-17T11:27:27.863059  / # . /lava-625211/environment/lava-625211/=
bin/lava-test-runner /lava-625211/1
    2023-06-17T11:27:27.864228  =

    2023-06-17T11:27:27.868179  / # /lava-625211/bin/lava-test-runner /lava=
-625211/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/648d9bafad05097f7b30617f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-53-gc0964c1ac81bd/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i=
-h2-plus-orangepi-r1.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-53-gc0964c1ac81bd/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i=
-h2-plus-orangepi-r1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648d9bafad05097f7b306184
        failing since 65 days (last pass: v5.15.82-124-g2b8b2c150867, first=
 fail: v5.15.105-194-g415a9d81c640)

    2023-06-17T11:40:06.888882  / # #
    2023-06-17T11:40:06.994456  export SHELL=3D/bin/sh
    2023-06-17T11:40:06.996235  #
    2023-06-17T11:40:07.099866  / # export SHELL=3D/bin/sh. /lava-3671769/e=
nvironment
    2023-06-17T11:40:07.101384  =

    2023-06-17T11:40:07.204812  / # . /lava-3671769/environment/lava-367176=
9/bin/lava-test-runner /lava-3671769/1
    2023-06-17T11:40:07.207450  =

    2023-06-17T11:40:07.213242  / # /lava-3671769/bin/lava-test-runner /lav=
a-3671769/1
    2023-06-17T11:40:07.378769  + export 'TESTRUN_ID=3D1_bootrr'
    2023-06-17T11:40:07.379906  + cd /lava-3671769/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
