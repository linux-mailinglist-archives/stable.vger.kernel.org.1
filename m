Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9D2789864
	for <lists+stable@lfdr.de>; Sat, 26 Aug 2023 19:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjHZRW2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 26 Aug 2023 13:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjHZRWH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 26 Aug 2023 13:22:07 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A24C9
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 10:22:01 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1c0fcbf7ae4so1393411fac.0
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 10:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693070520; x=1693675320;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UNmpKhxTvoqWZx6kGBdo/E27Y78n/IVfM2FaWCwOPKs=;
        b=YL3Bb/ihnUuKAPStLntp2mT1TnJZ051hA8c8VngQp8HVYveA/WZhvMacbQgAKLcKLm
         rUkE9pmogJTjFnLUMVp2qEXdExd3SyGQxemAc0OVpUfNIGya6uM8afcXs8ZGHu0sZUGa
         6ngSDh2/GH4LrV/MuMTKig7jmdsHGwR252BobC6rtI+KQtzsZHQ54Y9AMCdcxs6VN3c2
         CAfp5CGvC6ORGpRu2ZNAuRXBVUqY2s5CcOd+LJfQhDefU8RKBfsw0m2s6Lft+3TcZElU
         343o7AjgYhagRHSzdrSgjXLcWCXuRtDgxSu2KzvXHn2eM37g3bUsZ3d6sKHmZozNsp8H
         H5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693070520; x=1693675320;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UNmpKhxTvoqWZx6kGBdo/E27Y78n/IVfM2FaWCwOPKs=;
        b=HRCRtMKpdVeADlqkBplkjth9yE0rSCEvx1aoLdEPh5BQz1/p9ucY8Q8bWiN6yLNYgG
         7RD3Zx5hQZbcdw1S9sXUgVPr+qT6UB0CGx/bQ1KJwiUu9wrCG33Hlob57hpC9SblH40k
         EDLZPgGMZ6XlOsmHyV4xuRWUbStKyUh+oUnaHoxCh7c3xC4PP1fuJIQ719mJ26rHOfzH
         8TIy1z594cx5P41uf6/HRy0ozJqvrC2vHu+eqsb/fgdFX8dK4eNcPJ6DXQdke4zf2mxg
         Qbiub7j3XgdSq+qgzleHCrzwqr9BbsTtNtlHN4NsLK6bqg2D3xLncrmE3H1peNCGPsFb
         gx6g==
X-Gm-Message-State: AOJu0Yzdj63N4w4uWCmLvgMTxuURn2Px/T8mP5wOWdk7+D2Y+bQWPPTI
        okd6egfW8PunymGchUJQer9wju3ryBPpfELyI5o=
X-Google-Smtp-Source: AGHT+IGncyu5xO71Y/b4iG0q2z2JfdWpUKaBXXP3QYooah1Kr+tBtf3N8ez+6Xacidc+9qfUuswzAg==
X-Received: by 2002:a05:6870:ec8c:b0:1ba:dbad:e70 with SMTP id eo12-20020a056870ec8c00b001badbad0e70mr7024014oab.21.1693070520105;
        Sat, 26 Aug 2023 10:22:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h7-20020a62b407000000b0068a53ac9d46sm3511124pfn.100.2023.08.26.10.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 10:21:59 -0700 (PDT)
Message-ID: <64ea34b7.620a0220.c0504.5c87@mx.google.com>
Date:   Sat, 26 Aug 2023 10:21:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.128
Subject: stable/linux-5.15.y baseline: 195 runs, 23 regressions (v5.15.128)
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

stable/linux-5.15.y baseline: 195 runs, 23 regressions (v5.15.128)

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
/v5.15.128/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.15.y
  Describe: v5.15.128
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      5ddfe5cc87167343bd4c17f776de7b7aa1475b0c =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e9fe7ecd91f239e2286dbe

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e9fe7ecd91f239e2286dc7
        failing since 149 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-26T13:30:16.482059  <8>[   10.748471] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11362183_1.4.2.3.1>

    2023-08-26T13:30:16.485683  + set +x

    2023-08-26T13:30:16.589787  / # #

    2023-08-26T13:30:16.690368  export SHELL=3D/bin/sh

    2023-08-26T13:30:16.690523  #

    2023-08-26T13:30:16.791052  / # export SHELL=3D/bin/sh. /lava-11362183/=
environment

    2023-08-26T13:30:16.791224  =


    2023-08-26T13:30:16.891738  / # . /lava-11362183/environment/lava-11362=
183/bin/lava-test-runner /lava-11362183/1

    2023-08-26T13:30:16.891980  =


    2023-08-26T13:30:16.897410  / # /lava-11362183/bin/lava-test-runner /la=
va-11362183/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64e9fee0c9b6bfd852286de5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e9fee0c9b6bfd852286dea
        failing since 149 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-26T13:32:02.132579  + set +x

    2023-08-26T13:32:02.139503  <8>[   11.716817] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11362200_1.4.2.3.1>

    2023-08-26T13:32:02.247850  / # #

    2023-08-26T13:32:02.350518  export SHELL=3D/bin/sh

    2023-08-26T13:32:02.351418  #

    2023-08-26T13:32:02.453283  / # export SHELL=3D/bin/sh. /lava-11362200/=
environment

    2023-08-26T13:32:02.454354  =


    2023-08-26T13:32:02.556032  / # . /lava-11362200/environment/lava-11362=
200/bin/lava-test-runner /lava-11362200/1

    2023-08-26T13:32:02.557416  =


    2023-08-26T13:32:02.562696  / # /lava-11362200/bin/lava-test-runner /la=
va-11362200/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e9fe7297b88e645c286dc8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e9fe7297b88e645c286dcd
        failing since 149 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-26T13:30:05.732610  + set<8>[   11.724879] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11362174_1.4.2.3.1>

    2023-08-26T13:30:05.733002   +x

    2023-08-26T13:30:05.839117  / # #

    2023-08-26T13:30:05.941245  export SHELL=3D/bin/sh

    2023-08-26T13:30:05.941935  #

    2023-08-26T13:30:06.043241  / # export SHELL=3D/bin/sh. /lava-11362174/=
environment

    2023-08-26T13:30:06.044037  =


    2023-08-26T13:30:06.145474  / # . /lava-11362174/environment/lava-11362=
174/bin/lava-test-runner /lava-11362174/1

    2023-08-26T13:30:06.146435  =


    2023-08-26T13:30:06.151316  / # /lava-11362174/bin/lava-test-runner /la=
va-11362174/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64e9fed7ecd0182ce5286dd9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e9fed7ecd0182ce5286dde
        failing since 149 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-26T13:31:43.979373  + <8>[   12.398166] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11362203_1.4.2.3.1>

    2023-08-26T13:31:43.979863  set +x

    2023-08-26T13:31:44.088066  / # #

    2023-08-26T13:31:44.190812  export SHELL=3D/bin/sh

    2023-08-26T13:31:44.191615  #

    2023-08-26T13:31:44.293203  / # export SHELL=3D/bin/sh. /lava-11362203/=
environment

    2023-08-26T13:31:44.294119  =


    2023-08-26T13:31:44.395980  / # . /lava-11362203/environment/lava-11362=
203/bin/lava-test-runner /lava-11362203/1

    2023-08-26T13:31:44.397481  =


    2023-08-26T13:31:44.402404  / # /lava-11362203/bin/lava-test-runner /la=
va-11362203/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e9fe7509913b76f1286d79

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e9fe7509913b76f1286d7e
        failing since 149 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-26T13:30:06.949039  <8>[    7.975394] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11362134_1.4.2.3.1>

    2023-08-26T13:30:06.952318  + set +x

    2023-08-26T13:30:07.057933  =


    2023-08-26T13:30:07.159567  / # #export SHELL=3D/bin/sh

    2023-08-26T13:30:07.160315  =


    2023-08-26T13:30:07.261792  / # export SHELL=3D/bin/sh. /lava-11362134/=
environment

    2023-08-26T13:30:07.262544  =


    2023-08-26T13:30:07.364018  / # . /lava-11362134/environment/lava-11362=
134/bin/lava-test-runner /lava-11362134/1

    2023-08-26T13:30:07.364413  =


    2023-08-26T13:30:07.369826  / # /lava-11362134/bin/lava-test-runner /la=
va-11362134/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64e9fec3ecd0182ce5286d94

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e9fec3ecd0182ce5286d99
        failing since 149 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-26T13:32:41.257072  <8>[    9.213735] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11362201_1.4.2.3.1>

    2023-08-26T13:32:41.260155  + set +x

    2023-08-26T13:32:41.364733  #

    2023-08-26T13:32:41.467190  / # #export SHELL=3D/bin/sh

    2023-08-26T13:32:41.468005  =


    2023-08-26T13:32:41.569475  / # export SHELL=3D/bin/sh. /lava-11362201/=
environment

    2023-08-26T13:32:41.570294  =


    2023-08-26T13:32:41.671858  / # . /lava-11362201/environment/lava-11362=
201/bin/lava-test-runner /lava-11362201/1

    2023-08-26T13:32:41.673061  =


    2023-08-26T13:32:41.678570  / # /lava-11362201/bin/lava-test-runner /la=
va-11362201/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/64e9fd8bef311906ce286d96

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e9fd8bef311906ce286d9b
        failing since 30 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-08-26T13:27:53.474466  / # #

    2023-08-26T13:27:53.576607  export SHELL=3D/bin/sh

    2023-08-26T13:27:53.577354  #

    2023-08-26T13:27:53.678765  / # export SHELL=3D/bin/sh. /lava-11362123/=
environment

    2023-08-26T13:27:53.679482  =


    2023-08-26T13:27:53.780967  / # . /lava-11362123/environment/lava-11362=
123/bin/lava-test-runner /lava-11362123/1

    2023-08-26T13:27:53.782069  =


    2023-08-26T13:27:53.798801  / # /lava-11362123/bin/lava-test-runner /la=
va-11362123/1

    2023-08-26T13:27:53.862743  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-26T13:27:53.905657  + cd /lava-11362123/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea000779587436d2286d6c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ea000779587436d2286=
d6d
        failing since 143 days (last pass: v5.15.105, first fail: v5.15.106=
) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64e9fec257c823bcde286dec

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e9fec257c823bcde286df1
        failing since 219 days (last pass: v5.15.82, first fail: v5.15.89)

    2023-08-26T13:31:21.005051  <8>[   10.073223] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-08-26T13:31:21.005248  + set +x
    2023-08-26T13:31:21.008324  <8>[   10.083946] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3750870_1.5.2.4.1>
    2023-08-26T13:31:21.128158  / # #
    2023-08-26T13:31:21.232150  export SHELL=3D/bin/sh
    2023-08-26T13:31:21.232692  #
    2023-08-26T13:31:21.340160  / # export SHELL=3D/bin/sh. /lava-3750870/e=
nvironment
    2023-08-26T13:31:21.344302  =

    2023-08-26T13:31:21.452152  / # . /lava-3750870/environment/lava-375087=
0/bin/lava-test-runner /lava-3750870/1
    2023-08-26T13:31:21.452863   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e9ff66aca6b2351e286d6c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e9ff66aca6b2351e286d73
        failing since 176 days (last pass: v5.15.79, first fail: v5.15.97)

    2023-08-26T13:34:11.270581  [   10.664771] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1246701_1.5.2.4.1>
    2023-08-26T13:34:11.375879  =

    2023-08-26T13:34:11.477050  / # #export SHELL=3D/bin/sh
    2023-08-26T13:34:11.477463  =

    2023-08-26T13:34:11.578413  / # export SHELL=3D/bin/sh. /lava-1246701/e=
nvironment
    2023-08-26T13:34:11.578819  =

    2023-08-26T13:34:11.679773  / # . /lava-1246701/environment/lava-124670=
1/bin/lava-test-runner /lava-1246701/1
    2023-08-26T13:34:11.680446  =

    2023-08-26T13:34:11.684421  / # /lava-1246701/bin/lava-test-runner /lav=
a-1246701/1
    2023-08-26T13:34:11.699927  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e9fe5b791358a4a8286d89

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e9fe5b791358a4a8286d8e
        failing since 149 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-26T13:30:08.590574  + set +x

    2023-08-26T13:30:08.596926  <8>[   10.645311] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11362147_1.4.2.3.1>

    2023-08-26T13:30:08.701786  / # #

    2023-08-26T13:30:08.802403  export SHELL=3D/bin/sh

    2023-08-26T13:30:08.802624  #

    2023-08-26T13:30:08.903186  / # export SHELL=3D/bin/sh. /lava-11362147/=
environment

    2023-08-26T13:30:08.903420  =


    2023-08-26T13:30:09.003993  / # . /lava-11362147/environment/lava-11362=
147/bin/lava-test-runner /lava-11362147/1

    2023-08-26T13:30:09.004279  =


    2023-08-26T13:30:09.008809  / # /lava-11362147/bin/lava-test-runner /la=
va-11362147/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64e9febf57c823bcde286dc3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e9febf57c823bcde286dc8
        failing since 149 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-26T13:31:46.823483  + set +x

    2023-08-26T13:31:46.830172  <8>[   11.791460] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11362191_1.4.2.3.1>

    2023-08-26T13:31:46.934715  / # #

    2023-08-26T13:31:47.035250  export SHELL=3D/bin/sh

    2023-08-26T13:31:47.035438  #

    2023-08-26T13:31:47.135980  / # export SHELL=3D/bin/sh. /lava-11362191/=
environment

    2023-08-26T13:31:47.136173  =


    2023-08-26T13:31:47.236727  / # . /lava-11362191/environment/lava-11362=
191/bin/lava-test-runner /lava-11362191/1

    2023-08-26T13:31:47.236993  =


    2023-08-26T13:31:47.241621  / # /lava-11362191/bin/lava-test-runner /la=
va-11362191/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e9fe69150285b8b7286d99

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e9fe69150285b8b7286d9e
        failing since 149 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-26T13:29:59.173895  + set +x<8>[   10.367397] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11362172_1.4.2.3.1>

    2023-08-26T13:29:59.173978  =


    2023-08-26T13:29:59.275664  #

    2023-08-26T13:29:59.275959  =


    2023-08-26T13:29:59.376567  / # #export SHELL=3D/bin/sh

    2023-08-26T13:29:59.376769  =


    2023-08-26T13:29:59.477285  / # export SHELL=3D/bin/sh. /lava-11362172/=
environment

    2023-08-26T13:29:59.477471  =


    2023-08-26T13:29:59.578051  / # . /lava-11362172/environment/lava-11362=
172/bin/lava-test-runner /lava-11362172/1

    2023-08-26T13:29:59.578374  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64e9feacc417b8b3a1286e13

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e9feacc417b8b3a1286e18
        failing since 149 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-26T13:32:23.937526  + set +x<8>[   11.400334] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11362186_1.4.2.3.1>

    2023-08-26T13:32:23.937632  =


    2023-08-26T13:32:24.039889  =


    2023-08-26T13:32:24.140414  / # #export SHELL=3D/bin/sh

    2023-08-26T13:32:24.140613  =


    2023-08-26T13:32:24.241128  / # export SHELL=3D/bin/sh. /lava-11362186/=
environment

    2023-08-26T13:32:24.241317  =


    2023-08-26T13:32:24.341870  / # . /lava-11362186/environment/lava-11362=
186/bin/lava-test-runner /lava-11362186/1

    2023-08-26T13:32:24.342175  =


    2023-08-26T13:32:24.346758  / # /lava-11362186/bin/lava-test-runner /la=
va-11362186/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e9fe7609913b76f1286d8f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e9fe7609913b76f1286d94
        failing since 149 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-26T13:30:06.635209  + set<8>[    8.584380] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11362145_1.4.2.3.1>

    2023-08-26T13:30:06.635776   +x

    2023-08-26T13:30:06.743644  / # #

    2023-08-26T13:30:06.846171  export SHELL=3D/bin/sh

    2023-08-26T13:30:06.847012  #

    2023-08-26T13:30:06.948602  / # export SHELL=3D/bin/sh. /lava-11362145/=
environment

    2023-08-26T13:30:06.949294  =


    2023-08-26T13:30:07.050783  / # . /lava-11362145/environment/lava-11362=
145/bin/lava-test-runner /lava-11362145/1

    2023-08-26T13:30:07.051983  =


    2023-08-26T13:30:07.056969  / # /lava-11362145/bin/lava-test-runner /la=
va-11362145/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64e9fed97711bd2a9c286d6c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e9fed97711bd2a9c286d71
        failing since 149 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-26T13:31:59.460161  + <8>[   11.698719] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11362208_1.4.2.3.1>

    2023-08-26T13:31:59.460728  set +x

    2023-08-26T13:31:59.568237  / # #

    2023-08-26T13:31:59.670846  export SHELL=3D/bin/sh

    2023-08-26T13:31:59.671639  #

    2023-08-26T13:31:59.773138  / # export SHELL=3D/bin/sh. /lava-11362208/=
environment

    2023-08-26T13:31:59.774019  =


    2023-08-26T13:31:59.875628  / # . /lava-11362208/environment/lava-11362=
208/bin/lava-test-runner /lava-11362208/1

    2023-08-26T13:31:59.876882  =


    2023-08-26T13:31:59.882670  / # /lava-11362208/bin/lava-test-runner /la=
va-11362208/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e9fe6897b88e645c286d94

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e9fe6897b88e645c286d99
        failing since 149 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-26T13:30:01.235031  + <8>[   11.817311] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11362170_1.4.2.3.1>

    2023-08-26T13:30:01.235145  set +x

    2023-08-26T13:30:01.339278  / # #

    2023-08-26T13:30:01.439965  export SHELL=3D/bin/sh

    2023-08-26T13:30:01.440185  #

    2023-08-26T13:30:01.540731  / # export SHELL=3D/bin/sh. /lava-11362170/=
environment

    2023-08-26T13:30:01.540984  =


    2023-08-26T13:30:01.641589  / # . /lava-11362170/environment/lava-11362=
170/bin/lava-test-runner /lava-11362170/1

    2023-08-26T13:30:01.641934  =


    2023-08-26T13:30:01.646593  / # /lava-11362170/bin/lava-test-runner /la=
va-11362170/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64e9febab2299451d0286d6d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e9febab2299451d0286d72
        failing since 149 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-26T13:31:32.278619  + <8>[   12.866026] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11362202_1.4.2.3.1>

    2023-08-26T13:31:32.278734  set +x

    2023-08-26T13:31:32.382850  / # #

    2023-08-26T13:31:32.483440  export SHELL=3D/bin/sh

    2023-08-26T13:31:32.483628  #

    2023-08-26T13:31:32.584157  / # export SHELL=3D/bin/sh. /lava-11362202/=
environment

    2023-08-26T13:31:32.584364  =


    2023-08-26T13:31:32.684895  / # . /lava-11362202/environment/lava-11362=
202/bin/lava-test-runner /lava-11362202/1

    2023-08-26T13:31:32.685231  =


    2023-08-26T13:31:32.689606  / # /lava-11362202/bin/lava-test-runner /la=
va-11362202/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea04e85ea8c293df286d6c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ea04e85ea8c293df286=
d6d
        failing since 214 days (last pass: v5.15.89, first fail: v5.15.90) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e9fef57711bd2a9c286df4

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e9fef57711bd2a9c286df9
        failing since 30 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-08-26T13:33:49.262188  / # #

    2023-08-26T13:33:49.362688  export SHELL=3D/bin/sh

    2023-08-26T13:33:49.362808  #

    2023-08-26T13:33:49.463419  / # export SHELL=3D/bin/sh. /lava-11362224/=
environment

    2023-08-26T13:33:49.464084  =


    2023-08-26T13:33:49.565507  / # . /lava-11362224/environment/lava-11362=
224/bin/lava-test-runner /lava-11362224/1

    2023-08-26T13:33:49.566601  =


    2023-08-26T13:33:49.576425  / # /lava-11362224/bin/lava-test-runner /la=
va-11362224/1

    2023-08-26T13:33:49.617050  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-26T13:33:49.635115  + cd /lav<8>[   15.959749] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11362224_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea01c492b881fb5f286df9

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea01c492b881fb5f286dfe
        failing since 30 days (last pass: v5.15.118, first fail: v5.15.123)

    2023-08-26T13:46:04.217197  / # #

    2023-08-26T13:46:04.319338  export SHELL=3D/bin/sh

    2023-08-26T13:46:04.320065  #

    2023-08-26T13:46:04.421491  / # export SHELL=3D/bin/sh. /lava-11362265/=
environment

    2023-08-26T13:46:04.422218  =


    2023-08-26T13:46:04.523674  / # . /lava-11362265/environment/lava-11362=
265/bin/lava-test-runner /lava-11362265/1

    2023-08-26T13:46:04.524774  =


    2023-08-26T13:46:04.541582  / # /lava-11362265/bin/lava-test-runner /la=
va-11362265/1

    2023-08-26T13:46:04.666711  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-26T13:46:04.667214  + cd /lava-11362265/1/tests/1_bootrr
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e9ff03228895a723286e06

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e9ff03228895a723286e0b
        failing since 30 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-08-26T13:33:54.440882  / # #

    2023-08-26T13:33:55.519747  export SHELL=3D/bin/sh

    2023-08-26T13:33:55.521551  #

    2023-08-26T13:33:57.010178  / # export SHELL=3D/bin/sh. /lava-11362217/=
environment

    2023-08-26T13:33:57.011986  =


    2023-08-26T13:33:59.732587  / # . /lava-11362217/environment/lava-11362=
217/bin/lava-test-runner /lava-11362217/1

    2023-08-26T13:33:59.734751  =


    2023-08-26T13:33:59.747922  / # /lava-11362217/bin/lava-test-runner /la=
va-11362217/1

    2023-08-26T13:33:59.806922  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-26T13:33:59.807420  + cd /lava-113622<8>[   25.558677] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11362217_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e9fef4228895a723286dec

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.128/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e9fef4228895a723286df1
        failing since 30 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-08-26T13:34:02.921736  / # #

    2023-08-26T13:34:03.024113  export SHELL=3D/bin/sh

    2023-08-26T13:34:03.024929  #

    2023-08-26T13:34:03.126401  / # export SHELL=3D/bin/sh. /lava-11362223/=
environment

    2023-08-26T13:34:03.127181  =


    2023-08-26T13:34:03.228665  / # . /lava-11362223/environment/lava-11362=
223/bin/lava-test-runner /lava-11362223/1

    2023-08-26T13:34:03.229937  =


    2023-08-26T13:34:03.232569  / # /lava-11362223/bin/lava-test-runner /la=
va-11362223/1

    2023-08-26T13:34:03.273492  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-26T13:34:03.306314  + cd /lava-1136222<8>[   16.902717] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11362223_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
