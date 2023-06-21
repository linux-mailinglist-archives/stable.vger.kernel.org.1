Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBDD73925A
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 00:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjFUWQ3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 21 Jun 2023 18:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFUWQ3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Jun 2023 18:16:29 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F67CE57
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 15:16:27 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b520c77de0so32315475ad.0
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 15:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687385786; x=1689977786;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TStVjOWlzalkL/h6xsOI5rZ5OOUTim/xTbsS2CJHyng=;
        b=GN8u1sRIuMQFzMytLPI96v8MmQiDnt7ez0wfhN18gSB3J+SqsFuMhP91LraGLVJuLi
         YWEtUrdbynZBiUNjPck1edZ50zPK5fjoiit/GEnA0YY9dF3qep8CZrxwBekDxRu70O5o
         lX0SRywUTzxTxZx6nL0ZPMAQVUHcb6iBTlq4BIFUJgV+1QjfUXCwX9wZIE05B+a/b9Cl
         khBoM270OXl2hW3Wkz+9VeTqADjcyqz9sDanV+m32CTKb4xqzwXAIqDZTm+Q3Sp6Fhz3
         i8gxyTxCjymWQVKm7Wj2sA19vU3NNl4b4fLdQ1E3FyJvXb4YzHrLBT88OT5ej9O3o5nY
         HKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687385786; x=1689977786;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TStVjOWlzalkL/h6xsOI5rZ5OOUTim/xTbsS2CJHyng=;
        b=W4LdxQixvtYga1/avADWgG8gGPrREL7T2vIpCfZrUv8CVYqlh/Z1j5wIfT3TQaEzSv
         X+2P78Hpr6hK54OZaCu+as4EQj+tUUdei3bNwVbkS7RFaWchd4cN28slwAgJIczwsPCW
         EqV2PJaZxHYNFywJ8ewue7aeAv9GvgXqNKvUJK2bW68gxr3V/h5nv1K1rIj3LWo/YQX3
         fm8smbcXbewoetn2qfdlXFm4pb5APsw4NjfyCYC3uOCXc1tcgBwrrAOOxfJE+Q/C7Pfv
         mc88BYVq6f2eiWyk6Woc301WLATWc55cz88pSI5qxpP+2W5SxAqoAIMnrCTJqCHMOhpE
         VVZA==
X-Gm-Message-State: AC+VfDwIkeq7eHRe6wJJwDDemQld3EiSTbCAi2UFSkwnSmwtrIabm7+W
        5VLsN0FckIo3sTY2bKzuYSBXJe2gGeauj9fcG0yDDg==
X-Google-Smtp-Source: ACHHUZ4qwW8c7hswZXH0G0vKje3vvvA9zOGw31m0Jp/jCLy3V0DwiqW0jya2i7eMPu8mCJatbDoX+g==
X-Received: by 2002:a17:903:41d0:b0:1b5:5a5f:369e with SMTP id u16-20020a17090341d000b001b55a5f369emr7737979ple.8.1687385785787;
        Wed, 21 Jun 2023 15:16:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ja4-20020a170902efc400b001b55fe1b471sm3938959plb.302.2023.06.21.15.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 15:16:25 -0700 (PDT)
Message-ID: <649376b9.170a0220.51fdd.a05d@mx.google.com>
Date:   Wed, 21 Jun 2023 15:16:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.35
Subject: stable-rc/linux-6.1.y baseline: 129 runs, 11 regressions (v6.1.35)
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

stable-rc/linux-6.1.y baseline: 129 runs, 11 regressions (v6.1.35)

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

qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.35/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.35
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      e84a4e368abe42cf359fe237f0238820859d5044 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649341ab6f99eb88e030615c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649341ab6f99eb88e0306165
        failing since 83 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-21T18:29:43.426472  <8>[   12.335459] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10848673_1.4.2.3.1>

    2023-06-21T18:29:43.429971  + set +x

    2023-06-21T18:29:43.534151  / # #

    2023-06-21T18:29:43.634850  export SHELL=3D/bin/sh

    2023-06-21T18:29:43.635075  #

    2023-06-21T18:29:43.735594  / # export SHELL=3D/bin/sh. /lava-10848673/=
environment

    2023-06-21T18:29:43.735791  =


    2023-06-21T18:29:43.836314  / # . /lava-10848673/environment/lava-10848=
673/bin/lava-test-runner /lava-10848673/1

    2023-06-21T18:29:43.836603  =


    2023-06-21T18:29:43.842477  / # /lava-10848673/bin/lava-test-runner /la=
va-10848673/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649341ae0c53c664b1306131

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649341ae0c53c664b130613a
        failing since 83 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-21T18:29:45.893679  + set<8>[   11.893139] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10848691_1.4.2.3.1>

    2023-06-21T18:29:45.894156   +x

    2023-06-21T18:29:46.001165  / # #

    2023-06-21T18:29:46.101723  export SHELL=3D/bin/sh

    2023-06-21T18:29:46.101933  #

    2023-06-21T18:29:46.202397  / # export SHELL=3D/bin/sh. /lava-10848691/=
environment

    2023-06-21T18:29:46.202570  =


    2023-06-21T18:29:46.303035  / # . /lava-10848691/environment/lava-10848=
691/bin/lava-test-runner /lava-10848691/1

    2023-06-21T18:29:46.303288  =


    2023-06-21T18:29:46.307795  / # /lava-10848691/bin/lava-test-runner /la=
va-10848691/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6493419088e255107f306156

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6493419088e255107f30615f
        failing since 83 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-21T18:29:21.591972  <8>[   10.763392] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10848662_1.4.2.3.1>

    2023-06-21T18:29:21.595612  + set +x

    2023-06-21T18:29:21.700602  #

    2023-06-21T18:29:21.701683  =


    2023-06-21T18:29:21.803456  / # #export SHELL=3D/bin/sh

    2023-06-21T18:29:21.804230  =


    2023-06-21T18:29:21.905573  / # export SHELL=3D/bin/sh. /lava-10848662/=
environment

    2023-06-21T18:29:21.906251  =


    2023-06-21T18:29:22.007683  / # . /lava-10848662/environment/lava-10848=
662/bin/lava-test-runner /lava-10848662/1

    2023-06-21T18:29:22.008822  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6493409d36c66be82b3061d1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6493409d36c66be82b306=
1d2
        failing since 13 days (last pass: v6.1.31-40-g7d0a9678d276, first f=
ail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649341973bad37172d30613c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649341973bad37172d306145
        failing since 83 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-21T18:29:38.244400  + set +x

    2023-06-21T18:29:38.251225  <8>[   13.074041] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10848667_1.4.2.3.1>

    2023-06-21T18:29:38.355567  / # #

    2023-06-21T18:29:38.456273  export SHELL=3D/bin/sh

    2023-06-21T18:29:38.456478  #

    2023-06-21T18:29:38.557037  / # export SHELL=3D/bin/sh. /lava-10848667/=
environment

    2023-06-21T18:29:38.557261  =


    2023-06-21T18:29:38.657870  / # . /lava-10848667/environment/lava-10848=
667/bin/lava-test-runner /lava-10848667/1

    2023-06-21T18:29:38.658224  =


    2023-06-21T18:29:38.662559  / # /lava-10848667/bin/lava-test-runner /la=
va-10848667/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6493418fe3ced3d8d23061a2

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6493418fe3ced3d8d23061ab
        failing since 83 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-21T18:29:17.706616  + set<8>[   10.155630] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10848670_1.4.2.3.1>

    2023-06-21T18:29:17.706730   +x

    2023-06-21T18:29:17.808439  #

    2023-06-21T18:29:17.909331  / # #export SHELL=3D/bin/sh

    2023-06-21T18:29:17.909551  =


    2023-06-21T18:29:18.010103  / # export SHELL=3D/bin/sh. /lava-10848670/=
environment

    2023-06-21T18:29:18.010318  =


    2023-06-21T18:29:18.110857  / # . /lava-10848670/environment/lava-10848=
670/bin/lava-test-runner /lava-10848670/1

    2023-06-21T18:29:18.111158  =


    2023-06-21T18:29:18.116579  / # /lava-10848670/bin/lava-test-runner /la=
va-10848670/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649341a03ce7bcbe6e306132

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649341a03ce7bcbe6e30613b
        failing since 83 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-21T18:29:32.044288  + set<8>[   11.156152] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10848645_1.4.2.3.1>

    2023-06-21T18:29:32.044777   +x

    2023-06-21T18:29:32.152269  / # #

    2023-06-21T18:29:32.254513  export SHELL=3D/bin/sh

    2023-06-21T18:29:32.255226  #

    2023-06-21T18:29:32.356627  / # export SHELL=3D/bin/sh. /lava-10848645/=
environment

    2023-06-21T18:29:32.357353  =


    2023-06-21T18:29:32.458774  / # . /lava-10848645/environment/lava-10848=
645/bin/lava-test-runner /lava-10848645/1

    2023-06-21T18:29:32.460050  =


    2023-06-21T18:29:32.464656  / # /lava-10848645/bin/lava-test-runner /la=
va-10848645/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649341995f5c038e3a30618d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649341995f5c038e3a306196
        failing since 83 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-21T18:29:33.769788  + set<8>[   12.259544] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10848672_1.4.2.3.1>

    2023-06-21T18:29:33.769870   +x

    2023-06-21T18:29:33.874225  / # #

    2023-06-21T18:29:33.974801  export SHELL=3D/bin/sh

    2023-06-21T18:29:33.975000  #

    2023-06-21T18:29:34.075544  / # export SHELL=3D/bin/sh. /lava-10848672/=
environment

    2023-06-21T18:29:34.075738  =


    2023-06-21T18:29:34.176239  / # . /lava-10848672/environment/lava-10848=
672/bin/lava-test-runner /lava-10848672/1

    2023-06-21T18:29:34.176568  =


    2023-06-21T18:29:34.181299  / # /lava-10848672/bin/lava-test-runner /la=
va-10848672/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64934329246ac2eec8306136

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui=
-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui=
-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/64934329246ac2eec8306156
        failing since 41 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-06-21T18:36:07.476001  /lava-10848892/1/../bin/lava-test-case

    2023-06-21T18:36:07.485735  <8>[   22.967275] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64934329246ac2eec83061e2
        failing since 41 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-06-21T18:36:02.032844  + set +x

    2023-06-21T18:36:02.039567  <8>[   17.520529] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10848892_1.5.2.3.1>

    2023-06-21T18:36:02.147850  / # #

    2023-06-21T18:36:02.250129  export SHELL=3D/bin/sh

    2023-06-21T18:36:02.250794  #

    2023-06-21T18:36:02.352101  / # export SHELL=3D/bin/sh. /lava-10848892/=
environment

    2023-06-21T18:36:02.352812  =


    2023-06-21T18:36:02.454156  / # . /lava-10848892/environment/lava-10848=
892/bin/lava-test-runner /lava-10848892/1

    2023-06-21T18:36:02.455274  =


    2023-06-21T18:36:02.460628  / # /lava-10848892/bin/lava-test-runner /la=
va-10848892/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/64934048fa86017c6e306136

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64934048fa86017c6e306=
137
        failing since 2 days (last pass: v6.1.34-90-g7a9de0e648cfb, first f=
ail: v6.1.34-163-gfbff2eddae9a) =

 =20
