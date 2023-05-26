Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2136A712DF5
	for <lists+stable@lfdr.de>; Fri, 26 May 2023 21:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjEZT5p (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 26 May 2023 15:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEZT5o (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 26 May 2023 15:57:44 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3569E
        for <stable@vger.kernel.org>; Fri, 26 May 2023 12:57:42 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-534696e4e0aso744304a12.0
        for <stable@vger.kernel.org>; Fri, 26 May 2023 12:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685131061; x=1687723061;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t2y0Z2Bnt7CLIgkcx5D+9ipoA/+zqrPoVkFI1bJUtsw=;
        b=ogCxYp34jpHrNZ3k32nlACK4bWcEAr3cduAsxC45ESH2GpArI6t+xCp4yma369zicB
         7x7IFuJlGTH2lheZWaUh2+OYY+2xGrWv/jS+gvfsJzK+/fuZxPgUjisP84A8xrXKj4RG
         tBgB2gJOpGn6+f59S52REyLn6R39NOby2RRvy5sedOnX7SOpQ/XXKACdrrCn5UtHdkAw
         LTdCBrgepG6W2frWBrk5tyr6Rr9ExNdYzsWeFP4k9yMyAH+aAoJbIJKwUAG20U38KNYf
         capTI2+5XbhGdPttKOqezG+s5NjKjt5z8iEFIBGVWp5DaWF+HIXOQ6Oz46ldQmX0MGO8
         gZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685131061; x=1687723061;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t2y0Z2Bnt7CLIgkcx5D+9ipoA/+zqrPoVkFI1bJUtsw=;
        b=Qw6NogbodfAxH6Gh5YmLLHD83MKtjG8NV/18KAwbOzPYl0MS0LZEGS0wXfn5b7Zc0X
         du+arOwE4Sa2nkomf1N6Pxr2az86h0b+v3PUDFs0aGY0D+G+x7vwrVfNFv1FK3R8JqDf
         dTqTaIuTXWfXWhgP8I53+ly+0fJsGXhWjCSe6WYrs8UThJMwnwUQjytcKAMBjDjzUbMb
         N6KAkf8El80ofLG2Y00zDqKb+5KRkHMMWrYW0HNr1UmbC5RA02SJ7I2ahY1wC1DQbpo9
         QzABiOMBV702MTpaEbPFTmbmQUAomo+6T4aCk+LmNJqCaVpWxPl9oJrAmuCyK9RJnbQz
         h05A==
X-Gm-Message-State: AC+VfDzY32nOkGPPyTOuSohzqOWkXhfAOPv+rpDAzI068t9aw9iv8g6C
        EUQ2dnO6YKQ6qTwbFmogMNcQaBUzQSYpp0zny7eLJw==
X-Google-Smtp-Source: ACHHUZ64I5W56uDjGm/2Tf2RzGVDezdmWYgs+ZEjsEjzPQ29i7aI9lZaCIt/7adgzcbiAUO7DBLZzg==
X-Received: by 2002:a17:902:7e85:b0:19d:1834:92b9 with SMTP id z5-20020a1709027e8500b0019d183492b9mr3317970pla.56.1685131060827;
        Fri, 26 May 2023 12:57:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902ea8200b001a24cded097sm3599568plb.236.2023.05.26.12.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 12:57:40 -0700 (PDT)
Message-ID: <64710f34.170a0220.60d0e.7d7d@mx.google.com>
Date:   Fri, 26 May 2023 12:57:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.112-209-gba3c979964ddc
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 131 runs,
 9 regressions (v5.15.112-209-gba3c979964ddc)
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

stable-rc/queue/5.15 baseline: 131 runs, 9 regressions (v5.15.112-209-gba3c=
979964ddc)

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

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

qemu_x86_64                  | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.112-209-gba3c979964ddc/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.112-209-gba3c979964ddc
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      ba3c979964ddce877c870353101a062987afc1c4 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6470d8641d374b94fb2e8904

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-209-gba3c979964ddc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-209-gba3c979964ddc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6470d8641d374b94fb2e8909
        failing since 59 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-26T16:03:31.343401  + set<8>[   11.496180] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10468289_1.4.2.3.1>

    2023-05-26T16:03:31.343994   +x

    2023-05-26T16:03:31.452118  / # #

    2023-05-26T16:03:31.554634  export SHELL=3D/bin/sh

    2023-05-26T16:03:31.555476  #

    2023-05-26T16:03:31.657145  / # export SHELL=3D/bin/sh. /lava-10468289/=
environment

    2023-05-26T16:03:31.657961  =


    2023-05-26T16:03:31.759555  / # . /lava-10468289/environment/lava-10468=
289/bin/lava-test-runner /lava-10468289/1

    2023-05-26T16:03:31.760865  =


    2023-05-26T16:03:31.765728  / # /lava-10468289/bin/lava-test-runner /la=
va-10468289/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6470d87e9a1a79c5552e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-209-gba3c979964ddc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-209-gba3c979964ddc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6470d87e9a1a79c5552e85eb
        failing since 59 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-26T16:03:53.059472  <8>[   11.378388] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10468311_1.4.2.3.1>

    2023-05-26T16:03:53.062807  + set +x

    2023-05-26T16:03:53.165117  =


    2023-05-26T16:03:53.265899  / # #export SHELL=3D/bin/sh

    2023-05-26T16:03:53.266105  =


    2023-05-26T16:03:53.366613  / # export SHELL=3D/bin/sh. /lava-10468311/=
environment

    2023-05-26T16:03:53.366809  =


    2023-05-26T16:03:53.467328  / # . /lava-10468311/environment/lava-10468=
311/bin/lava-test-runner /lava-10468311/1

    2023-05-26T16:03:53.467643  =


    2023-05-26T16:03:53.472439  / # /lava-10468311/bin/lava-test-runner /la=
va-10468311/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6470d93b285e7aa3212e8631

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-209-gba3c979964ddc/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-209-gba3c979964ddc/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6470d93b285e7aa3212e8=
632
        failing since 112 days (last pass: v5.15.91-12-g3290f78df1ab, first=
 fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6470d92f2a50bf62be2e85fd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-209-gba3c979964ddc/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-209-gba3c979964ddc/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6470d92f2a50bf62be2e8602
        failing since 129 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-26T16:06:45.437972  <8>[   10.045164] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3620250_1.5.2.4.1>
    2023-05-26T16:06:45.549176  / # #
    2023-05-26T16:06:45.652560  export SHELL=3D/bin/sh
    2023-05-26T16:06:45.653480  #
    2023-05-26T16:06:45.755488  / # export SHELL=3D/bin/sh. /lava-3620250/e=
nvironment
    2023-05-26T16:06:45.756648  =

    2023-05-26T16:06:45.859032  / # . /lava-3620250/environment/lava-362025=
0/bin/lava-test-runner /lava-3620250/1
    2023-05-26T16:06:45.860893  =

    2023-05-26T16:06:45.865490  / # /lava-3620250/bin/lava-test-runner /lav=
a-3620250/1
    2023-05-26T16:06:45.958504  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6470d8b764f9ef38182e8615

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-209-gba3c979964ddc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-209-gba3c979964ddc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6470d8b764f9ef38182e861a
        failing since 59 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-26T16:04:42.276900  + set +x

    2023-05-26T16:04:42.283837  <8>[   10.646387] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10468281_1.4.2.3.1>

    2023-05-26T16:04:42.387972  / # #

    2023-05-26T16:04:42.488718  export SHELL=3D/bin/sh

    2023-05-26T16:04:42.488963  #

    2023-05-26T16:04:42.589576  / # export SHELL=3D/bin/sh. /lava-10468281/=
environment

    2023-05-26T16:04:42.589830  =


    2023-05-26T16:04:42.690399  / # . /lava-10468281/environment/lava-10468=
281/bin/lava-test-runner /lava-10468281/1

    2023-05-26T16:04:42.690818  =


    2023-05-26T16:04:42.695894  / # /lava-10468281/bin/lava-test-runner /la=
va-10468281/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6470d8695e1d00d6072e85fe

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-209-gba3c979964ddc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-209-gba3c979964ddc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6470d8695e1d00d6072e8603
        failing since 59 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-26T16:03:30.399819  + set<8>[   10.965289] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10468328_1.4.2.3.1>

    2023-05-26T16:03:30.399925   +x

    2023-05-26T16:03:30.502111  /#

    2023-05-26T16:03:30.602940   # #export SHELL=3D/bin/sh

    2023-05-26T16:03:30.603132  =


    2023-05-26T16:03:30.703644  / # export SHELL=3D/bin/sh. /lava-10468328/=
environment

    2023-05-26T16:03:30.703868  =


    2023-05-26T16:03:30.804446  / # . /lava-10468328/environment/lava-10468=
328/bin/lava-test-runner /lava-10468328/1

    2023-05-26T16:03:30.804801  =


    2023-05-26T16:03:30.809375  / # /lava-10468328/bin/lava-test-runner /la=
va-10468328/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6470d8661d374b94fb2e8912

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-209-gba3c979964ddc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-209-gba3c979964ddc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6470d8661d374b94fb2e8917
        failing since 59 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-26T16:03:26.199863  + <8>[   11.035232] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10468262_1.4.2.3.1>

    2023-05-26T16:03:26.199942  set +x

    2023-05-26T16:03:26.304377  / # #

    2023-05-26T16:03:26.405097  export SHELL=3D/bin/sh

    2023-05-26T16:03:26.405312  #

    2023-05-26T16:03:26.505835  / # export SHELL=3D/bin/sh. /lava-10468262/=
environment

    2023-05-26T16:03:26.506028  =


    2023-05-26T16:03:26.606579  / # . /lava-10468262/environment/lava-10468=
262/bin/lava-test-runner /lava-10468262/1

    2023-05-26T16:03:26.606894  =


    2023-05-26T16:03:26.611260  / # /lava-10468262/bin/lava-test-runner /la=
va-10468262/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6470d85b8c35a401bc2e8616

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-209-gba3c979964ddc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-209-gba3c979964ddc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6470d85b8c35a401bc2e861b
        failing since 59 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-26T16:03:24.948393  + set<8>[   11.826200] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10468270_1.4.2.3.1>

    2023-05-26T16:03:24.948487   +x

    2023-05-26T16:03:25.052823  / # #

    2023-05-26T16:03:25.153475  export SHELL=3D/bin/sh

    2023-05-26T16:03:25.153677  #

    2023-05-26T16:03:25.254174  / # export SHELL=3D/bin/sh. /lava-10468270/=
environment

    2023-05-26T16:03:25.254408  =


    2023-05-26T16:03:25.354947  / # . /lava-10468270/environment/lava-10468=
270/bin/lava-test-runner /lava-10468270/1

    2023-05-26T16:03:25.355248  =


    2023-05-26T16:03:25.359723  / # /lava-10468270/bin/lava-test-runner /la=
va-10468270/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64                  | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/6470d7abb295ba51d22e8629

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-209-gba3c979964ddc/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_x86_64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-209-gba3c979964ddc/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6470d7abb295ba51d22e8=
62a
        new failure (last pass: v5.15.112-208-g607aa828ce14c) =

 =20
