Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087B2741381
	for <lists+stable@lfdr.de>; Wed, 28 Jun 2023 16:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjF1OQh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 10:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjF1OQg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Jun 2023 10:16:36 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AB52947
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 07:16:34 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666683eb028so3230376b3a.0
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 07:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687961793; x=1690553793;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oaH580tXe+R1eaHJ416CdPieo4HIjHgNROhzfdwgWZs=;
        b=xPhnOtWk0pyG/oJ2ftvC93YGbAU+fL5H1Ogq2eg8Q2Mj1M1FkN8aeLIMi6LEnoJn6T
         PZyeR4SyNLQ4n6tKGnH42XoWbAJjP0kB9+1FozrF21IYZQPXDUdY8iRmObs3bDz2LE1j
         c+NHMyA31o3gy9+sF+IhIVQPiLavwqOs3ZJF6c0fFXkKHODQOm3vQHH4pAg7xb7f0Y0d
         1I5bSOLf7uZD6S17v2RNp/zCL4K0DtI33nML/ne2bmwUM1Qx9rrZql5q6OCOyOThZDwJ
         3YVR/hkqTYXIo17iXmu3WXvPbg8n4X5Rux5ict1L58R5VvrYuwrFgwhrpu05uqMOZypz
         8pug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687961793; x=1690553793;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oaH580tXe+R1eaHJ416CdPieo4HIjHgNROhzfdwgWZs=;
        b=VqGDKxtnvtayY3sGwpZl0mxNo3ZrgUrszbUQ6O0PyRPjozsMq9XrUo7ZSuUZpbB8WH
         DsCefknZLfSZezib2AL1U8yQlT4/GLzcea/aXMzS1TQenHv0a6f+B5xaRAwbWX1j6MAg
         yVl5BdLTV2xJpXe5Nes1WsN+MWrS2uwI/UnbKjiYeuALGrS/Tqb1EWZRBYBYw9C+y8F3
         VDLYUJGn+zA80U/FsCeMZk1/BK1LjXxsMJxPubpECHOe1mjWOhNUvPYxbQYI1g+SnLCl
         fcsyhShdr0D30l3bZiye0LsIcDYbPE87Syf5dR2YUoUJ8XLulluNMjeByWPtQhohn/Lb
         YzrA==
X-Gm-Message-State: AC+VfDz3OawmpktiuP/zJW4++2H4F3AlZY19rEjVOQ9iaWadVf+yllqi
        dcmMSXQ3sGkvYDaAmSOnut4q70v0qs3VLcu9WnaFyw==
X-Google-Smtp-Source: ACHHUZ7ey8X9lSLwEn7iuZJh+af25uoVjGtzuU2FYsxbFjEvyQrqUQI8bwNA5h9sbePWZ0ALjmYIuw==
X-Received: by 2002:a17:902:cec9:b0:1aa:ef83:34be with SMTP id d9-20020a170902cec900b001aaef8334bemr9234333plg.47.1687961793079;
        Wed, 28 Jun 2023 07:16:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l6-20020a170903120600b001b3acbde983sm7798187plh.3.2023.06.28.07.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 07:16:32 -0700 (PDT)
Message-ID: <649c40c0.170a0220.d1003.e974@mx.google.com>
Date:   Wed, 28 Jun 2023 07:16:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.36
Subject: stable/linux-6.1.y baseline: 121 runs, 9 regressions (v6.1.36)
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

stable/linux-6.1.y baseline: 121 runs, 9 regressions (v6.1.36)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-6.1.y/kernel/=
v6.1.36/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-6.1.y
  Describe: v6.1.36
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      a1c449d00ff8ce2c5fcea5f755df682d1f6bc2ef =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c0999abd6fb7862306188

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.36/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.36/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c0999abd6fb7862306191
        failing since 89 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-28T10:21:23.692951  <8>[    7.834031] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10935717_1.4.2.3.1>

    2023-06-28T10:21:23.697295  + set +x

    2023-06-28T10:21:23.803555  /#

    2023-06-28T10:21:23.905304   # #export SHELL=3D/bin/sh

    2023-06-28T10:21:23.905476  =


    2023-06-28T10:21:24.005930  / # export SHELL=3D/bin/sh. /lava-10935717/=
environment

    2023-06-28T10:21:24.006102  =


    2023-06-28T10:21:24.106674  / # . /lava-10935717/environment/lava-10935=
717/bin/lava-test-runner /lava-10935717/1

    2023-06-28T10:21:24.107017  =


    2023-06-28T10:21:24.112634  / # /lava-10935717/bin/lava-test-runner /la=
va-10935717/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c0991abd6fb7862306178

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.36/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.36/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c0991abd6fb7862306181
        failing since 89 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-28T10:20:54.800438  + set<8>[   11.923722] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10935705_1.4.2.3.1>

    2023-06-28T10:20:54.801047   +x

    2023-06-28T10:20:54.908895  / # #

    2023-06-28T10:20:55.011389  export SHELL=3D/bin/sh

    2023-06-28T10:20:55.012192  #

    2023-06-28T10:20:55.113811  / # export SHELL=3D/bin/sh. /lava-10935705/=
environment

    2023-06-28T10:20:55.114637  =


    2023-06-28T10:20:55.216228  / # . /lava-10935705/environment/lava-10935=
705/bin/lava-test-runner /lava-10935705/1

    2023-06-28T10:20:55.217554  =


    2023-06-28T10:20:55.222196  / # /lava-10935705/bin/lava-test-runner /la=
va-10935705/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c099b995857bca1306130

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.36/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.36/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c099b995857bca1306139
        failing since 89 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-28T10:20:54.471732  <8>[   10.064253] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10935776_1.4.2.3.1>

    2023-06-28T10:20:54.475539  + set +x

    2023-06-28T10:20:54.581764  =


    2023-06-28T10:20:54.683665  / # #export SHELL=3D/bin/sh

    2023-06-28T10:20:54.684349  =


    2023-06-28T10:20:54.785863  / # export SHELL=3D/bin/sh. /lava-10935776/=
environment

    2023-06-28T10:20:54.786733  =


    2023-06-28T10:20:54.888538  / # . /lava-10935776/environment/lava-10935=
776/bin/lava-test-runner /lava-10935776/1

    2023-06-28T10:20:54.889603  =


    2023-06-28T10:20:54.894701  / # /lava-10935776/bin/lava-test-runner /la=
va-10935776/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c0990d5c55c7cbe306195

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.36/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.36/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c0990d5c55c7cbe30619e
        failing since 89 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-28T10:20:48.739082  + set +x

    2023-06-28T10:20:48.746017  <8>[   10.281099] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10935703_1.4.2.3.1>

    2023-06-28T10:20:48.851265  / # #

    2023-06-28T10:20:48.952001  export SHELL=3D/bin/sh

    2023-06-28T10:20:48.952699  #

    2023-06-28T10:20:49.053978  / # export SHELL=3D/bin/sh. /lava-10935703/=
environment

    2023-06-28T10:20:49.054734  =


    2023-06-28T10:20:49.156267  / # . /lava-10935703/environment/lava-10935=
703/bin/lava-test-runner /lava-10935703/1

    2023-06-28T10:20:49.156601  =


    2023-06-28T10:20:49.160926  / # /lava-10935703/bin/lava-test-runner /la=
va-10935703/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c097a650b92721e306154

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.36/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.36/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c097a650b92721e30615d
        failing since 89 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-28T10:20:31.373191  <8>[    9.983911] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10935756_1.4.2.3.1>

    2023-06-28T10:20:31.376772  + set +x

    2023-06-28T10:20:31.477940  #

    2023-06-28T10:20:31.478191  =


    2023-06-28T10:20:31.578727  / # #export SHELL=3D/bin/sh

    2023-06-28T10:20:31.578916  =


    2023-06-28T10:20:31.679417  / # export SHELL=3D/bin/sh. /lava-10935756/=
environment

    2023-06-28T10:20:31.679610  =


    2023-06-28T10:20:31.780112  / # . /lava-10935756/environment/lava-10935=
756/bin/lava-test-runner /lava-10935756/1

    2023-06-28T10:20:31.780384  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c0990abd6fb7862306168

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.36/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.36/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c0990abd6fb7862306171
        failing since 89 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-28T10:20:53.922589  + set +x<8>[   11.397121] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10935695_1.4.2.3.1>

    2023-06-28T10:20:53.923171  =


    2023-06-28T10:20:54.031120  / # #

    2023-06-28T10:20:54.133863  export SHELL=3D/bin/sh

    2023-06-28T10:20:54.134665  #

    2023-06-28T10:20:54.236183  / # export SHELL=3D/bin/sh. /lava-10935695/=
environment

    2023-06-28T10:20:54.236968  =


    2023-06-28T10:20:54.338559  / # . /lava-10935695/environment/lava-10935=
695/bin/lava-test-runner /lava-10935695/1

    2023-06-28T10:20:54.339813  =


    2023-06-28T10:20:54.345042  / # /lava-10935695/bin/lava-test-runner /la=
va-10935695/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c09d3a053af455b306143

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.36/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.36/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c09d3a053af455b30614c
        failing since 89 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-28T10:21:57.312916  <8>[   11.412661] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10935693_1.4.2.3.1>

    2023-06-28T10:21:57.417865  / # #

    2023-06-28T10:21:57.518705  export SHELL=3D/bin/sh

    2023-06-28T10:21:57.518942  #

    2023-06-28T10:21:57.619532  / # export SHELL=3D/bin/sh. /lava-10935693/=
environment

    2023-06-28T10:21:57.619750  =


    2023-06-28T10:21:57.720372  / # . /lava-10935693/environment/lava-10935=
693/bin/lava-test-runner /lava-10935693/1

    2023-06-28T10:21:57.720690  =


    2023-06-28T10:21:57.726085  / # /lava-10935693/bin/lava-test-runner /la=
va-10935693/1

    2023-06-28T10:21:57.732522  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/649c0ff7d1db09d8ecd7d606

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.36/arm=
64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui-ja=
cuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.36/arm=
64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui-ja=
cuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/649c0ff7d1db09d8ecd7d626
        failing since 47 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-06-28T10:48:04.576538  /lava-10936081/1/../bin/lava-test-case

    2023-06-28T10:48:04.583297  <8>[   22.999639] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c0ff7d1db09d8ecd7d6b2
        failing since 47 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-06-28T10:47:59.179809  + set +x

    2023-06-28T10:47:59.186533  <8>[   17.601000] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10936081_1.5.2.3.1>

    2023-06-28T10:47:59.294550  / # #

    2023-06-28T10:47:59.396613  export SHELL=3D/bin/sh

    2023-06-28T10:47:59.397279  #

    2023-06-28T10:47:59.498594  / # export SHELL=3D/bin/sh. /lava-10936081/=
environment

    2023-06-28T10:47:59.499288  =


    2023-06-28T10:47:59.600469  / # . /lava-10936081/environment/lava-10936=
081/bin/lava-test-runner /lava-10936081/1

    2023-06-28T10:47:59.600801  =


    2023-06-28T10:47:59.605693  / # /lava-10936081/bin/lava-test-runner /la=
va-10936081/1
 =

    ... (13 line(s) more)  =

 =20
