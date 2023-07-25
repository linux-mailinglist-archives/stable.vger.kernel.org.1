Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CCA762335
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 22:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjGYUXU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 16:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjGYUXT (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 16:23:19 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE0D212B
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 13:23:16 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-666e6ecb52dso3483667b3a.2
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 13:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690316595; x=1690921395;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Htp88Js9z2VWL+rpPyUyzU7gV1qHoKzr4Lb+QdIRYiY=;
        b=XJM7jciRhLmdOfdGFu5S/wpmfjCyg0ji8PWybgz51yDSUCX/siWzHbhBIcJx/Dg034
         QlBGmAehYqx9JrhXrZ0nGdAhSsptjDGQLKTKpQrqpfa2d7MC3pkJe8DLll7yhmBDebJW
         EWUwf4EaI0bSmEFke2B1uZDQBWvoJz1WGOkqH6SMTKmHmNPcNByUmkSRgc1juRM6tVfC
         9PaVKx+tnDeFYXe6TlTgoU6r4i3MI61iYdN3XUM0AFq9xdDyfvuAKHCql3lmFhGsAyyW
         pzsDpMurfRVnfCdovXQDP7GrMMGbq28H4ndrWqCzU95eM7KQjOOKBJKHFv9NR0n43Q8x
         4kgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690316595; x=1690921395;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Htp88Js9z2VWL+rpPyUyzU7gV1qHoKzr4Lb+QdIRYiY=;
        b=Mpg9avUPufBtfkOmgfGxcA1lhAZQ5cG48A+3haF8+c3jIdRe7gqz/9Mf4A++z6HARO
         ouYVvZVBEGm1gnZADjkj8YXN9ipXd9Kt6VT0OOsB2gO+8GdiXDgWY+KlKaT9RyaJN8cG
         unK5sX7Niyeq064MtUFlNEKqhkuVyebb5bZ7dBDzajb7OAw0KBkWtauR4vyIgZIRr1nm
         ZrB1ud5SCwW32wJLKJRV2k7Mi1WiIzUcYDa2W23+CsejOCvXzuj+qMtBW/krKZ0YW+iV
         wCnNGZt0X0+Duc4KifMEUJ6HscIXjDGviomuU6dFLvR6/NML8bzaWtFQ7xbYbxb744PS
         SkkQ==
X-Gm-Message-State: ABy/qLZu7ABJZW5gaOcUTdvZIyS7psMWW/LkLi/2q88t0BW7ViOh0gRP
        IaltPaUCobupg1bncNBT3PEFUlTS0c00Tw4UjAErpQ==
X-Google-Smtp-Source: APBJJlE7YkolvFfS7R+CTjFceAXE81yK4+hKyKOfHAwst46wMSa67+jJMJitpSkk8nen0WMJ9swS8A==
X-Received: by 2002:a17:90a:d78f:b0:267:a6c5:e60a with SMTP id z15-20020a17090ad78f00b00267a6c5e60amr232238pju.0.1690316595028;
        Tue, 25 Jul 2023 13:23:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id hi16-20020a17090b30d000b0025be7b69d73sm4889pjb.12.2023.07.25.13.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 13:23:14 -0700 (PDT)
Message-ID: <64c02f32.170a0220.4f624.003d@mx.google.com>
Date:   Tue, 25 Jul 2023 13:23:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Kernel: v5.10.187-510-g4a64f03701033
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.10.y baseline: 131 runs,
 12 regressions (v5.10.187-510-g4a64f03701033)
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

stable-rc/linux-5.10.y baseline: 131 runs, 12 regressions (v5.10.187-510-g4=
a64f03701033)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

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

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.187-510-g4a64f03701033/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.187-510-g4a64f03701033
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      4a64f03701033c39271bac1039ff76ef15ae50a3 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64bffe87ffcd6480728ace6f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-510-g4a64f03701033/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-510-g4a64f03701033/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bffe87ffcd6480728ace74
        failing since 188 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-07-25T16:54:57.951952  <8>[   11.028733] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3724698_1.5.2.4.1>
    2023-07-25T16:54:58.058591  / # #
    2023-07-25T16:54:58.160000  export SHELL=3D/bin/sh
    2023-07-25T16:54:58.160359  #
    2023-07-25T16:54:58.261439  / # export SHELL=3D/bin/sh. /lava-3724698/e=
nvironment
    2023-07-25T16:54:58.261803  =

    2023-07-25T16:54:58.362980  / # . /lava-3724698/environment/lava-372469=
8/bin/lava-test-runner /lava-3724698/1
    2023-07-25T16:54:58.363525  =

    2023-07-25T16:54:58.368301  / # /lava-3724698/bin/lava-test-runner /lav=
a-3724698/1
    2023-07-25T16:54:58.446438  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64bffcb7b4aebc43848ace7d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-510-g4a64f03701033/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-r=
db.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-510-g4a64f03701033/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-r=
db.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bffcb7b4aebc43848ace80
        failing since 7 days (last pass: v5.10.142, first fail: v5.10.186-3=
32-gf98a4d3a5cec)

    2023-07-25T16:47:44.085199  [   10.132789] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1238024_1.5.2.4.1>
    2023-07-25T16:47:44.190430  =

    2023-07-25T16:47:44.291630  / # #export SHELL=3D/bin/sh
    2023-07-25T16:47:44.292046  =

    2023-07-25T16:47:44.393009  / # export SHELL=3D/bin/sh. /lava-1238024/e=
nvironment
    2023-07-25T16:47:44.393421  =

    2023-07-25T16:47:44.494425  / # . /lava-1238024/environment/lava-123802=
4/bin/lava-test-runner /lava-1238024/1
    2023-07-25T16:47:44.495369  =

    2023-07-25T16:47:44.499634  / # /lava-1238024/bin/lava-test-runner /lav=
a-1238024/1
    2023-07-25T16:47:44.521471  + export 'TESTRUN_[   10.567893] <LAVA_SIGN=
AL_STARTRUN 1_bootrr 1238024_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64bffd44dd4868590d8ace8c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-510-g4a64f03701033/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-r=
db.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-510-g4a64f03701033/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-r=
db.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bffd44dd4868590d8ace8f
        failing since 143 days (last pass: v5.10.155, first fail: v5.10.172)

    2023-07-25T16:49:46.021906  [   11.062158] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1238022_1.5.2.4.1>
    2023-07-25T16:49:46.126876  =

    2023-07-25T16:49:46.227701  / # #export SHELL=3D/bin/sh
    2023-07-25T16:49:46.228266  =

    2023-07-25T16:49:46.329211  / # export SHELL=3D/bin/sh. /lava-1238022/e=
nvironment
    2023-07-25T16:49:46.329645  =

    2023-07-25T16:49:46.430621  / # . /lava-1238022/environment/lava-123802=
2/bin/lava-test-runner /lava-1238022/1
    2023-07-25T16:49:46.431313  =

    2023-07-25T16:49:46.435265  / # /lava-1238022/bin/lava-test-runner /lav=
a-1238022/1
    2023-07-25T16:49:46.451260  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64bffb3f73b60f5cc88ace1c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-510-g4a64f03701033/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-510-g4a64f03701033/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bffb3f73b60f5cc88ace21
        failing since 118 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-07-25T16:41:22.227387  + set +x

    2023-07-25T16:41:22.233944  <8>[   14.430820] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11136944_1.4.2.3.1>

    2023-07-25T16:41:22.342974  / # #

    2023-07-25T16:41:22.445495  export SHELL=3D/bin/sh

    2023-07-25T16:41:22.446367  #

    2023-07-25T16:41:22.548505  / # export SHELL=3D/bin/sh. /lava-11136944/=
environment

    2023-07-25T16:41:22.549280  =


    2023-07-25T16:41:22.650887  / # . /lava-11136944/environment/lava-11136=
944/bin/lava-test-runner /lava-11136944/1

    2023-07-25T16:41:22.652141  =


    2023-07-25T16:41:22.657081  / # /lava-11136944/bin/lava-test-runner /la=
va-11136944/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64bffacd5ea99fc42d8ace1c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-510-g4a64f03701033/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-510-g4a64f03701033/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bffacd5ea99fc42d8ace21
        failing since 118 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-07-25T16:39:55.310234  + set +x

    2023-07-25T16:39:55.317215  <8>[   13.056411] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11136925_1.4.2.3.1>

    2023-07-25T16:39:55.418984  =


    2023-07-25T16:39:55.519577  / # #export SHELL=3D/bin/sh

    2023-07-25T16:39:55.519758  =


    2023-07-25T16:39:55.620299  / # export SHELL=3D/bin/sh. /lava-11136925/=
environment

    2023-07-25T16:39:55.620449  =


    2023-07-25T16:39:55.721006  / # . /lava-11136925/environment/lava-11136=
925/bin/lava-test-runner /lava-11136925/1

    2023-07-25T16:39:55.721273  =


    2023-07-25T16:39:55.726589  / # /lava-11136925/bin/lava-test-runner /la=
va-11136925/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64bffd87963c26d60a8ace1d

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-510-g4a64f03701033/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboo=
t.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-510-g4a64f03701033/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboo=
t.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bffd87963c26d60a8ace59
        failing since 7 days (last pass: v5.10.186-221-gf178eace6e074, firs=
t fail: v5.10.186-332-gf98a4d3a5cec)

    2023-07-25T16:50:54.339274  / # #
    2023-07-25T16:50:54.441992  export SHELL=3D/bin/sh
    2023-07-25T16:50:54.442761  #
    2023-07-25T16:50:54.544682  / # export SHELL=3D/bin/sh. /lava-8978/envi=
ronment
    2023-07-25T16:50:54.545435  =

    2023-07-25T16:50:54.647343  / # . /lava-8978/environment/lava-8978/bin/=
lava-test-runner /lava-8978/1
    2023-07-25T16:50:54.648574  =

    2023-07-25T16:50:54.663653  / # /lava-8978/bin/lava-test-runner /lava-8=
978/1
    2023-07-25T16:50:54.721379  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-25T16:50:54.721866  + cd /lava-8978/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64bffe2ce8703a03d78ace41

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-510-g4a64f03701033/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/basel=
ine-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-510-g4a64f03701033/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/basel=
ine-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bffe2ce8703a03d78ace44
        failing since 7 days (last pass: v5.10.186-221-gf178eace6e074, firs=
t fail: v5.10.186-332-gf98a4d3a5cec)

    2023-07-25T16:53:39.977871  + set +x
    2023-07-25T16:53:39.977993  <8>[   83.664738] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 989005_1.5.2.4.1>
    2023-07-25T16:53:40.084053  / # #
    2023-07-25T16:53:41.543961  export SHELL=3D/bin/sh
    2023-07-25T16:53:41.564416  #
    2023-07-25T16:53:41.564537  / # export SHELL=3D/bin/sh
    2023-07-25T16:53:43.446651  / # . /lava-989005/environment
    2023-07-25T16:53:46.896613  /lava-989005/bin/lava-test-runner /lava-989=
005/1
    2023-07-25T16:53:46.917227  . /lava-989005/environment
    2023-07-25T16:53:46.917356  / # /lava-989005/bin/lava-test-runner /lava=
-989005/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64bffea3df21912d078ace64

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-510-g4a64f03701033/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/basel=
ine-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-510-g4a64f03701033/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/basel=
ine-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bffea3df21912d078ace67
        failing since 7 days (last pass: v5.10.186-221-gf178eace6e074, firs=
t fail: v5.10.186-332-gf98a4d3a5cec)

    2023-07-25T16:55:41.665823  + set +x
    2023-07-25T16:55:41.666040  <8>[   83.949171] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 989007_1.5.2.4.1>
    2023-07-25T16:55:41.771913  / # #
    2023-07-25T16:55:43.235266  export SHELL=3D/bin/sh
    2023-07-25T16:55:43.256054  #
    2023-07-25T16:55:43.256321  / # export SHELL=3D/bin/sh
    2023-07-25T16:55:45.142192  / # . /lava-989007/environment
    2023-07-25T16:55:48.602040  /lava-989007/bin/lava-test-runner /lava-989=
007/1
    2023-07-25T16:55:48.622935  . /lava-989007/environment
    2023-07-25T16:55:48.623053  / # /lava-989007/bin/lava-test-runner /lava=
-989007/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64bffcd792504645bc8ace25

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-510-g4a64f03701033/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek87=
4.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-510-g4a64f03701033/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek87=
4.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bffcd792504645bc8ace28
        failing since 7 days (last pass: v5.10.186-221-gf178eace6e074, firs=
t fail: v5.10.186-332-gf98a4d3a5cec)

    2023-07-25T16:48:00.613287  / # #
    2023-07-25T16:48:02.073224  export SHELL=3D/bin/sh
    2023-07-25T16:48:02.093679  #
    2023-07-25T16:48:02.093842  / # export SHELL=3D/bin/sh
    2023-07-25T16:48:03.975299  / # . /lava-988999/environment
    2023-07-25T16:48:07.426524  /lava-988999/bin/lava-test-runner /lava-988=
999/1
    2023-07-25T16:48:07.447064  . /lava-988999/environment
    2023-07-25T16:48:07.447158  / # /lava-988999/bin/lava-test-runner /lava=
-988999/1
    2023-07-25T16:48:07.525874  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-25T16:48:07.525998  + cd /lava-988999/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64bffdb3963c26d60a8ace71

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-510-g4a64f03701033/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/basel=
ine-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-510-g4a64f03701033/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/basel=
ine-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bffdb3963c26d60a8ace74
        failing since 7 days (last pass: v5.10.186-221-gf178eace6e074, firs=
t fail: v5.10.186-332-gf98a4d3a5cec)

    2023-07-25T16:51:41.309979  / # #
    2023-07-25T16:51:42.768663  export SHELL=3D/bin/sh
    2023-07-25T16:51:42.789101  #
    2023-07-25T16:51:42.789287  / # export SHELL=3D/bin/sh
    2023-07-25T16:51:44.669853  / # . /lava-989009/environment
    2023-07-25T16:51:48.119944  /lava-989009/bin/lava-test-runner /lava-989=
009/1
    2023-07-25T16:51:48.140555  . /lava-989009/environment
    2023-07-25T16:51:48.140688  / # /lava-989009/bin/lava-test-runner /lava=
-989009/1
    2023-07-25T16:51:48.174170  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-25T16:51:48.223059  + cd /lava-989009/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c00241a53551a4f28ace1c

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-510-g4a64f03701033/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7796=
0-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-510-g4a64f03701033/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7796=
0-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c00241a53551a4f28ace21
        failing since 7 days (last pass: v5.10.186-221-gf178eace6e074, firs=
t fail: v5.10.186-332-gf98a4d3a5cec)

    2023-07-25T17:12:48.124604  / # #

    2023-07-25T17:12:48.226809  export SHELL=3D/bin/sh

    2023-07-25T17:12:48.227550  #

    2023-07-25T17:12:48.328979  / # export SHELL=3D/bin/sh. /lava-11136997/=
environment

    2023-07-25T17:12:48.329713  =


    2023-07-25T17:12:48.431208  / # . /lava-11136997/environment/lava-11136=
997/bin/lava-test-runner /lava-11136997/1

    2023-07-25T17:12:48.432321  =


    2023-07-25T17:12:48.448694  / # /lava-11136997/bin/lava-test-runner /la=
va-11136997/1

    2023-07-25T17:12:48.497898  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-25T17:12:48.498405  + cd /lav<8>[   16.405097] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11136997_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64bffc29d39deb2a8c8ace1c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-510-g4a64f03701033/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-=
h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-510-g4a64f03701033/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-=
h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bffc29d39deb2a8c8ace21
        failing since 7 days (last pass: v5.10.186-221-gf178eace6e074, firs=
t fail: v5.10.186-332-gf98a4d3a5cec)

    2023-07-25T16:46:48.026600  / # #

    2023-07-25T16:46:48.128740  export SHELL=3D/bin/sh

    2023-07-25T16:46:48.129478  #

    2023-07-25T16:46:48.230893  / # export SHELL=3D/bin/sh. /lava-11136996/=
environment

    2023-07-25T16:46:48.231616  =


    2023-07-25T16:46:48.333075  / # . /lava-11136996/environment/lava-11136=
996/bin/lava-test-runner /lava-11136996/1

    2023-07-25T16:46:48.334225  =


    2023-07-25T16:46:48.350631  / # /lava-11136996/bin/lava-test-runner /la=
va-11136996/1

    2023-07-25T16:46:48.408583  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-25T16:46:48.409112  + cd /lava-1113699<8>[   18.369129] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11136996_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
