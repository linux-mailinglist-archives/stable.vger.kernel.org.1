Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA406F1D36
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 19:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjD1RLb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 13:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjD1RLa (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 13:11:30 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DB61BF8
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 10:11:28 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64115e652eeso14078299b3a.0
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 10:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682701888; x=1685293888;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KigUKl/1UPMBqlzNQmGei5F8HbP1uIzKtxHcwsql/Gw=;
        b=nyVSAjXpFwNFbcw33LEEsLnzaLhtNpSm6hV/GYaDHyUKJ5xR4pzb6TudfrCdpudhpg
         vwntNGQcvGaenC2vvrrXt6pD9UTQ2msg6sd4RTnKufaet94B8DN5CsxaCZAicYqEG/Ml
         G/Gx+YTPb9Vaq3EpaAqFQRD8rdcGDggiVLSjjZdu+jOhklq9ovbPr3mn0F18ZvKvXYXe
         VOLMi6fSxZvK/0U4YSnRfI45aCuOaumciu4DHGMWbpa9VL46XYCYtOC97U4n8Qdm+5Ux
         upMu6i3ItjR+DpNgwExMO6gBn5vVFoN5lkkKEzQB7QxtRcP9Wbo0rDGlp5OIuOxSQQL8
         gCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682701888; x=1685293888;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KigUKl/1UPMBqlzNQmGei5F8HbP1uIzKtxHcwsql/Gw=;
        b=lNPb8Mo3oeIxAiBCKyt4WYGqDs8iYWFDqWSjIHgX0BfZ13PQHvfcNQEU/dVbPyRXcI
         7+ImgBSVNzFAbBABbFrN4NwglUAxHqCuZl5gcyus4PlNj5W3NQ28LRM98g+gXhsNAcih
         +bmfFSZsMjBTrP+iNvumQ/PQHRpS0IWIUZZ1sgXF0xuVwBXgjZ6p4rPB6QZjSRAPZ0Y4
         nA9IyH8eYi+rV2ZZ7gBtfkzzAWVi5FRgJmlZeCbn4HljMBsZLusLudyKUMHS2QQWU3a6
         LBwL+jXMW2QWnYb3kP7gAL6Sd3PHo6s1w4bnnUDTHlOdufksSO0/1nht7PzsLquSruYO
         X9+g==
X-Gm-Message-State: AC+VfDzSO/f85sle+9iJdNY/W4M0bKcFli+8ynPW5EqO/d7GI5zqhl7U
        Z78X1Fm1abFRDCXRULhyngJegZXaLUJGp97/Cwk=
X-Google-Smtp-Source: ACHHUZ7p8vU45wVozEVUHW6xVQfdWNLFLz1yZ4eIvvRThC6wjMxPCfqffZpBHcAg3EFepwYN1ESwOQ==
X-Received: by 2002:a05:6a21:3381:b0:f0:86ce:d02c with SMTP id yy1-20020a056a21338100b000f086ced02cmr12360238pzb.16.1682701887517;
        Fri, 28 Apr 2023 10:11:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 12-20020a63030c000000b004fbd91d9716sm13277474pgd.15.2023.04.28.10.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 10:11:26 -0700 (PDT)
Message-ID: <644bfe3e.630a0220.2b503.ba59@mx.google.com>
Date:   Fri, 28 Apr 2023 10:11:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.4
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.4.238-244-g4155c7163b86
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.4 baseline: 114 runs,
 5 regressions (v5.4.238-244-g4155c7163b86)
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

stable-rc/queue/5.4 baseline: 114 runs, 5 regressions (v5.4.238-244-g4155c7=
163b86)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hifive-unleashed-a00         | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.4/kern=
el/v5.4.238-244-g4155c7163b86/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.4
  Describe: v5.4.238-244-g4155c7163b86
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      4155c7163b86dd1023dd21c72e377e625421b78e =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644bc57b607d0d7e7a2e85ff

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.238-2=
44-g4155c7163b86/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubiet=
ruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.238-2=
44-g4155c7163b86/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubiet=
ruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bc57b607d0d7e7a2e8604
        failing since 87 days (last pass: v5.4.230-81-g2ad0dc06d587, first =
fail: v5.4.230-108-g761a8268d868)

    2023-04-28T13:08:57.285659  <8>[    9.944073] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3540954_1.5.2.4.1>
    2023-04-28T13:08:57.397760  / # #
    2023-04-28T13:08:57.501720  export SHELL=3D/bin/sh
    2023-04-28T13:08:57.503080  #
    2023-04-28T13:08:57.605669  / # export SHELL=3D/bin/sh. /lava-3540954/e=
nvironment
    2023-04-28T13:08:57.607077  =

    2023-04-28T13:08:57.709665  / # . /lava-3540954/environment/lava-354095=
4/bin/lava-test-runner /lava-3540954/1
    2023-04-28T13:08:57.712079  =

    2023-04-28T13:08:57.716607  / # /lava-3540954/bin/lava-test-runner /lav=
a-3540954/1
    2023-04-28T13:08:57.802397  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hifive-unleashed-a00         | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644bc579607d0d7e7a2e85e9

  Results:     3 PASS, 2 FAIL, 2 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.238-2=
44-g4155c7163b86/riscv/defconfig/gcc-10/lab-baylibre/baseline-hifive-unleas=
hed-a00.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.238-2=
44-g4155c7163b86/riscv/defconfig/gcc-10/lab-baylibre/baseline-hifive-unleas=
hed-a00.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/riscv/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/644bc579607d0d7e=
7a2e85f2
        failing since 191 days (last pass: v5.4.219-270-gde284a6cd1e4, firs=
t fail: v5.4.219-266-g5eb28a6c7901)
        3 lines

    2023-04-28T13:08:53.351579  / # =

    2023-04-28T13:08:53.353169  =

    2023-04-28T13:08:55.415911  / # #
    2023-04-28T13:08:55.416614  #
    2023-04-28T13:08:57.429024  / # export SHELL=3D/bin/sh
    2023-04-28T13:08:57.429411  export SHELL=3D/bin/sh
    2023-04-28T13:08:59.444926  / # . /lava-3540972/environment
    2023-04-28T13:08:59.445343  . /lava-3540972/environment
    2023-04-28T13:09:01.460941  / # /lava-3540972/bin/lava-test-runner /lav=
a-3540972/0
    2023-04-28T13:09:01.462817  /lava-3540972/bin/lava-test-runner /lava-35=
40972/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bc7187f26b996212e8613

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.238-2=
44-g4155c7163b86/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.238-2=
44-g4155c7163b86/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bc7187f26b996212e8618
        failing since 30 days (last pass: v5.4.238-29-g39c31e43e3b2b, first=
 fail: v5.4.238-60-gcf51829325af)

    2023-04-28T13:15:57.394535  + set<8>[   10.344925] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10151459_1.4.2.3.1>

    2023-04-28T13:15:57.394622   +x

    2023-04-28T13:15:57.496388  #

    2023-04-28T13:15:57.496687  =


    2023-04-28T13:15:57.597214  / # #export SHELL=3D/bin/sh

    2023-04-28T13:15:57.597398  =


    2023-04-28T13:15:57.697946  / # export SHELL=3D/bin/sh. /lava-10151459/=
environment

    2023-04-28T13:15:57.698153  =


    2023-04-28T13:15:57.798626  / # . /lava-10151459/environment/lava-10151=
459/bin/lava-test-runner /lava-10151459/1

    2023-04-28T13:15:57.798924  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bc7127f26b996212e85fb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.238-2=
44-g4155c7163b86/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.238-2=
44-g4155c7163b86/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bc7127f26b996212e8600
        failing since 30 days (last pass: v5.4.238-29-g39c31e43e3b2b, first=
 fail: v5.4.238-60-gcf51829325af)

    2023-04-28T13:15:49.990526  <8>[   13.051025] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10151452_1.4.2.3.1>

    2023-04-28T13:15:49.993859  + set +x

    2023-04-28T13:15:50.095088  #

    2023-04-28T13:15:50.095316  =


    2023-04-28T13:15:50.195897  / # #export SHELL=3D/bin/sh

    2023-04-28T13:15:50.196084  =


    2023-04-28T13:15:50.296574  / # export SHELL=3D/bin/sh. /lava-10151452/=
environment

    2023-04-28T13:15:50.296741  =


    2023-04-28T13:15:50.397262  / # . /lava-10151452/environment/lava-10151=
452/bin/lava-test-runner /lava-10151452/1

    2023-04-28T13:15:50.397497  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644bc4f7ab2d53aaf32e85f3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.238-2=
44-g4155c7163b86/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-=
h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.4/v5.4.238-2=
44-g4155c7163b86/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-=
h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bc4f7ab2d53aaf32e85f8
        failing since 86 days (last pass: v5.4.230-108-g761a8268d868, first=
 fail: v5.4.230-109-g0a6085bff265)

    2023-04-28T13:06:55.806134  + set +x
    2023-04-28T13:06:55.809402  <8>[    7.740813] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3540942_1.5.2.4.1>
    2023-04-28T13:06:55.914539  / # #
    2023-04-28T13:06:56.016225  export SHELL=3D/bin/sh
    2023-04-28T13:06:56.016595  #
    2023-04-28T13:06:56.117904  / # export SHELL=3D/bin/sh. /lava-3540942/e=
nvironment
    2023-04-28T13:06:56.118263  =

    2023-04-28T13:06:56.219588  / # . /lava-3540942/environment/lava-354094=
2/bin/lava-test-runner /lava-3540942/1
    2023-04-28T13:06:56.220211  =

    2023-04-28T13:06:56.224234  / # /lava-3540942/bin/lava-test-runner /lav=
a-3540942/1 =

    ... (12 line(s) more)  =

 =20
