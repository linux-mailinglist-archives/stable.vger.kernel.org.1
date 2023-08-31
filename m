Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2865F78F0E4
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 18:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237775AbjHaQHO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 12:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjHaQHO (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 12:07:14 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4CDE4F
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 09:06:41 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c06f6f98c0so7861975ad.3
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 09:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693497996; x=1694102796; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lj0vzXlLbPmcKAnceY/BchvtBVL3Iy3otkmM5GgkjrY=;
        b=aJiO4pjDB/XZh4izdvycs6fFCpFK/qEskx5HEQ6E2afH18Ka407vHdK3f45lKrjRBh
         ialiqTyi+xrr58Wc/DbO2y12NRqwt9SLL6J2c7eJ6nO2KcK+euq+Ij8jOMKp5n91rcg/
         idvFxXLQwojVfpiq94gNOfpvgqHHOw3wzRcLgTI6ehWl7j2mQMx+0Wg1YCwzsqg4OLp4
         PxS/t1EH2rNnmlHeb6VI+xTqISl3H9OZ1KIBkl0ucOMHLF4tRmRh6Aj+bc2G3Vkv1lvh
         YSqQLtqM1w7/wUQB5V55l4hM4xDRQHnEv98UfRluWDa32iHn9295JMi+8qTGHMdwgczp
         kb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693497996; x=1694102796;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lj0vzXlLbPmcKAnceY/BchvtBVL3Iy3otkmM5GgkjrY=;
        b=ffh/ivukvG+SJ9ehP5EM34G5XFISEvCq8DxtDHLNm64LBgmPnsgEaBKMpF2i920rbP
         7WujoERntvFQcVzlC4cgbxS9cGNIZdFA/EGaINNsk04m/z9XCaEF5TbUasnp+JKTrxaP
         2MARfAyzKUIH7p2Ej1ZfjqjuNZg6kC57YyoU6dD3yAOPrRpjgxem3c6ZbC3YO3EWq3no
         KX3yAE4fLCT3c6H6P+0mqkBPDf1KYx9a0AakyqT+i5wIIkU5/37ukqWvxh+xC1Mn2Pkc
         Oh5E6DQxFFdnqdyzF+yKXK7RmG4hL92zWx3xdVgF6G7To2omtSURTZaUFkXMD3T8HXUS
         ZGSg==
X-Gm-Message-State: AOJu0YxLzridYg72CeMOlzKUvep6/naH9jrEdpMng05xthXMkGAzpBz0
        n4V8q9sqGysMkfstluj35gI5pPoKfE3+KZ791XI=
X-Google-Smtp-Source: AGHT+IF5Jmfa3GYmIL+c4KAVKd/GU0bvSnO01wwvkLJRd7Txc0Aqoo3BODeEyhwAMh2RyVRE3OooRg==
X-Received: by 2002:a17:902:e808:b0:1c0:ec66:f2b2 with SMTP id u8-20020a170902e80800b001c0ec66f2b2mr79900plg.27.1693497995502;
        Thu, 31 Aug 2023 09:06:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ja5-20020a170902efc500b001a183ade911sm1445649plb.56.2023.08.31.09.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 09:06:34 -0700 (PDT)
Message-ID: <64f0ba8a.170a0220.3fb5d.2e93@mx.google.com>
Date:   Thu, 31 Aug 2023 09:06:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.50-11-g1767553758a66
Subject: stable-rc/linux-6.1.y baseline: 124 runs,
 11 regressions (v6.1.50-11-g1767553758a66)
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

stable-rc/linux-6.1.y baseline: 124 runs, 11 regressions (v6.1.50-11-g17675=
53758a66)

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

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

mt8192-asurada-spherion-r0   | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.50-11-g1767553758a66/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.50-11-g1767553758a66
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      1767553758a66ae5cc765f89bc22c22273b382a4 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f089a7d2f679e64f286d8c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50-=
11-g1767553758a66/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50-=
11-g1767553758a66/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f089a7d2f679e64f286d95
        failing since 153 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-31T12:38:50.838155  + set +x

    2023-08-31T12:38:50.845110  <8>[    9.980209] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11390008_1.4.2.3.1>

    2023-08-31T12:38:50.946629  #

    2023-08-31T12:38:51.047364  / # #export SHELL=3D/bin/sh

    2023-08-31T12:38:51.047523  =


    2023-08-31T12:38:51.148056  / # export SHELL=3D/bin/sh. /lava-11390008/=
environment

    2023-08-31T12:38:51.148225  =


    2023-08-31T12:38:51.248751  / # . /lava-11390008/environment/lava-11390=
008/bin/lava-test-runner /lava-11390008/1

    2023-08-31T12:38:51.249006  =


    2023-08-31T12:38:51.255227  / # /lava-11390008/bin/lava-test-runner /la=
va-11390008/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f089a7712b335792286d86

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50-=
11-g1767553758a66/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50-=
11-g1767553758a66/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f089a7712b335792286d8f
        failing since 153 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-31T12:37:49.051051  + set<8>[   11.457250] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11390005_1.4.2.3.1>

    2023-08-31T12:37:49.051613   +x

    2023-08-31T12:37:49.158669  / # #

    2023-08-31T12:37:49.261212  export SHELL=3D/bin/sh

    2023-08-31T12:37:49.261938  #

    2023-08-31T12:37:49.363548  / # export SHELL=3D/bin/sh. /lava-11390005/=
environment

    2023-08-31T12:37:49.364274  =


    2023-08-31T12:37:49.465745  / # . /lava-11390005/environment/lava-11390=
005/bin/lava-test-runner /lava-11390005/1

    2023-08-31T12:37:49.466927  =


    2023-08-31T12:37:49.471915  / # /lava-11390005/bin/lava-test-runner /la=
va-11390005/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f089b0d2f679e64f286da6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50-=
11-g1767553758a66/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50-=
11-g1767553758a66/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f089b0d2f679e64f286daf
        failing since 153 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-31T12:37:48.922723  <8>[    7.735398] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11390034_1.4.2.3.1>

    2023-08-31T12:37:48.926152  + set +x

    2023-08-31T12:37:49.027313  #

    2023-08-31T12:37:49.027625  =


    2023-08-31T12:37:49.128202  / # #export SHELL=3D/bin/sh

    2023-08-31T12:37:49.128390  =


    2023-08-31T12:37:49.228880  / # export SHELL=3D/bin/sh. /lava-11390034/=
environment

    2023-08-31T12:37:49.229081  =


    2023-08-31T12:37:49.329584  / # . /lava-11390034/environment/lava-11390=
034/bin/lava-test-runner /lava-11390034/1

    2023-08-31T12:37:49.329880  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f08762e28902adab286dc9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50-=
11-g1767553758a66/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50-=
11-g1767553758a66/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f08762e28902adab286=
dca
        failing since 84 days (last pass: v6.1.31-40-g7d0a9678d276, first f=
ail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f089d1f7a3c9878a286d6c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50-=
11-g1767553758a66/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50-=
11-g1767553758a66/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f089d1f7a3c9878a286d75
        failing since 153 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-31T12:39:32.299009  + set +x

    2023-08-31T12:39:32.305298  <8>[   10.367528] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11390030_1.4.2.3.1>

    2023-08-31T12:39:32.412740  / # #

    2023-08-31T12:39:32.514944  export SHELL=3D/bin/sh

    2023-08-31T12:39:32.515696  #

    2023-08-31T12:39:32.617118  / # export SHELL=3D/bin/sh. /lava-11390030/=
environment

    2023-08-31T12:39:32.617952  =


    2023-08-31T12:39:32.719657  / # . /lava-11390030/environment/lava-11390=
030/bin/lava-test-runner /lava-11390030/1

    2023-08-31T12:39:32.721013  =


    2023-08-31T12:39:32.726252  / # /lava-11390030/bin/lava-test-runner /la=
va-11390030/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f089b00198da2b45286d6c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50-=
11-g1767553758a66/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50-=
11-g1767553758a66/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f089b00198da2b45286d75
        failing since 153 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-31T12:37:49.304914  + set<8>[    8.613538] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11390036_1.4.2.3.1>

    2023-08-31T12:37:49.305026   +x

    2023-08-31T12:37:49.409113  / # #

    2023-08-31T12:37:49.509851  export SHELL=3D/bin/sh

    2023-08-31T12:37:49.510073  #

    2023-08-31T12:37:49.610620  / # export SHELL=3D/bin/sh. /lava-11390036/=
environment

    2023-08-31T12:37:49.610835  =


    2023-08-31T12:37:49.711402  / # . /lava-11390036/environment/lava-11390=
036/bin/lava-test-runner /lava-11390036/1

    2023-08-31T12:37:49.711771  =


    2023-08-31T12:37:49.716288  / # /lava-11390036/bin/lava-test-runner /la=
va-11390036/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f09536e6d66bc4c6286e30

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50-=
11-g1767553758a66/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50-=
11-g1767553758a66/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f09537e6d66bc4c6286e39
        failing since 153 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-31T13:26:54.359772  + set<8>[   11.133860] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11390038_1.4.2.3.1>

    2023-08-31T13:26:54.359856   +x

    2023-08-31T13:26:54.463553  / # #

    2023-08-31T13:26:54.564131  export SHELL=3D/bin/sh

    2023-08-31T13:26:54.564286  #

    2023-08-31T13:26:54.664811  / # export SHELL=3D/bin/sh. /lava-11390038/=
environment

    2023-08-31T13:26:54.664961  =


    2023-08-31T13:26:54.765509  / # . /lava-11390038/environment/lava-11390=
038/bin/lava-test-runner /lava-11390038/1

    2023-08-31T13:26:54.765800  =


    2023-08-31T13:26:54.770750  / # /lava-11390038/bin/lava-test-runner /la=
va-11390038/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8192-asurada-spherion-r0   | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64f089596584d245e5286d82

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50-=
11-g1767553758a66/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-mt8192-asurada-spherion-r0.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50-=
11-g1767553758a66/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-mt8192-asurada-spherion-r0.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f089596584d245e5286=
d83
        new failure (last pass: v6.1.50) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f09260a71e1c592a286db8

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50-=
11-g1767553758a66/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50-=
11-g1767553758a66/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f09260a71e1c592a286dc1
        failing since 44 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-31T13:16:30.653556  / # #

    2023-08-31T13:16:30.754104  export SHELL=3D/bin/sh

    2023-08-31T13:16:30.754237  #

    2023-08-31T13:16:30.854731  / # export SHELL=3D/bin/sh. /lava-11389939/=
environment

    2023-08-31T13:16:30.854862  =


    2023-08-31T13:16:30.955359  / # . /lava-11389939/environment/lava-11389=
939/bin/lava-test-runner /lava-11389939/1

    2023-08-31T13:16:30.955582  =


    2023-08-31T13:16:30.967394  / # /lava-11389939/bin/lava-test-runner /la=
va-11389939/1

    2023-08-31T13:16:31.020196  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-31T13:16:31.020351  + cd /lav<8>[   19.078627] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11389939_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f087b16bcfecfbbf286d79

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50-=
11-g1767553758a66/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ul=
cb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50-=
11-g1767553758a66/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ul=
cb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f087b16bcfecfbbf286d82
        failing since 44 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-31T12:30:34.438356  / # #

    2023-08-31T12:30:35.518805  export SHELL=3D/bin/sh

    2023-08-31T12:30:35.520594  #

    2023-08-31T12:30:37.011954  / # export SHELL=3D/bin/sh. /lava-11389933/=
environment

    2023-08-31T12:30:37.013847  =


    2023-08-31T12:30:39.735564  / # . /lava-11389933/environment/lava-11389=
933/bin/lava-test-runner /lava-11389933/1

    2023-08-31T12:30:39.737962  =


    2023-08-31T12:30:39.745015  / # /lava-11389933/bin/lava-test-runner /la=
va-11389933/1

    2023-08-31T12:30:39.806161  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-31T12:30:39.806667  + cd /lava-<8>[   28.493111] <LAVA_SIGNAL_S=
TARTRUN 1_bootrr 11389933_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f08781da18477785286d73

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50-=
11-g1767553758a66/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50-=
11-g1767553758a66/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f08781da18477785286d7c
        failing since 44 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-31T12:30:17.644148  / # #

    2023-08-31T12:30:17.746066  export SHELL=3D/bin/sh

    2023-08-31T12:30:17.746722  #

    2023-08-31T12:30:17.847968  / # export SHELL=3D/bin/sh. /lava-11389944/=
environment

    2023-08-31T12:30:17.848631  =


    2023-08-31T12:30:17.949887  / # . /lava-11389944/environment/lava-11389=
944/bin/lava-test-runner /lava-11389944/1

    2023-08-31T12:30:17.950886  =


    2023-08-31T12:30:17.993159  / # /lava-11389944/bin/lava-test-runner /la=
va-11389944/1

    2023-08-31T12:30:17.993506  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-31T12:30:18.031874  + cd /lava-11389944/1/tests/1_boot<8>[   16=
.890542] <LAVA_SIGNAL_STARTRUN 1_bootrr 11389944_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
