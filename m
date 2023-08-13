Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D6B77A4BE
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 04:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjHMChL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 22:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjHMChK (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 22:37:10 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F563130
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 19:37:12 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6bcade59b24so2874101a34.0
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 19:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691894231; x=1692499031;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ryuluMzaIwAIZOFlxM8VOVbDzJZZFTiRb4U3Kja9t0M=;
        b=KhmHNhCRdtcfCjre8ESG3mNm9S21Vx+qYzTXkihZHCEb31DDdaCZwekBC++0xCxxs4
         nmUVBrBQ2wJingfgkFuS+EU6mZ7BqePCUf2vJhD2Ih+wk2t8B68XIb887Z/sfVezp4XG
         K2X96uHOV8P6U5Wn0hJv8e/oeo/rXFIXpda5DSyYYfovpnUpDGSndejqWPkBGma7YQSy
         mIFsat7IBK3MsydCfxL5PZ+qtYHeRHjMuD5Q7tuKnL5o1yIH0pDLaHWxXoU411c6jbnD
         m6Iow5TgRMEhOyyd/D8+UnYrgFncPiCjn9y4+XRBuw0Gv/7DzgvnSXqoux425ckPLA4Q
         3Lvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691894231; x=1692499031;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ryuluMzaIwAIZOFlxM8VOVbDzJZZFTiRb4U3Kja9t0M=;
        b=UAKPXgaTGL0mjK5cFraPDQRJ3ASqWv65fGTExv2qlUTDae08lojuZBiWiKE0bHvPJY
         sqtN9ZdaILeQDn7ie4TkCSalHnWryC+xwbQBhhZCHGdx9V2RXtMWeh+kTGgQlg+MtvET
         3hwya0J1x4wEDLE/5aSba7x0GBYQA2IBGAGbb9Fd5URu6DlPoThr5bOOjC5btUpObq3j
         Rq29jGAk+P2T3v9GfFZ7hhwLQzeOMP9TOAxHDXO6X3UgHpxHAz8E2/cwEMpFxNRbJ2FT
         KcXCg7jbpN8hEqOkhtOY91UW3vRvn7xffxFLQwHUfFkOkReEpTpCiWV0AU1NXEENvYwm
         Hgxw==
X-Gm-Message-State: AOJu0Yz/4rB6FaPgiFgflZSXW71A//NnsWgI7lSk/IpJ0j+3ZIODN8Om
        EXDxJeky460VETW6PAzgym0rmPir5RYQwmzBvdY2RA==
X-Google-Smtp-Source: AGHT+IETKrjiwIa7pcuCy+6uvVghk8QMogd85jeDYMiTWQ5VXCcF9m8I+eLLTIEa8DIWFbu/3Ft3gQ==
X-Received: by 2002:a9d:67d3:0:b0:6bc:fdbd:ccb8 with SMTP id c19-20020a9d67d3000000b006bcfdbdccb8mr6593725otn.13.1691894230819;
        Sat, 12 Aug 2023 19:37:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902d2c400b001bb6c5ff4edsm6545296plc.173.2023.08.12.19.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 19:37:10 -0700 (PDT)
Message-ID: <64d841d6.170a0220.81e8.c17c@mx.google.com>
Date:   Sat, 12 Aug 2023 19:37:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.190-58-ge3154e1b14b6
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.10.y
Subject: stable-rc/linux-5.10.y baseline: 127 runs,
 12 regressions (v5.10.190-58-ge3154e1b14b6)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y baseline: 127 runs, 12 regressions (v5.10.190-58-ge3=
154e1b14b6)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.190-58-ge3154e1b14b6/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.190-58-ge3154e1b14b6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      e3154e1b14b6e4d7711451f10249d322bf89db90 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d80fa745feb1b1bf35b317

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-58-ge3154e1b14b6/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-58-ge3154e1b14b6/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d80fa745feb1b1bf35b31c
        failing since 207 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-08-12T23:02:39.283656  <8>[   11.150912] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3740150_1.5.2.4.1>
    2023-08-12T23:02:39.391108  / # #
    2023-08-12T23:02:39.492747  export SHELL=3D/bin/sh
    2023-08-12T23:02:39.493156  #
    2023-08-12T23:02:39.594439  / # export SHELL=3D/bin/sh. /lava-3740150/e=
nvironment
    2023-08-12T23:02:39.594855  =

    2023-08-12T23:02:39.595105  / # . /lava-3740150/environment<3>[   11.45=
2546] Bluetooth: hci0: command 0xfc18 tx timeout
    2023-08-12T23:02:39.696363  /lava-3740150/bin/lava-test-runner /lava-37=
40150/1
    2023-08-12T23:02:39.697064  =

    2023-08-12T23:02:39.701842  / # /lava-3740150/bin/lava-test-runner /lav=
a-3740150/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d8102024ad3d322035b1d9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-58-ge3154e1b14b6/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-58-ge3154e1b14b6/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d8102024ad3d322035b1dc
        failing since 25 days (last pass: v5.10.142, first fail: v5.10.186-=
332-gf98a4d3a5cec)

    2023-08-12T23:04:44.096229  [    9.868600] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1243323_1.5.2.4.1>
    2023-08-12T23:04:44.201555  =

    2023-08-12T23:04:44.302785  / # #export SHELL=3D/bin/sh
    2023-08-12T23:04:44.303346  =

    2023-08-12T23:04:44.404299  / # export SHELL=3D/bin/sh. /lava-1243323/e=
nvironment
    2023-08-12T23:04:44.404782  =

    2023-08-12T23:04:44.505767  / # . /lava-1243323/environment/lava-124332=
3/bin/lava-test-runner /lava-1243323/1
    2023-08-12T23:04:44.506446  =

    2023-08-12T23:04:44.510836  / # /lava-1243323/bin/lava-test-runner /lav=
a-1243323/1
    2023-08-12T23:04:44.532635  + export 'TESTRUN_[   10.303687] <LAVA_SIGN=
AL_STARTRUN 1_bootrr 1243323_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d81097290574551f35b1f2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-58-ge3154e1b14b6/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-58-ge3154e1b14b6/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d81097290574551f35b1f5
        failing since 162 days (last pass: v5.10.155, first fail: v5.10.172)

    2023-08-12T23:06:53.842127  [   16.395542] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1243322_1.5.2.4.1>
    2023-08-12T23:06:53.947369  =

    2023-08-12T23:06:54.048546  / # #export SHELL=3D/bin/sh
    2023-08-12T23:06:54.049085  =

    2023-08-12T23:06:54.150074  / # export SHELL=3D/bin/sh. /lava-1243322/e=
nvironment
    2023-08-12T23:06:54.150515  =

    2023-08-12T23:06:54.251534  / # . /lava-1243322/environment/lava-124332=
2/bin/lava-test-runner /lava-1243322/1
    2023-08-12T23:06:54.252220  =

    2023-08-12T23:06:54.256255  / # /lava-1243322/bin/lava-test-runner /lav=
a-1243322/1
    2023-08-12T23:06:54.270311  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d80e5d3664cf3eaa35b1e9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-58-ge3154e1b14b6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-58-ge3154e1b14b6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d80e5d3664cf3eaa35b1ee
        failing since 137 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-12T22:57:40.492388  + set +x

    2023-08-12T22:57:40.499008  <8>[   10.495393] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11274909_1.4.2.3.1>

    2023-08-12T22:57:40.605149  / # #

    2023-08-12T22:57:40.706618  export SHELL=3D/bin/sh

    2023-08-12T22:57:40.707090  #

    2023-08-12T22:57:40.808068  / # export SHELL=3D/bin/sh. /lava-11274909/=
environment

    2023-08-12T22:57:40.808702  =


    2023-08-12T22:57:40.909940  / # . /lava-11274909/environment/lava-11274=
909/bin/lava-test-runner /lava-11274909/1

    2023-08-12T22:57:40.910347  =


    2023-08-12T22:57:40.915099  / # /lava-11274909/bin/lava-test-runner /la=
va-11274909/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d80e4766dac5a85635b210

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-58-ge3154e1b14b6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-58-ge3154e1b14b6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d80e4766dac5a85635b215
        failing since 137 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-12T22:57:04.038840  + set +x

    2023-08-12T22:57:04.045649  <8>[   12.944859] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11274913_1.4.2.3.1>

    2023-08-12T22:57:04.147228  #

    2023-08-12T22:57:04.248061  / # #export SHELL=3D/bin/sh

    2023-08-12T22:57:04.248235  =


    2023-08-12T22:57:04.348787  / # export SHELL=3D/bin/sh. /lava-11274913/=
environment

    2023-08-12T22:57:04.348963  =


    2023-08-12T22:57:04.449502  / # . /lava-11274913/environment/lava-11274=
913/bin/lava-test-runner /lava-11274913/1

    2023-08-12T22:57:04.449766  =


    2023-08-12T22:57:04.454853  / # /lava-11274913/bin/lava-test-runner /la=
va-11274913/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d81047b4e3430ef035b25e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-58-ge3154e1b14b6/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hihope=
-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-58-ge3154e1b14b6/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hihope=
-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d81047b4e3430ef035b261
        failing since 11 days (last pass: v5.10.186-10-g5f99a36aeb1c, first=
 fail: v5.10.188-107-gc262f74329e1)

    2023-08-12T23:05:11.093070  + set +x
    2023-08-12T23:05:11.096353  <8>[   83.677697] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 996613_1.5.2.4.1>
    2023-08-12T23:05:11.204558  / # #
    2023-08-12T23:05:12.668442  export SHELL=3D/bin/sh
    2023-08-12T23:05:12.688964  #
    2023-08-12T23:05:12.689237  / # export SHELL=3D/bin/sh
    2023-08-12T23:05:14.574503  / # . /lava-996613/environment
    2023-08-12T23:05:18.032123  /lava-996613/bin/lava-test-runner /lava-996=
613/1
    2023-08-12T23:05:18.053654  . /lava-996613/environment
    2023-08-12T23:05:18.054074  / # /lava-996613/bin/lava-test-runner /lava=
-996613/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d8112382b2bd386535b1da

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-58-ge3154e1b14b6/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baselin=
e-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-58-ge3154e1b14b6/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baselin=
e-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d8112382b2bd386535b1dd
        failing since 25 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-12T23:09:02.572899  + set +x
    2023-08-12T23:09:02.576091  <8>[   83.689138] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 996622_1.5.2.4.1>
    2023-08-12T23:09:02.683302  / # #
    2023-08-12T23:09:04.147218  export SHELL=3D/bin/sh
    2023-08-12T23:09:04.168191  #
    2023-08-12T23:09:04.168693  / # export SHELL=3D/bin/sh
    2023-08-12T23:09:06.055022  / # . /lava-996622/environment
    2023-08-12T23:09:09.512359  /lava-996622/bin/lava-test-runner /lava-996=
622/1
    2023-08-12T23:09:09.533181  . /lava-996622/environment
    2023-08-12T23:09:09.533353  / # /lava-996622/bin/lava-test-runner /lava=
-996622/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d814ef7c3c097dc835b1e4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-58-ge3154e1b14b6/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baselin=
e-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-58-ge3154e1b14b6/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baselin=
e-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d814ef7c3c097dc835b1e7
        failing since 25 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-12T23:25:04.003860  + set +x
    2023-08-12T23:25:04.004079  <8>[   84.037000] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 996620_1.5.2.4.1>
    2023-08-12T23:25:04.109976  / # #
    2023-08-12T23:25:05.573234  export SHELL=3D/bin/sh
    2023-08-12T23:25:05.594042  #
    2023-08-12T23:25:05.594372  / # export SHELL=3D/bin/sh
    2023-08-12T23:25:07.480440  / # . /lava-996620/environment
    2023-08-12T23:25:10.938436  /lava-996620/bin/lava-test-runner /lava-996=
620/1
    2023-08-12T23:25:10.959201  . /lava-996620/environment
    2023-08-12T23:25:10.959312  / # /lava-996620/bin/lava-test-runner /lava=
-996620/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d810ca5027480c0335b209

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-58-ge3154e1b14b6/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.=
txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-58-ge3154e1b14b6/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d810cb5027480c0335b20c
        failing since 25 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-12T23:07:25.246685  / # #
    2023-08-12T23:07:26.708698  export SHELL=3D/bin/sh
    2023-08-12T23:07:26.729265  #
    2023-08-12T23:07:26.729470  / # export SHELL=3D/bin/sh
    2023-08-12T23:07:28.614896  / # . /lava-996611/environment
    2023-08-12T23:07:32.072671  /lava-996611/bin/lava-test-runner /lava-996=
611/1
    2023-08-12T23:07:32.093462  . /lava-996611/environment
    2023-08-12T23:07:32.093571  / # /lava-996611/bin/lava-test-runner /lava=
-996611/1
    2023-08-12T23:07:32.175069  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-12T23:07:32.175286  + cd /lava-996611/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d811baeb03939cf635b1e8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-58-ge3154e1b14b6/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baselin=
e-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-58-ge3154e1b14b6/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baselin=
e-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d811baeb03939cf635b1eb
        failing since 25 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-12T23:11:37.781294  / # #
    2023-08-12T23:11:39.243783  export SHELL=3D/bin/sh
    2023-08-12T23:11:39.264423  #
    2023-08-12T23:11:39.264629  / # export SHELL=3D/bin/sh
    2023-08-12T23:11:41.150287  / # . /lava-996623/environment
    2023-08-12T23:11:44.610329  /lava-996623/bin/lava-test-runner /lava-996=
623/1
    2023-08-12T23:11:44.631113  . /lava-996623/environment
    2023-08-12T23:11:44.631223  / # /lava-996623/bin/lava-test-runner /lava=
-996623/1
    2023-08-12T23:11:44.710096  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-12T23:11:44.710315  + cd /lava-996623/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d80fc80c92cdfc5835b261

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-58-ge3154e1b14b6/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-58-ge3154e1b14b6/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d80fc80c92cdfc5835b266
        failing since 25 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-12T23:04:51.010026  / # #

    2023-08-12T23:04:51.112100  export SHELL=3D/bin/sh

    2023-08-12T23:04:51.112844  #

    2023-08-12T23:04:51.214268  / # export SHELL=3D/bin/sh. /lava-11274978/=
environment

    2023-08-12T23:04:51.214907  =


    2023-08-12T23:04:51.316271  / # . /lava-11274978/environment/lava-11274=
978/bin/lava-test-runner /lava-11274978/1

    2023-08-12T23:04:51.317402  =


    2023-08-12T23:04:51.334145  / # /lava-11274978/bin/lava-test-runner /la=
va-11274978/1

    2023-08-12T23:04:51.383277  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-12T23:04:51.383738  + cd /lav<8>[   16.363924] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11274978_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d80fc40c92cdfc5835b249

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-58-ge3154e1b14b6/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-58-ge3154e1b14b6/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d80fc40c92cdfc5835b24e
        failing since 25 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-12T23:05:02.302790  / # #

    2023-08-12T23:05:02.403521  export SHELL=3D/bin/sh

    2023-08-12T23:05:02.404011  #

    2023-08-12T23:05:02.505342  / # export SHELL=3D/bin/sh. /lava-11274971/=
environment

    2023-08-12T23:05:02.506035  =


    2023-08-12T23:05:02.607349  / # . /lava-11274971/environment/lava-11274=
971/bin/lava-test-runner /lava-11274971/1

    2023-08-12T23:05:02.608386  =


    2023-08-12T23:05:02.617082  / # /lava-11274971/bin/lava-test-runner /la=
va-11274971/1

    2023-08-12T23:05:02.680870  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-12T23:05:02.681404  + cd /lava-1127497<8>[   18.343547] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11274971_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
