Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C276F1DE0
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 20:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344368AbjD1SQW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 14:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjD1SQV (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 14:16:21 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD2B19B2
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 11:16:20 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1a677dffb37so2232215ad.2
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 11:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682705779; x=1685297779;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KY8/L186CZ09p1eEqtqKYIPNrmFNHLwq9vqIndxV0eA=;
        b=mmW7SV0ssgRfUXh8xl+ntshMqDSs56vf2Iv8pYhMw7+PjOe4cFwqM944W7n8rFeN5J
         0QnDtYCQDxCrXKu2PreD0mNhXOnATvSHYO3jiC9rgnh7uCiMINFj+u7+/xaXS1WGeiTb
         iYeEHLr2qcJWONPAgfWdCAbaKYAmibdGFZWWhxgBn8nEUJW+IPtBjdoQXfDid0znoECx
         mNDoYI5KAQARMefsqzsruNmwPwdMUiIxNTmyXKv8VzRhQDe414c4V4nEQsbPB0PrRVUz
         BULlaGvj8dqKTzbCT8l71Pz0+rDr2gkbP5ZOs/G4/RWTSSCzL0FMnMDrt1bg6Ci0P9Si
         b4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682705779; x=1685297779;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KY8/L186CZ09p1eEqtqKYIPNrmFNHLwq9vqIndxV0eA=;
        b=eVfICHkdsGCkx+cMo64fQopMJfBwHhFXt9eExXL+m3+fhXo70/Ed+twiiBm6hrsvB+
         /RlSE2z0IikSXlvGulgXJp9XI9RpLDIAj/yc1b1Uy9B9LN6gj27vz+ifgqyyfzBBynJq
         UvBxXlehQJapSc44DOWUaciySCIUvAAa0ttCeyJD1FDBN2gPY7CUawUpEWdSD5DOo+zN
         kVTNG+t56xFkC/usOAijLbrMEW/UlM5oJwTo7XxoHlf31DDtnt1Amy5y5evhkiFtpYG/
         gd0B+ldvdJPb0Wf1ktmX6qWRD6XKg7Em9B57eQGdGzs4D8ZQPtLMEpeSMyOvkGPioz3H
         YCQg==
X-Gm-Message-State: AC+VfDyOGRiPQKm8INerfBQYfdtNu/mhNplJMhxH2JeqsK/gJeXFxzWM
        5TFUJx5rd69EIMft10JbCZTwKZkUYcrpRk0INJk=
X-Google-Smtp-Source: ACHHUZ7A0+31wG/Dlv9y9EX8RXxbANhaWzcDRgq/dAyaduue2cTuJhpmyOYqZ22f1CDIhBYP8o7hRQ==
X-Received: by 2002:a17:902:e5cf:b0:1a8:11d3:6b93 with SMTP id u15-20020a170902e5cf00b001a811d36b93mr6612485plf.66.1682705778762;
        Fri, 28 Apr 2023 11:16:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d6-20020a170902b70600b001a934af187esm13341330pls.153.2023.04.28.11.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 11:16:18 -0700 (PDT)
Message-ID: <644c0d72.170a0220.e2716.c5e2@mx.google.com>
Date:   Fri, 28 Apr 2023 11:16:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.4.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.4.238-245-g41e24252f52b
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.4.y baseline: 114 runs,
 8 regressions (v5.4.238-245-g41e24252f52b)
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

stable-rc/linux-5.4.y baseline: 114 runs, 8 regressions (v5.4.238-245-g41e2=
4252f52b)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

da850-lcdk                   | arm    | lab-baylibre  | gcc-10   | multi_v5=
_defconfig           | 1          =

hifive-unleashed-a00         | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.4.y/kern=
el/v5.4.238-245-g41e24252f52b/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.4.y
  Describe: v5.4.238-245-g41e24252f52b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      41e24252f52b4eddf6f8bab6e9c1e56cad3071ed =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644bd0e35f59a2acfc2e8615

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g41e24252f52b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g41e24252f52b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bd0e35f59a2acfc2e861a
        failing since 101 days (last pass: v5.4.226, first fail: v5.4.228-6=
59-gb3b34c474ec7)

    2023-04-28T13:57:41.894965  <8>[   23.658142] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3541142_1.5.2.4.1>
    2023-04-28T13:57:42.003234  / # #
    2023-04-28T13:57:42.105064  export SHELL=3D/bin/sh
    2023-04-28T13:57:42.105570  #
    2023-04-28T13:57:42.206901  / # export SHELL=3D/bin/sh. /lava-3541142/e=
nvironment
    2023-04-28T13:57:42.207456  =

    2023-04-28T13:57:42.308833  / # . /lava-3541142/environment/lava-354114=
2/bin/lava-test-runner /lava-3541142/1
    2023-04-28T13:57:42.309655  =

    2023-04-28T13:57:42.314679  / # /lava-3541142/bin/lava-test-runner /lav=
a-3541142/1
    2023-04-28T13:57:42.399904  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644bd15cbc424be84f2e8617

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g41e24252f52b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g41e24252f52b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bd15cbc424be84f2e861c
        failing since 101 days (last pass: v5.4.226-68-g8c05f5e0777d, first=
 fail: v5.4.228-659-gb3b34c474ec7)

    2023-04-28T13:59:32.831631  + set +x<8>[    9.903959] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3541146_1.5.2.4.1>
    2023-04-28T13:59:32.832477  =

    2023-04-28T13:59:32.942427  / # #
    2023-04-28T13:59:33.046461  export SHELL=3D/bin/sh
    2023-04-28T13:59:33.047539  #
    2023-04-28T13:59:33.149969  / # export SHELL=3D/bin/sh. /lava-3541146/e=
nvironment
    2023-04-28T13:59:33.151277  =

    2023-04-28T13:59:33.253775  / # . /lava-3541146/environment/lava-354114=
6/bin/lava-test-runner /lava-3541146/1
    2023-04-28T13:59:33.255806  =

    2023-04-28T13:59:33.256349  / # /lava-3541146/bin/lava-test-runner /lav=
a-3541146/1<3>[   10.320628] Bluetooth: hci0: command 0xfc18 tx timeout =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
da850-lcdk                   | arm    | lab-baylibre  | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644bd403ee9344f7622e8605

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g41e24252f52b/arm/multi_v5_defconfig/gcc-10/lab-baylibre/baseline-da85=
0-lcdk.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g41e24252f52b/arm/multi_v5_defconfig/gcc-10/lab-baylibre/baseline-da85=
0-lcdk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bd403ee9344f7622e860a
        failing since 101 days (last pass: v5.4.227, first fail: v5.4.228-6=
59-gb3b34c474ec7)

    2023-04-28T14:10:51.864243  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 3541168_1.5.=
2.4.1>
    2023-04-28T14:10:51.972994  / # #
    2023-04-28T14:10:52.076635  export SHELL=3D/bin/sh
    2023-04-28T14:10:52.077763  #
    2023-04-28T14:10:52.180058  / # export SHELL=3D/bin/sh. /lava-3541168/e=
nvironment
    2023-04-28T14:10:52.181085  =

    2023-04-28T14:10:52.283388  / # . /lava-3541168/environment/lava-354116=
8/bin/lava-test-runner /lava-3541168/1
    2023-04-28T14:10:52.284981  =

    2023-04-28T14:10:52.294502  / # /lava-3541168/bin/lava-test-runner /lav=
a-3541168/1
    2023-04-28T14:10:52.543160  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hifive-unleashed-a00         | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644bd8dc942e6d380d2e8603

  Results:     3 PASS, 2 FAIL, 2 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g41e24252f52b/riscv/defconfig/gcc-10/lab-baylibre/baseline-hifive-unle=
ashed-a00.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g41e24252f52b/riscv/defconfig/gcc-10/lab-baylibre/baseline-hifive-unle=
ashed-a00.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/riscv/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/644bd8dc942e6d38=
0d2e860c
        failing since 191 days (last pass: v5.4.219, first fail: v5.4.219-2=
67-g4a976f825745)
        3 lines

    2023-04-28T14:31:34.927199  / # =

    2023-04-28T14:31:34.928776  =

    2023-04-28T14:31:36.991333  / # #
    2023-04-28T14:31:36.991956  #
    2023-04-28T14:31:39.006456  / # export SHELL=3D/bin/sh
    2023-04-28T14:31:39.006829  export SHELL=3D/bin/sh
    2023-04-28T14:31:41.022109  / # . /lava-3541215/environment
    2023-04-28T14:31:41.022997  . /lava-3541215/environment
    2023-04-28T14:31:43.038584  / # /lava-3541215/bin/lava-test-runner /lav=
a-3541215/0
    2023-04-28T14:31:43.041056  /lava-3541215/bin/lava-test-runner /lava-35=
41215/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bdade5bcebd2d7f2e863a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g41e24252f52b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g41e24252f52b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bdade5bcebd2d7f2e863f
        failing since 29 days (last pass: v5.4.238, first fail: v5.4.238)

    2023-04-28T14:40:13.318862  + set +x<8>[   10.269937] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10152136_1.4.2.3.1>

    2023-04-28T14:40:13.318965  =


    2023-04-28T14:40:13.420755  #

    2023-04-28T14:40:13.421054  =


    2023-04-28T14:40:13.521662  / # #export SHELL=3D/bin/sh

    2023-04-28T14:40:13.521874  =


    2023-04-28T14:40:13.622442  / # export SHELL=3D/bin/sh. /lava-10152136/=
environment

    2023-04-28T14:40:13.622663  =


    2023-04-28T14:40:13.723210  / # . /lava-10152136/environment/lava-10152=
136/bin/lava-test-runner /lava-10152136/1

    2023-04-28T14:40:13.723512  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bdad050384294682e85f6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g41e24252f52b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g41e24252f52b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bdad050384294682e85fb
        failing since 29 days (last pass: v5.4.238, first fail: v5.4.238)

    2023-04-28T14:39:57.574927  <8>[   12.548481] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10152190_1.4.2.3.1>

    2023-04-28T14:39:57.577991  + set +x

    2023-04-28T14:39:57.682622  / # #

    2023-04-28T14:39:57.783406  export SHELL=3D/bin/sh

    2023-04-28T14:39:57.783642  #

    2023-04-28T14:39:57.884220  / # export SHELL=3D/bin/sh. /lava-10152190/=
environment

    2023-04-28T14:39:57.884468  =


    2023-04-28T14:39:57.985012  / # . /lava-10152190/environment/lava-10152=
190/bin/lava-test-runner /lava-10152190/1

    2023-04-28T14:39:57.985429  =


    2023-04-28T14:39:57.990761  / # /lava-10152190/bin/lava-test-runner /la=
va-10152190/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644bd037748f07067f2e8619

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g41e24252f52b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g41e24252f52b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bd037748f07067f2e861e
        failing since 101 days (last pass: v5.4.227, first fail: v5.4.228-6=
59-gb3b34c474ec7)

    2023-04-28T13:54:51.876595  / # #
    2023-04-28T13:54:51.978346  export SHELL=3D/bin/sh
    2023-04-28T13:54:51.978704  #
    2023-04-28T13:54:52.080027  / # export SHELL=3D/bin/sh. /lava-3541135/e=
nvironment
    2023-04-28T13:54:52.080380  =

    2023-04-28T13:54:52.181729  / # . /lava-3541135/environment/lava-354113=
5/bin/lava-test-runner /lava-3541135/1
    2023-04-28T13:54:52.182382  =

    2023-04-28T13:54:52.187811  / # /lava-3541135/bin/lava-test-runner /lav=
a-3541135/1
    2023-04-28T13:54:52.284797  + export 'TESTRUN_ID=3D1_bootrr'
    2023-04-28T13:54:52.285424  + cd /lava-3541135/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/644bd0b0c071c8470b2e860d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g41e24252f52b/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h=
3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.238=
-245-g41e24252f52b/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h=
3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bd0b0c071c8470b2e8612
        failing since 101 days (last pass: v5.4.227, first fail: v5.4.228-6=
59-gb3b34c474ec7)

    2023-04-28T13:56:39.097537  / # #
    2023-04-28T13:56:39.199588  export SHELL=3D/bin/sh
    2023-04-28T13:56:39.200014  #
    2023-04-28T13:56:39.301487  / # export SHELL=3D/bin/sh. /lava-3541152/e=
nvironment
    2023-04-28T13:56:39.302047  =

    2023-04-28T13:56:39.403481  / # . /lava-3541152/environment/lava-354115=
2/bin/lava-test-runner /lava-3541152/1
    2023-04-28T13:56:39.404113  =

    2023-04-28T13:56:39.423795  / # /lava-3541152/bin/lava-test-runner /lav=
a-3541152/1
    2023-04-28T13:56:39.489770  + export 'TESTRUN_ID=3D1_bootrr'
    2023-04-28T13:56:39.490301  + cd /lava-3541152/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
