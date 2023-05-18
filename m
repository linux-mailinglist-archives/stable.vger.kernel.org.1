Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC6B707B19
	for <lists+stable@lfdr.de>; Thu, 18 May 2023 09:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjERHgo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 18 May 2023 03:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjERHgn (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 18 May 2023 03:36:43 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F28EE64
        for <stable@vger.kernel.org>; Thu, 18 May 2023 00:36:41 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-643aad3bc41so1889789b3a.0
        for <stable@vger.kernel.org>; Thu, 18 May 2023 00:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684395400; x=1686987400;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=04V/lfoOMw27xWD4bhUi0GFaxIZBhK0bl2l8rvAUozc=;
        b=u+5EN0L57DHQ4UBn6EsOduVjAEULc5ZjbZYus0TDXxv7g8nlih94Yp3t6pHGoQ63Q1
         dQxVkQhaZiMjvJRMUV0R8z7Y/dx4kLTlMOKVbqLcLwTD1mKY0si8JICoqqG/KaLeTUm+
         6s/s8mAuqhgY8OyYEoGMD7WfV6czk2F+I/Ngg2mEARsDuog8yyBuhqlYJ0iXmg6RIWD/
         AmlW7y3OCwRNkRKgph6upAFvtqZkooT/xbbFyteeR+DdVDfCoCsgZrhFSLCpnKergome
         9V4C7eIhTJ5L/MvNmuDx0WwuoGHz52Pimyto5+kh+RR9Bw9IkuE5s4Cnk43HKwd3/Q6T
         nEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684395400; x=1686987400;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=04V/lfoOMw27xWD4bhUi0GFaxIZBhK0bl2l8rvAUozc=;
        b=AR1zNqdJT2cngwiaJHiBrsX8MZV8zvRAsorTgYsyOhAXV02Sy9eZN3wB6sVZWRpuYg
         esm326dXoySv5xgYhTcnWVa0lNw/p7pmng/bVRWv+Ra/m3ZrYhp5UR9a5flxT+pyETZM
         3cB5aycLt1s54MjM2Cpkmk55aBGPpY67na/NqKgS6GElVfxIALjVgsTXJ9l6xV+gVObF
         7kYGDsOLUn8JgIgQlkiCl8psyX0O8uUiHK2PWKBly87rHHZidzdFoJ4InJgvVtFjS9+f
         3BFCoyMnJVeYwkYl5yQ1CduwOUGBi6FVdob2SVaG5m2kEwok+CXV1tVia5jmCusaekoJ
         yROw==
X-Gm-Message-State: AC+VfDzYjZX3vxRYcYXVTRWbKQl6eEY7Z0RuOLXCgBd992UXkR8Sq4+Y
        PN0hL6t5jMWiqZjOU2/XdhkykuX8PZ7mV28Nag4ioQ==
X-Google-Smtp-Source: ACHHUZ6964Fz4xP5s7/XwWJSkbo8g5gXE2+EPNwhATrhxhKF9iKMyQlaqUBIdg99HTpRxBaHnTxXuQ==
X-Received: by 2002:a05:6a20:3d0e:b0:103:f088:105e with SMTP id y14-20020a056a203d0e00b00103f088105emr1383994pzi.16.1684395399987;
        Thu, 18 May 2023 00:36:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k35-20020a634b63000000b00502fd70b0bdsm627457pgl.52.2023.05.18.00.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 00:36:39 -0700 (PDT)
Message-ID: <6465d587.630a0220.1271c.105d@mx.google.com>
Date:   Thu, 18 May 2023 00:36:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.29-35-gb931b5f255d58
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 159 runs,
 11 regressions (v6.1.29-35-gb931b5f255d58)
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

stable-rc/queue/6.1 baseline: 159 runs, 11 regressions (v6.1.29-35-gb931b5f=
255d58)

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

meson-g12b-a311d-khadas-vim3 | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.29-35-gb931b5f255d58/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.29-35-gb931b5f255d58
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b931b5f255d58f4cc30e7bfc2a42386f286ad8ea =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6465a3f275f4a874df2e863e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-35=
-gb931b5f255d58/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-35=
-gb931b5f255d58/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6465a3f275f4a874df2e8643
        failing since 50 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-18T04:04:58.000493  + set +x

    2023-05-18T04:04:58.007094  <8>[    8.538380] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10367542_1.4.2.3.1>

    2023-05-18T04:04:58.111363  / # #

    2023-05-18T04:04:58.212070  export SHELL=3D/bin/sh

    2023-05-18T04:04:58.212923  #

    2023-05-18T04:04:58.314490  / # export SHELL=3D/bin/sh. /lava-10367542/=
environment

    2023-05-18T04:04:58.315328  =


    2023-05-18T04:04:58.416839  / # . /lava-10367542/environment/lava-10367=
542/bin/lava-test-runner /lava-10367542/1

    2023-05-18T04:04:58.417136  =


    2023-05-18T04:04:58.422478  / # /lava-10367542/bin/lava-test-runner /la=
va-10367542/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6465a4019cdfefdd882e8633

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-35=
-gb931b5f255d58/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-35=
-gb931b5f255d58/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6465a4019cdfefdd882e8638
        failing since 50 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-18T04:04:55.835642  + <8>[   11.687857] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10367538_1.4.2.3.1>

    2023-05-18T04:04:55.836227  set +x

    2023-05-18T04:04:55.944260  / # #

    2023-05-18T04:04:56.046818  export SHELL=3D/bin/sh

    2023-05-18T04:04:56.047702  #

    2023-05-18T04:04:56.149176  / # export SHELL=3D/bin/sh. /lava-10367538/=
environment

    2023-05-18T04:04:56.150007  =


    2023-05-18T04:04:56.251508  / # . /lava-10367538/environment/lava-10367=
538/bin/lava-test-runner /lava-10367538/1

    2023-05-18T04:04:56.252804  =


    2023-05-18T04:04:56.257401  / # /lava-10367538/bin/lava-test-runner /la=
va-10367538/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6465a3e827f97e455e2e8631

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-35=
-gb931b5f255d58/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-35=
-gb931b5f255d58/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6465a3e827f97e455e2e8636
        failing since 50 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-18T04:04:45.893971  <8>[   10.467324] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10367555_1.4.2.3.1>

    2023-05-18T04:04:45.897441  + set +x

    2023-05-18T04:04:46.003192  =


    2023-05-18T04:04:46.104817  / # #export SHELL=3D/bin/sh

    2023-05-18T04:04:46.105465  =


    2023-05-18T04:04:46.206784  / # export SHELL=3D/bin/sh. /lava-10367555/=
environment

    2023-05-18T04:04:46.207438  =


    2023-05-18T04:04:46.308850  / # . /lava-10367555/environment/lava-10367=
555/bin/lava-test-runner /lava-10367555/1

    2023-05-18T04:04:46.309914  =


    2023-05-18T04:04:46.315032  / # /lava-10367555/bin/lava-test-runner /la=
va-10367555/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6465a3e627f97e455e2e8626

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-35=
-gb931b5f255d58/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-35=
-gb931b5f255d58/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6465a3e627f97e455e2e862b
        failing since 50 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-18T04:04:36.929341  <8>[   11.343435] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10367551_1.4.2.3.1>

    2023-05-18T04:04:37.033841  / # #

    2023-05-18T04:04:37.134538  export SHELL=3D/bin/sh

    2023-05-18T04:04:37.134740  #

    2023-05-18T04:04:37.235299  / # export SHELL=3D/bin/sh. /lava-10367551/=
environment

    2023-05-18T04:04:37.235508  =


    2023-05-18T04:04:37.336098  / # . /lava-10367551/environment/lava-10367=
551/bin/lava-test-runner /lava-10367551/1

    2023-05-18T04:04:37.336409  =


    2023-05-18T04:04:37.340744  / # /lava-10367551/bin/lava-test-runner /la=
va-10367551/1

    2023-05-18T04:04:37.361067  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6465a3d0a97aaef32e2e861d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-35=
-gb931b5f255d58/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-35=
-gb931b5f255d58/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6465a3d0a97aaef32e2e8622
        failing since 50 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-18T04:04:14.596912  + set +x

    2023-05-18T04:04:14.603588  <8>[    7.762829] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10367500_1.4.2.3.1>

    2023-05-18T04:04:14.708147  / # #

    2023-05-18T04:04:14.808833  export SHELL=3D/bin/sh

    2023-05-18T04:04:14.809038  #

    2023-05-18T04:04:14.909552  / # export SHELL=3D/bin/sh. /lava-10367500/=
environment

    2023-05-18T04:04:14.909736  =


    2023-05-18T04:04:15.010248  / # . /lava-10367500/environment/lava-10367=
500/bin/lava-test-runner /lava-10367500/1

    2023-05-18T04:04:15.010575  =


    2023-05-18T04:04:15.015989  / # /lava-10367500/bin/lava-test-runner /la=
va-10367500/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6465a3eb27f97e455e2e863e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-35=
-gb931b5f255d58/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-35=
-gb931b5f255d58/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6465a3eb27f97e455e2e8643
        failing since 50 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-18T04:04:41.248406  + set<8>[   11.588329] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10367510_1.4.2.3.1>

    2023-05-18T04:04:41.248493   +x

    2023-05-18T04:04:41.352460  / # #

    2023-05-18T04:04:41.453088  export SHELL=3D/bin/sh

    2023-05-18T04:04:41.453302  #

    2023-05-18T04:04:41.553799  / # export SHELL=3D/bin/sh. /lava-10367510/=
environment

    2023-05-18T04:04:41.554010  =


    2023-05-18T04:04:41.654529  / # . /lava-10367510/environment/lava-10367=
510/bin/lava-test-runner /lava-10367510/1

    2023-05-18T04:04:41.654884  =


    2023-05-18T04:04:41.659611  / # /lava-10367510/bin/lava-test-runner /la=
va-10367510/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6465a3d89a103c41512e85e7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-35=
-gb931b5f255d58/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-35=
-gb931b5f255d58/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6465a3d89a103c41512e85ec
        failing since 50 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-18T04:04:28.433000  <8>[   11.045324] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10367520_1.4.2.3.1>

    2023-05-18T04:04:28.541193  / # #

    2023-05-18T04:04:28.642456  export SHELL=3D/bin/sh

    2023-05-18T04:04:28.643173  #

    2023-05-18T04:04:28.744509  / # export SHELL=3D/bin/sh. /lava-10367520/=
environment

    2023-05-18T04:04:28.745186  =


    2023-05-18T04:04:28.846666  / # . /lava-10367520/environment/lava-10367=
520/bin/lava-test-runner /lava-10367520/1

    2023-05-18T04:04:28.848070  =


    2023-05-18T04:04:28.852640  / # /lava-10367520/bin/lava-test-runner /la=
va-10367520/1

    2023-05-18T04:04:28.859287  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6465a135f57bf60c602e8637

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-35=
-gb931b5f255d58/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-g12b-a31=
1d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-35=
-gb931b5f255d58/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-g12b-a31=
1d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6465a135f57bf60c602e863c
        new failure (last pass: v6.1.29)

    2023-05-18T03:52:52.147393  <8>[   24.703860] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3598926_1.5.2.4.1>
    2023-05-18T03:52:52.252507  / # #
    2023-05-18T03:52:52.354382  export SHELL=3D/bin/sh
    2023-05-18T03:52:52.354909  #
    2023-05-18T03:52:52.456278  / # export SHELL=3D/bin/sh. /lava-3598926/e=
nvironment
    2023-05-18T03:52:52.456819  =

    2023-05-18T03:52:52.457054  / # . /lava-3598926/environment<3>[   25.00=
8945] brcmfmac: brcmf_sdio_htclk: HT Avail timeout (1000000): clkctl 0x50
    2023-05-18T03:52:52.558423  /lava-3598926/bin/lava-test-runner /lava-35=
98926/1
    2023-05-18T03:52:52.559206  =

    2023-05-18T03:52:52.576096  / # /lava-3598926/bin/lava-test-runner /lav=
a-3598926/1 =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64659f67695eb5f68f2e860a

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-35=
-gb931b5f255d58/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-35=
-gb931b5f255d58/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/64659f67695eb5f68f2e861e
        failing since 11 days (last pass: v6.1.22-704-ga3dcd1f09de2, first =
fail: v6.1.22-1160-g24230ce6f2e2)

    2023-05-18T03:45:28.831691  /lava-10367266/1/../bin/lava-test-case

    2023-05-18T03:45:28.837915  <8>[   23.093102] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64659f67695eb5f68f2e86aa
        failing since 11 days (last pass: v6.1.22-704-ga3dcd1f09de2, first =
fail: v6.1.22-1160-g24230ce6f2e2)

    2023-05-18T03:45:23.347543  + set +x

    2023-05-18T03:45:23.354044  <8>[   17.607067] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10367266_1.5.2.3.1>

    2023-05-18T03:45:23.463029  / # #

    2023-05-18T03:45:23.565604  export SHELL=3D/bin/sh

    2023-05-18T03:45:23.566415  #

    2023-05-18T03:45:23.667825  / # export SHELL=3D/bin/sh. /lava-10367266/=
environment

    2023-05-18T03:45:23.668095  =


    2023-05-18T03:45:23.768597  / # . /lava-10367266/environment/lava-10367=
266/bin/lava-test-runner /lava-10367266/1

    2023-05-18T03:45:23.768907  =


    2023-05-18T03:45:23.774714  / # /lava-10367266/bin/lava-test-runner /la=
va-10367266/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/6465a33cfd4ba5682c2e85f6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-35=
-gb931b5f255d58/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mip=
s-malta.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-35=
-gb931b5f255d58/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mip=
s-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6465a33cfd4ba5682c2e8=
5f7
        new failure (last pass: v6.1.29) =

 =20
