Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88D87145C7
	for <lists+stable@lfdr.de>; Mon, 29 May 2023 09:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjE2H4T (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 29 May 2023 03:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjE2H4R (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 29 May 2023 03:56:17 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE57AC
        for <stable@vger.kernel.org>; Mon, 29 May 2023 00:56:15 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b01bd7093aso15007875ad.1
        for <stable@vger.kernel.org>; Mon, 29 May 2023 00:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685346974; x=1687938974;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XcCo00b/w+ohNXvbuIJUlHPAAQ/M43ZiAc8ST58lM1M=;
        b=UDKkJwPS+zpzmL5+BRyHsWjvk7PbsobmX3vdPwr+wkBuqSmb/ccLxTtetZIIgFz8L4
         /3NieUjpWpSiUwppdEDJluRwPNeuLMC/+XzZ91x1dFEWRnz5T6ForV8wkyX355la6+Ov
         SuOXqFN84vfJpfLvd2Ch581T5q56ppe742iHvnHO3Gar+LKIP/1WqGDPYobInoywVvmi
         dzWluzWQaouMEK7dDvZREEsWDtoL4cIuqtb7WoFe4t2LqYnKi3nDELw49nWFtta2GinW
         j4Or7TEnRbXYVpawK1ktG9o5hNfEH9rzqkSMSTRpburSkzD7k0t4p5gz14A1LmQbl4Jx
         MT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685346974; x=1687938974;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XcCo00b/w+ohNXvbuIJUlHPAAQ/M43ZiAc8ST58lM1M=;
        b=ApGyZ/sh+GJPkTVTfkFipvRyU9+3fvbeehq+JID9w1lax1GOyfRIOBz4TcfMGr8ewE
         FqcxivI44G9oH5KiMZlQbSeBlFpGquoyEZPBOopkbAZ7AMR2NWeyBMk9mCECsB2p1pBi
         s8E1fnydVB28PQFmFDJYTdDus2IBhqCeognpOu7KcdSfCIAOylZih1Rk7dHsiNWUruK7
         NlFymGBkHlpHTPECVApuqJLJh++PLKKqk3Dw1vUiBlYZmfHOnb5Wnxfh/3Jwg9mne/51
         mzzvKXtnJrLHLUZVLMRjnph96uN2tR5nHm84MQJYbWEGsJNKkwIDnC1+Mou7LxN6Vpvj
         mUcw==
X-Gm-Message-State: AC+VfDyEKzXk7RfTpoRI1KEZ/DwTqfZfjIpct9yQaEGjyIEQMIbqqP4L
        xacD3LH6dbwUe11rCpzknRCDPRzHndeMgQufAlVLLA==
X-Google-Smtp-Source: ACHHUZ5YcPNgYeyTRzC3sjMjtbZ8BOCYWJg6kyC9hv3wMSmbojrh9CaVVe+Sv4RvCCGh1cKGa2HNJg==
X-Received: by 2002:a17:903:22c7:b0:1b0:49e1:7121 with SMTP id y7-20020a17090322c700b001b049e17121mr908882plg.50.1685346974440;
        Mon, 29 May 2023 00:56:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902c18400b001b04949e0acsm815353pld.232.2023.05.29.00.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 00:56:13 -0700 (PDT)
Message-ID: <64745a9d.170a0220.6f822.16a5@mx.google.com>
Date:   Mon, 29 May 2023 00:56:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.112-286-gb4a5fdb6a8b48
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 157 runs,
 10 regressions (v5.15.112-286-gb4a5fdb6a8b48)
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

stable-rc/queue/5.15 baseline: 157 runs, 10 regressions (v5.15.112-286-gb4a=
5fdb6a8b48)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | at91_dt_=
defconfig            | 1          =

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

kontron-pitx-imx8m           | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 2          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.112-286-gb4a5fdb6a8b48/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.112-286-gb4a5fdb6a8b48
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b4a5fdb6a8b486752b4d25b15e09ab72f54e59bd =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64742745a81fa517c02e8636

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-286-gb4a5fdb6a8b48/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-286-gb4a5fdb6a8b48/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64742745a81fa517c02e863b
        failing since 61 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-29T04:16:43.524441  + <8>[   11.275854] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10504077_1.4.2.3.1>

    2023-05-29T04:16:43.525019  set +x

    2023-05-29T04:16:43.633218  / # #

    2023-05-29T04:16:43.733769  export SHELL=3D/bin/sh

    2023-05-29T04:16:43.733949  #

    2023-05-29T04:16:43.834416  / # export SHELL=3D/bin/sh. /lava-10504077/=
environment

    2023-05-29T04:16:43.834604  =


    2023-05-29T04:16:43.935191  / # . /lava-10504077/environment/lava-10504=
077/bin/lava-test-runner /lava-10504077/1

    2023-05-29T04:16:43.936254  =


    2023-05-29T04:16:43.941287  / # /lava-10504077/bin/lava-test-runner /la=
va-10504077/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6474273d9eb622b1a32e85f5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-286-gb4a5fdb6a8b48/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-286-gb4a5fdb6a8b48/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6474273d9eb622b1a32e85fa
        failing since 61 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-29T04:16:39.857785  <8>[   10.498830] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10504056_1.4.2.3.1>

    2023-05-29T04:16:39.860821  + set +x

    2023-05-29T04:16:39.965189  =


    2023-05-29T04:16:40.065734  / # #export SHELL=3D/bin/sh

    2023-05-29T04:16:40.065908  =


    2023-05-29T04:16:40.166456  / # export SHELL=3D/bin/sh. /lava-10504056/=
environment

    2023-05-29T04:16:40.166687  =


    2023-05-29T04:16:40.267269  / # . /lava-10504056/environment/lava-10504=
056/bin/lava-test-runner /lava-10504056/1

    2023-05-29T04:16:40.267612  =


    2023-05-29T04:16:40.272814  / # /lava-10504056/bin/lava-test-runner /la=
va-10504056/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | at91_dt_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/647427cdf1da6351f92e85f7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-286-gb4a5fdb6a8b48/arm/at91_dt_defconfig/gcc-10/lab-broonie/baseline-at91s=
am9g20ek.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-286-gb4a5fdb6a8b48/arm/at91_dt_defconfig/gcc-10/lab-broonie/baseline-at91s=
am9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647427cdf1da6351f92e8=
5f8
        new failure (last pass: v5.15.112-231-ga29aa139444d8) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64742aa464da31ed042e8619

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-286-gb4a5fdb6a8b48/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-286-gb4a5fdb6a8b48/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64742aa464da31ed042e8=
61a
        failing since 114 days (last pass: v5.15.91-12-g3290f78df1ab, first=
 fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647428746d9a365e912e85eb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-286-gb4a5fdb6a8b48/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-286-gb4a5fdb6a8b48/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647428746d9a365e912e85f0
        failing since 131 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-29T04:22:02.625667  + set +x<8>[   10.127310] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3629112_1.5.2.4.1>
    2023-05-29T04:22:02.626379  =

    2023-05-29T04:22:02.736258  / # #
    2023-05-29T04:22:02.839952  export SHELL=3D/bin/sh
    2023-05-29T04:22:02.841018  #<3>[   10.203419] Bluetooth: hci0: command=
 0xfc18 tx timeout
    2023-05-29T04:22:02.841564  =

    2023-05-29T04:22:02.943845  / # export SHELL=3D/bin/sh. /lava-3629112/e=
nvironment
    2023-05-29T04:22:02.944920  =

    2023-05-29T04:22:03.047397  / # . /lava-3629112/environment/lava-362911=
2/bin/lava-test-runner /lava-3629112/1
    2023-05-29T04:22:03.049075   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64742783884656e8932e8614

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-286-gb4a5fdb6a8b48/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-286-gb4a5fdb6a8b48/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64742783884656e8932e8619
        failing since 61 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-29T04:17:55.985866  + <8>[   10.594301] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10504049_1.4.2.3.1>

    2023-05-29T04:17:55.986433  set +x

    2023-05-29T04:17:56.094169  / # #

    2023-05-29T04:17:56.196572  export SHELL=3D/bin/sh

    2023-05-29T04:17:56.197354  #

    2023-05-29T04:17:56.298984  / # export SHELL=3D/bin/sh. /lava-10504049/=
environment

    2023-05-29T04:17:56.299772  =


    2023-05-29T04:17:56.401318  / # . /lava-10504049/environment/lava-10504=
049/bin/lava-test-runner /lava-10504049/1

    2023-05-29T04:17:56.402598  =


    2023-05-29T04:17:56.407247  / # /lava-10504049/bin/lava-test-runner /la=
va-10504049/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64742729bca7dea59c2e85eb

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-286-gb4a5fdb6a8b48/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-286-gb4a5fdb6a8b48/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64742729bca7dea59c2e85f0
        failing since 61 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-29T04:16:28.934791  + set +x

    2023-05-29T04:16:28.941337  <8>[   10.246712] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10504078_1.4.2.3.1>

    2023-05-29T04:16:29.044011  =


    2023-05-29T04:16:29.144571  / # #export SHELL=3D/bin/sh

    2023-05-29T04:16:29.144741  =


    2023-05-29T04:16:29.245215  / # export SHELL=3D/bin/sh. /lava-10504078/=
environment

    2023-05-29T04:16:29.245412  =


    2023-05-29T04:16:29.345952  / # . /lava-10504078/environment/lava-10504=
078/bin/lava-test-runner /lava-10504078/1

    2023-05-29T04:16:29.346197  =


    2023-05-29T04:16:29.351331  / # /lava-10504078/bin/lava-test-runner /la=
va-10504078/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64742745a81fa517c02e862b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-286-gb4a5fdb6a8b48/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-286-gb4a5fdb6a8b48/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64742745a81fa517c02e8630
        failing since 61 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-29T04:16:48.005360  + set<8>[   11.391464] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10504072_1.4.2.3.1>

    2023-05-29T04:16:48.005474   +x

    2023-05-29T04:16:48.110455  / # #

    2023-05-29T04:16:48.211190  export SHELL=3D/bin/sh

    2023-05-29T04:16:48.211430  #

    2023-05-29T04:16:48.312013  / # export SHELL=3D/bin/sh. /lava-10504072/=
environment

    2023-05-29T04:16:48.312250  =


    2023-05-29T04:16:48.412813  / # . /lava-10504072/environment/lava-10504=
072/bin/lava-test-runner /lava-10504072/1

    2023-05-29T04:16:48.413186  =


    2023-05-29T04:16:48.418492  / # /lava-10504072/bin/lava-test-runner /la=
va-10504072/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-pitx-imx8m           | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 2          =


  Details:     https://kernelci.org/test/plan/id/647427a889d59f5b7f2e86b3

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-286-gb4a5fdb6a8b48/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pit=
x-imx8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-286-gb4a5fdb6a8b48/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pit=
x-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647427a889d59f5b7f2e86b6
        new failure (last pass: v5.15.112-273-gd9a33ebea341)

    2023-05-29T04:18:32.113398  / # #
    2023-05-29T04:18:32.216217  export SHELL=3D/bin/sh
    2023-05-29T04:18:32.217030  #
    2023-05-29T04:18:32.319084  / # export SHELL=3D/bin/sh. /lava-346143/en=
vironment
    2023-05-29T04:18:32.319900  =

    2023-05-29T04:18:32.421821  / # . /lava-346143/environment/lava-346143/=
bin/lava-test-runner /lava-346143/1
    2023-05-29T04:18:32.422979  =

    2023-05-29T04:18:32.439271  / # /lava-346143/bin/lava-test-runner /lava=
-346143/1
    2023-05-29T04:18:32.488093  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-29T04:18:32.488606  + cd /l<8>[   12.169673] <LAVA_SIGNAL_START=
RUN 1_bootrr 346143_1.5.2.4.5> =

    ... (10 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/647=
427a889d59f5b7f2e86c6
        new failure (last pass: v5.15.112-273-gd9a33ebea341)

    2023-05-29T04:18:34.807154  /lava-346143/1/../bin/lava-test-case
    2023-05-29T04:18:34.807646  <8>[   14.582803] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>
    2023-05-29T04:18:34.808019  /lava-346143/1/../bin/lava-test-case   =

 =20
