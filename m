Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7E37415AE
	for <lists+stable@lfdr.de>; Wed, 28 Jun 2023 17:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjF1PwD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 11:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjF1PwA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Jun 2023 11:52:00 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EFDEC
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 08:51:56 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-666eb03457cso3327582b3a.1
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 08:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687967515; x=1690559515;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sPkreVeIZN27dA6O69WEZuOeUoxElo32BdS0rakCwGA=;
        b=P3pJ+bjodaaUEF/dV+c88QtIFa+DN1lzZUuz0kEShXzkM8DMeLwTzmaQ9LDChlgdUl
         zwAvS72iY7hdNiSJnc5Z266PSS8A25Y1bbbZqOphihQBRJr62Yb7EbIRvuCvm8y3NfpB
         1BnF1mv70E6TfVFB1rP/SMANEOWZ3bTabU83M038YL/0l5cETA6EJwS0/1/wYl76uVBx
         batU9M81CNqgYDSGI1Vaa23Y8VS2EmqfF5fAnT3fDaET5rKzWomxOk5sM1EpUd5XyCtW
         1AOgDs1lySUc8aUUGpAC+lb6aTtrVNKAzXiGOczAkHtZfpUiwXblnTdG5HA7HRto3DYa
         sphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687967515; x=1690559515;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sPkreVeIZN27dA6O69WEZuOeUoxElo32BdS0rakCwGA=;
        b=Ja47UqN/2fhQgEy/9+yta1XByXMRIs4oxWj6iuFNE4recLg+L2xHCTdUADZ5LzBtX1
         ITPdTvznRblPblg06gng5dcupzIk/IWkxN+NzcpDijmPwsbuSST5zGNvlwyKHRObj8Po
         fNeNqbfjssmX6tAbBq01kU0tX3caSbk2OkxWVOEbOdSsFOcBefdAezRS52uk+qBwyPX9
         juAfR1ZcueU2tXDJPX/IP8D333ZrsYrURTbuaqUaQiwndVaDCUYe0Ipe5fHjZ+3LlATk
         PylO8K5wuwfx3vwu7p7tHlwvyv7gSks73zlTx3ZLRLg+2WwP7eq1c48XUfYKziBTGVrr
         MLFA==
X-Gm-Message-State: AC+VfDz3Ln1V+J1Lywh8Sd3aia34c45sQ7aPY5NHOG9Nebkj6hhv/BPH
        X3DLuApbf+HB5Qdc3cOjSxkAHdySGPZus9ZaoFyW3g==
X-Google-Smtp-Source: ACHHUZ74TRYD8z54kxZdGT3dRwYTaIcL/rdOiZYDhaufg4Y8pLBfM0p8Gh15i2vHTCmBZJQPHtuAiw==
X-Received: by 2002:a05:6a00:3a0c:b0:666:8cbb:6e0f with SMTP id fj12-20020a056a003a0c00b006668cbb6e0fmr28959214pfb.3.1687967515416;
        Wed, 28 Jun 2023 08:51:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g5-20020aa78745000000b00678159eacecsm4914867pfo.121.2023.06.28.08.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 08:51:54 -0700 (PDT)
Message-ID: <649c571a.a70a0220.8d572.a1a8@mx.google.com>
Date:   Wed, 28 Jun 2023 08:51:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Kernel: v5.10.186
Subject: stable-rc/linux-5.10.y baseline: 156 runs, 5 regressions (v5.10.186)
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

stable-rc/linux-5.10.y baseline: 156 runs, 5 regressions (v5.10.186)

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

rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.186/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.186
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      381518b4a9165cd793599c1668c82079fcbcbe1f =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c20d2c1e469d03bd7d5f6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c20d2c1e469d03bd7d5ff
        failing since 91 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-06-28T12:00:16.483100  + set +x

    2023-06-28T12:00:16.489751  <8>[   10.814331] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10936991_1.4.2.3.1>

    2023-06-28T12:00:16.594376  / # #

    2023-06-28T12:00:16.694993  export SHELL=3D/bin/sh

    2023-06-28T12:00:16.695179  #

    2023-06-28T12:00:16.795855  / # export SHELL=3D/bin/sh. /lava-10936991/=
environment

    2023-06-28T12:00:16.796061  =


    2023-06-28T12:00:16.896592  / # . /lava-10936991/environment/lava-10936=
991/bin/lava-test-runner /lava-10936991/1

    2023-06-28T12:00:16.896895  =


    2023-06-28T12:00:16.901431  / # /lava-10936991/bin/lava-test-runner /la=
va-10936991/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c20a06cea47a875d7d5e1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c20a06cea47a875d7d5ea
        failing since 91 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-06-28T11:59:13.694355  + set +x<8>[   11.940015] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10936982_1.4.2.3.1>

    2023-06-28T11:59:13.694443  =


    2023-06-28T11:59:13.796398  #

    2023-06-28T11:59:13.796738  =


    2023-06-28T11:59:13.897383  / # #export SHELL=3D/bin/sh

    2023-06-28T11:59:13.897710  =


    2023-06-28T11:59:13.998299  / # export SHELL=3D/bin/sh. /lava-10936982/=
environment

    2023-06-28T11:59:13.998539  =


    2023-06-28T11:59:14.099137  / # . /lava-10936982/environment/lava-10936=
982/bin/lava-test-runner /lava-10936982/1

    2023-06-28T11:59:14.099475  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649c2502dac82504e6d7d5e6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c2502dac82504e6d7d5ef
        failing since 60 days (last pass: v5.10.147, first fail: v5.10.176-=
373-g8415c0f9308b)

    2023-06-28T12:17:51.135373  [   15.963611] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3697666_1.5.2.4.1>
    2023-06-28T12:17:51.239903  =

    2023-06-28T12:17:51.341378  / # #export SHELL=3D/bin/sh
    2023-06-28T12:17:51.341818  =

    2023-06-28T12:17:51.342051  / # [   16.093829] rockchip-drm display-sub=
system: [drm] Cannot find any crtc or sizes
    2023-06-28T12:17:51.443309  export SHELL=3D/bin/sh. /lava-3697666/envir=
onment
    2023-06-28T12:17:51.443747  =

    2023-06-28T12:17:51.545183  / # . /lava-3697666/environment/lava-369766=
6/bin/lava-test-runner /lava-3697666/1
    2023-06-28T12:17:51.545867  =

    2023-06-28T12:17:51.549327  / # /lava-3697666/bin/lava-test-runner /lav=
a-3697666/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649c27cc847f774548d7d6f6

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c27cc847f774548d7d71f
        failing since 148 days (last pass: v5.10.158-107-g6b6a42c25ed4, fir=
st fail: v5.10.165-144-g930bc29c79c4)

    2023-06-28T12:29:35.356885  <8>[   17.098125] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3697683_1.5.2.4.1>
    2023-06-28T12:29:35.476687  / # #
    2023-06-28T12:29:35.582227  export SHELL=3D/bin/sh
    2023-06-28T12:29:35.583726  #
    2023-06-28T12:29:35.687160  / # export SHELL=3D/bin/sh. /lava-3697683/e=
nvironment
    2023-06-28T12:29:35.688743  =

    2023-06-28T12:29:35.792069  / # . /lava-3697683/environment/lava-369768=
3/bin/lava-test-runner /lava-3697683/1
    2023-06-28T12:29:35.794776  =

    2023-06-28T12:29:35.798088  / # /lava-3697683/bin/lava-test-runner /lav=
a-3697683/1
    2023-06-28T12:29:35.839250  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649c25fc8229c29b0ad7d657

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c25fc8229c29b0ad7d687
        failing since 148 days (last pass: v5.10.158-107-g6b6a42c25ed4, fir=
st fail: v5.10.165-144-g930bc29c79c4)

    2023-06-28T12:21:47.166202  + set +x
    2023-06-28T12:21:47.169481  <8>[   17.041970] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 672566_1.5.2.4.1>
    2023-06-28T12:21:47.286069  / # #
    2023-06-28T12:21:47.388153  export SHELL=3D/bin/sh
    2023-06-28T12:21:47.388652  #
    2023-06-28T12:21:47.490137  / # export SHELL=3D/bin/sh. /lava-672566/en=
vironment
    2023-06-28T12:21:47.490596  =

    2023-06-28T12:21:47.592341  / # . /lava-672566/environment/lava-672566/=
bin/lava-test-runner /lava-672566/1
    2023-06-28T12:21:47.593219  =

    2023-06-28T12:21:47.597197  / # /lava-672566/bin/lava-test-runner /lava=
-672566/1 =

    ... (12 line(s) more)  =

 =20
