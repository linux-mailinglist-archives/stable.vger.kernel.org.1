Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F98779730
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 20:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjHKSlg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 14:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236359AbjHKSlV (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 14:41:21 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD3D30DC
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 11:41:18 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-686b879f605so1772215b3a.1
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 11:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691779277; x=1692384077;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LyomMT+o5rSrOM2xVOS0Z4FNGQlKdYsG+xgHrif16/M=;
        b=QDpB9/yiY82kYzjhW2Gz6TQZ4s3srWv2Qkw2137kNjZJ8AOgbkoOZhtg6ffVnKw8IN
         X3nFpoPOPlWVzzHTy2WcqdLn3blH/A6zJFa1K3zQIA0mlSrZEVFhGDQKdKuQ6Gc1v+C+
         859hJXAABJJ3yqAzU2ZkNDwb8kwNi3emCCTC5CjxAB6X4EML2pXydLQoraLBW2zrbEuw
         QNqwPqQHJhODsV69rmkOdIyBU6r0WwfYKfYFOn5A9obSqTljGuDAEVjif4ynw5xqGAm2
         ybNAdpI2Azn0d2nm63e5o+5fRGC7x2wjFCD5SMUeJY4n87FMf4d2qJ+E2GsHpc7C7KSW
         q3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691779277; x=1692384077;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LyomMT+o5rSrOM2xVOS0Z4FNGQlKdYsG+xgHrif16/M=;
        b=J1VHt7R3EBoRB9ZZ6zLuH9F305Vjjeu/L++15Xlh/tRmr5OAQzWxNiP/11Guz7wtSV
         bIRM1FsWlu7d2u1Ry9nl5SvDwDN7zgbtkP+D+7/TZQjSv1MwhO3PnDsX209BY7qvPJWm
         I4cYu6MXPh0GYDiXq4dq2/VC2s6xKYz+xF+cb93fmtSE87g3ynoS9F3T1cWpQEBtjuXA
         YttQd0ycVvo3Fcq+kKGEZ6UZAdqZIyKvZtIWXw3v129xtFZ5EtwN4NaLSX46YAKNBUlk
         mwsx9poqvapezz484vglmCX7MG8A/aQHX8za6psY2isGNc0ZoIyf/3mW/1+8ePhErKLs
         Mq+w==
X-Gm-Message-State: AOJu0YzjUbwq4g4w5QfC4+7q7hgxXFO/5OjjjEAA7o2vesHHUCrNDIzK
        81Ip9jgds4PrtshkPfTc/HH+y8sZr2xX0dvAwHZiZA==
X-Google-Smtp-Source: AGHT+IHPmLTm9sW0lce+WizV0Hc85QzfhTgXTYcKTD+Gy9rnYhzWSuNUaTupk13pecm6wxEyvH4Xqg==
X-Received: by 2002:a05:6a00:9a3:b0:668:9bf9:fa70 with SMTP id u35-20020a056a0009a300b006689bf9fa70mr3342694pfg.34.1691779276965;
        Fri, 11 Aug 2023 11:41:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y2-20020a62b502000000b00687cb400f4asm3586123pfe.24.2023.08.11.11.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 11:41:16 -0700 (PDT)
Message-ID: <64d680cc.620a0220.a213d.7422@mx.google.com>
Date:   Fri, 11 Aug 2023 11:41:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.125-92-g24c4de4069cb
X-Kernelci-Tree: stable
X-Kernelci-Branch: linux-5.15.y
Subject: stable/linux-5.15.y baseline: 192 runs,
 23 regressions (v5.15.125-92-g24c4de4069cb)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-5.15.y baseline: 192 runs, 23 regressions (v5.15.125-92-g24c4d=
e4069cb)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.15.y/kernel=
/v5.15.125-92-g24c4de4069cb/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.15.y
  Describe: v5.15.125-92-g24c4de4069cb
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      24c4de4069cbce796a1c71166240807d617cd652 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d64b8b00096ab9cf35b217

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d64b8b00096ab9cf35b21c
        failing since 134 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-11T14:53:45.461761  + set +x

    2023-08-11T14:53:45.468009  <8>[   11.183784] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11264127_1.4.2.3.1>

    2023-08-11T14:53:45.572623  / # #

    2023-08-11T14:53:45.673135  export SHELL=3D/bin/sh

    2023-08-11T14:53:45.673294  #

    2023-08-11T14:53:45.773939  / # export SHELL=3D/bin/sh. /lava-11264127/=
environment

    2023-08-11T14:53:45.774671  =


    2023-08-11T14:53:45.876309  / # . /lava-11264127/environment/lava-11264=
127/bin/lava-test-runner /lava-11264127/1

    2023-08-11T14:53:45.877578  =


    2023-08-11T14:53:45.883952  / # /lava-11264127/bin/lava-test-runner /la=
va-11264127/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64d64d7fc487694a7735b1f9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/la=
b-collabora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/la=
b-collabora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d64d7fc487694a7735b1fe
        failing since 134 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-11T15:02:00.568127  <8>[   11.206790] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11264253_1.4.2.3.1>

    2023-08-11T15:02:00.571816  + set +x

    2023-08-11T15:02:00.676181  / # #

    2023-08-11T15:02:00.776737  export SHELL=3D/bin/sh

    2023-08-11T15:02:00.776934  #

    2023-08-11T15:02:00.877424  / # export SHELL=3D/bin/sh. /lava-11264253/=
environment

    2023-08-11T15:02:00.877632  =


    2023-08-11T15:02:00.978212  / # . /lava-11264253/environment/lava-11264=
253/bin/lava-test-runner /lava-11264253/1

    2023-08-11T15:02:00.978461  =


    2023-08-11T15:02:00.984223  / # /lava-11264253/bin/lava-test-runner /la=
va-11264253/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d64b81351882185735b215

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d64b81351882185735b21a
        failing since 134 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-11T14:53:33.907074  + set<8>[   11.225581] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11264157_1.4.2.3.1>

    2023-08-11T14:53:33.907490   +x

    2023-08-11T14:53:34.013743  / # #

    2023-08-11T14:53:34.115672  export SHELL=3D/bin/sh

    2023-08-11T14:53:34.116413  #

    2023-08-11T14:53:34.217784  / # export SHELL=3D/bin/sh. /lava-11264157/=
environment

    2023-08-11T14:53:34.218415  =


    2023-08-11T14:53:34.319720  / # . /lava-11264157/environment/lava-11264=
157/bin/lava-test-runner /lava-11264157/1

    2023-08-11T14:53:34.320836  =


    2023-08-11T14:53:34.325540  / # /lava-11264157/bin/lava-test-runner /la=
va-11264157/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64d64d8a205e79304435b205

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/la=
b-collabora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/la=
b-collabora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d64d8a205e79304435b20a
        failing since 134 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-11T15:02:12.207482  + set +x

    2023-08-11T15:02:12.210513  <8>[   10.266877] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11264254_1.4.2.3.1>

    2023-08-11T15:02:12.315147  / # #

    2023-08-11T15:02:12.415804  export SHELL=3D/bin/sh

    2023-08-11T15:02:12.415986  #

    2023-08-11T15:02:12.516494  / # export SHELL=3D/bin/sh. /lava-11264254/=
environment

    2023-08-11T15:02:12.516734  =


    2023-08-11T15:02:12.617320  / # . /lava-11264254/environment/lava-11264=
254/bin/lava-test-runner /lava-11264254/1

    2023-08-11T15:02:12.617644  =


    2023-08-11T15:02:12.622153  / # /lava-11264254/bin/lava-test-runner /la=
va-11264254/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d64b83351882185735b225

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d64b83351882185735b22a
        failing since 134 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-11T14:53:35.418970  <8>[   10.301129] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11264161_1.4.2.3.1>

    2023-08-11T14:53:35.423732  + set +x

    2023-08-11T14:53:35.529662  #

    2023-08-11T14:53:35.632723  / # #export SHELL=3D/bin/sh

    2023-08-11T14:53:35.632910  =


    2023-08-11T14:53:35.733444  / # export SHELL=3D/bin/sh. /lava-11264161/=
environment

    2023-08-11T14:53:35.733664  =


    2023-08-11T14:53:35.834250  / # . /lava-11264161/environment/lava-11264=
161/bin/lava-test-runner /lava-11264161/1

    2023-08-11T14:53:35.834978  =


    2023-08-11T14:53:35.840200  / # /lava-11264161/bin/lava-test-runner /la=
va-11264161/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64d64d74c487694a7735b1e9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/la=
b-collabora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/la=
b-collabora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d64d74c487694a7735b1ee
        failing since 134 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-11T15:02:06.155702  + set +x

    2023-08-11T15:02:06.162526  <8>[    9.194408] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11264247_1.4.2.3.1>

    2023-08-11T15:02:06.270054  / # #

    2023-08-11T15:02:06.372294  export SHELL=3D/bin/sh

    2023-08-11T15:02:06.373062  #

    2023-08-11T15:02:06.474494  / # export SHELL=3D/bin/sh. /lava-11264247/=
environment

    2023-08-11T15:02:06.475198  =


    2023-08-11T15:02:06.576730  / # . /lava-11264247/environment/lava-11264=
247/bin/lava-test-runner /lava-11264247/1

    2023-08-11T15:02:06.577824  =


    2023-08-11T15:02:06.583224  / # /lava-11264247/bin/lava-test-runner /la=
va-11264247/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/64d6490cde0a27db3735b1fb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm283=
6-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm283=
6-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d6490cde0a27db3735b200
        failing since 15 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-08-11T14:44:47.094261  / # #

    2023-08-11T14:44:47.196581  export SHELL=3D/bin/sh

    2023-08-11T14:44:47.197392  #

    2023-08-11T14:44:47.298845  / # export SHELL=3D/bin/sh. /lava-11263995/=
environment

    2023-08-11T14:44:47.299622  =


    2023-08-11T14:44:47.401109  / # . /lava-11263995/environment/lava-11263=
995/bin/lava-test-runner /lava-11263995/1

    2023-08-11T14:44:47.402333  =


    2023-08-11T14:44:47.417494  / # /lava-11263995/bin/lava-test-runner /la=
va-11263995/1

    2023-08-11T14:44:47.525336  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-11T14:44:47.525849  + cd /lava-11263995/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d64cf773aebbe7f935b1ed

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d64cf773aebbe7f935b=
1ee
        failing since 128 days (last pass: v5.15.105, first fail: v5.15.106=
) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d64ba0505a539f3935b1fb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubiet=
ruck.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubiet=
ruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d64ba0505a539f3935b200
        failing since 204 days (last pass: v5.15.82, first fail: v5.15.89)

    2023-08-11T14:54:14.580682  <8>[    9.981447] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3737257_1.5.2.4.1>
    2023-08-11T14:54:14.690429  / # #
    2023-08-11T14:54:14.793664  export SHELL=3D/bin/sh
    2023-08-11T14:54:14.794674  #
    2023-08-11T14:54:14.896780  / # export SHELL=3D/bin/sh. /lava-3737257/e=
nvironment
    2023-08-11T14:54:14.897825  =

    2023-08-11T14:54:14.999900  / # . /lava-3737257/environment/lava-373725=
7/bin/lava-test-runner /lava-3737257/1
    2023-08-11T14:54:15.001699  =

    2023-08-11T14:54:15.006151  / # /lava-3737257/bin/lava-test-runner /lav=
a-3737257/1
    2023-08-11T14:54:15.085397  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d64e16451b97716735b360

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d64e16451b97716735b363
        failing since 161 days (last pass: v5.15.79, first fail: v5.15.97)

    2023-08-11T15:04:37.292746  [   11.061618] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1242913_1.5.2.4.1>
    2023-08-11T15:04:37.397964  =

    2023-08-11T15:04:37.499120  / # #export SHELL=3D/bin/sh
    2023-08-11T15:04:37.499538  =

    2023-08-11T15:04:37.600479  / # export SHELL=3D/bin/sh. /lava-1242913/e=
nvironment
    2023-08-11T15:04:37.600880  =

    2023-08-11T15:04:37.701838  / # . /lava-1242913/environment/lava-124291=
3/bin/lava-test-runner /lava-1242913/1
    2023-08-11T15:04:37.702499  =

    2023-08-11T15:04:37.706484  / # /lava-1242913/bin/lava-test-runner /lav=
a-1242913/1
    2023-08-11T15:04:37.721815  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d64c0313e95c22a235b200

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d64c0313e95c22a235b205
        failing since 134 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-11T14:55:50.101382  + set +x

    2023-08-11T14:55:50.108003  <8>[   11.141270] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11264133_1.4.2.3.1>

    2023-08-11T14:55:50.212096  / # #

    2023-08-11T14:55:50.312737  export SHELL=3D/bin/sh

    2023-08-11T14:55:50.312937  #

    2023-08-11T14:55:50.413414  / # export SHELL=3D/bin/sh. /lava-11264133/=
environment

    2023-08-11T14:55:50.413616  =


    2023-08-11T14:55:50.514147  / # . /lava-11264133/environment/lava-11264=
133/bin/lava-test-runner /lava-11264133/1

    2023-08-11T14:55:50.514630  =


    2023-08-11T14:55:50.520128  / # /lava-11264133/bin/lava-test-runner /la=
va-11264133/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64d64d8abf0388adaf35b218

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/la=
b-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/la=
b-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d64d8abf0388adaf35b21d
        failing since 134 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-11T15:02:25.818221  + set +x

    2023-08-11T15:02:25.825133  <8>[   12.599078] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11264257_1.4.2.3.1>

    2023-08-11T15:02:25.933126  / # #

    2023-08-11T15:02:26.035841  export SHELL=3D/bin/sh

    2023-08-11T15:02:26.036666  #

    2023-08-11T15:02:26.138205  / # export SHELL=3D/bin/sh. /lava-11264257/=
environment

    2023-08-11T15:02:26.139046  =


    2023-08-11T15:02:26.240697  / # . /lava-11264257/environment/lava-11264=
257/bin/lava-test-runner /lava-11264257/1

    2023-08-11T15:02:26.242128  =


    2023-08-11T15:02:26.247174  / # /lava-11264257/bin/lava-test-runner /la=
va-11264257/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d64c1a13e95c22a235b225

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d64c1a13e95c22a235b22a
        failing since 134 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-11T14:56:03.670353  + set +x

    2023-08-11T14:56:03.676771  <8>[    8.039509] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11264165_1.4.2.3.1>

    2023-08-11T14:56:03.783663  #

    2023-08-11T14:56:03.784937  =


    2023-08-11T14:56:03.886687  / # #export SHELL=3D/bin/sh

    2023-08-11T14:56:03.887374  =


    2023-08-11T14:56:03.988828  / # export SHELL=3D/bin/sh. /lava-11264165/=
environment

    2023-08-11T14:56:03.989737  =


    2023-08-11T14:56:04.091245  / # . /lava-11264165/environment/lava-11264=
165/bin/lava-test-runner /lava-11264165/1

    2023-08-11T14:56:04.092317  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64d64d7646bd14381535b1ed

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/la=
b-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/la=
b-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d64d7646bd14381535b1f2
        failing since 134 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-11T15:01:51.665277  + set<8>[   11.548223] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11264249_1.4.2.3.1>

    2023-08-11T15:01:51.665969   +x

    2023-08-11T15:01:51.774032  #

    2023-08-11T15:01:51.775510  =


    2023-08-11T15:01:51.877384  / # #export SHELL=3D/bin/sh

    2023-08-11T15:01:51.878419  =


    2023-08-11T15:01:51.980200  / # export SHELL=3D/bin/sh. /lava-11264249/=
environment

    2023-08-11T15:01:51.981143  =


    2023-08-11T15:01:52.082704  / # . /lava-11264249/environment/lava-11264=
249/bin/lava-test-runner /lava-11264249/1

    2023-08-11T15:01:52.084120  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d64b8a505a539f3935b1da

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d64b8a505a539f3935b1df
        failing since 134 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-11T14:53:48.388986  + set<8>[   11.038476] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11264167_1.4.2.3.1>

    2023-08-11T14:53:48.389074   +x

    2023-08-11T14:53:48.493445  / # #

    2023-08-11T14:53:48.594080  export SHELL=3D/bin/sh

    2023-08-11T14:53:48.594245  #

    2023-08-11T14:53:48.694701  / # export SHELL=3D/bin/sh. /lava-11264167/=
environment

    2023-08-11T14:53:48.694908  =


    2023-08-11T14:53:48.795464  / # . /lava-11264167/environment/lava-11264=
167/bin/lava-test-runner /lava-11264167/1

    2023-08-11T14:53:48.795768  =


    2023-08-11T14:53:48.800404  / # /lava-11264167/bin/lava-test-runner /la=
va-11264167/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64d64d89c487694a7735b206

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/la=
b-collabora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/la=
b-collabora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d64d89c487694a7735b20b
        failing since 134 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-11T15:02:12.485582  <8>[   13.035459] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11264263_1.4.2.3.1>

    2023-08-11T15:02:12.590460  / # #

    2023-08-11T15:02:12.691011  export SHELL=3D/bin/sh

    2023-08-11T15:02:12.691244  #

    2023-08-11T15:02:12.791804  / # export SHELL=3D/bin/sh. /lava-11264263/=
environment

    2023-08-11T15:02:12.792029  =


    2023-08-11T15:02:12.892734  / # . /lava-11264263/environment/lava-11264=
263/bin/lava-test-runner /lava-11264263/1

    2023-08-11T15:02:12.894226  =


    2023-08-11T15:02:12.898874  / # /lava-11264263/bin/lava-test-runner /la=
va-11264263/1

    2023-08-11T15:02:12.924088  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d64b8e505a539f3935b1e8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d64b8e505a539f3935b1ed
        failing since 134 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-11T14:53:43.189700  + set<8>[   11.463868] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11264148_1.4.2.3.1>

    2023-08-11T14:53:43.189788   +x

    2023-08-11T14:53:43.293901  / # #

    2023-08-11T14:53:43.394587  export SHELL=3D/bin/sh

    2023-08-11T14:53:43.394809  #

    2023-08-11T14:53:43.495385  / # export SHELL=3D/bin/sh. /lava-11264148/=
environment

    2023-08-11T14:53:43.495637  =


    2023-08-11T14:53:43.596266  / # . /lava-11264148/environment/lava-11264=
148/bin/lava-test-runner /lava-11264148/1

    2023-08-11T14:53:43.596595  =


    2023-08-11T14:53:43.601562  / # /lava-11264148/bin/lava-test-runner /la=
va-11264148/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64d64d6cbf0388adaf35b1db

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/la=
b-collabora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/la=
b-collabora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d64d6cbf0388adaf35b1e0
        failing since 134 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-11T15:01:43.339155  + <8>[   13.330067] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11264252_1.4.2.3.1>

    2023-08-11T15:01:43.339240  set +x

    2023-08-11T15:01:43.443854  / # #

    2023-08-11T15:01:43.544410  export SHELL=3D/bin/sh

    2023-08-11T15:01:43.544564  #

    2023-08-11T15:01:43.645178  / # export SHELL=3D/bin/sh. /lava-11264252/=
environment

    2023-08-11T15:01:43.645438  =


    2023-08-11T15:01:43.745975  / # . /lava-11264252/environment/lava-11264=
252/bin/lava-test-runner /lava-11264252/1

    2023-08-11T15:01:43.746254  =


    2023-08-11T15:01:43.750868  / # /lava-11264252/bin/lava-test-runner /la=
va-11264252/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64d64eb40e76808a8f35b240

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-coll=
abora/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-coll=
abora/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d64eb40e76808a8f35b=
241
        failing since 199 days (last pass: v5.15.89, first fail: v5.15.90) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d64dbe675da85a7435b22e

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d64dbe675da85a7435b233
        failing since 15 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-08-11T15:04:46.375705  / # #

    2023-08-11T15:04:46.476216  export SHELL=3D/bin/sh

    2023-08-11T15:04:46.476347  #

    2023-08-11T15:04:46.576807  / # export SHELL=3D/bin/sh. /lava-11264288/=
environment

    2023-08-11T15:04:46.576998  =


    2023-08-11T15:04:46.677548  / # . /lava-11264288/environment/lava-11264=
288/bin/lava-test-runner /lava-11264288/1

    2023-08-11T15:04:46.677808  =


    2023-08-11T15:04:46.689626  / # /lava-11264288/bin/lava-test-runner /la=
va-11264288/1

    2023-08-11T15:04:46.743209  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-11T15:04:46.743285  + cd /lav<8>[   15.969966] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11264288_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d64ff0dcdff2b03d35b1dd

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-r8=
a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-r8=
a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d64ff0dcdff2b03d35b1e2
        failing since 15 days (last pass: v5.15.118, first fail: v5.15.123)

    2023-08-11T15:14:17.143251  / # #

    2023-08-11T15:14:17.243994  export SHELL=3D/bin/sh

    2023-08-11T15:14:17.244670  #

    2023-08-11T15:14:17.346099  / # export SHELL=3D/bin/sh. /lava-11264531/=
environment

    2023-08-11T15:14:17.346824  =


    2023-08-11T15:14:17.448299  / # . /lava-11264531/environment/lava-11264=
531/bin/lava-test-runner /lava-11264531/1

    2023-08-11T15:14:17.449461  =


    2023-08-11T15:14:17.493437  / # /lava-11264531/bin/lava-test-runner /la=
va-11264531/1

    2023-08-11T15:14:17.591265  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-11T15:14:17.591779  + cd /lava-11264531/1/tests/1_bootrr
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d64de3e1a9e8f98535b1f1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulc=
b.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulc=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d64de3e1a9e8f98535b1f6
        failing since 15 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-08-11T15:04:00.550433  / # #

    2023-08-11T15:04:01.629248  export SHELL=3D/bin/sh

    2023-08-11T15:04:01.631026  #

    2023-08-11T15:04:03.120955  / # export SHELL=3D/bin/sh. /lava-11264277/=
environment

    2023-08-11T15:04:03.122674  =


    2023-08-11T15:04:05.845831  / # . /lava-11264277/environment/lava-11264=
277/bin/lava-test-runner /lava-11264277/1

    2023-08-11T15:04:05.848066  =


    2023-08-11T15:04:05.863014  / # /lava-11264277/bin/lava-test-runner /la=
va-11264277/1

    2023-08-11T15:04:05.922131  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-11T15:04:05.922638  + cd /lava-112642<8>[   25.574149] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11264277_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d64dbd675da85a7435b221

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125-=
92-g24c4de4069cb/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d64dbd675da85a7435b226
        failing since 15 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-08-11T15:04:59.123407  / # #

    2023-08-11T15:04:59.223992  export SHELL=3D/bin/sh

    2023-08-11T15:04:59.224143  #

    2023-08-11T15:04:59.324758  / # export SHELL=3D/bin/sh. /lava-11264286/=
environment

    2023-08-11T15:04:59.324905  =


    2023-08-11T15:04:59.425477  / # . /lava-11264286/environment/lava-11264=
286/bin/lava-test-runner /lava-11264286/1

    2023-08-11T15:04:59.425763  =


    2023-08-11T15:04:59.437185  / # /lava-11264286/bin/lava-test-runner /la=
va-11264286/1

    2023-08-11T15:04:59.500001  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-11T15:04:59.500473  + cd /lava-1126428<8>[   16.829834] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11264286_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
