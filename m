Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E726F9C97
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 00:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjEGWzx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 18:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjEGWzw (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 18:55:52 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C55131
        for <stable@vger.kernel.org>; Sun,  7 May 2023 15:55:49 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1aaea3909d1so36124775ad.2
        for <stable@vger.kernel.org>; Sun, 07 May 2023 15:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683500148; x=1686092148;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n7Vey186o9DA9AWkKDj7MqpgfviKOxP/pmBe1IFNNOU=;
        b=viE5q96eIu2o6gP4xX/JPcLKDnkNdKzRVZrndlJPfsypAFpGYliss6f7Cin7C9jZc0
         jtXVr/cbigMzvEQN6LTm4E+tYJlirLagH4d2RYUv+ciyPw0Sqxutv0BgoAquIUOPofbE
         6SsFGqYPvJ2YHH9Vjg8iT6u4uGEkFAq2hk0TDbxVA9ENWi/MwN+2ydEa/5igO71e35xB
         Kh0ENl+WiQh1/c3aLmc+w2SteoW2ADK9wt7J6JxOOH73U3OsesYtxfvddeRwxtlTROea
         Ppyy1OZyf+KVJ9lPK5PD6jwbqDXEQK/3KvA0bhTHppxeRgHNNlSa3OJCoXaV1T7Zt2rn
         gk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683500148; x=1686092148;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n7Vey186o9DA9AWkKDj7MqpgfviKOxP/pmBe1IFNNOU=;
        b=IAbBNwq804qSsXVC4Ai4L1WISjmhA/i5PDlLkROck57mw2xvgITZfYlaXcooinDUxw
         3JFBJIdIGzJ7w2kGUPVWxGEUTiRLvnTKEP3J69JIyBqSAx58KmySGbT2D2t851O3iF05
         9Xln0tV3i8S8ULTpvyW9HGkxUf6ogQh5OWBYruNTAo8tWM9qUxujDMRZRCoCrYpxnevJ
         /OWGzdSgAPn6L/g/M+QyH4ss8b4qHYbikd72DQ1AYtd7L06KB6ALViUvtlV1Kza7VoVg
         JAfDMf4w/uy+eoeRHYX8KJxgSr6vRauXKKkMZkmG868UjMfhxeSunhp7ldaMwTagDgV9
         RRoA==
X-Gm-Message-State: AC+VfDzEOsIErUNs2+yxXqJR0ZlF9x/WqbTxgiTlbX5ZX1fE7LejyXjG
        yc+jl0UxoqbK97Ml92iQIdR/e6onQUX8pGqEMBsWQA==
X-Google-Smtp-Source: ACHHUZ5uejr9sfuWVYWVGqOMOGMAaqjYgdoB1q4VChZiqFLlZu+E/gUTeXQfpTcdR7Buvylc+2ADqQ==
X-Received: by 2002:a17:902:c950:b0:1ac:71ae:ce2f with SMTP id i16-20020a170902c95000b001ac71aece2fmr3169150pla.20.1683500148415;
        Sun, 07 May 2023 15:55:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e21-20020a170902d39500b001a980a23802sm5628383pld.111.2023.05.07.15.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 15:55:47 -0700 (PDT)
Message-ID: <64582c73.170a0220.5ddbc.9a79@mx.google.com>
Date:   Sun, 07 May 2023 15:55:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.105-738-g89e0c91492bf3
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.15.y baseline: 160 runs,
 13 regressions (v5.15.105-738-g89e0c91492bf3)
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

stable-rc/linux-5.15.y baseline: 160 runs, 13 regressions (v5.15.105-738-g8=
9e0c91492bf3)

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

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 4          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.105-738-g89e0c91492bf3/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.105-738-g89e0c91492bf3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      89e0c91492bf351b057268a9dd77674ec44e2522 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457f71a7266739a8b2e85f5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-738-g89e0c91492bf3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-738-g89e0c91492bf3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457f71a7266739a8b2e85fa
        failing since 39 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-07T19:07:50.987604  + set +x

    2023-05-07T19:07:50.993931  <8>[   10.829540] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10231544_1.4.2.3.1>

    2023-05-07T19:07:51.098392  / # #

    2023-05-07T19:07:51.199105  export SHELL=3D/bin/sh

    2023-05-07T19:07:51.199320  #

    2023-05-07T19:07:51.299878  / # export SHELL=3D/bin/sh. /lava-10231544/=
environment

    2023-05-07T19:07:51.300104  =


    2023-05-07T19:07:51.400698  / # . /lava-10231544/environment/lava-10231=
544/bin/lava-test-runner /lava-10231544/1

    2023-05-07T19:07:51.400976  =


    2023-05-07T19:07:51.406738  / # /lava-10231544/bin/lava-test-runner /la=
va-10231544/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457f6af90913590272e8613

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-738-g89e0c91492bf3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-738-g89e0c91492bf3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457f6af90913590272e8618
        failing since 39 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-07T19:06:02.928256  + set<8>[   11.602774] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10231487_1.4.2.3.1>

    2023-05-07T19:06:02.928360   +x

    2023-05-07T19:06:03.032537  / # #

    2023-05-07T19:06:03.133031  export SHELL=3D/bin/sh

    2023-05-07T19:06:03.133201  #

    2023-05-07T19:06:03.233717  / # export SHELL=3D/bin/sh. /lava-10231487/=
environment

    2023-05-07T19:06:03.233885  =


    2023-05-07T19:06:03.334397  / # . /lava-10231487/environment/lava-10231=
487/bin/lava-test-runner /lava-10231487/1

    2023-05-07T19:06:03.334641  =


    2023-05-07T19:06:03.338876  / # /lava-10231487/bin/lava-test-runner /la=
va-10231487/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457f6b08e56d28ae82e85f6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-738-g89e0c91492bf3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-738-g89e0c91492bf3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457f6b08e56d28ae82e85fb
        failing since 39 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-07T19:06:03.214121  <8>[   11.824960] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10231547_1.4.2.3.1>

    2023-05-07T19:06:03.217689  + set +x

    2023-05-07T19:06:03.319726  #

    2023-05-07T19:06:03.320154  =


    2023-05-07T19:06:03.420952  / # #export SHELL=3D/bin/sh

    2023-05-07T19:06:03.421163  =


    2023-05-07T19:06:03.521662  / # export SHELL=3D/bin/sh. /lava-10231547/=
environment

    2023-05-07T19:06:03.521963  =


    2023-05-07T19:06:03.622647  / # . /lava-10231547/environment/lava-10231=
547/bin/lava-test-runner /lava-10231547/1

    2023-05-07T19:06:03.623008  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457f699269e30d5732e85fa

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-738-g89e0c91492bf3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-738-g89e0c91492bf3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457f699269e30d5732e85ff
        failing since 39 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-07T19:05:52.429080  + set +x

    2023-05-07T19:05:52.435597  <8>[   11.395607] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10231474_1.4.2.3.1>

    2023-05-07T19:05:52.540117  / # #

    2023-05-07T19:05:52.641031  export SHELL=3D/bin/sh

    2023-05-07T19:05:52.641256  #

    2023-05-07T19:05:52.741803  / # export SHELL=3D/bin/sh. /lava-10231474/=
environment

    2023-05-07T19:05:52.742035  =


    2023-05-07T19:05:52.842534  / # . /lava-10231474/environment/lava-10231=
474/bin/lava-test-runner /lava-10231474/1

    2023-05-07T19:05:52.842893  =


    2023-05-07T19:05:52.847288  / # /lava-10231474/bin/lava-test-runner /la=
va-10231474/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457f695d19bcf9d442e85f7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-738-g89e0c91492bf3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-738-g89e0c91492bf3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457f695d19bcf9d442e85fc
        failing since 39 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-07T19:05:41.097743  <8>[   10.832537] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10231517_1.4.2.3.1>

    2023-05-07T19:05:41.100860  + set +x

    2023-05-07T19:05:41.202198  =


    2023-05-07T19:05:41.302723  / # #export SHELL=3D/bin/sh

    2023-05-07T19:05:41.302927  =


    2023-05-07T19:05:41.403385  / # export SHELL=3D/bin/sh. /lava-10231517/=
environment

    2023-05-07T19:05:41.403611  =


    2023-05-07T19:05:41.504183  / # . /lava-10231517/environment/lava-10231=
517/bin/lava-test-runner /lava-10231517/1

    2023-05-07T19:05:41.504584  =


    2023-05-07T19:05:41.509549  / # /lava-10231517/bin/lava-test-runner /la=
va-10231517/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457f6a12d521a5cd92e8615

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-738-g89e0c91492bf3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-738-g89e0c91492bf3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457f6a12d521a5cd92e861a
        failing since 39 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-07T19:05:48.277062  + <8>[   11.388517] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10231548_1.4.2.3.1>

    2023-05-07T19:05:48.277148  set +x

    2023-05-07T19:05:48.381520  / # #

    2023-05-07T19:05:48.482175  export SHELL=3D/bin/sh

    2023-05-07T19:05:48.482369  #

    2023-05-07T19:05:48.582907  / # export SHELL=3D/bin/sh. /lava-10231548/=
environment

    2023-05-07T19:05:48.583076  =


    2023-05-07T19:05:48.683613  / # . /lava-10231548/environment/lava-10231=
548/bin/lava-test-runner /lava-10231548/1

    2023-05-07T19:05:48.683902  =


    2023-05-07T19:05:48.688401  / # /lava-10231548/bin/lava-test-runner /la=
va-10231548/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6457fb6a06338c1dd02e85e8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-738-g89e0c91492bf3/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baselin=
e-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-738-g89e0c91492bf3/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baselin=
e-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457fb6a06338c1dd02e85ed
        failing since 97 days (last pass: v5.15.81-122-gc5f8d4a5d3c8, first=
 fail: v5.15.90-205-g5605d15db022)

    2023-05-07T19:26:27.524768  + set +x
    2023-05-07T19:26:27.525132  [    9.419452] <LAVA_SIGNAL_ENDRUN 0_dmesg =
943076_1.5.2.3.1>
    2023-05-07T19:26:27.631810  / # #
    2023-05-07T19:26:27.733563  export SHELL=3D/bin/sh
    2023-05-07T19:26:27.733961  #
    2023-05-07T19:26:27.835151  / # export SHELL=3D/bin/sh. /lava-943076/en=
vironment
    2023-05-07T19:26:27.835579  =

    2023-05-07T19:26:27.936805  / # . /lava-943076/environment/lava-943076/=
bin/lava-test-runner /lava-943076/1
    2023-05-07T19:26:27.937385  =

    2023-05-07T19:26:27.940013  / # /lava-943076/bin/lava-test-runner /lava=
-943076/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457f69a2d521a5cd92e85e8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-738-g89e0c91492bf3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-738-g89e0c91492bf3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457f69a2d521a5cd92e85ed
        failing since 39 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-07T19:05:50.889492  + set<8>[   10.881814] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10231525_1.4.2.3.1>

    2023-05-07T19:05:50.889596   +x

    2023-05-07T19:05:50.993616  / # #

    2023-05-07T19:05:51.094215  export SHELL=3D/bin/sh

    2023-05-07T19:05:51.094424  #

    2023-05-07T19:05:51.194925  / # export SHELL=3D/bin/sh. /lava-10231525/=
environment

    2023-05-07T19:05:51.195128  =


    2023-05-07T19:05:51.295658  / # . /lava-10231525/environment/lava-10231=
525/bin/lava-test-runner /lava-10231525/1

    2023-05-07T19:05:51.295996  =


    2023-05-07T19:05:51.301126  / # /lava-10231525/bin/lava-test-runner /la=
va-10231525/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 4          =


  Details:     https://kernelci.org/test/plan/id/6457f56f3597ef8b3c2e85f4

  Results:     153 PASS, 14 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-738-g89e0c91492bf3/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-738-g89e0c91492bf3/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/6457f56f3597ef8b3c2e860e
        new failure (last pass: v5.15.105-361-g64fb7ad7e758)

    2023-05-07T19:00:45.533478  /lava-10231428/1/../bin/lava-test-case

    2023-05-07T19:00:45.539930  <8>[   61.603853] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/6457f56f3597ef8b3c2e860e
        new failure (last pass: v5.15.105-361-g64fb7ad7e758)

    2023-05-07T19:00:45.533478  /lava-10231428/1/../bin/lava-test-case

    2023-05-07T19:00:45.539930  <8>[   61.603853] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/6457f56f3597ef8b3c2e8610
        new failure (last pass: v5.15.105-361-g64fb7ad7e758)

    2023-05-07T19:00:44.494020  /lava-10231428/1/../bin/lava-test-case

    2023-05-07T19:00:44.500371  <8>[   60.564597] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457f56f3597ef8b3c2e8698
        new failure (last pass: v5.15.105-361-g64fb7ad7e758)

    2023-05-07T19:00:30.336093  + <8>[   46.403690] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10231428_1.5.2.3.1>

    2023-05-07T19:00:30.339192  set +x

    2023-05-07T19:00:30.443522  / # #

    2023-05-07T19:00:30.544127  export SHELL=3D/bin/sh

    2023-05-07T19:00:30.544317  #

    2023-05-07T19:00:30.644858  / # export SHELL=3D/bin/sh. /lava-10231428/=
environment

    2023-05-07T19:00:30.645048  =


    2023-05-07T19:00:30.745607  / # . /lava-10231428/environment/lava-10231=
428/bin/lava-test-runner /lava-10231428/1

    2023-05-07T19:00:30.745881  =


    2023-05-07T19:00:30.750561  / # /lava-10231428/bin/lava-test-runner /la=
va-10231428/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6457faa2cc07393ddb2e85e9

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-738-g89e0c91492bf3/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a=
64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-738-g89e0c91492bf3/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a=
64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457faa2cc07393ddb2e8616
        failing since 110 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-05-07T19:22:50.986796  + set +x
    2023-05-07T19:22:50.990913  <8>[   16.085105] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3561826_1.5.2.4.1>
    2023-05-07T19:22:51.111380  / # #
    2023-05-07T19:22:51.216962  export SHELL=3D/bin/sh
    2023-05-07T19:22:51.218482  #
    2023-05-07T19:22:51.321964  / # export SHELL=3D/bin/sh. /lava-3561826/e=
nvironment
    2023-05-07T19:22:51.323560  =

    2023-05-07T19:22:51.427019  / # . /lava-3561826/environment/lava-356182=
6/bin/lava-test-runner /lava-3561826/1
    2023-05-07T19:22:51.429707  =

    2023-05-07T19:22:51.432977  / # /lava-3561826/bin/lava-test-runner /lav=
a-3561826/1 =

    ... (12 line(s) more)  =

 =20
