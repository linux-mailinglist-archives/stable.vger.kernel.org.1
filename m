Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71ECB78AF7A
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 14:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjH1MFG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 08:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjH1MEh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 08:04:37 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9A011A
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 05:04:33 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c06f6f98c0so24161525ad.3
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 05:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693224273; x=1693829073;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7iPtOACbta7iMaxscQ3Q7SREXs4ohM1gI0CaXJwmquc=;
        b=C4eB3poqXOoYUKjfOCAfnG4HQXueTiNh28ZfqCG6emjXkV+dQOs2ouMzLr+IL/i1Ee
         6Mj9OqfLkbrZzmLmjJHpMWSrXZV6/YuxDATU+RXz1SN6QkeZXjoIo5Y2ePT9eX+loTsB
         SMUPBU3Dzr4RNnMFxI3ivmGczP4l3XDTENLw9O+fM22WKKA5ipLgHYqGPR3uyk1GfkP5
         1YtPZY9VrBc6bmXnjAVrfUwYwtJ8OeuypbhtptBOCwwWQ1oecBWlaDxmL3x/bDoVV4HA
         pDoXtoUR8BYT7REZAK2YgNs1bfdEeZ+Kau75BWwa0+ucQFFoErl5eOfuSMwRD6KPvmC/
         rJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693224273; x=1693829073;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7iPtOACbta7iMaxscQ3Q7SREXs4ohM1gI0CaXJwmquc=;
        b=Dwiagv/OJj2cd9kr2wZrkz7AWD/w3Z4TsJG8J5lF4F3iV97ZxqTlNbchOKuojiw8Iu
         bVFzaYLMy1wOuW+yrCQz8KxtR0ZylNpXzd8/aSKbSxQTFvzSP3a7u93s70cClYh9GBph
         9WRvKuhhjrf/VW7AKSoztK7py30l1K6hDUUk0fON9QvPeZINDqaxty/roWzNW+osx4Ml
         Y+0lz/l6RefFn72DrJyeXNCsXSANEJe1G8NDcTdHHkXn8WLh062LsRqj1mAyTIpmno1z
         Eb39a+DlPI5xVQftgqkjH3OT5mMpt8ilouZRBxPQqEuh3fdR+8VmEy881+qS1u4KoH/g
         0kdQ==
X-Gm-Message-State: AOJu0YwBjHvaBdvLKHi+qpskWPWK0iCv+cH1ma7uACFHML3SGlmaxoLm
        ZkymBp1EQEV84zN+QvXVRvYFiZ0Mmyez69fwzu4=
X-Google-Smtp-Source: AGHT+IFEdcI8JCWWW6F6Btcs0VZs285C1dxceQ9KsaDe85maoiXBHpmo98mZyBGA+NK+cIvRFx79Aw==
X-Received: by 2002:a17:902:ce81:b0:1bc:9bb3:1d83 with SMTP id f1-20020a170902ce8100b001bc9bb31d83mr33953005plg.33.1693224272604;
        Mon, 28 Aug 2023 05:04:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f5-20020a170902ce8500b001b04c2023e3sm7180014plg.218.2023.08.28.05.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 05:04:32 -0700 (PDT)
Message-ID: <64ec8d50.170a0220.f6065.ae78@mx.google.com>
Date:   Mon, 28 Aug 2023 05:04:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.48-128-g360b24c05a932
Subject: stable-rc/linux-6.1.y baseline: 121 runs,
 9 regressions (v6.1.48-128-g360b24c05a932)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.1.y baseline: 121 runs, 9 regressions (v6.1.48-128-g360b2=
4c05a932)

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

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.48-128-g360b24c05a932/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.48-128-g360b24c05a932
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      360b24c05a9322e4e5536a9531bd38702f48dccc =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec58b359c941d368286dbe

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g360b24c05a932/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g360b24c05a932/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec58b359c941d368286dc3
        failing since 150 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-28T08:19:59.465347  + set +x

    2023-08-28T08:19:59.471710  <8>[   10.396045] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11370531_1.4.2.3.1>

    2023-08-28T08:19:59.573815  #

    2023-08-28T08:19:59.574143  =


    2023-08-28T08:19:59.674759  / # #export SHELL=3D/bin/sh

    2023-08-28T08:19:59.674946  =


    2023-08-28T08:19:59.775470  / # export SHELL=3D/bin/sh. /lava-11370531/=
environment

    2023-08-28T08:19:59.775692  =


    2023-08-28T08:19:59.876249  / # . /lava-11370531/environment/lava-11370=
531/bin/lava-test-runner /lava-11370531/1

    2023-08-28T08:19:59.876594  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec58c019036cac0e286d84

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g360b24c05a932/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g360b24c05a932/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec58c019036cac0e286d8d
        failing since 150 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-28T08:20:00.779011  + set<8>[    8.953585] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11370529_1.4.2.3.1>

    2023-08-28T08:20:00.779124   +x

    2023-08-28T08:20:00.883590  / # #

    2023-08-28T08:20:00.984191  export SHELL=3D/bin/sh

    2023-08-28T08:20:00.984480  #

    2023-08-28T08:20:01.085134  / # export SHELL=3D/bin/sh. /lava-11370529/=
environment

    2023-08-28T08:20:01.085333  =


    2023-08-28T08:20:01.185851  / # . /lava-11370529/environment/lava-11370=
529/bin/lava-test-runner /lava-11370529/1

    2023-08-28T08:20:01.186152  =


    2023-08-28T08:20:01.190871  / # /lava-11370529/bin/lava-test-runner /la=
va-11370529/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec58b059c941d368286da8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g360b24c05a932/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g360b24c05a932/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec58b059c941d368286db1
        failing since 150 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-28T08:19:45.735052  <8>[   10.519166] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11370539_1.4.2.3.1>

    2023-08-28T08:19:45.738404  + set +x

    2023-08-28T08:19:45.843003  / ##

    2023-08-28T08:19:45.945413  export SHELL=3D/bin/sh

    2023-08-28T08:19:45.946249   #

    2023-08-28T08:19:46.048001  / # export SHELL=3D/bin/sh. /lava-11370539/=
environment

    2023-08-28T08:19:46.048773  =


    2023-08-28T08:19:46.150378  / # . /lava-11370539/environment/lava-11370=
539/bin/lava-test-runner /lava-11370539/1

    2023-08-28T08:19:46.151693  =


    2023-08-28T08:19:46.156761  / # /lava-11370539/bin/lava-test-runner /la=
va-11370539/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec5e1a0603f1785b286d82

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g360b24c05a932/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g360b24c05a932/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ec5e1a0603f1785b286=
d83
        failing since 81 days (last pass: v6.1.31-40-g7d0a9678d276, first f=
ail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec589d7185db1f13286ddb

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g360b24c05a932/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g360b24c05a932/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec589d7185db1f13286de4
        failing since 150 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-28T08:19:46.030821  + set +x

    2023-08-28T08:19:46.037544  <8>[   10.297806] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11370503_1.4.2.3.1>

    2023-08-28T08:19:46.141860  / # #

    2023-08-28T08:19:46.242496  export SHELL=3D/bin/sh

    2023-08-28T08:19:46.242716  #

    2023-08-28T08:19:46.343289  / # export SHELL=3D/bin/sh. /lava-11370503/=
environment

    2023-08-28T08:19:46.343491  =


    2023-08-28T08:19:46.444053  / # . /lava-11370503/environment/lava-11370=
503/bin/lava-test-runner /lava-11370503/1

    2023-08-28T08:19:46.444361  =


    2023-08-28T08:19:46.449045  / # /lava-11370503/bin/lava-test-runner /la=
va-11370503/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec58b259c941d368286db3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g360b24c05a932/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g360b24c05a932/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec58b259c941d368286dbc
        failing since 150 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-28T08:19:57.663101  + <8>[   10.914702] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11370500_1.4.2.3.1>

    2023-08-28T08:19:57.663192  set +x

    2023-08-28T08:19:57.767556  / # #

    2023-08-28T08:19:57.868190  export SHELL=3D/bin/sh

    2023-08-28T08:19:57.868375  #

    2023-08-28T08:19:57.968866  / # export SHELL=3D/bin/sh. /lava-11370500/=
environment

    2023-08-28T08:19:57.969074  =


    2023-08-28T08:19:58.069653  / # . /lava-11370500/environment/lava-11370=
500/bin/lava-test-runner /lava-11370500/1

    2023-08-28T08:19:58.069917  =


    2023-08-28T08:19:58.074589  / # /lava-11370500/bin/lava-test-runner /la=
va-11370500/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec58a659c941d368286d7b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g360b24c05a932/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g360b24c05a932/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec58a659c941d368286d84
        failing since 150 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-28T08:19:39.260524  + <8>[   11.682430] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11370536_1.4.2.3.1>

    2023-08-28T08:19:39.261212  set +x

    2023-08-28T08:19:39.369651  / # #

    2023-08-28T08:19:39.472167  export SHELL=3D/bin/sh

    2023-08-28T08:19:39.473050  #

    2023-08-28T08:19:39.574737  / # export SHELL=3D/bin/sh. /lava-11370536/=
environment

    2023-08-28T08:19:39.575560  =


    2023-08-28T08:19:39.677316  / # . /lava-11370536/environment/lava-11370=
536/bin/lava-test-runner /lava-11370536/1

    2023-08-28T08:19:39.678602  =


    2023-08-28T08:19:39.684304  / # /lava-11370536/bin/lava-test-runner /la=
va-11370536/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec59283a57b906be286d8a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g360b24c05a932/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g360b24c05a932/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec59283a57b906be286d93
        failing since 41 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-28T08:22:52.297224  / # #

    2023-08-28T08:22:53.375785  export SHELL=3D/bin/sh

    2023-08-28T08:22:53.377602  #

    2023-08-28T08:22:54.865944  / # export SHELL=3D/bin/sh. /lava-11370547/=
environment

    2023-08-28T08:22:54.867725  =


    2023-08-28T08:22:57.587869  / # . /lava-11370547/environment/lava-11370=
547/bin/lava-test-runner /lava-11370547/1

    2023-08-28T08:22:57.589954  =


    2023-08-28T08:22:57.603955  / # /lava-11370547/bin/lava-test-runner /la=
va-11370547/1

    2023-08-28T08:22:57.657969  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-28T08:22:57.658438  + cd /lava-113705<8>[   28.491755] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11370547_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec590730afc0b2f4286e15

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g360b24c05a932/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g360b24c05a932/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec590730afc0b2f4286e1e
        failing since 41 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-28T08:22:58.595682  / # #

    2023-08-28T08:22:58.697601  export SHELL=3D/bin/sh

    2023-08-28T08:22:58.698295  #

    2023-08-28T08:22:58.799679  / # export SHELL=3D/bin/sh. /lava-11370558/=
environment

    2023-08-28T08:22:58.800405  =


    2023-08-28T08:22:58.901883  / # . /lava-11370558/environment/lava-11370=
558/bin/lava-test-runner /lava-11370558/1

    2023-08-28T08:22:58.902999  =


    2023-08-28T08:22:58.945405  / # /lava-11370558/bin/lava-test-runner /la=
va-11370558/1

    2023-08-28T08:22:58.945906  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-28T08:22:58.984103  + cd /lava-1137055<8>[   18.746205] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11370558_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
