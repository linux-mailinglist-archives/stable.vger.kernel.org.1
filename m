Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8671C7CAB4E
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjJPOX7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjJPOX7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:23:59 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AB29C
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:23:56 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-3512efed950so19129895ab.2
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697466236; x=1698071036; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8/telcBmeWkRpMtqgqdOrdzkNX6qZ3RKlZCKG0zvs4=;
        b=z2nyIsFohOy/H9oK/h2Kc7Nsqv0bvoQiZNd7nMDnaEk9+tybT8k4gnm4jJ1hONjDUT
         zsT4yBZhN9MVdjx0XEnGyhihhe/xae2r15PN9A/EjtnoxhOp9jZPkT0v9LRO9X/hxqPy
         TAK27ytpMTMY+VOCXiGezXaxELbRIWHGn7EXLY8Z7FuiIp3taXwBxLA3YcogDBsW4vjt
         mV9WZ9hM/hM3nskCYo+MFznbQEs7/HvbFj8wD2hU0hfjDLxnEfk/wJT/fpVTaIRjDutn
         AEChobSVeRJ8U1luO74+33mnQmqxtazaOtDfiLBekMFT73h06xXC19U3XhR0b6N9vrvg
         Nsog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697466236; x=1698071036;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q8/telcBmeWkRpMtqgqdOrdzkNX6qZ3RKlZCKG0zvs4=;
        b=eBajTQusADJjr/SZDyj3jUxWd6wobDbr6nnBYhcP8LjWjQRBDV5rWYNeeO3dulAn5Z
         BVxCKuZBvjmAGBjyBmDKnpuPXPcp4abjOdvLZpagYAa6NnpLocwspuDinfbmUNEOUKe9
         u6SwuKkPF5ZYDQU/hZH2CH0kqU6tMAV33OjHq6jv29JOr3HDbI2CKZKjEiyyHM/ySFzp
         +QcCs9zHEXo4OSzeB7CrUUcvj7vdAFDOqEFrno0dOkj+sSz7UZ6806c873khOlr4qPc3
         COmvDhM1gQz92udVteDQX3fhWyT9yd0vUKXKvZqTGOrlElTu5GnAs1hbZOHLsA0Yu3+q
         7rjA==
X-Gm-Message-State: AOJu0Yy2g2wcfyrNKXAzoY/+U2vHxWe+HJo7UoJAlLmJ7wAY1g26OI4X
        ED5IV0Y273Bb++yJbEM7+XSvhJqI8niAaGrg7PG9rA==
X-Google-Smtp-Source: AGHT+IFTYEG6u003+r7FmMrXB5nGXXJ3nRWRsdMvg2Z+nydsRSHB8s1u+o1ILExVtbHl+tOmAaIiuw==
X-Received: by 2002:a05:6e02:154d:b0:357:4ce1:6eaf with SMTP id j13-20020a056e02154d00b003574ce16eafmr18041972ilu.21.1697466235740;
        Mon, 16 Oct 2023 07:23:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b18-20020aa78112000000b006933e71956dsm18202138pfi.9.2023.10.16.07.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 07:23:55 -0700 (PDT)
Message-ID: <652d477b.a70a0220.a2ffb.365e@mx.google.com>
Date:   Mon, 16 Oct 2023 07:23:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.198-84-gf622826e6370
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.10.y baseline: 156 runs,
 7 regressions (v5.10.198-84-gf622826e6370)
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

stable-rc/linux-5.10.y baseline: 156 runs, 7 regressions (v5.10.198-84-gf62=
2826e6370)

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

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-clabbe    | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.198-84-gf622826e6370/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.198-84-gf622826e6370
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      f622826e6370c6d2feea54f778f491562a3df5d7 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652d12241bfcbf29acefcef3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-84-gf622826e6370/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-84-gf622826e6370/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652d12241bfcbf29acefcefc
        failing since 201 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-10-16T10:36:06.912177  + set +x

    2023-10-16T10:36:06.918357  <8>[   15.138812] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11789589_1.4.2.3.1>

    2023-10-16T10:36:07.026248  / # #

    2023-10-16T10:36:07.127256  export SHELL=3D/bin/sh

    2023-10-16T10:36:07.127963  #

    2023-10-16T10:36:07.229170  / # export SHELL=3D/bin/sh. /lava-11789589/=
environment

    2023-10-16T10:36:07.229458  =


    2023-10-16T10:36:07.330310  / # . /lava-11789589/environment/lava-11789=
589/bin/lava-test-runner /lava-11789589/1

    2023-10-16T10:36:07.331777  =


    2023-10-16T10:36:07.336241  / # /lava-11789589/bin/lava-test-runner /la=
va-11789589/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652d11fb280434426eefcf55

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-84-gf622826e6370/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-84-gf622826e6370/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652d11fb280434426eefcf5e
        failing since 201 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-10-16T10:35:27.722085  <8>[   13.237615] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11789525_1.4.2.3.1>

    2023-10-16T10:35:27.725132  + set +x

    2023-10-16T10:35:27.832614  / # #

    2023-10-16T10:35:27.935025  export SHELL=3D/bin/sh

    2023-10-16T10:35:27.935800  #

    2023-10-16T10:35:28.037145  / # export SHELL=3D/bin/sh. /lava-11789525/=
environment

    2023-10-16T10:35:28.037854  =


    2023-10-16T10:35:28.139238  / # . /lava-11789525/environment/lava-11789=
525/bin/lava-test-runner /lava-11789525/1

    2023-10-16T10:35:28.140663  =


    2023-10-16T10:35:28.145439  / # /lava-11789525/bin/lava-test-runner /la=
va-11789525/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/652d14f19021cc75e1efceff

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-84-gf622826e6370/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.=
txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-84-gf622826e6370/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652d14f29021cc75e1efcf3d
        failing since 25 days (last pass: v5.10.195, first fail: v5.10.195-=
84-gf147286de8e5)

    2023-10-16T10:47:46.689051  / # #
    2023-10-16T10:47:46.792031  export SHELL=3D/bin/sh
    2023-10-16T10:47:46.792801  #
    2023-10-16T10:47:46.894811  / # export SHELL=3D/bin/sh. /lava-173999/en=
vironment
    2023-10-16T10:47:46.895553  =

    2023-10-16T10:47:46.997569  / # . /lava-173999/environment/lava-173999/=
bin/lava-test-runner /lava-173999/1
    2023-10-16T10:47:46.998872  =

    2023-10-16T10:47:47.013374  / # /lava-173999/bin/lava-test-runner /lava=
-173999/1
    2023-10-16T10:47:47.072231  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-16T10:47:47.072733  + cd /lava-173999/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/652d1405583a887cc0efcfb5

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-84-gf622826e6370/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-84-gf622826e6370/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652d1405583a887cc0efcfbe
        failing since 90 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-10-16T10:48:33.874837  / # #

    2023-10-16T10:48:33.977053  export SHELL=3D/bin/sh

    2023-10-16T10:48:33.977762  #

    2023-10-16T10:48:34.079150  / # export SHELL=3D/bin/sh. /lava-11789811/=
environment

    2023-10-16T10:48:34.079909  =


    2023-10-16T10:48:34.181343  / # . /lava-11789811/environment/lava-11789=
811/bin/lava-test-runner /lava-11789811/1

    2023-10-16T10:48:34.182461  =


    2023-10-16T10:48:34.198555  / # /lava-11789811/bin/lava-test-runner /la=
va-11789811/1

    2023-10-16T10:48:34.248702  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-16T10:48:34.249213  + cd /lav<8>[   16.435373] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11789811_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/652d1439a9d6347ab0efcef4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-84-gf622826e6370/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-ro=
ck-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-84-gf622826e6370/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-ro=
ck-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652d1439a9d6347ab0efcefd
        failing since 52 days (last pass: v5.10.191, first fail: v5.10.190-=
136-gda59b7b5c515e)

    2023-10-16T10:47:23.358408  / # #

    2023-10-16T10:47:24.618415  export SHELL=3D/bin/sh

    2023-10-16T10:47:24.629371  #

    2023-10-16T10:47:24.629836  / # export SHELL=3D/bin/sh

    2023-10-16T10:47:26.371267  / # . /lava-11789804/environment

    2023-10-16T10:47:29.568075  /lava-11789804/bin/lava-test-runner /lava-1=
1789804/1

    2023-10-16T10:47:29.579087  . /lava-11789804/environment

    2023-10-16T10:47:29.579615  / # /lava-11789804/bin/lava-test-runner /la=
va-11789804/1

    2023-10-16T10:47:29.633465  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-16T10:47:29.633616  + cd /lava-11789804/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-clabbe    | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/652d1412de9bc996f9efcf01

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-84-gf622826e6370/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-84-gf622826e6370/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652d1412de9bc996f9efcf0a
        failing since 5 days (last pass: v5.10.176-224-g10e9fd53dc59, first=
 fail: v5.10.198)

    2023-10-16T10:44:10.411142  / # #
    2023-10-16T10:44:10.513186  export SHELL=3D/bin/sh
    2023-10-16T10:44:10.513935  #
    2023-10-16T10:44:10.615070  / # export SHELL=3D/bin/sh. /lava-438865/en=
vironment
    2023-10-16T10:44:10.615719  =

    2023-10-16T10:44:10.716780  / # . /lava-438865/environment/lava-438865/=
bin/lava-test-runner /lava-438865/1
    2023-10-16T10:44:10.717892  =

    2023-10-16T10:44:10.734872  / # /lava-438865/bin/lava-test-runner /lava=
-438865/1
    2023-10-16T10:44:10.750873  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-16T10:44:10.792106  + cd /lava-438865/<8>[   17.409575] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 438865_1.5.2.4.5> =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/652d1419917511427aefcf4e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-84-gf622826e6370/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-84-gf622826e6370/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652d1419917511427aefcf57
        failing since 5 days (last pass: v5.10.176-224-g10e9fd53dc59, first=
 fail: v5.10.198)

    2023-10-16T10:48:49.156071  / # #

    2023-10-16T10:48:49.257848  export SHELL=3D/bin/sh

    2023-10-16T10:48:49.258483  #

    2023-10-16T10:48:49.359675  / # export SHELL=3D/bin/sh. /lava-11789800/=
environment

    2023-10-16T10:48:49.360294  =


    2023-10-16T10:48:49.461501  / # . /lava-11789800/environment/lava-11789=
800/bin/lava-test-runner /lava-11789800/1

    2023-10-16T10:48:49.462481  =


    2023-10-16T10:48:49.464912  / # /lava-11789800/bin/lava-test-runner /la=
va-11789800/1

    2023-10-16T10:48:49.508239  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-16T10:48:49.539066  + cd /lava-1178980<8>[   18.303105] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11789800_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
