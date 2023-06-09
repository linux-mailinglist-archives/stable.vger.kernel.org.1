Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E53772A1D2
	for <lists+stable@lfdr.de>; Fri,  9 Jun 2023 20:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjFISKf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 9 Jun 2023 14:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjFISKe (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Jun 2023 14:10:34 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC9230FE
        for <stable@vger.kernel.org>; Fri,  9 Jun 2023 11:10:32 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b1bf83095aso8319255ad.3
        for <stable@vger.kernel.org>; Fri, 09 Jun 2023 11:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686334231; x=1688926231;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1I+VEnAaU8ZMVShQnbihtCY3eoNQWs48Ej3jAWxc0S4=;
        b=YSkmLo6tspMd6iNnjD3S4QOT2CKaeGn0IfkOx27ek3Mh+0yKwTgZ+0jg4hD550joEk
         FwX495DvrKSiEanE1tlqTURfI/KRqz1Je9o2rQBqHLuuP+f8H6r4AkQ9+d9v5MIusv4b
         XsPayq3n+CgBdAoB9w0+DIHC/yDxZHtLNJE6vr6JlOGfhp5WLs9A7yWEB+V+U+2NH3yI
         jxiUtSUFzTukR/44AFb0SIvWE55pwZwrS2OWBsbTCrDNZnH8UBLygWr0CUR24hJxp/y+
         3UYJUeJnZiCceDPYanaNcxaPZ5AmA8Q/iqR2qzE4q2GjFwBxKOisHJu7yzSRpYM1U0B1
         q/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686334231; x=1688926231;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1I+VEnAaU8ZMVShQnbihtCY3eoNQWs48Ej3jAWxc0S4=;
        b=kbhSGuKCJUt5THHbjWgiY5gQI4rWKVWvGk/Gybj080S+6uBp0K0U8a7F+bDkp+X3Lf
         jp2YB6kSKNv8QSrykY+qngFXDwAUvu4kA+ebh/tHQ1L2ny1uRpEI9gIfnEOcsjxrJK0b
         ZVch4iumxNwyPB+h3Tx5FEsunyi8ioKYj9TQkMprO+TQhjJcSj+h0uHC7krfV4d67mOc
         02hmiuhU7cOT2bgVag7OGDtlP3wpgZS17+3Pp9LpkKNiWAtO8iWn4ty3GgB3DYTjN/8O
         6PmoijcKvt7kM40KJR4Q2YoV4CJ9swMy5cAuUwr/pF1bFmZ0mtu5gzVaCmtpg3wALI4N
         4c+g==
X-Gm-Message-State: AC+VfDzvTNmVZUz2RBiOK2xf/N1yCqDsfa/ifaauM7fIc/XRufZwL6L+
        epiqzI2RnRa9d+FkNl5N24BzZl0TB60yCHMjynpCow==
X-Google-Smtp-Source: ACHHUZ5fjK7EDl9CuYVvRptMVK8ol8jQd5sCBPspsPvFfCbuR6BJ2ldn9EaRxAr+8hZKCxVMnGla9Q==
X-Received: by 2002:a17:902:d5cd:b0:1ab:1bdd:b307 with SMTP id g13-20020a170902d5cd00b001ab1bddb307mr1385357plh.51.1686334230319;
        Fri, 09 Jun 2023 11:10:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g18-20020a170902869200b001aaf2e8b1eesm3528197plo.248.2023.06.09.11.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 11:10:29 -0700 (PDT)
Message-ID: <64836b15.170a0220.c247a.7d4a@mx.google.com>
Date:   Fri, 09 Jun 2023 11:10:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.33
Subject: stable-rc/linux-6.1.y baseline: 168 runs, 12 regressions (v6.1.33)
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

stable-rc/linux-6.1.y baseline: 168 runs, 12 regressions (v6.1.33)

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

at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

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

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.33/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.33
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      2f3918bc53fb998fdeed8683ddc61194ceb84edf =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648336570e851acd6530612f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648336570e851acd65306134
        failing since 70 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-09T14:25:17.735881  + set +x

    2023-06-09T14:25:17.742757  <8>[   10.676190] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10659530_1.4.2.3.1>

    2023-06-09T14:25:17.844817  #

    2023-06-09T14:25:17.945737  / # #export SHELL=3D/bin/sh

    2023-06-09T14:25:17.945969  =


    2023-06-09T14:25:18.046524  / # export SHELL=3D/bin/sh. /lava-10659530/=
environment

    2023-06-09T14:25:18.046752  =


    2023-06-09T14:25:18.147324  / # . /lava-10659530/environment/lava-10659=
530/bin/lava-test-runner /lava-10659530/1

    2023-06-09T14:25:18.147687  =


    2023-06-09T14:25:18.191565  / # /lava-10659530/bin/lava-test-runner /la=
va-10659530/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64833659c96d38cec8306167

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64833659c96d38cec830616c
        failing since 70 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-09T14:25:25.928092  + set<8>[   11.717649] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10659580_1.4.2.3.1>

    2023-06-09T14:25:25.928174   +x

    2023-06-09T14:25:26.032528  / # #

    2023-06-09T14:25:26.133109  export SHELL=3D/bin/sh

    2023-06-09T14:25:26.133251  #

    2023-06-09T14:25:26.233703  / # export SHELL=3D/bin/sh. /lava-10659580/=
environment

    2023-06-09T14:25:26.233914  =


    2023-06-09T14:25:26.334434  / # . /lava-10659580/environment/lava-10659=
580/bin/lava-test-runner /lava-10659580/1

    2023-06-09T14:25:26.334673  =


    2023-06-09T14:25:26.338933  / # /lava-10659580/bin/lava-test-runner /la=
va-10659580/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648336522728d0f765306160

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648336522728d0f765306165
        failing since 70 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-09T14:25:12.937931  <8>[   10.573444] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10659564_1.4.2.3.1>

    2023-06-09T14:25:12.941142  + set +x

    2023-06-09T14:25:13.042471  =


    2023-06-09T14:25:13.143098  / # #export SHELL=3D/bin/sh

    2023-06-09T14:25:13.143845  =


    2023-06-09T14:25:13.245223  / # export SHELL=3D/bin/sh. /lava-10659564/=
environment

    2023-06-09T14:25:13.245955  =


    2023-06-09T14:25:13.347482  / # . /lava-10659564/environment/lava-10659=
564/bin/lava-test-runner /lava-10659564/1

    2023-06-09T14:25:13.348578  =


    2023-06-09T14:25:13.354259  / # /lava-10659564/bin/lava-test-runner /la=
va-10659564/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648338b56f92fc31a03061b3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-sama5d4_xplained.t=
xt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-sama5d4_xplained.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648338b66f92fc31a0306=
1b4
        new failure (last pass: v6.1.31-265-g621717027bee) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64833834cdf0c951a630613f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64833834cdf0c951a6306=
140
        failing since 1 day (last pass: v6.1.31-40-g7d0a9678d276, first fai=
l: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6483365788d5dbefb4306130

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6483365788d5dbefb4306135
        failing since 70 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-09T14:25:09.835978  + set +x

    2023-06-09T14:25:09.842545  <8>[   13.962034] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10659596_1.4.2.3.1>

    2023-06-09T14:25:09.946654  / # #

    2023-06-09T14:25:10.047364  export SHELL=3D/bin/sh

    2023-06-09T14:25:10.047540  #

    2023-06-09T14:25:10.148153  / # export SHELL=3D/bin/sh. /lava-10659596/=
environment

    2023-06-09T14:25:10.148326  =


    2023-06-09T14:25:10.248862  / # . /lava-10659596/environment/lava-10659=
596/bin/lava-test-runner /lava-10659596/1

    2023-06-09T14:25:10.249185  =


    2023-06-09T14:25:10.253617  / # /lava-10659596/bin/lava-test-runner /la=
va-10659596/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648336432728d0f765306151

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648336432728d0f765306156
        failing since 70 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-09T14:25:07.004382  <8>[    7.808220] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10659536_1.4.2.3.1>

    2023-06-09T14:25:07.007675  + set +x

    2023-06-09T14:25:07.109259  =


    2023-06-09T14:25:07.209830  / # #export SHELL=3D/bin/sh

    2023-06-09T14:25:07.210026  =


    2023-06-09T14:25:07.310538  / # export SHELL=3D/bin/sh. /lava-10659536/=
environment

    2023-06-09T14:25:07.310738  =


    2023-06-09T14:25:07.411237  / # . /lava-10659536/environment/lava-10659=
536/bin/lava-test-runner /lava-10659536/1

    2023-06-09T14:25:07.411510  =


    2023-06-09T14:25:07.416620  / # /lava-10659536/bin/lava-test-runner /la=
va-10659536/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6483365533c93937dc306141

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6483365533c93937dc306146
        failing since 70 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-09T14:25:17.167476  + set<8>[   10.908195] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10659544_1.4.2.3.1>

    2023-06-09T14:25:17.167553   +x

    2023-06-09T14:25:17.271394  / # #

    2023-06-09T14:25:17.371936  export SHELL=3D/bin/sh

    2023-06-09T14:25:17.372099  #

    2023-06-09T14:25:17.472532  / # export SHELL=3D/bin/sh. /lava-10659544/=
environment

    2023-06-09T14:25:17.472738  =


    2023-06-09T14:25:17.573229  / # . /lava-10659544/environment/lava-10659=
544/bin/lava-test-runner /lava-10659544/1

    2023-06-09T14:25:17.573496  =


    2023-06-09T14:25:17.578228  / # /lava-10659544/bin/lava-test-runner /la=
va-10659544/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6483365b33c93937dc306153

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6483365b33c93937dc306158
        failing since 70 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-09T14:25:27.459955  <8>[   11.846777] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10659553_1.4.2.3.1>

    2023-06-09T14:25:27.563987  / # #

    2023-06-09T14:25:27.664551  export SHELL=3D/bin/sh

    2023-06-09T14:25:27.664751  #

    2023-06-09T14:25:27.765293  / # export SHELL=3D/bin/sh. /lava-10659553/=
environment

    2023-06-09T14:25:27.765532  =


    2023-06-09T14:25:27.866116  / # . /lava-10659553/environment/lava-10659=
553/bin/lava-test-runner /lava-10659553/1

    2023-06-09T14:25:27.866434  =


    2023-06-09T14:25:27.870897  / # /lava-10659553/bin/lava-test-runner /la=
va-10659553/1

    2023-06-09T14:25:27.877678  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64833a4ef3e86e4142306167

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui=
-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui=
-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/64833a4ef3e86e4142306183
        failing since 28 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-06-09T14:42:10.432755  <8>[   22.056713] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-driver-present RESULT=3Dpass>

    2023-06-09T14:42:11.451942  /lava-10660222/1/../bin/lava-test-case

    2023-06-09T14:42:11.458833  <8>[   23.086102] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64833a4ef3e86e414230620f
        failing since 28 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-06-09T14:42:05.964770  + set +x

    2023-06-09T14:42:05.967829  <8>[   17.596738] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10660222_1.5.2.3.1>

    2023-06-09T14:42:06.074917  / # #

    2023-06-09T14:42:06.175573  export SHELL=3D/bin/sh

    2023-06-09T14:42:06.175962  #

    2023-06-09T14:42:06.276556  / # export SHELL=3D/bin/sh. /lava-10660222/=
environment

    2023-06-09T14:42:06.276746  =


    2023-06-09T14:42:06.377247  / # . /lava-10660222/environment/lava-10660=
222/bin/lava-test-runner /lava-10660222/1

    2023-06-09T14:42:06.377591  =


    2023-06-09T14:42:06.382491  / # /lava-10660222/bin/lava-test-runner /la=
va-10660222/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/6483331dff59589c0a30612f

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33/=
mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33/=
mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/mipsel/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/6483331dff59589=
c0a306137
        new failure (last pass: v6.1.31-265-g621717027bee)
        1 lines

    2023-06-09T14:11:19.344597  kern  :alert : CPU 0 Unable to handle kerne=
l paging request at virtual address 79e6cd54, epc =3D=3D 80201fa4, ra =3D=
=3D 802048f4
    2023-06-09T14:11:19.344813  =


    2023-06-09T14:11:19.383677  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dale=
rt RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D1>
    2023-06-09T14:11:19.383905  =

   =

 =20
