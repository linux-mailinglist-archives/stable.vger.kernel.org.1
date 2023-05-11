Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6D16FFC92
	for <lists+stable@lfdr.de>; Fri, 12 May 2023 00:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238254AbjEKWJx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 11 May 2023 18:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239064AbjEKWJu (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 11 May 2023 18:09:50 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113DF6EBD
        for <stable@vger.kernel.org>; Thu, 11 May 2023 15:09:16 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1aaea3909d1so86224975ad.2
        for <stable@vger.kernel.org>; Thu, 11 May 2023 15:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683842953; x=1686434953;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wWnyx10/JlkvZR8a7SUYqO9ffa8Ht/bv3DHxO0PF69A=;
        b=XJIixljHmqO9z/iyNbPKvC3oWy+Fcm1/zK6Lx0LotFurj66MJ0S0Fj8soi0GNOxoQx
         AtJ7owsFVbCYj9EKwpCKyPVZLqjyRj5TN0naMgJLljj/4s2pZ+HSoU6BOqqj6Oh/vQTk
         eRG6O0dCYdSTSGFGgtDZmVDSHHWSqzaijHVLgPK85I4Hr8lk5fzO3XC2GKPcd8YlS52p
         4WiPGf934/crN6qXxGrGc9teedHBWjWBus2EAMw78lDwijGVBMVsxoh3jqndcwjjqLRW
         +XYf+hcVBs0Uo+oLw9Lveu0scDtpKNHEjc2sxuuBOHfzAZ49bcalEvsJUNsVibhi8MJr
         95Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683842953; x=1686434953;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wWnyx10/JlkvZR8a7SUYqO9ffa8Ht/bv3DHxO0PF69A=;
        b=Im3dJgYrFac/Nqlobf8QFyM0VjcqtBdQnvJjUR2YZ/Et9ENBBAARDGmJ86O1wgtZpM
         7200ijXfmFJWgexUHacVjliTwx02yEXhvspqEq3z9NpGzvt41uDobMjRrw5FTYe/R73N
         rI8SCyUq47I2q9jUI/W6xO9TB9SK0/2mgYUJ6wdygFnWZidLQc2HxfTzHtMD3inQSNJr
         dmKWluagE+Qu1F+zZsd/mOWp4atqoDp0qMT7iRBpzH1FBkZPOSeGCLPKU4JfNhrT87Am
         QlEt36KaHI5ENpG0xFV76yh3jxy1lym37DNl50TrSujdOWHr0MDH8gTrXuaRZZwKB1au
         M0CQ==
X-Gm-Message-State: AC+VfDy2vCqpTu9w5Bc4F+dYuhi2/h1fS2MrEeM/ZZfRoTgCrkGaAxtC
        zHlIwFsZycaca3xUi2WXCsqX0fcaLi6DAhdmItM+8A==
X-Google-Smtp-Source: ACHHUZ7QAAn8A5YpVMpwMq5cgNcVdOgNq+VoYztrUs8ATqyLxC4EUjr6qIk9Cb7iH2Op+56gzMRH3g==
X-Received: by 2002:a17:903:1c7:b0:1ac:aee4:d75 with SMTP id e7-20020a17090301c700b001acaee40d75mr10497987plh.52.1683842952722;
        Thu, 11 May 2023 15:09:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902b60f00b001aafe232bcfsm6395448pls.44.2023.05.11.15.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 15:09:11 -0700 (PDT)
Message-ID: <645d6787.170a0220.a5e9b.d882@mx.google.com>
Date:   Thu, 11 May 2023 15:09:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.28-17-gfd8d81f05a2c
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 136 runs,
 10 regressions (v6.1.28-17-gfd8d81f05a2c)
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

stable-rc/queue/6.1 baseline: 136 runs, 10 regressions (v6.1.28-17-gfd8d81f=
05a2c)

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

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.28-17-gfd8d81f05a2c/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.28-17-gfd8d81f05a2c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      fd8d81f05a2c89c02aa0ae6c57c76a194af46961 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d30b148d370eb4e2e85ea

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-17=
-gfd8d81f05a2c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-17=
-gfd8d81f05a2c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d30b148d370eb4e2e85ef
        failing since 43 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-11T18:14:58.488875  <8>[   10.874928] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10286768_1.4.2.3.1>

    2023-05-11T18:14:58.492418  + set +x

    2023-05-11T18:14:58.599717  / # #

    2023-05-11T18:14:58.701784  export SHELL=3D/bin/sh

    2023-05-11T18:14:58.702518  #

    2023-05-11T18:14:58.803922  / # export SHELL=3D/bin/sh. /lava-10286768/=
environment

    2023-05-11T18:14:58.804669  =


    2023-05-11T18:14:58.906217  / # . /lava-10286768/environment/lava-10286=
768/bin/lava-test-runner /lava-10286768/1

    2023-05-11T18:14:58.907326  =


    2023-05-11T18:14:58.913354  / # /lava-10286768/bin/lava-test-runner /la=
va-10286768/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d301d4e1c4f9e0f2e85eb

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-17=
-gfd8d81f05a2c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-17=
-gfd8d81f05a2c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d301d4e1c4f9e0f2e85f0
        failing since 43 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-11T18:12:32.594271  + set<8>[   11.378348] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10286796_1.4.2.3.1>

    2023-05-11T18:12:32.594855   +x

    2023-05-11T18:12:32.702973  / # #

    2023-05-11T18:12:32.805558  export SHELL=3D/bin/sh

    2023-05-11T18:12:32.806384  #

    2023-05-11T18:12:32.907931  / # export SHELL=3D/bin/sh. /lava-10286796/=
environment

    2023-05-11T18:12:32.908736  =


    2023-05-11T18:12:33.010502  / # . /lava-10286796/environment/lava-10286=
796/bin/lava-test-runner /lava-10286796/1

    2023-05-11T18:12:33.011768  =


    2023-05-11T18:12:33.016553  / # /lava-10286796/bin/lava-test-runner /la=
va-10286796/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d3020f9a3f41dbc2e8602

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-17=
-gfd8d81f05a2c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-17=
-gfd8d81f05a2c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d3020f9a3f41dbc2e8607
        failing since 43 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-11T18:12:29.576976  <8>[   11.190215] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10286829_1.4.2.3.1>

    2023-05-11T18:12:29.580327  + set +x

    2023-05-11T18:12:29.685725  #

    2023-05-11T18:12:29.687663  =


    2023-05-11T18:12:29.790464  / # #export SHELL=3D/bin/sh

    2023-05-11T18:12:29.791500  =


    2023-05-11T18:12:29.893389  / # export SHELL=3D/bin/sh. /lava-10286829/=
environment

    2023-05-11T18:12:29.894026  =


    2023-05-11T18:12:29.995152  / # . /lava-10286829/environment/lava-10286=
829/bin/lava-test-runner /lava-10286829/1

    2023-05-11T18:12:29.996015  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d301ef9a3f41dbc2e85f2

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-17=
-gfd8d81f05a2c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-17=
-gfd8d81f05a2c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d301ef9a3f41dbc2e85f7
        failing since 43 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-11T18:12:28.470104  + set +x

    2023-05-11T18:12:28.476490  <8>[   11.449643] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10286830_1.4.2.3.1>

    2023-05-11T18:12:28.580851  / # #

    2023-05-11T18:12:28.681597  export SHELL=3D/bin/sh

    2023-05-11T18:12:28.681776  #

    2023-05-11T18:12:28.782260  / # export SHELL=3D/bin/sh. /lava-10286830/=
environment

    2023-05-11T18:12:28.782498  =


    2023-05-11T18:12:28.883049  / # . /lava-10286830/environment/lava-10286=
830/bin/lava-test-runner /lava-10286830/1

    2023-05-11T18:12:28.883394  =


    2023-05-11T18:12:28.887432  / # /lava-10286830/bin/lava-test-runner /la=
va-10286830/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d3015af9b7e80972e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-17=
-gfd8d81f05a2c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-17=
-gfd8d81f05a2c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d3015af9b7e80972e85eb
        failing since 43 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-11T18:12:20.735451  + set +x

    2023-05-11T18:12:20.741926  <8>[   10.005643] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10286770_1.4.2.3.1>

    2023-05-11T18:12:20.844252  =


    2023-05-11T18:12:20.944787  / # #export SHELL=3D/bin/sh

    2023-05-11T18:12:20.944960  =


    2023-05-11T18:12:21.045424  / # export SHELL=3D/bin/sh. /lava-10286770/=
environment

    2023-05-11T18:12:21.045636  =


    2023-05-11T18:12:21.146169  / # . /lava-10286770/environment/lava-10286=
770/bin/lava-test-runner /lava-10286770/1

    2023-05-11T18:12:21.146447  =


    2023-05-11T18:12:21.151636  / # /lava-10286770/bin/lava-test-runner /la=
va-10286770/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d301eaf9b7e80972e860e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-17=
-gfd8d81f05a2c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-17=
-gfd8d81f05a2c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d301eaf9b7e80972e8613
        failing since 43 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-11T18:12:28.935816  + <8>[   11.502618] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10286789_1.4.2.3.1>

    2023-05-11T18:12:28.936470  set +x

    2023-05-11T18:12:29.043764  / # #

    2023-05-11T18:12:29.146216  export SHELL=3D/bin/sh

    2023-05-11T18:12:29.146998  #

    2023-05-11T18:12:29.248532  / # export SHELL=3D/bin/sh. /lava-10286789/=
environment

    2023-05-11T18:12:29.249331  =


    2023-05-11T18:12:29.350939  / # . /lava-10286789/environment/lava-10286=
789/bin/lava-test-runner /lava-10286789/1

    2023-05-11T18:12:29.352251  =


    2023-05-11T18:12:29.357002  / # /lava-10286789/bin/lava-test-runner /la=
va-10286789/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d3103899de655d62e860b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-17=
-gfd8d81f05a2c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-17=
-gfd8d81f05a2c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d3103899de655d62e8610
        failing since 43 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-11T18:16:17.450779  + set<8>[   12.238808] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10286750_1.4.2.3.1>

    2023-05-11T18:16:17.450867   +x

    2023-05-11T18:16:17.555209  / # #

    2023-05-11T18:16:17.655835  export SHELL=3D/bin/sh

    2023-05-11T18:16:17.656129  #

    2023-05-11T18:16:17.756767  / # export SHELL=3D/bin/sh. /lava-10286750/=
environment

    2023-05-11T18:16:17.756962  =


    2023-05-11T18:16:17.857512  / # . /lava-10286750/environment/lava-10286=
750/bin/lava-test-runner /lava-10286750/1

    2023-05-11T18:16:17.857831  =


    2023-05-11T18:16:17.862138  / # /lava-10286750/bin/lava-test-runner /la=
va-10286750/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/645d2fe2c5cdf3e2352e861b

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-17=
-gfd8d81f05a2c/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseli=
ne-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-17=
-gfd8d81f05a2c/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseli=
ne-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/645d2fe2c5cdf3e2352e8637
        failing since 4 days (last pass: v6.1.22-704-ga3dcd1f09de2, first f=
ail: v6.1.22-1160-g24230ce6f2e2)

    2023-05-11T18:11:33.409087  /lava-10286714/1/../bin/lava-test-case

    2023-05-11T18:11:33.415497  <8>[   22.987457] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d2fe2c5cdf3e2352e86c3
        failing since 4 days (last pass: v6.1.22-704-ga3dcd1f09de2, first f=
ail: v6.1.22-1160-g24230ce6f2e2)

    2023-05-11T18:11:27.948436  + set +x

    2023-05-11T18:11:27.954761  <8>[   17.524984] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10286714_1.5.2.3.1>

    2023-05-11T18:11:28.061739  / # #

    2023-05-11T18:11:28.162459  export SHELL=3D/bin/sh

    2023-05-11T18:11:28.162694  #

    2023-05-11T18:11:28.263251  / # export SHELL=3D/bin/sh. /lava-10286714/=
environment

    2023-05-11T18:11:28.263486  =


    2023-05-11T18:11:28.364062  / # . /lava-10286714/environment/lava-10286=
714/bin/lava-test-runner /lava-10286714/1

    2023-05-11T18:11:28.364449  =


    2023-05-11T18:11:28.368936  / # /lava-10286714/bin/lava-test-runner /la=
va-10286714/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/645d2f58ada7eb0b172e860b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-17=
-gfd8d81f05a2c/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mips=
-malta.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-17=
-gfd8d81f05a2c/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mips=
-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645d2f58ada7eb0b172e8=
60c
        failing since 4 days (last pass: v6.1.22-1159-g8729cbdc1402, first =
fail: v6.1.22-1196-g571a2463c150b) =

 =20
