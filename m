Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E276A705625
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 20:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjEPSjl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 16 May 2023 14:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjEPSjk (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 16 May 2023 14:39:40 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238BF10F9
        for <stable@vger.kernel.org>; Tue, 16 May 2023 11:39:38 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6436e004954so14933574b3a.0
        for <stable@vger.kernel.org>; Tue, 16 May 2023 11:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684262377; x=1686854377;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kRx/mZ+7TVtCZWEI3ZZ6if10leKZJzGoJilrOBOJidc=;
        b=ezYDlsV68GVj6F2IBqoVz0zyseTKRBNiV/tTTYKzoA0Hy/D3wWOhUGNFqk07sawdNJ
         7l7o2as1vMlJEoVEe/pSucp97Nw34ApLNdIgBLYgUP/MzV65JO5w7sgpzxXGbWcU+mZ8
         OmkRz4skUnDfWfR3CtOt1GC0lXhsPQ8sFQTqx3Eznb/W7uw9G7YQoOJw5Yf/UXOeU2GS
         PH3o8oOCkVZA7JaVQ/EsJhOwKaZAhbfAJaTv2JTV2FJeuyz5Xy/EfCXIKobV72nESwUs
         BDqRNT1qlWJbVIQGm+mZmyCI/qJWhRwT74LQozlGkaL26ax1A+W6llqfFoxlwREd7xe2
         GRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684262377; x=1686854377;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kRx/mZ+7TVtCZWEI3ZZ6if10leKZJzGoJilrOBOJidc=;
        b=BYKrjebMlMe+S8nf8n3cfU/PFfS7SJZ1R4SUyNhpvqrJe9+gJzm6gMPMuUs64IQl7u
         pJx6eg1noCDzHAUVFDvxOgtqxsk0tRDQXuHEk1ugiG3/unT3oE7NOfgqNFz/j7m1rOuq
         Ld9ESt05Gkc1m9BjXoq2LicppNbrU2KqozLoKgMib6l9JBBPTlv7U5NNZKheDiEiwPl9
         vq878u7e1vC6Dcrgh7YaIl6vjx1Y/IPFavZ4GNofVh7mGSdjo/LqM54FQ+4ZCF5/5bFI
         cj6YYEmRZctolAx58jtjVAt+eLkozalHX+X92sIgdmT6MILpeszQfGVl3HZN2sm4M+iH
         baVQ==
X-Gm-Message-State: AC+VfDxYu3oqLh/CrZM13mVvPp51WjFef2USzjKRqFt7dCG+fuCJatvG
        nyIxQrWcjskU75q2mdH3U+J20zxVg2yRcVhfXDe8yg==
X-Google-Smtp-Source: ACHHUZ6bnz4HeAlh7V415+G1VCQQHuzDMi95EDM7tcK6qPUQs+BV0cfA6blQgAMhzSbloWJN5vihRQ==
X-Received: by 2002:a05:6a00:2d83:b0:643:9ca:3c7d with SMTP id fb3-20020a056a002d8300b0064309ca3c7dmr49494499pfb.4.1684262377119;
        Tue, 16 May 2023 11:39:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e13-20020a62aa0d000000b00625d84a0194sm13834724pff.107.2023.05.16.11.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 11:39:36 -0700 (PDT)
Message-ID: <6463cde8.620a0220.e18bd.c445@mx.google.com>
Date:   Tue, 16 May 2023 11:39:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.111-135-g070cc2c270b1
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.15.y baseline: 161 runs,
 13 regressions (v5.15.111-135-g070cc2c270b1)
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

stable-rc/linux-5.15.y baseline: 161 runs, 13 regressions (v5.15.111-135-g0=
70cc2c270b1)

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

fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

kontron-pitx-imx8m           | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 2          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.111-135-g070cc2c270b1/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.111-135-g070cc2c270b1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      070cc2c270b16bbdaf1701b7ade29ab4475f9423 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6463955c80b79831282e8609

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-135-g070cc2c270b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-135-g070cc2c270b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463955c80b79831282e860e
        failing since 48 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-16T14:37:59.605025  <8>[   11.477755] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10335505_1.4.2.3.1>

    2023-05-16T14:37:59.608392  + set +x

    2023-05-16T14:37:59.713083  / # #

    2023-05-16T14:37:59.813587  export SHELL=3D/bin/sh

    2023-05-16T14:37:59.813736  #

    2023-05-16T14:37:59.914181  / # export SHELL=3D/bin/sh. /lava-10335505/=
environment

    2023-05-16T14:37:59.914329  =


    2023-05-16T14:38:00.014798  / # . /lava-10335505/environment/lava-10335=
505/bin/lava-test-runner /lava-10335505/1

    2023-05-16T14:38:00.015032  =


    2023-05-16T14:38:00.021232  / # /lava-10335505/bin/lava-test-runner /la=
va-10335505/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646394ef6f5a77f2252e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-135-g070cc2c270b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-135-g070cc2c270b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646394ef6f5a77f2252e85eb
        failing since 48 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-16T14:36:04.643020  + set<8>[   11.560800] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10335501_1.4.2.3.1>

    2023-05-16T14:36:04.643177   +x

    2023-05-16T14:36:04.748050  / # #

    2023-05-16T14:36:04.848840  export SHELL=3D/bin/sh

    2023-05-16T14:36:04.849060  #

    2023-05-16T14:36:04.949632  / # export SHELL=3D/bin/sh. /lava-10335501/=
environment

    2023-05-16T14:36:04.949868  =


    2023-05-16T14:36:05.050395  / # . /lava-10335501/environment/lava-10335=
501/bin/lava-test-runner /lava-10335501/1

    2023-05-16T14:36:05.050732  =


    2023-05-16T14:36:05.054966  / # /lava-10335501/bin/lava-test-runner /la=
va-10335501/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646394e6b9d437ea372e8612

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-135-g070cc2c270b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-135-g070cc2c270b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646394e6b9d437ea372e8617
        failing since 48 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-16T14:35:56.977458  <8>[   10.321394] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10335480_1.4.2.3.1>

    2023-05-16T14:35:56.981111  + set +x

    2023-05-16T14:35:57.082575  =


    2023-05-16T14:35:57.183201  / # #export SHELL=3D/bin/sh

    2023-05-16T14:35:57.183391  =


    2023-05-16T14:35:57.283910  / # export SHELL=3D/bin/sh. /lava-10335480/=
environment

    2023-05-16T14:35:57.284114  =


    2023-05-16T14:35:57.384714  / # . /lava-10335480/environment/lava-10335=
480/bin/lava-test-runner /lava-10335480/1

    2023-05-16T14:35:57.385090  =


    2023-05-16T14:35:57.389738  / # /lava-10335480/bin/lava-test-runner /la=
va-10335480/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64639989d1feb4e9aa2e85fc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-135-g070cc2c270b1/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-135-g070cc2c270b1/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64639989d1feb4e9aa2e8=
5fd
        failing since 369 days (last pass: v5.15.37-259-gab77581473a3, firs=
t fail: v5.15.39) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64639a5965e3c213f02e85ec

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-135-g070cc2c270b1/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-135-g070cc2c270b1/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64639a5965e3c213f02e85f1
        failing since 119 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-05-16T14:59:02.250652  <8>[   10.003755] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3593403_1.5.2.4.1>
    2023-05-16T14:59:02.356852  / # #
    2023-05-16T14:59:02.458270  export SHELL=3D/bin/sh
    2023-05-16T14:59:02.458656  #
    2023-05-16T14:59:02.559705  / # export SHELL=3D/bin/sh. /lava-3593403/e=
nvironment
    2023-05-16T14:59:02.560128  =

    2023-05-16T14:59:02.661386  / # . /lava-3593403/environment/lava-359340=
3/bin/lava-test-runner /lava-3593403/1
    2023-05-16T14:59:02.662020  =

    2023-05-16T14:59:02.666930  / # /lava-3593403/bin/lava-test-runner /lav=
a-3593403/1
    2023-05-16T14:59:02.755232  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64639b533ed343927c2e861c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-135-g070cc2c270b1/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rd=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-135-g070cc2c270b1/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rd=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64639b533ed343927c2e861f
        failing since 73 days (last pass: v5.15.79, first fail: v5.15.98)

    2023-05-16T15:03:18.724369  [   15.815321] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1222297_1.5.2.4.1>
    2023-05-16T15:03:18.830125  / # #
    2023-05-16T15:03:18.932021  export SHELL=3D/bin/sh
    2023-05-16T15:03:18.932467  #
    2023-05-16T15:03:19.033817  / # export SHELL=3D/bin/sh. /lava-1222297/e=
nvironment
    2023-05-16T15:03:19.034256  =

    2023-05-16T15:03:19.135640  / # . /lava-1222297/environment/lava-122229=
7/bin/lava-test-runner /lava-1222297/1
    2023-05-16T15:03:19.136352  =

    2023-05-16T15:03:19.138155  / # /lava-1222297/bin/lava-test-runner /lav=
a-1222297/1
    2023-05-16T15:03:19.156177  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6463954762e2f9e1eb2e8636

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-135-g070cc2c270b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-135-g070cc2c270b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463954762e2f9e1eb2e863b
        failing since 48 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-16T14:37:43.244684  + set +x

    2023-05-16T14:37:43.251607  <8>[   10.410846] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10335499_1.4.2.3.1>

    2023-05-16T14:37:43.355809  / # #

    2023-05-16T14:37:43.456487  export SHELL=3D/bin/sh

    2023-05-16T14:37:43.456693  #

    2023-05-16T14:37:43.557257  / # export SHELL=3D/bin/sh. /lava-10335499/=
environment

    2023-05-16T14:37:43.557485  =


    2023-05-16T14:37:43.658097  / # . /lava-10335499/environment/lava-10335=
499/bin/lava-test-runner /lava-10335499/1

    2023-05-16T14:37:43.658365  =


    2023-05-16T14:37:43.663664  / # /lava-10335499/bin/lava-test-runner /la=
va-10335499/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646394e7379ce2d0de2e8648

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-135-g070cc2c270b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-135-g070cc2c270b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646394e7379ce2d0de2e864d
        failing since 48 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-16T14:36:00.627338  <8>[   10.340523] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10335485_1.4.2.3.1>

    2023-05-16T14:36:00.630667  + set +x

    2023-05-16T14:36:00.732054  #

    2023-05-16T14:36:00.732389  =


    2023-05-16T14:36:00.833023  / # #export SHELL=3D/bin/sh

    2023-05-16T14:36:00.833249  =


    2023-05-16T14:36:00.933791  / # export SHELL=3D/bin/sh. /lava-10335485/=
environment

    2023-05-16T14:36:00.934020  =


    2023-05-16T14:36:01.034584  / # . /lava-10335485/environment/lava-10335=
485/bin/lava-test-runner /lava-10335485/1

    2023-05-16T14:36:01.034874  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646394ea43c307f9af2e8608

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-135-g070cc2c270b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-135-g070cc2c270b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646394ea43c307f9af2e860d
        failing since 48 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-16T14:36:15.354242  + set<8>[   11.385803] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10335523_1.4.2.3.1>

    2023-05-16T14:36:15.354328   +x

    2023-05-16T14:36:15.458391  / # #

    2023-05-16T14:36:15.559106  export SHELL=3D/bin/sh

    2023-05-16T14:36:15.559298  #

    2023-05-16T14:36:15.659892  / # export SHELL=3D/bin/sh. /lava-10335523/=
environment

    2023-05-16T14:36:15.660114  =


    2023-05-16T14:36:15.760722  / # . /lava-10335523/environment/lava-10335=
523/bin/lava-test-runner /lava-10335523/1

    2023-05-16T14:36:15.761071  =


    2023-05-16T14:36:15.765101  / # /lava-10335523/bin/lava-test-runner /la=
va-10335523/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-pitx-imx8m           | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 2          =


  Details:     https://kernelci.org/test/plan/id/646397fb278dfbe3b52e8608

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-135-g070cc2c270b1/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pi=
tx-imx8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-135-g070cc2c270b1/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pi=
tx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646397fb278dfbe3b52e860b
        new failure (last pass: v5.15.111-134-g3cb5ed78068c9)

    2023-05-16T14:49:09.748104  / # #
    2023-05-16T14:49:09.850732  export SHELL=3D/bin/sh
    2023-05-16T14:49:09.851480  #
    2023-05-16T14:49:09.953228  / # export SHELL=3D/bin/sh. /lava-337895/en=
vironment
    2023-05-16T14:49:09.953934  =

    2023-05-16T14:49:10.055750  / # . /lava-337895/environment/lava-337895/=
bin/lava-test-runner /lava-337895/1
    2023-05-16T14:49:10.057014  =

    2023-05-16T14:49:10.074875  / # /lava-337895/bin/lava-test-runner /lava=
-337895/1
    2023-05-16T14:49:10.121771  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-16T14:49:10.122259  + cd /l<8>[   12.082987] <LAVA_SIGNAL_START=
RUN 1_bootrr 337895_1.5.2.4.5> =

    ... (10 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/646=
397fb278dfbe3b52e861b
        new failure (last pass: v5.15.111-134-g3cb5ed78068c9)

    2023-05-16T14:49:12.441882  /lava-337895/1/../bin/lava-test-case
    2023-05-16T14:49:12.442364  <8>[   14.496761] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>
    2023-05-16T14:49:12.442775  /lava-337895/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646394dd379ce2d0de2e85f6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-135-g070cc2c270b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-135-g070cc2c270b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646394dd379ce2d0de2e85fb
        failing since 48 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-16T14:35:58.526453  <8>[   11.250866] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10335503_1.4.2.3.1>

    2023-05-16T14:35:58.631026  / # #

    2023-05-16T14:35:58.731632  export SHELL=3D/bin/sh

    2023-05-16T14:35:58.731837  #

    2023-05-16T14:35:58.832356  / # export SHELL=3D/bin/sh. /lava-10335503/=
environment

    2023-05-16T14:35:58.832524  =


    2023-05-16T14:35:58.933001  / # . /lava-10335503/environment/lava-10335=
503/bin/lava-test-runner /lava-10335503/1

    2023-05-16T14:35:58.933314  =


    2023-05-16T14:35:58.938078  / # /lava-10335503/bin/lava-test-runner /la=
va-10335503/1

    2023-05-16T14:35:58.943396  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/6463a9f36746daf31e2e85ea

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-135-g070cc2c270b1/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i=
-h2-plus-orangepi-r1.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-135-g070cc2c270b1/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i=
-h2-plus-orangepi-r1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463a9f36746daf31e2e85ef
        failing since 33 days (last pass: v5.15.82-124-g2b8b2c150867, first=
 fail: v5.15.105-194-g415a9d81c640)

    2023-05-16T16:05:54.071008  <8>[    5.816980] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3593295_1.5.2.4.1>
    2023-05-16T16:05:54.193277  / # #
    2023-05-16T16:05:54.299903  export SHELL=3D/bin/sh
    2023-05-16T16:05:54.301616  #
    2023-05-16T16:05:54.405440  / # export SHELL=3D/bin/sh. /lava-3593295/e=
nvironment
    2023-05-16T16:05:54.407223  =

    2023-05-16T16:05:54.511109  / # . /lava-3593295/environment/lava-359329=
5/bin/lava-test-runner /lava-3593295/1
    2023-05-16T16:05:54.514344  =

    2023-05-16T16:05:54.530505  / # /lava-3593295/bin/lava-test-runner /lav=
a-3593295/1
    2023-05-16T16:05:54.659559  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
