Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7EB762244
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 21:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjGYT35 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 15:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGYT35 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 15:29:57 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07022115
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 12:29:52 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bbc87ded50so2664525ad.1
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 12:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690313391; x=1690918191;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zfUqLSRmTEYfbWP7k5ThYKe4h/8vtumLyOOcETdtJ6s=;
        b=5f/oM1pS9Eb/dJwo7UMyjkt60rX7+a6KtxqXhVMr0PoZUSxWEbA8+5d3Jsq7x+Hhxz
         032TRsp6Beesk6OeuuilYKDfGCubeGYAPaYejv252dVIfGjkKyxWbvL4j0EptcUHxjea
         dCzv8ZWeKeRsy4/QzXQszhn/6MH+gsnanufGkZxu1zjOaLU+rJgBYKshwJ37BjtwctSf
         3x6lGT+zXoXXoGp6HDatLa1uWqFYdX/j0b3BJkXN2TVBqKXQQHNkIYAcOeAf4128CQLT
         1duFyfT1w6pE7o3OoD4C8MSxZvhnJWiTcywAM2eVMMK24RkgVMC9SAF2E8Wta+uMuEFW
         Bw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690313391; x=1690918191;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zfUqLSRmTEYfbWP7k5ThYKe4h/8vtumLyOOcETdtJ6s=;
        b=jUkUpFjXVaAuCu2aPdmUbiDIrFzB/PHWf1H7w7q/lAJQhHaqvu92A4jEQarRPfU2pA
         knM+fXYkWBddTYlPwGIxEhI9lFoP73dS9gHcoxOsmB/KwHlsHpUXewhAR++hYhI/QnY8
         opUErckjKc0ChgDfJfZqaRpiP9I+GgDsKQwOKD15/s0XswACuzip0yPEslVOm8jQ7jt/
         9Z+XDMcB6sSgdL8D7wP1a1gLDjxzj/HdW+rC5W2gHGkFSrXsFRc+1e9PBV0C34HH8Im1
         vsN+ahwsNxhzdvWvtUK9VloPumpMOQbZyafjR3J/VDMLX58MT3zPF5jKRHSheZLss+97
         RC7g==
X-Gm-Message-State: ABy/qLb2FRE2IFWZQK0x/EB0yUcTKFwf7iRtp8LoL+o7bpwWvKaJxFoj
        62yoz8YJIbJXSY1O+pSUjpNRFQoRsrvLO3/MKYjlpQ==
X-Google-Smtp-Source: APBJJlGVsAQnVsJgoU9vhg7qCKoQv53fZ2YJWWG98VtZCE1sFV7fcgLW+wYF2QucwKoZMoeHJ2x8TA==
X-Received: by 2002:a17:903:1105:b0:1bb:3a7:6af7 with SMTP id n5-20020a170903110500b001bb03a76af7mr136259plh.23.1690313391402;
        Tue, 25 Jul 2023 12:29:51 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902dac700b001b7feed285csm11413430plx.36.2023.07.25.12.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 12:29:50 -0700 (PDT)
Message-ID: <64c022ae.170a0220.41968.52fb@mx.google.com>
Date:   Tue, 25 Jul 2023 12:29:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Kernel: v5.15.122-79-g3bef1500d246a
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.15.y baseline: 122 runs,
 14 regressions (v5.15.122-79-g3bef1500d246a)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.15.y baseline: 122 runs, 14 regressions (v5.15.122-79-g3b=
ef1500d246a)

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

fsl-ls2088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

fsl-lx2160a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.122-79-g3bef1500d246a/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.122-79-g3bef1500d246a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      3bef1500d246a00c075b244b6bb5849082569081 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64bfef9870ff00804e8ace22

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
22-79-g3bef1500d246a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
22-79-g3bef1500d246a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bfef9870ff00804e8ace27
        failing since 118 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-07-25T15:51:44.695060  <8>[   10.694504] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11136322_1.4.2.3.1>

    2023-07-25T15:51:44.698543  + set +x

    2023-07-25T15:51:44.804120  #

    2023-07-25T15:51:44.805388  =


    2023-07-25T15:51:44.907774  / # #export SHELL=3D/bin/sh

    2023-07-25T15:51:44.908476  =


    2023-07-25T15:51:45.009825  / # export SHELL=3D/bin/sh. /lava-11136322/=
environment

    2023-07-25T15:51:45.010039  =


    2023-07-25T15:51:45.110646  / # . /lava-11136322/environment/lava-11136=
322/bin/lava-test-runner /lava-11136322/1

    2023-07-25T15:51:45.111002  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64bfef86b7843ae61e8ace58

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
22-79-g3bef1500d246a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
22-79-g3bef1500d246a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bfef86b7843ae61e8ace5d
        failing since 118 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-07-25T15:51:32.673753  + set<8>[   11.517760] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11136332_1.4.2.3.1>

    2023-07-25T15:51:32.673848   +x

    2023-07-25T15:51:32.778682  / # #

    2023-07-25T15:51:32.879404  export SHELL=3D/bin/sh

    2023-07-25T15:51:32.879625  #

    2023-07-25T15:51:32.980105  / # export SHELL=3D/bin/sh. /lava-11136332/=
environment

    2023-07-25T15:51:32.980349  =


    2023-07-25T15:51:33.080949  / # . /lava-11136332/environment/lava-11136=
332/bin/lava-test-runner /lava-11136332/1

    2023-07-25T15:51:33.081327  =


    2023-07-25T15:51:33.085776  / # /lava-11136332/bin/lava-test-runner /la=
va-11136332/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64bfefa470ff00804e8ace4c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
22-79-g3bef1500d246a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
22-79-g3bef1500d246a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bfefa470ff00804e8ace51
        failing since 118 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-07-25T15:51:42.586863  <8>[   10.634009] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11136320_1.4.2.3.1>

    2023-07-25T15:51:42.590142  + set +x

    2023-07-25T15:51:42.691778  #

    2023-07-25T15:51:42.792673  / # #export SHELL=3D/bin/sh

    2023-07-25T15:51:42.792909  =


    2023-07-25T15:51:42.893471  / # export SHELL=3D/bin/sh. /lava-11136320/=
environment

    2023-07-25T15:51:42.893739  =


    2023-07-25T15:51:42.994370  / # . /lava-11136320/environment/lava-11136=
320/bin/lava-test-runner /lava-11136320/1

    2023-07-25T15:51:42.994697  =


    2023-07-25T15:51:42.999396  / # /lava-11136320/bin/lava-test-runner /la=
va-11136320/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64bff26c88c8e621458ace1c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
22-79-g3bef1500d246a/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
22-79-g3bef1500d246a/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64bff26c88c8e621458ac=
e1d
        new failure (last pass: v5.15.120) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64bff1a5f9f02dc4a48ace24

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
22-79-g3bef1500d246a/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
22-79-g3bef1500d246a/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bff1a5f9f02dc4a48ace29
        failing since 189 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-07-25T16:00:19.667525  <8>[   10.031223] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3724594_1.5.2.4.1>
    2023-07-25T16:00:19.778501  / # #
    2023-07-25T16:00:19.882228  export SHELL=3D/bin/sh
    2023-07-25T16:00:19.883214  #
    2023-07-25T16:00:19.985308  / # export SHELL=3D/bin/sh. /lava-3724594/e=
nvironment
    2023-07-25T16:00:19.986293  =

    2023-07-25T16:00:20.089125  / # . /lava-3724594/environment/lava-372459=
4/bin/lava-test-runner /lava-3724594/1
    2023-07-25T16:00:20.090692  <3>[   10.353815] Bluetooth: hci0: command =
0x0c03 tx timeout
    2023-07-25T16:00:20.091143  =

    2023-07-25T16:00:20.095313  / # /lava-3724594/bin/lava-test-runner /lav=
a-3724594/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64bff1f1e134d6db0f8ace97

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
22-79-g3bef1500d246a/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rd=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
22-79-g3bef1500d246a/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rd=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bff1f1e134d6db0f8ace9a
        failing since 11 days (last pass: v5.15.67, first fail: v5.15.119-1=
6-g66130849c020f)

    2023-07-25T16:01:41.838295  [   14.160172] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1237987_1.5.2.4.1>
    2023-07-25T16:01:41.943541  =

    2023-07-25T16:01:42.044718  / # #export SHELL=3D/bin/sh
    2023-07-25T16:01:42.045119  =

    2023-07-25T16:01:42.146075  / # export SHELL=3D/bin/sh. /lava-1237987/e=
nvironment
    2023-07-25T16:01:42.146476  =

    2023-07-25T16:01:42.247496  / # . /lava-1237987/environment/lava-123798=
7/bin/lava-test-runner /lava-1237987/1
    2023-07-25T16:01:42.248191  =

    2023-07-25T16:01:42.251564  / # /lava-1237987/bin/lava-test-runner /lav=
a-1237987/1
    2023-07-25T16:01:42.267674  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64bff1efe134d6db0f8ace89

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
22-79-g3bef1500d246a/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rd=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
22-79-g3bef1500d246a/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rd=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bff1efe134d6db0f8ace8c
        failing since 143 days (last pass: v5.15.79, first fail: v5.15.98)

    2023-07-25T16:01:25.744728  [   15.773364] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1237984_1.5.2.4.1>
    2023-07-25T16:01:25.850240  =

    2023-07-25T16:01:25.951429  / # #export SHELL=3D/bin/sh
    2023-07-25T16:01:25.951862  =

    2023-07-25T16:01:26.052816  / # export SHELL=3D/bin/sh. /lava-1237984/e=
nvironment
    2023-07-25T16:01:26.053246  =

    2023-07-25T16:01:26.154210  / # . /lava-1237984/environment/lava-123798=
4/bin/lava-test-runner /lava-1237984/1
    2023-07-25T16:01:26.154909  =

    2023-07-25T16:01:26.158852  / # /lava-1237984/bin/lava-test-runner /lav=
a-1237984/1
    2023-07-25T16:01:26.175414  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64bff18d87ac4fcd998acea1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
22-79-g3bef1500d246a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
22-79-g3bef1500d246a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bff18d87ac4fcd998acea6
        failing since 118 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-07-25T15:59:57.317169  + set +x

    2023-07-25T15:59:57.323629  <8>[   10.861139] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11136305_1.4.2.3.1>

    2023-07-25T15:59:57.431225  / # #

    2023-07-25T15:59:57.533490  export SHELL=3D/bin/sh

    2023-07-25T15:59:57.534150  #

    2023-07-25T15:59:57.635445  / # export SHELL=3D/bin/sh. /lava-11136305/=
environment

    2023-07-25T15:59:57.636214  =


    2023-07-25T15:59:57.737801  / # . /lava-11136305/environment/lava-11136=
305/bin/lava-test-runner /lava-11136305/1

    2023-07-25T15:59:57.738888  =


    2023-07-25T15:59:57.743533  / # /lava-11136305/bin/lava-test-runner /la=
va-11136305/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64bfef84ebc79d05618ace5b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
22-79-g3bef1500d246a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
22-79-g3bef1500d246a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bfef84ebc79d05618ace60
        failing since 118 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-07-25T15:51:27.768350  + <8>[    8.579018] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11136326_1.4.2.3.1>

    2023-07-25T15:51:27.768437  set +x

    2023-07-25T15:51:27.872515  / # #

    2023-07-25T15:51:27.973113  export SHELL=3D/bin/sh

    2023-07-25T15:51:27.973321  #

    2023-07-25T15:51:28.073856  / # export SHELL=3D/bin/sh. /lava-11136326/=
environment

    2023-07-25T15:51:28.074071  =


    2023-07-25T15:51:28.174604  / # . /lava-11136326/environment/lava-11136=
326/bin/lava-test-runner /lava-11136326/1

    2023-07-25T15:51:28.174900  =


    2023-07-25T15:51:28.179468  / # /lava-11136326/bin/lava-test-runner /la=
va-11136326/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64bff102538b100d328ace7f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
22-79-g3bef1500d246a/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline=
-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
22-79-g3bef1500d246a/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline=
-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bff102538b100d328ace84
        failing since 176 days (last pass: v5.15.81-122-gc5f8d4a5d3c8, firs=
t fail: v5.15.90-205-g5605d15db022)

    2023-07-25T15:57:46.159782  + set +x
    2023-07-25T15:57:46.159949  [    9.416962] <LAVA_SIGNAL_ENDRUN 0_dmesg =
996015_1.5.2.3.1>
    2023-07-25T15:57:46.267814  / # #
    2023-07-25T15:57:46.369695  export SHELL=3D/bin/sh
    2023-07-25T15:57:46.370211  #
    2023-07-25T15:57:46.471701  / # export SHELL=3D/bin/sh. /lava-996015/en=
vironment
    2023-07-25T15:57:46.472171  =

    2023-07-25T15:57:46.573499  / # . /lava-996015/environment/lava-996015/=
bin/lava-test-runner /lava-996015/1
    2023-07-25T15:57:46.574151  =

    2023-07-25T15:57:46.577291  / # /lava-996015/bin/lava-test-runner /lava=
-996015/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64bfef84b7843ae61e8ace41

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
22-79-g3bef1500d246a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
22-79-g3bef1500d246a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bfef84b7843ae61e8ace46
        failing since 118 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-07-25T15:51:24.878017  + set<8>[   12.329720] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11136308_1.4.2.3.1>

    2023-07-25T15:51:24.878432   +x

    2023-07-25T15:51:24.985518  / # #

    2023-07-25T15:51:25.087639  export SHELL=3D/bin/sh

    2023-07-25T15:51:25.088344  #

    2023-07-25T15:51:25.189528  / # export SHELL=3D/bin/sh. /lava-11136308/=
environment

    2023-07-25T15:51:25.189818  =


    2023-07-25T15:51:25.290541  / # . /lava-11136308/environment/lava-11136=
308/bin/lava-test-runner /lava-11136308/1

    2023-07-25T15:51:25.291476  =


    2023-07-25T15:51:25.295818  / # /lava-11136308/bin/lava-test-runner /la=
va-11136308/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c000d8a6d45372a78ace21

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
22-79-g3bef1500d246a/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
22-79-g3bef1500d246a/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c000d8a6d45372a78ace26
        failing since 5 days (last pass: v5.15.120-274-g478387c57e172, firs=
t fail: v5.15.120)

    2023-07-25T17:06:50.874853  / # #

    2023-07-25T17:06:50.977016  export SHELL=3D/bin/sh

    2023-07-25T17:06:50.977720  #

    2023-07-25T17:06:51.079155  / # export SHELL=3D/bin/sh. /lava-11136395/=
environment

    2023-07-25T17:06:51.079862  =


    2023-07-25T17:06:51.181161  / # . /lava-11136395/environment/lava-11136=
395/bin/lava-test-runner /lava-11136395/1

    2023-07-25T17:06:51.181498  =


    2023-07-25T17:06:51.182557  / # /lava-11136395/bin/lava-test-runner /la=
va-11136395/1

    2023-07-25T17:06:51.246622  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-25T17:06:51.246706  + cd /lav<8>[   15.956995] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11136395_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64bff14c1be0a459368ace7d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
22-79-g3bef1500d246a/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
22-79-g3bef1500d246a/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bff14c1be0a459368ace82
        failing since 5 days (last pass: v5.15.120-274-g478387c57e172, firs=
t fail: v5.15.120)

    2023-07-25T15:59:00.317999  / # #

    2023-07-25T15:59:01.396574  export SHELL=3D/bin/sh

    2023-07-25T15:59:01.398472  #

    2023-07-25T15:59:02.889152  / # export SHELL=3D/bin/sh. /lava-11136391/=
environment

    2023-07-25T15:59:02.890937  =


    2023-07-25T15:59:05.614494  / # . /lava-11136391/environment/lava-11136=
391/bin/lava-test-runner /lava-11136391/1

    2023-07-25T15:59:05.616771  =


    2023-07-25T15:59:05.628179  / # /lava-11136391/bin/lava-test-runner /la=
va-11136391/1

    2023-07-25T15:59:05.688327  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-25T15:59:05.688833  + cd /lava-111363<8>[   25.517027] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11136391_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64bff1361be0a459368ace30

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
22-79-g3bef1500d246a/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
22-79-g3bef1500d246a/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bff1361be0a459368ace35
        failing since 5 days (last pass: v5.15.120-274-g478387c57e172, firs=
t fail: v5.15.120)

    2023-07-25T16:00:04.981007  / # #

    2023-07-25T16:00:05.081614  export SHELL=3D/bin/sh

    2023-07-25T16:00:05.081886  #

    2023-07-25T16:00:05.182413  / # export SHELL=3D/bin/sh. /lava-11136382/=
environment

    2023-07-25T16:00:05.182702  =


    2023-07-25T16:00:05.283212  / # . /lava-11136382/environment/lava-11136=
382/bin/lava-test-runner /lava-11136382/1

    2023-07-25T16:00:05.283506  =


    2023-07-25T16:00:05.294409  / # /lava-11136382/bin/lava-test-runner /la=
va-11136382/1

    2023-07-25T16:00:05.356427  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-25T16:00:05.356575  + cd /lava-1113638<8>[   16.893742] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11136382_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
