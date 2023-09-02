Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEB3790815
	for <lists+stable@lfdr.de>; Sat,  2 Sep 2023 15:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjIBNdg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 2 Sep 2023 09:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjIBNdg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 2 Sep 2023 09:33:36 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C5A90
        for <stable@vger.kernel.org>; Sat,  2 Sep 2023 06:33:32 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bc0d39b52cso20829675ad.2
        for <stable@vger.kernel.org>; Sat, 02 Sep 2023 06:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693661611; x=1694266411; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pots45bvZF9i+UWOuCtOe0kgC0ZEe2nVhGwyrxt80ko=;
        b=0CG5Pfdt5Yh5tafofXrV13e5GLBJWfr9hmWSWuBoALwxbUvNc9EbK6UPdKU+zIL/ej
         ia1S0JAIgb7xMy1ZXxbTSKZmW7BAW6dNzEBE5Mk8kM/zQI5z7aIcPiPrNfNIAIkwIQ9Y
         v/SPnj7zj1clg6enAXJFwX1EuJ0NREXl4Ry6C46rVCw7Kzx15pAdITIZ08CYkHfsjG4P
         YBFmlbjBIf3Vlp6y+aSpczSW2hRwDo39xBMOaoXqW4RkxQfML2VRSST/+cQbhxU7zw7h
         y1u9UTYSq+xE00cyl4O5KU/SGor0ijsb9bpsMvbXsyLFooRfjyqYjRK0Ytw30vWLB1RI
         /qwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693661611; x=1694266411;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pots45bvZF9i+UWOuCtOe0kgC0ZEe2nVhGwyrxt80ko=;
        b=TGMS7rnEJb4xzyJIBVFyb7yII4c1BpD8kBv01j0hMjVkJDosUyNzRNEnlbqiFR56j+
         au/8cchoKfVIb2xVPgT15OWbGlVBpZhwX0pxURrpNNPjHQQXfM+ChXE6421ogSfLD7R2
         K0fh4lezDPPRRVqs0fDcDoJDgBScy6yYZHg++XsP78FLF+JeqnwiWT9wwIHar8fHoGdV
         QPXJdS46IAEAisfM1BywMSWWAEkURVisyjP7bU4dpSdlBM/6rkF7lo8s0PhCfoXxaNO5
         urndj31WDQxvd/1M3NmebnSm/ucvmkHEKtK2RPNzgnpr65lFQJaiMNBrf6tCKdND2MFS
         ruZQ==
X-Gm-Message-State: AOJu0Yx2wPb5R9arO9hDluFRxUHYucBKIy+fDSXY+49T8+JbMmpK7qKw
        kRMbt1dRVfREYD+ArXlKU2Q+I0f5loq2n//nsro=
X-Google-Smtp-Source: AGHT+IFgi8B2oKEDRyyElUhoJVrBR2HXkEodkvKKLvSxieECs1NveB30MR5lagTVQOZzMvHXCN/tJg==
X-Received: by 2002:a17:902:da87:b0:1bb:b226:52a0 with SMTP id j7-20020a170902da8700b001bbb22652a0mr5984329plx.44.1693661611032;
        Sat, 02 Sep 2023 06:33:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902748200b001c3267ae317sm1247196pll.165.2023.09.02.06.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 06:33:30 -0700 (PDT)
Message-ID: <64f339aa.170a0220.d854e.1a2c@mx.google.com>
Date:   Sat, 02 Sep 2023 06:33:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.130
Subject: stable-rc/linux-5.15.y baseline: 121 runs, 11 regressions (v5.15.130)
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

stable-rc/linux-5.15.y baseline: 121 runs, 11 regressions (v5.15.130)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

beagle-xm                 | arm    | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig          | 1          =

cubietruck                | arm    | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig           | 1          =

fsl-ls2088a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =

hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

r8a77960-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.130/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.130
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      8f790700c974345ab78054e109beddd84539f319 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f30760fd354ae329286d7b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f30760fd354ae329286d84
        failing since 157 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-02T09:58:49.186044  <8>[   10.731692] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11410556_1.4.2.3.1>

    2023-09-02T09:58:49.189376  + set +x

    2023-09-02T09:58:49.297372  / # #

    2023-09-02T09:58:49.399947  export SHELL=3D/bin/sh

    2023-09-02T09:58:49.400735  #

    2023-09-02T09:58:49.502502  / # export SHELL=3D/bin/sh. /lava-11410556/=
environment

    2023-09-02T09:58:49.503291  =


    2023-09-02T09:58:49.605092  / # . /lava-11410556/environment/lava-11410=
556/bin/lava-test-runner /lava-11410556/1

    2023-09-02T09:58:49.606311  =


    2023-09-02T09:58:49.612711  / # /lava-11410556/bin/lava-test-runner /la=
va-11410556/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f3076afd354ae329286daa

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f3076afd354ae329286db3
        failing since 157 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-02T09:58:43.787994  <8>[   10.115143] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11410581_1.4.2.3.1>

    2023-09-02T09:58:43.791234  + set +x

    2023-09-02T09:58:43.896931  =


    2023-09-02T09:58:43.998525  / # #export SHELL=3D/bin/sh

    2023-09-02T09:58:43.998911  =


    2023-09-02T09:58:44.100039  / # export SHELL=3D/bin/sh. /lava-11410581/=
environment

    2023-09-02T09:58:44.100799  =


    2023-09-02T09:58:44.202238  / # . /lava-11410581/environment/lava-11410=
581/bin/lava-test-runner /lava-11410581/1

    2023-09-02T09:58:44.203571  =


    2023-09-02T09:58:44.208551  / # /lava-11410581/bin/lava-test-runner /la=
va-11410581/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beagle-xm                 | arm    | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f30b1e549069fa96286d91

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f30b1e549069fa96286=
d92
        failing since 38 days (last pass: v5.15.120, first fail: v5.15.122-=
79-g3bef1500d246a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
cubietruck                | arm    | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64f307ba0ddbcc219a286d6f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f307ba0ddbcc219a286d78
        failing since 228 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-09-02T10:00:10.302589  + set +x<8>[    9.959999] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3760750_1.5.2.4.1>
    2023-09-02T10:00:10.302817  =

    2023-09-02T10:00:10.408947  / # #
    2023-09-02T10:00:10.510711  export SHELL=3D/bin/sh
    2023-09-02T10:00:10.511141  #
    2023-09-02T10:00:10.612427  / # export SHELL=3D/bin/sh. /lava-3760750/e=
nvironment
    2023-09-02T10:00:10.612779  =

    2023-09-02T10:00:10.612959  / # <3>[   10.194027] Bluetooth: hci0: comm=
and 0xfc18 tx timeout
    2023-09-02T10:00:10.714015  . /lava-3760750/environment/lava-3760750/bi=
n/lava-test-runner /lava-3760750/1
    2023-09-02T10:00:10.714541   =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
fsl-ls2088a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64f307fd439bc175bc286db0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f307fd439bc175bc286db3
        failing since 50 days (last pass: v5.15.67, first fail: v5.15.119-1=
6-g66130849c020f)

    2023-09-02T10:01:26.531489  [   15.712111] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1248895_1.5.2.4.1>
    2023-09-02T10:01:26.637425  =

    2023-09-02T10:01:26.738749  / # #export SHELL=3D/bin/sh
    2023-09-02T10:01:26.739216  =

    2023-09-02T10:01:26.840207  / # export SHELL=3D/bin/sh. /lava-1248895/e=
nvironment
    2023-09-02T10:01:26.840652  =

    2023-09-02T10:01:26.941670  / # . /lava-1248895/environment/lava-124889=
5/bin/lava-test-runner /lava-1248895/1
    2023-09-02T10:01:26.942531  =

    2023-09-02T10:01:26.946178  / # /lava-1248895/bin/lava-test-runner /lav=
a-1248895/1
    2023-09-02T10:01:26.961561  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f3074c9eabc7e49a286dad

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f3074c9eabc7e49a286db6
        failing since 157 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-02T09:59:26.853630  <8>[   10.488079] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11410588_1.4.2.3.1>

    2023-09-02T09:59:26.857081  + set +x

    2023-09-02T09:59:26.958391  #

    2023-09-02T09:59:26.958660  =


    2023-09-02T09:59:27.059197  / # #export SHELL=3D/bin/sh

    2023-09-02T09:59:27.059400  =


    2023-09-02T09:59:27.159849  / # export SHELL=3D/bin/sh. /lava-11410588/=
environment

    2023-09-02T09:59:27.160051  =


    2023-09-02T09:59:27.260562  / # . /lava-11410588/environment/lava-11410=
588/bin/lava-test-runner /lava-11410588/1

    2023-09-02T09:59:27.260841  =

 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f30768557bb218ed286d88

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f30768557bb218ed286d91
        failing since 157 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-02T09:58:58.702700  + set<8>[   10.752320] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11410574_1.4.2.3.1>

    2023-09-02T09:58:58.703114   +x

    2023-09-02T09:58:58.810043  / # #

    2023-09-02T09:58:58.912135  export SHELL=3D/bin/sh

    2023-09-02T09:58:58.912905  #

    2023-09-02T09:58:59.014440  / # export SHELL=3D/bin/sh. /lava-11410574/=
environment

    2023-09-02T09:58:59.015101  =


    2023-09-02T09:58:59.116564  / # . /lava-11410574/environment/lava-11410=
574/bin/lava-test-runner /lava-11410574/1

    2023-09-02T09:58:59.117631  =


    2023-09-02T09:58:59.122456  / # /lava-11410574/bin/lava-test-runner /la=
va-11410574/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f30758ab5d85f883286da3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-len=
ovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-len=
ovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f30758ab5d85f883286dac
        failing since 157 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-02T09:58:43.359803  + <8>[   12.331177] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11410596_1.4.2.3.1>

    2023-09-02T09:58:43.359905  set +x

    2023-09-02T09:58:43.463947  / # #

    2023-09-02T09:58:43.564455  export SHELL=3D/bin/sh

    2023-09-02T09:58:43.564588  #

    2023-09-02T09:58:43.665046  / # export SHELL=3D/bin/sh. /lava-11410596/=
environment

    2023-09-02T09:58:43.665308  =


    2023-09-02T09:58:43.765841  / # . /lava-11410596/environment/lava-11410=
596/bin/lava-test-runner /lava-11410596/1

    2023-09-02T09:58:43.766186  =


    2023-09-02T09:58:43.770961  / # /lava-11410596/bin/lava-test-runner /la=
va-11410596/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a77960-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64f32e4e3046f76bd6286d70

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f32e4e3046f76bd6286d79
        failing since 44 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-09-02T12:46:19.964782  / # #

    2023-09-02T12:46:20.066945  export SHELL=3D/bin/sh

    2023-09-02T12:46:20.067661  #

    2023-09-02T12:46:20.169036  / # export SHELL=3D/bin/sh. /lava-11410623/=
environment

    2023-09-02T12:46:20.169757  =


    2023-09-02T12:46:20.271062  / # . /lava-11410623/environment/lava-11410=
623/bin/lava-test-runner /lava-11410623/1

    2023-09-02T12:46:20.271384  =


    2023-09-02T12:46:20.272687  / # /lava-11410623/bin/lava-test-runner /la=
va-11410623/1

    2023-09-02T12:46:20.337154  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-02T12:46:20.337593  + cd /lav<8>[   15.960885] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11410623_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64f307c5d49a761092286da2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f307c5d49a761092286dab
        failing since 44 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-09-02T10:00:22.808404  / # #

    2023-09-02T10:00:23.885648  export SHELL=3D/bin/sh

    2023-09-02T10:00:23.886927  #

    2023-09-02T10:00:25.370521  / # export SHELL=3D/bin/sh. /lava-11410618/=
environment

    2023-09-02T10:00:25.371793  =


    2023-09-02T10:00:28.088311  / # . /lava-11410618/environment/lava-11410=
618/bin/lava-test-runner /lava-11410618/1

    2023-09-02T10:00:28.090563  =


    2023-09-02T10:00:28.091083  / # /lava-11410618/bin/lava-test-runner /la=
va-11410618/1

    2023-09-02T10:00:28.123356  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-02T10:00:28.166482  + cd /lava-11410618/1/tes<8>[   25.531869] =
<LAVA_SIGNAL_STARTRUN 1_bootrr 11410618_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64f307a3a15b6b4764286d78

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f307a3a15b6b4764286d81
        failing since 44 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-09-02T10:01:34.721217  / # #

    2023-09-02T10:01:34.823083  export SHELL=3D/bin/sh

    2023-09-02T10:01:34.823754  #

    2023-09-02T10:01:34.925063  / # export SHELL=3D/bin/sh. /lava-11410628/=
environment

    2023-09-02T10:01:34.925758  =


    2023-09-02T10:01:35.026976  / # . /lava-11410628/environment/lava-11410=
628/bin/lava-test-runner /lava-11410628/1

    2023-09-02T10:01:35.027948  =


    2023-09-02T10:01:35.029609  / # /lava-11410628/bin/lava-test-runner /la=
va-11410628/1

    2023-09-02T10:01:35.073338  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-02T10:01:35.104535  + cd /lava-1141062<8>[   16.759888] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11410628_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
