Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C76702A87
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 12:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240737AbjEOKdZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 06:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240673AbjEOKdY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 06:33:24 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB628113
        for <stable@vger.kernel.org>; Mon, 15 May 2023 03:33:20 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-643995a47f7so13088687b3a.1
        for <stable@vger.kernel.org>; Mon, 15 May 2023 03:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684146800; x=1686738800;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wHBzMU0fiWkNVQjtFGnpr/jxpHoGARJ7CPnN6XWHJ2o=;
        b=40qzUDtBhQp5rJg54nJDbsYRNIPVXXmeCeIjUqCXvch6T/hW0tUwDqyaLdYp3a2IpT
         +msAnYo++cfZrJv+i1Auz+9W3Jjd8ib4VwvkrJOdMEZVIE75lmQT13G6CR96Hpf2XPO7
         QdadP8VK5w7Aq3UCBMxn6lPf1pib2TqRXBDjFsdA0+kVDGJEmLXTdxSloo2nohy2ud4i
         22tKooftDAwATcqAj5vAC3Uv4dhdD9UCjkxUvl9Lwtf/Ab4yRGoxhBbnybbadaBfWsx0
         KFd4jeDpl8loJ8btJq37/c2w08Rrt58YKd4dYnmO7Q0PdEsLzTpyI9kG7utaXNXAKZ5L
         fSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684146800; x=1686738800;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wHBzMU0fiWkNVQjtFGnpr/jxpHoGARJ7CPnN6XWHJ2o=;
        b=VAtPeKIs2M2lGS9M5dUtBZ7TaVxfhYpKpY3OnHL+W08RIr0Iga0L5LcqsNOoIIJQ7q
         TI53T6LqQJpwuMMvQ3/FrrcZMaju2O++tfsoACg1VTcYosnhLv7x0og6LbRl17ythyDE
         9TYtnAVv56NUO6LbkYABQfSap5ePR6euEWGF+Fvr/sAQ9FUbzeQsio6VbRf5Y5SUUYrw
         sJu+EMhtTgfBLtDd9Su3Fl4Pz9+bvjuNoZzV3W2nRYZVMO584HHZ3myTgqw+um6tgArC
         +eA204zKA73jTC+raZclXAhfCTOaoSzKpnIwskJzXuZxYa57exwU2RaKaMg7dpz8f1eb
         NAzg==
X-Gm-Message-State: AC+VfDw+c4C1BtuA3V4o/pySDgWABpQ4lzl/gZXni0vmxHqLiREE2N/Z
        jP/NTF7JcPoAwb2Kfoi6JL1Y7qyNq/G3r6FASMP1pw==
X-Google-Smtp-Source: ACHHUZ5ari66MmCrpWJwijfyZlKP9ClVYRmMqeTVDIoQjcNG7E+kpd8eUSASIMwowd6QDrEa5FkxCA==
X-Received: by 2002:a05:6a00:17a7:b0:645:454c:286d with SMTP id s39-20020a056a0017a700b00645454c286dmr38849430pfg.3.1684146799862;
        Mon, 15 May 2023 03:33:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c1-20020aa78e01000000b00622e01989cbsm5186821pfr.176.2023.05.15.03.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 03:33:19 -0700 (PDT)
Message-ID: <64620a6f.a70a0220.857cf.869a@mx.google.com>
Date:   Mon, 15 May 2023 03:33:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.111-129-g30db4ad3561c4
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 172 runs,
 8 regressions (v5.15.111-129-g30db4ad3561c4)
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

stable-rc/queue/5.15 baseline: 172 runs, 8 regressions (v5.15.111-129-g30db=
4ad3561c4)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
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

sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.111-129-g30db4ad3561c4/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.111-129-g30db4ad3561c4
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      30db4ad3561c4dd9bc4af192a08cffe22d5db082 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461d83b74a854cf832e8613

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-129-g30db4ad3561c4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-129-g30db4ad3561c4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461d83b74a854cf832e8618
        failing since 47 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-15T06:59:00.590251  + set<8>[   11.480082] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10318439_1.4.2.3.1>

    2023-05-15T06:59:00.590334   +x

    2023-05-15T06:59:00.694671  / # #

    2023-05-15T06:59:00.795264  export SHELL=3D/bin/sh

    2023-05-15T06:59:00.795409  #

    2023-05-15T06:59:00.895918  / # export SHELL=3D/bin/sh. /lava-10318439/=
environment

    2023-05-15T06:59:00.896073  =


    2023-05-15T06:59:00.996593  / # . /lava-10318439/environment/lava-10318=
439/bin/lava-test-runner /lava-10318439/1

    2023-05-15T06:59:00.996842  =


    2023-05-15T06:59:01.001660  / # /lava-10318439/bin/lava-test-runner /la=
va-10318439/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6461d9fccdd8b1b6202e8621

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-129-g30db4ad3561c4/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-129-g30db4ad3561c4/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6461d9fccdd8b1b6202e8=
622
        failing since 100 days (last pass: v5.15.91-12-g3290f78df1ab, first=
 fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6461d70a673f55abae2e85f8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-129-g30db4ad3561c4/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-129-g30db4ad3561c4/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461d70a673f55abae2e85fd
        failing since 117 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-15T06:53:52.457377  <8>[   10.026133] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3590793_1.5.2.4.1>
    2023-05-15T06:53:52.567564  / # #
    2023-05-15T06:53:52.671197  export SHELL=3D/bin/sh
    2023-05-15T06:53:52.672235  #
    2023-05-15T06:53:52.774642  / # export SHELL=3D/bin/sh. /lava-3590793/e=
nvironment
    2023-05-15T06:53:52.775698  =

    2023-05-15T06:53:52.776287  / # <3>[   10.273575] Bluetooth: hci0: comm=
and 0xfc18 tx timeout
    2023-05-15T06:53:52.878739  . /lava-3590793/environment/lava-3590793/bi=
n/lava-test-runner /lava-3590793/1
    2023-05-15T06:53:52.880258  =

    2023-05-15T06:53:52.886712  / # /lava-3590793/bin/lava-test-runner /lav=
a-3590793/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461d8df6f46785bf02e8618

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-129-g30db4ad3561c4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-129-g30db4ad3561c4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461d8df6f46785bf02e861d
        failing since 47 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-15T07:01:35.091079  + <8>[   10.220624] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10318424_1.4.2.3.1>

    2023-05-15T07:01:35.091172  set +x

    2023-05-15T07:01:35.192463  #

    2023-05-15T07:01:35.192838  =


    2023-05-15T07:01:35.293522  / # #export SHELL=3D/bin/sh

    2023-05-15T07:01:35.293752  =


    2023-05-15T07:01:35.394364  / # export SHELL=3D/bin/sh. /lava-10318424/=
environment

    2023-05-15T07:01:35.394600  =


    2023-05-15T07:01:35.495218  / # . /lava-10318424/environment/lava-10318=
424/bin/lava-test-runner /lava-10318424/1

    2023-05-15T07:01:35.495528  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461d7c2552be7f2d12e8619

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-129-g30db4ad3561c4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-129-g30db4ad3561c4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461d7c2552be7f2d12e861e
        failing since 47 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-15T06:56:52.272784  <8>[   10.420313] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10318401_1.4.2.3.1>

    2023-05-15T06:56:52.276230  + set +x

    2023-05-15T06:56:52.380902  / # #

    2023-05-15T06:56:52.481478  export SHELL=3D/bin/sh

    2023-05-15T06:56:52.481689  #

    2023-05-15T06:56:52.582184  / # export SHELL=3D/bin/sh. /lava-10318401/=
environment

    2023-05-15T06:56:52.582410  =


    2023-05-15T06:56:52.682966  / # . /lava-10318401/environment/lava-10318=
401/bin/lava-test-runner /lava-10318401/1

    2023-05-15T06:56:52.683253  =


    2023-05-15T06:56:52.688175  / # /lava-10318401/bin/lava-test-runner /la=
va-10318401/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461d7f16f5422066f2e868b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-129-g30db4ad3561c4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-129-g30db4ad3561c4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461d7f16f5422066f2e8690
        failing since 47 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-15T06:57:42.598884  + set +x<8>[   10.690159] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10318416_1.4.2.3.1>

    2023-05-15T06:57:42.599000  =


    2023-05-15T06:57:42.703044  / # #

    2023-05-15T06:57:42.803669  export SHELL=3D/bin/sh

    2023-05-15T06:57:42.803829  #

    2023-05-15T06:57:42.904285  / # export SHELL=3D/bin/sh. /lava-10318416/=
environment

    2023-05-15T06:57:42.904466  =


    2023-05-15T06:57:43.005026  / # . /lava-10318416/environment/lava-10318=
416/bin/lava-test-runner /lava-10318416/1

    2023-05-15T06:57:43.005309  =


    2023-05-15T06:57:43.009906  / # /lava-10318416/bin/lava-test-runner /la=
va-10318416/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461d7d1f559be2a782e862d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-129-g30db4ad3561c4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-129-g30db4ad3561c4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461d7d1f559be2a782e8632
        failing since 47 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-15T06:57:02.192277  <8>[   11.519850] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10318434_1.4.2.3.1>

    2023-05-15T06:57:02.299523  / # #

    2023-05-15T06:57:02.401747  export SHELL=3D/bin/sh

    2023-05-15T06:57:02.402448  #

    2023-05-15T06:57:02.503831  / # export SHELL=3D/bin/sh. /lava-10318434/=
environment

    2023-05-15T06:57:02.504529  =


    2023-05-15T06:57:02.606005  / # . /lava-10318434/environment/lava-10318=
434/bin/lava-test-runner /lava-10318434/1

    2023-05-15T06:57:02.606332  =


    2023-05-15T06:57:02.610749  / # /lava-10318434/bin/lava-test-runner /la=
va-10318434/1

    2023-05-15T06:57:02.616206  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/6461d80ba264e531cf2e8630

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-129-g30db4ad3561c4/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-=
h2-plus-orangepi-r1.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-129-g30db4ad3561c4/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-=
h2-plus-orangepi-r1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461d80ba264e531cf2e8635
        failing since 103 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.90-203-gea2e94bef77e)

    2023-05-15T06:57:54.159199  / # #
    2023-05-15T06:57:54.264766  export SHELL=3D/bin/sh
    2023-05-15T06:57:54.266354  #
    2023-05-15T06:57:54.369639  / # export SHELL=3D/bin/sh. /lava-3590759/e=
nvironment
    2023-05-15T06:57:54.371198  =

    2023-05-15T06:57:54.474608  / # . /lava-3590759/environment/lava-359075=
9/bin/lava-test-runner /lava-3590759/1
    2023-05-15T06:57:54.477241  =

    2023-05-15T06:57:54.484859  / # /lava-3590759/bin/lava-test-runner /lav=
a-3590759/1
    2023-05-15T06:57:54.607708  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-15T06:57:54.608756  + cd /lava-3590759/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
