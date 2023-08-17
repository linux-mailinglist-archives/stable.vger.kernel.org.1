Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF2977EEDE
	for <lists+stable@lfdr.de>; Thu, 17 Aug 2023 03:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347455AbjHQB4G (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 16 Aug 2023 21:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347416AbjHQBzt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 16 Aug 2023 21:55:49 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70831270A
        for <stable@vger.kernel.org>; Wed, 16 Aug 2023 18:55:46 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5657add1073so318635a12.0
        for <stable@vger.kernel.org>; Wed, 16 Aug 2023 18:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692237345; x=1692842145;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XpwD/vJzG/uyyS8MrIukQaF+h4omf9ojpGcLsNZtE1E=;
        b=ejeVg9x3lQ+hjPqb9YqGbO1hw3g/y0TX7npj5z4txTqsxXEswalQqdOJtA0JAwbkRL
         MClM2UZdOL9Wdx2kn9y5XICDATNonmSsUsT/fyJyHafp8S9DUNWGFIjdm8afCjyCnj8B
         K3K8t7M/3UvAYP6vegbO1DRqM2hbA0wJkSapt1qIZoaO5jIJz1EZ8EVQSEQZek7swJAm
         6Wr2Gi935z7FUN8qOZWSQ7uv/kiS81A4gwxS6uONdYGhsOBGwoIrWzpsH3Wf1BrFHHpN
         otDwWUULXi5D1bwK9T/5jFLjKPL74fZNsLoWuPOhlwEUga9aAdbJLuxfxBcIrtrCvcpv
         eU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692237345; x=1692842145;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XpwD/vJzG/uyyS8MrIukQaF+h4omf9ojpGcLsNZtE1E=;
        b=W+L6akrghH4PP4eFh6pP1Z8INpkvKetP8MIljHpZSMLAIwG+5JTzHeefObIbaPk9Ci
         b5VGWU6Lp4TqygMGCZeWda3UOdjUFchjnaH0TwWLX5JaoILD2FiAO0WG5TY8uvuGmkqo
         d4wubTH+tVMUiMuLgAEz+V15WFnquQZRqp1x/cfE4Cw39vcF2mggtyo4WOiTGQP620hn
         C0KepMkc8i5z30SDex0jqbUl+ONza6/GJhLsmdzA2wF3pb5A3ZSh2mSaGACbks6iVYJx
         7Av0PYe3bGBQaoADmeznXIQpZ26C0K4FmLCkFhGQ2rYEB+pascq6argUYggFZfubulYl
         7HGg==
X-Gm-Message-State: AOJu0YzjQkCy68M4kEDKU2CN8mEz90YM9thMshbtzAc1SF7rHlg6qIHO
        2XEYUDqCG6pZqUQfpZ8+GhKkolcl3CiobHrl4PeEew==
X-Google-Smtp-Source: AGHT+IFt/rZQhAVQGluZ7sjqSzPHlFm2bMZemTpi4veRPh1wlxno1X2iN1dqKDedtt+eNMHxdNV8kA==
X-Received: by 2002:a17:90b:1205:b0:268:f8c8:bd5c with SMTP id gl5-20020a17090b120500b00268f8c8bd5cmr1621109pjb.17.1692237345286;
        Wed, 16 Aug 2023 18:55:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x14-20020a17090a6b4e00b00268320ab9f2sm54248pjl.6.2023.08.16.18.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 18:55:44 -0700 (PDT)
Message-ID: <64dd7e20.170a0220.d9d4c.01dc@mx.google.com>
Date:   Wed, 16 Aug 2023 18:55:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.46
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-6.1.y
Subject: stable-rc/linux-6.1.y baseline: 115 runs, 11 regressions (v6.1.46)
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

stable-rc/linux-6.1.y baseline: 115 runs, 11 regressions (v6.1.46)

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

at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.46/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.46
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      6c44e13dc284f7f4db17706ca48fd016d6b3d49a =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd4b781c490e3bd135b25b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-c=
hromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-c=
hromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd4b781c490e3bd135b=
25c
        failing since 2 days (last pass: v6.1.45-128-ge73191cf0a0b2, first =
fail: v6.1.45-150-gdbb92b2240ba) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd4b34f9137d2f8b35b27d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd4b34f9137d2f8b35b282
        failing since 139 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-16T22:19:20.656377  + set +x

    2023-08-16T22:19:20.663350  <8>[   10.375153] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11303639_1.4.2.3.1>

    2023-08-16T22:19:20.771519  =


    2023-08-16T22:19:20.873468  / # #export SHELL=3D/bin/sh

    2023-08-16T22:19:20.874263  =


    2023-08-16T22:19:20.975957  / # export SHELL=3D/bin/sh. /lava-11303639/=
environment

    2023-08-16T22:19:20.976774  =


    2023-08-16T22:19:21.078295  / # . /lava-11303639/environment/lava-11303=
639/bin/lava-test-runner /lava-11303639/1

    2023-08-16T22:19:21.079406  =


    2023-08-16T22:19:21.085608  / # /lava-11303639/bin/lava-test-runner /la=
va-11303639/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd4b3af9137d2f8b35b293

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd4b3af9137d2f8b35b298
        failing since 139 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-16T22:18:28.439617  + <8>[   12.071001] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11303647_1.4.2.3.1>

    2023-08-16T22:18:28.439743  set +x

    2023-08-16T22:18:28.543865  / # #

    2023-08-16T22:18:28.644389  export SHELL=3D/bin/sh

    2023-08-16T22:18:28.644624  #

    2023-08-16T22:18:28.745188  / # export SHELL=3D/bin/sh. /lava-11303647/=
environment

    2023-08-16T22:18:28.745414  =


    2023-08-16T22:18:28.846024  / # . /lava-11303647/environment/lava-11303=
647/bin/lava-test-runner /lava-11303647/1

    2023-08-16T22:18:28.846288  =


    2023-08-16T22:18:28.850841  / # /lava-11303647/bin/lava-test-runner /la=
va-11303647/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd4bb4b77cdcbb2b35b1df

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd4bb4b77cdcbb2b35b1e4
        failing since 139 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-16T22:20:13.596079  <8>[   10.397619] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11303652_1.4.2.3.1>

    2023-08-16T22:20:13.599362  + set +x

    2023-08-16T22:20:13.704433  #

    2023-08-16T22:20:13.705650  =


    2023-08-16T22:20:13.807364  / # #export SHELL=3D/bin/sh

    2023-08-16T22:20:13.808183  =


    2023-08-16T22:20:13.909674  / # export SHELL=3D/bin/sh. /lava-11303652/=
environment

    2023-08-16T22:20:13.910780  =


    2023-08-16T22:20:14.012576  / # . /lava-11303652/environment/lava-11303=
652/bin/lava-test-runner /lava-11303652/1

    2023-08-16T22:20:14.013691  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd4d31abd85fe1b135b24a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-sama5d4_xplained.t=
xt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-sama5d4_xplained.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd4d31abd85fe1b135b=
24b
        new failure (last pass: v6.1.45-150-gdbb92b2240ba) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd4f89c389d6c7f335b269

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd4f89c389d6c7f335b26e
        failing since 139 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-16T22:36:44.071848  + set +x

    2023-08-16T22:36:44.078516  <8>[   11.024960] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11303634_1.4.2.3.1>

    2023-08-16T22:36:44.186727  / # #

    2023-08-16T22:36:44.289207  export SHELL=3D/bin/sh

    2023-08-16T22:36:44.290043  #

    2023-08-16T22:36:44.391773  / # export SHELL=3D/bin/sh. /lava-11303634/=
environment

    2023-08-16T22:36:44.392069  =


    2023-08-16T22:36:44.493111  / # . /lava-11303634/environment/lava-11303=
634/bin/lava-test-runner /lava-11303634/1

    2023-08-16T22:36:44.494366  =


    2023-08-16T22:36:44.499130  / # /lava-11303634/bin/lava-test-runner /la=
va-11303634/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd4b3ef2e14042f635b1fd

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd4b3ef2e14042f635b202
        failing since 139 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-16T22:18:17.486164  + set<8>[   11.465826] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11303654_1.4.2.3.1>

    2023-08-16T22:18:17.486247   +x

    2023-08-16T22:18:17.590071  / # #

    2023-08-16T22:18:17.690626  export SHELL=3D/bin/sh

    2023-08-16T22:18:17.690798  #

    2023-08-16T22:18:17.791330  / # export SHELL=3D/bin/sh. /lava-11303654/=
environment

    2023-08-16T22:18:17.791533  =


    2023-08-16T22:18:17.892070  / # . /lava-11303654/environment/lava-11303=
654/bin/lava-test-runner /lava-11303654/1

    2023-08-16T22:18:17.892347  =


    2023-08-16T22:18:17.896970  / # /lava-11303654/bin/lava-test-runner /la=
va-11303654/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd4b3bf2e14042f635b1d9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd4b3bf2e14042f635b1de
        failing since 139 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-16T22:18:19.486648  + set<8>[   12.651621] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11303667_1.4.2.3.1>

    2023-08-16T22:18:19.487235   +x

    2023-08-16T22:18:19.595302  / # #

    2023-08-16T22:18:19.698135  export SHELL=3D/bin/sh

    2023-08-16T22:18:19.698929  #

    2023-08-16T22:18:19.800590  / # export SHELL=3D/bin/sh. /lava-11303667/=
environment

    2023-08-16T22:18:19.801448  =


    2023-08-16T22:18:19.903181  / # . /lava-11303667/environment/lava-11303=
667/bin/lava-test-runner /lava-11303667/1

    2023-08-16T22:18:19.904537  =


    2023-08-16T22:18:19.909170  / # /lava-11303667/bin/lava-test-runner /la=
va-11303667/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd4b63f2e14042f635b28b

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd4b63f2e14042f635b290
        failing since 30 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-16T22:20:42.766684  / # #

    2023-08-16T22:20:42.869318  export SHELL=3D/bin/sh

    2023-08-16T22:20:42.870048  #

    2023-08-16T22:20:42.971416  / # export SHELL=3D/bin/sh. /lava-11303687/=
environment

    2023-08-16T22:20:42.972178  =


    2023-08-16T22:20:43.073601  / # . /lava-11303687/environment/lava-11303=
687/bin/lava-test-runner /lava-11303687/1

    2023-08-16T22:20:43.074801  =


    2023-08-16T22:20:43.089975  / # /lava-11303687/bin/lava-test-runner /la=
va-11303687/1

    2023-08-16T22:20:43.139976  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-16T22:20:43.140545  + cd /lav<8>[   19.114999] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11303687_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd4b9f97a67da7bb35b1e0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd4b9f97a67da7bb35b1e5
        failing since 30 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-16T22:20:56.924978  / # #

    2023-08-16T22:20:58.005487  export SHELL=3D/bin/sh

    2023-08-16T22:20:58.007330  #

    2023-08-16T22:20:59.498584  / # export SHELL=3D/bin/sh. /lava-11303688/=
environment

    2023-08-16T22:20:59.500350  =


    2023-08-16T22:21:02.224696  / # . /lava-11303688/environment/lava-11303=
688/bin/lava-test-runner /lava-11303688/1

    2023-08-16T22:21:02.227006  =


    2023-08-16T22:21:02.234674  / # /lava-11303688/bin/lava-test-runner /la=
va-11303688/1

    2023-08-16T22:21:02.295111  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-16T22:21:02.295603  + cd /lava-113036<8>[   28.505343] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11303688_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd4b791c490e3bd135b25e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd4b791c490e3bd135b263
        failing since 30 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-16T22:20:56.285547  / # #

    2023-08-16T22:20:56.387677  export SHELL=3D/bin/sh

    2023-08-16T22:20:56.388394  #

    2023-08-16T22:20:56.489784  / # export SHELL=3D/bin/sh. /lava-11303684/=
environment

    2023-08-16T22:20:56.490501  =


    2023-08-16T22:20:56.591951  / # . /lava-11303684/environment/lava-11303=
684/bin/lava-test-runner /lava-11303684/1

    2023-08-16T22:20:56.593101  =


    2023-08-16T22:20:56.609689  / # /lava-11303684/bin/lava-test-runner /la=
va-11303684/1

    2023-08-16T22:20:56.674578  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-16T22:20:56.674743  + cd /lava-1130368<8>[   18.699007] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11303684_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
