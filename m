Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2966F645E
	for <lists+stable@lfdr.de>; Thu,  4 May 2023 07:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjEDF2K (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 4 May 2023 01:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEDF2K (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 4 May 2023 01:28:10 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED7919B3
        for <stable@vger.kernel.org>; Wed,  3 May 2023 22:28:07 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1aaff9c93a5so29421885ad.2
        for <stable@vger.kernel.org>; Wed, 03 May 2023 22:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683178087; x=1685770087;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JC5Ab6nZJBUbfc6e7xSjR9n8bVWy7ouo6HYiTYOks5I=;
        b=edRl1K4dPS5fYLiO2FnRQDAQvuqMsgF+6ZvIB4zBly0QZvmBcACtKlMsc7Xwjzqr2X
         VR7PvLN865nquj8R7Sq2RIRJKUKo9Lk0zlvmZIKRNa/VIRzgz8bo/QSR961Z5M1WSGUm
         RWma9LCtUNDjPxBYLGFLdf4tCpx+1NT4XN1hX21OCZmnVbcNx89sfJ1ifYdJudNgcSSp
         6bUzQ6/lc5vuzGsG74Wz7byurGg9D5V48S8vnYxJjDE47UEVcq58tILKURo24Z3a6MFY
         6XyP+S9/lke5T3ffXtII4UtN9o+1RQ1WT5p2tN+yf3aP9/7sw+PGZ+1iZggKcp+26Ej3
         6/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683178087; x=1685770087;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JC5Ab6nZJBUbfc6e7xSjR9n8bVWy7ouo6HYiTYOks5I=;
        b=Fyy1JqDxWAu74eJNyA9/Bq6CADzYSsqdQEbsZfeUaXo4PV5gS0BDlJNeLQI7u+dtcX
         YSFMSfgQiTd+KSHhpUxO5BHfEMcoPNyyXK62IAEHbqcds7ouciXcLN/3g5y/MyMp+mGE
         amXSvhMvJ/xm3hLpjIFvpMJo2m5hwQT7dOfRAw/6+oLr3oeGEwLRRghSQ7e7YnWs4TUu
         Cbaz2E/Xu8MMcJU5nvjopJiWZ7HQaIm1yQjOcSoHlASaw0fFeQR9fLlvDyLGqyI/pcLY
         sy4/h+PDRcnNDWXk3yJCL/IxopOsLPKnzRejr+rO/VvLrdZKarYVbppWhv3H6/riy1Ld
         Y27A==
X-Gm-Message-State: AC+VfDyL/uhfjQHHv6UIEbnfFPowlBqU541PCzLynHCVh/3FjpLIJNlB
        MAb8PgEpUWlJUNp/IvEkmzD1S6MO1WDelhGDGvf/hQ==
X-Google-Smtp-Source: ACHHUZ7addl8r7FmQRvtyl7fpQUk5fnwClSHf+sRQk3f6+3/Zf5hPttNGegF65qVPQQDHemnFuWk3Q==
X-Received: by 2002:a17:902:768c:b0:1a0:4913:61f3 with SMTP id m12-20020a170902768c00b001a0491361f3mr2399440pll.37.1683178086760;
        Wed, 03 May 2023 22:28:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y7-20020a170902864700b001a63b051b0csm22425901plt.282.2023.05.03.22.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 22:28:06 -0700 (PDT)
Message-ID: <64534266.170a0220.bf97c.daec@mx.google.com>
Date:   Wed, 03 May 2023 22:28:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.22-613-gc6f64e1fa083
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 163 runs,
 9 regressions (v6.1.22-613-gc6f64e1fa083)
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

stable-rc/queue/6.1 baseline: 163 runs, 9 regressions (v6.1.22-613-gc6f64e1=
fa083)

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

mt8192-asurada-spherion-r0   | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.22-613-gc6f64e1fa083/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.22-613-gc6f64e1fa083
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      c6f64e1fa0834cc2e6518775eeb7a387d4b9d153 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64530c900c5948387a2e8650

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-61=
3-gc6f64e1fa083/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-61=
3-gc6f64e1fa083/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64530c900c5948387a2e8655
        failing since 36 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-04T01:38:11.164693  <8>[   10.809380] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10190988_1.4.2.3.1>

    2023-05-04T01:38:11.168302  + set +x

    2023-05-04T01:38:11.272551  / # #

    2023-05-04T01:38:11.373165  export SHELL=3D/bin/sh

    2023-05-04T01:38:11.373379  #

    2023-05-04T01:38:11.473950  / # export SHELL=3D/bin/sh. /lava-10190988/=
environment

    2023-05-04T01:38:11.474150  =


    2023-05-04T01:38:11.574772  / # . /lava-10190988/environment/lava-10190=
988/bin/lava-test-runner /lava-10190988/1

    2023-05-04T01:38:11.575089  =


    2023-05-04T01:38:11.580791  / # /lava-10190988/bin/lava-test-runner /la=
va-10190988/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64530c9a3fc84b3d382e8642

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-61=
3-gc6f64e1fa083/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-61=
3-gc6f64e1fa083/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64530c9a3fc84b3d382e8647
        failing since 36 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-04T01:38:27.211210  + set<8>[   11.429016] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10191036_1.4.2.3.1>

    2023-05-04T01:38:27.211676   +x

    2023-05-04T01:38:27.318761  / # #

    2023-05-04T01:38:27.420922  export SHELL=3D/bin/sh

    2023-05-04T01:38:27.421627  #

    2023-05-04T01:38:27.523250  / # export SHELL=3D/bin/sh. /lava-10191036/=
environment

    2023-05-04T01:38:27.523983  =


    2023-05-04T01:38:27.625452  / # . /lava-10191036/environment/lava-10191=
036/bin/lava-test-runner /lava-10191036/1

    2023-05-04T01:38:27.626776  =


    2023-05-04T01:38:27.632103  / # /lava-10191036/bin/lava-test-runner /la=
va-10191036/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64530c8b0c5948387a2e8639

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-61=
3-gc6f64e1fa083/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-61=
3-gc6f64e1fa083/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64530c8b0c5948387a2e863e
        failing since 36 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-04T01:37:57.187715  <8>[   10.355563] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10191067_1.4.2.3.1>

    2023-05-04T01:37:57.190627  + set +x

    2023-05-04T01:37:57.292046  =


    2023-05-04T01:37:57.392634  / # #export SHELL=3D/bin/sh

    2023-05-04T01:37:57.392806  =


    2023-05-04T01:37:57.493320  / # export SHELL=3D/bin/sh. /lava-10191067/=
environment

    2023-05-04T01:37:57.493525  =


    2023-05-04T01:37:57.594076  / # . /lava-10191067/environment/lava-10191=
067/bin/lava-test-runner /lava-10191067/1

    2023-05-04T01:37:57.594402  =


    2023-05-04T01:37:57.599578  / # /lava-10191067/bin/lava-test-runner /la=
va-10191067/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64530a23ba5d3197af2e85ec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-61=
3-gc6f64e1fa083/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-61=
3-gc6f64e1fa083/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64530a23ba5d3197af2e8=
5ed
        failing since 13 days (last pass: v6.1.22-477-g2128d4458cbc, first =
fail: v6.1.22-474-gecc61872327e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64530c820c5948387a2e862b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-61=
3-gc6f64e1fa083/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-61=
3-gc6f64e1fa083/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64530c820c5948387a2e8630
        failing since 36 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-04T01:37:58.899292  + set +x

    2023-05-04T01:37:58.905913  <8>[   10.383801] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10191007_1.4.2.3.1>

    2023-05-04T01:37:59.010210  / # #

    2023-05-04T01:37:59.110810  export SHELL=3D/bin/sh

    2023-05-04T01:37:59.110999  #

    2023-05-04T01:37:59.211486  / # export SHELL=3D/bin/sh. /lava-10191007/=
environment

    2023-05-04T01:37:59.211710  =


    2023-05-04T01:37:59.312200  / # . /lava-10191007/environment/lava-10191=
007/bin/lava-test-runner /lava-10191007/1

    2023-05-04T01:37:59.312499  =


    2023-05-04T01:37:59.316713  / # /lava-10191007/bin/lava-test-runner /la=
va-10191007/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64530c7be6818c91092e8606

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-61=
3-gc6f64e1fa083/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-61=
3-gc6f64e1fa083/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64530c7be6818c91092e860b
        failing since 36 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-04T01:37:50.905754  <8>[   10.200179] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10190992_1.4.2.3.1>

    2023-05-04T01:37:50.909048  + set +x

    2023-05-04T01:37:51.013280  / # #

    2023-05-04T01:37:51.113863  export SHELL=3D/bin/sh

    2023-05-04T01:37:51.114121  #

    2023-05-04T01:37:51.214648  / # export SHELL=3D/bin/sh. /lava-10190992/=
environment

    2023-05-04T01:37:51.214846  =


    2023-05-04T01:37:51.315345  / # . /lava-10190992/environment/lava-10190=
992/bin/lava-test-runner /lava-10190992/1

    2023-05-04T01:37:51.315641  =


    2023-05-04T01:37:51.320636  / # /lava-10190992/bin/lava-test-runner /la=
va-10190992/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64530c973fc84b3d382e8615

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-61=
3-gc6f64e1fa083/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-61=
3-gc6f64e1fa083/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64530c973fc84b3d382e861a
        failing since 36 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-04T01:38:13.139623  + set<8>[   10.623509] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10191020_1.4.2.3.1>

    2023-05-04T01:38:13.139713   +x

    2023-05-04T01:38:13.244029  / # #

    2023-05-04T01:38:13.344667  export SHELL=3D/bin/sh

    2023-05-04T01:38:13.344867  #

    2023-05-04T01:38:13.445398  / # export SHELL=3D/bin/sh. /lava-10191020/=
environment

    2023-05-04T01:38:13.445600  =


    2023-05-04T01:38:13.546122  / # . /lava-10191020/environment/lava-10191=
020/bin/lava-test-runner /lava-10191020/1

    2023-05-04T01:38:13.546470  =


    2023-05-04T01:38:13.550988  / # /lava-10191020/bin/lava-test-runner /la=
va-10191020/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64530c859669f5cb872e860f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-61=
3-gc6f64e1fa083/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-61=
3-gc6f64e1fa083/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64530c859669f5cb872e8614
        failing since 36 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-04T01:38:01.608748  <8>[   12.659982] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10190993_1.4.2.3.1>

    2023-05-04T01:38:01.712845  / # #

    2023-05-04T01:38:01.813404  export SHELL=3D/bin/sh

    2023-05-04T01:38:01.813623  #

    2023-05-04T01:38:01.914129  / # export SHELL=3D/bin/sh. /lava-10190993/=
environment

    2023-05-04T01:38:01.914347  =


    2023-05-04T01:38:02.014857  / # . /lava-10190993/environment/lava-10190=
993/bin/lava-test-runner /lava-10190993/1

    2023-05-04T01:38:02.015138  =


    2023-05-04T01:38:02.019914  / # /lava-10190993/bin/lava-test-runner /la=
va-10190993/1

    2023-05-04T01:38:02.026419  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8192-asurada-spherion-r0   | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64530ed32648617eed2e8863

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-61=
3-gc6f64e1fa083/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8192-asurada-spherion-r0.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-61=
3-gc6f64e1fa083/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8192-asurada-spherion-r0.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64530ed32648617eed2e8=
864
        new failure (last pass: v6.1.22-609-gb309b971b2c8) =

 =20
