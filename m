Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB0C74136E
	for <lists+stable@lfdr.de>; Wed, 28 Jun 2023 16:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjF1OKj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 10:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjF1OKi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Jun 2023 10:10:38 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE9AFB
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 07:10:35 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-55767141512so2726084a12.3
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 07:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687961434; x=1690553434;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QxJ5q0cKk501OLR/tx9rlwFiH1ABajbhpdnZGTKCVH8=;
        b=gdPhf94Yn/UV/VTypCjZ/aHsnUmLlCuxLwXKSQNQjShx8lfxB2Hcy0cnrCwnoRfs5k
         C8Rud0qkqR8l+2OAOZ7Laev2+QPWST3LQHEvY6Qd4JQGRmWb+Cy9p18pVU/w6c9ZGaiJ
         Q/90xpoe4fRFyX0h2F6KppuNgG++nHzXFIQ0qr/JVASYLbFW/sD4YP0nJKAoCss1Q0h3
         Exnu8JCjda+6vpndmWuqRgoZt2yGKuJBbIECnPlWClTM5RBuGk0THDEmNpodu7mVwZnn
         DnTtP5FnBj9b3v+AqSRwjYu3neiCFZKM0SGG0lfoDH5q+/CtF4NYX6M3SK08dtXdzO1W
         ie9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687961434; x=1690553434;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QxJ5q0cKk501OLR/tx9rlwFiH1ABajbhpdnZGTKCVH8=;
        b=ADFrL/p6JXb9U1ziWKBHHcuvIB8R8j1usOsKhXPUqNSmu1RSwwqfDChdY3MBlO6oyn
         5c8B8XWNX/i+YrUBymJ8Lt9B8vkChwJ7Lg/OvvRuXVU2p4bNk1U3hZnVKoQW7y9h6/3D
         dYEt5cieMlTy9QWPKFp9l26nF1eqSYKeziMaYH0aPQURFgR8BSwGweWoS5ZpbbIq5lD8
         0HyhkRqO4dSrYb9HARG9VoPVspODWL6ex0AxAPl6Ieex6JKPWtSGxsk1xj1aiySM9hYY
         J869p8OCViVFxC+AJVLLE7LIEHGPPrhXUS12+Zh/f6NJxavcNtq7etYp4n6oVDNEBoHE
         fCPw==
X-Gm-Message-State: AC+VfDxfrpzXKokYDgkaK/zz3Bx3BZJ3JqSQB1H5dackfM1Lb1th/OJ8
        +Gj813PfTlx8JA4TFwO1IJJEXrB9nKiUIwEVqkJqFA==
X-Google-Smtp-Source: ACHHUZ76FtV65n6MEN/psyKfi8zN1PzfGIfjGKEJpeicPE64ukZDr6xkiXaMihLefKEgh7SEjxuYHw==
X-Received: by 2002:a17:90a:9316:b0:262:e909:d7fd with SMTP id p22-20020a17090a931600b00262e909d7fdmr6515735pjo.14.1687961433150;
        Wed, 28 Jun 2023 07:10:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 12-20020a17090a030c00b0026308e86d2csm4117441pje.45.2023.06.28.07.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 07:10:32 -0700 (PDT)
Message-ID: <649c3f58.170a0220.1335.957c@mx.google.com>
Date:   Wed, 28 Jun 2023 07:10:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.119
Subject: stable/linux-5.15.y baseline: 166 runs, 19 regressions (v5.15.119)
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

stable/linux-5.15.y baseline: 166 runs, 19 regressions (v5.15.119)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-R721T-grunt             | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

rk3328-rock64                | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.15.y/kernel=
/v5.15.119/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.15.y
  Describe: v5.15.119
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      4af60700a60cc45ee4fb6d579cccf1b7bca20c34 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-R721T-grunt             | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/649c059485324ce176306176

  Results:     18 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-acer-R721T-grunt.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-acer-R721T-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/649c059485324ce=
176306179
        new failure (last pass: v5.15.118)
        1 lines

    2023-06-28T10:03:53.111141  kern  :emerg : __common_interrupt: 1.55 No =
irq handler for vector<8>[   12.198742] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=
=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D1>

    2023-06-28T10:03:53.111325  =

   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c0531b15cf9aab8306154

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c0531b15cf9aab830615d
        failing since 89 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-28T10:02:26.450857  <8>[   10.488025] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10935073_1.4.2.3.1>

    2023-06-28T10:02:26.454198  + set +x

    2023-06-28T10:02:26.558629  / # #

    2023-06-28T10:02:26.659196  export SHELL=3D/bin/sh

    2023-06-28T10:02:26.659384  #

    2023-06-28T10:02:26.759924  / # export SHELL=3D/bin/sh. /lava-10935073/=
environment

    2023-06-28T10:02:26.760114  =


    2023-06-28T10:02:26.860638  / # . /lava-10935073/environment/lava-10935=
073/bin/lava-test-runner /lava-10935073/1

    2023-06-28T10:02:26.860943  =


    2023-06-28T10:02:26.867269  / # /lava-10935073/bin/lava-test-runner /la=
va-10935073/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/649c05b87107784537306158

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c05b87107784537306161
        failing since 89 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-28T10:04:14.921041  <8>[   11.327610] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10935205_1.4.2.3.1>

    2023-06-28T10:04:14.924690  + set +x

    2023-06-28T10:04:15.025903  #

    2023-06-28T10:04:15.026186  =


    2023-06-28T10:04:15.126769  / # #export SHELL=3D/bin/sh

    2023-06-28T10:04:15.126976  =


    2023-06-28T10:04:15.227514  / # export SHELL=3D/bin/sh. /lava-10935205/=
environment

    2023-06-28T10:04:15.227726  =


    2023-06-28T10:04:15.328256  / # . /lava-10935205/environment/lava-10935=
205/bin/lava-test-runner /lava-10935205/1

    2023-06-28T10:04:15.328676  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c051e04c22397d7306156

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c051e04c22397d730615f
        failing since 89 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-28T10:01:50.943736  + set<8>[   11.297930] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10935108_1.4.2.3.1>

    2023-06-28T10:01:50.944295   +x

    2023-06-28T10:01:51.051530  / # #

    2023-06-28T10:01:51.153735  export SHELL=3D/bin/sh

    2023-06-28T10:01:51.154063  #

    2023-06-28T10:01:51.255035  / # export SHELL=3D/bin/sh. /lava-10935108/=
environment

    2023-06-28T10:01:51.255754  =


    2023-06-28T10:01:51.357417  / # . /lava-10935108/environment/lava-10935=
108/bin/lava-test-runner /lava-10935108/1

    2023-06-28T10:01:51.358602  =


    2023-06-28T10:01:51.363837  / # /lava-10935108/bin/lava-test-runner /la=
va-10935108/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/649c0595490bf5732f30613a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c0595490bf5732f306143
        failing since 89 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-28T10:03:58.632654  + <8>[   12.182221] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10935203_1.4.2.3.1>

    2023-06-28T10:03:58.632857  set +x

    2023-06-28T10:03:58.738885  / # #

    2023-06-28T10:03:58.840954  export SHELL=3D/bin/sh

    2023-06-28T10:03:58.841670  #

    2023-06-28T10:03:58.943273  / # export SHELL=3D/bin/sh. /lava-10935203/=
environment

    2023-06-28T10:03:58.944162  =


    2023-06-28T10:03:59.045577  / # . /lava-10935203/environment/lava-10935=
203/bin/lava-test-runner /lava-10935203/1

    2023-06-28T10:03:59.046707  =


    2023-06-28T10:03:59.051027  / # /lava-10935203/bin/lava-test-runner /la=
va-10935203/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c051d04c22397d7306143

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c051d04c22397d730614c
        failing since 89 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-28T10:01:57.710268  <8>[   10.349775] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10935144_1.4.2.3.1>

    2023-06-28T10:01:57.714415  + set +x

    2023-06-28T10:01:57.819227  #

    2023-06-28T10:01:57.922181  / # #export SHELL=3D/bin/sh

    2023-06-28T10:01:57.922678  =


    2023-06-28T10:01:58.023809  / # export SHELL=3D/bin/sh. /lava-10935144/=
environment

    2023-06-28T10:01:58.024105  =


    2023-06-28T10:01:58.124793  / # . /lava-10935144/environment/lava-10935=
144/bin/lava-test-runner /lava-10935144/1

    2023-06-28T10:01:58.125106  =


    2023-06-28T10:01:58.129897  / # /lava-10935144/bin/lava-test-runner /la=
va-10935144/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/649c05a9afd2b3a991306147

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c05a9afd2b3a991306150
        failing since 89 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-28T10:04:08.593286  <8>[   12.919434] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10935194_1.4.2.3.1>

    2023-06-28T10:04:08.596372  + set +x

    2023-06-28T10:04:08.697773  =


    2023-06-28T10:04:08.798339  / # #export SHELL=3D/bin/sh

    2023-06-28T10:04:08.798527  =


    2023-06-28T10:04:08.899065  / # export SHELL=3D/bin/sh. /lava-10935194/=
environment

    2023-06-28T10:04:08.899252  =


    2023-06-28T10:04:08.999802  / # . /lava-10935194/environment/lava-10935=
194/bin/lava-test-runner /lava-10935194/1

    2023-06-28T10:04:09.000069  =


    2023-06-28T10:04:09.004817  / # /lava-10935194/bin/lava-test-runner /la=
va-10935194/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c051a04c22397d7306136

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c051a04c22397d730613f
        failing since 89 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-28T10:01:50.085284  + set +x

    2023-06-28T10:01:50.091820  <8>[    9.900818] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10935133_1.4.2.3.1>

    2023-06-28T10:01:50.196194  / # #

    2023-06-28T10:01:50.296852  export SHELL=3D/bin/sh

    2023-06-28T10:01:50.297074  #

    2023-06-28T10:01:50.397650  / # export SHELL=3D/bin/sh. /lava-10935133/=
environment

    2023-06-28T10:01:50.397878  =


    2023-06-28T10:01:50.498438  / # . /lava-10935133/environment/lava-10935=
133/bin/lava-test-runner /lava-10935133/1

    2023-06-28T10:01:50.498769  =


    2023-06-28T10:01:50.503098  / # /lava-10935133/bin/lava-test-runner /la=
va-10935133/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/649c07ec0028769ca230614a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c07ec0028769ca2306153
        failing since 89 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-28T10:13:56.046727  + set +x<8>[   12.294624] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10935173_1.4.2.3.1>

    2023-06-28T10:13:56.047029  =


    2023-06-28T10:13:56.152999  / # #

    2023-06-28T10:13:56.255157  export SHELL=3D/bin/sh

    2023-06-28T10:13:56.255882  #

    2023-06-28T10:13:56.357443  / # export SHELL=3D/bin/sh. /lava-10935173/=
environment

    2023-06-28T10:13:56.358208  =


    2023-06-28T10:13:56.459724  / # . /lava-10935173/environment/lava-10935=
173/bin/lava-test-runner /lava-10935173/1

    2023-06-28T10:13:56.460985  =


    2023-06-28T10:13:56.465669  / # /lava-10935173/bin/lava-test-runner /la=
va-10935173/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c051e802badab6a30612e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c051e802badab6a306137
        failing since 89 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-28T10:01:43.448710  <8>[   10.266490] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10935159_1.4.2.3.1>

    2023-06-28T10:01:43.451646  + set +x

    2023-06-28T10:01:43.555961  / # #

    2023-06-28T10:01:43.656621  export SHELL=3D/bin/sh

    2023-06-28T10:01:43.656819  #

    2023-06-28T10:01:43.757351  / # export SHELL=3D/bin/sh. /lava-10935159/=
environment

    2023-06-28T10:01:43.757550  =


    2023-06-28T10:01:43.858066  / # . /lava-10935159/environment/lava-10935=
159/bin/lava-test-runner /lava-10935159/1

    2023-06-28T10:01:43.858386  =


    2023-06-28T10:01:43.863498  / # /lava-10935159/bin/lava-test-runner /la=
va-10935159/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/649c0584052b4f02c0306145

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c0584052b4f02c030614e
        failing since 89 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-28T10:03:41.609909  + <8>[   12.182469] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10935202_1.4.2.3.1>

    2023-06-28T10:03:41.609996  set +x

    2023-06-28T10:03:41.711209  #

    2023-06-28T10:03:41.812178  / # #export SHELL=3D/bin/sh

    2023-06-28T10:03:41.812403  =


    2023-06-28T10:03:41.912965  / # export SHELL=3D/bin/sh. /lava-10935202/=
environment

    2023-06-28T10:03:41.913234  =


    2023-06-28T10:03:42.013795  / # . /lava-10935202/environment/lava-10935=
202/bin/lava-test-runner /lava-10935202/1

    2023-06-28T10:03:42.014106  =


    2023-06-28T10:03:42.019184  / # /lava-10935202/bin/lava-test-runner /la=
va-10935202/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c051d56059026e8306151

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c051d56059026e830615a
        failing since 89 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-28T10:01:49.541422  + set<8>[   11.232731] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10935082_1.4.2.3.1>

    2023-06-28T10:01:49.541962   +x

    2023-06-28T10:01:49.648968  / # #

    2023-06-28T10:01:49.751327  export SHELL=3D/bin/sh

    2023-06-28T10:01:49.752056  #

    2023-06-28T10:01:49.853712  / # export SHELL=3D/bin/sh. /lava-10935082/=
environment

    2023-06-28T10:01:49.854448  =


    2023-06-28T10:01:49.956149  / # . /lava-10935082/environment/lava-10935=
082/bin/lava-test-runner /lava-10935082/1

    2023-06-28T10:01:49.957316  =


    2023-06-28T10:01:49.962419  / # /lava-10935082/bin/lava-test-runner /la=
va-10935082/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/649c059485324ce176306169

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c059485324ce176306172
        failing since 89 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-28T10:03:56.952415  + <8>[   11.503029] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10935186_1.4.2.3.1>

    2023-06-28T10:03:56.953036  set +x

    2023-06-28T10:03:57.060992  / # #

    2023-06-28T10:03:57.163053  export SHELL=3D/bin/sh

    2023-06-28T10:03:57.163764  #

    2023-06-28T10:03:57.265165  / # export SHELL=3D/bin/sh. /lava-10935186/=
environment

    2023-06-28T10:03:57.265853  =


    2023-06-28T10:03:57.367378  / # . /lava-10935186/environment/lava-10935=
186/bin/lava-test-runner /lava-10935186/1

    2023-06-28T10:03:57.367685  =


    2023-06-28T10:03:57.372135  / # /lava-10935186/bin/lava-test-runner /la=
va-10935186/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/649c086582892fc932306140

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c086582892fc932306149
        failing since 147 days (last pass: v5.15.81, first fail: v5.15.91)

    2023-06-28T10:15:55.751480  + set +x
    2023-06-28T10:15:55.751650  [    9.447074] <LAVA_SIGNAL_ENDRUN 0_dmesg =
989599_1.5.2.3.1>
    2023-06-28T10:15:55.859626  / # #
    2023-06-28T10:15:55.961218  export SHELL=3D/bin/sh
    2023-06-28T10:15:55.961672  #
    2023-06-28T10:15:56.062952  / # export SHELL=3D/bin/sh. /lava-989599/en=
vironment
    2023-06-28T10:15:56.063414  =

    2023-06-28T10:15:56.164678  / # . /lava-989599/environment/lava-989599/=
bin/lava-test-runner /lava-989599/1
    2023-06-28T10:15:56.165210  =

    2023-06-28T10:15:56.168324  / # /lava-989599/bin/lava-test-runner /lava=
-989599/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c0521398e28d31230617b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c0521398e28d312306184
        failing since 89 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-28T10:01:49.231872  <8>[   11.816590] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10935137_1.4.2.3.1>

    2023-06-28T10:01:49.340871  / # #

    2023-06-28T10:01:49.443479  export SHELL=3D/bin/sh

    2023-06-28T10:01:49.444326  #

    2023-06-28T10:01:49.546012  / # export SHELL=3D/bin/sh. /lava-10935137/=
environment

    2023-06-28T10:01:49.546809  =


    2023-06-28T10:01:49.648537  / # . /lava-10935137/environment/lava-10935=
137/bin/lava-test-runner /lava-10935137/1

    2023-06-28T10:01:49.649857  =


    2023-06-28T10:01:49.655168  / # /lava-10935137/bin/lava-test-runner /la=
va-10935137/1

    2023-06-28T10:01:49.660042  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/649c05b3afd2b3a991306175

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c05b3afd2b3a99130617e
        failing since 89 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-28T10:04:06.233105  + <8>[   31.311670] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10935187_1.4.2.3.1>

    2023-06-28T10:04:06.233587  set +x

    2023-06-28T10:04:06.341369  / # #

    2023-06-28T10:04:06.443760  export SHELL=3D/bin/sh

    2023-06-28T10:04:06.444603  #

    2023-06-28T10:04:06.546154  / # export SHELL=3D/bin/sh. /lava-10935187/=
environment

    2023-06-28T10:04:06.546945  =


    2023-06-28T10:04:06.648550  / # . /lava-10935187/environment/lava-10935=
187/bin/lava-test-runner /lava-10935187/1

    2023-06-28T10:04:06.649756  =


    2023-06-28T10:04:06.654943  / # /lava-10935187/bin/lava-test-runner /la=
va-10935187/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3328-rock64                | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649c033e87c01cc56e306139

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c033f87c01cc56e306142
        failing since 58 days (last pass: v5.15.71, first fail: v5.15.110)

    2023-06-28T09:53:44.656878  [   16.069062] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3696993_1.5.2.4.1>
    2023-06-28T09:53:44.761794  =

    2023-06-28T09:53:44.762028  / # #[   16.129936] rockchip-drm display-su=
bsystem: [drm] Cannot find any crtc or sizes
    2023-06-28T09:53:44.863509  export SHELL=3D/bin/sh
    2023-06-28T09:53:44.864419  =

    2023-06-28T09:53:44.966388  / # export SHELL=3D/bin/sh. /lava-3696993/e=
nvironment
    2023-06-28T09:53:44.966711  =

    2023-06-28T09:53:45.067873  / # . /lava-3696993/environment/lava-369699=
3/bin/lava-test-runner /lava-3696993/1
    2023-06-28T09:53:45.068373  =

    2023-06-28T09:53:45.071914  / # /lava-3696993/bin/lava-test-runner /lav=
a-3696993/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649c03fe8f7470bcf1306131

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c03fe8f7470bcf130615f
        failing since 141 days (last pass: v5.15.82, first fail: v5.15.92)

    2023-06-28T09:56:54.120207  + set +x
    2023-06-28T09:56:54.124136  <8>[   16.157669] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3696975_1.5.2.4.1>
    2023-06-28T09:56:54.265286  / # #
    2023-06-28T09:56:54.370854  export SHELL=3D/bin/sh
    2023-06-28T09:56:54.372405  #
    2023-06-28T09:56:54.475723  / # export SHELL=3D/bin/sh. /lava-3696975/e=
nvironment
    2023-06-28T09:56:54.477308  =

    2023-06-28T09:56:54.580661  / # . /lava-3696975/environment/lava-369697=
5/bin/lava-test-runner /lava-3696975/1
    2023-06-28T09:56:54.583314  =

    2023-06-28T09:56:54.586599  / # /lava-3696975/bin/lava-test-runner /lav=
a-3696975/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649c03d655c287b091306174

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.119/=
arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c03d655c287b0913061a5
        failing since 141 days (last pass: v5.15.82, first fail: v5.15.92)

    2023-06-28T09:56:07.775663  + set +x
    2023-06-28T09:56:07.779668  <8>[   16.154313] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 671715_1.5.2.4.1>
    2023-06-28T09:56:07.892608  / # #
    2023-06-28T09:56:07.996304  export SHELL=3D/bin/sh
    2023-06-28T09:56:07.997159  #
    2023-06-28T09:56:08.099746  / # export SHELL=3D/bin/sh. /lava-671715/en=
vironment
    2023-06-28T09:56:08.100616  =

    2023-06-28T09:56:08.203231  / # . /lava-671715/environment/lava-671715/=
bin/lava-test-runner /lava-671715/1
    2023-06-28T09:56:08.204949  =

    2023-06-28T09:56:08.208952  / # /lava-671715/bin/lava-test-runner /lava=
-671715/1 =

    ... (12 line(s) more)  =

 =20
