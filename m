Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641D96F2E97
	for <lists+stable@lfdr.de>; Mon,  1 May 2023 07:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjEAFV0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 1 May 2023 01:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjEAFVY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 1 May 2023 01:21:24 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496F6A4
        for <stable@vger.kernel.org>; Sun, 30 Apr 2023 22:21:22 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5208be24dcbso1344037a12.1
        for <stable@vger.kernel.org>; Sun, 30 Apr 2023 22:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682918481; x=1685510481;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5gcf/6X+UrVw07ebyN8qizFNMbEDGTp6oOdlfUI5VnI=;
        b=ItEObpv2LRcqqcsRmGJz4VzQU5fpWxPg09xSialuKfazlWCbIU7lmkdJaRYF1OQQUC
         FnSS0HTDSmEc7nHoFoQJq3IngNxI626n9SYfjPvrNG1x+PTXzaP/cOwMwmGD6FWmmZDJ
         xuy4X2CdIxRmIf7v/Gy/7dyCk74ShOf+7AO7gQ8TKltXqjqdhhPNOhCd5xsDotWm3Opi
         64U44aIfqp1y3gCxLn93QxU2UlNMDJC4cpwzeERB9XEj8e/+TqwmMBjUplePHhNN3EN8
         2DI7zEmVc8s+RGd6722woA0dx4sgsTD1y6dYP3TWAgDNgtCLMLqA0vKujS2H5i07y2eT
         9a6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682918481; x=1685510481;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gcf/6X+UrVw07ebyN8qizFNMbEDGTp6oOdlfUI5VnI=;
        b=Zm/tFh+fQ2ihkhBhWqQBprm7I4c5KvD4xxHGa20PzoHC4dl2ralon027UkHd5lx7hB
         kkB2U32vv1pLF+kdt33c4JYm9mSIqNSYPqDk5gPwIKvG5hN6UF8KFeUIMYAVKu+bJEMx
         5i2Im83WD4h36xZD2RY8HO55jHrae5kKV2ogZQrgn5Y/dbu/2WVY6StoCRPgRpOvGxJW
         /YsKHuGHcbRsOUxxwtM6SCJaoaTKITINqz/MHIXGVu4YnjZwAWyURLZ+ii/C3aszyGga
         8JJOkzUA2s0ii0KrASIcHM9IY3IGZV4oFPpAiHg6ydMbHWUb4o7xTSQLXryEc5csQgMp
         Cprg==
X-Gm-Message-State: AC+VfDz52rtP4FP+HqZ++ZHBIth6IWT55la4ddcS0g316wo13oYMp+Ck
        WCBiWPFSESBxPtp9bbYih/lRht0WtJddOPy+lms=
X-Google-Smtp-Source: ACHHUZ7yShCdhyaNx8yZ7HAd4r0mvKWWnG0ZQJkPYyj3/dS6Z/xgEy5ukpt8KQIz2YHW/SfbmEWgrg==
X-Received: by 2002:a05:6a20:e195:b0:f5:68c9:6f83 with SMTP id ks21-20020a056a20e19500b000f568c96f83mr14466107pzb.18.1682918480957;
        Sun, 30 Apr 2023 22:21:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u14-20020a63470e000000b0051f15beba7fsm16112591pga.67.2023.04.30.22.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 22:21:20 -0700 (PDT)
Message-ID: <644f4c50.630a0220.50d40.0578@mx.google.com>
Date:   Sun, 30 Apr 2023 22:21:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.22-590-gb2ac7c980cc6
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 174 runs,
 10 regressions (v6.1.22-590-gb2ac7c980cc6)
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

stable-rc/queue/6.1 baseline: 174 runs, 10 regressions (v6.1.22-590-gb2ac7c=
980cc6)

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

bcm2835-rpi-b-rev2           | arm    | lab-broonie   | gcc-10   | bcm2835_=
defconfig            | 1          =

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

meson-g12a-sei510            | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.22-590-gb2ac7c980cc6/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.22-590-gb2ac7c980cc6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b2ac7c980cc63dc87f165e2a2dd90f613f491bec =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644f1684a4de7caff82e85f4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-59=
0-gb2ac7c980cc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-59=
0-gb2ac7c980cc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f1684a4de7caff82e85f9
        failing since 33 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-01T01:31:30.087619  + set +x

    2023-05-01T01:31:30.094412  <8>[   10.399362] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10164375_1.4.2.3.1>

    2023-05-01T01:31:30.196891  #

    2023-05-01T01:31:30.197168  =


    2023-05-01T01:31:30.297757  / # #export SHELL=3D/bin/sh

    2023-05-01T01:31:30.297943  =


    2023-05-01T01:31:30.398459  / # export SHELL=3D/bin/sh. /lava-10164375/=
environment

    2023-05-01T01:31:30.398654  =


    2023-05-01T01:31:30.499185  / # . /lava-10164375/environment/lava-10164=
375/bin/lava-test-runner /lava-10164375/1

    2023-05-01T01:31:30.499471  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644f1682f214b620622e85f4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-59=
0-gb2ac7c980cc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-59=
0-gb2ac7c980cc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f1682f214b620622e85f9
        failing since 33 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-01T01:31:25.261159  + <8>[    8.865939] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10164348_1.4.2.3.1>

    2023-05-01T01:31:25.261253  set +x

    2023-05-01T01:31:25.365810  / # #

    2023-05-01T01:31:25.466508  export SHELL=3D/bin/sh

    2023-05-01T01:31:25.466700  #

    2023-05-01T01:31:25.567380  / # export SHELL=3D/bin/sh. /lava-10164348/=
environment

    2023-05-01T01:31:25.567610  =


    2023-05-01T01:31:25.668205  / # . /lava-10164348/environment/lava-10164=
348/bin/lava-test-runner /lava-10164348/1

    2023-05-01T01:31:25.668489  =


    2023-05-01T01:31:25.673122  / # /lava-10164348/bin/lava-test-runner /la=
va-10164348/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644f1692438cb793432e85fb

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-59=
0-gb2ac7c980cc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-59=
0-gb2ac7c980cc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f1692438cb793432e8600
        failing since 33 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-01T01:31:41.699685  <8>[   10.038367] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10164368_1.4.2.3.1>

    2023-05-01T01:31:41.702830  + set +x

    2023-05-01T01:31:41.804115  =


    2023-05-01T01:31:41.904688  / # #export SHELL=3D/bin/sh

    2023-05-01T01:31:41.904873  =


    2023-05-01T01:31:42.005383  / # export SHELL=3D/bin/sh. /lava-10164368/=
environment

    2023-05-01T01:31:42.005559  =


    2023-05-01T01:31:42.106105  / # . /lava-10164368/environment/lava-10164=
368/bin/lava-test-runner /lava-10164368/1

    2023-05-01T01:31:42.106424  =


    2023-05-01T01:31:42.111112  / # /lava-10164368/bin/lava-test-runner /la=
va-10164368/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2835-rpi-b-rev2           | arm    | lab-broonie   | gcc-10   | bcm2835_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/644f140b0fb4d513ba2e8604

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-59=
0-gb2ac7c980cc6/arm/bcm2835_defconfig/gcc-10/lab-broonie/baseline-bcm2835-r=
pi-b-rev2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-59=
0-gb2ac7c980cc6/arm/bcm2835_defconfig/gcc-10/lab-broonie/baseline-bcm2835-r=
pi-b-rev2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f140b0fb4d513ba2e8636
        failing since 3 days (last pass: v6.1.22-573-g35b4c8b34dab, first f=
ail: v6.1.22-580-ga9ca34ec26f3)

    2023-05-01T01:20:51.241259  + set +x
    2023-05-01T01:20:51.245698  <8>[   17.659436] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 402878_1.5.2.4.1>
    2023-05-01T01:20:51.362487  / # #
    2023-05-01T01:20:51.465013  export SHELL=3D/bin/sh
    2023-05-01T01:20:51.465353  #
    2023-05-01T01:20:51.566496  / # export SHELL=3D/bin/sh. /lava-402878/en=
vironment
    2023-05-01T01:20:51.567240  =

    2023-05-01T01:20:51.668862  / # . /lava-402878/environment/lava-402878/=
bin/lava-test-runner /lava-402878/1
    2023-05-01T01:20:51.669969  =

    2023-05-01T01:20:51.676403  / # /lava-402878/bin/lava-test-runner /lava=
-402878/1 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/644f19322a7579c7d12e861e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-59=
0-gb2ac7c980cc6/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-59=
0-gb2ac7c980cc6/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644f19322a7579c7d12e8=
61f
        failing since 10 days (last pass: v6.1.22-477-g2128d4458cbc, first =
fail: v6.1.22-474-gecc61872327e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644f166e1239706ec92e8660

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-59=
0-gb2ac7c980cc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-59=
0-gb2ac7c980cc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f166e1239706ec92e8665
        failing since 33 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-01T01:31:17.869708  + set +x

    2023-05-01T01:31:17.876762  <8>[   10.696967] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10164364_1.4.2.3.1>

    2023-05-01T01:31:17.981273  / # #

    2023-05-01T01:31:18.082018  export SHELL=3D/bin/sh

    2023-05-01T01:31:18.082216  #

    2023-05-01T01:31:18.182752  / # export SHELL=3D/bin/sh. /lava-10164364/=
environment

    2023-05-01T01:31:18.182944  =


    2023-05-01T01:31:18.283469  / # . /lava-10164364/environment/lava-10164=
364/bin/lava-test-runner /lava-10164364/1

    2023-05-01T01:31:18.283751  =


    2023-05-01T01:31:18.288598  / # /lava-10164364/bin/lava-test-runner /la=
va-10164364/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644f167ec14f6e23df2e8618

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-59=
0-gb2ac7c980cc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-59=
0-gb2ac7c980cc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f167ec14f6e23df2e861d
        failing since 33 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-01T01:31:25.163611  + set +x<8>[    7.831183] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10164423_1.4.2.3.1>

    2023-05-01T01:31:25.163721  =


    2023-05-01T01:31:25.265854  #

    2023-05-01T01:31:25.366737  / # #export SHELL=3D/bin/sh

    2023-05-01T01:31:25.366939  =


    2023-05-01T01:31:25.467518  / # export SHELL=3D/bin/sh. /lava-10164423/=
environment

    2023-05-01T01:31:25.467719  =


    2023-05-01T01:31:25.568270  / # . /lava-10164423/environment/lava-10164=
423/bin/lava-test-runner /lava-10164423/1

    2023-05-01T01:31:25.568591  =


    2023-05-01T01:31:25.573629  / # /lava-10164423/bin/lava-test-runner /la=
va-10164423/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644f1693438cb793432e861d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-59=
0-gb2ac7c980cc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-59=
0-gb2ac7c980cc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f1693438cb793432e8622
        failing since 33 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-01T01:31:40.952212  + <8>[   11.153519] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10164425_1.4.2.3.1>

    2023-05-01T01:31:40.952315  set +x

    2023-05-01T01:31:41.056101  / # #

    2023-05-01T01:31:41.156657  export SHELL=3D/bin/sh

    2023-05-01T01:31:41.156829  #

    2023-05-01T01:31:41.257346  / # export SHELL=3D/bin/sh. /lava-10164425/=
environment

    2023-05-01T01:31:41.257533  =


    2023-05-01T01:31:41.358057  / # . /lava-10164425/environment/lava-10164=
425/bin/lava-test-runner /lava-10164425/1

    2023-05-01T01:31:41.358382  =


    2023-05-01T01:31:41.362810  / # /lava-10164425/bin/lava-test-runner /la=
va-10164425/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644f168ca4de7caff82e8684

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-59=
0-gb2ac7c980cc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-59=
0-gb2ac7c980cc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f168ca4de7caff82e8689
        failing since 33 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-01T01:31:34.790811  + set +x<8>[   11.243997] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10164393_1.4.2.3.1>

    2023-05-01T01:31:34.790894  =


    2023-05-01T01:31:34.895277  / # #

    2023-05-01T01:31:34.995907  export SHELL=3D/bin/sh

    2023-05-01T01:31:34.996070  #

    2023-05-01T01:31:35.096585  / # export SHELL=3D/bin/sh. /lava-10164393/=
environment

    2023-05-01T01:31:35.096773  =


    2023-05-01T01:31:35.197300  / # . /lava-10164393/environment/lava-10164=
393/bin/lava-test-runner /lava-10164393/1

    2023-05-01T01:31:35.197549  =


    2023-05-01T01:31:35.202110  / # /lava-10164393/bin/lava-test-runner /la=
va-10164393/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-g12a-sei510            | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644f1b708c24e2f6362e8987

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-59=
0-gb2ac7c980cc6/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-g12a-sei=
510.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-59=
0-gb2ac7c980cc6/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-g12a-sei=
510.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f1b708c24e2f6362e898c
        new failure (last pass: v6.1.22-573-g35b4c8b34dab)

    2023-05-01T01:52:24.309560  / # #
    2023-05-01T01:52:24.411561  export SHELL=3D/bin/sh
    2023-05-01T01:52:24.411979  #
    2023-05-01T01:52:24.513372  / # export SHELL=3D/bin/sh. /lava-3545149/e=
nvironment
    2023-05-01T01:52:24.514123  =

    2023-05-01T01:52:24.514586  / # <3>[   24.734716] brcmfmac: brcmf_sdio_=
htclk: HT Avail timeout (1000000): clkctl 0x50
    2023-05-01T01:52:24.616483  . /lava-3545149/environment/lava-3545149/bi=
n/lava-test-runner /lava-3545149/1
    2023-05-01T01:52:24.617617  =

    2023-05-01T01:52:24.631620  / # /lava-3545149/bin/lava-test-runner /lav=
a-3545149/1
    2023-05-01T01:52:24.693616  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =20
