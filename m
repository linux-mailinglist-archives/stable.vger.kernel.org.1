Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0BB7C9C74
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 00:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjJOWft (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 15 Oct 2023 18:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJOWfs (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Oct 2023 18:35:48 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359A9AD
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 15:35:46 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-57bca5b9b0aso2110909eaf.3
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 15:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697409345; x=1698014145; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y/gmo6eMVER9UgDG9Ny4JkbK2EVGIQBlRqLBEPaQQDo=;
        b=PXGNxckXWlRiy9AKcPgGIwvqrGcXqtN0Tq3VZo6XjQUnIOv22sxI5vZMfaWP4MT8cL
         qfdkFA1RcVQ5IH8aKSVzfZ9dEI/fbhmQnbAqEfZAVmsct4T7h44cxm1dlNg/v5vsxnv0
         ttoPLeVdiVYHJhXiMvXNqst6cFYbSIeM3XkdnXGRCgp11mBmm43Qz9S3Pch1ElLh5CUI
         qblw8e7/MtZKhTBird3lcB0HL+vAVdvNUdWnrRdf27CvK/XvSRjDxnBkVcu6z9hzmpN0
         tamI/VlG8klX5tRwm48NuCyx/sKQFfDVEx8Y2meViya63a9vk2gmRCRY5egDwutFvZBM
         QUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697409345; x=1698014145;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y/gmo6eMVER9UgDG9Ny4JkbK2EVGIQBlRqLBEPaQQDo=;
        b=oHqL4ut4zvetFOaOqsobmHhgqxxBJB0p2mecYmMdE3DJfZioRQllDgL1kFl+ryr6Z8
         O7ayVKvRvAmyWXR33zaAJUEY3T6Oe0CucI2prJ0PwD0hKOb1OQGV2tqVan7Gyqs9Rk/E
         3el1sEjY0vLu44nUfZKU5CeSfO1FU/BqA4FxNbeiRO7+VuXS1xtxPnefJkGYjwVt7o4d
         vOAw6wcEHe7GyzLPS/nGD6+IbOVgAEztZ7Kf52dmCa3NqpeuaHppMXEjPc5PnY+T8itj
         WGJ2F21Uhz5H5yiLpfk83BK1WqFURT8V8F6HV2XqMsjizsIjgK8hLz2euzPxPO+oH9y2
         umvA==
X-Gm-Message-State: AOJu0YzgL/kQ+hk81C3zVL9ppC3jjdIsZ0hLIRDeo1r8hvx19kuHAwWi
        wTQ4cuiIt0u/En9a/NTYwvFb64NRdEnwzBFJ0WRAIw==
X-Google-Smtp-Source: AGHT+IHsCl4yl6H9PZBc8qvJFOcy95MnTK1vSqQ+vnqmHj5NMRBCrgErnF/xcrghbWmnZnv3b2R5dg==
X-Received: by 2002:a05:6358:7e49:b0:135:5ede:f352 with SMTP id p9-20020a0563587e4900b001355edef352mr38029874rwm.8.1697409344635;
        Sun, 15 Oct 2023 15:35:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s10-20020aa78d4a000000b0068be348e35fsm16807894pfe.166.2023.10.15.15.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 15:35:44 -0700 (PDT)
Message-ID: <652c6940.a70a0220.290b2.f9f4@mx.google.com>
Date:   Sun, 15 Oct 2023 15:35:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.58
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-6.1.y baseline: 166 runs, 9 regressions (v6.1.58)
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

stable-rc/linux-6.1.y baseline: 166 runs, 9 regressions (v6.1.58)

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

sun50i-h6-pine-h64           | arm64  | lab-clabbe    | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.58/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.58
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      adc4d740ad9ec780657327c69ab966fa4fdf0e8e =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652c34d5fffd1d0964efcef3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652c34d5fffd1d0964efcefc
        failing since 199 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-15T18:53:22.995690  <8>[   10.165946] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11782235_1.4.2.3.1>

    2023-10-15T18:53:22.999095  + set +x

    2023-10-15T18:53:23.103280  / # #

    2023-10-15T18:53:23.204014  export SHELL=3D/bin/sh

    2023-10-15T18:53:23.204238  #

    2023-10-15T18:53:23.304711  / # export SHELL=3D/bin/sh. /lava-11782235/=
environment

    2023-10-15T18:53:23.304946  =


    2023-10-15T18:53:23.405428  / # . /lava-11782235/environment/lava-11782=
235/bin/lava-test-runner /lava-11782235/1

    2023-10-15T18:53:23.405719  =


    2023-10-15T18:53:23.412134  / # /lava-11782235/bin/lava-test-runner /la=
va-11782235/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652c34ea2c2ecf2427efcef6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652c34ea2c2ecf2427efceff
        failing since 199 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-15T18:52:17.923248  + set<8>[   12.579421] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11782306_1.4.2.3.1>

    2023-10-15T18:52:17.923668   +x

    2023-10-15T18:52:18.030703  / # #

    2023-10-15T18:52:18.132886  export SHELL=3D/bin/sh

    2023-10-15T18:52:18.133647  #

    2023-10-15T18:52:18.235004  / # export SHELL=3D/bin/sh. /lava-11782306/=
environment

    2023-10-15T18:52:18.235748  =


    2023-10-15T18:52:18.337179  / # . /lava-11782306/environment/lava-11782=
306/bin/lava-test-runner /lava-11782306/1

    2023-10-15T18:52:18.338193  =


    2023-10-15T18:52:18.343715  / # /lava-11782306/bin/lava-test-runner /la=
va-11782306/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652c34db0328d152afefcf26

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652c34db0328d152afefcf2f
        failing since 199 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-15T18:52:00.276914  <8>[    7.747461] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11782293_1.4.2.3.1>

    2023-10-15T18:52:00.279961  + set +x

    2023-10-15T18:52:00.382087  =


    2023-10-15T18:52:00.482864  / # #export SHELL=3D/bin/sh

    2023-10-15T18:52:00.483059  =


    2023-10-15T18:52:00.583584  / # export SHELL=3D/bin/sh. /lava-11782293/=
environment

    2023-10-15T18:52:00.583773  =


    2023-10-15T18:52:00.684318  / # . /lava-11782293/environment/lava-11782=
293/bin/lava-test-runner /lava-11782293/1

    2023-10-15T18:52:00.684613  =


    2023-10-15T18:52:00.689590  / # /lava-11782293/bin/lava-test-runner /la=
va-11782293/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/652c38de5ea79d4a3befcf36

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652c38de5ea79d4a3befc=
f37
        failing since 129 days (last pass: v6.1.31-40-g7d0a9678d276, first =
fail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652c34b3d9aaa791a5efcf20

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652c34b3d9aaa791a5efcf29
        failing since 199 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-15T18:51:42.210540  + set +x

    2023-10-15T18:51:42.217254  <8>[    8.066527] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11782231_1.4.2.3.1>

    2023-10-15T18:51:42.321628  / # #

    2023-10-15T18:51:42.422239  export SHELL=3D/bin/sh

    2023-10-15T18:51:42.422420  #

    2023-10-15T18:51:42.522933  / # export SHELL=3D/bin/sh. /lava-11782231/=
environment

    2023-10-15T18:51:42.523114  =


    2023-10-15T18:51:42.623635  / # . /lava-11782231/environment/lava-11782=
231/bin/lava-test-runner /lava-11782231/1

    2023-10-15T18:51:42.623954  =


    2023-10-15T18:51:42.628715  / # /lava-11782231/bin/lava-test-runner /la=
va-11782231/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652c34d60328d152afefcef4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652c34d70328d152afefcefd
        failing since 199 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-15T18:51:44.899278  + set<8>[   11.561276] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11782236_1.4.2.3.1>

    2023-10-15T18:51:44.899364   +x

    2023-10-15T18:51:45.004024  / # #

    2023-10-15T18:51:45.104594  export SHELL=3D/bin/sh

    2023-10-15T18:51:45.104821  #

    2023-10-15T18:51:45.205370  / # export SHELL=3D/bin/sh. /lava-11782236/=
environment

    2023-10-15T18:51:45.205546  =


    2023-10-15T18:51:45.306058  / # . /lava-11782236/environment/lava-11782=
236/bin/lava-test-runner /lava-11782236/1

    2023-10-15T18:51:45.306310  =


    2023-10-15T18:51:45.311106  / # /lava-11782236/bin/lava-test-runner /la=
va-11782236/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652c34d2c9e014c25defcf39

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652c34d2c9e014c25defcf42
        failing since 199 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-15T18:51:45.207920  <8>[   12.917180] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11782291_1.4.2.3.1>

    2023-10-15T18:51:45.312652  / # #

    2023-10-15T18:51:45.413377  export SHELL=3D/bin/sh

    2023-10-15T18:51:45.413608  #

    2023-10-15T18:51:45.514149  / # export SHELL=3D/bin/sh. /lava-11782291/=
environment

    2023-10-15T18:51:45.514384  =


    2023-10-15T18:51:45.614963  / # . /lava-11782291/environment/lava-11782=
291/bin/lava-test-runner /lava-11782291/1

    2023-10-15T18:51:45.615321  =


    2023-10-15T18:51:45.619808  / # /lava-11782291/bin/lava-test-runner /la=
va-11782291/1

    2023-10-15T18:51:45.626901  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-clabbe    | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/652c36d1e6eaa623deefd09e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58/=
arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58/=
arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652c36d1e6eaa623deefd0a7
        failing since 4 days (last pass: v6.1.22-178-gf8a7fa4a96bb, first f=
ail: v6.1.57)

    2023-10-15T19:00:17.801721  / # #
    2023-10-15T19:00:17.903751  export SHELL=3D/bin/sh
    2023-10-15T19:00:17.904398  #
    2023-10-15T19:00:18.005412  / # export SHELL=3D/bin/sh. /lava-438696/en=
vironment
    2023-10-15T19:00:18.006046  =

    2023-10-15T19:00:18.107107  / # . /lava-438696/environment/lava-438696/=
bin/lava-test-runner /lava-438696/1
    2023-10-15T19:00:18.108314  =

    2023-10-15T19:00:18.125618  / # /lava-438696/bin/lava-test-runner /lava=
-438696/1
    2023-10-15T19:00:18.189649  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-15T19:00:18.190278  + cd /lava-438696/<8>[   18.591002] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 438696_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/652c36dd8f11898b23efd1ab

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652c36dd8f11898b23efd1b4
        failing since 4 days (last pass: v6.1.22-178-gf8a7fa4a96bb, first f=
ail: v6.1.57)

    2023-10-15T19:04:42.619419  / # #

    2023-10-15T19:04:42.721771  export SHELL=3D/bin/sh

    2023-10-15T19:04:42.722538  #

    2023-10-15T19:04:42.823983  / # export SHELL=3D/bin/sh. /lava-11782349/=
environment

    2023-10-15T19:04:42.824756  =


    2023-10-15T19:04:42.926159  / # . /lava-11782349/environment/lava-11782=
349/bin/lava-test-runner /lava-11782349/1

    2023-10-15T19:04:42.927347  =


    2023-10-15T19:04:42.944289  / # /lava-11782349/bin/lava-test-runner /la=
va-11782349/1

    2023-10-15T19:04:43.011387  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-15T19:04:43.011929  + cd /lava-11782349/1/tests/1_boot<8>[   17=
.052937] <LAVA_SIGNAL_STARTRUN 1_bootrr 11782349_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
