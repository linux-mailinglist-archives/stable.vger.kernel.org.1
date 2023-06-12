Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A672372CBA4
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 18:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237126AbjFLQff (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 12:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbjFLQfe (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 12:35:34 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E18195
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 09:35:31 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-652328c18d5so3470769b3a.1
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 09:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686587730; x=1689179730;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=asRPWtxNq7+zsZ8MHGiA4rvLzDaozdjyZjYfPPoRa8Q=;
        b=FPSXrcQyVnnmEC1DQKOoHMNSQS62f6vuKKCOMoSHzAnuLGt+ZI3PnjBTe85ggj0Daa
         djZBhUr3MgIZwtZK/7Cv5qzMZzgCur97SdhDLoN6UDU0ktMw0662fynZ2/GEcA/5kLpH
         yt8ycf2XyClQKQBZ1V/GA50KoC709rKWYHSzcwG63JWqZNpai1ZyNkWP86aChduh8ZhP
         WJ/SsA76bbZmKiZRG8uKxfMg2lh6wPATR0XpELq5R1+o/u/ZgZLhdMEfjTUDnJUebKsa
         GCiIPuS38UzuZyVlwIxuajdaPZf5yjZbagKt20vE6vMmFQIJ8eXbnw3FjPE372Sse+R7
         H9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686587730; x=1689179730;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=asRPWtxNq7+zsZ8MHGiA4rvLzDaozdjyZjYfPPoRa8Q=;
        b=Mkpdlfu62RTg2sS6/vVShsBd8uJ71vpwJahLZPK/ZVJuESFs9xQ6Rjz1z2i6VbHsjL
         SmGAIIQLH2o/ML2P5yaIVVqdOjZfIrIpKN6lx3toh1fmxWYKeQyPHrm+UhJ0j9oKFTSA
         oQIs4QLlWffe/NTOp9Y90sMGYIM7eax8ZY2v97SeNSZ79hNCRMMFuoIr5YbkYSWs7Fb/
         IlMA6SJ+Ex+VaxNPAnm4JnqAMNcmepnW5BjbB1YCHi+F7QQ6humVzIHmlk3QKFZhXCmx
         PldS6EgS3JVgTsuD9zzPgS9xxu1RzrpCVfhou4B90Os/LYbv/YIy/qYKrYrdj4MG+krZ
         GnLw==
X-Gm-Message-State: AC+VfDzu7gbCe1JDn1yhIV8sm91l2pbnui90RlgLi6Gn7qhjC5rblw+E
        hsFwgrufHQCb3nYR1sFt2QBISuseyBnRysRfR5wisQ==
X-Google-Smtp-Source: ACHHUZ541mIU/IWxkbxqivT8+gqLd3WbjrO2/zMfqp3EEQMfbCLvBJ/GxJzYeLXtLDw240SCO7qVSg==
X-Received: by 2002:a05:6a00:228f:b0:661:237d:6c1f with SMTP id f15-20020a056a00228f00b00661237d6c1fmr12606069pfe.3.1686587729297;
        Mon, 12 Jun 2023 09:35:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p10-20020a62ab0a000000b00625d84a0194sm7110047pff.107.2023.06.12.09.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 09:35:28 -0700 (PDT)
Message-ID: <64874950.620a0220.f6781.e21e@mx.google.com>
Date:   Mon, 12 Jun 2023 09:35:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.116-92-g09ab3478acfde
Subject: stable-rc/linux-5.15.y baseline: 175 runs,
 21 regressions (v5.15.116-92-g09ab3478acfde)
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

stable-rc/linux-5.15.y baseline: 175 runs, 21 regressions (v5.15.116-92-g09=
ab3478acfde)

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

kontron-pitx-imx8m           | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 2          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 4          =

rk3328-rock64                | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

stm32mp157c-dk2              | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.116-92-g09ab3478acfde/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.116-92-g09ab3478acfde
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      09ab3478acfde2bfd20e35fa2f6d3db44662db69 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64871624caf8c882be30613b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
16-92-g09ab3478acfde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
16-92-g09ab3478acfde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64871624caf8c882be306140
        failing since 75 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-12T12:56:56.883026  <8>[   10.733578] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10690125_1.4.2.3.1>

    2023-06-12T12:56:56.886029  + set +x

    2023-06-12T12:56:56.990869  / # #

    2023-06-12T12:56:57.091557  export SHELL=3D/bin/sh

    2023-06-12T12:56:57.091745  #

    2023-06-12T12:56:57.192268  / # export SHELL=3D/bin/sh. /lava-10690125/=
environment

    2023-06-12T12:56:57.192463  =


    2023-06-12T12:56:57.292967  / # . /lava-10690125/environment/lava-10690=
125/bin/lava-test-runner /lava-10690125/1

    2023-06-12T12:56:57.293317  =


    2023-06-12T12:56:57.299303  / # /lava-10690125/bin/lava-test-runner /la=
va-10690125/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64871622359d2662e130612e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
16-92-g09ab3478acfde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
16-92-g09ab3478acfde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64871623359d2662e1306133
        failing since 75 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-12T12:56:59.788444  + set<8>[   11.254588] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10690101_1.4.2.3.1>

    2023-06-12T12:56:59.788530   +x

    2023-06-12T12:56:59.892839  / # #

    2023-06-12T12:56:59.995076  export SHELL=3D/bin/sh

    2023-06-12T12:56:59.995846  #

    2023-06-12T12:57:00.097462  / # export SHELL=3D/bin/sh. /lava-10690101/=
environment

    2023-06-12T12:57:00.097612  =


    2023-06-12T12:57:00.198094  / # . /lava-10690101/environment/lava-10690=
101/bin/lava-test-runner /lava-10690101/1

    2023-06-12T12:57:00.198678  =


    2023-06-12T12:57:00.203324  / # /lava-10690101/bin/lava-test-runner /la=
va-10690101/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6487161567c6834953306169

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
16-92-g09ab3478acfde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
16-92-g09ab3478acfde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6487161567c683495330616e
        failing since 75 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-12T12:56:33.824386  <8>[   10.579436] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10690139_1.4.2.3.1>

    2023-06-12T12:56:33.827736  + set +x

    2023-06-12T12:56:33.928947  #

    2023-06-12T12:56:33.929282  =


    2023-06-12T12:56:34.029943  / # #export SHELL=3D/bin/sh

    2023-06-12T12:56:34.030122  =


    2023-06-12T12:56:34.130642  / # export SHELL=3D/bin/sh. /lava-10690139/=
environment

    2023-06-12T12:56:34.130844  =


    2023-06-12T12:56:34.231360  / # . /lava-10690139/environment/lava-10690=
139/bin/lava-test-runner /lava-10690139/1

    2023-06-12T12:56:34.231656  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6487195680dcf145bd306131

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
16-92-g09ab3478acfde/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
16-92-g09ab3478acfde/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6487195680dcf145bd306=
132
        failing since 395 days (last pass: v5.15.37-259-gab77581473a3, firs=
t fail: v5.15.39) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64871657f7f0dc5fa83061a1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
16-92-g09ab3478acfde/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
16-92-g09ab3478acfde/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64871657f7f0dc5fa83061a6
        failing since 146 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-06-12T12:57:28.563671  <8>[   10.014641] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3659167_1.5.2.4.1>
    2023-06-12T12:57:28.671511  / # #
    2023-06-12T12:57:28.775051  export SHELL=3D/bin/sh
    2023-06-12T12:57:28.777994  #
    2023-06-12T12:57:28.778741  / # export SHELL=3D/bin/sh<3>[   10.193496]=
 Bluetooth: hci0: command 0xfc18 tx timeout
    2023-06-12T12:57:28.885367  . /lava-3659167/environment
    2023-06-12T12:57:28.885780  =

    2023-06-12T12:57:28.987006  / # . /lava-3659167/environment/lava-365916=
7/bin/lava-test-runner /lava-3659167/1
    2023-06-12T12:57:28.987596  =

    2023-06-12T12:57:28.992350  / # /lava-3659167/bin/lava-test-runner /lav=
a-3659167/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64871610da753a9832306141

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
16-92-g09ab3478acfde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
16-92-g09ab3478acfde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64871610da753a9832306146
        failing since 75 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-12T12:56:34.743398  + set +x

    2023-06-12T12:56:34.749498  <8>[   10.554749] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10690097_1.4.2.3.1>

    2023-06-12T12:56:34.855402  / # #

    2023-06-12T12:56:34.956235  export SHELL=3D/bin/sh

    2023-06-12T12:56:34.956444  #

    2023-06-12T12:56:35.057035  / # export SHELL=3D/bin/sh. /lava-10690097/=
environment

    2023-06-12T12:56:35.057260  =


    2023-06-12T12:56:35.157804  / # . /lava-10690097/environment/lava-10690=
097/bin/lava-test-runner /lava-10690097/1

    2023-06-12T12:56:35.158131  =


    2023-06-12T12:56:35.163056  / # /lava-10690097/bin/lava-test-runner /la=
va-10690097/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648716091be699c8e0306133

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
16-92-g09ab3478acfde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
16-92-g09ab3478acfde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648716091be699c8e0306138
        failing since 75 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-12T12:56:32.818182  + set +x

    2023-06-12T12:56:32.824461  <8>[   11.448733] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10690069_1.4.2.3.1>

    2023-06-12T12:56:32.932558  / # #

    2023-06-12T12:56:33.034810  export SHELL=3D/bin/sh

    2023-06-12T12:56:33.035529  #

    2023-06-12T12:56:33.136948  / # export SHELL=3D/bin/sh. /lava-10690069/=
environment

    2023-06-12T12:56:33.137639  =


    2023-06-12T12:56:33.239042  / # . /lava-10690069/environment/lava-10690=
069/bin/lava-test-runner /lava-10690069/1

    2023-06-12T12:56:33.240261  =


    2023-06-12T12:56:33.247268  / # /lava-10690069/bin/lava-test-runner /la=
va-10690069/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64871622caf8c882be30612e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
16-92-g09ab3478acfde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
16-92-g09ab3478acfde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64871622caf8c882be306133
        failing since 75 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-12T12:56:42.589425  + set<8>[   11.306206] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10690118_1.4.2.3.1>

    2023-06-12T12:56:42.589524   +x

    2023-06-12T12:56:42.694050  / # #

    2023-06-12T12:56:42.794762  export SHELL=3D/bin/sh

    2023-06-12T12:56:42.794966  #

    2023-06-12T12:56:42.895494  / # export SHELL=3D/bin/sh. /lava-10690118/=
environment

    2023-06-12T12:56:42.895733  =


    2023-06-12T12:56:42.996300  / # . /lava-10690118/environment/lava-10690=
118/bin/lava-test-runner /lava-10690118/1

    2023-06-12T12:56:42.996597  =


    2023-06-12T12:56:43.001036  / # /lava-10690118/bin/lava-test-runner /la=
va-10690118/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64871612da753a983230614f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
16-92-g09ab3478acfde/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline=
-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
16-92-g09ab3478acfde/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline=
-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64871612da753a9832306154
        failing since 132 days (last pass: v5.15.81-122-gc5f8d4a5d3c8, firs=
t fail: v5.15.90-205-g5605d15db022)

    2023-06-12T12:56:39.950890  + set +x
    2023-06-12T12:56:39.951056  [    9.431821] <LAVA_SIGNAL_ENDRUN 0_dmesg =
974476_1.5.2.3.1>
    2023-06-12T12:56:40.058204  / # #
    2023-06-12T12:56:40.159676  export SHELL=3D/bin/sh
    2023-06-12T12:56:40.160049  #
    2023-06-12T12:56:40.261237  / # export SHELL=3D/bin/sh. /lava-974476/en=
vironment
    2023-06-12T12:56:40.261594  =

    2023-06-12T12:56:40.362801  / # . /lava-974476/environment/lava-974476/=
bin/lava-test-runner /lava-974476/1
    2023-06-12T12:56:40.363350  =

    2023-06-12T12:56:40.365490  / # /lava-974476/bin/lava-test-runner /lava=
-974476/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
kontron-pitx-imx8m           | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 2          =


  Details:     https://kernelci.org/test/plan/id/6487167ae835e4d06a30614f

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
16-92-g09ab3478acfde/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pi=
tx-imx8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
16-92-g09ab3478acfde/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pi=
tx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6487167ae835e4d06a306152
        new failure (last pass: v5.15.114-196-g00621f2608ac)

    2023-06-12T12:58:20.723091  / # #
    2023-06-12T12:58:20.825942  export SHELL=3D/bin/sh
    2023-06-12T12:58:20.826618  #
    2023-06-12T12:58:20.928341  / # export SHELL=3D/bin/sh. /lava-355341/en=
vironment
    2023-06-12T12:58:20.929155  =

    2023-06-12T12:58:21.031078  / # . /lava-355341/environment/lava-355341/=
bin/lava-test-runner /lava-355341/1
    2023-06-12T12:58:21.032153  =

    2023-06-12T12:58:21.049086  / # /lava-355341/bin/lava-test-runner /lava=
-355341/1
    2023-06-12T12:58:21.097822  + export 'TESTRUN_ID=3D1_bootrr'
    2023-06-12T12:58:21.098316  + cd /l<8>[   12.161524] <LAVA_SIGNAL_START=
RUN 1_bootrr 355341_1.5.2.4.5> =

    ... (10 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/648=
7167ae835e4d06a306162
        new failure (last pass: v5.15.114-196-g00621f2608ac)

    2023-06-12T12:58:23.445991  /lava-355341/1/../bin/lava-test-case
    2023-06-12T12:58:23.446530  <8>[   14.574240] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>
    2023-06-12T12:58:23.446909  /lava-355341/1/../bin/lava-test-case
    2023-06-12T12:58:23.447226  <8>[   14.593769] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dimx8mq-usb-phy-driver-present RESULT=3Dpass>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6487160e962930244330613b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
16-92-g09ab3478acfde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
16-92-g09ab3478acfde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6487160e9629302443306140
        failing since 75 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-12T12:56:32.189907  <8>[   12.108273] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10690076_1.4.2.3.1>

    2023-06-12T12:56:32.294009  / # #

    2023-06-12T12:56:32.394663  export SHELL=3D/bin/sh

    2023-06-12T12:56:32.394843  #

    2023-06-12T12:56:32.495377  / # export SHELL=3D/bin/sh. /lava-10690076/=
environment

    2023-06-12T12:56:32.495606  =


    2023-06-12T12:56:32.596204  / # . /lava-10690076/environment/lava-10690=
076/bin/lava-test-runner /lava-10690076/1

    2023-06-12T12:56:32.596484  =


    2023-06-12T12:56:32.601160  / # /lava-10690076/bin/lava-test-runner /la=
va-10690076/1

    2023-06-12T12:56:32.606091  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 4          =


  Details:     https://kernelci.org/test/plan/id/648718c3f20e2793de3061a3

  Results:     153 PASS, 14 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
16-92-g09ab3478acfde/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/=
baseline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
16-92-g09ab3478acfde/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/=
baseline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/648718c3f20e2793de3061bd
        failing since 28 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-12T13:08:03.097717  /lava-10690230/1/../bin/lava-test-case

    2023-06-12T13:08:03.103633  <8>[   61.558623] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/648718c3f20e2793de3061bd
        failing since 28 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-12T13:08:03.097717  /lava-10690230/1/../bin/lava-test-case

    2023-06-12T13:08:03.103633  <8>[   61.558623] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/648718c3f20e2793de3061bf
        failing since 28 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-12T13:08:02.058057  /lava-10690230/1/../bin/lava-test-case

    2023-06-12T13:08:02.064407  <8>[   60.518839] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648718c3f20e2793de306247
        failing since 28 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-12T13:07:47.888729  + set +x

    2023-06-12T13:07:47.895475  <8>[   46.350191] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10690230_1.5.2.3.1>

    2023-06-12T13:07:47.999402  / # #

    2023-06-12T13:07:48.099993  export SHELL=3D/bin/sh

    2023-06-12T13:07:48.100156  #

    2023-06-12T13:07:48.200686  / # export SHELL=3D/bin/sh. /lava-10690230/=
environment

    2023-06-12T13:07:48.200851  =


    2023-06-12T13:07:48.301399  / # . /lava-10690230/environment/lava-10690=
230/bin/lava-test-runner /lava-10690230/1

    2023-06-12T13:07:48.301648  =


    2023-06-12T13:07:48.306842  / # /lava-10690230/bin/lava-test-runner /la=
va-10690230/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3328-rock64                | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648716e9462c29f5f7306139

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
16-92-g09ab3478acfde/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-ro=
ck64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
16-92-g09ab3478acfde/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-ro=
ck64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648716e9462c29f5f730613e
        failing since 4 days (last pass: v5.15.72-38-gebe70cd7f5413, first =
fail: v5.15.114-196-g00621f2608ac)

    2023-06-12T13:00:07.883695  [   16.123616] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3659204_1.5.2.4.1>
    2023-06-12T13:00:07.988547  =

    2023-06-12T13:00:08.090032  / # #export SHELL=3D/bin/sh
    2023-06-12T13:00:08.090500  =

    2023-06-12T13:00:08.191843  / # export SHELL=3D/bin/sh. /lava-3659204/e=
nvironment
    2023-06-12T13:00:08.192417  =

    2023-06-12T13:00:08.293790  / # . /lava-3659204/environment/lava-365920=
4/bin/lava-test-runner /lava-3659204/1
    2023-06-12T13:00:08.294490  =

    2023-06-12T13:00:08.297986  / # /lava-3659204/bin/lava-test-runner /lav=
a-3659204/1
    2023-06-12T13:00:08.328706  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
stm32mp157c-dk2              | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6487162194eb6db08030612e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
16-92-g09ab3478acfde/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-st=
m32mp157c-dk2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
16-92-g09ab3478acfde/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-st=
m32mp157c-dk2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6487162194eb6db080306133
        failing since 127 days (last pass: v5.15.59, first fail: v5.15.91-2=
1-gd8296a906e7a)

    2023-06-12T12:56:54.445215  <8>[   11.616098] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3659158_1.5.2.4.1>
    2023-06-12T12:56:54.551378  / # #
    2023-06-12T12:56:54.653922  export SHELL=3D/bin/sh
    2023-06-12T12:56:54.654413  #
    2023-06-12T12:56:54.755995  / # export SHELL=3D/bin/sh. /lava-3659158/e=
nvironment
    2023-06-12T12:56:54.756389  =

    2023-06-12T12:56:54.858042  / # . /lava-3659158/environment/lava-365915=
8/bin/lava-test-runner /lava-3659158/1
    2023-06-12T12:56:54.858901  =

    2023-06-12T12:56:54.863364  / # /lava-3659158/bin/lava-test-runner /lav=
a-3659158/1
    2023-06-12T12:56:54.931262  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6487197756bd541f5b306133

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
16-92-g09ab3478acfde/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a6=
4-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
16-92-g09ab3478acfde/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a6=
4-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6487197756bd541f5b306160
        failing since 146 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-06-12T13:10:44.530463  + set +x
    2023-06-12T13:10:44.534640  <8>[   16.145419] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3659209_1.5.2.4.1>
    2023-06-12T13:10:44.654689  / # #
    2023-06-12T13:10:44.760261  export SHELL=3D/bin/sh
    2023-06-12T13:10:44.761792  #
    2023-06-12T13:10:44.865121  / # export SHELL=3D/bin/sh. /lava-3659209/e=
nvironment
    2023-06-12T13:10:44.866629  =

    2023-06-12T13:10:44.970075  / # . /lava-3659209/environment/lava-365920=
9/bin/lava-test-runner /lava-3659209/1
    2023-06-12T13:10:44.972792  =

    2023-06-12T13:10:44.976080  / # /lava-3659209/bin/lava-test-runner /lav=
a-3659209/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648716a121e4440d2e30616a

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
16-92-g09ab3478acfde/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64=
-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
16-92-g09ab3478acfde/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64=
-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648716a121e4440d2e306197
        failing since 146 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-06-12T12:58:43.329844  + set +x
    2023-06-12T12:58:43.333786  <8>[   16.080909] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 598163_1.5.2.4.1>
    2023-06-12T12:58:43.445555  / # #
    2023-06-12T12:58:43.547826  export SHELL=3D/bin/sh
    2023-06-12T12:58:43.548645  #
    2023-06-12T12:58:43.650473  / # export SHELL=3D/bin/sh. /lava-598163/en=
vironment
    2023-06-12T12:58:43.650913  =

    2023-06-12T12:58:43.752379  / # . /lava-598163/environment/lava-598163/=
bin/lava-test-runner /lava-598163/1
    2023-06-12T12:58:43.753121  =

    2023-06-12T12:58:43.757615  / # /lava-598163/bin/lava-test-runner /lava=
-598163/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/6487141b5a61583dac30614d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
16-92-g09ab3478acfde/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i=
-h2-plus-orangepi-r1.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
16-92-g09ab3478acfde/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i=
-h2-plus-orangepi-r1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6487141b5a61583dac306152
        failing since 60 days (last pass: v5.15.82-124-g2b8b2c150867, first=
 fail: v5.15.105-194-g415a9d81c640)

    2023-06-12T12:48:02.886766  <8>[    5.654946] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3659109_1.5.2.4.1>
    2023-06-12T12:48:03.006091  / # #
    2023-06-12T12:48:03.111816  export SHELL=3D/bin/sh
    2023-06-12T12:48:03.113408  #
    2023-06-12T12:48:03.216791  / # export SHELL=3D/bin/sh. /lava-3659109/e=
nvironment
    2023-06-12T12:48:03.218448  =

    2023-06-12T12:48:03.321952  / # . /lava-3659109/environment/lava-365910=
9/bin/lava-test-runner /lava-3659109/1
    2023-06-12T12:48:03.324709  =

    2023-06-12T12:48:03.331348  / # /lava-3659109/bin/lava-test-runner /lav=
a-3659109/1
    2023-06-12T12:48:03.455083  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
