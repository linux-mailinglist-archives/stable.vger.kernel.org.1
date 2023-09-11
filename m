Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232A879B699
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359494AbjIKWRH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244133AbjIKTHU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 15:07:20 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749E6DD
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 12:07:14 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68fb2e9ebbfso1405976b3a.2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 12:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694459233; x=1695064033; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SmJGn82qhQQlW9OpM7nqtY5dbCWSoRvDLm5RdkQFEzI=;
        b=WCLUQvzpEg0+CrcrOxrOD3/F7QoEXi59JdQLhEQfXv7l3LDXvlhRtDmw2wyq+HGaxp
         TVuoh2kSfk2CqDmNZpBmON6a8N10czFaZEOoaASCm/pFQ8CY/BSZLSlyCdSLSH9ItXLh
         fZCvL2gvjNEK6nI4Fce/VIA+lVoW193R5VMnxPNXLyyXDDp4MrXs9rP5q2MyNzhM3vKc
         9Yp2Dj+JeVwdT4GMzt9rtihl7FJmzlo8Bt8pamdQQWvfM8a4L1JQHKP0VnSE6Cq+A15+
         58bY+DfxgQBQuYLaEIntu1ou0V4uVrZ5Goi+nCzi1mIemlkYMmvHq6gyWKxMD0xKTYpm
         HrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694459233; x=1695064033;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SmJGn82qhQQlW9OpM7nqtY5dbCWSoRvDLm5RdkQFEzI=;
        b=jdoPloBCcelo7swH0UXMexj01iufT1gJ1LP+Pqh9byszAouH7juSooTvWAOebUlX1Q
         cx/fePgnhqPHj/FDIVEOKUXNmT8mYLAf3zK8HRSVKzZ+tUVrqNuil4QFHYnvUVDFLtzB
         2WBmiGj4OcxV4ahDXGefU6sX7U6Pbc15zuEqDeT0MXlw9psSakxculRUBV5cBOuiyfGK
         Cqid6lvqZni0+qtarS4htM7t8fIECyA6O6sXSn49mb3dxkRIKjFFUS0vnTuT9lYjHbDg
         u3PYInSUX+NBzRdG9wo5oc5f1utwXTRxh5LXTcsBPjckDJM0XYr9/ho7PXZAisqXMUA8
         b4AA==
X-Gm-Message-State: AOJu0Yw8CZXcOArECXRepZQWflQt3Vh9XVms6W6nbng2KIBToRwwZq9O
        QsaL0PINxq4nHgTt+5N2KvIq4TiDetR5nbnAv4M=
X-Google-Smtp-Source: AGHT+IEH2BCPL6SCjc4xJ2eb7FiDaeYmfuhvsD7bXyTL+gOjDV8HCQ1+Dit+WuBQJVoTvIyqwZJD5A==
X-Received: by 2002:a05:6a21:3b46:b0:137:514a:984f with SMTP id zy6-20020a056a213b4600b00137514a984fmr8548355pzb.35.1694459233283;
        Mon, 11 Sep 2023 12:07:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id cw22-20020a056a00451600b0068fc6570874sm2191131pfb.9.2023.09.11.12.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 12:07:12 -0700 (PDT)
Message-ID: <64ff6560.050a0220.1d1ec.72f4@mx.google.com>
Date:   Mon, 11 Sep 2023 12:07:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.194-314-geea281d7b56d
Subject: stable-rc/linux-5.10.y baseline: 122 runs,
 9 regressions (v5.10.194-314-geea281d7b56d)
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

stable-rc/linux-5.10.y baseline: 122 runs, 9 regressions (v5.10.194-314-gee=
a281d7b56d)

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

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.194-314-geea281d7b56d/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.194-314-geea281d7b56d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      eea281d7b56dfcf274de1e29b1371964a9a4497a =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ff526ae435d2d12e286d7a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-geea281d7b56d/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-geea281d7b56d/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ff526ae435d2d12e286d83
        failing since 236 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-09-11T17:46:03.268281  <8>[   11.027521] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3770373_1.5.2.4.1>
    2023-09-11T17:46:03.377447  / # #
    2023-09-11T17:46:03.480009  export SHELL=3D/bin/sh
    2023-09-11T17:46:03.480839  #
    2023-09-11T17:46:03.582621  / # export SHELL=3D/bin/sh. /lava-3770373/e=
nvironment
    2023-09-11T17:46:03.583492  =

    2023-09-11T17:46:03.584047  / # <3>[   11.291822] Bluetooth: hci0: comm=
and 0xfc18 tx timeout
    2023-09-11T17:46:03.686128  . /lava-3770373/environment/lava-3770373/bi=
n/lava-test-runner /lava-3770373/1
    2023-09-11T17:46:03.686725  =

    2023-09-11T17:46:03.691888  / # /lava-3770373/bin/lava-test-runner /lav=
a-3770373/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ff358380cb1ac1ad286d9d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-geea281d7b56d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-geea281d7b56d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ff358380cb1ac1ad286da6
        failing since 166 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-09-11T15:44:09.420503  + set +x

    2023-09-11T15:44:09.426872  <8>[   10.102147] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11496369_1.4.2.3.1>

    2023-09-11T15:44:09.531260  / # #

    2023-09-11T15:44:09.632058  export SHELL=3D/bin/sh

    2023-09-11T15:44:09.632345  #

    2023-09-11T15:44:09.732941  / # export SHELL=3D/bin/sh. /lava-11496369/=
environment

    2023-09-11T15:44:09.733220  =


    2023-09-11T15:44:09.833877  / # . /lava-11496369/environment/lava-11496=
369/bin/lava-test-runner /lava-11496369/1

    2023-09-11T15:44:09.834293  =


    2023-09-11T15:44:09.839357  / # /lava-11496369/bin/lava-test-runner /la=
va-11496369/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ff347921d3f7b2e0286d90

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-geea281d7b56d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-geea281d7b56d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ff347921d3f7b2e0286d99
        failing since 166 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-09-11T15:38:20.457955  <8>[   12.102805] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11496389_1.4.2.3.1>

    2023-09-11T15:38:20.461218  + set +x

    2023-09-11T15:38:20.562889  #

    2023-09-11T15:38:20.563232  =


    2023-09-11T15:38:20.663943  / # #export SHELL=3D/bin/sh

    2023-09-11T15:38:20.664142  =


    2023-09-11T15:38:20.764727  / # export SHELL=3D/bin/sh. /lava-11496389/=
environment

    2023-09-11T15:38:20.764926  =


    2023-09-11T15:38:20.865496  / # . /lava-11496389/environment/lava-11496=
389/bin/lava-test-runner /lava-11496389/1

    2023-09-11T15:38:20.865849  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ff316ed898b657f2286d6f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-geea281d7b56d/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-geea281d7b56d/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ff316ed898b657f2286d72
        failing since 55 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-11T15:25:04.946820  + set +x
    2023-09-11T15:25:04.947040  <8>[   83.944292] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1007934_1.5.2.4.1>
    2023-09-11T15:25:05.053766  / # #
    2023-09-11T15:25:06.515999  export SHELL=3D/bin/sh
    2023-09-11T15:25:06.536596  #
    2023-09-11T15:25:06.536806  / # export SHELL=3D/bin/sh
    2023-09-11T15:25:08.492752  / # . /lava-1007934/environment
    2023-09-11T15:25:12.091780  /lava-1007934/bin/lava-test-runner /lava-10=
07934/1
    2023-09-11T15:25:12.112586  . /lava-1007934/environment
    2023-09-11T15:25:12.112697  / # /lava-1007934/bin/lava-test-runner /lav=
a-1007934/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ff30ce507600207d286e93

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-geea281d7b56d/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-geea281d7b56d/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ff30ce507600207d286e96
        failing since 55 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-11T15:22:24.068705  / # #
    2023-09-11T15:22:25.528726  export SHELL=3D/bin/sh
    2023-09-11T15:22:25.549191  #
    2023-09-11T15:22:25.549349  / # export SHELL=3D/bin/sh
    2023-09-11T15:22:27.502363  / # . /lava-1007925/environment
    2023-09-11T15:22:31.095829  /lava-1007925/bin/lava-test-runner /lava-10=
07925/1
    2023-09-11T15:22:31.116485  . /lava-1007925/environment
    2023-09-11T15:22:31.116614  / # /lava-1007925/bin/lava-test-runner /lav=
a-1007925/1
    2023-09-11T15:22:31.193691  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-11T15:22:31.193827  + cd /lava-1007925/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ff31bef30567a827286d6c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-geea281d7b56d/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-geea281d7b56d/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ff31bef30567a827286d6f
        failing since 55 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-11T15:26:36.746982  / # #
    2023-09-11T15:26:38.209597  export SHELL=3D/bin/sh
    2023-09-11T15:26:38.230168  #
    2023-09-11T15:26:38.230378  / # export SHELL=3D/bin/sh
    2023-09-11T15:26:40.186475  / # . /lava-1007935/environment
    2023-09-11T15:26:43.787438  /lava-1007935/bin/lava-test-runner /lava-10=
07935/1
    2023-09-11T15:26:43.809262  . /lava-1007935/environment
    2023-09-11T15:26:43.809652  / # /lava-1007935/bin/lava-test-runner /lav=
a-1007935/1
    2023-09-11T15:26:43.887301  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-11T15:26:43.887733  + cd /lava-1007935/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ff302f2777e12965286da2

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-geea281d7b56d/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-geea281d7b56d/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ff302f2777e12965286dab
        failing since 55 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-11T15:24:23.763493  / # #

    2023-09-11T15:24:23.865466  export SHELL=3D/bin/sh

    2023-09-11T15:24:23.866209  #

    2023-09-11T15:24:23.967632  / # export SHELL=3D/bin/sh. /lava-11496175/=
environment

    2023-09-11T15:24:23.968319  =


    2023-09-11T15:24:24.069634  / # . /lava-11496175/environment/lava-11496=
175/bin/lava-test-runner /lava-11496175/1

    2023-09-11T15:24:24.070589  =


    2023-09-11T15:24:24.112267  / # /lava-11496175/bin/lava-test-runner /la=
va-11496175/1

    2023-09-11T15:24:24.136027  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-11T15:24:24.136552  + cd /lav<8>[   16.405153] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11496175_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ff307238dff0c612286e1c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-geea281d7b56d/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-r=
ock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-geea281d7b56d/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-r=
ock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ff307238dff0c612286e25
        failing since 17 days (last pass: v5.10.191, first fail: v5.10.190-=
136-gda59b7b5c515e)

    2023-09-11T15:22:49.177323  / # #

    2023-09-11T15:22:50.437213  export SHELL=3D/bin/sh

    2023-09-11T15:22:50.447453  #

    2023-09-11T15:22:50.447539  / # export SHELL=3D/bin/sh

    2023-09-11T15:22:52.188194  / # . /lava-11496180/environment

    2023-09-11T15:22:55.390827  /lava-11496180/bin/lava-test-runner /lava-1=
1496180/1

    2023-09-11T15:22:55.402203  . /lava-11496180/environment

    2023-09-11T15:22:55.402532  / # /lava-11496180/bin/lava-test-runner /la=
va-11496180/1

    2023-09-11T15:22:55.459194  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-11T15:22:55.459690  + cd /lava-11496180/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ff303f2777e12965286dc6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-geea281d7b56d/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-geea281d7b56d/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ff303f2777e12965286dcf
        failing since 55 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-11T15:24:39.080980  / # #

    2023-09-11T15:24:39.181586  export SHELL=3D/bin/sh

    2023-09-11T15:24:39.181789  #

    2023-09-11T15:24:39.282291  / # export SHELL=3D/bin/sh. /lava-11496177/=
environment

    2023-09-11T15:24:39.282498  =


    2023-09-11T15:24:39.383047  / # . /lava-11496177/environment/lava-11496=
177/bin/lava-test-runner /lava-11496177/1

    2023-09-11T15:24:39.383340  =


    2023-09-11T15:24:39.427914  / # /lava-11496177/bin/lava-test-runner /la=
va-11496177/1

    2023-09-11T15:24:39.456642  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-11T15:24:39.456836  + cd /lava-1149617<8>[   18.284106] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11496177_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
