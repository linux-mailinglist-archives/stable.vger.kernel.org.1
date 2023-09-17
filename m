Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD797A35B1
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 15:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbjIQNbF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 09:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbjIQNbB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 09:31:01 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDB9130
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 06:30:54 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso26878175ad.1
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 06:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694957454; x=1695562254; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g7r4S08W5jaOe8gYmcHOVEmr26oM1kv9r+KQ84U+NCY=;
        b=ljHM31uynLIYorqOrex0TfDhJnhVLg+F6TdxfE/5vJcpBc46CkXvCUHOKlDA8Xz4Of
         HK65ONKkhlLCH4FooCz9yQG62/PamvxR6bcsy/bfwsHOYOgr/pRuKsmB8w2ryAFZGI57
         0ajXRV0og/k3FdbrkNqA5IzJ21hI+5Y/1WMd7HEPTCUfN7T3BGD67jsTQfnX4F3kp/Sz
         fZ5glf8R7iOw5ea9JBPMQd3IYzAGyhYzluA2jk/xL70SOf+IJlSu/eJEXisjg3YuzFJm
         NqHJRyo/jd3W+NPR6wcnBptU6qbG+C952/c10chxbTLHjCQ/2ywMXdN06fC0G/DWfzj7
         RYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694957454; x=1695562254;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7r4S08W5jaOe8gYmcHOVEmr26oM1kv9r+KQ84U+NCY=;
        b=j6c8oe2r6vefzk46jSQDvGva3HKutaXQ0jFBMn/vAP/et2MKFUkyeLWcle5gwgUgtL
         7aSxQbWCx23pW2z1y1Qs+V87eEhFR8SvBG+RI+pt4XK0Ni5hO048U9X8+9e2qjJfcLLy
         yPpL2DWZJEuwYe6wfrvxKS4+IXxLX08kK2Uz0Hj4mpjCZoeItrwvCc1xxef3gPEjylXG
         LsBM2Oq82PPwl+YZ0CxsmQOLqWexg+SM4MtnD2nVym8LsMuzhC48XqEG31wXJSJzXIkL
         yqzKDiMNF25ci9Mx7exHq6n4Zyd+JzSsWbkXlkZZT50v3hOoZsoLfK/AFzS8DPaStyGs
         rLEg==
X-Gm-Message-State: AOJu0Yxz6wLszphrFFZrmV/7yTEuzykiD9PECqhclm6WN9LAk1MKqJIH
        PFZkOheGPzhwD5hMVVut9/RYv0GwoEGFxWwpOgMLsQ==
X-Google-Smtp-Source: AGHT+IFVjICaXGQXG9N9iTmJ7ZgsmFF8sdfFAfp+/Owi2jTi02z1kluPSpfRgNxV8/lN/txDJSemcQ==
X-Received: by 2002:a17:902:ec89:b0:1c4:16f:cc3e with SMTP id x9-20020a170902ec8900b001c4016fcc3emr5902459plg.35.1694957453637;
        Sun, 17 Sep 2023 06:30:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902854900b001bd41b70b65sm6617831plo.49.2023.09.17.06.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 06:30:53 -0700 (PDT)
Message-ID: <6506ff8d.170a0220.a1de9.79de@mx.google.com>
Date:   Sun, 17 Sep 2023 06:30:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.194-406-g8281c551d5a7
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.10.y baseline: 115 runs,
 10 regressions (v5.10.194-406-g8281c551d5a7)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y baseline: 115 runs, 10 regressions (v5.10.194-406-g8=
281c551d5a7)

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

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.194-406-g8281c551d5a7/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.194-406-g8281c551d5a7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      8281c551d5a75f700029af48ca75d1a340fd47c0 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6506c83d0fbaeaf68e8a0a85

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-406-g8281c551d5a7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-406-g8281c551d5a7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6506c83d0fbaeaf68e8a0a8e
        failing since 172 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-09-17T09:34:37.967858  + set +x

    2023-09-17T09:34:37.974164  <8>[   10.789822] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11552575_1.4.2.3.1>

    2023-09-17T09:34:38.078572  / # #

    2023-09-17T09:34:38.179196  export SHELL=3D/bin/sh

    2023-09-17T09:34:38.179383  #

    2023-09-17T09:34:38.279909  / # export SHELL=3D/bin/sh. /lava-11552575/=
environment

    2023-09-17T09:34:38.280075  =


    2023-09-17T09:34:38.380599  / # . /lava-11552575/environment/lava-11552=
575/bin/lava-test-runner /lava-11552575/1

    2023-09-17T09:34:38.380835  =


    2023-09-17T09:34:38.385363  / # /lava-11552575/bin/lava-test-runner /la=
va-11552575/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6506c84111f3056f8d8a0a75

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-406-g8281c551d5a7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-406-g8281c551d5a7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6506c84111f3056f8d8a0a7e
        failing since 172 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-09-17T09:36:01.876831  + set +x

    2023-09-17T09:36:01.883660  <8>[   10.300964] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11552602_1.4.2.3.1>

    2023-09-17T09:36:01.985721  =


    2023-09-17T09:36:02.086316  / # #export SHELL=3D/bin/sh

    2023-09-17T09:36:02.086503  =


    2023-09-17T09:36:02.187028  / # export SHELL=3D/bin/sh. /lava-11552602/=
environment

    2023-09-17T09:36:02.187202  =


    2023-09-17T09:36:02.287772  / # . /lava-11552602/environment/lava-11552=
602/bin/lava-test-runner /lava-11552602/1

    2023-09-17T09:36:02.288092  =


    2023-09-17T09:36:02.293243  / # /lava-11552602/bin/lava-test-runner /la=
va-11552602/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6506ca3fef6723848f8a0a4e

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-406-g8281c551d5a7/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-406-g8281c551d5a7/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6506ca40ef6723848f8a0a8e
        new failure (last pass: v5.10.194-314-geea281d7b56d)

    2023-09-17T09:43:11.140328  / # #
    2023-09-17T09:43:11.243123  export SHELL=3D/bin/sh
    2023-09-17T09:43:11.243891  #
    2023-09-17T09:43:11.345772  / # export SHELL=3D/bin/sh. /lava-112641/en=
vironment
    2023-09-17T09:43:11.346602  =

    2023-09-17T09:43:11.448527  / # . /lava-112641/environment/lava-112641/=
bin/lava-test-runner /lava-112641/1
    2023-09-17T09:43:11.449767  =

    2023-09-17T09:43:11.464544  / # /lava-112641/bin/lava-test-runner /lava=
-112641/1
    2023-09-17T09:43:11.522342  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-17T09:43:11.522835  + cd /lava-112641/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6506ca2c5fb22dd9498a0a98

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-406-g8281c551d5a7/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hihop=
e-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-406-g8281c551d5a7/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hihop=
e-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6506ca2c5fb22dd9498a0a9f
        failing since 47 days (last pass: v5.10.186-10-g5f99a36aeb1c, first=
 fail: v5.10.188-107-gc262f74329e1)

    2023-09-17T09:42:48.169451  + set +x
    2023-09-17T09:42:48.172620  <8>[   84.020252] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1009470_1.5.2.4.1>
    2023-09-17T09:42:48.280393  / # #
    2023-09-17T09:42:49.744991  export SHELL=3D/bin/sh
    2023-09-17T09:42:49.765933  #
    2023-09-17T09:42:49.766393  / # export SHELL=3D/bin/sh
    2023-09-17T09:42:51.724551  / # . /lava-1009470/environment
    2023-09-17T09:42:55.326589  /lava-1009470/bin/lava-test-runner /lava-10=
09470/1
    2023-09-17T09:42:55.348051  . /lava-1009470/environment
    2023-09-17T09:42:55.348467  / # /lava-1009470/bin/lava-test-runner /lav=
a-1009470/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6506cb08e7a498b4fb8a0a83

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-406-g8281c551d5a7/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-406-g8281c551d5a7/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6506cb08e7a498b4fb8a0a8a
        failing since 61 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-17T09:46:29.009436  + set +x
    2023-09-17T09:46:29.012655  <8>[   83.954477] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1009478_1.5.2.4.1>
    2023-09-17T09:46:29.120870  / # #
    2023-09-17T09:46:30.585339  export SHELL=3D/bin/sh
    2023-09-17T09:46:30.606286  #
    2023-09-17T09:46:30.606759  / # export SHELL=3D/bin/sh
    2023-09-17T09:46:32.564820  / # . /lava-1009478/environment
    2023-09-17T09:46:36.167298  /lava-1009478/bin/lava-test-runner /lava-10=
09478/1
    2023-09-17T09:46:36.188791  . /lava-1009478/environment
    2023-09-17T09:46:36.189209  / # /lava-1009478/bin/lava-test-runner /lav=
a-1009478/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6506ca57a3a01d23518a0a7f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-406-g8281c551d5a7/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-406-g8281c551d5a7/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6506ca57a3a01d23518a0a86
        failing since 61 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-17T09:43:21.740161  / # #
    2023-09-17T09:43:23.199646  export SHELL=3D/bin/sh
    2023-09-17T09:43:23.220100  #
    2023-09-17T09:43:23.220258  / # export SHELL=3D/bin/sh
    2023-09-17T09:43:25.173392  / # . /lava-1009471/environment
    2023-09-17T09:43:28.766517  /lava-1009471/bin/lava-test-runner /lava-10=
09471/1
    2023-09-17T09:43:28.787126  . /lava-1009471/environment
    2023-09-17T09:43:28.787240  / # /lava-1009471/bin/lava-test-runner /lav=
a-1009471/1
    2023-09-17T09:43:28.864580  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-17T09:43:28.864707  + cd /lava-1009471/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6506cb6e3d6938b1e68a0a43

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-406-g8281c551d5a7/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-406-g8281c551d5a7/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6506cb6e3d6938b1e68a0a4a
        failing since 61 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-17T09:48:01.856995  / # #
    2023-09-17T09:48:03.320314  export SHELL=3D/bin/sh
    2023-09-17T09:48:03.340896  #
    2023-09-17T09:48:03.341102  / # export SHELL=3D/bin/sh
    2023-09-17T09:48:05.297215  / # . /lava-1009479/environment
    2023-09-17T09:48:08.897865  /lava-1009479/bin/lava-test-runner /lava-10=
09479/1
    2023-09-17T09:48:08.918857  . /lava-1009479/environment
    2023-09-17T09:48:08.918990  / # /lava-1009479/bin/lava-test-runner /lav=
a-1009479/1
    2023-09-17T09:48:08.997220  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-17T09:48:08.997437  + cd /lava-1009479/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6506f1a647728f8adf8a0a42

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-406-g8281c551d5a7/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-406-g8281c551d5a7/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6506f1a647728f8adf8a0a4b
        failing since 61 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-17T12:35:31.146824  / # #

    2023-09-17T12:35:31.248926  export SHELL=3D/bin/sh

    2023-09-17T12:35:31.249628  #

    2023-09-17T12:35:31.351184  / # export SHELL=3D/bin/sh. /lava-11552646/=
environment

    2023-09-17T12:35:31.351946  =


    2023-09-17T12:35:31.453424  / # . /lava-11552646/environment/lava-11552=
646/bin/lava-test-runner /lava-11552646/1

    2023-09-17T12:35:31.454651  =


    2023-09-17T12:35:31.470780  / # /lava-11552646/bin/lava-test-runner /la=
va-11552646/1

    2023-09-17T12:35:31.520500  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-17T12:35:31.521017  + cd /lav<8>[   16.479009] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11552646_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6506c9d0301981ea4b8a0a51

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-406-g8281c551d5a7/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-r=
ock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-406-g8281c551d5a7/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-r=
ock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6506c9d0301981ea4b8a0a5a
        failing since 23 days (last pass: v5.10.191, first fail: v5.10.190-=
136-gda59b7b5c515e)

    2023-09-17T09:43:14.418327  / # #

    2023-09-17T09:43:15.678409  export SHELL=3D/bin/sh

    2023-09-17T09:43:15.689385  #

    2023-09-17T09:43:15.689861  / # export SHELL=3D/bin/sh

    2023-09-17T09:43:17.433033  / # . /lava-11552643/environment

    2023-09-17T09:43:20.638226  /lava-11552643/bin/lava-test-runner /lava-1=
1552643/1

    2023-09-17T09:43:20.649533  . /lava-11552643/environment

    2023-09-17T09:43:20.653763  / # /lava-11552643/bin/lava-test-runner /la=
va-11552643/1

    2023-09-17T09:43:20.705656  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-17T09:43:20.706142  + cd /lava-11552643/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6506c9b4aff84bbab58a0a42

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-406-g8281c551d5a7/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-406-g8281c551d5a7/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6506c9b4aff84bbab58a0a4b
        failing since 61 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-17T09:45:19.300762  / # #

    2023-09-17T09:45:19.401282  export SHELL=3D/bin/sh

    2023-09-17T09:45:19.401457  #

    2023-09-17T09:45:19.501893  / # export SHELL=3D/bin/sh. /lava-11552642/=
environment

    2023-09-17T09:45:19.502022  =


    2023-09-17T09:45:19.602523  / # . /lava-11552642/environment/lava-11552=
642/bin/lava-test-runner /lava-11552642/1

    2023-09-17T09:45:19.602768  =


    2023-09-17T09:45:19.614157  / # /lava-11552642/bin/lava-test-runner /la=
va-11552642/1

    2023-09-17T09:45:19.674086  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-17T09:45:19.674165  + cd /lava-1155264<8>[   18.223078] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11552642_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
