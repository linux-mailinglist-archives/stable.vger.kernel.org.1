Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F3A7141B9
	for <lists+stable@lfdr.de>; Mon, 29 May 2023 03:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjE2BiF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 21:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjE2BiE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 21:38:04 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498BEB1
        for <stable@vger.kernel.org>; Sun, 28 May 2023 18:38:02 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d3fbb8c1cso3212487b3a.3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 18:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685324281; x=1687916281;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BnpM15zvrjNeczK4CJfUPdU3RWDKdkDdaugWgEQLkxw=;
        b=fnP3wBvN3WS42Zkv8RSKxXPcXuwweSDNfIXMhZkLsBJHEpYsS18/89MS5z4PUqfiwu
         ciwB3kbg8pKr5LtWNEm4os/qGZn/bG/a0txwHc6R2zcWdmzkEHGZDsDb449UKoIeuHJz
         GYSmqGbKbxp70NvTPNr/4dFpDyX0W5/iT207O7Z3taMrGqdxa/M6HwImk/7V1Qz6Ik0t
         QHa38TzBHk1uAlJyrVs15l3l5Fq7z1PiKZnkjfC8nrNIiL/yExd7FkT/j8OKzDcej+N3
         jyhVdxeayvx9NQGZbEkDv/bBm5exdMWoIt46baEm/FUON/+zGbbe23bGtNF71tKp6Sx6
         6D/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685324281; x=1687916281;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BnpM15zvrjNeczK4CJfUPdU3RWDKdkDdaugWgEQLkxw=;
        b=dLcQY4fPJwGcpYu8E3CrB4LNACxtNyUh1uhsz1OQhb/b4nVLc8kqEDgRtzKRWr5ay9
         kG9RITvz80w0Jl3nLNjVPOUHmnzzK4D8CpaHS8FTonbKGVhH9ssQheGpDKeYHdQL3awF
         OVg1i8mEWyNAKPp9ztH2QMb4CP0raaTGvnSstNU/UoRhWsbA2fTQIYzw+aKVHlwrRz9j
         7+EU3wDNaU5IG+2tpe8yAru/YWyZBfjAvwa4g6zEQs2u/7Pt8yKyxxDXb+Q/gRvOY9L9
         /7rMDg7hnzBTYZObGEi2dAWSex/uN3amnXvg9hNibMfBa6CbW0VzN7tMhDeZ7/Ck9y33
         AJIQ==
X-Gm-Message-State: AC+VfDybAsh/+Vjs53xzfRCPWw9f+tEOa/9/KviBoXF8taMCnQWQQ0Fe
        zpxGsPzpi7XOLY0hnVMX+I3KGI2q1qsAQ+mtjkmNrw==
X-Google-Smtp-Source: ACHHUZ6j4TUJVMraeG7UcNSK2qsyxb2oKYqaSIklpB9/lUN3rrgQqCn1YIJuJcynoQ0kkhfyRN7P8Q==
X-Received: by 2002:a05:6a00:10ca:b0:64f:4197:8d93 with SMTP id d10-20020a056a0010ca00b0064f41978d93mr13389722pfu.24.1685324280572;
        Sun, 28 May 2023 18:38:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k3-20020aa792c3000000b005d22639b577sm5610443pfa.165.2023.05.28.18.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 18:38:00 -0700 (PDT)
Message-ID: <647401f8.a70a0220.5b0ab.b49f@mx.google.com>
Date:   Sun, 28 May 2023 18:38:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.112-274-gcd3aaa9c7395
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.15.y baseline: 165 runs,
 13 regressions (v5.15.112-274-gcd3aaa9c7395)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.15.y baseline: 165 runs, 13 regressions (v5.15.112-274-gc=
d3aaa9c7395)

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

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 4          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.112-274-gcd3aaa9c7395/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.112-274-gcd3aaa9c7395
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      cd3aaa9c7395cb221c57a5d6e5ca7d342669d553 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473cf9508f8b0f9582e85f2

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gcd3aaa9c7395/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gcd3aaa9c7395/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473cf9508f8b0f9582e85f7
        failing since 61 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-28T22:02:45.568706  + set +x

    2023-05-28T22:02:45.574472  <8>[   11.149816] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10499475_1.4.2.3.1>

    2023-05-28T22:02:45.682581  / # #

    2023-05-28T22:02:45.784906  export SHELL=3D/bin/sh

    2023-05-28T22:02:45.785624  #

    2023-05-28T22:02:45.887063  / # export SHELL=3D/bin/sh. /lava-10499475/=
environment

    2023-05-28T22:02:45.887835  =


    2023-05-28T22:02:45.989312  / # . /lava-10499475/environment/lava-10499=
475/bin/lava-test-runner /lava-10499475/1

    2023-05-28T22:02:45.990555  =


    2023-05-28T22:02:45.996295  / # /lava-10499475/bin/lava-test-runner /la=
va-10499475/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473cf9b0b4d9dd1922e85fa

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gcd3aaa9c7395/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gcd3aaa9c7395/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473cf9b0b4d9dd1922e85ff
        failing since 61 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-28T22:02:45.587295  + set<8>[   10.195868] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10499496_1.4.2.3.1>

    2023-05-28T22:02:45.587410   +x

    2023-05-28T22:02:45.692154  / # #

    2023-05-28T22:02:45.792846  export SHELL=3D/bin/sh

    2023-05-28T22:02:45.793104  #

    2023-05-28T22:02:45.893680  / # export SHELL=3D/bin/sh. /lava-10499496/=
environment

    2023-05-28T22:02:45.893900  =


    2023-05-28T22:02:45.994415  / # . /lava-10499496/environment/lava-10499=
496/bin/lava-test-runner /lava-10499496/1

    2023-05-28T22:02:45.994772  =


    2023-05-28T22:02:45.998882  / # /lava-10499496/bin/lava-test-runner /la=
va-10499496/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473cfa4e2a0e362562e8616

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gcd3aaa9c7395/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gcd3aaa9c7395/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473cfa4e2a0e362562e861b
        failing since 61 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-28T22:02:55.326324  <8>[   16.903381] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10499531_1.4.2.3.1>

    2023-05-28T22:02:55.329290  + set +x

    2023-05-28T22:02:55.430916  =


    2023-05-28T22:02:55.531561  / # #export SHELL=3D/bin/sh

    2023-05-28T22:02:55.531776  =


    2023-05-28T22:02:55.632313  / # export SHELL=3D/bin/sh. /lava-10499531/=
environment

    2023-05-28T22:02:55.632519  =


    2023-05-28T22:02:55.733040  / # . /lava-10499531/environment/lava-10499=
531/bin/lava-test-runner /lava-10499531/1

    2023-05-28T22:02:55.733340  =


    2023-05-28T22:02:55.738295  / # /lava-10499531/bin/lava-test-runner /la=
va-10499531/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6473ced6c6a64524f72e8624

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gcd3aaa9c7395/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gcd3aaa9c7395/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6473ced6c6a64524f72e8=
625
        failing since 381 days (last pass: v5.15.37-259-gab77581473a3, firs=
t fail: v5.15.39) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6473cf26b9ffd1cc562e86ba

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gcd3aaa9c7395/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gcd3aaa9c7395/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473cf26b9ffd1cc562e86bf
        failing since 131 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-05-28T22:00:58.242009  <8>[    9.991599] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3628289_1.5.2.4.1>
    2023-05-28T22:00:58.352176  / # #
    2023-05-28T22:00:58.455570  export SHELL=3D/bin/sh
    2023-05-28T22:00:58.456670  #
    2023-05-28T22:00:58.559206  / # export SHELL=3D/bin/sh. /lava-3628289/e=
nvironment
    2023-05-28T22:00:58.560467  =

    2023-05-28T22:00:58.561076  / # <3>[   10.273248] Bluetooth: hci0: comm=
and 0xfc18 tx timeout
    2023-05-28T22:00:58.663666  . /lava-3628289/environment/lava-3628289/bi=
n/lava-test-runner /lava-3628289/1
    2023-05-28T22:00:58.665554  =

    2023-05-28T22:00:58.669844  / # /lava-3628289/bin/lava-test-runner /lav=
a-3628289/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473cf8dbc65554a5b2e85f8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gcd3aaa9c7395/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gcd3aaa9c7395/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473cf8dbc65554a5b2e85fd
        failing since 61 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-28T22:02:42.734657  + set +x

    2023-05-28T22:02:42.741310  <8>[   11.506894] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10499515_1.4.2.3.1>

    2023-05-28T22:02:42.845618  / # #

    2023-05-28T22:02:42.946325  export SHELL=3D/bin/sh

    2023-05-28T22:02:42.946524  #

    2023-05-28T22:02:43.047009  / # export SHELL=3D/bin/sh. /lava-10499515/=
environment

    2023-05-28T22:02:43.047228  =


    2023-05-28T22:02:43.147736  / # . /lava-10499515/environment/lava-10499=
515/bin/lava-test-runner /lava-10499515/1

    2023-05-28T22:02:43.148092  =


    2023-05-28T22:02:43.152903  / # /lava-10499515/bin/lava-test-runner /la=
va-10499515/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473cf891cdbc76e252e865c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gcd3aaa9c7395/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gcd3aaa9c7395/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473cf891cdbc76e252e8661
        failing since 61 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-28T22:02:34.595367  <8>[   10.686318] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10499547_1.4.2.3.1>

    2023-05-28T22:02:34.598590  + set +x

    2023-05-28T22:02:34.703544  / # #

    2023-05-28T22:02:34.804205  export SHELL=3D/bin/sh

    2023-05-28T22:02:34.804398  #

    2023-05-28T22:02:34.904931  / # export SHELL=3D/bin/sh. /lava-10499547/=
environment

    2023-05-28T22:02:34.905156  =


    2023-05-28T22:02:35.005737  / # . /lava-10499547/environment/lava-10499=
547/bin/lava-test-runner /lava-10499547/1

    2023-05-28T22:02:35.006019  =


    2023-05-28T22:02:35.010595  / # /lava-10499547/bin/lava-test-runner /la=
va-10499547/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473cfa4e2a0e362562e860b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gcd3aaa9c7395/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gcd3aaa9c7395/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473cfa4e2a0e362562e8610
        failing since 61 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-28T22:02:49.330822  + set<8>[   11.306308] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10499503_1.4.2.3.1>

    2023-05-28T22:02:49.330906   +x

    2023-05-28T22:02:49.434971  / # #

    2023-05-28T22:02:49.535615  export SHELL=3D/bin/sh

    2023-05-28T22:02:49.535801  #

    2023-05-28T22:02:49.636310  / # export SHELL=3D/bin/sh. /lava-10499503/=
environment

    2023-05-28T22:02:49.636527  =


    2023-05-28T22:02:49.737067  / # . /lava-10499503/environment/lava-10499=
503/bin/lava-test-runner /lava-10499503/1

    2023-05-28T22:02:49.737402  =


    2023-05-28T22:02:49.742399  / # /lava-10499503/bin/lava-test-runner /la=
va-10499503/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473cf73a99f6a50442e8663

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gcd3aaa9c7395/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gcd3aaa9c7395/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473cf73a99f6a50442e8668
        failing since 61 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-28T22:02:12.625336  <8>[   11.545507] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10499472_1.4.2.3.1>

    2023-05-28T22:02:12.729743  / # #

    2023-05-28T22:02:12.830376  export SHELL=3D/bin/sh

    2023-05-28T22:02:12.830585  #

    2023-05-28T22:02:12.931113  / # export SHELL=3D/bin/sh. /lava-10499472/=
environment

    2023-05-28T22:02:12.931294  =


    2023-05-28T22:02:13.031867  / # . /lava-10499472/environment/lava-10499=
472/bin/lava-test-runner /lava-10499472/1

    2023-05-28T22:02:13.032217  =


    2023-05-28T22:02:13.037161  / # /lava-10499472/bin/lava-test-runner /la=
va-10499472/1

    2023-05-28T22:02:13.042460  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 4          =


  Details:     https://kernelci.org/test/plan/id/6473ce47d69c32833f2e8690

  Results:     153 PASS, 14 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gcd3aaa9c7395/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/=
baseline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gcd3aaa9c7395/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/=
baseline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/6473ce47d69c32833f2e86aa
        failing since 13 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-05-28T21:57:08.883578  /lava-10499387/1/../bin/lava-test-case

    2023-05-28T21:57:08.889862  <8>[   61.630241] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/6473ce47d69c32833f2e86aa
        failing since 13 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-05-28T21:57:08.883578  /lava-10499387/1/../bin/lava-test-case

    2023-05-28T21:57:08.889862  <8>[   61.630241] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/6473ce47d69c32833f2e86ac
        failing since 13 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-05-28T21:57:07.843152  /lava-10499387/1/../bin/lava-test-case

    2023-05-28T21:57:07.849299  <8>[   60.589758] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473ce48d69c32833f2e8734
        failing since 13 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-05-28T21:56:53.665898  + set +x

    2023-05-28T21:56:53.671896  <8>[   46.412064] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10499387_1.5.2.3.1>

    2023-05-28T21:56:53.780855  / # #

    2023-05-28T21:56:53.883244  export SHELL=3D/bin/sh

    2023-05-28T21:56:53.884098  #

    2023-05-28T21:56:53.985617  / # export SHELL=3D/bin/sh. /lava-10499387/=
environment

    2023-05-28T21:56:53.986622  =


    2023-05-28T21:56:54.088657  / # . /lava-10499387/environment/lava-10499=
387/bin/lava-test-runner /lava-10499387/1

    2023-05-28T21:56:54.089912  =


    2023-05-28T21:56:54.095591  / # /lava-10499387/bin/lava-test-runner /la=
va-10499387/1
 =

    ... (13 line(s) more)  =

 =20
