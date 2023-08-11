Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D87D7791D5
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 16:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbjHKO2t (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 10:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235761AbjHKO2s (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 10:28:48 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABB02723
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 07:28:46 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bdc6867ec4so491645ad.0
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 07:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691764125; x=1692368925;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3T30rJ+qhDAhfF77GfIuD3cJhJfdLZRGdDFhD9YRfyU=;
        b=KpGDhKaznlaoa4c3kTdjyAP0BlNvgD3Z9mryulVV09XtThxM5TRuuXElnmfJ/jqlWx
         rKhx28f/fpQCZfqh3WHTfTO3j3/zg2cjmiThUpHIFaWE0M7ROgHccBN+1ufWga0Bc5w+
         /7rmSCIZkgd/r3qIu+cT1p4fYzN+j1E44b4gWIhivaYMYq2TN7it7f0lXy+NOz97Pay7
         Uk035Amq6DMBZGSXOg6Noho4rlCLTQchrPUAfh5DID/nyCjuV3mwyHi+hBjaPQ2rTDbt
         nhNlEvigaDZWdl9a2ydYovxCE8JXx6U6or7rIbeRYTwCh2vkmF1dCSTAKu6uZ+h+NZq2
         EAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691764125; x=1692368925;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3T30rJ+qhDAhfF77GfIuD3cJhJfdLZRGdDFhD9YRfyU=;
        b=ByaWsOvnoohYY6i+9uHk7KyxJkWWZ/kWt3x7J3dBbuWOhgKh3UqIDMjywv7EeR2Tyy
         nh93IGgvExRCumldBE5aWQSa4I62QoT90D+VJp9KeyTG3UgUzgWiDG89mGv3cvtOzxiZ
         iYjI2Mc5MdGOKtcLMPmPI/LqON5oiUPoptI+I1honIFs4J6MxqaG/9atJw4ZsORAfpO+
         L38qIN5GiPVSKWO0qGy4yu+FVLY8SZc9Y5Ojm3tg03TDRgg2/phlWyapTFK46dIAJwmE
         LVDqMHbcLUy9TP3gmRgUTClaRoCVT5dB1UArZbL3kTmUf8BwqrAsCuIpfeW4zf6hVqIH
         8RyA==
X-Gm-Message-State: AOJu0YwKKiZL2Psu9i++b6gId6vEZg/PiYibwSxgXQyAmv3Km5Qn2rGA
        6rSTDe8PJOG+A/YRsiDJcggKyiDvPJloMrm6vF/9xg==
X-Google-Smtp-Source: AGHT+IExn0d+hT95k0G6kUHW605SqlMSwEJIzoaRnFKFgZTKLzGqMiV5ksMeSGAaUBKGwVFq4DTftQ==
X-Received: by 2002:a17:903:11c8:b0:1bc:56c3:ebb7 with SMTP id q8-20020a17090311c800b001bc56c3ebb7mr1777067plh.20.1691764124431;
        Fri, 11 Aug 2023 07:28:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l1-20020a170903244100b001b03a1a3151sm4002436pls.70.2023.08.11.07.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 07:28:43 -0700 (PDT)
Message-ID: <64d6459b.170a0220.b026.7467@mx.google.com>
Date:   Fri, 11 Aug 2023 07:28:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.291
X-Kernelci-Tree: stable
X-Kernelci-Branch: linux-4.19.y
Subject: stable/linux-4.19.y baseline: 94 runs, 35 regressions (v4.19.291)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-4.19.y baseline: 94 runs, 35 regressions (v4.19.291)

Regressions Summary
-------------------

platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
asus-C433TA-AJ0005-rammus  | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

asus-C523NA-A20057-coral   | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

beagle-xm                  | arm    | lab-baylibre  | gcc-10   | omap2plus_=
defconfig          | 1          =

beaglebone-black           | arm    | lab-broonie   | gcc-10   | multi_v7_d=
efconfig           | 1          =

beaglebone-black           | arm    | lab-cip       | gcc-10   | omap2plus_=
defconfig          | 1          =

cubietruck                 | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =

imx6q-sabrelite            | arm    | lab-collabora | gcc-10   | multi_v7_d=
efconfig           | 1          =

imx6ul-14x14-evk           | arm    | lab-nxp       | gcc-10   | multi_v7_d=
efconfig           | 1          =

imx7d-sdb                  | arm    | lab-nxp       | gcc-10   | multi_v7_d=
efconfig           | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

r8a7796-m3ulcb             | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =

rk3288-veyron-jaq          | arm    | lab-collabora | gcc-10   | multi_v7_d=
efconfig           | 3          =

rk3399-gru-kevin           | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook   | 2          =

sun50i-a64-pine64-plus     | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =

sun50i-h6-pine-h64         | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =

zynqmp-zcu102              | arm64  | lab-cip       | gcc-10   | defconfig =
                   | 1          =

zynqmp-zcu102              | arm64  | lab-cip       | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-4.19.y/kernel=
/v4.19.291/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-4.19.y
  Describe: v4.19.291
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      fbbeed723bc5560108f32c8cf5df5a9a0b19519e =



Test Regressions
---------------- =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
asus-C433TA-AJ0005-rammus  | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d613101771d6d86535b1fd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d613101771d6d86535b202
        failing since 204 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-08-11T10:53:23.130513  + set +x

    2023-08-11T10:53:23.137301  <8>[   10.857751] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11261568_1.4.2.3.1>

    2023-08-11T10:53:23.242135  / # #

    2023-08-11T10:53:23.342890  export SHELL=3D/bin/sh

    2023-08-11T10:53:23.343118  #

    2023-08-11T10:53:23.443655  / # export SHELL=3D/bin/sh. /lava-11261568/=
environment

    2023-08-11T10:53:23.443875  =


    2023-08-11T10:53:23.544419  / # . /lava-11261568/environment/lava-11261=
568/bin/lava-test-runner /lava-11261568/1

    2023-08-11T10:53:23.544813  =


    2023-08-11T10:53:23.550092  / # /lava-11261568/bin/lava-test-runner /la=
va-11261568/1
 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
asus-C523NA-A20057-coral   | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d6130edeba6ab77c35b1fe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d6130edeba6ab77c35b203
        failing since 204 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-08-11T10:52:52.517339  + <8>[   12.006111] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11261565_1.4.2.3.1>

    2023-08-11T10:52:52.517451  set +x

    2023-08-11T10:52:52.618906  #

    2023-08-11T10:52:52.719661  / # #export SHELL=3D/bin/sh

    2023-08-11T10:52:52.719878  =


    2023-08-11T10:52:52.820413  / # export SHELL=3D/bin/sh. /lava-11261565/=
environment

    2023-08-11T10:52:52.820619  =


    2023-08-11T10:52:52.921108  / # . /lava-11261565/environment/lava-11261=
565/bin/lava-test-runner /lava-11261565/1

    2023-08-11T10:52:52.921446  =


    2023-08-11T10:52:52.963485  / # /lava-11261565/bin/lava-test-runner /la=
va-11261565/1
 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
beagle-xm                  | arm    | lab-baylibre  | gcc-10   | omap2plus_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d613cfa298ea1b0d35b225

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d613cfa298ea1b0d35b22a
        failing since 199 days (last pass: v4.19.268, first fail: v4.19.271)

    2023-08-11T10:55:59.262710  + set +x<8>[   25.303649] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3736632_1.5.2.4.1>
    2023-08-11T10:55:59.263497  =

    2023-08-11T10:55:59.377060  / # #
    2023-08-11T10:55:59.481187  export SHELL=3D/bin/sh
    2023-08-11T10:55:59.482432  #
    2023-08-11T10:55:59.584990  / # export SHELL=3D/bin/sh. /lava-3736632/e=
nvironment
    2023-08-11T10:55:59.586243  =

    2023-08-11T10:55:59.688932  / # . /lava-3736632/environment/lava-373663=
2/bin/lava-test-runner /lava-3736632/1
    2023-08-11T10:55:59.690872  =

    2023-08-11T10:55:59.696593  / # /lava-3736632/bin/lava-test-runner /lav=
a-3736632/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
beaglebone-black           | arm    | lab-broonie   | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d614e5370d0a66b735b204

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d614e5370d0a66b735b22f
        failing since 204 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-08-11T11:00:16.118577  <8>[   23.303710] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 45318_1.5.2.4.1>
    2023-08-11T11:00:16.227292  / # #
    2023-08-11T11:00:16.330489  export SHELL=3D/bin/sh
    2023-08-11T11:00:16.331448  #
    2023-08-11T11:00:16.433927  / # export SHELL=3D/bin/sh. /lava-45318/env=
ironment
    2023-08-11T11:00:16.434879  =

    2023-08-11T11:00:16.537362  / # . /lava-45318/environment/lava-45318/bi=
n/lava-test-runner /lava-45318/1
    2023-08-11T11:00:16.538807  =

    2023-08-11T11:00:16.542112  / # /lava-45318/bin/lava-test-runner /lava-=
45318/1
    2023-08-11T11:00:16.610625  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
beaglebone-black           | arm    | lab-cip       | gcc-10   | omap2plus_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d614ca1cbea7123e35b227

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d614ca1cbea7123e35b=
228
        new failure (last pass: v4.19.288) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
cubietruck                 | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d614c02410d1226135b226

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d614c02410d1226135b22b
        failing since 204 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-08-11T11:00:03.548576  <8>[    7.374196] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3736683_1.5.2.4.1>
    2023-08-11T11:00:03.658127  / # #
    2023-08-11T11:00:03.761392  export SHELL=3D/bin/sh
    2023-08-11T11:00:03.762427  #
    2023-08-11T11:00:03.864585  / # export SHELL=3D/bin/sh. /lava-3736683/e=
nvironment
    2023-08-11T11:00:03.865538  =

    2023-08-11T11:00:03.967684  / # . /lava-3736683/environment/lava-373668=
3/bin/lava-test-runner /lava-3736683/1
    2023-08-11T11:00:03.969279  =

    2023-08-11T11:00:03.974248  / # /lava-3736683/bin/lava-test-runner /lav=
a-3736683/1
    2023-08-11T11:00:04.049783  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
imx6q-sabrelite            | arm    | lab-collabora | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d614cfd6d491f37735b1dd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d614cfd6d491f37735b1e2
        failing since 204 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-08-11T11:00:45.948527  / # #

    2023-08-11T11:00:46.050693  export SHELL=3D/bin/sh

    2023-08-11T11:00:46.051407  #

    2023-08-11T11:00:46.152831  / # export SHELL=3D/bin/sh. /lava-11261739/=
environment

    2023-08-11T11:00:46.153543  =


    2023-08-11T11:00:46.255007  / # . /lava-11261739/environment/lava-11261=
739/bin/lava-test-runner /lava-11261739/1

    2023-08-11T11:00:46.256104  =


    2023-08-11T11:00:46.272519  / # /lava-11261739/bin/lava-test-runner /la=
va-11261739/1

    2023-08-11T11:00:46.356437  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-11T11:00:46.356951  + cd /lava-11261739/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
imx6ul-14x14-evk           | arm    | lab-nxp       | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d614e4370d0a66b735b1f9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d614e4370d0a66b735b1fc
        failing since 146 days (last pass: v4.19.260, first fail: v4.19.278)

    2023-08-11T11:00:36.713001  + set +x<8>[   22.827284] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1242808_1.5.2.4.1>
    2023-08-11T11:00:36.713298  =

    2023-08-11T11:00:36.823708  / # #
    2023-08-11T11:00:37.979611  export SHELL=3D/bin/sh
    2023-08-11T11:00:37.985315  #
    2023-08-11T11:00:39.527350  / # export SHELL=3D/bin/sh. /lava-1242808/e=
nvironment
    2023-08-11T11:00:39.533073  =

    2023-08-11T11:00:42.345318  / # . /lava-1242808/environment/lava-124280=
8/bin/lava-test-runner /lava-1242808/1
    2023-08-11T11:00:42.351323  =

    2023-08-11T11:00:42.352913  / # /lava-1242808/bin/lava-test-runner /lav=
a-1242808/1 =

    ... (15 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
imx7d-sdb                  | arm    | lab-nxp       | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d614d11cbea7123e35b22e

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d614d11cbea7123e35b231
        failing since 204 days (last pass: v4.19.267, first fail: v4.19.270)

    2023-08-11T11:00:11.084117  / # #
    2023-08-11T11:00:12.240128  export SHELL=3D/bin/sh
    2023-08-11T11:00:12.245767  #
    2023-08-11T11:00:13.788103  / # export SHELL=3D/bin/sh. /lava-1242807/e=
nvironment
    2023-08-11T11:00:13.793745  =

    2023-08-11T11:00:16.606321  / # . /lava-1242807/environment/lava-124280=
7/bin/lava-test-runner /lava-1242807/1
    2023-08-11T11:00:16.612281  =

    2023-08-11T11:00:16.625646  / # /lava-1242807/bin/lava-test-runner /lav=
a-1242807/1
    2023-08-11T11:00:16.720528  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-11T11:00:16.720910  + cd /lava-1242807/1/tests/1_bootrr =

    ... (16 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d6177963edf32b3d35b1e7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d6177963edf32b3d35b=
1e8
        failing since 339 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d618e176adaed5cc35b1f9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d618e176adaed5cc35b=
1fa
        failing since 377 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d615d3ca995cf2a535b210

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d615d3ca995cf2a535b=
211
        failing since 339 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d616c2789345e96035b1ec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d616c2789345e96035b=
1ed
        failing since 377 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d616e3ccba6efb5e35b1e8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d616e3ccba6efb5e35b=
1e9
        failing since 339 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d618f541fef05c7135b1f5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d618f541fef05c7135b=
1f6
        failing since 377 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d615d2f749238d3235b2d6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d615d2f749238d3235b=
2d7
        failing since 339 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d616feccba6efb5e35b1ec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d616feccba6efb5e35b=
1ed
        failing since 377 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d61765d77ac9568035b1f7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d61765d77ac9568035b=
1f8
        failing since 339 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d61909fc30e667b935b1db

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d61909fc30e667b935b=
1dc
        failing since 377 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d615df476f3f59fa35b1d9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d615df476f3f59fa35b=
1da
        failing since 339 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d616cf789345e96035b1f3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d616cf789345e96035b=
1f4
        failing since 377 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d616d8789345e96035b1f9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d616d8789345e96035b=
1fa
        failing since 339 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d618d776adaed5cc35b1f2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d618d776adaed5cc35b=
1f3
        failing since 377 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d615caca995cf2a535b20a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d615caca995cf2a535b=
20b
        failing since 339 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d616d6ccba6efb5e35b1de

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d616d6ccba6efb5e35b=
1df
        failing since 377 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
r8a7796-m3ulcb             | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d62a03de04ba354635b2be

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7796-m3ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7796-m3ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d62a03de04ba354635b2c3
        failing since 204 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-08-11T12:32:31.328938  / # #

    2023-08-11T12:32:31.431085  export SHELL=3D/bin/sh

    2023-08-11T12:32:31.431821  #

    2023-08-11T12:32:31.533219  / # export SHELL=3D/bin/sh. /lava-11261644/=
environment

    2023-08-11T12:32:31.533951  =


    2023-08-11T12:32:31.635367  / # . /lava-11261644/environment/lava-11261=
644/bin/lava-test-runner /lava-11261644/1

    2023-08-11T12:32:31.636504  =


    2023-08-11T12:32:31.653164  / # /lava-11261644/bin/lava-test-runner /la=
va-11261644/1

    2023-08-11T12:32:31.702955  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-11T12:32:31.703446  + cd /lav<8>[   13.148545] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11261644_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
rk3288-veyron-jaq          | arm    | lab-collabora | gcc-10   | multi_v7_d=
efconfig           | 3          =


  Details:     https://kernelci.org/test/plan/id/64d6155a5ebedf3f3835b20f

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64d6155a5ebedf3f3835b23f
        failing since 203 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-08-11T11:04:04.713970  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   10.500169] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-08-11T11:04:04.717540   multi-call binary.

    2023-08-11T11:04:04.717594  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64d6155a5ebedf3f3835b240
        failing since 203 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-08-11T11:04:04.695270  /lava-11261743/1/../bin/lava-test-case<8>[ =
  10.482728] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-probed RE=
SULT=3Dpass>

    2023-08-11T11:04:04.695319  =

   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d6155a5ebedf3f3835b253
        failing since 203 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-08-11T11:04:00.865376  <8>[    6.652875] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-08-11T11:04:00.874630  + <8>[    6.665005] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11261743_1.5.2.3.1>

    2023-08-11T11:04:00.877155  set +x

    2023-08-11T11:04:00.981622  =


    2023-08-11T11:04:01.083153  / # #export SHELL=3D/bin/sh

    2023-08-11T11:04:01.083849  =


    2023-08-11T11:04:01.185221  / # export SHELL=3D/bin/sh. /lava-11261743/=
environment

    2023-08-11T11:04:01.185914  =


    2023-08-11T11:04:01.287356  / # . /lava-11261743/environment/lava-11261=
743/bin/lava-test-runner /lava-11261743/1

    2023-08-11T11:04:01.288421  =

 =

    ... (17 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
rk3399-gru-kevin           | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64d6147ef7ca766bfa35b1f5

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64d6147ef7ca766bfa35b1fb
        failing since 146 days (last pass: v4.19.277, first fail: v4.19.278)

    2023-08-11T10:59:03.232814  /lava-11261725/1/../bin/lava-test-case<8>[ =
  35.479407] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drockchip-usb2phy0-probed =
RESULT=3Dfail>

    2023-08-11T10:59:03.233373  =

   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64d6147ef7ca766bfa35b1fc
        failing since 146 days (last pass: v4.19.277, first fail: v4.19.278=
) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
sun50i-a64-pine64-plus     | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d61412bc7fe3217035b1e9

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d61412bc7fe3217035b20e
        failing since 204 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-08-11T10:56:44.140137  <8>[   15.910941] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 45264_1.5.2.4.1>
    2023-08-11T10:56:44.245482  / # #
    2023-08-11T10:56:44.347494  export SHELL=3D/bin/sh
    2023-08-11T10:56:44.348070  #
    2023-08-11T10:56:44.449503  / # export SHELL=3D/bin/sh. /lava-45264/env=
ironment
    2023-08-11T10:56:44.450067  =

    2023-08-11T10:56:44.551477  / # . /lava-45264/environment/lava-45264/bi=
n/lava-test-runner /lava-45264/1
    2023-08-11T10:56:44.552156  =

    2023-08-11T10:56:44.556206  / # /lava-45264/bin/lava-test-runner /lava-=
45264/1
    2023-08-11T10:56:44.587610  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
sun50i-h6-pine-h64         | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d613f2bd6e8f5bfb35b1db

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d613f2bd6e8f5bfb35b1e0
        failing since 204 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-08-11T10:58:11.104745  / # #

    2023-08-11T10:58:11.207005  export SHELL=3D/bin/sh

    2023-08-11T10:58:11.207723  #

    2023-08-11T10:58:11.309047  / # export SHELL=3D/bin/sh. /lava-11261645/=
environment

    2023-08-11T10:58:11.309779  =


    2023-08-11T10:58:11.411222  / # . /lava-11261645/environment/lava-11261=
645/bin/lava-test-runner /lava-11261645/1

    2023-08-11T10:58:11.412278  =


    2023-08-11T10:58:11.428645  / # /lava-11261645/bin/lava-test-runner /la=
va-11261645/1

    2023-08-11T10:58:11.486712  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-11T10:58:11.487212  + cd /lava-1126164<8>[   15.626648] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11261645_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
zynqmp-zcu102              | arm64  | lab-cip       | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d613dbd8e0b1144135b20d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d613dbd8e0b1144135b210
        failing since 204 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-08-11T10:56:18.285801  + set +x
    2023-08-11T10:56:18.287794  <8>[    3.750688] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 995509_1.5.2.4.1>
    2023-08-11T10:56:18.394016  / # #
    2023-08-11T10:56:18.495395  export SHELL=3D/bin/sh
    2023-08-11T10:56:18.495719  #
    2023-08-11T10:56:18.596565  / # export SHELL=3D/bin/sh. /lava-995509/en=
vironment
    2023-08-11T10:56:18.596903  =

    2023-08-11T10:56:18.697912  / # . /lava-995509/environment/lava-995509/=
bin/lava-test-runner /lava-995509/1
    2023-08-11T10:56:18.698465  =

    2023-08-11T10:56:18.701744  / # /lava-995509/bin/lava-test-runner /lava=
-995509/1 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
zynqmp-zcu102              | arm64  | lab-cip       | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d6157e132ebd22e235b207

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.291/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d6157e132ebd22e235b20a
        failing since 204 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-08-11T11:03:06.215414  <8>[    3.721159] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 995512_1.5.2.4.1>
    2023-08-11T11:03:06.321304  / # #
    2023-08-11T11:03:06.423430  export SHELL=3D/bin/sh
    2023-08-11T11:03:06.423912  #
    2023-08-11T11:03:06.525276  / # export SHELL=3D/bin/sh. /lava-995512/en=
vironment
    2023-08-11T11:03:06.525639  =

    2023-08-11T11:03:06.626702  / # . /lava-995512/environment/lava-995512/=
bin/lava-test-runner /lava-995512/1
    2023-08-11T11:03:06.627219  =

    2023-08-11T11:03:06.630349  / # /lava-995512/bin/lava-test-runner /lava=
-995512/1
    2023-08-11T11:03:06.667409  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =20
