Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1AE4739075
	for <lists+stable@lfdr.de>; Wed, 21 Jun 2023 21:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjFUT5O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 21 Jun 2023 15:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjFUT5K (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Jun 2023 15:57:10 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0B3186
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 12:57:09 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b6824141b4so16331375ad.1
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 12:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687377428; x=1689969428;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C1xMHPhK4Vb37fG0pY6f3F65ga67RGL2KUIZscKeLz4=;
        b=eHzwHnN52PurJ9gX5DOqd9b4dYvNSWk+wgfW7GbQONTr1zncAUQ0WT8IvA5bJf+Aaj
         yat2pxU7dEW0J3NkYp7suz+fETof46I3FQH/jQwg5waG/HK8Z+4DkAAcUjGLEMC2DRtb
         1bgZ6Rd1RR5Elor6fKBtzLWwJSlVxG/V+CFWHYsCxEmRtUyC+b4KRwk6250s4Uxn9LaH
         TcBJBlB6JzYp4dTx/4f3AGouxkgTfegZgq67nYR12YruezlykscQ7grXPgvHehL4J3lh
         AzQOv/pz3MGCn2VcRmTplyXtcO0c5drRCbpQsWglrYhiPvB2BTjaAQlIg4F/e4fv3bSZ
         o0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687377428; x=1689969428;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C1xMHPhK4Vb37fG0pY6f3F65ga67RGL2KUIZscKeLz4=;
        b=fRRbB7uqAGFHaJsaiHneCbVw0Ex1fhgmkQ8KqxlJ1WBFWdR+SOmeKLlF3zM+ppJbx5
         ZaIkzzunuHGWR7IfVnRJLm7fCLOauF8NRyeRT6B0L1siKS7IxeSirp5moYu3kTUjTqBl
         zoL3dOqyJwwKyiabet0Hsann4Eh3JkqmDLbUMRsX4MQjR9gDhKsL2Qe071CgKZQV5qY2
         upcf5hmi1qooDJ6dJYA2als1iQr9TtcutpKeausj6nYHE2h7qFu5j7RDhrP7du23EXCG
         7DumZKppaazPhNzGSyK9xFex+3k2e0sUfy9CxCABgjoWoJBZxg/obxfE6YRG1+v29ZE3
         XdMA==
X-Gm-Message-State: AC+VfDwKGtaMwIPznMXsJQ9rxvcrJ6YmKZTOdyoe2iJWuXSAd32vCvfK
        ZYJIulrgLLwj9INwN3AoNZIUKoM3Xp2Ecyt93QXc6w==
X-Google-Smtp-Source: ACHHUZ5PcouACIZPHz8Wv6+jy1xIy/kl8UOkc22x0XM+pkfCKaMEzxnGUrBATNjxzxSucN7LoKksiA==
X-Received: by 2002:a17:903:48c:b0:1b1:99c9:8ce5 with SMTP id jj12-20020a170903048c00b001b199c98ce5mr24576402plb.16.1687377428232;
        Wed, 21 Jun 2023 12:57:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id iw13-20020a170903044d00b001aaf536b1e3sm3885315plb.123.2023.06.21.12.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:57:07 -0700 (PDT)
Message-ID: <64935613.170a0220.123a8.93bc@mx.google.com>
Date:   Wed, 21 Jun 2023 12:57:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.185
Subject: stable/linux-5.10.y baseline: 148 runs, 6 regressions (v5.10.185)
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

stable/linux-5.10.y baseline: 148 runs, 6 regressions (v5.10.185)

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

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =

rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.10.y/kernel=
/v5.10.185/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.10.y
  Describe: v5.10.185
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      ef0d5feb32ab7007d1316e9c5037cd7d9f7febbf =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64931c1217aa804c4330612f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.185/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.185/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64931c1217aa804c43306138
        failing since 153 days (last pass: v5.10.158, first fail: v5.10.164)

    2023-06-21T15:49:17.464264  <8>[   11.000692] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3683793_1.5.2.4.1>
    2023-06-21T15:49:17.571498  / # #
    2023-06-21T15:49:17.673279  export SHELL=3D/bin/sh
    2023-06-21T15:49:17.673684  #
    2023-06-21T15:49:17.774780  / # export SHELL=3D/bin/sh. /lava-3683793/e=
nvironment
    2023-06-21T15:49:17.775200  <3>[   11.212253] Bluetooth: hci0: command =
0x0c03 tx timeout
    2023-06-21T15:49:17.775461  =

    2023-06-21T15:49:17.876461  / # . /lava-3683793/environment/lava-368379=
3/bin/lava-test-runner /lava-3683793/1
    2023-06-21T15:49:17.877019  =

    2023-06-21T15:49:17.882086  / # /lava-3683793/bin/lava-test-runner /lav=
a-3683793/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64931f2d43f8cbbfc93061fc

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.185/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.185/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64931f2d43f8cbbfc9306205
        failing since 77 days (last pass: v5.10.176, first fail: v5.10.177)

    2023-06-21T16:02:37.986352  + set +x

    2023-06-21T16:02:37.992910  <8>[   10.982038] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10846447_1.4.2.3.1>

    2023-06-21T16:02:38.096910  / # #

    2023-06-21T16:02:38.197563  export SHELL=3D/bin/sh

    2023-06-21T16:02:38.197807  #

    2023-06-21T16:02:38.298345  / # export SHELL=3D/bin/sh. /lava-10846447/=
environment

    2023-06-21T16:02:38.298559  =


    2023-06-21T16:02:38.399081  / # . /lava-10846447/environment/lava-10846=
447/bin/lava-test-runner /lava-10846447/1

    2023-06-21T16:02:38.399368  =


    2023-06-21T16:02:38.403836  / # /lava-10846447/bin/lava-test-runner /la=
va-10846447/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64931b80456a315c88306162

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.185/=
arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.185/=
arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64931b80456a315c88306=
163
        failing since 12 days (last pass: v5.10.182, first fail: v5.10.183) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64932071042162f5733061ad

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.185/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.185/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64932071042162f5733061b6
        failing since 140 days (last pass: v5.10.146, first fail: v5.10.166)

    2023-06-21T16:08:10.379095  [   16.003437] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3683863_1.5.2.4.1>
    2023-06-21T16:08:10.483486  =

    2023-06-21T16:08:10.483693  / # #[   16.093402] rockchip-drm display-su=
bsystem: [drm] Cannot find any crtc or sizes
    2023-06-21T16:08:10.585215  export SHELL=3D/bin/sh
    2023-06-21T16:08:10.585692  =

    2023-06-21T16:08:10.687023  / # export SHELL=3D/bin/sh. /lava-3683863/e=
nvironment
    2023-06-21T16:08:10.687511  =

    2023-06-21T16:08:10.788913  / # . /lava-3683863/environment/lava-368386=
3/bin/lava-test-runner /lava-3683863/1
    2023-06-21T16:08:10.789657  =

    2023-06-21T16:08:10.792074  / # /lava-3683863/bin/lava-test-runner /lav=
a-3683863/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64932187a091a0b3b53061aa

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.185/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.185/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64932187a091a0b3b53061da
        failing since 140 days (last pass: v5.10.154, first fail: v5.10.166)

    2023-06-21T16:12:02.392858  + set +x
    2023-06-21T16:12:02.398676  <8>[   17.068071] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3683885_1.5.2.4.1>
    2023-06-21T16:12:02.528845  / # #
    2023-06-21T16:12:02.637096  export SHELL=3D/bin/sh
    2023-06-21T16:12:02.640227  #
    2023-06-21T16:12:02.744063  / # export SHELL=3D/bin/sh. /lava-3683885/e=
nvironment
    2023-06-21T16:12:02.746116  =

    2023-06-21T16:12:02.850118  / # . /lava-3683885/environment/lava-368388=
5/bin/lava-test-runner /lava-3683885/1
    2023-06-21T16:12:02.853156  =

    2023-06-21T16:12:02.855746  / # /lava-3683885/bin/lava-test-runner /lav=
a-3683885/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649320ebf47a0e9c183061f4

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.185/=
arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.185/=
arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649320ebf47a0e9c18306224
        failing since 140 days (last pass: v5.10.154, first fail: v5.10.166)

    2023-06-21T16:09:44.441260  + set +x
    2023-06-21T16:09:44.445144  <8>[   17.109364] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 646450_1.5.2.4.1>
    2023-06-21T16:09:44.557923  / # #
    2023-06-21T16:09:44.660312  export SHELL=3D/bin/sh
    2023-06-21T16:09:44.661260  #
    2023-06-21T16:09:44.763254  / # export SHELL=3D/bin/sh. /lava-646450/en=
vironment
    2023-06-21T16:09:44.763946  =

    2023-06-21T16:09:44.865860  / # . /lava-646450/environment/lava-646450/=
bin/lava-test-runner /lava-646450/1
    2023-06-21T16:09:44.867226  =

    2023-06-21T16:09:44.871220  / # /lava-646450/bin/lava-test-runner /lava=
-646450/1 =

    ... (12 line(s) more)  =

 =20
