Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41D979E838
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 14:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjIMMmh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 08:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjIMMmg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 08:42:36 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D6819AC
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 05:42:32 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c397ed8681so34413305ad.2
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 05:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694608952; x=1695213752; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CKmlq6R+XFrGrPewjwB/25GRUiE9OEeHjzKks/MGLnM=;
        b=rx06knkzlQQ5YFLOfRORgDDD5SFjrHiSIDNu3rE/w2PSq98/WNEIs4eEIJpfdlepdU
         6aJg3lRRytcSwgA1N0obJTnSEvtIFu1rP+fFubSzZbwXNX+cSbYLPG2w4NOxQfiUir79
         uah0G83HH8zl6noEJ24t0pCn9jHEzwV9WomS4ntH0b5bo1KDujV57JiI8MhPwoU3p5fA
         XUNKZOfuWxCudC6P/vbBY20Sl/LnhC0psFjRoYXHInxf+OxKhw0CRhO4Aq1o5r/6eRFA
         vA2sb1md+D4rejP1odUUdaqwlYD6/0ruJMTbX4je++noxbESoRK4GrRaeBd98vqv8MyX
         DSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694608952; x=1695213752;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CKmlq6R+XFrGrPewjwB/25GRUiE9OEeHjzKks/MGLnM=;
        b=ceepCfWpmQiR2xRcjbqfIIQWha5Pzl+d7jzGLiJjoC8JbJLmzp2bh4ukGn/G9OVo0h
         7IuEwY9IBIuCaNiiPtaczacxHpvyHFm0KJlBMfVwwMOES1ktpLJsxZb3pntUh/hO6LiO
         l4Ei+zx1HtOo/Q+oUmzr4ze2uXlZzQiGlhCKqC0+SkiBOMF2r91bs+I28+KGHRrobGor
         kO/ZV+RpKq0WMkYplalPKmu+prjz1P5TMP15NzS3uhJL4U6TbCYHMFWk+vufZo1Y+/AW
         jWJRKib+atMcqKu753g+Yjw+MvfKN9Ib28QIyJIv1TSqC7AeZ/zAvhavktHT5GXGRNhL
         DMQw==
X-Gm-Message-State: AOJu0YzZRwrmcj/SwxEOjyNZQRnPfvWCyziG2nHGnPjoTgPHGyT5YlX/
        8F5ejj7JY8Tv/KfL01QD59kMgQpqnV0MssThTkQ=
X-Google-Smtp-Source: AGHT+IF+mo0I0F8vrp820FoBq+IODaU8ZW7/mkqjFVTr8/IeYPqsFSocWaShuMyZRZdE2oTQ34A9Pg==
X-Received: by 2002:a17:902:6906:b0:1c3:61d9:2b32 with SMTP id j6-20020a170902690600b001c361d92b32mr2281751plk.45.1694608951804;
        Wed, 13 Sep 2023 05:42:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jj18-20020a170903049200b001b9d95945afsm10431256plb.155.2023.09.13.05.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 05:42:31 -0700 (PDT)
Message-ID: <6501ae37.170a0220.34ee9.d6d0@mx.google.com>
Date:   Wed, 13 Sep 2023 05:42:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable
X-Kernelci-Kernel: v6.1.53
X-Kernelci-Report-Type: test
Subject: stable/linux-6.1.y baseline: 118 runs, 10 regressions (v6.1.53)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-6.1.y baseline: 118 runs, 10 regressions (v6.1.53)

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

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-6.1.y/kernel/=
v6.1.53/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-6.1.y
  Describe: v6.1.53
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      09045dae0d902f9f78901a26c7ff1714976a38f9 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65017a310160bde6af8a0a45

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.53/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.53/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65017a310160bde6af8a0a4e
        failing since 166 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-13T09:01:42.975047  + set +x

    2023-09-13T09:01:42.981521  <8>[    9.761067] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11514396_1.4.2.3.1>

    2023-09-13T09:01:43.088521  #

    2023-09-13T09:01:43.089631  =


    2023-09-13T09:01:43.191330  / # #export SHELL=3D/bin/sh

    2023-09-13T09:01:43.192089  =


    2023-09-13T09:01:43.293411  / # export SHELL=3D/bin/sh. /lava-11514396/=
environment

    2023-09-13T09:01:43.294122  =


    2023-09-13T09:01:43.395511  / # . /lava-11514396/environment/lava-11514=
396/bin/lava-test-runner /lava-11514396/1

    2023-09-13T09:01:43.396597  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6501791da3f65b9bba8a0a90

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.53/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.53/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501791da3f65b9bba8a0a99
        failing since 166 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-13T08:56:03.681438  + set<8>[   11.871545] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11514373_1.4.2.3.1>

    2023-09-13T08:56:03.681974   +x

    2023-09-13T08:56:03.789534  / # #

    2023-09-13T08:56:03.891687  export SHELL=3D/bin/sh

    2023-09-13T08:56:03.892379  #

    2023-09-13T08:56:03.993915  / # export SHELL=3D/bin/sh. /lava-11514373/=
environment

    2023-09-13T08:56:03.994606  =


    2023-09-13T08:56:04.095962  / # . /lava-11514373/environment/lava-11514=
373/bin/lava-test-runner /lava-11514373/1

    2023-09-13T08:56:04.097129  =


    2023-09-13T08:56:04.101478  / # /lava-11514373/bin/lava-test-runner /la=
va-11514373/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650179291eb6b2e5848a0a7e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.53/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.53/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650179291eb6b2e5848a0a87
        failing since 166 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-13T08:55:53.604768  <8>[   11.172669] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11514401_1.4.2.3.1>

    2023-09-13T08:55:53.607761  + set +x

    2023-09-13T08:55:53.712689  #

    2023-09-13T08:55:53.713690  =


    2023-09-13T08:55:53.815495  / # #export SHELL=3D/bin/sh

    2023-09-13T08:55:53.816029  =


    2023-09-13T08:55:53.917210  / # export SHELL=3D/bin/sh. /lava-11514401/=
environment

    2023-09-13T08:55:53.917748  =


    2023-09-13T08:55:54.018926  / # . /lava-11514401/environment/lava-11514=
401/bin/lava-test-runner /lava-11514401/1

    2023-09-13T08:55:54.019786  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65017e54e48df470d58a0a82

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.53/arm=
/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.53/arm=
/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65017e54e48df470d58a0=
a83
        failing since 20 days (last pass: v6.1.46, first fail: v6.1.47) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6501798fc2d52d49938a0a76

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.53/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.53/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501798fc2d52d49938a0a7f
        failing since 166 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-13T08:57:37.212713  + set +x

    2023-09-13T08:57:37.219050  <8>[   10.521914] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11514383_1.4.2.3.1>

    2023-09-13T08:57:37.323698  / # #

    2023-09-13T08:57:37.424220  export SHELL=3D/bin/sh

    2023-09-13T08:57:37.424372  #

    2023-09-13T08:57:37.524880  / # export SHELL=3D/bin/sh. /lava-11514383/=
environment

    2023-09-13T08:57:37.525038  =


    2023-09-13T08:57:37.625497  / # . /lava-11514383/environment/lava-11514=
383/bin/lava-test-runner /lava-11514383/1

    2023-09-13T08:57:37.625767  =


    2023-09-13T08:57:37.630258  / # /lava-11514383/bin/lava-test-runner /la=
va-11514383/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65017911a3f65b9bba8a0a69

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.53/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.53/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65017911a3f65b9bba8a0a72
        failing since 166 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-13T08:55:39.321592  <8>[   10.149145] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11514392_1.4.2.3.1>

    2023-09-13T08:55:39.324498  + set +x

    2023-09-13T08:55:39.429020  /#

    2023-09-13T08:55:39.531646   # #export SHELL=3D/bin/sh

    2023-09-13T08:55:39.532380  =


    2023-09-13T08:55:39.633793  / # export SHELL=3D/bin/sh. /lava-11514392/=
environment

    2023-09-13T08:55:39.634499  =


    2023-09-13T08:55:39.735951  / # . /lava-11514392/environment/lava-11514=
392/bin/lava-test-runner /lava-11514392/1

    2023-09-13T08:55:39.737246  =


    2023-09-13T08:55:39.741780  / # /lava-11514392/bin/lava-test-runner /la=
va-11514392/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6501791d22c5d2859d8a0a5e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.53/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.53/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501791d22c5d2859d8a0a67
        failing since 166 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-13T08:55:38.913235  + <8>[   11.694049] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11514367_1.4.2.3.1>

    2023-09-13T08:55:38.913653  set +x

    2023-09-13T08:55:39.020404  / # #

    2023-09-13T08:55:39.121191  export SHELL=3D/bin/sh

    2023-09-13T08:55:39.121948  #

    2023-09-13T08:55:39.223264  / # export SHELL=3D/bin/sh. /lava-11514367/=
environment

    2023-09-13T08:55:39.223961  =


    2023-09-13T08:55:39.325303  / # . /lava-11514367/environment/lava-11514=
367/bin/lava-test-runner /lava-11514367/1

    2023-09-13T08:55:39.326352  =


    2023-09-13T08:55:39.330954  / # /lava-11514367/bin/lava-test-runner /la=
va-11514367/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65017917a3f65b9bba8a0a75

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.53/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.53/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65017917a3f65b9bba8a0a7e
        failing since 166 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-13T08:55:40.061531  + set<8>[   12.049833] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11514372_1.4.2.3.1>

    2023-09-13T08:55:40.061636   +x

    2023-09-13T08:55:40.165592  / # #

    2023-09-13T08:55:40.266139  export SHELL=3D/bin/sh

    2023-09-13T08:55:40.266320  #

    2023-09-13T08:55:40.366834  / # export SHELL=3D/bin/sh. /lava-11514372/=
environment

    2023-09-13T08:55:40.367024  =


    2023-09-13T08:55:40.467537  / # . /lava-11514372/environment/lava-11514=
372/bin/lava-test-runner /lava-11514372/1

    2023-09-13T08:55:40.467829  =


    2023-09-13T08:55:40.472787  / # /lava-11514372/bin/lava-test-runner /la=
va-11514372/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65017adc8610be7efd8a0a6f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.53/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.53/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65017adc8610be7efd8a0a78
        failing since 55 days (last pass: v6.1.38, first fail: v6.1.39)

    2023-09-13T09:05:03.319842  / # #

    2023-09-13T09:05:04.394457  export SHELL=3D/bin/sh

    2023-09-13T09:05:04.396256  #

    2023-09-13T09:05:05.881517  / # export SHELL=3D/bin/sh. /lava-11514439/=
environment

    2023-09-13T09:05:05.882830  =


    2023-09-13T09:05:08.604448  / # . /lava-11514439/environment/lava-11514=
439/bin/lava-test-runner /lava-11514439/1

    2023-09-13T09:05:08.606769  =


    2023-09-13T09:05:08.615970  / # /lava-11514439/bin/lava-test-runner /la=
va-11514439/1

    2023-09-13T09:05:08.675137  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-13T09:05:08.675636  + cd /lava-115144<8>[   28.509611] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11514439_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65017acb7b533bd1ea8a0b50

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.53/arm=
64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.53/arm=
64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65017acb7b533bd1ea8a0b59
        failing since 55 days (last pass: v6.1.38, first fail: v6.1.39)

    2023-09-13T09:07:22.960595  / # #

    2023-09-13T09:07:23.062631  export SHELL=3D/bin/sh

    2023-09-13T09:07:23.063374  #

    2023-09-13T09:07:23.164822  / # export SHELL=3D/bin/sh. /lava-11514435/=
environment

    2023-09-13T09:07:23.165533  =


    2023-09-13T09:07:23.266986  / # . /lava-11514435/environment/lava-11514=
435/bin/lava-test-runner /lava-11514435/1

    2023-09-13T09:07:23.268136  =


    2023-09-13T09:07:23.284952  / # /lava-11514435/bin/lava-test-runner /la=
va-11514435/1

    2023-09-13T09:07:23.351427  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-13T09:07:23.351612  + cd /lava-11514435/1/tests/1_boot<8>[   16=
.939873] <LAVA_SIGNAL_STARTRUN 1_bootrr 11514435_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
