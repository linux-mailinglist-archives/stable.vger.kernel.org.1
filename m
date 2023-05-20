Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BF470A602
	for <lists+stable@lfdr.de>; Sat, 20 May 2023 09:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjETHBZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 20 May 2023 03:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjETHBY (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 20 May 2023 03:01:24 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F8F1A8
        for <stable@vger.kernel.org>; Sat, 20 May 2023 00:01:22 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ae3f6e5d70so38184145ad.1
        for <stable@vger.kernel.org>; Sat, 20 May 2023 00:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684566082; x=1687158082;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U19NtcRlqmqjbr632890A4Eb1eEeKobRXMS6nP1qJKw=;
        b=MLuq7Kwdg1pZPW7FUERuPWroC9x0sceSxUNQdaqHYJQtgfpKRWu1IjY923P65/IvZ4
         ZMS0KP6tgng5lQtKjiQsQRGre1WusB4SdRY+MoXkIfxTtmEVqcL5sjRQnNxpIrEnALuK
         tlUTDHULV+n6Xa+XTh7IqVxcEo+APv0CeEYxtT7/1PglQR8G/pOeJhPdMLxoDiDPw5NH
         Rjrj3lZwR+PdRYNbZkYdu1RC16GydEWQQr0ppf6Q55vpJMqz9VYcL6g8cOvC1mNUoiN7
         jeFhyZlBJq6uYOqHfSQYs4aKsMfUcE3uGIhOsje7TQpFkxiwhH3/heE0cK/S7T1nfSLp
         fMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684566082; x=1687158082;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U19NtcRlqmqjbr632890A4Eb1eEeKobRXMS6nP1qJKw=;
        b=Jysuyt/kH70+1/90iqD10uua+SNyfmClCNifchhx1HB8t4EKijLwITw/CxagqkP1hF
         tLcR4k19rg/0JUrqpztbsmyApjkqD8395ShM5e0fCOvguAi3UslBS/idD4xd9zIF/kp4
         cvyyXNW9PZjII+BV+ZW05iszAM3lXiwTMWQEQq9mNXhqLV1WMmwSZLD4Z5Pg5xVExL3I
         Lzjth/jd2oP01E6yYBeAj+5pJLNsQ/E9eW9bUfdeXtN8rfdRUK64SfWbr/JkDa+9lF16
         GZ46nH0AUli1VOKBpWPnCIYnm2oUjeEpwLn+FDf/81H6yx8YEsbp9/OS7QQWEpbDD98V
         ATmA==
X-Gm-Message-State: AC+VfDytdTbeZsT2Rq5iHjn1JbPpLhFC73Ixhs6a8B5v4PGPunr9jxK2
        uPu4DXBJoHilg8qx09bOrgdULYoJm+iQ9VyYVLEN/w==
X-Google-Smtp-Source: ACHHUZ5oTPhAEovSorm6+oABIBxmaUX4DUjDmFJJWE5PxHiJmD2jh2caw1EbGP3YriikgXYd74ynrw==
X-Received: by 2002:a17:902:e549:b0:1a9:9a18:345c with SMTP id n9-20020a170902e54900b001a99a18345cmr5913316plf.44.1684566081724;
        Sat, 20 May 2023 00:01:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ji9-20020a170903324900b001ae1a35eb35sm754643plb.178.2023.05.20.00.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 00:01:21 -0700 (PDT)
Message-ID: <64687041.170a0220.8f7de.16e8@mx.google.com>
Date:   Sat, 20 May 2023 00:01:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.180-83-g73efc80f41a9e
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 152 runs,
 6 regressions (v5.10.180-83-g73efc80f41a9e)
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

stable-rc/queue/5.10 baseline: 152 runs, 6 regressions (v5.10.180-83-g73efc=
80f41a9e)

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
nel/v5.10.180-83-g73efc80f41a9e/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.180-83-g73efc80f41a9e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      73efc80f41a9efbc0464a7b2ca61daeea5c658c1 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64683c615dade715d82e8658

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-83-g73efc80f41a9e/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-83-g73efc80f41a9e/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64683c615dade715d82e868c
        failing since 95 days (last pass: v5.10.167-127-g921934d621e4, firs=
t fail: v5.10.167-139-gf9519a5a1701)

    2023-05-20T03:19:47.585222  + set +x
    2023-05-20T03:19:47.588971  <8>[   19.668215] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 486870_1.5.2.4.1>
    2023-05-20T03:19:47.698994  / # #
    2023-05-20T03:19:47.801503  export SHELL=3D/bin/sh
    2023-05-20T03:19:47.802218  #
    2023-05-20T03:19:47.904288  / # export SHELL=3D/bin/sh. /lava-486870/en=
vironment
    2023-05-20T03:19:47.905008  =

    2023-05-20T03:19:48.007287  / # . /lava-486870/environment/lava-486870/=
bin/lava-test-runner /lava-486870/1
    2023-05-20T03:19:48.008290  =

    2023-05-20T03:19:48.012837  / # /lava-486870/bin/lava-test-runner /lava=
-486870/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646839d822f7e71fb22e85e7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-83-g73efc80f41a9e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-83-g73efc80f41a9e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646839d822f7e71fb22e85ec
        failing since 50 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-20T03:08:57.127245  + set +x

    2023-05-20T03:08:57.133523  <8>[   10.851242] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10394596_1.4.2.3.1>

    2023-05-20T03:08:57.241257  / # #

    2023-05-20T03:08:57.343660  export SHELL=3D/bin/sh

    2023-05-20T03:08:57.344394  #

    2023-05-20T03:08:57.445786  / # export SHELL=3D/bin/sh. /lava-10394596/=
environment

    2023-05-20T03:08:57.446473  =


    2023-05-20T03:08:57.547908  / # . /lava-10394596/environment/lava-10394=
596/bin/lava-test-runner /lava-10394596/1

    2023-05-20T03:08:57.549079  =


    2023-05-20T03:08:57.553712  / # /lava-10394596/bin/lava-test-runner /la=
va-10394596/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646839909866ae3c352e85fb

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-83-g73efc80f41a9e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-83-g73efc80f41a9e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646839909866ae3c352e8600
        failing since 50 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-20T03:07:47.326667  + set +x

    2023-05-20T03:07:47.332873  <8>[   13.751943] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10394610_1.4.2.3.1>

    2023-05-20T03:07:47.438164  / # #

    2023-05-20T03:07:47.539009  export SHELL=3D/bin/sh

    2023-05-20T03:07:47.539301  #

    2023-05-20T03:07:47.639944  / # export SHELL=3D/bin/sh. /lava-10394610/=
environment

    2023-05-20T03:07:47.640216  =


    2023-05-20T03:07:47.740901  / # . /lava-10394610/environment/lava-10394=
610/bin/lava-test-runner /lava-10394610/1

    2023-05-20T03:07:47.741368  =


    2023-05-20T03:07:47.745987  / # /lava-10394610/bin/lava-test-runner /la=
va-10394610/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64683f8d725509cd7b2e85f9

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-83-g73efc80f41a9e/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-83-g73efc80f41a9e/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64683f8d725509cd7b2e85ff
        failing since 67 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-20T03:33:12.158074  /lava-10395006/1/../bin/lava-test-case

    2023-05-20T03:33:12.168803  <8>[   35.281152] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64683f8d725509cd7b2e8600
        failing since 67 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-20T03:33:11.120314  /lava-10395006/1/../bin/lava-test-case

    2023-05-20T03:33:11.131096  <8>[   34.243795] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6468398ec634816d4b2e85fe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-83-g73efc80f41a9e/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-83-g73efc80f41a9e/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6468398ec634816d4b2e8603
        failing since 107 days (last pass: v5.10.165-139-gefb57ce0f880, fir=
st fail: v5.10.165-149-ge30e8271d674)

    2023-05-20T03:07:40.842487  + set +x
    2023-05-20T03:07:40.844430  <8>[    8.576334] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3602533_1.5.2.4.1>
    2023-05-20T03:07:40.950074  / # #
    2023-05-20T03:07:41.051952  export SHELL=3D/bin/sh
    2023-05-20T03:07:41.052478  #
    2023-05-20T03:07:41.153833  / # export SHELL=3D/bin/sh. /lava-3602533/e=
nvironment
    2023-05-20T03:07:41.154381  =

    2023-05-20T03:07:41.255851  / # . /lava-3602533/environment/lava-360253=
3/bin/lava-test-runner /lava-3602533/1
    2023-05-20T03:07:41.256685  =

    2023-05-20T03:07:41.275092  / # /lava-3602533/bin/lava-test-runner /lav=
a-3602533/1 =

    ... (12 line(s) more)  =

 =20
