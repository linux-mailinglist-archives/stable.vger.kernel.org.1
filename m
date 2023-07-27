Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11C67654B3
	for <lists+stable@lfdr.de>; Thu, 27 Jul 2023 15:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjG0NQL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Jul 2023 09:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjG0NQK (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Jul 2023 09:16:10 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22572D5B
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 06:15:54 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b8b2886364so5635535ad.0
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 06:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690463754; x=1691068554;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eDP0lSBWHmmUk8iGmclA7GS3v8zifw3GnofnAwTS5rg=;
        b=umoUmOm4S5MitAWas1qTD3CxJlTePbbYvIFsa17sY3rTIh/ikdtzXzlLLcEkKS/k5z
         rhXNB71N068wvRSJfKZaZegdk5dmzPgr8ejLZ9dqHTaNJcxKP6LkblF/UvgmsA1VDj3l
         DCh9JAlseHiZNqIb5+Iz4QSZ3lQuVgxU0GbNfss5IQ6TA3ZMALF/k4Em51rQiqQy5YOw
         RFh1Cp74LMi0TDgBxu/ovEHOzdnZDei8sZJoaupQXol6du/G9nQ4LSKV+uUY7Sk6xRIu
         VKMbVxa+edQdbUd7Y/A9RALsifqyYqa+E9ICbclRU5OQDaFTt15SM/rpA9pLFChsKN8e
         kULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690463754; x=1691068554;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eDP0lSBWHmmUk8iGmclA7GS3v8zifw3GnofnAwTS5rg=;
        b=XO5klNmoqt1lfLgvOk0pIymOK1EQwjqB8gRcWbz1SuX32CkCJ+GcCAbbb/MAE8c2D0
         /lUcuLs5yzM8NAIXcfq/wDXfNj1Ccis5pjuSMh8/BWCI9roa9g2sc0wwAAFsZiUjPiO4
         eUXRCb4xqwtuCX3SfPA1D+JF02rGVnwkW9M/HsQ4fpFDFyRn3rNvXOrQGx62rRMBMcsF
         0NKSkUc4xPS4gkWnJ/LaWUBuSeM7yVi14qiTHPj82aQHyEsSUSAw9khrSrp0WG8gIg0f
         mwosUZS4MHdN73TyxFOGA0NczG/hbOEYnVJH3mJY/xVTlElBjYkLZF2fv00k8IVad8gm
         R1UQ==
X-Gm-Message-State: ABy/qLaymiV9MWnsNuLM6zAw01rIHg8Ws5JZuOPQXFVgAX4cExsuA8is
        vOwWJCsT5H+sSCu97/jKSw94rz9buruj/RIdm88NGg==
X-Google-Smtp-Source: APBJJlEU/uW61+eP6WIHAfANbmydhCVLS/57qeKiH+5FPhXvw2Le+FYvdlFT3vd5xW9GnuPxcIHteA==
X-Received: by 2002:a17:903:1210:b0:1b0:3a74:7fc4 with SMTP id l16-20020a170903121000b001b03a747fc4mr4950808plh.24.1690463753521;
        Thu, 27 Jul 2023 06:15:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g1-20020a170902740100b001b9ecee459csm1621005pll.34.2023.07.27.06.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 06:15:52 -0700 (PDT)
Message-ID: <64c26e08.170a0220.5d87b.2a73@mx.google.com>
Date:   Thu, 27 Jul 2023 06:15:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Kernel: v6.1.42
X-Kernelci-Report-Type: test
Subject: stable/linux-6.1.y baseline: 126 runs, 14 regressions (v6.1.42)
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

stable/linux-6.1.y baseline: 126 runs, 14 regressions (v6.1.42)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

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

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-6.1.y/kernel/=
v6.1.42/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-6.1.y
  Describe: v6.1.42
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      d2a6dc4eaf6d50ba32a9b39b4c6ec713a92072ab =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c2386c2123f915bf8ace58

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.42/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-chro=
mebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.42/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-chro=
mebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64c2386c2123f915bf8ac=
e59
        new failure (last pass: v6.1.39) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c238446462360d578ace53

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.42/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.42/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c238446462360d578ace58
        failing since 118 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-27T09:26:52.684874  <8>[   10.654124] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11150004_1.4.2.3.1>

    2023-07-27T09:26:52.688173  + set +x

    2023-07-27T09:26:52.789755  #

    2023-07-27T09:26:52.890559  / # #export SHELL=3D/bin/sh

    2023-07-27T09:26:52.890708  =


    2023-07-27T09:26:52.991219  / # export SHELL=3D/bin/sh. /lava-11150004/=
environment

    2023-07-27T09:26:52.991368  =


    2023-07-27T09:26:53.091879  / # . /lava-11150004/environment/lava-11150=
004/bin/lava-test-runner /lava-11150004/1

    2023-07-27T09:26:53.092113  =


    2023-07-27T09:26:53.097806  / # /lava-11150004/bin/lava-test-runner /la=
va-11150004/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c23844674b4f64ee8ace20

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.42/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.42/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c23844674b4f64ee8ace25
        failing since 118 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-27T09:26:12.632315  + set<8>[   11.662074] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11149991_1.4.2.3.1>

    2023-07-27T09:26:12.632882   +x

    2023-07-27T09:26:12.741087  / # #

    2023-07-27T09:26:12.843683  export SHELL=3D/bin/sh

    2023-07-27T09:26:12.844482  #

    2023-07-27T09:26:12.946063  / # export SHELL=3D/bin/sh. /lava-11149991/=
environment

    2023-07-27T09:26:12.946922  =


    2023-07-27T09:26:13.048645  / # . /lava-11149991/environment/lava-11149=
991/bin/lava-test-runner /lava-11149991/1

    2023-07-27T09:26:13.049903  =


    2023-07-27T09:26:13.054814  / # /lava-11149991/bin/lava-test-runner /la=
va-11149991/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c238436462360d578ace48

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.42/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.42/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c238436462360d578ace4d
        failing since 118 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-27T09:26:15.557285  <8>[   10.163047] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11150023_1.4.2.3.1>

    2023-07-27T09:26:15.560702  + set +x

    2023-07-27T09:26:15.661871  #

    2023-07-27T09:26:15.763026  / # #export SHELL=3D/bin/sh

    2023-07-27T09:26:15.763258  =


    2023-07-27T09:26:15.863850  / # export SHELL=3D/bin/sh. /lava-11150023/=
environment

    2023-07-27T09:26:15.864042  =


    2023-07-27T09:26:15.964568  / # . /lava-11150023/environment/lava-11150=
023/bin/lava-test-runner /lava-11150023/1

    2023-07-27T09:26:15.964827  =


    2023-07-27T09:26:15.969680  / # /lava-11150023/bin/lava-test-runner /la=
va-11150023/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c238436462360d578ace3d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.42/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.42/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c238436462360d578ace42
        failing since 118 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-27T09:26:39.911217  + set +x

    2023-07-27T09:26:39.917814  <8>[   10.466224] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11150002_1.4.2.3.1>

    2023-07-27T09:26:40.022510  / # #

    2023-07-27T09:26:40.123201  export SHELL=3D/bin/sh

    2023-07-27T09:26:40.123419  #

    2023-07-27T09:26:40.223947  / # export SHELL=3D/bin/sh. /lava-11150002/=
environment

    2023-07-27T09:26:40.224216  =


    2023-07-27T09:26:40.324804  / # . /lava-11150002/environment/lava-11150=
002/bin/lava-test-runner /lava-11150002/1

    2023-07-27T09:26:40.325137  =


    2023-07-27T09:26:40.329474  / # /lava-11150002/bin/lava-test-runner /la=
va-11150002/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c2383b34e7310bfa8aced2

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.42/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.42/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c2383b34e7310bfa8aced7
        failing since 118 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-27T09:26:01.347986  + set<8>[   10.895002] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11150028_1.4.2.3.1>

    2023-07-27T09:26:01.348438   +x

    2023-07-27T09:26:01.456412  #

    2023-07-27T09:26:01.457499  =


    2023-07-27T09:26:01.559234  / # #export SHELL=3D/bin/sh

    2023-07-27T09:26:01.560088  =


    2023-07-27T09:26:01.661581  / # export SHELL=3D/bin/sh. /lava-11150028/=
environment

    2023-07-27T09:26:01.662291  =


    2023-07-27T09:26:01.763972  / # . /lava-11150028/environment/lava-11150=
028/bin/lava-test-runner /lava-11150028/1

    2023-07-27T09:26:01.765333  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c2384f6945ad91658ace21

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.42/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.42/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c238506945ad91658ace26
        failing since 118 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-27T09:26:20.321384  + <8>[   11.414220] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11150029_1.4.2.3.1>

    2023-07-27T09:26:20.322107  set +x

    2023-07-27T09:26:20.430787  / # #

    2023-07-27T09:26:20.533293  export SHELL=3D/bin/sh

    2023-07-27T09:26:20.534068  #

    2023-07-27T09:26:20.635725  / # export SHELL=3D/bin/sh. /lava-11150029/=
environment

    2023-07-27T09:26:20.636577  =


    2023-07-27T09:26:20.738198  / # . /lava-11150029/environment/lava-11150=
029/bin/lava-test-runner /lava-11150029/1

    2023-07-27T09:26:20.739404  =


    2023-07-27T09:26:20.744666  / # /lava-11150029/bin/lava-test-runner /la=
va-11150029/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-pitx-imx8m           | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 2          =


  Details:     https://kernelci.org/test/plan/id/64c23ad498493700c98acf29

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.42/arm=
64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.42/arm=
64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c23ad498493700c98acf2c
        new failure (last pass: v6.1.39)

    2023-07-27T09:37:08.507309  / # #
    2023-07-27T09:37:08.609396  export SHELL=3D/bin/sh
    2023-07-27T09:37:08.610105  #
    2023-07-27T09:37:08.711486  / # export SHELL=3D/bin/sh. /lava-372313/en=
vironment
    2023-07-27T09:37:08.712168  =

    2023-07-27T09:37:08.813754  / # . /lava-372313/environment/lava-372313/=
bin/lava-test-runner /lava-372313/1
    2023-07-27T09:37:08.814940  =

    2023-07-27T09:37:08.834952  / # /lava-372313/bin/lava-test-runner /lava=
-372313/1
    2023-07-27T09:37:08.883935  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-27T09:37:08.884356  + cd /l<8>[   14.475852] <LAVA_SIGNAL_START=
RUN 1_bootrr 372313_1.5.2.4.5> =

    ... (10 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/64c=
23ad498493700c98acf3c
        new failure (last pass: v6.1.39)

    2023-07-27T09:37:11.237715  /lava-372313/1/../bin/lava-test-case
    2023-07-27T09:37:11.238172  <8>[   16.923794] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>
    2023-07-27T09:37:11.238535  /lava-372313/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c2383734e7310bfa8aceaf

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.42/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.42/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c2383734e7310bfa8aceb4
        failing since 118 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-27T09:25:57.458565  <8>[   12.325727] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11149980_1.4.2.3.1>

    2023-07-27T09:25:57.562748  / # #

    2023-07-27T09:25:57.663422  export SHELL=3D/bin/sh

    2023-07-27T09:25:57.663625  #

    2023-07-27T09:25:57.764169  / # export SHELL=3D/bin/sh. /lava-11149980/=
environment

    2023-07-27T09:25:57.764394  =


    2023-07-27T09:25:57.864949  / # . /lava-11149980/environment/lava-11149=
980/bin/lava-test-runner /lava-11149980/1

    2023-07-27T09:25:57.865277  =


    2023-07-27T09:25:57.869926  / # /lava-11149980/bin/lava-test-runner /la=
va-11149980/1

    2023-07-27T09:25:57.876586  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c265b7feaa48b4218ace4c

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.42/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.42/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c265b7feaa48b4218ace51
        failing since 7 days (last pass: v6.1.38, first fail: v6.1.39)

    2023-07-27T12:41:43.323373  / # #

    2023-07-27T12:41:43.425558  export SHELL=3D/bin/sh

    2023-07-27T12:41:43.426276  #

    2023-07-27T12:41:43.527664  / # export SHELL=3D/bin/sh. /lava-11150064/=
environment

    2023-07-27T12:41:43.528376  =


    2023-07-27T12:41:43.629744  / # . /lava-11150064/environment/lava-11150=
064/bin/lava-test-runner /lava-11150064/1

    2023-07-27T12:41:43.630821  =


    2023-07-27T12:41:43.647647  / # /lava-11150064/bin/lava-test-runner /la=
va-11150064/1

    2023-07-27T12:41:43.695558  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-27T12:41:43.696021  + cd /lav<8>[   19.085451] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11150064_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c23b01aa7306242f8ace2c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.42/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.42/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c23b01aa7306242f8ace31
        failing since 7 days (last pass: v6.1.38, first fail: v6.1.39)

    2023-07-27T09:38:01.535193  / # #

    2023-07-27T09:38:02.614839  export SHELL=3D/bin/sh

    2023-07-27T09:38:02.616731  #

    2023-07-27T09:38:04.104135  / # export SHELL=3D/bin/sh. /lava-11150061/=
environment

    2023-07-27T09:38:04.105427  =


    2023-07-27T09:38:06.822369  / # . /lava-11150061/environment/lava-11150=
061/bin/lava-test-runner /lava-11150061/1

    2023-07-27T09:38:06.824617  =


    2023-07-27T09:38:06.828077  / # /lava-11150061/bin/lava-test-runner /la=
va-11150061/1

    2023-07-27T09:38:06.892070  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-27T09:38:06.892223  + cd /lava-111500<8>[   28.476141] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11150061_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64c23c5e7ee668356c8ace6e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.42/arm=
64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevi=
n.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.42/arm=
64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevi=
n.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64c23c5e7ee668356c8ac=
e6f
        new failure (last pass: v6.1.39) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c23af554b7ffa0598aceab

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.42/arm=
64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.42/arm=
64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c23af554b7ffa0598aceb0
        failing since 7 days (last pass: v6.1.38, first fail: v6.1.39)

    2023-07-27T09:39:11.744806  / # #

    2023-07-27T09:39:11.846945  export SHELL=3D/bin/sh

    2023-07-27T09:39:11.847635  #

    2023-07-27T09:39:11.948983  / # export SHELL=3D/bin/sh. /lava-11150075/=
environment

    2023-07-27T09:39:11.949745  =


    2023-07-27T09:39:12.051030  / # . /lava-11150075/environment/lava-11150=
075/bin/lava-test-runner /lava-11150075/1

    2023-07-27T09:39:12.051338  =


    2023-07-27T09:39:12.093032  / # /lava-11150075/bin/lava-test-runner /la=
va-11150075/1

    2023-07-27T09:39:12.093145  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-27T09:39:12.132260  + cd /lava-11150075/1/tests/1_boot<8>[   16=
.847524] <LAVA_SIGNAL_STARTRUN 1_bootrr 11150075_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
