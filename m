Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332E47D27FC
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 03:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjJWB1T (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 22 Oct 2023 21:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbjJWB1M (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Oct 2023 21:27:12 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D99FB
        for <stable@vger.kernel.org>; Sun, 22 Oct 2023 18:27:09 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6b89ab5ddb7so2807781b3a.0
        for <stable@vger.kernel.org>; Sun, 22 Oct 2023 18:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698024428; x=1698629228; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y/QVXhukOYr7DIrpeMUQ8J56wEpRoPgEuVRBKVQb+Wo=;
        b=uWMSw/uJkbL2DhzxvzvBF/eWfc16le6Wfe+SRO3e6C/2GJrDEiinDrerrRBFGMQ5XL
         jWGSvFEXzOFaDEi2Yg28ZWbjduiRk0Tk5qB4YdKLTb+/HojL6dsz9O/QDHENfTVg95in
         luZxQVY4KmpNMa4IdRxPlzM4WSHkk41TLsS2nbesh8clDrIxy3veq0d9yAPWYL0MVFoe
         +zgR+tCOoaLoaqwOeJJ70KtH/co/wJp7uM62s7J6IY4oj/ZLwsA1lSAVx/t6tplJYYps
         FUeC6idKk4YS21uJC3pus3xd8KXsD0Lc0xciw5k4l27gcCuEkbRscWDbFGgty1YZ3xbZ
         XSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698024428; x=1698629228;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y/QVXhukOYr7DIrpeMUQ8J56wEpRoPgEuVRBKVQb+Wo=;
        b=VLZPrrOVWSfEGYnspmNMivFThphYEOdnUF4GGKz6gV7tFG1vzrromY/Wy7wFMsM8f5
         kTqLqxGha55TmAkmL8zeVJJrBKcPjCki0mVmLv1cp5nInnwFldrueL4oK5DXX9Q2bH3s
         4hs7osFdEmn8uG/cLvxPII0kCgWOy9XnrfQv6vfC2ARF4eaAo4GWVLv7rKsqQ0Ks5m7E
         BlCrBMNB+bmnAyWNvpENfxHaUF5130ABU3FlpJrs/c38TM/ym6QW6AZSscVGxqsUfCeu
         TruMXXKYxPv8W6O8sF9+9UyIUO0hjUK+Q8oSrvf0PHSJIfpCBFMKrZ9pZiHunWCuFrnN
         GH3w==
X-Gm-Message-State: AOJu0YxjvKygsFi/Ryq09KpwsepecqoN5DT9F18OYuXA8UJgXCSwwVOh
        N1ho5i8vqCQWHK0D2FSnjfhafAxvEQiu8JX7gfa/CA==
X-Google-Smtp-Source: AGHT+IE9svuIyVJ49NuTaQ1r1/qEkZTpQqh2eZmKYMC0J7RE7On+LoeDybtJ8M5aPNYQGGdJsYJ+sA==
X-Received: by 2002:a05:6a00:230b:b0:6b4:6b34:8ce0 with SMTP id h11-20020a056a00230b00b006b46b348ce0mr10426068pfh.31.1698024428179;
        Sun, 22 Oct 2023 18:27:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y10-20020aa79e0a000000b006875df4773fsm5068705pfq.163.2023.10.22.18.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 18:27:07 -0700 (PDT)
Message-ID: <6535cbeb.a70a0220.6cb06.ef49@mx.google.com>
Date:   Sun, 22 Oct 2023 18:27:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.198-202-g380033a2840c
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.10.y baseline: 116 runs,
 7 regressions (v5.10.198-202-g380033a2840c)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y baseline: 116 runs, 7 regressions (v5.10.198-202-g38=
0033a2840c)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-clabbe    | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.198-202-g380033a2840c/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.198-202-g380033a2840c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      380033a2840c0b70c0b22ea637a3b20ea8691c8c =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65359a79572d895af0efcef3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-202-g380033a2840c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-202-g380033a2840c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65359a7a572d895af0efcefc
        failing since 208 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-10-22T21:55:46.372393  + set +x

    2023-10-22T21:55:46.378952  <8>[   10.654447] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11847552_1.4.2.3.1>

    2023-10-22T21:55:46.483099  / # #

    2023-10-22T21:55:46.583725  export SHELL=3D/bin/sh

    2023-10-22T21:55:46.583912  #

    2023-10-22T21:55:46.684453  / # export SHELL=3D/bin/sh. /lava-11847552/=
environment

    2023-10-22T21:55:46.684632  =


    2023-10-22T21:55:46.785190  / # . /lava-11847552/environment/lava-11847=
552/bin/lava-test-runner /lava-11847552/1

    2023-10-22T21:55:46.785467  =


    2023-10-22T21:55:46.790470  / # /lava-11847552/bin/lava-test-runner /la=
va-11847552/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65359a7b7a3b77e826efcf10

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-202-g380033a2840c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-202-g380033a2840c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65359a7b7a3b77e826efcf19
        failing since 208 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-10-22T21:55:51.148711  + set +x

    2023-10-22T21:55:51.155478  <8>[   13.031992] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11847641_1.4.2.3.1>

    2023-10-22T21:55:51.257472  =


    2023-10-22T21:55:51.358104  / # #export SHELL=3D/bin/sh

    2023-10-22T21:55:51.358281  =


    2023-10-22T21:55:51.458802  / # export SHELL=3D/bin/sh. /lava-11847641/=
environment

    2023-10-22T21:55:51.459027  =


    2023-10-22T21:55:51.559646  / # . /lava-11847641/environment/lava-11847=
641/bin/lava-test-runner /lava-11847641/1

    2023-10-22T21:55:51.559944  =


    2023-10-22T21:55:51.564963  / # /lava-11847641/bin/lava-test-runner /la=
va-11847641/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65359b402d39d38ab1efcf38

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-202-g380033a2840c/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-202-g380033a2840c/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65359b402d39d38ab1efcf75
        failing since 32 days (last pass: v5.10.195, first fail: v5.10.195-=
84-gf147286de8e5)

    2023-10-22T21:58:52.651326  / # #
    2023-10-22T21:58:52.754134  export SHELL=3D/bin/sh
    2023-10-22T21:58:52.754882  #
    2023-10-22T21:58:52.856772  / # export SHELL=3D/bin/sh. /lava-186065/en=
vironment
    2023-10-22T21:58:52.857530  =

    2023-10-22T21:58:52.959422  / # . /lava-186065/environment/lava-186065/=
bin/lava-test-runner /lava-186065/1
    2023-10-22T21:58:52.960664  =

    2023-10-22T21:58:52.975752  / # /lava-186065/bin/lava-test-runner /lava=
-186065/1
    2023-10-22T21:58:53.033532  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-22T21:58:53.034091  + cd /lava-186065/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65359a8e848ae05f1fefcf2b

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-202-g380033a2840c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-202-g380033a2840c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65359a8e848ae05f1fefcf34
        failing since 96 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-10-22T22:00:31.498317  / # #

    2023-10-22T22:00:31.598866  export SHELL=3D/bin/sh

    2023-10-22T22:00:31.598987  #

    2023-10-22T22:00:31.699454  / # export SHELL=3D/bin/sh. /lava-11847640/=
environment

    2023-10-22T22:00:31.699597  =


    2023-10-22T22:00:31.800034  / # . /lava-11847640/environment/lava-11847=
640/bin/lava-test-runner /lava-11847640/1

    2023-10-22T22:00:31.800235  =


    2023-10-22T22:00:31.811946  / # /lava-11847640/bin/lava-test-runner /la=
va-11847640/1

    2023-10-22T22:00:31.865470  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-22T22:00:31.865527  + cd /lav<8>[   16.410573] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11847640_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65359ac0d8830e2983efcef4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-202-g380033a2840c/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-r=
ock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-202-g380033a2840c/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-r=
ock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65359ac0d8830e2983efcefd
        failing since 59 days (last pass: v5.10.191, first fail: v5.10.190-=
136-gda59b7b5c515e)

    2023-10-22T21:56:59.039328  / # #

    2023-10-22T21:57:00.300668  export SHELL=3D/bin/sh

    2023-10-22T21:57:00.311657  #

    2023-10-22T21:57:00.312132  / # export SHELL=3D/bin/sh

    2023-10-22T21:57:02.056109  / # . /lava-11847632/environment

    2023-10-22T21:57:05.261944  /lava-11847632/bin/lava-test-runner /lava-1=
1847632/1

    2023-10-22T21:57:05.273428  . /lava-11847632/environment

    2023-10-22T21:57:05.276053  / # /lava-11847632/bin/lava-test-runner /la=
va-11847632/1

    2023-10-22T21:57:05.329019  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-22T21:57:05.329509  + cd /lava-11847632/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-clabbe    | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65359a7b0924de674cefcf78

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-202-g380033a2840c/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-202-g380033a2840c/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65359a7b0924de674cefcf81
        failing since 11 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-10-22T21:56:04.736130  <8>[   17.046553] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 439820_1.5.2.4.1>
    2023-10-22T21:56:04.841205  / # #
    2023-10-22T21:56:04.942793  export SHELL=3D/bin/sh
    2023-10-22T21:56:04.943377  #
    2023-10-22T21:56:05.044374  / # export SHELL=3D/bin/sh. /lava-439820/en=
vironment
    2023-10-22T21:56:05.044981  =

    2023-10-22T21:56:05.145996  / # . /lava-439820/environment/lava-439820/=
bin/lava-test-runner /lava-439820/1
    2023-10-22T21:56:05.146976  =

    2023-10-22T21:56:05.151495  / # /lava-439820/bin/lava-test-runner /lava=
-439820/1
    2023-10-22T21:56:05.217494  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65359aa2581cc2d59aefcf1e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-202-g380033a2840c/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-202-g380033a2840c/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65359aa2581cc2d59aefcf27
        failing since 11 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-10-22T22:00:47.987344  / # #

    2023-10-22T22:00:48.089495  export SHELL=3D/bin/sh

    2023-10-22T22:00:48.090192  #

    2023-10-22T22:00:48.191578  / # export SHELL=3D/bin/sh. /lava-11847627/=
environment

    2023-10-22T22:00:48.192305  =


    2023-10-22T22:00:48.293723  / # . /lava-11847627/environment/lava-11847=
627/bin/lava-test-runner /lava-11847627/1

    2023-10-22T22:00:48.294789  =


    2023-10-22T22:00:48.311424  / # /lava-11847627/bin/lava-test-runner /la=
va-11847627/1

    2023-10-22T22:00:48.352274  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-22T22:00:48.370401  + cd /lava-1184762<8>[   18.181820] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11847627_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
