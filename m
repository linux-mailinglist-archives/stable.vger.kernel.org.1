Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278B9730293
	for <lists+stable@lfdr.de>; Wed, 14 Jun 2023 16:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245665AbjFNO7j (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 14 Jun 2023 10:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245664AbjFNO7h (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Jun 2023 10:59:37 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4DB1FD2
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 07:59:35 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6667c54839bso251220b3a.3
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 07:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686754774; x=1689346774;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6jn3KkuInGo80JjG8KaE6hBRUmLa/THmvxyo3jYhwAs=;
        b=QnQBBBGz0+BArmhVAJL44iEDKBfvTaREf8XYITZIMbjTH7INjoDzUs3mhk7IQefna6
         yXMlkmwDN9fNFA0FChKGwk5h3AlOAcar9Uy7x0p1kSrqwZhkwnTf521BHjpCdRPissLM
         HZYc5kNVywvsjV8yafLXiWVzEQJE6kykgxUJT1ZEPtEyaKBACVuBivQDKfD5uc7TMl8a
         rC01KtlZpqDGbfug5cQ8xHDjpYl5IGITAsFi182068z0gk5qgN68/vREnrBNdd9zuuAj
         i2w1XwgWIbI5NJ4bFaXiE1l+AHVSZUkvPwLdMcT8ClFKSIsx4RAGPULavxwJOPoVeqJt
         l/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686754774; x=1689346774;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6jn3KkuInGo80JjG8KaE6hBRUmLa/THmvxyo3jYhwAs=;
        b=IqvMXFsT44+m/taanHQSO1mDAu/wFA8zAXOtYmmz4xoWnOr7ZW2FRgRTs7n6oqGC5y
         aJ5fDtS8pV9y0oQOHRGywdTPzB+drZ+SZRSoCWCCELyUOLp2qFaEX+f0jkzN44i0Tept
         JKeb4bE7xIYRl/UKx8ALgyfU5LIMaAIpCbUABoQoaL9AhBWJ6xE6h+YWQ9EIWQakuSqe
         ibODJVs9asNUrSsAYFRE35L9W++3NsQyUeiTtf4pfXOh6pt5pQEjHsA1VE3O4rf8grSm
         y4aeHxhAJVMID26zgWoFkbhlB/OzlpFFOot0rnlW4hZqG5o3KkfrNV+rtMoOAs0bTJv4
         A0Vw==
X-Gm-Message-State: AC+VfDySpTRHBUxGnbujtAuFCSWNX2qGV/UaB+BFRjdpYwGTsOUl+v56
        cUUPlP5o6YX//He73J1Ugz/zyNHicXq/GTfndizH6Q==
X-Google-Smtp-Source: ACHHUZ5aVQALCRD5kYkhKNHKQn+CEYfY28I1L9WGU8pgT52by/oZBRlGjTC2SSNFa7Iziie+83o7BQ==
X-Received: by 2002:a05:6a21:620f:b0:119:be71:1596 with SMTP id wm15-20020a056a21620f00b00119be711596mr1958758pzb.13.1686754774248;
        Wed, 14 Jun 2023 07:59:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m26-20020a056a00165a00b0064f71d8adf8sm10432750pfc.208.2023.06.14.07.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 07:59:33 -0700 (PDT)
Message-ID: <6489d5d5.050a0220.906e.5096@mx.google.com>
Date:   Wed, 14 Jun 2023 07:59:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.34
Subject: stable/linux-6.1.y baseline: 176 runs, 11 regressions (v6.1.34)
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

stable/linux-6.1.y baseline: 176 runs, 11 regressions (v6.1.34)

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

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

qemu_i386                    | i386   | lab-baylibre  | gcc-10   | i386_def=
config               | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-6.1.y/kernel/=
v6.1.34/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-6.1.y
  Describe: v6.1.34
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      ca87e77a2ef8b298aa9f69658d5898e72ee450fe =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6489a00fcd2444238430614d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.34/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.34/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489a00fcd24442384306152
        failing since 75 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-14T11:09:45.360516  + set +x

    2023-06-14T11:09:45.367161  <8>[   11.225994] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10723342_1.4.2.3.1>

    2023-06-14T11:09:45.471683  / # #

    2023-06-14T11:09:45.572497  export SHELL=3D/bin/sh

    2023-06-14T11:09:45.572726  #

    2023-06-14T11:09:45.673261  / # export SHELL=3D/bin/sh. /lava-10723342/=
environment

    2023-06-14T11:09:45.673472  =


    2023-06-14T11:09:45.774023  / # . /lava-10723342/environment/lava-10723=
342/bin/lava-test-runner /lava-10723342/1

    2023-06-14T11:09:45.774312  =


    2023-06-14T11:09:45.780164  / # /lava-10723342/bin/lava-test-runner /la=
va-10723342/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6489a001d10f66cd7c3062aa

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.34/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.34/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489a001d10f66cd7c3062af
        failing since 75 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-14T11:09:41.409590  + set<8>[   11.149051] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10723299_1.4.2.3.1>

    2023-06-14T11:09:41.410187   +x

    2023-06-14T11:09:41.514890  / # #

    2023-06-14T11:09:41.617493  export SHELL=3D/bin/sh

    2023-06-14T11:09:41.618278  #

    2023-06-14T11:09:41.719996  / # export SHELL=3D/bin/sh. /lava-10723299/=
environment

    2023-06-14T11:09:41.720779  =


    2023-06-14T11:09:41.822404  / # . /lava-10723299/environment/lava-10723=
299/bin/lava-test-runner /lava-10723299/1

    2023-06-14T11:09:41.823682  =


    2023-06-14T11:09:41.828741  / # /lava-10723299/bin/lava-test-runner /la=
va-10723299/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64899ffca3d630d78d306152

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.34/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.34/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64899ffca3d630d78d306157
        failing since 75 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-14T11:09:25.833126  <8>[   10.737048] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10723304_1.4.2.3.1>

    2023-06-14T11:09:25.836382  + set +x

    2023-06-14T11:09:25.941558  #

    2023-06-14T11:09:25.942720  =


    2023-06-14T11:09:26.044478  / # #export SHELL=3D/bin/sh

    2023-06-14T11:09:26.045263  =


    2023-06-14T11:09:26.146743  / # export SHELL=3D/bin/sh. /lava-10723304/=
environment

    2023-06-14T11:09:26.147563  =


    2023-06-14T11:09:26.249151  / # . /lava-10723304/environment/lava-10723=
304/bin/lava-test-runner /lava-10723304/1

    2023-06-14T11:09:26.250336  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64899ffc5b935d9381306157

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.34/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.34/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64899ffc5b935d938130615c
        failing since 75 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-14T11:09:39.361708  + set +x

    2023-06-14T11:09:39.368301  <8>[   11.962845] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10723276_1.4.2.3.1>

    2023-06-14T11:09:39.472779  / # #

    2023-06-14T11:09:39.573535  export SHELL=3D/bin/sh

    2023-06-14T11:09:39.573734  #

    2023-06-14T11:09:39.674339  / # export SHELL=3D/bin/sh. /lava-10723276/=
environment

    2023-06-14T11:09:39.674540  =


    2023-06-14T11:09:39.775074  / # . /lava-10723276/environment/lava-10723=
276/bin/lava-test-runner /lava-10723276/1

    2023-06-14T11:09:39.775398  =


    2023-06-14T11:09:39.779893  / # /lava-10723276/bin/lava-test-runner /la=
va-10723276/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64899ff4ad39ca5e0e306154

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.34/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.34/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64899ff4ad39ca5e0e306159
        failing since 75 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-14T11:09:22.531029  <8>[   10.017042] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10723314_1.4.2.3.1>

    2023-06-14T11:09:22.534325  + set +x

    2023-06-14T11:09:22.638611  / # #

    2023-06-14T11:09:22.739109  export SHELL=3D/bin/sh

    2023-06-14T11:09:22.739257  #

    2023-06-14T11:09:22.839746  / # export SHELL=3D/bin/sh. /lava-10723314/=
environment

    2023-06-14T11:09:22.839892  =


    2023-06-14T11:09:22.940346  / # . /lava-10723314/environment/lava-10723=
314/bin/lava-test-runner /lava-10723314/1

    2023-06-14T11:09:22.940576  =


    2023-06-14T11:09:22.945865  / # /lava-10723314/bin/lava-test-runner /la=
va-10723314/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6489a002d10f66cd7c3062b8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.34/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.34/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489a002d10f66cd7c3062bd
        failing since 75 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-14T11:09:30.970324  + set<8>[   10.855499] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10723283_1.4.2.3.1>

    2023-06-14T11:09:30.970404   +x

    2023-06-14T11:09:31.074860  / # #

    2023-06-14T11:09:31.175399  export SHELL=3D/bin/sh

    2023-06-14T11:09:31.175572  #

    2023-06-14T11:09:31.276027  / # export SHELL=3D/bin/sh. /lava-10723283/=
environment

    2023-06-14T11:09:31.276203  =


    2023-06-14T11:09:31.376701  / # . /lava-10723283/environment/lava-10723=
283/bin/lava-test-runner /lava-10723283/1

    2023-06-14T11:09:31.377004  =


    2023-06-14T11:09:31.381982  / # /lava-10723283/bin/lava-test-runner /la=
va-10723283/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64899ff6ad39ca5e0e306166

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.34/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.34/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64899ff6ad39ca5e0e30616b
        failing since 75 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-14T11:09:25.876945  <8>[   11.941943] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10723325_1.4.2.3.1>

    2023-06-14T11:09:25.981110  / # #

    2023-06-14T11:09:26.081755  export SHELL=3D/bin/sh

    2023-06-14T11:09:26.081925  #

    2023-06-14T11:09:26.182448  / # export SHELL=3D/bin/sh. /lava-10723325/=
environment

    2023-06-14T11:09:26.182628  =


    2023-06-14T11:09:26.283102  / # . /lava-10723325/environment/lava-10723=
325/bin/lava-test-runner /lava-10723325/1

    2023-06-14T11:09:26.283402  =


    2023-06-14T11:09:26.287881  / # /lava-10723325/bin/lava-test-runner /la=
va-10723325/1

    2023-06-14T11:09:26.294786  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6489a06ff2151c8d9030617a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.34/arm=
64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8173-elm-hana=
.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.34/arm=
64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8173-elm-hana=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6489a06ff2151c8d90306=
17b
        new failure (last pass: v6.1.29) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64899ff9d10f66cd7c306172

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.34/arm=
64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui-ja=
cuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.34/arm=
64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui-ja=
cuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/64899ff9d10f66cd7c306181
        failing since 33 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-06-14T11:09:38.705499  /lava-10723237/1/../bin/lava-test-case

    2023-06-14T11:09:38.711952  <8>[   22.884842] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64899ff9d10f66cd7c30620d
        failing since 33 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-06-14T11:09:33.250732  + set +x

    2023-06-14T11:09:33.257438  <8>[   17.428482] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10723237_1.5.2.3.1>

    2023-06-14T11:09:33.364689  / # #

    2023-06-14T11:09:33.465313  export SHELL=3D/bin/sh

    2023-06-14T11:09:33.465505  #

    2023-06-14T11:09:33.566063  / # export SHELL=3D/bin/sh. /lava-10723237/=
environment

    2023-06-14T11:09:33.566268  =


    2023-06-14T11:09:33.666792  / # . /lava-10723237/environment/lava-10723=
237/bin/lava-test-runner /lava-10723237/1

    2023-06-14T11:09:33.667091  =


    2023-06-14T11:09:33.671908  / # /lava-10723237/bin/lava-test-runner /la=
va-10723237/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_i386                    | i386   | lab-baylibre  | gcc-10   | i386_def=
config               | 1          =


  Details:     https://kernelci.org/test/plan/id/64899f9702895fda4130619f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.34/i38=
6/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_i386.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.34/i38=
6/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_i386.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64899f9702895fda41306=
1a0
        new failure (last pass: v6.1.33) =

 =20
