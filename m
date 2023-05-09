Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD366FBE30
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 06:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjEIE2p (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 00:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjEIE2o (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 00:28:44 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5094EC7
        for <stable@vger.kernel.org>; Mon,  8 May 2023 21:28:43 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1aafa03f541so52930365ad.0
        for <stable@vger.kernel.org>; Mon, 08 May 2023 21:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683606522; x=1686198522;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TG5MlNDSOhUyKaD/kctPoxsfihMrbrslLPREL7J8MZk=;
        b=rZg7+tHEkOTFuMzCfUQyWOz5xw//pkJsmjM/KeWdmEHfDJ+fx9b12ojDxtcrHEKWNM
         YZk8ffTawoIAAQaxNlcLRTOV9k+HeUwgRaeD9BrgXYwlLuvV7ntUpuJx/NPMiRb5icOd
         tciD8hGhp4NWtO1qG+hbhNYzGFnnoeQ48ujSqPFl8m8HBpuWGY4v1NZF4JJHDwer0+Xm
         H7Jz+u2i68JvZOY0OPeUFDwDUZEjWjNyY3EEJVbx+65k9ZtP/GhaN5KcpVbA9d7gkTH5
         J/MKVoCJ9M4AUE81RQkTnOAit0q2xunxXUFq6hI6rTFwWqlhtU6z8FpRUH9iWzKptcHk
         aeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683606522; x=1686198522;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TG5MlNDSOhUyKaD/kctPoxsfihMrbrslLPREL7J8MZk=;
        b=ZUMJlFiX/UtE7fMyU5XIlFBVLQtRKcxJntI12mLKT+uRBGxWd1lkoQNDqxtJlZKTL/
         6FRH60twOeMGlu6en6pLmkjqpAwzZAld/PJoJwAnWHmkXSeia33T1bdLlAiGJOvNbyq6
         JrxubT6SxqkyMHWU4xcJarA6OJS7VU7hikVUT4LxNqHT+jNc9WgCbc9FDdSIVu6SsmOE
         dn+9eznsggs61BNeIjW38ApUdHDjbfx3tGy10Y/Af087RAM69RtUQT9oQecKy9aPH71Z
         GsbildX8V9zhIaBm0yzj5AVepCVI2yozIgBjw8oPmJp6Z5DKoMXprvSs5H4sAXmSx2GY
         m6XQ==
X-Gm-Message-State: AC+VfDyCAE7qKzhuIToGRACWXe7RZ5ilsDTs5pCVfrPMXMNSbt5Z4b8F
        pmbqREzOUr5qBoN+2a/4Rzmgwa+Fxh59KhDtjYpLEQ==
X-Google-Smtp-Source: ACHHUZ4yKuBQ4DUgHgpFeyTcWpv/eDrb1SqWcY1kh3L7uaRewUZJTZQjpoTODyBTlFOBMb+3DfbEcQ==
X-Received: by 2002:a17:902:d4c1:b0:1a5:167f:620f with SMTP id o1-20020a170902d4c100b001a5167f620fmr16091380plg.15.1683606521965;
        Mon, 08 May 2023 21:28:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id bc3-20020a170902930300b001aaf92130b2sm352996plb.115.2023.05.08.21.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 21:28:41 -0700 (PDT)
Message-ID: <6459cbf9.170a0220.96091.0eaa@mx.google.com>
Date:   Mon, 08 May 2023 21:28:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.176-658-g69add2d190f2
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 159 runs,
 7 regressions (v5.10.176-658-g69add2d190f2)
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

stable-rc/queue/5.10 baseline: 159 runs, 7 regressions (v5.10.176-658-g69ad=
d2d190f2)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2711-rpi-4-b              | arm64  | lab-linaro-lkft | gcc-10   | defcon=
fig                    | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.176-658-g69add2d190f2/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.176-658-g69add2d190f2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      69add2d190f20ca138f2b41b9e93b49f104297ee =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2711-rpi-4-b              | arm64  | lab-linaro-lkft | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6459b6d6912db65e822e863d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-658-g69add2d190f2/arm64/defconfig/gcc-10/lab-linaro-lkft/baseline-bcm2711-=
rpi-4-b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-658-g69add2d190f2/arm64/defconfig/gcc-10/lab-linaro-lkft/baseline-bcm2711-=
rpi-4-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6459b6d6912db65e822e8=
63e
        new failure (last pass: v5.10.176-642-gf5012685b6367) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6459970d3b9341db412e85ff

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-658-g69add2d190f2/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-658-g69add2d190f2/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459970d3b9341db412e8633
        failing since 84 days (last pass: v5.10.167-127-g921934d621e4, firs=
t fail: v5.10.167-139-gf9519a5a1701)

    2023-05-09T00:42:35.170755  <8>[   19.346669] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 430347_1.5.2.4.1>
    2023-05-09T00:42:35.282037  / # #
    2023-05-09T00:42:35.385095  export SHELL=3D/bin/sh
    2023-05-09T00:42:35.385975  #
    2023-05-09T00:42:35.488070  / # export SHELL=3D/bin/sh. /lava-430347/en=
vironment
    2023-05-09T00:42:35.488979  =

    2023-05-09T00:42:35.590981  / # . /lava-430347/environment/lava-430347/=
bin/lava-test-runner /lava-430347/1
    2023-05-09T00:42:35.592467  =

    2023-05-09T00:42:35.596972  / # /lava-430347/bin/lava-test-runner /lava=
-430347/1
    2023-05-09T00:42:35.703331  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645997256e9eb7b2242e8626

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-658-g69add2d190f2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-658-g69add2d190f2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645997256e9eb7b2242e862b
        failing since 39 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-09T00:43:10.982210  + set +x

    2023-05-09T00:43:10.988501  <8>[   15.367437] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10245600_1.4.2.3.1>

    2023-05-09T00:43:11.093257  / # #

    2023-05-09T00:43:11.193820  export SHELL=3D/bin/sh

    2023-05-09T00:43:11.194004  #

    2023-05-09T00:43:11.294536  / # export SHELL=3D/bin/sh. /lava-10245600/=
environment

    2023-05-09T00:43:11.294722  =


    2023-05-09T00:43:11.395200  / # . /lava-10245600/environment/lava-10245=
600/bin/lava-test-runner /lava-10245600/1

    2023-05-09T00:43:11.395491  =


    2023-05-09T00:43:11.399986  / # /lava-10245600/bin/lava-test-runner /la=
va-10245600/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459971d195d16b2cf2e85e9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-658-g69add2d190f2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-658-g69add2d190f2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459971d195d16b2cf2e85ee
        failing since 39 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-09T00:42:53.000078  + set<8>[   12.831948] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10245602_1.4.2.3.1>

    2023-05-09T00:42:53.000165   +x

    2023-05-09T00:42:53.101737  /#

    2023-05-09T00:42:53.202506   # #export SHELL=3D/bin/sh

    2023-05-09T00:42:53.202690  =


    2023-05-09T00:42:53.303205  / # export SHELL=3D/bin/sh. /lava-10245602/=
environment

    2023-05-09T00:42:53.303367  =


    2023-05-09T00:42:53.403995  / # . /lava-10245602/environment/lava-10245=
602/bin/lava-test-runner /lava-10245602/1

    2023-05-09T00:42:53.404236  =


    2023-05-09T00:42:53.409327  / # /lava-10245602/bin/lava-test-runner /la=
va-10245602/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64599ac0a4de6240e62e85fc

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-658-g69add2d190f2/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-658-g69add2d190f2/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64599ac0a4de6240e62e8602
        failing since 55 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-09T00:58:20.493688  /lava-10246017/1/../bin/lava-test-case

    2023-05-09T00:58:20.505968  <8>[   35.332096] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64599ac0a4de6240e62e8603
        failing since 55 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-09T00:58:19.457850  /lava-10246017/1/../bin/lava-test-case

    2023-05-09T00:58:19.467739  <8>[   34.295181] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645996d8bd2ef2a2b32e85e8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-658-g69add2d190f2/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-658-g69add2d190f2/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645996d8bd2ef2a2b32e85ed
        failing since 96 days (last pass: v5.10.165-139-gefb57ce0f880, firs=
t fail: v5.10.165-149-ge30e8271d674)

    2023-05-09T00:41:38.482037  <8>[    8.522709] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3564964_1.5.2.4.1>
    2023-05-09T00:41:38.587359  / # #
    2023-05-09T00:41:38.689309  export SHELL=3D/bin/sh
    2023-05-09T00:41:38.689845  #
    2023-05-09T00:41:38.791193  / # export SHELL=3D/bin/sh. /lava-3564964/e=
nvironment
    2023-05-09T00:41:38.791692  =

    2023-05-09T00:41:38.893096  / # . /lava-3564964/environment/lava-356496=
4/bin/lava-test-runner /lava-3564964/1
    2023-05-09T00:41:38.893871  =

    2023-05-09T00:41:38.898490  / # /lava-3564964/bin/lava-test-runner /lav=
a-3564964/1
    2023-05-09T00:41:39.002898  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
