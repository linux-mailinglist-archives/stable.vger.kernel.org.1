Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCC974FCBF
	for <lists+stable@lfdr.de>; Wed, 12 Jul 2023 03:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjGLBke (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 21:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjGLBkd (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 21:40:33 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD8F195
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 18:40:32 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b8c81e36c0so31955015ad.0
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 18:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689126031; x=1691718031;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lXwsUbrO9sBu2erwGluV/RO2tfRWkjLBaDVCBz14+HA=;
        b=ZQpFWw7H1KrHxs07ioKGulhk88xT89TdJceocZOhTIcLXPwPXCskK2rqFr8JhTE91q
         G5qxfYMRPS592jTTqAkMYFn7CS3dRJFvcUprvU7t912UocUTl3SIsJcp1W5N5+bfDjuK
         GN04j3SX4nFRgwCCrKQm1JQWCzLT9VBxEJFqFEgX3xfr0wjSfwcvmPmrObda9eMZrD09
         gCGbWXh84OzZUhdygectoBGNMw8Sw6CYrpuZQmm/wlj07dAG5FlGzYAq884GC8vT1OWS
         TQpQ9DS8bDKEa4dOnLEnpqnzavdrv+hx61nkxZTYEW7Hhm+MSZdV3Hkrnz9W/ozTlsV9
         8F0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689126031; x=1691718031;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lXwsUbrO9sBu2erwGluV/RO2tfRWkjLBaDVCBz14+HA=;
        b=T01WQst7tzvCR8lvk6GybTABzgC6qER7Kc3QdNaYAWIfreJ1lksvEqnfvj4UOkpqPD
         Ek2ty6dW6yFj3Rk8zWlaFDFwX8uVea7zNLoRT9NpKQQJO20Ft+Xq9eSetovTsVAyTNza
         2SDE4FA0jX9imCXisMLq8HGvsBUm6PkmqYQTdkb09/ZCTHGpTO2vypvWrHOLZdGFR5N/
         KL9TwT8/Dc/HUZc/wxt5YU4ZTiqFD3bC5fmw6rsXDphVajU1MtWe2ohsFjjrAzT1aP4O
         ExfaOTeuj8mvZY8xQCHl1Z7541EqkB74aKKXyFBX1cHn3UiDygDxMyY0YY2rGFzfZHXD
         +IbA==
X-Gm-Message-State: ABy/qLbUDXLZx+3hbzGXcm6wFKxebkbJbDHLQCDtENg0/hf1gyYaiYBg
        ZVRNE0lmmJ29zz9DofWVcXQzoRShbFsBfz8VesEZ0g==
X-Google-Smtp-Source: APBJJlE4FajusF3DP/S5lQw0SCIS73sIYXE2NomhiuYMBAX1kFB40r0hnEV3LgQqa8fKCpyociKmbQ==
X-Received: by 2002:a17:902:d50c:b0:1b8:a3e8:51d0 with SMTP id b12-20020a170902d50c00b001b8a3e851d0mr15943157plg.45.1689126030872;
        Tue, 11 Jul 2023 18:40:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id je3-20020a170903264300b001b83e624eecsm2602301plb.81.2023.07.11.18.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 18:40:30 -0700 (PDT)
Message-ID: <64ae048e.170a0220.ea29.6093@mx.google.com>
Date:   Tue, 11 Jul 2023 18:40:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.38-393-gb6386e7314b4
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y
Subject: stable-rc/linux-6.1.y baseline: 164 runs,
 9 regressions (v6.1.38-393-gb6386e7314b4)
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

stable-rc/linux-6.1.y baseline: 164 runs, 9 regressions (v6.1.38-393-gb6386=
e7314b4)

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


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.38-393-gb6386e7314b4/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.38-393-gb6386e7314b4
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b6386e7314b41a0e90dc9c4b9f6db439c2a9a73d =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64add006bec195a264bb2ac0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
393-gb6386e7314b4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-acer-chromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
393-gb6386e7314b4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-acer-chromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64add006bec195a264bb2=
ac1
        failing since 8 days (last pass: v6.1.37, first fail: v6.1.37-12-g8=
6236a041c0f) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64adcff3bec195a264bb2a8b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
393-gb6386e7314b4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
393-gb6386e7314b4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64adcff3bec195a264bb2a90
        failing since 103 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-11T21:55:44.901497  + set +x

    2023-07-11T21:55:44.908309  <8>[   10.303440] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11063905_1.4.2.3.1>

    2023-07-11T21:55:45.012367  / # #

    2023-07-11T21:55:45.112918  export SHELL=3D/bin/sh

    2023-07-11T21:55:45.113109  #

    2023-07-11T21:55:45.213647  / # export SHELL=3D/bin/sh. /lava-11063905/=
environment

    2023-07-11T21:55:45.213826  =


    2023-07-11T21:55:45.314320  / # . /lava-11063905/environment/lava-11063=
905/bin/lava-test-runner /lava-11063905/1

    2023-07-11T21:55:45.314598  =


    2023-07-11T21:55:45.320131  / # /lava-11063905/bin/lava-test-runner /la=
va-11063905/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64adcff1312f545d70bb2ae2

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
393-gb6386e7314b4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
393-gb6386e7314b4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64adcff1312f545d70bb2ae7
        failing since 103 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-11T21:55:40.355578  + set<8>[   11.511709] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11063874_1.4.2.3.1>

    2023-07-11T21:55:40.356005   +x

    2023-07-11T21:55:40.463959  / # #

    2023-07-11T21:55:40.565909  export SHELL=3D/bin/sh

    2023-07-11T21:55:40.566576  #

    2023-07-11T21:55:40.667971  / # export SHELL=3D/bin/sh. /lava-11063874/=
environment

    2023-07-11T21:55:40.668714  =


    2023-07-11T21:55:40.770220  / # . /lava-11063874/environment/lava-11063=
874/bin/lava-test-runner /lava-11063874/1

    2023-07-11T21:55:40.771443  =


    2023-07-11T21:55:40.776275  / # /lava-11063874/bin/lava-test-runner /la=
va-11063874/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64adcfdfd4df6821adbb2adb

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
393-gb6386e7314b4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
393-gb6386e7314b4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64adcfdfd4df6821adbb2ae0
        failing since 103 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-11T21:55:44.414854  <8>[   10.127970] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11063906_1.4.2.3.1>

    2023-07-11T21:55:44.418318  + set +x

    2023-07-11T21:55:44.519591  /#

    2023-07-11T21:55:44.620442   # #export SHELL=3D/bin/sh

    2023-07-11T21:55:44.620601  =


    2023-07-11T21:55:44.721052  / # export SHELL=3D/bin/sh. /lava-11063906/=
environment

    2023-07-11T21:55:44.721225  =


    2023-07-11T21:55:44.821807  / # . /lava-11063906/environment/lava-11063=
906/bin/lava-test-runner /lava-11063906/1

    2023-07-11T21:55:44.822029  =


    2023-07-11T21:55:44.826715  / # /lava-11063906/bin/lava-test-runner /la=
va-11063906/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64add01925b4b78c0ebb2a7f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
393-gb6386e7314b4/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
393-gb6386e7314b4/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64add01925b4b78c0ebb2=
a80
        failing since 33 days (last pass: v6.1.31-40-g7d0a9678d276, first f=
ail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64adcff21ddeae8500bb2ad3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
393-gb6386e7314b4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
393-gb6386e7314b4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64adcff21ddeae8500bb2ad8
        failing since 103 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-11T21:55:53.877941  + set +x

    2023-07-11T21:55:53.884100  <8>[   10.946908] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11063871_1.4.2.3.1>

    2023-07-11T21:55:53.991871  / # #

    2023-07-11T21:55:54.094208  export SHELL=3D/bin/sh

    2023-07-11T21:55:54.094912  #

    2023-07-11T21:55:54.196357  / # export SHELL=3D/bin/sh. /lava-11063871/=
environment

    2023-07-11T21:55:54.197099  =


    2023-07-11T21:55:54.298632  / # . /lava-11063871/environment/lava-11063=
871/bin/lava-test-runner /lava-11063871/1

    2023-07-11T21:55:54.299749  =


    2023-07-11T21:55:54.304739  / # /lava-11063871/bin/lava-test-runner /la=
va-11063871/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64adcfcfd4df6821adbb2ab0

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
393-gb6386e7314b4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
393-gb6386e7314b4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64adcfcfd4df6821adbb2ab5
        failing since 103 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-11T21:55:07.990170  + set +x

    2023-07-11T21:55:07.996524  <8>[   10.548786] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11063892_1.4.2.3.1>

    2023-07-11T21:55:08.103317  #

    2023-07-11T21:55:08.104545  =


    2023-07-11T21:55:08.206408  / # #export SHELL=3D/bin/sh

    2023-07-11T21:55:08.207128  =


    2023-07-11T21:55:08.308536  / # export SHELL=3D/bin/sh. /lava-11063892/=
environment

    2023-07-11T21:55:08.309170  =


    2023-07-11T21:55:08.410603  / # . /lava-11063892/environment/lava-11063=
892/bin/lava-test-runner /lava-11063892/1

    2023-07-11T21:55:08.411820  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64adcfde312f545d70bb2ab4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
393-gb6386e7314b4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
393-gb6386e7314b4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64adcfde312f545d70bb2ab9
        failing since 103 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-11T21:55:31.628625  + set<8>[   10.841811] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11063883_1.4.2.3.1>

    2023-07-11T21:55:31.629186   +x

    2023-07-11T21:55:31.737513  / # #

    2023-07-11T21:55:31.840079  export SHELL=3D/bin/sh

    2023-07-11T21:55:31.840851  #

    2023-07-11T21:55:31.942555  / # export SHELL=3D/bin/sh. /lava-11063883/=
environment

    2023-07-11T21:55:31.943365  =


    2023-07-11T21:55:32.045102  / # . /lava-11063883/environment/lava-11063=
883/bin/lava-test-runner /lava-11063883/1

    2023-07-11T21:55:32.046382  =


    2023-07-11T21:55:32.051270  / # /lava-11063883/bin/lava-test-runner /la=
va-11063883/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64adcfd0956a83bb7fbb2ab7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
393-gb6386e7314b4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
393-gb6386e7314b4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64adcfd0956a83bb7fbb2abc
        failing since 103 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-11T21:55:14.623063  + set<8>[   11.588140] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11063880_1.4.2.3.1>

    2023-07-11T21:55:14.623169   +x

    2023-07-11T21:55:14.727883  / # #

    2023-07-11T21:55:14.828488  export SHELL=3D/bin/sh

    2023-07-11T21:55:14.828693  #

    2023-07-11T21:55:14.929157  / # export SHELL=3D/bin/sh. /lava-11063880/=
environment

    2023-07-11T21:55:14.929350  =


    2023-07-11T21:55:15.029873  / # . /lava-11063880/environment/lava-11063=
880/bin/lava-test-runner /lava-11063880/1

    2023-07-11T21:55:15.030178  =


    2023-07-11T21:55:15.035158  / # /lava-11063880/bin/lava-test-runner /la=
va-11063880/1
 =

    ... (12 line(s) more)  =

 =20
