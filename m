Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD48705A67
	for <lists+stable@lfdr.de>; Wed, 17 May 2023 00:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjEPWHQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 16 May 2023 18:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjEPWHP (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 16 May 2023 18:07:15 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CD02696
        for <stable@vger.kernel.org>; Tue, 16 May 2023 15:07:13 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1ae50da739dso283735ad.1
        for <stable@vger.kernel.org>; Tue, 16 May 2023 15:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684274833; x=1686866833;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WfucAn1M9dxWQW090D1peju16FJpwW3u4/6eC3joVSA=;
        b=2KWFjtALYhRuoi2ZHlRMhUslVlDXTpTevmfP812a5nWZ6s7d53E4EcN9ZEH2Yp0zw7
         sovC6qu68labFmBE7oEE0Ft+em2VqYzcFi3vYangoCLlmp51t7/6/KptOLgbJn7BICae
         6yEkk0hKmGMMeFGcRNbYbIrawSVZ5ai1P3jgE/r9Aem47nnvBEhY3NRo+83U0SJT9jFK
         1BJGPTr7B2h2+9Vu7Pw7o2nNDXEOh5a6322NNa1LtlV8Ccc1sGKzAR8Fjxmk/Ek21Tkz
         +XrZUGS89rcDx42Jb9BqjhZJTSsFHLbC6VDhO1KaruhlPJCr2cNtuyIqlVSruDQc+bIk
         CndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684274833; x=1686866833;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WfucAn1M9dxWQW090D1peju16FJpwW3u4/6eC3joVSA=;
        b=FeePmFCILat1TK5U6wmsAUaRWCtMlVahSZXICWM5sGg0FXLIn7eL2MJz3RWkuAkG7l
         sWzz+8yDPre6Fllp0JmcMmtqA++mG94LKrce32BbJTDqthzPK0SEQ5mH5FB/RMjInvXp
         mY4YaapYsWDEtXmJfl78pz/c3+SAtuAlw8FgIajqj2da5sSmkg/06/WzYffhXwT3YXgI
         qWKsw+xBFH2/Y3F3L3vYTxdf8WLaTPg/Yp8Ey6FsRissbnmjABwhzH1j6QqC6Z7EgptL
         Y7ZmpanHsB6QOyXlbu/JAnRlx9B9W4oUM7VNNdOFnDBBqFl1GOeZ9TgG5O6e1xGjNGAi
         jY5A==
X-Gm-Message-State: AC+VfDzYT8dggY3CjG6B6Qkfivc24pRf6cOVNlwmGVrTAuDz0AooTfYZ
        AfOQv0Ea0i9tpAh4PGOC8AN3/stea2A30SFsGjepSA==
X-Google-Smtp-Source: ACHHUZ4rwhzvcL/MZe0nDE9ScB/b7JN+itQUXj+wrCVFlsN9dTuLeuyNz9H2GNZmM5jknmVbIrct+A==
X-Received: by 2002:a17:903:4d5:b0:1ac:aac1:e344 with SMTP id jm21-20020a17090304d500b001acaac1e344mr26614016plb.36.1684274832764;
        Tue, 16 May 2023 15:07:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902788400b001a69d1bc32csm15961837pll.238.2023.05.16.15.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 15:07:12 -0700 (PDT)
Message-ID: <6463fe90.170a0220.581d7.ec28@mx.google.com>
Date:   Tue, 16 May 2023 15:07:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.179-382-g065b6901e6da
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.10.y baseline: 177 runs,
 6 regressions (v5.10.179-382-g065b6901e6da)
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

stable-rc/linux-5.10.y baseline: 177 runs, 6 regressions (v5.10.179-382-g06=
5b6901e6da)

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

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.179-382-g065b6901e6da/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.179-382-g065b6901e6da
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      065b6901e6dab7dcc7c8884779b96269724c7201 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6463ca61d08a3b5beb2e8641

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
79-382-g065b6901e6da/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
79-382-g065b6901e6da/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463ca61d08a3b5beb2e8646
        failing since 118 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-05-16T18:24:04.103284  <8>[   11.004493] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3594201_1.5.2.4.1>
    2023-05-16T18:24:04.210039  / # #
    2023-05-16T18:24:04.311478  export SHELL=3D/bin/sh
    2023-05-16T18:24:04.311821  #
    2023-05-16T18:24:04.413099  / # export SHELL=3D/bin/sh. /lava-3594201/e=
nvironment
    2023-05-16T18:24:04.414090  =

    2023-05-16T18:24:04.516401  / # . /lava-3594201/environment/lava-359420=
1/bin/lava-test-runner /lava-3594201/1
    2023-05-16T18:24:04.517566  =

    2023-05-16T18:24:04.522026  / # /lava-3594201/bin/lava-test-runner /lav=
a-3594201/1
    2023-05-16T18:24:04.602185  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6463ca2e3b07728f972e8640

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
79-382-g065b6901e6da/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
79-382-g065b6901e6da/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463ca2e3b07728f972e8645
        failing since 48 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-05-16T18:23:24.795423  + set +x

    2023-05-16T18:23:24.801905  <8>[   10.150544] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10339407_1.4.2.3.1>

    2023-05-16T18:23:24.906582  / # #

    2023-05-16T18:23:25.007251  export SHELL=3D/bin/sh

    2023-05-16T18:23:25.007949  #

    2023-05-16T18:23:25.109460  / # export SHELL=3D/bin/sh. /lava-10339407/=
environment

    2023-05-16T18:23:25.110153  =


    2023-05-16T18:23:25.211576  / # . /lava-10339407/environment/lava-10339=
407/bin/lava-test-runner /lava-10339407/1

    2023-05-16T18:23:25.212680  =


    2023-05-16T18:23:25.217902  / # /lava-10339407/bin/lava-test-runner /la=
va-10339407/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6463ca060551113bc92e85e9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
79-382-g065b6901e6da/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
79-382-g065b6901e6da/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463ca060551113bc92e85ee
        failing since 48 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-05-16T18:22:48.853282  <8>[   13.934722] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10339400_1.4.2.3.1>

    2023-05-16T18:22:48.856375  + set +x

    2023-05-16T18:22:48.957770  =


    2023-05-16T18:22:49.058317  / # #export SHELL=3D/bin/sh

    2023-05-16T18:22:49.058542  =


    2023-05-16T18:22:49.159122  / # export SHELL=3D/bin/sh. /lava-10339400/=
environment

    2023-05-16T18:22:49.159314  =


    2023-05-16T18:22:49.259825  / # . /lava-10339400/environment/lava-10339=
400/bin/lava-test-runner /lava-10339400/1

    2023-05-16T18:22:49.260224  =


    2023-05-16T18:22:49.265104  / # /lava-10339400/bin/lava-test-runner /la=
va-10339400/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6463c84239ea41872c2e85f7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
79-382-g065b6901e6da/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743=
-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
79-382-g065b6901e6da/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743=
-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6463c84239ea41872c2e8=
5f8
        failing since 5 days (last pass: v5.10.176-651-g9f10a95a08702, firs=
t fail: v5.10.179) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6463cdb22fbc7703d32e8616

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
79-382-g065b6901e6da/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
79-382-g065b6901e6da/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6463cdb22fbc7703d32e8=
617
        new failure (last pass: v5.10.179) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6463c876d33af158b22e8600

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
79-382-g065b6901e6da/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/=
baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
79-382-g065b6901e6da/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/=
baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6463c876d33af158b22e8=
601
        new failure (last pass: v5.10.179) =

 =20
