Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA86072010C
	for <lists+stable@lfdr.de>; Fri,  2 Jun 2023 14:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbjFBMAL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 2 Jun 2023 08:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbjFBL7x (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Jun 2023 07:59:53 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90975E40
        for <stable@vger.kernel.org>; Fri,  2 Jun 2023 04:59:32 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-75ca95cd9b1so207457185a.0
        for <stable@vger.kernel.org>; Fri, 02 Jun 2023 04:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685707171; x=1688299171;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cj5N0Fo6NQafPOSdxxRvuhUqoVZn+ySPo8YOak838IM=;
        b=OBQGHVVPjKAWc1l6SAbMIGP7ZjpXXwHyhn3twHot/U3ynh6u0JO7scdtTnFbXnwJ5y
         NYwX0cXRYkdyE6oPBa0PKLc7gmcukElJDihV3CKbKvAashkWJBTOB/GjKAdYKBxn2l0S
         5SoIZCfLAD5AX/idrwMm9fNJS9sJKRNSYakE0NGX8t7NCSzNN4LU7WzU7blTQElrc9hM
         PsWeQPQMj6RT4nq4uozZjvAGwEhm7zJYEfxOMH/choSc+1mJy5bbrH+Xwm5JDbNYi2cf
         PbW/Pu+u2LCDx0FyRzMCx9kSeVxp+S+eMBMRWDhXpdBGpSa4TXO+0sSezB9zflL0JGY0
         QBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685707171; x=1688299171;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cj5N0Fo6NQafPOSdxxRvuhUqoVZn+ySPo8YOak838IM=;
        b=OqpGRdSrr8Kwn0L40zS5Q0sg3PJUuvDokWYfmvkoimJMPnTT+lK8u3PBIFAg4VtCY3
         ABR/zPW+HDGxnkOnrwQk/lSAndUlzEBWu2AW0g7TwlXgRfq+Fxdim3it2wTTeWV+E/VP
         bWL2TOPHE8wtm0afhSZErK69gIGYpRapxHt/GmshktRGMZuffClXrVTrnlj7FmYk9Zct
         NupCNLUs798SyjaZGk+K9jEp98vIYaPcYUTss1Z7xxtItozZbeZ6y1DUQ/EtKtY2S0Ye
         rd+QYgVKneVhWYsBAl220JPx1dMLzhRsR5ra+KI09Ppj8lMUG8yaAYxVboyi4nCJr95Z
         le8g==
X-Gm-Message-State: AC+VfDxjLA0eX/VpYuFa7Rud45DZ+QO2ACUWLWbvaM2hES5I/WF9SAn4
        4B0UAkYZNZN7AGbllREU9ENCo3RIzQ00ZSqMrL3TsA==
X-Google-Smtp-Source: ACHHUZ7+1UmmaRarLiYCvZqH+VYLQCFno/zQcmOwB0OpeheVXbITMBSU3v2gDukl+M4qYeltObKFaA==
X-Received: by 2002:a05:620a:4406:b0:75b:23a1:3665 with SMTP id v6-20020a05620a440600b0075b23a13665mr16059545qkp.38.1685707170812;
        Fri, 02 Jun 2023 04:59:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d6-20020aa78146000000b00634b91326a9sm899576pfn.143.2023.06.02.04.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 04:59:30 -0700 (PDT)
Message-ID: <6479d9a2.a70a0220.f0fde.1317@mx.google.com>
Date:   Fri, 02 Jun 2023 04:59:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.31-40-g7d0a9678d276
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-6.1.y baseline: 174 runs,
 9 regressions (v6.1.31-40-g7d0a9678d276)
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

stable-rc/linux-6.1.y baseline: 174 runs, 9 regressions (v6.1.31-40-g7d0a96=
78d276)

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

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.31-40-g7d0a9678d276/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.31-40-g7d0a9678d276
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      7d0a9678d27663bef481e0ed18226dab66fd884b =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6479a79537b1fa2dfcf5de57

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
40-g7d0a9678d276/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
40-g7d0a9678d276/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6479a79537b1fa2dfcf5de60
        failing since 63 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-02T08:25:36.892563  <8>[   10.554874] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10560762_1.4.2.3.1>

    2023-06-02T08:25:36.895626  + set +x

    2023-06-02T08:25:37.000181  /#

    2023-06-02T08:25:37.102703   # #export SHELL=3D/bin/sh

    2023-06-02T08:25:37.103428  =


    2023-06-02T08:25:37.204994  / # export SHELL=3D/bin/sh. /lava-10560762/=
environment

    2023-06-02T08:25:37.205792  =


    2023-06-02T08:25:37.307391  / # . /lava-10560762/environment/lava-10560=
762/bin/lava-test-runner /lava-10560762/1

    2023-06-02T08:25:37.308523  =


    2023-06-02T08:25:37.314604  / # /lava-10560762/bin/lava-test-runner /la=
va-10560762/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6479a7258370e7585df5dead

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
40-g7d0a9678d276/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
40-g7d0a9678d276/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6479a7258370e7585df5deb6
        failing since 63 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-02T08:23:45.350731  + <8>[   11.582074] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10560690_1.4.2.3.1>

    2023-06-02T08:23:45.351287  set +x

    2023-06-02T08:23:45.459102  / # #

    2023-06-02T08:23:45.561288  export SHELL=3D/bin/sh

    2023-06-02T08:23:45.561933  #

    2023-06-02T08:23:45.663146  / # export SHELL=3D/bin/sh. /lava-10560690/=
environment

    2023-06-02T08:23:45.663779  =


    2023-06-02T08:23:45.765141  / # . /lava-10560690/environment/lava-10560=
690/bin/lava-test-runner /lava-10560690/1

    2023-06-02T08:23:45.766183  =


    2023-06-02T08:23:45.770984  / # /lava-10560690/bin/lava-test-runner /la=
va-10560690/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6479a71ca79db81490f5de38

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
40-g7d0a9678d276/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
40-g7d0a9678d276/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6479a71ca79db81490f5de41
        failing since 63 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-02T08:23:33.715155  + <8>[   10.822245] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10560760_1.4.2.3.1>

    2023-06-02T08:23:33.715251  set +x

    2023-06-02T08:23:33.816461  #

    2023-06-02T08:23:33.816744  =


    2023-06-02T08:23:33.917349  / # #export SHELL=3D/bin/sh

    2023-06-02T08:23:33.917594  =


    2023-06-02T08:23:34.018172  / # export SHELL=3D/bin/sh. /lava-10560760/=
environment

    2023-06-02T08:23:34.018392  =


    2023-06-02T08:23:34.118936  / # . /lava-10560760/environment/lava-10560=
760/bin/lava-test-runner /lava-10560760/1

    2023-06-02T08:23:34.119258  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6479a709118f436975f5de43

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
40-g7d0a9678d276/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
40-g7d0a9678d276/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6479a709118f436975f5de4c
        failing since 63 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-02T08:23:29.625886  + set +x

    2023-06-02T08:23:29.632611  <8>[   10.722653] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10560711_1.4.2.3.1>

    2023-06-02T08:23:29.736543  / # #

    2023-06-02T08:23:29.837135  export SHELL=3D/bin/sh

    2023-06-02T08:23:29.837329  #

    2023-06-02T08:23:29.937844  / # export SHELL=3D/bin/sh. /lava-10560711/=
environment

    2023-06-02T08:23:29.938035  =


    2023-06-02T08:23:30.038541  / # . /lava-10560711/environment/lava-10560=
711/bin/lava-test-runner /lava-10560711/1

    2023-06-02T08:23:30.038839  =


    2023-06-02T08:23:30.043545  / # /lava-10560711/bin/lava-test-runner /la=
va-10560711/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6479a70acdcf7d9468f5de46

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
40-g7d0a9678d276/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
40-g7d0a9678d276/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6479a70acdcf7d9468f5de4f
        failing since 63 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-02T08:23:24.434828  + set +x

    2023-06-02T08:23:24.441428  <8>[   10.168745] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10560732_1.4.2.3.1>

    2023-06-02T08:23:24.543339  =


    2023-06-02T08:23:24.643888  / # #export SHELL=3D/bin/sh

    2023-06-02T08:23:24.644068  =


    2023-06-02T08:23:24.744647  / # export SHELL=3D/bin/sh. /lava-10560732/=
environment

    2023-06-02T08:23:24.744867  =


    2023-06-02T08:23:24.845420  / # . /lava-10560732/environment/lava-10560=
732/bin/lava-test-runner /lava-10560732/1

    2023-06-02T08:23:24.845679  =


    2023-06-02T08:23:24.850400  / # /lava-10560732/bin/lava-test-runner /la=
va-10560732/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6479a71e8370e7585df5de52

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
40-g7d0a9678d276/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
40-g7d0a9678d276/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6479a71e8370e7585df5de5b
        failing since 63 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-02T08:23:38.626432  + set<8>[   11.062452] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10560758_1.4.2.3.1>

    2023-06-02T08:23:38.626517   +x

    2023-06-02T08:23:38.730284  / # #

    2023-06-02T08:23:38.830873  export SHELL=3D/bin/sh

    2023-06-02T08:23:38.831075  #

    2023-06-02T08:23:38.931634  / # export SHELL=3D/bin/sh. /lava-10560758/=
environment

    2023-06-02T08:23:38.931856  =


    2023-06-02T08:23:39.032402  / # . /lava-10560758/environment/lava-10560=
758/bin/lava-test-runner /lava-10560758/1

    2023-06-02T08:23:39.032920  =


    2023-06-02T08:23:39.037687  / # /lava-10560758/bin/lava-test-runner /la=
va-10560758/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6479a706cdcf7d9468f5de36

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
40-g7d0a9678d276/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
40-g7d0a9678d276/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6479a706cdcf7d9468f5de3f
        failing since 63 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-02T08:23:24.136391  <8>[    9.302042] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10560739_1.4.2.3.1>

    2023-06-02T08:23:24.241097  / # #

    2023-06-02T08:23:24.341777  export SHELL=3D/bin/sh

    2023-06-02T08:23:24.341963  #

    2023-06-02T08:23:24.442457  / # export SHELL=3D/bin/sh. /lava-10560739/=
environment

    2023-06-02T08:23:24.442673  =


    2023-06-02T08:23:24.543233  / # . /lava-10560739/environment/lava-10560=
739/bin/lava-test-runner /lava-10560739/1

    2023-06-02T08:23:24.543573  =


    2023-06-02T08:23:24.547873  / # /lava-10560739/bin/lava-test-runner /la=
va-10560739/1

    2023-06-02T08:23:24.554481  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6479a8bec3e7c2c48df5de41

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
40-g7d0a9678d276/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
40-g7d0a9678d276/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/6479a8bec3e7c2c48df5de61
        failing since 21 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-06-02T08:30:29.745937  /lava-10560823/1/../bin/lava-test-case

    2023-06-02T08:30:29.752398  <8>[   23.043938] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6479a8bec3e7c2c48df5deed
        failing since 21 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-06-02T08:30:24.259007  <8>[   17.552052] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10560823_1.5.2.3.1>

    2023-06-02T08:30:24.262381  + set +x

    2023-06-02T08:30:24.366938  / # #

    2023-06-02T08:30:24.467522  export SHELL=3D/bin/sh

    2023-06-02T08:30:24.467688  #

    2023-06-02T08:30:24.568197  / # export SHELL=3D/bin/sh. /lava-10560823/=
environment

    2023-06-02T08:30:24.568359  =


    2023-06-02T08:30:24.668826  / # . /lava-10560823/environment/lava-10560=
823/bin/lava-test-runner /lava-10560823/1

    2023-06-02T08:30:24.669075  =


    2023-06-02T08:30:24.673777  / # /lava-10560823/bin/lava-test-runner /la=
va-10560823/1
 =

    ... (13 line(s) more)  =

 =20
