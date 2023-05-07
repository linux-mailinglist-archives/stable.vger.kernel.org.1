Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599BA6F9B1E
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 21:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjEGTOm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 15:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjEGTOi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 15:14:38 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6590B3C33
        for <stable@vger.kernel.org>; Sun,  7 May 2023 12:14:34 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1aaff9c93a5so24928815ad.2
        for <stable@vger.kernel.org>; Sun, 07 May 2023 12:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683486873; x=1686078873;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A7lcBRTNjdxW1lQnmeFr/QUJqVTmuMnv1Xgcm6dxMko=;
        b=MP4VOK53OmxJPLnNPMlVEq/93k25Z0MxOwbm1VVzGY70ezyVo86joH+CLnr1ixgofR
         gH1j52BbTQbeaTKJcaLgLr3ACaNuQznA2oqqYyjLd6WcxFDHQ25TcLG9n/fPgugV0ISg
         azoxFhPMyQxD1+E2pLJEfVY43WH0OsnS0nyP8H0hKYy7wO1EKe7ohKM0r9PorwiJ3ty4
         qF/h41YUMdqeyGd9A/HMFx/VT1iQImEJMjl3u9v3QhjqMHvv6u198uVKz3fcPk5GOVCd
         ALvppkn87FVfNldbCbskNs5cKpx4sc/bHWqFCqtMKeS+7OOMqBsv2kBqF5URfNewadA+
         1krA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683486873; x=1686078873;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7lcBRTNjdxW1lQnmeFr/QUJqVTmuMnv1Xgcm6dxMko=;
        b=UByq4ioVkCydKM9nU/oORgDBjRPv7atVj6GkL/WNQXRzHMJHrJQXvX1GeNwCau40I1
         6vVV7yP0HBvvcgkiqaXgGJdolFX4iYUlTK6/Ul/Fflat3hyPOixjGyhnGRAFAW1Rmtgv
         O2nwgrXNJzeUcApT2KETAZcN0oqOFf9JtBaDG6HAJRUpkmK0++96YfckM6JdjlMI6Y+w
         4WxGgeWBzSnriix9yRe4+FJGBjWSYdNfKt/zpkVuGqmKidXv30AgXD1xy6Rxa4UOOalG
         1GM/jchQ0EGV4k+K9RiE7SBNTiLwaH+2KFg8T50XVnEDEn2+blcXWIQ7ia1GTo7x/bAF
         nGLQ==
X-Gm-Message-State: AC+VfDxr2cgmA2wp0Qf9nJLvIk3ztnBaoz8/ZnYu5ZLW4mIhYH1+W5gr
        aswbKTYhoPhv8WkpjnRvWbKiDGE1nv7SX1xaqWF6ZA==
X-Google-Smtp-Source: ACHHUZ7sVhLmGyKr4ux0MPFjQFBfEXHuFCoiz4I9LvOIUn3LP6lBCWFlZ1OW3Sr4MlfEVv64Tysb/w==
X-Received: by 2002:a17:903:183:b0:1ac:7260:80a7 with SMTP id z3-20020a170903018300b001ac726080a7mr2152211plg.43.1683486873300;
        Sun, 07 May 2023 12:14:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902740200b001aaf2172418sm5422567pll.95.2023.05.07.12.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 12:14:32 -0700 (PDT)
Message-ID: <6457f898.170a0220.ca76f.94ab@mx.google.com>
Date:   Sun, 07 May 2023 12:14:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.176-651-g9f10a95a08702
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.10.y baseline: 167 runs,
 6 regressions (v5.10.176-651-g9f10a95a08702)
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

stable-rc/linux-5.10.y baseline: 167 runs, 6 regressions (v5.10.176-651-g9f=
10a95a08702)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.176-651-g9f10a95a08702/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.176-651-g9f10a95a08702
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      9f10a95a0870290a1fe0451f8a771f471e248a05 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457c68378e414c6172e860c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
76-651-g9f10a95a08702/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
76-651-g9f10a95a08702/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457c68378e414c6172e8611
        failing since 39 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-05-07T15:40:42.845639  + set +x

    2023-05-07T15:40:42.851445  <8>[   15.042913] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10229422_1.4.2.3.1>

    2023-05-07T15:40:42.956848  / # #

    2023-05-07T15:40:43.058948  export SHELL=3D/bin/sh

    2023-05-07T15:40:43.059650  #

    2023-05-07T15:40:43.161029  / # export SHELL=3D/bin/sh. /lava-10229422/=
environment

    2023-05-07T15:40:43.161731  =


    2023-05-07T15:40:43.263048  / # . /lava-10229422/environment/lava-10229=
422/bin/lava-test-runner /lava-10229422/1

    2023-05-07T15:40:43.263329  =


    2023-05-07T15:40:43.268091  / # /lava-10229422/bin/lava-test-runner /la=
va-10229422/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457c684d1e0ebd9322e85f1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
76-651-g9f10a95a08702/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
76-651-g9f10a95a08702/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457c684d1e0ebd9322e85f6
        failing since 39 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-05-07T15:40:37.948847  + set +x<8>[   16.061680] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10229417_1.4.2.3.1>

    2023-05-07T15:40:37.949434  =


    2023-05-07T15:40:38.057109  #

    2023-05-07T15:40:38.160256  / # #export SHELL=3D/bin/sh

    2023-05-07T15:40:38.161045  =


    2023-05-07T15:40:38.262784  / # export SHELL=3D/bin/sh. /lava-10229417/=
environment

    2023-05-07T15:40:38.263630  =


    2023-05-07T15:40:38.365402  / # . /lava-10229417/environment/lava-10229=
417/bin/lava-test-runner /lava-10229417/1

    2023-05-07T15:40:38.366744  =


    2023-05-07T15:40:38.371915  / # /lava-10229417/bin/lava-test-runner /la=
va-10229417/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6457c602bdaddefac42e862d

  Results:     62 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
76-651-g9f10a95a08702/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-=
rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
76-651-g9f10a95a08702/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-=
rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cros-ec-keyb-probed: https://kernelci.org/test/case/id/=
6457c602bdaddefac42e865d
        new failure (last pass: v5.10.176-373-g8415c0f9308b)

    2023-05-07T15:38:15.147025  /lava-10229324/1/../bin/lava-test-case<8>[ =
  18.711502] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dcros-ec-keyb-driver-prese=
nt RESULT=3Dpass>

    2023-05-07T15:38:15.147246  =


    2023-05-07T15:38:16.159168  /lava-10229324/1/../bin/lava-test-case

    2023-05-07T15:38:16.166796  <8>[   19.732476] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-keyb-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6457c7dc8bb788c51c2e85e9

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
76-651-g9f10a95a08702/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
76-651-g9f10a95a08702/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6457c7dc8bb788c51c2e85ef
        failing since 54 days (last pass: v5.10.173, first fail: v5.10.173-=
4-g955623617f2f)

    2023-05-07T15:46:14.032034  <8>[   33.942082] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-05-07T15:46:15.056528  /lava-10229458/1/../bin/lava-test-case

    2023-05-07T15:46:15.066797  <8>[   34.977694] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6457c7dc8bb788c51c2e85f0
        failing since 54 days (last pass: v5.10.173, first fail: v5.10.173-=
4-g955623617f2f)

    2023-05-07T15:46:14.020165  /lava-10229458/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6457c80ed633099ec92e85eb

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
76-651-g9f10a95a08702/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a=
64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
76-651-g9f10a95a08702/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a=
64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457c80ed633099ec92e8617
        failing since 96 days (last pass: v5.10.158-107-g6b6a42c25ed4, firs=
t fail: v5.10.165-144-g930bc29c79c4)

    2023-05-07T15:46:52.342319  + set +x
    2023-05-07T15:46:52.346449  <8>[   17.157281] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3561039_1.5.2.4.1>
    2023-05-07T15:46:52.466642  / # #
    2023-05-07T15:46:52.572295  export SHELL=3D/bin/sh
    2023-05-07T15:46:52.574097  #
    2023-05-07T15:46:52.677739  / # export SHELL=3D/bin/sh. /lava-3561039/e=
nvironment
    2023-05-07T15:46:52.679349  =

    2023-05-07T15:46:52.783047  / # . /lava-3561039/environment/lava-356103=
9/bin/lava-test-runner /lava-3561039/1
    2023-05-07T15:46:52.786235  =

    2023-05-07T15:46:52.789246  / # /lava-3561039/bin/lava-test-runner /lav=
a-3561039/1 =

    ... (12 line(s) more)  =

 =20
