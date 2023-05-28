Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF31E713D2D
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjE1TWn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjE1TWm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:22:42 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4294BF3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:22:35 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b01d912924so19055995ad.1
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685301754; x=1687893754;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ljdwNx5v5VBtZsRHGd1X+snzC3QlortfdAjW0Ep2kGA=;
        b=RpdemDOlKFk7rI8FAuNBq3IUFe4lrpA3qjNFBPJ89RRUxdfqHBNo2x+b0MgPzkgRGu
         1eemUsTTyr0zaPZhqBWUWQW5deErJ8nhhglBpvVBfHlqeIn+63UVeQDxa0FPGWCLmsY3
         cSADxm8RkNcg4YAOhDGjGMSssDQ2qy3n4Dzgtvk9ds1uMFaa+Rm4+NnbNqC96Fxi5/56
         u7brG0h7GqG9Pt/CTMW8lQKjUO9fvqIG9eZKMvGVe4tq9t2drSt+HYMZKiJo7iLrwGsc
         WtPEiEitfsxyNV2pIT0ljEgm9epCGMcd9GWI4JnDmXIpxqeM01KzvuPVYP7pRtMR56KI
         +BVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685301754; x=1687893754;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ljdwNx5v5VBtZsRHGd1X+snzC3QlortfdAjW0Ep2kGA=;
        b=J7FTh6sQbX4ZAPi+EmbVCJyjcdd8izZkrgR+ge5dL6C+dABPGLq9ldU3YByEsea2Gs
         Zrvw2fF86j3wVCNZSjFekRqh//cqAsQWP9KO0ttSfBbE8289ZR8JJQIOy8Km01oLE5fh
         gfM3BQLWycysN5OJcSGOPIVKqmXGW3VLFE/Qo89qlxk0ID49Z3magEt1uwPSZsKsomBT
         JN+UF/b2t06EiZ3IKNamH3N5Cn3NEMc1kwZ0h/avfbaZ5fOBBReFID9kNbdHy78I1WOW
         2hfJipVfhOvAvEMpRKZtAKeC7UfRVEAgOgNAaPEgyZuwewDc4GBHDFvWmPffl4yllKfF
         PXhA==
X-Gm-Message-State: AC+VfDw9zDhchyhKXhkUG5SwocIwwtAtRdet28n4cskQ6vf8ewxuZN/J
        u5EpHMbYLhfDGw9XMI5jqosl2Au85UPVhZL1uVkTlg==
X-Google-Smtp-Source: ACHHUZ7K9FxxPtOtSvpVS/JSoYYwuVjkK7bhf2OKQj01EYTNckcYnVKgW3A6viaE6CyuwS80rISnDg==
X-Received: by 2002:a17:902:a40d:b0:1b0:26f0:8778 with SMTP id p13-20020a170902a40d00b001b026f08778mr4438955plq.19.1685301754103;
        Sun, 28 May 2023 12:22:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w12-20020a170902e88c00b001b0358848b0sm1650228plg.161.2023.05.28.12.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 12:22:33 -0700 (PDT)
Message-ID: <6473a9f9.170a0220.86b8f.2920@mx.google.com>
Date:   Sun, 28 May 2023 12:22:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.112-229-gb30ec1feec1e8
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 170 runs,
 9 regressions (v5.15.112-229-gb30ec1feec1e8)
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

stable-rc/queue/5.15 baseline: 170 runs, 9 regressions (v5.15.112-229-gb30e=
c1feec1e8)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
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

kontron-pitx-imx8m           | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 2          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.112-229-gb30ec1feec1e8/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.112-229-gb30ec1feec1e8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b30ec1feec1e804f461c1ef9f89d79f0dcd2e2e9 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647374532073ec6e5f2e860a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-229-gb30ec1feec1e8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-229-gb30ec1feec1e8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647374532073ec6e5f2e860f
        failing since 61 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-28T15:33:19.122426  + <8>[   11.372924] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10494785_1.4.2.3.1>

    2023-05-28T15:33:19.122614  set +x

    2023-05-28T15:33:19.228233  / # #

    2023-05-28T15:33:19.330868  export SHELL=3D/bin/sh

    2023-05-28T15:33:19.331783  #

    2023-05-28T15:33:19.433680  / # export SHELL=3D/bin/sh. /lava-10494785/=
environment

    2023-05-28T15:33:19.434526  =


    2023-05-28T15:33:19.536197  / # . /lava-10494785/environment/lava-10494=
785/bin/lava-test-runner /lava-10494785/1

    2023-05-28T15:33:19.537497  =


    2023-05-28T15:33:19.542434  / # /lava-10494785/bin/lava-test-runner /la=
va-10494785/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647374542073ec6e5f2e8617

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-229-gb30ec1feec1e8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-229-gb30ec1feec1e8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647374542073ec6e5f2e861c
        failing since 61 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-28T15:33:17.505135  <8>[   11.114619] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10494792_1.4.2.3.1>

    2023-05-28T15:33:17.508223  + set +x

    2023-05-28T15:33:17.610109  #

    2023-05-28T15:33:17.611599  =


    2023-05-28T15:33:17.713634  / # #export SHELL=3D/bin/sh

    2023-05-28T15:33:17.714401  =


    2023-05-28T15:33:17.816080  / # export SHELL=3D/bin/sh. /lava-10494792/=
environment

    2023-05-28T15:33:17.816825  =


    2023-05-28T15:33:17.918482  / # . /lava-10494792/environment/lava-10494=
792/bin/lava-test-runner /lava-10494792/1

    2023-05-28T15:33:17.919768  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647375dcabc57ec5492e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-229-gb30ec1feec1e8/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-229-gb30ec1feec1e8/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647375dcabc57ec5492e8=
5e7
        failing since 114 days (last pass: v5.15.91-12-g3290f78df1ab, first=
 fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6473776f3faff39e6a2e85f5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-229-gb30ec1feec1e8/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-229-gb30ec1feec1e8/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473776f3faff39e6a2e85f8
        failing since 131 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-28T15:46:38.378321  <8>[    9.972713] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3626748_1.5.2.4.1>
    2023-05-28T15:46:38.489477  / # #
    2023-05-28T15:46:38.593330  export SHELL=3D/bin/sh
    2023-05-28T15:46:38.594512  #
    2023-05-28T15:46:38.696787  / # export SHELL=3D/bin/sh. /lava-3626748/e=
nvironment
    2023-05-28T15:46:38.698031  =

    2023-05-28T15:46:38.800549  / # . /lava-3626748/environment/lava-362674=
8/bin/lava-test-runner /lava-3626748/1
    2023-05-28T15:46:38.802399  =

    2023-05-28T15:46:38.802876  / # <3>[   10.353078] Bluetooth: hci0: comm=
and 0xfc18 tx timeout
    2023-05-28T15:46:38.807142  /lava-3626748/bin/lava-test-runner /lava-36=
26748/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473745513fe89921a2e85f4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-229-gb30ec1feec1e8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-229-gb30ec1feec1e8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473745513fe89921a2e85f9
        failing since 61 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-28T15:33:25.066992  + <8>[   10.275868] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10494814_1.4.2.3.1>

    2023-05-28T15:33:25.067106  set +x

    2023-05-28T15:33:25.168528  #

    2023-05-28T15:33:25.168774  =


    2023-05-28T15:33:25.269443  / # #export SHELL=3D/bin/sh

    2023-05-28T15:33:25.270432  =


    2023-05-28T15:33:25.371928  / # export SHELL=3D/bin/sh. /lava-10494814/=
environment

    2023-05-28T15:33:25.372574  =


    2023-05-28T15:33:25.473903  / # . /lava-10494814/environment/lava-10494=
814/bin/lava-test-runner /lava-10494814/1

    2023-05-28T15:33:25.474945  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647374404b44f669072e869e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-229-gb30ec1feec1e8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-229-gb30ec1feec1e8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647374404b44f669072e86a3
        failing since 61 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-28T15:33:03.070431  <8>[   10.590476] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10494767_1.4.2.3.1>

    2023-05-28T15:33:03.073481  + set +x

    2023-05-28T15:33:03.177764  =


    2023-05-28T15:33:03.279941  / # #export SHELL=3D/bin/sh

    2023-05-28T15:33:03.280671  =


    2023-05-28T15:33:03.382139  / # export SHELL=3D/bin/sh. /lava-10494767/=
environment

    2023-05-28T15:33:03.382855  =


    2023-05-28T15:33:03.484309  / # . /lava-10494767/environment/lava-10494=
767/bin/lava-test-runner /lava-10494767/1

    2023-05-28T15:33:03.485832  =


    2023-05-28T15:33:03.490561  / # /lava-10494767/bin/lava-test-runner /la=
va-10494767/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473744b2073ec6e5f2e85e8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-229-gb30ec1feec1e8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-229-gb30ec1feec1e8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473744b2073ec6e5f2e85ed
        failing since 61 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-28T15:33:05.423124  + set<8>[   10.723070] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10494779_1.4.2.3.1>

    2023-05-28T15:33:05.423209   +x

    2023-05-28T15:33:05.526974  / # #

    2023-05-28T15:33:05.627552  export SHELL=3D/bin/sh

    2023-05-28T15:33:05.627712  #

    2023-05-28T15:33:05.728221  / # export SHELL=3D/bin/sh. /lava-10494779/=
environment

    2023-05-28T15:33:05.728375  =


    2023-05-28T15:33:05.828903  / # . /lava-10494779/environment/lava-10494=
779/bin/lava-test-runner /lava-10494779/1

    2023-05-28T15:33:05.829145  =


    2023-05-28T15:33:05.833955  / # /lava-10494779/bin/lava-test-runner /la=
va-10494779/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-pitx-imx8m           | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 2          =


  Details:     https://kernelci.org/test/plan/id/647378cf3442896fa22e864e

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-229-gb30ec1feec1e8/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pit=
x-imx8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-229-gb30ec1feec1e8/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pit=
x-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647378cf3442896fa22e8651
        new failure (last pass: v5.15.112-229-gf0f8d123660a)

    2023-05-28T15:52:31.606717  / # #
    2023-05-28T15:52:31.709466  export SHELL=3D/bin/sh
    2023-05-28T15:52:31.710223  #
    2023-05-28T15:52:31.812298  / # export SHELL=3D/bin/sh. /lava-345928/en=
vironment
    2023-05-28T15:52:31.813061  =

    2023-05-28T15:52:31.914958  / # . /lava-345928/environment/lava-345928/=
bin/lava-test-runner /lava-345928/1
    2023-05-28T15:52:31.916246  =

    2023-05-28T15:52:31.933656  / # /lava-345928/bin/lava-test-runner /lava=
-345928/1
    2023-05-28T15:52:31.981568  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-28T15:52:31.982069  + cd /l<8>[   12.073361] <LAVA_SIGNAL_START=
RUN 1_bootrr 345928_1.5.2.4.5> =

    ... (10 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/647=
378cf3442896fa22e8661
        new failure (last pass: v5.15.112-229-gf0f8d123660a)

    2023-05-28T15:52:34.299664  /lava-345928/1/../bin/lava-test-case
    2023-05-28T15:52:34.300154  <8>[   14.485872] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>   =

 =20
