Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65731734880
	for <lists+stable@lfdr.de>; Sun, 18 Jun 2023 23:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjFRVKb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 18 Jun 2023 17:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjFRVKb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Jun 2023 17:10:31 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B1A13D
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 14:10:28 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b53e1cd0ffso7830125ad.0
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 14:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687122627; x=1689714627;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H2E4+LYyyQZ3YWy6aUwMPxjUVGf2auQS4JrSpFkVHsk=;
        b=j/V975mkgu+SbUJAHUbaONQviZuT9wBvTfri4wAZGMnDak28WUuF5RWnHJ8RzcVxow
         Q6XOwYa5eGhSIhcFhUrIOSdcUV2U70m1bHZaIyeoErhAcFiwb6MHL21+ZvAm25Lff398
         qYh3Gtz/GAkebHT4WZNDCTwzLSMYFMwKA0fwxHIsGFC7UVdrLAb2RfZic9b5aoDo4WV6
         1fXCMzPcchw/0Gf8WyNR2/h18nNsGmplCs3p8Vhe+Xj1UXWNiSw+pyBcmyLdcn66rfPb
         BNPuPozJ66zS2QXluX4ITm40NTlYOJSjtFLxd2jRfKmT8gfxORcmaYn0IEyWMPHR6bvi
         7dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687122627; x=1689714627;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H2E4+LYyyQZ3YWy6aUwMPxjUVGf2auQS4JrSpFkVHsk=;
        b=f9rCMAPKorBrVXgRhBri5+geSvnYNlkqPpABt4MMhum3rytI2NPlqO1U7sMhM3yWda
         MlxfK4TxYcn0l0jBC+J1Rzej80l9pdnJNL5yUn5fwBfwq4O4t00/jFqFF/eZ5tunp4vo
         /ZE/g27vUTsq3v0kzxEtrQkV19VcB24R0h9Cq/912QQmuh+0qf3wrWIV3zWLkE2y7s45
         j38IxC0/+hXe+H6Dy+9eMvz5MhCs+0oF/w2o4Hkx/tiH3DQsbsH8U8Y6VafaV9ymRsE7
         FjadySnmK6XiMCqaJTUH+8ucgfunA2BiGpPTzYjjCafrn/JrO3F6b/cQiP43yusruLk2
         jPwA==
X-Gm-Message-State: AC+VfDydjYmPZS5dEMuc9RUNme/tQmyk/GcS21dc8VmerfJ6OWAlHioZ
        QGJnqMExfuvtBZmCBxrnoOz63HQbtt0fsDtnj3mSUm+e
X-Google-Smtp-Source: ACHHUZ7VxcmROr0b+5/WDXbWM2cqEZQyyVV0L9iCDAR50C8jwbedKB1Hg9mRVysLd9TNEjxWW0UWOA==
X-Received: by 2002:a17:903:2348:b0:1ac:921c:87fc with SMTP id c8-20020a170903234800b001ac921c87fcmr7425667plh.32.1687122626415;
        Sun, 18 Jun 2023 14:10:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jg18-20020a17090326d200b001b3d27a7820sm6568224plb.234.2023.06.18.14.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 14:10:25 -0700 (PDT)
Message-ID: <648f72c1.170a0220.a2dba.cf36@mx.google.com>
Date:   Sun, 18 Jun 2023 14:10:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.117-100-g2fe36c0c7a9d
Subject: stable-rc/linux-5.15.y baseline: 168 runs,
 18 regressions (v5.15.117-100-g2fe36c0c7a9d)
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

stable-rc/linux-5.15.y baseline: 168 runs, 18 regressions (v5.15.117-100-g2=
fe36c0c7a9d)

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
nel/v5.15.117-100-g2fe36c0c7a9d/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.117-100-g2fe36c0c7a9d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      2fe36c0c7a9d53fb086d4f005193cd6c4bb030e7 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648f3d7e7cf99f314530613b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-100-g2fe36c0c7a9d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-100-g2fe36c0c7a9d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f3d7e7cf99f3145306140
        failing since 81 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-18T17:22:54.537495  <8>[   11.461795] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10796148_1.4.2.3.1>

    2023-06-18T17:22:54.540690  + set +x

    2023-06-18T17:22:54.644926  / # #

    2023-06-18T17:22:54.745575  export SHELL=3D/bin/sh

    2023-06-18T17:22:54.745814  #

    2023-06-18T17:22:54.846357  / # export SHELL=3D/bin/sh. /lava-10796148/=
environment

    2023-06-18T17:22:54.846552  =


    2023-06-18T17:22:54.947112  / # . /lava-10796148/environment/lava-10796=
148/bin/lava-test-runner /lava-10796148/1

    2023-06-18T17:22:54.947400  =


    2023-06-18T17:22:54.952991  / # /lava-10796148/bin/lava-test-runner /la=
va-10796148/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648f3d87187a8d970430612e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-100-g2fe36c0c7a9d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-100-g2fe36c0c7a9d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f3d87187a8d9704306133
        failing since 81 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-18T17:22:54.371784  + <8>[   11.539151] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10796195_1.4.2.3.1>

    2023-06-18T17:22:54.371894  set +x

    2023-06-18T17:22:54.476135  / # #

    2023-06-18T17:22:54.576881  export SHELL=3D/bin/sh

    2023-06-18T17:22:54.577128  #

    2023-06-18T17:22:54.677719  / # export SHELL=3D/bin/sh. /lava-10796195/=
environment

    2023-06-18T17:22:54.677898  =


    2023-06-18T17:22:54.778409  / # . /lava-10796195/environment/lava-10796=
195/bin/lava-test-runner /lava-10796195/1

    2023-06-18T17:22:54.778675  =


    2023-06-18T17:22:54.783208  / # /lava-10796195/bin/lava-test-runner /la=
va-10796195/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648f3d6f736f51f8c0306132

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-100-g2fe36c0c7a9d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-100-g2fe36c0c7a9d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f3d6f736f51f8c0306137
        failing since 81 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-18T17:23:03.660095  <8>[   10.690314] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10796167_1.4.2.3.1>

    2023-06-18T17:23:03.663895  + set +x

    2023-06-18T17:23:03.769506  =


    2023-06-18T17:23:03.871328  / # #export SHELL=3D/bin/sh

    2023-06-18T17:23:03.872069  =


    2023-06-18T17:23:03.973382  / # export SHELL=3D/bin/sh. /lava-10796167/=
environment

    2023-06-18T17:23:03.973685  =


    2023-06-18T17:23:04.074482  / # . /lava-10796167/environment/lava-10796=
167/bin/lava-test-runner /lava-10796167/1

    2023-06-18T17:23:04.075581  =


    2023-06-18T17:23:04.080627  / # /lava-10796167/bin/lava-test-runner /la=
va-10796167/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/648f3ee494a9ac6bdf30613b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-100-g2fe36c0c7a9d/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-100-g2fe36c0c7a9d/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648f3ee494a9ac6bdf306=
13c
        failing since 402 days (last pass: v5.15.37-259-gab77581473a3, firs=
t fail: v5.15.39) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648f3d949541729cbf30612f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-100-g2fe36c0c7a9d/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-100-g2fe36c0c7a9d/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f3d949541729cbf306134
        failing since 152 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-06-18T17:23:04.728984  <8>[    9.982306] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3673414_1.5.2.4.1>
    2023-06-18T17:23:04.838947  / # #
    2023-06-18T17:23:04.941126  export SHELL=3D/bin/sh
    2023-06-18T17:23:04.941899  #
    2023-06-18T17:23:05.043960  / # export SHELL=3D/bin/sh. /lava-3673414/e=
nvironment
    2023-06-18T17:23:05.044355  =

    2023-06-18T17:23:05.145817  / # . /lava-3673414/environment/lava-367341=
4/bin/lava-test-runner /lava-3673414/1
    2023-06-18T17:23:05.146692  =

    2023-06-18T17:23:05.151336  / # /lava-3673414/bin/lava-test-runner /lav=
a-3673414/1
    2023-06-18T17:23:05.178446  <3>[   10.433514] Bluetooth: hci0: command =
0x0c03 tx timeout =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648f3d75736f51f8c0306173

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-100-g2fe36c0c7a9d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-100-g2fe36c0c7a9d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f3d75736f51f8c0306178
        failing since 81 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-18T17:22:49.926106  + <8>[   10.637127] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10796173_1.4.2.3.1>

    2023-06-18T17:22:49.926210  set +x

    2023-06-18T17:22:50.027591  #

    2023-06-18T17:22:50.027929  =


    2023-06-18T17:22:50.128603  / # #export SHELL=3D/bin/sh

    2023-06-18T17:22:50.128836  =


    2023-06-18T17:22:50.229392  / # export SHELL=3D/bin/sh. /lava-10796173/=
environment

    2023-06-18T17:22:50.229619  =


    2023-06-18T17:22:50.330177  / # . /lava-10796173/environment/lava-10796=
173/bin/lava-test-runner /lava-10796173/1

    2023-06-18T17:22:50.330513  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648f3d74736f51f8c0306168

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-100-g2fe36c0c7a9d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-100-g2fe36c0c7a9d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f3d74736f51f8c030616d
        failing since 81 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-18T17:22:49.006132  + set<8>[   10.491554] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10796145_1.4.2.3.1>

    2023-06-18T17:22:49.006597   +x

    2023-06-18T17:22:49.111200  / #

    2023-06-18T17:22:49.213816  # #export SHELL=3D/bin/sh

    2023-06-18T17:22:49.214636  =


    2023-06-18T17:22:49.316113  / # export SHELL=3D/bin/sh. /lava-10796145/=
environment

    2023-06-18T17:22:49.316820  =


    2023-06-18T17:22:49.418253  / # . /lava-10796145/environment/lava-10796=
145/bin/lava-test-runner /lava-10796145/1

    2023-06-18T17:22:49.419370  =


    2023-06-18T17:22:49.425174  / # /lava-10796145/bin/lava-test-runner /la=
va-10796145/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648f3d89a46fd7aa5830612e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-100-g2fe36c0c7a9d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-100-g2fe36c0c7a9d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f3d89a46fd7aa58306133
        failing since 81 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-18T17:22:53.317940  + set<8>[   11.260680] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10796205_1.4.2.3.1>

    2023-06-18T17:22:53.318488   +x

    2023-06-18T17:22:53.427796  / # #

    2023-06-18T17:22:53.530355  export SHELL=3D/bin/sh

    2023-06-18T17:22:53.531192  #

    2023-06-18T17:22:53.632764  / # export SHELL=3D/bin/sh. /lava-10796205/=
environment

    2023-06-18T17:22:53.633628  =


    2023-06-18T17:22:53.735254  / # . /lava-10796205/environment/lava-10796=
205/bin/lava-test-runner /lava-10796205/1

    2023-06-18T17:22:53.736499  =


    2023-06-18T17:22:53.741399  / # /lava-10796205/bin/lava-test-runner /la=
va-10796205/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648f3cb2208dd32df530613c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-100-g2fe36c0c7a9d/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline=
-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-100-g2fe36c0c7a9d/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline=
-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f3cb2208dd32df5306141
        failing since 139 days (last pass: v5.15.81-122-gc5f8d4a5d3c8, firs=
t fail: v5.15.90-205-g5605d15db022)

    2023-06-18T17:19:39.517686  + set +x
    2023-06-18T17:19:39.517864  [    9.463888] <LAVA_SIGNAL_ENDRUN 0_dmesg =
980506_1.5.2.3.1>
    2023-06-18T17:19:39.624993  / # #
    2023-06-18T17:19:39.726453  export SHELL=3D/bin/sh
    2023-06-18T17:19:39.726869  #
    2023-06-18T17:19:39.828297  / # export SHELL=3D/bin/sh. /lava-980506/en=
vironment
    2023-06-18T17:19:39.828769  =

    2023-06-18T17:19:39.930152  / # . /lava-980506/environment/lava-980506/=
bin/lava-test-runner /lava-980506/1
    2023-06-18T17:19:39.930865  =

    2023-06-18T17:19:39.933115  / # /lava-980506/bin/lava-test-runner /lava=
-980506/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648f3d7538dd9e2caa306191

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-100-g2fe36c0c7a9d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-100-g2fe36c0c7a9d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f3d7538dd9e2caa306196
        failing since 81 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-18T17:22:52.147075  + set<8>[   12.610378] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10796188_1.4.2.3.1>

    2023-06-18T17:22:52.147164   +x

    2023-06-18T17:22:52.251473  / # #

    2023-06-18T17:22:52.353287  export SHELL=3D/bin/sh

    2023-06-18T17:22:52.353465  #

    2023-06-18T17:22:52.453984  / # export SHELL=3D/bin/sh. /lava-10796188/=
environment

    2023-06-18T17:22:52.454175  =


    2023-06-18T17:22:52.554793  / # . /lava-10796188/environment/lava-10796=
188/bin/lava-test-runner /lava-10796188/1

    2023-06-18T17:22:52.555030  =


    2023-06-18T17:22:52.559941  / # /lava-10796188/bin/lava-test-runner /la=
va-10796188/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 4          =


  Details:     https://kernelci.org/test/plan/id/648f40a41e3605fc9c3061b8

  Results:     153 PASS, 14 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-100-g2fe36c0c7a9d/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/=
baseline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-100-g2fe36c0c7a9d/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/=
baseline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/648f40a41e3605fc9c3061d2
        failing since 34 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-18T17:36:39.848322  /lava-10796516/1/../bin/lava-test-case

    2023-06-18T17:36:39.854744  <8>[   32.172500] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/648f40a41e3605fc9c3061d2
        failing since 34 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-18T17:36:39.848322  /lava-10796516/1/../bin/lava-test-case

    2023-06-18T17:36:39.854744  <8>[   32.172500] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/648f40a41e3605fc9c3061d4
        failing since 34 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-18T17:36:38.809540  /lava-10796516/1/../bin/lava-test-case

    2023-06-18T17:36:38.816264  <8>[   31.133290] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f40a41e3605fc9c30625c
        failing since 34 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-18T17:36:24.645471  <8>[   16.965594] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10796516_1.5.2.3.1>

    2023-06-18T17:36:24.648778  + set +x

    2023-06-18T17:36:24.755825  / # #

    2023-06-18T17:36:24.857942  export SHELL=3D/bin/sh

    2023-06-18T17:36:24.858657  #

    2023-06-18T17:36:24.960115  / # export SHELL=3D/bin/sh. /lava-10796516/=
environment

    2023-06-18T17:36:24.960892  =


    2023-06-18T17:36:25.062403  / # . /lava-10796516/environment/lava-10796=
516/bin/lava-test-runner /lava-10796516/1

    2023-06-18T17:36:25.063489  =


    2023-06-18T17:36:25.068123  / # /lava-10796516/bin/lava-test-runner /la=
va-10796516/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3328-rock64                | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648f41ccb66d4f22dd306181

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-100-g2fe36c0c7a9d/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-ro=
ck64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-100-g2fe36c0c7a9d/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-ro=
ck64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f41ccb66d4f22dd306186
        failing since 10 days (last pass: v5.15.72-38-gebe70cd7f5413, first=
 fail: v5.15.114-196-g00621f2608ac)

    2023-06-18T17:41:18.097667  [   16.034552] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3673605_1.5.2.4.1>
    2023-06-18T17:41:18.202423  =

    2023-06-18T17:41:18.202668  / # #[   16.095430] rockchip-drm display-su=
bsystem: [drm] Cannot find any crtc or sizes
    2023-06-18T17:41:18.304075  export SHELL=3D/bin/sh
    2023-06-18T17:41:18.304553  =

    2023-06-18T17:41:18.405969  / # export SHELL=3D/bin/sh. /lava-3673605/e=
nvironment
    2023-06-18T17:41:18.406459  =

    2023-06-18T17:41:18.507831  / # . /lava-3673605/environment/lava-367360=
5/bin/lava-test-runner /lava-3673605/1
    2023-06-18T17:41:18.508621  =

    2023-06-18T17:41:18.512032  / # /lava-3673605/bin/lava-test-runner /lav=
a-3673605/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648f430cda5851978f30613a

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-100-g2fe36c0c7a9d/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a6=
4-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-100-g2fe36c0c7a9d/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a6=
4-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f430cda5851978f306166
        failing since 152 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-06-18T17:46:31.444797  + set +x
    2023-06-18T17:46:31.448031  <8>[   16.013201] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3673602_1.5.2.4.1>
    2023-06-18T17:46:31.569923  / # #
    2023-06-18T17:46:31.675624  export SHELL=3D/bin/sh
    2023-06-18T17:46:31.677223  #
    2023-06-18T17:46:31.780551  / # export SHELL=3D/bin/sh. /lava-3673602/e=
nvironment
    2023-06-18T17:46:31.782054  =

    2023-06-18T17:46:31.885536  / # . /lava-3673602/environment/lava-367360=
2/bin/lava-test-runner /lava-3673602/1
    2023-06-18T17:46:31.888185  =

    2023-06-18T17:46:31.892083  / # /lava-3673602/bin/lava-test-runner /lav=
a-3673602/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648f421f85ad38326730619e

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-100-g2fe36c0c7a9d/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64=
-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-100-g2fe36c0c7a9d/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64=
-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f421f85ad3832673061c9
        failing since 152 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-06-18T17:42:42.252563  + set +x
    2023-06-18T17:42:42.256585  <8>[   16.057294] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 627112_1.5.2.4.1>
    2023-06-18T17:42:42.366610  / # #
    2023-06-18T17:42:42.468932  export SHELL=3D/bin/sh
    2023-06-18T17:42:42.469489  #
    2023-06-18T17:42:42.571163  / # export SHELL=3D/bin/sh. /lava-627112/en=
vironment
    2023-06-18T17:42:42.571948  =

    2023-06-18T17:42:42.673544  / # . /lava-627112/environment/lava-627112/=
bin/lava-test-runner /lava-627112/1
    2023-06-18T17:42:42.675022  =

    2023-06-18T17:42:42.677507  / # /lava-627112/bin/lava-test-runner /lava=
-627112/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/648f3aa7148bc9d324306165

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-100-g2fe36c0c7a9d/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i=
-h2-plus-orangepi-r1.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-100-g2fe36c0c7a9d/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i=
-h2-plus-orangepi-r1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f3aa7148bc9d32430616a
        failing since 66 days (last pass: v5.15.82-124-g2b8b2c150867, first=
 fail: v5.15.105-194-g415a9d81c640)

    2023-06-18T17:10:41.426103  / # #
    2023-06-18T17:10:41.531640  export SHELL=3D/bin/sh
    2023-06-18T17:10:41.533152  #
    2023-06-18T17:10:41.636532  / # export SHELL=3D/bin/sh. /lava-3673375/e=
nvironment
    2023-06-18T17:10:41.638069  =

    2023-06-18T17:10:41.741984  / # . /lava-3673375/environment/lava-367337=
5/bin/lava-test-runner /lava-3673375/1
    2023-06-18T17:10:41.744870  =

    2023-06-18T17:10:41.750435  / # /lava-3673375/bin/lava-test-runner /lav=
a-3673375/1
    2023-06-18T17:10:41.889120  + export 'TESTRUN_ID=3D1_bootrr'
    2023-06-18T17:10:41.890155  + cd /lava-3673375/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
