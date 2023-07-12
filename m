Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D8F74FD0D
	for <lists+stable@lfdr.de>; Wed, 12 Jul 2023 04:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjGLC24 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 22:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGLC2z (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 22:28:55 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADBB1720
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 19:28:52 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666edfc50deso178635b3a.0
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 19:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689128931; x=1691720931;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1ipXmlAYAetodj7Sw7pa3sof+a3/o682AemGEHuqIyw=;
        b=DuQ9AKzXWznKhJ4SRseVs4WTjaiVu8wNirftcwrxhNXAplFEtYpv32em3tzvDl6Y8J
         XVm94UfYZCFRvalJMz845iTqXowMdtRPBtPweJ/s5sckoixXyLvZ0nYKjl9rop0QeSRy
         PMgqkYTzIhQkFyaERXhbXz2MPoCjIFiiKzCuQcjXMYxtAl/yChcImNv/h9k95QPdBHG3
         jpHrf9F8WKxQ8MKDr/HVJ6yOUxOR2mZ78PILf5slB4ZtHZd2Cmb4iJBsmq9bDaioYPig
         uLWhqKi6arNWeI7Yducmm+92QtYoTHqu7GZ9bJ2Nvd8q2St9L0d/lMbYbxDs/fmT7gI+
         gPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689128931; x=1691720931;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ipXmlAYAetodj7Sw7pa3sof+a3/o682AemGEHuqIyw=;
        b=c7wD6tIPMKmkvW0QzgQCmbyTtr3CFteSdW5giaJz+8Sk0/ibPL5BE0qrSHHXp+z1eJ
         gy7+zsLTA6NPwRoFemRRBwPO22j4vxbawjKUgE29T3ESH17Qx+BCLFGM/Q1Zv/JxQuZR
         MBrkeQEMRTHWDYuvEe77cvCjr1Cg30T2FeTJMaIoMgN4l12W5ix1YlRvpxatZA5HX52g
         NIm4aRoifk44XhhkxIDUfAh3ZbY1GLaBHcMAwBMUpCXbaYjU5+ReZwZEDrzwkVMlG8hP
         IHDmKWWmieJsqC8hxZgyiIYC9Elpvq0EGIzhuCcy80Eta7EIZLvcqgGOpiiFKT4ZC/8O
         F3RQ==
X-Gm-Message-State: ABy/qLY3k9/0PC/3xnboCCcZW+mXho/D2CZ0gWquuIFr1dJFVxOGRYND
        zpuO6ocoFtqm1/ekgR1VfDk43ZeHPtR7nTCTb78lkA==
X-Google-Smtp-Source: APBJJlE8FpJ1t8P7mzzpczYvo2GswOqClmB9U+RbB/EzLqXwaHiVbTHv4U4wTqrRD6U25CdqnVHjlg==
X-Received: by 2002:a05:6a20:9147:b0:12f:d350:8a12 with SMTP id x7-20020a056a20914700b0012fd3508a12mr733832pzc.21.1689128931152;
        Tue, 11 Jul 2023 19:28:51 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h8-20020a633848000000b0052871962579sm2220576pgn.63.2023.07.11.19.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 19:28:50 -0700 (PDT)
Message-ID: <64ae0fe2.630a0220.ce1e2.4b8d@mx.google.com>
Date:   Tue, 11 Jul 2023 19:28:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15.120-274-g478387c57e172
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.15.y
Subject: stable-rc/linux-5.15.y baseline: 152 runs,
 15 regressions (v5.15.120-274-g478387c57e172)
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

stable-rc/linux-5.15.y baseline: 152 runs, 15 regressions (v5.15.120-274-g4=
78387c57e172)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6q-var-dt6customboard     | arm    | lab-baylibre    | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6q-var-dt6customboard     | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

rk3328-rock64                | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.120-274-g478387c57e172/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.120-274-g478387c57e172
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      478387c57e172d08b97a3998979210735a56ba69 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64addcaf1b59c20603bb2a7e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-274-g478387c57e172/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-274-g478387c57e172/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64addcaf1b59c20603bb2a83
        failing since 105 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-07-11T22:50:09.258854  <8>[   10.332069] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11064515_1.4.2.3.1>

    2023-07-11T22:50:09.261849  + set +x

    2023-07-11T22:50:09.369853  / # #

    2023-07-11T22:50:09.472376  export SHELL=3D/bin/sh

    2023-07-11T22:50:09.473179  #

    2023-07-11T22:50:09.574728  / # export SHELL=3D/bin/sh. /lava-11064515/=
environment

    2023-07-11T22:50:09.575570  =


    2023-07-11T22:50:09.677255  / # . /lava-11064515/environment/lava-11064=
515/bin/lava-test-runner /lava-11064515/1

    2023-07-11T22:50:09.678501  =


    2023-07-11T22:50:09.685344  / # /lava-11064515/bin/lava-test-runner /la=
va-11064515/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64addcb1cb3e0ab6a1bb2c2f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-274-g478387c57e172/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-274-g478387c57e172/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64addcb1cb3e0ab6a1bb2c34
        failing since 105 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-07-11T22:50:08.447979  + set<8>[   11.478071] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11064539_1.4.2.3.1>

    2023-07-11T22:50:08.448561   +x

    2023-07-11T22:50:08.556430  / # #

    2023-07-11T22:50:08.659082  export SHELL=3D/bin/sh

    2023-07-11T22:50:08.659923  #

    2023-07-11T22:50:08.761724  / # export SHELL=3D/bin/sh. /lava-11064539/=
environment

    2023-07-11T22:50:08.762513  =


    2023-07-11T22:50:08.864121  / # . /lava-11064539/environment/lava-11064=
539/bin/lava-test-runner /lava-11064539/1

    2023-07-11T22:50:08.865370  =


    2023-07-11T22:50:08.871031  / # /lava-11064539/bin/lava-test-runner /la=
va-11064539/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64addc9ccb3e0ab6a1bb2a83

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-274-g478387c57e172/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-274-g478387c57e172/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64addc9ccb3e0ab6a1bb2a88
        failing since 105 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-07-11T22:50:05.816571  <8>[   10.351427] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11064519_1.4.2.3.1>

    2023-07-11T22:50:05.819737  + set +x

    2023-07-11T22:50:05.920846  #

    2023-07-11T22:50:06.021575  / # #export SHELL=3D/bin/sh

    2023-07-11T22:50:06.021758  =


    2023-07-11T22:50:06.122313  / # export SHELL=3D/bin/sh. /lava-11064519/=
environment

    2023-07-11T22:50:06.122513  =


    2023-07-11T22:50:06.222985  / # . /lava-11064519/environment/lava-11064=
519/bin/lava-test-runner /lava-11064519/1

    2023-07-11T22:50:06.223426  =


    2023-07-11T22:50:06.228060  / # /lava-11064519/bin/lava-test-runner /la=
va-11064519/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64adddb579dc031f46bb2a81

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-274-g478387c57e172/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-=
beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-274-g478387c57e172/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-=
beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64adddb579dc031f46bb2=
a82
        failing since 425 days (last pass: v5.15.37-259-gab77581473a3, firs=
t fail: v5.15.39) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64addb8f37af70605abb2a77

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-274-g478387c57e172/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-274-g478387c57e172/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64addb8f37af70605abb2a7c
        failing since 175 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-07-11T22:45:18.077013  <8>[   10.036427] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3719468_1.5.2.4.1>
    2023-07-11T22:45:18.188551  / # #
    2023-07-11T22:45:18.291774  export SHELL=3D/bin/sh
    2023-07-11T22:45:18.292946  #
    2023-07-11T22:45:18.394999  / # export SHELL=3D/bin/sh. /lava-3719468/e=
nvironment
    2023-07-11T22:45:18.396033  =

    2023-07-11T22:45:18.498139  / # . /lava-3719468/environment/lava-371946=
8/bin/lava-test-runner /lava-3719468/1
    2023-07-11T22:45:18.499738  =

    2023-07-11T22:45:18.504447  / # /lava-3719468/bin/lava-test-runner /lav=
a-3719468/1
    2023-07-11T22:45:18.586998  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64addc9cd80834dea6bb2b27

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-274-g478387c57e172/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-274-g478387c57e172/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64addc9cd80834dea6bb2b2c
        failing since 105 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-07-11T22:50:03.202510  + <8>[   10.758159] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11064530_1.4.2.3.1>

    2023-07-11T22:50:03.202604  set +x

    2023-07-11T22:50:03.303812  #

    2023-07-11T22:50:03.404605  / # #export SHELL=3D/bin/sh

    2023-07-11T22:50:03.404775  =


    2023-07-11T22:50:03.505315  / # export SHELL=3D/bin/sh. /lava-11064530/=
environment

    2023-07-11T22:50:03.505506  =


    2023-07-11T22:50:03.606157  / # . /lava-11064530/environment/lava-11064=
530/bin/lava-test-runner /lava-11064530/1

    2023-07-11T22:50:03.606458  =


    2023-07-11T22:50:03.610769  / # /lava-11064530/bin/lava-test-runner /la=
va-11064530/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64addc8e4fdda849b5bb2ace

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-274-g478387c57e172/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-274-g478387c57e172/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64addc8e4fdda849b5bb2ad3
        failing since 105 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-07-11T22:49:34.669247  + set +x

    2023-07-11T22:49:34.676488  <8>[   10.293852] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11064503_1.4.2.3.1>

    2023-07-11T22:49:34.778319  =


    2023-07-11T22:49:34.878884  / # #export SHELL=3D/bin/sh

    2023-07-11T22:49:34.879097  =


    2023-07-11T22:49:34.979633  / # export SHELL=3D/bin/sh. /lava-11064503/=
environment

    2023-07-11T22:49:34.979844  =


    2023-07-11T22:49:35.080374  / # . /lava-11064503/environment/lava-11064=
503/bin/lava-test-runner /lava-11064503/1

    2023-07-11T22:49:35.080766  =


    2023-07-11T22:49:35.085763  / # /lava-11064503/bin/lava-test-runner /la=
va-11064503/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64addc9dd80834dea6bb2b3f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-274-g478387c57e172/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-274-g478387c57e172/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64addc9dd80834dea6bb2b44
        failing since 105 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-07-11T22:50:05.267583  + <8>[   10.992996] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11064527_1.4.2.3.1>

    2023-07-11T22:50:05.267678  set +x

    2023-07-11T22:50:05.371710  / # #

    2023-07-11T22:50:05.472323  export SHELL=3D/bin/sh

    2023-07-11T22:50:05.472553  #

    2023-07-11T22:50:05.573131  / # export SHELL=3D/bin/sh. /lava-11064527/=
environment

    2023-07-11T22:50:05.573331  =


    2023-07-11T22:50:05.673852  / # . /lava-11064527/environment/lava-11064=
527/bin/lava-test-runner /lava-11064527/1

    2023-07-11T22:50:05.674108  =


    2023-07-11T22:50:05.678935  / # /lava-11064527/bin/lava-test-runner /la=
va-11064527/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64addb14561ffc2d47bb2a76

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-274-g478387c57e172/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baselin=
e-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-274-g478387c57e172/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baselin=
e-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64addb14561ffc2d47bb2a7b
        failing since 162 days (last pass: v5.15.81-122-gc5f8d4a5d3c8, firs=
t fail: v5.15.90-205-g5605d15db022)

    2023-07-11T22:43:22.781229  + set +x
    2023-07-11T22:43:22.781395  [    9.420586] <LAVA_SIGNAL_ENDRUN 0_dmesg =
994925_1.5.2.3.1>
    2023-07-11T22:43:22.888212  / # #
    2023-07-11T22:43:22.990174  export SHELL=3D/bin/sh
    2023-07-11T22:43:22.990794  #
    2023-07-11T22:43:23.092298  / # export SHELL=3D/bin/sh. /lava-994925/en=
vironment
    2023-07-11T22:43:23.093239  =

    2023-07-11T22:43:23.194776  / # . /lava-994925/environment/lava-994925/=
bin/lava-test-runner /lava-994925/1
    2023-07-11T22:43:23.195606  =

    2023-07-11T22:43:23.198310  / # /lava-994925/bin/lava-test-runner /lava=
-994925/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-var-dt6customboard     | arm    | lab-baylibre    | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64addd02d8c691173ebb2ac0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-274-g478387c57e172/arm/imx_v6_v7_defconfig/gcc-10/lab-baylibre/baseline-=
imx6q-var-dt6customboard.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-274-g478387c57e172/arm/imx_v6_v7_defconfig/gcc-10/lab-baylibre/baseline-=
imx6q-var-dt6customboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64addd02d8c691173ebb2ac5
        new failure (last pass: v5.15.55-168-g91c6070d5ced)

    2023-07-11T22:51:22.461309  / # #
    2023-07-11T22:51:22.562963  export SHELL=3D/bin/sh
    2023-07-11T22:51:22.563318  #
    2023-07-11T22:51:22.664615  / # export SHELL=3D/bin/sh. /lava-3719512/e=
nvironment
    2023-07-11T22:51:22.664958  =

    2023-07-11T22:51:22.766276  / # . /lava-3719512/environment/lava-371951=
2/bin/lava-test-runner /lava-3719512/1
    2023-07-11T22:51:22.766868  =

    2023-07-11T22:51:22.807439  / # /lava-3719512/bin/lava-test-runner /lav=
a-3719512/1
    2023-07-11T22:51:22.972679  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-11T22:51:22.972934  + cd /lava-3719512/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-var-dt6customboard     | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64addb2704f78df281bb2a90

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-274-g478387c57e172/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-i=
mx6q-var-dt6customboard.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-274-g478387c57e172/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-i=
mx6q-var-dt6customboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64addb2704f78df281bb2a95
        new failure (last pass: v5.15.59)

    2023-07-11T22:43:30.126199  / # #
    2023-07-11T22:43:30.228108  export SHELL=3D/bin/sh
    2023-07-11T22:43:30.228605  #
    2023-07-11T22:43:30.329956  / # export SHELL=3D/bin/sh. /lava-3719476/e=
nvironment
    2023-07-11T22:43:30.330476  =

    2023-07-11T22:43:30.431884  / # . /lava-3719476/environment/lava-371947=
6/bin/lava-test-runner /lava-3719476/1
    2023-07-11T22:43:30.432657  =

    2023-07-11T22:43:30.437121  / # /lava-3719476/bin/lava-test-runner /lav=
a-3719476/1
    2023-07-11T22:43:30.529034  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-11T22:43:30.529311  + cd /lava-3719476/1/tests/1_bootrr =

    ... (18 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64addc9ed80834dea6bb2b4c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-274-g478387c57e172/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-274-g478387c57e172/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64addc9ed80834dea6bb2b51
        failing since 105 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-07-11T22:49:52.491970  <8>[   12.512838] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11064526_1.4.2.3.1>

    2023-07-11T22:49:52.596969  / # #

    2023-07-11T22:49:52.697532  export SHELL=3D/bin/sh

    2023-07-11T22:49:52.697728  #

    2023-07-11T22:49:52.798228  / # export SHELL=3D/bin/sh. /lava-11064526/=
environment

    2023-07-11T22:49:52.798421  =


    2023-07-11T22:49:52.898913  / # . /lava-11064526/environment/lava-11064=
526/bin/lava-test-runner /lava-11064526/1

    2023-07-11T22:49:52.899209  =


    2023-07-11T22:49:52.903726  / # /lava-11064526/bin/lava-test-runner /la=
va-11064526/1

    2023-07-11T22:49:52.909278  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3328-rock64                | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64addef84991dd91e4bb2a78

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-274-g478387c57e172/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-r=
ock64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-274-g478387c57e172/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-r=
ock64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64addef84991dd91e4bb2a7d
        failing since 34 days (last pass: v5.15.72-38-gebe70cd7f5413, first=
 fail: v5.15.114-196-g00621f2608ac)

    2023-07-11T22:59:53.316427  [   16.058193] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3719551_1.5.2.4.1>
    2023-07-11T22:59:53.421368  =

    2023-07-11T22:59:53.421806  / # [   16.096078] rockchip-drm display-sub=
system: [drm] Cannot find any crtc or sizes
    2023-07-11T22:59:53.523927  #export SHELL=3D/bin/sh
    2023-07-11T22:59:53.524621  =

    2023-07-11T22:59:53.626403  / # export SHELL=3D/bin/sh. /lava-3719551/e=
nvironment
    2023-07-11T22:59:53.627187  =

    2023-07-11T22:59:53.729136  / # . /lava-3719551/environment/lava-371955=
1/bin/lava-test-runner /lava-3719551/1
    2023-07-11T22:59:53.730112  =

    2023-07-11T22:59:53.733570  / # /lava-3719551/bin/lava-test-runner /lav=
a-3719551/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64addf91bd7a240d48bb2ad8

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-274-g478387c57e172/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a=
64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-274-g478387c57e172/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a=
64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64addf91bd7a240d48bb2b05
        failing since 175 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-07-11T23:02:13.456674  + set +x
    2023-07-11T23:02:13.460125  <8>[   16.077271] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3719534_1.5.2.4.1>
    2023-07-11T23:02:13.581315  / # #
    2023-07-11T23:02:13.692818  export SHELL=3D/bin/sh
    2023-07-11T23:02:13.696397  #
    2023-07-11T23:02:13.803229  / # export SHELL=3D/bin/sh. /lava-3719534/e=
nvironment
    2023-07-11T23:02:13.806719  =

    2023-07-11T23:02:13.913674  / # . /lava-3719534/environment/lava-371953=
4/bin/lava-test-runner /lava-3719534/1
    2023-07-11T23:02:13.919534  =

    2023-07-11T23:02:13.922193  / # /lava-3719534/bin/lava-test-runner /lav=
a-3719534/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ade2a82d511bdc22bb2ab1

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-274-g478387c57e172/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a6=
4-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-274-g478387c57e172/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a6=
4-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ade2a82d511bdc22bb2ade
        failing since 175 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-07-11T23:15:34.077322  + set +x
    2023-07-11T23:15:34.081230  <8>[   16.045224] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 715182_1.5.2.4.1>
    2023-07-11T23:15:34.191698  / # #
    2023-07-11T23:15:34.294462  export SHELL=3D/bin/sh
    2023-07-11T23:15:34.295182  #
    2023-07-11T23:15:34.397223  / # export SHELL=3D/bin/sh. /lava-715182/en=
vironment
    2023-07-11T23:15:34.397834  =

    2023-07-11T23:15:34.499688  / # . /lava-715182/environment/lava-715182/=
bin/lava-test-runner /lava-715182/1
    2023-07-11T23:15:34.500976  =

    2023-07-11T23:15:34.505043  / # /lava-715182/bin/lava-test-runner /lava=
-715182/1 =

    ... (12 line(s) more)  =

 =20
