Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42033716D5D
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 21:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbjE3TTJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 15:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjE3TTE (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 15:19:04 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0F7BE
        for <stable@vger.kernel.org>; Tue, 30 May 2023 12:19:00 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-52c30fa5271so2482037a12.0
        for <stable@vger.kernel.org>; Tue, 30 May 2023 12:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685474339; x=1688066339;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/f9hpQsXyuwN7+7alnd+M08/fFrygIGl2bi2mp0SGmg=;
        b=vLfNxwtm5aqwvXtlnx60sK81gapwQxUw1G18k6oX8ugANnA+h6/cvNbrGJJT6b00x8
         CxsWgU8GfB/2wfWi0fECJGGpLsLMSCygb+rkQ5wvdEUmlgzakKlrQfZkL4Hfnyy1nfZU
         JTdGl9EAe9nSmlW6llnq9msC4uXLH1Gqunt5usRDpOs7tx3zTyzjmOysEtzU69EWvbh5
         mbr3EWDUZTlThiMqZ1TxyXhdn5l5capCBLEeL7WJgzpjoWZHQY4b40FBgU5+wGQnGs7e
         vnU1GZA+XpHVfdmAQ0YtBY3mF2MLALwdNvr9icc/ur052m/8r8JEIixv+L4vAWVGT4ur
         ESgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685474339; x=1688066339;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/f9hpQsXyuwN7+7alnd+M08/fFrygIGl2bi2mp0SGmg=;
        b=XxMbmbrNuQa8+GAu1BqpM4D7VXdjzizpEyIdxouH86AC9F3rgtY+KpoizYxdpzOwC0
         OSEjKiTs9XF4xb8GwTln5a7/vkJScFgdaiwyzIToPT5KsqUAOPGG2Ml5k+DPkO7vWHPr
         qrDy/IoQxEHQRmVY42YhPDtfH+aSaVWGG53JzWxfQ4sFFMevAWhHXx/0Deb7COkjSJD0
         qj1bklW/EMKIkbDZKjJo4YUKVzSja/z5HIjTMQM5sdyYADzZ6WONDVhGO/0Y5ER0iOYA
         izyd9L2rFirfpw9MGy1qwCL/N5lR0v4HgX8wzuvHLO8l+a2ADrGhe7zQjcec/2eErqx8
         pmcQ==
X-Gm-Message-State: AC+VfDzuXeRr/RWslou4cvlcx+L/FqVzR/SgDaz77H1XbCbWvi6ydEXQ
        8zT6cfhBtMAJlVJqLFaG5UixdpOGKOMtl9P+kT3/5w==
X-Google-Smtp-Source: ACHHUZ6SJ5QAnFZsFJyfE8iZF/LRs+oBDE+u2ilpfObf/EaU2LyI8Y7I/bpNz5E7VN8FnDm1ePtYPw==
X-Received: by 2002:a17:902:dac3:b0:1ac:8837:df8 with SMTP id q3-20020a170902dac300b001ac88370df8mr3773042plx.6.1685474338891;
        Tue, 30 May 2023 12:18:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ix4-20020a170902f80400b001b0305757c3sm6199257plb.51.2023.05.30.12.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 12:18:58 -0700 (PDT)
Message-ID: <64764c22.170a0220.d7724.b095@mx.google.com>
Date:   Tue, 30 May 2023 12:18:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable
X-Kernelci-Kernel: v5.15.114
X-Kernelci-Report-Type: test
Subject: stable/linux-5.15.y baseline: 177 runs, 19 regressions (v5.15.114)
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

stable/linux-5.15.y baseline: 177 runs, 19 regressions (v5.15.114)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 4          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.15.y/kernel=
/v5.15.114/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.15.y
  Describe: v5.15.114
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      0ab06468cbd149aac0d7f216ec00452ff8c74e0b =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/647612f52cf6b6b30d2e85ea

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.114/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.114/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647612f52cf6b6b30d2e85ef
        failing since 61 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-30T15:14:36.888750  + set +x

    2023-05-30T15:14:36.895761  <8>[   11.654619] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10525989_1.4.2.3.1>

    2023-05-30T15:14:36.999650  / # #

    2023-05-30T15:14:37.100203  export SHELL=3D/bin/sh

    2023-05-30T15:14:37.100450  #

    2023-05-30T15:14:37.200975  / # export SHELL=3D/bin/sh. /lava-10525989/=
environment

    2023-05-30T15:14:37.201177  =


    2023-05-30T15:14:37.301749  / # . /lava-10525989/environment/lava-10525=
989/bin/lava-test-runner /lava-10525989/1

    2023-05-30T15:14:37.302042  =


    2023-05-30T15:14:37.307932  / # /lava-10525989/bin/lava-test-runner /la=
va-10525989/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647613597a494bd5b32e86bc

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.114/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.114/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647613597a494bd5b32e86c1
        failing since 61 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-30T15:16:16.890787  <8>[   10.338515] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10526091_1.4.2.3.1>

    2023-05-30T15:16:16.894142  + set +x

    2023-05-30T15:16:17.002952  / # #

    2023-05-30T15:16:17.104911  export SHELL=3D/bin/sh

    2023-05-30T15:16:17.105133  #

    2023-05-30T15:16:17.205637  / # export SHELL=3D/bin/sh. /lava-10526091/=
environment

    2023-05-30T15:16:17.205825  =


    2023-05-30T15:16:17.306397  / # . /lava-10526091/environment/lava-10526=
091/bin/lava-test-runner /lava-10526091/1

    2023-05-30T15:16:17.306672  =


    2023-05-30T15:16:17.312250  / # /lava-10526091/bin/lava-test-runner /la=
va-10526091/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/647612d568c81661782e8668

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.114/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.114/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647612d568c81661782e866d
        failing since 61 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-30T15:14:22.268398  + <8>[   12.248024] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10526018_1.4.2.3.1>

    2023-05-30T15:14:22.268825  set +x

    2023-05-30T15:14:22.376405  / # #

    2023-05-30T15:14:22.478979  export SHELL=3D/bin/sh

    2023-05-30T15:14:22.479618  #

    2023-05-30T15:14:22.581117  / # export SHELL=3D/bin/sh. /lava-10526018/=
environment

    2023-05-30T15:14:22.581779  =


    2023-05-30T15:14:22.683191  / # . /lava-10526018/environment/lava-10526=
018/bin/lava-test-runner /lava-10526018/1

    2023-05-30T15:14:22.684272  =


    2023-05-30T15:14:22.689181  / # /lava-10526018/bin/lava-test-runner /la=
va-10526018/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64761344be20def4662e85e7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.114/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.114/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64761344be20def4662e85ec
        failing since 61 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-30T15:16:07.041633  + set<8>[   11.306484] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10526117_1.4.2.3.1>

    2023-05-30T15:16:07.042292   +x

    2023-05-30T15:16:07.150188  / # #

    2023-05-30T15:16:07.252883  export SHELL=3D/bin/sh

    2023-05-30T15:16:07.253670  #

    2023-05-30T15:16:07.355463  / # export SHELL=3D/bin/sh. /lava-10526117/=
environment

    2023-05-30T15:16:07.356267  =


    2023-05-30T15:16:07.458066  / # . /lava-10526117/environment/lava-10526=
117/bin/lava-test-runner /lava-10526117/1

    2023-05-30T15:16:07.459400  =


    2023-05-30T15:16:07.464066  / # /lava-10526117/bin/lava-test-runner /la=
va-10526117/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647613517a494bd5b32e8682

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.114/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.114/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647613517a494bd5b32e8687
        failing since 61 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-30T15:16:08.299771  <8>[    8.009488] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10526101_1.4.2.3.1>

    2023-05-30T15:16:08.302978  + set +x

    2023-05-30T15:16:08.404193  #

    2023-05-30T15:16:08.404451  =


    2023-05-30T15:16:08.505009  / # #export SHELL=3D/bin/sh

    2023-05-30T15:16:08.505164  =


    2023-05-30T15:16:08.605677  / # export SHELL=3D/bin/sh. /lava-10526101/=
environment

    2023-05-30T15:16:08.605834  =


    2023-05-30T15:16:08.706325  / # . /lava-10526101/environment/lava-10526=
101/bin/lava-test-runner /lava-10526101/1

    2023-05-30T15:16:08.706581  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647614c3b6edfe91682e85f3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.114/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.114/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647614c3b6edfe91682e8=
5f4
        failing since 55 days (last pass: v5.15.105, first fail: v5.15.106) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647617e350442fdc402e8635

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.114/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.114/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647617e350442fdc402e863a
        failing since 131 days (last pass: v5.15.82, first fail: v5.15.89)

    2023-05-30T15:35:55.071136  + set +x<8>[    9.978412] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3631580_1.5.2.4.1>
    2023-05-30T15:35:55.071864  =

    2023-05-30T15:35:55.182652  / # #
    2023-05-30T15:35:55.286576  export SHELL=3D/bin/sh
    2023-05-30T15:35:55.287585  #
    2023-05-30T15:35:55.389841  / # export SHELL=3D/bin/sh. /lava-3631580/e=
nvironment
    2023-05-30T15:35:55.390926  =

    2023-05-30T15:35:55.493407  / # . /lava-3631580/environment/lava-363158=
0/bin/lava-test-runner /lava-3631580/1
    2023-05-30T15:35:55.495062  =

    2023-05-30T15:35:55.500180  / # /lava-3631580/bin/lava-test-runner /lav=
a-3631580/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/647612e068c81661782e8693

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.114/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.114/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647612e068c81661782e8698
        failing since 61 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-30T15:14:18.023224  + set +x

    2023-05-30T15:14:18.029213  <8>[   11.861408] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10526015_1.4.2.3.1>

    2023-05-30T15:14:18.133553  / # #

    2023-05-30T15:14:18.234309  export SHELL=3D/bin/sh

    2023-05-30T15:14:18.234540  #

    2023-05-30T15:14:18.335115  / # export SHELL=3D/bin/sh. /lava-10526015/=
environment

    2023-05-30T15:14:18.335340  =


    2023-05-30T15:14:18.435905  / # . /lava-10526015/environment/lava-10526=
015/bin/lava-test-runner /lava-10526015/1

    2023-05-30T15:14:18.436178  =


    2023-05-30T15:14:18.441026  / # /lava-10526015/bin/lava-test-runner /la=
va-10526015/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647613325f15688dcd2e85f5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.114/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.114/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647613325f15688dcd2e85fa
        failing since 61 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-30T15:15:50.379986  + <8>[   10.318246] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10526078_1.4.2.3.1>

    2023-05-30T15:15:50.383176  set +x

    2023-05-30T15:15:50.484349  /#

    2023-05-30T15:15:50.585153   # #export SHELL=3D/bin/sh

    2023-05-30T15:15:50.585328  =


    2023-05-30T15:15:50.685830  / # export SHELL=3D/bin/sh. /lava-10526078/=
environment

    2023-05-30T15:15:50.685995  =


    2023-05-30T15:15:50.786506  / # . /lava-10526078/environment/lava-10526=
078/bin/lava-test-runner /lava-10526078/1

    2023-05-30T15:15:50.786857  =


    2023-05-30T15:15:50.791855  / # /lava-10526078/bin/lava-test-runner /la=
va-10526078/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/647612c0b0d45edee52e8621

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.114/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.114/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647612c0b0d45edee52e8626
        failing since 61 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-30T15:14:00.495179  + <8>[   12.261726] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10525995_1.4.2.3.1>

    2023-05-30T15:14:00.495267  set +x

    2023-05-30T15:14:00.596444  #

    2023-05-30T15:14:00.697192  / # #export SHELL=3D/bin/sh

    2023-05-30T15:14:00.697341  =


    2023-05-30T15:14:00.797905  / # export SHELL=3D/bin/sh. /lava-10525995/=
environment

    2023-05-30T15:14:00.798110  =


    2023-05-30T15:14:00.898619  / # . /lava-10525995/environment/lava-10525=
995/bin/lava-test-runner /lava-10525995/1

    2023-05-30T15:14:00.898863  =


    2023-05-30T15:14:00.903796  / # /lava-10525995/bin/lava-test-runner /la=
va-10525995/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647613375f15688dcd2e8605

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.114/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.114/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647613375f15688dcd2e860a
        failing since 61 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-30T15:15:54.021542  + set +x<8>[   10.666647] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10526070_1.4.2.3.1>

    2023-05-30T15:15:54.021660  =


    2023-05-30T15:15:54.123413  #

    2023-05-30T15:15:54.224285  / # #export SHELL=3D/bin/sh

    2023-05-30T15:15:54.224510  =


    2023-05-30T15:15:54.325082  / # export SHELL=3D/bin/sh. /lava-10526070/=
environment

    2023-05-30T15:15:54.325311  =


    2023-05-30T15:15:54.425894  / # . /lava-10526070/environment/lava-10526=
070/bin/lava-test-runner /lava-10526070/1

    2023-05-30T15:15:54.426317  =


    2023-05-30T15:15:54.431598  / # /lava-10526070/bin/lava-test-runner /la=
va-10526070/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/647612f109d369708a2e8614

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.114/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.114/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647612f109d369708a2e8619
        failing since 61 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-30T15:14:34.407142  + <8>[   12.367462] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10526016_1.4.2.3.1>

    2023-05-30T15:14:34.407580  set +x

    2023-05-30T15:14:34.514904  / # #

    2023-05-30T15:14:34.617646  export SHELL=3D/bin/sh

    2023-05-30T15:14:34.618400  #

    2023-05-30T15:14:34.719670  / # export SHELL=3D/bin/sh. /lava-10526016/=
environment

    2023-05-30T15:14:34.719845  =


    2023-05-30T15:14:34.820396  / # . /lava-10526016/environment/lava-10526=
016/bin/lava-test-runner /lava-10526016/1

    2023-05-30T15:14:34.820686  =


    2023-05-30T15:14:34.825437  / # /lava-10526016/bin/lava-test-runner /la=
va-10526016/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647613507a494bd5b32e8677

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.114/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.114/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647613507a494bd5b32e867c
        failing since 61 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-30T15:16:10.296340  + <8>[   11.523990] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10526099_1.4.2.3.1>

    2023-05-30T15:16:10.296423  set +x

    2023-05-30T15:16:10.400587  / # #

    2023-05-30T15:16:10.501219  export SHELL=3D/bin/sh

    2023-05-30T15:16:10.501405  #

    2023-05-30T15:16:10.601894  / # export SHELL=3D/bin/sh. /lava-10526099/=
environment

    2023-05-30T15:16:10.602077  =


    2023-05-30T15:16:10.702620  / # . /lava-10526099/environment/lava-10526=
099/bin/lava-test-runner /lava-10526099/1

    2023-05-30T15:16:10.702869  =


    2023-05-30T15:16:10.707782  / # /lava-10526099/bin/lava-test-runner /la=
va-10526099/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/647612e03ac987710f2e8617

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.114/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.114/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647612e03ac987710f2e861c
        failing since 61 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-30T15:14:34.320752  + set<8>[   11.890428] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10525978_1.4.2.3.1>

    2023-05-30T15:14:34.320850   +x

    2023-05-30T15:14:34.424918  / # #

    2023-05-30T15:14:34.525565  export SHELL=3D/bin/sh

    2023-05-30T15:14:34.525769  #

    2023-05-30T15:14:34.626243  / # export SHELL=3D/bin/sh. /lava-10525978/=
environment

    2023-05-30T15:14:34.626436  =


    2023-05-30T15:14:34.726968  / # . /lava-10525978/environment/lava-10525=
978/bin/lava-test-runner /lava-10525978/1

    2023-05-30T15:14:34.727263  =


    2023-05-30T15:14:34.732222  / # /lava-10525978/bin/lava-test-runner /la=
va-10525978/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647613393c1b36d8ba2e865a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.114/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.114/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647613393c1b36d8ba2e865f
        failing since 61 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-30T15:15:54.597488  + set +x<8>[   11.151495] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10526122_1.4.2.3.1>

    2023-05-30T15:15:54.597577  =


    2023-05-30T15:15:54.702082  / # #

    2023-05-30T15:15:54.802696  export SHELL=3D/bin/sh

    2023-05-30T15:15:54.802913  #

    2023-05-30T15:15:54.903437  / # export SHELL=3D/bin/sh. /lava-10526122/=
environment

    2023-05-30T15:15:54.903675  =


    2023-05-30T15:15:55.004185  / # . /lava-10526122/environment/lava-10526=
122/bin/lava-test-runner /lava-10526122/1

    2023-05-30T15:15:55.004582  =


    2023-05-30T15:15:55.008356  / # /lava-10526122/bin/lava-test-runner /la=
va-10526122/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 4          =


  Details:     https://kernelci.org/test/plan/id/6476166caf887c81b42e8675

  Results:     153 PASS, 14 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.114/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui=
-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.114/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui=
-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/6476166caf887c81b42e868f
        failing since 18 days (last pass: v5.15.110, first fail: v5.15.111)

    2023-05-30T15:29:31.697468  /lava-10526326/1/../bin/lava-test-case

    2023-05-30T15:29:31.704015  <8>[   61.625787] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/6476166caf887c81b42e868f
        failing since 18 days (last pass: v5.15.110, first fail: v5.15.111)

    2023-05-30T15:29:31.697468  /lava-10526326/1/../bin/lava-test-case

    2023-05-30T15:29:31.704015  <8>[   61.625787] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/6476166caf887c81b42e8691
        failing since 18 days (last pass: v5.15.110, first fail: v5.15.111)

    2023-05-30T15:29:30.656887  /lava-10526326/1/../bin/lava-test-case

    2023-05-30T15:29:30.663574  <8>[   60.584610] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6476166caf887c81b42e8719
        failing since 18 days (last pass: v5.15.110, first fail: v5.15.111)

    2023-05-30T15:29:16.459230  + set +x

    2023-05-30T15:29:16.462577  <8>[   46.387314] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10526326_1.5.2.3.1>

    2023-05-30T15:29:16.573847  / # #

    2023-05-30T15:29:16.674832  export SHELL=3D/bin/sh

    2023-05-30T15:29:16.675641  #

    2023-05-30T15:29:16.777266  / # export SHELL=3D/bin/sh. /lava-10526326/=
environment

    2023-05-30T15:29:16.778137  =


    2023-05-30T15:29:16.879862  / # . /lava-10526326/environment/lava-10526=
326/bin/lava-test-runner /lava-10526326/1

    2023-05-30T15:29:16.881190  =


    2023-05-30T15:29:16.886828  / # /lava-10526326/bin/lava-test-runner /la=
va-10526326/1
 =

    ... (13 line(s) more)  =

 =20
