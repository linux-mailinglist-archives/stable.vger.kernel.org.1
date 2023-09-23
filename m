Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572A47AC256
	for <lists+stable@lfdr.de>; Sat, 23 Sep 2023 15:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjIWNr4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 23 Sep 2023 09:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjIWNr4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 23 Sep 2023 09:47:56 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C43819E
        for <stable@vger.kernel.org>; Sat, 23 Sep 2023 06:47:46 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c5bbb205e3so34942795ad.0
        for <stable@vger.kernel.org>; Sat, 23 Sep 2023 06:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695476865; x=1696081665; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/DOfCoEYnh3in9/2gJ+Nt1aSMesl/uUmotng23Fa2PM=;
        b=JSzyFOG/C3y+GH28DFcebeXoPTULakVknfDbUdKtrt90fO0FZBejl7S6jfemI1ciOw
         yEFVnDf2QaqEK9AnS56O1Zkn77A7CbTlMUOMd4resB4JzhWh0si0FnR0ooJ1vRSvH3KD
         ze4XJbmZ6PF/42QM9NQgp0O7zB6McKENc9B1z6gAVJp9bEiJ0/9gl2poLDcasX8dpFAe
         4CNAHd6wuK1efkHDk65MWJILy0FO4gz3nu2uG44xSwl/VXsnMxwHYUaLbjhCv0GXnYne
         ufOUu4/mVR9RVHm+V+Ssx+XlbZe+MrD3GkT64gwlfJd1R/QtEKxH4Wmbe7y99rgW1XtE
         //6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695476865; x=1696081665;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/DOfCoEYnh3in9/2gJ+Nt1aSMesl/uUmotng23Fa2PM=;
        b=F1ar31YUckai6NRJ2lhJdc4oyox1KTBq2l+Y6h4fZ9XVC1dih2NyIX8wu/q8ye0y+e
         0wRPRNhx+EoFAqepKkbVayWZBZQLfXRlyw9neOU/o5zv4tMXpwRhyBQVEImQ+I/8r/J/
         vo9PGSw15728JiFbVfBhdcXWD9oghEYdW3wDzDMPyyaflS6zUpWN5yUHdzbSzPeRor7c
         vnXWrE40hb70JSKnQMwcJZ9Zv7Qzb8AxEcE+uPpW/dsOIP9ixgW80Wcg5Ly0Tv+kHajf
         GIlCvj1zf6owGAAxuxbSBSr0cZC3oRve1ol04SXJ3ltdIAUFVNjBIn7txlAyX2/YnqaQ
         6lTg==
X-Gm-Message-State: AOJu0Yxs5M/HDkxPEMfnwmR5+IuKMl7/d+DmGkk3nXwlEF4a7U5J3gp8
        3JA4j+4vepdm38yXHvuEmNLRZlPD8pOoPodDuI0qtQ==
X-Google-Smtp-Source: AGHT+IHsmzKNLNxGaIhhcJTr3G6/xFWqXls0IDNcPNQnJfzCJNvNpeYUoLQYE4vQ8z2S0z12UGU5Fw==
X-Received: by 2002:a17:902:a5c5:b0:1c4:50f0:c4e1 with SMTP id t5-20020a170902a5c500b001c450f0c4e1mr2247024plq.38.1695476864846;
        Sat, 23 Sep 2023 06:47:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y3-20020a170902864300b001bdc8a5e96csm5347620plt.169.2023.09.23.06.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 06:47:44 -0700 (PDT)
Message-ID: <650eec80.170a0220.795c2.a4ed@mx.google.com>
Date:   Sat, 23 Sep 2023 06:47:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable
X-Kernelci-Kernel: v5.15.133
X-Kernelci-Report-Type: test
Subject: stable/linux-5.15.y baseline: 136 runs, 27 regressions (v5.15.133)
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

stable/linux-5.15.y baseline: 136 runs, 27 regressions (v5.15.133)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

fsl-ls1028a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g+kselftest          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g+kselftest          | 1          =

kontron-sl28-var3-ads2       | arm64  | lab-kontron   | gcc-10   | defconfi=
g+kselftest          | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+kselftest          | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =

mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =

sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.15.y/kernel=
/v5.15.133/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.15.y
  Describe: v5.15.133
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      b911329317b4218e63baf78f3f422efbaa7198ed =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/650eb621e09b8c15198a0ac6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650eb621e09b8c15198a0acf
        failing since 176 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-23T09:55:27.264972  + set +x

    2023-09-23T09:55:27.271540  <8>[    9.081643] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11600895_1.4.2.3.1>

    2023-09-23T09:55:27.379986  / # #

    2023-09-23T09:55:27.482802  export SHELL=3D/bin/sh

    2023-09-23T09:55:27.483655  #

    2023-09-23T09:55:27.585319  / # export SHELL=3D/bin/sh. /lava-11600895/=
environment

    2023-09-23T09:55:27.586146  =


    2023-09-23T09:55:27.687896  / # . /lava-11600895/environment/lava-11600=
895/bin/lava-test-runner /lava-11600895/1

    2023-09-23T09:55:27.689105  =


    2023-09-23T09:55:27.695508  / # /lava-11600895/bin/lava-test-runner /la=
va-11600895/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650eb932a58d42bb8f8a0a42

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650eb932a58d42bb8f8a0a4b
        failing since 176 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-23T10:10:06.397576  <8>[   10.771005] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11601057_1.4.2.3.1>

    2023-09-23T10:10:06.400535  + set +x

    2023-09-23T10:10:06.502215  #

    2023-09-23T10:10:06.603161  / # #export SHELL=3D/bin/sh

    2023-09-23T10:10:06.603473  =


    2023-09-23T10:10:06.704093  / # export SHELL=3D/bin/sh. /lava-11601057/=
environment

    2023-09-23T10:10:06.704349  =


    2023-09-23T10:10:06.804963  / # . /lava-11601057/environment/lava-11601=
057/bin/lava-test-runner /lava-11601057/1

    2023-09-23T10:10:06.805377  =


    2023-09-23T10:10:06.811065  / # /lava-11601057/bin/lava-test-runner /la=
va-11601057/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/650eb6255b6a3087f18a0a82

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650eb6255b6a3087f18a0a8b
        failing since 176 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-23T09:55:31.495577  + <8>[   11.924764] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11600917_1.4.2.3.1>

    2023-09-23T09:55:31.496103  set +x

    2023-09-23T09:55:31.603554  / # #

    2023-09-23T09:55:31.706010  export SHELL=3D/bin/sh

    2023-09-23T09:55:31.706785  #

    2023-09-23T09:55:31.808470  / # export SHELL=3D/bin/sh. /lava-11600917/=
environment

    2023-09-23T09:55:31.809203  =


    2023-09-23T09:55:31.910917  / # . /lava-11600917/environment/lava-11600=
917/bin/lava-test-runner /lava-11600917/1

    2023-09-23T09:55:31.912039  =


    2023-09-23T09:55:31.917105  / # /lava-11600917/bin/lava-test-runner /la=
va-11600917/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650eb92ab33200784f8a0a81

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650eb92ab33200784f8a0a8a
        failing since 176 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-23T10:08:21.515949  + <8>[   11.152220] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11601083_1.4.2.3.1>

    2023-09-23T10:08:21.516032  set +x

    2023-09-23T10:08:21.620910  / # #

    2023-09-23T10:08:21.723449  export SHELL=3D/bin/sh

    2023-09-23T10:08:21.724271  #

    2023-09-23T10:08:21.825865  / # export SHELL=3D/bin/sh. /lava-11601083/=
environment

    2023-09-23T10:08:21.826658  =


    2023-09-23T10:08:21.928120  / # . /lava-11601083/environment/lava-11601=
083/bin/lava-test-runner /lava-11601083/1

    2023-09-23T10:08:21.928494  =


    2023-09-23T10:08:21.933502  / # /lava-11601083/bin/lava-test-runner /la=
va-11601083/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/650eb626a8a8e8f4908a0a61

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650eb626a8a8e8f4908a0a6a
        failing since 176 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-23T09:56:54.920073  <8>[   11.219871] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11600906_1.4.2.3.1>

    2023-09-23T09:56:54.923227  + set +x

    2023-09-23T09:56:55.024950  =


    2023-09-23T09:56:55.125524  / # #export SHELL=3D/bin/sh

    2023-09-23T09:56:55.125667  =


    2023-09-23T09:56:55.226188  / # export SHELL=3D/bin/sh. /lava-11600906/=
environment

    2023-09-23T09:56:55.226328  =


    2023-09-23T09:56:55.326847  / # . /lava-11600906/environment/lava-11600=
906/bin/lava-test-runner /lava-11600906/1

    2023-09-23T09:56:55.327099  =


    2023-09-23T09:56:55.332477  / # /lava-11600906/bin/lava-test-runner /la=
va-11600906/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650eb923b33200784f8a0a68

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650eb923b33200784f8a0a71
        failing since 176 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-23T10:08:51.200591  <8>[   10.873842] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11601072_1.4.2.3.1>

    2023-09-23T10:08:51.204322  + set +x

    2023-09-23T10:08:51.309778  #

    2023-09-23T10:08:51.311263  =


    2023-09-23T10:08:51.413059  / # #export SHELL=3D/bin/sh

    2023-09-23T10:08:51.413887  =


    2023-09-23T10:08:51.515451  / # export SHELL=3D/bin/sh. /lava-11601072/=
environment

    2023-09-23T10:08:51.516387  =


    2023-09-23T10:08:51.617941  / # . /lava-11601072/environment/lava-11601=
072/bin/lava-test-runner /lava-11601072/1

    2023-09-23T10:08:51.619229  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/650eb7430dc77a66d88a0a8a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650eb7430dc77a66d88a0a93
        failing since 58 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-09-23T10:04:37.412247  / # #

    2023-09-23T10:04:37.514478  export SHELL=3D/bin/sh

    2023-09-23T10:04:37.515218  #

    2023-09-23T10:04:37.616661  / # export SHELL=3D/bin/sh. /lava-11600953/=
environment

    2023-09-23T10:04:37.617401  =


    2023-09-23T10:04:37.718839  / # . /lava-11600953/environment/lava-11600=
953/bin/lava-test-runner /lava-11600953/1

    2023-09-23T10:04:37.720045  =


    2023-09-23T10:04:37.736517  / # /lava-11600953/bin/lava-test-runner /la=
va-11600953/1

    2023-09-23T10:04:37.844404  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-23T10:04:37.844917  + cd /lava-11600953/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/650ebb0ae2a0a6384e8a0a44

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650ebb0ae2a0a6384e8a0=
a45
        failing since 170 days (last pass: v5.15.105, first fail: v5.15.106=
) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/650ebcc03480fa57838a0a44

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
arm64/defconfig+kselftest/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
arm64/defconfig+kselftest/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650ebcc03480fa57838a0=
a45
        failing since 21 days (last pass: v5.15.128, first fail: v5.15.130) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/650eb613e09b8c15198a0a49

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650eb613e09b8c15198a0a52
        failing since 176 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-23T09:55:08.920450  + set +x

    2023-09-23T09:55:08.926720  <8>[   12.061433] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11600907_1.4.2.3.1>

    2023-09-23T09:55:09.036477  / # #

    2023-09-23T09:55:09.139013  export SHELL=3D/bin/sh

    2023-09-23T09:55:09.139859  #

    2023-09-23T09:55:09.241335  / # export SHELL=3D/bin/sh. /lava-11600907/=
environment

    2023-09-23T09:55:09.242122  =


    2023-09-23T09:55:09.343656  / # . /lava-11600907/environment/lava-11600=
907/bin/lava-test-runner /lava-11600907/1

    2023-09-23T09:55:09.344863  =


    2023-09-23T09:55:09.350187  / # /lava-11600907/bin/lava-test-runner /la=
va-11600907/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650eb900f6738bd39b8a0a4f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650eb900f6738bd39b8a0a58
        failing since 176 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-23T10:08:09.955260  + set +x

    2023-09-23T10:08:09.962233  <8>[   10.708304] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11601044_1.4.2.3.1>

    2023-09-23T10:08:10.066377  / # #

    2023-09-23T10:08:10.166966  export SHELL=3D/bin/sh

    2023-09-23T10:08:10.167172  #

    2023-09-23T10:08:10.267665  / # export SHELL=3D/bin/sh. /lava-11601044/=
environment

    2023-09-23T10:08:10.267863  =


    2023-09-23T10:08:10.368366  / # . /lava-11601044/environment/lava-11601=
044/bin/lava-test-runner /lava-11601044/1

    2023-09-23T10:08:10.368652  =


    2023-09-23T10:08:10.373067  / # /lava-11601044/bin/lava-test-runner /la=
va-11601044/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/650eb60cd0e23907c28a0a67

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650eb60cd0e23907c28a0a70
        failing since 176 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-23T09:55:02.484066  + set +x<8>[   11.385563] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11600891_1.4.2.3.1>

    2023-09-23T09:55:02.484662  =


    2023-09-23T09:55:02.591994  / # #

    2023-09-23T09:55:02.694166  export SHELL=3D/bin/sh

    2023-09-23T09:55:02.694821  #

    2023-09-23T09:55:02.796212  / # export SHELL=3D/bin/sh. /lava-11600891/=
environment

    2023-09-23T09:55:02.796964  =


    2023-09-23T09:55:02.898486  / # . /lava-11600891/environment/lava-11600=
891/bin/lava-test-runner /lava-11600891/1

    2023-09-23T09:55:02.899723  =


    2023-09-23T09:55:02.904779  / # /lava-11600891/bin/lava-test-runner /la=
va-11600891/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650eb91eb6160263538a0a46

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650eb91eb6160263538a0a4f
        failing since 176 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-23T10:09:48.472166  + set +x

    2023-09-23T10:09:48.478635  <8>[   10.582407] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11601059_1.4.2.3.1>

    2023-09-23T10:09:48.580694  =


    2023-09-23T10:09:48.681318  / # #export SHELL=3D/bin/sh

    2023-09-23T10:09:48.681511  =


    2023-09-23T10:09:48.782013  / # export SHELL=3D/bin/sh. /lava-11601059/=
environment

    2023-09-23T10:09:48.782253  =


    2023-09-23T10:09:48.882771  / # . /lava-11601059/environment/lava-11601=
059/bin/lava-test-runner /lava-11601059/1

    2023-09-23T10:09:48.883089  =


    2023-09-23T10:09:48.888325  / # /lava-11601059/bin/lava-test-runner /la=
va-11601059/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/650eb615e09b8c15198a0a81

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650eb615e09b8c15198a0a8a
        failing since 176 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-23T09:55:47.604474  + <8>[   12.248257] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11600900_1.4.2.3.1>

    2023-09-23T09:55:47.605094  set +x

    2023-09-23T09:55:47.712776  / # #

    2023-09-23T09:55:47.813781  export SHELL=3D/bin/sh

    2023-09-23T09:55:47.814541  #

    2023-09-23T09:55:47.916051  / # export SHELL=3D/bin/sh. /lava-11600900/=
environment

    2023-09-23T09:55:47.916850  =


    2023-09-23T09:55:48.018384  / # . /lava-11600900/environment/lava-11600=
900/bin/lava-test-runner /lava-11600900/1

    2023-09-23T09:55:48.019552  =


    2023-09-23T09:55:48.024294  / # /lava-11600900/bin/lava-test-runner /la=
va-11600900/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650eb916eac0ffd9828a0a85

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650eb916eac0ffd9828a0a8e
        failing since 176 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-23T10:08:03.135716  + <8>[   11.479813] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11601040_1.4.2.3.1>

    2023-09-23T10:08:03.136201  set +x

    2023-09-23T10:08:03.243532  / # #

    2023-09-23T10:08:03.345663  export SHELL=3D/bin/sh

    2023-09-23T10:08:03.346437  #

    2023-09-23T10:08:03.447835  / # export SHELL=3D/bin/sh. /lava-11601040/=
environment

    2023-09-23T10:08:03.448602  =


    2023-09-23T10:08:03.550276  / # . /lava-11601040/environment/lava-11601=
040/bin/lava-test-runner /lava-11601040/1

    2023-09-23T10:08:03.551562  =


    2023-09-23T10:08:03.556722  / # /lava-11601040/bin/lava-test-runner /la=
va-11601040/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/650ebc9c4fdfee2d708a0a5e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
arm64/defconfig+kselftest/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls=
.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
arm64/defconfig+kselftest/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650ebc9c4fdfee2d708a0=
a5f
        failing since 21 days (last pass: v5.15.128, first fail: v5.15.130) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-sl28-var3-ads2       | arm64  | lab-kontron   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/650ebc9a642d50f24f8a0a97

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
arm64/defconfig+kselftest/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads=
2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
arm64/defconfig+kselftest/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads=
2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650ebc9a642d50f24f8a0=
a98
        failing since 16 days (last pass: v5.15.128, first fail: v5.15.131) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/650eb5fdf555fc11cb8a0a6f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650eb5fdf555fc11cb8a0a78
        failing since 176 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-23T09:55:04.174962  + <8>[   12.917367] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11600910_1.4.2.3.1>

    2023-09-23T09:55:04.175447  set +x

    2023-09-23T09:55:04.283319  / # #

    2023-09-23T09:55:04.385478  export SHELL=3D/bin/sh

    2023-09-23T09:55:04.386253  #

    2023-09-23T09:55:04.487638  / # export SHELL=3D/bin/sh. /lava-11600910/=
environment

    2023-09-23T09:55:04.488329  =


    2023-09-23T09:55:04.589662  / # . /lava-11600910/environment/lava-11600=
910/bin/lava-test-runner /lava-11600910/1

    2023-09-23T09:55:04.590755  =


    2023-09-23T09:55:04.596676  / # /lava-11600910/bin/lava-test-runner /la=
va-11600910/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650eb921b33200784f8a0a4e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650eb921b33200784f8a0a57
        failing since 176 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-23T10:08:10.945571  <8>[   11.475173] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11601055_1.4.2.3.1>

    2023-09-23T10:08:11.053752  / # #

    2023-09-23T10:08:11.156031  export SHELL=3D/bin/sh

    2023-09-23T10:08:11.156769  #

    2023-09-23T10:08:11.258224  / # export SHELL=3D/bin/sh. /lava-11601055/=
environment

    2023-09-23T10:08:11.259043  =


    2023-09-23T10:08:11.360611  / # . /lava-11601055/environment/lava-11601=
055/bin/lava-test-runner /lava-11601055/1

    2023-09-23T10:08:11.361771  =


    2023-09-23T10:08:11.366566  / # /lava-11601055/bin/lava-test-runner /la=
va-11601055/1

    2023-09-23T10:08:11.371996  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/650eba04cf669f04578a0a60

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-baylibre/baseline-mes=
on-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-baylibre/baseline-mes=
on-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650eba04cf669f04578a0=
a61
        failing since 23 days (last pass: v5.15.128, first fail: v5.15.129) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/650ebdec12b6129d598a0ab6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
arm64/defconfig+kselftest/gcc-10/lab-baylibre/baseline-meson-gxl-s905x-libr=
etech-cc.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
arm64/defconfig+kselftest/gcc-10/lab-baylibre/baseline-meson-gxl-s905x-libr=
etech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650ebdec12b6129d598a0=
ab7
        failing since 21 days (last pass: v5.15.125-92-g24c4de4069cb, first=
 fail: v5.15.130) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/650eb9dbcaea4792148a0a5a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-broonie/baseline-meso=
n-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-broonie/baseline-meso=
n-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650eb9dbcaea4792148a0=
a5b
        failing since 23 days (last pass: v5.15.128, first fail: v5.15.129) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/650eba1ccae678b5228a0a42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650eba1ccae678b5228a0=
a43
        failing since 241 days (last pass: v5.15.89, first fail: v5.15.90) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/650ebc9a4fdfee2d708a0a58

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650ebc9a4fdfee2d708a0=
a59
        failing since 21 days (last pass: v5.15.128, first fail: v5.15.130) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/650ebca0642d50f24f8a0a9d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.t=
xt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650ebca0642d50f24f8a0=
a9e
        failing since 21 days (last pass: v5.15.128, first fail: v5.15.130) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/650ebc914fdfee2d708a0a42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
arm64/defconfig+kselftest/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plu=
s.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
arm64/defconfig+kselftest/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plu=
s.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650ebc914fdfee2d708a0=
a43
        failing since 21 days (last pass: v5.15.128, first fail: v5.15.130) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/650ebca54fdfee2d708a0a64

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
arm64/defconfig+kselftest/gcc-10/lab-broonie/baseline-sun50i-h5-libretech-a=
ll-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.133/=
arm64/defconfig+kselftest/gcc-10/lab-broonie/baseline-sun50i-h5-libretech-a=
ll-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650ebca54fdfee2d708a0=
a65
        failing since 16 days (last pass: v5.15.128, first fail: v5.15.131) =

 =20
