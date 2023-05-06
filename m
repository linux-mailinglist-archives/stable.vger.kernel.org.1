Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E1D6F91C3
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 13:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjEFL5f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 07:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjEFL5e (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 07:57:34 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7E57EDA
        for <stable@vger.kernel.org>; Sat,  6 May 2023 04:57:32 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-24dec03ad8fso1998444a91.1
        for <stable@vger.kernel.org>; Sat, 06 May 2023 04:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683374252; x=1685966252;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9US7IHGlUNdzPdN5rq8SDQYn1ohM3tpCHNbnPAZJGjg=;
        b=wRqsHaRONbUcVmjbTBRKguZx8/oJmELUeQ157S5+SBzNnJnf/cYtbacxMvdNI4W/Vv
         y6nWiWLkXsHfd/Uyfd6CjbBeY80nhn+qc10Ygw/ogJ/5eCyo1osDdW57Dn6iVC/VNqxE
         AQl3r6wFbYyP3VOCrHImoi8dApbaHHjqtE256gBVOVd4Nm9NBadAY1KTNVrzJnC9D/qM
         ahq7veJ1dCaUlSJgSuS1CqxRpF4AEqg5GQE8AxiJi+eQs7Zzevtrb5cGZSC7oJ+zMpdC
         mK00k0uv2zf0FjMViyJmqcz2wwWEtC1v+Hz56QA09rCDlD7YwgBJBkO4HvoUIehS1yzE
         85ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683374252; x=1685966252;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9US7IHGlUNdzPdN5rq8SDQYn1ohM3tpCHNbnPAZJGjg=;
        b=azOc5OudwybgNOFzCBh+w/MlSDyuSlnyFV4cshzxLKLKLYLJBafcFABQbjZXJxaHSD
         khJSn3tBy6x1mUczUKCGFUC8EZf1drf6AFS0MLrgTYHWnXaltWR4DhRlVJZ92y5RHHyn
         mwRw9Cz0KREUZnECNcva2auSVgAHlHOONP8bTnlAs3/nMTcloMNQ2/izXuRSy9Cb/DqZ
         NV8dO3XJY0G5tycGrWZ9mhW+BzRFXHIN6LgLxVA2gR0gJRQANLLtxbIJboctVw8Gx0ct
         +XhcfggtvSxkrV8T9/zlZFb6T/GMaAOYSSQHjU4r0INHKgxXOUNudUQeH43fTc2KNYbR
         zjSQ==
X-Gm-Message-State: AC+VfDxtJQTuv2KRAZx4TrXaZl8NjbQHa4vaPL1G6FcSsVh9V98WvdsD
        znB3GDDnqufbsA9VfGvsubbyJY7ezcL8ARHhly2Ndw==
X-Google-Smtp-Source: ACHHUZ7YS0r2AjHYiA3bRsR7FKAvy1p3x7ET6g3Sz0GyD+GLLoASvKVQ7btpZbbxUtgOowK9P7jrIg==
X-Received: by 2002:a17:90a:d17:b0:24e:1b9:8292 with SMTP id t23-20020a17090a0d1700b0024e01b98292mr3966208pja.48.1683374251634;
        Sat, 06 May 2023 04:57:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id fs9-20020a17090af28900b002470f179b92sm6503710pjb.43.2023.05.06.04.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 04:57:30 -0700 (PDT)
Message-ID: <645640aa.170a0220.e035a.d7f8@mx.google.com>
Date:   Sat, 06 May 2023 04:57:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.176-414-g115099cfacde
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 161 runs,
 7 regressions (v5.10.176-414-g115099cfacde)
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

stable-rc/queue/5.10 baseline: 161 runs, 7 regressions (v5.10.176-414-g1150=
99cfacde)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

meson-gxbb-p200              | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.176-414-g115099cfacde/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.176-414-g115099cfacde
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      115099cfacde6461fe7fb2b1bf4e5c74cef4ef13 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64560ec1259c575d522e85e6

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-414-g115099cfacde/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-414-g115099cfacde/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64560ec1259c575d522e861a
        failing since 81 days (last pass: v5.10.167-127-g921934d621e4, firs=
t fail: v5.10.167-139-gf9519a5a1701)

    2023-05-06T08:24:14.358290  <8>[   19.560906] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 417478_1.5.2.4.1>
    2023-05-06T08:24:14.468828  / # #
    2023-05-06T08:24:14.571185  export SHELL=3D/bin/sh
    2023-05-06T08:24:14.571655  #
    2023-05-06T08:24:14.673355  / # export SHELL=3D/bin/sh. /lava-417478/en=
vironment
    2023-05-06T08:24:14.673928  =

    2023-05-06T08:24:14.775726  / # . /lava-417478/environment/lava-417478/=
bin/lava-test-runner /lava-417478/1
    2023-05-06T08:24:14.776768  =

    2023-05-06T08:24:14.780425  / # /lava-417478/bin/lava-test-runner /lava=
-417478/1
    2023-05-06T08:24:14.877571  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64560c11c33edb050a2e861b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-414-g115099cfacde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-414-g115099cfacde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64560c11c33edb050a2e8620
        failing since 36 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-06T08:12:53.418108  + <8>[   10.778452] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10214094_1.4.2.3.1>

    2023-05-06T08:12:53.418221  set +x

    2023-05-06T08:12:53.520726  =


    2023-05-06T08:12:53.621393  / # #export SHELL=3D/bin/sh

    2023-05-06T08:12:53.621580  =


    2023-05-06T08:12:53.722089  / # export SHELL=3D/bin/sh. /lava-10214094/=
environment

    2023-05-06T08:12:53.722284  =


    2023-05-06T08:12:53.822831  / # . /lava-10214094/environment/lava-10214=
094/bin/lava-test-runner /lava-10214094/1

    2023-05-06T08:12:53.823122  =


    2023-05-06T08:12:53.827656  / # /lava-10214094/bin/lava-test-runner /la=
va-10214094/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64560c18bb2664d9112e863e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-414-g115099cfacde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-414-g115099cfacde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64560c18bb2664d9112e8643
        failing since 36 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-06T08:12:54.078434  <8>[   11.804656] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10214130_1.4.2.3.1>

    2023-05-06T08:12:54.081569  + set +x

    2023-05-06T08:12:54.186522  #

    2023-05-06T08:12:54.187903  =


    2023-05-06T08:12:54.289865  / # #export SHELL=3D/bin/sh

    2023-05-06T08:12:54.290624  =


    2023-05-06T08:12:54.392018  / # export SHELL=3D/bin/sh. /lava-10214130/=
environment

    2023-05-06T08:12:54.392808  =


    2023-05-06T08:12:54.494388  / # . /lava-10214130/environment/lava-10214=
130/bin/lava-test-runner /lava-10214130/1

    2023-05-06T08:12:54.494725  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxbb-p200              | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64561051851f709eaa2e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-414-g115099cfacde/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-=
p200.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-414-g115099cfacde/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-=
p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64561051851f709eaa2e8=
5e7
        new failure (last pass: v5.10.176-378-gf09e1800957b) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6456100229831b58882e85fb

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-414-g115099cfacde/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-414-g115099cfacde/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6456100229831b58882e8601
        failing since 53 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-06T08:29:31.710657  /lava-10214231/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6456100229831b58882e8602
        failing since 53 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-06T08:29:30.673553  /lava-10214231/1/../bin/lava-test-case

    2023-05-06T08:29:30.684262  <8>[   61.005475] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64560dba4be91bf95d2e8609

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-414-g115099cfacde/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-414-g115099cfacde/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64560dba4be91bf95d2e860e
        failing since 93 days (last pass: v5.10.165-139-gefb57ce0f880, firs=
t fail: v5.10.165-149-ge30e8271d674)

    2023-05-06T08:19:40.862236  / # #
    2023-05-06T08:19:40.964018  export SHELL=3D/bin/sh
    2023-05-06T08:19:40.964576  #
    2023-05-06T08:19:41.065946  / # export SHELL=3D/bin/sh. /lava-3555748/e=
nvironment
    2023-05-06T08:19:41.066376  =

    2023-05-06T08:19:41.167773  / # . /lava-3555748/environment/lava-355574=
8/bin/lava-test-runner /lava-3555748/1
    2023-05-06T08:19:41.168392  =

    2023-05-06T08:19:41.172101  / # /lava-3555748/bin/lava-test-runner /lav=
a-3555748/1
    2023-05-06T08:19:41.236187  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-06T08:19:41.283928  + cd /lava-3555748/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
