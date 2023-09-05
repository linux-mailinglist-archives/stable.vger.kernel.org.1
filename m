Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1612B792465
	for <lists+stable@lfdr.de>; Tue,  5 Sep 2023 17:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjIEP64 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 5 Sep 2023 11:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244380AbjIEBPo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 21:15:44 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4997B1BE
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 18:15:40 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68ca2a37c6aso1727256b3a.0
        for <stable@vger.kernel.org>; Mon, 04 Sep 2023 18:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693876539; x=1694481339; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kZt+Sukn8Pt7mIxHIvC2nuaQ9F9ksAG0QmHMVbwQF+Q=;
        b=ddWThw+DoAIgL6ZivF4bVa50TWGmXr5xy3uTYorovh7TTK8FM0goaJIeYebO+7pXXk
         qKetfetTd2/DIWl2RPHTdf/AGG8I7fiQtDlKVGVNVBEs8ClZGV44t1dInGl6WeKLzYzr
         amZAUTIdoeeVyzHJ1XZlTnx97B2vQ9LEMywB+LmxLuyXHYdSOOJgqf3KU4SwFH3Nsucg
         wrPgP/5lBg3M2t3SCe+ELGULwRmVxGSBP7KLtHpdIetmx+T5u8Sqp9VYsXyYnSnStNt4
         FoyUWkyJCJdbWT5E5eSHweRWKhCTOLHgOJ4WIt1PS4ez2l8JPNOizLtCdzZ6wxT0AsQk
         nazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693876539; x=1694481339;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZt+Sukn8Pt7mIxHIvC2nuaQ9F9ksAG0QmHMVbwQF+Q=;
        b=NX9DBXnY2m5BJVb771yHbU74YpnP+ko25QOBQuNuwTOcHAW0LXesZ7kp2SqlojKS1d
         RusH0P3tYTLo4SXXelwkDvA0ukme/HyLTt8UbBrnLMw+3qMImeDQ1zUO+lRtyoC36LmL
         ZxKtKbz3Kj+2C76c5fzvvlQtDEcvi0bwVU1wbRuB9ORmH+v1tOvX5z+8QE7fwvFg/GWS
         XUcFTimL8BgwrxPFxd3zHJg1NIZ4VSK2BDNHFBVgSj7EJg2wLpA59VMG9Z8Y6/24pFyO
         jnNCTdJ1fyu0xcNUijzYKptlqkEsEQNZatgpp1PXPs0GxxlBi/y5dVdf+ySTelAD1a5c
         lABg==
X-Gm-Message-State: AOJu0Yy+8MnaCeRSBT/X3hD7anFgbDOqj8/NGymKCn2rea5RsC8OOq7W
        br2NcGxsIXx/Sare2R3NRXUbRx22SZgnqcVHa70=
X-Google-Smtp-Source: AGHT+IEEu/twwPQxFG7ciHxZmXnBi8E7JCnAiARLXp6xkrjiB1Sr4wOEvh5fltyn+uOUPuBgYJb39w==
X-Received: by 2002:a05:6a20:244b:b0:127:76ab:a6ff with SMTP id t11-20020a056a20244b00b0012776aba6ffmr15712425pzc.22.1693876539218;
        Mon, 04 Sep 2023 18:15:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z3-20020a63ac43000000b005658d3a46d7sm8416768pgn.84.2023.09.04.18.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 18:15:38 -0700 (PDT)
Message-ID: <64f6813a.630a0220.1e03e.0f04@mx.google.com>
Date:   Mon, 04 Sep 2023 18:15:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.51-32-gd0abe9b6003a
Subject: stable-rc/linux-6.1.y baseline: 125 runs,
 11 regressions (v6.1.51-32-gd0abe9b6003a)
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

stable-rc/linux-6.1.y baseline: 125 runs, 11 regressions (v6.1.51-32-gd0abe=
9b6003a)

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

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

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
el/v6.1.51-32-gd0abe9b6003a/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.51-32-gd0abe9b6003a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      d0abe9b6003aae74696bf546c325193113e4b56e =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f64df1e092889597286de0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-gd0abe9b6003a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-acer-chromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-gd0abe9b6003a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-acer-chromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f64df1e092889597286=
de1
        failing since 2 days (last pass: v6.1.50-11-g1767553758a66, first f=
ail: v6.1.51) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f64e8658febb8c1e286d77

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-gd0abe9b6003a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-gd0abe9b6003a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f64e8658febb8c1e286d7c
        failing since 158 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-04T21:39:04.432669  <8>[   10.545853] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11432579_1.4.2.3.1>

    2023-09-04T21:39:04.436428  + set +x

    2023-09-04T21:39:04.542648  =


    2023-09-04T21:39:04.644515  / # #export SHELL=3D/bin/sh

    2023-09-04T21:39:04.645377  =


    2023-09-04T21:39:04.746888  / # export SHELL=3D/bin/sh. /lava-11432579/=
environment

    2023-09-04T21:39:04.747675  =


    2023-09-04T21:39:04.849273  / # . /lava-11432579/environment/lava-11432=
579/bin/lava-test-runner /lava-11432579/1

    2023-09-04T21:39:04.850509  =


    2023-09-04T21:39:04.855730  / # /lava-11432579/bin/lava-test-runner /la=
va-11432579/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f64dc397cbd90704286dbd

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-gd0abe9b6003a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-gd0abe9b6003a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f64dc397cbd90704286dc2
        failing since 158 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-04T21:35:46.261150  + set<8>[   12.428556] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11432564_1.4.2.3.1>

    2023-09-04T21:35:46.261691   +x

    2023-09-04T21:35:46.369486  / # #

    2023-09-04T21:35:46.470651  export SHELL=3D/bin/sh

    2023-09-04T21:35:46.471357  #

    2023-09-04T21:35:46.572771  / # export SHELL=3D/bin/sh. /lava-11432564/=
environment

    2023-09-04T21:35:46.573471  =


    2023-09-04T21:35:46.674911  / # . /lava-11432564/environment/lava-11432=
564/bin/lava-test-runner /lava-11432564/1

    2023-09-04T21:35:46.675985  =


    2023-09-04T21:35:46.681168  / # /lava-11432564/bin/lava-test-runner /la=
va-11432564/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f64dc5051721b893286de0

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-gd0abe9b6003a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-gd0abe9b6003a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f64dc5051721b893286de5
        failing since 158 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-04T21:35:44.672083  <8>[   10.182084] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11432582_1.4.2.3.1>

    2023-09-04T21:35:44.675446  + set +x

    2023-09-04T21:35:44.780630  #

    2023-09-04T21:35:44.781070  =


    2023-09-04T21:35:44.881976  / # #export SHELL=3D/bin/sh

    2023-09-04T21:35:44.882682  =


    2023-09-04T21:35:44.983930  / # export SHELL=3D/bin/sh. /lava-11432582/=
environment

    2023-09-04T21:35:44.984583  =


    2023-09-04T21:35:45.085857  / # . /lava-11432582/environment/lava-11432=
582/bin/lava-test-runner /lava-11432582/1

    2023-09-04T21:35:45.087340  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f651b25ea2bfcd6f286d85

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-gd0abe9b6003a/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-gd0abe9b6003a/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f651b25ea2bfcd6f286=
d86
        failing since 88 days (last pass: v6.1.31-40-g7d0a9678d276, first f=
ail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f64da21713a7dbfb286d7b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-gd0abe9b6003a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-gd0abe9b6003a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f64da21713a7dbfb286d80
        failing since 158 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-04T21:36:25.696412  + set +x

    2023-09-04T21:36:25.703376  <8>[   10.140377] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11432556_1.4.2.3.1>

    2023-09-04T21:36:25.807397  / # #

    2023-09-04T21:36:25.908091  export SHELL=3D/bin/sh

    2023-09-04T21:36:25.908279  #

    2023-09-04T21:36:26.008814  / # export SHELL=3D/bin/sh. /lava-11432556/=
environment

    2023-09-04T21:36:26.009034  =


    2023-09-04T21:36:26.109597  / # . /lava-11432556/environment/lava-11432=
556/bin/lava-test-runner /lava-11432556/1

    2023-09-04T21:36:26.109915  =


    2023-09-04T21:36:26.113970  / # /lava-11432556/bin/lava-test-runner /la=
va-11432556/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f64dc669777bdf30286dd1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-gd0abe9b6003a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-gd0abe9b6003a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f64dc669777bdf30286dd6
        failing since 158 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-04T21:35:50.002329  + <8>[   11.319099] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11432558_1.4.2.3.1>

    2023-09-04T21:35:50.002412  set +x

    2023-09-04T21:35:50.106711  / # #

    2023-09-04T21:35:50.207291  export SHELL=3D/bin/sh

    2023-09-04T21:35:50.207434  #

    2023-09-04T21:35:50.307938  / # export SHELL=3D/bin/sh. /lava-11432558/=
environment

    2023-09-04T21:35:50.308083  =


    2023-09-04T21:35:50.408598  / # . /lava-11432558/environment/lava-11432=
558/bin/lava-test-runner /lava-11432558/1

    2023-09-04T21:35:50.408868  =


    2023-09-04T21:35:50.413462  / # /lava-11432558/bin/lava-test-runner /la=
va-11432558/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f64dae3b2b0d5c52286d7f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-gd0abe9b6003a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-gd0abe9b6003a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f64dae3b2b0d5c52286d84
        failing since 158 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-04T21:35:30.941289  + set +x<8>[   12.043467] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11432559_1.4.2.3.1>

    2023-09-04T21:35:30.941372  =


    2023-09-04T21:35:31.046063  / # #

    2023-09-04T21:35:31.146710  export SHELL=3D/bin/sh

    2023-09-04T21:35:31.146859  #

    2023-09-04T21:35:31.247358  / # export SHELL=3D/bin/sh. /lava-11432559/=
environment

    2023-09-04T21:35:31.247514  =


    2023-09-04T21:35:31.348013  / # . /lava-11432559/environment/lava-11432=
559/bin/lava-test-runner /lava-11432559/1

    2023-09-04T21:35:31.348318  =


    2023-09-04T21:35:31.353484  / # /lava-11432559/bin/lava-test-runner /la=
va-11432559/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f64f9d5d0818d4c2286de0

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-gd0abe9b6003a/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-gd0abe9b6003a/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f64f9d5d0818d4c2286de5
        failing since 49 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-09-04T21:45:16.788749  / # #

    2023-09-04T21:45:16.889202  export SHELL=3D/bin/sh

    2023-09-04T21:45:16.889403  #

    2023-09-04T21:45:16.989841  / # export SHELL=3D/bin/sh. /lava-11432630/=
environment

    2023-09-04T21:45:16.989970  =


    2023-09-04T21:45:17.090393  / # . /lava-11432630/environment/lava-11432=
630/bin/lava-test-runner /lava-11432630/1

    2023-09-04T21:45:17.090564  =


    2023-09-04T21:45:17.102584  / # /lava-11432630/bin/lava-test-runner /la=
va-11432630/1

    2023-09-04T21:45:17.154871  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-04T21:45:17.154940  + cd /lava-114326<8>[   19.086267] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11432630_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f64fc85e1f92815a286d76

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-gd0abe9b6003a/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulc=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-gd0abe9b6003a/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulc=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f64fc85e1f92815a286d7b
        failing since 49 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-09-04T21:45:38.935616  / # #

    2023-09-04T21:45:40.014328  export SHELL=3D/bin/sh

    2023-09-04T21:45:40.016106  #

    2023-09-04T21:45:41.504441  / # export SHELL=3D/bin/sh. /lava-11432623/=
environment

    2023-09-04T21:45:41.506262  =


    2023-09-04T21:45:44.226087  / # . /lava-11432623/environment/lava-11432=
623/bin/lava-test-runner /lava-11432623/1

    2023-09-04T21:45:44.228255  =


    2023-09-04T21:45:44.229357  / # /lava-11432623/bin/lava-test-runner /la=
va-11432623/1

    2023-09-04T21:45:44.296769  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-04T21:45:44.297259  + cd /lava-114326<8>[   28.464809] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11432623_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f64f9c5d0818d4c2286dd5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-gd0abe9b6003a/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-gd0abe9b6003a/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f64f9c5d0818d4c2286dda
        failing since 49 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-09-04T21:45:29.076539  / # #

    2023-09-04T21:45:29.178714  export SHELL=3D/bin/sh

    2023-09-04T21:45:29.179419  #

    2023-09-04T21:45:29.280770  / # export SHELL=3D/bin/sh. /lava-11432621/=
environment

    2023-09-04T21:45:29.281609  =


    2023-09-04T21:45:29.382964  / # . /lava-11432621/environment/lava-11432=
621/bin/lava-test-runner /lava-11432621/1

    2023-09-04T21:45:29.384109  =


    2023-09-04T21:45:29.401181  / # /lava-11432621/bin/lava-test-runner /la=
va-11432621/1

    2023-09-04T21:45:29.468098  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-04T21:45:29.468614  + cd /lava-1143262<8>[   16.849387] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11432621_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
