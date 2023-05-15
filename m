Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73EF702D19
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 14:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241947AbjEOMvS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 08:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241705AbjEOMvR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 08:51:17 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B4ED2
        for <stable@vger.kernel.org>; Mon, 15 May 2023 05:51:13 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6439d505274so7901038b3a.0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 05:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684155072; x=1686747072;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1raX9mvuWu/xQiXbSXgp16T2UYIEezrUWQNspMg+xSM=;
        b=pSv4mQpx1OeO+0IiK7szU+NNe0ab5DyG7RAPbfqL2paol3tAhtC3dg0lvE6jJ2VuIi
         wuZI5veEUzFP7aEErxPefnYWXWytXRpMKxNlehcA7VrOQ9LdI72hZRc4WsDuBnl2VZ3E
         3D/Ciok7hi/GTJJo74UtT+Pgrl+6o8L+tpSXfAUGBEhXN2dSa5Smt9W/pBdHl9Qzk7mH
         BuYpcvutdgOPSaL5lhoSohaPYWXREXQfQxcnpZ2wLQjcaq83GcMeYTW9pRYMesoKVAH+
         N+h34xslUOZex/2w83MboarB0faY6mCd6Mc8o68F3+e0p0iV4Iq6MUSgCubhWP5khj+b
         aqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684155072; x=1686747072;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1raX9mvuWu/xQiXbSXgp16T2UYIEezrUWQNspMg+xSM=;
        b=lmdlvmqGo5WPGP8/91lEW4gR6+aM2DrCcWcH0J6cbKgER3uvRWcTqLlbK97LTl+fY6
         SODYz+4BCu1oSB5FeI+Z00hzuqR9ZPdfqAmJTWku43WpFH9UvvNriOWyymwdEsVLQQxf
         gNVDrcwfWWVK7A/89Dr8sBuXcEyD6H5zH2udyp+RC6MjOnOuSJ6dbOkNl49UEjqJoXBL
         jJag2w0vQqhoiAcNSFQ9m73A4tXpV+yhvd20Yg8UhEDlDExw/li5mgAgYEg8YYIsjqTX
         pLpj6gaL4rRLINNVWfkwydQmFQUi9auAjxOButhUYgza2Vc/OkzFq3giuyfO5JuTZXER
         3arg==
X-Gm-Message-State: AC+VfDzyXLllQZzTWnqc+RfTZUe+knN+RY93xqCoSt30w6OpQXp09tqo
        Twa9KZpqtRxbgziAlDYjTsoOi1HQ5wKbgOfsxNvv5Q==
X-Google-Smtp-Source: ACHHUZ6xo95agrMaotRVvL72FDg6+5XIjKO+5o7Yb3bh8QT3y5Ytr5kvLppbzDhy7IY0ni1eH/j1eQ==
X-Received: by 2002:a05:6a20:3d1a:b0:101:5f22:b46d with SMTP id y26-20020a056a203d1a00b001015f22b46dmr29368967pzi.29.1684155071859;
        Mon, 15 May 2023 05:51:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y1-20020a62b501000000b0064c98c87384sm2664968pfe.44.2023.05.15.05.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 05:51:11 -0700 (PDT)
Message-ID: <64622abf.620a0220.743f6.3dc7@mx.google.com>
Date:   Mon, 15 May 2023 05:51:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.111-130-g571d94b189c99
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 173 runs,
 9 regressions (v5.15.111-130-g571d94b189c99)
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

stable-rc/queue/5.15 baseline: 173 runs, 9 regressions (v5.15.111-130-g571d=
94b189c99)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.111-130-g571d94b189c99/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.111-130-g571d94b189c99
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      571d94b189c9974074be6cf47e2432bf627bfa48 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461f202b94bf8a69d2e861c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-130-g571d94b189c99/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-130-g571d94b189c99/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461f202b94bf8a69d2e8621
        failing since 47 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-15T08:48:45.470718  + set +x<8>[   11.035636] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10319933_1.4.2.3.1>

    2023-05-15T08:48:45.470794  =


    2023-05-15T08:48:45.575202  / # #

    2023-05-15T08:48:45.675832  export SHELL=3D/bin/sh

    2023-05-15T08:48:45.676048  #

    2023-05-15T08:48:45.776538  / # export SHELL=3D/bin/sh. /lava-10319933/=
environment

    2023-05-15T08:48:45.776765  =


    2023-05-15T08:48:45.877337  / # . /lava-10319933/environment/lava-10319=
933/bin/lava-test-runner /lava-10319933/1

    2023-05-15T08:48:45.877616  =


    2023-05-15T08:48:45.882397  / # /lava-10319933/bin/lava-test-runner /la=
va-10319933/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461f21c9cc76b82622e8619

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-130-g571d94b189c99/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-130-g571d94b189c99/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461f21c9cc76b82622e861e
        failing since 47 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-15T08:49:10.936963  <8>[   11.178729] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10319954_1.4.2.3.1>

    2023-05-15T08:49:10.940392  + set +x

    2023-05-15T08:49:11.045351  #

    2023-05-15T08:49:11.046679  =


    2023-05-15T08:49:11.148628  / # #export SHELL=3D/bin/sh

    2023-05-15T08:49:11.149521  =


    2023-05-15T08:49:11.250867  / # export SHELL=3D/bin/sh. /lava-10319954/=
environment

    2023-05-15T08:49:11.251068  =


    2023-05-15T08:49:11.351616  / # . /lava-10319954/environment/lava-10319=
954/bin/lava-test-runner /lava-10319954/1

    2023-05-15T08:49:11.351960  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6461f3d42cbd3434c92e8609

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-130-g571d94b189c99/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-130-g571d94b189c99/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6461f3d42cbd3434c92e8=
60a
        failing since 100 days (last pass: v5.15.91-12-g3290f78df1ab, first=
 fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6461f4cf00ab5f7b7e2e85ef

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-130-g571d94b189c99/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-130-g571d94b189c99/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461f4cf00ab5f7b7e2e85f4
        failing since 118 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-15T09:00:43.349812  + set +x<8>[   10.035802] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3591528_1.5.2.4.1>
    2023-05-15T09:00:43.350110  =

    2023-05-15T09:00:43.456928  / # #
    2023-05-15T09:00:43.558628  export SHELL=3D/bin/sh
    2023-05-15T09:00:43.559148  #
    2023-05-15T09:00:43.660476  / # export SHELL=3D/bin/sh. /lava-3591528/e=
nvironment
    2023-05-15T09:00:43.661074  =

    2023-05-15T09:00:43.762336  / # . /lava-3591528/environment/lava-359152=
8/bin/lava-test-runner /lava-3591528/1
    2023-05-15T09:00:43.763114  =

    2023-05-15T09:00:43.767890  / # /lava-3591528/bin/lava-test-runner /lav=
a-3591528/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461f2fbb1624529712e861a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-130-g571d94b189c99/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-130-g571d94b189c99/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461f2fbb1624529712e861f
        failing since 47 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-15T08:53:00.403913  + set +x

    2023-05-15T08:53:00.410083  <8>[   10.843528] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10319949_1.4.2.3.1>

    2023-05-15T08:53:00.514394  / # #

    2023-05-15T08:53:00.614960  export SHELL=3D/bin/sh

    2023-05-15T08:53:00.615121  #

    2023-05-15T08:53:00.715593  / # export SHELL=3D/bin/sh. /lava-10319949/=
environment

    2023-05-15T08:53:00.715786  =


    2023-05-15T08:53:00.816340  / # . /lava-10319949/environment/lava-10319=
949/bin/lava-test-runner /lava-10319949/1

    2023-05-15T08:53:00.816611  =


    2023-05-15T08:53:00.821319  / # /lava-10319949/bin/lava-test-runner /la=
va-10319949/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461f1f9fa4246491f2e860c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-130-g571d94b189c99/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-130-g571d94b189c99/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461f1f9fa4246491f2e8611
        failing since 47 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-15T08:48:44.284902  <8>[   10.864640] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10319959_1.4.2.3.1>

    2023-05-15T08:48:44.288354  + set +x

    2023-05-15T08:48:44.393969  #

    2023-05-15T08:48:44.395299  =


    2023-05-15T08:48:44.496987  / # #export SHELL=3D/bin/sh

    2023-05-15T08:48:44.497229  =


    2023-05-15T08:48:44.597797  / # export SHELL=3D/bin/sh. /lava-10319959/=
environment

    2023-05-15T08:48:44.598011  =


    2023-05-15T08:48:44.698607  / # . /lava-10319959/environment/lava-10319=
959/bin/lava-test-runner /lava-10319959/1

    2023-05-15T08:48:44.698856  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461f20cb94bf8a69d2e8634

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-130-g571d94b189c99/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-130-g571d94b189c99/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461f20cb94bf8a69d2e8639
        failing since 47 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-15T08:48:57.082985  + set<8>[   11.341572] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10319977_1.4.2.3.1>

    2023-05-15T08:48:57.083096   +x

    2023-05-15T08:48:57.187245  / # #

    2023-05-15T08:48:57.287793  export SHELL=3D/bin/sh

    2023-05-15T08:48:57.287988  #

    2023-05-15T08:48:57.388483  / # export SHELL=3D/bin/sh. /lava-10319977/=
environment

    2023-05-15T08:48:57.388661  =


    2023-05-15T08:48:57.489205  / # . /lava-10319977/environment/lava-10319=
977/bin/lava-test-runner /lava-10319977/1

    2023-05-15T08:48:57.489504  =


    2023-05-15T08:48:57.494571  / # /lava-10319977/bin/lava-test-runner /la=
va-10319977/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461f1f3ff20465d732e8609

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-130-g571d94b189c99/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-130-g571d94b189c99/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461f1f3ff20465d732e860e
        failing since 47 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-15T08:48:40.864817  + set<8>[   12.494237] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10319940_1.4.2.3.1>

    2023-05-15T08:48:40.865262   +x

    2023-05-15T08:48:40.973436  / # #

    2023-05-15T08:48:41.075839  export SHELL=3D/bin/sh

    2023-05-15T08:48:41.076545  #

    2023-05-15T08:48:41.177861  / # export SHELL=3D/bin/sh. /lava-10319940/=
environment

    2023-05-15T08:48:41.178638  =


    2023-05-15T08:48:41.280053  / # . /lava-10319940/environment/lava-10319=
940/bin/lava-test-runner /lava-10319940/1

    2023-05-15T08:48:41.281240  =


    2023-05-15T08:48:41.286195  / # /lava-10319940/bin/lava-test-runner /la=
va-10319940/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/6461f3976f8e18b5142e85f2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-130-g571d94b189c99/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-=
h2-plus-orangepi-r1.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-130-g571d94b189c99/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-=
h2-plus-orangepi-r1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461f3976f8e18b5142e85f7
        failing since 103 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.90-203-gea2e94bef77e)

    2023-05-15T08:53:30.515795  / # #
    2023-05-15T08:53:30.621504  export SHELL=3D/bin/sh
    2023-05-15T08:53:30.623169  #
    2023-05-15T08:53:30.726483  / # export SHELL=3D/bin/sh. /lava-3591488/e=
nvironment
    2023-05-15T08:53:30.728096  =

    2023-05-15T08:53:30.831541  / # . /lava-3591488/environment/lava-359148=
8/bin/lava-test-runner /lava-3591488/1
    2023-05-15T08:53:30.834371  =

    2023-05-15T08:53:30.840746  / # /lava-3591488/bin/lava-test-runner /lav=
a-3591488/1
    2023-05-15T08:53:30.978392  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-15T08:53:30.979446  + cd /lava-3591488/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
