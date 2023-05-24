Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB57710098
	for <lists+stable@lfdr.de>; Thu, 25 May 2023 00:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbjEXWEy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 24 May 2023 18:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236458AbjEXWEw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 24 May 2023 18:04:52 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330ED135
        for <stable@vger.kernel.org>; Wed, 24 May 2023 15:04:50 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-52867360efcso635143a12.2
        for <stable@vger.kernel.org>; Wed, 24 May 2023 15:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684965889; x=1687557889;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dSQeL1DCrRCN9bzt6fs2PY2wGU0OJguyEwsnzhaDbWQ=;
        b=3PkDWjzZGmtjrL/NFr+2//dy8Bft2G5U/zSAP8aEIItyFqYHubcqkBl+Pctd//aDET
         RM7AHjgv5BE+uStxvunbk+StBHAYOkbwF/rem72lnXkDIBn2ncMUmNWskVJ/0z9R1eLp
         9R4s4bCJzsJ16h1jdtLHIc8Wlqess963gVwwGn5mjvnru61iC2O2skKjMlRp4EXoINbh
         CBvfAIcGP1g32+bOTG2WNpZk+EBuymxpe0yo8HS7CV17hpi8msuSlU72G9Xs//A2cjRO
         BywrXoO6IR6PsNxPwb3ZAaAci7Yetr8LuQZ6K3lyXXCEHJVmdP7h439p1cvt9+Y255YH
         Pl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684965889; x=1687557889;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dSQeL1DCrRCN9bzt6fs2PY2wGU0OJguyEwsnzhaDbWQ=;
        b=l0MA9X6yAWcshzRW/fwLvvqQUsHlLmRw67jOBB4d4osjZMBQ/oOe2DI0K1bTXmBmGr
         6sIkcbx8kvsnNPBB3rw7yfcH/59MjuoLfiHjHTbJn9LEVwvqg+mUwZT4/TuWbWi6bWKQ
         cax2ByCP9XVqIChRXzrnZwrtptdZWJmTf0N8sazcXAGoFq5wNw6NZJoy9Vd2XgzpOFxw
         k51WP+KshcZbZyIXMai2MTnSYyB/QbKJe4VAZpstSbYBvGqXvPF3zousW85jylVNcRuC
         Y0i6fZEGSbA4dp3FdfhNTCXjeVDKy+J2W4Xaf+FggGA82+KGSS5Al6TZNRGLKLV2fpaZ
         F/DA==
X-Gm-Message-State: AC+VfDxqXtTOFY9p34+o5XFfSE6v24od8Eq6K8bqmtDnU4kV8DHLQJds
        UAmparf3UitFzSX/pagqK/jZ3x4sdPrWSvp/vtLGHQ==
X-Google-Smtp-Source: ACHHUZ4HfG0LwmrKWtdNhqSQ9xwQE9j1VhXGAS5BDWUi/MdkLJihtGYq32VhTWAUegw6VtNozx/5eQ==
X-Received: by 2002:a05:6a21:78a4:b0:10a:dd89:420f with SMTP id bf36-20020a056a2178a400b0010add89420fmr18215468pzc.6.1684965889200;
        Wed, 24 May 2023 15:04:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q89-20020a17090a756200b002508f0ac3edsm1890261pjk.53.2023.05.24.15.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 15:04:48 -0700 (PDT)
Message-ID: <646e8a00.170a0220.226e8.3e5d@mx.google.com>
Date:   Wed, 24 May 2023 15:04:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.180-153-g6c958850abd5
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 162 runs,
 6 regressions (v5.10.180-153-g6c958850abd5)
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

stable-rc/queue/5.10 baseline: 162 runs, 6 regressions (v5.10.180-153-g6c95=
8850abd5)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.180-153-g6c958850abd5/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.180-153-g6c958850abd5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      6c958850abd56c1df81abe559320084eeeda9f03 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/646e527fb62656eb712e85f3

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-153-g6c958850abd5/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-153-g6c958850abd5/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646e527fb62656eb712e8624
        failing since 99 days (last pass: v5.10.167-127-g921934d621e4, firs=
t fail: v5.10.167-139-gf9519a5a1701)

    2023-05-24T18:07:38.306627  + set +x
    2023-05-24T18:07:38.310666  <8>[   19.562407] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 508342_1.5.2.4.1>
    2023-05-24T18:07:38.420258  / # #
    2023-05-24T18:07:38.522236  export SHELL=3D/bin/sh
    2023-05-24T18:07:38.522694  #
    2023-05-24T18:07:38.624344  / # export SHELL=3D/bin/sh. /lava-508342/en=
vironment
    2023-05-24T18:07:38.624830  =

    2023-05-24T18:07:38.726557  / # . /lava-508342/environment/lava-508342/=
bin/lava-test-runner /lava-508342/1
    2023-05-24T18:07:38.727447  =

    2023-05-24T18:07:38.731640  / # /lava-508342/bin/lava-test-runner /lava=
-508342/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646e540de909af20f82e85ee

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-153-g6c958850abd5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-153-g6c958850abd5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646e540de909af20f82e85f3
        failing since 55 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-24T18:14:25.325071  + set +x

    2023-05-24T18:14:25.331732  <8>[   14.562840] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10442075_1.4.2.3.1>

    2023-05-24T18:14:25.439175  / # #

    2023-05-24T18:14:25.541426  export SHELL=3D/bin/sh

    2023-05-24T18:14:25.542265  #

    2023-05-24T18:14:25.643900  / # export SHELL=3D/bin/sh. /lava-10442075/=
environment

    2023-05-24T18:14:25.644612  =


    2023-05-24T18:14:25.746085  / # . /lava-10442075/environment/lava-10442=
075/bin/lava-test-runner /lava-10442075/1

    2023-05-24T18:14:25.746490  =


    2023-05-24T18:14:25.751289  / # /lava-10442075/bin/lava-test-runner /la=
va-10442075/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646e545d71a4c39f742e8607

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-153-g6c958850abd5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-153-g6c958850abd5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646e545d71a4c39f742e860c
        failing since 55 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-24T18:15:37.861008  <8>[   13.320806] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10442045_1.4.2.3.1>

    2023-05-24T18:15:37.864396  + set +x

    2023-05-24T18:15:37.968922  =


    2023-05-24T18:15:38.069470  / # #export SHELL=3D/bin/sh

    2023-05-24T18:15:38.069705  =


    2023-05-24T18:15:38.170337  / # export SHELL=3D/bin/sh. /lava-10442045/=
environment

    2023-05-24T18:15:38.171059  =


    2023-05-24T18:15:38.272516  / # . /lava-10442045/environment/lava-10442=
045/bin/lava-test-runner /lava-10442045/1

    2023-05-24T18:15:38.272809  =


    2023-05-24T18:15:38.278054  / # /lava-10442045/bin/lava-test-runner /la=
va-10442045/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/646e583126ca3cb0d62e85eb

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-153-g6c958850abd5/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-153-g6c958850abd5/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/646e583126ca3cb0d62e85f1
        failing since 71 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-24T18:32:11.896594  <8>[   32.351450] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-05-24T18:32:12.920695  /lava-10442319/1/../bin/lava-test-case

    2023-05-24T18:32:12.932208  <8>[   33.389051] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/646e583126ca3cb0d62e85f2
        failing since 71 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-24T18:32:11.883980  /lava-10442319/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646e56e4fbceba665b2e85f6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-153-g6c958850abd5/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-153-g6c958850abd5/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646e56e4fbceba665b2e85fb
        failing since 111 days (last pass: v5.10.165-139-gefb57ce0f880, fir=
st fail: v5.10.165-149-ge30e8271d674)

    2023-05-24T18:26:18.998375  <8>[    8.464924] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3614901_1.5.2.4.1>
    2023-05-24T18:26:19.116680  / # #
    2023-05-24T18:26:19.218496  export SHELL=3D/bin/sh
    2023-05-24T18:26:19.219007  #
    2023-05-24T18:26:19.320365  / # export SHELL=3D/bin/sh. /lava-3614901/e=
nvironment
    2023-05-24T18:26:19.320881  =

    2023-05-24T18:26:19.422308  / # . /lava-3614901/environment/lava-361490=
1/bin/lava-test-runner /lava-3614901/1
    2023-05-24T18:26:19.423136  =

    2023-05-24T18:26:19.429070  / # /lava-3614901/bin/lava-test-runner /lav=
a-3614901/1
    2023-05-24T18:26:19.493195  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
