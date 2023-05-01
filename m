Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C106F351C
	for <lists+stable@lfdr.de>; Mon,  1 May 2023 19:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjEARii (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 1 May 2023 13:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjEARih (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 1 May 2023 13:38:37 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780A3AF
        for <stable@vger.kernel.org>; Mon,  1 May 2023 10:38:35 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63b5ce4f069so3271907b3a.1
        for <stable@vger.kernel.org>; Mon, 01 May 2023 10:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682962714; x=1685554714;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yqCPS2NFFuTqm98mCU3vcax6+mwApJ47pDkeL2gO4LY=;
        b=u7qo0ZxKyBMkpn/7q+9EF4RCYRADBihSmT8x0v5ieaH4wW4YbSyxgIHUyT/78tYCtS
         TIlk3d128MCdiVSgTQJGpoqvDPXb7t0EojzklzTCHhFQJNY/o0ejWHZ8HAftV9n75br+
         EntyBdgS5uqAISoVSXx+1efARKEjPya03rwhHmdEhD84KeAtYhUL1ggFLFLiqtqPxuTf
         4eD4tqm3DpYuD6jUCPtT87tkels+GOP6bcUv1U9UpNN0tcVduhgYup91eMIiYc502tUU
         yfeWD7LfoluMg9NgRmWiW2sntx6kVIUq0NPxIr8aF9Wxd0VxWHNWlaSONS03Sc4bD2FU
         R+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682962714; x=1685554714;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yqCPS2NFFuTqm98mCU3vcax6+mwApJ47pDkeL2gO4LY=;
        b=U0vCDbMGwkArgsdpUvuzQB6XgX92BzFUZ1Xvo7mMOzbR/9kDdzO8yOBulr2Icnzpxq
         yhSRnwdD6c5mFwoF6MZ05J/VofiA1xod2mKvyESeRm1SoDJ0lCGZdhqa/mIChRckSP8O
         sPcdJGoxeseRLIGUkwbvY+HjS0j4qNPW3KHe2zgQLyoK7u56XCN/0bvG1pmHc0GLdkkF
         1YncRicqnC8WfSzEkMf3TJ3xC/xXCGi/gs0PiAVTmyfeT8h7RwYYlhM+NmPAPDIpcP7g
         8K5j9I6YB59KhUr75GmQt+44Do/PRAGOs/enX+x1Yjz1K38a2LTKP4Je2IoBp7jjMoPq
         Ev1g==
X-Gm-Message-State: AC+VfDx8hUbwkeOGYZ70eusrz+3Klh9KrjmWrFtZFWRVdKm/9+1UUNz1
        bXzqKUqIEln2GenQucbZq730ecJX7XxQzaQiIPY=
X-Google-Smtp-Source: ACHHUZ5bibP+vHDPpHyirc/gOU+H6uc1O+B+6pNy8e1e1tQo6Tzus6r6nkQtSJMkB8WdIJKpiYv9Kg==
X-Received: by 2002:a05:6a20:d906:b0:f0:ccb8:e837 with SMTP id jd6-20020a056a20d90600b000f0ccb8e837mr15819046pzb.55.1682962714350;
        Mon, 01 May 2023 10:38:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p11-20020a635b0b000000b0050bd4bb900csm5879597pgb.71.2023.05.01.10.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 10:38:33 -0700 (PDT)
Message-ID: <644ff919.630a0220.2003a.b9d9@mx.google.com>
Date:   Mon, 01 May 2023 10:38:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.22-608-g0bd5040e4caae
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 173 runs,
 8 regressions (v6.1.22-608-g0bd5040e4caae)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/queue/6.1 baseline: 173 runs, 8 regressions (v6.1.22-608-g0bd5040=
e4caae)

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


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.22-608-g0bd5040e4caae/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.22-608-g0bd5040e4caae
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      0bd5040e4caae3cd5fd6c00b4aec85ba43f1a418 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644fc4b0eae32966f22e8636

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-60=
8-g0bd5040e4caae/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-60=
8-g0bd5040e4caae/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644fc4b0eae32966f22e863b
        failing since 33 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-01T13:54:49.969805  <8>[    7.924813] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10168865_1.4.2.3.1>

    2023-05-01T13:54:49.972900  + set +x

    2023-05-01T13:54:50.077799  / # #

    2023-05-01T13:54:50.178396  export SHELL=3D/bin/sh

    2023-05-01T13:54:50.178595  #

    2023-05-01T13:54:50.279080  / # export SHELL=3D/bin/sh. /lava-10168865/=
environment

    2023-05-01T13:54:50.279276  =


    2023-05-01T13:54:50.379787  / # . /lava-10168865/environment/lava-10168=
865/bin/lava-test-runner /lava-10168865/1

    2023-05-01T13:54:50.380092  =


    2023-05-01T13:54:50.386616  / # /lava-10168865/bin/lava-test-runner /la=
va-10168865/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644fc541c5aba186652e8609

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-60=
8-g0bd5040e4caae/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-60=
8-g0bd5040e4caae/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644fc541c5aba186652e860e
        failing since 33 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-01T13:57:02.986834  + set<8>[   11.926466] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10168807_1.4.2.3.1>

    2023-05-01T13:57:02.987366   +x

    2023-05-01T13:57:03.094745  / # #

    2023-05-01T13:57:03.197345  export SHELL=3D/bin/sh

    2023-05-01T13:57:03.198125  #

    2023-05-01T13:57:03.299628  / # export SHELL=3D/bin/sh. /lava-10168807/=
environment

    2023-05-01T13:57:03.300459  =


    2023-05-01T13:57:03.401997  / # . /lava-10168807/environment/lava-10168=
807/bin/lava-test-runner /lava-10168807/1

    2023-05-01T13:57:03.403162  =


    2023-05-01T13:57:03.408834  / # /lava-10168807/bin/lava-test-runner /la=
va-10168807/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644fc4bb48a038351e2e85e7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-60=
8-g0bd5040e4caae/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-60=
8-g0bd5040e4caae/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644fc4bb48a038351e2e85ec
        failing since 33 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-01T13:54:50.036137  <8>[    9.910816] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10168848_1.4.2.3.1>

    2023-05-01T13:54:50.038989  + set +x

    2023-05-01T13:54:50.140307  =


    2023-05-01T13:54:50.240914  / # #export SHELL=3D/bin/sh

    2023-05-01T13:54:50.241542  =


    2023-05-01T13:54:50.342845  / # export SHELL=3D/bin/sh. /lava-10168848/=
environment

    2023-05-01T13:54:50.343570  =


    2023-05-01T13:54:50.444936  / # . /lava-10168848/environment/lava-10168=
848/bin/lava-test-runner /lava-10168848/1

    2023-05-01T13:54:50.446135  =


    2023-05-01T13:54:50.451462  / # /lava-10168848/bin/lava-test-runner /la=
va-10168848/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/644fc78622b761eebb2e869c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-60=
8-g0bd5040e4caae/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-60=
8-g0bd5040e4caae/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644fc78622b761eebb2e8=
69d
        failing since 11 days (last pass: v6.1.22-477-g2128d4458cbc, first =
fail: v6.1.22-474-gecc61872327e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644fc4ae9f8208ad712e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-60=
8-g0bd5040e4caae/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-60=
8-g0bd5040e4caae/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644fc4ae9f8208ad712e85eb
        failing since 33 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-01T13:54:39.204394  + set +x

    2023-05-01T13:54:39.210869  <8>[   10.193447] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10168842_1.4.2.3.1>

    2023-05-01T13:54:39.315868  / # #

    2023-05-01T13:54:39.416626  export SHELL=3D/bin/sh

    2023-05-01T13:54:39.416831  #

    2023-05-01T13:54:39.517351  / # export SHELL=3D/bin/sh. /lava-10168842/=
environment

    2023-05-01T13:54:39.517563  =


    2023-05-01T13:54:39.618097  / # . /lava-10168842/environment/lava-10168=
842/bin/lava-test-runner /lava-10168842/1

    2023-05-01T13:54:39.618407  =


    2023-05-01T13:54:39.622866  / # /lava-10168842/bin/lava-test-runner /la=
va-10168842/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644fc493eae32966f22e85f5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-60=
8-g0bd5040e4caae/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-60=
8-g0bd5040e4caae/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644fc493eae32966f22e85fa
        failing since 33 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-01T13:54:10.888304  <8>[   10.115178] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10168811_1.4.2.3.1>

    2023-05-01T13:54:10.891280  + set +x

    2023-05-01T13:54:10.995898  / # #

    2023-05-01T13:54:11.096577  export SHELL=3D/bin/sh

    2023-05-01T13:54:11.096787  #

    2023-05-01T13:54:11.197379  / # export SHELL=3D/bin/sh. /lava-10168811/=
environment

    2023-05-01T13:54:11.197703  =


    2023-05-01T13:54:11.298255  / # . /lava-10168811/environment/lava-10168=
811/bin/lava-test-runner /lava-10168811/1

    2023-05-01T13:54:11.298607  =


    2023-05-01T13:54:11.303572  / # /lava-10168811/bin/lava-test-runner /la=
va-10168811/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644fc4af8f5da489312e8612

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-60=
8-g0bd5040e4caae/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-60=
8-g0bd5040e4caae/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644fc4af8f5da489312e8617
        failing since 33 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-01T13:54:36.816041  + set +x<8>[   10.743260] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10168820_1.4.2.3.1>

    2023-05-01T13:54:36.816122  =


    2023-05-01T13:54:36.920740  / # #

    2023-05-01T13:54:37.021304  export SHELL=3D/bin/sh

    2023-05-01T13:54:37.021473  #

    2023-05-01T13:54:37.121926  / # export SHELL=3D/bin/sh. /lava-10168820/=
environment

    2023-05-01T13:54:37.122082  =


    2023-05-01T13:54:37.222631  / # . /lava-10168820/environment/lava-10168=
820/bin/lava-test-runner /lava-10168820/1

    2023-05-01T13:54:37.222888  =


    2023-05-01T13:54:37.227807  / # /lava-10168820/bin/lava-test-runner /la=
va-10168820/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644fc4aae54044f9332e8629

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-60=
8-g0bd5040e4caae/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-60=
8-g0bd5040e4caae/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644fc4aae54044f9332e862e
        failing since 33 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-01T13:54:37.720154  + set<8>[   11.790371] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10168859_1.4.2.3.1>

    2023-05-01T13:54:37.720636   +x

    2023-05-01T13:54:37.828105  / # #

    2023-05-01T13:54:37.930496  export SHELL=3D/bin/sh

    2023-05-01T13:54:37.931239  #

    2023-05-01T13:54:38.032671  / # export SHELL=3D/bin/sh. /lava-10168859/=
environment

    2023-05-01T13:54:38.033317  =


    2023-05-01T13:54:38.134561  / # . /lava-10168859/environment/lava-10168=
859/bin/lava-test-runner /lava-10168859/1

    2023-05-01T13:54:38.135647  =


    2023-05-01T13:54:38.139802  / # /lava-10168859/bin/lava-test-runner /la=
va-10168859/1
 =

    ... (12 line(s) more)  =

 =20
