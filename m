Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB85714161
	for <lists+stable@lfdr.de>; Mon, 29 May 2023 02:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjE2AVq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 20:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjE2AVp (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 20:21:45 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFC9C7
        for <stable@vger.kernel.org>; Sun, 28 May 2023 17:21:42 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64d3e5e5980so3280265b3a.2
        for <stable@vger.kernel.org>; Sun, 28 May 2023 17:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685319701; x=1687911701;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8XN9RYr2BHLPOKCyniuFXcXjtcVhywyKdB6xXVnvPH8=;
        b=FWxjvnLDLWdD1CSN3HiCzOGkAnuYTX0cFtD09N5v0+0ekqfCQW9uP441viuw3JYfkh
         5I7nYi5FFrR89YSqSCpWQF4QTHDuz6WPWQDu3kHZtTUB0xi9f6QNnZYL2NRACKmYYBy+
         7ai4EgmDRAaPKbfoiRJx0vlsqYyrds1vgwPImRQo9lxxJfCFFiQK5JvuC8fwVS2YNr1W
         byGnwm/4i6ZjDnz9nY3viPU37GLfUUYzG2cfd+zhDxZ3CbdSJQYnnvy+mF6MBKU+d/qO
         sZ1HXXq9+jo2lb+3fpwLNymmQit2+Am49G+R23Sj61FjfsSAu5Z82gVd92kvkJ5X0O19
         3l5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685319701; x=1687911701;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8XN9RYr2BHLPOKCyniuFXcXjtcVhywyKdB6xXVnvPH8=;
        b=AG16ZVSHzrcnj/od03Np4NOWi6h7DS9GqcOzm5cMfmqsCiZPLPfyRbbTu7RB/Wr+gJ
         kEIuIKGoan7QoEYvNBcXLcCcizLVsf+/7NcU3NsKIsvSuHMAnL6auajfhhefHES8asUA
         kWV0XFBvcjJSJp6ZbJmgWwK05WRWl5uBnz0o2ciIF/C3scvl6TQfZom98hccoeuAvAlJ
         Jju0F3VH+e6eJ/4A28b+Vq8kQdaqo+tU8IYOt/DmqScyEgjkUNwq2lGriPEZVuv+2mzI
         2EQFysbmPmCAG9F+Lb/qWmFm+sFewLec6bHPUVVvhDnEoH94z2McrkK+vctIJDzOzkRq
         Kz8g==
X-Gm-Message-State: AC+VfDxib9Ac3rykKkZBFj8g+f4WebEfnWv+ad4rlYAY7PgoIsZfG4g7
        bOnWzEyHRwOlgGopPnpQO0hJrnGJNO54WXZwLGNoXg==
X-Google-Smtp-Source: ACHHUZ4qB3nWSFNjcbQJOc5sHtyDSgvk7nAk0nbBLOUphD33qJpVAtUTX/Mj7pniuelefowlXzRlkw==
X-Received: by 2002:a05:6a20:441f:b0:109:2f11:8b77 with SMTP id ce31-20020a056a20441f00b001092f118b77mr8426902pzb.1.1685319700873;
        Sun, 28 May 2023 17:21:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n16-20020aa79050000000b0064f3bde4981sm5672322pfo.34.2023.05.28.17.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 17:21:40 -0700 (PDT)
Message-ID: <6473f014.a70a0220.79f6b.b1ca@mx.google.com>
Date:   Sun, 28 May 2023 17:21:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.29-412-g59962e745c3c
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 134 runs,
 8 regressions (v6.1.29-412-g59962e745c3c)
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

stable-rc/queue/6.1 baseline: 134 runs, 8 regressions (v6.1.29-412-g59962e7=
45c3c)

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
el/v6.1.29-412-g59962e745c3c/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.29-412-g59962e745c3c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      59962e745c3c63728c5669e01bba09e07a4f58aa =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473bb0479f9b39d462e85f5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-41=
2-g59962e745c3c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-41=
2-g59962e745c3c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473bb0479f9b39d462e85fa
        failing since 61 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-28T20:34:59.555190  <8>[   10.899775] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10498453_1.4.2.3.1>

    2023-05-28T20:34:59.558484  + set +x

    2023-05-28T20:34:59.664074  =


    2023-05-28T20:34:59.765827  / # #export SHELL=3D/bin/sh

    2023-05-28T20:34:59.766553  =


    2023-05-28T20:34:59.867842  / # export SHELL=3D/bin/sh. /lava-10498453/=
environment

    2023-05-28T20:34:59.868521  =


    2023-05-28T20:34:59.970032  / # . /lava-10498453/environment/lava-10498=
453/bin/lava-test-runner /lava-10498453/1

    2023-05-28T20:34:59.971286  =


    2023-05-28T20:34:59.977001  / # /lava-10498453/bin/lava-test-runner /la=
va-10498453/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473bafdb8acf1ad8b2e8629

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-41=
2-g59962e745c3c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-41=
2-g59962e745c3c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473bafdb8acf1ad8b2e862e
        failing since 61 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-28T20:34:50.341892  + set<8>[   11.622017] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10498445_1.4.2.3.1>

    2023-05-28T20:34:50.342517   +x

    2023-05-28T20:34:50.451325  / # #

    2023-05-28T20:34:50.553717  export SHELL=3D/bin/sh

    2023-05-28T20:34:50.554450  #

    2023-05-28T20:34:50.655887  / # export SHELL=3D/bin/sh. /lava-10498445/=
environment

    2023-05-28T20:34:50.656528  =


    2023-05-28T20:34:50.757893  / # . /lava-10498445/environment/lava-10498=
445/bin/lava-test-runner /lava-10498445/1

    2023-05-28T20:34:50.758938  =


    2023-05-28T20:34:50.764150  / # /lava-10498445/bin/lava-test-runner /la=
va-10498445/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473bb02b27d66306f2e8602

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-41=
2-g59962e745c3c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-41=
2-g59962e745c3c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473bb02b27d66306f2e8607
        failing since 61 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-28T20:34:54.165883  <8>[   10.644166] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10498506_1.4.2.3.1>

    2023-05-28T20:34:54.169188  + set +x

    2023-05-28T20:34:54.273520  =


    2023-05-28T20:34:54.375365  / # #export SHELL=3D/bin/sh

    2023-05-28T20:34:54.376048  =


    2023-05-28T20:34:54.477394  / # export SHELL=3D/bin/sh. /lava-10498506/=
environment

    2023-05-28T20:34:54.478029  =


    2023-05-28T20:34:54.579317  / # . /lava-10498506/environment/lava-10498=
506/bin/lava-test-runner /lava-10498506/1

    2023-05-28T20:34:54.580527  =


    2023-05-28T20:34:54.586191  / # /lava-10498506/bin/lava-test-runner /la=
va-10498506/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6473bea7619166ac652e85fc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-41=
2-g59962e745c3c/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-41=
2-g59962e745c3c/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6473bea7619166ac652e8=
5fd
        failing since 38 days (last pass: v6.1.22-477-g2128d4458cbc, first =
fail: v6.1.22-474-gecc61872327e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473baf0cddb82416b2e862d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-41=
2-g59962e745c3c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-41=
2-g59962e745c3c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473baf0cddb82416b2e8632
        failing since 61 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-28T20:34:45.300932  + set +x

    2023-05-28T20:34:45.307141  <8>[   11.880606] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10498504_1.4.2.3.1>

    2023-05-28T20:34:45.411974  / # #

    2023-05-28T20:34:45.512581  export SHELL=3D/bin/sh

    2023-05-28T20:34:45.512757  #

    2023-05-28T20:34:45.613296  / # export SHELL=3D/bin/sh. /lava-10498504/=
environment

    2023-05-28T20:34:45.613484  =


    2023-05-28T20:34:45.714022  / # . /lava-10498504/environment/lava-10498=
504/bin/lava-test-runner /lava-10498504/1

    2023-05-28T20:34:45.714268  =


    2023-05-28T20:34:45.718650  / # /lava-10498504/bin/lava-test-runner /la=
va-10498504/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473bae9b8acf1ad8b2e85f9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-41=
2-g59962e745c3c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-41=
2-g59962e745c3c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473bae9b8acf1ad8b2e85fe
        failing since 61 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-28T20:34:36.154006  + set<8>[   10.201080] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10498486_1.4.2.3.1>

    2023-05-28T20:34:36.154448   +x

    2023-05-28T20:34:36.261128  /#

    2023-05-28T20:34:36.363320   # #export SHELL=3D/bin/sh

    2023-05-28T20:34:36.363490  =


    2023-05-28T20:34:36.464047  / # export SHELL=3D/bin/sh. /lava-10498486/=
environment

    2023-05-28T20:34:36.464724  =


    2023-05-28T20:34:36.566082  / # . /lava-10498486/environment/lava-10498=
486/bin/lava-test-runner /lava-10498486/1

    2023-05-28T20:34:36.567364  =


    2023-05-28T20:34:36.572822  / # /lava-10498486/bin/lava-test-runner /la=
va-10498486/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473bafc462869aba62e8619

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-41=
2-g59962e745c3c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-41=
2-g59962e745c3c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473bafc462869aba62e861e
        failing since 61 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-28T20:34:53.790978  + <8>[   11.647751] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10498489_1.4.2.3.1>

    2023-05-28T20:34:53.791611  set +x

    2023-05-28T20:34:53.899398  / # #

    2023-05-28T20:34:54.001956  export SHELL=3D/bin/sh

    2023-05-28T20:34:54.002765  #

    2023-05-28T20:34:54.104399  / # export SHELL=3D/bin/sh. /lava-10498489/=
environment

    2023-05-28T20:34:54.105235  =


    2023-05-28T20:34:54.206894  / # . /lava-10498489/environment/lava-10498=
489/bin/lava-test-runner /lava-10498489/1

    2023-05-28T20:34:54.208190  =


    2023-05-28T20:34:54.213189  / # /lava-10498489/bin/lava-test-runner /la=
va-10498489/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473baff79f9b39d462e85e7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-41=
2-g59962e745c3c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-41=
2-g59962e745c3c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473baff79f9b39d462e85ec
        failing since 61 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-28T20:34:49.992653  <8>[   12.254298] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10498470_1.4.2.3.1>

    2023-05-28T20:34:50.096803  / # #

    2023-05-28T20:34:50.197359  export SHELL=3D/bin/sh

    2023-05-28T20:34:50.197593  #

    2023-05-28T20:34:50.298067  / # export SHELL=3D/bin/sh. /lava-10498470/=
environment

    2023-05-28T20:34:50.298296  =


    2023-05-28T20:34:50.398809  / # . /lava-10498470/environment/lava-10498=
470/bin/lava-test-runner /lava-10498470/1

    2023-05-28T20:34:50.399289  =


    2023-05-28T20:34:50.403504  / # /lava-10498470/bin/lava-test-runner /la=
va-10498470/1

    2023-05-28T20:34:50.410001  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =20
