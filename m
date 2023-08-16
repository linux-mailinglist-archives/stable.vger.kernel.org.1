Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FABB77ECFD
	for <lists+stable@lfdr.de>; Thu, 17 Aug 2023 00:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346875AbjHPWRt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 16 Aug 2023 18:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346981AbjHPWRp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 16 Aug 2023 18:17:45 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E412F10FF
        for <stable@vger.kernel.org>; Wed, 16 Aug 2023 15:17:22 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bc73a2b0easo47749335ad.0
        for <stable@vger.kernel.org>; Wed, 16 Aug 2023 15:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692224242; x=1692829042;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6UTbn4xpNMapZLUA3ScvMIvn9YowYIXXbdog+JM0gnY=;
        b=1dnNVUGicqlAiIaNDzcXEyW3enBVWN9s+9diUQP5/pNwOf+oLZVNxjOO86FTi08zaH
         OK54Eyv2AD3QPLA2mIKR09b+Ui4mHqB06Gmf/N61L6bEGvgLg9EANztLvVcnvzafkZvR
         mcBf1dMZWCoAlt4Dkv79QkEZnCya9De6eVeinLlz7qdn0rJQn4wWSkCErkB6p/vy6p5R
         26CKNUHj3O3ChFnt3sg2lTJa9uHoYbyXRAi7RQaEYEk1C7qW/fiayJHLZzLlnCUt6Beh
         NxHhsq4c59lEKV6hRE8d8PyP127XpEOg/m9WcqbQ5XzqnhB64/EYHFN+t5gDLQrKNMSP
         588g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692224242; x=1692829042;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6UTbn4xpNMapZLUA3ScvMIvn9YowYIXXbdog+JM0gnY=;
        b=ix1YrayDtks5pphjP3QIOkgGpip0M9q0+Ryv0DFsloN2i54hWyJvtcyYkRO9R3PmYP
         lht+4S/U2n9Ef2YkLJcHmYVs42dcxEyELnJ/7FF/KvksEztT3Y/sBnfVUJ11a9Hjj3Mx
         r/lKbAsLBwX+DYTD4FxaX7HXqujrLIJokyQG/zvf0rHqpP5vkz+zloFScOdlKc4OMO/7
         knYKjtJtt4+UF6e2+LHS7BD+3UocXoDKfM5AFBcz2qNLhxe13MQE+30l7ifN/8E3BC/j
         CXtPzG4RjDpUNrePzUT9exF4xp2nySVAavaUQaHz+Ihd+7v3iK75T/pkywQMVM9Azs1v
         gC7w==
X-Gm-Message-State: AOJu0Yz51CgUUjCeb1QZ2Mywmc1Bx2jiVrEIKHYVaBArD4tlG9B5Ry5a
        qFuzM2nqxSWriiLPPBzcIFnJwcGt5yOD0dygIYI52g==
X-Google-Smtp-Source: AGHT+IGxVq+YeBA6Lv4G/zc/5j09bk4x5fC1B5oypSPCcHi2aiBCStWNxYkYA9bR2w9o5AHX9VXAMw==
X-Received: by 2002:a17:902:e5cd:b0:1b8:9552:2249 with SMTP id u13-20020a170902e5cd00b001b895522249mr3979375plf.43.1692224241353;
        Wed, 16 Aug 2023 15:17:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b19-20020a17090ae39300b0026943a8468dsm213535pjz.18.2023.08.16.15.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 15:17:20 -0700 (PDT)
Message-ID: <64dd4af0.170a0220.40d58.0bd8@mx.google.com>
Date:   Wed, 16 Aug 2023 15:17:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.127
X-Kernelci-Tree: stable
X-Kernelci-Branch: linux-5.15.y
Subject: stable/linux-5.15.y baseline: 189 runs, 23 regressions (v5.15.127)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-5.15.y baseline: 189 runs, 23 regressions (v5.15.127)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.15.y/kernel=
/v5.15.127/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.15.y
  Describe: v5.15.127
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      f6f7927ac664ba23447f8dd3c3dfe2f4ee39272f =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd14de8517dbbaab35b23b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd14de8517dbbaab35b240
        failing since 139 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-16T18:26:21.704700  + set +x

    2023-08-16T18:26:21.711218  <8>[   10.663650] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11301608_1.4.2.3.1>

    2023-08-16T18:26:21.818789  / # #

    2023-08-16T18:26:21.921301  export SHELL=3D/bin/sh

    2023-08-16T18:26:21.922025  #

    2023-08-16T18:26:22.023390  / # export SHELL=3D/bin/sh. /lava-11301608/=
environment

    2023-08-16T18:26:22.024157  =


    2023-08-16T18:26:22.125545  / # . /lava-11301608/environment/lava-11301=
608/bin/lava-test-runner /lava-11301608/1

    2023-08-16T18:26:22.126792  =


    2023-08-16T18:26:22.132560  / # /lava-11301608/bin/lava-test-runner /la=
va-11301608/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd155613fed8962a35b217

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd155613fed8962a35b21c
        failing since 139 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-16T18:28:17.995430  <8>[   11.258367] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11301657_1.4.2.3.1>

    2023-08-16T18:28:17.998768  + set +x

    2023-08-16T18:28:18.103630  #

    2023-08-16T18:28:18.206372  / # #export SHELL=3D/bin/sh

    2023-08-16T18:28:18.207174  =


    2023-08-16T18:28:18.308829  / # export SHELL=3D/bin/sh. /lava-11301657/=
environment

    2023-08-16T18:28:18.309637  =


    2023-08-16T18:28:18.411292  / # . /lava-11301657/environment/lava-11301=
657/bin/lava-test-runner /lava-11301657/1

    2023-08-16T18:28:18.412586  =


    2023-08-16T18:28:18.418772  / # /lava-11301657/bin/lava-test-runner /la=
va-11301657/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd14e922ba8ff0f735b1d9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd14ea22ba8ff0f735b1de
        failing since 139 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-16T18:26:37.805329  + set<8>[   11.982765] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11301623_1.4.2.3.1>

    2023-08-16T18:26:37.805423   +x

    2023-08-16T18:26:37.909900  / # #

    2023-08-16T18:26:38.010568  export SHELL=3D/bin/sh

    2023-08-16T18:26:38.010744  #

    2023-08-16T18:26:38.111325  / # export SHELL=3D/bin/sh. /lava-11301623/=
environment

    2023-08-16T18:26:38.111494  =


    2023-08-16T18:26:38.212140  / # . /lava-11301623/environment/lava-11301=
623/bin/lava-test-runner /lava-11301623/1

    2023-08-16T18:26:38.212409  =


    2023-08-16T18:26:38.217136  / # /lava-11301623/bin/lava-test-runner /la=
va-11301623/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd150f0432f6dd6635b21a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd150f0432f6dd6635b21f
        failing since 139 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-16T18:27:08.167796  + set +x

    2023-08-16T18:27:08.170813  <8>[   10.331852] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11301660_1.4.2.3.1>

    2023-08-16T18:27:08.279357  / # #

    2023-08-16T18:27:08.382282  export SHELL=3D/bin/sh

    2023-08-16T18:27:08.383094  #

    2023-08-16T18:27:08.484741  / # export SHELL=3D/bin/sh. /lava-11301660/=
environment

    2023-08-16T18:27:08.485552  =


    2023-08-16T18:27:08.587362  / # . /lava-11301660/environment/lava-11301=
660/bin/lava-test-runner /lava-11301660/1

    2023-08-16T18:27:08.588592  =


    2023-08-16T18:27:08.593518  / # /lava-11301660/bin/lava-test-runner /la=
va-11301660/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd14db8517dbbaab35b225

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd14db8517dbbaab35b22a
        failing since 139 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-16T18:26:28.232563  <8>[   10.604090] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11301595_1.4.2.3.1>

    2023-08-16T18:26:28.235708  + set +x

    2023-08-16T18:26:28.337217  #

    2023-08-16T18:26:28.438077  / # #export SHELL=3D/bin/sh

    2023-08-16T18:26:28.438281  =


    2023-08-16T18:26:28.538817  / # export SHELL=3D/bin/sh. /lava-11301595/=
environment

    2023-08-16T18:26:28.539035  =


    2023-08-16T18:26:28.639636  / # . /lava-11301595/environment/lava-11301=
595/bin/lava-test-runner /lava-11301595/1

    2023-08-16T18:26:28.639950  =


    2023-08-16T18:26:28.645021  / # /lava-11301595/bin/lava-test-runner /la=
va-11301595/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd14fb0432f6dd6635b1e5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd14fb0432f6dd6635b1ea
        failing since 139 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-16T18:27:00.569342  <8>[   12.247151] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11301638_1.4.2.3.1>

    2023-08-16T18:27:00.572754  + set +x

    2023-08-16T18:27:00.677967  #

    2023-08-16T18:27:00.679362  =


    2023-08-16T18:27:00.781434  / # #export SHELL=3D/bin/sh

    2023-08-16T18:27:00.782223  =


    2023-08-16T18:27:00.884087  / # export SHELL=3D/bin/sh. /lava-11301638/=
environment

    2023-08-16T18:27:00.884811  =


    2023-08-16T18:27:00.986511  / # . /lava-11301638/environment/lava-11301=
638/bin/lava-test-runner /lava-11301638/1

    2023-08-16T18:27:00.987735  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd16fb70808fce2735b272

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd16fb70808fce2735b277
        failing since 20 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-08-16T18:36:58.655760  / # #

    2023-08-16T18:36:58.757917  export SHELL=3D/bin/sh

    2023-08-16T18:36:58.758610  #

    2023-08-16T18:36:58.860024  / # export SHELL=3D/bin/sh. /lava-11301698/=
environment

    2023-08-16T18:36:58.860723  =


    2023-08-16T18:36:58.962207  / # . /lava-11301698/environment/lava-11301=
698/bin/lava-test-runner /lava-11301698/1

    2023-08-16T18:36:58.963282  =


    2023-08-16T18:36:58.980151  / # /lava-11301698/bin/lava-test-runner /la=
va-11301698/1

    2023-08-16T18:36:59.088014  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-16T18:36:59.088518  + cd /lava-11301698/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd192ac6ccacbb5c35b1d9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd192ac6ccacbb5c35b=
1da
        failing since 133 days (last pass: v5.15.105, first fail: v5.15.106=
) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd160a88ba034ced35b20f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd160a88ba034ced35b214
        failing since 210 days (last pass: v5.15.82, first fail: v5.15.89)

    2023-08-16T18:31:24.608924  + set +x<8>[   10.109469] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3743366_1.5.2.4.1>
    2023-08-16T18:31:24.609639  =

    2023-08-16T18:31:24.719262  / # #
    2023-08-16T18:31:24.822972  export SHELL=3D/bin/sh
    2023-08-16T18:31:24.824140  #
    2023-08-16T18:31:24.926383  / # export SHELL=3D/bin/sh. /lava-3743366/e=
nvironment
    2023-08-16T18:31:24.927482  =

    2023-08-16T18:31:25.029747  / # . /lava-3743366/environment/lava-374336=
6/bin/lava-test-runner /lava-3743366/1
    2023-08-16T18:31:25.031561  =

    2023-08-16T18:31:25.036408  / # /lava-3743366/bin/lava-test-runner /lav=
a-3743366/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd15ff362e35214935b1f1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd15ff362e35214935b1f6
        failing since 166 days (last pass: v5.15.79, first fail: v5.15.97)

    2023-08-16T18:31:17.959615  [   10.746568] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1244232_1.5.2.4.1>
    2023-08-16T18:31:18.064777  =

    2023-08-16T18:31:18.165927  / # #export SHELL=3D/bin/sh
    2023-08-16T18:31:18.166323  =

    2023-08-16T18:31:18.267247  / # export SHELL=3D/bin/sh. /lava-1244232/e=
nvironment
    2023-08-16T18:31:18.267643  =

    2023-08-16T18:31:18.368636  / # . /lava-1244232/environment/lava-124423=
2/bin/lava-test-runner /lava-1244232/1
    2023-08-16T18:31:18.369312  =

    2023-08-16T18:31:18.372984  / # /lava-1244232/bin/lava-test-runner /lav=
a-1244232/1
    2023-08-16T18:31:18.389265  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd14d2abdfd8ae0735b1f3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd14d2abdfd8ae0735b1f8
        failing since 139 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-16T18:26:14.489113  + set +x

    2023-08-16T18:26:14.495854  <8>[   10.886812] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11301601_1.4.2.3.1>

    2023-08-16T18:26:14.600091  / # #

    2023-08-16T18:26:14.700742  export SHELL=3D/bin/sh

    2023-08-16T18:26:14.700979  #

    2023-08-16T18:26:14.801548  / # export SHELL=3D/bin/sh. /lava-11301601/=
environment

    2023-08-16T18:26:14.801787  =


    2023-08-16T18:26:14.902345  / # . /lava-11301601/environment/lava-11301=
601/bin/lava-test-runner /lava-11301601/1

    2023-08-16T18:26:14.902727  =


    2023-08-16T18:26:14.907866  / # /lava-11301601/bin/lava-test-runner /la=
va-11301601/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd1521796078794435b1f6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd1521796078794435b1fb
        failing since 139 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-16T18:27:38.705541  + set +x

    2023-08-16T18:27:38.712366  <8>[   12.619030] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11301651_1.4.2.3.1>

    2023-08-16T18:27:38.816571  / # #

    2023-08-16T18:27:38.917288  export SHELL=3D/bin/sh

    2023-08-16T18:27:38.917477  #

    2023-08-16T18:27:39.017984  / # export SHELL=3D/bin/sh. /lava-11301651/=
environment

    2023-08-16T18:27:39.018159  =


    2023-08-16T18:27:39.118648  / # . /lava-11301651/environment/lava-11301=
651/bin/lava-test-runner /lava-11301651/1

    2023-08-16T18:27:39.118925  =


    2023-08-16T18:27:39.123047  / # /lava-11301651/bin/lava-test-runner /la=
va-11301651/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd14d88517dbbaab35b20f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd14d88517dbbaab35b214
        failing since 139 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-16T18:26:21.076979  <8>[   10.919366] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11301614_1.4.2.3.1>

    2023-08-16T18:26:21.080481  + set +x

    2023-08-16T18:26:21.181786  #

    2023-08-16T18:26:21.182137  =


    2023-08-16T18:26:21.282798  / # #export SHELL=3D/bin/sh

    2023-08-16T18:26:21.283772  =


    2023-08-16T18:26:21.385260  / # export SHELL=3D/bin/sh. /lava-11301614/=
environment

    2023-08-16T18:26:21.386017  =


    2023-08-16T18:26:21.487455  / # . /lava-11301614/environment/lava-11301=
614/bin/lava-test-runner /lava-11301614/1

    2023-08-16T18:26:21.488756  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd14eafff34a62ea35b1dd

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd14eafff34a62ea35b1e2
        failing since 139 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-16T18:26:41.352521  + <8>[   11.014208] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11301656_1.4.2.3.1>

    2023-08-16T18:26:41.352939  set +x

    2023-08-16T18:26:41.456646  #

    2023-08-16T18:26:41.558973  / # #export SHELL=3D/bin/sh

    2023-08-16T18:26:41.559576  =


    2023-08-16T18:26:41.660868  / # export SHELL=3D/bin/sh. /lava-11301656/=
environment

    2023-08-16T18:26:41.661350  =


    2023-08-16T18:26:41.762367  / # . /lava-11301656/environment/lava-11301=
656/bin/lava-test-runner /lava-11301656/1

    2023-08-16T18:26:41.763215  =


    2023-08-16T18:26:41.768272  / # /lava-11301656/bin/lava-test-runner /la=
va-11301656/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd14ec833972bb5d35b1e7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd14ec833972bb5d35b1ec
        failing since 139 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-16T18:26:37.297616  + set<8>[   10.872454] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11301588_1.4.2.3.1>

    2023-08-16T18:26:37.298174   +x

    2023-08-16T18:26:37.406071  / # #

    2023-08-16T18:26:37.508670  export SHELL=3D/bin/sh

    2023-08-16T18:26:37.509458  #

    2023-08-16T18:26:37.611073  / # export SHELL=3D/bin/sh. /lava-11301588/=
environment

    2023-08-16T18:26:37.611987  =


    2023-08-16T18:26:37.713712  / # . /lava-11301588/environment/lava-11301=
588/bin/lava-test-runner /lava-11301588/1

    2023-08-16T18:26:37.715055  =


    2023-08-16T18:26:37.719853  / # /lava-11301588/bin/lava-test-runner /la=
va-11301588/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd15040432f6dd6635b20e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd15040432f6dd6635b213
        failing since 139 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-16T18:26:57.514247  + set +x

    2023-08-16T18:26:57.517700  <8>[   12.100296] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11301659_1.4.2.3.1>

    2023-08-16T18:26:57.621971  / # #

    2023-08-16T18:26:57.722537  export SHELL=3D/bin/sh

    2023-08-16T18:26:57.722701  #

    2023-08-16T18:26:57.823168  / # export SHELL=3D/bin/sh. /lava-11301659/=
environment

    2023-08-16T18:26:57.823324  =


    2023-08-16T18:26:57.923822  / # . /lava-11301659/environment/lava-11301=
659/bin/lava-test-runner /lava-11301659/1

    2023-08-16T18:26:57.924074  =


    2023-08-16T18:26:57.928913  / # /lava-11301659/bin/lava-test-runner /la=
va-11301659/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd14c7abdfd8ae0735b1e2

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd14c7abdfd8ae0735b1e7
        failing since 139 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-16T18:26:01.047818  + <8>[   12.709640] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11301598_1.4.2.3.1>

    2023-08-16T18:26:01.048352  set +x

    2023-08-16T18:26:01.155737  / # #

    2023-08-16T18:26:01.257984  export SHELL=3D/bin/sh

    2023-08-16T18:26:01.258777  #

    2023-08-16T18:26:01.360329  / # export SHELL=3D/bin/sh. /lava-11301598/=
environment

    2023-08-16T18:26:01.361424  =


    2023-08-16T18:26:01.463344  / # . /lava-11301598/environment/lava-11301=
598/bin/lava-test-runner /lava-11301598/1

    2023-08-16T18:26:01.463750  =


    2023-08-16T18:26:01.467837  / # /lava-11301598/bin/lava-test-runner /la=
va-11301598/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd14e995b948747035b1ee

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd14e995b948747035b1f3
        failing since 139 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-16T18:26:43.279696  + set +x

    2023-08-16T18:26:43.282933  <8>[   12.815048] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11301643_1.4.2.3.1>

    2023-08-16T18:26:43.387836  / # #

    2023-08-16T18:26:43.488507  export SHELL=3D/bin/sh

    2023-08-16T18:26:43.488757  #

    2023-08-16T18:26:43.589563  / # export SHELL=3D/bin/sh. /lava-11301643/=
environment

    2023-08-16T18:26:43.590395  =


    2023-08-16T18:26:43.691796  / # . /lava-11301643/environment/lava-11301=
643/bin/lava-test-runner /lava-11301643/1

    2023-08-16T18:26:43.692900  =


    2023-08-16T18:26:43.697531  / # /lava-11301643/bin/lava-test-runner /la=
va-11301643/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd1b2cc95d7dafd935b1d9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd1b2cc95d7dafd935b=
1da
        failing since 204 days (last pass: v5.15.89, first fail: v5.15.90) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd156a5ac58d0cf335b1e5

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd156a5ac58d0cf335b1ea
        failing since 20 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-08-16T18:30:21.914738  / # #

    2023-08-16T18:30:22.015287  export SHELL=3D/bin/sh

    2023-08-16T18:30:22.015456  #

    2023-08-16T18:30:22.115959  / # export SHELL=3D/bin/sh. /lava-11301666/=
environment

    2023-08-16T18:30:22.116094  =


    2023-08-16T18:30:22.216623  / # . /lava-11301666/environment/lava-11301=
666/bin/lava-test-runner /lava-11301666/1

    2023-08-16T18:30:22.216869  =


    2023-08-16T18:30:22.228282  / # /lava-11301666/bin/lava-test-runner /la=
va-11301666/1

    2023-08-16T18:30:22.282017  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-16T18:30:22.282100  + cd /lav<8>[   15.969654] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11301666_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd168285228c7f3335b2c3

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd168285228c7f3335b2c8
        failing since 20 days (last pass: v5.15.118, first fail: v5.15.123)

    2023-08-16T18:35:08.994362  / # #

    2023-08-16T18:35:09.096631  export SHELL=3D/bin/sh

    2023-08-16T18:35:09.097305  #

    2023-08-16T18:35:09.198528  / # export SHELL=3D/bin/sh. /lava-11301702/=
environment

    2023-08-16T18:35:09.199150  =


    2023-08-16T18:35:09.300342  / # . /lava-11301702/environment/lava-11301=
702/bin/lava-test-runner /lava-11301702/1

    2023-08-16T18:35:09.301395  =


    2023-08-16T18:35:09.318830  / # /lava-11301702/bin/lava-test-runner /la=
va-11301702/1

    2023-08-16T18:35:09.442625  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-16T18:35:09.443131  + cd /lava-11301702/1/tests/1_bootrr
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd1581eb36c7773d35b328

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd1581eb36c7773d35b32d
        failing since 20 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-08-16T18:29:13.030444  / # #

    2023-08-16T18:29:14.108585  export SHELL=3D/bin/sh

    2023-08-16T18:29:14.110345  #

    2023-08-16T18:29:15.598256  / # export SHELL=3D/bin/sh. /lava-11301673/=
environment

    2023-08-16T18:29:15.600020  =


    2023-08-16T18:29:18.319656  / # . /lava-11301673/environment/lava-11301=
673/bin/lava-test-runner /lava-11301673/1

    2023-08-16T18:29:18.321920  =


    2023-08-16T18:29:18.322522  / # /lava-11301673/bin/lava-test-runner /la=
va-11301673/1

    2023-08-16T18:29:18.354781  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-16T18:29:18.397755  + cd /lava-113016<8>[   25.563537] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11301673_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd156beb36c7773d35b1db

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.127/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd156beb36c7773d35b1e0
        failing since 20 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-08-16T18:30:33.257477  / # #

    2023-08-16T18:30:33.359552  export SHELL=3D/bin/sh

    2023-08-16T18:30:33.360225  #

    2023-08-16T18:30:33.461401  / # export SHELL=3D/bin/sh. /lava-11301667/=
environment

    2023-08-16T18:30:33.461625  =


    2023-08-16T18:30:33.562053  / # . /lava-11301667/environment/lava-11301=
667/bin/lava-test-runner /lava-11301667/1

    2023-08-16T18:30:33.562244  =


    2023-08-16T18:30:33.568730  / # /lava-11301667/bin/lava-test-runner /la=
va-11301667/1

    2023-08-16T18:30:33.634807  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-16T18:30:33.634875  + cd /lava-1130166<8>[   16.780262] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11301667_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
