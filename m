Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC017A97A3
	for <lists+stable@lfdr.de>; Thu, 21 Sep 2023 19:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjIUR0f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 21 Sep 2023 13:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjIUR0e (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 21 Sep 2023 13:26:34 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E021170F
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 10:02:00 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-59bdad64411so15093717b3.3
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 10:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695315647; x=1695920447; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6tgIRf6LLoja3CuViy2VdZdiwY6cMJQyHnBtk5IYSvo=;
        b=mwE48iC3kXDM7R8B59IE0tEYLn67D4RbhkF5OUJuw5QR2kBrKuril2122Ms7oqjS0J
         VgV1uIRLtft7SF0Ysy7YVArJE+fER+IDjxMZfwlmrMRUmiXXQN06yT+qjuLNHh5uIlcq
         793EQqF/tyO6xOywk4tLPN5+M9zcz6Gemq0LJaIFr6hfxHVw8w0M7+3fUUDj/9j8uqo1
         7YYawRnNjBUnLna7FG+5iAt6lzwCbj1kQ92u3JqChjMoYZWcmUgztwoamnXXAcwTJ2zy
         vRI15tOMfJ1nneruU0euEGuVc/t9/hOlCOegk1pFilvljR1A3D68S83Zf8hhQFSf/tz/
         8zlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315647; x=1695920447;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6tgIRf6LLoja3CuViy2VdZdiwY6cMJQyHnBtk5IYSvo=;
        b=q+Go+e5q2fXKj5X+U0wQPRbKBf1V3Sxe5o7W9KNfEfpVyWgn1RehDTKCje0RAP35B7
         ZI5Vgk0vS54+I8dUzZeX9+HCpv/JFdyemDvBj1vv+olUHPC8lhUDpnQyV+1zHZs7hIW4
         J7EDXMK/9jwCcpvTHdQn5OIrk3vD4aUGAH/az2XsaQAccbjSAs5oGIA6V6QVZ7x5v71H
         nng4pyJ+kWlubpu6WkzFlohuAyXC8zqSGHXVm5TlLdDPtuhjjwY97mz4dNsPICUnqS9s
         1bl+hVtzTowBaBJsG8794wNm4iHsSv3vuW5k1DfWfoR9W7nAqSkcRdTBH6mrraXMT2Pl
         CBjQ==
X-Gm-Message-State: AOJu0Yz7LksPd9qU1N/FgkVt+l5mMWKv8UuhJmZVESsdms/S5ZE2YNNg
        NLGftapPCVcjZ5ViC3n0oxxzE1O3bwbUSZaHR+6Zeg==
X-Google-Smtp-Source: AGHT+IHA0ivkoeixmBXfZCwa2ZrF5XXWTugq/GMqpfMOvp+2xTBhnDXpJACRorTWjTPdg/JIJSvPwA==
X-Received: by 2002:a17:902:ced1:b0:1bc:7001:6e5e with SMTP id d17-20020a170902ced100b001bc70016e5emr5785720plg.32.1695299412604;
        Thu, 21 Sep 2023 05:30:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a2-20020a170902ee8200b001b66a71a4a0sm1355745pld.32.2023.09.21.05.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 05:30:11 -0700 (PDT)
Message-ID: <650c3753.170a0220.726d0.33c4@mx.google.com>
Date:   Thu, 21 Sep 2023 05:30:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable
X-Kernelci-Kernel: v5.10.196
X-Kernelci-Report-Type: test
Subject: stable/linux-5.10.y baseline: 119 runs, 10 regressions (v5.10.196)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-5.10.y baseline: 119 runs, 10 regressions (v5.10.196)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.10.y/kernel=
/v5.10.196/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.10.y
  Describe: v5.10.196
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      ff0bfa8f23eb4c5a65ee6b0d0b7dc2e3439f1063 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650c08a8d6c3ae4af78a0a43

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.196/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.196/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c08a8d6c3ae4af78a0a4c
        failing since 168 days (last pass: v5.10.176, first fail: v5.10.177)

    2023-09-21T09:11:06.165923  + set +x

    2023-09-21T09:11:06.172340  <8>[   12.112380] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11586462_1.4.2.3.1>

    2023-09-21T09:11:06.277319  / # #

    2023-09-21T09:11:06.378002  export SHELL=3D/bin/sh

    2023-09-21T09:11:06.378230  #

    2023-09-21T09:11:06.478752  / # export SHELL=3D/bin/sh. /lava-11586462/=
environment

    2023-09-21T09:11:06.478995  =


    2023-09-21T09:11:06.579539  / # . /lava-11586462/environment/lava-11586=
462/bin/lava-test-runner /lava-11586462/1

    2023-09-21T09:11:06.579885  =


    2023-09-21T09:11:06.584395  / # /lava-11586462/bin/lava-test-runner /la=
va-11586462/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/650c06ebd49c971c0d8a0c08

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.196/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rz=
g2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.196/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rz=
g2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c06ebd49c971c0d8a0c0f
        failing since 56 days (last pass: v5.10.184, first fail: v5.10.188)

    2023-09-21T09:03:13.040556  + set +x
    2023-09-21T09:03:13.040780  <8>[   83.893831] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1011256_1.5.2.4.1>
    2023-09-21T09:03:13.146489  / # #
    2023-09-21T09:03:14.608160  export SHELL=3D/bin/sh
    2023-09-21T09:03:14.628757  #
    2023-09-21T09:03:14.628969  / # export SHELL=3D/bin/sh
    2023-09-21T09:03:16.583210  / # . /lava-1011256/environment
    2023-09-21T09:03:20.174082  /lava-1011256/bin/lava-test-runner /lava-10=
11256/1
    2023-09-21T09:03:20.194695  . /lava-1011256/environment
    2023-09-21T09:03:20.194821  / # /lava-1011256/bin/lava-test-runner /lav=
a-1011256/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/650c07c5a4edbb379c8a0a84

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.196/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774b1-hihope-rz=
g2n-ex.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.196/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774b1-hihope-rz=
g2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c07c5a4edbb379c8a0a8b
        failing since 56 days (last pass: v5.10.184, first fail: v5.10.188)

    2023-09-21T09:06:49.900342  + set +x
    2023-09-21T09:06:49.900599  <8>[   84.177386] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1011255_1.5.2.4.1>
    2023-09-21T09:06:50.006416  / # #
    2023-09-21T09:06:51.470406  export SHELL=3D/bin/sh
    2023-09-21T09:06:51.490860  #
    2023-09-21T09:06:51.490988  / # export SHELL=3D/bin/sh
    2023-09-21T09:06:53.447588  / # . /lava-1011255/environment
    2023-09-21T09:06:57.045859  /lava-1011255/bin/lava-test-runner /lava-10=
11255/1
    2023-09-21T09:06:57.066652  . /lava-1011255/environment
    2023-09-21T09:06:57.066763  / # /lava-1011255/bin/lava-test-runner /lav=
a-1011255/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650c065d639282ab558a0aae

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.196/=
arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.196/=
arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c065d639282ab558a0ab5
        failing since 56 days (last pass: v5.10.185, first fail: v5.10.188)

    2023-09-21T09:01:02.564205  / # #
    2023-09-21T09:01:04.026534  export SHELL=3D/bin/sh
    2023-09-21T09:01:04.047255  #
    2023-09-21T09:01:04.047473  / # export SHELL=3D/bin/sh
    2023-09-21T09:01:06.004235  / # . /lava-1011245/environment
    2023-09-21T09:01:09.602858  /lava-1011245/bin/lava-test-runner /lava-10=
11245/1
    2023-09-21T09:01:09.623640  . /lava-1011245/environment
    2023-09-21T09:01:09.623751  / # /lava-1011245/bin/lava-test-runner /lav=
a-1011245/1
    2023-09-21T09:01:09.701867  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-21T09:01:09.702088  + cd /lava-1011245/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/650c0762e2708c4b798a0b17

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.196/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.196/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c0762e2708c4b798a0b1e
        failing since 56 days (last pass: v5.10.184, first fail: v5.10.188)

    2023-09-21T09:05:06.267681  / # #
    2023-09-21T09:05:07.729635  export SHELL=3D/bin/sh
    2023-09-21T09:05:07.750190  #
    2023-09-21T09:05:07.750394  / # export SHELL=3D/bin/sh
    2023-09-21T09:05:09.705595  / # . /lava-1011257/environment
    2023-09-21T09:05:13.303213  /lava-1011257/bin/lava-test-runner /lava-10=
11257/1
    2023-09-21T09:05:13.323907  . /lava-1011257/environment
    2023-09-21T09:05:13.324016  / # /lava-1011257/bin/lava-test-runner /lav=
a-1011257/1
    2023-09-21T09:05:13.403975  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-21T09:05:13.404188  + cd /lava-1011257/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650c059cdce064cc0a8a0a42

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.196/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.196/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c059cdce064cc0a8a0a4b
        failing since 55 days (last pass: v5.10.185, first fail: v5.10.188)

    2023-09-21T09:02:15.090914  / # #

    2023-09-21T09:02:15.193102  export SHELL=3D/bin/sh

    2023-09-21T09:02:15.193837  #

    2023-09-21T09:02:15.295162  / # export SHELL=3D/bin/sh. /lava-11586589/=
environment

    2023-09-21T09:02:15.295998  =


    2023-09-21T09:02:15.397384  / # . /lava-11586589/environment/lava-11586=
589/bin/lava-test-runner /lava-11586589/1

    2023-09-21T09:02:15.397861  =


    2023-09-21T09:02:15.414600  / # /lava-11586589/bin/lava-test-runner /la=
va-11586589/1

    2023-09-21T09:02:15.464118  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-21T09:02:15.464624  + cd /lav<8>[   16.411779] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11586589_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/650c06d91f64fb980c8a0adb

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.196/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.196/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/650c06d91f64fb980c8a0ae5
        failing since 187 days (last pass: v5.10.174, first fail: v5.10.175)

    2023-09-21T09:03:05.538557  /lava-11586601/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/650c06d91f64fb980c8a0ae6
        failing since 187 days (last pass: v5.10.174, first fail: v5.10.175)

    2023-09-21T09:03:03.474689  <8>[   59.997563] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-09-21T09:03:04.501085  /lava-11586601/1/../bin/lava-test-case

    2023-09-21T09:03:04.511596  <8>[   61.035611] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650c05f0c549b3690a8a0ade

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.196/=
arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.196/=
arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c05f0c549b3690a8a0ae7
        failing since 25 days (last pass: v5.10.191, first fail: v5.10.192)

    2023-09-21T08:59:00.895779  / # #

    2023-09-21T08:59:02.157207  export SHELL=3D/bin/sh

    2023-09-21T08:59:02.168100  #

    2023-09-21T08:59:02.168543  / # export SHELL=3D/bin/sh

    2023-09-21T08:59:03.912257  / # . /lava-11586590/environment

    2023-09-21T08:59:07.117730  /lava-11586590/bin/lava-test-runner /lava-1=
1586590/1

    2023-09-21T08:59:07.129237  . /lava-11586590/environment

    2023-09-21T08:59:07.132678  / # /lava-11586590/bin/lava-test-runner /la=
va-11586590/1

    2023-09-21T08:59:07.184820  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-21T08:59:07.185342  + cd /lava-11586590/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650c05b1dce064cc0a8a0a5c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.196/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.196/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c05b1dce064cc0a8a0a65
        failing since 56 days (last pass: v5.10.185, first fail: v5.10.188)

    2023-09-21T09:02:31.050545  / # #

    2023-09-21T09:02:31.152677  export SHELL=3D/bin/sh

    2023-09-21T09:02:31.153368  #

    2023-09-21T09:02:31.254762  / # export SHELL=3D/bin/sh. /lava-11586586/=
environment

    2023-09-21T09:02:31.255452  =


    2023-09-21T09:02:31.356931  / # . /lava-11586586/environment/lava-11586=
586/bin/lava-test-runner /lava-11586586/1

    2023-09-21T09:02:31.358001  =


    2023-09-21T09:02:31.375006  / # /lava-11586586/bin/lava-test-runner /la=
va-11586586/1

    2023-09-21T09:02:31.432828  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-21T09:02:31.433319  + cd /lava-1158658<8>[   18.239629] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11586586_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
