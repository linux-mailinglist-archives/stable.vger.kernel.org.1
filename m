Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E996F9801
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 11:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjEGJ3C (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 05:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjEGJ3B (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 05:29:01 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9964211556
        for <stable@vger.kernel.org>; Sun,  7 May 2023 02:28:58 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-643bb9cdd6eso1017926b3a.1
        for <stable@vger.kernel.org>; Sun, 07 May 2023 02:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683451737; x=1686043737;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GOHGBjHXQ2h3vJRigMoa81Za5MBVKC5bBKKMsYf4zD4=;
        b=TEvADrrmjLJDogqSik3stAKxbmFVWvBA6K9kp7Yf6LU1B05tgFd81WosNlr5/rDck/
         f2kQNM+8CSTxIhYwDArNH6dMWNcEwcrUcPgzZR8IY3nAPVYn7HVDrtXCpMLXy9uCaaOB
         PYvsKfu4FPrxcTsDXQQpsX7jQIXNkKhBIyYRTC0V7YQn1ljMjtjrmn679F6P7oolzMnR
         OhbN40Q0ZhTF7/zInS8j7ZEZuxTnQF/23Bi2/o2RmVnUOLrEb8YidY5CyIZ7NpfVbzIA
         Bn2eHoaf8r26nXtlrgdqG6K7oIEsYSO2fBS0vBcZTzEBCUYfYo19FoEqXfm1e2GCtZv6
         S+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683451737; x=1686043737;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GOHGBjHXQ2h3vJRigMoa81Za5MBVKC5bBKKMsYf4zD4=;
        b=lYsI8dUU2tNLrB5VauEFFoy33x1OjF54ceG3MA1O5rsSMKdVIDGbna4g9oatFP9eja
         VzU7R9ngiOKtXWYMnqCk+VLmr8XYObArs9UqxBTpZ2Xdhs4p8BlatlLSUcta2qoLJYZU
         /2oqKrfBZ3IBhGgKeLrnZZN0DMiJqLX8aDJ3oVeSzQCV4hVkL1MkqT401tU/WcdYQTZk
         i/s6LcwqS9G0jgZeM/b1sn6CUJgkSgOTOijBP0e2VA42C5zQjP8V86Yney94WrFns8Ws
         d2llyx9ppIVEE33uEMkQYEehgnoInOfBm+NBAqT5hxJ9K4FVMQL4F7jxrPJ+MWS39ve3
         3Uxg==
X-Gm-Message-State: AC+VfDxK1Zu9pbwou3BwgUeWkr+31PEalL65jhuFibhMnzreaYBlxmlU
        2BdaU9PoMJRuRb1FXFSxrhJK+jsB4BzndxMEanT/aQ==
X-Google-Smtp-Source: ACHHUZ7FPD43cAABTTBb5Yod2b8Kp3UMSvbv269La+KBxGzgf2m5Mg55VOjJMB0ZF2WounqRDRPJ4Q==
X-Received: by 2002:a05:6a20:4658:b0:ec:8f81:e9f7 with SMTP id eb24-20020a056a20465800b000ec8f81e9f7mr7190995pzb.16.1683451737473;
        Sun, 07 May 2023 02:28:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x20-20020aa79194000000b0063ba9108c5csm4293033pfa.149.2023.05.07.02.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 02:28:56 -0700 (PDT)
Message-ID: <64576f58.a70a0220.acdc8.7f66@mx.google.com>
Date:   Sun, 07 May 2023 02:28:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.105-716-gfdc6dc8bf16a
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 162 runs,
 13 regressions (v5.15.105-716-gfdc6dc8bf16a)
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

stable-rc/queue/5.15 baseline: 162 runs, 13 regressions (v5.15.105-716-gfdc=
6dc8bf16a)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 4          =

qemu_i386                    | i386   | lab-collabora   | gcc-10   | i386_d=
efconfig               | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.105-716-gfdc6dc8bf16a/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.105-716-gfdc6dc8bf16a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      fdc6dc8bf16a619850b2adf1fe4be9b53985a4dd =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457394392ecd247312e85eb

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-gfdc6dc8bf16a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-gfdc6dc8bf16a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457394392ecd247312e85f0
        failing since 39 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-07T05:37:50.468597  + set<8>[   11.287971] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10223021_1.4.2.3.1>

    2023-05-07T05:37:50.468685   +x

    2023-05-07T05:37:50.572800  / # #

    2023-05-07T05:37:50.673544  export SHELL=3D/bin/sh

    2023-05-07T05:37:50.673753  #

    2023-05-07T05:37:50.774297  / # export SHELL=3D/bin/sh. /lava-10223021/=
environment

    2023-05-07T05:37:50.774500  =


    2023-05-07T05:37:50.875060  / # . /lava-10223021/environment/lava-10223=
021/bin/lava-test-runner /lava-10223021/1

    2023-05-07T05:37:50.875351  =


    2023-05-07T05:37:50.879703  / # /lava-10223021/bin/lava-test-runner /la=
va-10223021/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457394a3802a79d222e874a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-gfdc6dc8bf16a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-gfdc6dc8bf16a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457394a3802a79d222e874f
        failing since 39 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-07T05:37:54.913411  <8>[   10.962497] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10223064_1.4.2.3.1>

    2023-05-07T05:37:54.916746  + set +x

    2023-05-07T05:37:55.021724  =


    2023-05-07T05:37:55.123132  / # #export SHELL=3D/bin/sh

    2023-05-07T05:37:55.123897  =


    2023-05-07T05:37:55.225546  / # export SHELL=3D/bin/sh. /lava-10223064/=
environment

    2023-05-07T05:37:55.226328  =


    2023-05-07T05:37:55.327879  / # . /lava-10223064/environment/lava-10223=
064/bin/lava-test-runner /lava-10223064/1

    2023-05-07T05:37:55.328978  =


    2023-05-07T05:37:55.334007  / # /lava-10223064/bin/lava-test-runner /la=
va-10223064/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64573928d085b600872e8603

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-gfdc6dc8bf16a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-gfdc6dc8bf16a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64573928d085b600872e8608
        failing since 39 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-07T05:37:32.831337  + set +x

    2023-05-07T05:37:32.838006  <8>[   10.775620] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10223073_1.4.2.3.1>

    2023-05-07T05:37:32.942355  / # #

    2023-05-07T05:37:33.043013  export SHELL=3D/bin/sh

    2023-05-07T05:37:33.043248  #

    2023-05-07T05:37:33.143789  / # export SHELL=3D/bin/sh. /lava-10223073/=
environment

    2023-05-07T05:37:33.144019  =


    2023-05-07T05:37:33.244645  / # . /lava-10223073/environment/lava-10223=
073/bin/lava-test-runner /lava-10223073/1

    2023-05-07T05:37:33.244982  =


    2023-05-07T05:37:33.249393  / # /lava-10223073/bin/lava-test-runner /la=
va-10223073/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64573930d085b600872e8641

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-gfdc6dc8bf16a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-gfdc6dc8bf16a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64573930d085b600872e8646
        failing since 39 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-07T05:37:37.863237  + set +x

    2023-05-07T05:37:37.869372  <8>[   11.121151] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10223024_1.4.2.3.1>

    2023-05-07T05:37:37.972431  #

    2023-05-07T05:37:37.972902  =


    2023-05-07T05:37:38.073643  / # #export SHELL=3D/bin/sh

    2023-05-07T05:37:38.073915  =


    2023-05-07T05:37:38.174593  / # export SHELL=3D/bin/sh. /lava-10223024/=
environment

    2023-05-07T05:37:38.174902  =


    2023-05-07T05:37:38.275573  / # . /lava-10223024/environment/lava-10223=
024/bin/lava-test-runner /lava-10223024/1

    2023-05-07T05:37:38.276041  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64573941e6bcdb09f52e8603

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-gfdc6dc8bf16a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-gfdc6dc8bf16a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64573941e6bcdb09f52e8608
        failing since 39 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-07T05:37:44.536089  + <8>[   11.048221] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10223038_1.4.2.3.1>

    2023-05-07T05:37:44.536199  set +x

    2023-05-07T05:37:44.640210  / # #

    2023-05-07T05:37:44.741012  export SHELL=3D/bin/sh

    2023-05-07T05:37:44.741312  #

    2023-05-07T05:37:44.841866  / # export SHELL=3D/bin/sh. /lava-10223038/=
environment

    2023-05-07T05:37:44.842106  =


    2023-05-07T05:37:44.942685  / # . /lava-10223038/environment/lava-10223=
038/bin/lava-test-runner /lava-10223038/1

    2023-05-07T05:37:44.943014  =


    2023-05-07T05:37:44.947864  / # /lava-10223038/bin/lava-test-runner /la=
va-10223038/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645738b8fac17250502e85e7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-gfdc6dc8bf16a/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-i=
mx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-gfdc6dc8bf16a/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-i=
mx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645738b8fac17250502e85ec
        failing since 99 days (last pass: v5.15.81-121-gcb14018a85f6, first=
 fail: v5.15.90-146-gbf7101723cc0)

    2023-05-07T05:35:44.996510  + set +x
    2023-05-07T05:35:44.996753  [    9.451126] <LAVA_SIGNAL_ENDRUN 0_dmesg =
942400_1.5.2.3.1>
    2023-05-07T05:35:45.104721  / # #
    2023-05-07T05:35:45.206823  export SHELL=3D/bin/sh
    2023-05-07T05:35:45.207361  #
    2023-05-07T05:35:45.308429  / # export SHELL=3D/bin/sh. /lava-942400/en=
vironment
    2023-05-07T05:35:45.308926  =

    2023-05-07T05:35:45.410166  / # . /lava-942400/environment/lava-942400/=
bin/lava-test-runner /lava-942400/1
    2023-05-07T05:35:45.410831  =

    2023-05-07T05:35:45.413452  / # /lava-942400/bin/lava-test-runner /lava=
-942400/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64573936a2520825a32e8661

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-gfdc6dc8bf16a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-gfdc6dc8bf16a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64573936a2520825a32e8666
        failing since 39 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-07T05:37:45.769870  + set<8>[   11.098316] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10223044_1.4.2.3.1>

    2023-05-07T05:37:45.769959   +x

    2023-05-07T05:37:45.874473  / # #

    2023-05-07T05:37:45.975118  export SHELL=3D/bin/sh

    2023-05-07T05:37:45.975350  #

    2023-05-07T05:37:46.075884  / # export SHELL=3D/bin/sh. /lava-10223044/=
environment

    2023-05-07T05:37:46.076142  =


    2023-05-07T05:37:46.176762  / # . /lava-10223044/environment/lava-10223=
044/bin/lava-test-runner /lava-10223044/1

    2023-05-07T05:37:46.177070  =


    2023-05-07T05:37:46.181904  / # /lava-10223044/bin/lava-test-runner /la=
va-10223044/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 4          =


  Details:     https://kernelci.org/test/plan/id/64573d7ec99731bca52e8613

  Results:     153 PASS, 14 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-gfdc6dc8bf16a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-gfdc6dc8bf16a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/64573d7ec99731bca52e862d
        failing since 0 day (last pass: v5.15.105-406-g93046c7116de, first =
fail: v5.15.105-716-g0ba96946e8d1)

    2023-05-07T05:55:57.429490  /lava-10223409/1/../bin/lava-test-case

    2023-05-07T05:55:57.435941  <8>[   61.557302] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/64573d7ec99731bca52e862d
        failing since 0 day (last pass: v5.15.105-406-g93046c7116de, first =
fail: v5.15.105-716-g0ba96946e8d1)

    2023-05-07T05:55:57.429490  /lava-10223409/1/../bin/lava-test-case

    2023-05-07T05:55:57.435941  <8>[   61.557302] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/64573d7ec99731bca52e862f
        failing since 0 day (last pass: v5.15.105-406-g93046c7116de, first =
fail: v5.15.105-716-g0ba96946e8d1)

    2023-05-07T05:55:56.389544  /lava-10223409/1/../bin/lava-test-case

    2023-05-07T05:55:56.396073  <8>[   60.517457] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64573d7ec99731bca52e86b7
        failing since 0 day (last pass: v5.15.105-406-g93046c7116de, first =
fail: v5.15.105-716-g0ba96946e8d1)

    2023-05-07T05:55:42.211529  + set +x

    2023-05-07T05:55:42.217713  <8>[   46.339240] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10223409_1.5.2.3.1>

    2023-05-07T05:55:42.323091  / # #

    2023-05-07T05:55:42.423904  export SHELL=3D/bin/sh

    2023-05-07T05:55:42.424146  #

    2023-05-07T05:55:42.524763  / # export SHELL=3D/bin/sh. /lava-10223409/=
environment

    2023-05-07T05:55:42.525010  =


    2023-05-07T05:55:42.625646  / # . /lava-10223409/environment/lava-10223=
409/bin/lava-test-runner /lava-10223409/1

    2023-05-07T05:55:42.626049  =


    2023-05-07T05:55:42.630745  / # /lava-10223409/bin/lava-test-runner /la=
va-10223409/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_i386                    | i386   | lab-collabora   | gcc-10   | i386_d=
efconfig               | 1          =


  Details:     https://kernelci.org/test/plan/id/64573978d595a4cadb2e85f2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-gfdc6dc8bf16a/i386/i386_defconfig/gcc-10/lab-collabora/baseline-qemu_i=
386.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-gfdc6dc8bf16a/i386/i386_defconfig/gcc-10/lab-collabora/baseline-qemu_i=
386.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64573978d595a4cadb2e8=
5f3
        new failure (last pass: v5.15.105-716-g0ba96946e8d1) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/645741203817fbefdf2e85e6

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-gfdc6dc8bf16a/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-=
pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-gfdc6dc8bf16a/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-=
pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645741203817fbefdf2e8611
        failing since 109 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-07T06:11:27.385384  + set +x
    2023-05-07T06:11:27.389551  <8>[   16.152142] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3558635_1.5.2.4.1>
    2023-05-07T06:11:27.510025  / # #
    2023-05-07T06:11:27.615867  export SHELL=3D/bin/sh
    2023-05-07T06:11:27.617391  #
    2023-05-07T06:11:27.720848  / # export SHELL=3D/bin/sh. /lava-3558635/e=
nvironment
    2023-05-07T06:11:27.722378  =

    2023-05-07T06:11:27.825959  / # . /lava-3558635/environment/lava-355863=
5/bin/lava-test-runner /lava-3558635/1
    2023-05-07T06:11:27.828732  =

    2023-05-07T06:11:27.831081  / # /lava-3558635/bin/lava-test-runner /lav=
a-3558635/1 =

    ... (12 line(s) more)  =

 =20
