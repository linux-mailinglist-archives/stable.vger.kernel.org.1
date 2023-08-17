Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F9777EE5E
	for <lists+stable@lfdr.de>; Thu, 17 Aug 2023 02:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347323AbjHQAhx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 16 Aug 2023 20:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347374AbjHQAhn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 16 Aug 2023 20:37:43 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F3026AD
        for <stable@vger.kernel.org>; Wed, 16 Aug 2023 17:37:40 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bf078d5fb7so5677665ad.0
        for <stable@vger.kernel.org>; Wed, 16 Aug 2023 17:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692232659; x=1692837459;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2/JD0SLMdfiT+X+RNk86Qh1sZZxOQHaoJwLYYJwOMs0=;
        b=UJAFkDvkyoNAdXyoRM920iynGEXq5uev4cyjBPM0+OIaLkKgvr1zu4Tlfs90PIGUA/
         TwCYfkVgMmkrJWv53MMaAyYCJwWBmkLflIGqJmIvrcwQFpcBYZCPXPD1hB/0/ZxKMmUj
         +ct6RQFqUdDFgzd/pqqiFIjSCUeFIl2NrswniMV13+YQ+/jiHnJdgaHQCclppofuWt5k
         VYw0ssn0mDpulyDR2HqRYBIUEJYbQbnEn/YY0LcT6imUCCTHCNrzUzR88MhJ/1I/N6O0
         dDeKkiZiXhj/uZu2FKvdIbRb2srNw/DCoOh8IGTAa1CUz5lvqZMIOnIJP7PBPO8KYvzE
         gq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692232659; x=1692837459;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/JD0SLMdfiT+X+RNk86Qh1sZZxOQHaoJwLYYJwOMs0=;
        b=Wd9R5YXq0XS2+iqTN8wVlpzpbybIG3a+FsFLss3XkVhl4D1hElFrTqoIaS9r7WmwjC
         7h1JB2sAEikHV2CRzOBYm23JZaP7f3ej6L1b3IGqWqpom70mSNvypQSiKoues/ZANDLu
         IncmJZRJYkw6Mnwfq4bTZoIfenNuL0mxxfsaIoXMiX+14ktzAW8OkLxDTiQYpKEw+wgo
         3robxFHESbXqSAy+JSzEJtk4prjeONMgFk8GDJE33iAVrC5L5O42HVHuY8xmUtVMeiEK
         AvmHl2hp2NOrdJATtv2WhEtLKz8v3kylfzZrHWXaf1jijBIO2BR72dgV6wnGvP2977pB
         ZT+g==
X-Gm-Message-State: AOJu0YwPxuA/QzHmSNhKcRGA9T0BJxKUU6qZshAB42A4HMnfzcc0IE6h
        Yp0Ib7V469TB5DNWHhz7CGY4QjcBP9jwyh0gXdsSmQ==
X-Google-Smtp-Source: AGHT+IFMj3ataHdFEAAC4+fB7Qv4rpVTaE6rngms8G9rBswmBYxYOEjXgssLBRZfl97+tO+np0t+Gg==
X-Received: by 2002:a17:902:ff01:b0:1bc:7a4b:5c68 with SMTP id f1-20020a170902ff0100b001bc7a4b5c68mr2646972plj.39.1692232659338;
        Wed, 16 Aug 2023 17:37:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i15-20020a17090332cf00b001bc35b14c99sm13694063plr.212.2023.08.16.17.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 17:37:38 -0700 (PDT)
Message-ID: <64dd6bd2.170a0220.152d2.9fb4@mx.google.com>
Date:   Wed, 16 Aug 2023 17:37:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.127
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.15.y
Subject: stable-rc/linux-5.15.y baseline: 118 runs, 13 regressions (v5.15.127)
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

stable-rc/linux-5.15.y baseline: 118 runs, 13 regressions (v5.15.127)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

at91-sama5d4_xplained     | arm    | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig           | 1          =

beagle-xm                 | arm    | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig          | 1          =

cubietruck                | arm    | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig           | 1          =

fsl-ls2088a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =

fsl-lx2160a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =

hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

r8a77960-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.127/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.127
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      f6f7927ac664ba23447f8dd3c3dfe2f4ee39272f =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd387915ddb94a6f35b1e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd387915ddb94a6f35b1eb
        failing since 140 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-16T20:58:10.061151  + set +x

    2023-08-16T20:58:10.068194  <8>[   11.047638] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11302944_1.4.2.3.1>

    2023-08-16T20:58:10.176572  / # #

    2023-08-16T20:58:10.279082  export SHELL=3D/bin/sh

    2023-08-16T20:58:10.280075  #

    2023-08-16T20:58:10.381606  / # export SHELL=3D/bin/sh. /lava-11302944/=
environment

    2023-08-16T20:58:10.382359  =


    2023-08-16T20:58:10.484110  / # . /lava-11302944/environment/lava-11302=
944/bin/lava-test-runner /lava-11302944/1

    2023-08-16T20:58:10.484413  =


    2023-08-16T20:58:10.490339  / # /lava-11302944/bin/lava-test-runner /la=
va-11302944/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd38781ad068017635b1e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd38781ad068017635b1eb
        failing since 140 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-16T20:58:08.558387  <8>[   11.043094] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11302939_1.4.2.3.1>

    2023-08-16T20:58:08.561899  + set +x

    2023-08-16T20:58:08.663310  =


    2023-08-16T20:58:08.763885  / # #export SHELL=3D/bin/sh

    2023-08-16T20:58:08.764054  =


    2023-08-16T20:58:08.864570  / # export SHELL=3D/bin/sh. /lava-11302939/=
environment

    2023-08-16T20:58:08.864730  =


    2023-08-16T20:58:08.965249  / # . /lava-11302939/environment/lava-11302=
939/bin/lava-test-runner /lava-11302939/1

    2023-08-16T20:58:08.965489  =


    2023-08-16T20:58:08.970737  / # /lava-11302939/bin/lava-test-runner /la=
va-11302939/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
at91-sama5d4_xplained     | arm    | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd3c062533d6c23535b201

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-sama5d4_xplaine=
d.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-sama5d4_xplaine=
d.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd3c062533d6c23535b=
202
        new failure (last pass: v5.15.126-90-g952b0de2b49f7) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beagle-xm                 | arm    | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd3ce1f267b22f0d35b1ed

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd3ce1f267b22f0d35b=
1ee
        failing since 22 days (last pass: v5.15.120, first fail: v5.15.122-=
79-g3bef1500d246a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
cubietruck                | arm    | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd3bf61a851d6e8635b324

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd3bf61a851d6e8635b329
        failing since 211 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-08-16T21:13:06.775741  <8>[    9.904024] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3743944_1.5.2.4.1>
    2023-08-16T21:13:06.883777  / # #
    2023-08-16T21:13:06.987476  export SHELL=3D/bin/sh
    2023-08-16T21:13:06.988421  #
    2023-08-16T21:13:07.090148  / # export SHELL=3D/bin/sh. /lava-3743944/e=
nvironment
    2023-08-16T21:13:07.091226  =

    2023-08-16T21:13:07.193549  / # . /lava-3743944/environment/lava-374394=
4/bin/lava-test-runner /lava-3743944/1
    2023-08-16T21:13:07.195718  =

    2023-08-16T21:13:07.199995  / # /lava-3743944/bin/lava-test-runner /lav=
a-3743944/1
    2023-08-16T21:13:07.288379  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
fsl-ls2088a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd3ae16d3a227e6535b1f0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd3ae16d3a227e6535b1f3
        failing since 33 days (last pass: v5.15.67, first fail: v5.15.119-1=
6-g66130849c020f)

    2023-08-16T21:08:33.256181  [   11.373765] EDAC FSL_DDR MC1: Expected D=
ata / ECC:	0x52800022_54dff921 / 0x8000000e
    2023-08-16T21:08:33.261743  [   11.389757] EDAC FSL_DDR MC1: Captured D=
ata / ECC:	0x52a00022_54fff921 / 0x0e
    2023-08-16T21:08:33.267316  [   11.396885] EDAC FSL_DDR MC1: Err addr: =
0x00f36800
    2023-08-16T21:08:33.272862  [   11.401668] EDAC FSL_DDR MC1: PFN: 0x000=
00f36
    2023-08-16T21:08:33.283992  [   11.406017] EDAC MC1: 1 CE fsl_mc_err on=
 mc#1csrow#0channel#0 (csrow:0 channel:0 page:0xf36 offset:0x800 grain:8 sy=
ndrome:0xe)
    2023-08-16T21:08:33.289506  + set +x[   11.417456] <LAVA_SIGNAL_ENDRUN =
0_dmesg 1244309_1.5.2.4.1>
    2023-08-16T21:08:33.289759  =

    2023-08-16T21:08:33.295089  [   11.423774] EDAC FSL_DDR MC1: Err Detect=
 Register: 0x00000004
    2023-08-16T21:08:33.300669  [   11.429517] EDAC FSL_DDR MC1: Faulty Dat=
a bit: 53
    2023-08-16T21:08:33.306221  [   11.434212] EDAC FSL_DDR MC1: Expected D=
ata / ECC:	0x52800022_54dff921 / 0x8000000e =

    ... (52 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
fsl-lx2160a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd3ae742e34bdfe935b31e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd3ae742e34bdfe935b321
        failing since 166 days (last pass: v5.15.79, first fail: v5.15.98)

    2023-08-16T21:08:34.541682  [   13.991262] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1244311_1.5.2.4.1>
    2023-08-16T21:08:34.646740  =

    2023-08-16T21:08:34.747909  / # #export SHELL=3D/bin/sh
    2023-08-16T21:08:34.748319  =

    2023-08-16T21:08:34.849290  / # export SHELL=3D/bin/sh. /lava-1244311/e=
nvironment
    2023-08-16T21:08:34.849699  =

    2023-08-16T21:08:34.950655  / # . /lava-1244311/environment/lava-124431=
1/bin/lava-test-runner /lava-1244311/1
    2023-08-16T21:08:34.951353  =

    2023-08-16T21:08:34.954388  / # /lava-1244311/bin/lava-test-runner /lav=
a-1244311/1
    2023-08-16T21:08:34.970315  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd394aee185fbb2335b26a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd394bee185fbb2335b26f
        failing since 140 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-16T21:01:43.134917  + set +x

    2023-08-16T21:01:43.141737  <8>[   10.364171] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11302932_1.4.2.3.1>

    2023-08-16T21:01:43.243447  #

    2023-08-16T21:01:43.243720  =


    2023-08-16T21:01:43.344330  / # #export SHELL=3D/bin/sh

    2023-08-16T21:01:43.344514  =


    2023-08-16T21:01:43.445098  / # export SHELL=3D/bin/sh. /lava-11302932/=
environment

    2023-08-16T21:01:43.445267  =


    2023-08-16T21:01:43.545831  / # . /lava-11302932/environment/lava-11302=
932/bin/lava-test-runner /lava-11302932/1

    2023-08-16T21:01:43.546072  =

 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd3866c1c5f92fef35b1f4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd3866c1c5f92fef35b1f9
        failing since 140 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-16T20:58:03.356450  + set<8>[   10.929951] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11302930_1.4.2.3.1>

    2023-08-16T20:58:03.356961   +x

    2023-08-16T20:58:03.464277  / # #

    2023-08-16T20:58:03.566711  export SHELL=3D/bin/sh

    2023-08-16T20:58:03.567714  #

    2023-08-16T20:58:03.669201  / # export SHELL=3D/bin/sh. /lava-11302930/=
environment

    2023-08-16T20:58:03.669970  =


    2023-08-16T20:58:03.771479  / # . /lava-11302930/environment/lava-11302=
930/bin/lava-test-runner /lava-11302930/1

    2023-08-16T20:58:03.772877  =


    2023-08-16T20:58:03.777959  / # /lava-11302930/bin/lava-test-runner /la=
va-11302930/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd3865c1c5f92fef35b1e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-len=
ovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-len=
ovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd3865c1c5f92fef35b1eb
        failing since 140 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-16T20:57:57.777520  + set<8>[   12.283414] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11302949_1.4.2.3.1>

    2023-08-16T20:57:57.777604   +x

    2023-08-16T20:57:57.881952  / # #

    2023-08-16T20:57:57.982633  export SHELL=3D/bin/sh

    2023-08-16T20:57:57.982879  #

    2023-08-16T20:57:58.083428  / # export SHELL=3D/bin/sh. /lava-11302949/=
environment

    2023-08-16T20:57:58.083634  =


    2023-08-16T20:57:58.184211  / # . /lava-11302949/environment/lava-11302=
949/bin/lava-test-runner /lava-11302949/1

    2023-08-16T20:57:58.184564  =


    2023-08-16T20:57:58.188896  / # /lava-11302949/bin/lava-test-runner /la=
va-11302949/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a77960-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd3a5a186a864acb35b1fb

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd3a5a186a864acb35b200
        failing since 28 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-08-16T21:07:56.149215  / # #

    2023-08-16T21:07:56.251556  export SHELL=3D/bin/sh

    2023-08-16T21:07:56.252325  #

    2023-08-16T21:07:56.353741  / # export SHELL=3D/bin/sh. /lava-11303076/=
environment

    2023-08-16T21:07:56.354526  =


    2023-08-16T21:07:56.455892  / # . /lava-11303076/environment/lava-11303=
076/bin/lava-test-runner /lava-11303076/1

    2023-08-16T21:07:56.457223  =


    2023-08-16T21:07:56.472710  / # /lava-11303076/bin/lava-test-runner /la=
va-11303076/1

    2023-08-16T21:07:56.522726  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-16T21:07:56.523252  + cd /lav<8>[   15.916352] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11303076_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd3a6f9625068fde35b1d9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd3a6f9625068fde35b1de
        failing since 28 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-08-16T21:06:34.506928  / # #

    2023-08-16T21:06:35.586928  export SHELL=3D/bin/sh

    2023-08-16T21:06:35.588701  #

    2023-08-16T21:06:37.078724  / # export SHELL=3D/bin/sh. /lava-11303081/=
environment

    2023-08-16T21:06:37.080489  =


    2023-08-16T21:06:39.804456  / # . /lava-11303081/environment/lava-11303=
081/bin/lava-test-runner /lava-11303081/1

    2023-08-16T21:06:39.806727  =


    2023-08-16T21:06:39.815124  / # /lava-11303081/bin/lava-test-runner /la=
va-11303081/1

    2023-08-16T21:06:39.877550  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-16T21:06:39.878046  + cd /lava-113030<8>[   25.491057] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11303081_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd3a6db2e6eeee6735b2b4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd3a6db2e6eeee6735b2b9
        failing since 28 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-08-16T21:08:09.854464  / # #

    2023-08-16T21:08:09.955025  export SHELL=3D/bin/sh

    2023-08-16T21:08:09.955173  #

    2023-08-16T21:08:10.055634  / # export SHELL=3D/bin/sh. /lava-11303071/=
environment

    2023-08-16T21:08:10.055791  =


    2023-08-16T21:08:10.156390  / # . /lava-11303071/environment/lava-11303=
071/bin/lava-test-runner /lava-11303071/1

    2023-08-16T21:08:10.157385  =


    2023-08-16T21:08:10.163145  / # /lava-11303071/bin/lava-test-runner /la=
va-11303071/1

    2023-08-16T21:08:10.230138  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-16T21:08:10.230583  + cd /lava-1130307<8>[   16.788066] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11303071_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
