Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B69A76CBC4
	for <lists+stable@lfdr.de>; Wed,  2 Aug 2023 13:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjHBL1r (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 2 Aug 2023 07:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjHBL1q (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 2 Aug 2023 07:27:46 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7C6DC
        for <stable@vger.kernel.org>; Wed,  2 Aug 2023 04:27:43 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1a28de15c8aso5441801fac.2
        for <stable@vger.kernel.org>; Wed, 02 Aug 2023 04:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690975662; x=1691580462;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F8PF/zC5kmjDGwTZMx9lJBRrpE/bv6+84Fi7mqWhkGc=;
        b=Da2QlxgaDoEjbFUbuUrztPkJkKmBoIRUpmJrz48aTEnvfa6mK9fJ6LSDORKjiYqcfl
         rge2Dgz6ko8owy08a6kOIbFn+PQz1WMRV6Q0XtLGWLUx103LoRPqLR5uXJFatqXRk7u0
         i7Ai6Cr4ep3fajchZtjVY05Sy2FhuKBsihhO9S8nO98uvVH6wUCQvGddS+v356lzUy/Y
         B5rjtN7w+XGcjScc1GxzwiosYTKcsiviHud0spY9kuumoZU89SpCuUr02Td2jtv3PRT1
         4zqw3141g59PxaBkVZlJogfbiT9TA4NVWs6RO8nKNC2ol1P6KuuSqZ3K3hQGok1gBBlJ
         dAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690975662; x=1691580462;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F8PF/zC5kmjDGwTZMx9lJBRrpE/bv6+84Fi7mqWhkGc=;
        b=eWwyFG0+Z7/aZyTCGSAkOQNyoz59EjsuurGMj69PmTMTaelnfGO/EQ24D8v0UrVQLQ
         XNVRXxg+4eTNxTZD+dVxOuwW7Y+Z2tEQp+1ZHsUnKGxdBShLnX8iKCnPVSh/X07cgAll
         UmFExFykX6Xvelt9wEKOb0s/iZPGSY8sJRB/8Dv4K4r/p3WG5W9SK4kfGAP55xIltMcB
         EwgxbzCEGa//+fIiScDwhhTolZ6io5d0sX+5ygvZSFt2xbbLQFW9x+cQFYzALef9Ha4x
         T2IG+0xS0IgPlq5VbN0ReLpIt/S92xZWGmSyM2dYSLsV611v2MdOSftvyzivuDRO/mHu
         +q6A==
X-Gm-Message-State: ABy/qLY0FFgAxtTrvvf9sJsfntmfarDubj297rmiS/1gMlWurz1GN4hS
        aRygqcoTb5D34nQP6u5N4WCvALXaZxC7nIvLMIdpqw==
X-Google-Smtp-Source: APBJJlGWG0a3aQqDikAtFUAV5E35hYuUPufzAUEbJSw+3kdWx5Xt/6x+J55xGvjKist85mZSrrr8rA==
X-Received: by 2002:a05:6870:8a0e:b0:1ba:8224:1fef with SMTP id p14-20020a0568708a0e00b001ba82241fefmr18168507oaq.22.1690975661850;
        Wed, 02 Aug 2023 04:27:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090a410900b00268dac826d4sm952304pjf.0.2023.08.02.04.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 04:27:41 -0700 (PDT)
Message-ID: <64ca3dad.170a0220.ec4ed.1b44@mx.google.com>
Date:   Wed, 02 Aug 2023 04:27:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.123-154-gb261bd72eeda8
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.15.y
Subject: stable-rc/linux-5.15.y baseline: 124 runs,
 13 regressions (v5.15.123-154-gb261bd72eeda8)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.15.y baseline: 124 runs, 13 regressions (v5.15.123-154-gb=
261bd72eeda8)

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

beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

fsl-ls2088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

fsl-lx2160a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

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

r8a779m1-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.123-154-gb261bd72eeda8/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.123-154-gb261bd72eeda8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b261bd72eeda8af76b98809780cd6f182ec444bc =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ca0aeacebc04aece35b1db

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-154-gb261bd72eeda8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-154-gb261bd72eeda8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ca0aeacebc04aece35b1e0
        failing since 126 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-02T07:50:58.029906  <8>[   10.651835] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11188452_1.4.2.3.1>

    2023-08-02T07:50:58.033351  + set +x

    2023-08-02T07:50:58.138262  / # #

    2023-08-02T07:50:58.238984  export SHELL=3D/bin/sh

    2023-08-02T07:50:58.239218  #

    2023-08-02T07:50:58.339751  / # export SHELL=3D/bin/sh. /lava-11188452/=
environment

    2023-08-02T07:50:58.339941  =


    2023-08-02T07:50:58.440434  / # . /lava-11188452/environment/lava-11188=
452/bin/lava-test-runner /lava-11188452/1

    2023-08-02T07:50:58.440700  =


    2023-08-02T07:50:58.446425  / # /lava-11188452/bin/lava-test-runner /la=
va-11188452/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ca0ae03a65e7df4f35b1ea

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-154-gb261bd72eeda8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-154-gb261bd72eeda8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ca0ae03a65e7df4f35b1ef
        failing since 126 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-02T07:50:45.429386  + <8>[    8.930098] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11188453_1.4.2.3.1>

    2023-08-02T07:50:45.429807  set +x

    2023-08-02T07:50:45.536859  / # #

    2023-08-02T07:50:45.638805  export SHELL=3D/bin/sh

    2023-08-02T07:50:45.639438  #

    2023-08-02T07:50:45.740761  / # export SHELL=3D/bin/sh. /lava-11188453/=
environment

    2023-08-02T07:50:45.741401  =


    2023-08-02T07:50:45.842763  / # . /lava-11188453/environment/lava-11188=
453/bin/lava-test-runner /lava-11188453/1

    2023-08-02T07:50:45.843815  =


    2023-08-02T07:50:45.848383  / # /lava-11188453/bin/lava-test-runner /la=
va-11188453/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ca0d12149071468f35b29d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-154-gb261bd72eeda8/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-=
beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-154-gb261bd72eeda8/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-=
beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ca0d12149071468f35b=
29e
        failing since 7 days (last pass: v5.15.120, first fail: v5.15.122-7=
9-g3bef1500d246a) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ca0c53a7f9d59e2635b1e8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-154-gb261bd72eeda8/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-154-gb261bd72eeda8/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ca0c53a7f9d59e2635b1ed
        failing since 197 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-08-02T07:56:49.640279  <8>[    9.955307] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3727464_1.5.2.4.1>
    2023-08-02T07:56:49.747099  / # #
    2023-08-02T07:56:49.848791  export SHELL=3D/bin/sh
    2023-08-02T07:56:49.849218  #
    2023-08-02T07:56:49.950503  / # export SHELL=3D/bin/sh. /lava-3727464/e=
nvironment
    2023-08-02T07:56:49.950988  =

    2023-08-02T07:56:50.052382  / # . /lava-3727464/environment/lava-372746=
4/bin/lava-test-runner /lava-3727464/1
    2023-08-02T07:56:50.052915  <3>[   10.274221] Bluetooth: hci0: command =
0xfc18 tx timeout
    2023-08-02T07:56:50.053110  =

    2023-08-02T07:56:50.058160  / # /lava-3727464/bin/lava-test-runner /lav=
a-3727464/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ca0cfea20a2ef30a35b25b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-154-gb261bd72eeda8/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-r=
db.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-154-gb261bd72eeda8/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-r=
db.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ca0cfea20a2ef30a35b25e
        failing since 19 days (last pass: v5.15.67, first fail: v5.15.119-1=
6-g66130849c020f)

    2023-08-02T07:59:38.317738  + [   14.697014] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1240205_1.5.2.4.1>
    2023-08-02T07:59:38.318000  set +x
    2023-08-02T07:59:38.423220  =

    2023-08-02T07:59:38.524421  / # #export SHELL=3D/bin/sh
    2023-08-02T07:59:38.524824  =

    2023-08-02T07:59:38.625801  / # export SHELL=3D/bin/sh. /lava-1240205/e=
nvironment
    2023-08-02T07:59:38.626201  =

    2023-08-02T07:59:38.727187  / # . /lava-1240205/environment/lava-124020=
5/bin/lava-test-runner /lava-1240205/1
    2023-08-02T07:59:38.727851  =

    2023-08-02T07:59:38.732240  / # /lava-1240205/bin/lava-test-runner /lav=
a-1240205/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ca0d179cb66e775835b1f2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-154-gb261bd72eeda8/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-r=
db.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-154-gb261bd72eeda8/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-r=
db.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ca0d179cb66e775835b1f5
        failing since 151 days (last pass: v5.15.79, first fail: v5.15.98)

    2023-08-02T08:00:08.612824  [   10.184757] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1240207_1.5.2.4.1>
    2023-08-02T08:00:08.718138  =

    2023-08-02T08:00:08.819398  / # #export SHELL=3D/bin/sh
    2023-08-02T08:00:08.819796  =

    2023-08-02T08:00:08.920782  / # export SHELL=3D/bin/sh. /lava-1240207/e=
nvironment
    2023-08-02T08:00:08.921190  =

    2023-08-02T08:00:09.022215  / # . /lava-1240207/environment/lava-124020=
7/bin/lava-test-runner /lava-1240207/1
    2023-08-02T08:00:09.022990  =

    2023-08-02T08:00:09.026916  / # /lava-1240207/bin/lava-test-runner /lav=
a-1240207/1
    2023-08-02T08:00:09.042794  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ca0abcf91180db0235b1e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-154-gb261bd72eeda8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-154-gb261bd72eeda8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ca0abcf91180db0235b1eb
        failing since 126 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-02T07:50:47.210228  + <8>[   10.291364] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11188421_1.4.2.3.1>

    2023-08-02T07:50:47.210310  set +x

    2023-08-02T07:50:47.311457  #

    2023-08-02T07:50:47.412326  / # #export SHELL=3D/bin/sh

    2023-08-02T07:50:47.412505  =


    2023-08-02T07:50:47.513008  / # export SHELL=3D/bin/sh. /lava-11188421/=
environment

    2023-08-02T07:50:47.513178  =


    2023-08-02T07:50:47.613664  / # . /lava-11188421/environment/lava-11188=
421/bin/lava-test-runner /lava-11188421/1

    2023-08-02T07:50:47.613918  =


    2023-08-02T07:50:47.619111  / # /lava-11188421/bin/lava-test-runner /la=
va-11188421/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ca0ad3b17bab42ce35b23f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-154-gb261bd72eeda8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-154-gb261bd72eeda8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ca0ad3b17bab42ce35b244
        failing since 126 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-02T07:50:56.773321  <8>[   10.356661] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11188441_1.4.2.3.1>

    2023-08-02T07:50:56.776708  + set +x

    2023-08-02T07:50:56.880875  / # #

    2023-08-02T07:50:56.981449  export SHELL=3D/bin/sh

    2023-08-02T07:50:56.981616  #

    2023-08-02T07:50:57.082157  / # export SHELL=3D/bin/sh. /lava-11188441/=
environment

    2023-08-02T07:50:57.082310  =


    2023-08-02T07:50:57.182800  / # . /lava-11188441/environment/lava-11188=
441/bin/lava-test-runner /lava-11188441/1

    2023-08-02T07:50:57.183130  =


    2023-08-02T07:50:57.188107  / # /lava-11188441/bin/lava-test-runner /la=
va-11188441/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ca0accb17bab42ce35b1e4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-154-gb261bd72eeda8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-154-gb261bd72eeda8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ca0accb17bab42ce35b1e9
        failing since 126 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-02T07:50:29.265378  + set<8>[   10.704704] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11188423_1.4.2.3.1>

    2023-08-02T07:50:29.265483   +x

    2023-08-02T07:50:29.370218  / # #

    2023-08-02T07:50:29.470859  export SHELL=3D/bin/sh

    2023-08-02T07:50:29.471091  #

    2023-08-02T07:50:29.571618  / # export SHELL=3D/bin/sh. /lava-11188423/=
environment

    2023-08-02T07:50:29.571777  =


    2023-08-02T07:50:29.672251  / # . /lava-11188423/environment/lava-11188=
423/bin/lava-test-runner /lava-11188423/1

    2023-08-02T07:50:29.672535  =


    2023-08-02T07:50:29.677238  / # /lava-11188423/bin/lava-test-runner /la=
va-11188423/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ca0bfd0ec8ad39e635b205

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-154-gb261bd72eeda8/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baselin=
e-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-154-gb261bd72eeda8/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baselin=
e-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ca0bfd0ec8ad39e635b20a
        failing since 183 days (last pass: v5.15.81-122-gc5f8d4a5d3c8, firs=
t fail: v5.15.90-205-g5605d15db022)

    2023-08-02T07:55:35.358951  + set +x
    2023-08-02T07:55:35.359146  [    9.406532] <LAVA_SIGNAL_ENDRUN 0_dmesg =
996848_1.5.2.3.1>
    2023-08-02T07:55:35.467195  / # #
    2023-08-02T07:55:35.568827  export SHELL=3D/bin/sh
    2023-08-02T07:55:35.569307  #
    2023-08-02T07:55:35.670556  / # export SHELL=3D/bin/sh. /lava-996848/en=
vironment
    2023-08-02T07:55:35.671071  =

    2023-08-02T07:55:35.772350  / # . /lava-996848/environment/lava-996848/=
bin/lava-test-runner /lava-996848/1
    2023-08-02T07:55:35.772979  =

    2023-08-02T07:55:35.775797  / # /lava-996848/bin/lava-test-runner /lava=
-996848/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ca0accb17bab42ce35b1ef

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-154-gb261bd72eeda8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-154-gb261bd72eeda8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ca0accb17bab42ce35b1f4
        failing since 126 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-02T07:50:18.394078  + set +x<8>[   12.274884] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11188417_1.4.2.3.1>

    2023-08-02T07:50:18.394159  =


    2023-08-02T07:50:18.498677  / # #

    2023-08-02T07:50:18.599215  export SHELL=3D/bin/sh

    2023-08-02T07:50:18.599433  #

    2023-08-02T07:50:18.699928  / # export SHELL=3D/bin/sh. /lava-11188417/=
environment

    2023-08-02T07:50:18.700109  =


    2023-08-02T07:50:18.800619  / # . /lava-11188417/environment/lava-11188=
417/bin/lava-test-runner /lava-11188417/1

    2023-08-02T07:50:18.800931  =


    2023-08-02T07:50:18.805779  / # /lava-11188417/bin/lava-test-runner /la=
va-11188417/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ca0c929cd0742cfe35b22a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-154-gb261bd72eeda8/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m=
1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-154-gb261bd72eeda8/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m=
1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ca0c929cd0742cfe35b22f
        failing since 13 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-08-02T07:58:26.987793  / # #

    2023-08-02T07:58:28.067422  export SHELL=3D/bin/sh

    2023-08-02T07:58:28.069219  #

    2023-08-02T07:58:29.560015  / # export SHELL=3D/bin/sh. /lava-11188541/=
environment

    2023-08-02T07:58:29.561863  =


    2023-08-02T07:58:32.286326  / # . /lava-11188541/environment/lava-11188=
541/bin/lava-test-runner /lava-11188541/1

    2023-08-02T07:58:32.288624  =


    2023-08-02T07:58:32.294374  / # /lava-11188541/bin/lava-test-runner /la=
va-11188541/1

    2023-08-02T07:58:32.358655  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-02T07:58:32.359158  + cd /lava-111885<8>[   25.502977] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11188541_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ca0c8b9d3470a45335b229

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-154-gb261bd72eeda8/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-=
h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-154-gb261bd72eeda8/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-=
h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ca0c8b9d3470a45335b22e
        failing since 13 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-08-02T07:59:35.088144  / # #

    2023-08-02T07:59:35.190316  export SHELL=3D/bin/sh

    2023-08-02T07:59:35.191026  #

    2023-08-02T07:59:35.292414  / # export SHELL=3D/bin/sh. /lava-11188545/=
environment

    2023-08-02T07:59:35.293164  =


    2023-08-02T07:59:35.394616  / # . /lava-11188545/environment/lava-11188=
545/bin/lava-test-runner /lava-11188545/1

    2023-08-02T07:59:35.395708  =


    2023-08-02T07:59:35.412405  / # /lava-11188545/bin/lava-test-runner /la=
va-11188545/1

    2023-08-02T07:59:35.470255  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-02T07:59:35.470776  + cd /lava-1118854<8>[   16.859683] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11188545_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
