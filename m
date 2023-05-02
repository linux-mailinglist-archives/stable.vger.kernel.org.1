Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B83A6F4C1B
	for <lists+stable@lfdr.de>; Tue,  2 May 2023 23:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjEBVXv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 2 May 2023 17:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjEBVXu (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 2 May 2023 17:23:50 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796AF10EF
        for <stable@vger.kernel.org>; Tue,  2 May 2023 14:23:48 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63b70ca0a84so4976218b3a.2
        for <stable@vger.kernel.org>; Tue, 02 May 2023 14:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683062627; x=1685654627;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Il/3vX7oxKtqIF4AsPqX5rwx2JddumX8oUBCTFlVpf4=;
        b=ZdKNUz6pNf/aVMJN3S4nn8MxzmIE7iGIAQ730jwXamrPfClo8amMrKBeWT5FWWgERJ
         fTopOWVHmALNOL2fQYJPkttntGB0OBAvcitnzHqw0Cg+OmEl+/GaZ57lX8Pa8O0xiUkl
         FOyHpeOPLYP39W2AnI6rJEolWQly0vcHDFHCr5ZD6feO/k/mNPPJFp+8GVHtRoUXq1Pk
         E5aza55Mrud7ktVu8AzxPyKPJp6Mory3NNnu/OIZjU45TxAIM1+IpIt5V/F2pYrEdFyT
         qr2n3mias/uWxhG/DsIgxQwsLVe2BaRUV1KSjQmk88KFcIEMtu9DBAKEwtBaYDUEfZej
         at+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683062627; x=1685654627;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Il/3vX7oxKtqIF4AsPqX5rwx2JddumX8oUBCTFlVpf4=;
        b=JRQkfPJFaBBgNPRig+GJvd60PBnJQ0eutwdjfuEoR6GMoqQAvfRc/NuIx4BZd93INq
         7ubPgF06KAVXd5pACbD/XlYVtJQrQndZ0xZ0VrnBwp9nUwqj/UFo60+PrDdh3gllPzBp
         9auP6/fwzVxQKCl1UcRQCfhexlQxrYYt0vb0eHdIYB7VvoX9iNikouvPcA42iaO54UQL
         lK0A/FoANilLZYMvHE49pYRwz2YNT007QNi2uGluVdyRlRnG+Z43xAmhzysLRJJs5Tmz
         7F3ABsXesLkNEULmocpVrtnDHkdN6rxLcyYvhCjAD+fReYouhy8QWFf9zYcWueNAxbAr
         Nraw==
X-Gm-Message-State: AC+VfDyZd0m09sJ0C2VgBLuxBWHdU2IExsPNZGBjUPAaVrF/ZCySwHfO
        qCzGpdPbA7s15UHL2BTsoSeSwFkQzs7u9lS7ccg=
X-Google-Smtp-Source: ACHHUZ7TqPeStHu9loJYLmZeI+/pLEgPkRLB2d4UcTQ6qjmVq4cP22LK9XPaVQhaUJza6NRj4QdP7w==
X-Received: by 2002:a05:6a20:1588:b0:f0:ec64:f3db with SMTP id h8-20020a056a20158800b000f0ec64f3dbmr22432904pzj.24.1683062627371;
        Tue, 02 May 2023 14:23:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 20-20020a630514000000b005142206430fsm19380785pgf.36.2023.05.02.14.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 14:23:46 -0700 (PDT)
Message-ID: <64517f62.630a0220.e8231.7cf5@mx.google.com>
Date:   Tue, 02 May 2023 14:23:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.22-609-gb309b971b2c8
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 171 runs,
 9 regressions (v6.1.22-609-gb309b971b2c8)
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

stable-rc/queue/6.1 baseline: 171 runs, 9 regressions (v6.1.22-609-gb309b97=
1b2c8)

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


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.22-609-gb309b971b2c8/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.22-609-gb309b971b2c8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b309b971b2c861be229332af8d59c5d5f3182d13 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645149a1aef3a46e972e8621

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-60=
9-gb309b971b2c8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-60=
9-gb309b971b2c8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645149a1aef3a46e972e8626
        failing since 34 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-02T17:34:08.228798  <8>[   10.555890] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10176808_1.4.2.3.1>

    2023-05-02T17:34:08.232207  + set +x

    2023-05-02T17:34:08.336578  / # #

    2023-05-02T17:34:08.437169  export SHELL=3D/bin/sh

    2023-05-02T17:34:08.437375  #

    2023-05-02T17:34:08.537846  / # export SHELL=3D/bin/sh. /lava-10176808/=
environment

    2023-05-02T17:34:08.538035  =


    2023-05-02T17:34:08.638555  / # . /lava-10176808/environment/lava-10176=
808/bin/lava-test-runner /lava-10176808/1

    2023-05-02T17:34:08.638837  =


    2023-05-02T17:34:08.644539  / # /lava-10176808/bin/lava-test-runner /la=
va-10176808/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64514bb1b034d7ebc72e865c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-60=
9-gb309b971b2c8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-60=
9-gb309b971b2c8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64514bb1b034d7ebc72e8661
        failing since 34 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-02T17:42:58.394583  + <8>[   11.055874] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10176798_1.4.2.3.1>

    2023-05-02T17:42:58.395156  set +x

    2023-05-02T17:42:58.503369  / # #

    2023-05-02T17:42:58.606003  export SHELL=3D/bin/sh

    2023-05-02T17:42:58.606798  #

    2023-05-02T17:42:58.708425  / # export SHELL=3D/bin/sh. /lava-10176798/=
environment

    2023-05-02T17:42:58.709215  =


    2023-05-02T17:42:58.810850  / # . /lava-10176798/environment/lava-10176=
798/bin/lava-test-runner /lava-10176798/1

    2023-05-02T17:42:58.812069  =


    2023-05-02T17:42:58.816938  / # /lava-10176798/bin/lava-test-runner /la=
va-10176798/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64514a438a349f7f0d2e85e9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-60=
9-gb309b971b2c8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-60=
9-gb309b971b2c8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64514a438a349f7f0d2e85ee
        failing since 34 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-02T17:36:41.631211  <8>[   10.161418] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10176847_1.4.2.3.1>

    2023-05-02T17:36:41.634830  + set +x

    2023-05-02T17:36:41.736163  #

    2023-05-02T17:36:41.736441  =


    2023-05-02T17:36:41.837060  / # #export SHELL=3D/bin/sh

    2023-05-02T17:36:41.837276  =


    2023-05-02T17:36:41.937809  / # export SHELL=3D/bin/sh. /lava-10176847/=
environment

    2023-05-02T17:36:41.938030  =


    2023-05-02T17:36:42.038571  / # . /lava-10176847/environment/lava-10176=
847/bin/lava-test-runner /lava-10176847/1

    2023-05-02T17:36:42.038865  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2835-rpi-b-rev2           | arm    | lab-broonie   | gcc-10   | bcm2835_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/64514725812c0dc0492e85f8

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-60=
9-gb309b971b2c8/arm/bcm2835_defconfig/gcc-10/lab-broonie/baseline-bcm2835-r=
pi-b-rev2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-60=
9-gb309b971b2c8/arm/bcm2835_defconfig/gcc-10/lab-broonie/baseline-bcm2835-r=
pi-b-rev2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64514725812c0dc0492e8628
        new failure (last pass: v6.1.22-608-g0bd5040e4caae)

    2023-05-02T17:23:26.491676  + set +x
    2023-05-02T17:23:26.496632  <8>[   17.186634] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 405340_1.5.2.4.1>
    2023-05-02T17:23:26.611933  / # #
    2023-05-02T17:23:26.714927  export SHELL=3D/bin/sh
    2023-05-02T17:23:26.715542  #
    2023-05-02T17:23:26.817525  / # export SHELL=3D/bin/sh. /lava-405340/en=
vironment
    2023-05-02T17:23:26.818247  =

    2023-05-02T17:23:26.920362  / # . /lava-405340/environment/lava-405340/=
bin/lava-test-runner /lava-405340/1
    2023-05-02T17:23:26.921627  =

    2023-05-02T17:23:26.927983  / # /lava-405340/bin/lava-test-runner /lava=
-405340/1 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64514b6f0600db1e6e2e861a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-60=
9-gb309b971b2c8/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-60=
9-gb309b971b2c8/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64514b6f0600db1e6e2e8=
61b
        failing since 12 days (last pass: v6.1.22-477-g2128d4458cbc, first =
fail: v6.1.22-474-gecc61872327e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6451498de6ba09f20c2e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-60=
9-gb309b971b2c8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-60=
9-gb309b971b2c8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6451498de6ba09f20c2e85eb
        failing since 34 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-02T17:33:58.243525  + set +x

    2023-05-02T17:33:58.250021  <8>[   10.609658] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10176806_1.4.2.3.1>

    2023-05-02T17:33:58.355022  / # #

    2023-05-02T17:33:58.455720  export SHELL=3D/bin/sh

    2023-05-02T17:33:58.455930  #

    2023-05-02T17:33:58.556444  / # export SHELL=3D/bin/sh. /lava-10176806/=
environment

    2023-05-02T17:33:58.556675  =


    2023-05-02T17:33:58.657217  / # . /lava-10176806/environment/lava-10176=
806/bin/lava-test-runner /lava-10176806/1

    2023-05-02T17:33:58.657526  =


    2023-05-02T17:33:58.661873  / # /lava-10176806/bin/lava-test-runner /la=
va-10176806/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64514beea15cf02f292e85e9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-60=
9-gb309b971b2c8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-60=
9-gb309b971b2c8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64514beea15cf02f292e85ee
        failing since 34 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-02T17:43:53.395537  + set +x<8>[   10.433689] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10176854_1.4.2.3.1>

    2023-05-02T17:43:53.395641  =


    2023-05-02T17:43:53.497215  #

    2023-05-02T17:43:53.598091  / # #export SHELL=3D/bin/sh

    2023-05-02T17:43:53.598765  =


    2023-05-02T17:43:53.700036  / # export SHELL=3D/bin/sh. /lava-10176854/=
environment

    2023-05-02T17:43:53.700749  =


    2023-05-02T17:43:53.802087  / # . /lava-10176854/environment/lava-10176=
854/bin/lava-test-runner /lava-10176854/1

    2023-05-02T17:43:53.803259  =


    2023-05-02T17:43:53.808228  / # /lava-10176854/bin/lava-test-runner /la=
va-10176854/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645149bbfe787dae982e8670

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-60=
9-gb309b971b2c8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-60=
9-gb309b971b2c8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645149bbfe787dae982e8675
        failing since 34 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-02T17:34:30.492463  + set<8>[   11.163685] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10176861_1.4.2.3.1>

    2023-05-02T17:34:30.492547   +x

    2023-05-02T17:34:30.596289  / # #

    2023-05-02T17:34:30.696885  export SHELL=3D/bin/sh

    2023-05-02T17:34:30.697081  #

    2023-05-02T17:34:30.797567  / # export SHELL=3D/bin/sh. /lava-10176861/=
environment

    2023-05-02T17:34:30.797770  =


    2023-05-02T17:34:30.898327  / # . /lava-10176861/environment/lava-10176=
861/bin/lava-test-runner /lava-10176861/1

    2023-05-02T17:34:30.898638  =


    2023-05-02T17:34:30.903270  / # /lava-10176861/bin/lava-test-runner /la=
va-10176861/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645149affe787dae982e8634

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-60=
9-gb309b971b2c8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-60=
9-gb309b971b2c8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645149affe787dae982e8639
        failing since 34 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-02T17:34:32.183411  <8>[   13.005736] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10176821_1.4.2.3.1>

    2023-05-02T17:34:32.287355  / # #

    2023-05-02T17:34:32.388019  export SHELL=3D/bin/sh

    2023-05-02T17:34:32.388282  #

    2023-05-02T17:34:32.488914  / # export SHELL=3D/bin/sh. /lava-10176821/=
environment

    2023-05-02T17:34:32.489143  =


    2023-05-02T17:34:32.589758  / # . /lava-10176821/environment/lava-10176=
821/bin/lava-test-runner /lava-10176821/1

    2023-05-02T17:34:32.590112  =


    2023-05-02T17:34:32.602456  / # /lava-10176821/bin/lava-test-runner /la=
va-10176821/1

    2023-05-02T17:34:32.602828  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =20
