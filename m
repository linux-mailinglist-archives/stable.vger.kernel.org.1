Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425C96F06E0
	for <lists+stable@lfdr.de>; Thu, 27 Apr 2023 15:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243284AbjD0Nv3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Apr 2023 09:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243218AbjD0Nv2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Apr 2023 09:51:28 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13574483
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 06:51:26 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a677dffb37so70255815ad.2
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 06:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682603485; x=1685195485;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=amIbjNhpZNx3qaFAawP8Hl9AneytoHpoUoI3GFrgLg0=;
        b=RZQGjY8JAob/q5EUEGywasbQKSA28YUpvxqYeJCySkJj1cY2+NyiTkiVXysFrWk9pK
         MwBuvbsO43sTqn+WFV4VXq/2eAn9e6IZdK/2RH7PmU/OlnvNWnQ0YEiiAauWszidl/B5
         kVOMwK1tnTc6ERu+Lh7aXDKE6Z18tBLW4268SLUWpNyY4Ab3vu3xFm61F4pe01ySaTMY
         2vekvitxmoVJyJ0oTJKI919VAVyxJfVUVfHK0jgGF2szv+R2NHv2mDEgQiVEFbINA8E8
         P/BRIzZmrV+8ZSF809eWLfPVW5WhM8ZybQlgfsadw+QyEYkpE54hq0a1gyD3LuRPIiYN
         nZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682603485; x=1685195485;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=amIbjNhpZNx3qaFAawP8Hl9AneytoHpoUoI3GFrgLg0=;
        b=GNevCV+K9HiDNN0FCfzpxM7OzO96WIE/nOLhS3/2LQRKVUAPoQI/TlewB+t3YbMyHX
         BoPulsKTsLFXXJVT0XuMsvjcv7wnK4gCQc+FlbVVpPE9LjPaj5+Q+Z3yMDG16Q22lGRa
         lCx/cPEZc9r4kFM9wa95jFMmLjfNL9nlAsYMiV31/PowfGGRV4GQC4fq1EDTsS9Lrw/U
         Y1rhfCnBrvWbNh5/ZlIMYhaQvioyMes14ZZNmHN43ugigWgI7sJaUUxjc9K4igZHkM3f
         fCK9pASig/SYirFXgPJUBhoEtgH7+6fqxuycYGjDbxHDUddbeX8cF/KGG8YvlKvYmrd6
         8OAw==
X-Gm-Message-State: AC+VfDyg3y2XY2Mbi7yqCRud3rC3QwcKOCYYDa/wbB247ddlh8Udr5Nz
        HWXqveYSL24FlfWzThVR8j5j7JMeniSJOtDauZKjpg==
X-Google-Smtp-Source: ACHHUZ72RgLY1fHt/Qh0RlJvKFQpA0kbKaLr8yyziEUBHQPRam4bSMHxPvMhGSQe7wEFIxHaYudEsQ==
X-Received: by 2002:a17:902:aa85:b0:1a5:22f3:220d with SMTP id d5-20020a170902aa8500b001a522f3220dmr1528674plr.49.1682603485396;
        Thu, 27 Apr 2023 06:51:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ij8-20020a170902ab4800b0019c93ee6902sm11653260plb.109.2023.04.27.06.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 06:51:24 -0700 (PDT)
Message-ID: <644a7ddc.170a0220.2c3ce.8295@mx.google.com>
Date:   Thu, 27 Apr 2023 06:51:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.176-366-ge81f84a0b890
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 133 runs,
 8 regressions (v5.10.176-366-ge81f84a0b890)
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

stable-rc/queue/5.10 baseline: 133 runs, 8 regressions (v5.10.176-366-ge81f=
84a0b890)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

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
nel/v5.10.176-366-ge81f84a0b890/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.176-366-ge81f84a0b890
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      e81f84a0b89044ae4c9111d734628a26f44bd011 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a4924a64d1c3ef12e8669

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-366-ge81f84a0b890/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-366-ge81f84a0b890/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644a4924a64d1c3ef12e8=
66a
        new failure (last pass: v5.10.176-364-g4696eda40cdc) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/644a48d4a80c07f75e2e85ff

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-366-ge81f84a0b890/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-366-ge81f84a0b890/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a48d4a80c07f75e2e8633
        failing since 72 days (last pass: v5.10.167-127-g921934d621e4, firs=
t fail: v5.10.167-139-gf9519a5a1701)

    2023-04-27T10:04:51.454460  <8>[   20.228993] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 393422_1.5.2.4.1>
    2023-04-27T10:04:51.570534  / # #
    2023-04-27T10:04:51.673088  export SHELL=3D/bin/sh
    2023-04-27T10:04:51.673838  #
    2023-04-27T10:04:51.775928  / # export SHELL=3D/bin/sh. /lava-393422/en=
vironment
    2023-04-27T10:04:51.776577  =

    2023-04-27T10:04:51.878578  / # . /lava-393422/environment/lava-393422/=
bin/lava-test-runner /lava-393422/1
    2023-04-27T10:04:51.879770  =

    2023-04-27T10:04:51.884378  / # /lava-393422/bin/lava-test-runner /lava=
-393422/1
    2023-04-27T10:04:51.980686  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644a4b04c647abf98d2e8611

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-366-ge81f84a0b890/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-366-ge81f84a0b890/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a4b04c647abf98d2e8616
        failing since 90 days (last pass: v5.10.165-76-g5c2e982fcf18, first=
 fail: v5.10.165-77-g4600242c13ed)

    2023-04-27T10:14:17.049414  + set +x<8>[   11.212691] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3536812_1.5.2.4.1>
    2023-04-27T10:14:17.049648  =

    2023-04-27T10:14:17.152847  / # #
    2023-04-27T10:14:17.254346  export SHELL=3D/bin/sh
    2023-04-27T10:14:17.254771  #
    2023-04-27T10:14:17.356084  / # export SHELL=3D/bin/sh. /lava-3536812/e=
nvironment
    2023-04-27T10:14:17.356454  =

    2023-04-27T10:14:17.457719  / # . /lava-3536812/environment/lava-353681=
2/bin/lava-test-runner /lava-3536812/1
    2023-04-27T10:14:17.458556  =

    2023-04-27T10:14:17.463966  / # /lava-3536812/bin/lava-test-runner /lav=
a-3536812/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a482a40e103bdfd2e85ed

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-366-ge81f84a0b890/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-366-ge81f84a0b890/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a482a40e103bdfd2e85f2
        failing since 27 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-04-27T10:02:10.676909  + set +x

    2023-04-27T10:02:10.683453  <8>[   10.919356] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10140953_1.4.2.3.1>

    2023-04-27T10:02:10.788086  / # #

    2023-04-27T10:02:10.888775  export SHELL=3D/bin/sh

    2023-04-27T10:02:10.888963  #

    2023-04-27T10:02:10.989471  / # export SHELL=3D/bin/sh. /lava-10140953/=
environment

    2023-04-27T10:02:10.989674  =


    2023-04-27T10:02:11.090186  / # . /lava-10140953/environment/lava-10140=
953/bin/lava-test-runner /lava-10140953/1

    2023-04-27T10:02:11.090492  =


    2023-04-27T10:02:11.095001  / # /lava-10140953/bin/lava-test-runner /la=
va-10140953/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a4810a9cc4158882e85f4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-366-ge81f84a0b890/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-366-ge81f84a0b890/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a4810a9cc4158882e85f9
        failing since 27 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-04-27T10:01:34.931067  + set +x<8>[   10.377455] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10140950_1.4.2.3.1>

    2023-04-27T10:01:34.931163  =


    2023-04-27T10:01:35.032930  #

    2023-04-27T10:01:35.133701  / # #export SHELL=3D/bin/sh

    2023-04-27T10:01:35.133887  =


    2023-04-27T10:01:35.234442  / # export SHELL=3D/bin/sh. /lava-10140950/=
environment

    2023-04-27T10:01:35.234623  =


    2023-04-27T10:01:35.335179  / # . /lava-10140950/environment/lava-10140=
950/bin/lava-test-runner /lava-10140950/1

    2023-04-27T10:01:35.335448  =


    2023-04-27T10:01:35.340567  / # /lava-10140950/bin/lava-test-runner /la=
va-10140950/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/644a47b8c93f3d89852e85eb

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-366-ge81f84a0b890/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-366-ge81f84a0b890/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/644a47b8c93f3d89852e85f1
        failing since 44 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-04-27T10:00:09.959457  <8>[   61.064402] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-04-27T10:00:10.983432  /lava-10140905/1/../bin/lava-test-case

    2023-04-27T10:00:10.994991  <8>[   62.101132] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/644a47b8c93f3d89852e85f2
        failing since 44 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-04-27T10:00:09.947245  /lava-10140905/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644a7111bde3c2e8b42e85ed

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-366-ge81f84a0b890/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-366-ge81f84a0b890/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a7111bde3c2e8b42e85f2
        failing since 84 days (last pass: v5.10.165-139-gefb57ce0f880, firs=
t fail: v5.10.165-149-ge30e8271d674)

    2023-04-27T12:56:23.141998  / # #
    2023-04-27T12:56:23.243709  export SHELL=3D/bin/sh
    2023-04-27T12:56:23.244067  #
    2023-04-27T12:56:23.345393  / # export SHELL=3D/bin/sh. /lava-3536808/e=
nvironment
    2023-04-27T12:56:23.345752  =

    2023-04-27T12:56:23.447144  / # . /lava-3536808/environment/lava-353680=
8/bin/lava-test-runner /lava-3536808/1
    2023-04-27T12:56:23.447764  =

    2023-04-27T12:56:23.453217  / # /lava-3536808/bin/lava-test-runner /lav=
a-3536808/1
    2023-04-27T12:56:23.552153  + export 'TESTRUN_ID=3D1_bootrr'
    2023-04-27T12:56:23.552649  + cd /lava-3536808/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
