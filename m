Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9865D729EFB
	for <lists+stable@lfdr.de>; Fri,  9 Jun 2023 17:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjFIPqA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 9 Jun 2023 11:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjFIPqA (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Jun 2023 11:46:00 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692893596
        for <stable@vger.kernel.org>; Fri,  9 Jun 2023 08:45:57 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-653fcd58880so1644976b3a.0
        for <stable@vger.kernel.org>; Fri, 09 Jun 2023 08:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686325556; x=1688917556;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kIDO/QuGl+hmfnZOrjWxo9Nx8VVp0G0lRkglAoR9xQw=;
        b=ts0wi1s4vnDKxwvizDQ5ypL7P7lmvc9Rdo+bB5dcRebI1loxmZJqXFQe00V7urHaRT
         yI9z+7kMca/ryV/Gn7mrkmpFCbhTBJPTB3mMXTgCS4PjmsdGGae5K1/fkn4I/KCqNrv3
         PGBluNu7EeI+0MhNKmxxAbZtIIgDuJsOpXht2kCCw4Dt6YVX5o6MK9DEZH39qdxBDy88
         sgZXC+PO+9p1zsX+/v8QT84rvpf2k/geaAB8HCLoaEyZd1e9BsQk+J3LIDjw7KAJrUkq
         DNoM1cXWSooXGipeoUXll3QWWtaSbaUg7kP4hKd1U+4w71i7bVgsGO4PJrPTR8erCZyW
         HsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686325556; x=1688917556;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kIDO/QuGl+hmfnZOrjWxo9Nx8VVp0G0lRkglAoR9xQw=;
        b=Eqv7zyb7H8sI8gNBmFZHUqYeEpD+xMGI6k9ws32W3zVMcHkRJdBgpYxlh/2pR5FeBe
         hoG1lQ4liTciRXZKvRhICiV1p9PRBvaIO8+6mMqYxwg7HkfN0bhQ8J4NRan/mM9koioF
         wJ83CGBcB9uAqRI5yvgJudzB0Tp43AECEaEDdIaw98VAJLOv2CXYVNd2jvHbtuhnt7Ko
         xuMLDVSjl+W30b/LHsFP92WK1MDQJiZ43NvVVUhkvw8E4TIZVvYmGkfzXMCgguesC1YX
         4VOTre3gVVdF8HrtBOdy1YeY4e43b2+TJMBgA5nSj5dhImUeuHFv+BQINkEZ5scTPBwr
         E74w==
X-Gm-Message-State: AC+VfDwn78Ux2I6V/UnouUKZcOEzCUmNuhKsk6wZjEY4jMF/UI2RceP8
        q8R818UaRVZkAdD5pdE85rhfmp30AsOcITOB1UlI1g==
X-Google-Smtp-Source: ACHHUZ5EUs1OHgCh/OKl7IbhQ3D1dMWSMXtV3tqDfX/DZCaoqb+3h8z+BVeEbXjA5msYlILzGsLGhA==
X-Received: by 2002:a17:902:b58d:b0:1ac:8384:a7fb with SMTP id a13-20020a170902b58d00b001ac8384a7fbmr1239315pls.66.1686325556114;
        Fri, 09 Jun 2023 08:45:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v1-20020a1709029a0100b001add2ba4459sm3443977plp.32.2023.06.09.08.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 08:45:55 -0700 (PDT)
Message-ID: <64834933.170a0220.4ddf1.6db5@mx.google.com>
Date:   Fri, 09 Jun 2023 08:45:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.33
Subject: stable/linux-6.1.y baseline: 152 runs, 8 regressions (v6.1.33)
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

stable/linux-6.1.y baseline: 152 runs, 8 regressions (v6.1.33)

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

qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-6.1.y/kernel/=
v6.1.33/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-6.1.y
  Describe: v6.1.33
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      2f3918bc53fb998fdeed8683ddc61194ceb84edf =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648315226136310ba030613b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.33/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.33/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648315226136310ba0306140
        failing since 70 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-09T12:03:22.187313  <8>[   11.090187] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10657943_1.4.2.3.1>

    2023-06-09T12:03:22.190868  + set +x

    2023-06-09T12:03:22.296530  #

    2023-06-09T12:03:22.297796  =


    2023-06-09T12:03:22.399968  / # #export SHELL=3D/bin/sh

    2023-06-09T12:03:22.400760  =


    2023-06-09T12:03:22.502449  / # export SHELL=3D/bin/sh. /lava-10657943/=
environment

    2023-06-09T12:03:22.502915  =


    2023-06-09T12:03:22.604205  / # . /lava-10657943/environment/lava-10657=
943/bin/lava-test-runner /lava-10657943/1

    2023-06-09T12:03:22.605441  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648315226136310ba0306149

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.33/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.33/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648315226136310ba030614e
        failing since 70 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-09T12:03:29.242271  + set<8>[   11.070327] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10657895_1.4.2.3.1>

    2023-06-09T12:03:29.242866   +x

    2023-06-09T12:03:29.351172  / # #

    2023-06-09T12:03:29.453728  export SHELL=3D/bin/sh

    2023-06-09T12:03:29.454546  #

    2023-06-09T12:03:29.556121  / # export SHELL=3D/bin/sh. /lava-10657895/=
environment

    2023-06-09T12:03:29.556958  =


    2023-06-09T12:03:29.658653  / # . /lava-10657895/environment/lava-10657=
895/bin/lava-test-runner /lava-10657895/1

    2023-06-09T12:03:29.659942  =


    2023-06-09T12:03:29.664777  / # /lava-10657895/bin/lava-test-runner /la=
va-10657895/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6483151c009d9dc8453061b9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.33/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.33/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6483151c009d9dc8453061be
        failing since 70 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-09T12:03:17.751192  <8>[   10.837977] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10657902_1.4.2.3.1>

    2023-06-09T12:03:17.754703  + set +x

    2023-06-09T12:03:17.856608  #

    2023-06-09T12:03:17.857947  =


    2023-06-09T12:03:17.960281  / # #export SHELL=3D/bin/sh

    2023-06-09T12:03:17.961082  =


    2023-06-09T12:03:18.062789  / # export SHELL=3D/bin/sh. /lava-10657902/=
environment

    2023-06-09T12:03:18.063692  =


    2023-06-09T12:03:18.165352  / # . /lava-10657902/environment/lava-10657=
902/bin/lava-test-runner /lava-10657902/1

    2023-06-09T12:03:18.166834  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648315082fe3538114306146

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.33/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.33/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648315082fe353811430614b
        failing since 70 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-09T12:03:08.655112  + set +x

    2023-06-09T12:03:08.661734  <8>[   11.009107] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10657884_1.4.2.3.1>

    2023-06-09T12:03:08.765961  / # #

    2023-06-09T12:03:08.866524  export SHELL=3D/bin/sh

    2023-06-09T12:03:08.866720  #

    2023-06-09T12:03:08.967151  / # export SHELL=3D/bin/sh. /lava-10657884/=
environment

    2023-06-09T12:03:08.967358  =


    2023-06-09T12:03:09.067859  / # . /lava-10657884/environment/lava-10657=
884/bin/lava-test-runner /lava-10657884/1

    2023-06-09T12:03:09.068141  =


    2023-06-09T12:03:09.072909  / # /lava-10657884/bin/lava-test-runner /la=
va-10657884/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6483150a168851952530614d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.33/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.33/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6483150a1688519525306152
        failing since 70 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-09T12:03:10.420708  + set +x

    2023-06-09T12:03:10.427370  <8>[    9.861415] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10657951_1.4.2.3.1>

    2023-06-09T12:03:10.534821  =


    2023-06-09T12:03:10.636496  / # #export SHELL=3D/bin/sh

    2023-06-09T12:03:10.637200  =


    2023-06-09T12:03:10.738504  / # export SHELL=3D/bin/sh. /lava-10657951/=
environment

    2023-06-09T12:03:10.739206  =


    2023-06-09T12:03:10.840607  / # . /lava-10657951/environment/lava-10657=
951/bin/lava-test-runner /lava-10657951/1

    2023-06-09T12:03:10.841881  =


    2023-06-09T12:03:10.847978  / # /lava-10657951/bin/lava-test-runner /la=
va-10657951/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6483151d009d9dc8453061cf

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.33/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.33/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6483151d009d9dc8453061d4
        failing since 70 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-09T12:03:28.886035  + <8>[   11.644902] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10657889_1.4.2.3.1>

    2023-06-09T12:03:28.886631  set +x

    2023-06-09T12:03:28.995064  / # #

    2023-06-09T12:03:29.097851  export SHELL=3D/bin/sh

    2023-06-09T12:03:29.098674  #

    2023-06-09T12:03:29.200451  / # export SHELL=3D/bin/sh. /lava-10657889/=
environment

    2023-06-09T12:03:29.201287  =


    2023-06-09T12:03:29.302801  / # . /lava-10657889/environment/lava-10657=
889/bin/lava-test-runner /lava-10657889/1

    2023-06-09T12:03:29.304026  =


    2023-06-09T12:03:29.309079  / # /lava-10657889/bin/lava-test-runner /la=
va-10657889/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6483150376383ab4ca30615d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.33/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.33/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6483150376383ab4ca306162
        failing since 70 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-09T12:02:59.633821  + set<8>[   12.326621] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10657912_1.4.2.3.1>

    2023-06-09T12:02:59.634255   +x

    2023-06-09T12:02:59.741470  / # #

    2023-06-09T12:02:59.842784  export SHELL=3D/bin/sh

    2023-06-09T12:02:59.843054  #

    2023-06-09T12:02:59.943777  / # export SHELL=3D/bin/sh. /lava-10657912/=
environment

    2023-06-09T12:02:59.944515  =


    2023-06-09T12:03:00.045899  / # . /lava-10657912/environment/lava-10657=
912/bin/lava-test-runner /lava-10657912/1

    2023-06-09T12:03:00.047177  =


    2023-06-09T12:03:00.051910  / # /lava-10657912/bin/lava-test-runner /la=
va-10657912/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/648310b819b23698e3306151

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.33/mip=
s/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.33/mip=
s/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/mipsel/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/648310b819b2369=
8e3306159
        new failure (last pass: v6.1.29)
        1 lines

    2023-06-09T11:44:49.325201  kern  :alert : CPU 0 Unable to handle kerne=
l paging request at virtual address 79e6cd54, epc =3D=3D 80201fa4, ra =3D=
=3D 802048f4
    2023-06-09T11:44:49.325357  =


    2023-06-09T11:44:49.342059  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dale=
rt RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D1>
    2023-06-09T11:44:49.342170  =

   =

 =20
