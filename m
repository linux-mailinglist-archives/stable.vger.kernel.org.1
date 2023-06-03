Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BC47211F5
	for <lists+stable@lfdr.de>; Sat,  3 Jun 2023 21:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjFCT7U (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 3 Jun 2023 15:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjFCT7T (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 3 Jun 2023 15:59:19 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2051118D
        for <stable@vger.kernel.org>; Sat,  3 Jun 2023 12:59:17 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-39a9b16b37bso445926b6e.1
        for <stable@vger.kernel.org>; Sat, 03 Jun 2023 12:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685822355; x=1688414355;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ASmr5xRbp1xfUcJK7S97S/GxUMpvrp1r6KZHJx+0Kfo=;
        b=wZnKFoPbSlMucxVrhCmTjm5Q7zgNOYOi55D/htghvWDCw+LW16AdMLh07XtTUtsz+6
         qg+fJZfd3oaZ/y4uiJNtuwIVTkc6yrJJjH/02akn76XJpbVNrpGEnDUTGJQzvwX89TzQ
         Sov4YquFS0WPP4wJwmxAoUaWqKIleQ062uqVrXnDz/9BqFF5MDtfvviJfGEcjUwecsoj
         WlZhJxlnFibX6jKo5YQRjDuLCwVgBs+7zx3rn741ViFF5q2PdslYhJr0ZE7as+F25VX/
         cjld8vI8UsNN/VWGxdZhZbQbf90iyAeiSfnlVEUquXyLP7Jr1Tj5F6DQmAhZXQBAwf09
         yWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685822355; x=1688414355;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ASmr5xRbp1xfUcJK7S97S/GxUMpvrp1r6KZHJx+0Kfo=;
        b=L4H+buOJ40GuBIKKIm4Ua8XW6aj2i+G7bqJgOgxmyBufaMbuGpEn9NOmOIYMevMFMO
         7V62XcR4ZbOl/BuTV57e12NSunkZ5rJOrWxD7j7WkGUQyfRCcgNraQ7rsWGScGbSEjBz
         PrxFD+ofPX1gFrcpiTrpafYL8QdqO6j0CPljZDACwSvyeMUnwDBJEKEXMOgTfGy9suZ/
         yOI7a3eUe/nfO8T1L1YBJX4lMCBbdrJZmJnhYnkpaRLEkZvS9TvPI5qNkJCi+zgWNUti
         ZKDbIyIZVXCPH3CT9ZeeoyFxo8XdAJJLkUA4YZqYnpEDLKFfrQuoiIHqEUNoGfRb2faV
         WXMg==
X-Gm-Message-State: AC+VfDzmqUqNGkr5wRlQXqVs6AxArkQwO5KlNnMEWbH6sCwphZTYYX7Q
        ywbNlWgSEMNJX2Pyu5+nEO0Jtri9+l5KJDgoA3reQQ==
X-Google-Smtp-Source: ACHHUZ6/8DOZoqlr44tPj8nKruN0zP8FpwwGEf4NHIx6u6Xq/lZ5dVe8hq/rG8OpLCwhVP1h0pNlrQ==
X-Received: by 2002:aca:f10:0:b0:398:57ac:23fe with SMTP id 16-20020aca0f10000000b0039857ac23femr3838838oip.10.1685822354556;
        Sat, 03 Jun 2023 12:59:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jj20-20020a170903049400b001b06deeb319sm3517891plb.300.2023.06.03.12.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jun 2023 12:59:13 -0700 (PDT)
Message-ID: <647b9b91.170a0220.d2fe7.65d8@mx.google.com>
Date:   Sat, 03 Jun 2023 12:59:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15.114-36-ge43ef124b08b3
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.15.y baseline: 131 runs,
 14 regressions (v5.15.114-36-ge43ef124b08b3)
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

stable-rc/linux-5.15.y baseline: 131 runs, 14 regressions (v5.15.114-36-ge4=
3ef124b08b3)

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

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 4          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.114-36-ge43ef124b08b3/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.114-36-ge43ef124b08b3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      e43ef124b08b3125f1560d34f33fe33bce33c1ce =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647b63817d0095f9eff5de75

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-36-ge43ef124b08b3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-36-ge43ef124b08b3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647b63817d0095f9eff5de7e
        failing since 66 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-03T15:59:52.085527  + set +x

    2023-06-03T15:59:52.092589  <8>[   10.804954] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10575759_1.4.2.3.1>

    2023-06-03T15:59:52.196557  / # #

    2023-06-03T15:59:52.297356  export SHELL=3D/bin/sh

    2023-06-03T15:59:52.297572  #

    2023-06-03T15:59:52.398121  / # export SHELL=3D/bin/sh. /lava-10575759/=
environment

    2023-06-03T15:59:52.398328  =


    2023-06-03T15:59:52.498900  / # . /lava-10575759/environment/lava-10575=
759/bin/lava-test-runner /lava-10575759/1

    2023-06-03T15:59:52.499266  =


    2023-06-03T15:59:52.505341  / # /lava-10575759/bin/lava-test-runner /la=
va-10575759/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647b638c18e3f4745af5de8b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-36-ge43ef124b08b3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-36-ge43ef124b08b3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647b638c18e3f4745af5de94
        failing since 66 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-03T15:59:45.525745  + set +x<8>[    8.779801] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10575767_1.4.2.3.1>

    2023-06-03T15:59:45.525830  =


    2023-06-03T15:59:45.630006  / # #

    2023-06-03T15:59:45.730808  export SHELL=3D/bin/sh

    2023-06-03T15:59:45.731005  #

    2023-06-03T15:59:45.831541  / # export SHELL=3D/bin/sh. /lava-10575767/=
environment

    2023-06-03T15:59:45.831739  =


    2023-06-03T15:59:45.932277  / # . /lava-10575767/environment/lava-10575=
767/bin/lava-test-runner /lava-10575767/1

    2023-06-03T15:59:45.932530  =


    2023-06-03T15:59:45.937179  / # /lava-10575767/bin/lava-test-runner /la=
va-10575767/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647b638c3c7c3b2089f5de39

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-36-ge43ef124b08b3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-36-ge43ef124b08b3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647b638c3c7c3b2089f5de42
        failing since 66 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-03T15:59:49.960077  <8>[   11.671463] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10575710_1.4.2.3.1>

    2023-06-03T15:59:49.963091  + set +x

    2023-06-03T15:59:50.065352  =


    2023-06-03T15:59:50.166124  / # #export SHELL=3D/bin/sh

    2023-06-03T15:59:50.166405  =


    2023-06-03T15:59:50.267039  / # export SHELL=3D/bin/sh. /lava-10575710/=
environment

    2023-06-03T15:59:50.267344  =


    2023-06-03T15:59:50.368036  / # . /lava-10575710/environment/lava-10575=
710/bin/lava-test-runner /lava-10575710/1

    2023-06-03T15:59:50.368515  =


    2023-06-03T15:59:50.373458  / # /lava-10575710/bin/lava-test-runner /la=
va-10575710/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647b692cef22a28411f5de40

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-36-ge43ef124b08b3/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-36-ge43ef124b08b3/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647b692cef22a28411f5d=
e41
        failing since 387 days (last pass: v5.15.37-259-gab77581473a3, firs=
t fail: v5.15.39) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647b66486712a94bc9f5de5d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-36-ge43ef124b08b3/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-36-ge43ef124b08b3/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647b66486712a94bc9f5de66
        failing since 137 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-06-03T16:11:29.527119  + set +x<8>[    9.945993] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3638645_1.5.2.4.1>
    2023-06-03T16:11:29.527934  =

    2023-06-03T16:11:29.637605  / # #
    2023-06-03T16:11:29.741218  export SHELL=3D/bin/sh
    2023-06-03T16:11:29.741702  #
    2023-06-03T16:11:29.843587  / # export SHELL=3D/bin/sh. /lava-3638645/e=
nvironment
    2023-06-03T16:11:29.844744  =

    2023-06-03T16:11:29.947577  / # . /lava-3638645/environment/lava-363864=
5/bin/lava-test-runner /lava-3638645/1
    2023-06-03T16:11:29.949783  <3>[   10.273403] Bluetooth: hci0: command =
0xfc18 tx timeout
    2023-06-03T16:11:29.950590   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647b6421dff0c3ad66f5de37

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-36-ge43ef124b08b3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-36-ge43ef124b08b3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647b6421dff0c3ad66f5de40
        failing since 66 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-03T16:02:24.625459  + set +x

    2023-06-03T16:02:24.631857  <8>[   10.029801] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10575722_1.4.2.3.1>

    2023-06-03T16:02:24.736488  / # #

    2023-06-03T16:02:24.837181  export SHELL=3D/bin/sh

    2023-06-03T16:02:24.837396  #

    2023-06-03T16:02:24.938009  / # export SHELL=3D/bin/sh. /lava-10575722/=
environment

    2023-06-03T16:02:24.938227  =


    2023-06-03T16:02:25.038785  / # . /lava-10575722/environment/lava-10575=
722/bin/lava-test-runner /lava-10575722/1

    2023-06-03T16:02:25.039080  =


    2023-06-03T16:02:25.043963  / # /lava-10575722/bin/lava-test-runner /la=
va-10575722/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647b638f3c7c3b2089f5de7c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-36-ge43ef124b08b3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-36-ge43ef124b08b3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647b638f3c7c3b2089f5de85
        failing since 66 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-03T15:59:51.442023  + set +x

    2023-06-03T15:59:51.448772  <8>[    9.978947] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10575786_1.4.2.3.1>

    2023-06-03T15:59:51.551820  #

    2023-06-03T15:59:51.552292  =


    2023-06-03T15:59:51.653088  / # #export SHELL=3D/bin/sh

    2023-06-03T15:59:51.653398  =


    2023-06-03T15:59:51.754058  / # export SHELL=3D/bin/sh. /lava-10575786/=
environment

    2023-06-03T15:59:51.754362  =


    2023-06-03T15:59:51.855020  / # . /lava-10575786/environment/lava-10575=
786/bin/lava-test-runner /lava-10575786/1

    2023-06-03T15:59:51.855484  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647b637dcb739a039ef5de79

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-36-ge43ef124b08b3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-36-ge43ef124b08b3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647b637dcb739a039ef5de82
        failing since 66 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-03T15:59:33.853258  + set +x<8>[   11.995669] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10575747_1.4.2.3.1>

    2023-06-03T15:59:33.853376  =


    2023-06-03T15:59:33.957621  / # #

    2023-06-03T15:59:34.058340  export SHELL=3D/bin/sh

    2023-06-03T15:59:34.058572  #

    2023-06-03T15:59:34.159111  / # export SHELL=3D/bin/sh. /lava-10575747/=
environment

    2023-06-03T15:59:34.159346  =


    2023-06-03T15:59:34.259918  / # . /lava-10575747/environment/lava-10575=
747/bin/lava-test-runner /lava-10575747/1

    2023-06-03T15:59:34.260239  =


    2023-06-03T15:59:34.265002  / # /lava-10575747/bin/lava-test-runner /la=
va-10575747/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647b65f81b050d4fd7f5de4e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-36-ge43ef124b08b3/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline=
-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-36-ge43ef124b08b3/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline=
-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647b65f81b050d4fd7f5de57
        failing since 124 days (last pass: v5.15.81-122-gc5f8d4a5d3c8, firs=
t fail: v5.15.90-205-g5605d15db022)

    2023-06-03T16:10:11.473975  + set +x
    2023-06-03T16:10:11.474186  [    9.389908] <LAVA_SIGNAL_ENDRUN 0_dmesg =
966641_1.5.2.3.1>
    2023-06-03T16:10:11.581279  / # #
    2023-06-03T16:10:11.682920  export SHELL=3D/bin/sh
    2023-06-03T16:10:11.683477  #
    2023-06-03T16:10:11.784847  / # export SHELL=3D/bin/sh. /lava-966641/en=
vironment
    2023-06-03T16:10:11.785412  =

    2023-06-03T16:10:11.886772  / # . /lava-966641/environment/lava-966641/=
bin/lava-test-runner /lava-966641/1
    2023-06-03T16:10:11.887510  =

    2023-06-03T16:10:11.889883  / # /lava-966641/bin/lava-test-runner /lava=
-966641/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647b636854b4b7804ef5de34

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-36-ge43ef124b08b3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-36-ge43ef124b08b3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647b636854b4b7804ef5de3d
        failing since 66 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-03T15:59:24.232739  + set<8>[   12.001458] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10575718_1.4.2.3.1>

    2023-06-03T15:59:24.233176   +x

    2023-06-03T15:59:24.340987  / # #

    2023-06-03T15:59:24.443000  export SHELL=3D/bin/sh

    2023-06-03T15:59:24.443664  #

    2023-06-03T15:59:24.545041  / # export SHELL=3D/bin/sh. /lava-10575718/=
environment

    2023-06-03T15:59:24.545806  =


    2023-06-03T15:59:24.647424  / # . /lava-10575718/environment/lava-10575=
718/bin/lava-test-runner /lava-10575718/1

    2023-06-03T15:59:24.648602  =


    2023-06-03T15:59:24.653319  / # /lava-10575718/bin/lava-test-runner /la=
va-10575718/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 4          =


  Details:     https://kernelci.org/test/plan/id/647b6635080669b57af5de31

  Results:     153 PASS, 14 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-36-ge43ef124b08b3/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/=
baseline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-36-ge43ef124b08b3/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/=
baseline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/647b6635080669b57af5de4f
        failing since 19 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-03T16:11:08.381662  /lava-10575825/1/../bin/lava-test-case

    2023-06-03T16:11:08.388147  <8>[   61.549871] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/647b6635080669b57af5de4f
        failing since 19 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-03T16:11:08.381662  /lava-10575825/1/../bin/lava-test-case

    2023-06-03T16:11:08.388147  <8>[   61.549871] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/647b6635080669b57af5de51
        failing since 19 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-03T16:11:07.341644  /lava-10575825/1/../bin/lava-test-case

    2023-06-03T16:11:07.347826  <8>[   60.509808] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647b6635080669b57af5ded9
        failing since 19 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-03T16:10:53.171210  + <8>[   46.335357] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10575825_1.5.2.3.1>

    2023-06-03T16:10:53.174017  set +x

    2023-06-03T16:10:53.278580  / # #

    2023-06-03T16:10:53.379489  export SHELL=3D/bin/sh

    2023-06-03T16:10:53.379789  #

    2023-06-03T16:10:53.480424  / # export SHELL=3D/bin/sh. /lava-10575825/=
environment

    2023-06-03T16:10:53.480718  =


    2023-06-03T16:10:53.581402  / # . /lava-10575825/environment/lava-10575=
825/bin/lava-test-runner /lava-10575825/1

    2023-06-03T16:10:53.581744  =


    2023-06-03T16:10:53.586597  / # /lava-10575825/bin/lava-test-runner /la=
va-10575825/1
 =

    ... (13 line(s) more)  =

 =20
