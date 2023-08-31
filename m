Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FCF78EFDF
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 17:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbjHaPAB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 11:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHaO77 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 10:59:59 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B46CC5
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 07:59:55 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c0bae4da38so6008055ad.0
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 07:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693493995; x=1694098795; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=792TTYwGDJcAb5DC2Erciu+fWdbRpAgM3caaq1zh81g=;
        b=ty6H/vrpOfK9zqDnpMW1z83dQEsRWKy+ps4R8moFWt7LIaGvV1TENSfkvc+qYLkgMn
         wg4WqbWhgWuRXD6cQV7uoZ53Q1e3d6Zu0za3b+BfrREffCdGMHLycy2L/7BanGBQoXZw
         Vuc3cM2DSiM4E559j/0V0JzsxS17NK8G6H8jLcv5Iqmxy1e/0uXmc+CrwCq2bfmFArvt
         fWqR1nQQYs6ZYAM2EArAwsbu3bBMr8UxOs1Ganr2bUShNYiBIga2oRFDZzuY0oMnrUdU
         1Vf3uJcTLFo0WdV0+POwou7PwNsoE+I1spRoWwemXWghjSD2tqDntl/yYE4Wg8U4HTM4
         a+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693493995; x=1694098795;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=792TTYwGDJcAb5DC2Erciu+fWdbRpAgM3caaq1zh81g=;
        b=YqoSmV0ZFdCEQK+8gVfUg6/6+pWFL+HNI/hQgxqrynyjhHkvO8Ya+eDszxTwJm3Fow
         puiFXSX9cY8BcpbUeElnNhagEpOVXp5ADNs8B2QWvaGbq9gwmrU6FK+Adxr4d+yrByOL
         u2mRowkUvqeYENe9josLUfJHRfZBukUOWEdxsCDXYTert1N7wspf9ClwzmvF5ub8lLaD
         hOeO1W0tCf0XMUcDKyqDpVtiylggZbbb3UzQYSMZMBrBEXsma3fHVzut+GmVVBrEKUOv
         BQJ1Kv2WMsdyjVujLbk7TK9Mi2GcTt6ejOzkbZ78uZFqSooN56sUYXQWYbuoyOccWLTR
         Lsrw==
X-Gm-Message-State: AOJu0YyLBVRoDelLZfO2OZM0d5LcfUhn6gqDqHY3uqK1YxECtgBqB7Ct
        sl0ILE1so21zr8e3RTEHwA3im66zJafxulOr43c=
X-Google-Smtp-Source: AGHT+IHCQ5yEsjzGBtip8H4LemqmvCK68hIdOxgunOJ8zxT1j6H8EKQchS8NZ35D5QGvjGgSEqUzQA==
X-Received: by 2002:a17:902:e811:b0:1b8:8682:62fb with SMTP id u17-20020a170902e81100b001b8868262fbmr3532793plg.4.1693493994549;
        Thu, 31 Aug 2023 07:59:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j1-20020a170902c3c100b001bb9aadfb04sm1354720plj.220.2023.08.31.07.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 07:59:53 -0700 (PDT)
Message-ID: <64f0aae9.170a0220.2432.2da4@mx.google.com>
Date:   Thu, 31 Aug 2023 07:59:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.193
Subject: stable-rc/linux-5.10.y baseline: 95 runs, 6 regressions (v5.10.193)
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

stable-rc/linux-5.10.y baseline: 95 runs, 6 regressions (v5.10.193)

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

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.193/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.193
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      4566606fe3a43e819e0a5e00eb47deccdf5427eb =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64f075cbbefe0d7b5a286d7a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f075cbbefe0d7b5a286d83
        failing since 225 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-08-31T11:13:02.515931  <8>[   11.089855] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3757451_1.5.2.4.1>
    2023-08-31T11:13:02.625901  / # #
    2023-08-31T11:13:02.727941  export SHELL=3D/bin/sh
    2023-08-31T11:13:02.729232  #
    2023-08-31T11:13:02.729843  / # export SHELL=3D/bin/sh<3>[   11.291633]=
 Bluetooth: hci0: command 0xfc18 tx timeout
    2023-08-31T11:13:02.832351  . /lava-3757451/environment
    2023-08-31T11:13:02.833576  =

    2023-08-31T11:13:02.935942  / # . /lava-3757451/environment/lava-375745=
1/bin/lava-test-runner /lava-3757451/1
    2023-08-31T11:13:02.937636  =

    2023-08-31T11:13:02.942607  / # /lava-3757451/bin/lava-test-runner /lav=
a-3757451/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f0793c99fce0961f286d7e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f0793c99fce0961f286d87
        failing since 155 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-31T11:28:47.139321  + set +x

    2023-08-31T11:28:47.145712  <8>[   10.575968] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11389484_1.4.2.3.1>

    2023-08-31T11:28:47.253578  / # #

    2023-08-31T11:28:47.355780  export SHELL=3D/bin/sh

    2023-08-31T11:28:47.356505  #

    2023-08-31T11:28:47.457888  / # export SHELL=3D/bin/sh. /lava-11389484/=
environment

    2023-08-31T11:28:47.458650  =


    2023-08-31T11:28:47.560031  / # . /lava-11389484/environment/lava-11389=
484/bin/lava-test-runner /lava-11389484/1

    2023-08-31T11:28:47.560350  =


    2023-08-31T11:28:47.564667  / # /lava-11389484/bin/lava-test-runner /la=
va-11389484/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f079ba19ed3d4ef7286d79

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f079ba19ed3d4ef7286d82
        failing since 155 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-31T11:29:44.068550  + set +x<8>[   12.770769] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11389469_1.4.2.3.1>

    2023-08-31T11:29:44.069051  =


    2023-08-31T11:29:44.176654  #

    2023-08-31T11:29:44.178011  =


    2023-08-31T11:29:44.280045  / # #export SHELL=3D/bin/sh

    2023-08-31T11:29:44.280830  =


    2023-08-31T11:29:44.382536  / # export SHELL=3D/bin/sh. /lava-11389469/=
environment

    2023-08-31T11:29:44.383391  =


    2023-08-31T11:29:44.485092  / # . /lava-11389469/environment/lava-11389=
469/bin/lava-test-runner /lava-11389469/1

    2023-08-31T11:29:44.486467  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64f0767aef0ac56d0b286d9d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope=
-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope=
-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f0767aef0ac56d0b286da0
        failing since 44 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-31T11:15:53.670836  + set +x
    2023-08-31T11:15:53.671412  <8>[   84.056264] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1003309_1.5.2.4.1>
    2023-08-31T11:15:53.780087  / # #
    2023-08-31T11:15:55.249983  export SHELL=3D/bin/sh
    2023-08-31T11:15:55.271211  #
    2023-08-31T11:15:55.271767  / # export SHELL=3D/bin/sh
    2023-08-31T11:15:57.236918  / # . /lava-1003309/environment
    2023-08-31T11:16:00.848892  /lava-1003309/bin/lava-test-runner /lava-10=
03309/1
    2023-08-31T11:16:00.870534  . /lava-1003309/environment
    2023-08-31T11:16:00.870940  / # /lava-1003309/bin/lava-test-runner /lav=
a-1003309/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64f076ac0c9f53c726286dad

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774b1-hihope=
-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774b1-hihope=
-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f076ac0c9f53c726286db0
        failing since 44 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-31T11:16:41.148768  + set +x
    2023-08-31T11:16:41.148987  <8>[   84.145537] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1003311_1.5.2.4.1>
    2023-08-31T11:16:41.255992  / # #
    2023-08-31T11:16:42.720222  export SHELL=3D/bin/sh
    2023-08-31T11:16:42.740826  #
    2023-08-31T11:16:42.741033  / # export SHELL=3D/bin/sh
    2023-08-31T11:16:44.697885  / # . /lava-1003311/environment
    2023-08-31T11:16:48.297215  /lava-1003311/bin/lava-test-runner /lava-10=
03311/1
    2023-08-31T11:16:48.317999  . /lava-1003311/environment
    2023-08-31T11:16:48.318109  / # /lava-1003311/bin/lava-test-runner /lav=
a-1003311/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64f076c00c9f53c726286dd8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.=
txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f076c00c9f53c726286ddb
        failing since 44 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-31T11:17:07.971062  / # #
    2023-08-31T11:17:09.434034  export SHELL=3D/bin/sh
    2023-08-31T11:17:09.454607  #
    2023-08-31T11:17:09.454814  / # export SHELL=3D/bin/sh
    2023-08-31T11:17:11.410949  / # . /lava-1003308/environment
    2023-08-31T11:17:15.011628  /lava-1003308/bin/lava-test-runner /lava-10=
03308/1
    2023-08-31T11:17:15.032526  . /lava-1003308/environment
    2023-08-31T11:17:15.032637  / # /lava-1003308/bin/lava-test-runner /lav=
a-1003308/1
    2023-08-31T11:17:15.110991  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-31T11:17:15.111376  + cd /lava-1003308/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =20
