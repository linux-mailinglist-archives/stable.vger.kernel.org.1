Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1686C77AFB8
	for <lists+stable@lfdr.de>; Mon, 14 Aug 2023 04:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjHNC4T (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 22:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbjHNCzw (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 22:55:52 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9404E65
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 19:55:49 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686f38692b3so3720503b3a.2
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 19:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691981749; x=1692586549;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V6TYbNf2C7h3NfVVGj9qJuDJh8eZEBuf0pdki6Ovf7I=;
        b=XHqCAzoZdeRPSlZ/rnnLGmlas4yiCICUS4O9wyO++KHRgoJhLnkdZu54h+x56bWwFs
         QP1xHmqQZ9kfdmt2iqyoDyWyEYieDETYlZVZ3H3gn8G1Cae76f8HmBU8R8iy843WjpSj
         Z6kvkcAhkpCaryrrJltM+v9P9JKfkghviwatu3NpZq3h5RvAEHrz34NLY0duEBHfQfbc
         bQR46EtvoYbF/6HY5hNSlPyMRgsi3I5L+siuZQLLJ50gPE/BGi52EQRi77SDzqtZpEU9
         4sSjm0f6yIpPnbIjXlGYnvXcEGYvi4YXRUnZyZt6BWe6GUUbUwGfDtrsId0XmmoZYaX3
         SHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691981749; x=1692586549;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V6TYbNf2C7h3NfVVGj9qJuDJh8eZEBuf0pdki6Ovf7I=;
        b=IweW9ifDHnpwkYdm9cjfpe25Yt0K3j/7UxxXxktg9X6LUELDt2ggU8ya+UjbhfsmaL
         Htrc9M+nVR9FkhuKkwvenLt48NasU4Z583mJvGvgu8S6r6wTQZ3X7Vch/qQZmCzQ6cWM
         aTFRTP9k3sFx2YD13waF7FBzJtxGIxIFT4ZCyF+QagMmQfH6TqfgoSdB9ZyPOpH7tKzc
         Zg033cQoNl5vyXmKKDVwb6sLfbmWY8vdu3U/1+Xy2vh6GWLM4RkAEHX7jBzvXppnblM1
         tuFQcs982fiWBJNmtXXflJ6NT36nLcDprj8JnBqfP3l79xjmAmV7Jm5cmHCc3q7FGrlr
         XUBQ==
X-Gm-Message-State: AOJu0Yzn1E3w4CLHC56CR6+Kqr/km73ACF4k9R3wxD+Xt3Q2iTWXAD57
        ANcFxA4g563JwaGKRBpcJFcaeiTfvYs7EVpFT5j+e9hw
X-Google-Smtp-Source: AGHT+IG9r0amfhtR8YuKyCpxRppq6Qp9P6mnk6nkeKWQTnwSoHBantyGgU/FlhWNaJv4aWmEVxmi2g==
X-Received: by 2002:a05:6a20:f3a7:b0:13d:b8ed:a5b8 with SMTP id qr39-20020a056a20f3a700b0013db8eda5b8mr9745201pzb.12.1691981748593;
        Sun, 13 Aug 2023 19:55:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bm17-20020a056a00321100b00640ddad2e0dsm6842923pfb.47.2023.08.13.19.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 19:55:47 -0700 (PDT)
Message-ID: <64d997b3.050a0220.56b84.baac@mx.google.com>
Date:   Sun, 13 Aug 2023 19:55:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.190-69-g5b1776cc14bf8
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.10.y
Subject: stable-rc/linux-5.10.y baseline: 127 runs,
 12 regressions (v5.10.190-69-g5b1776cc14bf8)
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

stable-rc/linux-5.10.y baseline: 127 runs, 12 regressions (v5.10.190-69-g5b=
1776cc14bf8)

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
nel/v5.10.190-69-g5b1776cc14bf8/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.190-69-g5b1776cc14bf8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      5b1776cc14bf85186ed45a8d68d33206f73c727e =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d965768e955d7c7b35b2ff

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-69-g5b1776cc14bf8/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-69-g5b1776cc14bf8/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d965768e955d7c7b35b304
        failing since 208 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-08-13T23:21:11.151173  <8>[   11.091296] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3741538_1.5.2.4.1>
    2023-08-13T23:21:11.261379  / # #
    2023-08-13T23:21:11.364584  export SHELL=3D/bin/sh
    2023-08-13T23:21:11.365521  #
    2023-08-13T23:21:11.469451  / # export SHELL=3D/bin/sh. /lava-3741538/e=
nvironment
    2023-08-13T23:21:11.469930  =

    2023-08-13T23:21:11.571498  / # . /lava-3741538/environment/lava-374153=
8/bin/lava-test-runner /lava-3741538/1
    2023-08-13T23:21:11.572878  =

    2023-08-13T23:21:11.577785  / # /lava-3741538/bin/lava-test-runner /lav=
a-3741538/1
    2023-08-13T23:21:11.663436  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d96691e7a09d579f35b231

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-69-g5b1776cc14bf8/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rd=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-69-g5b1776cc14bf8/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rd=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d96691e7a09d579f35b234
        failing since 26 days (last pass: v5.10.142, first fail: v5.10.186-=
332-gf98a4d3a5cec)

    2023-08-13T23:25:56.144919  [   13.906944] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1243472_1.5.2.4.1>
    2023-08-13T23:25:56.250271  =

    2023-08-13T23:25:56.351477  / # #export SHELL=3D/bin/sh
    2023-08-13T23:25:56.351887  =

    2023-08-13T23:25:56.452857  / # export SHELL=3D/bin/sh. /lava-1243472/e=
nvironment
    2023-08-13T23:25:56.453271  =

    2023-08-13T23:25:56.554256  / # . /lava-1243472/environment/lava-124347=
2/bin/lava-test-runner /lava-1243472/1
    2023-08-13T23:25:56.554939  =

    2023-08-13T23:25:56.558940  / # /lava-1243472/bin/lava-test-runner /lav=
a-1243472/1
    2023-08-13T23:25:56.574957  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d96669eb49b6ffaa35b203

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-69-g5b1776cc14bf8/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rd=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-69-g5b1776cc14bf8/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rd=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d96669eb49b6ffaa35b206
        failing since 163 days (last pass: v5.10.155, first fail: v5.10.172)

    2023-08-13T23:25:20.841295  [   11.557624] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1243475_1.5.2.4.1>
    2023-08-13T23:25:20.948000  =

    2023-08-13T23:25:21.049290  / # #export SHELL=3D/bin/sh
    2023-08-13T23:25:21.049769  =

    2023-08-13T23:25:21.150869  / # export SHELL=3D/bin/sh. /lava-1243475/e=
nvironment
    2023-08-13T23:25:21.151405  =

    2023-08-13T23:25:21.252533  / # . /lava-1243475/environment/lava-124347=
5/bin/lava-test-runner /lava-1243475/1
    2023-08-13T23:25:21.253335  =

    2023-08-13T23:25:21.256339  / # /lava-1243475/bin/lava-test-runner /lav=
a-1243475/1
    2023-08-13T23:25:21.272803  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d964d1bcbd87e4a135b1de

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-69-g5b1776cc14bf8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-69-g5b1776cc14bf8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d964d1bcbd87e4a135b1e3
        failing since 138 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-13T23:18:41.277071  + <8>[   14.645497] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11280705_1.4.2.3.1>

    2023-08-13T23:18:41.277507  set +x

    2023-08-13T23:18:41.382068  #

    2023-08-13T23:18:41.484928  / # #export SHELL=3D/bin/sh

    2023-08-13T23:18:41.485733  =


    2023-08-13T23:18:41.587357  / # export SHELL=3D/bin/sh. /lava-11280705/=
environment

    2023-08-13T23:18:41.588157  =


    2023-08-13T23:18:41.689769  / # . /lava-11280705/environment/lava-11280=
705/bin/lava-test-runner /lava-11280705/1

    2023-08-13T23:18:41.691029  =


    2023-08-13T23:18:41.696089  / # /lava-11280705/bin/lava-test-runner /la=
va-11280705/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9649d63f6d82ec335b201

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-69-g5b1776cc14bf8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-69-g5b1776cc14bf8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d9649d63f6d82ec335b206
        failing since 138 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-13T23:18:07.765137  + set +x<8>[   12.332680] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11280695_1.4.2.3.1>

    2023-08-13T23:18:07.765242  =


    2023-08-13T23:18:07.867164  #

    2023-08-13T23:18:07.968016  / # #export SHELL=3D/bin/sh

    2023-08-13T23:18:07.968205  =


    2023-08-13T23:18:08.068723  / # export SHELL=3D/bin/sh. /lava-11280695/=
environment

    2023-08-13T23:18:08.068893  =


    2023-08-13T23:18:08.169424  / # . /lava-11280695/environment/lava-11280=
695/bin/lava-test-runner /lava-11280695/1

    2023-08-13T23:18:08.169724  =


    2023-08-13T23:18:08.174994  / # /lava-11280695/bin/lava-test-runner /la=
va-11280695/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9672f0a3c6daa3835b1db

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-69-g5b1776cc14bf8/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-69-g5b1776cc14bf8/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d9672f0a3c6daa3835b216
        new failure (last pass: v5.10.190-58-ge3154e1b14b6)

    2023-08-13T23:28:15.708605  / # #
    2023-08-13T23:28:15.812259  export SHELL=3D/bin/sh
    2023-08-13T23:28:15.813067  #
    2023-08-13T23:28:15.915108  / # export SHELL=3D/bin/sh. /lava-50478/env=
ironment
    2023-08-13T23:28:15.916100  =

    2023-08-13T23:28:16.018150  / # . /lava-50478/environment/lava-50478/bi=
n/lava-test-runner /lava-50478/1
    2023-08-13T23:28:16.019574  =

    2023-08-13T23:28:16.031555  / # /lava-50478/bin/lava-test-runner /lava-=
50478/1
    2023-08-13T23:28:16.092414  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-13T23:28:16.092923  + cd /lava-50478/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d967c37bed17835435b1e7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-69-g5b1776cc14bf8/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-69-g5b1776cc14bf8/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d967c37bed17835435b1ea
        failing since 26 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-13T23:30:44.220641  + set +x
    2023-08-13T23:30:44.220857  <8>[   83.736624] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 997063_1.5.2.4.1>
    2023-08-13T23:30:44.329930  / # #
    2023-08-13T23:30:45.791552  export SHELL=3D/bin/sh
    2023-08-13T23:30:45.812183  #
    2023-08-13T23:30:45.812406  / # export SHELL=3D/bin/sh
    2023-08-13T23:30:47.698154  / # . /lava-997063/environment
    2023-08-13T23:30:51.157043  /lava-997063/bin/lava-test-runner /lava-997=
063/1
    2023-08-13T23:30:51.177835  . /lava-997063/environment
    2023-08-13T23:30:51.177945  / # /lava-997063/bin/lava-test-runner /lava=
-997063/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d968769e966b44d535b1da

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-69-g5b1776cc14bf8/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-69-g5b1776cc14bf8/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d968769e966b44d535b1dd
        failing since 26 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-13T23:34:03.541690  + set +x
    2023-08-13T23:34:03.541911  <8>[   83.994705] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 997062_1.5.2.4.1>
    2023-08-13T23:34:03.647688  / # #
    2023-08-13T23:34:05.110788  export SHELL=3D/bin/sh
    2023-08-13T23:34:05.131368  #
    2023-08-13T23:34:05.131580  / # export SHELL=3D/bin/sh
    2023-08-13T23:34:07.017424  / # . /lava-997062/environment
    2023-08-13T23:34:10.476869  /lava-997062/bin/lava-test-runner /lava-997=
062/1
    2023-08-13T23:34:10.497802  . /lava-997062/environment
    2023-08-13T23:34:10.497939  / # /lava-997062/bin/lava-test-runner /lava=
-997062/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d966aa1f535f008635b1db

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-69-g5b1776cc14bf8/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-69-g5b1776cc14bf8/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d966aa1f535f008635b1de
        failing since 26 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-13T23:26:22.110556  / # #
    2023-08-13T23:26:23.574407  export SHELL=3D/bin/sh
    2023-08-13T23:26:23.595002  #
    2023-08-13T23:26:23.595209  / # export SHELL=3D/bin/sh
    2023-08-13T23:26:25.481106  / # . /lava-997054/environment
    2023-08-13T23:26:28.940191  /lava-997054/bin/lava-test-runner /lava-997=
054/1
    2023-08-13T23:26:28.961078  . /lava-997054/environment
    2023-08-13T23:26:28.961191  / # /lava-997054/bin/lava-test-runner /lava=
-997054/1
    2023-08-13T23:26:29.038956  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-13T23:26:29.039172  + cd /lava-997054/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d967863f3f4396af35b208

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-69-g5b1776cc14bf8/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-69-g5b1776cc14bf8/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d967863f3f4396af35b20b
        failing since 26 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-13T23:29:51.853269  / # #
    2023-08-13T23:29:53.315294  export SHELL=3D/bin/sh
    2023-08-13T23:29:53.335864  #
    2023-08-13T23:29:53.336067  / # export SHELL=3D/bin/sh
    2023-08-13T23:29:55.219958  / # . /lava-997059/environment
    2023-08-13T23:29:58.676372  /lava-997059/bin/lava-test-runner /lava-997=
059/1
    2023-08-13T23:29:58.697154  . /lava-997059/environment
    2023-08-13T23:29:58.697264  / # /lava-997059/bin/lava-test-runner /lava=
-997059/1
    2023-08-13T23:29:58.776290  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-13T23:29:58.776519  + cd /lava-997059/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d96619e422d0f7db35b27d

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-69-g5b1776cc14bf8/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-69-g5b1776cc14bf8/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d96619e422d0f7db35b282
        failing since 26 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-13T23:25:32.471244  / # #

    2023-08-13T23:25:32.571759  export SHELL=3D/bin/sh

    2023-08-13T23:25:32.571904  #

    2023-08-13T23:25:32.672362  / # export SHELL=3D/bin/sh. /lava-11280782/=
environment

    2023-08-13T23:25:32.672485  =


    2023-08-13T23:25:32.773010  / # . /lava-11280782/environment/lava-11280=
782/bin/lava-test-runner /lava-11280782/1

    2023-08-13T23:25:32.773194  =


    2023-08-13T23:25:32.780459  / # /lava-11280782/bin/lava-test-runner /la=
va-11280782/1

    2023-08-13T23:25:32.839459  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-13T23:25:32.839574  + cd /lav<8>[   16.438966] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11280782_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9662d31b4f735a835b1e7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-69-g5b1776cc14bf8/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-69-g5b1776cc14bf8/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d9662d31b4f735a835b1ec
        failing since 26 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-13T23:25:48.403756  / # #

    2023-08-13T23:25:48.505458  export SHELL=3D/bin/sh

    2023-08-13T23:25:48.506079  #

    2023-08-13T23:25:48.607229  / # export SHELL=3D/bin/sh. /lava-11280780/=
environment

    2023-08-13T23:25:48.607820  =


    2023-08-13T23:25:48.708977  / # . /lava-11280780/environment/lava-11280=
780/bin/lava-test-runner /lava-11280780/1

    2023-08-13T23:25:48.709870  =


    2023-08-13T23:25:48.711270  / # /lava-11280780/bin/lava-test-runner /la=
va-11280780/1

    2023-08-13T23:25:48.753467  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-13T23:25:48.785489  + cd /lava-1128078<8>[   18.303253] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11280780_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
