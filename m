Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5007676B766
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 16:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbjHAO2q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 10:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbjHAO2o (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 10:28:44 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAAAE9
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 07:28:41 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686ed1d2594so5443825b3a.2
        for <stable@vger.kernel.org>; Tue, 01 Aug 2023 07:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690900120; x=1691504920;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1DrgthpGK6Xnqj0+Nd7uZ3mcbHJ9dteqHYm4GiqrbyI=;
        b=s738q407BZdVuzV9wm1PFgwtsa7h9yIjMrssgSq+ub0CjNa9wTYihvXfldrjOJjxMH
         jg6yVJ/03aTvz5RoZavZj9qVmi5A20SKmyNdk+2HfcKGmBm/kuKSZyLu3vkM8gg82kSq
         H6BxD3zI0RrYC1wlqEJ9J6HXYTfjOMQhVJIM/oPgT6bgjRSQDIy2ec3dpEmImsJl4+u+
         ezktXOPi8ho37oNYsvU7ABARk8IAeMymhyPGrbJfc8NloaTWn0dU6b2/m8sdbw2ZzHNu
         2uHtV2a0irRBG2ojkXejBs064WXEPq46wxwv0Kpjat9hFFldeDzM8K8HEAkXivvJeTzc
         emBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690900120; x=1691504920;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1DrgthpGK6Xnqj0+Nd7uZ3mcbHJ9dteqHYm4GiqrbyI=;
        b=IUhtAiYm9DIvb2bj1sYXgrjN2no8kfk2M1u0IGFNg8yKMIpMh16ivp1zOxTj7bgbnr
         TfnxeF4mO2hCJKqf92xds1hILklYE9Wm6VyV5PUILvl8V8EEA8ztbB/S45oiZW5o3jBm
         CW35657ekPbGf65gLqTKdFLFjVzrgGdEBjACEwanFYxb+yMGt5dVngecHZgiVO/2OaMI
         8VxnNooXN4q5U92D6UVlJaxAmAI4ZxHS4peMWIAqQF2p/bN0qiKLNE76WbL5or2fQi3x
         Qp/l/+OPsA1WwjGSp8+3H4OiHCtUyW4PCCyRdoLM07g+0IA2qBBzRLQUDR3h7bfygpaE
         DLvQ==
X-Gm-Message-State: ABy/qLbbiAfwRSPZ6nMmgR1eOBeNyc0aTL7bX1g0qqYnN3BNFIKCj6lb
        r6VciCgeW+lnDvHs/5gQJ0feQ4CKybjai5VKKPYBQw==
X-Google-Smtp-Source: APBJJlF/HdcibanvZgUHSWbZLdUaqmVf0Ylm0iYrtJOdX9UnL68Vwo+Lsb46NAMMUSbZHkePnPnYBA==
X-Received: by 2002:a05:6a20:d90b:b0:13d:c86b:d76d with SMTP id jd11-20020a056a20d90b00b0013dc86bd76dmr7175672pzb.60.1690900120006;
        Tue, 01 Aug 2023 07:28:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l21-20020a62be15000000b0068743cab196sm3000657pff.186.2023.08.01.07.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 07:28:39 -0700 (PDT)
Message-ID: <64c91697.620a0220.7fa17.6297@mx.google.com>
Date:   Tue, 01 Aug 2023 07:28:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Kernel: v5.15.123-156-gb2c388dc24433
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.15.y baseline: 118 runs,
 15 regressions (v5.15.123-156-gb2c388dc24433)
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

stable-rc/linux-5.15.y baseline: 118 runs, 15 regressions (v5.15.123-156-gb=
2c388dc24433)

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

r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.123-156-gb2c388dc24433/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.123-156-gb2c388dc24433
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b2c388dc24433c87e9fa67ae5aeade83f5625286 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8e08ffbef75f8778ace64

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-156-gb2c388dc24433/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-156-gb2c388dc24433/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8e08ffbef75f8778ace69
        failing since 125 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-01T10:37:58.832552  + set +x

    2023-08-01T10:37:58.838997  <8>[   10.904000] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11182913_1.4.2.3.1>

    2023-08-01T10:37:58.946458  / # #

    2023-08-01T10:37:59.047004  export SHELL=3D/bin/sh

    2023-08-01T10:37:59.047164  #

    2023-08-01T10:37:59.147695  / # export SHELL=3D/bin/sh. /lava-11182913/=
environment

    2023-08-01T10:37:59.147894  =


    2023-08-01T10:37:59.248552  / # . /lava-11182913/environment/lava-11182=
913/bin/lava-test-runner /lava-11182913/1

    2023-08-01T10:37:59.249605  =


    2023-08-01T10:37:59.255654  / # /lava-11182913/bin/lava-test-runner /la=
va-11182913/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8e08f690e5b4b108ace4b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-156-gb2c388dc24433/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-156-gb2c388dc24433/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8e08f690e5b4b108ace50
        failing since 125 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-01T10:37:50.581872  + set<8>[   11.611687] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11182925_1.4.2.3.1>

    2023-08-01T10:37:50.581984   +x

    2023-08-01T10:37:50.685716  / # #

    2023-08-01T10:37:50.786266  export SHELL=3D/bin/sh

    2023-08-01T10:37:50.786421  #

    2023-08-01T10:37:50.886926  / # export SHELL=3D/bin/sh. /lava-11182925/=
environment

    2023-08-01T10:37:50.887098  =


    2023-08-01T10:37:50.987583  / # . /lava-11182925/environment/lava-11182=
925/bin/lava-test-runner /lava-11182925/1

    2023-08-01T10:37:50.987822  =


    2023-08-01T10:37:50.992501  / # /lava-11182925/bin/lava-test-runner /la=
va-11182925/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8e09043fdf184658ace3f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-156-gb2c388dc24433/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-156-gb2c388dc24433/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8e09043fdf184658ace44
        failing since 125 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-01T10:37:49.171093  <8>[    8.590207] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11182903_1.4.2.3.1>

    2023-08-01T10:37:49.174255  + set +x

    2023-08-01T10:37:49.275574  =


    2023-08-01T10:37:49.376093  / # #export SHELL=3D/bin/sh

    2023-08-01T10:37:49.376291  =


    2023-08-01T10:37:49.476842  / # export SHELL=3D/bin/sh. /lava-11182903/=
environment

    2023-08-01T10:37:49.477002  =


    2023-08-01T10:37:49.577520  / # . /lava-11182903/environment/lava-11182=
903/bin/lava-test-runner /lava-11182903/1

    2023-08-01T10:37:49.577802  =


    2023-08-01T10:37:49.582916  / # /lava-11182903/bin/lava-test-runner /la=
va-11182903/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8e268a4949d0c448ace1e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-156-gb2c388dc24433/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-=
beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-156-gb2c388dc24433/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-=
beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64c8e268a4949d0c448ac=
e1f
        failing since 6 days (last pass: v5.15.120, first fail: v5.15.122-7=
9-g3bef1500d246a) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8e1f717e2ed46738ace37

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-156-gb2c388dc24433/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-156-gb2c388dc24433/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8e1f717e2ed46738ace3c
        failing since 196 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-08-01T10:43:36.637230  <8>[   10.021836] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3727201_1.5.2.4.1>
    2023-08-01T10:43:36.748004  / # #
    2023-08-01T10:43:36.850467  export SHELL=3D/bin/sh
    2023-08-01T10:43:36.851256  #
    2023-08-01T10:43:36.952973  / # export SHELL=3D/bin/sh. /lava-3727201/e=
nvironment
    2023-08-01T10:43:36.953388  =

    2023-08-01T10:43:36.953694  / # <3>[   10.273200] Bluetooth: hci0: comm=
and 0xfc18 tx timeout
    2023-08-01T10:43:37.054947  . /lava-3727201/environment/lava-3727201/bi=
n/lava-test-runner /lava-3727201/1
    2023-08-01T10:43:37.055622  =

    2023-08-01T10:43:37.060704  / # /lava-3727201/bin/lava-test-runner /lav=
a-3727201/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8e0f92aca0327a88ace1e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-156-gb2c388dc24433/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-r=
db.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-156-gb2c388dc24433/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-r=
db.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8e0f92aca0327a88ace21
        failing since 18 days (last pass: v5.15.67, first fail: v5.15.119-1=
6-g66130849c020f)

    2023-08-01T10:39:46.478871  + [   14.179078] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1239975_1.5.2.4.1>
    2023-08-01T10:39:46.479196  set +x
    2023-08-01T10:39:46.584284  =

    2023-08-01T10:39:46.685456  / # #export SHELL=3D/bin/sh
    2023-08-01T10:39:46.685856  =

    2023-08-01T10:39:46.786824  / # export SHELL=3D/bin/sh. /lava-1239975/e=
nvironment
    2023-08-01T10:39:46.787237  =

    2023-08-01T10:39:46.888213  / # . /lava-1239975/environment/lava-123997=
5/bin/lava-test-runner /lava-1239975/1
    2023-08-01T10:39:46.888889  =

    2023-08-01T10:39:46.893256  / # /lava-1239975/bin/lava-test-runner /lav=
a-1239975/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8e1132aca0327a88ace59

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-156-gb2c388dc24433/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-r=
db.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-156-gb2c388dc24433/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-r=
db.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8e1132aca0327a88ace5c
        failing since 150 days (last pass: v5.15.79, first fail: v5.15.98)

    2023-08-01T10:39:48.665831  [   10.930451] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1239978_1.5.2.4.1>
    2023-08-01T10:39:48.770378  =

    2023-08-01T10:39:48.871633  / # #export SHELL=3D/bin/sh
    2023-08-01T10:39:48.872042  =

    2023-08-01T10:39:48.972993  / # export SHELL=3D/bin/sh. /lava-1239978/e=
nvironment
    2023-08-01T10:39:48.973415  =

    2023-08-01T10:39:49.074393  / # . /lava-1239978/environment/lava-123997=
8/bin/lava-test-runner /lava-1239978/1
    2023-08-01T10:39:49.075063  =

    2023-08-01T10:39:49.079084  / # /lava-1239978/bin/lava-test-runner /lav=
a-1239978/1
    2023-08-01T10:39:49.094320  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8e07d8cce7579828ace84

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-156-gb2c388dc24433/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-156-gb2c388dc24433/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8e07d8cce7579828ace89
        failing since 125 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-01T10:37:43.576515  + set +x

    2023-08-01T10:37:43.583101  <8>[   10.799006] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11182936_1.4.2.3.1>

    2023-08-01T10:37:43.688025  / # #

    2023-08-01T10:37:43.788715  export SHELL=3D/bin/sh

    2023-08-01T10:37:43.788918  #

    2023-08-01T10:37:43.889406  / # export SHELL=3D/bin/sh. /lava-11182936/=
environment

    2023-08-01T10:37:43.889637  =


    2023-08-01T10:37:43.990176  / # . /lava-11182936/environment/lava-11182=
936/bin/lava-test-runner /lava-11182936/1

    2023-08-01T10:37:43.990487  =


    2023-08-01T10:37:43.994825  / # /lava-11182936/bin/lava-test-runner /la=
va-11182936/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8e07c43fdf184658ace30

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-156-gb2c388dc24433/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-156-gb2c388dc24433/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8e07c43fdf184658ace35
        failing since 125 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-01T10:37:39.099260  <8>[   11.023002] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11182915_1.4.2.3.1>

    2023-08-01T10:37:39.102881  + set +x

    2023-08-01T10:37:39.204073  #

    2023-08-01T10:37:39.204350  =


    2023-08-01T10:37:39.304885  / # #export SHELL=3D/bin/sh

    2023-08-01T10:37:39.305074  =


    2023-08-01T10:37:39.405541  / # export SHELL=3D/bin/sh. /lava-11182915/=
environment

    2023-08-01T10:37:39.405756  =


    2023-08-01T10:37:39.506286  / # . /lava-11182915/environment/lava-11182=
915/bin/lava-test-runner /lava-11182915/1

    2023-08-01T10:37:39.506625  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8e090eb81b05b258ace3d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-156-gb2c388dc24433/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-156-gb2c388dc24433/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8e090eb81b05b258ace42
        failing since 125 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-01T10:37:50.882414  + set<8>[   11.448793] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11182898_1.4.2.3.1>

    2023-08-01T10:37:50.882499   +x

    2023-08-01T10:37:50.986429  / # #

    2023-08-01T10:37:51.087058  export SHELL=3D/bin/sh

    2023-08-01T10:37:51.087263  #

    2023-08-01T10:37:51.187770  / # export SHELL=3D/bin/sh. /lava-11182898/=
environment

    2023-08-01T10:37:51.187977  =


    2023-08-01T10:37:51.288502  / # . /lava-11182898/environment/lava-11182=
898/bin/lava-test-runner /lava-11182898/1

    2023-08-01T10:37:51.288855  =


    2023-08-01T10:37:51.294005  / # /lava-11182898/bin/lava-test-runner /la=
va-11182898/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8e1afd874ce3f138ace61

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-156-gb2c388dc24433/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baselin=
e-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-156-gb2c388dc24433/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baselin=
e-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8e1afd874ce3f138ace66
        failing since 182 days (last pass: v5.15.81-122-gc5f8d4a5d3c8, firs=
t fail: v5.15.90-205-g5605d15db022)

    2023-08-01T10:42:38.032860  + set +x
    2023-08-01T10:42:38.033122  [    9.702190] <LAVA_SIGNAL_ENDRUN 0_dmesg =
996757_1.5.2.3.1>
    2023-08-01T10:42:38.139735  / # #
    2023-08-01T10:42:38.241570  export SHELL=3D/bin/sh
    2023-08-01T10:42:38.242059  #
    2023-08-01T10:42:38.343329  / # export SHELL=3D/bin/sh. /lava-996757/en=
vironment
    2023-08-01T10:42:38.343871  =

    2023-08-01T10:42:38.445245  / # . /lava-996757/environment/lava-996757/=
bin/lava-test-runner /lava-996757/1
    2023-08-01T10:42:38.445971  =

    2023-08-01T10:42:38.448518  / # /lava-996757/bin/lava-test-runner /lava=
-996757/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8e07f690e5b4b108ace3e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-156-gb2c388dc24433/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-156-gb2c388dc24433/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8e07f690e5b4b108ace43
        failing since 125 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-01T10:37:45.992109  <8>[   12.228863] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11182937_1.4.2.3.1>

    2023-08-01T10:37:46.099276  / # #

    2023-08-01T10:37:46.201225  export SHELL=3D/bin/sh

    2023-08-01T10:37:46.201822  #

    2023-08-01T10:37:46.303102  / # export SHELL=3D/bin/sh. /lava-11182937/=
environment

    2023-08-01T10:37:46.303703  =


    2023-08-01T10:37:46.405129  / # . /lava-11182937/environment/lava-11182=
937/bin/lava-test-runner /lava-11182937/1

    2023-08-01T10:37:46.406174  =


    2023-08-01T10:37:46.410250  / # /lava-11182937/bin/lava-test-runner /la=
va-11182937/1

    2023-08-01T10:37:46.415841  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c9052877c427519f8ace22

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-156-gb2c388dc24433/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7796=
0-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-156-gb2c388dc24433/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7796=
0-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c9052877c427519f8ace27
        failing since 12 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-08-01T13:15:33.801201  / # #

    2023-08-01T13:15:33.901680  export SHELL=3D/bin/sh

    2023-08-01T13:15:33.901788  #

    2023-08-01T13:15:34.002269  / # export SHELL=3D/bin/sh. /lava-11182906/=
environment

    2023-08-01T13:15:34.002383  =


    2023-08-01T13:15:34.102887  / # . /lava-11182906/environment/lava-11182=
906/bin/lava-test-runner /lava-11182906/1

    2023-08-01T13:15:34.103079  =


    2023-08-01T13:15:34.114914  / # /lava-11182906/bin/lava-test-runner /la=
va-11182906/1

    2023-08-01T13:15:34.168308  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-01T13:15:34.168387  + cd /lav<8>[   15.973906] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11182906_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8e0ae329e8bc77e8ace36

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-156-gb2c388dc24433/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m=
1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-156-gb2c388dc24433/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m=
1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8e0ae329e8bc77e8ace3b
        failing since 12 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-08-01T10:38:35.943873  / # #

    2023-08-01T10:38:37.023422  export SHELL=3D/bin/sh

    2023-08-01T10:38:37.025348  #

    2023-08-01T10:38:38.515614  / # export SHELL=3D/bin/sh. /lava-11182902/=
environment

    2023-08-01T10:38:38.517547  =


    2023-08-01T10:38:41.241027  / # . /lava-11182902/environment/lava-11182=
902/bin/lava-test-runner /lava-11182902/1

    2023-08-01T10:38:41.243129  =


    2023-08-01T10:38:41.251135  / # /lava-11182902/bin/lava-test-runner /la=
va-11182902/1

    2023-08-01T10:38:41.315015  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-01T10:38:41.315500  + cd /lava-111829<8>[   25.522485] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11182902_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8e09495ef3151ab8ace59

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-156-gb2c388dc24433/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-=
h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23-156-gb2c388dc24433/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-=
h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8e09495ef3151ab8ace5e
        failing since 12 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-08-01T10:39:42.860070  / # #

    2023-08-01T10:39:42.962235  export SHELL=3D/bin/sh

    2023-08-01T10:39:42.962935  #

    2023-08-01T10:39:43.064344  / # export SHELL=3D/bin/sh. /lava-11182904/=
environment

    2023-08-01T10:39:43.065123  =


    2023-08-01T10:39:43.166611  / # . /lava-11182904/environment/lava-11182=
904/bin/lava-test-runner /lava-11182904/1

    2023-08-01T10:39:43.167762  =


    2023-08-01T10:39:43.169121  / # /lava-11182904/bin/lava-test-runner /la=
va-11182904/1

    2023-08-01T10:39:43.244210  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-01T10:39:43.244714  + cd /lava-1118290<8>[   16.888583] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11182904_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
