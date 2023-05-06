Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5CA6F91C4
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 13:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjEFL5f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 07:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjEFL5e (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 07:57:34 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF767ED1
        for <stable@vger.kernel.org>; Sat,  6 May 2023 04:57:32 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1aaec9ad820so25732265ad.0
        for <stable@vger.kernel.org>; Sat, 06 May 2023 04:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683374251; x=1685966251;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/JlNsPgIZjyChN3FK0ZVSRUI4TiTeFueuzzSlz/lGeg=;
        b=tWzCIN7G5Dmu564DDQz7n4SbIo7iDFvN/NPVLK3MF84rypGKIGy6h0E0z08mByZ65M
         F3F49neHJgbdlXhytIzUh7dWf5/oneauFUMDz7Ysh8iQB+gwNlVzCdCFXV2OXwdGwRak
         HDjqjayZMS/OR4SX/Nfi9FDmQ8arx1rbw/kAjn9Jf13YJzE+okmg8RR2yRu2/uWVXHvF
         Ol+X7knX8HoU4uSKdszEwjhqzCgnvnLEhw0dUzjCRvOlBJJHcHjzJsFDznGChE+//IKY
         /v421zerglYFNbQVN/2druIMPVK4X0EDcBYtrhQ1IOafbC69gB+P0o+QuV8BszFrz7kc
         nbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683374251; x=1685966251;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/JlNsPgIZjyChN3FK0ZVSRUI4TiTeFueuzzSlz/lGeg=;
        b=dlqASKEZKdYES5cDXitHAKtVYY+5JI2JsIIWf3Aq/ZdsQ52UhHNBCeKIipPhvzgg8P
         IDWy6TrbyQaYO9jJAhqOFlGhaTLGPt0GsZ1++dY+2qA7Y1hqwDRUnhEbAHg09EWyVqgc
         SyWCdQwFv7hbCLxpXri7pjcffhSjxDzVoMlv4rqDlGBSddjU3pFJqn6Eq0a4k9Juqs9x
         f5tZiyoBSfsCifDfOs/Mvgqo0Farflaw45oHpPbW6znAl4X3bt6CTn+bA/cWT64Vou6q
         lJFV03sHmfGVE5KYV71cUk2kNmU8XJpZ/blq4CV9JwAQqhiML9ySqH7pNdYp0KT/++YO
         XOjQ==
X-Gm-Message-State: AC+VfDzznW4sWJVtRg1qZQKehtDsshFAW95wAwOrzWzsAkFQMYiNdSwl
        GhchgUF6sCudrROIrc7yf5R1kkWxqvY35shU7w9xVQ==
X-Google-Smtp-Source: ACHHUZ6ymcE7SxiMYe+rufrimY/REsM/aN7SUcRJB6XaZSHvSGpH5j59meBatngcfHwgbQP2ziifyA==
X-Received: by 2002:a17:902:7295:b0:1a2:6257:36b9 with SMTP id d21-20020a170902729500b001a2625736b9mr4133824pll.31.1683374251107;
        Sat, 06 May 2023 04:57:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i18-20020a170902eb5200b001a2b79db755sm3481570pli.140.2023.05.06.04.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 04:57:30 -0700 (PDT)
Message-ID: <645640aa.170a0220.92434.65ab@mx.google.com>
Date:   Sat, 06 May 2023 04:57:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.105-420-gb25577533173
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 147 runs,
 8 regressions (v5.15.105-420-gb25577533173)
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

stable-rc/queue/5.15 baseline: 147 runs, 8 regressions (v5.15.105-420-gb255=
77533173)

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

sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.105-420-gb25577533173/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.105-420-gb25577533173
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b25577533173117fe3e262899303a3e3cb9a6ccd =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6456092ad9d2ce33fb2e861c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-420-gb25577533173/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-420-gb25577533173/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6456092ad9d2ce33fb2e8621
        failing since 38 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-06T08:00:20.685451  + <8>[   11.625827] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10213930_1.4.2.3.1>

    2023-05-06T08:00:20.685612  set +x

    2023-05-06T08:00:20.790509  / # #

    2023-05-06T08:00:20.891396  export SHELL=3D/bin/sh

    2023-05-06T08:00:20.891694  #

    2023-05-06T08:00:20.992330  / # export SHELL=3D/bin/sh. /lava-10213930/=
environment

    2023-05-06T08:00:20.992645  =


    2023-05-06T08:00:21.093303  / # . /lava-10213930/environment/lava-10213=
930/bin/lava-test-runner /lava-10213930/1

    2023-05-06T08:00:21.093771  =


    2023-05-06T08:00:21.098178  / # /lava-10213930/bin/lava-test-runner /la=
va-10213930/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6456092458a215b5ad2e8677

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-420-gb25577533173/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-420-gb25577533173/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6456092458a215b5ad2e867c
        failing since 38 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-06T08:00:15.127278  <8>[   10.442371] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10213948_1.4.2.3.1>

    2023-05-06T08:00:15.130644  + set +x

    2023-05-06T08:00:15.231994  =


    2023-05-06T08:00:15.332556  / # #export SHELL=3D/bin/sh

    2023-05-06T08:00:15.332720  =


    2023-05-06T08:00:15.433193  / # export SHELL=3D/bin/sh. /lava-10213948/=
environment

    2023-05-06T08:00:15.433394  =


    2023-05-06T08:00:15.533883  / # . /lava-10213948/environment/lava-10213=
948/bin/lava-test-runner /lava-10213948/1

    2023-05-06T08:00:15.534129  =


    2023-05-06T08:00:15.539237  / # /lava-10213948/bin/lava-test-runner /la=
va-10213948/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6456091958a215b5ad2e8658

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-420-gb25577533173/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-420-gb25577533173/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6456091958a215b5ad2e865d
        failing since 38 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-06T08:00:14.462430  + set +x

    2023-05-06T08:00:14.468931  <8>[   10.228315] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10213982_1.4.2.3.1>

    2023-05-06T08:00:14.573770  / # #

    2023-05-06T08:00:14.674473  export SHELL=3D/bin/sh

    2023-05-06T08:00:14.674688  #

    2023-05-06T08:00:14.775198  / # export SHELL=3D/bin/sh. /lava-10213982/=
environment

    2023-05-06T08:00:14.775422  =


    2023-05-06T08:00:14.875941  / # . /lava-10213982/environment/lava-10213=
982/bin/lava-test-runner /lava-10213982/1

    2023-05-06T08:00:14.876234  =


    2023-05-06T08:00:14.881185  / # /lava-10213982/bin/lava-test-runner /la=
va-10213982/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6456091258a215b5ad2e862a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-420-gb25577533173/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-420-gb25577533173/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6456091258a215b5ad2e862f
        failing since 38 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-06T08:00:03.429718  <8>[   10.837612] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10213974_1.4.2.3.1>

    2023-05-06T08:00:03.432642  + set +x

    2023-05-06T08:00:03.537463  #

    2023-05-06T08:00:03.538546  =


    2023-05-06T08:00:03.640289  / # #export SHELL=3D/bin/sh

    2023-05-06T08:00:03.640993  =


    2023-05-06T08:00:03.742307  / # export SHELL=3D/bin/sh. /lava-10213974/=
environment

    2023-05-06T08:00:03.743016  =


    2023-05-06T08:00:03.844388  / # . /lava-10213974/environment/lava-10213=
974/bin/lava-test-runner /lava-10213974/1

    2023-05-06T08:00:03.845815  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6456092de6692bfed52e85e9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-420-gb25577533173/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-420-gb25577533173/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6456092de6692bfed52e85ee
        failing since 38 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-06T08:00:22.087475  + set<8>[   11.403352] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10214002_1.4.2.3.1>

    2023-05-06T08:00:22.087561   +x

    2023-05-06T08:00:22.191557  / # #

    2023-05-06T08:00:22.292246  export SHELL=3D/bin/sh

    2023-05-06T08:00:22.292501  #

    2023-05-06T08:00:22.393112  / # export SHELL=3D/bin/sh. /lava-10214002/=
environment

    2023-05-06T08:00:22.393323  =


    2023-05-06T08:00:22.493863  / # . /lava-10214002/environment/lava-10214=
002/bin/lava-test-runner /lava-10214002/1

    2023-05-06T08:00:22.494190  =


    2023-05-06T08:00:22.498639  / # /lava-10214002/bin/lava-test-runner /la=
va-10214002/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64560a1d5c0fc629142e86b4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-420-gb25577533173/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-i=
mx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-420-gb25577533173/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-i=
mx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64560a1d5c0fc629142e86b9
        failing since 98 days (last pass: v5.15.81-121-gcb14018a85f6, first=
 fail: v5.15.90-146-gbf7101723cc0)

    2023-05-06T08:04:20.169242  + set +x
    2023-05-06T08:04:20.169414  [    9.415901] <LAVA_SIGNAL_ENDRUN 0_dmesg =
941930_1.5.2.3.1>
    2023-05-06T08:04:20.276691  / # #
    2023-05-06T08:04:20.378148  export SHELL=3D/bin/sh
    2023-05-06T08:04:20.378476  #
    2023-05-06T08:04:20.479654  / # export SHELL=3D/bin/sh. /lava-941930/en=
vironment
    2023-05-06T08:04:20.480037  =

    2023-05-06T08:04:20.581215  / # . /lava-941930/environment/lava-941930/=
bin/lava-test-runner /lava-941930/1
    2023-05-06T08:04:20.581703  =

    2023-05-06T08:04:20.584182  / # /lava-941930/bin/lava-test-runner /lava=
-941930/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6456091d58a215b5ad2e8665

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-420-gb25577533173/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-420-gb25577533173/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6456091d58a215b5ad2e866a
        failing since 38 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-06T08:00:14.032606  <8>[   12.099893] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10213945_1.4.2.3.1>

    2023-05-06T08:00:14.136821  / # #

    2023-05-06T08:00:14.237386  export SHELL=3D/bin/sh

    2023-05-06T08:00:14.237558  #

    2023-05-06T08:00:14.338114  / # export SHELL=3D/bin/sh. /lava-10213945/=
environment

    2023-05-06T08:00:14.338278  =


    2023-05-06T08:00:14.438793  / # . /lava-10213945/environment/lava-10213=
945/bin/lava-test-runner /lava-10213945/1

    2023-05-06T08:00:14.439038  =


    2023-05-06T08:00:14.443526  / # /lava-10213945/bin/lava-test-runner /la=
va-10213945/1

    2023-05-06T08:00:14.449476  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64560c40ececaa384b2e85fa

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-420-gb25577533173/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-=
pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-420-gb25577533173/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-=
pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64560c40ececaa384b2e8627
        failing since 108 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-06T08:13:36.936949  + set +x
    2023-05-06T08:13:36.941121  <8>[   16.074015] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3555646_1.5.2.4.1>
    2023-05-06T08:13:37.061467  / # #
    2023-05-06T08:13:37.167075  export SHELL=3D/bin/sh
    2023-05-06T08:13:37.168587  #
    2023-05-06T08:13:37.272326  / # export SHELL=3D/bin/sh. /lava-3555646/e=
nvironment
    2023-05-06T08:13:37.275444  =

    2023-05-06T08:13:37.381905  / # . /lava-3555646/environment/lava-355564=
6/bin/lava-test-runner /lava-3555646/1
    2023-05-06T08:13:37.387555  =

    2023-05-06T08:13:37.390075  / # /lava-3555646/bin/lava-test-runner /lav=
a-3555646/1 =

    ... (12 line(s) more)  =

 =20
