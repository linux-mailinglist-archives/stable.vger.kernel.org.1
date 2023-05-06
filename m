Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E756F933B
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 19:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjEFRFJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 13:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEFRFJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 13:05:09 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C8C1A1D1
        for <stable@vger.kernel.org>; Sat,  6 May 2023 10:05:07 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6439bbc93b6so1692327b3a.1
        for <stable@vger.kernel.org>; Sat, 06 May 2023 10:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683392706; x=1685984706;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SGhqWZ2PkClOcIhLUQP5IL5iPr3gC+SWVp5MD9+cMIg=;
        b=XmicoNAKpOrC55IPXMEcUg50nU4y07ffRcFa18pLdFAPX0UrTORi9FhpHAE6NP6eJk
         MYD5RyLfW/ighZULAQF+VgnBcx7Zs9y7bYDeJiogHhx7DxIM1Niiw+L4DVKon1wtyJ0F
         zkw6rr5k7EwDGdbE/IltlH8DX2xwl/lwePDvtKR/A4eAe5s/qkPU1MiAWfj7ZmfHnQVb
         tGQ8VE9IpwSMdlCUl9CgrLXV+LLO1kAZL+oBxVknQQsYs/ViUnsyuGoZlnmFB/LN7zLN
         SGM6CqaZd73WFlgqcZvHrx6AlihNlY3+B6eG3lY1YsfXoVxXkid4vovP4+K3rP5zLTOb
         HMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683392706; x=1685984706;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SGhqWZ2PkClOcIhLUQP5IL5iPr3gC+SWVp5MD9+cMIg=;
        b=FAXUHpbwCZCE90+pVD1wr47lwFP/zHr4Aro0btPy7tYMbcRuZMsEtzYHEkkmyLpHvX
         fizehpYonkV4N0+OcyBzkyW/uj2QaZBQXYx1dVPAP8WGoO2opOt95w2FjwTd9+9LPWnY
         x8HAriDg0VxpV4NAat4i3Ex1xjsU8QuK9m5aTii6Vy57DTr/j8QFhhqlG5wqgtXgRF68
         DcvHDnKaqFF5Wzm57CQQTvXyfCtbrfNcWXkiPx8eJvkvLHtSUNoXVzpU9cAhGgrpjAhf
         LHDjui/miIHkm1jSzJwKaUE/E0GPsaZm4ANlbfvqOJHegf0QsHTVtgjuIArssNq2tjF7
         a3cg==
X-Gm-Message-State: AC+VfDzyuM/Wnz+2iDtlOt2zo4ZDlGGmiBaCPorN5vjeJVCZkzcAYl89
        xM8u7oA0mAr/94eih3dtEZXB/yrhKnBFxXwljvp+bQ==
X-Google-Smtp-Source: ACHHUZ4YuUAQkGBqgkTtMpDTxCWeGUDdQAFa9STdQLuF25K2loV2E+eCf6ALw+oS4RE/phO6Ce+hBw==
X-Received: by 2002:a05:6a00:14c8:b0:63b:4e99:807d with SMTP id w8-20020a056a0014c800b0063b4e99807dmr7494329pfu.8.1683392706064;
        Sat, 06 May 2023 10:05:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a2-20020aa780c2000000b0062dd993fdfcsm3387649pfn.105.2023.05.06.10.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 10:05:05 -0700 (PDT)
Message-ID: <645688c1.a70a0220.4f2be.64c8@mx.google.com>
Date:   Sat, 06 May 2023 10:05:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.176-634-g06f82a6323c0
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 161 runs,
 6 regressions (v5.10.176-634-g06f82a6323c0)
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

stable-rc/queue/5.10 baseline: 161 runs, 6 regressions (v5.10.176-634-g06f8=
2a6323c0)

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

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.176-634-g06f82a6323c0/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.176-634-g06f82a6323c0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      06f82a6323c09b67743b28dcf64dd6d83ae37edd =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/645654cb6e2713ae302e8622

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-634-g06f82a6323c0/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-634-g06f82a6323c0/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645654cb6e2713ae302e8656
        failing since 81 days (last pass: v5.10.167-127-g921934d621e4, firs=
t fail: v5.10.167-139-gf9519a5a1701)

    2023-05-06T13:23:07.117365  <8>[   19.848644] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 417912_1.5.2.4.1>
    2023-05-06T13:23:07.227695  / # #
    2023-05-06T13:23:07.330884  export SHELL=3D/bin/sh
    2023-05-06T13:23:07.331633  #
    2023-05-06T13:23:07.434022  / # export SHELL=3D/bin/sh. /lava-417912/en=
vironment
    2023-05-06T13:23:07.434764  =

    2023-05-06T13:23:07.537195  / # . /lava-417912/environment/lava-417912/=
bin/lava-test-runner /lava-417912/1
    2023-05-06T13:23:07.538387  =

    2023-05-06T13:23:07.542221  / # /lava-417912/bin/lava-test-runner /lava=
-417912/1
    2023-05-06T13:23:07.641915  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645654d16e2713ae302e8661

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-634-g06f82a6323c0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-634-g06f82a6323c0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645654d16e2713ae302e8666
        failing since 37 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-06T13:23:17.096896  + <8>[   14.360340] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10215558_1.4.2.3.1>

    2023-05-06T13:23:17.096987  set +x

    2023-05-06T13:23:17.198189  #

    2023-05-06T13:23:17.299117  / # #export SHELL=3D/bin/sh

    2023-05-06T13:23:17.299327  =


    2023-05-06T13:23:17.399837  / # export SHELL=3D/bin/sh. /lava-10215558/=
environment

    2023-05-06T13:23:17.400084  =


    2023-05-06T13:23:17.500648  / # . /lava-10215558/environment/lava-10215=
558/bin/lava-test-runner /lava-10215558/1

    2023-05-06T13:23:17.501014  =


    2023-05-06T13:23:17.505926  / # /lava-10215558/bin/lava-test-runner /la=
va-10215558/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64565465caff6d05252e85e9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-634-g06f82a6323c0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-634-g06f82a6323c0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64565465caff6d05252e85ee
        failing since 37 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-06T13:21:27.655888  + set +x

    2023-05-06T13:21:27.662634  <8>[   12.377203] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10215511_1.4.2.3.1>

    2023-05-06T13:21:27.764755  =


    2023-05-06T13:21:27.865593  / # #export SHELL=3D/bin/sh

    2023-05-06T13:21:27.866325  =


    2023-05-06T13:21:27.967826  / # export SHELL=3D/bin/sh. /lava-10215511/=
environment

    2023-05-06T13:21:27.968093  =


    2023-05-06T13:21:28.068739  / # . /lava-10215511/environment/lava-10215=
511/bin/lava-test-runner /lava-10215511/1

    2023-05-06T13:21:28.069848  =


    2023-05-06T13:21:28.075012  / # /lava-10215511/bin/lava-test-runner /la=
va-10215511/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6456559964a04d8bb82e85e7

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-634-g06f82a6323c0/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-634-g06f82a6323c0/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6456559964a04d8bb82e85ed
        failing since 53 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-06T13:26:28.576210  <8>[   32.652421] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-05-06T13:26:29.600945  /lava-10215647/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6456559964a04d8bb82e85ee
        failing since 53 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-06T13:26:28.563536  /lava-10215647/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64565632909beb0a612e8668

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-634-g06f82a6323c0/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-634-g06f82a6323c0/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64565632909beb0a612e866c
        failing since 93 days (last pass: v5.10.165-139-gefb57ce0f880, firs=
t fail: v5.10.165-149-ge30e8271d674)

    2023-05-06T13:29:08.009046  / # #
    2023-05-06T13:29:08.111179  export SHELL=3D/bin/sh
    2023-05-06T13:29:08.111668  #
    2023-05-06T13:29:08.213014  / # export SHELL=3D/bin/sh. /lava-3556086/e=
nvironment
    2023-05-06T13:29:08.213494  =

    2023-05-06T13:29:08.314865  / # . /lava-3556086/environment/lava-355608=
6/bin/lava-test-runner /lava-3556086/1
    2023-05-06T13:29:08.315572  =

    2023-05-06T13:29:08.334855  / # /lava-3556086/bin/lava-test-runner /lav=
a-3556086/1
    2023-05-06T13:29:08.382911  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-06T13:29:08.430621  + cd /lava-3556086/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
