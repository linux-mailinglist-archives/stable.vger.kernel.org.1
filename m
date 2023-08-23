Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8663A7861B7
	for <lists+stable@lfdr.de>; Wed, 23 Aug 2023 22:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbjHWUpq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 23 Aug 2023 16:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236109AbjHWUpZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 23 Aug 2023 16:45:25 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC9410C8
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 13:45:22 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-26d5970cd28so3321581a91.2
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 13:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692823521; x=1693428321;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HVPB+kp1LT8tkTNsfWNDgDB9ztr/tG88LVkIq7yFf4s=;
        b=SdCRe/FCboX6z6CcPnma7kfyhhaszfmlwgwoV+j4IgVeAneOF0r/5wewccVmKgrtdR
         +/zyCbJ8Am2maTHQ5ZVD7ePgIDEgg2RqTUUopjWtEUkOu3h54ghzeyPFXAOOn8Walblx
         W9qTbEsCFgIAh01OOCPu4aLafPRkaByowF2KuP3s8PsNskJzX76N8PpD9e465liGKcBj
         9n5foPhZVk0jmRHL7x5LZ23raus0FNio/sB46Hie1/nayZ8mWEsxPFc8BhBWElfxYx64
         d3LS0M3jLY/VE+1EQ1CqHBNsVhtOWBWDBDFKn2sXR/APJ/3Paqw8ulTrs4hVT/kn7oyP
         5l/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692823521; x=1693428321;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HVPB+kp1LT8tkTNsfWNDgDB9ztr/tG88LVkIq7yFf4s=;
        b=crgRxmrBMdSnEz5i+M1pQAiEwdL6HkHMa9gomFuUhWdS7v4JsQc1PwNrHPVsPhjqOP
         9AJTDNtgz8KQVpztBbtvLNymDkVft2QZLs6gCZsGpHYD3FmPcmvo5l0xSWnO1tl1I0g5
         M4LINg7CnyUw435ckXspeBhclYEoWQH2OoVekxIwnXwYfkwXZK9Op+ZTPRKN2LPNuKaY
         BBbgS+i1dCq3ymZnEU4ciojGxZjubQm5EMJmp3JkMPQPy32nNQHlph6H566u+RfqXm28
         yN4+D6Jo+K2qDVOm3qGnMclWTtbDZUaMcUS5/VdjhQQ57J1eloIaF5RDcgNmR2Q9PWL7
         vDlA==
X-Gm-Message-State: AOJu0YyjsM8Nuk+F7BB04bVuNB5v3aSAGuhP21t/HJPtrw/InUblKZuT
        UGIk0UP/7GRipidl0dI1HRp0hlLmQyGig7uW1AQ=
X-Google-Smtp-Source: AGHT+IG3p8MT7d3sLUmifFw3kCJCLeScdoCfe8wjSaaUKmGTd0NK3f2KlxHJ2FkyoQ4ZNpXvRRDdUw==
X-Received: by 2002:a17:90b:1956:b0:268:7be6:29a5 with SMTP id nk22-20020a17090b195600b002687be629a5mr10237427pjb.9.1692823521015;
        Wed, 23 Aug 2023 13:45:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id az15-20020a17090b028f00b00262d9b4b527sm190429pjb.52.2023.08.23.13.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 13:45:20 -0700 (PDT)
Message-ID: <64e66fe0.170a0220.8d68.0d3e@mx.google.com>
Date:   Wed, 23 Aug 2023 13:45:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.127
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.15.y
Subject: stable-rc/linux-5.15.y baseline: 124 runs, 14 regressions (v5.15.127)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.15.y baseline: 124 runs, 14 regressions (v5.15.127)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
acer-cb317-1h-c3z6-dedede | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

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
acer-cb317-1h-c3z6-dedede | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd3866c1c5f92fef35b1ff

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-ace=
r-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-ace=
r-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd3866c1c5f92fef35b=
200
        new failure (last pass: v5.15.126-90-g952b0de2b49f7) =

 =



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

    2023-08-23T16:52:39.496036  + set +x

    2023-08-23T16:52:39.502936  <8>[   10.599687] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11337829_1.4.2.3.1>

    2023-08-23T16:52:39.611782  =


    2023-08-23T16:52:39.713543  / # #export SHELL=3D/bin/sh

    2023-08-23T16:52:39.713776  =


    2023-08-23T16:52:39.814487  / # export SHELL=3D/bin/sh. /lava-11337829/=
environment

    2023-08-23T16:52:39.815207  =


    2023-08-23T16:52:39.916655  / # . /lava-11337829/environment/lava-11337=
829/bin/lava-test-runner /lava-11337829/1

    2023-08-23T16:52:39.917911  =


    2023-08-23T16:52:39.924137  / # /lava-11337829/bin/lava-test-runner /la=
va-11337829/1
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

    2023-08-23T16:52:29.519088  <8>[   10.561468] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11337824_1.4.2.3.1>

    2023-08-23T16:52:29.522630  + set +x

    2023-08-23T16:52:29.623959  #

    2023-08-23T16:52:29.624185  =


    2023-08-23T16:52:29.724722  / # #export SHELL=3D/bin/sh

    2023-08-23T16:52:29.724899  =


    2023-08-23T16:52:29.825375  / # export SHELL=3D/bin/sh. /lava-11337824/=
environment

    2023-08-23T16:52:29.825556  =


    2023-08-23T16:52:29.926094  / # . /lava-11337824/environment/lava-11337=
824/bin/lava-test-runner /lava-11337824/1

    2023-08-23T16:52:29.926395  =

 =

    ... (13 line(s) more)  =

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

    2023-08-23T16:57:37.092859  + set +x<8>[    9.995678] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3746163_1.5.2.4.1>
    2023-08-23T16:57:37.093538  =

    2023-08-23T16:57:37.203225  / # #
    2023-08-23T16:57:37.306723  export SHELL=3D/bin/sh
    2023-08-23T16:57:37.307682  #
    2023-08-23T16:57:37.409562  / # export SHELL=3D/bin/sh. /lava-3746163/e=
nvironment
    2023-08-23T16:57:37.410388  =

    2023-08-23T16:57:37.512340  / # . /lava-3746163/environment/lava-374616=
3/bin/lava-test-runner /lava-3746163/1
    2023-08-23T16:57:37.513667  =

    2023-08-23T16:57:37.518348  / # /lava-3746163/bin/lava-test-runner /lav=
a-3746163/1 =

    ... (12 line(s) more)  =

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

    2023-08-23T16:47:38.240876  [   10.240787] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1245296_1.5.2.4.1>
    2023-08-23T16:47:38.346218  =

    2023-08-23T16:47:38.447401  / # #export SHELL=3D/bin/sh
    2023-08-23T16:47:38.447809  =

    2023-08-23T16:47:38.548746  / # export SHELL=3D/bin/sh. /lava-1245296/e=
nvironment
    2023-08-23T16:47:38.549153  =

    2023-08-23T16:47:38.650109  / # . /lava-1245296/environment/lava-124529=
6/bin/lava-test-runner /lava-1245296/1
    2023-08-23T16:47:38.650777  =

    2023-08-23T16:47:38.654627  / # /lava-1245296/bin/lava-test-runner /lav=
a-1245296/1
    2023-08-23T16:47:38.668223  + export 'TESTRUN_ID=3D1_bootrr' =

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

    2023-08-23T16:53:33.942943  + set +x<8>[   10.728731] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11337817_1.4.2.3.1>

    2023-08-23T16:53:33.943035  =


    2023-08-23T16:53:34.045061  #

    2023-08-23T16:53:34.145968  / # #export SHELL=3D/bin/sh

    2023-08-23T16:53:34.146193  =


    2023-08-23T16:53:34.246719  / # export SHELL=3D/bin/sh. /lava-11337817/=
environment

    2023-08-23T16:53:34.246922  =


    2023-08-23T16:53:34.347452  / # . /lava-11337817/environment/lava-11337=
817/bin/lava-test-runner /lava-11337817/1

    2023-08-23T16:53:34.347853  =


    2023-08-23T16:53:34.352378  / # /lava-11337817/bin/lava-test-runner /la=
va-11337817/1
 =

    ... (12 line(s) more)  =

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

    2023-08-23T16:52:35.039994  + <8>[   11.472735] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11337815_1.4.2.3.1>

    2023-08-23T16:52:35.040081  set +x

    2023-08-23T16:52:35.144364  / # #

    2023-08-23T16:52:35.245242  export SHELL=3D/bin/sh

    2023-08-23T16:52:35.245452  #

    2023-08-23T16:52:35.346052  / # export SHELL=3D/bin/sh. /lava-11337815/=
environment

    2023-08-23T16:52:35.346254  =


    2023-08-23T16:52:35.446759  / # . /lava-11337815/environment/lava-11337=
815/bin/lava-test-runner /lava-11337815/1

    2023-08-23T16:52:35.447046  =


    2023-08-23T16:52:35.451746  / # /lava-11337815/bin/lava-test-runner /la=
va-11337815/1
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

    2023-08-23T16:52:34.307733  + set<8>[   11.134060] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11337834_1.4.2.3.1>

    2023-08-23T16:52:34.307820   +x

    2023-08-23T16:52:34.412001  / # #

    2023-08-23T16:52:34.512584  export SHELL=3D/bin/sh

    2023-08-23T16:52:34.512816  #

    2023-08-23T16:52:34.613324  / # export SHELL=3D/bin/sh. /lava-11337834/=
environment

    2023-08-23T16:52:34.613529  =


    2023-08-23T16:52:34.714115  / # . /lava-11337834/environment/lava-11337=
834/bin/lava-test-runner /lava-11337834/1

    2023-08-23T16:52:34.714547  =


    2023-08-23T16:52:34.719029  / # /lava-11337834/bin/lava-test-runner /la=
va-11337834/1
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

    2023-08-23T16:47:57.188285  / # #

    2023-08-23T16:47:57.288909  export SHELL=3D/bin/sh

    2023-08-23T16:47:57.289144  #

    2023-08-23T16:47:57.389644  / # export SHELL=3D/bin/sh. /lava-11337782/=
environment

    2023-08-23T16:47:57.389868  =


    2023-08-23T16:47:57.490382  / # . /lava-11337782/environment/lava-11337=
782/bin/lava-test-runner /lava-11337782/1

    2023-08-23T16:47:57.490686  =


    2023-08-23T16:47:57.501819  / # /lava-11337782/bin/lava-test-runner /la=
va-11337782/1

    2023-08-23T16:47:57.544955  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-23T16:47:57.561045  + cd /lav<8>[   15.940838] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11337782_1.5.2.4.5>
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

    2023-08-23T16:48:11.785201  / # #

    2023-08-23T16:48:12.865628  export SHELL=3D/bin/sh

    2023-08-23T16:48:12.867543  #

    2023-08-23T16:48:14.358619  / # export SHELL=3D/bin/sh. /lava-11337787/=
environment

    2023-08-23T16:48:14.360414  =


    2023-08-23T16:48:17.085629  / # . /lava-11337787/environment/lava-11337=
787/bin/lava-test-runner /lava-11337787/1

    2023-08-23T16:48:17.087961  =


    2023-08-23T16:48:17.091155  / # /lava-11337787/bin/lava-test-runner /la=
va-11337787/1

    2023-08-23T16:48:17.157148  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-23T16:48:17.157660  + cd /lava-113377<8>[   25.506570] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11337787_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

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

    2023-08-23T16:48:16.373906  / # #

    2023-08-23T16:48:16.474431  export SHELL=3D/bin/sh

    2023-08-23T16:48:16.474556  #

    2023-08-23T16:48:16.575077  / # export SHELL=3D/bin/sh. /lava-11337777/=
environment

    2023-08-23T16:48:16.575234  =


    2023-08-23T16:48:16.675772  / # . /lava-11337777/environment/lava-11337=
777/bin/lava-test-runner /lava-11337777/1

    2023-08-23T16:48:16.676017  =


    2023-08-23T16:48:16.687779  / # /lava-11337777/bin/lava-test-runner /la=
va-11337777/1

    2023-08-23T16:48:16.749653  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-23T16:48:16.749731  + cd /lava-1133777<8>[   16.908072] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11337777_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
