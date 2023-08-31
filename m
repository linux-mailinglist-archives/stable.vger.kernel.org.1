Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A102D78F03F
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 17:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjHaP0B (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 11:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241859AbjHaP0B (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 11:26:01 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9CDE55
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 08:25:56 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686be3cbea0so1456140b3a.0
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 08:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693495556; x=1694100356; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=khnM62Axr5GFCMZ8Rdi0izT3+buyAS8WKFrEPHqY9Gs=;
        b=2SVA7PFcAbDVtmf+V+Q9bJLQR4gdkQZmf4quZXiAOhu/cbs3ob7GctzaUa94U/S7ua
         hCCK6pSmQ3k5w2ZmFtaNHm11iGlyLLEX9fjqT5fMadyNlNTitC0OhYwKHcUkUJWuXlpZ
         KSn1FyyInwXBeyKAsAcjJJHKLUK0wS0QQ7JaGnnhd9XMtjtgu1luE+an+OPClAB3ATBb
         dYTH8gLVQUdvFjOwzXNYVRXzKoYc6JNUFnVJ5gI5gxCmtfsoPTjnxfdr/5wMU6A4b3n7
         UjtLAsQMhRF3TJDeuX5bmgEPBQspjBvFNNv1JbiXhRckmcD+VIenD4tkRtsZpoQ3+7Y5
         iURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693495556; x=1694100356;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=khnM62Axr5GFCMZ8Rdi0izT3+buyAS8WKFrEPHqY9Gs=;
        b=LS76gSFpYbPzyupotQWyDxfCvec7kYUalmrSoB2AgVoQyTxwDlyr4058vdKNxSz3J3
         l+1P7/EqvCFYK0OA1Zr1ucjA6NfW0nuvyvvtY4BSg7Kzf16bMa8iUwxmcOrOaVFuysXk
         vpTxK8B6yiGL+s6fQkkQeBkHacgmm02mJ30/QelSyBPfj7rokSQfsh7xujhxZu2gt5Q4
         egUDzNdDXbIoHsAQe0TMhKl2cbHpFAs39p3FLmwm2gnaXKvqJT12g+DoaHB/uM55UJFl
         7N48kbwQ7R3jGUWQ+wK610i7QqW01HKfR+WenidsZED1gYuVkSLe8q1IMK36E8WUrwje
         KyMQ==
X-Gm-Message-State: AOJu0YzBvPbb0krZlrNeS+vHYHGLzyp4wapzGEtbWAhvc5PJzxkd+g6Q
        Dh2TH+d8Io2pn8a3Pk3Qq/bc70ndith7s3sZ7sU=
X-Google-Smtp-Source: AGHT+IETFyAyj8JV/9qlZI39oONiyXvAUtbpFigtwT9H3yhNAdy9bONXbbqSt9Lj7AXG1Yypn5ZODQ==
X-Received: by 2002:a05:6a20:734e:b0:133:1d62:dcbd with SMTP id v14-20020a056a20734e00b001331d62dcbdmr4005628pzc.28.1693495555660;
        Thu, 31 Aug 2023 08:25:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l19-20020a639853000000b00565a0e66c79sm1450529pgo.72.2023.08.31.08.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 08:25:54 -0700 (PDT)
Message-ID: <64f0b102.630a0220.a839a.2b2f@mx.google.com>
Date:   Thu, 31 Aug 2023 08:25:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.50
Subject: stable-rc/linux-6.1.y baseline: 123 runs, 11 regressions (v6.1.50)
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

stable-rc/linux-6.1.y baseline: 123 runs, 11 regressions (v6.1.50)

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
el/v6.1.50/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.50
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      a2943d2d9a00ae7c5c1fde2b2e7e9cdb47e7db05 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f07babcde8191ceb286d74

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-c=
hromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-c=
hromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f07babcde8191ceb286=
d75
        new failure (last pass: v6.1.48-128-g1aa86af84d82) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f07b4eac5c760fad286d9c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f07b4eac5c760fad286da5
        failing since 153 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-31T11:36:30.421535  + set +x

    2023-08-31T11:36:30.428203  <8>[    9.958193] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11389549_1.4.2.3.1>

    2023-08-31T11:36:30.532858  / # #

    2023-08-31T11:36:30.633709  export SHELL=3D/bin/sh

    2023-08-31T11:36:30.634160  #

    2023-08-31T11:36:30.734768  / # export SHELL=3D/bin/sh. /lava-11389549/=
environment

    2023-08-31T11:36:30.735011  =


    2023-08-31T11:36:30.835699  / # . /lava-11389549/environment/lava-11389=
549/bin/lava-test-runner /lava-11389549/1

    2023-08-31T11:36:30.836083  =


    2023-08-31T11:36:30.841662  / # /lava-11389549/bin/lava-test-runner /la=
va-11389549/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f07b4f8bc6a197ec286d6d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f07b4f8bc6a197ec286d76
        failing since 153 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-31T11:36:31.735087  + set<8>[   11.924239] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11389569_1.4.2.3.1>

    2023-08-31T11:36:31.735521   +x

    2023-08-31T11:36:31.842543  / # #

    2023-08-31T11:36:31.944730  export SHELL=3D/bin/sh

    2023-08-31T11:36:31.945726  #

    2023-08-31T11:36:32.047367  / # export SHELL=3D/bin/sh. /lava-11389569/=
environment

    2023-08-31T11:36:32.048054  =


    2023-08-31T11:36:32.149424  / # . /lava-11389569/environment/lava-11389=
569/bin/lava-test-runner /lava-11389569/1

    2023-08-31T11:36:32.150412  =


    2023-08-31T11:36:32.155273  / # /lava-11389569/bin/lava-test-runner /la=
va-11389569/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f07b5e0b2a154a35286d8a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f07b5e0b2a154a35286d93
        failing since 153 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-31T11:36:42.263426  <8>[    7.911145] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11389545_1.4.2.3.1>

    2023-08-31T11:36:42.266984  + set +x

    2023-08-31T11:36:42.368267  =


    2023-08-31T11:36:42.468773  / # #export SHELL=3D/bin/sh

    2023-08-31T11:36:42.468936  =


    2023-08-31T11:36:42.569403  / # export SHELL=3D/bin/sh. /lava-11389545/=
environment

    2023-08-31T11:36:42.569580  =


    2023-08-31T11:36:42.670096  / # . /lava-11389545/environment/lava-11389=
545/bin/lava-test-runner /lava-11389545/1

    2023-08-31T11:36:42.670348  =


    2023-08-31T11:36:42.675506  / # /lava-11389545/bin/lava-test-runner /la=
va-11389545/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f07d0944093e41c0286dce

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f07d0944093e41c0286=
dcf
        failing since 84 days (last pass: v6.1.31-40-g7d0a9678d276, first f=
ail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f07b588bc6a197ec286d99

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f07b588bc6a197ec286da2
        failing since 153 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-31T11:37:43.458080  + set +x

    2023-08-31T11:37:43.464412  <8>[   11.054132] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11389548_1.4.2.3.1>

    2023-08-31T11:37:43.568764  / # #

    2023-08-31T11:37:43.669339  export SHELL=3D/bin/sh

    2023-08-31T11:37:43.669498  #

    2023-08-31T11:37:43.770034  / # export SHELL=3D/bin/sh. /lava-11389548/=
environment

    2023-08-31T11:37:43.770197  =


    2023-08-31T11:37:43.870796  / # . /lava-11389548/environment/lava-11389=
548/bin/lava-test-runner /lava-11389548/1

    2023-08-31T11:37:43.871065  =


    2023-08-31T11:37:43.875556  / # /lava-11389548/bin/lava-test-runner /la=
va-11389548/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f07b508bc6a197ec286d78

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f07b508bc6a197ec286d81
        failing since 153 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-31T11:36:40.522031  + <8>[   11.437420] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11389581_1.4.2.3.1>

    2023-08-31T11:36:40.522159  set +x

    2023-08-31T11:36:40.626658  / # #

    2023-08-31T11:36:40.727356  export SHELL=3D/bin/sh

    2023-08-31T11:36:40.727558  #

    2023-08-31T11:36:40.828131  / # export SHELL=3D/bin/sh. /lava-11389581/=
environment

    2023-08-31T11:36:40.828388  =


    2023-08-31T11:36:40.929008  / # . /lava-11389581/environment/lava-11389=
581/bin/lava-test-runner /lava-11389581/1

    2023-08-31T11:36:40.929279  =


    2023-08-31T11:36:40.933943  / # /lava-11389581/bin/lava-test-runner /la=
va-11389581/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f07b6ce463137884286d86

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f07b6ce463137884286d8f
        failing since 153 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-31T11:36:50.483194  + set<8>[   11.476687] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11389578_1.4.2.3.1>

    2023-08-31T11:36:50.483279   +x

    2023-08-31T11:36:50.587471  / # #

    2023-08-31T11:36:50.688059  export SHELL=3D/bin/sh

    2023-08-31T11:36:50.688247  #

    2023-08-31T11:36:50.788718  / # export SHELL=3D/bin/sh. /lava-11389578/=
environment

    2023-08-31T11:36:50.788985  =


    2023-08-31T11:36:50.889465  / # . /lava-11389578/environment/lava-11389=
578/bin/lava-test-runner /lava-11389578/1

    2023-08-31T11:36:50.889726  =


    2023-08-31T11:36:50.894185  / # /lava-11389578/bin/lava-test-runner /la=
va-11389578/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f0920c0bf957825f286ebd

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f0920c0bf957825f286ec6
        failing since 44 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-31T13:15:07.169339  / # #

    2023-08-31T13:15:07.269849  export SHELL=3D/bin/sh

    2023-08-31T13:15:07.269967  #

    2023-08-31T13:15:07.370463  / # export SHELL=3D/bin/sh. /lava-11389725/=
environment

    2023-08-31T13:15:07.370580  =


    2023-08-31T13:15:07.471032  / # . /lava-11389725/environment/lava-11389=
725/bin/lava-test-runner /lava-11389725/1

    2023-08-31T13:15:07.471226  =


    2023-08-31T13:15:07.482580  / # /lava-11389725/bin/lava-test-runner /la=
va-11389725/1

    2023-08-31T13:15:07.535658  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-31T13:15:07.535738  + cd /lav<8>[   19.128285] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11389725_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f07f6d1787ce67d4286d6f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f07f6d1787ce67d4286d78
        failing since 44 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-31T11:54:19.505347  / # #

    2023-08-31T11:54:20.581197  export SHELL=3D/bin/sh

    2023-08-31T11:54:20.582450  #

    2023-08-31T11:54:22.070022  / # export SHELL=3D/bin/sh. /lava-11389717/=
environment

    2023-08-31T11:54:22.071888  =


    2023-08-31T11:54:24.795483  / # . /lava-11389717/environment/lava-11389=
717/bin/lava-test-runner /lava-11389717/1

    2023-08-31T11:54:24.797606  =


    2023-08-31T11:54:24.812836  / # /lava-11389717/bin/lava-test-runner /la=
va-11389717/1

    2023-08-31T11:54:24.865723  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-31T11:54:24.866187  + cd /lava-113897<8>[   28.465648] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11389717_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f07f605b16d8f904286d78

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.50/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f07f605b16d8f904286d81
        failing since 44 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-31T11:55:37.128376  / # #

    2023-08-31T11:55:37.230609  export SHELL=3D/bin/sh

    2023-08-31T11:55:37.231316  #

    2023-08-31T11:55:37.332768  / # export SHELL=3D/bin/sh. /lava-11389718/=
environment

    2023-08-31T11:55:37.333534  =


    2023-08-31T11:55:37.435035  / # . /lava-11389718/environment/lava-11389=
718/bin/lava-test-runner /lava-11389718/1

    2023-08-31T11:55:37.436178  =


    2023-08-31T11:55:37.452731  / # /lava-11389718/bin/lava-test-runner /la=
va-11389718/1

    2023-08-31T11:55:37.519733  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-31T11:55:37.520230  + cd /lava-11389718/1/tests/1_boot<8>[   16=
.888805] <LAVA_SIGNAL_STARTRUN 1_bootrr 11389718_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
