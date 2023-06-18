Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3D473479D
	for <lists+stable@lfdr.de>; Sun, 18 Jun 2023 20:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjFRS1h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 18 Jun 2023 14:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFRS1g (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Jun 2023 14:27:36 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDA09B
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 11:27:34 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5533c545786so1662872a12.1
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 11:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687112854; x=1689704854;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xt3nLht7/1/+6goSU9mhvj83Ax4TwbSRFzynOX5j0OU=;
        b=p6OIXYyGu9x75c8bKIYhRxn/+AX+h2arID6bukCzh0dIn+o7/nZ7OW6N+NJDstLJIy
         mkmglILd1RCJPN+/RQ0/wHkYmHQvYcc8Wbk/tWFBiwNSs/TKrorFhVhJQAifm+VsPOpZ
         ugexEbYWMbxaRX1/Tsj8PvF2XynKLNptgrXOikmrzGriDktq3kxlSb3BIf2X6t2pqBPo
         Sf5+Rqzpmqw7AxCvX1hDmTLnc6BWnJg3qSR2MBEyJJi8w7xzrDYH3y0wer/FjocOY4Xi
         UdXVgy0aR2vy85FRapOqa5TFvufW6ojr9EpF0dHo8h06Q3nUF3aAC6Y6rjVKwjjoXOrR
         Hh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687112854; x=1689704854;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xt3nLht7/1/+6goSU9mhvj83Ax4TwbSRFzynOX5j0OU=;
        b=KOushEGyFXV29Y8qP8RFpTVf4Dbo13L9dnMo70zjUZh4LP5AJwBV1GKxO1vr2oXFed
         GAagJp550zEOUaWae4jXtiqqyW+/uog/s0mm5RvfGxWDbGLRQE8HrOVdD3jjNMl+JZV1
         r/+hoVyhduIVJQbd1c521+DUkooS1iRJjkFaaQVPJxGmm94A/YCBuTAGCpD7eJIo2Fls
         XSmQXhJAet2mX7NRnSq6qM1y5cKGDr6J5RaAhxQTolJJC9dZCESxq4nCwUsWdPVXB3i4
         JcNSKWLr6cafO706wt5tIIDMPGl3DuHqCpo0BtyBbdXQF+vt4aSlpnnFKtbNXAhB0bwf
         9NQA==
X-Gm-Message-State: AC+VfDx24JfFeOMbEkJfT3Q96Humj0R8ot47reKp35om1pqcgMFlP2DK
        MHLKpR3oaEb71DshvTizuRSf6rd3MdObc3pGxs/EAW93
X-Google-Smtp-Source: ACHHUZ7Xarrjzyh5uNuvq4vHK8xPT1VxWfMCvzwKdpLOGi8Jrw81kWFStxVr3AkR8FjvNPIKh+eDIg==
X-Received: by 2002:a17:90b:e12:b0:24b:52cb:9a31 with SMTP id ge18-20020a17090b0e1200b0024b52cb9a31mr17612908pjb.22.1687112853750;
        Sun, 18 Jun 2023 11:27:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s12-20020a6550cc000000b0051b460fd90fsm16029657pgp.8.2023.06.18.11.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 11:27:33 -0700 (PDT)
Message-ID: <648f4c95.650a0220.9c8cd.e6f0@mx.google.com>
Date:   Sun, 18 Jun 2023 11:27:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.184-46-gb25b2921d506
Subject: stable-rc/linux-5.10.y baseline: 172 runs,
 5 regressions (v5.10.184-46-gb25b2921d506)
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

stable-rc/linux-5.10.y baseline: 172 runs, 5 regressions (v5.10.184-46-gb25=
b2921d506)

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

rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.184-46-gb25b2921d506/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.184-46-gb25b2921d506
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b25b2921d5068131d014c425e83680856412101f =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648f1515ab4ec89b60306135

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-46-gb25b2921d506/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-46-gb25b2921d506/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f1515ab4ec89b6030613a
        failing since 151 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-06-18T14:30:24.752680  <8>[   11.153076] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3672945_1.5.2.4.1>
    2023-06-18T14:30:24.861123  / # #
    2023-06-18T14:30:24.963817  export SHELL=3D/bin/sh
    2023-06-18T14:30:24.964702  #
    2023-06-18T14:30:25.066569  / # export SHELL=3D/bin/sh. /lava-3672945/e=
nvironment
    2023-06-18T14:30:25.067317  =

    2023-06-18T14:30:25.169248  / # . /lava-3672945/environment/lava-367294=
5/bin/lava-test-runner /lava-3672945/1
    2023-06-18T14:30:25.170880  =

    2023-06-18T14:30:25.171448  / # <3>[   11.531847] Bluetooth: hci0: comm=
and 0x0c03 tx timeout
    2023-06-18T14:30:25.175380  /lava-3672945/bin/lava-test-runner /lava-36=
72945/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648f124321c1659094306165

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-46-gb25b2921d506/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-46-gb25b2921d506/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f124321c165909430616a
        failing since 81 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-06-18T14:18:39.285298  + set +x

    2023-06-18T14:18:39.292251  <8>[   14.507700] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10793200_1.4.2.3.1>

    2023-06-18T14:18:39.402525  / # #

    2023-06-18T14:18:39.504639  export SHELL=3D/bin/sh

    2023-06-18T14:18:39.504827  #

    2023-06-18T14:18:39.605394  / # export SHELL=3D/bin/sh. /lava-10793200/=
environment

    2023-06-18T14:18:39.605602  =


    2023-06-18T14:18:39.706118  / # . /lava-10793200/environment/lava-10793=
200/bin/lava-test-runner /lava-10793200/1

    2023-06-18T14:18:39.706433  =


    2023-06-18T14:18:39.710962  / # /lava-10793200/bin/lava-test-runner /la=
va-10793200/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648f125c6812e4f008306169

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-46-gb25b2921d506/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-46-gb25b2921d506/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f125c6812e4f00830616e
        failing since 81 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-06-18T14:18:50.725392  + set +x<8>[   11.920063] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10793266_1.4.2.3.1>

    2023-06-18T14:18:50.725500  =


    2023-06-18T14:18:50.827391  #

    2023-06-18T14:18:50.928157  / # #export SHELL=3D/bin/sh

    2023-06-18T14:18:50.928351  =


    2023-06-18T14:18:51.028827  / # export SHELL=3D/bin/sh. /lava-10793266/=
environment

    2023-06-18T14:18:51.029051  =


    2023-06-18T14:18:51.129595  / # . /lava-10793266/environment/lava-10793=
266/bin/lava-test-runner /lava-10793266/1

    2023-06-18T14:18:51.129973  =


    2023-06-18T14:18:51.134332  / # /lava-10793266/bin/lava-test-runner /la=
va-10793266/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648f134bebdcfba84630619d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-46-gb25b2921d506/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-roc=
k64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-46-gb25b2921d506/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-roc=
k64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f134bebdcfba8463061a2
        failing since 51 days (last pass: v5.10.147, first fail: v5.10.176-=
373-g8415c0f9308b)

    2023-06-18T14:22:43.952145  [   15.964616] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3672901_1.5.2.4.1>
    2023-06-18T14:22:44.055707  =

    2023-06-18T14:22:44.055856  / # #[   16.061270] rockchip-drm display-su=
bsystem: [drm] Cannot find any crtc or sizes
    2023-06-18T14:22:44.157112  export SHELL=3D/bin/sh
    2023-06-18T14:22:44.157476  =

    2023-06-18T14:22:44.258655  / # export SHELL=3D/bin/sh. /lava-3672901/e=
nvironment
    2023-06-18T14:22:44.259003  =

    2023-06-18T14:22:44.360219  / # . /lava-3672901/environment/lava-367290=
1/bin/lava-test-runner /lava-3672901/1
    2023-06-18T14:22:44.360779  =

    2023-06-18T14:22:44.364080  / # /lava-3672901/bin/lava-test-runner /lav=
a-3672901/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648f14d9ea0a8421b5306154

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-46-gb25b2921d506/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64=
-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-46-gb25b2921d506/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64=
-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f14d9ea0a8421b5306180
        failing since 138 days (last pass: v5.10.158-107-g6b6a42c25ed4, fir=
st fail: v5.10.165-144-g930bc29c79c4)

    2023-06-18T14:29:19.662027  + set +x
    2023-06-18T14:29:19.665615  <8>[   17.133845] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3672904_1.5.2.4.1>
    2023-06-18T14:29:19.786475  / # #
    2023-06-18T14:29:19.892350  export SHELL=3D/bin/sh
    2023-06-18T14:29:19.893894  #
    2023-06-18T14:29:19.997298  / # export SHELL=3D/bin/sh. /lava-3672904/e=
nvironment
    2023-06-18T14:29:19.998875  =

    2023-06-18T14:29:20.103072  / # . /lava-3672904/environment/lava-367290=
4/bin/lava-test-runner /lava-3672904/1
    2023-06-18T14:29:20.105947  =

    2023-06-18T14:29:20.109202  / # /lava-3672904/bin/lava-test-runner /lav=
a-3672904/1 =

    ... (12 line(s) more)  =

 =20
