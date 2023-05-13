Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1C370196E
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 21:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjEMTAj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 15:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEMTAi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 15:00:38 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D97D268D
        for <stable@vger.kernel.org>; Sat, 13 May 2023 12:00:35 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1aafa41116fso76707135ad.1
        for <stable@vger.kernel.org>; Sat, 13 May 2023 12:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684004434; x=1686596434;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CXRZvndtiZWiDmR8+RGI0QBs3/BZDgLXmYa6tAqBgqM=;
        b=OW9mrIXqcJ9qCEpgxg5jEMC2XU32/nRQbUX7GZuJmuQBkg1CY/wtVdcJIWYBrJX8xz
         oUQIkHNRf/XxKWKWrnedQoTY2RbDcgsFc02vnLP880N+YgAl8czfBarZaWHQLnWX60x7
         way6uxGE5rsKI4e9L+bccEQjT4Z02ObU5uMbdz2qKjESyx2PhlbZ+72aZ7E13TMQIDd8
         lFtnipytMNAStqf32+NmcBlpzANwf3CT2gNIdEx2dwW15GjEzIXEuWoD2Zz+B2AJyXp+
         DMaJClrM4xFyVHLsnd8KYNS8wWSO2nScNO7+hugNH0rCL6ZLsWtY4plBTj3ZVodSOOvP
         Ys1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684004434; x=1686596434;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CXRZvndtiZWiDmR8+RGI0QBs3/BZDgLXmYa6tAqBgqM=;
        b=cdDfOT6f0MdF3Cf0xS7nQDnxVhyQnM7pcPAfa3Tc2zV431mLkYL9CRl9VGO1CNW9GV
         KY4jfA68YelpM++RDr6n1mJ1cJFB/YqqGaYR9GpY8Osy1rP2fhjm35XGtPwWrKDHT2cj
         zIWDimPplEYM9C/n+DLLEa8ZhwBukf8M4sG6bljy9MunBJ/5sbXvKvf5jXgJIET9Tq5J
         uGxk79V1Q/+LJXZL7DuvN63UVPdkGZHOXnbLrMIAB5JT6hIu/1oqZOdRqcMqGaD49Hyh
         KXDUozreJFveqtdF9Str0RLTSaIXZW0n7M30AZ90ouHoa+3NjEmht26w3MyGYanHEkc4
         yWgA==
X-Gm-Message-State: AC+VfDxULr7clgPRbCHfjJvEGlOZfV7HPymxVN1Ux7FzdDoM7gMDgcQA
        FZbvkQOL2FhTbCWkDbvpFSTkBbrprj1vkv6wsEA=
X-Google-Smtp-Source: ACHHUZ6rnZaVVNiEf2rV1xrPErApKrYlYPsMxy4roWoD+0tV41Wp3CuWMFGhYzAa86p48Z4nnW6/MQ==
X-Received: by 2002:a17:902:da89:b0:1ac:acb5:4336 with SMTP id j9-20020a170902da8900b001acacb54336mr20800788plx.33.1684004434146;
        Sat, 13 May 2023 12:00:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902860c00b001ac6293577fsm10140603plo.110.2023.05.13.12.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 12:00:33 -0700 (PDT)
Message-ID: <645fde51.170a0220.99483.46ff@mx.google.com>
Date:   Sat, 13 May 2023 12:00:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.28-184-gf7399b5543f3d
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 181 runs,
 10 regressions (v6.1.28-184-gf7399b5543f3d)
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

stable-rc/queue/6.1 baseline: 181 runs, 10 regressions (v6.1.28-184-gf7399b=
5543f3d)

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

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.28-184-gf7399b5543f3d/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.28-184-gf7399b5543f3d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      f7399b5543f3dd4f5e067908e4f57a0f22fcf5aa =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645fa91211ae8d0f822e8666

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gf7399b5543f3d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gf7399b5543f3d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645fa91211ae8d0f822e866b
        failing since 45 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-13T15:12:59.529618  + set +x

    2023-05-13T15:12:59.536152  <8>[   10.519605] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10306348_1.4.2.3.1>

    2023-05-13T15:12:59.641323  / # #

    2023-05-13T15:12:59.741982  export SHELL=3D/bin/sh

    2023-05-13T15:12:59.742219  #

    2023-05-13T15:12:59.842736  / # export SHELL=3D/bin/sh. /lava-10306348/=
environment

    2023-05-13T15:12:59.842970  =


    2023-05-13T15:12:59.943481  / # . /lava-10306348/environment/lava-10306=
348/bin/lava-test-runner /lava-10306348/1

    2023-05-13T15:12:59.943818  =


    2023-05-13T15:12:59.949476  / # /lava-10306348/bin/lava-test-runner /la=
va-10306348/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645fa865b97587a9842e861b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gf7399b5543f3d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gf7399b5543f3d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645fa865b97587a9842e8620
        failing since 45 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-13T15:10:12.227544  + set<8>[   11.350926] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10306375_1.4.2.3.1>

    2023-05-13T15:10:12.228021   +x

    2023-05-13T15:10:12.335123  / # #

    2023-05-13T15:10:12.437220  export SHELL=3D/bin/sh

    2023-05-13T15:10:12.437862  #

    2023-05-13T15:10:12.539176  / # export SHELL=3D/bin/sh. /lava-10306375/=
environment

    2023-05-13T15:10:12.539823  =


    2023-05-13T15:10:12.641206  / # . /lava-10306375/environment/lava-10306=
375/bin/lava-test-runner /lava-10306375/1

    2023-05-13T15:10:12.642220  =


    2023-05-13T15:10:12.647531  / # /lava-10306375/bin/lava-test-runner /la=
va-10306375/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645fa858422b49f31e2e8629

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gf7399b5543f3d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gf7399b5543f3d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645fa858422b49f31e2e862e
        failing since 45 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-13T15:10:00.450256  <8>[   10.888700] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10306288_1.4.2.3.1>

    2023-05-13T15:10:00.453822  + set +x

    2023-05-13T15:10:00.559575  =


    2023-05-13T15:10:00.661514  / # #export SHELL=3D/bin/sh

    2023-05-13T15:10:00.662133  =


    2023-05-13T15:10:00.763407  / # export SHELL=3D/bin/sh. /lava-10306288/=
environment

    2023-05-13T15:10:00.764024  =


    2023-05-13T15:10:00.865301  / # . /lava-10306288/environment/lava-10306=
288/bin/lava-test-runner /lava-10306288/1

    2023-05-13T15:10:00.866452  =


    2023-05-13T15:10:00.871496  / # /lava-10306288/bin/lava-test-runner /la=
va-10306288/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/645fae695cf8e325972e85fa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gf7399b5543f3d/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gf7399b5543f3d/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645fae695cf8e325972e8=
5fb
        failing since 23 days (last pass: v6.1.22-477-g2128d4458cbc, first =
fail: v6.1.22-474-gecc61872327e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645fa83b6c2f6e26c02e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gf7399b5543f3d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gf7399b5543f3d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645fa83b6c2f6e26c02e85eb
        failing since 45 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-13T15:09:39.187328  + set +x

    2023-05-13T15:09:39.193830  <8>[   11.456485] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10306280_1.4.2.3.1>

    2023-05-13T15:09:39.298687  / # #

    2023-05-13T15:09:39.399401  export SHELL=3D/bin/sh

    2023-05-13T15:09:39.399632  #

    2023-05-13T15:09:39.500179  / # export SHELL=3D/bin/sh. /lava-10306280/=
environment

    2023-05-13T15:09:39.500408  =


    2023-05-13T15:09:39.600994  / # . /lava-10306280/environment/lava-10306=
280/bin/lava-test-runner /lava-10306280/1

    2023-05-13T15:09:39.601345  =


    2023-05-13T15:09:39.605874  / # /lava-10306280/bin/lava-test-runner /la=
va-10306280/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645fa84a201111ed892e866e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gf7399b5543f3d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gf7399b5543f3d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645fa84a201111ed892e8673
        failing since 45 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-13T15:09:46.022817  <8>[    8.028614] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10306296_1.4.2.3.1>

    2023-05-13T15:09:46.026030  + set +x

    2023-05-13T15:09:46.127980  #

    2023-05-13T15:09:46.128407  =


    2023-05-13T15:09:46.229173  / # #export SHELL=3D/bin/sh

    2023-05-13T15:09:46.229470  =


    2023-05-13T15:09:46.330109  / # export SHELL=3D/bin/sh. /lava-10306296/=
environment

    2023-05-13T15:09:46.330406  =


    2023-05-13T15:09:46.431047  / # . /lava-10306296/environment/lava-10306=
296/bin/lava-test-runner /lava-10306296/1

    2023-05-13T15:09:46.431488  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645fa857fee94747572e864b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gf7399b5543f3d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gf7399b5543f3d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645fa857fee94747572e8650
        failing since 45 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-13T15:09:59.081108  + set<8>[   11.476112] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10306316_1.4.2.3.1>

    2023-05-13T15:09:59.081204   +x

    2023-05-13T15:09:59.185569  / # #

    2023-05-13T15:09:59.286145  export SHELL=3D/bin/sh

    2023-05-13T15:09:59.286308  #

    2023-05-13T15:09:59.386850  / # export SHELL=3D/bin/sh. /lava-10306316/=
environment

    2023-05-13T15:09:59.387020  =


    2023-05-13T15:09:59.487583  / # . /lava-10306316/environment/lava-10306=
316/bin/lava-test-runner /lava-10306316/1

    2023-05-13T15:09:59.487838  =


    2023-05-13T15:09:59.492465  / # /lava-10306316/bin/lava-test-runner /la=
va-10306316/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645fa858422b49f31e2e861e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gf7399b5543f3d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gf7399b5543f3d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645fa858422b49f31e2e8623
        failing since 45 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-13T15:10:04.194883  + set<8>[   11.901151] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10306339_1.4.2.3.1>

    2023-05-13T15:10:04.194968   +x

    2023-05-13T15:10:04.299390  / # #

    2023-05-13T15:10:04.400034  export SHELL=3D/bin/sh

    2023-05-13T15:10:04.400174  #

    2023-05-13T15:10:04.500667  / # export SHELL=3D/bin/sh. /lava-10306339/=
environment

    2023-05-13T15:10:04.500797  =


    2023-05-13T15:10:04.601327  / # . /lava-10306339/environment/lava-10306=
339/bin/lava-test-runner /lava-10306339/1

    2023-05-13T15:10:04.601547  =


    2023-05-13T15:10:04.606061  / # /lava-10306339/bin/lava-test-runner /la=
va-10306339/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/645fabfc1ac87694e32e8629

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gf7399b5543f3d/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gf7399b5543f3d/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/645fabfc1ac87694e32e8645
        failing since 6 days (last pass: v6.1.22-704-ga3dcd1f09de2, first f=
ail: v6.1.22-1160-g24230ce6f2e2)

    2023-05-13T15:25:39.936190  /lava-10306506/1/../bin/lava-test-case

    2023-05-13T15:25:39.943044  <8>[   23.015021] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645fabfc1ac87694e32e86d1
        failing since 6 days (last pass: v6.1.22-704-ga3dcd1f09de2, first f=
ail: v6.1.22-1160-g24230ce6f2e2)

    2023-05-13T15:25:34.455085  + set +x

    2023-05-13T15:25:34.461372  <8>[   17.531223] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10306506_1.5.2.3.1>

    2023-05-13T15:25:34.570194  / # #

    2023-05-13T15:25:34.672329  export SHELL=3D/bin/sh

    2023-05-13T15:25:34.672813  #

    2023-05-13T15:25:34.773864  / # export SHELL=3D/bin/sh. /lava-10306506/=
environment

    2023-05-13T15:25:34.774511  =


    2023-05-13T15:25:34.875876  / # . /lava-10306506/environment/lava-10306=
506/bin/lava-test-runner /lava-10306506/1

    2023-05-13T15:25:34.876117  =


    2023-05-13T15:25:34.881431  / # /lava-10306506/bin/lava-test-runner /la=
va-10306506/1
 =

    ... (13 line(s) more)  =

 =20
