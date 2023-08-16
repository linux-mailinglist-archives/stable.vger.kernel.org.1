Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E1D77EDFF
	for <lists+stable@lfdr.de>; Thu, 17 Aug 2023 01:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242109AbjHPX5s (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 16 Aug 2023 19:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347254AbjHPX5n (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 16 Aug 2023 19:57:43 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AE72723
        for <stable@vger.kernel.org>; Wed, 16 Aug 2023 16:57:40 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1bfca0ec8b9so5191705fac.2
        for <stable@vger.kernel.org>; Wed, 16 Aug 2023 16:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692230259; x=1692835059;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=evtiaS4i53zR4R35+tuvFJtlgxkgzD6/4jWmF+GJkdY=;
        b=QJjo7HaZjtpVY6tfFIJd3CFPyw+RsSMGcBB5jsCoTdCH55sxocsa4mm8sVtusQmk3c
         jVjJJ0pzWrnICjYXdnsdNQP1jrrVSqTGuepE++eWOmvn65XXJkFQz9bffLNBsY1YYJd9
         MF80P5bd0tGnCQMwBOiYU/tSGevbDsjAByMROz71oJ/oTA0tchTeONYWJrHBR7Knze4F
         rakNOYkmL82ALyCZR7MxjXhpubgYkXTw8X3dB8FEw1HqRHkXA12CXggl7xGBfiEm53WV
         AtnGZ179e2QkauV0PaqUXxEBrKAg3CIUgYjdE+myDE7QLAAl4gTe2yPBSOy3XgJmIgCO
         aOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692230259; x=1692835059;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=evtiaS4i53zR4R35+tuvFJtlgxkgzD6/4jWmF+GJkdY=;
        b=KWc/A2Py9ZUFg016uaccp3KtKMHyB+CIEzfaKENwDzvhK+vlYnrHqffRmncvQX+0DP
         UqK32I4hs6zFY4NvdY5nmSRLyOs6COPNWLB9ndDBoN32MDEBJk7fUZtyxOKOW2Ql9LY2
         vm0x6hpaRl5bVeTZjsOM4YXEs4X/Je2qFem0v87UoK1U5tq8YG/ShYFW9seDarJ6/jSE
         lSNWG0ansMOjRIr7KedmLucDce+0IwwVJx9wjiLS1aI+WBNMdkGRzfCmZFtHPLqBvxkg
         jTYe4T0khSYrEg32lVZYnH12voRx8D+US/9L6/SZuME1UWhaooFCPN/fK5mwYGgPQVoU
         qHEg==
X-Gm-Message-State: AOJu0Yx3ID1unHWKMT4+dsi3lNmOQAKg2CptbKN2umouAngr/pX6ZGC4
        XfLHUbfYScZCH0YZqevDmdzm7v2x1RxuPXbgvn/2DA==
X-Google-Smtp-Source: AGHT+IHY0AY2HSk1EMR+AFQV0MLzlkqdm4kOn+oDDPLL5Rc5Nflceokxlg+gUAF3U9atJGJ/qz8xbw==
X-Received: by 2002:a05:6870:2051:b0:1c0:1caf:3324 with SMTP id l17-20020a056870205100b001c01caf3324mr4189527oad.44.1692230259404;
        Wed, 16 Aug 2023 16:57:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bb8-20020a17090b008800b00262d079720bsm285143pjb.29.2023.08.16.16.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 16:57:38 -0700 (PDT)
Message-ID: <64dd6272.170a0220.2d577.0e03@mx.google.com>
Date:   Wed, 16 Aug 2023 16:57:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.46
X-Kernelci-Tree: stable
X-Kernelci-Branch: linux-6.1.y
Subject: stable/linux-6.1.y baseline: 124 runs, 12 regressions (v6.1.46)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-6.1.y baseline: 124 runs, 12 regressions (v6.1.46)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-6.1.y/kernel/=
v6.1.46/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-6.1.y
  Describe: v6.1.46
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      6c44e13dc284f7f4db17706ca48fd016d6b3d49a =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd2edb7d34dd120935b224

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.46/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-chro=
mebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.46/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-chro=
mebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd2edb7d34dd120935b=
225
        failing since 20 days (last pass: v6.1.39, first fail: v6.1.42) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd2ebd96ea4b891935b21a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.46/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.46/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd2ebd96ea4b891935b21f
        failing since 139 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-16T20:17:54.346500  <8>[   10.170024] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11302528_1.4.2.3.1>

    2023-08-16T20:17:54.349451  + set +x

    2023-08-16T20:17:54.450581  / #

    2023-08-16T20:17:54.551389  # #export SHELL=3D/bin/sh

    2023-08-16T20:17:54.551646  =


    2023-08-16T20:17:54.652160  / # export SHELL=3D/bin/sh. /lava-11302528/=
environment

    2023-08-16T20:17:54.652331  =


    2023-08-16T20:17:54.752819  / # . /lava-11302528/environment/lava-11302=
528/bin/lava-test-runner /lava-11302528/1

    2023-08-16T20:17:54.753108  =


    2023-08-16T20:17:54.758777  / # /lava-11302528/bin/lava-test-runner /la=
va-11302528/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd2eb67b1a2ff48935b1fc

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.46/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.46/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd2eb67b1a2ff48935b201
        failing since 139 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-16T20:16:36.563797  + <8>[   11.710067] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11302547_1.4.2.3.1>

    2023-08-16T20:16:36.564272  set +x

    2023-08-16T20:16:36.672147  / # #

    2023-08-16T20:16:36.774587  export SHELL=3D/bin/sh

    2023-08-16T20:16:36.775368  #

    2023-08-16T20:16:36.877006  / # export SHELL=3D/bin/sh. /lava-11302547/=
environment

    2023-08-16T20:16:36.877878  =


    2023-08-16T20:16:36.979514  / # . /lava-11302547/environment/lava-11302=
547/bin/lava-test-runner /lava-11302547/1

    2023-08-16T20:16:36.980814  =


    2023-08-16T20:16:36.985945  / # /lava-11302547/bin/lava-test-runner /la=
va-11302547/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd2ec87d34dd120935b204

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.46/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.46/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd2ec87d34dd120935b209
        failing since 139 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-16T20:16:59.502753  <8>[   10.153873] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11302511_1.4.2.3.1>

    2023-08-16T20:16:59.506040  + set +x

    2023-08-16T20:16:59.607294  #

    2023-08-16T20:16:59.607565  =


    2023-08-16T20:16:59.708167  / # #export SHELL=3D/bin/sh

    2023-08-16T20:16:59.708348  =


    2023-08-16T20:16:59.808922  / # export SHELL=3D/bin/sh. /lava-11302511/=
environment

    2023-08-16T20:16:59.809098  =


    2023-08-16T20:16:59.909626  / # . /lava-11302511/environment/lava-11302=
511/bin/lava-test-runner /lava-11302511/1

    2023-08-16T20:16:59.909885  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd30a510a3f1acaf35b1f1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.46/arm=
/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-sama5d4_xplained.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.46/arm=
/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-sama5d4_xplained.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd30a510a3f1acaf35b=
1f2
        new failure (last pass: v6.1.39) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd302ee034e7a3eb35b1fb

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.46/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.46/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd302ee034e7a3eb35b200
        failing since 139 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-16T20:23:07.571536  + set +x

    2023-08-16T20:23:07.578069  <8>[   10.656434] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11302534_1.4.2.3.1>

    2023-08-16T20:23:07.685789  / # #

    2023-08-16T20:23:07.788154  export SHELL=3D/bin/sh

    2023-08-16T20:23:07.789060  #

    2023-08-16T20:23:07.890851  / # export SHELL=3D/bin/sh. /lava-11302534/=
environment

    2023-08-16T20:23:07.891729  =


    2023-08-16T20:23:07.993431  / # . /lava-11302534/environment/lava-11302=
534/bin/lava-test-runner /lava-11302534/1

    2023-08-16T20:23:07.994819  =


    2023-08-16T20:23:07.999278  / # /lava-11302534/bin/lava-test-runner /la=
va-11302534/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd2ebe96ea4b891935b225

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.46/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.46/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd2ebe96ea4b891935b22a
        failing since 139 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-16T20:17:47.630203  + set +x

    2023-08-16T20:17:47.636713  <8>[   10.650097] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11302546_1.4.2.3.1>

    2023-08-16T20:17:47.738717  =


    2023-08-16T20:17:47.839348  / # #export SHELL=3D/bin/sh

    2023-08-16T20:17:47.839560  =


    2023-08-16T20:17:47.940066  / # export SHELL=3D/bin/sh. /lava-11302546/=
environment

    2023-08-16T20:17:47.940276  =


    2023-08-16T20:17:48.040824  / # . /lava-11302546/environment/lava-11302=
546/bin/lava-test-runner /lava-11302546/1

    2023-08-16T20:17:48.041147  =


    2023-08-16T20:17:48.046298  / # /lava-11302546/bin/lava-test-runner /la=
va-11302546/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd2eb596ea4b891935b20f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.46/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.46/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd2eb596ea4b891935b214
        failing since 139 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-16T20:16:34.452323  + set<8>[   11.792307] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11302545_1.4.2.3.1>

    2023-08-16T20:16:34.452531   +x

    2023-08-16T20:16:34.558414  / # #

    2023-08-16T20:16:34.660366  export SHELL=3D/bin/sh

    2023-08-16T20:16:34.660565  #

    2023-08-16T20:16:34.761101  / # export SHELL=3D/bin/sh. /lava-11302545/=
environment

    2023-08-16T20:16:34.761270  =


    2023-08-16T20:16:34.861797  / # . /lava-11302545/environment/lava-11302=
545/bin/lava-test-runner /lava-11302545/1

    2023-08-16T20:16:34.862066  =


    2023-08-16T20:16:34.866599  / # /lava-11302545/bin/lava-test-runner /la=
va-11302545/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd2eabc4a1e69ced35b1ec

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.46/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.46/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd2eabc4a1e69ced35b1f1
        failing since 139 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-16T20:16:29.164242  + set<8>[   11.927804] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11302504_1.4.2.3.1>

    2023-08-16T20:16:29.164707   +x

    2023-08-16T20:16:29.272552  / # #

    2023-08-16T20:16:29.374079  export SHELL=3D/bin/sh

    2023-08-16T20:16:29.374269  #

    2023-08-16T20:16:29.474910  / # export SHELL=3D/bin/sh. /lava-11302504/=
environment

    2023-08-16T20:16:29.475667  =


    2023-08-16T20:16:29.577060  / # . /lava-11302504/environment/lava-11302=
504/bin/lava-test-runner /lava-11302504/1

    2023-08-16T20:16:29.578555  =


    2023-08-16T20:16:29.583283  / # /lava-11302504/bin/lava-test-runner /la=
va-11302504/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd31975fde58914335b3fa

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.46/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.46/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd31975fde58914335b3ff
        failing since 28 days (last pass: v6.1.38, first fail: v6.1.39)

    2023-08-16T20:30:44.867922  / # #

    2023-08-16T20:30:44.970029  export SHELL=3D/bin/sh

    2023-08-16T20:30:44.970785  #

    2023-08-16T20:30:45.072205  / # export SHELL=3D/bin/sh. /lava-11302624/=
environment

    2023-08-16T20:30:45.073000  =


    2023-08-16T20:30:45.174485  / # . /lava-11302624/environment/lava-11302=
624/bin/lava-test-runner /lava-11302624/1

    2023-08-16T20:30:45.175652  =


    2023-08-16T20:30:45.192286  / # /lava-11302624/bin/lava-test-runner /la=
va-11302624/1

    2023-08-16T20:30:45.240829  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-16T20:30:45.241370  + cd /lav<8>[   19.070748] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11302624_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd31c150552359ed35b241

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.46/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.46/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd31c150552359ed35b246
        failing since 28 days (last pass: v6.1.38, first fail: v6.1.39)

    2023-08-16T20:29:32.219460  / # #

    2023-08-16T20:29:33.296454  export SHELL=3D/bin/sh

    2023-08-16T20:29:33.297734  #

    2023-08-16T20:29:34.785441  / # export SHELL=3D/bin/sh. /lava-11302619/=
environment

    2023-08-16T20:29:34.787245  =


    2023-08-16T20:29:37.511446  / # . /lava-11302619/environment/lava-11302=
619/bin/lava-test-runner /lava-11302619/1

    2023-08-16T20:29:37.513861  =


    2023-08-16T20:29:37.527710  / # /lava-11302619/bin/lava-test-runner /la=
va-11302619/1

    2023-08-16T20:29:37.543712  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-16T20:29:37.586636  + cd /lava-113026<8>[   28.482306] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11302619_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd31ac00c5e6d2c335b285

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.46/arm=
64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.46/arm=
64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd31ac00c5e6d2c335b28a
        failing since 28 days (last pass: v6.1.38, first fail: v6.1.39)

    2023-08-16T20:30:58.867445  / # #

    2023-08-16T20:30:58.969850  export SHELL=3D/bin/sh

    2023-08-16T20:30:58.970636  #

    2023-08-16T20:30:59.072088  / # export SHELL=3D/bin/sh. /lava-11302623/=
environment

    2023-08-16T20:30:59.072859  =


    2023-08-16T20:30:59.174378  / # . /lava-11302623/environment/lava-11302=
623/bin/lava-test-runner /lava-11302623/1

    2023-08-16T20:30:59.175601  =


    2023-08-16T20:30:59.192487  / # /lava-11302623/bin/lava-test-runner /la=
va-11302623/1

    2023-08-16T20:30:59.256340  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-16T20:30:59.256872  + cd /lava-1130262<8>[   18.779238] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11302623_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
