Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F37F7431B7
	for <lists+stable@lfdr.de>; Fri, 30 Jun 2023 02:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjF3Aau (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 20:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjF3Aas (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 20:30:48 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D64E4
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 17:30:45 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5440e98616cso789856a12.0
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 17:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688085044; x=1690677044;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fEFIrVT2TZI1G+WJzCdOUTjNdU8eRrphwz//iByfJIg=;
        b=WeSaG7YWHFz4QdJgMzdjlbPQJZoH0+PNGF09zCH6W5uD4Rq1zcri0g7LabxU9QL1xb
         26xhm4Os5pOBclXZ/HBwRTI1lXjacxZ9UJC3F/NzgcogvhXtLrsQMeDjHKZgjQeXDJVo
         VlYDusjSb/wbXZ+oZObG0QylzgS7M7dgCDYAmOqCxuiGR+lMVeDkxwrUcjqTKh0Cbo5k
         fXnB/lQe5CbIMAsrgWIjcfD6P8YNhN0fK27EUn60FPp8LPH3ynPibYhgcLFGAGBy21NG
         5wflbmHX5+813cla+YEw9HswY9Me+uOxskzvSHK91emMBfexMCO5sPomLK7dp7Y36ows
         YTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688085044; x=1690677044;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fEFIrVT2TZI1G+WJzCdOUTjNdU8eRrphwz//iByfJIg=;
        b=eRWBJvK1Drf1I4B0NTK56C3Z/bPMbGAUIPV17biUVdtsHFk2QCXjc2bqK9CtYE0Qoc
         s/pHTVVEi/UAWscqzm/RT6YmN+1VS8N7r8GbaqEJoNZrAvvGWr6fDj7ZVenVRymcrVnn
         W4eNF2TAZPICkimbz3diHRsVOyurED3P5fNXNEqEQ4WAXOD5RpGnvz8br1UJygbTLxUf
         Xa7pTknAFt9k3ziFJIlmXN/k/8FkeuGBdAzb7CCCwSnWYyDrxZhDm1uaFYvn5sL+sryU
         7WGS/CgMQ9x8Z6+zBPdi7qf+/g0dbq4NxFbqOXHhVAsv7QiUjrSlZ+ZpQgMRNKdDKj1T
         KrlA==
X-Gm-Message-State: ABy/qLZ/se4YPFq3Xwu3K6T+qhFUDarpRPR81LDnASKNgbP4x8HZ8Iv2
        NAf35g+t8ajV/lxcdDcz6wQCzBiKP/OIpTy5TeoQJw==
X-Google-Smtp-Source: APBJJlFpyynjpENzBjMMSwz+aSicuYMBFXlpczGqEVUy46LlrN9oh5qWiDJeOFxPL8xzAtkfJW68ZQ==
X-Received: by 2002:a17:90a:94cc:b0:253:3eb5:3ade with SMTP id j12-20020a17090a94cc00b002533eb53ademr1783652pjw.8.1688085044333;
        Thu, 29 Jun 2023 17:30:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m19-20020a17090ade1300b0025c1cfdb93esm9774362pjv.13.2023.06.29.17.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 17:30:43 -0700 (PDT)
Message-ID: <649e2233.170a0220.f8254.33ff@mx.google.com>
Date:   Thu, 29 Jun 2023 17:30:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15.119-13-ga5e54d03cf39d
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.15.y
Subject: stable-rc/linux-5.15.y baseline: 146 runs,
 13 regressions (v5.15.119-13-ga5e54d03cf39d)
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

stable-rc/linux-5.15.y baseline: 146 runs, 13 regressions (v5.15.119-13-ga5=
e54d03cf39d)

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

rk3328-rock64                | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.119-13-ga5e54d03cf39d/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.119-13-ga5e54d03cf39d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      a5e54d03cf39db7eed877a6417d2518e8573435a =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649de9df4eebcdfdf5bb2abf

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-13-ga5e54d03cf39d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-13-ga5e54d03cf39d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649de9df4eebcdfdf5bb2ac4
        failing since 92 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-29T20:30:07.557841  <8>[   11.147793] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10955033_1.4.2.3.1>

    2023-06-29T20:30:07.560858  + set +x

    2023-06-29T20:30:07.666080  / # #

    2023-06-29T20:30:07.768332  export SHELL=3D/bin/sh

    2023-06-29T20:30:07.769160  #

    2023-06-29T20:30:07.870801  / # export SHELL=3D/bin/sh. /lava-10955033/=
environment

    2023-06-29T20:30:07.871663  =


    2023-06-29T20:30:07.973246  / # . /lava-10955033/environment/lava-10955=
033/bin/lava-test-runner /lava-10955033/1

    2023-06-29T20:30:07.974474  =


    2023-06-29T20:30:07.980238  / # /lava-10955033/bin/lava-test-runner /la=
va-10955033/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649de9ddc6b7f82283bb2a86

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-13-ga5e54d03cf39d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-13-ga5e54d03cf39d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649de9ddc6b7f82283bb2a8b
        failing since 92 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-29T20:30:08.503143  + set<8>[   11.022124] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10955045_1.4.2.3.1>

    2023-06-29T20:30:08.503576   +x

    2023-06-29T20:30:08.611405  / # #

    2023-06-29T20:30:08.713868  export SHELL=3D/bin/sh

    2023-06-29T20:30:08.714679  #

    2023-06-29T20:30:08.816040  / # export SHELL=3D/bin/sh. /lava-10955045/=
environment

    2023-06-29T20:30:08.816747  =


    2023-06-29T20:30:08.918233  / # . /lava-10955045/environment/lava-10955=
045/bin/lava-test-runner /lava-10955045/1

    2023-06-29T20:30:08.919289  =


    2023-06-29T20:30:08.924331  / # /lava-10955045/bin/lava-test-runner /la=
va-10955045/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649de9e0c6b7f82283bb2aa0

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-13-ga5e54d03cf39d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-13-ga5e54d03cf39d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649de9e0c6b7f82283bb2aa5
        failing since 92 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-29T20:30:10.021600  <8>[   11.433676] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10955122_1.4.2.3.1>

    2023-06-29T20:30:10.025551  + set +x

    2023-06-29T20:30:10.130808  #

    2023-06-29T20:30:10.131297  =


    2023-06-29T20:30:10.232136  / # #export SHELL=3D/bin/sh

    2023-06-29T20:30:10.232879  =


    2023-06-29T20:30:10.334246  / # export SHELL=3D/bin/sh. /lava-10955122/=
environment

    2023-06-29T20:30:10.334998  =


    2023-06-29T20:30:10.436507  / # . /lava-10955122/environment/lava-10955=
122/bin/lava-test-runner /lava-10955122/1

    2023-06-29T20:30:10.437646  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/649e1120567f00c4a5bb2b7b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-13-ga5e54d03cf39d/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-13-ga5e54d03cf39d/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649e1120567f00c4a5bb2=
b7c
        failing since 413 days (last pass: v5.15.37-259-gab77581473a3, firs=
t fail: v5.15.39) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/649e0b7655ec87f5d0bb2a7b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-13-ga5e54d03cf39d/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-13-ga5e54d03cf39d/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649e0b7655ec87f5d0bb2a80
        failing since 163 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-06-29T22:53:17.197619  <8>[   10.058041] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3700723_1.5.2.4.1>
    2023-06-29T22:53:17.304939  / # #
    2023-06-29T22:53:17.408093  export SHELL=3D/bin/sh
    2023-06-29T22:53:17.408991  #
    2023-06-29T22:53:17.510854  / # export SHELL=3D/bin/sh. /lava-3700723/e=
nvironment
    2023-06-29T22:53:17.511216  =

    2023-06-29T22:53:17.511418  / # . /lava-3700723/environment<3>[   10.35=
3153] Bluetooth: hci0: command 0xfc18 tx timeout
    2023-06-29T22:53:17.612757  /lava-3700723/bin/lava-test-runner /lava-37=
00723/1
    2023-06-29T22:53:17.614590  =

    2023-06-29T22:53:17.619408  / # /lava-3700723/bin/lava-test-runner /lav=
a-3700723/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649dea2efe18cc15a1bb2a91

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-13-ga5e54d03cf39d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-13-ga5e54d03cf39d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649dea2efe18cc15a1bb2a96
        failing since 92 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-29T20:31:27.288061  + set +x

    2023-06-29T20:31:27.294719  <8>[   10.097787] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10955127_1.4.2.3.1>

    2023-06-29T20:31:27.402948  / # #

    2023-06-29T20:31:27.505317  export SHELL=3D/bin/sh

    2023-06-29T20:31:27.506060  #

    2023-06-29T20:31:27.607494  / # export SHELL=3D/bin/sh. /lava-10955127/=
environment

    2023-06-29T20:31:27.608223  =


    2023-06-29T20:31:27.709491  / # . /lava-10955127/environment/lava-10955=
127/bin/lava-test-runner /lava-10955127/1

    2023-06-29T20:31:27.709900  =


    2023-06-29T20:31:27.714567  / # /lava-10955127/bin/lava-test-runner /la=
va-10955127/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649de9cd8e0bfd69acbb2ac4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-13-ga5e54d03cf39d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-13-ga5e54d03cf39d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649de9cd8e0bfd69acbb2ac9
        failing since 92 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-29T20:29:48.282371  <8>[   10.670505] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10955104_1.4.2.3.1>

    2023-06-29T20:29:48.285476  + set +x

    2023-06-29T20:29:48.386953  =


    2023-06-29T20:29:48.487800  / # #export SHELL=3D/bin/sh

    2023-06-29T20:29:48.488657  =


    2023-06-29T20:29:48.590160  / # export SHELL=3D/bin/sh. /lava-10955104/=
environment

    2023-06-29T20:29:48.590856  =


    2023-06-29T20:29:48.692161  / # . /lava-10955104/environment/lava-10955=
104/bin/lava-test-runner /lava-10955104/1

    2023-06-29T20:29:48.693492  =


    2023-06-29T20:29:48.699191  / # /lava-10955104/bin/lava-test-runner /la=
va-10955104/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649de9e172ea7a1e7bbb2a9a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-13-ga5e54d03cf39d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-13-ga5e54d03cf39d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649de9e172ea7a1e7bbb2a9f
        failing since 92 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-29T20:30:00.793108  + set<8>[   10.617048] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10955062_1.4.2.3.1>

    2023-06-29T20:30:00.793207   +x

    2023-06-29T20:30:00.897443  / # #

    2023-06-29T20:30:00.998084  export SHELL=3D/bin/sh

    2023-06-29T20:30:00.998272  #

    2023-06-29T20:30:01.098740  / # export SHELL=3D/bin/sh. /lava-10955062/=
environment

    2023-06-29T20:30:01.098936  =


    2023-06-29T20:30:01.199450  / # . /lava-10955062/environment/lava-10955=
062/bin/lava-test-runner /lava-10955062/1

    2023-06-29T20:30:01.199791  =


    2023-06-29T20:30:01.204684  / # /lava-10955062/bin/lava-test-runner /la=
va-10955062/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/649dedd192e6c5a27cbb2a8e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-13-ga5e54d03cf39d/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline=
-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-13-ga5e54d03cf39d/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline=
-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649dedd192e6c5a27cbb2a93
        failing since 150 days (last pass: v5.15.81-122-gc5f8d4a5d3c8, firs=
t fail: v5.15.90-205-g5605d15db022)

    2023-06-29T20:47:05.262061  + set +x
    2023-06-29T20:47:05.262230  [    9.492631] <LAVA_SIGNAL_ENDRUN 0_dmesg =
990858_1.5.2.3.1>
    2023-06-29T20:47:05.369066  / # #
    2023-06-29T20:47:05.470675  export SHELL=3D/bin/sh
    2023-06-29T20:47:05.471116  #
    2023-06-29T20:47:05.572274  / # export SHELL=3D/bin/sh. /lava-990858/en=
vironment
    2023-06-29T20:47:05.572655  =

    2023-06-29T20:47:05.673848  / # . /lava-990858/environment/lava-990858/=
bin/lava-test-runner /lava-990858/1
    2023-06-29T20:47:05.674412  =

    2023-06-29T20:47:05.677436  / # /lava-990858/bin/lava-test-runner /lava=
-990858/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649de9cc8e0bfd69acbb2ab4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-13-ga5e54d03cf39d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-13-ga5e54d03cf39d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649de9cc8e0bfd69acbb2ab9
        failing since 92 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-29T20:29:55.272289  <8>[   12.402265] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10955043_1.4.2.3.1>

    2023-06-29T20:29:55.380241  / # #

    2023-06-29T20:29:55.482603  export SHELL=3D/bin/sh

    2023-06-29T20:29:55.483349  #

    2023-06-29T20:29:55.584918  / # export SHELL=3D/bin/sh. /lava-10955043/=
environment

    2023-06-29T20:29:55.585672  =


    2023-06-29T20:29:55.687566  / # . /lava-10955043/environment/lava-10955=
043/bin/lava-test-runner /lava-10955043/1

    2023-06-29T20:29:55.688757  =


    2023-06-29T20:29:55.693689  / # /lava-10955043/bin/lava-test-runner /la=
va-10955043/1

    2023-06-29T20:29:55.699350  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3328-rock64                | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649def9fb7b494bbffbb2a7a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-13-ga5e54d03cf39d/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-ro=
ck64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-13-ga5e54d03cf39d/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-ro=
ck64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649def9fb7b494bbffbb2a7d
        failing since 21 days (last pass: v5.15.72-38-gebe70cd7f5413, first=
 fail: v5.15.114-196-g00621f2608ac)

    2023-06-29T20:54:36.653436  [   16.011862] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3700797_1.5.2.4.1>
    2023-06-29T20:54:36.758127  =

    2023-06-29T20:54:36.758349  / # #[   16.095692] rockchip-drm display-su=
bsystem: [drm] Cannot find any crtc or sizes
    2023-06-29T20:54:36.859926  export SHELL=3D/bin/sh
    2023-06-29T20:54:36.860384  =

    2023-06-29T20:54:36.961856  / # export SHELL=3D/bin/sh. /lava-3700797/e=
nvironment
    2023-06-29T20:54:36.962233  =

    2023-06-29T20:54:37.063446  / # . /lava-3700797/environment/lava-370079=
7/bin/lava-test-runner /lava-3700797/1
    2023-06-29T20:54:37.063920  =

    2023-06-29T20:54:37.067335  / # /lava-3700797/bin/lava-test-runner /lav=
a-3700797/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649df45490348b2618bb2b23

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-13-ga5e54d03cf39d/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a6=
4-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-13-ga5e54d03cf39d/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a6=
4-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649df45490348b2618bb2b50
        failing since 163 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-06-29T21:14:33.490802  + set +x
    2023-06-29T21:14:33.494965  <8>[   16.121678] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3700821_1.5.2.4.1>
    2023-06-29T21:14:33.616117  / # #
    2023-06-29T21:14:33.722136  export SHELL=3D/bin/sh
    2023-06-29T21:14:33.723645  #
    2023-06-29T21:14:33.826886  / # export SHELL=3D/bin/sh. /lava-3700821/e=
nvironment
    2023-06-29T21:14:33.828749  =

    2023-06-29T21:14:33.932424  / # . /lava-3700821/environment/lava-370082=
1/bin/lava-test-runner /lava-3700821/1
    2023-06-29T21:14:33.935290  =

    2023-06-29T21:14:33.937834  / # /lava-3700821/bin/lava-test-runner /lav=
a-3700821/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649defd559888d7c03bb2aa7

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-13-ga5e54d03cf39d/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64=
-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19-13-ga5e54d03cf39d/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64=
-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649defd559888d7c03bb2ad4
        failing since 163 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-06-29T20:55:35.683548  + set +x
    2023-06-29T20:55:35.687447  <8>[   16.043205] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 677918_1.5.2.4.1>
    2023-06-29T20:55:35.797543  / # #
    2023-06-29T20:55:35.899732  export SHELL=3D/bin/sh
    2023-06-29T20:55:35.900312  #
    2023-06-29T20:55:36.001912  / # export SHELL=3D/bin/sh. /lava-677918/en=
vironment
    2023-06-29T20:55:36.002384  =

    2023-06-29T20:55:36.104103  / # . /lava-677918/environment/lava-677918/=
bin/lava-test-runner /lava-677918/1
    2023-06-29T20:55:36.105004  =

    2023-06-29T20:55:36.108775  / # /lava-677918/bin/lava-test-runner /lava=
-677918/1 =

    ... (12 line(s) more)  =

 =20
