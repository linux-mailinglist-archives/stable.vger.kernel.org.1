Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA02714658
	for <lists+stable@lfdr.de>; Mon, 29 May 2023 10:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjE2Ifg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 29 May 2023 04:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjE2Ifd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 29 May 2023 04:35:33 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1B1A7
        for <stable@vger.kernel.org>; Mon, 29 May 2023 01:35:29 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b01d912924so23314385ad.1
        for <stable@vger.kernel.org>; Mon, 29 May 2023 01:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685349328; x=1687941328;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bVoLL6FWRcInO7eTXuuLToeLqGEqjRdxaLnaKol1Gwc=;
        b=J54c6yDvqtXIRj9BGyqqK9jlH/4+epbo05s8xmrBMDAd0DWKl46elTWrO5mHJgFu/X
         dIk4rLmmm9v6LbtY35pcujC9mLv8l/shdlWXclXjTm5j8I9mEvGmaijfnGPTAobhKJj0
         LKznpi9muSOUVfxVvKEMoanqIW8bQxFOwQilUBEUdPuHwAdvZLfEiWUAkVZ8X3+Nvy72
         amMn70QSEyLPlQ3hOkBdMsvghFGCN/3+t3aoTq7P+36vaEEGsyEV9/Devgeo+Q0RB3V4
         dSeV7SECCJtvwmd70a0KVU+mwKVTxkKn3fqKk7Cdpd4yZoe02iA541NbBtVjgvtgQCHQ
         xtoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685349328; x=1687941328;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bVoLL6FWRcInO7eTXuuLToeLqGEqjRdxaLnaKol1Gwc=;
        b=ZDD7BVcsxwU6gvhWPMlPH8DZLDrKZs4aeVp3gkCXuGrnMV/w0kJubBZjv9pLAlPQKm
         5IjHTCXL3QAuxBnoF56VUy/dhkCrRpf35voyy2Y7HaIlqvnrIU6mX7SX2d4UrQsYbyHi
         +uX90akJaQH0OyjGWnsjxj6Dj9zcvNrXVdJcr/nwEGczHcauiDcYmGIJIWS0pMMvGR7b
         rIaLQdSHVG55MPMQVl4udL/J/UDRmwUjJBjWUF/TJf7Iodkt2EovxPojRdnBhFkjgT2T
         A2kk8h/JcxNTdIxbvfb4+5uP/OriSuAsmRMMGueOlX/8EtJZl4DHbsHimXsc95qp3A0Q
         WZkg==
X-Gm-Message-State: AC+VfDztFfqiGG2Qh5Gq5iz+J7ALoVpeifSPREc9wfXZ4N/iktTcQfwo
        ist8InVpf58neulEPo+ot/Pht9FOYlc8ViAlYL71pw==
X-Google-Smtp-Source: ACHHUZ7N3f198hzQKqQuI1/dQAkkIfTBMlscNt6gjAuKQimsnxQOzGD1CejPMZ8Rrc4e+0k4NlQCYg==
X-Received: by 2002:a17:903:234a:b0:1af:c6d2:287 with SMTP id c10-20020a170903234a00b001afc6d20287mr12215069plh.53.1685349328432;
        Mon, 29 May 2023 01:35:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d18-20020a170902ced200b001ae62d7cb2bsm7610015plg.199.2023.05.29.01.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 01:35:27 -0700 (PDT)
Message-ID: <647463cf.170a0220.ffc61.e572@mx.google.com>
Date:   Mon, 29 May 2023 01:35:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.180-229-gce6531c049a4
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 153 runs,
 7 regressions (v5.10.180-229-gce6531c049a4)
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

stable-rc/queue/5.10 baseline: 153 runs, 7 regressions (v5.10.180-229-gce65=
31c049a4)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.180-229-gce6531c049a4/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.180-229-gce6531c049a4
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      ce6531c049a4e606c4ea631ee16cc7439e3449ea =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6474324c7fa21f890b2e862e

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-229-gce6531c049a4/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-229-gce6531c049a4/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6474324c7fa21f890b2e8664
        failing since 104 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-05-29T05:03:56.274317  + set +x
    2023-05-29T05:03:56.277407  <8>[   19.264897] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 529970_1.5.2.4.1>
    2023-05-29T05:03:56.389779  / # #
    2023-05-29T05:03:56.492588  export SHELL=3D/bin/sh
    2023-05-29T05:03:56.493291  #
    2023-05-29T05:03:56.595286  / # export SHELL=3D/bin/sh. /lava-529970/en=
vironment
    2023-05-29T05:03:56.595891  =

    2023-05-29T05:03:56.698168  / # . /lava-529970/environment/lava-529970/=
bin/lava-test-runner /lava-529970/1
    2023-05-29T05:03:56.699914  =

    2023-05-29T05:03:56.703061  / # /lava-529970/bin/lava-test-runner /lava=
-529970/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64743184889ff885192e8606

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-229-gce6531c049a4/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-229-gce6531c049a4/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64743184889ff885192e860b
        failing since 122 days (last pass: v5.10.165-76-g5c2e982fcf18, firs=
t fail: v5.10.165-77-g4600242c13ed)

    2023-05-29T05:00:40.789603  <8>[   11.036751] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3629346_1.5.2.4.1>
    2023-05-29T05:00:40.899851  / # #
    2023-05-29T05:00:41.003553  export SHELL=3D/bin/sh
    2023-05-29T05:00:41.004711  #
    2023-05-29T05:00:41.107239  / # export SHELL=3D/bin/sh. /lava-3629346/e=
nvironment
    2023-05-29T05:00:41.108439  =

    2023-05-29T05:00:41.211003  / # . /lava-3629346/environment/lava-362934=
6/bin/lava-test-runner /lava-3629346/1
    2023-05-29T05:00:41.212826  =

    2023-05-29T05:00:41.213291  / # /lava-3629346/bin/lava-test-runner /lav=
a-3629346/1<3>[   11.455103] Bluetooth: hci0: command 0x0c03 tx timeout
    2023-05-29T05:00:41.217477   =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64742f7e28c03d82532e8680

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-229-gce6531c049a4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-229-gce6531c049a4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64742f7e28c03d82532e8685
        failing since 59 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-29T04:51:57.659789  + set +x

    2023-05-29T04:51:57.666156  <8>[   10.983291] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10504833_1.4.2.3.1>

    2023-05-29T04:51:57.770525  / # #

    2023-05-29T04:51:57.871199  export SHELL=3D/bin/sh

    2023-05-29T04:51:57.871410  #

    2023-05-29T04:51:57.971922  / # export SHELL=3D/bin/sh. /lava-10504833/=
environment

    2023-05-29T04:51:57.972131  =


    2023-05-29T04:51:58.072731  / # . /lava-10504833/environment/lava-10504=
833/bin/lava-test-runner /lava-10504833/1

    2023-05-29T04:51:58.073087  =


    2023-05-29T04:51:58.077298  / # /lava-10504833/bin/lava-test-runner /la=
va-10504833/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64742f77c128a93ff12e8613

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-229-gce6531c049a4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-229-gce6531c049a4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64742f77c128a93ff12e8618
        failing since 59 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-29T04:51:57.705737  <8>[   14.134245] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10504843_1.4.2.3.1>

    2023-05-29T04:51:57.709333  + set +x

    2023-05-29T04:51:57.813798  / # #

    2023-05-29T04:51:57.914375  export SHELL=3D/bin/sh

    2023-05-29T04:51:57.914532  #

    2023-05-29T04:51:58.015041  / # export SHELL=3D/bin/sh. /lava-10504843/=
environment

    2023-05-29T04:51:58.015223  =


    2023-05-29T04:51:58.115703  / # . /lava-10504843/environment/lava-10504=
843/bin/lava-test-runner /lava-10504843/1

    2023-05-29T04:51:58.115961  =


    2023-05-29T04:51:58.120909  / # /lava-10504843/bin/lava-test-runner /la=
va-10504843/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/647433335510cee4a82e85ec

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-229-gce6531c049a4/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-229-gce6531c049a4/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/647433335510cee4a82e85f2
        failing since 76 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-29T05:07:44.338419  /lava-10505094/1/../bin/lava-test-case

    2023-05-29T05:07:44.349722  <8>[   35.059811] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/647433335510cee4a82e85f3
        failing since 76 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-29T05:07:43.302858  /lava-10505094/1/../bin/lava-test-case

    2023-05-29T05:07:43.313261  <8>[   34.023869] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6474305e9d92f1a7bf2e8633

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-229-gce6531c049a4/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-229-gce6531c049a4/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6474305e9d92f1a7bf2e8638
        failing since 116 days (last pass: v5.10.165-139-gefb57ce0f880, fir=
st fail: v5.10.165-149-ge30e8271d674)

    2023-05-29T04:55:29.300156  / # #
    2023-05-29T04:55:29.402134  export SHELL=3D/bin/sh
    2023-05-29T04:55:29.402674  #
    2023-05-29T04:55:29.504061  / # export SHELL=3D/bin/sh. /lava-3629347/e=
nvironment
    2023-05-29T04:55:29.504627  =

    2023-05-29T04:55:29.606061  / # . /lava-3629347/environment/lava-362934=
7/bin/lava-test-runner /lava-3629347/1
    2023-05-29T04:55:29.606848  =

    2023-05-29T04:55:29.610801  / # /lava-3629347/bin/lava-test-runner /lav=
a-3629347/1
    2023-05-29T04:55:29.674971  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-29T04:55:29.709723  + cd /lava-3629347/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
