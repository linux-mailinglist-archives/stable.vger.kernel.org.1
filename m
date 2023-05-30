Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45D37170AC
	for <lists+stable@lfdr.de>; Wed, 31 May 2023 00:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjE3W11 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 18:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjE3W10 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 18:27:26 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E93AEC
        for <stable@vger.kernel.org>; Tue, 30 May 2023 15:27:25 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b011cffef2so44273065ad.3
        for <stable@vger.kernel.org>; Tue, 30 May 2023 15:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685485644; x=1688077644;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5raG5/SkSd+OAvooLfCQRbPtTDyGjiaViGN7/6AB2fM=;
        b=bZi2cb4/Mum6yWy9QzeRfthvWVWTu5yy6gi/RDmbhiEh61XS1wgo8dBBLeR6nke0Ds
         v5r8lmsb/8c3yQMLYzwLnhnlJaRJJ/8wpILx97OeIQnu9YJYwPlTkaVPHWXbh30INaq0
         /K78PQPBIV1KdiJmxUyVvcwY/Viean8IKRefM9Anr3lzT+RkSSa85c4PiFv4nEK27Pcd
         pUfwn/zw6Di45lkYvcOccq2bYyeIaREc/cmN+UNw0yrNZ41EDl9UbFaSG9LhYJADz9Rg
         a/6v+Hm9pwdFvUZFwjrxG4d/gfPfnRyIcNZEepZYXtQcHZIdbKjzGGMjckRVYkDeTMVp
         yDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685485644; x=1688077644;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5raG5/SkSd+OAvooLfCQRbPtTDyGjiaViGN7/6AB2fM=;
        b=barO5Bkd7KbCJFHq/er2MGoTIzKvbS5MFYJKGtSPUX3gNFL3dPO1PISYlzOQX8kmoV
         CVEeACi6d3en6BJh3s9nor6tH6BivVP//hPgxV5zBtgTMGLN/Of0q+mCRrZ+6TD6O6OL
         EmGlS0kHgZQqwmUE/fjTIxSyUQEDVr/R8Muwg7oZ2Sc9L7GAI5q3MDEgpPwc9E89JduF
         nNoTRPfC6gPVkp+5GgEY3Rw7pw59GAg/cxpYJ64fCMQ+cGwpFD/k8Ojl1bFKBE/Iyvfr
         TD0vWHdoMQsJz+JNDjK3YI4jOnjWrJFNtCTQWJNuxaPDarVr/CYhqIB9Zk9bxoN1sapk
         qz8g==
X-Gm-Message-State: AC+VfDyR5GDzSfXd9K2A443+F/7Fxw9OR45r1A6GD7oxC5wcabakhWk6
        q68yoFnU+wINMJWXhv+yGwCFdOvH3nYBhAncRjRcpA==
X-Google-Smtp-Source: ACHHUZ7CxECVVfpkUZgconY4u0dQ6+G0XLtuGMEc0ErXp8qF/lFxzB2uVNQjKnBxBtTgkh6H8WLX+A==
X-Received: by 2002:a17:902:c948:b0:1af:e2f2:1cce with SMTP id i8-20020a170902c94800b001afe2f21ccemr4494209pla.38.1685485643993;
        Tue, 30 May 2023 15:27:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l19-20020a170902d35300b001ac55a5e5eesm4110377plk.121.2023.05.30.15.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 15:27:23 -0700 (PDT)
Message-ID: <6476784b.170a0220.262be.8145@mx.google.com>
Date:   Tue, 30 May 2023 15:27:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.181
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.10.y baseline: 168 runs, 4 regressions (v5.10.181)
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

stable-rc/linux-5.10.y baseline: 168 runs, 4 regressions (v5.10.181)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.181/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.181
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      272d4b8a5b96dda1374b9039a884cce2cd9cb630 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647647794bbf2f86c12e864d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
81/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
81/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647647794bbf2f86c12e8652
        failing since 132 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-05-30T18:58:53.900796  <8>[   11.226600] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3632285_1.5.2.4.1>
    2023-05-30T18:58:54.012284  / # #
    2023-05-30T18:58:54.116072  export SHELL=3D/bin/sh
    2023-05-30T18:58:54.117132  #
    2023-05-30T18:58:54.219554  / # export SHELL=3D/bin/sh. /lava-3632285/e=
nvironment
    2023-05-30T18:58:54.220790  =

    2023-05-30T18:58:54.323528  / # . /lava-3632285/environment/lava-363228=
5/bin/lava-test-runner /lava-3632285/1
    2023-05-30T18:58:54.325431  =

    2023-05-30T18:58:54.330035  / # /lava-3632285/bin/lava-test-runner /lav=
a-3632285/1
    2023-05-30T18:58:54.417277  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64764631f3ec5f3a132e85ef

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
81/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
81/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64764631f3ec5f3a132e85f4
        failing since 62 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-05-30T18:53:25.051720  + set +x

    2023-05-30T18:53:25.058808  <8>[   14.498549] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10529506_1.4.2.3.1>

    2023-05-30T18:53:25.166554  / # #

    2023-05-30T18:53:25.269071  export SHELL=3D/bin/sh

    2023-05-30T18:53:25.269940  #

    2023-05-30T18:53:25.371633  / # export SHELL=3D/bin/sh. /lava-10529506/=
environment

    2023-05-30T18:53:25.372424  =


    2023-05-30T18:53:25.474065  / # . /lava-10529506/environment/lava-10529=
506/bin/lava-test-runner /lava-10529506/1

    2023-05-30T18:53:25.475437  =


    2023-05-30T18:53:25.480564  / # /lava-10529506/bin/lava-test-runner /la=
va-10529506/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6476460eccfaa268262e8651

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
81/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
81/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6476460eccfaa268262e8656
        failing since 62 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-05-30T18:52:41.026791  <8>[   13.679296] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10529571_1.4.2.3.1>

    2023-05-30T18:52:41.030280  + set +x

    2023-05-30T18:52:41.134481  / # #

    2023-05-30T18:52:41.235497  export SHELL=3D/bin/sh

    2023-05-30T18:52:41.236333  #

    2023-05-30T18:52:41.337763  / # export SHELL=3D/bin/sh. /lava-10529571/=
environment

    2023-05-30T18:52:41.338443  =


    2023-05-30T18:52:41.439931  / # . /lava-10529571/environment/lava-10529=
571/bin/lava-test-runner /lava-10529571/1

    2023-05-30T18:52:41.441032  =


    2023-05-30T18:52:41.446820  / # /lava-10529571/bin/lava-test-runner /la=
va-10529571/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6476426156eabb83592e8608

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
81/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
81/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6476426156eabb83592e8=
609
        failing since 2 days (last pass: v5.10.180-154-gfd59dd82642d, first=
 fail: v5.10.180-212-g5bb979836617c) =

 =20
