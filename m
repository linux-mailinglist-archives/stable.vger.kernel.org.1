Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE4C717641
	for <lists+stable@lfdr.de>; Wed, 31 May 2023 07:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjEaFgO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 31 May 2023 01:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjEaFgN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 31 May 2023 01:36:13 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52F0EE
        for <stable@vger.kernel.org>; Tue, 30 May 2023 22:36:10 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-19f7f41d9dcso2131023fac.2
        for <stable@vger.kernel.org>; Tue, 30 May 2023 22:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685511369; x=1688103369;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zoQPCbABHRNXVaC7fkUSujovFRvKwlD6itK/tatX2R0=;
        b=ZDHvQe8UqQS4wSH9CZCZvP+ubSwG1Xnnu6ncSuyG8HyYGCnY4QizX9MtN3weB3bo2T
         MdEJQGKRgg3uMyR6mZr4b007YBQMZcwjTpLy49H3HFcdSuBK9me9BkCSGzli4DGw1LH4
         QWkfMx5M0IW3p3UsHE4C0M3ni9klFLIzQ02k8TAlw3m2EcooG1vLKokQ+99R1M62ys1a
         ioAuPBDDyiQIuJAo87qskizgHCLuhQHp5h3ihnBjQ71D5RZRYYqWycdwltScqDuslji+
         voNZOoVtPVuYWK5/Dmet7aDcbzj1O3rOUf5OwR3uC+Ak19duuULfYx+IuNgPZFOKpxHE
         6/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685511369; x=1688103369;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zoQPCbABHRNXVaC7fkUSujovFRvKwlD6itK/tatX2R0=;
        b=j8KvrNY4o9zstnOZKkf7Yz6OFdwAUWE0SmTnsyfJkXxXsYRoyoTI6F3dwM60/Ib2iN
         cbcfpvUULb0Xxc6llZJh3ON92y2YyX5V2eBh1zLPqyKrkAHPr96+NIbtKfDNcvW9E4yb
         HyKEdw2lv2Rao5ydNWXyW+XIeoEaijAt/hXq1JfIVNv5VMT515pu3V8lnGrrM5EyH6Uc
         vZ1vmHK46nx029xb+9yw4l/ASHhjM4t9UHaOkNkho/FHJ+AmcVuc6TD9qZF5iuZHcf6o
         4L9Lq86VT0iYhELYc1ALSF87AqUWx/pc827nuOpMrotTf+cxAdmS977awLz/WFRFnU36
         rtWA==
X-Gm-Message-State: AC+VfDzwbIqLLk3xeHIarX92pAml6EXwV29SAszUzMjQN6CvCsQpVIWv
        ZeTuFQxG9jfsM4JqhDwC3yNY8hkdz0blOWYsAKQUkA==
X-Google-Smtp-Source: ACHHUZ6YeJYTw2E570lIWDffno/7/Yeuk+Yfu1UTtqijyie2fiUqFPKHFM4iRU1GIr2we+HPqMhGyg==
X-Received: by 2002:a05:6871:8a7:b0:19f:515d:92ac with SMTP id r39-20020a05687108a700b0019f515d92acmr3494547oaq.14.1685511369537;
        Tue, 30 May 2023 22:36:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p9-20020aa78609000000b00640f588b36dsm2500225pfn.8.2023.05.30.22.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 22:36:08 -0700 (PDT)
Message-ID: <6476dcc8.a70a0220.50d68.5896@mx.google.com>
Date:   Tue, 30 May 2023 22:36:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.114-13-g095e387c3889
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 159 runs,
 7 regressions (v5.15.114-13-g095e387c3889)
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

stable-rc/queue/5.15 baseline: 159 runs, 7 regressions (v5.15.114-13-g095e3=
87c3889)

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


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.114-13-g095e387c3889/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.114-13-g095e387c3889
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      095e387c38898026f554e6890f6304e68dc8c5b0 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6476a3ec56f013340e2e862f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.114=
-13-g095e387c3889/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.114=
-13-g095e387c3889/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6476a3ec56f013340e2e8634
        failing since 63 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-31T01:33:12.179285  + <8>[   12.152990] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10535407_1.4.2.3.1>

    2023-05-31T01:33:12.179380  set +x

    2023-05-31T01:33:12.283621  / # #

    2023-05-31T01:33:12.384494  export SHELL=3D/bin/sh

    2023-05-31T01:33:12.384776  #

    2023-05-31T01:33:12.485400  / # export SHELL=3D/bin/sh. /lava-10535407/=
environment

    2023-05-31T01:33:12.485673  =


    2023-05-31T01:33:12.586355  / # . /lava-10535407/environment/lava-10535=
407/bin/lava-test-runner /lava-10535407/1

    2023-05-31T01:33:12.586637  =


    2023-05-31T01:33:12.590960  / # /lava-10535407/bin/lava-test-runner /la=
va-10535407/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6476a3f556f013340e2e8651

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.114=
-13-g095e387c3889/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.114=
-13-g095e387c3889/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6476a3f556f013340e2e8656
        failing since 63 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-31T01:33:21.744462  <8>[   10.767450] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10535398_1.4.2.3.1>

    2023-05-31T01:33:21.747653  + set +x

    2023-05-31T01:33:21.848749  #

    2023-05-31T01:33:21.848995  =


    2023-05-31T01:33:21.949519  / # #export SHELL=3D/bin/sh

    2023-05-31T01:33:21.949663  =


    2023-05-31T01:33:22.050109  / # export SHELL=3D/bin/sh. /lava-10535398/=
environment

    2023-05-31T01:33:22.050262  =


    2023-05-31T01:33:22.150724  / # . /lava-10535398/environment/lava-10535=
398/bin/lava-test-runner /lava-10535398/1

    2023-05-31T01:33:22.150952  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6476a67aedfb0704502e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.114=
-13-g095e387c3889/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.114=
-13-g095e387c3889/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6476a67aedfb0704502e8=
5e7
        failing since 116 days (last pass: v5.15.91-12-g3290f78df1ab, first=
 fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6476a47369f3e83b3e2e85f2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.114=
-13-g095e387c3889/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubie=
truck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.114=
-13-g095e387c3889/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubie=
truck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6476a47369f3e83b3e2e85f7
        failing since 133 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-31T01:35:35.803898  <8>[   10.042802] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3633066_1.5.2.4.1>
    2023-05-31T01:35:35.914344  / # #
    2023-05-31T01:35:36.018068  export SHELL=3D/bin/sh
    2023-05-31T01:35:36.019125  #
    2023-05-31T01:35:36.121625  / # export SHELL=3D/bin/sh. /lava-3633066/e=
nvironment
    2023-05-31T01:35:36.122882  =

    2023-05-31T01:35:36.123494  / # <3>[   10.273195] Bluetooth: hci0: comm=
and 0xfc18 tx timeout
    2023-05-31T01:35:36.225997  . /lava-3633066/environment/lava-3633066/bi=
n/lava-test-runner /lava-3633066/1
    2023-05-31T01:35:36.227627  =

    2023-05-31T01:35:36.232609  / # /lava-3633066/bin/lava-test-runner /lav=
a-3633066/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6476a402476163d88b2e85f6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.114=
-13-g095e387c3889/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.114=
-13-g095e387c3889/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6476a402476163d88b2e85fb
        failing since 63 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-31T01:33:39.049374  + set +x

    2023-05-31T01:33:39.055621  <8>[   10.568070] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10535386_1.4.2.3.1>

    2023-05-31T01:33:39.163171  / # #

    2023-05-31T01:33:39.263688  export SHELL=3D/bin/sh

    2023-05-31T01:33:39.263836  #

    2023-05-31T01:33:39.364323  / # export SHELL=3D/bin/sh. /lava-10535386/=
environment

    2023-05-31T01:33:39.364506  =


    2023-05-31T01:33:39.465036  / # . /lava-10535386/environment/lava-10535=
386/bin/lava-test-runner /lava-10535386/1

    2023-05-31T01:33:39.465268  =


    2023-05-31T01:33:39.469467  / # /lava-10535386/bin/lava-test-runner /la=
va-10535386/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6476a3da89b2aab32e2e8632

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.114=
-13-g095e387c3889/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.114=
-13-g095e387c3889/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6476a3da89b2aab32e2e8637
        failing since 63 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-31T01:32:57.649383  <8>[   13.567415] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10535408_1.4.2.3.1>

    2023-05-31T01:32:57.653177  + set +x

    2023-05-31T01:32:57.755202  #

    2023-05-31T01:32:57.755663  =


    2023-05-31T01:32:57.856433  / # #export SHELL=3D/bin/sh

    2023-05-31T01:32:57.856730  =


    2023-05-31T01:32:57.957369  / # export SHELL=3D/bin/sh. /lava-10535408/=
environment

    2023-05-31T01:32:57.957581  =


    2023-05-31T01:32:58.058152  / # . /lava-10535408/environment/lava-10535=
408/bin/lava-test-runner /lava-10535408/1

    2023-05-31T01:32:58.058541  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6476a3ff6597c097952e85fe

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.114=
-13-g095e387c3889/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.114=
-13-g095e387c3889/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6476a3ff6597c097952e8603
        failing since 63 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-31T01:33:26.780340  + <8>[   10.684173] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10535420_1.4.2.3.1>

    2023-05-31T01:33:26.780475  set +x

    2023-05-31T01:33:26.885158  / # #

    2023-05-31T01:33:26.985867  export SHELL=3D/bin/sh

    2023-05-31T01:33:26.986087  #

    2023-05-31T01:33:27.086619  / # export SHELL=3D/bin/sh. /lava-10535420/=
environment

    2023-05-31T01:33:27.086828  =


    2023-05-31T01:33:27.187362  / # . /lava-10535420/environment/lava-10535=
420/bin/lava-test-runner /lava-10535420/1

    2023-05-31T01:33:27.187691  =


    2023-05-31T01:33:27.192177  / # /lava-10535420/bin/lava-test-runner /la=
va-10535420/1
 =

    ... (12 line(s) more)  =

 =20
