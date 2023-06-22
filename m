Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1550273A1D3
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 15:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjFVNXJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 09:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjFVNXI (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 09:23:08 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD8C198
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 06:23:06 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-25e83a63143so5241679a91.3
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 06:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687440185; x=1690032185;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L/aKjCv3XwspZp9J+X62Gm+FB9pCCesqaDhJGbnCQq0=;
        b=mpJoYjZh6bYFKMjQTKBkriFcUCdByfNvjXt1m9SlqyIhGkLbRm0FVWV8GFtqHLA+D7
         kcJ9GcJljlhb8Fc9htBWIq5irCyqmHpsiGNlYaGXOr7iPWiea3dSbtYns8h7C7Pnczbo
         Xe1C/PWRsRB1nTAPflKGF2TUVgkvNpwz3ahdqBx/7CJ9pU1wTQP4L4vqPxCVMDUoPEV8
         3Wcn2zRije+su2VEUrwFmJiCtQRXj3kCP0gkZnZLBZUFhq2NfpJaojUVS6KCZRHUIGJ4
         610dPnEv6oHtb4sCxqT1FW82+yTRBVEu07ZmktT8Fj4p8BUpniS6uP02oahXR2qr9esz
         DhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687440185; x=1690032185;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L/aKjCv3XwspZp9J+X62Gm+FB9pCCesqaDhJGbnCQq0=;
        b=WR3Jcw7EIVXDvmw2TmGqSQ3syvHrFN5e6cEQDujf1QXkTxCf4TUeYUEofgAhaN2eD1
         ReFGz9z4VLusX6SMrGdLgWMRf7y1Hbk3/1Bw1URhBGkB7oeCpOAff2Tl8PUY98+HsV7m
         L69IfXTWNIAXb3X0GXmm9GuA2u7JiN/Acyqvkz2a3HgsYk0J3bIE9OXUzmbywiKrDpp2
         FO9gAloQaeCUd1Zt4tvgTkKusDn2ET1oWGjKRqO/edgWQzebOKBCuap7DNJPPdsc44R9
         8ttYkkVNIC8HkqOCaWgvOkFyfCtIFA3WV9CgNuEZyqHTu608tWooPnV4tRCuXd46DUnm
         z0cw==
X-Gm-Message-State: AC+VfDztMnbkHCVH81I97F/AgLeu+jG5XRUxjA2joiJ6sQpHYHvi1KH0
        JnkzrgfEYxY48HT8kQAW7RmHmA0TgKjoDhauGYXUHQ==
X-Google-Smtp-Source: ACHHUZ51eNzj7zBGY3ezaTcJbSmQ4CzccrlXO0vn4pYjDmNnDTnbQ4A9l3pJkhffbYMSamepPIZOGg==
X-Received: by 2002:a17:90a:d811:b0:256:87f4:432a with SMTP id a17-20020a17090ad81100b0025687f4432amr17824816pjv.18.1687440184618;
        Thu, 22 Jun 2023 06:23:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 12-20020a17090a194c00b0025ef39c0f87sm5236183pjh.0.2023.06.22.06.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 06:23:04 -0700 (PDT)
Message-ID: <64944b38.170a0220.ad509.ba70@mx.google.com>
Date:   Thu, 22 Jun 2023 06:23:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.118-11-gd2efde0d1c2ee
Subject: stable-rc/linux-5.15.y baseline: 122 runs,
 14 regressions (v5.15.118-11-gd2efde0d1c2ee)
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

stable-rc/linux-5.15.y baseline: 122 runs, 14 regressions (v5.15.118-11-gd2=
efde0d1c2ee)

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


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.118-11-gd2efde0d1c2ee/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.118-11-gd2efde0d1c2ee
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      d2efde0d1c2ee9b3d2865da7c8a670475c4bb9df =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64941439728e4ad79030617b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18-11-gd2efde0d1c2ee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18-11-gd2efde0d1c2ee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64941439728e4ad790306184
        failing since 85 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-22T09:28:04.731396  <8>[   11.081666] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10858061_1.4.2.3.1>

    2023-06-22T09:28:04.734511  + set +x

    2023-06-22T09:28:04.835848  =


    2023-06-22T09:28:04.936372  / # #export SHELL=3D/bin/sh

    2023-06-22T09:28:04.936577  =


    2023-06-22T09:28:05.037130  / # export SHELL=3D/bin/sh. /lava-10858061/=
environment

    2023-06-22T09:28:05.037343  =


    2023-06-22T09:28:05.137861  / # . /lava-10858061/environment/lava-10858=
061/bin/lava-test-runner /lava-10858061/1

    2023-06-22T09:28:05.138193  =


    2023-06-22T09:28:05.143736  / # /lava-10858061/bin/lava-test-runner /la=
va-10858061/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6494143e728e4ad79030619c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18-11-gd2efde0d1c2ee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18-11-gd2efde0d1c2ee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6494143e728e4ad7903061a5
        failing since 85 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-22T09:28:25.314192  + set<8>[    8.884801] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10858017_1.4.2.3.1>

    2023-06-22T09:28:25.314284   +x

    2023-06-22T09:28:25.418863  / # #

    2023-06-22T09:28:25.519496  export SHELL=3D/bin/sh

    2023-06-22T09:28:25.519675  #

    2023-06-22T09:28:25.620218  / # export SHELL=3D/bin/sh. /lava-10858017/=
environment

    2023-06-22T09:28:25.620403  =


    2023-06-22T09:28:25.720927  / # . /lava-10858017/environment/lava-10858=
017/bin/lava-test-runner /lava-10858017/1

    2023-06-22T09:28:25.721308  =


    2023-06-22T09:28:25.726489  / # /lava-10858017/bin/lava-test-runner /la=
va-10858017/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6494143f2130ddb6e630612e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18-11-gd2efde0d1c2ee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18-11-gd2efde0d1c2ee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6494143f2130ddb6e6306137
        failing since 85 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-22T09:28:08.922947  <8>[   10.625868] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10858054_1.4.2.3.1>

    2023-06-22T09:28:08.926521  + set +x

    2023-06-22T09:28:09.027840  #

    2023-06-22T09:28:09.028134  =


    2023-06-22T09:28:09.128745  / # #export SHELL=3D/bin/sh

    2023-06-22T09:28:09.128958  =


    2023-06-22T09:28:09.229455  / # export SHELL=3D/bin/sh. /lava-10858054/=
environment

    2023-06-22T09:28:09.229674  =


    2023-06-22T09:28:09.330283  / # . /lava-10858054/environment/lava-10858=
054/bin/lava-test-runner /lava-10858054/1

    2023-06-22T09:28:09.330560  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/649412af11402e4cdb306179

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18-11-gd2efde0d1c2ee/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18-11-gd2efde0d1c2ee/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649412af11402e4cdb306=
17a
        failing since 405 days (last pass: v5.15.37-259-gab77581473a3, firs=
t fail: v5.15.39) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6494131de2dffce51f306134

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18-11-gd2efde0d1c2ee/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18-11-gd2efde0d1c2ee/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6494131de2dffce51f30613d
        failing since 156 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-06-22T09:23:13.156028  + set +x<8>[   10.023011] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3686692_1.5.2.4.1>
    2023-06-22T09:23:13.156344  =

    2023-06-22T09:23:13.263145  / # #
    2023-06-22T09:23:13.364851  export SHELL=3D/bin/sh
    2023-06-22T09:23:13.365300  #
    2023-06-22T09:23:13.466501  / # export SHELL=3D/bin/sh. /lava-3686692/e=
nvironment
    2023-06-22T09:23:13.467054  =

    2023-06-22T09:23:13.568442  / # . /lava-3686692/environment/lava-368669=
2/bin/lava-test-runner /lava-3686692/1
    2023-06-22T09:23:13.569090  =

    2023-06-22T09:23:13.573940  / # /lava-3686692/bin/lava-test-runner /lav=
a-3686692/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6494147ce905cd407130615e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18-11-gd2efde0d1c2ee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18-11-gd2efde0d1c2ee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6494147ce905cd4071306167
        failing since 85 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-22T09:29:29.570847  + set +x

    2023-06-22T09:29:29.577486  <8>[   10.782655] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10858045_1.4.2.3.1>

    2023-06-22T09:29:29.685064  / # #

    2023-06-22T09:29:29.787117  export SHELL=3D/bin/sh

    2023-06-22T09:29:29.787900  #

    2023-06-22T09:29:29.889310  / # export SHELL=3D/bin/sh. /lava-10858045/=
environment

    2023-06-22T09:29:29.890109  =


    2023-06-22T09:29:29.991478  / # . /lava-10858045/environment/lava-10858=
045/bin/lava-test-runner /lava-10858045/1

    2023-06-22T09:29:29.992513  =


    2023-06-22T09:29:29.996909  / # /lava-10858045/bin/lava-test-runner /la=
va-10858045/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6494142c245ccfb0ba30615e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18-11-gd2efde0d1c2ee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18-11-gd2efde0d1c2ee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6494142c245ccfb0ba306167
        failing since 85 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-22T09:27:55.441590  <8>[   10.083833] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10858010_1.4.2.3.1>

    2023-06-22T09:27:55.444668  + set +x

    2023-06-22T09:27:55.546124  #

    2023-06-22T09:27:55.546479  =


    2023-06-22T09:27:55.647098  / # #export SHELL=3D/bin/sh

    2023-06-22T09:27:55.647378  =


    2023-06-22T09:27:55.747907  / # export SHELL=3D/bin/sh. /lava-10858010/=
environment

    2023-06-22T09:27:55.748104  =


    2023-06-22T09:27:55.848662  / # . /lava-10858010/environment/lava-10858=
010/bin/lava-test-runner /lava-10858010/1

    2023-06-22T09:27:55.848939  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64941434728e4ad790306150

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18-11-gd2efde0d1c2ee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18-11-gd2efde0d1c2ee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64941434728e4ad790306159
        failing since 85 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-22T09:27:59.081571  + set<8>[   10.649253] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10858046_1.4.2.3.1>

    2023-06-22T09:27:59.082003   +x

    2023-06-22T09:27:59.189407  / # #

    2023-06-22T09:27:59.290074  export SHELL=3D/bin/sh

    2023-06-22T09:27:59.290719  #

    2023-06-22T09:27:59.392212  / # export SHELL=3D/bin/sh. /lava-10858046/=
environment

    2023-06-22T09:27:59.392940  =


    2023-06-22T09:27:59.494528  / # . /lava-10858046/environment/lava-10858=
046/bin/lava-test-runner /lava-10858046/1

    2023-06-22T09:27:59.495836  =


    2023-06-22T09:27:59.500872  / # /lava-10858046/bin/lava-test-runner /la=
va-10858046/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/649412c1b86f12de6730613e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18-11-gd2efde0d1c2ee/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline=
-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18-11-gd2efde0d1c2ee/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline=
-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649412c1b86f12de67306147
        failing since 142 days (last pass: v5.15.81-122-gc5f8d4a5d3c8, firs=
t fail: v5.15.90-205-g5605d15db022)

    2023-06-22T09:22:00.919767  + set +x
    2023-06-22T09:22:00.919966  [    9.472523] <LAVA_SIGNAL_ENDRUN 0_dmesg =
985065_1.5.2.3.1>
    2023-06-22T09:22:01.027302  / # #
    2023-06-22T09:22:01.128980  export SHELL=3D/bin/sh
    2023-06-22T09:22:01.129464  #
    2023-06-22T09:22:01.230772  / # export SHELL=3D/bin/sh. /lava-985065/en=
vironment
    2023-06-22T09:22:01.231432  =

    2023-06-22T09:22:01.332792  / # . /lava-985065/environment/lava-985065/=
bin/lava-test-runner /lava-985065/1
    2023-06-22T09:22:01.333457  =

    2023-06-22T09:22:01.336209  / # /lava-985065/bin/lava-test-runner /lava=
-985065/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64941438728e4ad79030616d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18-11-gd2efde0d1c2ee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18-11-gd2efde0d1c2ee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64941438728e4ad790306176
        failing since 85 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-22T09:28:02.074904  <8>[   10.919809] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10858052_1.4.2.3.1>

    2023-06-22T09:28:02.179495  / # #

    2023-06-22T09:28:02.280096  export SHELL=3D/bin/sh

    2023-06-22T09:28:02.280292  #

    2023-06-22T09:28:02.380812  / # export SHELL=3D/bin/sh. /lava-10858052/=
environment

    2023-06-22T09:28:02.380981  =


    2023-06-22T09:28:02.481534  / # . /lava-10858052/environment/lava-10858=
052/bin/lava-test-runner /lava-10858052/1

    2023-06-22T09:28:02.481850  =


    2023-06-22T09:28:02.486569  / # /lava-10858052/bin/lava-test-runner /la=
va-10858052/1

    2023-06-22T09:28:02.492309  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 4          =


  Details:     https://kernelci.org/test/plan/id/64941a67493318fef0306174

  Results:     153 PASS, 14 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18-11-gd2efde0d1c2ee/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/=
baseline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18-11-gd2efde0d1c2ee/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/=
baseline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/64941a67493318fef0306191
        failing since 38 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-22T09:54:28.801873  /lava-10858386/1/../bin/lava-test-case

    2023-06-22T09:54:28.808330  <8>[   60.559816] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/64941a67493318fef03061a3
        failing since 38 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-22T09:54:29.843120  /lava-10858386/1/../bin/lava-test-case

    2023-06-22T09:54:29.849668  <8>[   61.600792] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/64941a67493318fef03061a3
        failing since 38 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-22T09:54:29.843120  /lava-10858386/1/../bin/lava-test-case

    2023-06-22T09:54:29.849668  <8>[   61.600792] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64941a67493318fef030621c
        failing since 38 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-22T09:54:14.629325  <8>[   46.383526] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10858386_1.5.2.3.1>

    2023-06-22T09:54:14.632240  + set +x

    2023-06-22T09:54:14.741030  / # #

    2023-06-22T09:54:14.843436  export SHELL=3D/bin/sh

    2023-06-22T09:54:14.844176  #

    2023-06-22T09:54:14.945760  / # export SHELL=3D/bin/sh. /lava-10858386/=
environment

    2023-06-22T09:54:14.946544  =


    2023-06-22T09:54:15.048154  / # . /lava-10858386/environment/lava-10858=
386/bin/lava-test-runner /lava-10858386/1

    2023-06-22T09:54:15.049488  =


    2023-06-22T09:54:15.054447  / # /lava-10858386/bin/lava-test-runner /la=
va-10858386/1
 =

    ... (13 line(s) more)  =

 =20
