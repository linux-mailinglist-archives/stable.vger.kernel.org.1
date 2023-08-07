Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82897725CC
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 15:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjHGNbU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 09:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbjHGNa5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 09:30:57 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4242681
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 06:30:07 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-686daaa5f1fso2968413b3a.3
        for <stable@vger.kernel.org>; Mon, 07 Aug 2023 06:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691414990; x=1692019790;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wlHAqU9kHeAkNTagbS8Grpx8aYDgWe4tOk9aTdgT8qI=;
        b=GGfh1Z+oRD6FeNOxskNxDXdhgX+uDWoUAVMfbfljplvTzm9thXoDVG+jSGoSyPeVy8
         FDxVZ9Z8Tsy/uy4MnRJebm9vls6xgFDyfyqNEC7Lbk0tYEn71qzuFFlyQVsrI1/hiLFF
         snITv20FnTN4EZ43mLW3Fc4Hmi7jK8bmyHCI5J+L+pqnCX/ceibVgJ3qZW/IxHHoTPPU
         MqUO6vpx9hq99CnD9f/je+/B+4k0ODKJ3Syk4vPlxfaXRnfh84xk1wDd6dta7aASP8Wz
         PiJgzAMow2uNJ6MWeZ9+07aYlGV+dw3VWjxLykVFHgkKoi65tEqyO7IRu7lhWD4xuwpU
         ou/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691414990; x=1692019790;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wlHAqU9kHeAkNTagbS8Grpx8aYDgWe4tOk9aTdgT8qI=;
        b=PW4vxdEr4FBayNJ5NiMsqOO8QGeSwlb2oTrhixhyhHSwnR5tT4YWfVzyctYtsjASy7
         AFevUIUc6ZO2HrVmByYn55geTdaOhoSBav8xPWeW+YzUD4RoCvVQPo0St9knJdNcBzyq
         c73AMBpa+XfDfjV1niXD2oXS98wa4UlUw0JOW6ytmTBWwid0CViNKAPszVrXFQMDN52g
         p9T58clrRuGrlwZFOyadBTWURAT6QtDde4saLMkp4brDiKMK6KxDTsrHC1P3wYo2KTFo
         WAFtrqY1HPaiCvy+vF+F648IHQSS4Rv7twvUcT17e4DYPJPW0EzepU8K8MZCbNMFhcIc
         FQCg==
X-Gm-Message-State: AOJu0YwvK7e6/TY/oZl5wLQe2ZIBDTxSFQBesgzGkc2gSW1h2cVhISVD
        jYFkS5ZYeYqgnHJSGeRpE3s3ZwY7boewBFYW+10qmQ==
X-Google-Smtp-Source: AGHT+IHdHExc7luXGjjmIsXGR0I94YGXT1p6eMoOkpRsu9YU58LdQRhJLpqVpHysSz5uFvADLIuZQw==
X-Received: by 2002:a05:6a20:8e24:b0:13e:9451:53ee with SMTP id y36-20020a056a208e2400b0013e945153eemr8778964pzj.38.1691414990154;
        Mon, 07 Aug 2023 06:29:50 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q24-20020a62e118000000b00681783cfc85sm6341078pfh.144.2023.08.07.06.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 06:29:49 -0700 (PDT)
Message-ID: <64d0f1cd.620a0220.aa29a.aef0@mx.google.com>
Date:   Mon, 07 Aug 2023 06:29:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.124-80-g6a5dd0772845f
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.15.y
Subject: stable-rc/linux-5.15.y baseline: 51 runs,
 8 regressions (v5.15.124-80-g6a5dd0772845f)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.15.y baseline: 51 runs, 8 regressions (v5.15.124-80-g6a5d=
d0772845f)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.124-80-g6a5dd0772845f/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.124-80-g6a5dd0772845f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      6a5dd0772845f2aa538ac5a4aeaf609d54892791 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d0bfb3711483d75735b1d9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
24-80-g6a5dd0772845f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
24-80-g6a5dd0772845f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d0bfb3711483d75735b1de
        failing since 131 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-07T09:55:45.693253  + set +x

    2023-08-07T09:55:45.700100  <8>[   10.812470] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11221348_1.4.2.3.1>

    2023-08-07T09:55:45.804837  / # #

    2023-08-07T09:55:45.907743  export SHELL=3D/bin/sh

    2023-08-07T09:55:45.908457  #

    2023-08-07T09:55:46.009766  / # export SHELL=3D/bin/sh. /lava-11221348/=
environment

    2023-08-07T09:55:46.010518  =


    2023-08-07T09:55:46.111839  / # . /lava-11221348/environment/lava-11221=
348/bin/lava-test-runner /lava-11221348/1

    2023-08-07T09:55:46.112926  =


    2023-08-07T09:55:46.118288  / # /lava-11221348/bin/lava-test-runner /la=
va-11221348/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d0bfb8711483d75735b206

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
24-80-g6a5dd0772845f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
24-80-g6a5dd0772845f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d0bfb8711483d75735b20b
        failing since 131 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-07T09:55:54.075067  + set<8>[   11.403187] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11221352_1.4.2.3.1>

    2023-08-07T09:55:54.075177   +x

    2023-08-07T09:55:54.179624  / # #

    2023-08-07T09:55:54.281638  export SHELL=3D/bin/sh

    2023-08-07T09:55:54.282657  #

    2023-08-07T09:55:54.384406  / # export SHELL=3D/bin/sh. /lava-11221352/=
environment

    2023-08-07T09:55:54.385402  =


    2023-08-07T09:55:54.487148  / # . /lava-11221352/environment/lava-11221=
352/bin/lava-test-runner /lava-11221352/1

    2023-08-07T09:55:54.488680  =


    2023-08-07T09:55:54.493425  / # /lava-11221352/bin/lava-test-runner /la=
va-11221352/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d0bfb1207e829f1d35b206

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
24-80-g6a5dd0772845f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
24-80-g6a5dd0772845f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d0bfb1207e829f1d35b20b
        failing since 131 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-07T09:55:42.775995  <8>[   10.887510] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11221332_1.4.2.3.1>

    2023-08-07T09:55:42.779775  + set +x

    2023-08-07T09:55:42.887160  / # #

    2023-08-07T09:55:42.989299  export SHELL=3D/bin/sh

    2023-08-07T09:55:42.990130  #

    2023-08-07T09:55:43.091709  / # export SHELL=3D/bin/sh. /lava-11221332/=
environment

    2023-08-07T09:55:43.092340  =


    2023-08-07T09:55:43.193732  / # . /lava-11221332/environment/lava-11221=
332/bin/lava-test-runner /lava-11221332/1

    2023-08-07T09:55:43.194747  =


    2023-08-07T09:55:43.199613  / # /lava-11221332/bin/lava-test-runner /la=
va-11221332/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d0c1dc42e4b7655535b1f6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
24-80-g6a5dd0772845f/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
24-80-g6a5dd0772845f/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d0c1dc42e4b7655535b=
1f7
        failing since 12 days (last pass: v5.15.120, first fail: v5.15.122-=
79-g3bef1500d246a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d0bfb1a9d4aa9ae235b228

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
24-80-g6a5dd0772845f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
24-80-g6a5dd0772845f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d0bfb1a9d4aa9ae235b22d
        failing since 131 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-07T09:56:16.347327  + <8>[    7.868661] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11221327_1.4.2.3.1>

    2023-08-07T09:56:16.347435  set +x

    2023-08-07T09:56:16.448951  #

    2023-08-07T09:56:16.549878  / # #export SHELL=3D/bin/sh

    2023-08-07T09:56:16.550099  =


    2023-08-07T09:56:16.650609  / # export SHELL=3D/bin/sh. /lava-11221327/=
environment

    2023-08-07T09:56:16.650809  =


    2023-08-07T09:56:16.751375  / # . /lava-11221327/environment/lava-11221=
327/bin/lava-test-runner /lava-11221327/1

    2023-08-07T09:56:16.751804  =


    2023-08-07T09:56:16.757121  / # /lava-11221327/bin/lava-test-runner /la=
va-11221327/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d0bfa2207e829f1d35b1d9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
24-80-g6a5dd0772845f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
24-80-g6a5dd0772845f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d0bfa2207e829f1d35b1de
        failing since 131 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-07T09:55:35.928385  <8>[   10.510412] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11221345_1.4.2.3.1>

    2023-08-07T09:55:35.931862  + set +x

    2023-08-07T09:55:36.033390  =


    2023-08-07T09:55:36.134176  / # #export SHELL=3D/bin/sh

    2023-08-07T09:55:36.134350  =


    2023-08-07T09:55:36.234893  / # export SHELL=3D/bin/sh. /lava-11221345/=
environment

    2023-08-07T09:55:36.235105  =


    2023-08-07T09:55:36.335576  / # . /lava-11221345/environment/lava-11221=
345/bin/lava-test-runner /lava-11221345/1

    2023-08-07T09:55:36.335893  =


    2023-08-07T09:55:36.341302  / # /lava-11221345/bin/lava-test-runner /la=
va-11221345/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d0bfb9711483d75735b215

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
24-80-g6a5dd0772845f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
24-80-g6a5dd0772845f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d0bfb9711483d75735b21a
        failing since 131 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-07T09:55:45.903776  + set<8>[   11.490639] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11221344_1.4.2.3.1>

    2023-08-07T09:55:45.903869   +x

    2023-08-07T09:55:46.008264  / # #

    2023-08-07T09:55:46.108928  export SHELL=3D/bin/sh

    2023-08-07T09:55:46.109115  #

    2023-08-07T09:55:46.209587  / # export SHELL=3D/bin/sh. /lava-11221344/=
environment

    2023-08-07T09:55:46.209802  =


    2023-08-07T09:55:46.310320  / # . /lava-11221344/environment/lava-11221=
344/bin/lava-test-runner /lava-11221344/1

    2023-08-07T09:55:46.310666  =


    2023-08-07T09:55:46.315196  / # /lava-11221344/bin/lava-test-runner /la=
va-11221344/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d0bfb6711483d75735b1e4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
24-80-g6a5dd0772845f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
24-80-g6a5dd0772845f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d0bfb6711483d75735b1e9
        failing since 131 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-07T09:55:49.596616  <8>[   11.925770] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11221324_1.4.2.3.1>

    2023-08-07T09:55:49.704740  / # #

    2023-08-07T09:55:49.805362  export SHELL=3D/bin/sh

    2023-08-07T09:55:49.805542  #

    2023-08-07T09:55:49.906010  / # export SHELL=3D/bin/sh. /lava-11221324/=
environment

    2023-08-07T09:55:49.906196  =


    2023-08-07T09:55:50.006705  / # . /lava-11221324/environment/lava-11221=
324/bin/lava-test-runner /lava-11221324/1

    2023-08-07T09:55:50.006986  =


    2023-08-07T09:55:50.011269  / # /lava-11221324/bin/lava-test-runner /la=
va-11221324/1

    2023-08-07T09:55:50.016846  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =20
