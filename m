Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027B17C7A37
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 01:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443024AbjJLXIX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 12 Oct 2023 19:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443006AbjJLXIW (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Oct 2023 19:08:22 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F94A9
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 16:08:20 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c9daca2b85so11353705ad.1
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 16:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697152099; x=1697756899; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dV98UaPhmKWjhcdjWh2Jz7MJ7sG2y6h+QfzS0uuVgvE=;
        b=1rCeYttUDgaUyEVUIzjTNLc1LqL1A/MDP2zRJHeGUYs2nqB1/oXiGvUwW0WHdjRYtw
         nhy0QOoZRSNXpLHxhuapqk/D19OoWkMwMU5opGErx93Pc0nvxTQSC5hpGcvnfUJLI19n
         I6oTQ0PuLEgnhrHTu9o+sFqW/4J414Jf+3W1gz5imRvoJnXKE0a3NtTkFHMteKo0EMxl
         WUtHtL7kh0u7YTFrya6rAJ563KE34L6u2xtSppkouA5iN/ZwZCYev74a7HB0UB3J5p+u
         pZdcH14TBIHm4OfzfMqsTCVNci8GxJnZ6fxTycYVWCwfcriycsjVtkJSLaxpjp7nT2gR
         OU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697152099; x=1697756899;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dV98UaPhmKWjhcdjWh2Jz7MJ7sG2y6h+QfzS0uuVgvE=;
        b=dXFrYxuxA/8vVO49kO3aPbvh3S2qpTsRigR28aCKLsYVGwH9iPzI4M6rXDtrodpisf
         Xu66yUAfSrEQ1waJ4P+dA1ZMaBuoSjMevpUjz3GKnw5PspCU5PwYVtw3nMsr0fcc5gxi
         oTg9mBxspPUqYOYcSPcMeh2gWUBt6vzI9QNF03CG+aIdFc6M0vm8GbBbNVKF+K3QOYs0
         Y0nw5HUs271q7DQVxB4oC/suOJOR9w0tD6tSgtYWfFAKB4G9F0Z0WWiUzR2Sw5BtG/3l
         l1UlGEf86b4ViGKTPZH9F5JHYXBJ8lAbYYeLWnja6XSZ0j8kyz9StNOtKebqc3cWpJpL
         GiIA==
X-Gm-Message-State: AOJu0YxbK1bmtU0rHnR9amAJE+nYyEXr4tyXZGUA9i9sU7aIdfw3x90G
        r5JAwfWTRRBTqKIxaS7phsAW1iSl8vQ5Lr5Ih9g6AQ==
X-Google-Smtp-Source: AGHT+IG61IG0zAUiw/wbu+rhkEVbHZmBwV1n4ruoerIQRKPLpWD1Z2SkW1LtIBs3SbZfT7BFF/XGDw==
X-Received: by 2002:a17:902:f54c:b0:1c1:e818:1e76 with SMTP id h12-20020a170902f54c00b001c1e8181e76mr33654306plf.6.1697152099098;
        Thu, 12 Oct 2023 16:08:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e23-20020a170902ed9700b001b8a00d4f7asm2534895plj.9.2023.10.12.16.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 16:08:18 -0700 (PDT)
Message-ID: <65287c62.170a0220.989c3.8e22@mx.google.com>
Date:   Thu, 12 Oct 2023 16:08:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.57-7-g3fe61dd155ac
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-6.1.y baseline: 162 runs,
 10 regressions (v6.1.57-7-g3fe61dd155ac)
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

stable-rc/linux-6.1.y baseline: 162 runs, 10 regressions (v6.1.57-7-g3fe61d=
d155ac)

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

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx6dl-riotboard             | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

sun50i-h6-pine-h64           | arm64  | lab-clabbe      | gcc-10   | defcon=
fig                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.57-7-g3fe61dd155ac/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.57-7-g3fe61dd155ac
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      3fe61dd155ac48d1642f5cac17bd41a92ef585b7 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652849e02b8ad3878aefcf15

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57-=
7-g3fe61dd155ac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57-=
7-g3fe61dd155ac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652849e02b8ad3878aefcf1e
        failing since 196 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-12T19:32:27.269756  <8>[   10.127963] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11753754_1.4.2.3.1>

    2023-10-12T19:32:27.272820  + set +x

    2023-10-12T19:32:27.377248  /#

    2023-10-12T19:32:27.478058   # #export SHELL=3D/bin/sh

    2023-10-12T19:32:27.478809  =


    2023-10-12T19:32:27.580054  / # export SHELL=3D/bin/sh. /lava-11753754/=
environment

    2023-10-12T19:32:27.580253  =


    2023-10-12T19:32:27.680821  / # . /lava-11753754/environment/lava-11753=
754/bin/lava-test-runner /lava-11753754/1

    2023-10-12T19:32:27.681090  =


    2023-10-12T19:32:27.687546  / # /lava-11753754/bin/lava-test-runner /la=
va-11753754/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652849dd6eb29dfae5efcf7a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57-=
7-g3fe61dd155ac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57-=
7-g3fe61dd155ac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652849dd6eb29dfae5efcf83
        failing since 196 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-12T19:32:27.236667  + set<8>[   11.143044] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11753738_1.4.2.3.1>

    2023-10-12T19:32:27.237236   +x

    2023-10-12T19:32:27.345247  / # #

    2023-10-12T19:32:27.447679  export SHELL=3D/bin/sh

    2023-10-12T19:32:27.448633  #

    2023-10-12T19:32:27.550601  / # export SHELL=3D/bin/sh. /lava-11753738/=
environment

    2023-10-12T19:32:27.551391  =


    2023-10-12T19:32:27.653189  / # . /lava-11753738/environment/lava-11753=
738/bin/lava-test-runner /lava-11753738/1

    2023-10-12T19:32:27.654495  =


    2023-10-12T19:32:27.659553  / # /lava-11753738/bin/lava-test-runner /la=
va-11753738/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652849dc6eb29dfae5efcf6c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57-=
7-g3fe61dd155ac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57-=
7-g3fe61dd155ac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652849dc6eb29dfae5efcf75
        failing since 196 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-12T19:32:20.878604  <8>[   10.969952] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11753757_1.4.2.3.1>

    2023-10-12T19:32:20.881878  + set +x

    2023-10-12T19:32:20.988492  =


    2023-10-12T19:32:21.090431  / # #export SHELL=3D/bin/sh

    2023-10-12T19:32:21.091237  =


    2023-10-12T19:32:21.192837  / # export SHELL=3D/bin/sh. /lava-11753757/=
environment

    2023-10-12T19:32:21.193644  =


    2023-10-12T19:32:21.295204  / # . /lava-11753757/environment/lava-11753=
757/bin/lava-test-runner /lava-11753757/1

    2023-10-12T19:32:21.295533  =


    2023-10-12T19:32:21.300770  / # /lava-11753757/bin/lava-test-runner /la=
va-11753757/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/652849e32b8ad3878aefcf4d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57-=
7-g3fe61dd155ac/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57-=
7-g3fe61dd155ac/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652849e32b8ad3878aefc=
f4e
        failing since 126 days (last pass: v6.1.31-40-g7d0a9678d276, first =
fail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65284a86ed0669204eefcf07

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57-=
7-g3fe61dd155ac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57-=
7-g3fe61dd155ac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65284a86ed0669204eefcf10
        failing since 196 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-12T19:35:41.048841  + set +x

    2023-10-12T19:35:41.055415  <8>[   10.902724] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11753785_1.4.2.3.1>

    2023-10-12T19:35:41.160011  / # #

    2023-10-12T19:35:41.260672  export SHELL=3D/bin/sh

    2023-10-12T19:35:41.260878  #

    2023-10-12T19:35:41.361437  / # export SHELL=3D/bin/sh. /lava-11753785/=
environment

    2023-10-12T19:35:41.361657  =


    2023-10-12T19:35:41.462183  / # . /lava-11753785/environment/lava-11753=
785/bin/lava-test-runner /lava-11753785/1

    2023-10-12T19:35:41.462482  =


    2023-10-12T19:35:41.467075  / # /lava-11753785/bin/lava-test-runner /la=
va-11753785/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652849d26eb29dfae5efcf38

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57-=
7-g3fe61dd155ac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57-=
7-g3fe61dd155ac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652849d26eb29dfae5efcf41
        failing since 196 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-12T19:32:49.042393  + set<8>[   11.321167] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11753756_1.4.2.3.1>

    2023-10-12T19:32:49.042504   +x

    2023-10-12T19:32:49.146882  / # #

    2023-10-12T19:32:49.247497  export SHELL=3D/bin/sh

    2023-10-12T19:32:49.247677  #

    2023-10-12T19:32:49.348223  / # export SHELL=3D/bin/sh. /lava-11753756/=
environment

    2023-10-12T19:32:49.348466  =


    2023-10-12T19:32:49.449052  / # . /lava-11753756/environment/lava-11753=
756/bin/lava-test-runner /lava-11753756/1

    2023-10-12T19:32:49.449342  =


    2023-10-12T19:32:49.454323  / # /lava-11753756/bin/lava-test-runner /la=
va-11753756/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-riotboard             | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65284af576e404ad45efcfab

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57-=
7-g3fe61dd155ac/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
dl-riotboard.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57-=
7-g3fe61dd155ac/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
dl-riotboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65284af576e404ad45efcfb4
        new failure (last pass: v6.1.56-163-g282079f8e4074)

    2023-10-12T19:37:02.109992  + set[   14.922218] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1003261_1.5.2.3.1>
    2023-10-12T19:37:02.110163   +x
    2023-10-12T19:37:02.216148  / # #
    2023-10-12T19:37:02.317856  export SHELL=3D/bin/sh
    2023-10-12T19:37:02.318258  #
    2023-10-12T19:37:02.419431  / # export SHELL=3D/bin/sh. /lava-1003261/e=
nvironment
    2023-10-12T19:37:02.419867  =

    2023-10-12T19:37:02.521074  / # . /lava-1003261/environment/lava-100326=
1/bin/lava-test-runner /lava-1003261/1
    2023-10-12T19:37:02.521623  =

    2023-10-12T19:37:02.524548  / # /lava-1003261/bin/lava-test-runner /lav=
a-1003261/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652849c516d8d125d1efcf39

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57-=
7-g3fe61dd155ac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57-=
7-g3fe61dd155ac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652849c516d8d125d1efcf42
        failing since 196 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-12T19:32:01.381122  + set<8>[   11.966005] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11753734_1.4.2.3.1>

    2023-10-12T19:32:01.381292   +x

    2023-10-12T19:32:01.485520  / # #

    2023-10-12T19:32:01.586182  export SHELL=3D/bin/sh

    2023-10-12T19:32:01.586389  #

    2023-10-12T19:32:01.686950  / # export SHELL=3D/bin/sh. /lava-11753734/=
environment

    2023-10-12T19:32:01.687147  =


    2023-10-12T19:32:01.787716  / # . /lava-11753734/environment/lava-11753=
734/bin/lava-test-runner /lava-11753734/1

    2023-10-12T19:32:01.788012  =


    2023-10-12T19:32:01.792969  / # /lava-11753734/bin/lava-test-runner /la=
va-11753734/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-clabbe      | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65284b06f3e2835b08efcf2c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57-=
7-g3fe61dd155ac/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57-=
7-g3fe61dd155ac/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65284b06f3e2835b08efcf35
        failing since 86 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-10-12T19:37:34.353226  <8>[   18.023619] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 438116_1.5.2.4.1>
    2023-10-12T19:37:34.458366  / # #
    2023-10-12T19:37:34.560091  export SHELL=3D/bin/sh
    2023-10-12T19:37:34.560753  #
    2023-10-12T19:37:34.661760  / # export SHELL=3D/bin/sh. /lava-438116/en=
vironment
    2023-10-12T19:37:34.662482  =

    2023-10-12T19:37:34.763545  / # . /lava-438116/environment/lava-438116/=
bin/lava-test-runner /lava-438116/1
    2023-10-12T19:37:34.764494  =

    2023-10-12T19:37:34.768364  / # /lava-438116/bin/lava-test-runner /lava=
-438116/1
    2023-10-12T19:37:34.847379  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65284b03f3e2835b08efcf21

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57-=
7-g3fe61dd155ac/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57-=
7-g3fe61dd155ac/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65284b03f3e2835b08efcf2a
        failing since 86 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-10-12T19:41:36.582495  / # #

    2023-10-12T19:41:36.682996  export SHELL=3D/bin/sh

    2023-10-12T19:41:36.683149  #

    2023-10-12T19:41:36.783640  / # export SHELL=3D/bin/sh. /lava-11753801/=
environment

    2023-10-12T19:41:36.783753  =


    2023-10-12T19:41:36.884268  / # . /lava-11753801/environment/lava-11753=
801/bin/lava-test-runner /lava-11753801/1

    2023-10-12T19:41:36.884446  =


    2023-10-12T19:41:36.896478  / # /lava-11753801/bin/lava-test-runner /la=
va-11753801/1

    2023-10-12T19:41:36.968267  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-12T19:41:36.968343  + cd /lava-11753801/1/tests/1_boot<8>[   16=
.892152] <LAVA_SIGNAL_STARTRUN 1_bootrr 11753801_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
