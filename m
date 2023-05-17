Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E2A7072E5
	for <lists+stable@lfdr.de>; Wed, 17 May 2023 22:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjEQUUo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 17 May 2023 16:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEQUUn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 17 May 2023 16:20:43 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4816E2D55
        for <stable@vger.kernel.org>; Wed, 17 May 2023 13:20:40 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-643990c5319so900662b3a.2
        for <stable@vger.kernel.org>; Wed, 17 May 2023 13:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684354839; x=1686946839;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rsskv0nuZUVGJTxlmxatbKMQ+6CP9TijQhxmeWtdPm4=;
        b=F9izoguyj+JRbNW5tvfUchKRVCd0Vv+G8B5Ss3bP1l9QZFosaFdf3K+CkbU3k0pv1W
         fOKFPIKvWtspkETvznFq+sgnRij5Q4AKIRPCHpmZYsk3skTJArsMBEuKJOZrq+fPUakY
         64jArqOPRNlDH6nl578vnU+BxBkxgFN52r3BO6hqeXg8r4DxzB5OZqG1rc7nnBUPytrr
         GrTYw/WKhz7ag+424W9pR3niXOd9jJoH3t3tug7WrKJEyd415ERjjZ3aJR9VTZCxvETr
         bpGUUWzGyP46FHodfVt9HkX2nRaCAHYFPHzeW7+zQzwPveSJ1COIYPBsXJnXSI43vJlB
         lnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684354839; x=1686946839;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rsskv0nuZUVGJTxlmxatbKMQ+6CP9TijQhxmeWtdPm4=;
        b=BAhUWTuM2aSJ1FoWquRUzQ9Nc5E2T7v2PotaltNfzxPIfzJZFNaxoFHHeZ7iNGbLth
         yU9Ig3To8bTei2Ibk++n+j//3OOir8r5XzeMoGcNc4V8gZT7Uych5yzrAfgJljgRsdbS
         QvE8bf9hdQiA7Vy4EAUe2//Al/B/0FpGHsrFQT4ycomUmdoGi1lKVCts6LvAySR/NJ0/
         ZzJVjMGlvxOWzKijhd2rHWiVHv76UqlnqBSI5DbY18pGZ8UYfPT9nMxnBvYQCHTPEkCC
         q+cgT3wIUz6Mxve6SFUam2IN/z1mHmfeq3SZtja+samZKuUNnOELIWsnMtRi+ZVn7c4T
         ZjbQ==
X-Gm-Message-State: AC+VfDycc67mCj0Bipj5BhIojibZtFKRbF2hS0Q77b1tHLkupvQz4Xd7
        3aLTRoci76LcK0e6IYUef9zfr30Tsi/bbuZYIJqVHA==
X-Google-Smtp-Source: ACHHUZ4eIylpBtpi/54Y1hRteXvVxdwMUQbcM6p1HEF5SlFXO0RwBdwht7QuCsUWgrhAi/Dkl6Nopg==
X-Received: by 2002:a05:6a00:2343:b0:648:cfbb:885c with SMTP id j3-20020a056a00234300b00648cfbb885cmr1239886pfj.29.1684354838930;
        Wed, 17 May 2023 13:20:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x22-20020aa79196000000b0063b7af71b61sm10751364pfa.212.2023.05.17.13.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 13:20:38 -0700 (PDT)
Message-ID: <64653716.a70a0220.a783.5108@mx.google.com>
Date:   Wed, 17 May 2023 13:20:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.29
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-6.1.y baseline: 155 runs, 10 regressions (v6.1.29)
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

stable-rc/linux-6.1.y baseline: 155 runs, 10 regressions (v6.1.29)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

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

imx6dl-riotboard             | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.29/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.29
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      fa74641fb6b93a19ccb50579886ecc98320230f9 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6465038bcfa2de531d2e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6465038bcfa2de531d2e85eb
        failing since 48 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-17T16:40:23.080054  <8>[   10.276985] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10358350_1.4.2.3.1>

    2023-05-17T16:40:23.085747  + set +x

    2023-05-17T16:40:23.194094  / # #

    2023-05-17T16:40:23.296706  export SHELL=3D/bin/sh

    2023-05-17T16:40:23.296919  #

    2023-05-17T16:40:23.397487  / # export SHELL=3D/bin/sh. /lava-10358350/=
environment

    2023-05-17T16:40:23.398444  =


    2023-05-17T16:40:23.500365  / # . /lava-10358350/environment/lava-10358=
350/bin/lava-test-runner /lava-10358350/1

    2023-05-17T16:40:23.501932  =


    2023-05-17T16:40:23.507189  / # /lava-10358350/bin/lava-test-runner /la=
va-10358350/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646502986231ec67f62e862a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646502986231ec67f62e862f
        failing since 48 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-17T16:36:22.690156  + set<8>[   11.560964] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10358348_1.4.2.3.1>

    2023-05-17T16:36:22.690271   +x

    2023-05-17T16:36:22.794721  / # #

    2023-05-17T16:36:22.895374  export SHELL=3D/bin/sh

    2023-05-17T16:36:22.895565  #

    2023-05-17T16:36:22.996092  / # export SHELL=3D/bin/sh. /lava-10358348/=
environment

    2023-05-17T16:36:22.996289  =


    2023-05-17T16:36:23.096809  / # . /lava-10358348/environment/lava-10358=
348/bin/lava-test-runner /lava-10358348/1

    2023-05-17T16:36:23.097077  =


    2023-05-17T16:36:23.101794  / # /lava-10358348/bin/lava-test-runner /la=
va-10358348/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646502874007f837352e8637

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646502874007f837352e863c
        failing since 48 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-17T16:36:00.595983  <8>[    8.631241] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10358294_1.4.2.3.1>

    2023-05-17T16:36:00.599238  + set +x

    2023-05-17T16:36:00.704978  =


    2023-05-17T16:36:00.806786  / # #export SHELL=3D/bin/sh

    2023-05-17T16:36:00.807630  =


    2023-05-17T16:36:00.909097  / # export SHELL=3D/bin/sh. /lava-10358294/=
environment

    2023-05-17T16:36:00.909902  =


    2023-05-17T16:36:01.011462  / # . /lava-10358294/environment/lava-10358=
294/bin/lava-test-runner /lava-10358294/1

    2023-05-17T16:36:01.012668  =


    2023-05-17T16:36:01.018047  / # /lava-10358294/bin/lava-test-runner /la=
va-10358294/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646502854007f837352e8626

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646502854007f837352e862b
        failing since 48 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-17T16:36:06.279449  + set +x

    2023-05-17T16:36:06.286089  <8>[   10.891441] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10358288_1.4.2.3.1>

    2023-05-17T16:36:06.394308  / # #

    2023-05-17T16:36:06.496914  export SHELL=3D/bin/sh

    2023-05-17T16:36:06.497712  #

    2023-05-17T16:36:06.599333  / # export SHELL=3D/bin/sh. /lava-10358288/=
environment

    2023-05-17T16:36:06.600221  =


    2023-05-17T16:36:06.701718  / # . /lava-10358288/environment/lava-10358=
288/bin/lava-test-runner /lava-10358288/1

    2023-05-17T16:36:06.702940  =


    2023-05-17T16:36:06.707573  / # /lava-10358288/bin/lava-test-runner /la=
va-10358288/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6465028c6231ec67f62e8611

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6465028c6231ec67f62e8616
        failing since 48 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-17T16:36:16.790577  <8>[   12.012992] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10358320_1.4.2.3.1>

    2023-05-17T16:36:16.793979  + set +x

    2023-05-17T16:36:16.898527  / # #

    2023-05-17T16:36:16.999186  export SHELL=3D/bin/sh

    2023-05-17T16:36:16.999379  #

    2023-05-17T16:36:17.099926  / # export SHELL=3D/bin/sh. /lava-10358320/=
environment

    2023-05-17T16:36:17.100121  =


    2023-05-17T16:36:17.200657  / # . /lava-10358320/environment/lava-10358=
320/bin/lava-test-runner /lava-10358320/1

    2023-05-17T16:36:17.200948  =


    2023-05-17T16:36:17.206105  / # /lava-10358320/bin/lava-test-runner /la=
va-10358320/1
 =

    ... (19 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6465028b6231ec67f62e8606

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6465028b6231ec67f62e860b
        failing since 48 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-17T16:36:03.895579  + <8>[   10.740797] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10358282_1.4.2.3.1>

    2023-05-17T16:36:03.895677  set +x

    2023-05-17T16:36:04.000773  / # #

    2023-05-17T16:36:04.101472  export SHELL=3D/bin/sh

    2023-05-17T16:36:04.101679  #

    2023-05-17T16:36:04.202207  / # export SHELL=3D/bin/sh. /lava-10358282/=
environment

    2023-05-17T16:36:04.202413  =


    2023-05-17T16:36:04.302956  / # . /lava-10358282/environment/lava-10358=
282/bin/lava-test-runner /lava-10358282/1

    2023-05-17T16:36:04.303305  =


    2023-05-17T16:36:04.307739  / # /lava-10358282/bin/lava-test-runner /la=
va-10358282/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-riotboard             | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646506206eda72bdb52e8659

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29/=
arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6dl-riotboard.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29/=
arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6dl-riotboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646506206eda72bdb52e865e
        new failure (last pass: v6.1.28-240-gb82733c0ff99)

    2023-05-17T16:51:25.025296  + set[   14.934361] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 952932_1.5.2.3.1>
    2023-05-17T16:51:25.025474   +x
    2023-05-17T16:51:25.131633  / # #
    2023-05-17T16:51:25.233486  export SHELL=3D/bin/sh
    2023-05-17T16:51:25.234039  #
    2023-05-17T16:51:25.335340  / # export SHELL=3D/bin/sh. /lava-952932/en=
vironment
    2023-05-17T16:51:25.335870  =

    2023-05-17T16:51:25.437196  / # . /lava-952932/environment/lava-952932/=
bin/lava-test-runner /lava-952932/1
    2023-05-17T16:51:25.437911  =

    2023-05-17T16:51:25.440822  / # /lava-952932/bin/lava-test-runner /lava=
-952932/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646502844007f837352e861b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646502844007f837352e8620
        failing since 48 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-17T16:36:09.529154  <8>[   12.257595] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10358347_1.4.2.3.1>

    2023-05-17T16:36:09.633922  / # #

    2023-05-17T16:36:09.734503  export SHELL=3D/bin/sh

    2023-05-17T16:36:09.734673  #

    2023-05-17T16:36:09.835198  / # export SHELL=3D/bin/sh. /lava-10358347/=
environment

    2023-05-17T16:36:09.835387  =


    2023-05-17T16:36:09.935938  / # . /lava-10358347/environment/lava-10358=
347/bin/lava-test-runner /lava-10358347/1

    2023-05-17T16:36:09.936265  =


    2023-05-17T16:36:09.940778  / # /lava-10358347/bin/lava-test-runner /la=
va-10358347/1

    2023-05-17T16:36:09.947544  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6465049b62a89fb3ac2e8606

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui=
-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui=
-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/6465049b62a89fb3ac2e860c
        failing since 5 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-05-17T16:44:56.387235  /lava-10358481/1/../bin/lava-test-case

    2023-05-17T16:44:56.393315  <8>[   22.937221] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6465049c62a89fb3ac2e86ae
        failing since 5 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-05-17T16:44:50.973135  + set +x

    2023-05-17T16:44:50.979370  <8>[   17.521517] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10358481_1.5.2.3.1>

    2023-05-17T16:44:51.088163  / # #

    2023-05-17T16:44:51.190505  export SHELL=3D/bin/sh

    2023-05-17T16:44:51.191194  #

    2023-05-17T16:44:51.292589  / # export SHELL=3D/bin/sh. /lava-10358481/=
environment

    2023-05-17T16:44:51.293292  =


    2023-05-17T16:44:51.394704  / # . /lava-10358481/environment/lava-10358=
481/bin/lava-test-runner /lava-10358481/1

    2023-05-17T16:44:51.395903  =


    2023-05-17T16:44:51.400936  / # /lava-10358481/bin/lava-test-runner /la=
va-10358481/1
 =

    ... (13 line(s) more)  =

 =20
