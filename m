Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3C06FEBA2
	for <lists+stable@lfdr.de>; Thu, 11 May 2023 08:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjEKGR5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 11 May 2023 02:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjEKGRz (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 11 May 2023 02:17:55 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707F73596
        for <stable@vger.kernel.org>; Wed, 10 May 2023 23:17:53 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-52cbd7e73d2so5360706a12.3
        for <stable@vger.kernel.org>; Wed, 10 May 2023 23:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683785872; x=1686377872;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NV9Q7BACA1ncfWx1SuLHYez5lOrIKjtiEJVl18UlqGs=;
        b=hrmPt+NOdampRyVkCQkcW9mthPy0CisRWnjWYJop0aM+MA4szlzdSso8XOSAzr11KZ
         uwoMObF/VcWywmT5UiuChIojnpatCfJQhien1UnC73jtf8igCuHZXoewgDhDcvsidCw9
         M8XkH08ldI7zda86rELsx6WnOrTSfP6iHm4QMxgEoQ9lNzG8zyCTJd6m69wZ3G/8tk/e
         yfxlkp/AhxrkzAp3MSSHFwnJ/50WvNQgrxQhglePA1CucLhq7JCewv2vPDO9ayiSH9gu
         MMhtrXDlyRzVmwYBigKYdUybgpUxCN1f2O7FfR7/JvXIqcEWM3EBVhi72O0uQG6It8U/
         QnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683785872; x=1686377872;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NV9Q7BACA1ncfWx1SuLHYez5lOrIKjtiEJVl18UlqGs=;
        b=bT3lshhH9GqtQ1T0hH5PBeDw2hcBIoWIBcdsmtxRR1r9VFNTKAlNYX0qs6ejCX98QP
         awZyISboCrHxgH7tzkUOx3Ebd6El3hR2k5JkIWPTl0Bv4xO6aVSI3fxRc2PYbBEKFmdO
         mnzRZIUGpaxuBelTBRuv05CoqHyplhpXBPgp0ysqr6JDmg3hdaJB9xdX8WY7bMlV9kqj
         MNnndNnUnOzF6q49xET+aGrJ+mJ4zQ8XD4WxleF4/3NQpy/wzOBigyiBhCKKxQvJe6Cj
         r9OEimTgMquTYxGI++r2d1m4NSTpe0EZKvoWdiP00HAdcuRMJLXoAvs+Rg3lnh6zJyOb
         ucAg==
X-Gm-Message-State: AC+VfDw1y9TlXL860hYWnyC9SaJqJjE2lQcdAd7yrVljbmvj1kSCsse1
        jKJqWcheq8xOgYrSN35+Lv/8JKkJhUs1gQZhM6SqPg==
X-Google-Smtp-Source: ACHHUZ5zDmkP1x6sNVa8UdZtn1mdyLKHphm5NBcOucZUwvA39G1HmgdUrvW82JFne9gnIpguCgeLGw==
X-Received: by 2002:a17:90b:1047:b0:24e:3bb3:ea0c with SMTP id gq7-20020a17090b104700b0024e3bb3ea0cmr20303691pjb.10.1683785872265;
        Wed, 10 May 2023 23:17:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s1-20020a17090a1c0100b0024e11f31012sm15262851pjs.5.2023.05.10.23.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 23:17:51 -0700 (PDT)
Message-ID: <645c888f.170a0220.e33c2.e5ae@mx.google.com>
Date:   Wed, 10 May 2023 23:17:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.27
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-6.1.y baseline: 175 runs, 7 regressions (v6.1.27)
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

stable-rc/linux-6.1.y baseline: 175 runs, 7 regressions (v6.1.27)

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


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.27/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.27
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      ca48fc16c49388400eddd6c6614593ebf7c7726a =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645c55c427103980de2e8608

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.27/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.27/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c55c427103980de2e860d
        failing since 41 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-11T02:40:51.565372  <8>[   10.113500] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10274933_1.4.2.3.1>

    2023-05-11T02:40:51.568714  + set +x

    2023-05-11T02:40:51.673213  / # #

    2023-05-11T02:40:51.773833  export SHELL=3D/bin/sh

    2023-05-11T02:40:51.774046  #

    2023-05-11T02:40:51.874560  / # export SHELL=3D/bin/sh. /lava-10274933/=
environment

    2023-05-11T02:40:51.874772  =


    2023-05-11T02:40:51.975298  / # . /lava-10274933/environment/lava-10274=
933/bin/lava-test-runner /lava-10274933/1

    2023-05-11T02:40:51.975598  =


    2023-05-11T02:40:51.981459  / # /lava-10274933/bin/lava-test-runner /la=
va-10274933/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645c55caa725c16b3f2e85e7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.27/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.27/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c55caa725c16b3f2e85ec
        failing since 41 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-11T02:40:54.684178  + <8>[    8.957628] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10274942_1.4.2.3.1>

    2023-05-11T02:40:54.684292  set +x

    2023-05-11T02:40:54.788441  / # #

    2023-05-11T02:40:54.889154  export SHELL=3D/bin/sh

    2023-05-11T02:40:54.889362  #

    2023-05-11T02:40:54.989960  / # export SHELL=3D/bin/sh. /lava-10274942/=
environment

    2023-05-11T02:40:54.990165  =


    2023-05-11T02:40:55.090738  / # . /lava-10274942/environment/lava-10274=
942/bin/lava-test-runner /lava-10274942/1

    2023-05-11T02:40:55.091064  =


    2023-05-11T02:40:55.095766  / # /lava-10274942/bin/lava-test-runner /la=
va-10274942/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645c55c76fb8f380b42e8624

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.27/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.27/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c55c76fb8f380b42e8629
        failing since 41 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-11T02:40:48.709754  <8>[    9.913026] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10274964_1.4.2.3.1>

    2023-05-11T02:40:48.713098  + set +x

    2023-05-11T02:40:48.815033  =


    2023-05-11T02:40:48.915616  / # #export SHELL=3D/bin/sh

    2023-05-11T02:40:48.915894  =


    2023-05-11T02:40:49.016375  / # export SHELL=3D/bin/sh. /lava-10274964/=
environment

    2023-05-11T02:40:49.016603  =


    2023-05-11T02:40:49.117207  / # . /lava-10274964/environment/lava-10274=
964/bin/lava-test-runner /lava-10274964/1

    2023-05-11T02:40:49.117535  =


    2023-05-11T02:40:49.122972  / # /lava-10274964/bin/lava-test-runner /la=
va-10274964/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645c564f785c6023022e8640

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.27/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.27/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c564f785c6023022e8645
        failing since 41 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-11T02:43:15.695715  + set +x

    2023-05-11T02:43:15.702401  <8>[   11.023499] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10274963_1.4.2.3.1>

    2023-05-11T02:43:15.806736  / # #

    2023-05-11T02:43:15.907291  export SHELL=3D/bin/sh

    2023-05-11T02:43:15.907477  #

    2023-05-11T02:43:16.007933  / # export SHELL=3D/bin/sh. /lava-10274963/=
environment

    2023-05-11T02:43:16.008107  =


    2023-05-11T02:43:16.108642  / # . /lava-10274963/environment/lava-10274=
963/bin/lava-test-runner /lava-10274963/1

    2023-05-11T02:43:16.108905  =


    2023-05-11T02:43:16.114036  / # /lava-10274963/bin/lava-test-runner /la=
va-10274963/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645c55adecbc8a01d32e864a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.27/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.27/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c55adecbc8a01d32e864f
        failing since 41 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-11T02:40:29.178879  + set<8>[    9.919849] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10274998_1.4.2.3.1>

    2023-05-11T02:40:29.179036   +x

    2023-05-11T02:40:29.281889  /#

    2023-05-11T02:40:29.382948   # #export SHELL=3D/bin/sh

    2023-05-11T02:40:29.383259  =


    2023-05-11T02:40:29.483908  / # export SHELL=3D/bin/sh. /lava-10274998/=
environment

    2023-05-11T02:40:29.484231  =


    2023-05-11T02:40:29.584916  / # . /lava-10274998/environment/lava-10274=
998/bin/lava-test-runner /lava-10274998/1

    2023-05-11T02:40:29.585397  =


    2023-05-11T02:40:29.590715  / # /lava-10274998/bin/lava-test-runner /la=
va-10274998/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645c55c789bb80a44c2e85ee

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.27/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.27/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c55c789bb80a44c2e85f3
        failing since 41 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-11T02:40:50.824024  + <8>[   11.157262] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10274969_1.4.2.3.1>

    2023-05-11T02:40:50.824115  set +x

    2023-05-11T02:40:50.928736  / # #

    2023-05-11T02:40:51.029303  export SHELL=3D/bin/sh

    2023-05-11T02:40:51.029490  #

    2023-05-11T02:40:51.129974  / # export SHELL=3D/bin/sh. /lava-10274969/=
environment

    2023-05-11T02:40:51.130163  =


    2023-05-11T02:40:51.230652  / # . /lava-10274969/environment/lava-10274=
969/bin/lava-test-runner /lava-10274969/1

    2023-05-11T02:40:51.230939  =


    2023-05-11T02:40:51.235596  / # /lava-10274969/bin/lava-test-runner /la=
va-10274969/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645c55b2ecbc8a01d32e8703

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.27/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.27/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c55b2ecbc8a01d32e8708
        failing since 41 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-11T02:40:36.530407  + set<8>[    8.833605] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10274999_1.4.2.3.1>

    2023-05-11T02:40:36.530537   +x

    2023-05-11T02:40:36.635363  / # #

    2023-05-11T02:40:36.736038  export SHELL=3D/bin/sh

    2023-05-11T02:40:36.736230  #

    2023-05-11T02:40:36.836758  / # export SHELL=3D/bin/sh. /lava-10274999/=
environment

    2023-05-11T02:40:36.837009  =


    2023-05-11T02:40:36.937601  / # . /lava-10274999/environment/lava-10274=
999/bin/lava-test-runner /lava-10274999/1

    2023-05-11T02:40:36.937899  =


    2023-05-11T02:40:36.942504  / # /lava-10274999/bin/lava-test-runner /la=
va-10274999/1
 =

    ... (12 line(s) more)  =

 =20
