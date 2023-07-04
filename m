Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676FD7466B6
	for <lists+stable@lfdr.de>; Tue,  4 Jul 2023 02:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjGDA7g (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 20:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjGDA7f (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 20:59:35 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7EC138
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 17:59:32 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a38953c928so2515731b6e.1
        for <stable@vger.kernel.org>; Mon, 03 Jul 2023 17:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688432371; x=1691024371;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N+otICHWIDfl/EWBDf+hcH21FCi9oXQ0HQPvHPvTkj0=;
        b=yTp/hhA8uhpAqUZQ+1ZBZIWa8zt0+5OeGvVpIsJ2sfCG9QcWGiseJpmnMi2bmpj60q
         av+1CKI5zyNkF3FLOpXxv6MKhuHd3yezl1eZOm/RjNJOZUAeXYXJbkr06G9bx52VnH6w
         d8VDvixnrV8SkpFjB1X2jirBj3LNDlPY6gx9V5H99nSBY5t/c6hjvDB4dErQWY2qPCFc
         m+YQKakCNGUaUB7kFoXY0gCwa6nvCHlkdEe9dXdRzzme3Z+O99kSndZ3++22iCaH5pX4
         0Ptu9ZJJ2wYPgCWY6C062Jdl+YGnIoaJyUc7r3JjyGJdmHdWtzbpjSujL+TNvhAq9FMe
         tvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688432371; x=1691024371;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N+otICHWIDfl/EWBDf+hcH21FCi9oXQ0HQPvHPvTkj0=;
        b=EzwJtdgcDgmZBGHhiXErnoQckPMptO8GZ+Q1KI2Qfi4GtXF1+2QIC2yOg+ZbqtCmiT
         JJAy6Djco5lqna5TEJ0eqzi9ZQC8RFwOzNFeZRZn/dtFdBFen9+/MADCtECrrklWCktp
         oJIvjlDucucr7QIhVnAszpW0u9Z85HzbOMWtxpYA3loWiYMuQDpYNb2DA46f8PHFbLQt
         I0ElQK7T9bHiMSAzLxcOOHL3xMUJdHQgbtfQivly2k5+h4B77UgsqzTUslNT1JSbwNOx
         TeW4Su+uRIt4ZL/S0CTkEotcgelJMce7CZXJGAUlXYuqBx+F5EO7o1/5v4cMYMqew67B
         IMeQ==
X-Gm-Message-State: ABy/qLbQbRrDb/QRXzNKcoJt5DIvBx6TwogJahS2yDTvZixbvZCtBSbX
        jiEqqKduhfvsBRxr6gSWrUge56cw9B+iQTm47hbIZA==
X-Google-Smtp-Source: APBJJlE5zCy6cvrpB/66sFC5YRnzAJkhnRVbRz9YtkaFm9xCMDU3EP0ZUgRwXIdCDb+U+ZwuMLkQ1g==
X-Received: by 2002:a05:6808:120e:b0:3a3:a78a:1737 with SMTP id a14-20020a056808120e00b003a3a78a1737mr4553712oil.9.1688432370997;
        Mon, 03 Jul 2023 17:59:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jj11-20020a170903048b00b001b80e07989csm12907679plb.200.2023.07.03.17.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 17:59:30 -0700 (PDT)
Message-ID: <64a36ef2.170a0220.91071.a7fa@mx.google.com>
Date:   Mon, 03 Jul 2023 17:59:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15.119-16-g66130849c020f
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.15.y
Subject: stable-rc/linux-5.15.y baseline: 149 runs,
 13 regressions (v5.15.119-16-g66130849c020f)
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

stable-rc/linux-5.15.y baseline: 149 runs, 13 regressions (v5.15.119-16-g66=
130849c020f)

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

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.119-16-g66130849c020f/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.119-16-g66130849c020f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      66130849c020f4cf55ecac785b8017d2b7c63a88 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a33a8acd6e53297bbb2a75

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-16-g66130849c020f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-16-g66130849c020f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a33a8acd6e53297bbb2a7a
        failing since 96 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-07-03T21:15:37.333011  <8>[   10.135382] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10998269_1.4.2.3.1>

    2023-07-03T21:15:37.336382  + set +x

    2023-07-03T21:15:37.437718  =


    2023-07-03T21:15:37.538350  / # #export SHELL=3D/bin/sh

    2023-07-03T21:15:37.538552  =


    2023-07-03T21:15:37.639054  / # export SHELL=3D/bin/sh. /lava-10998269/=
environment

    2023-07-03T21:15:37.639253  =


    2023-07-03T21:15:37.739808  / # . /lava-10998269/environment/lava-10998=
269/bin/lava-test-runner /lava-10998269/1

    2023-07-03T21:15:37.740163  =


    2023-07-03T21:15:37.745469  / # /lava-10998269/bin/lava-test-runner /la=
va-10998269/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a33705fa47116ff5bb2aa2

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-16-g66130849c020f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-16-g66130849c020f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a33705fa47116ff5bb2aa7
        failing since 96 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-07-03T21:00:39.696419  + set<8>[   11.375602] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10998314_1.4.2.3.1>

    2023-07-03T21:00:39.697043   +x

    2023-07-03T21:00:39.805925  / # #

    2023-07-03T21:00:39.908257  export SHELL=3D/bin/sh

    2023-07-03T21:00:39.909003  #

    2023-07-03T21:00:40.010426  / # export SHELL=3D/bin/sh. /lava-10998314/=
environment

    2023-07-03T21:00:40.011176  =


    2023-07-03T21:00:40.112697  / # . /lava-10998314/environment/lava-10998=
314/bin/lava-test-runner /lava-10998314/1

    2023-07-03T21:00:40.113841  =


    2023-07-03T21:00:40.119209  / # /lava-10998314/bin/lava-test-runner /la=
va-10998314/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a336ec9072ff9903bb2a75

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-16-g66130849c020f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-16-g66130849c020f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a336ec9072ff9903bb2a7a
        failing since 96 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-07-03T21:00:06.675948  <8>[   10.484446] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10998262_1.4.2.3.1>

    2023-07-03T21:00:06.679403  + set +x

    2023-07-03T21:00:06.780781  =


    2023-07-03T21:00:06.881343  / # #export SHELL=3D/bin/sh

    2023-07-03T21:00:06.881492  =


    2023-07-03T21:00:06.982000  / # export SHELL=3D/bin/sh. /lava-10998262/=
environment

    2023-07-03T21:00:06.982182  =


    2023-07-03T21:00:07.082721  / # . /lava-10998262/environment/lava-10998=
262/bin/lava-test-runner /lava-10998262/1

    2023-07-03T21:00:07.083017  =


    2023-07-03T21:00:07.088482  / # /lava-10998262/bin/lava-test-runner /la=
va-10998262/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3384371fffe2583bb2ac8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-16-g66130849c020f/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-16-g66130849c020f/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a3384371fffe2583bb2=
ac9
        failing since 417 days (last pass: v5.15.37-259-gab77581473a3, firs=
t fail: v5.15.39) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64a33998680a68eea8bb2a98

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-16-g66130849c020f/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-16-g66130849c020f/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a33998680a68eea8bb2a9d
        failing since 167 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-07-03T21:11:35.439550  <8>[   10.012612] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3708625_1.5.2.4.1>
    2023-07-03T21:11:35.549319  / # #
    2023-07-03T21:11:35.652968  export SHELL=3D/bin/sh
    2023-07-03T21:11:35.654241  #
    2023-07-03T21:11:35.756685  / # export SHELL=3D/bin/sh. /lava-3708625/e=
nvironment
    2023-07-03T21:11:35.758108  =

    2023-07-03T21:11:35.860983  / # . /lava-3708625/environment/lava-370862=
5/bin/lava-test-runner /lava-3708625/1
    2023-07-03T21:11:35.862946  =

    2023-07-03T21:11:35.863480  / # <3>[   10.353040] Bluetooth: hci0: comm=
and 0xfc18 tx timeout
    2023-07-03T21:11:35.867678  /lava-3708625/bin/lava-test-runner /lava-37=
08625/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a338515504d27e17bb2a98

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-16-g66130849c020f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-16-g66130849c020f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a338515504d27e17bb2a9d
        failing since 96 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-07-03T21:06:10.198591  + set +x

    2023-07-03T21:06:10.205034  <8>[   10.650852] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10998283_1.4.2.3.1>

    2023-07-03T21:06:10.312258  / # #

    2023-07-03T21:06:10.414533  export SHELL=3D/bin/sh

    2023-07-03T21:06:10.415290  #

    2023-07-03T21:06:10.516957  / # export SHELL=3D/bin/sh. /lava-10998283/=
environment

    2023-07-03T21:06:10.517735  =


    2023-07-03T21:06:10.619246  / # . /lava-10998283/environment/lava-10998=
283/bin/lava-test-runner /lava-10998283/1

    2023-07-03T21:06:10.620492  =


    2023-07-03T21:06:10.625495  / # /lava-10998283/bin/lava-test-runner /la=
va-10998283/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a336fb9072ff9903bb2a90

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-16-g66130849c020f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-16-g66130849c020f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a336fb9072ff9903bb2a95
        failing since 96 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-07-03T21:00:38.296686  + set +x<8>[   10.412464] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10998320_1.4.2.3.1>

    2023-07-03T21:00:38.297194  =


    2023-07-03T21:00:38.403792  #

    2023-07-03T21:00:38.506334  / # #export SHELL=3D/bin/sh

    2023-07-03T21:00:38.506999  =


    2023-07-03T21:00:38.608382  / # export SHELL=3D/bin/sh. /lava-10998320/=
environment

    2023-07-03T21:00:38.608998  =


    2023-07-03T21:00:38.710346  / # . /lava-10998320/environment/lava-10998=
320/bin/lava-test-runner /lava-10998320/1

    2023-07-03T21:00:38.711733  =


    2023-07-03T21:00:38.716560  / # /lava-10998320/bin/lava-test-runner /la=
va-10998320/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a336f26e6203c4b4bb2a94

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-16-g66130849c020f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-16-g66130849c020f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a336f26e6203c4b4bb2a99
        failing since 96 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-07-03T21:00:13.644419  + set +x<8>[   10.635014] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10998264_1.4.2.3.1>

    2023-07-03T21:00:13.644506  =


    2023-07-03T21:00:13.748953  / # #

    2023-07-03T21:00:13.849691  export SHELL=3D/bin/sh

    2023-07-03T21:00:13.849944  #

    2023-07-03T21:00:13.950510  / # export SHELL=3D/bin/sh. /lava-10998264/=
environment

    2023-07-03T21:00:13.950732  =


    2023-07-03T21:00:14.051340  / # . /lava-10998264/environment/lava-10998=
264/bin/lava-test-runner /lava-10998264/1

    2023-07-03T21:00:14.051712  =


    2023-07-03T21:00:14.056718  / # /lava-10998264/bin/lava-test-runner /la=
va-10998264/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a33703fa47116ff5bb2a76

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-16-g66130849c020f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-16-g66130849c020f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a33703fa47116ff5bb2a7b
        failing since 96 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-07-03T21:00:22.889030  + <8>[   10.860685] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10998257_1.4.2.3.1>

    2023-07-03T21:00:22.889459  set +x

    2023-07-03T21:00:22.997200  / # #

    2023-07-03T21:00:23.098459  export SHELL=3D/bin/sh

    2023-07-03T21:00:23.099338  #

    2023-07-03T21:00:23.200874  / # export SHELL=3D/bin/sh. /lava-10998257/=
environment

    2023-07-03T21:00:23.201607  =


    2023-07-03T21:00:23.302834  / # . /lava-10998257/environment/lava-10998=
257/bin/lava-test-runner /lava-10998257/1

    2023-07-03T21:00:23.303158  =


    2023-07-03T21:00:23.307541  / # /lava-10998257/bin/lava-test-runner /la=
va-10998257/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64a335890549b40b4bbb2b2f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-16-g66130849c020f/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-ro=
ck64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-16-g66130849c020f/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-ro=
ck64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a335890549b40b4bbb2b34
        failing since 25 days (last pass: v5.15.72-38-gebe70cd7f5413, first=
 fail: v5.15.114-196-g00621f2608ac)

    2023-07-03T20:54:22.921175  [   16.046427] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3708521_1.5.2.4.1>
    2023-07-03T20:54:23.025645  =

    2023-07-03T20:54:23.025865  / # #[   16.131457] rockchip-drm display-su=
bsystem: [drm] Cannot find any crtc or sizes
    2023-07-03T20:54:23.127498  export SHELL=3D/bin/sh
    2023-07-03T20:54:23.127961  =

    2023-07-03T20:54:23.229333  / # export SHELL=3D/bin/sh. /lava-3708521/e=
nvironment
    2023-07-03T20:54:23.229677  =

    2023-07-03T20:54:23.330888  / # . /lava-3708521/environment/lava-370852=
1/bin/lava-test-runner /lava-3708521/1
    2023-07-03T20:54:23.331384  =

    2023-07-03T20:54:23.334881  / # /lava-3708521/bin/lava-test-runner /lav=
a-3708521/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64a338f9108022fd26bb2aa7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-16-g66130849c020f/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-st=
m32mp157c-dk2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-16-g66130849c020f/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-st=
m32mp157c-dk2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a338f9108022fd26bb2aaa
        failing since 149 days (last pass: v5.15.59, first fail: v5.15.91-2=
1-gd8296a906e7a)

    2023-07-03T21:08:59.631470  <8>[   10.566167] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3708624_1.5.2.4.1>
    2023-07-03T21:08:59.737333  / # #
    2023-07-03T21:08:59.839149  export SHELL=3D/bin/sh
    2023-07-03T21:08:59.839604  #
    2023-07-03T21:08:59.941034  / # export SHELL=3D/bin/sh. /lava-3708624/e=
nvironment
    2023-07-03T21:08:59.941484  =

    2023-07-03T21:09:00.042981  / # . /lava-3708624/environment/lava-370862=
4/bin/lava-test-runner /lava-3708624/1
    2023-07-03T21:09:00.043684  =

    2023-07-03T21:09:00.047511  / # /lava-3708624/bin/lava-test-runner /lav=
a-3708624/1
    2023-07-03T21:09:00.116393  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64a33750b2c73fc2a7bb2a76

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-16-g66130849c020f/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a6=
4-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-16-g66130849c020f/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a6=
4-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a33750b2c73fc2a7bb2aa2
        failing since 167 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-07-03T21:01:41.601047  + set +x
    2023-07-03T21:01:41.605079  <8>[   16.025483] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3708540_1.5.2.4.1>
    2023-07-03T21:01:41.724963  / # #
    2023-07-03T21:01:41.830477  export SHELL=3D/bin/sh
    2023-07-03T21:01:41.831975  #
    2023-07-03T21:01:41.935371  / # export SHELL=3D/bin/sh. /lava-3708540/e=
nvironment
    2023-07-03T21:01:41.936991  =

    2023-07-03T21:01:42.040369  / # . /lava-3708540/environment/lava-370854=
0/bin/lava-test-runner /lava-3708540/1
    2023-07-03T21:01:42.043006  =

    2023-07-03T21:01:42.046294  / # /lava-3708540/bin/lava-test-runner /lav=
a-3708540/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64a337c28269d9a9f1bb2b3d

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-16-g66130849c020f/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64=
-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-16-g66130849c020f/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64=
-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a337c28269d9a9f1bb2b6a
        failing since 167 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-07-03T21:03:40.002052  + set +x
    2023-07-03T21:03:40.005976  <8>[   16.045005] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 691864_1.5.2.4.1>
    2023-07-03T21:03:40.120832  / # #
    2023-07-03T21:03:40.223649  export SHELL=3D/bin/sh
    2023-07-03T21:03:40.224354  #
    2023-07-03T21:03:40.326527  / # export SHELL=3D/bin/sh. /lava-691864/en=
vironment
    2023-07-03T21:03:40.327720  =

    2023-07-03T21:03:40.430133  / # . /lava-691864/environment/lava-691864/=
bin/lava-test-runner /lava-691864/1
    2023-07-03T21:03:40.430895  =

    2023-07-03T21:03:40.435581  / # /lava-691864/bin/lava-test-runner /lava=
-691864/1 =

    ... (12 line(s) more)  =

 =20
