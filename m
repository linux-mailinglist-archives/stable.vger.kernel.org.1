Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8372E712FD8
	for <lists+stable@lfdr.de>; Sat, 27 May 2023 00:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244376AbjEZWR4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 26 May 2023 18:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244389AbjEZWRz (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 26 May 2023 18:17:55 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46797194
        for <stable@vger.kernel.org>; Fri, 26 May 2023 15:17:46 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ae3f6e5d70so11755815ad.1
        for <stable@vger.kernel.org>; Fri, 26 May 2023 15:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685139465; x=1687731465;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TBhxVlqc2DxwlXVSJacDyw+LEynObPyhqE8HEMNBA1o=;
        b=1rsBk2aXKmrHslL0kJ5ewebZJbC7nBFxhwg1EETdqA3wjpw3Xqtnxv/YEWGyotbseh
         Ih2hvBKbKpL9ZLYEm60b6y2OIfk994aH9WRcH6KlRrGx6esG/RvmFoojStjEHCh6dA9T
         zNRJyxy6rM7mY5Vm+izwrbwNDgiQZlqeyzMlPo1Fints2S/YYuUza9I50FPaBmF4rN89
         2etX7IiuNtbEtDraqQuObawnPGYcoca+AB8MJ8OfljNucGer12rDx6AH0cRNPvmiUbjJ
         IUa/GOwdNZ8uhM2mkz2W1Nj9YznfPPz0SvYA1cvaAeC4rzM+LjmZnVuadfxDaE3KfYKi
         lJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685139465; x=1687731465;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TBhxVlqc2DxwlXVSJacDyw+LEynObPyhqE8HEMNBA1o=;
        b=VQ1oxN/a3rsxR+tqyrjciHItgt4MIoG6zBFU65aSNsbjXO/ychKvxCaHYWyUmVE4Q7
         dmy8+PES6JdQS10F53AT5S4TQHofB380OAomRF8+6QlQTwROJoVoVTmPAsaqucKxg6F8
         O2c4ghcihI6aWJbyuzfQD196SAsUhjEVnASQB2rVINi1CtlN5gjih5AveRWYnc9mW7At
         29z6RLd8aq8nT/zHJGEH46ZyPy8YhIIkmQY5pcY3csZRSgKe6uZwganX2fyxdy8Ttrz/
         nSgit1ClgkheV47zJxSBTi8aUKlsPbTjuN+0f7V52ofmh6A4PIV6uDv+RaMSo6CqseUQ
         KjYA==
X-Gm-Message-State: AC+VfDxlAmBQqCNDT1xjBcPQzKneklGA9tTlzFIrPVtreqQbcJg95nE4
        KLUlZkaK8GWPVRxtOAW6qcJeAOB+NpVadWNTnW8LzQ==
X-Google-Smtp-Source: ACHHUZ5r3HEUNfMQaSB5+7jU7QtilWTHW3cthCUCiegOrncsI4Xkpm5hXhokCpPTUPHGx+WNi8RXag==
X-Received: by 2002:a17:903:191:b0:1af:fd3a:2b4d with SMTP id z17-20020a170903019100b001affd3a2b4dmr4210178plg.58.1685139465003;
        Fri, 26 May 2023 15:17:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t9-20020a1709028c8900b001a980a23802sm3686270plo.111.2023.05.26.15.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 15:17:44 -0700 (PDT)
Message-ID: <64713008.170a0220.5eb40.8355@mx.google.com>
Date:   Fri, 26 May 2023 15:17:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.29-305-ga4121db79070f
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 157 runs,
 11 regressions (v6.1.29-305-ga4121db79070f)
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

stable-rc/queue/6.1 baseline: 157 runs, 11 regressions (v6.1.29-305-ga4121d=
b79070f)

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

kontron-pitx-imx8m           | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 2          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.29-305-ga4121db79070f/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.29-305-ga4121db79070f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      a4121db79070fec877658a066de0af8fca5eace8 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6470fb95636f6e21cd2e8651

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
5-ga4121db79070f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
5-ga4121db79070f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6470fb95636f6e21cd2e8656
        failing since 58 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-26T18:33:48.263424  <8>[    9.979186] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10471371_1.4.2.3.1>

    2023-05-26T18:33:48.267254  + set +x

    2023-05-26T18:33:48.368672  /#

    2023-05-26T18:33:48.469494   # #export SHELL=3D/bin/sh

    2023-05-26T18:33:48.469744  =


    2023-05-26T18:33:48.570322  / # export SHELL=3D/bin/sh. /lava-10471371/=
environment

    2023-05-26T18:33:48.570534  =


    2023-05-26T18:33:48.671049  / # . /lava-10471371/environment/lava-10471=
371/bin/lava-test-runner /lava-10471371/1

    2023-05-26T18:33:48.671387  =


    2023-05-26T18:33:48.676972  / # /lava-10471371/bin/lava-test-runner /la=
va-10471371/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6470fbcaaa55cdbd072e8643

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
5-ga4121db79070f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
5-ga4121db79070f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6470fbcaaa55cdbd072e8648
        failing since 58 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-26T18:34:25.591301  + <8>[    9.053199] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10471375_1.4.2.3.1>

    2023-05-26T18:34:25.591776  set +x

    2023-05-26T18:34:25.699406  / # #

    2023-05-26T18:34:25.801485  export SHELL=3D/bin/sh

    2023-05-26T18:34:25.801685  #

    2023-05-26T18:34:25.902281  / # export SHELL=3D/bin/sh. /lava-10471375/=
environment

    2023-05-26T18:34:25.902680  =


    2023-05-26T18:34:26.003636  / # . /lava-10471375/environment/lava-10471=
375/bin/lava-test-runner /lava-10471375/1

    2023-05-26T18:34:26.003981  =


    2023-05-26T18:34:26.008990  / # /lava-10471375/bin/lava-test-runner /la=
va-10471375/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6470fb94636f6e21cd2e8646

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
5-ga4121db79070f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
5-ga4121db79070f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6470fb94636f6e21cd2e864b
        failing since 58 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-26T18:33:39.612913  <8>[   10.344934] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10471384_1.4.2.3.1>

    2023-05-26T18:33:39.616291  + set +x

    2023-05-26T18:33:39.722276  =


    2023-05-26T18:33:39.824131  / # #export SHELL=3D/bin/sh

    2023-05-26T18:33:39.824791  =


    2023-05-26T18:33:39.925797  / # export SHELL=3D/bin/sh. /lava-10471384/=
environment

    2023-05-26T18:33:39.926293  =


    2023-05-26T18:33:40.027409  / # . /lava-10471384/environment/lava-10471=
384/bin/lava-test-runner /lava-10471384/1

    2023-05-26T18:33:40.028635  =


    2023-05-26T18:33:40.034380  / # /lava-10471384/bin/lava-test-runner /la=
va-10471384/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647100f731a2ab311f2e8638

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
5-ga4121db79070f/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
5-ga4121db79070f/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647100f731a2ab311f2e8=
639
        failing since 36 days (last pass: v6.1.22-477-g2128d4458cbc, first =
fail: v6.1.22-474-gecc61872327e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6471019ac7f3c6aa482e85f1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
5-ga4121db79070f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
5-ga4121db79070f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6471019ac7f3c6aa482e85f6
        failing since 59 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-26T18:59:22.504464  + set +x

    2023-05-26T18:59:22.511202  <8>[   11.090108] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10471344_1.4.2.3.1>

    2023-05-26T18:59:22.618953  / # #

    2023-05-26T18:59:22.720976  export SHELL=3D/bin/sh

    2023-05-26T18:59:22.722046  #

    2023-05-26T18:59:22.823378  / # export SHELL=3D/bin/sh. /lava-10471344/=
environment

    2023-05-26T18:59:22.824189  =


    2023-05-26T18:59:22.925492  / # . /lava-10471344/environment/lava-10471=
344/bin/lava-test-runner /lava-10471344/1

    2023-05-26T18:59:22.926710  =


    2023-05-26T18:59:22.931665  / # /lava-10471344/bin/lava-test-runner /la=
va-10471344/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647100839d3d1b488e2e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
5-ga4121db79070f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
5-ga4121db79070f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647100839d3d1b488e2e85eb
        failing since 59 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-26T18:54:39.509714  <8>[   10.744624] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10471365_1.4.2.3.1>

    2023-05-26T18:54:39.512539  + set +x

    2023-05-26T18:54:39.613719  #

    2023-05-26T18:54:39.613977  =


    2023-05-26T18:54:39.714577  / # #export SHELL=3D/bin/sh

    2023-05-26T18:54:39.714745  =


    2023-05-26T18:54:39.815265  / # export SHELL=3D/bin/sh. /lava-10471365/=
environment

    2023-05-26T18:54:39.815433  =


    2023-05-26T18:54:39.915920  / # . /lava-10471365/environment/lava-10471=
365/bin/lava-test-runner /lava-10471365/1

    2023-05-26T18:54:39.916283  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6470fb92636f6e21cd2e862d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
5-ga4121db79070f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
5-ga4121db79070f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6470fb92636f6e21cd2e8632
        failing since 58 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-26T18:33:38.251912  + set +x<8>[   10.893029] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10471340_1.4.2.3.1>

    2023-05-26T18:33:38.252338  =


    2023-05-26T18:33:38.359370  / # #

    2023-05-26T18:33:38.461729  export SHELL=3D/bin/sh

    2023-05-26T18:33:38.462460  #

    2023-05-26T18:33:38.563919  / # export SHELL=3D/bin/sh. /lava-10471340/=
environment

    2023-05-26T18:33:38.564676  =


    2023-05-26T18:33:38.666200  / # . /lava-10471340/environment/lava-10471=
340/bin/lava-test-runner /lava-10471340/1

    2023-05-26T18:33:38.667354  =


    2023-05-26T18:33:38.672120  / # /lava-10471340/bin/lava-test-runner /la=
va-10471340/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-pitx-imx8m           | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 2          =


  Details:     https://kernelci.org/test/plan/id/6470fdf38c21beee072e861b

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
5-ga4121db79070f/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-i=
mx8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
5-ga4121db79070f/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-i=
mx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6470fdf38c21beee072e861e
        new failure (last pass: v6.1.29-304-g13ee4424b4d8)

    2023-05-26T18:43:51.331488  / # #
    2023-05-26T18:43:51.434282  export SHELL=3D/bin/sh
    2023-05-26T18:43:51.435041  #
    2023-05-26T18:43:51.537066  / # export SHELL=3D/bin/sh. /lava-345007/en=
vironment
    2023-05-26T18:43:51.537842  =

    2023-05-26T18:43:51.639877  / # . /lava-345007/environment/lava-345007/=
bin/lava-test-runner /lava-345007/1
    2023-05-26T18:43:51.641102  =

    2023-05-26T18:43:51.657874  / # /lava-345007/bin/lava-test-runner /lava=
-345007/1
    2023-05-26T18:43:51.712941  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-26T18:43:51.713465  + cd /l<8>[   14.546501] <LAVA_SIGNAL_START=
RUN 1_bootrr 345007_1.5.2.4.5> =

    ... (10 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/647=
0fdf38c21beee072e862e
        new failure (last pass: v6.1.29-304-g13ee4424b4d8)

    2023-05-26T18:43:54.064373  /lava-345007/1/../bin/lava-test-case
    2023-05-26T18:43:54.064551  <8>[   16.994915] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>
    2023-05-26T18:43:54.064656  /lava-345007/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6470fb8ae02daacad72e864a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
5-ga4121db79070f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
5-ga4121db79070f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6470fb8ae02daacad72e864f
        failing since 58 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-26T18:33:32.935952  <8>[    9.777416] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10471367_1.4.2.3.1>

    2023-05-26T18:33:33.043634  / # #

    2023-05-26T18:33:33.146015  export SHELL=3D/bin/sh

    2023-05-26T18:33:33.146773  #

    2023-05-26T18:33:33.248174  / # export SHELL=3D/bin/sh. /lava-10471367/=
environment

    2023-05-26T18:33:33.249124  =


    2023-05-26T18:33:33.350858  / # . /lava-10471367/environment/lava-10471=
367/bin/lava-test-runner /lava-10471367/1

    2023-05-26T18:33:33.351927  =


    2023-05-26T18:33:33.357006  / # /lava-10471367/bin/lava-test-runner /la=
va-10471367/1

    2023-05-26T18:33:33.363771  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6470ff46dee97753e42e85f4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
5-ga4121db79070f/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-=
pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
5-ga4121db79070f/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-=
pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6470ff46dee97753e42e8=
5f5
        new failure (last pass: v6.1.29-304-g13ee4424b4d8) =

 =20
