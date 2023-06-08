Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC597273FC
	for <lists+stable@lfdr.de>; Thu,  8 Jun 2023 03:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjFHBLY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 21:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjFHBLX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 21:11:23 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177BB269F
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 18:11:22 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-53f04fdd77dso3184814a12.3
        for <stable@vger.kernel.org>; Wed, 07 Jun 2023 18:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686186681; x=1688778681;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XHdQTVmnIjRuZlPxe4NZvRPnTfYBfitMjkLU/E/P6UI=;
        b=oMsRVpHXIvHQWS1PSw+PMQfoM0C90BjwpQNA3XfwbPdnxx/JBqB5AWKGK24k80rns+
         NyZL2J9GgLZLVoJ/ODZQ9H1yScpz/HP+Z5jSw556or6M4Q7TSsngnSo9Xa42NNWyc7hW
         0p+D6yVSpd0yBRO7xeI7LgvzbHi/gxOWuvTbzEMezTrVCYXm5YMcGfSFa5+FUeNxB1c9
         bSRqPlcARPNQ+tOFdV07C/V47EunP6Dq4cTLWHg15OYaIpwvB8cEUdGLBTWcGY0m0jsR
         SowjVqY7lcW2I9THbEtFQtMGyd81BB5j9hQJ32X2a8iSo7tijnAXaiQaGJ61fPZf7DKR
         9M5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686186681; x=1688778681;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XHdQTVmnIjRuZlPxe4NZvRPnTfYBfitMjkLU/E/P6UI=;
        b=Ulwq3lECQ/en/zr5iZpbSYCrNH4MwS52TuT93QfBMtbv78uIlsbmzanlmkv6HXtoPZ
         HbserO4tjWfTkcMGmxQ4N7Py5Ma5ZGYdwKXfhT+Z6y2iwyHSdFB1UnDTAh9Pw5CW04Cq
         SHdE1d26dmTtHUKUlfyVwJ3Ay1AUfsSqr/3hMlkekgdFl39AUssCfMXlWcdIYor5gT1q
         uFvhEzzEJoclR7BHABGVLLeZIEDmhdeYAOTVux/tFWnTf+/RmjcSoY1Ly/Qn+rchR+S+
         N7IfruI4/7+994l/YTjP8Vkr29QFk2PjpKCqULOrfXYB2iaGQENxUM30SNjCwKdBINzf
         cTGg==
X-Gm-Message-State: AC+VfDzQtkf0jp/hzTWj88hN6sUJFuvzpXpK6xVqz6EzntmI1K19ZJk6
        YGWV2L6xGW+RKowQgPhtr1Kfb7upojgcVMuHW7Wgpw==
X-Google-Smtp-Source: ACHHUZ7+8SHGxoLUcpC9tli0dxQZvUy2NlZMSREJM29wHVMH2V/lUcasbtIjP8cDxhoTQ/yY4jBbWQ==
X-Received: by 2002:a05:6a20:4416:b0:e9:5b0a:deff with SMTP id ce22-20020a056a20441600b000e95b0adeffmr3195414pzb.22.1686186681046;
        Wed, 07 Jun 2023 18:11:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a18-20020a62bd12000000b0064ff855751fsm267pff.4.2023.06.07.18.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 18:11:20 -0700 (PDT)
Message-ID: <64812ab8.620a0220.b499d.0008@mx.google.com>
Date:   Wed, 07 Jun 2023 18:11:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.181-144-gea69b726b972
Subject: stable-rc/linux-5.10.y baseline: 179 runs,
 5 regressions (v5.10.181-144-gea69b726b972)
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

stable-rc/linux-5.10.y baseline: 179 runs, 5 regressions (v5.10.181-144-gea=
69b726b972)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =

stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.181-144-gea69b726b972/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.181-144-gea69b726b972
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      ea69b726b972cb7a7fa65a50b185152ecc870dde =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6480f581be5f5174ed306138

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
81-144-gea69b726b972/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
81-144-gea69b726b972/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6480f581be5f5174ed30613d
        failing since 140 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-06-07T21:23:52.643586  <8>[   11.061185] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3646448_1.5.2.4.1>
    2023-06-07T21:23:52.749596  / # #
    2023-06-07T21:23:52.850987  export SHELL=3D/bin/sh
    2023-06-07T21:23:52.851390  #
    2023-06-07T21:23:52.952543  / # export SHELL=3D/bin/sh. /lava-3646448/e=
nvironment
    2023-06-07T21:23:52.952910  =

    2023-06-07T21:23:53.054114  / # . /lava-3646448/environment/lava-364644=
8/bin/lava-test-runner /lava-3646448/1
    2023-06-07T21:23:53.054695  =

    2023-06-07T21:23:53.059640  / # /lava-3646448/bin/lava-test-runner /lav=
a-3646448/1
    2023-06-07T21:23:53.144870  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6480f200d212881ede306150

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
81-144-gea69b726b972/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
81-144-gea69b726b972/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6480f200d212881ede306155
        failing since 71 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-06-07T21:09:05.957653  + set +x

    2023-06-07T21:09:05.964130  <8>[   14.233692] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10630561_1.4.2.3.1>

    2023-06-07T21:09:06.068442  / # #

    2023-06-07T21:09:06.169106  export SHELL=3D/bin/sh

    2023-06-07T21:09:06.169401  #

    2023-06-07T21:09:06.270010  / # export SHELL=3D/bin/sh. /lava-10630561/=
environment

    2023-06-07T21:09:06.270210  =


    2023-06-07T21:09:06.370733  / # . /lava-10630561/environment/lava-10630=
561/bin/lava-test-runner /lava-10630561/1

    2023-06-07T21:09:06.371107  =


    2023-06-07T21:09:06.375460  / # /lava-10630561/bin/lava-test-runner /la=
va-10630561/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6480f1da64bdcc0c6b306152

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
81-144-gea69b726b972/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
81-144-gea69b726b972/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6480f1da64bdcc0c6b306157
        failing since 71 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-06-07T21:08:27.967839  <8>[   14.982232] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10630573_1.4.2.3.1>

    2023-06-07T21:08:27.970913  + set +x

    2023-06-07T21:08:28.072757  =


    2023-06-07T21:08:28.173389  / # #export SHELL=3D/bin/sh

    2023-06-07T21:08:28.173644  =


    2023-06-07T21:08:28.274237  / # export SHELL=3D/bin/sh. /lava-10630573/=
environment

    2023-06-07T21:08:28.274506  =


    2023-06-07T21:08:28.375076  / # . /lava-10630573/environment/lava-10630=
573/bin/lava-test-runner /lava-10630573/1

    2023-06-07T21:08:28.375491  =


    2023-06-07T21:08:28.380426  / # /lava-10630573/bin/lava-test-runner /la=
va-10630573/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6480f1a8fd44da93a0306147

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
81-144-gea69b726b972/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743=
-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
81-144-gea69b726b972/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743=
-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6480f1a8fd44da93a0306=
148
        failing since 10 days (last pass: v5.10.180-154-gfd59dd82642d, firs=
t fail: v5.10.180-212-g5bb979836617c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6480f50f8f06ef75b330612e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
81-144-gea69b726b972/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-st=
m32mp157c-dk2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
81-144-gea69b726b972/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-st=
m32mp157c-dk2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6480f50f8f06ef75b3306133
        failing since 124 days (last pass: v5.10.147, first fail: v5.10.166=
-10-g6278b8c9832e)

    2023-06-07T21:22:06.526322  <8>[  226.551938] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3646447_1.5.2.4.1>
    2023-06-07T21:22:06.631025  / # #
    2023-06-07T21:22:06.732743  export SHELL=3D/bin/sh
    2023-06-07T21:22:06.733082  #
    2023-06-07T21:22:06.834195  / # export SHELL=3D/bin/sh. /lava-3646447/e=
nvironment
    2023-06-07T21:22:06.834561  =

    2023-06-07T21:22:06.935676  / # . /lava-3646447/environment/lava-364644=
7/bin/lava-test-runner /lava-3646447/1
    2023-06-07T21:22:06.936124  =

    2023-06-07T21:22:06.940246  / # /lava-3646447/bin/lava-test-runner /lav=
a-3646447/1
    2023-06-07T21:22:07.007216  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
